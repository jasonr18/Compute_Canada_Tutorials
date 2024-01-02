#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH -t 0-00:30
#SBATCH --output=%N-%j.out

module load julia
julia MPC.jl > MPC_{$SLURM_NODEID}_{$SLURM_JOBID}.log