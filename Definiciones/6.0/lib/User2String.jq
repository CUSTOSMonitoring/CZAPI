#vim: set ts=3 expandtab shiftwidth=3:
include "Gral2String";
#include "Mediatype2String";

def UserAutologoutToString( value ):
   if value=="0" then "autologout disabled"
   else value end;

def UserAutologinToString( value ):
   if value=="0" then "autologin disabled"
   elif value=="1" then "autologin enabled"
   else "desconocido" end;

def UserTypeToString( value ):
   if value=="1" then "Zabbix user"
   elif value=="2" then "Zabbix admin"
   elif value=="3" then "Zabbix super admin"
   else "desconocido" end;

def UserGui_accessToString( value ):
   if value=="0" then "system default"
   elif value=="1" then "internal"
   elif value=="2" then "LDAP"
   elif value=="3" then "disabled"
   else "desconocido" end;

def UserDebug_modeToString( value ):
   if value=="0" then "disabled"
   elif value=="1" then "enabled"
   else "desconocido" end;

def UserUsers_statusToString( value ):
   if value=="0" then "enabled"
   elif value=="1" then "disabled"
   else "desconocido" end;

def UserToString( User ):
   User | to_entries | map( if .key == "attempt_clock" then
                           .value = DateToString ( .value )
                        elif .key == "attempt_failed" then
                           .value = DateToString ( .value )
                        elif .key == "autologin" then
                           .value = UserAutologinToString( .value )
                        elif .key == "autologout" then
                           .value = UserAutologoutToString( .value )
                        elif .key == "type" then
                           .value = UserTypeToString( .value )
                        elif .key == "gui_access" then
                           .value = UserGui_accessToString( .value )
                        elif .key == "debug_mode" then
                           .value = UserDebug_modeToString( .value )
                        elif .key == "users_status" then
                           .value = UserUsers_statusToString( .value )
                        #elif .key == "medias" then
                           #.value[] |= MediatypeToString( .value )
                        else
                           .
                        end) | from_entries ;
