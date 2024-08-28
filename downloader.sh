#!/usr/bin/env sh

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
output_dir="$script_dir/videos"

mkdir -p "$output_dir"

placeholder="COUNTER"

source="$1"
counter="$2"

[[ -z "$1" ]] && echo "Provide url" && exit 1

urls=()

if test -f "$source"; then
    input_file=$source
    while IFS= read -r line; do
        urls+=("$line")
    done < "$input_file"
else
    [[ -z "$2" ]] && echo "Provide counter" && exit 1
    url=$source
    for i in $(seq "$counter"); do
        formatted_url="${url/$placeholder/$i}"
        urls+=("$formatted_url")
    done
fi

length="${#urls[@]}"
i=0
for url in "${urls[@]}"; do
    i=$((i+=1))
    echo -e -n ">>> Downloading: \t $i / $length \t|\t"
    echo "$url"
    wget --no-clobber --content-on-error -P "$output_dir/" "$url"
done
