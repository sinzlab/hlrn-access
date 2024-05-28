# A Guide for Accessing the GPUs Cluster at the NHR/HLRN HPC.

This is a guide for accessing the computational resources at NHR/HLRN. It is a condensed version of [this guide](https://www.hlrn.de/doc/display/PUB/GPU+Usage), which should be referred for further information.


## Hardware and Nodes
The NHR/HLRN HPC consists in a cluster of processing nodes, to which users can submit [SLURM](https://slurm.schedmd.com/documentation.html) jobs from access nodes within the same HPC system. For a complete list of resources, please referr to [this link](https://www.hlrn.de/doc/display/PUB/Compute+node+partitions#Computenodepartitions-Emmy(G%C3%B6ttingen)). 

## Creating an account
Please apply for an account here: https://www.hlrn.de/doc/display/PUB/Apply+for+a+User+Account.

You will also receive an e-mail with a PIN and username. Please store this PIN safely, since it is used to set your initial password when your application is accepted.

## Accessing the servers

The password that you set is for the portal only. In order to access the nodes on the HLRN cluster, you need to have an SSH key uploaded to the HLRN portal: https://www.hlrn.de/doc/display/PUB/SSH+Login. Notice that when you follow the instructions to upload an SSH key, you will receive an e-mail with the link to access the upload page, and you should upload just the _.pub_ file there.

With the SSH key uploaded, you can now log into the cluster using ssh: ```ssh -i <path_to_your_private_key> -l <your_username> glogin9.hlrn.de```. We recommend using `glogin9` instead of others because it allows you to access the `/scratch-grete/` directly from the assigned GPU compute node.

## Testing the servers
Once in the server, to test its functionality you can follow the the tutorial available in https://gitlab-ce.gwdg.de/dmuelle3/deep-learning-with-gpu-cores. 

## Using the the servers
There are essentially **two** ways to use the HLRN cluster
1. build a singularity/apptainer image, run it, ssh into the container on a compute node
2. set up a conda/mamba environment on your scratch, ssh into the compute node, activate your conda/mamba environment

# 1. Using the nodes with singularity

At the moment these instructions work with Linux and Mac. It is not tested on Windows.

In order to run code with your dependencies on a compute node you need three things in order: 

(1) create a singularity container (docker is not allowed), 

(2) run the singularity container on the node, and 

(3) install and setup vscode and connect to the running singularity container in order to develop on the assigned node.

### Creating the singularity container
Create a singularity image using a singularity definition file (find examples under `singularity/`). You can also convert a docker image into a singularity image: https://docs.sylabs.io/guides/3.0/user-guide/build_a_container.html. In order to build a singularity image, use: `singularity build --fakeroot <singularity_example.sif> <singularity_example.def>`.

Note that the image needs to be built on a Linux machine.

### Setup vscode on your local machine
Three steps: 

(1) Install vscode https://code.visualstudio.com on your local machine; 

(2) Install the extension `Remote - SSH`: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh; 

(3) `ssh` into the login node `glogin9` via vscode. In order to do this, add a config file (a template `config` is provided in the repo) under `~/.ssh/config` and ssh into the login node via the `Command pallete` on vscode (keyboard shortcut `cmd + ^ + p` on mac) by using the option "Remote-SSH: Connect to Host...". Please add both the entries as in the `config` file provided, i.e., "Host hlrn ..." as well as "Host hlrn-*".

Doing this creates a `.vscode-server` folder on the login node that you will need to use the vscode frontend on your local machine and to develop on the assigned GPU compute note on the cluster.

### Running the singularity container on slurm
Once the singularity image is built, upload the image (`.sif` file) to the login node (e.g. to your home dir). In order to run the singularity image (i.e., create a container/instance): 

(1) create an `example.sbatch` file (see `example.sbatch` in this repo), 

(2) use the `sbatch` command on the login node to run the `example.sbatch` file, for example: `sbatch example.sbatch`.
*We recommend you familiarize yourself with slurm an slurm commands, which will help you see (a) what nodes are available, (b) how to check your running jobs, (c) how to read the output and logs, (d) how to change the sbatch file in order to customize your requirements (such as needing more GPU nodes), etc. Please see the slurm documentation page for more: https://slurm.schedmd.com.*

### Remote-ssh'ing into the assigned compute node
(1) Once you run the `sbatch` command your built singularity image will run as an instance on your assigned GPU compute node. You can find out which one via the command: `squeue --me`. Copy the name of your assigned compute node `<compute-node-name>` listed under "NODELIST" (e.g. `ggpu111`). 

(2) You can now directly `remote ssh` into the instance running on the GPU node via vscode locally. In order to do this, open the `Command pallete` on vscode (keyboard shortcut `cmd + ^ + p` on mac) by using the option "Remote-SSH: Connect to Host..." and type in `hlrn-<compute-node-name>` and hit enter. This should open a new vscode window on the compute node within your singularity instance.

# 2. Using the nodes with a conda environment

### Install mamba and set up your environment
Follow the guide provided by Anwai Archit (here)[https://docs.hpc.gwdg.de/software/hlrn_tmod/devtools_compiler_debugger/conda/index.html#setting-up-mamba] and install mamba in `/scratch/usr/$USER/mambaforge`. After this, set up your environment with all the libraries that you require. This can be done on the login node of the HLRN. However, be aware that you have to install mamba and set up your environment at the right `/scratch` directory (i.e. use login node `glogin9` for gpu nodes, `glogin1-glogin8` for cpu nodes).

### Setup vscode on your local machine
Three steps: 

(1) Install vscode https://code.visualstudio.com on your local machine; 

(2) Install the extension `Remote - SSH`: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh; 

(3) `ssh` into the login node `glogin9` via vscode. In order to do this, add a config file (a template `config` is provided in the repo `conda`) under `~/.ssh/config` and ssh into the login node via the `Command pallete` on vscode (keyboard shortcut `cmd + ^ + p` on mac) by using the option "Remote-SSH: Connect to Host...". Please add both the entries as in the `config` file provided, i.e., "Host hlrn ..." as well as "Host hlrn-*".

Doing this creates a `.vscode-server` folder on the login node that you will need to use the vscode frontend on your local machine and to develop on the assigned GPU compute note on the cluster.

### Submit a job to slurm
The last step is to submit a job to slurm and remote-ssh into the compute node via vscode

(1) Use the `conda/example.sbatch` file that is provided and adjust it to your needs. Afterwards, submit your job to slurm by `sbatch example.sbatch`. You can check the status of the slurm job and your allocated compute node with `squeue --me`.

(2) You can now directly `remote ssh` into the compute node via vscode locally. In order to do this, open the `Command pallete` on vscode (keyboard shortcut `cmd + ^ + p` on mac) by using the option "Remote-SSH: Connect to Host..." and type in `hlrn-<compute-node-name>` and hit enter. This should open a new vscode window on the compute node.

(3) Now you can activate your conda environment in the vscode terminal and run scripts, use the vscode debugger or work with jupyter notebooks by choosing your environment as the respective kernel. 

*We recommend you familiarize yourself with slurm an slurm commands, which will help you see (a) what nodes are available, (b) how to check your running jobs, (c) how to read the output and logs, (d) how to change the sbatch file in order to customize your requirements (such as needing more GPU nodes), etc. Please see the slurm documentation page for more: https://slurm.schedmd.com.*


*Credits to Pedro Costa Klein for helping create this document.*

