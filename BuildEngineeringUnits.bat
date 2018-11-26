@ECHO off
REM ****************************************************************************************************************
REM ** --
REM ** This script demonstrates how to use the model compiler to generate engineering units.
REM ** --
REM ****************************************************************************************************************
SETLOCAL

set MODELCOMPILER=.\Bin\Release\Opc.Ua.ModelCompiler.exe
set OUTPUT=.\Published
set EXCLUDE=-exclude nothing
set ANNEX1_SRCPATH=.\ModelCompiler\Design\rec20_latest_a1.csv
set ANNEX2_SRCPATH=.\ModelCompiler\Design\rec20_latest_a2-3.csv
set OUTPUT_PATH=%OUTPUT%\Schema\UNECE_to_OPCUA.csv

REM Make sure that all of our output locations exist..

IF NOT EXIST %MODELCOMPILER% GOTO noModelCompiler
IF NOT EXIST %OUTPUT% MKDIR %OUTPUT%
IF NOT EXIST %OUTPUT%\Schema MKDIR %OUTPUT%\Schema

REM STEP 1) Generate files.

ECHO Building Unit File
ECHO ON
%MODELCOMPILER% -units -annex1 "%ANNEX1_SRCPATH%" -annex2 "%ANNEX2_SRCPATH%" -output "%OUTPUT_PATH%"
IF %ERRORLEVEL% NEQ 0 ( ECHO Failed %PARTNAME% & EXIT /B 1 )

ECHO Copying CSV files to %OUTPUT%\Schema\
ECHO ON
COPY "%ANNEX1_SRCPATH%" "%OUTPUT%\Schema\rec20_latest_a1.csv"
COPY "%ANNEX2_SRCPATH%" "%OUTPUT%\Schema\rec20_latest_a2-3.csv"
@ECHO OFF

GOTO theEnd

:noModelCompiler
ECHO.
ECHO ModelCompiler not found. Please make sure it is compiled in RELEASE mode.
ECHO Searched for: %MODELCOMPILER%

:theEnd
ENDLOCAL