*** Settings ***
Library    SeleniumLibrary
Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource  ../../../Resources/Web_POS/POS/Billing/keyboard_shortcut_keywords.robot
Resource  ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource   ../../../Resources/Web_POS/POS/Billing/add_to_cart_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot

Test Setup    Open Application | POS
Test Teardown   Close Browser

#*** Variables ***
#${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}keyboard_shortcut_test_data.xlsx

*** Variables ***
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Billing${/}keyboard_shortcut_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Billing${/}keyboard_shortcut_test_data.xlsx

*** Test Cases ***

Zwing_KB_01 Search product using keyboard shortcut
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_1
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Allows Searching Product    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_02 View/Hide product using keyboard shortcut
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_2
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Displays And Hide Catalogue Window    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_03 Refresh catalog using keyboard shortcut
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_3
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Allows Updating Catalogue
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_04 View Salesperson using keyboard shortcut
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_4
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Displays Salesperson Details
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_05 view held bills using keyboard shortcut
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_5
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Hold Bill
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Allows Navigating To Held Bills
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_06 Hold the current bill using keyboard shortcut
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_6
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan And Add Product    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Holds Bill
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_07 Add manual discount using keyboard shortcut
    [Tags]    Valid Failure
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_7
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan And Add Product    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Allows Adding Manual Discount
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_08 Add Carry bags using keyboard shortcut
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_8
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan And Add Product        ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Allows Adding Carry Bags    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_09 Tag a customer using keyboard shortcut before tagging a customer
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_9
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan And Add Product    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Allows Tagging Customer    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_10 Tag a customer using keyboard shortcut after tagging a customer
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_10
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan And Add Product    ${pos_data}
    Add Customer Details    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Customer Information Is Displayed For Tag A Customer After Tagging Customer
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_11 Cancel current bill using keyboard shortcut
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_11
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan And Add Product    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Clears The Cart
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_12 Checkout bill using keyboard shortcut when ST is optional
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_12
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan And Add Product    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Navigates To Checkout Page
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_13 Checkout bill using keyboard shortcut when ST is mandatory
    [Tags]    Valid Failure
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_13
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan And Add Product    ${pos_data}
    Add Customer Details    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Navigates To Checkout Page When ST Is Mandatory
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_14 Checkout bill using keyboard shortcut without tagging customer
    [Tags]    valid failure
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_14
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan And Add Product    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Navigates To Checkout Page When CT Is Mandatory
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_15 Checkout using shortcut before opening session
    [Tags]    retry
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_15
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan And Add Product    ${pos_data}
    Close The Session For Adding The Item From Previous Session    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Does Not Navigates To Checkout Page When Session Is Closed
    Open Session Before Revoking Serial Key    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_16 Search product using keyboard shortcut | Order Mode
    [Tags]    retry
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_16
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Wait Until Keyword Succeeds    3    2     Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Allows Searching Product    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_17 View/Hide product using keyboard shortcut | Order Mode
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_17
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Displays And Hide Catalogue Window    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_18 Refresh catalog using keyboard shortcut | Order Mode
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_18
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Allows Updating Catalogue
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_19 view Salesperson using keyboard shortcut | Order Mode
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_19
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan And Add Product    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Displays Salesperson Details
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_20 Add manual discount using keyboard shortcut | Order Mode
    [Tags]    Valid Failure
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_20
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan And Add Product    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Allows Adding Manual Discount
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_21 Add Carry bags using keyboard shortcut | Order Mode
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_21
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan And Add Product    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Allows Adding Carry Bags    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_22 On Order screen before tagging a customer, press Ctrl + A | Order Mode
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_22
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan And Add Product    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Allows Tagging Customer    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_23 On Order screen after tagging a customer, press Ctrl + A | Order Mode
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_23
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan And Add Product    ${pos_data}
    Add Customer Details    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Customer Information Is Displayed For Tag A Customer After Tagging Customer
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_24 Cancel current bill using keyboard shortcut on Order Screen | Order Mode
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_24
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan And Add Product    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Clears The Cart
    [Teardown]   Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_25 Checkout bill using keyboard shortcut-After adding product when policies for salesperson and customer tagging is optional, press Ctrl + B on Order Screen
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_25
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Product By Scan Only    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Insufficient Inventory Window | Order   ${pos_data}
    Verify Fulfilment Option is Visible
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_26 Checkout bill using keyboard shortcut-Without tagging salesperson when policy for salesperson is mandatory, press Ctrl + B on Order Screen
   [Tags]    valid failure
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_26
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Product By Scan Only    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Salesperson Tagging Is Mandatory Using Shortcut     ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_27 Checkout bill using keyboard shortcut-Without tagging customer when policy for customer is mandatory, press Ctrl + B on Order Screen
    [Tags]    Valid Failure
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_27
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan And Add Product    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Customer Tagging Is Mandatory Using Shortcut    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_28 Checkout using shortcut before opening session | Order Mode
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_28
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Navigates To Checkout Page When Session Is Closed   ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_29 Search product using keyboard shortcut On Return Screen
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_29
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan And Add Product    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Allows Searching Product    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_KB_30 View/Hide product using keyboard shortcut On Return Screen
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_30
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Press Shortcut Key    ${pos_data}
   Verify Shortcut Key Displays And Hide Catalogue Window  ${pos_data}
   Revoke Serial Key    ${pos_data}
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}