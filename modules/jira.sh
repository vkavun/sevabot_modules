#!/bin/bash

# HELP SECTION
if echo $1 | grep -iq help; then
   echo "This command turns on and off notifications from JIRA."
   echo ""
   echo 'Usage exmaple: "!jira start", "!jira stop"'
   exit
fi

# CHECKING CORRECTNESS PARAMETERS
if [ -z "$@" ]
  then
  echo "Please specify 'start' or 'stop' command"
  echo "Examples: '!jira start' - will turn on notifications from JIRA"
  echo "And '!jira stop' will turn notifications off"
  exit
fi

args=($@)
for i in "${args[@]}"
do
if [ "$i" != "start" ] && [ "$i" != 'stop' ]
then
   echo "Specified command doesn't exist!"
   echo "Please use 'start' or 'stop'"
   exit
fi
done

# START
# Checking if we already started
if [ "$1" == "start" ]
then
   chat_list=$(crontab -l | awk '{print $7 $8}')

   IFS_OLD=$IFS
   IFS=$'\n'
   for i in $(echo "$chat_list"); do
     if [ "$i" == "$SEVABOT_HOME/custom/jira.sh$CHAT_ID" ]
       then
       echo "Already started JIRA notifications in this chat!"
       exit
     fi
   done
   IFS=$IFS_OLD

   crontab -l > $SEVABOT_HOME/custom/cron_jira
   #echo new cron into cron file
   echo "*/5 * * * * bash $SEVABOT_HOME/custom/jira.sh $CHAT_ID" >> $SEVABOT_HOME/custom/cron_jira
   #install new cron file
   crontab $SEVABOT_HOME/custom/cron_jira
   rm $SEVABOT_HOME/custom/cron_jira
   echo "Started notifying this chat with new tickets in JIRA !"
fi


# STOP
# Checking if we have cron, that we can stop

if [ "$1" == "stop" ]
then
   chat_list=$(crontab -l | awk '{print $7 $8}')
   chat_present=0 # flag to show presense of chat in crontab list
   IFS_OLD=$IFS
   IFS=$'\n'
   for i in $(echo "$chat_list"); do
     if [ "$i" == "$SEVABOT_HOME/custom/jira.sh$CHAT_ID" ]
       then
       chat_present=1
     fi
   done
   IFS=$IFS_OLD
   
   if [ "$chat_present" == 1 ]
      then
      crontab -l > $SEVABOT_HOME/custom/cron_jira
      # remove cron from file
      sed -i "/jira.sh $CHAT_ID/d" $SEVABOT_HOME/custom/cron_jira
      crontab $SEVABOT_HOME/custom/cron_jira
      rm $SEVABOT_HOME/custom/cron_jira
      echo "Stopped notifying this chat with new tickets in JIRA!"
      exit
   fi
   echo "JIRA notifications are not turned on! Nothing to stop."
fi
