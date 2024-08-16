*** Settings ***
Library    SeleniumLibrary
Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Test Setup      Open Application | POS
Test Teardown   Close Browser

#*** Variables ***
#${login_td}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Promo${/}login_test_data.xlsx

*** Variables ***
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Promo${/}login_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Promo${/}login_test_data.xlsx

*** Test Cases ***
TC_01 Verify user is able to login with valid username and password
    [Documentation]    login
    ${LOGIN_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${login_data}=  Fetch Testdata By Id   ${LOGIN_TD}    TC_01
    ${response}=    Login With Valid Username And Password | POS    ${login_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${login_data}

TC_02 Verify user is able to login with valid username and password
    [Documentation]    login
    ${LOGIN_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${login_data}=  Fetch Testdata By Id   ${LOGIN_TD}    TC_02
    ${response}=    Login With Valid Username And Password | POS    ${login_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${login_data}

TC_03 Verify user is able to login with valid username and password
    [Documentation]    login
    ${LOGIN_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${login_data}=  Fetch Testdata By Id   ${LOGIN_TD}    TC_03
    ${response}=    Login With Valid Username And Password | POS    ${login_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${login_data}

TC_04 Verify user is able to login with valid username and password
    [Documentation]    login
    ${LOGIN_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${login_data}=  Fetch Testdata By Id   ${LOGIN_TD}    TC_04
    ${response}=    Login With Valid Username And Password | POS    ${login_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${login_data}

TC_05 Verify user is able to login with valid username and password
    [Documentation]    login
    ${LOGIN_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${login_data}=  Fetch Testdata By Id   ${LOGIN_TD}    TC_05
    ${response}=    Login With Valid Username And Password | POS    ${login_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${login_data}
