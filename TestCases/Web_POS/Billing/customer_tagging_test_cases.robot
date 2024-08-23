*** Settings ***
Library    SeleniumLibrary

Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/salesperson_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot


Test Setup    Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Billing${/}customer_tagging_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Billing${/}customer_tagging_test_data.xlsx
${response}=    'NULL'

*** Test Cases ***
TC_C1 Customer Tagging is not mandatory with Bill on POS
     [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_01
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Verify Customer Tagging Is Not Mandatory
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C2 Customer Tagging is mandatory with Bill on POS
     [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_02
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Verify Customer Tagging Is Mandatory
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify Customer Tagging    ${customer_info}
     Verify Billing Checkout
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C3 Customer Tagging is mandatory with non mandatory customer information
     [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_03
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Verify Customer Tagging Is Mandatory
     Verify Customer Tagging Is Mandatory With Non Mandatory Information
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C4 Customer Tagging is mandatory with all fields mandatory in customer information
     [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_04
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Assign A Salesperson All Items     ${pos_data}
     Verify Customer Tagging Is Mandatory With All Fields    ${pos_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C5 Get the Customer Information of tagged Customer
     [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_05
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify And Fetch Customer Information    ${customer_info}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C6 Edit Customer Information
     [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_06
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     ${customer_info}    Edit Customer Information
     Verify Customer Tagging    ${customer_info}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C7 Edit Customer Group
     [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_07
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     ${group_data}    Edit Customer Group    ${pos_data}
     Verify Edited Group    ${group_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_08 Untag Customer from Bill
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_08
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify Customer Untagging
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C9 Tag a Existing customer to a bill
     [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_09
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Tag Existing Customer   ${pos_data}
     Discard Items If Present From Previous Session
     Verify Customer Tagging    ${pos_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C10 Remove customer from all groups
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_10
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Remove Customer From All Groups    ${pos_data}
     Verify Customer Removed From All Groups
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C11 Add Customer to all available groups
     [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_11
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     ${group_count}  Add Customer To All Groups    ${pos_data}
     Verify Customer Added To All Groups   ${group_count}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C12 Tag customer with tax invoice GST number
     [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_12
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify Customer Tagged With Tax Invoice GST Number  ${pos_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C13 Tag customer with tax invoice UIN number
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_13
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify Customer Tagged With Tax Invoice UIN Number    ${pos_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C14 Add existing GST number and customer should be tagged
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_14
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Tag Existing Customer    ${pos_data}
     Discard Items If Present From Previous Session
     Verify Existing GST Added After Tagging Customer    ${pos_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C15 Add existing UIN number and customer should be tagged
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_15
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Tag Existing Customer    ${pos_data}
     Discard Items If Present From Previous Session
     Verify Existing UIN Added After Tagging Customer    ${pos_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C16 Edit GST number
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_16
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Tag Existing Customer    ${pos_data}
     Discard Items If Present From Previous Session
     Verify GST Name Edited    ${pos_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C17 Edit UIN number
     [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_17
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Tag Existing Customer    ${pos_data}
     Discard Items If Present From Previous Session
     Verify GST Name Edited    ${pos_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C18 Delete GSTIN for a GST number
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_18
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Tag Existing Customer    ${pos_data}
     Discard Items If Present From Previous Session
     Delete And Add Same GST Number Again So That Next Time Test Case Doesnt Fail    ${pos_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C19 Delete GSTIN for a UIN number
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_19
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Tag Existing Customer    ${pos_data}
     Discard Items If Present From Previous Session
     Delete And Add Same UIN Number Again So That Next Time Test Case Doesnt Fail    ${pos_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C20 Change Invoice Type from sales to GST
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_20
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Change Invoice Type From Sales To GST In Customer Information  ${pos_data}
     Verify Change Invoice Type from sales to GST
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C21 Change Invoice Type from sales to UIN
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_21
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Change Invoice Type From Sales To UIN In Customer Information  ${pos_data}
     Verify Change Invoice Type From Sales To GST
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C22 Change Invoice Type from GST to Sales
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_22
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Change Invoice Type from Tax Invoice to Sales Invoice
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C23 Change Invoice Type from UIN to Sales
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_23
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Change Invoice Type from Tax Invoice to Sales Invoice
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C24 Change Invoice Type from UIN to GST
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_24
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Tag Existing Customer    ${pos_data}
     Change Tax Invoice Type   ${pos_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C25 Change Invoice Type from GST to UIN
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_25
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Tag Existing Customer   ${pos_data}
     Change Tax Invoice Type    ${pos_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C26 Add new GST With Invalid GST Number
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_26
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Tag Customer And Enter Invalid GST Number    ${pos_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C27 Edit Customer Information | Phone Number Field should be disabled
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_27
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Changing Phone Number Not Allowed In Customer Information
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C28 Add Customer phone number more than 10 digit
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_28
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify Only Ten Digits Number Is Entered
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

TC_C29 Add Customer phone number less than 10 digit
     [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_29
     Log    ${pos_data}
     ${response}=  Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Not Allowed Tagging Customer With Phone Number Less Than Ten Digits  ${pos_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

