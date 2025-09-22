#!/bin/bash

DEBUG=0
MASTER="en-US.json"
WARNING=0

bold=$(tput bold)
normal=$(tput sgr0)

_debug()
{
   test -z DEBUG && return 0
   test $DEBUG -eq 0 && return 0

   echo "DEBUG: $@"
}

_abort()
{
   echo "ERROR: $@"
   exit 1
}

_warning()
{
   echo "WARNING: $@"
   (( WARNING = WARNING + 1 ))
   _debug "warning count: $WARNING"
}

is_valid_json_file()
{
   local f=$1

   cat $f | jq empty > /dev/null 2>&1
   if [ $? -ne 0 ]
   then
      return 1
   else
      return 0
   fi
}

check_for_missing_keys()
{
   local f=$1

   if [ ! -r $f ]
   then
      _abort "can't open file $f"
   fi

   if ! is_valid_json_file $f
   then
      _abort "not a valid json file: ${bold}$( basename $f )${normal}"
   fi

   # iterate over the toplevel keys
   while read k
   do
      _debug "checking toplevel key $k"

      # does this toplevel key even exist?
      if [ $( cat $f | jq -r 'keys_unsorted[]' | grep -c $k ) -eq 0 ]
      then
         _warning "toplevel key $k not found in ${bold}$( basename $f )${normal}"
      else
         # the toplevel key exists, now let's check the subkeys
         while read l
	 do
            _debug "checking toplevel key $k, sublevel key $l"
	    if [ $( cat $f | jq -r ".${k} | keys_unsorted[]" | grep -c $l ) -eq 0 ]
	    then
               _warning "key $k, sublevel key $l not found in ${bold}$( basename $f )${normal}"
	    fi
         done < <( cat en-US.json| jq -r ".${k} | keys_unsorted[]" )
      fi
   done < <( cat $MASTER | jq -r 'keys_unsorted[]' )

   # let's do a reverse check: does the translation file has keys
   # that don't exist at all (in the master file)

   cat $f | jq -r 'keys_unsorted[]' |
   while read k
   do
      _debug "reverse checking toplevel key $k"

      # does this toplevel key even exist?
      if [ $( cat $MASTER | jq -r 'keys_unsorted[]' | grep -c $k ) -eq 0 ]
      then
         echo "ERROR: ${bold}$( basename $f )${normal}: toplevel $k not found in MASTER"
      else
         # the toplevel key exists, now let's check the subkeys
	 cat $f | jq -r ".${k} | keys_unsorted[]" |
         while read l
	 do
            _debug "reverse checking toplevel key $k, sublevel key $l"
	    if [ $( cat $MASTER | jq -r ".${k} | keys_unsorted[]" | grep -c $l ) -eq 0 ]
	    then
               echo "ERROR: ${bold}$( basename $f )${normal}: key $k, sublevel key $l not found in MASTER"
	    fi
	 done
      fi
   done
}

########################################################################################################################
########################################################################################################################

# do we have jq?
type jq >/dev/null 2>&1
if [ $? -ne 0 ]
then
   _abort "can't find 'jq' executable"
fi

# iterate over all files (except master)
for file in $( ls ./*.json | grep -v $MASTER )
do
   echo "found language file: ${bold}$( basename $file )${normal}"
   check_for_missing_keys $file
done

_debug "warning counts: $WARNING"
if [ $WARNING -eq 0 ]
then
   echo
   echo "Everything looks OK!"
else
   echo
   echo "Please fix the warnings..."
fi

exit 0
