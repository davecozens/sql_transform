#!/bin/bash

while read line           
do           
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
	user_address_latitude=$(cut -d"	" -f31 <<<"${line}")
	user_address_longitude=$(cut -d"	" -f32 <<<"${line}")
	user_address_city=$(cut -d"	" -f33 <<<"${line}")
	user_address_region=$(cut -d"	" -f34 <<<"${line}")
	user_address_country_code=$(cut -d"	" -f35 <<<"${line}")
	user_interests=$(cut -d"	" -f36 <<<"${line}")
	user_channel=$(cut -d"	" -f37 <<<"${line}")
	user_socialNetworks_facebook=$(cut -d"	" -f38 <<<"${line}")
	user_socialNetworks_linkedin=$(cut -d"	" -f39 <<<"${line}")
	user_socialNetworks_google=$(cut -d"	" -f40 <<<"${line}")
	url=$(cut -d"	" -f41 <<<"${line}")



	echo "$id $clusters $user_birthdate $user_address_country_code $user_gender $user_socialNetworks_facebook $user_socialNetworks_linkedin $user_socialNetworks_google $url"
done < pageview_event_out.tab


