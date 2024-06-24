#vim: set ts=3 expandtab:
include "Gral2String";

def MaitenanceEvalTypeToString( value ):
   if value=="0" then "And/Or"
   elif value=="2" then "Or"
   else "desconocido" end;
  
def MaitenanceTypeToString( value ):
   if value=="0" then "with data collection"
   elif value=="1" then "without data collection"
   else "desconocido" end;

def MaintenanceToString( Obj ):
   Obj | to_entries | map( if .key == "maintenance_type" then
                           .value = MaitenanceTypeToString( .value )
                        elif .key == "active_since" then
                           .value = DateToString( .value )
                        elif .key == "active_till" then
                           .value = DateToString( .value )
                        elif .key == "tags_evaltype" then
                           .value = MaitenanceEvalTypeToString( .value )
                        else
                           .
                        end) | from_entries ;
