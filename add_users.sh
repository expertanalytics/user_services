#! /bin/bash

#only execute if root
if [ $(id -u) -eq 0 ]; then
	cd /xal/internal
	git pull
	#iterate over added ssh keys
	for dir in /xal/internal/pub_keys/*/
	do
		dir=${dir%*/}
		username=${dir##*/}
		egrep "$username" /etc/passwd >/dev/null
		if [ ! $? -eq 0 ]; then
			echo adding user $username
			useradd -m -s /bin/bash $username
			mkdir /home/$username/.ssh
			chown -R $username /home/$username
			if [ -f /etc/nebula/ca.key ]; then
				bash /xal/user_services/encrypt_cert.sh $username
			#should be changed to check lighthouse status instead.
			else
				bash /xal/user_services/enable_ssh.sh $username
			fi
		fi
	done
else
	echo script must be run as root, exting
fi
