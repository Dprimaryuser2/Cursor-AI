*** Settings ***
Library    SeleniumLibrary
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Resource    ../../../Resources/Web_POS/POS/Billing/salesperson_keyword.robot
Library    ../../../Resources/CustomKeywords/utilities.py

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Billing${/}salesperson_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Billing${/}salesperson_test_data.xlsx
${response}=    'NULL'

*** Test Cases ***
Zwing_ST_1 Salesperson Tagging is Enabled and Salesperson Tagging is Mandatory in Policies
   [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_1
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Add Customer Details    ${pos_data}
   Verify Salesperson Tagging is Enabled and Salesperson Tagging is Mandatory in Policies
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_ST_2 Salesperson Tagging is Enabled and Salesperson Tagging is Optional in Policies
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_2
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Add Customer Details    ${pos_data}
   Verify Salesperson Tagging is Enabled and Salesperson Tagging is Optional in Policies
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_ST_3 Salesperson Tagging is Enabled and Salesperson Tagging is Mandatory after adding the product in Policies
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_3
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Salesperson Tagging is Enabled and Salesperson Tagging is Mandatory in Policies after adding the product    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_ST_4 Salesperson Tagging Item Level
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_4
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    Assign A Salesperson To An Item  ${pos_data}
    Verify If Salesperson Is Assigned To An Item    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_ST_5 Salesperson Tagging Bill Level
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_5
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    Assign A Salesperson All Items   ${pos_data}
    Verify Salesperson Tagged At Bill Level    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_ST_6 Tag Single Salesperson To multiple Items
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_6
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    Verify Assign Same Salesperson To All Products Except Last Product   ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_ST_7 Tag Different salesperson for each item
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_7
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    Assign A different Salesperson To Each Item  ${pos_data}
    Verify If Different Salesperson Was Assigned To Each Person
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_ST_8 Change Salesperson tagging for item
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_8
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    Assign A Salesperson All Items   ${pos_data}
    Verify Change Salesperson tagging for item    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_ST_9 Change Salesperson tagging for bill
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_9
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    Assign A Salesperson All Items   ${pos_data}
    Verify Change Salesperson tagging for bill   ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_ST_10 Tagged Sales person view below the tagged Item
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_10
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    Assign A Salesperson All Items   ${pos_data}
    Verify Salesperson Tagged At Bill Level    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

#Zwing_ST_11

Zwing_ST_12 Salesperson Tagging is Disabled in policies
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_12
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Verify Salesperson Tagging is Disabled
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}