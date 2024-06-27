#vim: set ts=3 expandtab:
include "Gral2String";

def AlertTypeToString( type ):
   if type=="0" then "message"
   elif type=="1" then "remote command"
   else "desconocido" end;

def AlertStatusToString( status; type ):
   if type=="0" then 
      if status=="0" then "message not sent."
      elif status=="1" then "message sent."
      elif status=="2" then "failed after a number of retries."
      elif status=="3" then "new alert is not yet processed by alert manager."
      else "desconocido" end
   elif type=="1" then
      if status=="0" then "command not run."
      elif status=="1" then "command run."
      elif status=="2" then "tried to run the command on the Zabbix agent but it was unavailable."
      else "desconocido" end
   else "desconocido" end;

def AlertToString( alert ):
   (alert.alerttype as $type), alert | to_entries | map( if .key == "type" then
                           .value = AlertTypeToString( .value )
                        elif .key == "status" then
                           .value = AlertStatusToString( .value; $type )
                        elif .key == "clock" then
                           .value = DateToString( .value )
                        else
                           .
                        end) | from_entries ;
