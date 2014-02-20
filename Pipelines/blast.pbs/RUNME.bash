#!/bin/bash

##################### VARIABLES
# Find the directory of the pipeline
CWD=$(pwd)
PDIR=$(dirname $(readlink -f $0));

# Load config
if [[ "$PROJ" == "" ]] ; then PROJ="$1" ; fi
if [[ "$TASK" == "" ]] ; then TASK="$2" ; fi
if [[ "$TASK" == "" ]] ; then TASK="check" ; fi
NAMES=$(ls $PDIR/CONFIG.*.bash | sed -e 's/.*CONFIG\./    * /' | sed -e 's/\.bash//');
if [[ "$PROJ" == "" ]] ; then
   if [[ "$HELP" == "" ]] ; then
      echo "
Usage:
   $0 name task
   
   name		The name of the run.  CONFIG.name.bash must exist.
   task		The action to perform.  One of:
		  run: Executes the BLAST.
		  check: Indicates the progress of the task.
		  pause: Cancels running jobs (resume using run).
   		If no task is given, assumes 'check'.

   See $PDIR/README.txt for more information.
   
   Available names are:
$NAMES
" >&2
   else
      echo "$HELP   
   Available names are:
$NAMES
" >&2
   fi
   exit 1
fi
if [[ ! -e "$PDIR/CONFIG.$PROJ.bash" ]] ; then
   echo "$0: Error: Impossible to find $PDIR/CONFIG.$PROJ.bash, available names are:
$NAMES" >&2
   exit 1
fi
source "$PDIR/CONFIG.$PROJ.bash"
MINVARS="PDIR=$PDIR,SCRATCH=$SCRATCH,PROJ=$PROJ"

##################### FUNCTIONS
function REGISTER_JOB {
   STEP=$1
   SUBSTEP=$2
   MESSAGE=$3
   JOBID=$4
   
   echo "$MESSAGE: $JOBID." >> "$SCRATCH/log/status/$STEP"
   echo "$STEP: $SUBSTEP: $(date)" > "$SCRATCH/log/active/$JOBID"
   #GUARDIAN_JOB=$(msub -l "depend=afternotok=$JOBID" -v "$MINVARS,STEP=$STEP,JOBID=$JOBID" "$PDIR/recover.pbs.bash") ;
}

##################### RUN
# Create the scratch directory
if [[ ! -d $SCRATCH ]] ; then mkdir -p $SCRATCH ; fi;
# Execute task
if [[ ! -e "$PDIR/TASK.$TASK.bash" ]] ; then
   echo "Unrecognized task: $TASK." >&2 ;
   exit 1 ;
else
   source "$PDIR/TASK.$TASK.bash"
fi
