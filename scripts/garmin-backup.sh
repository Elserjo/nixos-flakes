#!/usr/bin/env bash

backupDir="/home/serg/Backup/Garmin Edge 830/"
#I need to export this variables for notify-send
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

on_error() 
{
     _MSG_=$1
     echo "$_MSG_"
     exit 1
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

    if [ ! -e "$outputPath" ]; then
        echo "Backup_log: " > "$outputPath"
    fi
    date >> "$outputPath"
}

garmin()
{
    mpointGarmin="$(findmnt -nr -o TARGET -S UUID="961E-AA0E")"

    check_mount "${mpointGarmin}" "Garmin"
    
    inputDir="${mpointGarmin}/Garmin/"
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
    #Glob should be used inside array (according shellcheck)
    #See https://www.shellcheck.net/wiki/SC2125
    
    for val in "${copyArray[@]}"
        do
            copyStr+=( --include="$val"/*** )
        done
    
    LOG_NAME="garmin"
    rsync --no-perms --checksum --progress -v -r "${copyStr[@]}" \
         --exclude=* "${inputDir}" "${backupDir}"
    
    RET_CODE=$?
    
    if test $RET_CODE -eq 0; then
        writeLog "$LOG_NAME" "${backupDir}"
        notify-send "Garmin 830 Backup is Done"
    fi     
}

garmin
