SELECT 
        uuid() as `_id`,
        'browser' as `DeviceType`,
        `infiniti-live`.`SessionAction_NoReferrers`.`SessionActionDate` AS `clientTimestamp`,
        'pageview' as action,
        null as `namespace`,
        Customer.CustomerGuid as `infinitiID`,
        `infiniti-live`.`Customer`.`CustomerID` as `installationID`,
        `infiniti-live`.`Session`.`SessionID` AS `sessionID`,
        `infiniti-live`.`Customer`.`CustomerID` AS `customerID`,
        `infiniti-live`.`SessionAction_Referrers`.`referrerChannel` AS `referral_Channel`,
        `infiniti-live`.`SessionAction_Referrers`.`referrerURL` AS `referral_URL`,
        `infiniti-live`.`BD_CustomerCluster`.`clusters` as `clusters`,
        `infiniti-live`.`BD_CustomerTopConfidentLanguage`.`LanguageCode` as `language`,
        CONCAT_WS(', ',
			IF(LENGTH(`infiniti-live`.`BD_IPAddressWithCountryAndCity`.`City`),`infiniti-live`.`BD_IPAddressWithCountryAndCity`.`City`,NULL),
			IF(LENGTH(`infiniti-live`.`BD_IPAddressWithCountryAndCity`.`Country`),`infiniti-live`.`BD_IPAddressWithCountryAndCity`.`Country`,NULL)
        )	as `geolocation_locationName`,
        `infiniti-live`.`BD_IPAddressWithCountryAndCity`.`IPAddressValue` AS `geolocation_ip`,
        `infiniti-live`.`BD_IPAddressWithCountryAndCity`.`IPAddressLat` AS `geolocation_latitude`,
        `infiniti-live`.`BD_IPAddressWithCountryAndCity`.`IPAddressLong` AS `geolocation_longitude`,
        `infiniti-live`.`BD_IPAddressWithCountryAndCity`.`City` AS `geolocation_city`,
        `infiniti-live`.`BD_IPAddressWithCountryAndCity`.`IPAddressRegion` AS `geolocation_region`,
        `infiniti-live`.`BD_IPAddressWithCountryAndCity`.`Country` AS `geolocation_country`,
        `infiniti-live`.`BD_IPAddressWithCountryAndCity`.`CountryCode2` AS `geolocation_countryCode`,
        `infiniti-live`.`CustomerDevice`.`USerAgent` AS `environment_userAgent`,
        `infiniti-live`.`CustomerDevice`.`JavascriptEnabled` AS `environment_javascript`,
        `infiniti-live`.`CustomerDevice`.`CookiesEnabled` AS `environment_cookies`,
        `infiniti-live`.`CustomerDevice`.`DeviceBrowser` AS `environment_browser_name`,
        `infiniti-live`.`CustomerDevice`.`BrowserVersion` AS `environment_browser_version`,
        `infiniti-live`.`CustomerDevice`.`OS` AS `environment_os`,
        `infiniti-live`.`BD_CustomerCluster`.`Clusters` AS `user_clusters`,
        `infiniti-live`.`BD_CustomerTopConfidentLanguage`.`LanguageCode` AS `user_language`,
        `infiniti-live`.`BD_CustomerTopConfidentBirthDate`.`CustomerBirthDate` AS `user_birthdate`,
        LOWER(`ESPreparedCustomerTopConfidentGender`.`GenderName`) AS `user_gender`,                                
        '' as `user_address_latitutde`,
        '' as `user_address_longitude`,        
        `ESPreparedCustomerTopConfidentCountry`.`CityName` AS `user_address_city`,
        '' as `user_address_region`,        
        `ESPreparedCustomerTopConfidentCountry`.`CountryCode` AS `user_address_country_code`,
        '' as `user_interests`,        
        '' as `user_channel`,        
        `infiniti-live`.`BD_SocialAccountMembership`.`Facebook` AS `user.socialNetworks.facebook`,
        `infiniti-live`.`BD_SocialAccountMembership`.`LinkedIn` AS `user.socialNetworks.linkedin`,
        `infiniti-live`.`BD_SocialAccountMembership`.`GooglePlus` AS `user.socialNetworks.google`,
        `infiniti-live`.`SessionAction_NoReferrers`.`PageURI` AS `url`,
        `infiniti-live`.`SessionAction_NoReferrers`.`PageKeywords` AS `keywords`,
	REPLACE( `infiniti-live`.`SessionAction_NoReferrers`.`PageTitle`, '"', '' ) AS `pagetitle`,
--        `infiniti-live`.`SessionAction_NoReferrers`.`PageTitle` AS `pagetitle`,
        `infiniti-live`.`BD_IsAnonymousUser`.`isAnonymous` AS `isAnonymous`,
	lower(`infiniti-live`.`CustomerDevice`.`DeviceType`) as DeviceType
    FROM
        ((((((((((((
--        (
--        (
        `infiniti-live`.`SessionAction_NoReferrers`
--        JOIN `infiniti-live`.`Action` ON ((`infiniti-live`.`SessionAction_NoReferrers`.`ActionID` = `infiniti-live`.`Action`.`ActionID`)))
        JOIN `infiniti-live`.`Session` ON ((`infiniti-live`.`Session`.`SessionID` = `infiniti-live`.`SessionAction_NoReferrers`.`SessionID`)))
        JOIN `infiniti-live`.`Customer` ON ((`infiniti-live`.`Session`.`CustomerID` = `infiniti-live`.`Customer`.`CustomerID`)))
        LEFT JOIN `infiniti-live`.`BD_SocialAccountMembership` ON ((`infiniti-live`.`Customer`.`CustomerID` = `infiniti-live`.`BD_SocialAccountMembership`.`CustomerID`)))                
        LEFT JOIN `infiniti-live`.`BD_CustomerTopConfidentBirthDate` ON ((`infiniti-live`.`Customer`.`CustomerID` = `infiniti-live`.`BD_CustomerTopConfidentBirthDate`.`CustomerID`)))                
        LEFT JOIN `infiniti-live`.`BD_CustomerTopConfidentLanguage` ON ((`infiniti-live`.`Customer`.`CustomerID` = `infiniti-live`.`BD_CustomerTopConfidentLanguage`.`CustomerID`)))        
        LEFT JOIN `infiniti-live`.`BD_CustomerCluster` ON ((`infiniti-live`.`Customer`.`CustomerID` = `infiniti-live`.`BD_CustomerCluster`.`CustomerID`)))
        LEFT JOIN `infiniti-live`.`BD_IPAddressWithCountryAndCity` ON ((`infiniti-live`.`Session`.`IPAddressID` = `infiniti-live`.`BD_IPAddressWithCountryAndCity`.`IPAddressID`)))
        LEFT JOIN `infiniti-live`.`ESPreparedCustomerTopConfidentGender` ON ((`infiniti-live`.`Customer`.`CustomerID` = `ESPreparedCustomerTopConfidentGender`.`CustomerID`)))
        LEFT JOIN `infiniti-live`.`ESPreparedCustomerTopConfidentCountry` ON ((`ESPreparedCustomerTopConfidentCountry`.`CustomerID` = `infiniti-live`.`Customer`.`CustomerID`)))
--        LEFT JOIN `infiniti-live`.`ESPreparedTransactions` ON ((`ESPreparedTransactions`.`SessionID` = `infiniti-live`.`Session`.`SessionID`)))
		LEFT JOIN `infiniti-live`.`SessionAction_Referrers` on ((`SessionAction_Referrers`.`SessionID` = `infiniti-live`.`Session`.`SessionID`)))
--		JOIN `infiniti-live`.`BD_SessionPageViews` on ((`BD_SessionPageViews`.`SessionID` = `infiniti-live`.`Session`.`SessionID`)))
		JOIN `infiniti-live`.`BD_IsAnonymousUser` on ((`infiniti-live`.`BD_IsAnonymousUser`.`CustomerID` = `infiniti-live`.`Session`.`CustomerID`)))
--        JOIN `infiniti-live`.`ESPreparedEntryPoints` ON ((`ESPreparedEntryPoints`.`SessionID` = `infiniti-live`.`Session`.`SessionID`)))
--        JOIN `infiniti-live`.`ChannelSource` ON ((`infiniti-live`.`Session`.`ChannelSourceID` = `infiniti-live`.`ChannelSource`.`ChannelSourceID`)))
        LEFT JOIN `infiniti-live`.`CustomerDevice` ON (((`infiniti-live`.`Session`.`CustomerDeviceID` = `infiniti-live`.`CustomerDevice`.`CustomerDeviceID`)
            )))
            
where `infiniti-live`.`Customer`.`CustomerID`  between user1 and  user2



