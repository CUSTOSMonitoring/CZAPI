#!/bin/bash
# vim: set ts=3 expandtab shiftwidth=3: 

# de donde leemos la ayuda
URL=https://www.zabbix.com/documentation/current/en/manual/api
#bajada del archivo de ayuda
ArchPrinc=ArchPrinc.html
#solo la lista de métodos
MethodList=MethodList.html
#parametros comunes a las funciones get
#ArchOpComunesGet="$(dirname $(readlink -f $0))/ObjParamsComunes.json"
ArchOpComunesGet="/home/gguido/ZAPI/ObjParamsComunes.json"


#base de ka ayuda de zabbix
wget -qO- -o /dev/null ${URL} | \
#tomamos un pedazo, el del menú, limitado por dos líneas conocidas y nos quedamos con las referencias
awk '/Method reference/, /Appendix 1./ { print }' | \
#sacamos las referencias a la documentación
grep '<a href="/documentation' |
#sacamos la primera y última línea qee tomamos como separadores
sed '1 d; $ d; s/<a href="/https:\/\/www.zabbix.com/; s/" class="nodeFdUrl">/ /; s/<\/a>$//; s/&gt\;//' > "${MethodList}" 

#generamos para las funciones "standard"

i=2
grep -Pw 'get|create|update|delete' "${MethodList}" | while read methodURL methodName
do
   Description="" # tenemos que sacar la descripcion del método de la página de ayuda
   funcion=${methodName##*.}
   objeto=${methodName%%.*}
   #Cambiamos el nombre de la funcion
   ZAPIFunc=${objeto^${objeto:0:1}}${funcion^${funcion:0:1}} 
   wget -O "${methodName}.html" -o /dev/null "${methodURL}"
   echo ' {
         "'"${ZAPIFunc}"'": {
         "apiname": "'${methodName}'",
         "description": "'"${Description}"'",
         "url":"'${methodURL}'",
         "parameters": [
         ' ;
   
   if [ "${funcion}" == "delete" ]
   then
       echo '"@Array(int) Array of ID to delete. No ha sido testeado"'
   elif [ "${funcion}" == "create" ]
   then
       echo '"@Array(@Object('"${methodName%%.*}"',createprop)) Array of objects '"${methodName%%.*}"' to create, it may have extra properties, No ha sido testeado"'
   elif [ "${funcion}" == "update" ]
   then
       echo '"@Array(@Object('"${methodName%%.*}"',updateprop)) Array of objects '"${methodName%%.*}"' to update with ID property set, it may have extra properties, No ha sido testeado"'
   else
      grep '[/<]td[>]\|[/<]tr[>]' "${methodName}.html" | sed 's/^\s*//' | awk '
      BEGIN {
       Nombre = ""
       Tipo = ""
       Descripcion = ""
       SEP =""
            }
      ($1 == "</tr>") { if ( Nombre != "" && Tipo != "" && Descripcion != "" )
                        {
                           printf SEP
                           print "{\042description\042:\042"Descripcion"\042,\042name\042:\042"Nombre"\042,\042type\042:\042"Tipo"\042}"
                           SEP = ","
                        }
                        Nombre = ""
                        Tipo = ""
                        Descripcion = ""
                        next }
      (Nombre == "") { Nombre=substr( $0, 5, index($0, "</td>") -5 ) ; next  }
      (Tipo == "") { Tipo=substr( $0, 5, index($0, "</td>") -5 ) ; next }
      (Descripcion == "") { gsub( "\"", "\\\"" )
                            Descripcion=substr( $0, 5, index($0, "</td>") -5)
                           ; next }
      ' ;
      if [ "${funcion}" == "get" -a "${object}" != "apiinfo" ]
      then # es una funcion get, ponemos los parámetros comunes
         echo "," ;
         cat "${ArchOpComunesGet}" ;
      fi;
   fi;
   echo '] } }'
   #falta borrar "${methodName}.html"
[[ i-- = 0 ]] && exit
done | jq --slurp 'add'
