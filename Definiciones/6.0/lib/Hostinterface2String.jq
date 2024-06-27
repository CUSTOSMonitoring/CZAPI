#vim: set ts=3 expandtab shiftwidth=3:

# include "Host2String"; tenemos problemas con la inclusión cíclica de módulos, vamos a tener que resolverlo a nivel de la llamada en bash

def HostinterfaceavailableToString( value ):
   if value=="0" then "unknown"
   elif value=="1" then "available"
   elif value=="2" then "unavailable"
   else "desconocido" end;

def HostinterfacemainToString( value ):
   if value=="0" then "not default"
   elif value=="1" then "default"
   else "desconocido" end;

def HostinterfacetypeToString( value ):
   if value=="1" then "agent"
   elif value=="2" then "SNMP"
   elif value=="3" then "IPMI"
   elif value=="4" then "JMX"
   else "desconocido" end;

def HostinterfaceuseipToString( value ):
   if value=="0" then "connect using host DNS name"
   elif value=="1" then "connect using host IP address for this host interface"
   else "desconocido" end;

def HostinterfaceToString( value ):
 value | to_entries | map( if .key == "available" then
                           .value = HostinterfaceavailableToString( .value )
                        elif .key == "main" then
                           .value = HostinterfacemainToString( .value )
                        elif .key == "type" then
                           .value = HostinterfacetypeToString( .value )
                        elif .key == "useip" then
                           .value = HostinterfaceuseipToString( .value )
                        #elif .key == "hosts" then
                           #.value[] |= HostToString( . )
                        else
                           .
                        end) | from_entries ;
