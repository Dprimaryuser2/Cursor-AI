*** Settings ***
Library    SeleniumLibrary
Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/promo_keyword.robot
Resource    ../../../Resources/Web_POS/POS/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/mode_of_payment_keyword.robot
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

Zwing_MOP_17 Collecting Payment by Redeem Store Credit using voucher code | Partially Redemption Allowed
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_17
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Collect Payment Using Store Credit
#    Verify Partial Redemption Allowed
    Verify If Payment Is Complete Or Not
    Verify Successful Payment    ${value}    ${customer_details}

Zwing_MOP_18 Collecting Payment by Redeem Store Credit using voucher | Partially Redemption is not Allowed
    ${mop_data}=    Fetch Testdata By Id    ${MOP_TD}    TC_18
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Collect Payment Using Store Credit | Partial Redemption Not Allowed
