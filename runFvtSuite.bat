call setupenv.bat
@echo off

if "%1"=="" goto error
if "%2"=="-nobuild" goto runWithOldBuild
goto runWithNewBuild
 
:runWithOldBuild
set suite=%1
cd ..
cd BTTAutomation
ws_ant -Dcategory=fvt -Dsuite=%suite% -Drebuild=false runFvtTestSuite & cd .. & cd sandbox & goto end


:runWithNewBuild
set suite=%1
cd ..
cd BTTAutomation
ws_ant -Dcategory=fvt -Dsuite=%suite% -Drebuild=true runFvtTestSuite & cd .. & cd sandbox & goto end


:error
  REM cls 
  echo  You should input a valid suite name: CHA, Struts, OPSTEP 
  goto end

:end
  echo.
  echo.