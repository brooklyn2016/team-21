#!/bin/expect

read -s -p "Enter Username: " username
read -s -p "Enter Password(so insecure): " password


for i in {1..1000};
do 
	echo new commit >> spam
	git commit -am "Destroyable History $i"
	spawn "git push"
	expect "Username"
	send "$username\r"
	expect "Password"
	send "$password\r"
	interact
	sleep 3s
done

