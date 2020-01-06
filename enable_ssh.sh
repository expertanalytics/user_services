
key=$( cat /xal/internal/pub_keys/$1/*)
echo $key >> /home/$1/.ssh/authorized_keys
