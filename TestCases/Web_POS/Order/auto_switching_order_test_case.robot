*** Settings ***
Library    SeleniumLibrary
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Library    ../../../Resources/CustomKeywords/utilities.py
Resource    ../../../Resources/Web_POS/POS/Order/auto_switch_order_keywords.robot
Resource    ../../../Resources/Web_POS/POS/Return/adhoc_return_keywords.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

#*** Variables ***
#${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Order${/}auto_switching_order_test_data.xlsx

*** Variables ***
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Order${/}auto_switching_order_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Order${/}auto_switching_order_test_data.xlsx

*** Test Cases ***
Zwing_A_1 Switching to Order POS while Order Pos is not allowed in Policies | Order from pos not allowed
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_01
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Verify Order Mode Is Disable In Policies  ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_2 Switching to Order POS while Order Pos is allowed in Policies | Order from pos is allowed
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_02
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Verify Order Option In Dropdown    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_3 Confirm the Switching to the Order | Order from pos is allowed
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_03
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_4 Cancel the Switching to the Order | Order from pos is allowed
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_04
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Verify Cancel Button While Switching Mode    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_5 Return to POS Screen when Auto Switch the Billing is on
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_05
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Turn Auto Switch To Billing On
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switched To Billing
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_6 Return to POS Screen when Auto Switch the Billing is off
    [Tags]    retry
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_06
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Turn Auto Switch To Billing Off
    Change Billing Mode    ${pos_data}
    Verify Auto Switch to billing is Off | Order
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_153 Click on Confirm button on switch to Billing popup box
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_153
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Switch From Order Mode To Billing
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_154 Click on Cancel button on switch to Billing popup box
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_154
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Cancel Switch From Order Mode To Billing
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_155 Switching Between Order to Billing Will Give Confirmation Popup
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_155
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify Mode Option Popup  ${billing_option}
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_156 Click on Confirm button on switch to Exchange popup box
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_156
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Switch From Order Mode To Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_157 Click on Cancel button on switch to Exchange popup box
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_157
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Cancel Switch From Order Mode To Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_158 Switching Between Order to Exchange Will Give Confirmation Popup
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_158
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify Mode Option Popup   ${exchange_option}
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_159 Click on Confirm button on switch to Return popup box
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_159
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Switch From Order Mode To Return
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_160 Click on Cancel button on switch to Return popup box
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_160
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Cancel Switch From Order Mode To Return
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_161 Switching Between Order to Return Will Give Confirmation Popup
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_161
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify Mode Option Popup  ${return_option}
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_189 Cancel Switch From Billing to Order
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_16
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Cancel Switch From Billing Mode To Order
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_190 Cancel Switch From Billing to Return
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_17
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Cancel Switch From Billing Mode To Return
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_A_191 Cancel Switch From Billing to Exchange
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_18
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Cancel Switch From Billing Mode To Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}
