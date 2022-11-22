#!/bin/bash
#SBATCH --nodes=1
#SBATCH –tasks-per-node=1
#SBATCH -t 0-01:00
#SBATCH – output=%N-%j.out

cd ${SLURM_SUBMIT-DIR}

module load julia
julia MPC.jl