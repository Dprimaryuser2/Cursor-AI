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
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Order${/}carry_bag_order_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Order${/}carry_bag_order_test_data.xlsx
${response}=    'NULL'

*** Test Cases ***
Zwing_CB_O_159 View All Carry Bags Allocated To Store
   [Tags]    test:retry(1)
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${POS_TD}    CB_O_1
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   ${storename}  Get Store Name | Web POS
   Close Browser
   Open Application | Admin
   Login With Valid Username And Password  ${carry_data}
   Navigate To Carry Bags | Console
   ${carrybag}  Verify Carry Bags Are Allocated To Store  ${storename}
   Close Browser
   Open Application | POS
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Carry Bag By Scanning Barcode   ${carrybag}
   Verify Item Added In Cart
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_160 Enter Positive Integer As Qty In Select Carry Bags Form
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${POS_TD}    CB_O_2
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_161 Enter Decimal Number As Qty In Select Carry Bags Form
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${POS_TD}    CB_O_3
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   ${carrybag_value}  Add Carry Bag With Decimal/Negative Integer Value  ${carry_data}
   Verify Carry Bag Window Ignores Decimal/Negative Sign    ${carrybag_value}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_162 Enter Negative Integer As Qty In Select Carry Bags Form
    [Tags]    Demo
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${POS_TD}   CB_O_4
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   ${carrybag_value}  Add Carry Bag With Decimal/Negative Integer Value  ${carry_data}
   Verify Carry Bag Window Ignores Decimal/Negative Sign    ${carrybag_value}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_163 Add Carry Bags Button Should Be Disabled If Qty Not Entered In Any Carry Bag
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${POS_TD}    CB_O_5
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Verify Add Carry Button Is Disabled If Qty Is Not Entered
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_164 Add Carry Bag Button Should Be Enabled Once Qty Is Entered In Any Carry Bag
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${POS_TD}    CB_O_6
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   ${carrybag_value}  Add Carry Bag With Decimal/Negative Integer Value  ${carry_data}
   Verify Carry Bag Window Ignores Decimal/Negative Sign    ${carrybag_value}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_165 Add Single Carry Bag To Cart
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${POS_TD}    CB_O_7
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_166 Add Multiple Carry Bags At Once To Cart
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${POS_TD}    CB_O_8
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_167 Add Carry Bags With 0 Inventory
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${POS_TD}    CB_O_9
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Carry Bag With Negative Inventory By Scanning Barcode  ${carry_data}
   Verify 0 Inventory To Cart With Disable Negative Inventory | Carry Bag  ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_168 Add Carry Bags With 0 Inventory
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${POS_TD}    CB_O_10
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Carry Bag With Negative Inventory By Scanning Barcode  ${carry_data}
   Verify 0 Inventory To Cart With Enable Negative Inventory | Carry Bag  ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_169 View Details Of Carry Bags Added To Cart By Clicking On Product In Cart
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${POS_TD}    CB_O_11
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_170 Validate Count Of Carry Bags Added To Cart On Add Carry Bags Button On Billing Screen
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${POS_TD}    CB_O_12
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_O_171 Validate Details Of Carry Bag Details As On Cart Screen To The Product Details Window
  ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${POS_TD}    CB_O_13
   ${response}    Login With Valid Username And Password | POS    ${carry_data}
   Open The Session    ${carry_data}
   Change Billing Mode    ${carry_data}
   ${carrybag_value}  Add Carry Bag With Decimal/Negative Integer Value    ${carry_data}
   Verify The Details Of Carry Bag Added in Cart   ${carrybag_value}
   [Teardown]    Revoke Licence Key | API   ${response}   ${carry_data}

Zwing_CB_172 Set variance limit and enter price override less or more than total price but within variance limit
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_O_14
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Add Product By Scan Only    ${carry_data}
   Verify Item Added In Cart
   Price Override | Billing    ${carry_data}
   Verify Price Overridden | Billing
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_173 Disable price override and try price overriding then check the response
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_O_15
   ${response}=    Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Add Product By Scan Only   ${carry_data}
   Verify Item Added In Cart
   Verify Price Override Link Is Disabled
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_174 Set variance limit and enter price override less or more than total price but out of variance limit
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_O_16
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Add Product By Scan Only   ${carry_data}
   Verify Item Added In Cart
   Price Override | Billing    ${carry_data}
   Verify Alert Message for Price Overridden | Billing
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}