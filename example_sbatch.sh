#!/bin/bash
#SBATCH --job-name=exmaple_ml_job

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1M
#SBATCH --gpus=1
#SBATCH --time=60

module load singularity
singularity exec --nv --env-file=<path_to_env_file> --bind /home/$USER/.vscode-server:/.vscode-server,<host-dir>:<contianer-dir> <singulairty-image.sif> <commannd_to_run>
