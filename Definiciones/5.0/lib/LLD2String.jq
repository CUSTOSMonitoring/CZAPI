#vim: set ts=3 expandtab:

def LLDStatusToString( status ):
   if status=="0" then "enabled"
   elif status=="1" then "disabled"
   else "desconocido" end;

def LLDStateToString( state ):
   if state=="0" then "normal"
   elif state=="1" then "not supported"
   else "desconocido" end;

def LLDTypeToString( type ):
   if type=="0" then "Zabbix agent"
   elif type=="10" then "external check"
   elif type=="11" then "database monitor"
   elif type=="12" then "IPMI agent"
   elif type=="13" then "SSH agent"
   elif type=="14" then "TELNET agent"
   elif type=="16" then "JMX agent"
   elif type=="18" then "Dependent item"
   elif type=="19" then "HTTP agent"
   elif type=="2" then "Zabbix trapper"
   elif type=="20" then "SNMP agent"
   elif type=="21" then "Script."
   elif type=="3" then "simple check"
   elif type=="5" then "Zabbix internal"
   elif type=="7" then "Zabbix agent (active)"
   else "desconocida" end;

def LLDToString( LLD ):
   LLD | to_entries | map( if .key == "status" then
                           .value = LLDStatusToString( .value )
                        elif .key == "state" then
                           .value = LLDStateToString( .value )
                        elif .key == "type" then
                           .value = LLDTypeToString( .value )
                        else
                           .
                        end) | from_entries ;
