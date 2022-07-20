#!/bin/bash

new_path=`echo $PATH|sed -e 's/\/home\/make-dir//g'`
export PATH=$new_path

