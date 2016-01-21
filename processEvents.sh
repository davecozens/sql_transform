#!/bin/bash

sourceStart=$1
cd data
file="pageview_event_out_${1}.tab"
dest="pageview_event_out_${1}.json"

echo $file
numLines=`wc -l $file | cut -f1 -d' '`

echo "processing $file lines: $numLines into $dest"
rm $dest

#while read line 
for (( l=1; l <= numLines; l++ ))
do      
	line=`sed $l!d $file` 

#echo $line

        id=$(cut -d"	" -f1 <<<"${line}")
        deviceType=$(cut -d"	" -f2 <<<"${line}")
        clientTimestamp=$(cut -d"	" -f3 <<<"${line}")
        action=$(cut -d"	" -f4 <<<"${line}")
        namespace=$(cut -d"	" -f5 <<<"${line}")
        infinitiID=$(cut -d"	" -f6 <<<"${line}")
        installationID=$(cut -d"	" -f7 <<<"${line}")
        sessionID=$(cut -d"	" -f8 <<<"${line}")
        customerID=$(cut -d"	" -f9 <<<"${line}")
        referral_channel=$(cut -d"	" -f10 <<<"${line}")
        referral_url=$(cut -d"	" -f11 <<<"${line}")
        clusters=$(cut -d"	" -f12 <<<"${line}")
        language=$(cut -d"	" -f13 <<<"${line}")
        geolocation_locationName=$(cut -d"	" -f14 <<<"${line}")
        geolocation_ip=$(cut -d"	" -f15 <<<"${line}")
        geolocation_latitude=$(cut -d"	" -f16 <<<"${line}")
        geolocation_longitude=$(cut -d"	" -f17 <<<"${line}")
        geolocation_city=$(cut -d"	" -f18 <<<"${line}")
        geolocation_region=$(cut -d"	" -f19 <<<"${line}")
        geolocation_country=$(cut -d"	" -f20 <<<"${line}")
        geolocation_countryCode=$(cut -d"	" -f21 <<<"${line}")
        environment_userAgent=$(cut -d"	" -f22 <<<"${line}")
        environment_javascript=$(cut -d"	" -f23 <<<"${line}")
        environment_cookies=$(cut -d"	" -f24 <<<"${line}")
        environment_browser_name=$(cut -d"	" -f25 <<<"${line}")
        environment_browser_version=$(cut -d"	" -f26 <<<"${line}")
        environment_os=$(cut -d"	" -f27 <<<"${line}")
        user_clusters=$(cut -d"	" -f28 <<<"${line}")
        user_language=$(cut -d"	" -f29 <<<"${line}")
        user_birthdate=$(cut -d"	" -f30 <<<"${line}")
        user_gender=$(cut -d"	" -f31 <<<"${line}")
        user_address_latitude=$(cut -d"	" -f32 <<<"${line}")
        user_address_longitude=$(cut -d"	" -f33 <<<"${line}")
        user_address_city=$(cut -d"	" -f34 <<<"${line}")
        user_address_region=$(cut -d"	" -f35 <<<"${line}")
        user_address_country_code=$(cut -d"	" -f36 <<<"${line}")
        user_interests=$(cut -d"	" -f37 <<<"${line}")
        user_channel=$(cut -d"	" -f38 <<<"${line}")
        user_socialNetworks_facebook=$(cut -d"	" -f39 <<<"${line}")
        user_socialNetworks_linkedin=$(cut -d"	" -f40 <<<"${line}")
        user_socialNetworks_google=$(cut -d"	" -f41 <<<"${line}")
        url=$(cut -d"	" -f42 <<<"${line}")
        devicetype=$(cut -d"	" -f43 <<<"${line}")	

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

result="{\"_id\":\"$id\",\"deviceType\":\"browser\",\"clientTimestamp\":\"$clientTimestamp\",\"serverTimestamp\":\"$clientTimestamp\",\"processedTimestamp\":\"$clientTimestamp\",\"action\":\"pageview\",\"namespace\":null,\"infinitiID\":\"63e67c1b-3d82-4217-b01a-0df1e5121465\",\"installationID\":\"$customerID\",\"sessionID\":\"$sessionID\",\"customerID\":\"$customerID\",\"referral\":null,\"clusters\":[$clusters],\"language\":\"$language\",\"geolocation\":{\"locationName\":\"$geolocation_locationName\",\"ip\":\"$geolocation_ip\",\"latitude\":\"$geolocation_latitude\",\"longitude\":\"$geolocation_longitude\",\"city\":\"$geolocation_city\",\"region\":\"$geolocation_region\",\"countryCode\":\"$geolocation_countryCode\"},\"environment\":{\"userAgent\":\"$environment_userAgent\",\"screenSize\":null,\"windowSize\":null,\"javascript\":true,\"cookies\":true,\"doNotTrack\":false,\"geolocation\":$geolocation,\"touchPoints\":null,\"landscapeMode\":null,\"device\":{\"isProjection\":false,\"isTV\":false},\"browser\":{\"name\":\"$environment_browser_name\",\"version\":\"$environment_browser_version\",\"language\":\"user_language\"},\"os\":\"$environment_os\",\"vendor\":null,\"model\":null,\"deviceId\":null,\"deviceType\":\"$devicetype\",\"maxTouchPoints\":null},\"user\":{\"clusters\":[$clusters],\"language\":\"$user_language\",\"birthday\":\"$user_birthdate\",\"gender\":\"$user_gender\",\"address\":{\"latitude\":\"$user_address_latitude\",\"longitude\":\"$user_address_longitude\",\"city\":\"$user_address_city\",\"region\":\"$user_address_region\",\"country_code\":\"$user_address_country_code\"},\"interests\":null,\"channel\":null,\"socialNetworks\":{\"facebook\":\"$user_socialNetworks_facebook\",\"linkedin\":\"$user_socialNetworks_linkedin\",\"linkedin\":\"$user_socialNetworks_google\"}},\"payload_pageview\":{\"url\":\"$url\",\"context\":null,\"keywords\":null}}"



final=`sed  's:"NULL":null:g'  <<< $result`
final=`sed  's:"false":false:g'  <<< $final`
final=`sed  's:"true":true:g'  <<< $final`
final=`sed  's:"":null:g'  <<< $final`

echo $final >> $dest



#echo "$id $clusters $user_birthdate $user_address_country_code $user_gender $user_socialNetworks_facebook | $user_socialNetworks_linkedin | $user_socialNetworks_google | $url"
done
#done < $file

aws s3 cp $dest s3://2p-bq --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers --region us-east-1  --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
gsutil cp $dest gs://2pventuredataeu
bq insert infiniti_tracking_development.event $dest



echo $(date)
