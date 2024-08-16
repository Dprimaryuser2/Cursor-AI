*** Settings ***
Library    SeleniumLibrary
Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/mode_of_payment_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Order/mode_of_payment_order_keywords.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Resource    ../../../Resources/Web_POS/POS/Order/payment_keywords.robot
Resource    ../../../Resources/Web_POS/POS/Billing/keyboard_shortcut_keywords.robot
Resource    ../../../Resources/Web_POS/POS/Billing/salesperson_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Order/salesperson_tagging_order_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Order/order_options_keywords.robot

Test Setup    Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Order${/}order_option_test_data.xlsx

*** Test Cases ***
Zwing_O_130 Check condintions before confirming the order
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_130
    ${response}    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Assign A Salesperson All Items | Order    ${pos_data}
    Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
    Payment By Paytm   ${value}
    Verify Stock Not Available alert | Order Created | Advance Payment On
    [Teardown]    Revoke Licence Key | API   ${response}    ${pos_data}

Zwing_O_131 Confirmation message
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_131
     ${response}    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${value}    Get payable amount
    Assign A Salesperson All Items | Order    ${pos_data}
    Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not | Order
    Navigate To Order Confirmation Page From Checkout Page
    Verify Order Confirm Alert
    [Teardown]    Revoke Licence Key | API   ${response}    ${pos_data}

#Zwing_O_132 Order Review before confirming the order
#    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_132
#    ${response}    Login With Valid Username And Password | POS   ${pos_data}
#    Open The Session    ${pos_data}
#    Change Billing Mode    ${pos_data}
#    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#    ${value}    Get payable amount
#    Add Customer Details    ${pos_data}
#    Assign A Salesperson All Items | Order    ${pos_data}
#    Apply Item Promo | Manual
#    Verify Promo Discount In Cart | POS
#    Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
##    [Teardown]    Revoke Licence Key | API   ${response}    ${pos_data}

Zwing_O_133 Confirming the order without reveiwing
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_133
    ${response}    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${value}    Get payable amount
    Assign A Salesperson All Items | Order    ${pos_data}
    Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
    Payment By Cash    ${value}
    Navigate To Order Confirmation Page From Order Summary Page
#    Verify Redirection To Order Confirmation Page
    Verify Order Confirm Alert
    [Teardown]    Revoke Licence Key | API   ${response}    ${pos_data}

Zwing_O_137 Collect pending amount of total payable | Taken advance should be less than payable amount or zero
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_137
     ${response}    Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get Payable Amount
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Enable Split payment mode
     ${payable_amount}  Enter 10 Percent Amount In Payable Amount  ${value}
     Payment By Cash Less Than Payable Amount     ${payable_amount}
     Verify Continue Button Is Disabled
     [Teardown]    Revoke Licence Key | API   ${response}    ${pos_data}

Zwing_O_138 Collect pending amount using split payment
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_138
     ${response}    Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get Payable Amount
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Enable Split payment mode
     ${payable_amount}  Enter 10 Percent Amount In Payable Amount  ${value}
     Payment By Cash   ${payable_amount}
     Verify Redirection To Checkout Page After Advance Payment
     ${due_amount}  Get Amount From Payable Amount After Partial Payment
     Payment By Cash   ${due_amount}
     Verify If Payment Is Complete Or Not After Full Payment | Order
     Verify Successful Payment After Full Payment| Order    ${value}
     [Teardown]    Revoke Licence Key | API   ${response}    ${pos_data}

Zwing_O_139 Collected amount need to reflect in bill summary
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_139
     ${response}    Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get Payable Amount
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Enable Split payment mode
     ${payable_amount}  Enter 10 Percent Amount In Payable Amount  ${value}
     Payment By Cash   ${payable_amount}
     Verify Redirection To Checkout Page After Advance Payment
     ${due_amount}  Get Amount From Payable Amount After Partial Payment
     Payment By Cash   ${payable_amount}
     Verify Redirection To Checkout Page After Advance Payment
     ${due_amount}  Get Amount From Payable Amount After Partial Payment
     Payment By Cash   ${due_amount}
     Verify If Payment Is Complete Or Not After Full Payment | Order
     [Teardown]    Revoke Licence Key | API   ${response}    ${pos_data}

Zwing_O_140 Collected amount could be removal and removed amount will refelct on payable amount
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_140
     ${response}    Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_details}    Add Customer Details    ${pos_data}
     ${value}    Get Payable Amount
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Enable Split payment mode
     ${payable_amount}  Enter 10 Percent Amount In Payable Amount  ${value}
     Payment By Cash   ${payable_amount}
     Verify Redirection To Checkout Page After Advance Payment
     ${due_amount}  Get Amount From Payable Amount After Partial Payment
     Payment By Cash   ${due_amount}
     Verify If Payment Is Complete Or Not After Full Payment | Order
     Verify Successful Payment After Full Payment| Order    ${value}
     [Teardown]    Revoke Licence Key | API   ${response}    ${pos_data}

Zwing_O_141 Re-Print Order Receipt
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_141
     ${response}    Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Add Customer Details   ${pos_data}
     ${value}   Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Payment By Cash   ${value}
     Verify If Payment Is Complete Or Not | Order
     Navigate To Print Recipt Container
     ${order_number}  Get Order Number
     Navigate To Order Management And Redirect To Checkout Page Using Order Number      ${order_number}
     ${cust_info_checkout}  Verify Recipt Content | Order
     ${cust_info_invoice}   Get Customer Details | Print Invoice | Order
     Verify Customer Details | Print Invoice  ${cust_info_checkout}    ${cust_info_invoice}
     [Teardown]    Revoke Licence Key | API   ${response}    ${pos_data}

Zwing_O_142 Cancel Order if advance is already paid, need to refund
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_142
     ${response}    Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get Payable Amount
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Enable Split payment mode
     ${payable_amount}  Enter 10 Percent Amount In Payable Amount  ${value}
     Payment By Cash   ${payable_amount}
     Navigate To Order Summary Page From Checkout Page
     Verify If Payment Is Complete Or Not | Order
     Navigate To Print Recipt Container
     ${order_number}  Get Order Number
     Navigate To Order Management And Redirect To Checkout Page Using Order Number      ${order_number}
     Cancel Order
     Verify Discard Order Popup With Different Method | Cancel Order Popup    ${cash_cancel_order_popup}
     [Teardown]    Revoke Licence Key | API   ${response}    ${pos_data}

Zwing_O_144 Refund by Cash
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_144
     ${response}    Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get Payable Amount
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Enable Split payment mode
     ${payable_amount}  Enter 10 Percent Amount In Payable Amount  ${value}
     Payment By Cash   ${payable_amount}
     Navigate To Order Summary Page From Checkout Page
     Verify If Payment Is Complete Or Not | Order
     Navigate To Print Recipt Container
     ${order_number}  Get Order Number
     Navigate To Order Management And Redirect To Checkout Page Using Order Number      ${order_number}
     Cancel Order
     Verify Discard Order Popup With Different Method | Cancel Order Popup    ${cash_cancel_order_popup}
      [Teardown]    Revoke Licence Key | API   ${response}    ${pos_data}

Zwing_O_145 Refund by Credit note
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_145
     ${response}    Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get Payable Amount
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Enable Split payment mode
     ${payable_amount}  Enter 10 Percent Amount In Payable Amount  ${value}
     Payment By Cash   ${payable_amount}
     Navigate To Order Summary Page From Checkout Page
     Verify If Payment Is Complete Or Not | Order
     Navigate To Print Recipt Container
     ${order_number}  Get Order Number
     Navigate To Order Management And Redirect To Checkout Page Using Order Number      ${order_number}
     Cancel Order
     Verify Discard Order Popup With Different Method | Cancel Order Popup    ${store_credit_cancel_order_popup}
      [Teardown]    Revoke Licence Key | API   ${response}    ${pos_data}
