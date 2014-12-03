#!/bin/bash
. $(dirname $0)/../git_jira_settings.sh

# GETTING GIT LOG
cd $GIT_REPO
git pull >/dev/null
git_log=$(git log --format=format:"%an - %d - %s" --abbrev-commit --date=relative --since="5 minutes ago")

if [ ! -z "$git_log" ] ; then
   curl -X POST -s "http://$HTTP_HOST:$HTTP_PORT/message/$1/" -d"message=Something+new+was+pushed+to+GIT%21%0D%0A%0D%0A$git_log&shared_secret=$SHARED_SECRET" >/dev/null
fi
