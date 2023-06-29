#!/bin/bash
help="$0 in_filename [FrameRate(10)]\n\t-- auto genrate outfile .gif\n"
echo -e $help

[ $# -lt 1 ] && exit 1

infile=$1

frate=10

[ "$2" = "" ] || frate=$2

outfile=${infile%.*}.r$frate.gif

echo -e "ffmpeg -i $infile -f gif -r $frate $outfile"

ffmpeg -i $infile -f gif -r $frate $outfile

echo -e "\noutput file --> $outfile"
ls -l $outfile
