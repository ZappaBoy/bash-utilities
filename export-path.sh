#!/bin/bash

INPUT_ERROR=5
SUCCESS=0

function export-path(){
    KEY=${1:-""}
    VALUE=${2:-""}
    SOURCE_FILE=${3:-"/home/${USER}/.bashrc"}
    EXPORT_IN_PATH=${4:-false}
    if [[ "${EXPORT_IN_PATH}" = true ]]; then
	            if grep -q -e "PATH=${VALUE}" "${SOURCE_FILE}" ; then
                            echo "PATH value exists"
	            else
	                echo "Exporting in PATH: ${VALUE}"
                    echo "export PATH=${VALUE}:\$PATH" >> "${SOURCE_FILE}"
                    export PATH="${VALUE}:${PATH}"
	            fi
    else
	    if grep -q -e "${KEY}=${VALUE}" "${SOURCE_FILE}" ; then
                    echo "${KEY}=${VALUE} exists"
	    else

	        echo "Exporting : ${KEY}=${VALUE}"
	        export "${KEY}"="${VALUE}"
	        echo "export ${KEY}=${VALUE}" >> "${SOURCE_FILE}"
	    fi
    fi

}

[[ $# -eq 0 ]] && echo "No params detected: see ${0} -h" && exit "${INPUT_ERROR}"

while getopts "k:v:s:P" ARG; do
    case "${ARG}" in
	k)
	    [[ -z "${OPTARG}" ]] && echo "Please insert a PATH to export" && exit "${INPUT_ERROR}"
	    KEY="${OPTARG}"
	    EXPORT_IN_PATH=false
	    ;;
	v)
	    [[ -z "${OPTARG}" ]] && echo "Please insert a PATH to export" && exit "${INPUT_ERROR}"
	    VALUE="${OPTARG}"
	    ;;
	s)
      	[[ -z "${KEY}" && -z "${VALUE}" ]] && echo "Please insert a KEY and VALUE to export, then the source file path" && exit "${INPUT_ERROR}"
	    SOURCE_FILE="${OPTARG}"
	    ;;
	P)
      	[[ -n "${KEY}" ]] && echo "Please insert only '-k' or '-P' params not both " && exit "${INPUT_ERROR}"
	    EXPORT_IN_PATH=true
	    ;;
	*)
	    cat <<EOF
Usage: export-path -k BIN_KEY -v BIN_PATH -s SOURCE_FILE

- BIN_KEY: is the KEY of the variable to export
- BIN_PATH: is the PATH to export
- SOURCE_FILE: is the file path where export the BIN_PATH (Default: ~/.bashrc)
EOF
	    exit "${INPUT_ERROR}"
	    ;;
    esac
done
shift "$((OPTIND-1))"

export-path "${KEY}" "${VALUE}" "${SOURCE_FILE}" "${EXPORT_IN_PATH}"
exit "${SUCCESS}"
