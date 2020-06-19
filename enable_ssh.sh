#! /bin/bash
base_path=/xal/internal

num_files=$(ls -1 ${base_path}/pub_keys/$1/ | wc -l)
if (( num_files > 1)); then
    rm -f ${base_path}/pub_keys/$1/generated_authorized_keys
    keys=$(find ${base_path}/pub_keys/$1 | egrep '\.pub\>')
    for key in $keys
    do
        cat $key >> ${base_path}/pub_keys/$1/generated_authorized_keys
    done
    mv /xal/internal/pub_keys/$1/generated_authorized_keys /home/$1/.ssh/authorized_keys
else
    cp /xal/internal/pub_keys/$1/* /home/$1/.ssh/authorized_keys
fi

chown $1 /home/$1/.ssh/*
