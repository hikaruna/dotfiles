#!/bin/sh

cd `dirname $0`

for file in `ls -adF .* | grep -v / | sed 's/@$//'` ;do
	command="ln -s $(pwd)/${file} ~/." 
	eval ${command}
	if [ $? -eq 0 ] ;then
		echo "${command}"
	else
		echo "${command} failed" >&2
	fi
done
