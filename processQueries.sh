#!/bin/bash

myIp=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
sql='select max(jobEnd)+1 as next from `infiniti-live`.exportBatch'
startRow=`mysql --user=fcbadmin --password=wMh4z2SVSqD6 -h infinitifcb.chuapwo9kkbi.us-east-1.rds.amazonaws.com --raw -N -e "$sql"`

sql="select value from \`infiniti-live\`.exportSettings where settingId='batchSize'"
batchSize=`mysql --user=fcbadmin --password=wMh4z2SVSqD6 -h infinitifcb.chuapwo9kkbi.us-east-1.rds.amazonaws.com --raw -N -e "$sql"`


echo "Init Log $(date)" >> process.log

if [ "$startRow" = "NULL" ]; then
	startRow=1
fi


startCustomers=$startRow
endCustomers=$((startRow+batchSize))

sql="insert into \`infiniti-live\`.exportBatch (jobStart,jobEnd,server,started,processing) values ($startRow , $endCustomers,'$myIp',now(),1)"
register=`mysql --user=fcbadmin --password=wMh4z2SVSqD6 -h infinitifcb.chuapwo9kkbi.us-east-1.rds.amazonaws.com --raw -N -e "$sql"`


rm -r -f data
mkdir -p data

sql=$(<pageview_event.sql)
find="user1"
find2="user2"
user=$startCustomers
sql2=${sql/$find/$startCustomers}
sql2=${sql2/$find2/$endCustomers}
echo "Processing $startCustomers to $endCustomers - total: $batchSize $(date)" >> process.log
mysql --user=fcbadmin --password=wMh4z2SVSqD6 -h infinitifcb.chuapwo9kkbi.us-east-1.rds.amazonaws.com --raw -N -e "$sql2"  > data/pageview_event_out_$user.tab
echo "Received mysql response ${date} and written to data/pageview_event_out_${user}.tab" >> process.log
./processEvents.sh $startCustomers

lc=`wc -l $dest | cut -f1 -d' '`
echo "$lc lines written"
sql="update \`infiniti-live\`.exportBatch set finished=now(), processing=2  where server = '$myIp' and jobStart=$startRow"
register=`mysql --user=fcbadmin --password=wMh4z2SVSqD6 -h infinitifcb.chuapwo9kkbi.us-east-1.rds.amazonaws.com --raw -N -e "$sql"`

echo "Going again"

./processQueries.sh

