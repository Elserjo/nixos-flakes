#!/usr/bin/env bash

outputDir="${HOME}/Media/DAP/MusicLib"

#Set list of all flac files in all directories
function onError() {
    local message="$1"
    echo "${message}"
    read -s -r
    exit 1
}

function setFiles() {
    local currentDir="${1}"

    #TODO sort find result
    while IFS= read -r -d '' result; do
        files+=( "${result}" )
    done < <(find "${currentDir}" \
        -maxdepth 1 -mindepth 1 -type f \
        -name "*.flac" -print0)
}
#Get artist and album name from tag
function getTags() {
    local pattern=":?<>*\\/|\"" #pattern for replacing symbols
    local fileName="${1}"

    #Replace sed with bash extension, because it's simplier
    artistName="$(metaflac --show-tag "ARTIST" "${fileName}" | sed "s/ARTIST=//i")"
    albumName="$(metaflac --show-tag "ALBUM" "${fileName}" | sed "s/ALBUM=//i")"

    #Album and artist name may contain '/' symbol, we need to replace it
    albumName="${albumName//[$pattern]/_}"
    artistName="${artistName//[$pattern]/_}"

    #set max albumName and artistName len
    albumName="${albumName:0:50}"
    artistName="${artistName:0:50}"

    [[ -n ${artistName} ]] || onError "Tag {ARTIST} is empty"
    [[ -n ${albumName} ]] || onError "Tag {ALBUM} is empty"
}
#Checking that all dirs are exists
for dir in "${@}"; do
    if [[ ! -d "${dir}" ]]; then
        onError "Directory is not exists \"${dir}\""
    fi
    setFiles "${dir}"
done

for inputFile in "${files[@]}"; do
    getTags "${inputFile}"

    hardlinkSavePath="${outputDir}/${artistName}/${albumName}"
    mkdir -p -v "${hardlinkSavePath}"

    if ln -P -t "${hardlinkSavePath}" "${inputFile}"; then
        echo "Copied [${hardlinkSavePath} $(basename "${inputFile}")]"
    fi
done

#Wait for user exit
read -s -r
