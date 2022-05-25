#!/bin/awk -f
BEGIN{
	NORMAL_COL="\033[0m"
	YELLOW_COL="\033[33m"
	RED_COL="\033[31m"
	BLUE_COL="\033[34m"
	BLUE_COL2="\033[36m"
	GREEN_COL="\033[32m"
}
{
	tail[NR]= $NF
	#line[NR] = $0
	split($0,lst,$NF)
	line[NR] = lst[1]
}
END {
    cnt = 1
	while(cnt <= 5)
	{
		i = 0
		while(i <= NR) 
		{
			tt = split(line[i],tmplst," ")
			if(tt < 3){
				i++
				continue
			}
			spcnts=split(tmplst[1],aa,"x")
			#print "spcnts:" spcnts
			if(index(line[i],"d") == 1 && cnt == 5)
				print line[i] BLUE_COL tail[i] NORMAL_COL
			else if(spcnts > 1 && index(line[i],"d") != 1 && index(line[i],"->") == 0 && cnt == 3)
				print line[i] GREEN_COL tail[i] NORMAL_COL
			else if(index(line[i],"d") != 1 && index(line[i],"l") != 1 && index(line[i],"->") == 0 && cnt == 2)
				print line[i] tail[i]
			else if(index(line[i],"l") == 1 && cnt == 4)
			{
				tt2=split(line[i],str2," ")
				split(line[i],str3,str2[tt-1])
				print str3[1] BLUE_COL2 str2[tt2-1] " " str2[tt2] " " tail[i] NORMAL_COL
				#print line[i] BLUE_COL2 tail[i] NORMAL_COL
				tt2=0
			}
			else if (index(tail[i],".") == 1 && index(line[i],"d") != 1 && index(line[i],"->") == 0 && cnt == 1)
				print line[i] tail[i]
			i++
		}
		cnt++
	}
}
