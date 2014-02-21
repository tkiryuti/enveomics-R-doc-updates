#!/bin/bash

##################### RUN
# Check if it was sourced from RUNME.bash
if [[ "$PDIR" == "" ]] ; then
   echo "$0: Error: This file is not stand-alone.  Execute RUNME.bash as described in the README.txt file" >&2
   exit 1
fi

if [[ ! -e "$SCRATCH/etc/01.bash" ]] ; then
   # 00. Initialize the project
   mkdir -p "$SCRATCH/tmp" "$SCRATCH/etc" "$SCRATCH/results" "$SCRATCH/success" ;
   mkdir -p "$SCRATCH/log/status" "$SCRATCH/log/active" "$SCRATCH/log/done" "$SCRATCH/log/failed";
   mkdir -p "$SCRATCH/log/err" "$SCRATCH/log/out" ;
   echo "Preparing structure." >> "$SCRATCH/log/status/00" ;
   echo "msub -q '$QUEUE' -l 'walltime=$MAX_H:00:00,mem=$RAM' -v '$MINVARS' -N '$PROJ-01' '$PDIR/01.pbs.bash' | tr -d '\\n'" > "$SCRATCH/etc/01.bash"
   touch "$SCRATCH/success/00" ;
fi ;

if [[ ! -e "$SCRATCH/etc/02.bash" ]] ; then
   # 01. Preparing input
   JOB01=$(REGISTER_JOB "01" "00" "Preparing input files" "$SCRATCH/etc/01.bash") ;
else
   if [[ ! -e "$SCRATCH/etc/03.bash" ]] ; then
      # 02. Launching BLAST
      JOB02=$(REGISTER_JOB "02" "00" "Launching BLAST runs" "$SCRATCH/etc/02.bash") ;
   else
      # 03. Finalize
      JOB03=$(REGISTER_JOB "03" "00" "Concatenating results" "$SCRATCH/etc/03.bash") ;
   fi ;
fi ;

