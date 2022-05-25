#!/usr/bin/perl

$arc_cnt = @ARGV;
if ($arc_cnt<1) {
    print ("\n\n This program usage\n");
    print (" Useage $0 <app_file>\n\n");
    exit -1;
}

$app_file=$ARGV[0];

$interval=5;
if($arc_cnt >= 2)
{
	$interval=$ARGV[1];
}

$version=0;
print("app file: $app_file\n");
my @file_stat = stat ($app_file);
printf("file %s size is -> %d\n", $app_file, $file_stat[7]);
$size=$file_stat[7];

open (appfile, "<$app_file") || die("Error: can't open in file $app_file \n");
binmode(appfile);
$length=read(appfile, $buffer, $size);
close(appfile);
printf("read length: %d\n", $length);
@istream = unpack("C*",$buffer);
$ts_pack=0;

for($i=0 ; $i<$length ; )
{
	if ($istream[$i] == 0x47)
	{
		$ts_pack=$ts_pack+1;
		$pid  = $istream[$i+1] << 8;
		$pid |= $istream[$i+2];
		#printf("pid = %d, 0x%x\n", $pid&0x1fff, $pid);
		if( ($pid & 0x1fff) == 288)
		{
			$pid_pack += 1;
			$tid = $istream[$i+4];
			if ($tid == 0x3b)
			{
				$tid_cnts += 1;
				$outfile=sprintf(".0x38_tmp_%d.bin", $tid_cnts);
				#printf("out file: %s\n", $outfile);
				open (OFILE, ">$outfile") || die("Error: can't open out file $outfile \n");
				@in_stream=();
				for( $j=0; $j < 188; $j+=1 )
				{
					if($j%16 == 0 && $j != 0)
					{
						#printf("\n");
					}
					#printf("%02x ",$istream[$i+$j]);
					push (@in_stream, $istream[$i+$j]);
				}
				#printf("\n");
				$out_stream = pack("C*", @in_stream);
				binmode(OFILE);
				print (OFILE $out_stream);
				close (OFILE);
			}
		}
		$i += 188
	}
	else
	{
		$i += 1
	}
}
printf("find pid pack : %d, tid=0x38 counts:%d\n", $pid_pack, $tid_cnts);


#insert
$newfile="insert_dsi.ts";
open (OFILE, ">$newfile") || die("Error: can't open new out file $newfile \n");
$step_size=188*$interval;
$start=0;
$dsi_cnt=1;
$insert_times=0;

while($start < $size)
{
$insert_times += 1;
@in_stream=();
for($i=$start; $i<$step_size + $start; $i+=1)
{
	push (@in_stream, $istream[$i]);
}
$out_stream = pack("C*", @in_stream);
binmode(OFILE);
print (OFILE $out_stream);

if($dsi_cnt > $tid_cnts)
{
	$dsi_cnt=0;
}
$tmpfile=sprintf(".0x38_tmp_%d.bin", $dsi_cnt);
open (IFILE, "<$tmpfile") || die("Error: can't open out file $tmpfile \n");
binmode(IFILE);
read(IFILE, $buffer, 188);
close(IFILE);
print (OFILE $buffer);
$start += $step_size;
}

printf("insert times: %d, new ts file -> %s, interval: %d\n", $insert_times, $newfile, $interval);

