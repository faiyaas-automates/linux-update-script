#!/usr/bin/bash

os_info=/etc/os-release
std_op=/var/log/update_success.log
std_err=/var/log/update_error.log

echo "updating system ... :)"

check_status(){

	if [ $? -ne 0 ]
	then
		echo "check error file at $std_err"	
	else
		echo "check success file at $std_op"
	fi
	
}

dnf(){
		sudo dnf update -y && sudo dnf upgrade -y 1 >> $std_op 2 >> $std_err
		check_status
		echo "error and success log files are at /var/log/"
}

apt(){
		sudo apt update -y && sudo apt upgrade -y 1 >> $std_op 2 >> $std_err
		check_status
		echo "error and success log files are at /var/log/"
}

pacman(){
		sudo pacman -Syu 1 >> $std_op 2 >> $std_err
		check_status
		echo "error and success log files are at /var/log/"
}

if grep -q "nobara" $os_info || grep -q "fedora" $os_info
then
	dnf
fi

if grep -q "debian" $os_info
	apt
fi

if grep -q "arch" $os_info
then
	pacman
fi
