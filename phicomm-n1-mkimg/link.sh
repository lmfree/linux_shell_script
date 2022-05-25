#!/bin/bash

for x in `find -name *.ko`
do
	sudo ln -s $x .
done

