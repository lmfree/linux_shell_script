#!/usr/bin/perl

$insert_multiplier=1;

$arc_cnt = @ARGV;
if ($arc_cnt<2) {
    print ("\n\n This program usage\n");
    print (" Useage $0 <in_ts_file> <sw_version> [pid(288)]\n\n");  ##[multiplier] 
    exit -1;
}

printf("\n");
$app_file=$ARGV[0];

$sw_version_to_dsi=$ARGV[1];

$interval=1;
$file_name_len = length($app_file);
$output_filename=sprintf("%s_dsi_dii.ts", substr($app_file, 0, $file_name_len -3 ));
#printf ("%s\n", $output_filename);

#default pid = 288
$pid_deal = 288;
if($arc_cnt >= 3)
{
	$pid_deal=$ARGV[2];
}

printf("output file -> %s\n", $output_filename);
$version=0;
#print("app file: $app_file\n");
my @file_stat = stat ($app_file);
#printf("file %s size is -> %d\n", $app_file, $file_stat[7]);
$size=$file_stat[7];

if($size < 5000)
{
	printf("file size < 5000 bytes, not need todo.\n");
	exit 0;
}

open (appfile, "<$app_file") || die("Error: can't open in file $app_file \n");
binmode(appfile);
$length=read(appfile, $buffer, $size);
close(appfile);
printf("input file  -> %s size is -> %d, read length -> %d\n", $app_file, $file_stat[7], $length);
@istream = unpack("C*",$buffer);
$ts_pack=0;
$dii_cnts=0;
$dsi_cnts=0;
$dsi_insert_swversion=0;

for($i=0 ; $i<$length ; )
{
	if ($istream[$i] == 0x47)
	{
		$ts_pack=$ts_pack+1;
		$pid  = $istream[$i+1] << 8;
		$pid |= $istream[$i+2];
		#printf("pid = %d, 0x%x\n", $pid&0x1fff, $pid);
		if( ($pid & 0x1fff) == $pid_deal)
		{
			$pid_pack += 1;
			$tid = $istream[$i+5];
			$tid_ex = $istream[$i+4];
			$slen  = $istream[$i+6] << 8;
			$slen |= $istream[$i+7];
			$slen &= 0x0fff;
			if ($tid == 0x3b)
			{
				$dii_id  = $istream[$i+15]<<8;
				$dii_id |= $istream[$i+16];
				if( $dii_id == 0x1002)
				{
					$dii_cnts+=1;
					#printf("-----dii_cnts: %d, index: %d, section len: %d\n", $dii_cnts, $tid_cnts+1, $slen);
				}
				
				if( $dii_id == 0x1006)
				{
					$dsi_cnts+=1;
					#printf("-----dsi_cnts: %d, index: %d, section len: %d\n", $dsi_cnts, $tid_cnts+1, $slen);
				}
				
				$tid_cnts += 1;
				if( $dsi_cnts > 0)
				{
					$dsi_cnts = 0;
					$dsi_dii_outfile = "ts_dsi.ts";
					$dsi_insert_swversion = 1;
				}
				elsif($dii_cnts > 0 )
				{
					$dii_cnts = 0;
					$dsi_dii_outfile = "ts_dii.ts";
					$dsi_insert_swversion = 0;
				}
				else
				{
					$dsi_dii_outfile="";
					$dsi_insert_swversion = 0;
				}
				
				if(length($dsi_dii_outfile) > 3)
				{
					printf("find dsi dii ts packege, exact this section to -> %s\n", $dsi_dii_outfile);
					open (OFILE, ">$dsi_dii_outfile") || die("Error: can't open out file $dsi_dii_outfile \n");
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
					$_tmp_outf=".tmp_new_dsi.ts";
					$result = system("./add_version $dsi_dii_outfile $_tmp_outf $sw_version_to_dsi");
					if(($result == 0) && ($dsi_insert_swversion != 0))
					{
						printf("add sw version successfuly swversin -> %d\n", $sw_version_to_dsi);
						system("cp $_tmp_outf $dsi_dii_outfile");
						system("rm $_tmp_outf");
					}
					elsif($dsi_insert_swversion != 0)
					{
						printf("add sw version faild, exit 1\n");
						exit 1;
					}
				}
			}
			if($tid == 0x3c)
			{
				#printf("0x3c offset: %d\n", $i);
			}
		}
		$i += 188
	}
	else
	{
		$i += 1
	}
}
printf("find pid pack : %d, tid=0x3b counts:%d\n", $pid_pack, $tid_cnts);

if (0)
{
	#read null ts
	$null_file="null.ts";
	open (appfile2, "<$null_file") || die("Error: can't open in file $null_file \n");
	binmode(appfile2);
	$length=read(appfile2, $null_buffer, 188);
	close(appfile2);
	printf("read null ts size: %d\n", $length);
}

#insert
$newfile=$output_filename;
open (OFILE, ">$newfile") || die("Error: can't open new out file $newfile \n");
binmode(OFILE);

#read dsi and dii ts pack
$tmpfile="ts_dsi.ts";
open (IFILE, "<$tmpfile") || die("Error: can't open tmp in file $tmpfile \n");
binmode(IFILE);
read(IFILE, $buffer_dsi, 188);
close(IFILE);

$tmpfile="ts_dii.ts";
open (IFILE, "<$tmpfile") || die("Error: can't open tmp in file $tmpfile \n");
binmode(IFILE);
read(IFILE, $buffer_dii, 188);
close(IFILE);


$interval=1;
$step_size=188*$interval;
$start=0;
$dsi_cnt=1;
$insert_times=0;
$insert_times2=0;
$insert_limite=4000; ##关键section插入到 > 4000字节的section前, 否则会导致收不到全部升级数据问题.
$insert_multiplier_real = 0;

printf("only insert key section to > %d byte \n", $insert_limite);
while($start < $size)
{
	@in_stream=();
	$tid   = $istream[$start+5];
	$slen  = $istream[$start+6] << 8;
	$slen |= $istream[$start+7];
	$slen &= 0x0fff;

	if( ($tid == 0x3c) && (($istream[$start+1] & 0xE0) == 0x40) && ($slen > $insert_limite) )
	{
		$insert_times += 1;
		#if($insert_times <= 120 && $insert_times >= 10) ##从第几个开始插入关键section.
		{
			$insert_multiplier_real += 1;
			for ($clc_cnt = 1; $clc_cnt <= $insert_multiplier; $clc_cnt += 1) ##每次插入多少个关键section.
			{
				if(1)
				{
					if(0)
					{
						for($kk=0;$kk<10;$kk+=1)
						{
							#$null_buffer
							print (OFILE $null_buffer);
						}
					}
					#for ($dsi_cnt = 1; $dsi_cnt <= 2; $dsi_cnt += 1)
					{
						$insert_times2 += 1;
						#printf("insert : %d\n", $insert_times2);
						print (OFILE $buffer_dsi);
						print (OFILE $buffer_dii);
					}
				}
				else
				{	##交替方式插入两个关键section.
					if(insert_times%2 == 1)
					{
						$tmpfile=".0x3b_tmp_1.bin"
					}
					else
					{
						$tmpfile=".0x3b_tmp_2.bin"
					}
					open (IFILE, "<$tmpfile") || die("Error: can't open tmp in file $tmpfile \n");
					binmode(IFILE);
					read(IFILE, $buffer, 188);
					close(IFILE);
					print (OFILE $buffer);
				}
				if(0) ## insert null package
				{
					for($kk=0;$kk<10;$kk+=1)
					{
						#$null_buffer
						print (OFILE $null_buffer);
					}
				}
			}
		}
	}
	
	#replace first dsi package.
	$dii_id  = $istream[$start+15]<<8;
	$dii_id |= $istream[$start+16];
	if( ($tid == 0x3b) && $dii_id == 0x1006)
	{
		printf("-----relpace the dsi package\n");
		print (OFILE $buffer_dsi);
	}
	else
	{
		for($i=$start; $i<$step_size + $start; $i+=1)
		{
			push (@in_stream, $istream[$i]);
		}
		$out_stream = pack("C*", @in_stream);
		binmode(OFILE);
		print (OFILE $out_stream);
	}
	$start += $step_size;
}

close(OFILE);
printf("\nresult:\n\tinsert times: %d, multiplier: %d, new ts file -> %s, pid = %d(0x%x)\n\n\n", $insert_times2, $insert_times2/$insert_multiplier_real, $newfile, $pid_deal, $pid_deal);
exit 0;

