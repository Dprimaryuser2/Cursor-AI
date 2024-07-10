*** Settings ***
Library    SeleniumLibrary
Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/promo_keyword.robot
Resource    ../../../Resources/Web_POS/POS/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/mode_of_payment_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
#Resource    ../../../Resources/Web_POS/POS/split_payment_keyword.robot

Test Setup    Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${MOP_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}mode_of_payment_test_data.xlsx

*** Test Cases ***
Zwing_MOP_1 Customer Paid amount equal to payable amount
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_01
     Login With Valid Username And Password | POS   ${mop_data}
     Open The Session    ${mop_data}
     Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
     ${customer_details}    Add Customer Details    ${mop_data}
     ${value}    Get Payable Amount
     Verify Billing Checkout
     Payment By Cash    ${value}
     Verify If Payment Is Complete Or Not
     Verify Successful Payment    ${value}    ${customer_details}
     Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_MOP_2 Customer Paid amount less than to payable amount(continue button remains disabled)
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_02
     Login With Valid Username And Password | POS   ${mop_data}
     Open The Session    ${mop_data}
     Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
     ${customer_details}    Add Customer Details    ${mop_data}
     ${value}    Get Payable Amount
     Verify Billing Checkout
     Collecting Payment Through Cash | Less Than Payable Amount    ${value}
     Verify Continue Button Is Disabled
     Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_MOP_3 Customer Paid amount more than to payable amount
     ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_03
     Login With Valid Username And Password | POS   ${mop_data}
     Open The Session    ${mop_data}
     Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
     ${customer_details}    Add Customer Details    ${mop_data}
     ${value}    Get Payable Amount
     Verify Billing Checkout
     Collecting Payment Through Cash | More Than Payable Amount    ${value}
     Verify If Payment Is Complete Or Not
     Verify Successful Payment    ${value}    ${customer_details}
     Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

#Zwing_MOP_4 Redeem Voucher against mobile Number  #OTP Required

#Zwing_MOP_5 Redeem Voucher by scanning or entering the voucher Code

#Zwing_MOP_6 Redeem Voucher by scanning or entering the voucher Wrong Voucher Code

#Zwing_MOP_7 "Redeem Voucher by scanning or entering the voucher Voucher value is more than Payable amount

#Zwing_MOP_8 Redeem Voucher by scanning or entering the voucher 1) Voucher value is more than Payable amount

#Zwing_MOP_9 Redeem Voucher by scanning or entering the voucher Voucher value is less than Payable amount (Gift voucher should sold)

#Zwing_MOP_10 Gift Voucher need to sold against mobile number OTP authentication is required

#Zwing_MOP_15 Store Credit should be against the mobile number

Zwing_MOP_16 Redeem Store Credit using Voucher Code
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_16
     Login With Valid Username And Password | POS   ${mop_data}
     Open The Session    ${mop_data}
     Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
     ${customer_details}    Add Customer Details    ${mop_data}
     ${value}    Get Payable Amount
     Verify Billing Checkout
     Collect Payment Using Store Credit    ${mop_data}
     Verify If Payment Is Complete Or Not
     Verify Successful Payment    ${value}    ${customer_details}
     Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_MOP_17 Collecting Payment by Redeem Store Credit using voucher code | Partially Redemption Allowed
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_17
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Collect Payment Using Store Credit | Partial Redemption Allowed    ${mop_data}
    Verify Partial Redemption Allowed
    Verify If Payment Is Complete Or Not
    Verify Successful Payment    ${value}    ${customer_details}
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_MOP_18 Collecting Payment by Redeem Store Credit using voucher | Partially Redemption is not Allowed
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_18
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Collect Payment Using Store Credit | Partial Redemption Not Allowed    ${mop_data}
    Verify Partial Redemption Not Allowed
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

#Zwing_MOP_19 Collecting Paymnet by Redeem Store Credit using mobile number | Partially Redeemption Allowed

#Zwing_MOP_20 Collecting Paymnet by Redeem Store Credit using mobile number | Partially Redeemption not Allowed

#Zwing_MOP_21 Redeem Store Credit against Mobile Number | OTP Authentication is allowed

Zwing_MOP_22 Payment by using on Account Sale
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_22
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Collect Payment Via On Account Sale
    Verify If Payment Is Complete Or Not
    Verify Successful Payment    ${value}    ${customer_details}
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_MOP_23 Payment by using on Account Sale | Account Balance is Greater or Equal to payable amount
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_23
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Collect Payment Via On Account Sale
    Verify If Payment Is Complete Or Not
    Verify Successful Payment    ${value}    ${customer_details}
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_MOP_24 Payment by using on Account Sale | Account Balance is less than payable amount
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_24
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Unable To Pay Via On Account Sale With Less Account Balance
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}


Zwing_MOP_25 Additional MOP's | Validate additional MOP's available.
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_25
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment Via Additional MOP
    Verify If Payment Is Complete Or Not
    Verify Successful Payment    ${value}    ${customer_details}
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_MOP_26 Clicking on a MOP should open a popup to enter transaction reference id
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_26
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment Via Additional MOP
    Verify Additional MOP Reference Id Popup
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_MOP_27 Additional MOP's | Enter transaction id
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_27
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Additional MOP Reference Id Popup
    Verify Entered Transaction ID
    Verify Successful Payment    ${value}    ${customer_details}
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_MOP_28 Validate the amount auto-populated in customer paid field.
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_28
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Additional MOP Reference Id Popup
#    Verify Amount AutoPopulated    ${value}
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_MOP_29 Close the transaction reference id popup using X button.
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_29
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Additional MOP Reference Id Popup
    Close The Transaction Popup
    Verify Close (X) Button Of Transaction Id
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_MOP_30 Customer paid field should be non - editable
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_30
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Additional MOP Reference Id Popup
    Verify Customer Paid Field Is Non-editable
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_MOP_31 Complete payment by clicking on continue button, without entering transaction reference id
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_31
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Complete Payment Without Reference ID
    Verify If Payment Is Complete Or Not
    Verify Successful Payment    ${value}    ${customer_details}
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_MOP_32 complete payment by clicking on continue button after entering transaction reference id.
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_32
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment Via Additional MOP
    Verify If Payment Is Complete Or Not
    Verify Successful Payment    ${value}    ${customer_details}
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}