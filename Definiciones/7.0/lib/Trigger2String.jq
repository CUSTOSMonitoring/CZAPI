#vim: set ts=3 expandtab:
include "Gral2String";
include "Tag2String";

def TriggerPriorityToString( value ):
   if value == "0" then "not classified"
   elif value == "1" then "information"
   elif value == "2" then "warning"
   elif value == "3" then "average"
   elif value == "4" then "high"
   elif value == "5" then "disaster"
   else "desconocido" end;

def TriggerFlagsToString( value ):
   if value == "0" then "plain trigger"
   elif value == "4" then "discovered trigger"
   else "desconocido" end;

def TriggerStateToString( value ):
   if value == "0" then "trigger state is up to date"
   elif value == "1" then "current trigger state is unknown"
   else "desconocido" end;

def TriggerStatusToString( value ):
   if value == "0" then "enabled"
   elif value == "1" then "disabled"
   else "desconocido" end;

def TriggerTypeToString( value ):
   if value == "0" then "do not generate multiple events"
   elif value == "1" then "generate multiple events"
   else "desconocido" end;

def TriggerValueToString( value ):
   if value == "0" then "OK"
   elif value == "1" then "problem"
   else "desconocido" end;

def TriggerRecovery_modeToString( value ):
   if value == "0" then "Expression"
   elif value == "1" then "Recovery expression"
   elif value == "2" then "None"
   else "desconocido" end;

def TriggerCorrelation_modeToString( value ):
   if value == "0" then "All problems"
   elif value == "1" then "All problems if tab values match"
   else "desconocido" end;

def TriggerManual_closeToString( value ):
   if value == "0" then "No"
   elif value == "1" then "Yes"
   else "desconocido" end;

def TriggerToString( value ):
 value | to_entries | map( if .key == "priority" then
                           .value = TriggerPriorityToString( .value )
                        elif .key == "status" then
                           .value = TriggerStatusToString( .value )
                        elif .key == "state" then
                           .value = TriggerStateToString( .value )
                        elif .key == "type" then
                           .value = TriggerTypeToString( .value )
                        elif .key == "value" then
                           .value = TriggerValueToString( .value )
                        elif .key == "recovery_mode" then
                           .value = TriggerRecovery_modeToString( .value )
                        elif .key == "correlation_mode" then
                           .value = TriggerCorrelation_modeToString( .value )
                        elif .key == "manual_close" then
                           .value = TriggerManual_closeToString( .value )
                        elif .key == "flags" then
                           .value = TriggerFlagsToString( .value )
                        elif .key == "tags" then
                           if ( ( .key | type ) == "array" ) then
                              .value[] |= TagToString( . )
                           else
                              .
                           end
                        else
                           .
                        end) | from_entries ;
