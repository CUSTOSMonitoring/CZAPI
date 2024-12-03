#!/bin/bash
# vim: set ts=3 expandtab shiftwidth=3:

. echoformats.sh

# valores por defecto
if [ "$(which ZAPI)" ]
then
   DefFunc="$(ZAPI --variables=def)"
fi

function Ayuda()
{
   echo "$(basename $0) -d ArchDefFunc [-h|--help]
   busca parametros con el mismmo nombre en las definiciones de funciones
   por defecto busca en '${DefFunc}'

   Si ZAPI está en el path, se toma por defecto el nombre del archivo de definiciones de funciones
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

{
echo -e "Repetidos en el archivo ${Red}'${DefFunc}'${Normal}
" ;
jq -C '
    to_entries | map( select ( (.value.parameters | map(.name?) | length ) != (.value.parameters | map(.name?) | unique | length ) ) ) 
    | .[] | .key, ( .value.parameters |  group_by(.name?) | map( select( length > 1) | .[0]  ))
    ' "${DefFunc}" ; } | less -Fr
