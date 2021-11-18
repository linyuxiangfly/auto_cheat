#!/bin/bash

while true
do
  cpu_id=`top -bn 1 | sed -n 3p |awk -F , '{print $4}'|awk '{print $1}'`
  export cpu=$(echo "scale=2;  100-${cpu_id}" | bc)

  #统计内存使用率
  mem_total=`free | grep "Mem:" |awk '{print $2}'`
  mem_free=`free | grep "Mem:" |awk '{print $4}'`
  mem_use=$((mem_total-mem_free))
  #mem_used_persent=`free -m | awk -F '[ :]+' 'NR==2{printf "%d", ($3)/$2*100}'`
  # -e参数是使 "\n"换行符生效进行输出换行的
  #mem=$((mem_use/mem_total))
  export mem=$(echo "scale=2;  ${mem_use}/${mem_total}*100" | bc)

  echo "cpu:$cpu,mem:$mem"

  sleep 1

done
