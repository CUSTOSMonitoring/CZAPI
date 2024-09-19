#!/bin/bash
# vim: set ts=3 expandtab shiftwidth=3:

function Ayuda()
{
   echo "$(basename $0) -d ArchDefFunc [-h|--help]
   busca parametros con el mimso nombre en las definiciones de funciones
"
}

while [ $# -gt 0 ]
do
   case $1 in
      -d | --def-func ) DefFunc="$2"; shift;;
      -h | --help ) Ayuda; exit;;
   esac
   shift
done

! [ "${DefFunc}" ] && ERR="${ERR}\nEspecifique un archivo de defininción de funciones"

[ "${ERR}" ] && echo -e "${ERR}" && Ayuda && exit 1;

jq '
    to_entries | map( select ( (.value.parameters | map(.name?) | length ) != (.value.parameters | map(.name?) | unique | length ) ) ) 
    | .[] | .key, ( .value.parameters |  group_by(.name?) | map( select( length > 1) | .[0]  ))
    ' "${DefFunc}"
