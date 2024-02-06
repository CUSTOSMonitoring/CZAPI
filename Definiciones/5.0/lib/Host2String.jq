#vim: set ts=3 expandtab:

def HostStatusToString( status ):
      if status=="0" then "monitored host"
      elif status=="1" then "unmonitored host."
      else "desconocido" end;

def HostToString( host ):
 host | to_entries | map( if .key == "status" then
                           .value = HostStatusToString( .value )
                        elif .key == "OTRAAAAA" then
                           .value = HostStatusToString( .value )
                        else
                           .
                        end) | from_entries ;
