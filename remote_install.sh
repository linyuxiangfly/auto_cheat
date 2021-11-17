#!/usr/bin/expect -f

set timeout 120
set ip [lindex $argv 0]
set user [lindex $argv 1]
set pwd [lindex $argv 2]
set outFile [lindex $argv 3]
set scriptFile [lindex $argv 4]
set destDir [lindex $argv 5]
set destFile [lindex $argv 6]

spawn ssh -o StrictHostKeyChecking=no -p22 $user@$ip

expect {
    "(yes/no)?"
    {
    send "yes\n"
    expect "*assword:" { send "$pwd\n"}
    }
    "*assword:"
    {
    send "$pwd\n"
    }
}

expect "*#"

send "mkdir -p $destDir\r"
send "tar -xvf $scriptFile -C $destDir\r"
send "chmod 777 $destDir/*\r"
send "$destDir$destFile $destDir\r"
send "exit\r"

expect eof

#catch wait result
#exit [lindex $result 3]
exit 1
