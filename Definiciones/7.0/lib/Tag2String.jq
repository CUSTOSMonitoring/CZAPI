#vim: set ts=3 expandtab:

def TagAutomaticToString( value ):
   if value == "0" then "manual (tag created by user)"
   elif value == "1" then "automatic (tag created by low-level discovery)"
   else "desconocido" end;

def TagToString( obj ):
 obj | to_entries | map( if .key == "automatic" then
                           .value = TagAutomaticToString( .value )
                        else
                           .
                        end) | from_entries ;
