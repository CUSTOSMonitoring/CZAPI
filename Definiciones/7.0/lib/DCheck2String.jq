#vim: set ts=3 expandtab:

def Dchecksnmpv3_authprotocolToString( value ):
   if value == "0" then  "MD5"
   elif value == "1" then "SHA1"
   elif value == "2" then "SHA224"
   elif value == "3" then "SHA256"
   elif value == "4" then "SHA384"
   elif value == "5" then "SHA512"
   else "desconocido" end;

def Dchecksnmpv3_privprotocolToString(value):
   if value   == "0" then "DES"
   elif value == "1" then "AES128"
   elif value == "2" then "AES192"
   elif value == "3" then "AES256"
   elif value == "4" then "AES192C"
   elif value == "5" then "AES256C"
   else "desconocido" end;

def Dchecksnmpv3_securitylevelToString( value ):
   if value   == "0" then "noAuthNoPriv"
   elif value == "1" then "authNoPriv"
   elif value == "2" then "authPriv"
   else "desconocido" end;

def DchecktypeToString( value ):
   if value   == "0" then "SSH"
   elif value == "1" then "LDAP"
   elif value == "2" then "SMTP"
   elif value == "3" then "FTP"
   elif value == "4" then "HTTP"
   elif value == "5" then "POP"
   elif value == "6" then "NNTP"
   elif value == "7" then "IMAP"
   elif value == "8" then "TCP"
   elif value == "9" then "Zabbix agent"
   elif value == "10" then "SNMPv1 agent"
   elif value == "11" then "SNMPv2 agent"
   elif value == "12" then "ICMP ping"
   elif value == "13" then "SNMPv3 agent"
   elif value == "14" then "HTTPS"
   elif value == "15" then "Telnet"
   else "desconocido" end;

def DcheckuniqToString( value ):
   if value == "0" then "do not use this check as a uniqueness criteria"
   elif value == "1" then "use this check as a uniqueness criteria"
   else "desconocido" end;

def Dcheckhost_source( value ):
   if value == "1" then "DNS"
   elif value == "2" then "IP"
   elif value == "3" then "discovery value of this check"
   else "desconocido" end;

def Dcheckname_sourceToString( value ):
   if value == "0" then "not specified"
   elif value == "1" then "DNS"
   elif value == "2" then "IP"
   elif value == "3" then "discovery value of this check"
   else "desconocido" end;

def DcheckToString( value ):
 value | to_entries | map( if .key == "snmpv3_authprotocol" then
                           .value = Dchecksnmpv3_authprotocolToString( .value )
                        elif .key == "snmpv3_privprotocol" then
                           .value = Dchecksnmpv3_privprotocolToString( .value )
                        elif .key == "snmpv3_securitylevel" then
                           .value = Dchecksnmpv3_securitylevelToString( .value )
                        elif .key == "type" then
                           .value = DchecktypeToString( .value )
                        elif .key == "uniq" then
                           .value = DcheckuniqToString( .value )
                        elif .key == "host_source" then
                           .value = Dcheckhost_source( .value )
                        elif .key == "name_source" then
                           .value = Dcheckname_sourceToString( .value )
                        else
                           .
                        end) | from_entries ;
