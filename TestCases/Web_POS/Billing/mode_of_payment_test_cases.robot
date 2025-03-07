*** Settings ***
Library    SeleniumLibrary
Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/mode_of_payment_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Resource    ../../../Resources/Web_POS/POS/Billing/split_payment_keyword.robot

Test Setup    Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Billing${/}mode_of_payment_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Billing${/}mode_of_payment_test_data.xlsx
${response}=    'NULL'

*** Test Cases ***
Zwing_MOP_1 Customer Paid amount equal to payable amount
     [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_01
    ${response}=  Login With Valid Username And Password | POS   ${mop_data}
     Open The Session    ${mop_data}
     Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
     ${customer_details}    Add Customer Details    ${mop_data}
     ${value}    Get Payable Amount
     Verify Billing Checkout
     Payment By Cash    ${value}
     Verify If Payment Is Complete Or Not
     Verify Successful Payment    ${value}    ${customer_details}
     [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}

Zwing_MOP_2 Customer Paid amount less than to payable amount(continue button remains disabled)
    [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_02
    ${response}=  Login With Valid Username And Password | POS   ${mop_data}
     Open The Session    ${mop_data}
     Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
     ${customer_details}    Add Customer Details    ${mop_data}
     ${value}    Get Payable Amount
     Verify Billing Checkout
     Collecting Payment Through Cash | Less Than Payable Amount    ${value}
     Verify Continue Button Is Disabled
     [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}

Zwing_MOP_3 Customer Paid amount more than to payable amount
     [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_03
    ${response}=  Login With Valid Username And Password | POS   ${mop_data}
     Open The Session    ${mop_data}
     Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
     ${customer_details}    Add Customer Details    ${mop_data}
     ${value}    Get Payable Amount
     Verify Billing Checkout
     Collecting Payment Through Cash | More Than Payable Amount    ${value}
     Verify If Payment Is Complete Or Not
     Verify Successful Payment    ${value}    ${customer_details}
     [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}

#Zwing_MOP_4 Redeem Voucher against mobile Number  #OTP Required

#Zwing_MOP_5 Redeem Voucher by scanning or entering the voucher Code

#Zwing_MOP_6 Redeem Voucher by scanning or entering the voucher Wrong Voucher Code

#Zwing_MOP_7 "Redeem Voucher by scanning or entering the voucher Voucher value is more than Payable amount

#Zwing_MOP_8 Redeem Voucher by scanning or entering the voucher 1) Voucher value is more than Payable amount

#Zwing_MOP_9 Redeem Voucher by scanning or entering the voucher Voucher value is less than Payable amount (Gift voucher should sold)

#Zwing_MOP_10 Gift Voucher need to sold against mobile number OTP authentication is required

#Zwing_MOP_15 Store Credit should be against the mobile number

Zwing_MOP_16 Redeem Store Credit using Voucher Code
    [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_16
    ${response}=  Login With Valid Username And Password | POS   ${mop_data}
     Open The Session    ${mop_data}
     Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
     ${customer_details}    Add Customer Details    ${mop_data}
     ${value}    Get Payable Amount
     Verify Billing Checkout
     Collect Payment Using Store Credit    ${mop_data}
     Verify If Payment Is Complete Or Not
     Verify Successful Payment    ${value}    ${customer_details}
     [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}

Zwing_MOP_17 Collecting Payment by Redeem Store Credit using voucher code | Partially Redemption Allowed
    [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_17
   ${response}=  Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Collect Payment Using Store Credit | Partial Redemption Allowed    ${mop_data}
    Verify Partial Redemption Allowed
    Verify If Payment Is Complete Or Not
    Verify Successful Payment    ${value}    ${customer_details}
    [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}

Zwing_MOP_18 Collecting Payment by Redeem Store Credit using voucher | Partially Redemption is not Allowed
    [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_18
   ${response}=  Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Collect Payment Using Store Credit | Partial Redemption Not Allowed    ${mop_data}
    Verify Partial Redemption Not Allowed
    [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}

#Zwing_MOP_19 Collecting Paymnet by Redeem Store Credit using mobile number | Partially Redeemption Allowed

#Zwing_MOP_20 Collecting Paymnet by Redeem Store Credit using mobile number | Partially Redeemption not Allowed

#Zwing_MOP_21 Redeem Store Credit against Mobile Number | OTP Authentication is allowed

Zwing_MOP_22 Payment by using on Account Sale
    [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_22
   ${response}=  Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Collect Payment Via On Account Sale
    Verify If Payment Is Complete Or Not
    Verify Successful Payment    ${value}    ${customer_details}
    [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}

Zwing_MOP_23 Payment by using on Account Sale | Account Balance is Greater or Equal to payable amount
    [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_23
   ${response}=  Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Collect Payment Via On Account Sale
    Verify If Payment Is Complete Or Not
    Verify Successful Payment    ${value}    ${customer_details}
    [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}

Zwing_MOP_24 Payment by using on Account Sale | Account Balance is less than payable amount
    [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_24
   ${response}=  Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Unable To Pay Via On Account Sale With Less Account Balance
    [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}


Zwing_MOP_25 Additional MOP's | Validate additional MOP's available.
    [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_25
   ${response}=  Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment Via Additional MOP
    Verify If Payment Is Complete Or Not
    Verify Successful Payment    ${value}    ${customer_details}
    [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}

Zwing_MOP_26 Clicking on a MOP should open a popup to enter transaction reference id
    [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_26
   ${response}=  Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Additional MOP Reference Id Popup
    [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}

Zwing_MOP_27 Additional MOP's | Enter transaction id
    [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_27
   ${response}=  Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Entered Transaction ID
    Verify Successful Payment    ${value}    ${customer_details}
    [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}

Zwing_MOP_28 Validate the amount auto-populated in customer paid field.
    [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_28
   ${response}=  Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Additional MOP Reference Id Popup
#    Verify Amount AutoPopulated    ${value}
    [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}

Zwing_MOP_29 Close the transaction reference id popup using X button.
    [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_29
   ${response}=  Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Additional MOP Reference Id Popup
    Close The Transaction Popup
    Verify Close (X) Button Of Transaction Id
    [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}

Zwing_MOP_30 Customer paid field should be non - editable
    [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_30
   ${response}=  Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Additional MOP Reference Id Popup
    Verify Customer Paid Field Is Non-editable
    [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}

Zwing_MOP_31 Complete payment by clicking on continue button, without entering transaction reference id
    [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_31
   ${response}=  Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Complete Payment Without Reference ID
    Verify If Payment Is Complete Or Not
    Verify Successful Payment    ${value}    ${customer_details}
    [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}

Zwing_MOP_32 complete payment by clicking on continue button after entering transaction reference id.
    [Tags]    test:retry(1)
     ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}     TC_32
   ${response}=  Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment Via Additional MOP
    Verify If Payment Is Complete Or Not
    Verify Successful Payment    ${value}    ${customer_details}
    [Teardown]    Revoke Licence Key | API   ${response}      ${mop_data}