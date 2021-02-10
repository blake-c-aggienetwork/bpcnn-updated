# BPCNN
This code has been taken from https://github.com/liangfei-info/Iterative-BP-CNN. It updates the respository to include support tensorflow-gpu 2.4.1. Also a batch file to help with queueing simulations from start to finsish.

# Hardware Used
RTX 3070 running nvidia driver 461.40 with CUDA toolkit 11.2, and CUDNN 11.1 was used to to perform tests. tensorflow-gpu 2.4.1 with python 3.8.6 

# Example Usage
> 1. Download all files
> 2. Run masterResearchScript.bat located within the folder titled 'batch'
> 3. Follow command line prompts
> 4. ![batch script usage](https://i.imgur.com/p4YKzXK.png)
> 5. After the experiment has finished, results will be stored inside /batch/results/EXPERIMENT_NAME/trial#

# Changelog
> 2/9/2021
> - Added test cases for "Determing BP Effectiveness" experiments
> - Changed batch script slightly

> 2/8/2021
> - Updated code for tensorflow-gpu 2.4.1
> - Added batch script with ability to select 1 test case
