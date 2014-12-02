#!/bin/bash
# HELP SECTION
if echo $1 | grep -iq help; then
   echo "This command returns version of specific qa servers - bmw honda audi jeep opel pagani vw ford"
   echo ""
   echo 'Usage exmaple: "!version bmw", "!version honda vw"'
   echo 'In this case "!version" - all qa machine versions will be returned'
   exit
fi

# CHECKING CORRECTNESS OF QA SERVER NAMES
# BUILDING ARRAY QA_SERVERS, BASED ON QA SERVERS INDICATED IN SETTINGS.PY
i=0
if [ ! -z "$QA_SERVER0" ]
then
   server=$QA_SERVER0
   while [ ! -z "$server" ]
   do
      server_name=QA_SERVER$i
      server=${!server_name}
      QA_SERVERS[$i]=$server
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

if [ ! -z "$@" ]
then
   if [ $flag2 == 0 ]
   then
      echo "Specified QA server doesn't exist"
      exit
   fi
fi

# RETURNING QA SERVERS VERSIONS
if [ -z "$@" ]
then
for i in "${QA_SERVERS[@]}"
do
   if [ ! -z "$i" ]
      then
      version=$(curl -s http://$i$VERSION_APPENDIX)
      if [ -z "$version" ]
      then
         version="OFFLINE"
      fi
      echo $i " - " $version
   fi
done
else
for i in "$@"
do
   if [ ! -z "$i" ]
      then
      version=$(curl -s http://$i$VERSION_APPENDIX)
      if [ -z "$version" ]
      then
         version="OFFLINE"
      fi
      echo $i " - " $version
   fi
done
fi
