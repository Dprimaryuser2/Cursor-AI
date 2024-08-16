*** Settings ***
Library    SeleniumLibrary
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Library   ../../../Resources/CustomKeywords/utilities.py
Resource    ../../../Resources/Web_POS/POS/Billing/product_catalog_keywords.robot
Resource   ../../../Resources/Web_POS/POS/Billing/carry_bag_keyword.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${carrybag_td}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}carry_bag_order_test_data.xlsx

*** Test Cases ***
Zwing_CB_O_159 View All Carry Bags Allocated To Store
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_O_1
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   ${storename}  Get Store Name | Web POS
   Close Browser
   Open Application | Admin
   Login With Valid Username And Password  ${carry_data}
   Change Billing Mode    ${carry_data}
   Navigate To Carry Bags | Console
   ${carrybag}  Verify Carry Bags Are Allocated To Store  ${storename}
   Close Browser
   Open Application | POS
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Carry Bag By Scanning Barcode   ${carrybag}
   Verify Item Added In Cart
   Revoke Serial Key    ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_160 Enter Positive Integer As Qty In Select Carry Bags Form
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_O_2
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   Revoke Serial Key    ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_161 Enter Decimal Number As Qty In Select Carry Bags Form
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_O_3
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   ${carrybag_value}  Add Carry Bag With Decimal/Negative Integer Value  ${carry_data}
   Verify Carry Bag Window Ignores Decimal/Negative Sign    ${carrybag_value}
   Revoke Serial Key    ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_162 Enter Negative Integer As Qty In Select Carry Bags Form
    [Tags]    Demo
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}   CB_O_4
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   ${carrybag_value}  Add Carry Bag With Decimal/Negative Integer Value  ${carry_data}
   Verify Carry Bag Window Ignores Decimal/Negative Sign    ${carrybag_value}
   Revoke Serial Key    ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_163 Add Carry Bags Button Should Be Disabled If Qty Not Entered In Any Carry Bag
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_O_5
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Verify Add Carry Button Is Disabled If Qty Is Not Entered
   Revoke Serial Key    ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_164 Add Carry Bag Button Should Be Enabled Once Qty Is Entered In Any Carry Bag
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_O_6
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   ${carrybag_value}  Add Carry Bag With Decimal/Negative Integer Value  ${carry_data}
   Verify Carry Bag Window Ignores Decimal/Negative Sign    ${carrybag_value}
   Revoke Serial Key    ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_165 Add Single Carry Bag To Cart
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_O_7
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   Revoke Serial Key    ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_166 Add Multiple Carry Bags At Once To Cart
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_O_8
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   Revoke Serial Key    ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_167 Add Carry Bags With 0 Inventory
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_O_9
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Carry Bag With Negative Inventory By Scanning Barcode  ${carry_data}
   Verify 0 Inventory To Cart With Disable Negative Inventory | Carry Bag  ${carry_data}
   Revoke Serial Key    ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_168 Add Carry Bags With 0 Inventory
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_O_10
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Carry Bag With Negative Inventory By Scanning Barcode  ${carry_data}
   Verify 0 Inventory To Cart With Enable Negative Inventory | Carry Bag  ${carry_data}
   Revoke Serial Key    ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_169 View Details Of Carry Bags Added To Cart By Clicking On Product In Cart
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_O_11
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   Revoke Serial Key    ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_170 Validate Count Of Carry Bags Added To Cart On Add Carry Bags Button On Billing Screen
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_O_12
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   Revoke Serial Key    ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_171 Validate Details Of Carry Bag Details As On Cart Screen To The Product Details Window
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_O_13
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   ${carrybag_value}  Add Carry Bag With Decimal/Negative Integer Value    ${carry_data}
   Verify The Details Of Carry Bag Added in Cart   ${carrybag_value}
   Revoke Serial Key    ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_172 Set variance limit and enter price override less or more than total price but within variance limit
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_O_14
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Product By Scan Only    ${carry_data}
   Verify Item Added In Cart
   Price Override | Billing    ${carry_data}
   Verify Price Overridden | Billing
   Revoke Serial Key    ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_173 Disable price override and try price overriding then check the response
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_O_15
   ${response}    Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Product By Scan Only   ${carry_data}
   Verify Item Added In Cart
   Verify Price Override Link Is Disabled
   Revoke Serial Key    ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_174 Set variance limit and enter price override less or more than total price but out of variance limit
   ${carry_data}=  Fetch Testdata By Id   ${carrybag_td}    CB_O_16
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Product By Scan Only   ${carry_data}
   Verify Item Added In Cart
   Price Override | Billing    ${carry_data}
   Verify Alert Message for Price Overridden | Billing
   Revoke Serial Key    ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}
