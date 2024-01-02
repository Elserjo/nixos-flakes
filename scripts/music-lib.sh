#!/usr/bin/env bash

# First arg is outputDir
outputDir="${1}"

#Set list of all flac files in all directories
function onError() {
    local message="${1}"
    echo "${message}"
    read -s -r
    exit 1
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

    [[ -n ${artistName} ]] || \
        onError "Tag {ARTIST} is empty in [${fileName}]"
    [[ -n ${albumName} ]] || \
        onError "Tag {ALBUM} is empty in [${fileName}]"
}

function checkUnique() {
    local verifyFile="${1}" #It just first element of array
    getTags "${verifyFile}"

    local currentArtist="${artistName}" #artistName and albumName are global variables
    local currentAlbum="${albumName}"

    for flacFile in "${files[@]}"; do
        getTags "${flacFile}" #Get tags to verify with and also set them to variables
        [[ ${currentArtist} = "${artistName}" ]] || \
            onError "Artist tag is not same [${currentArtist}:${artistName}]"
        [[ ${currentAlbum} = "${albumName}" ]] || \
            onError "Album tag is not same [${currentAlbum}:${albumName}]"
    done
}
# Checking that all dirs or files are exists
for inputPath in "${@}"; do
    if ! realpath -e "${inputPath}"; then
        onError "Input is not exists \"${inputPath}\""
    fi
done

shift 1 # always skip first arg
while [ "$#" != 0 ]; do
    inputPath="${1}"

    if ! realpath -e "${inputPath}"; then
        onError "Input is not exists \"${inputPath}\""
    fi

    # I can add single flac file or directory. It will anyway scan all flac files
    # in current dir
    if [[ -f "${inputPath}" ]]; then
        currentDir="$(dirname "${inputPath}")"
    else
        currentDir="$(realpath "${inputPath}")"
    fi

    #We assume, that one directory contains only one artist and album

    for inputFile in "${currentDir}"/*.flac; do
        [[ -e "${inputFile}" ]] || onError "No flac files found"
        files+=( "${inputFile}" )
    done

    checkUnique "${files[@]}" #This function also sets artistName and albumName variables
    hardlinkSavePath="${outputDir}/${artistName}/${albumName}"
    # Canonize outputDir path
    mkdir -p -v "$(realpath -m "${hardlinkSavePath}")"

    for inputFile in "${files[@]}"; do
        if ln -P -t "${hardlinkSavePath}" "${inputFile}"; then
            echo "Copied [${hardlinkSavePath} $(basename "${inputFile}")]"
        fi
    done

    for cover in "${currentDir}"/*.jpg; do
        coverName="$(basename "${cover}")"
        #\d (digit) won't works in POSIX
        if [[ "${coverName}" =~ ^[0-9]{3,4}x[0-9]{3,4}\.(jpe?g)$ ]]; then
            if ln -P -t "${hardlinkSavePath}" "${cover}"; then
                echo "Copied [${hardlinkSavePath} $(basename "${cover}")]"
            fi
            break;
        fi
    done
    unset files #Clean array before new iteration
    shift
done

#Wait for user confirm
read -s -r
