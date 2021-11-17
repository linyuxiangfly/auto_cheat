#!/bin/bash
#yum -y install expect
#apt install expect

#path=`dirname $0`
#path=$(cd `dirname $0`; pwd)
#echo $path

path=$1
csvFile=$2
outFile=$3
localScriptFile=$4
uploadScriptDir=$5
destDir=$6
scriptFile=$7
destFile=$8

rm -rf $outFile

echo "start read csv..."

while read line
do
	#读取CSV文件
	OLD_IFS="$IFS"
    	IFS=","
    	arr=($line)
    	IFS="$OLD_IFS"
	ip=${arr[0]}
	user=${arr[1]}
	pwd=${arr[2]}

	echo "上传脚本："
	$path/upload_script.sh $ip $user $pwd $localScriptFile $uploadScriptDir

	echo "远程连接安装：$ip $user"

	$path/remote_install.sh $ip $user $pwd $outFile $scriptFile $destDir $destFile

	var=$?
	#echo $var >> $outFile
	echo $ip,complete!
done < $csvFile

echo "complete!"
