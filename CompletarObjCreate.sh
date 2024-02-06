# Para completar los comandos de ZAPI
# VERSION Tue Sep 20 19:40:36 -03 2022

function Gus_GetListaObjetos()
{
   GusDebugObjetos "ObjCreate $1 --def_nom | jq -r '.[]'"
   ObjCreate $1 --def_nom | jq -r '.[]'
}

function Gus_GetListaParamObj()
{
   ObjCreate $2 $1 --def_para  | jq -r ' keys[] | .'
}

function GusDebugObjetos()
{
   echo $(date +"*%F %T") "$*" >> Log.CompletarObjetos
   #echo $(date +"*%F %T") $* > /dev/null
}

function Gus_Complete_ObjCreate ()
{
   local cur prev Obj band OptsGral OptsFunc OptsParams
   COMPREPLY=()
   cur="${COMP_WORDS[COMP_CWORD]}"
   prev="${COMP_WORDS[COMP_CWORD-1]}"
   OptsGral="-c --def --def_nom --help --variables --init -t --traduccion"

   if [[ ${prev} == "-c" ]]
   then
      dirConfCompletion=$( ObjCreate --variables=DirConn)
      a=$( find ${dirConfCompletion} -maxdepth 1 -name '*.zapi' -type f ; find . -maxdepth 1 -name '*.zapi' -type f )
      COMPREPLY=( $(compgen -W "$a" -- ${cur}) )
      if [ ${#COMPREPLY} -eq 0 ]
      then
         COMPREPLY=( $(compgen -W "$a" -- ${dirConfCompletion}/${cur} ) )
      fi
   else
      GusDebugObjetos "No tenemos Objeto, van los objetos y opciones generales recorremos las banderas en ${COMP_WORDS[@]} desde 1 a $(( ${COMP_CWORD} -1 ))"
      for i in $(seq 1 $(( ${COMP_CWORD} -1 )) )
      do
	GusDebugObjetos "Recorriendo, actual ${COMP_WORDS[$i]}"      
        if [[ "${COMP_WORDS[$i]}" == "-c" ]]
        then # el siguiente tiene que se el archivo de conf sino, no estariamos aca
           BanderaConf="-c ${COMP_WORDS[$i+1]}"
	   GusDebugObjetos "Seteamos BanderaConf='-c ${COMP_WORDS[$i+1]}'"
        fi
      done
      if [ ! "${Obj}" ]
      then # Completamos con los objetos
         GusDebugObjetos No tenemos Objeto, van los objetos y opciones generales
         COMPREPLY=( $(compgen -W "$(Gus_GetListaObjetos "${BanderaConf}" ) ${OptsGral}" -- ${cur}) )
      else
         # hay problemas con el = porque separa palabras
         GusDebugObjetos tenemos objeto ${Obj}, van los parametros 
         COMPREPLY=( $(compgen -W "$(Gus_GetListaParamObj ${Obj} ${BanderaConf} ) ${Optsparam}" -- ${cur}) )
      fi
   fi
}

complete -F Gus_Complete_ObjCreate ObjCreate 
