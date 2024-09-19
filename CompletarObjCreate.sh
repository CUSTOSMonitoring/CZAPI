# Para completar los comandos de ZAPI
# vim: set ts=3 expandtab shiftwidth=3:

function Gus_Complete_ObjCreate ()
{
   local cur prev Obj band OptsGral OptsFunc OptsParams i
   COMPREPLY=()
   cur="${COMP_WORDS[COMP_CWORD]}"
   prev="${COMP_WORDS[COMP_CWORD-1]}"
   AntPrev="${COMP_WORDS[COMP_CWORD-2]}"
   OptsGral="--ignore-read-only -c --configuration --def --def_nom --help --variables --init -t --traduccion --lista-objetos --lista-propiedades --edit-objetos --debug-level"

   i=1
   while [ $i -lt ${COMP_CWORD} ]
   do # determinamos cual es el archivo de configuracion que vamos a usar
      if [[ "${COMP_WORDS[i]}" == "-c" || "${COMP_WORDS[i]}" == "--configuration" ]]
      then
         let i++
         [ $i -lt ${COMP_CWORD} ] && ArchConf="-c ${COMP_WORDS[i]}"
      fi
      let i++
   done

   if [[ "${prev}" == "-c" || "${prev}" == "--configuration" ]]
   then # el paramentro de esta bandera es un archivo de configuracion
      dirConfCompletion=$( $1 ${ArchConf} --variables=DirConn)
      a=$( find ${dirConfCompletion} -name '*.zapi' -type f ; find . -maxdepth 1 -name '*.zapi' -type f )
      COMPREPLY=( $(compgen -W "$a" -- ${cur}) )
      if [ ${#COMPREPLY} -eq 0 ]
      then
         COMPREPLY=( $(compgen -W "$a" -- ${dirConfCompletion}/${cur} ) )
      fi
   elif [[ "${prev}" == "-t" || "${prev}" == "--traduccion" || "${prev}" == "--lista-propiedades" ]]
   then
      COMPREPLY=( $( $1 ${ArchConf} --lista-objetos "^${cur}" ) )
   elif [[ "${AntPrev}" == "-t" || "${AntPrev}" == "--traduccion" || "${AntPrev}" == "--lista-propiedades" ]]
   then
      COMPREPLY=( $( $1 ${ArchConf} --lista-propiedades ${prev} "^${cur}" ) )
   elif [[ "${prev}" == "--lista-objetos" ]]
   then # el parametro debe ser especificado en la linea de comandos, podríamos mañana sugerir alguna creación
      COMPREPLY=( $( $1 ${ArchConf} --lista-objetos "${cur}" ) )
   elif [[ "${prev}" == "--init" ]]
   then # el parametro debe ser especificado en la linea de comandos, podríamos mañana sugerir alguna creación
      COMPREPLY=( )
   else
      # si no es nada específico, es un objeto y/o las banderras
      a=$( $1 ${ArchConf} --lista-objetos "${cur}" )
      COMPREPLY=( $(compgen -W "$a $OptsGral" -- ${cur}) )
   fi
}

complete -F Gus_Complete_ObjCreate ObjCreate 
