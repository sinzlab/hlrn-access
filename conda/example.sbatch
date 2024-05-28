#!/bin/bash
#SBATCH --job-name=example_job
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=grete:shared    # see https://www.hlrn.de/doc/display/PUB/Compute+node+partitions for a list of accessible hlrn partitions
#SBATCH --gpus 1                    # number of gpus per node

sleep infinity
