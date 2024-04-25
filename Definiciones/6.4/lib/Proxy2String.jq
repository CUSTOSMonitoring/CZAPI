#vim: set ts=3 expandtab:
include "Tag2String";

def ProxyStatusToString( status ):
   if status=="5" then "active proxy"
   elif status=="6" then "pasive proxy"
   else "desconocido" end;

def Proxytls_connectToString( value ):
   if value == "1" then "No encryption"
   elif value == "2" then "PSK"
   elif value == "4" then "certificate"
   else "desconocido" end;

def Proxytls_acceptToString( value ):
   if value == "1" then "No encryption"
   elif value == "2" then "PSK"
   elif value == "4" then "certificate"
   else "desconocido" end;

def Proxyauto_compressToString( value ):
   if value == "0" then "No compresion"
   elif value == "1" then "Compresion enabled"
   else "desconocido" end;

def ProxycompatibilityToString( value ):
   if value == "0" then "Udefined"
   elif value == "1" then "Current version (proxy and server have the same major version)"
   elif value == "2" then "Outdated version (proxy version is older than server version, but is partially supported)"
   elif value == "3" then "Unsupported version (proxy version is older than server previous LTS release version or server major version is older than proxy major version)"
   else "desconocido" end;

def ProxyToString( value ):
 value | to_entries | map( if .key == "status" then
                           .value = ProxyStatusToString( .value )
                        elif .key == "compatibility" then
                           .value = ProxycompatibilityToString( .value )
                        elif .key == "auto_compress" then
                           .value = Proxyauto_compressToString( .value )
                        elif .key == "tls_accept" then
                           .value = Proxytls_acceptToString( .value )
                        elif .key == "tls_connect" then
                           .value = Proxytls_connectToString( .value )
                        elif .key == "tags" then
                           .value[] |= TagToString( . )
                        else
                           .
                        end) | from_entries ;
