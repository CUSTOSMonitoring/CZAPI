#vim: set ts=3 expandtab:

include "Host2String";

def TemplateToString( value ):
   value | to_entries | map( if .key == "hosts" then
                           if ( ( .key | type ) == "array" ) then
                              .value[] |= HostToString( . )
                           else
                              .
                           end
                        else
                           .
                        end) | from_entries ;
