#!/bin/bash

# ADDING PYTHON CODE, TO GET GIT REPO, HTTP HOST, HTTP PORT, SHARED SECRET VARIABLES
echo "print GIT_REPO" >> $(dirname $0)/../settings.py
GIT_REPO=$(python $(dirname $0)/../settings.py)
sed -i '$ d' $(dirname $0)/../settings.py

echo "print SHARED_SECRET" >> $(dirname $0)/../settings.py
SHARED_SECRET=$(python $(dirname $0)/../settings.py)
sed -i '$ d' $(dirname $0)/../settings.py

echo "print HTTP_PORT" >> $(dirname $0)/../settings.py
HTTP_PORT=$(python $(dirname $0)/../settings.py)
sed -i '$ d' $(dirname $0)/../settings.py

echo "print HTTP_HOST" >> $(dirname $0)/../settings.py
HTTP_HOST=$(python $(dirname $0)/../settings.py)
sed -i '$ d' $(dirname $0)/../settings.py

# GETTING GIT LOG
cd $GIT_REPO
git pull >/dev/null
git_log=$(git log --format=format:"%an - %d - %s" --abbrev-commit --date=relative --since="5 minutes ago")

if [ ! -z "$git_log" ] ; then
   curl -X POST -s "http://$HTTP_HOST:$HTTP_PORT/message/$1/" -d"message=Something+new+was+pushed+to+GIT%21%0D%0A%0D%0A$git_log&shared_secret=$SHARED_SECRET" >/dev/null
fi
