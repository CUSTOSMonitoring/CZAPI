#vim: set ts=3 expandtab:
include "Gral2String";
include "Tag2String";
include "Trigger2String";

def EventSoruceToString( value ):
   if value == "0" then "event created by a trigger;"
   elif value == "1" then "event created by a discovery rule;"
   elif value == "2" then "event created by active agent autoregistration;"
   elif value == "3" then "internal event;"
   elif value == "4" then "event created on service status update."
   else "desconocido" end;

def  EventObjectToString( value ):
   if value == "0" then "trigger."
   elif value == "1" then "discovered host;"
   elif value == "2" then "discovered service."
   elif value == "3" then "auto-registered host."
   elif value == "4" then "item;"
   elif value == "5" then "LLD rule."
   elif value == "6" then "service."
   else "desconocido" end;

def  EventAcknowledgedToString( value ):
   if value == "0" then "yes"
   elif value == "1" then "no"
   else "desconocido" end;

def EventValueToString( source; value ):
   if ( source == "event created by a trigger" ) or ( source == "event created on service status update" ) or
      ( source == "0" ) or ( source == "4" ) then
      if value == "0" then "OK"
      elif value == "1" then "Problem"
      else "desconocido" end
   elif ( source == "event created by a discovery rule" ) or ( source == "1" ) then
      if value == "0" then "host or service up;"
      elif value == "1" then "host or service down;"
      elif value == "2" then "host or service discovered;"
      elif value == "3" then "host or service lost."
      else "desconocido" end
   elif ( source == "internal event" ) or ( source == "3" ) then
      if value == "0" then "normal state"
      elif value == "1" then "unknown or not supported state."
      else "desconocido" end
   #else "desconocido" end;
   else source end;

def EventSeverityToString( value ):
   if value == "0" then "not classified;"
   elif value == "1" then "information;"
   elif value == "2" then "warning;"
   elif value == "3" then "average;"
   elif value == "4" then "high;"
   elif value == "5" then "disaster."
   else "desconocido" end;

def EventSuppressedToString( value ):
   if value == "0" then "event is in normal state;"
   elif value == "1" then "event is suppressed."
   else "desconocido" end;

def EventToString( event ):
 event | .source as $EventSource | to_entries | map( if .key == "source" then
                              .value = EventSoruceToString( .value )
                           elif .key == "object" then
                              .value = EventObjectToString( .value )
                           elif .key == "acknowledged" then
                              .value = EventAcknowledgedToString( .value )
                           elif .key == "clock" then
                              .value = DateToString( .value )
                           elif .key == "value" then
                              .value = EventValueToString( $EventSource; .value )
                           elif .key == "severity" then
                              .value = EventSeverityToString( .value )
                           elif .key == "suppressed" then
                              .value = EventSuppressedToString( .value )
                           else
                              .
                           end) | from_entries ;
