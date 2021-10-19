#!/bin/bash

#-----------------------------------------------------------------------------
#
# Run global_cycle consistency test on WCOSS2.
#
# Set $WORK_DIR to your working directory.  Set the project code 
# and queue as appropriate.
#
# Invoke the script from the command line as follows:  ./$script
#
# Log output is placed in consistency.log??.  A summary is
# placed in summary.log
#
# A test fails when its output does not match the baseline files
# as determined by the 'nccmp' utility.  This baseline files are
# stored in HOMEreg.
#
#-----------------------------------------------------------------------------

set -x

source  ../../modulefiles/fv3gfs/global_cycle.wcoss2_cray
# for mpiexec command
module load cray-pals/1.0.12
module list

WORK_DIR="${WORK_DIR:-/lfs/h2/emc/stmp/$LOGNAME}"

PROJECT_CODE="${PROJECT_CODE:-GFS-DEV}"
QUEUE="${QUEUE:-dev}"

#-----------------------------------------------------------------------------
# Should not have to change anything below.
#-----------------------------------------------------------------------------

DATA_DIR="${WORK_DIR}/reg-tests/global-cycle"

export HOMEreg=/lfs/h2/emc/eib/noscrub/George.Gayno/ufs_utils.git/reg_tests/global_cycle

export GSI_FILE=$HOMEreg/input_data/gdas.t00z.dtfanl.nc

export OMP_NUM_THREADS_CY=2
export OMP_PLACES=cores

export APRUNCY="mpiexec -n 6 -ppn 6 --cpu-bind core --depth ${OMP_NUM_THREADS_CY}"

export NWPROD=$PWD/../..

reg_dir=$PWD

export NCCMP=/lfs/h2/emc/eib/noscrub/George.Gayno/util/nccmp/nccmp-1.8.5.0/src/nccmp

LOG_FILE=consistency.log
rm -f ${LOG_FILE}*

export DATA="${DATA_DIR}/test1"
export COMOUT=$DATA
TEST1=$(qsub -V -o ${LOG_FILE}01 -e ${LOG_FILE}01 -q $QUEUE -A $PROJECT_CODE -l walltime=00:05:00 \
        -N c768.fv3gfs -l select=1:ncpus=12:mem=8GB $PWD/C768.fv3gfs.sh)

qsub -V -o ${LOG_FILE} -e ${LOG_FILE} -q $QUEUE -A $PROJECT_CODE -l walltime=00:01:00 \
        -N cycle_summary -l select=1:ncpus=1:mem=100MB -W depend=afterok:$TEST1 << EOF
#!/bin/bash
cd $reg_dir
grep -a '<<<' ${LOG_FILE}??  > summary.log
EOF

exit