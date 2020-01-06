#! /bin/bash
key=$( cat /xal/internal/pub_keys/$1/*)
touch /home/$1/.ssh/authorized_keys
echo $key >> /home/$1/.ssh/authorized_keys
