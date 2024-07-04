*** Settings ***
Library    SeleniumLibrary
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/promo_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Library   ../../../Resources/CustomKeywords/utilities.py
Resource    ../../../Resources/Web_POS/POS/product_catalog_keywords.robot
Resource   ../../../Resources/Web_POS/POS/carry_bag_keyword.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${carrybag_td}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}carry_bag_test_data.xlsx

*** Test Cases ***
Zwing_CB_1 View All Carry Bags Allocated To Store
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_1
   Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   ${storename}  Get Store Name | Web POS
   Close Browser
   Open Application | Admin
   Login With Valid Username And Password  ${carry_data}
   Navigate To Carry Bags | Console
   ${carrybag}  Verify Carry Bags Are Allocated To Store  ${storename}
   Close Browser
   Open Application | POS
   Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Add Carry Bag By Scanning Barcode   ${carrybag}
   Verify Item Added In Cart
   Revoke Serial Key    ${carry_data}
   [Teardown]    Tear It Down If Test Case Failed    ${carry_data}

Zwing_CB_2 Enter Positive Integer As Qty In Select Carry Bags Form
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_2
   Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   Revoke Serial Key    ${carry_data}
   [Teardown]    Tear It Down If Test Case Failed    ${carry_data}

Zwing_CB_3 Enter Decimal Number As Qty In Select Carry Bags Form
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_3
   Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   ${carrybag_value}  Add Carry Bag With Decimal/Negative Integer Value  ${carry_data}
   Verify Carry Bag Window Ignores Decimal/Negative Sign    ${carrybag_value}
   Revoke Serial Key    ${carry_data}
   [Teardown]    Tear It Down If Test Case Failed    ${carry_data}

Zwing_CB_4 Enter Negative Integer As Qty In Select Carry Bags Form
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_4
   Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   ${carrybag_value}  Add Carry Bag With Decimal/Negative Integer Value  ${carry_data}
   Verify Carry Bag Window Ignores Decimal/Negative Sign    ${carrybag_value}
   Revoke Serial Key    ${carry_data}
   [Teardown]    Tear It Down If Test Case Failed    ${carry_data}

Zwing_CB_5 Add Carry Bags Button Should Be Disabled If Qty Not Entered In Any Carry Bag
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_5
   Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Verify Add Carry Button Is Disabled If Qty Is Not Entered
   Revoke Serial Key    ${carry_data}
   [Teardown]    Tear It Down If Test Case Failed    ${carry_data}

Zwing_CB_6 Add Carry Bag Button Should Be Enabled Once Qty Is Entered In Any Carry Bag
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_6
   Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   ${carrybag_value}  Add Carry Bag With Decimal/Negative Integer Value  ${carry_data}
   Verify Carry Bag Window Ignores Decimal/Negative Sign    ${carrybag_value}
   Revoke Serial Key    ${carry_data}
   [Teardown]    Tear It Down If Test Case Failed    ${carry_data}

Zwing_CB_7 Add Single Carry Bag To Cart
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_7
   Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   Revoke Serial Key    ${carry_data}
   [Teardown]    Tear It Down If Test Case Failed    ${carry_data}

Zwing_CB_8 Add Multiple Carry Bags At Once To Cart
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_8
   Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   Revoke Serial Key    ${carry_data}
   [Teardown]    Tear It Down If Test Case Failed    ${carry_data}

Zwing_CB_9 Add Carry Bags With 0 Inventory
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_9
   Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Add Carry Bag With Negative Inventory By Scanning Barcode  ${carry_data}
   Verify 0 Inventory To Cart With Disable Negative Inventory | Carry Bag  ${carry_data}
   Revoke Serial Key    ${carry_data}
   [Teardown]    Tear It Down If Test Case Failed    ${carry_data}

Zwing_CB_10 Add Carry Bags With 0 Inventory
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_10
   Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Add Carry Bag With Negative Inventory By Scanning Barcode  ${carry_data}
   Verify 0 Inventory To Cart With Enable Negative Inventory | Carry Bag  ${carry_data}
   Revoke Serial Key    ${carry_data}
   [Teardown]    Tear It Down If Test Case Failed    ${carry_data}

Zwing_CB_11 View Details Of Carry Bags Added To Cart By Clicking On Product In Cart
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_11
   Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   Revoke Serial Key    ${carry_data}
   [Teardown]    Tear It Down If Test Case Failed    ${carry_data}

Zwing_CB_12 Validate Count Of Carry Bags Added To Cart On Add Carry Bags Button On Billing Screen
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_12
   Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   Revoke Serial Key    ${carry_data}
   [Teardown]    Tear It Down If Test Case Failed    ${carry_data}

Zwing_CB_13 Validate Details Of Carry Bag Details As On Cart Screen To The Product Details Window
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_13
   Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   ${carrybag_value}  Add Carry Bag With Decimal/Negative Integer Value    ${carry_data}
   Verify The Details Of Carry Bag Added in Cart   ${carrybag_value}
   Revoke Serial Key    ${carry_data}
   [Teardown]    Tear It Down If Test Case Failed    ${carry_data}

Zwing_CB_14 Set variance limit and enter price override less or more than total price but within variance limit
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_14
   Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Add Product By Scan Only    ${carry_data}
   Verify Item Added In Cart
   Price Override | Billing    ${carry_data}
   Verify Price Overridden | Billing
   Revoke Serial Key    ${carry_data}
   [Teardown]    Tear It Down If Test Case Failed    ${carry_data}

Zwing_CB_15 Disable price override and try price overriding then check the response
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_15
   Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Add Product By Scan Only   ${carry_data}
   Verify Item Added In Cart
   Verify Price Override Link Is Disabled
   Revoke Serial Key    ${carry_data}
   [Teardown]    Tear It Down If Test Case Failed    ${carry_data}

Zwing_CB_16 Set variance limit and enter price override less or more than total price but out of variance limit
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_16
   Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Add Product By Scan Only   ${carry_data}
   Verify Item Added In Cart
   Price Override | Billing    ${carry_data}
   Verify Alert Message for Price Overridden | Billing
   Revoke Serial Key    ${carry_data}
   [Teardown]    Tear It Down If Test Case Failed    ${carry_data}
