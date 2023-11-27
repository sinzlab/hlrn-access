#!/bin/bash
#SBATCH --job-name=example_job
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=grete:shared    # see https://www.hlrn.de/doc/display/PUB/Compute+node+partitions for a list of accessible hlrn partitions
#SBATCH --gpus 1                    # number of gpus per node

module load singularity
singularity instance start --nv --bind /home/$USER/.vscode-server:/.vscode-server,/home/$USER/hlrn-access/example_data:/example_data singularity/singularity_example.sif example_instance
# keep the instance and job running since you want to connect to it with ssh and develop in the container
sleep infinity