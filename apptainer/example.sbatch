#!/bin/bash
#SBATCH --job-name=example_job
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=grete:shared    # see https://www.hlrn.de/doc/display/PUB/Compute+node+partitions for a list of accessible hlrn partitions
#SBATCH --gpus 1                    # number of gpus per node

module load apptainer
# note: if you start your instance from your home directory the whole home directory will always be mounted into your instance (even with --no-home) 
apptainer instance start --nv --bind /home/USER/.vscode-server:/.vscode-server,/scratch/usr/USER/hlrn-access/example_data:/home/USER/example_data apptainer/apptainer_example.sif example_instance
# keep the instance and job running since you want to connect to it with ssh and develop in the container
sleep infinity
