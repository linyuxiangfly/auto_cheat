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
  echo "cpu:$cpu,mem:$mem" >> `dirname $0`/1.txt

  sleep 1
done
