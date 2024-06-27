#vim: set ts=3 expandtab:

include "Host2String";

def HostGroupFlagsToString( flag ):
      if flag=="0" then "a plain host group"
      elif flag=="4" then "a discovered host group."
      else "desconocido" end;

def HostGroupToString( hostgroup ):
 hostgroup | to_entries | map( if .key == "flags" then
                           .value = HostGroupFlagsToString( .value )
                        elif .key == "hosts" then
                           if ( ( .key | type ) == "array" ) then
                              .value[] |= HostToString( . ) 
                           else
                              .
                           end
                        else
                           .
                        end) | from_entries ;
