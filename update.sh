#!/usr/bin/bash

os_info=/etc/os-release
std_op=/var/log/update_success.log
std_err=/var/log/update_error.log

echo "updating system ... :)"

if grep -q "nobara" $os_info
then
	sudo dnf update -y && sudo dnf upgrade -y 1 >> $std_op 2 >> $std_err
	echo "error and success log files are at /var/log/"

else
	if grep -q "debian" $os_info
	then
		sudo apt update -y && sudo apt upgrade -y 1 >> $std_op 2 >> $std_err
		echo "error and success log files are at /var/log/"

	else
		if grep -q "arch" $os_info
		then 
			sudo pacman -Syu 1 >> $std_op 2 >> $std_err
			echo "error and success log files are at /var/log/"
		fi
	fi
fi	
