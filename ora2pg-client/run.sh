#!/bin/sh

mkdir /export/pg


#EXPORT_TYPE="TABLE PACKAGE VIEW GRANT SEQUENCE TRIGGER FUNCTION PROCEDURE TABLESPACE PARTITION TYPE MVIEW DBLINK SYNONYM DIRECTORY QUERY"

#Change to add all types required
#TODO move into environment variable to pass them from execution
EXPORT_TYPE="SEQUENCE TABLE INSERT TRIGGER VIEW FUNCTION PROCEDURE"

num=1


for etype in $(echo $EXPORT_TYPE | tr " " "\n"); do
   ora2pg -s "dbi:Oracle:host=$DB_HOST;sid=$DB_SID" -t $etype -o /export/pg/$num-$etype.sql
   num=`expr $num + 1`                
done


#while [ 1 ]; do sleep 1; done
