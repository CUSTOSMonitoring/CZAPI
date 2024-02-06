#vim: set ts=3 expandtab:

def ItemTypeToString( type ):
   if type=="0" then "Zabbix agent"
   elif type=="2" then "Zabbix trapper"
   elif type=="3" then "Simple check"
   elif type=="5" then "Zabbix internal"
   elif type=="7" then "Zabbix agent (active)"
   elif type=="9" then "Web itemx"
   elif type=="10" then "External check"
   elif type=="11" then "Database monitor"
   elif type=="12" then "IPMI agent"
   elif type=="13" then "SSH agent"
   elif type=="14" then "Telnet agent"
   elif type=="15" then "Calculatedx"
   elif type=="16" then "JMX agent"
   elif type=="17" then "SNMP trap"
   elif type=="18" then "Dependent item"
   elif type=="19" then "HTTP agent"
   elif type=="20" then "SNMP agent"
   elif type=="21" then "Script"
   else "desconocido" end;

def ItemStatusToString( status ):
   if status=="0" then "habilitado"
   elif status=="1" then "deshabilitado"
   else "desconocido" end;

def ItemStateToString( state ):
   if state=="0" then "normal"
   elif state=="1" then "not supported"
   else "desconocido" end;

def ItemAllowTrapsToString( allow ):
   if allow=="0" then "Not allow"
   elif allow=="1" then "Allow"
   else "desconocido" end;

def ItemVerifyToString( verify ):
   if verify=="0" then "Do not validate"
   elif verify=="1" then "Validate"
   else "desconocido" end;

def ItemValueTypeToString( type ):
   if type=="0" then "numeric float"
   elif type=="1" then "character"
   elif type=="2" then "log"
   elif type=="3" then "numeric unsigned"
   elif type=="4" then "text"
   else "desconocido" end;

def ItemAuthTypeToString( itemtype; authType):
    if itemtype=="13" then #SSH Agent
       if authType=="0" then "password"
       elif authType=="1" then "public key"
       else "desconocido" end
    elif itemtype=="19" then # HTTP agent
       if authType=="0" then "none"
       elif authType=="1" then "basic"
       elif authType=="2" then "NTLM"
       elif authType=="3" then "Kerberos"
       else "desconocido" end
    else authType + " desconocido (Se necesita el tipo de item)" end;

def ItemFlagsToString( flags ):
    if flags=="0" then "plain item"
    elif flags=="4" then "discovered item"
    else "desconocido" end;

def ItemFollowRedirectsToString( follow ):
   if follow=="0" then "Do not follow redirects"
   elif follow=="1" then "Follow redirects"
   else "desconocido" end;

def ItemOutputFormatToString( format ):
   if format=="0" then "Store raw"
   elif format=="1" then "Convert to JSON"
   else "desconocido" end;

def ItemPostTypeToString( post ):
   if post=="0" then "Raw data"
   elif post=="2" then "JSON data"
   elif post=="3" then "XML data"
   else "desconocido" end;

def ItemRequestMethodToString( request ):
   if request=="0" then "GET"
   elif request=="1" then "POST"
   elif request=="2" then "PUT"
   elif request=="3" then "HEAD"
   else "desconocido" end;

def ItemRetrieveModeToString( retrive ):
   if retrive=="0" then "Body"
   elif retrive=="1" then "Headers"
   elif retrive=="2" then "Both body and headers"
   else "desconocido" end;

def ItemObjectToString( item ):
   "Cambio el nombre de la funcion de 'ItemObjectToString(' a 'ItemToString('";

def ItemToString( item ):
   item | to_entries | map( if .key == "type" then
                           .value = ItemTypeToString( .value )
                        elif .key == "status" then
                           .value = ItemStatusToString( .value )
                        elif .key == "state" then
                           .value = ItemStateToString( .value )
                        elif .key == "allow_traps" then
                           .value = ItemAllowTrapsToString( .value )
                        elif .key == "verify_host" then
                           .value = ItemVerifyToString( .value )
                        elif .key == "verify_peer" then
                           .value = ItemVerifyToString( .value )
                        elif .key == "value_type" then
                           .value = ItemValueTypeToString( .value )
                        elif .key == "authtype" then
                           .value = ItemAuthTypeToString( item.itemtype?; .value)
                        elif .key == "flags" then
                           .value = ItemFlagsToString( .value )
                        elif .key == "follow_redirects" then
                           .value = ItemFollowRedirectsToString( .value )
                        elif .key == "output_format" then
                           .value = ItemOutputFormatToString( .value )
                        elif .key == "request_method" then
                           .value = ItemRequestMethodToString( .value )
                        elif .key == "retrieve_mode" then
                           .value = ItemRetrieveModeToString( .value )
                        else
                           .
                        end) | from_entries ;
