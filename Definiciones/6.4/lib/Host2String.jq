#vim: set ts=3 expandtab:
include "Gral2String";

def HostStatusToString( status ):
   if status=="0" then "monitored host"
   elif status=="1" then "unmonitored host."
   else "desconocido" end;

def HostIpmi_authtypeToString( value ):
   if value == "-1" then "default"
   elif value == "0" then "none"
   elif value == "1" then "MD2"
   elif value == "2" then "MD5"
   elif value == "4" then "straight"
   elif value == "5" then "OEM"
   elif value == "6" then "RMCP+"
   else "desconocido" end;

def HostIpmi_privilegeToString( value ):
   if value == "1" then "callback"
   elif value == "2" then "user"
   elif value == "3" then "operator"
   elif value == "4" then "admin"
   elif value == "5" then "OEM"
   else "desconocido" end;

def HostMaintenance_statusToString( value ):
   if value == "0" then "no maintenance"
   elif value == "1" then "maintenance in effect"
   else "desconocido" end;

def Hosttls_connectToString( value ):
   if value == "1" then "No encryption"
   elif value == "2" then "PSK"
   elif value == "4" then "certificate"
   else "desconocido" end;

def Hosttls_acceptToString( value ):
   if value == "1" then "No encryption"
   elif value == "2" then "PSK"
   elif value == "4" then "certificate"
   else "desconocido" end;

def HostInventory_modeToString( value ):
   if value == "-1" then "disabled"
   elif value == "0" then "manual"
   elif value == "1" then "automatic"
   else "desconocido" end;

def HostFlagsToString( value ):
   if value == "0" then "plain host"
   elif value == "1" then "Discovered host"
   else "desconocido" end;

def HostToString( host ):
 host | to_entries | map( if .key == "status" then
                           .value = HostStatusToString( .value )
                        elif .key == "ipmi_authtype" then
                           .value = HostIpmi_authtypeToString( .value )
                        elif .key == "ipmi_privilege" then
                           .value = HostIpmi_privilegeToString( .value )
                        elif .key == "maintenance_status" then
                           .value = HostMaintenance_statusToString( .value )
                        elif .key == "inventory_mode" then
                           .value = HostInventory_modeToString( .value )
                        elif .key == "maintenance_from" then
                           .value = DateToString( .value )
                        elif .key == "tls_accept" then
                           .value = Hosttls_acceptToString( .value )
                        elif .key == "tls_connect" then
                           .value = Hosttls_connectToString( .value )
                        elif .key == "flags" then
                           .value = HostFlagsToString( .value )
                        else
                           .
                        end) | from_entries ;
