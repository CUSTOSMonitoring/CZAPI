#vim: set ts=3 expandtab shiftwidth=3:

def InterfaceTypeToString( tipo ):
   if tipo=="1" then "agent"
   elif tipo=="2" then "SNMP"
   elif tipo=="3" then "IPMI"
   elif tipo=="4" then "JMX"
   else "desconocida" end;

def InterfaceAvailabilityToString( available ):
   if available=="0" then "unknown"
   elif available=="1" then "available"
   elif available=="2" then "unavailable"
   else "desconocida" end;

def InterfaceUseIpToString( useip ):
   if useip == "0" then "connect using DNS name"
   elif useip == "1" then "connect using IP address"
   else "desconocida" end;

def InterfaceErrorsFromToString( errors_from ):
   if errors_from == "0" then "N/A"
   else errors_from | tonumber | strflocaltime("%Y-%m-%d %H:%M:%S") end;

def InterfaceDisableUntilToString( disable_until ):
   if disable_until == "0" then "N/A"
   else disable_until | tonumber | strflocaltime("%Y-%m-%d %H:%M:%S") end;

def InterfaceDetailsVersionToString( version ):
   if version == "1" then "SNMPv1"
   elif version == "2" then "SNMPv2c"
   elif version == "3" then "SNMPv3"
   else "desconocida" end;

def InterfaceDetailsBulkToString( bulk ):
   if bulk == "0" then "don't use bulk requests"
   elif bulk == "1" then "use bulk requests"
   else "desconocida" end;

def InterfaceDetailsSecurityLevelToString( securitylevel ):
   if securitylevel == "0" then "noAuthNoPriv"
   elif securitylevel == "1" then "authNoPriv"
   elif securitylevel == "2" then "authPriv"
   else "desconocida" end;

def InterfaceDetailsauthprotocolLevelToString( securitylevel ):
   if securitylevel == "0" then "MD5"
   elif securitylevel == "1" then "SHA1"
   elif securitylevel == "2" then "SHA224"
   elif securitylevel == "3" then "SHA256"
   elif securitylevel == "4" then "SHA384"
   elif securitylevel == "5" then "SHA512"
   else "desconocida" end;

def InterfaceDetailsToString( details ):
 details | to_entries | map( if .key == "version" then
                           .value = InterfaceDetailsVersionToString( .value )
                        elif .key == "bulk" then
                           .value = InterfaceDetailsBulkToString( .value )
                        elif .key == "securitylevel" then
                           .value = InterfaceDetailsSecurityLevelToString( .value )
                        elif .key == "authprotocol" then
                           .value = InterfaceDetailsauthprotocolLevelToString( .value )
                        else
                           .
                        end) | from_entries ;

def InterfacemainToString( value ):
   if value == "0" then "not default"
   elif value == "1" then "default"
   else "unknown" end;

def InterfaceToString( interface ):
 interface | to_entries | map( if .key == "available" then
                           .value = InterfaceAvailabilityToString( .value )
                        elif .key == "main" then
                           .value = InterfacemainToString( .value )
                        elif .key == "details" then
                           .value = InterfaceDetailsToString( .value )
                        elif .key == "errors_from" then
                           .value = InterfaceErrorsFromToString( .value )
                        elif .key == "disable_until" then
                           .value = InterfaceDisableUntilToString( .value )
                        elif .key == "useip" then
                           .value = InterfaceUseIpToString( .value )
                        elif .key == "type" then
                           .value = InterfaceTypeToString( .value )
                        else
                           .
                        end) | from_entries ;

