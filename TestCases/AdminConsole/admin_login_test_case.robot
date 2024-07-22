*** Settings ***
Library    SeleniumLibrary
Library    ../../Resources/CustomKeywords/utilities.py
Resource   ../../Resources/AdminConsole/Login/login_keyword.robot


Test Setup      Open Application | Admin
Test Teardown   Close Browser


*** Variables ***
${login_td}=    ${CURDIR}${/}..${/}..${/}TestData${/}AdimnConsole${/}Promo${/}promo_test_data.xlsx

*** Test Cases ***
TC_01 Verify user is able to login with valid username and password
    [Documentation]    login
    ${login_data}=    Fetch Testdata By Id    ${login_td}    TC-01
    Login With Valid Username And Password    ${login_data}
