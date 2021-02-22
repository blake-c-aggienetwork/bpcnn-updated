:: Script for Iterative BP-CNN V1.2
:: To use:
:: create "batch" directory inside of "Iterative-BP-CNN-master"
:: place "masterResearchScript.bat" there
:: run script from the command line!

@echo off
setlocal EnableDelayedExpansion
title Research Terminal
cls
echo Master Script For Running Iterative-BP-CNN Experiments &echo Created by Thomas Bonsey

:: EXPERIMENT DEFINITIONS *********************************************************************
:: each experiment needs a name
:: each trial needs a description and input arguments
set experimentNames[1]=Determining BP Effectiveness
	set trialDescriptionsE1[1]=BP(1)-CNN-BP(1)
		set trialArgsE1[1]=-CorrPara 0.8 -BP_IterForGenData 1 -BP_IterForSimu 1,1
	set trialDescriptionsE1[2]=BP(2)-CNN-BP(2)
		set trialArgsE1[2]=-CorrPara 0.8 -BP_IterForGenData 2 -BP_IterForSimu 2,2
	set trialDescriptionsE1[3]=BP(3)-CNN-BP(3)
		set trialArgsE1[3]=-CorrPara 0.8 -BP_IterForGenData 3 -BP_IterForSimu 3,3
	set trialDescriptionsE1[4]=BP(4)-CNN-BP(4)
		set trialArgsE1[4]=-CorrPara 0.8 -BP_IterForGenData 4 -BP_IterForSimu 4,4
	set trialDescriptionsE1[5]=BP(5)-CNN-BP(5)
		set trialArgsE1[5]=-CorrPara 0.8 -BP_IterForGenData 5 -BP_IterForSimu 5,5
set experimentNames[2]=Testing Script - Multiple CNN
	set trialDescriptionsE2[1]=Test 1: 2 same CNN
		set trialArgsE2[1]=-CorrPara 0.8 -BP_IterForGenData 1,1 -BP_IterForSimu 1,1,1 -NetNumber 2 -SameModelAllNets True
	set trialDescriptionsE2[2]=Test 2: 2 different CNN
		set trialArgsE2[2]=-CorrPara 0.8 -BP_IterForGenData 1,1 -BP_IterForSimu 1,1,1 -NetNumber 2
:: ^^^ ADD NEW EXPERIMENTS/TRIALS HERE ^^^ *********************************************************************

:: experiment selection
call :arrayLength experimentNames numExperiments
echo ---------------------------------------------------------------------
for /l %%i in (1,1,%numExperiments%) do echo %%i. !experimentNames[%%i]!
echo ---------------------------------------------------------------------
set /p experimentNum="Choose Experiment: " & echo.
set currentExperimentName=!experimentNames[%experimentNum%]!

:: trial selection
call :arrayLength trialArgsE%experimentNum% numTrials
echo ---------------------------------------------------------------------
for /l %%i in (1,1,%numTrials%) do echo %%i. !trialDescriptionsE%experimentNum%[%%i]!
echo ---------------------------------------------------------------------
set /p trialStart="Choose Trial Start Number: "
set /p trialEnd="Choose Trial End Number: "

:: run it!
call :runExperiment %experimentNum% %trialStart% %trialEnd%
cmd /k


:: functions ---------------------------------------------------------------------

:runExperiment
:: runs experiments
:: args: in-experiment num, in-trial start num, in-trial end num
title Research in Progress
echo. &echo Experiment: %currentExperimentName%
for /l %%i in (%~2,1,%~3) do call :runTrial %~1 %%i
title Research Completed
exit /b 0

:runTrial
:: runs trials
:: args: in-current experiment num, in-current trial num
set currentTrialDescription=!trialDescriptionsE%~1[%~2]!
set currentTrialArgs=!trialArgsE%~1[%~2]!
call :setupTrial %~2
call :genData
call :train
call :simulation
call :cleanup %~2
exit /b 0

:genData
:: runs GenData step
cd ..\
echo GenData started %date% %time% &echo.
python main.py -Func GenData %currentTrialArgs%
echo GenData completed %date% %time% &echo.
echo ---------------------------------------------------------------------
cd batch
exit /b 0

:train
:: runs Train step
cd ..\
echo Train started %date% %time% &echo.
python main.py -Func Train %currentTrialArgs%
echo Train completed %date% %time% &echo.
echo ---------------------------------------------------------------------
cd batch
exit /b 0

:simulation
:: runs Simulation step
cd ..\
echo Simulation started %date% %time% &echo.
python main.py -Func Simulation %currentTrialArgs%
echo Simulation completed %date% %time% &echo.
echo ---------------------------------------------------------------------
cd batch
exit /b 0

:setupTrial
:: creates results folders
:: args: in-current trial num
echo. &echo Trial %~1 : %currentTrialDescription% Begins &echo.
if not exist results mkdir results
cd results
if not exist "%currentExperimentName%" mkdir "%currentExperimentName%"
cd "%currentExperimentName%"
if not exist trial%~1 mkdir trial%~1 &
cd trial%~1
if not exist _trialDescription.txt echo %currentTrialDescription% > _trialDescription.txt
set trialDirectory=%cd%
cd ..\..\..\
exit /b 0

:cleanup
:: save output files to trial folder, clears folders for next run, logs finished
:: args: in-current trial num
xcopy ..\model "%trialDirectory%" /q
rmdir /s /q ..\model
mkdir ..\model
rmdir /s /q ..\TestData
mkdir ..\TestData
rmdir /s /q ..\TrainingData
mkdir ..\TrainingData
echo Experiment %experimentNum% - Trial %~1 Completed %date% %time% &echo.
exit /b 0

:arrayLength
:: gets length of input array
:: args: in-array, out-array length
set len=%~1
for /l %%i in (1,1,1000) do if "!%len%[%%i]!"=="" (
	set /a %~2=%%i-1
	exit /b 0)
exit /b 0