#!/bin/bash


on_error() 
{
     _MSG_=$1
     echo "$_MSG_"
     exit 1
}

get_distro()
{
    local distro=$(grep -woP "ID=\K\w+" /etc/os-release)
    local backupName="$(cat ${BACKUP_NAME_PATH})"
     
     case $distro in
     "gentoo") 
          #BACKUP_FOLDER="$MPOINT_LINUX/root_gentoo";
          LOG_NAME="${backupName}"
          ;;
     "arch") 
          #BACKUP_FOLDER="$MPOINT_LINUX/root"
          LOG_NAME=""
          ;;
     *) 
          on_error "Unknown distro"
          ;;
     esac
}

set_backup_name()
{
    if [[ ! -f "${BACKUP_NAME_PATH}" ]]; then
        on_error "Backup name is empty"
    fi
    
    local backupName="$(cat ${BACKUP_NAME_PATH})"

    if [[ -z "${backupName}" ]]; then
        on_error "Backup config file is empty"
    fi

    local ans=""
    read -p "Backup name is: ${backupName}. Continue ? (y/N): " ans
    if [[ ! "${ans}" =~ (y|Y) ]]; then
        on_error "Exiting..."
    fi

    BACKUP_FOLDER="${MPOINT_LINUX}/${backupName}"
}

do_test()
{
    _BIN_=$1
 
    if [ ! -x "$(command -v $_BIN_)" ]; then
        echo "$_BIN_ is not installed"
        exit 1
    fi
}

check_mount()
{
    _MOUNT_=$1
    _MSG_=$2
    
    if [ ! -d "$_MOUNT_" ]; then
        echo "Path to $_MSG_ mount point is not exists"
        exit 1
    fi
}

writeLog() 
{
    _LOG_=$1
    _SAVE_PATH_=$2

    local outputPath="$_SAVE_PATH_/backup_history_${_LOG_}".log
    #echo $outputPath
    #exit 1

    if [ ! -e "$outputPath" ]; then
        echo "Backup_log: " > "$outputPath"
    fi
    date >> "$outputPath"
}

garmin()
{
    export DISPLAY=:0 
    export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
    
    MPOINT_GARMIN="$(df -h | grep -i "Garmin" | awk '{print $NF}')"
    
    check_mount "$MPOINT_GARMIN" "Garmin"
    
    _SRC_DIR="$MPOINT_GARMIN/Garmin/"
    _BACKUP_DIR="/home/serg/Backup/Garmin Edge 830"
    copyArray=(
            "Activities" 
            "Locations" 
            "Records" 
            "Settings" 
            "Sports" 
            "Totals" 
            "Weight"
        )
    
    #https://stackoverflow.com/questions/9952000/using-rsync-include-and-exclude-options-to-include-directory-and-file-by-pattern
    #https://github.com/JonnyTischbein/rsync-server/blob/master/sync-folder.sh
    
    for val in "${copyArray[@]}"
        do
	    _COPY_STR+="--include=$val/*** "
        done
    
    LOG_NAME="_garmin"
      
    rsync --no-perms --checksum --progress -v -r $_COPY_STR --exclude=* $_SRC_DIR "$_BACKUP_DIR" 
    
    RET_CODE=$?
    
    if test $RET_CODE -eq 0; then
        writeLog "$LOG_NAME" "$_BACKUP_DIR"
        notify-send "Garmin 830 Backup is Done"
    fi     
    #echo "$_COPY_STR"
}


backup_data() 
{
    if [[ "$EUID" -ne 0 ]]; then 
    	on_error "Should be run as root"
    fi
    
    BACKUP_FOLDER="" #global variable for backup path
    BACKUP_NAME_PATH=""
    MPOINT_WINDOWS="$(df -h | grep -i "Windows" | awk '{print $NF}')"
    MPOINT_MEDIA="$(df -h | grep "/home/serg/Media" | awk '{print $NF}')"
    MPOINT_LINUX="$(df -h | grep -i "Linux" | awk '{print $NF}')"
    BACKUP_NAME_PATH="${MPOINT_LINUX}/backupConfig"

    do_test "rsync"
    do_test "awk"
    do_test "grep"
    do_test "df"

    check_mount "${MPOINT_MEDIA}" "Media"
    check_mount "${MPOINT_LINUX}" "Linux"
    check_mount "${MPOINT_WINDOWS}" "Windows"

    local PASS_PATH="${MPOINT_MEDIA}/syncthing/Пароли.kdbx"

    set_backup_name #set output backup folder on external hdd
    get_distro

    #we want to skip windows *.LNK files for better rsync copy
    rsync -aAXHv --delete --progress \
        --exclude "/dev/*" \
        --exclude "/proc/*" \
        --exclude "/sys/*" \
        --exclude "/tmp/*" \
        --exclude "/run/*" \
        --exclude "/mnt/*" \
        --exclude "/media/*" \
        --exclude "/lost+found" \
        --exclude "Backup/*" \
        --exclude "Media/*" \
        --exclude "Work/*" \
        --exclude "/home/*/.cache/*" \
        --exclude "/home/*/.local/share/TelegramDesktop/tdata/*" \
        --exclude "Soulseek Downloads/*" \
        --exclude "*.LNK" \
          / "$BACKUP_FOLDER" \
        && writeLog "$LOG_NAME" "$MPOINT_LINUX"

    cp -v "${PASS_PATH}" "${MPOINT_WINDOWS}"

    umount "${MPOINT_LINUX}"
    umount "${MPOINT_WINDOWS}"
}

while getopts "gl" opt
    do
        case $opt in
        g) garmin
           ;;
        l) backup_data
           ;;
        *) echo "Nothing to do"
           ;;
        esac
    done
