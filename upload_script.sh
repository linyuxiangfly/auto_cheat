#!/usr/bin/expect -f

set timeout 120
set ip [lindex $argv 0]
set user [lindex $argv 1]
set pwd [lindex $argv 2]
set file [lindex $argv 3]
set destDir [lindex $argv 4]

#spawn ssh -o StrictHostKeyChecking=no -p22 $user@$ip
spawn scp "$file" $user@$ip:"$destDir"

expect {
	"yes/no?"
    	{
    		send "yes\n"
    		expect "*assword:" { send "$pwd\n"}
    	}
    	"*assword:"
    	{
    		send "$pwd\n"
    	}
}

expect eof
