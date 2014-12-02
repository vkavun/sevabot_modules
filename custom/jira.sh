#!/bin/bash

# ADDING PYTHON CODE, TO GET HTTP HOST, HTTP PORT, SHARED SECRET VARIABLES

echo "print SHARED_SECRET" >> $(dirname $0)/../settings.py
SHARED_SECRET=$(python $(dirname $0)/../settings.py)
sed -i '$ d' $(dirname $0)/../settings.py

echo "print HTTP_PORT" >> $(dirname $0)/../settings.py
HTTP_PORT=$(python $(dirname $0)/../settings.py)
sed -i '$ d' $(dirname $0)/../settings.py

echo "print HTTP_HOST" >> $(dirname $0)/../settings.py
HTTP_HOST=$(python $(dirname $0)/../settings.py)
sed -i '$ d' $(dirname $0)/../settings.py

echo "print SEVABOT_HOME" >> $(dirname $0)/../settings.py
SEVABOT_HOME=$(python $(dirname $0)/../settings.py)
sed -i '$ d' $(dirname $0)/../settings.py

issues_list=$(python $SEVABOT_HOME/custom/jira_issues.py)

if [ ! -z "$issues_list" ] ; then
   curl -X POST -s "http://$HTTP_HOST:$HTTP_PORT/message/$1/" -d"message=New+tickets+were+created%21%0D%0A%0D%0A$issues_list&shared_secret=$SHARED_SECRET" >/dev/null
fi
