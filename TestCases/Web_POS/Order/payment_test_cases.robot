*** Settings ***
Library    SeleniumLibrary
Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/mode_of_payment_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Resource    ../../../Resources/Web_POS/POS/Order/payment_keywords.robot
Resource    ../../../Resources/Web_POS/POS/Billing/keyboard_shortcut_keywords.robot
#Resource    ../../../Resources/Web_POS/POS/split_payment_keyword.robot

Test Setup    Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Order${/}order_payment_test_data.xlsx

*** Test Cases ***
Zwing_O_P_89 Delivery Fulfillment option while its mandatory from policy
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_89
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Set Fulfillment Date And Continue
     Verify Delivery Fulfillment
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_90 Delivery Fulfillment option while its non mandatory from policy
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_90
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Set Fulfillment Date And Continue
     Verify Delivery Fulfillment
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_91 Allow to place Order without payment
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_91
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Set Fulfillment Date And Continue
     Verify Order Can Be Placed Without Payment
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_92 Set Minimum Value in Amount
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_92
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Set Fulfillment Date And Continue
     Place Order With Minimum Amount
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_93 Set Minimum Percentage Value
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_93
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Set Fulfillment Date And Continue
     Place Order With Minimum Amount
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_94 Both Minimum value in Amount and Percentage Value is configured
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_94
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Set Fulfillment Date And Continue
     Place Order With Minimum Amount
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_95 Both Minimum value in Amount and Percentage Value is Zero But Advance Collection is Mandatory
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_95
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Set Fulfillment Date And Continue
     Verify Order Can Be Placed Without Payment
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_119 Block order if the Ordered Product's Inventory is negative | Alert Message while inventory is not sufficient
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_119
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Verify Insufficient Inventory Buttons
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}


Zwing_O_P_120 Block order if the Ordered Product's Inventory is negative | Alert Message while inventory is not sufficient, cancel the message
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_120
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Verify Insufficient Inventory Buttons
     Cancel Insufficient Inventory Popup
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_121 Block order if the Ordered Product's Inventory is negative | Alert Message while inventory is not sufficient, continue the message
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_121
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Set Fulfillment Date And Continue
     Verify Delivery Fulfillment
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_122 Block order if the Ordered Product's Inventory is negative | Order Blocking while, order is being created
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_122
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Set Fulfillment Date And Continue
     Verify Delivery Fulfillment
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}
