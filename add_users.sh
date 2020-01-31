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
			useradd -m -s /bin/bash $username
			mkdir /home/$username/.ssh
			chown -R $username /home/$username
			#add ssh key to authorized_keys
			if [ -f /etc/nebula/ca.key ]; then
				usermod -aG docker $username
				bash /xal/user_services/encrypt_cert.sh $username
			#should be changed to check lighthouse status instead.
			#else
			#	fname=${username}_nebula_cert.tar.gx.age
			#	if [ ! -f /home/$username/$fname ]; then
			#		scp $username@192.168.100.200:/nebula_age/$fname /home/$username/$fname
			#	fi
			fi
		fi
		bash /xal/user_services/enable_ssh.sh $username
	done
else
	echo script must be run as root, exting
fi
