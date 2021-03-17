Script for Iterative BP-CNN


To use script:
create "batch" directory inside of "Iterative-BP-CNN-master"
place "masterResearchScript.bat" there
open CMD and navigate to the "batch" folder you created
run masterResearchScript.bat from the command line!


Term definitions:
The experiments text document is used to define your own experiments and trials.
Experiments are defined as a collection of Trials. 
Experiments themselves arent actually run through the architecture, thats what the trials are for.
Trials are individual tests that get run. Ex. BP(5)-CNN-BP(5) would be 1 trial.


Adding your own experiments:

In experiments.txt you can add your own experiments and trials.
Newlines dont matter, you can space this out however you want to.
If you want to run trials with multiple CNN then you have to break them up into multiple trials, currently each trial can only handle 1 CNN. For example, if you wanted to run BP(5)-CNN-BP(5)-CNN-BP(5) you would need 1 trial to train the first CNN so you would run BP(5)-CNN-BP(5) and then the second trial would run the full thing. For multiple net trials, every trial except the last one in the sequence needs to be set to 'multiple'.

Each Experiment needs 2 things: an indicator, and A description
The indicator tells the script to start parsing a new experiment (ex. Experiment #1)
The Description is displayed when selecting experiments via the script and is used to label the experiment results folder.

Each Trial needs 3 things: a description, input arguments, and single/multiple
The description is what test is actually being run, ex. BP(5)-CNN-BP(5)
The input arguments are passed to the architecture. These include things like the correlation coefficient or number of BP iterations. All of the input arguments can be seen in Configurations.py. The same input arguments are used for GenData, Train, and Simulation.
single/multiple indicates the number of neural nets in the final simulation.


Example experiment.txt:

Experiment #1
Testing With 1 CNN

BP(1)-CNN-BP(1)
-CorrPara 0.8 -BP_IterForGenData 1 -BP_IterForSimu 1,1
single

BP(2)-CNN-BP(2)
-CorrPara 0.8 -BP_IterForGenData 2 -BP_IterForSimu 2,2
single


Experiment #2
Testing With Multiple CNN

***EXAMPLE TO BE ADDED AT A LATER DATE, STILL NEED TO FIGURE THIS OUT FULLY***