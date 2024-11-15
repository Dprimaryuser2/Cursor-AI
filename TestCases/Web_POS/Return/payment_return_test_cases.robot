*** Settings ***
Library    SeleniumLibrary
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/salesperson_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Return/adhoc_return_keywords.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Library    ../../../Resources/CustomKeywords/utilities.py
Resource    ../../../Resources/Web_POS/POS/Billing/split_payment_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/mode_of_payment_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Order/mode_of_payment_order_keywords.robot
Resource    ../../../Resources/Web_POS/POS/Billing/manual_discount_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Return/payment_return_keywords.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Return${/}payment_return_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Return${/}payment_return_test_data.xlsx
${response}=    'NULL'

*** Test Cases ***
Zwing_O_40 Allow Refund Against Returned Item | Refund Through UPI
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_40
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Return Checkout
    Refund By UPI
    Verify Refund By MOP   ${upi_payment_text}
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}

Zwing_O_41 Allow Refund Against Returned Item | Refund Through Redeem Voucher
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_41
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Return Checkout
    Refund By Redeem Voucher
    Verify Refund By MOP    ${redeem_voucher_payment_text}
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}

Zwing_O_42 Allow Refund Against Returned Item | Refund Through Paytm Card
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_42
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Return Checkout
    Refund By UPI
    Verify Refund By MOP   ${paytm_card_text}
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}

#share invoice
Zwing_O_43 After checkout click on Print Invoice button | Return
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_43
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Add Product By Scan Only   ${mop_data}
    Add Customer Details    ${mop_data}
    ${value}    Get payable amount
    Verify Return Checkout
    Refund By UPI
    Verify Refund By MOP   ${upi_payment_text}
    Automatic Invoice Generation | Return
    Verify The Print Invoice Button
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}

Zwing_O_44 Close the Invoice preview using close button | Return
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_44
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Add Product By Scan Only   ${mop_data}
    Add Customer Details    ${mop_data}
    ${value}    Get payable amount
    Verify Return Checkout
    Refund By UPI
    Verify Refund By MOP   ${upi_payment_text}
    Automatic Invoice Generation | Return
    Verify The Print Invoice Button
    Verify The Close Invoice Button | Return
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}

Zwing_SI_45 Click on share invoice button to open share invoice popup
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_45
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Add Product By Scan Only   ${mop_data}
    Add Customer Details    ${mop_data}
    ${value}    Get payable amount
    Verify Return Checkout
    Refund By UPI
    Automatic Invoice Generation | Return
    Verify The Share Invoice Button
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}

Zwing_SI_46 Close share invoice pop up using X button
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_46
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Add Product By Scan Only   ${mop_data}
    Add Customer Details    ${mop_data}
    ${value}    Get payable amount
    Verify Return Checkout
    Refund By UPI
    Automatic Invoice Generation | Return
    Verify The Share Invoice Button
    Verify The Close Icon | Share Invoice | Return
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}

Zwing_SI_47 Navigate from email id tab to phone No. tab and vice versa in share invoice popup
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_47
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Add Product By Scan Only   ${mop_data}
    Add Customer Details    ${mop_data}
    ${value}    Get payable amount
    Verify Return Checkout
    Refund By UPI
    Automatic Invoice Generation | Return
    Verify The Share Invoice Button
    Navigate from email id tab to phone No. tab  ${mop_data}
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}

Zwing_SI_48 Validate the phone No. should get auto populated with the no. tagged while customer tagging
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_48
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Add Product By Scan Only   ${mop_data}
    Add Customer Details    ${mop_data}
    ${value}    Get payable amount
    Verify Return Checkout
    Refund By UPI
    Automatic Invoice Generation | Return
    Verify The Share Invoice Button
    Verify Customer Number Is Auto-Populated | Share Invoice
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}

Zwing_SI_49 Validate the Email address should get auto populated with the Email id tagged while customer tagging
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_49
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Add Product By Scan Only   ${mop_data}
    Add Customer Details    ${mop_data}
    ${value}    Get payable amount
    Verify Return Checkout
    Refund By UPI
    Automatic Invoice Generation | Return
    Verify The Share Invoice Button
    Verify Customer Email Is Auto-Populated | Share Invoice   ${mop_data}
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}

Zwing_SI_50 Update the phone No. while sharing the Invoice
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_50
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Add Product By Scan Only   ${mop_data}
    Add Customer Details    ${mop_data}
    ${value}    Get payable amount
    Verify Return Checkout
    Refund By UPI
    Automatic Invoice Generation | Return
    Verify The Share Invoice Button
    Update The Phone No. While Sharing The Invoice  ${mop_data}
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}

Zwing_SI_51 While updating the phoneNo, send button should be disabled and error message should be displayed if phoneNo is not of 10 characters
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_51
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Add Product By Scan Only   ${mop_data}
    Add Customer Details    ${mop_data}
    ${value}    Get payable amount
    Verify Return Checkout
    Refund By UPI
    Automatic Invoice Generation | Return
    Verify The Share Invoice Button
    Verify Alert Message Is Displayed For Invalid Number | Share Invoice   ${mop_data}
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}

Zwing_SI_52 Update the Email address while sharing the Invoice
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_52
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Add Product By Scan Only   ${mop_data}
    Add Customer Details    ${mop_data}
    ${value}    Get payable amount
    Verify Return Checkout
    Refund By UPI
    Automatic Invoice Generation | Return
    Verify The Share Invoice Button
    Update The Email While Sharing The Invoice  ${mop_data}
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}

Zwing_SI_53 While updating the Email address, send button should be disabled and error message should be displayed if emailId is not valid. Valid format.
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_53
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Add Product By Scan Only   ${mop_data}
    Add Customer Details    ${mop_data}
    ${value}    Get payable amount
    Verify Return Checkout
    Refund By UPI
    Automatic Invoice Generation | Return
    Verify The Share Invoice Button
    Verify Alert Message Is Displayed For Invalid Email | Share Invoice  ${mop_data}
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}

Zwing_SI_54 Send Invoice using email Id.
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_54
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Add Product By Scan Only   ${mop_data}
    ${store_name}  Get Store Name | Web POS
    Add Customer Details | Share Invoice    ${mop_data}
    ${value}    Get payable amount
    Verify Return Checkout
    Refund By UPI
    ${cust_info_checkout}  Automatic Invoice Generation | Return
    Verify The Share Invoice Button
    Verify Customer Email Is Auto-Populated | Share Invoice   ${mop_data}
    Send Invoice To Email | Share Invoice
    Verify Invoice Generated Received On Email  ${store_name}    ${cust_info_checkout}
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}

Zwing_SI_55 Navigate to billing page using new bill button on checkout page
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_55
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Add Product By Scan Only   ${mop_data}
    Add Customer Details | Share Invoice    ${mop_data}
    ${value}    Get payable amount
    Verify Return Checkout
    Refund By UPI
    Automatic Invoice Generation | Return
    Verify New Bill Button | Return
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}

Zwing_SI_56 Update the Email address while sharing the Invoice and send invoice
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=    Fetch Testdata By Id    ${POS_TD}    TC_56
    ${response}     Login With Valid Username And Password | POS       ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Add Product By Scan Only   ${mop_data}
    ${store_name}  Get Store Name | Web POS
    Add Customer Details | Share Invoice    ${mop_data}
    ${value}    Get payable amount
    Verify Return Checkout
    Refund By UPI
    ${cust_info_checkout}  Automatic Invoice Generation | Return
    Verify The Share Invoice Button
    Update The Email While Sharing The Invoice  ${mop_data}
    Send Invoice To Email | Share Invoice
    Verify Invoice Generated Received On Email  ${store_name}    ${cust_info_checkout}
    [Teardown]    Revoke Licence Key | API   ${response}         ${mop_data}
