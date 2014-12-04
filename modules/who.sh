#!/bin/bash

# HELP SECTION
if echo $1 | grep -iq help; then
   echo "This command returns user who's logged in specific qa server. Also date of a last post/get request to this server"
   echo "Currently I'm aware about - bmw, honda, audi, jeep, opel, pagani, vw"
   echo ""
   echo 'Usage exmaple: "!who bmw"'
   exit
fi

# RETURNING USERS LOGGED IN ON QA MACHINE
if [ -z "$@" ]
then
   echo "Please specify qa machine"
   exit
else
   machine=($@)
fi

user=$(ssh $machine "w | awk '{print \$1}' | awk '!x[\$0]++' | grep -e '[a-z]'")
if [ -z "$user" ]
then
   user="Seems no one is tracing logs on this machine"
fi

# GETTING LATEST LOCALHOST_ACCESS_LOG
log_name=$(ssh $machine "ls -l -rt /usr/local/tomcat/logs/ | grep localhost_access | tail -1 | awk '{print \$9}'")

# GETTING LATEST TIME WHEN QA SERVER WAS USED
latest_time=$(ssh $machine "sudo cat /usr/local/tomcat/logs/$log_name | grep -v "/solr/" | tail -1 | awk '{print \$4}' | sed 's/\[//g' ")

echo $machine " - " $user
echo "Last time usage (UTC) - " $latest_time
