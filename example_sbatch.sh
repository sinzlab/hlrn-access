#!/bin/bash
#SBATCH --job-name=exmaple_ml_job

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=grete:shared
#SBATCH --gpus 1

module load singularity
singularity instance start --nv --bind /home/$USER/.vscode-server:/.vscode-server,/home/$USER/hlrn_access/example_data:/example_data singularity_example.sif example_instance
