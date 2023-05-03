#!/usr/bin/env bash

on_error() 
{
     _MSG_=$1
     echo "$_MSG_"
     exit 1
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

garmin
