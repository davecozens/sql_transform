#!/bin/bash

        startCustomers=15000
        endCustomers=15005

echo "Processing queries $date"


        myIp=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
        sql="select max(jobEnd)+1 as next from `infiniti-live`.exportBatch where type='transaction'"
        startRow=`mysql --user=fcbadmin --password=wMh4z2SVSqD6 -h infinitifcb.chuapwo9kkbi.us-east-1.rds.amazonaws.com --raw -N -e "$sql"`



        sql="select value from \`infiniti-live\`.exportSettings where settingId='batchSize'"
        batchSize=`mysql --user=fcbadmin --password=wMh4z2SVSqD6 -h infinitifcb.chuapwo9kkbi.us-east-1.rds.amazonaws.com --raw -N -e "$sql"`


        echo "Init Log $(date)" >> process.log

        if [ "$startRow" = "NULL" ]; then
                startRow=1
        fi

        startCustomers=$startRow
        endCustomers=$((startRow+batchSize))

sql="insert into \`infiniti-live\`.exportBatch (jobStart,jobEnd,server,started,processing,type) values ($startRow , $endCustomers,'$myIp',now(),1,'transaction')"
register=`mysql --user=fcbadmin --password=wMh4z2SVSqD6 -h infinitifcb.chuapwo9kkbi.us-east-1.rds.amazonaws.com --raw -N -e "$sql"`

rm -r -f dataTrans
mkdir -p dataTrans

sql=$(<transaction_event.sql)
find="user1"
find2="user2"
user=$startCustomers
sql2=${sql/$find/$startCustomers}
sql2=${sql2/$find2/$endCustomers}
echo "Processing $startCustomers to $endCustomers - total: $batchSize $(date)" >> process.log
echo $sql

mysql --user=fcbadmin --password=wMh4z2SVSqD6 -h infinitifcb.chuapwo9kkbi.us-east-1.rds.amazonaws.com --raw -N -e "$sql2"  > dataTrans/trans_event_out_$user.tab
echo "Received mysql response ${date} and written to dataRans/trans_event_out_${user}.tab"




./processDataTransaction.sh $startCustomers


sql="update \`infiniti-live\`.exportBatch set finished=now(), processing=2  where server = '$myIp' and jobStart=$startRow and type='transaction':w
"
register=`mysql --user=fcbadmin --password=wMh4z2SVSqD6 -h infinitifcb.chuapwo9kkbi.us-east-1.rds.amazonaws.com --raw -N -e "$sql"`





