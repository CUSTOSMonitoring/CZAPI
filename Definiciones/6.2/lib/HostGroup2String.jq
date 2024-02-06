#vim: set ts=3 expandtab:

def HostGroupFlagsToString( flag ):
      if flag=="0" then "a plain host group"
      elif flag=="4" then "a discovered host group."
      else "desconocido" end;

def HostGroupToString( hostgroup ):
 hostgroup | to_entries | map( if .key == "flags" then
                           .value = HostGroupFlagsToString( .value )
                        else
                           .
                        end) | from_entries ;
