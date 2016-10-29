#!/bin/bash

for i in {1..1000};
do 
	echo new commit >> spam
	git commit -am "Destroyable History $i"
	git push
	sleep 3s
done

