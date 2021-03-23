#!/usr/bin/env bash
set -euo pipefail

VERSION='1.0.0'
HOURS=1

TIMETABLE=$(cat << _EOF_
|Monday|Tuesday|Wednesday|Thursday|Friday|
| - - - | - - - | - - - | - - - | - - - |
09-10:|||Networking security|Computational statistics|Computational statistics|
10-11:|||Networking security|Computational statistics|Computational statistics|
11-12:|Biometric systems|Networking security|Networking security|Informatics and law|Biometric systems|
12-13:|Biometric systems|Networking security|Networking security|Informatics and law|Biometric systems|
13-14:|---|---|---|---|---|
14-15:||Project management|Computational statistics|Informatics and law|Project management|
15-16:||Project management|Computational statistics|Informatics and law|Project management|
16-17:||Project management|||Project management|
17-18:||Project management||||
_EOF_
)

usage() { cat << _EOF_
Usage: lessons [OPTION]
Show the lessons.
     -a, --all      print all the lessons (weekly)
     -d, --day      print lessons of the specified day (default current day)
     -h, --help     display this help and exit
     -v, --version  output version information and exit

Exit status:
     0  if OK,
     1  if minor problems (e.g., wrong specified day)

License:
    License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.

_EOF_
1>&2; exit 1; }

show-daily-lessons(){
    local DAY

    case "${1}" in
        Mon)
            DAY=1
            ;;
        Tue)
            DAY=2
            ;;
        Wed)
            DAY=3
            ;;
        Thu)
            DAY=4
            ;;
        Fri)
            DAY=5
            ;;
        *)
            echo "Wrong specified day"
            exit 1
            ;;
    esac

    DAY=$((DAY + 1))
    DAILY_LESSONS=$(echo "${TIMETABLE}" | awk  -F '|' "{print \$${HOURS} \"\t\" \$${DAY}}")
    echo "${DAILY_LESSONS}"
}

show-all-lessons(){
    ALL_LESSONS=$(echo "${TIMETABLE}" | column -s "|" -L -t)
    echo "${ALL_LESSONS}"
}

while getopts "ad:hv" o; do
    case "${o}" in
        a)
            echo "Show all lessons"
            show-all-lessons
            ;;
        d)
            DAY=${OPTARG:0:3}
            echo "Show lessons of ${DAY}"
            show-daily-lessons "${DAY}"
            ;;
        v)
            echo "Version: ${VERSION}"
            ;;
        h | *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if (( OPTIND == 1 )); then
   show-daily-lessons "$(date +%a)"
fi

exit 0
