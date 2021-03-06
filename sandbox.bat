call C:\SandBox\setupenv.bat

rd /S /Q %release%

jar -xf %BTT_HOME%\%release%.zip
del /f /q %BTT_HOME%\%release%.zip

date /T > %BTT_HOME%\sandbox.log

copy  %BTT_HOME%\setupenv.bat %ENG_WORK_SPACE%\SandBox\setupenv.bat /Y
copy  %BTT_HOME%\build.properties %ENG_WORK_SPACE%\BTTAutomation\build.properties /Y
call ws_ant -f xcpautocfg.xml 

rem xcopy %BTT_HOME%\BTTAutomation %ENG_WORK_SPACE%\BTTAutomation /R /Y /S
rem copy c:\sandbox\build.xml %ENG_WORK_SPACE%\BTTAutomation\build.xml /Y
rem copy c:\sandbox\CHAEX04\case.xml %ENG_WORK_SPACE%\BTTAutomation\fvt\CHAEX04\case.xml /Y
rem copy c:\sandbox\WSDII\case.xml %ENG_WORK_SPACE%\BTTAutomation\fvt\WSDII\case.xml /Y

rem call %ENG_WORK_SPACE%\SandBox\build_level.bat
rem echo level_serialbuild=%level_serialbuild:~-8,8%>>%ENG_WORK_SPACE%\BTTAutomation\build.properties

call ws_ant -f %ENG_WORK_SPACE%\BTTAutomation\init.xml checkBackends

call ws_ant -k -f %ENG_WORK_SPACE%\BTTAutomation\build.xml -Dcategory=unit -Drebuild=true runAllUnit
call ws_ant -k -f %ENG_WORK_SPACE%\BTTAutomation\build.xml -Dcategory=unit -Drebuild=true sendReportToWebsite
call ws_ant -k -f %ENG_WORK_SPACE%\BTTAutomation\build.xml -Dcategory=unit transferFileToMailSrv

rem call ws_ant -f %ENG_WORK_SPACE%\BTTAutomation\build.xml -Dcategory=unit -Drebuild=true sendReportToServer

call ws_ant -k -f %ENG_WORK_SPACE%\BTTAutomation\build.xml -Dcategory=fvt -Drebuild=true runFvt
call ws_ant -k -f %ENG_WORK_SPACE%\BTTAutomation\build.xml -Dcategory=fvt -Drebuild=true runAllFvtCaseWithOutWas
call ws_ant -k -f %ENG_WORK_SPACE%\BTTAutomation\build.xml -Dcategory=fvt -Drebuild=true sendReportToWebsite
call ws_ant -k -f %ENG_WORK_SPACE%\BTTAutomation\build.xml -Dcategory=fvt transferFileToMailSrv

rem call ws_ant -f %ENG_WORK_SPACE%\BTTAutomation\build.xml -Dcategory=fvt -Drebuild=true sendReportToServer

call ws_ant -k -f %ENG_WORK_SPACE%\BTTAutomation\build.xml -Dcategory=svt -Drebuild=true runSvt
call ws_ant -k -f %ENG_WORK_SPACE%\BTTAutomation\build.xml -Dcategory=svt -Drebuild=true sendReportToWebsite
call ws_ant -k -f %ENG_WORK_SPACE%\BTTAutomation\build.xml -Dcategory=svt transferFileToMailSrv

rem call ws_ant -f %ENG_WORK_SPACE%\BTTAutomation\build.xml -Dcategory=svt -Drebuild=true sendReportToServer

rem transfer the coverage report to mail server
call ws_ant -k -f %ENG_WORK_SPACE%\BTTAutomation\build.xml transferCoverageResult