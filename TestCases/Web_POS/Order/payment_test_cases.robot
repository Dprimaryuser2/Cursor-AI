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
#Resource    ../../../Resources/Web_POS/POS/split_payment_keyword.robot

Test Setup    Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Order${/}order_payment_test_data.xlsx

*** Test Cases ***
Zwing_O_P_84 Allow to place Order without payment
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_84
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Verify Checkout Page Redirection
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_85 Set Minimum Value in Amount
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_85
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Place Order With Minimum Amount | Continue Button Enabled
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_86 Set Minimum Percentage Value
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_86
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Place Order With Minimum Percentage | Continue Button Enabled
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_87 Both Mimimum value in Amount and Percentage Value is configured | Advance collection is off
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_87
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Verify Order Can Be Placed Without Payment
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}


Zwing_O_P_89 Delivery Fulfillment option while its mandatory from policy
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_89
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Verify Billing Checkout
     Verify Delivery Fulfillment
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_90 Delivery Fulfillment option while its non mandatory from policy
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_90
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Verify Delivery Fulfillment
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_91 Allow to place Order without payment
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_91
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Verify Order Can Be Placed Without Payment
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_92 Set Minimum Value in Amount
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_92
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Place Order With Minimum Amount
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_93 Set Minimum Percentage Value
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_93
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Place Order With Minimum Amount
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_94 Both Minimum value in Amount and Percentage Value is configured
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_94
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Place Order With Minimum Amount
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_95 Both Minimum value in Amount and Percentage Value is Zero But Advance Collection is Mandatory
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_95
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
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
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Verify Checkout Page Redirection
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_122 Block order if the Ordered Product's Inventory is negative | Order Blocking while, order is being created
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_122
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Add Customer Details    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Verify Stock Not Available Popup | Order Is Created
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_123 Block order if the Ordered Product's Inventory is negative | Order Blocking while, order is being confirmed
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_123
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Add Customer Details    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Verify Stock Not Available Popup | Order Is Confirmed
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_124 Block order if the Ordered Product's Inventory is negative | Order Blocking while, order is being packed
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_124
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Navigate To Pack Order Page | Order Is Packed
     Scan Barcode To Add Item And Quantity To Cart | Pack Order   ${pos_data}
     Verify Stock Not Available Popup | Order Is Packed
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

#Zwing_O_P_125 Block order if the Ordered Product's Inventory is negative | Order Blocking while, invoice is getting generated against order
#    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_125
#     Login With Valid Username And Password | POS   ${pos_data}
#     Open The Session    ${pos_data}
#     Change Billing Mode    ${pos_data}
#     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
#     Navigate To Pack Order Page | Order Is Packed
#     Scan Barcode To Add Item And Quantity To Cart | Pack Order    ${pos_data}  #more quantity of products
##    Blocked Due To generte invoice is not redirecting to any page or not opening any popup

Zwing_O_126 Add Bill Remark while placing order
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    O_P_126
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
    Verify Bill Remark Added Is Visible In Bill Remark Textarea | Order     ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_127 Add Bill Remark while placing order | Save Bill Remark
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_127
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Add Bill Remarks | Order  ${pos_data}
     Verify Bill Remark Added | Order
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_128 Add Bill Remark while placing order | Clear bill remark
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_128
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Verify The Clear Button Of Add Bill Remark | Order    ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_129 Check Conditions before placing order | Place Order
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_122
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}   Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Pay 10 percent Amount of total Payable Amount By Cash   ${value}
     Navigate To Pack Order Page | Order Is Packed
     Scan Barcode To Add Item And Quantity To Cart | Pack Order   ${pos_data}
     Verify Stock Not Available Popup | Order Is Packed
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

#Zwing_O_P_146 Replace with product with higher value than ordered product
#    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_122
#     Login With Valid Username And Password | POS   ${pos_data}
#     Open The Session    ${pos_data}
#     Change Billing Mode    ${pos_data}
#     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
#     Verify Order Can Be Placed Without Payment
#
#Zwing_O_P_147 Replace with product with less value than ordered product
#    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_122
#     Login With Valid Username And Password | POS   ${pos_data}
#
#Zwing_O_P_148 Replace with product with same value of ordered product
#    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_122
#     Login With Valid Username And Password | POS   ${pos_data}

Zwing_O_P_149 Discard product from order | Refund to pay if advance taken for discarded product
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_149
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Enable Split payment mode
     Split Payment By Paytm  ${value}
     Verify If Payment Is Complete Or Not | Order
     Navigate To Discard Order Popup | Discard Order
     Verify Discard Order Popup
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_150 Discard product from order | Refund to pay if advance taken for discarded product | Refund Initiated by cash
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_150
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Enable Split payment mode
     Split Payment By Paytm  ${value}
     Verify If Payment Is Complete Or Not | Order
     Navigate To Discard Order Popup | Discard Order
     Verify Discard Order Popup With Different Method    ${cash_button_discard_popup}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_151 Discard product from order | Refund to pay if advance taken for discarded product | Refund Initiated by credit note
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_151
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Enable Split payment mode
     Split Payment By Paytm  ${value}
     Verify If Payment Is Complete Or Not | Order
     Navigate To Discard Order Popup | Discard Order
     Verify Discard Order Popup With Different Method    ${store_credit_button_discard_popup}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_152 Discard product from order | If advance is not taken for discarded product, no need to initiate refund
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_P_152
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${value}    Get payable amount
     Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
     Navigate To Discard Order Popup | Discard Order
     Verify Discard Product | No Advance Payment
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_P_O_162 Set variance limit and enter price override less or more than total price but within variance limit
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    O_P_162
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Price Overridden | Billing
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_P_O_163 Set variance limit and enter price override less or more than total price but out of variance limit
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}   O_P_163
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Alert Message for Price Overridden | Billing
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_164 Set variance limit and enter price override less or more than total price but equal to variance limit
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    O_P_164
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Price Overridden | Billing
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_165 Set variance limit and enter price override less or more than total price but within variance limit. Then try again price override and check the response
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}  O_P_165
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Price Override Link Is Disabled
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_166 Disable price override and try price overriding then check the response
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    O_P_166
   Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Verify Price Override Link Is Disabled
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_P_167 Update The fulfilment date
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    O_P_167
   Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
   Verify Update Of Fullfilment Options Due Date
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}
