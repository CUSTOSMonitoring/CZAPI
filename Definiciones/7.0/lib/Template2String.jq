#vim: set ts=3 expandtab:

include "Tag2String";
include "Item2String";

def TagAutomaticToString( value ):
   if value == "0" then "manual (tag created by user)"
   elif value == "1" then "automatic (tag created by low-level discovery)"
   else "desconocido" end;

def TemplateToString( obj ):
 obj | to_entries | map( if .key == "tags" then
                           if ( ( .key | type ) == "array" ) then
                              .value[] |= TagToString( . )
                           else
                              .
                           end
                        elif .key == "items" then
                           if ( ( .key | type ) == "array" ) then
                              .value[] |= ItemToString( . )
                           else
                              .
                           end
                        else
                           .
                        end) | from_entries ;
