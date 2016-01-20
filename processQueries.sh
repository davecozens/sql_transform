#!/bin/bash

startCustomers=$1
endCustomers=$2


rm -r -f data
mkdir -p data

sql=$(<pageview_event.sql)
find="user1"
find2="user2"
user=$startCustomers
sql2=${sql/$find/$startCustomers}
sql2=${sql2/$find2/$endCustomers}
echo "Processing $startCustomers to $endCustomers $(date)"
mysql --user=fcbadmin --password=wMh4z2SVSqD6 -h infinitifcb.chuapwo9kkbi.us-east-1.rds.amazonaws.com --raw -N -e "$sql2"  > data/pageview_event_out_$user.tab
echo "Received mysql response ${date} and written to data/pageview_event_out_${user}.tab"
./processEvents.sh $startCustomers
