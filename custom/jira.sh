#!/bin/bash
$(dirname $0)/../git_jira_settings.py

issues_list=$(python $SEVABOT_HOME/custom/jira_issues.py)

if [ ! -z "$issues_list" ] ; then
   curl -X POST -s "http://$HTTP_HOST:$HTTP_PORT/message/$1/" -d"message=New+tickets+were+created%21%0D%0A%0D%0A$issues_list&shared_secret=$SHARED_SECRET" >/dev/null
fi
