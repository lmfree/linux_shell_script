#!/usr/bin/perl

$arc_cnt = @ARGV;
if ($arc_cnt<1) {
    print ("\n\n This program usage\n");
    print (" Useage $0 <app_file>\n\n");
    exit -1;
}
$app_file=$ARGV[0];
$version=0;
print("app file: $app_file\n");

open (appfile, "<$app_file") ||
    die("Error: can't open file $app_file \n");
binmode(appfile);
$length = read(appfile,$buffer,0x20);
close (appfile);

print("read len->$length\n");

@istream = unpack("C*",$buffer);

printf("Version: 0x %02x %02x %02x %02x \n", $istream[20], $istream[21], $istream[22], $istream[23]);

if (0)
{
	$version  = $istream[23]<<24;
	$version |= $istream[22]<<16;
	$version |= $istream[21]<<8;
	$version |= $istream[20];
}
else
{
	$version = $istream[20];
}

printf("ret: 0x%x\n", $version);
exit $version;


