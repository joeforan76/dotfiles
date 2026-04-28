print_job_info() {
    echo "===== SLURM JOB INFO ====="
    echo "Job ID:        $SLURM_JOB_ID"
    echo "Job Name:      $SLURM_JOB_NAME"

    if [ -n "${SLURM_ARRAY_TASK_ID+x}" ]; then
        echo "Array Task Id: $SLURM_ARRAY_TASK_ID"
    fi
    
    echo "Node:          $SLURMD_NODENAME"
    echo "All Nodes:     $(scontrol show hostnames $SLURM_NODELIST)"
    echo "Num Nodes:     $SLURM_NNODES"
    echo "Node ID:       $SLURM_NODEID"
    echo "Tasks:         $SLURM_NTASKS"
    echo "CPUs/Task:     $SLURM_CPUS_PER_TASK"
    echo "GPUs:          $CUDA_VISIBLE_DEVICES"
    
    echo "===== GPU INFO ====="
    nvidia-smi --query-gpu=uuid,name,pci.bus_id --format=csv,noheader
    echo "=========================="

    echo "Job Script" 
    echo "=========================="
    cat $0
    echo "=========================="
}    


BASEDIR="${SLURM_SUBMIT_DIR:-$(realpath $(dirname $0))}"
if [ -n "${SLURM_ARRAY_TASK_ID+x}" ]; then
    LOGDIR=${BASEDIR}/logs/run_${SLURM_JOB_ID}_${SLURM_ARRAY_TASK_ID}_$(date +%y%m%d_%H%M%S)
else
    LOGDIR=${BASEDIR}/logs/run_${SLURM_JOB_ID}_$(date +%y%m%d_%H%M%S)
fi

mkdir -p ${LOGDIR}

run_cmd() {
    CMD=$1
    echo "========================================" 2>&1 
    date 2>&1 
    echo $CMD 2>&1 
    echo "----------------------------------------" 2>&1 
    eval "$CMD" 2>&1 
    echo "========================================" 2>&1 
}

    
