#!/bin/sh

## https://github.com/vishnubob/wait-for-it

TIMEOUT=15
QUIET=0

echoerr() {
  if [ "$QUIET" -ne 1 ]; then printf "%s\n" "$*" 1>&2; fi
}

usage() {
  exitcode="$1"
  cat << USAGE >&2
Usage:
  $cmdname host:port [-t timeout] [-- command args]
  -q | --quiet                        Do not output any status messages
  -t TIMEOUT | --timeout=timeout      Timeout in seconds, zero for no timeout
  -- COMMAND ARGS                     Execute command with args after the test finishes
USAGE
  exit "$exitcode"
}

wait_for() {
  for i in `seq $TIMEOUT` ; do
    nc -z "$HOST" "$PORT" > /dev/null 2>&1

    result=$?
    if [ $result -eq 0 ] ; then
      if [ $# -gt 0 ] ; then
        exec "$@"
      fi
      exit 0
    fi
    sleep 1
  done
  echo "Operation timed out" >&2
  exit 1
}

while [ $# -gt 0 ]
do
  case "$1" in
    *:* )
    HOST=$(printf "%s\n" "$1"| cut -d : -f 1)
    PORT=$(printf "%s\n" "$1"| cut -d : -f 2)
    shift 1
    ;;
    -q | --quiet)
    QUIET=1
    shift 1
    ;;
    -t)
    TIMEOUT="$2"
    if [ "$TIMEOUT" = "" ]; then break; fi
    shift 2
    ;;
    --timeout=*)
    TIMEOUT="${1#*=}"
    shift 1
    ;;
    --)
    shift
    break
    ;;
    --help)
    usage 0
    ;;
    *)
    echoerr "Unknown argument: $1"
    usage 1
    ;;
  esac
done

if [ "$HOST" = "" -o "$PORT" = "" ]; then
  echoerr "Error: you need to provide a host and port to test."
  usage 2
fi

wait_for "$@"
#! / bin / sh TIMEOUT = 15 QUIET = 0 echoerr () {    pokud ["$ QUIET" -ne 1]; potom printf "% s \ n" "$ *" 1> & 2; fi } využití () {    exitcode = "$ 1"    kočka << POUŽITÍ> & 2 Používání:    $ cmdname host: port [-t timeout] [- příkaz args]    -q | --quiet Nevystupují žádné stavové zprávy    -t TIMEOUT | --timeout = timeout Timeout v sekundách, nula bez timeoutu    - COMMAND ARGS Po dokončení testu provede příkaz args POUŽÍVÁNÍ    exit "$ exitcode" } čekat na() {    pro i v `seq $ TIMEOUT`; dělat      nc -z "$ HOST" "$ PORT"> / dev / null 2> & 1           výsledek = $?      pokud [$ result -eq 0]; pak        pokud [$ # -gt 0]; pak          vykonat "$ @"        fi        exit 0      fi      spát 1    Hotovo    echo "Vypršel časový limit operace"> & 2    výjezd 1 } zatímco [$ # -gt 0] dělat    případ "$ 1" v      *: *)      HOST = $ (printf "% s \ n" "$ 1" | cut -d: -f 1)      PORT = $ (printf "% s \ n" "$ 1" | cut -d: -f 2)      posun 1      ;;;      -q | --klid)      QUIET = 1      posun 1      ;;;      -t)      TIMEOUT = "$ 2"      pokud ["$ TIMEOUT" = ""]; pak rozbít; fi      posun 2      ;;;      --timeout = *)      TIMEOUT = "$ {1 # * =}"      posun 1      ;;;      -)      posun      přestávka      ;;;      --Pomoc)      použití 0      ;;;      *)      echoerr "Neznámý argument: $ 1"      použití 1      ;;;    esac Hotovo pokud ["$ HOST" = "" -o "$ PORT" = ""]; pak    echoerr "Chyba: k testování musíte poskytnout hostitele a port."    použití 2 fi wait_for "$ @"
translated from: English