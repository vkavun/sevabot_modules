#!/bin/bash

# HELP SECTION
if echo $1 | grep -iq help; then
   echo "This command restarts tomcat on qa servers"
   echo ""
   echo 'Usage exmaple: "!tomcat qa.server.com"'
   exit
fi

# CHECKING CORRECTNESS OF QA SERVER NAMES
if [ -z "$@" ]
  then
  echo "Please specify QA server, on which tomcat should be restarted"
  exit
fi

# BUILDING ARRAY QA_SERVERS, BASED ON QA SERVERS INDICATED IN SETTINGS.PY
i=0
if [ ! -z "$QA_SERVER0" ]
then
   server=$QA_SERVER0
   while [ ! -z "$server" ]
   do
      server_name=QA_SERVER$i
      server=${!server_name}
      QA_SERVERS[i]=$server
      i=$(( $i + 1 ))
   done
fi

args=($@)
flag2=0
for i in "${args[@]}"
do
   for j in "${QA_SERVERS[@]}"
   do
      if [ "$i" == "$j" ]
      then
         flag2=1
         break
      fi
   done
done

if [ $flag2 == 0 ]
then
   echo "Specified QA server doesn't exist"
   exit
fi

# CHECKING IF WE ARE ALREADY RESTARTING TOMCAT
screens=$(ssh $1 "screen -list | awk '{print \$1}' | cut -d '.' -f 2")

IFS_OLD=$IFS
IFS=$'\n'
for i in $(echo "$screens"); do
  if [ "$i" == "tomcat_restart" ]
    then
    echo "Already restarting tomcat on $1"
    exit
  fi
done
IFS=$IFS_OLD

# RESTARTING TOMCAT
echo "Restarting tomcat on $1 "

ssh $1 "screen -S tomcat_restart -d -m bash -c \"sudo /etc/init.d/tomcat restart; curl -X POST -s 'http://$HTTP_HOST:$HTTP_PORT/message/$CHAT_ID/' -d'message=Tomcat+has+started+on+$1%21&shared_secret=$SHARED_SECRET'\"" 2>&1 &
