#! /bin/bash

#only execute if root
if [ $(id -u) -eq 0 ]; then
	#iterate over added ssh keys
	for dir in /root/internal/pub_keys/*/
	do
		dir=${dir%*/}
		username=${dir##*/}
		egrep "$username" /etc/passwd >/dev/null
		if [ $? -eq 0 ]; then
			echo $username exists!
		else
			echo $username doesnt exist!
		fi
	done
fi
