@REM @echo off
@REM setlocal
@REM
@REM :: Define the output directory
@REM set "OUTPUT_DIR=output"
@REM
@REM :: Check if environment is provided as an argument
@REM if "%~1"=="" (
@REM     echo No environment provided. Usage: executor.bat env [module] [testfile]
@REM     exit /b 1
@REM )
@REM
@REM :: Store the environment from the command line argument
@REM set "ENV=%~1"
@REM
@REM :: Check if a specific module is provided as an argument
@REM if "%~2"=="" (
@REM     set "MODULE=TestCases\Web_POS"
@REM ) else (
@REM     set "MODULE=TestCases\Web_POS\%~2"
@REM )
@REM
@REM :: Check if a specific test file is provided as an argument
@REM if "%~3"=="" (
@REM     set "TEST_FILE="
@REM ) else (
@REM     set "TEST_FILE=%~3"
@REM )
@REM
@REM :: Debugging: Show the constructed paths
@REM echo Debug: Environment: %ENV%
@REM echo Debug: Module: %MODULE%
@REM echo Debug: Test File: %TEST_FILE%
@REM
@REM :: Create the output directory if it does not exist
@REM if not exist "%OUTPUT_DIR%" (
@REM     mkdir "%OUTPUT_DIR%"
@REM )
@REM
@REM :: Define the paths within the output directory
@REM set "ALLURE_RESULTS=%OUTPUT_DIR%\allure-results"
@REM set "ALLURE_REPORT=%OUTPUT_DIR%\allure-report"
@REM set "LOG_DIR=%OUTPUT_DIR%\log"
@REM set "SCREENSHOTS_DIR=%OUTPUT_DIR%\Screenshots"
@REM
@REM :: Debugging: Show paths for output directories
@REM echo Debug: Allure Results Path: %ALLURE_RESULTS%
@REM echo Debug: Allure Report Path: %ALLURE_REPORT%
@REM echo Debug: Log Path: %LOG_DIR%
@REM echo Debug: Screenshots Path: %SCREENSHOTS_DIR%
@REM
@REM :: Preserve history folder from the previous report
@REM if exist "%ALLURE_REPORT%\history" (
@REM     echo Copying history...
@REM     xcopy /E /I /Y "%ALLURE_REPORT%\history" "%ALLURE_RESULTS%\history"
@REM )
@REM
@REM :: Remove old report directories, but keep allure-results for trend generation
@REM echo Removing old report directories...
@REM if exist "%ALLURE_REPORT%" (
@REM     rmdir /s /q "%ALLURE_REPORT%"
@REM )
@REM
@REM if exist "%OUTPUT_DIR%\robot_results" (
@REM     rmdir /s /q "%OUTPUT_DIR%\robot_results"
@REM )
@REM
@REM if exist "%SCREENSHOTS_DIR%" (
@REM     rmdir /s /q "%SCREENSHOTS_DIR%"
@REM )
@REM
@REM :: Delete specific files, but do not delete allure-results to keep historical data
@REM echo Deleting specific files...
@REM if exist "%LOG_DIR%\output.xml" (
@REM     del /q "%LOG_DIR%\output.xml"
@REM )
@REM
@REM if exist "%LOG_DIR%\log.html" (
@REM     del /q "%LOG_DIR%\log.html"
@REM )
@REM
@REM :: Install required Python packages
@REM echo Installing required Python packages...
@REM python -m pip install -r .\requirements.txt
@REM
@REM :: Run the specific module's tests or all tests if no module or file specified
@REM if "%TEST_FILE%"=="" (
@REM     echo Running tests in "%MODULE%"...
@REM     robot --listener allure_robotframework:%ALLURE_RESULTS% --outputdir %ALLURE_RESULTS% -v ENV:%ENV% "%MODULE%"
@REM ) else (
@REM     echo Running tests in "%MODULE%\%TEST_FILE%"...
@REM     robot --listener allure_robotframework:%ALLURE_RESULTS% --outputdir %ALLURE_RESULTS% -v ENV:%ENV% "%MODULE%\%TEST_FILE%"
@REM )
@REM
@REM :: Check if the results directory contains results
@REM if not exist "%ALLURE_RESULTS%\output.xml" (
@REM     echo No test results found in "%ALLURE_RESULTS%".
@REM     exit /b 1
@REM )
@REM
@REM :: Generate Allure report with trends and copy screenshots
@REM echo Generating Allure report...
@REM allure generate --clean --output "%ALLURE_REPORT%" "%ALLURE_RESULTS%"
@REM
@REM if exist ..\Screenshots (
@REM     echo Copying screenshots...
@REM     robocopy ..\Screenshots "%SCREENSHOTS_DIR%" /E
@REM )
@REM
@REM allure open "%ALLURE_REPORT%"
@REM
@REM :: Pause to review the output
@REM pause

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
set "LOG_DIR=%OUTPUT_DIR%\log"
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
    robot  --listener  RetryFailed  --listener allure_robotframework:%ALLURE_RESULTS% --outputdir %ALLURE_RESULTS% -v ENV:%ENV% "%MODULE%"
) else (
    echo Running tests in "%MODULE%\%TEST_FILE%"...
    robot  --listener  RetryFailed   --listener allure_robotframework:%ALLURE_RESULTS% --outputdir %ALLURE_RESULTS% -v ENV:%ENV% "%MODULE%\%TEST_FILE%"
)

:: Check if the results directory contains results
if not exist "%ALLURE_RESULTS%\output.xml" (
    echo No test results found in "%ALLURE_RESULTS%".
    exit /b 1
)

:: Generate Allure report with trends and copy screenshots
echo Generating Allure report...
allure generate --clean --output "%ALLURE_REPORT%" "%ALLURE_RESULTS%"

if exist ..\Screenshots (
    echo Copying screenshots...
    robocopy ..\Screenshots "%SCREENSHOTS_DIR%" /E
)

allure open "%ALLURE_REPORT%"

echo Sending Email
python  EmailNotifier.py
echo email send

:: Pause to review the output
pause

