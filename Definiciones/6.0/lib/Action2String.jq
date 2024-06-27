#vim: set ts=3 expandtab shiftwidth=3:

def ActioneventsourceToString( value ):
   if value=="0" then "event created by a trigger"
   elif value=="1" then "event created by a discovery rule"
   elif value=="2" then "event created by active agent autoregistration"
   elif value=="3" then "internal event"
   elif value=="4" then "event created on service status update"
   else "desconocido" end;

def ActionstatusToString( value ):
   if value=="0" then "enabled"
   elif value=="1" then "disabled"
   else "desconocido" end;

def Actionpause_suppressedToString( value ):
   if value=="0" then "Don't pause escalation"
   elif value=="1" then "Pause escalation"
   else "desconocido" end;

def Actionnotify_if_canceledToString( value ):
   if value=="0" then "Don't notify when escalation is canceled"
   elif value=="1" then "Notify when escalation is canceled"
   else "desconocido" end;

def ActionoperationtypeToString( value ):
   if value=="0" then "send message"
   elif value=="1" then "global script"
   elif value=="2" then "add host"
   elif value=="3" then "remove host"
   elif value=="4" then "add to host group"
   elif value=="5" then "remove from host group"
   elif value=="6" then "link to template"
   elif value=="7" then "unlink from template"
   elif value=="8" then "enable host"
   elif value=="9" then "disable host"
   elif value=="10" then "set host inventory mode"
   else "desconocido" end;

def ActionoperationevaltypeToString( value ):
   if value=="0" then "AND/OR"
   elif value=="1" then "AND"
   elif value=="2" then "OR"
   else "desconocido" end;

def ActionoperationsToString( value ):
value | to_entries | map( if .key == "operationtype" then
                           .value = ActionoperationtypeToString( .value )
                          elif .key == "evaltype" then
                             .value = ActionoperationevaltypeToString( .value )
                          elif .key == "opmessage" then
                             if .value.default_msg == "0" then .value.default_msg = "use the data from the operation"
                             elif .value.default_msg == "1" then .value.default_msg = "use the data from the media type"
                             else "desconocido"
                             end
                          else
                             .
                          end) | from_entries ;

def ActionfilterevaltypeToString( value ):
   if value=="0" then "AND/OR"
   elif value=="1" then "AND"
   elif value=="2" then "OR"
   elif value=="3" then "custom expression"
   else "desconocido" end;

def ActionfilterconditionconditiontypeToString( value ):

   # Possible values for trigger actions:
   if value=="0" then "host group"
   elif value=="1" then "host"
   elif value=="2" then "trigger"
   elif value=="3" then "event name"
   elif value=="4" then "trigger severity"
   elif value=="6" then "time period"
   elif value=="7" then "host IP"
   elif value=="8" then "discovered service type"
   elif value=="9" then "discovered service port"
   elif value=="10" then "discovery status"
   elif value=="11" then "uptime or downtime duration"
   elif value=="12" then "received value"
   elif value=="13" then "host template"
   elif value=="16" then "problem is suppressed"
   elif value=="18" then "discovery rule"
   elif value=="19" then "discovery check"
   elif value=="20" then "proxy"
   elif value=="21" then "discovery object"
   elif value=="22" then "host name"
   elif value=="23" then "event type"
   elif value=="24" then "host metadata"
   elif value=="25" then "event tag"
   elif value=="26" then "event tag value"
   elif value=="27" then "service"
   elif value=="28" then "service name"
   else "desconocido" end;

def ActionfilterconditionoperatorToString( value ):
    if value=="0" then "equals"
    elif value=="1" then "does not equal"
    elif value=="2" then "contains"
    elif value=="3" then "does not contain"
    elif value=="4" then "in"
    elif value=="5" then "is greater than or equals"
    elif value=="6" then "is less than or equals"
    elif value=="7" then "not in"
    elif value=="8" then "matches"
    elif value=="9" then "does not match"
    elif value=="10" then "Yes"
    elif value=="11" then "No"
    else "desconocido" end;

def ActionfiltersconditionsToString( value ):
value | to_entries | map( if .key == "conditiontype" then
                             .value = ActionfilterconditionconditiontypeToString( .value )
                          elif .key == "operator" then
                             .value = ActionfilterconditionoperatorToString( .value )
                          else
                             .
                          end) | from_entries ;

def ActionfilterToString( value ):
value | to_entries | map( if .key == "evaltype" then
                             .value = ActionfilterevaltypeToString( .value )
                          elif .key == "conditions" then
                             .value[] |= ActionfiltersconditionsToString( . )
                          else
                             .
                          end) | from_entries ;

def ActionToString( value ):
value | to_entries | map( if .key == "eventsource" then
                           .value = ActioneventsourceToString( .value )
                          elif .key == "status" then
                             .value = ActionstatusToString( .value )
                          elif .key == "pause_suppressed" then
                             .value = Actionpause_suppressedToString( .value )
                          elif .key == "notify_if_canceled" then
                             .value = Actionnotify_if_canceledToString( .value )
                          elif .key == "filter" then
                             .value = ActionfilterToString( .value )
                          elif .key == "operations" then
                             .value[] |= ActionoperationsToString( . )
                          else
                             .
                          end) | from_entries ;
