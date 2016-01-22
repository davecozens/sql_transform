#!/bin/bash

sourceStart=$1
cd dataTrans
file="trans_event_out_${1}.tab"
dest="trans_event_out_${1}.json"
log="trans_event_import_${1}.log"
invalid="trans_event_invalid_${1}.log"


#echo $file
numLines=`wc -l $file | cut -f1 -d' '`

echo "processing $file lines: $numLines into $dest"
rm $dest

#while read line 
for (( l=1; l <= numLines; l++ ))
do      
	line=`sed $l!d $file` 

	echo $line
echo "HERE1"
        id=$(cut -d"	" -f1 <<<"${line}")
        sessionID=$(cut -d"	" -f2 <<<"${line}")
        installationID=$(cut -d"	" -f3 <<<"${line}")
        customerID=$(cut -d"	" -f4 <<<"${line}")
        infinitiID=$(cut -d"	" -f5 <<<"${line}")
        deviceType=$(cut -d"	" -f6 <<<"${line}")
        clientTimeStamp=$(cut -d"	" -f7 <<<"${line}")
        serverTimeStamp=$(cut -d"	" -f8 <<<"${line}")
        processedTimeStamp=$(cut -d"	" -f9 <<<"${line}")
        action=$(cut -d"	" -f10 <<<"${line}")
	namespace=$(cut -d"	" -f11 <<<"${line}")
        referral_channel=$(cut -d"	" -f12 <<<"${line}")
        referral_url=$(cut -d"	" -f13 <<<"${line}")
	clusters=$(cut -d"	" -f14 <<<"${line}")
        language=$(cut -d"	" -f15 <<<"${line}")
        geolocation_locationName=$(cut -d"	" -f16 <<<"${line}")
        geolocation_ip=$(cut -d"	" -f17 <<<"${line}")
        geolocation_latitude=$(cut -d"	" -f18 <<<"${line}")
        geolocation_longitude=$(cut -d"	" -f19 <<<"${line}")
        geolocation_city=$(cut -d"	" -f20 <<<"${line}")
        geolocation_region=$(cut -d"	" -f21 <<<"${line}")
        geolocation_country=$(cut -d"	" -f22 <<<"${line}")
        geolocation_countryCode=$(cut -d"	" -f23 <<<"${line}")
        environment_userAgent=$(cut -d"	" -f24 <<<"${line}")
        environment_javascript=$(cut -d"	" -f25 <<<"${line}")
        environment_cookies=$(cut -d"	" -f26 <<<"${line}")
        environment_browser_name=$(cut -d"	" -f27 <<<"${line}")
        environment_browser_version=$(cut -d"	" -f28 <<<"${line}")
        environment_os=$(cut -d"	" -f29 <<<"${line}")
        user_clusters=$(cut -d"	" -f300 <<<"${line}")
        user_language=$(cut -d"	" -f31 <<<"${line}")
        user_birthdate=$(cut -d"	" -f32 <<<"${line}")
        user_gender=$(cut -d"	" -f33 <<<"${line}")
	user_gender=${user_gender:0:1}
        user_address_latitude=$(cut -d"	" -f34 <<<"${line}")
        user_address_longitude=$(cut -d"	" -f35 <<<"${line}")
        user_address_city=$(cut -d"	" -f36 <<<"${line}")
        user_address_region=$(cut -d"	" -f37 <<<"${line}")
        user_address_country_code=$(cut -d"	" -f38 <<<"${line}")
        user_interests=$(cut -d"	" -f39 <<<"${line}")
        user_channel=$(cut -d"	" -f40 <<<"${line}")
        user_socialNetworks_facebook=$(cut -d"	" -f41 <<<"${line}")
        user_socialNetworks_linkedin=$(cut -d"	" -f42 <<<"${line}")
        user_socialNetworks_google=$(cut -d"	" -f43 <<<"${line}")
	isanonymous=$(cut -d"	" -f44 <<<"${line}")
        delivry_revenue=$(cut -d"	" -f45 <<<"${line}")	
	delivery_lat=$(cut -d"	" -f46 <<<"${line}")
	delivery_long=$(cut -d"	" -f47 <<<"${line}")
	delivery_city=$(cut -d"	" -f48 <<<"${line}")
	delivery_region=$(cut -d"	" -f49 <<<"${line}")
	delivery_countrycode=$(cut -d"	" -f50 <<<"${line}")
	trans_currency=$(cut -d"	" -f5§ <<<"${line}")
	transitemsku=$(cut -d"	" -f51 <<<"${line}")
	transitemcurrency=$(cut -d"	" -f52 <<<"${line}")
	transitemprice=$(cut -d"	" -f53 <<<"${line}")
	transitemquantity=$(cut -d"	" -f54 <<<"${line}")
	transitemname=$(cut -d"	" -f55 <<<"${line}")
	transitemcategory=$(cut -d"	" -f56 <<<"${line}")
	itemscount=$(cut -d"	" -f57 <<<"${line}")
	loyalty=$(cut -d"	" -f58 <<<"${line}")
	servertemistamp=$(cut -d"	" -f59 <<<"${line}")
	transactionid=$(cut -d"	" -f60 <<<"${line}")
	isanonymous=$(cut -d"	" -f61 <<<"${line}")	
	items=$(cut -d"	" -f62 <<<"${line}")
#echo "Fields"
#echo $processedTimeStamp
#echo $action
#echo $referral_channel
#echo $namespace
#echo "$clusters $(cut -d"	" -f13 <<<"${line}")"	
#echo $referral_channel
#echo $(cut -d"	" -f11 <<<"${line}")
#echo $user_gender
#echo "UA: $environment_userAgent"
#echo $environment_os
#echo $transactionid
#echo $items
	geolcation="false"
if [ -n "$geolocation_city" ]; then
    geolocation="true"
elif  [ -n "$geolocation_latitude" ]; then
    geolocation="true"
elif  [ -n "$geolocation_country" ]; then
    geolocation="true"
fi

if [ "$user_birthdate" != "NULL" ]; then
	user_birthdate="$user_birthdate 00:00"
else
        user_birthdate="null"
fi

if (( $l % 100 == 0 )); then
	echo "Line $l $(date)"
fi

if [ "$clusters"=="NULL" ]; then
	clusters=""
fi



result="{\"_id\":\"$id\",\"deviceType\":\"browser\",\"clientTimestamp\":\"$clientTimestamp\",\"serverTimestamp\":\"$clientTimestamp\",\"processedTimestamp\":\"$clientTimestamp\",\"action\":\"pageview\",\"namespace\":null,\"infinitiID\":\"63e67c1b-3d82-4217-b01a-0df1e5121465\",\"installationID\":\"$customerID\",\"sessionID\":\"$sessionID\",\"customerID\":\"$customerID\",\"referral\":{\"channel\":\"$referral_channel\",\"url\":\"$referral_url\"},\"clusters\":[$clusters],\"language\":\"$language\",\"geolocation\":{\"locationName\":\"$geolocation_locationName\",\"ip\":\"$geolocation_ip\",\"latitude\":\"$geolocation_latitude\",\"longitude\":\"$geolocation_longitude\",\"city\":\"$geolocation_city\",\"region\":\"$geolocation_region\",\"countryCode\":\"$geolocation_countryCode\"},\"environment\":{\"userAgent\":\"$environment_userAgent\",\"screenSize\":null,\"windowSize\":null,\"javascript\":true,\"cookies\":true,\"doNotTrack\":false,\"geolocation\":$geolocation,\"touchPoints\":null,\"landscapeMode\":null,\"device\":{\"isProjection\":false,\"isTV\":false},\"browser\":{\"name\":\"$environment_browser_name\",\"version\":\"$environment_browser_version\",\"language\":\"user_language\"},\"os\":\"$environment_os\",\"vendor\":null,\"model\":null,\"deviceId\":null,\"deviceType\":\"$devicetype\",\"maxTouchPoints\":null},\"user\":{\"isAnonymous\":\"$isanonymous\",\"clusters\":[$clusters],\"language\":\"$user_language\",\"birthday\":\"$user_birthdate\",\"gender\":\"$user_gender\",\"address\":{\"latitude\":\"$user_address_latitude\",\"longitude\":\"$user_address_longitude\",\"city\":\"$user_address_city\",\"region\":\"$user_address_region\",\"country_code\":\"$user_address_country_code\"},\"interests\":null,\"channel\":null,\"socialNetworks\":{\"facebook\":\"$user_socialNetworks_facebook\",\"linkedin\":\"$user_socialNetworks_linkedin\",\"google\":\"$user_socialNetworks_google\"}},\"payload_transaction\":{\"revenue\": $delivry_revenue,\"deliveryAddress\": {  \"latitude\": \"$delivery_lat\",  \"longitude\": \"$delivery_long\",  \"city\": \"$delivery_city\",  \"region\": \"$delivery_region\",  \"countryCode\": \"$delivery_countrycode\"},\"currency\": \"$trans_currency\",\"items\": [$items]}}"

final=`sed  's:"NULL":null:g'  <<< $result`
final=`sed  's:"null":null:g'  <<< $final`
final=`sed  's:"false":false:g'  <<< $final`
final=`sed  's:"true":true:g'  <<< $final`
final=`sed  's:"":null:g'  <<< $final`

final=`sed  's#"channel":null#"channel":"direct"#g'  <<< $final`
#vlads seds

final=`sed -e 's#"screenSize":null,"windowSize":null#"screenSize":{},"windowSize":{}#g' <<< $final`
final=`sed -e 's#deviceId#deviceID#g' <<< $final`
final=`sed -e 's#"interests":null#"interests":[]#g' <<< $final`
final=`sed -e 's#"keywords":null#"keywords":[]#g' <<< $final`
#final=`sed -E 's#"pageview":\s?"([A-Za-z ]*)"([A-Za-z ]*)",?#"pageview":"\1\\"\2"#g'` <<< $final

#final='{bad data}'

validate=`python -m json.tool <<< ${final} | wc -l`
if [[ "$validate" != "0" ]]; then
#        echo "valid row $dest"
        echo $final >> $dest
else
#        echo "Invalid Row"
#        echo $final     
        echo $final >> $invalid
fi

echo $final
exit

#exit after 1 row for debug
exit

done




