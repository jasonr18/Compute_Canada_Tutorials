#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH -t 0-01:00
#SBATCH --output=%N-%j.out

module load julia
julia MPC.jl