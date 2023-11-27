# A Guide for Accessing the GPUs Cluster at the NIM/HLRN HPC.

This is a guide for accessing the computational resources at NIM/HLRN. It is a condensed version of [this guide](https://www.hlrn.de/doc/display/PUB/GPU+Usage), which should be referred for further information.


## Hardware and Nodes
The NIM/HLRN HPC consists in a cluster of processing nodes, to which users can submit [SLURM](https://slurm.schedmd.com/documentation.html) jobs from access nodes within the same HPC system. For a complete list of resources, please referr to [this link](https://www.hlrn.de/doc/display/PUB/Compute+node+partitions#Computenodepartitions-Emmy(G%C3%B6ttingen)). 

## Creating an account
Please apply for an account here: https://www.hlrn.de/doc/display/PUB/Apply+for+a+User+Account.

You will also receive an e-mail with a PIN and username. Please store this PIN safely, since it is used to set your initial password when your application is accepted.

## Accessing the servers

The password that you set is for the portal only. In order to access the nodes on the HLRN cluster, you need to have an SSH key uploaded to the HLRN portal: https://www.hlrn.de/doc/display/PUB/SSH+Login. Notice that when you follow the instructions to upload an SSH key, you will receive an e-mail with the link to access the upload page, and you should upload just the _.pub_ file there.

With the SSH key uploaded, you can now log into the cluster using ssh: ```ssh -i <path_to_your_private_key> -l <your_username> glogin.hlrn.de```.

## Testing the servers
Once in the server, to test its functionality you can follow the the tutorial available in https://gitlab-ce.gwdg.de/dmuelle3/deep-learning-with-gpu-cores. 

Credits to Pedro Costa Klein for helping create this document.
