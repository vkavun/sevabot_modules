#!/bin/bash

# HELP SECTION
if echo $1 | grep -iq help; then
   echo "This command returns user who's logged in specific qa server."
   echo ""
   echo 'Usage exmaple: "!who qa.server.com"'
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
echo $machine " - " $user
