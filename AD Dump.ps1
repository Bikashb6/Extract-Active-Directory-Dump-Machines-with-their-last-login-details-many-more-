$wkst=Get-ADComputer -LDAPFilter "(&(objectcategory=computer)(|((name=W*U8*)(name=SDU8*)(name=STU8*)(name=SAU8*)(name=SPU8*))))" -Properties distinguishedName,name,description,dNSHostName,IPv4Address,operatingSystem,enabled,lastLogonTimestamp -SearchBase "ou=u8,ou=tenants,dc=ad,dc=ing,dc=net" | Sort-Object Name | Select  Name,distinguishedName,description,dNSHostName,IPv4Address,operatingSystem,enabled,@{n='lastLogonTimestamp';e={[DateTime]::FromFileTime($_.lastLogonTimestamp)}}
$wkst | Select Name,distinguishedName,description,dNSHostName,IPv4Address,operatingSystem,enabled, @{Name="lastLogonTimestamp";
  Expression={$_.lastLogonTimestamp.Tostring("yyyy-MM-dd HH:mm")}} | Export-Csv -Delimiter ',' -Path dest:\"AD-dump $(get-date -f yyyy-MM-dd).csv" -NoTypeInformation

