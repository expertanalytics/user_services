#! /bin/bash

if [ ! -f /bin/age ]; then
	#install age
	cd /tmp
	version=v1.0.0-beta2
	base=https://github.com/FiloSottile/age/releases/download
	wget $base/$version/age-$version-linux-amd64.tar.gz
	tar -xvzf age-$version-linux-amd64.tar.gz
	mv ./age/* /bin/
fi

#fetch public key for encryption
key=$( cat /root/internal/pub_keys/$1/*)
subnet_ip=$(($(cat /etc/nebula/client_subnet.number) + 1))

#create nebula cert and keys
mkdir $1_nebula_cert
cd /etc/nebula/
nebula-cert sign -name "$1.laptop" -ip "192.168.100.$subnet_ip/24" -groups "laptop"

#compress and encrypt nebula cert and keys
mv $1.laptop* tmp/$1_nebula_cert
cd /tmp
tar -czvf $1_nebula_cert.tar.gz $1_nebula_cert
age -r "$key" $1_nebula_cert.tar.gz > $1_nebula_cert.tar.gz.age
mv $1_nebula_cert.tar.gz.age /nebula_age
rm -rf $1_nebula_cert
