#!/bin/bash

while true
do
  cpu_id=`top -bn 1 | sed -n 3p |awk -F , '{print $4}'|awk '{print $1}'`
  export cpu=$(echo "scale=2;  100-${cpu_id}" | bc)

  #统计内存使用率
  mem_used_persent=`free -m | awk -F '[ :]+' 'NR==2{printf "%d", ($3)/$2*100}'`
  # -e参数是使 "\n"换行符生效进行输出换行的
  mem=$mem_used_persent

  #echo "cpu:$cpu,mem:$mem"
  #echo "cpu:$cpu,mem:$mem" >> `dirname $0`/1.txt

  #计算CPU使用率是不是很低
  cpuIsLow=`echo "if($cpu < 5.0) print "1" else print "0"" | bc`

  if [ $cpuIsLow -eq 1 ]; then
    echo "cpu low" >> `dirname $0`/1.txt

    #消耗CPU，后面加上&是让命令在后台执行
    timeout 1s cat /dev/urandom |gzip -9|gzip -d |gzip -9 |gzip -d>/dev/null &

    #让CPU占满CPU
    #for i in `seq 1 $(cat /proc/cpuinfo |grep "physical id" |wc -l)`; do dd if=/dev/zero of=/dev/null & done
    #杀死dd进程
    #pkill -9 dd
    #sleep 1
  else
    echo "cpu:$cpu,mem:$mem" >> `dirname $0`/1.txt
  fi

  #计算内存使用率是不是很低
  memIsLow=`echo "if($mem < 20.0) print "1" else print "0"" | bc`
  if [ $memIsLow -eq 1 ]; then
    echo "mem low" >> `dirname $0`/1.txt

    # $1 内存,比如100M
    # $2 占用内存时间（s）
    ./consume_mem.sh 100 1 &
  else
    echo "cpu:$cpu,mem:$mem" >> `dirname $0`/1.txt
  fi

  sleep 1

done
