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
Resource    ../../../Resources/Web_POS/POS/Order/order_options_keywords.robot
#Resource    ../../../Resources/Web_POS/POS/split_payment_keyword.robot

Test Setup    Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Order${/}order_payment_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Order${/}order_payment_test_data.xlsx
${response}=    'NULL'

*** Test Cases ***
Zwing_O_P_84 Allow to place Order without payment
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_84
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Verify Checkout Page Redirection
       [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_85 Set Minimum Value in Amount
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id     ${POS_TD}    O_P_85
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Place Order With Minimum Amount | Continue Button Enabled
       [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_86 Set Minimum Percentage Value
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_86
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Place Order With Minimum Percentage | Continue Button Enabled
       [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_87 Both Minimum value in Amount and Percentage Value is configured | Advance collection is off
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_87
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Verify Order Can Be Placed Without Payment
       [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}


Zwing_O_P_89 Delivery Fulfillment option while its mandatory from policy
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_89
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Verify Order Checkout
     Verify Delivery Fulfillment Popup
      [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_90 Delivery Fulfillment option while its non mandatory from policy
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_90
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Verify Delivery Fulfillment Popup
      [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_91 Allow to place Order without payment
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_91
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Verify Order Can Be Placed Without Payment
      [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_92 Set Minimum Value in Amount
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_92
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Place Order With Minimum Amount
      [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_93 Set Minimum Percentage Value
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_93
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Place Order With Minimum Amount
      [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_94 Both Minimum value in Amount and Percentage Value is configured
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_94
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Place Order With Minimum Amount
      [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_95 Both Minimum value in Amount and Percentage Value is Zero But Advance Collection is Mandatory
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_95
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Verify Order Can Be Placed Without Payment
      [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_119 Block order if the Ordered Product's Inventory is negative | Alert Message while inventory is not sufficient
    [Tags]     test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_119
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Verify Insufficient Inventory Buttons
     [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_120 Block order if the Ordered Product's Inventory is negative | Alert Message while inventory is not sufficient, cancel the message
    [Tags]     test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_120
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}

     Verify Insufficient Inventory Buttons
     Cancel Insufficient Inventory Popup
       [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_121 Block order if the Ordered Product's Inventory is negative | Alert Message while inventory is not sufficient, continue the message
    [Tags]     test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_121
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Verify Checkout Page Redirection
       [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_122 Block order if the Ordered Product's Inventory is negative | Order Blocking while, order is being created
    [Tags]     test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_122
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Add Customer Details    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Verify Stock Not Available Popup | Order Is Created
       [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_123 Block order if the Ordered Product's Inventory is negative | Order Blocking while, order is being confirmed
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_123
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Add Customer Details    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Verify Stock Not Available Popup | Order Is Confirmed
       [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_124 Block order if the Ordered Product's Inventory is negative | Order Blocking while, order is being packed
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_124
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Navigate To Pack Order Page | Order Is Packed
     Scan Barcode To Add Item And Quantity To Cart | Pack Order   ${pos_data}
     Verify Stock Not Available Popup | Order Is Packed
       [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_125 Block order if the Ordered Product's Inventory is negative | Order Blocking while, invoice is getting generated against order
    [Tags]   Valid Failure
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_125
     ${response}   Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Add Customer Details    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Navigate To Pack Order Page | Order Is Packed
     Scan Barcode To Add Item And Quantity To Cart | Pack Order    ${pos_data}
     Verify Invoice Generation When Advance Payment Is Off | When Inovices Is Generated
    [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_126 Add Bill Remark while placing order
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id     ${POS_TD}   O_P_126
    ${response}     Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
    Verify Bill Remark Added Is Visible In Bill Remark Textarea | Order     ${pos_data}
     [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_127 Add Bill Remark while placing order | Save Bill Remark
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_127
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Add Bill Remarks | Order  ${pos_data}
     Verify Bill Remark Added | Order
       [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_128 Add Bill Remark while placing order | Clear bill remark
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_128
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Verify The Clear Button Of Add Bill Remark | Order    ${pos_data}
       [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_129 Check Conditions before placing order | Place Order
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_129
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}   Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Enable Split payment mode
     ${payable_amount}  Enter 10 Percent Amount In Payable Amount  ${value}
     Payment By Cash   ${payable_amount}
     Navigate To Pack Order Page | Order Is Packed
     Scan Barcode To Add Item And Quantity To Cart | Pack Order   ${pos_data}
     Verify Stock Not Available Popup | Order Is Packed
     [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_146 Replace with product with higher value than ordered product
   [Tags]  Valid Failure
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_146
      ${response}   Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Add Customer Details    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Verify Order Can Be Placed Without Payment
     Navigate To Order Confirmation Page From Order Summary Page
     Verify Replace Product | Order Is Packed
     Scan Barcode To Add Item And Quantity To Cart | Replace Product    ${pos_data}
     Verify Product Replace Button Functionality
     [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_147 Replace with product with less value than ordered product
   [Tags]  Valid Failure
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_147
      ${response}   Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Add Customer Details    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Verify Order Can Be Placed Without Payment
     Navigate To Order Confirmation Page From Order Summary Page
     Verify Replace Product | Order Is Packed
     Scan Barcode To Add Item And Quantity To Cart | Replace Product    ${pos_data}
     Verify Product Replace Button Functionality
     [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_148 Replace with product with same value of ordered product
    [Tags]  Valid Failure
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_148
      ${response}   Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Add Customer Details    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Verify Order Can Be Placed Without Payment
     Navigate To Order Confirmation Page From Order Summary Page
     Verify Replace Product | Order Is Packed
     Scan Barcode To Add Item And Quantity To Cart | Replace Product    ${pos_data}
     Verify Product Replace Button Functionality
     [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_149 Discard product from order | Refund to pay if advance taken for discarded product
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_149
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Enable Split payment mode
     Split Payment By Paytm  ${value}
     Verify If Payment Is Complete Or Not | Order
     Navigate To Discard Order Popup | Discard Order
     Verify Discard Order Popup
       [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_150 Discard product from order | Refund to pay if advance taken for discarded product | Refund Initiated by cash
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_150
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Enable Split payment mode
     Split Payment By Paytm  ${value}
     Verify If Payment Is Complete Or Not | Order
     Navigate To Discard Order Popup | Discard Order
     Verify Discard Order Popup With Different Method    ${cash_button_discard_popup}
       [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_151 Discard product from order | Refund to pay if advance taken for discarded product | Refund Initiated by credit note
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_151
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Enable Split payment mode
     Split Payment By Paytm  ${value}
     Verify If Payment Is Complete Or Not | Order
     Navigate To Discard Order Popup | Discard Order
     Verify Discard Order Popup With Different Method    ${store_credit_button_discard_popup}
       [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_152 Discard product from order | If advance is not taken for discarded product, no need to initiate refund
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id      ${POS_TD}   O_P_152
     ${response}     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
     Navigate To Discard Order Popup | Discard Order
     Verify Discard Product | No Advance Payment
       [Teardown]  Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_P_O_162 Set variance limit and enter price override less or more than total price but within variance limit
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id     ${POS_TD}   O_P_162
   ${response}     Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Price Overridden | Billing
   [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_P_O_163 Set variance limit and enter price override less or more than total price but out of variance limit
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id     ${POS_TD}  O_P_163
   ${response}     Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Alert Message for Price Overridden | Billing
   [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_164 Set variance limit and enter price override less or more than total price but equal to variance limit
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id     ${POS_TD}   O_P_164
   ${response}     Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Price Overridden | Billing
   [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_165 Set variance limit and enter price override less or more than total price but within variance limit. Then try again price override and check the response
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id     ${POS_TD}     O_P_165
   ${response}     Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Price Override Link Is Disabled
   [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_166 Disable price override and try price overriding then check the response
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id     ${POS_TD}   O_P_166
   ${response}     Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Verify Price Override Link Is Disabled
   [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_O_P_167 Update The fulfilment date
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id     ${POS_TD}   O_P_167
   ${response}     Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
   Verify Update Of Fulfillment Options Due Date
   [Teardown]    Revoke Licence Key | API   ${response}       ${pos_data}