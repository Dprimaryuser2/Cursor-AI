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

#*** Variables ***
#${carrybag_td}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}carry_bag_test_data.xlsx

*** Variables ***
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Billing${/}carry_bag_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Billing${/}carry_bag_test_data.xlsx

*** Test Cases ***
Zwing_CB_1 View All Carry Bags Allocated To Store
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}    CB_1
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   ${storename}  Get Store Name | Web POS
   Close Browser
   Open Application | Admin
   Login With Valid Username And Password  ${carry_data}
   Navigate To Carry Bags | Console
   ${carrybag}  Verify Carry Bags Are Allocated To Store  ${storename}
   Close Browser
   Open Application | POS
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Add Carry Bag By Scanning Barcode   ${carrybag}
   Verify Item Added In Cart
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_2 Enter Positive Integer As Qty In Select Carry Bags Form
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_2
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_3 Enter Decimal Number As Qty In Select Carry Bags Form
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_3
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   ${carrybag_value}  Add Carry Bag With Decimal/Negative Integer Value  ${carry_data}
   Verify Carry Bag Window Ignores Decimal/Negative Sign    ${carrybag_value}
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_4 Enter Negative Integer As Qty In Select Carry Bags Form
    [Tags]    Demo
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_4
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   ${carrybag_value}  Add Carry Bag With Decimal/Negative Integer Value  ${carry_data}
   Verify Carry Bag Window Ignores Decimal/Negative Sign    ${carrybag_value}
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_5 Add Carry Bags Button Should Be Disabled If Qty Not Entered In Any Carry Bag
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_5
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Verify Add Carry Button Is Disabled If Qty Is Not Entered
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_6 Add Carry Bag Button Should Be Enabled Once Qty Is Entered In Any Carry Bag
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_6
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   ${carrybag_value}  Add Carry Bag With Decimal/Negative Integer Value  ${carry_data}
   Verify Carry Bag Window Ignores Decimal/Negative Sign    ${carrybag_value}
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_7 Add Single Carry Bag To Cart
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_7
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_8 Add Multiple Carry Bags At Once To Cart
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_8
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_9 Add Carry Bags With 0 Inventory
    [Tags]    try
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_9
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Add Carry Bag With Negative Inventory By Scanning Barcode  ${carry_data}
   Verify 0 Inventory To Cart With Disable Negative Inventory | Carry Bag  ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_10 Add Carry Bags With 0 Inventory
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_10
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Add Carry Bag With Negative Inventory By Scanning Barcode  ${carry_data}
   Verify 0 Inventory To Cart With Enable Negative Inventory | Carry Bag  ${carry_data}
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_11 View Details Of Carry Bags Added To Cart By Clicking On Product In Cart
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_11
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_12 Validate Count Of Carry Bags Added To Cart On Add Carry Bags Button On Billing Screen
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_12
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Add Carry Bags    ${carry_data}
   Verify Item Added In Cart
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_13 Validate Details Of Carry Bag Details As On Cart Screen To The Product Details Window
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_13
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   ${carrybag_value}  Add Carry Bag With Decimal/Negative Integer Value    ${carry_data}
   Verify The Details Of Carry Bag Added in Cart   ${carrybag_value}
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_14 Set variance limit and enter price override less or more than total price but within variance limit
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_14
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Add Product By Scan Only    ${carry_data}
   Verify Item Added In Cart
   Price Override | Billing    ${carry_data}
   Verify Price Overridden | Billing
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_15 Disable price override and try price overriding then check the response
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_15
   ${response}=    Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Add Product By Scan Only   ${carry_data}
   Verify Item Added In Cart
   Verify Price Override Link Is Disabled
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}

Zwing_CB_16 Set variance limit and enter price override less or more than total price but out of variance limit
   ${CARRYBAG_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${carry_data}=  Fetch Testdata By Id   ${CARRYBAG_TD}   CB_16
    ${response}=  Login With Valid Username And Password | POS   ${carry_data}
   Open The Session    ${carry_data}
   Add Product By Scan Only   ${carry_data}
   Verify Item Added In Cart
   Price Override | Billing    ${carry_data}
   Verify Alert Message for Price Overridden | Billing
   [Teardown]    Revoke Licence Key | API   ${response}      ${carry_data}