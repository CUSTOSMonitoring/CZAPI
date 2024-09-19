#vim: set ts=3 expandtab shiftwidth=3:
include "User2String";

def MediatypeTypeToString( type ):
   if type == "0" then "email"
   elif type == "1" then "script"
   elif type == "2" then "SMS"
   elif type == "4" then "Webhook"
   else "desconocido" end;

def Mediatypesmtp_securityToString( value ):
   if value == "0" then "None"
   elif value == "1" then "STARTTLS"
   elif value == "2" then "SSL/TLS"
   else "desconocido" end;

def Mediatypesmtp_verify_peerToString( value ):
   if value == "0" then "None"
   elif value == "1" then "STARTTLS"
   else "desconocido" end;

def Mediatypesmtp_verify_hostToString( value ):
   if value == "0" then "No"
   elif value == "1" then "Yes"
   else "desconocido" end;

def Mediatypesmtp_authenticationToString( value ):
   if value == "0" then "None"
   elif value == "1" then "Normal password"
   else "desconocido" end;

def MediatypestatusToString( value ):
   if value == "0" then "enabled"
   elif value == "1" then "disabled"
   else "desconocido" end;

def Mediatypecontent_typeToString( value ):
   if value == "0" then "plain text"
   elif value == "1" then "html"
   else "desconocido" end;

def Mediatypeprocess_tagsToString( value ):
   if value == "0" then "Ignore webhook script response"
   elif value == "1" then "Process webhook script response as tags"
   else "desconocido" end;

def MediatypeToString( value ):
   value | to_entries | map( if .key == "type" then
                           .value = MediatypeTypeToString( .value )
                        elif .key == "status" then
                           .value = MediatypestatusToString( .value )
                        elif .key == "smtp_security" then
                           .value = Mediatypesmtp_securityToString( .value )
                        elif .key =="smtp_verify_peer" then
                           .value = Mediatypesmtp_verify_peerToString( .value )
                        elif .key =="smtp_verify_host" then
                           .value = Mediatypesmtp_verify_hostToString( .value )
                        elif .key =="smtp_authentication" then
                           .value = Mediatypesmtp_authenticationToString( .value )
                        elif .key =="content_type" then
                           .value = Mediatypecontent_typeToString( .value )
                        elif .key =="process_tags" then
                           .value = Mediatypeprocess_tagsToString( .value )
                        elif .key =="users" then
                           .value[] |= UserToString( . )
                        else
                           .
                        end) | from_entries ;
                       
