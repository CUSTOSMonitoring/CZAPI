#vim: set ts=3 expandtab:
include "Gral2String";

def DservicestatusToString( value ):
   if value == "0" then "service up"
   elif value == "1" then "service down"
   else "desconocido" end;

def DserviceToString( value ):
 value | to_entries | map( if .key == "lastdown" then
                           .value =  DateToString( .value )
                        elif .key == "lastup" then
                           .value = DateToString( .value )
                        elif .key == "status" then
                           .value = DservicestatusToString( .value )
                        else
                           .
                        end) | from_entries ;
