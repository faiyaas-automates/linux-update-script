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
		sudo timeshift --create
		if [ $? -eq 0 ]
		then
			sudo dnf install timeshift -y
		fi
		sudo timeshift --create
		sudo dnf update -y && sudo dnf upgrade -y 1 >> $std_op 2 >> $std_err
		check_status

}

apt(){
		sudo timeshift --create
		if [ $? -eq 0 ]
		then
			sudo apt install timeshift -y
		fi
		sudo timeshift --create
		sudo apt update -y && sudo apt upgrade -y 1 >> $std_op 2 >> $std_err
		check_status
}

pacman(){
		sudo timeshift --create

		if [ $? -eq 0 ]
		then
			sudo pacman install timeshift -y
		fi
		sudo timeshift --create
		sudo pacman -Syu 1>> $std_op 2>> $std_err
		check_status
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
