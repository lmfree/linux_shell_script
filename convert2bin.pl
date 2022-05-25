#!/usr/bin/perl

$arc_cnt = @ARGV;
if ($arc_cnt<2) {
    print ("\n\n This program usage\n");
    print (" Useage $0 <in_data> <out_file> \n\n");
    exit -1;
}

$input_data  = $ARGV[0];
$output_file = $ARGV[1];

@istream = unpack("C*",$buffer);
# Make sure we got a whole number of words in array

$istream[3]=(($input_data>>24)&0xFF);
$istream[2]=(($input_data>>16)&0xFF);
$istream[1]=(($input_data>>8)&0xFF);
$istream[0]=$input_data&0xff;

$ostream = pack("C*", @istream);
open (OFILE, ">$output_file") ||
    die("Error: can't open file $output_file \n");
binmode(OFILE);
print (OFILE $ostream);
close (OFILE);

