#!/bin/bash

username="$1"
user_dir="directoare/$username"

if [[ -z $(ls -A "$user_dir") ]]; then
    echo "The directory is empty."
    exit 0
fi

num_files=$(find "$user_dir" -type f | wc -l)
num_dirs=$(find "$user_dir" -type d | wc -l)
total_size=$(du -sh "$user_dir" | cut -f1)


data=$(date +'%d_%m')
nume_raport="$user_dir/raport_${data}.txt"


echo "Number of files     : $num_files" >> "$nume_raport"
echo "Number of directories  : $num_dirs" >> "$nume_raport"
echo "Total size : $total_size" >> "$nume_raport"
