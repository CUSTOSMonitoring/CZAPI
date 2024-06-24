# Para completar los comandos de ZAPI
# vim: set ts=3 expandtab shiftwidth=3:

function Gus_GetListaFunctions()
{
# el parametro opcional es el archivo de configuracion en la forma "-c Arch"
   ZAPI $1 --def_nom | jq -r '.[]'
}

function Gus_GetListaParametros()
{
# el segundo parametro opcional es el archivo de conf en la forma "-c Arch"
   GusDebug En Gus_GetListaParametros 
   ZAPI $2 "$1" --def_para | jq -r '.parameters[] | .name'
   GusDebug Saliendo Gus_GetListaParametros 
}

function GusDebug()
{
   echo $(date +"*%F %T") $* >> aux.log
   #echo $(date +"*%F %T") $* >&2
   #echo $(date +"*%F %T") $* > /dev/null
   #:
}

function Gus_Complete_ZAPI ()
{
   # tenemos el problema de que se pueden cambiar los archivos en la línea de comandos, por lo que tenemos que enterarnos de la configuración actual de ZAPI
   local cur prev Func band OptsGral OptsFunc OptsParams BanderaConf
   COMPREPLY=()
   cur="${COMP_WORDS[COMP_CWORD]}"
   prev="${COMP_WORDS[COMP_CWORD-1]}"
   for i in $(seq 1 $(( ${#COMP_WORDS[@]} -2 )) )
   do # recorremos los parametros
     GusDebug Analizando "'${COMP_WORDS[$i]}'" en el lugar $i
     if [[ "${COMP_WORDS[$i]}" =~ -.* ]]
     then 
        GusDebug Encontramos la bandera "'${COMP_WORDS[$i]}'"
        band=${COMP_WORDS[$i]}
     else
        if [[ "${band}" == "-c" ]]
        then # es una bandera que tiene parametro, tal vez se necesiten agregar más a futuro
           GusDebug salteamos el parametro de la bandera "'$band'" "'${COMP_WORDS[$i]}'"
        else
           GusDebug encontramos la funcion "'${COMP_WORDS[$i]}'"
           Func="${COMP_WORDS[$i]}"
           break
        fi
        band=""
     fi
   done
   OptsGral="--def --def_nom --help --variables -c --show-debug --show-API-call --edit-conf --edit-funciones --edit-traduccion --no-format  --list-conexiones"
   OptsFunc="--def --def_apiname --def_returns --def_description --def_parameters"
   OptsParams="description= name= type="

   if [ "${prev}" == "-c" ] || [ "${prev}" == "-C" ]
   then # completamos con los archivos de Conexion
      dirConfCompletion=$( ZAPI --variables=DirConn )
      a=$( [ -d "${dirConfCompletion}" ] && find ${dirConfCompletion} -maxdepth 1 -name '*.zapi' -type f ; find . -maxdepth 1 -name '*.zapi' -type f )
      COMPREPLY=( $(compgen -W "$a" -- ${cur}) )
      if [ ${#COMPREPLY} -eq 0 ]
      then
         COMPREPLY=( $(compgen -W "$a" -- ${dirConfCompletion}/${cur} ) )
      fi
   else
      for i in $(seq 1 $(( ${COMP_CWORD} -1 )) )
      do
        if [[ "${COMP_WORDS[$i]}" == "-c" ]]
        then # el siguiente tiene que se el archivo de conf sino, no estariamos aca
           BanderaConf="-c ${COMP_WORDS[$i+1]}"
           i+=1
           break
        fi
        i+=1
      done

      if [ ! "${Func}" ]
      then # No hay una función en la línea de comandos, completamos con las funciones
         GusDebug No tenemos funcion, van las funciones y op grales
         COMPREPLY=( $(compgen -W "$(Gus_GetListaFunctions "${BanderaConf}") ${OptsGral}" -- ${cur}) )
      else
         # hay problemas con el = porque separa palabras
         GusDebug tenemos funcion ${Func}, van los parametros y op de func
         COMPREPLY=( $(compgen -W "$(Gus_GetListaParametros ${Func} "${BanderaConf}" ) ${OptsFunc}" -- ${cur}) )
      fi
   fi
}

function Gus_Complete_ZAPI2 ()
{
   local cur prev Func band OptsGral OptsFunc OptsParams BanderaConf dirConfCompletion
   OptsGral="--def --def_nom --help --variables -c --show-debug --show-API-call --edit-conf --edit-funciones --no-format"
   OptsFunc="--def --def_apiname --def_returns --def_description --def_parameters"
   OptsParams="description= name= type="

   cur="${COMP_WORDS[COMP_CWORD]}"
   prev="${COMP_WORDS[COMP_CWORD-1]}"

   op=1
   while [ ${op} -lt ${COMP_CWORD} ]
   do # concatenamos las banderas para llamar a ZAPI hasta llegar a la palabra actual
      BanderaConf="${BanderaConf} ${COMP_WORDS[op]}"
   done

   if [[ "${cur}" =~ -.* ]]
   then #tenemos que completar una bandera
      COMPREPLY=( $(compgen -W "${OptsGral} ${OptsFunc}" -- ${cur} ) )
   else
      case ${prev} in
         -c | -C ) # es la bandera para la configuración, tenemos que saber si la tenemos que completar o usar el valor
                 dirConfCompletion=$( ZAPI ${BanderaConf} --variables=DirConn )
                 a=$( find ${dirConfCompletion} -maxdepth 1 -name '*.zapi' -type f ; find . -maxdepth 1 -name '*.zapi' -type f )
                 COMPREPLY=( $(compgen -W "$a" -- ${cur}) )
                 if [ ${#COMPREPLY} -eq 0 ]
                 then
                    COMPREPLY=( $(compgen -W "$a" -- ${dirConfCompletion}/${cur} ) )
                 fi;;
         * ) # prev es la funcion, dado que no es ninguna bandera
      esac
   fi
}

complete -F Gus_Complete_ZAPI ZAPI zbx
