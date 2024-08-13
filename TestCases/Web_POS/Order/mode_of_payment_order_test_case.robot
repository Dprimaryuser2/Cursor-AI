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
Resource    ../../../Resources/Web_POS/POS/Order/mode_of_payment_order_keywords.robot
Resource    ../../../Resources/Web_POS/POS/Order/customer_tagging_order_keyword.robot
Variables   ../../../PageObjects/Web_POS/POS/order_locators.py

Test Setup    Open Application | POS
Test Teardown   Close Browser

#*** Variables ***
#${MOP_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Order${/}mode_of_payment_order_test_data.xlsx

*** Variables ***
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Order${/}mode_of_payment_order_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Order${/}mode_of_payment_order_test_data.xlsx

*** Test Cases ***
Zwing_O_96 Customer Paid amount equal to payable amount
    [Tags]    retry
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_96
     Login With Valid Username And Password | POS   ${mop_data}
     Open The Session    ${mop_data}
     Change Billing Mode    ${mop_data}
     Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
     ${customer_details}    Add Customer Details    ${mop_data}
     ${value}    Get Payable Amount
     Verify Billing Checkout
     Payment By Cash    ${value}
     Verify If Payment Is Complete Or Not | Order
     Verify Successful Payment | Order    ${value}    ${customer_details}
     Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_O_97 Customer Paid amount less than to payable amount(continue button remains disabled)
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_97
     Login With Valid Username And Password | POS   ${mop_data}
     Open The Session    ${mop_data}
     Change Billing Mode    ${mop_data}
     Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
     ${customer_details}    Add Customer Details    ${mop_data}
     ${value}    Get Payable Amount
     Verify Billing Checkout
     Collecting Payment Through Cash | Less Than Payable Amount    ${value}
     Verify Continue Button Is Disabled
     Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_O_98 Customer Paid amount more than to payable amount
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_98
     Login With Valid Username And Password | POS   ${mop_data}
     Open The Session    ${mop_data}
     Change Billing Mode    ${mop_data}
     Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
     ${customer_details}    Add Customer Details    ${mop_data}
     ${value}    Get Payable Amount
     Verify Billing Checkout
     Collecting Payment Through Cash | More Than Payable Amount    ${value}
     Verify If Payment Is Complete Or Not | Order
     Verify Successful Payment | Order    ${value}    ${customer_details}
     Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

#Zwing_O_99 Redeem Store Credit Against Mobile Number

Zwing_O_100 Redeem Store Credit using Vouhcer Code
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_100
     Login With Valid Username And Password | POS   ${mop_data}
     Open The Session    ${mop_data}
     Change Billing Mode    ${mop_data}
     Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
     ${customer_details}    Add Customer Details    ${mop_data}
     ${value}    Get Payable Amount
     Verify Billing Checkout
     Collect Payment Using Store Credit    ${mop_data}
     Verify If Payment Is Complete Or Not | Order
     Verify Successful Payment | Order    ${value}    ${customer_details}
     Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}


Zwing_O_101 Collecting Payment by Redeem Store Credit using voucher code | Partially Redemption Allowed
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_101
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Collect Payment Using Store Credit | Partial Redemption Allowed    ${mop_data}
    Verify Partial Redemption Allowed | Order
    Verify If Payment Is Complete Or Not | Order
    Verify Successful Payment | Order    ${value}    ${customer_details}
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_O_102 Collecting Payment by Redeem Store Credit using voucher | Partially Redemption is not Allowed
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_102
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Collect Payment Using Store Credit | Partial Redemption Not Allowed    ${mop_data}
    Verify Partial Redemption Not Allowed
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

#Zwing_O_103 Collecting Paymnet by Redeem Store Credit using mobile number | Partially Redeemption Allowed
#Zwing_O_104 Collecting Paymnet by Redeem Store Credit using mobile number | Partially Redeemption not Allowed
#Zwing_O_105 Redeem Store Credit against Mobile Number | OTP Authentication is allowed

Zwing_O_106 Payment by using on Account Sale
    [Tags]    Valid Failure
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_106
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Collect Payment Via On Account Sale
    Verify If Payment Is Complete Or Not | Order
    Verify Successful Payment | Order    ${value}    ${customer_details}
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_O_107 Payment by using on Account Sale | Account Balance is Greater or Equal to payable amount
    [Tags]    Valid Failure
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_107
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Collect Payment Via On Account Sale
    Verify If Payment Is Complete Or Not | Order
    Verify Successful Payment | Order    ${value}    ${customer_details}
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_O_108 Payment by using on Account Sale | Account Balance is less than payable amount
    [Tags]    Valid Failure
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_108
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Unable To Pay Via On Account Sale With Less Account Balance
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}


Zwing_O_109 Additional MOP's | Validate additional MOP's available
    [Tags]    retry
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_109
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment Via Additional MOP
    Verify If Payment Is Complete Or Not | Order
    Verify Successful Payment | Order    ${value}    ${customer_details}
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_O_110 Clicking on a MOP should open a popup to enter transaction reference id
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_110
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Additional MOP Reference Id Popup
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_O_111 Additional MOP's | Enter transaction id
     [Tags]    retry
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_111
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Entered Transaction ID | Order
    Verify Successful Payment | Order    ${value}    ${customer_details}
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_O_112 Validate the amount auto-populated in customer paid field
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_112
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Additional MOP Reference Id Popup
#    Verify Amount AutoPopulated    ${value}
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_O_113 Close the transaction reference id popup using X button
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_113
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Additional MOP Reference Id Popup
    Close The Transaction Popup
    Verify Close (X) Button Of Transaction Id
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_O_114 Customer paid field should be non - editable
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_114
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Verify Additional MOP Reference Id Popup
    Verify Customer Paid Field Is Non-editable
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_O_115 Complete payment by clicking on continue button, without entering transaction reference id.
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_115
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Complete Payment Without Reference ID
    Verify If Payment Is Complete Or Not | Order
    Verify Successful Payment | Order    ${value}    ${customer_details}
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

Zwing_O_116 complete payment by clicking on continue button after entering transaction reference id.
    ${MOP_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${mop_data}=  Fetch Testdata By Id   ${MOP_TD}    TC_116
    Login With Valid Username And Password | POS   ${mop_data}
    Open The Session    ${mop_data}
    Change Billing Mode    ${mop_data}
    Scan Barcode To Add Item And Quantity To Cart    ${mop_data}
    ${customer_details}    Add Customer Details    ${mop_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment Via Additional MOP
    Verify If Payment Is Complete Or Not | Order
    Verify Successful Payment | Order    ${value}    ${customer_details}
    Revoke Serial Key    ${mop_data}
    [Teardown]    Tear It Down If Test Case Failed    ${mop_data}

#Zwing_O_117 Collecting Payment by Redeem Store Credit using phone number by Resend OTP
#Zwing_O_118 Collecting Payment by Redeem Store Credit using phone number | Remove Voucher
