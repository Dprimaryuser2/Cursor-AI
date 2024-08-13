*** Settings ***
Library    SeleniumLibrary
Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Test Setup      Open Application | POS
Test Teardown   Close Browser

#*** Variables ***
#${login_td}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Promo${/}login_test_data.xlsx

*** Variables ***
${QA_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Staging${/}Promo${/}login_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Production${/}Promo${/}login_test_data.xlsx

*** Test Cases ***
TC_01 Verify user is able to login with valid username and password
    [Documentation]    login
    ${LOGIN_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${login_data}=  Fetch Testdata By Id   ${LOGIN_TD}    TC_01
    Login With Valid Username And Password | POS    ${login_data}

TC_02 Verify user is able to login with valid username and password
    [Documentation]    login
    ${LOGIN_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${login_data}=  Fetch Testdata By Id   ${LOGIN_TD}    TC_02
    Login With Valid Username And Password | POS    ${login_data}

TC_03 Verify user is able to login with valid username and password
    [Documentation]    login
    ${LOGIN_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${login_data}=  Fetch Testdata By Id   ${LOGIN_TD}    TC_03
    Login With Valid Username And Password | POS    ${login_data}

TC_04 Verify user is able to login with valid username and password
    [Documentation]    login
    ${LOGIN_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${login_data}=  Fetch Testdata By Id   ${LOGIN_TD}    TC_04
    Login With Valid Username And Password | POS    ${login_data}

TC_05 Verify user is able to login with valid username and password
    [Documentation]    login
    ${LOGIN_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${login_data}=  Fetch Testdata By Id   ${LOGIN_TD}    TC_05
    Login With Valid Username And Password | POS    ${login_data}
