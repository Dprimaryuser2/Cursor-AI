@echo off
setlocal

:: Define the output directory
set "OUTPUT_DIR=output"

:: Check if environment is provided as an argument
if "%~1"=="" (
    echo No environment provided. Usage: executor.bat env [module] [testfile]
    exit /b 1
)

:: Store the environment from the command line argument
set "ENV=%~1"

:: Check if a specific module is provided as an argument
if "%~2"=="" (
    set "MODULE=TestCases\Web_POS"
) else (
    set "MODULE=TestCases\Web_POS\%~2"
)

:: Check if a specific test file is provided as an argument
if "%~3"=="" (
    set "TEST_FILE="
) else (
    set "TEST_FILE=%~3"
)

:: Debugging: Show the constructed paths
echo Debug: Environment: %ENV%
echo Debug: Module: %MODULE%
echo Debug: Test File: %TEST_FILE%

:: Create the output directory if it does not exist
if not exist "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
)

:: Define the paths within the output directory
set "ALLURE_RESULTS=%OUTPUT_DIR%\allure-results"
set "ALLURE_REPORT=%OUTPUT_DIR%\allure-report"
set "LOG_DIR=%OUTPUT_DIR%"
set "SCREENSHOTS_DIR=%OUTPUT_DIR%\Screenshots"

:: Debugging: Show paths for output directories
echo Debug: Allure Results Path: %ALLURE_RESULTS%
echo Debug: Allure Report Path: %ALLURE_REPORT%
echo Debug: Log Path: %LOG_DIR%
echo Debug: Screenshots Path: %SCREENSHOTS_DIR%

:: Preserve history folder from the previous report
if exist "%ALLURE_REPORT%\history" (
    echo Copying history...
    xcopy /E /I /Y "%ALLURE_REPORT%\history" "%ALLURE_RESULTS%\history"
)

:: Remove old report directories, but keep allure-results for trend generation
echo Removing old report directories...
if exist "%ALLURE_REPORT%" (
    rmdir /s /q "%ALLURE_REPORT%"
)

if exist "%OUTPUT_DIR%\robot_results" (
    rmdir /s /q "%OUTPUT_DIR%\robot_results"
)

if exist "%SCREENSHOTS_DIR%" (
    rmdir /s /q "%SCREENSHOTS_DIR%"
)

:: Delete specific files, but do not delete allure-results to keep historical data
echo Deleting specific files...
if exist "%LOG_DIR%\output.xml" (
    del /q "%LOG_DIR%\output.xml"
)

if exist "%LOG_DIR%\log.html" (
    del /q "%LOG_DIR%\log.html"
)

:: Install required Python packages
echo Installing required Python packages...
python -m pip install -r .\requirements.txt

:: Run the specific module's tests or all tests if no module or file specified
if "%TEST_FILE%"=="" (
    echo Running tests in "%MODULE%"...
    robot --listener allure_robotframework:%ALLURE_RESULTS% --outputdir %OUTPUT_DIR% -v ENV:%ENV% "%MODULE%"
) else (
    echo Running tests in "%MODULE%\%TEST_FILE%"...
    robot --listener allure_robotframework:%ALLURE_RESULTS% --outputdir %OUTPUT_DIR% -v ENV:%ENV% "%MODULE%\%TEST_FILE%"
)

:: Check if the results directory contains results
if not exist "%OUTPUT_DIR%\output.xml" (
    echo No test results found in "%OUTPUT_DIR%".
    exit /b 1
)

:: Run Slack notifier
echo Running Slack notifier...
python ./Runner/slack_notifier.py
if %errorlevel% neq 0 (
    echo Slack notifier failed with error code %errorlevel%.
    exit /b %errorlevel%
)
echo Slack notifier completed successfully.

:: Run Email notifier
echo Running Email notifier...
python ./Runner/EmailNotifier.py
if %errorlevel% neq 0 (
    echo Email notifier failed with error code %errorlevel%.
    exit /b %errorlevel%
)
echo Email notifier completed successfully.

:: Generate Allure report with trends and copy screenshots
echo Generating Allure report...
allure generate --clean --output "%ALLURE_REPORT%" "%ALLURE_RESULTS%"

if exist ..\Screenshots (
    echo Copying screenshots...
    robocopy ..\Screenshots "%SCREENSHOTS_DIR%" /E
)

allure open "%ALLURE_REPORT%"

:: Run AWS S3 upload script
echo Running AWS S3 upload script...
python ./Runner/aws_s3_upload.py
if %errorlevel% neq 0 (
    echo AWS S3 upload script failed with error code %errorlevel%.
    exit /b %errorlevel%
)
echo AWS S3 upload script completed successfully.

:: Pause to review the output
pause
