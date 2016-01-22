use `infiniti-live`;
SET SESSION group_concat_max_len = 10000;

select
        uuid() as `_id`,
        S.SessionID as sessionID,
        `infiniti-live`.`Customer`.`CustomerID` as `installationID`,
       `infiniti-live`.`Customer`.`CustomerID` AS `customerID`,
        Customer.CustomerGuid as `infinitiID`,
        'browser' as `DeviceType`,
        CO.CustomerOrderCreated AS `clientTimestamp`,
        CO.CustomerOrderCreated AS `serverTimestamp`,
        CO.CustomerOrderCreated AS `processedTimestamp`,
        'transaction' as action,
        'shop' as `namespace`,


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
         `infiniti-live`.`BD_IsAnonymousUser`.`isAnonymous` AS `isAnonymous`,
 
	CO.AmountPaid as transactionRevenue,
        '' as `delivery_address_latitude`,
        '' as `delivery_address_longitude`,        
        `ESPreparedCustomerTopConfidentCountry`.`CityName` AS `delivery_address_city`,
        '' as `delivery_address_region`,        
        `ESPreparedCustomerTopConfidentCountry`.`CountryCode` AS `delivery_address_country_code`,

    CO.Currency as orderCurrency,





	M.SKU as transactionItemsSKU,
    CECT.AmountPaid as transactionItemsPrice,
    CECT.Quantity as transactionItemsQuantity,    
	CECT.Name as itemsName,
	CECT.Category as transactionItemsCategory,

	orderSummary.orderQuantity as itemsCount,
	null as loyalty,
	CO.CustomerOrderCreated as transactionServerTimestamp,
	CO.TransactionNumber as transactionID,
	`infiniti-live`.`BD_IsAnonymousUser`.`isAnonymous` AS isAnonymous,
	ti.items
from 
	BD_CustomerEcommerce CECT
		join Merchandise M
			on (M.ID = CECT.MerchandiseID )
		join CustomerOrder CO
			on (CECT.CustomerOrderID = CO.CustomerOrderID) 
		join Session S
			on (CECT.SessionID = S.SessionID)        


		LEFT JOIN `infiniti-live`.`BD_IPAddressWithCountryAndCity` 
			ON S.`IPAddressID` = `infiniti-live`.`BD_IPAddressWithCountryAndCity`.`IPAddressID`

		LEFT JOIN `infiniti-live`.`BD_CustomerTopConfidentBirthDate` ON CO.`CustomerID` = `infiniti-live`.`BD_CustomerTopConfidentBirthDate`.`CustomerID`                
        LEFT JOIN `infiniti-live`.`BD_CustomerTopConfidentLanguage` ON CO.`CustomerID` = `infiniti-live`.`BD_CustomerTopConfidentLanguage`.`CustomerID`        
        LEFT JOIN `infiniti-live`.`BD_CustomerCluster` ON CO.`CustomerID` = `infiniti-live`.`BD_CustomerCluster`.`CustomerID`
        LEFT JOIN `infiniti-live`.`CustomerDevice` ON S.`CustomerDeviceID` = `infiniti-live`.`CustomerDevice`.`CustomerDeviceID`
        JOIN `infiniti-live`.`Customer` ON CO.`CustomerID` = `infiniti-live`.`Customer`.`CustomerID`        

        LEFT JOIN `infiniti-live`.`BD_SocialAccountMembership` ON Customer.`CustomerID` = `infiniti-live`.`BD_SocialAccountMembership`.`CustomerID`              
        LEFT JOIN `infiniti-live`.`ESPreparedCustomerTopConfidentGender` ON `infiniti-live`.`Customer`.`CustomerID` = `ESPreparedCustomerTopConfidentGender`.`CustomerID`
        LEFT JOIN `infiniti-live`.`ESPreparedCustomerTopConfidentCountry` ON `ESPreparedCustomerTopConfidentCountry`.`CustomerID` = `infiniti-live`.`Customer`.`CustomerID`
		LEFT JOIN `infiniti-live`.`SessionAction_Referrers` on `SessionAction_Referrers`.`SessionID` = S.`SessionID`
		JOIN `infiniti-live`.`BD_IsAnonymousUser` on `infiniti-live`.`BD_IsAnonymousUser`.`CustomerID` = S.`CustomerID`
		join (

			select 
			CustomerOrderId,
			count(quantity) as orderQuantity
			from BD_CustomerEcommerce
			group by CustomerOrderId

		) orderSummary on orderSummary.CustomerOrderId = CO.CustomerOrderId
join (
	select
		CustomerOrderID,
		group_concat(
			'{',
			'"sku":"',SKU,'",'
			'"currency":"',Currency,'",'
			'"quantity":',Quantity,','
			'"name":"',Name,'",'    
			'"category":"',Category,'"'    
			'}'
		) as items
		FROM `infiniti-live`.BD_CustomerEcommerce
		where CustomerOrderID=421396
		group by CustomerOrderID
	) ti  on ti.CustomerOrderID = CO.CustomerOrderID 			

-- where 
-- `infiniti-live`.`CustomerDevice`.`DeviceBrowser` !='Node.js' -- DO WE EXCLUDE IMPORTED ORDERS because alls ession info will be wrong...


-- and CO.CustomerID between user1 and user2
limit 100


