#!/usr/bin/env bash

outputDir="${HOME}/Word/MusicLib"

#Set list of all flac files in all directories
function setFiles() {
    local currentDir="${1}"

    while IFS= read -r -d '' result; do
        files+=( "${result}" )
    done < <(find "${currentDir}" \
        -maxdepth 1 -mindepth 1 -type f \
        -iname "*.flac" -print0)
}
#Get artist and album name from tag
function getTags() {
    local fileName="${1}"

    artistName="$()"
    albumName="$()"
    if [[ -z ${artistName} || -z ${albumName} ]]; then
        echo "Tag is empty $artistName"
        exit 1
    fi
}
#Checking that all dirs are exists
for dir in "${@}"; do
    if [[ ! -d "${dir}" ]]; then
        echo "Directory is not exists \"${dir}\""
        exit 1
    fi

    setFiles "${dir}"
done

for inputFile in "${files[@]}"; do

    getTags "${inputFile}"

    hardlinkSavePath="${outputDir}/${artistName}/${albumName}"
    mkdir -p "${hardlinkSavePath}"

    if ln -P -t "${hardlinkSavePath}" "${inputFile}"; then
        echo "$inputFile"
    fi
done

read -s
