#vim: set ts=3 expandtab shiftwidth=3:
include "Gral2String";

def AuditlogactionToString( value ):
   if value=="0" then "Add"
   elif value=="1" then "Update"
   elif value=="2" then "Delete"
   elif value=="4" then "Logout"
   elif value=="7" then "Execute"
   elif value=="8" then "Login"
   elif value=="9" then "Failed login"
   elif value=="10" then "History clear"
   else "desconocido" end;


def AuditlogresourcetypeToString( value ):
   if value=="0" then "User"
   elif value=="3" then "Media type"
   elif value=="4" then "Host"
   elif value=="5" then "Action"
   elif value=="6" then "Graph"
   elif value=="11" then "User group"
   elif value=="13" then "Trigger"
   elif value=="14" then "Host group"
   elif value=="15" then "Item"
   elif value=="16" then "Image"
   elif value=="17" then "Value map"
   elif value=="18" then "Service"
   elif value=="19" then "Map"
   elif value=="22" then "Web scenario"
   elif value=="23" then "Discovery rule"
   elif value=="25" then "Script"
   elif value=="26" then "Proxy"
   elif value=="27" then "Maintenance"
   elif value=="28" then "Regular expression"
   elif value=="29" then "Macro"
   elif value=="30" then "Template"
   elif value=="31" then "Trigger prototype"
   elif value=="32" then "Icon mapping"
   elif value=="33" then "Dashboard"
   elif value=="34" then "Event correlation"
   elif value=="35" then "Graph prototype"
   elif value=="36" then "Item prototype"
   elif value=="37" then "Host prototype"
   elif value=="38" then "Autoregistration"
   elif value=="39" then "Module"
   elif value=="40" then "Settings"
   elif value=="41" then "Housekeeping"
   elif value=="42" then "Authentication"
   elif value=="43" then "Template dashboard"
   elif value=="44" then "User role"
   elif value=="45" then "API token"
   elif value=="46" then "Scheduled report"
   elif value=="47" then "High availability node"
   elif value=="48" then "SLA"
   else "desconocido" end;

def AuditlogToString( obj ):
 obj | to_entries | map( if .key == "clock" then
                           .value = DateToString( .value )
                        elif .key == "action" then
                           .value = AuditlogactionToString( .value )
                        elif .key == "resourcetype" then
                           .value = AuditlogresourcetypeToString( .value )
                        elif .key == "details" then
                           .value = ( .value )
                        else
                           .
                        end) | from_entries ;
