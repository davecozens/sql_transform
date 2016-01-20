SELECT 
        uuid() as `_id`,
        'browser' as `DeviceType`,
        `infiniti-live`.`SessionAction`.`SessionActionDate` AS `clientTimestamp`,
        'pageview' as action,
        null as `namespace`,
        Customer.CustomerGuid as `infinitiID`,
        '' as `installationID`,
        `infiniti-live`.`Session`.`SessionID` AS `sessionID`,
        `infiniti-live`.`Customer`.`CustomerID` AS `customerID`,
        `infiniti-live`.`ChannelSource`.`ChannelSourceName` AS `referral_Channel`,
        '' as `referral_url`,
        `infiniti-live`.`BD_CustomerCluster`.`clusters` as `clusters`,
        `infiniti-live`.`BD_CustomerTopConfidentLanguage`.`LanguageCode` as `language`,
        '' as `geolocation_locationName`,
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
        `ESPreparedCustomerTopConfidentGender`.`GenderName` AS `user_gender`,                                
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
        `infiniti-live`.`SessionAction`.`ActionURL` AS `actionUrl`,
	`infiniti-live`.`CustomerDevice`.`DeviceType` AS `DeviceType`

    FROM
        ((((((((((((((
        `infiniti-live`.`SessionAction`
        JOIN `infiniti-live`.`Action` ON ((`infiniti-live`.`SessionAction`.`ActionID` = `infiniti-live`.`Action`.`ActionID`)))
        JOIN `infiniti-live`.`Session` ON ((`infiniti-live`.`Session`.`SessionID` = `infiniti-live`.`SessionAction`.`SessionID`)))
        JOIN `infiniti-live`.`Customer` ON ((`infiniti-live`.`Session`.`CustomerID` = `infiniti-live`.`Customer`.`CustomerID`)))
        LEFT JOIN `infiniti-live`.`BD_SocialAccountMembership` ON ((`infiniti-live`.`Customer`.`CustomerID` = `infiniti-live`.`BD_SocialAccountMembership`.`CustomerID`)))                
        LEFT JOIN `infiniti-live`.`BD_CustomerTopConfidentBirthDate` ON ((`infiniti-live`.`Customer`.`CustomerID` = `infiniti-live`.`BD_CustomerTopConfidentBirthDate`.`CustomerID`)))                
        LEFT JOIN `infiniti-live`.`BD_CustomerTopConfidentLanguage` ON ((`infiniti-live`.`Customer`.`CustomerID` = `infiniti-live`.`BD_CustomerTopConfidentLanguage`.`CustomerID`)))        
        LEFT JOIN `infiniti-live`.`BD_CustomerCluster` ON ((`infiniti-live`.`Customer`.`CustomerID` = `infiniti-live`.`BD_CustomerCluster`.`CustomerID`)))
        LEFT JOIN `infiniti-live`.`BD_IPAddressWithCountryAndCity` ON ((`infiniti-live`.`Session`.`IPAddressID` = `infiniti-live`.`BD_IPAddressWithCountryAndCity`.`IPAddressID`)))
        LEFT JOIN `infiniti-live`.`ESPreparedCustomerTopConfidentGender` ON ((`infiniti-live`.`Customer`.`CustomerID` = `ESPreparedCustomerTopConfidentGender`.`CustomerID`)))
        LEFT JOIN `infiniti-live`.`ESPreparedCustomerTopConfidentCountry` ON ((`ESPreparedCustomerTopConfidentCountry`.`CustomerID` = `infiniti-live`.`Customer`.`CustomerID`)))
        LEFT JOIN `infiniti-live`.`ESPreparedTransactions` ON ((`ESPreparedTransactions`.`SessionID` = `infiniti-live`.`Session`.`SessionID`)))
        JOIN `infiniti-live`.`ESPreparedEntryPoints` ON ((`ESPreparedEntryPoints`.`SessionID` = `infiniti-live`.`Session`.`SessionID`)))
        JOIN `infiniti-live`.`ChannelSource` ON ((`infiniti-live`.`Session`.`ChannelSourceID` = `infiniti-live`.`ChannelSource`.`ChannelSourceID`)))
        LEFT JOIN `infiniti-live`.`CustomerDevice` ON (((`infiniti-live`.`Session`.`CustomerDeviceID` = `infiniti-live`.`CustomerDevice`.`CustomerDeviceID`)
            AND (`infiniti-live`.`SessionAction`.`ActionID` = `infiniti-live`.`Action`.`ActionID`))))
            
limit 100
