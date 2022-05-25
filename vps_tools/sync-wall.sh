#!/bin/bash
home_dir=/home/opc

o_ss="wallinfo/org/ss.org.link"
n_ss="wallinfo/ss.html"
o_ssr="wallinfo/org/ssr.org.link"
n_ssr="wallinfo/ssr.html"
o_v2ray="wallinfo/org/v2ray.org.link"
n_v2ray="wallinfo/v2ray.html"

tool_en="wallinfo/tool/base64_en.py"
tool_de="wallinfo/tool/base64_de.py"

date "+%Y-%m-%d %H:%M:%S"
cd $home_dir

#adguard check...
ck=`diff -r adguard-list/list wallinfo/adguard-list/list  --exclude='.git'`
if [ "$ck" = "" ];then
	echo -e "adguard not update..."
else
	cp -av adguard-list/list/* wallinfo/adguard-list/list/
fi

#wallinfo check...
#ck=`diff -r wallinfo/ web/wall/|grep -v "\.sync"|grep -v "dlovtip.*"`
ck=`diff -r wallinfo/ web/wall/ --exclude='.sync' --exclude='dlovtip.*'`
if [ "$ck" = "" ];then
	echo -e "not update..."
else
	echo -e "need update..."
	echo -e "convert file: $o_ss $o_ssr $o_v2ray"
	$tool_en $o_ss > $n_ss
	$tool_en $o_ssr > $n_ssr
	$tool_en $o_v2ray > $n_v2ray
	
	rm web/wall/* -rf
	rm nowww/wall/* -rf
	cp wallinfo/* web/wall/ -av
	cp wallinfo/* nowww/wall/ -av
echo -e "\nalready done.... \nexit\n"
fi

if [ -f tools/dlovtip.txt ];then
	cp -af  tools/dlovtip.txt web/wall/dlovtip.txt
	cp -af  tools/dlovtip.txt web/wall/dlovtip.html
	cp -af  tools/dlovtip.txt nowww/wall/dlovtip.txt
	cp -af  tools/dlovtip.txt nowww/wall/dlovtip.html
fi

cd - >/dev/null

