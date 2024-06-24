#vim: set ts=3 expandtab:
include "Gral2String";

def ProblemSourceToString( source ):
   if source == "0" then "event created by a trigger"
   elif source == "3" then "internal event"
   elif source == "4" then "event created on service status update"
   else "desconocido" end;

def ProblemSuppressedToString( suppressed ):
   if suppressed == "0" then "problem is in normal state"
   elif suppressed == "1" then "problem is suppressed"
   else "desconocido" end;

def ProblemAcknowledgedToString( acknowledged ):
   if acknowledged == "0" then "not acknowledged"
   elif acknowledged == "1" then "acknowledged"
   else "desconocido" end;

def ProblemSeverityToString( severity ):
   if severity == "0" then "not classified"
   elif severity == "1" then "information"
   elif severity == "2" then "warning"
   elif severity == "3" then "average"
   elif severity == "4" then "high"
   elif severity == "5" then "disaster"
   else "desconocido" end;

def ProblemObjectToString( object ):
   if object == "0" then "trigger"
   elif object == "4" then "item"
   elif object == "5" then "LLD rule"
   elif object == "6" then "service"
   else "desconocido" end;

def ProblemToString( problem ):
   problem | to_entries | map( if .key == "object" then
                           .value = ProblemObjectToString( .value )
                        elif .key == "source" then
                           .value = ProblemSourceToString( .value )
                        elif .key == "suppressed" then
                           .value = ProblemSuppressedToString( .value )
                        elif .key == "acknowledged" then
                           .value = ProblemAcknowledgedToString( .value )
                        elif .key == "severity" then
                           .value = ProblemSeverityToString( .value )
                        elif .key == "object" then
                           .value = ProblemObjectToString( .value )
                        elif .key == "clock" then
                           .value = DateToString( .value )
                        else
                           .
                        end) | from_entries ;
