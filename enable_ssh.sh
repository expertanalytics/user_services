#! /bin/bash
cp /xal/internal/pub_keys/$1/* /home/$1/.ssh/authorized_keys
chown $1.$1 /home/$1/.ssh/*
