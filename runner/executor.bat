@echo off
setlocal

:: Check if a folder name, test file name, and environment are provided as arguments
if "%~1"=="" (
    echo No environment provided. Usage: scriptname.bat env foldername testfile
    exit /b 1
)

if "%~2"=="" (
    echo No folder name provided. Usage: scriptname.bat env foldername testfile
    exit /b 1
)

if "%~3"=="" (
    echo No test file name provided. Usage: scriptname.bat env foldername testfile
    exit /b 1
)

:: Store the environment, folder name, and test file name from the command line arguments
set ENV=%~1
set FOLDERNAME=%~2
set TESTFILE=%~3

:: Define the common base path
set BASE_PATH=TestCases\Web_POS\

:: Debugging: Show the constructed path
echo Debug: Checking path %BASE_PATH%%FOLDERNAME%\%TESTFILE%

:: Check if the test file exists in the specified folder
if exist "%BASE_PATH%%FOLDERNAME%\%TESTFILE%" (
    echo Folder: %BASE_PATH%%FOLDERNAME%
    echo Test File: %TESTFILE%
    echo Full Path: %BASE_PATH%%FOLDERNAME%\%TESTFILE%
) else (
    echo Unable to find path for the test file: %FOLDERNAME%\%TESTFILE%
    exit /b 1
)

:: Preserve history folder from the previous report
if exist allure-report\history (
    xcopy /E /I /Y allure-report\history allure-results\history
)

:: Remove old report directories, but keep allure-results for trend generation
rmdir /s /q allure-report
rmdir /s /q pabot_results
rmdir /s /q ..\Screenshots

:: Delete specific files, but do not delete allure-results to keep historical data
del /q log\output.xml
del /q log\log.html

:: Install required Python packages
pip install -r ./requirements.txt

:: Run the test file with Pabot and pass the environment variable
pabot --listener RetryFailed:1 --listener allure_robotframework:./allure-results --outputdir allure-results -v ENV:%ENV% .\%BASE_PATH%%FOLDERNAME%\%TESTFILE%

:: Optional: Run a performance metrics script
:: python3 PerformanceMetrics.py

:: Delete report data file
del /q report_data.txt

:: Run email notification script
@REM python EmailNotifier.py

:: Generate Allure report with trends and copy screenshots
allure generate --clean allure-results --output allure-report
robocopy ..\Screenshots allure-report\Screenshots /E
allure open allure-report

:: Pause to review the output
pause

