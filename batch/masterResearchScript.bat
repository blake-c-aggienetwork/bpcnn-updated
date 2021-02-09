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

:: all experiment names
set experimentNames[0]=Determining BP Effectiveness
:: ^^^ ADD NEW EXPERIMENTS HERE ^^^
call :arrayLength experimentNames
set /a numExperiments=%errorlevel%

:: experiment selection
echo ---------------------------------------------------------------------
for /l %%i in (0,1,%numExperiments%) do echo %%i. !experimentNames[%%i]!
echo ---------------------------------------------------------------------
set /p experimentNum="Choose Experiment: "
set currentExperimentName=!experimentNames[%experimentNum%]!
call :experiment%experimentNum%

cmd /k


:: experiments ---------------------------------------------------------------------

:experiment0
::Determining BP Effectiveness
title Research in Progress
echo. &echo Experiment: %currentExperimentName%
set /a trialNum=1

::Trial 1
set trialDescription=BP(1)-CNN-BP(1)
call :setupTrial %trialNum%
::set Arguments
set args=-CorrPara 0.8 -BP_IterForGenData 1 -BP_IterForSimu 1,1
::run trial
call :genData
call :train
call :simulation
::end trial
call :cleanup
set trialNum=%trialNum%+1

::Trial 2

title Research Completed
exit /b 0


:: other functions ---------------------------------------------------------------------

:genData
cd ..\
echo GenData started %date% %time% &echo.
python main.py -Func GenData %args%
echo GenData completed %date% %time% &echo.
echo ---------------------------------------------------------------------
cd batch
exit /b 0

:train
cd ..\
echo Train started %date% %time% &echo.
python main.py -Func Train %args%
echo Train completed %date% %time% &echo.
echo ---------------------------------------------------------------------
cd batch
exit /b 0

:simulation
cd ..\
echo Simulation started %date% %time% &echo.
python main.py -Func Simulation %args%
echo Simulation completed %date% %time% &echo.
echo ---------------------------------------------------------------------
cd batch
exit /b 0

:setupTrial
:: creates results folders
echo. &echo Trial %~1 : %trialDescription% Begins &echo.
if not exist results mkdir results
cd results
if not exist "%currentExperimentName%" mkdir "%currentExperimentName%"
cd "%currentExperimentName%"
if not exist trial%~1 mkdir trial%~1 &
cd trial%~1
if not exist _trialDescription.txt echo %trialDescription% > _trialDescription.txt
set trialDirectory=%cd%
cd ..\..\..\
exit /b 0

:cleanup
:: save output files to trial folder
xcopy ..\model "%trialDirectory%" /q
:: clear folders for next run
rmdir /s /q ..\model
mkdir ..\model
rmdir /s /q ..\TestData
mkdir ..\TestData
rmdir /s /q ..\TrainingData
mkdir ..\TrainingData
:: log finished
echo Experiment %experimentNum% - Trial %trialNum% Completed %date% %time% &echo.
exit /b 0

:arrayLength
set len=%~1
for /l %%i in (0,1,1000) do if "!%len%[%%i]!"=="" exit /b %%i
exit /b 0