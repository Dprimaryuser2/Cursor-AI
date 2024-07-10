*** Settings ***
Library    SeleniumLibrary

Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/promo_keyword.robot
Resource    ../../../Resources/Web_POS/POS/customer_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot


Test Setup    Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}customer_tagging_test_data.xlsx

*** Test Cases ***
TC_C1 Customer Tagging is not mandatory with Bill on POS
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_01
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Verify Customer Tagging Is Not Mandatory
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}
     
TC_C2 Customer Tagging is mandatory with Bill on POS
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_02
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Verify Customer Tagging Is Mandatory
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify Customer Tagging    ${customer_info}
     Verify Billing Checkout
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}
     
TC_C3 Customer Tagging is mandatory with non mandatory customer information
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_03
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Verify Customer Tagging Is Mandatory
     Verify Customer Tagging Is Mandatory With Non Mandatory Information
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

TC_C4 Customer Tagging is mandatory with all fields mandatory in customer information
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_04
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Verify Customer Tagging Is Mandatory With All Fields    ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

TC_C5 Get the Customer Information of tagged Customer
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_05
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify And Fetch Customer Information    ${customer_info}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

TC_C6 Edit Customer Information
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_06
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     ${customer_info}    Edit Customer Information
     Verify Customer Tagging    ${customer_info}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


TC_C7 Edit Customer Group
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_07
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     ${group_data}    Edit Customer Group    ${pos_data}
     Verify Edited Group    ${group_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


TC_08 Untag Customer from Bill
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_07
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify Customer Untagging
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

TC_C9 Tag a Existing customer to a bill
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_09
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Tag Existing Customer   ${pos_data}
     Discard Items If Present From Previous Session
     Verify Customer Tagging    ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

TC_C10 Remove customer from all groups
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_10
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Remove Customer From All Groups
     Verify Customer Removed From All Groups
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


TC_C11 Add Customer to all available groups
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_11
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     ${group_count}  Add Customer To All Groups
     Verify Customer Added To All Groups   ${group_count}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


TC_C12 tag customer with tax invoice GST number
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_12
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify Customer Tagged With Tax Invoice GST Number  ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

TC_C13 tag customer with tax invoice UIN number
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_13
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify Customer Tagged With Tax Invoice UIN Number
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

TC_C14 Add existing GST number and customer should be tagged
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_14
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

TC_C15 Add existing UIN number and customer should be tagged
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_15
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


TC_C16 Edit GST number
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_16
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


TC_C17 Edit GST number
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_17
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


TC_C18 Delete GSTIN for a GST number
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_18
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


TC_C19 Delete GSTIN for a UIN number
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_19
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


TC_C20 Change Invoice Type from sales to GST
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_20
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Change Invoice Type From Sales To GST In Customer Information  ${pos_data}
     Verify Change Invoice Type from sales to GST
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

TC_C21 Change Invoice Type from sales to UIN
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_21
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Change Invoice Type From Sales To UIN In Customer Information  ${pos_data}
     Verify Change Invoice Type From Sales To GST
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

TC_C22 Change Invoice Type from GST to Sales
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_22
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Change Invoice Type from Tax Invoice to Sales Invoice
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


TC_C23 Change Invoice Type from UIN to Sales
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_23
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Change Invoice Type from Tax Invoice to Sales Invoice
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

TC_C24 Change Invoice Type from UIN to GST
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_24
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Change Tax Invoice Type  ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


TC_C25 Change Invoice Type from GST to UIN
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_25
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Tag Existing Customer   ${pos_data}
     Change Tax Invoice Type    ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

TC_C26 Add new GST With Invalid GST Number
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_26
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Tag Customer And Enter Invalid GST Number    ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


TC_C27 Edit Customer Information | Phone Number Field should be disabled
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_27
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Changing Phone Number Not Allowed In Customer Information
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}



TC_C28 Add Customer phone number more than 10 digit
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_28
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify Only Ten Digits Number Is Entered
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}



TC_C29 Add Customer phone number more than 10 digit
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_29
     Log    ${pos_data}
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Not Allowed Tagging Customer With Phone Number Less Than Ten Digits  ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

