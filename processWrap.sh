#!/bin/bash

task=$1

if [ ! -f /tmp/${task}.lock ]; then
	echo "$task Not locked"
else
	echo "$task locked - ABORT"
	exit
fi

echo $date > /tmp/${task}.lock



echo "Processing $task at $date"
./processQueries${task}.sh

echo "Removing Lock at $date"
rm /tmp/${task}.lock

./processWrap.sh $task

