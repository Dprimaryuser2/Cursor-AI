*** Settings ***
Library    SeleniumLibrary
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Library   ../../../Resources/CustomKeywords/utilities.py
Resource    ../../../Resources/Web_POS/POS/Billing/product_catalog_keywords.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Order${/}product_catalog_order_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Order${/}product_catalog_order_test_data.xlsx
${response}=    'NULL'

*** Test Cases ***
Zwing_CP_O_175 View Catalog using Catalog button in WebPOS
    [Tags]    Demo
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pc_data}=  Fetch Testdata By Id     ${POS_TD}    PC_01
   ${response}     Login With Valid Username And Password | POS    ${pc_data}
   Open The Session    ${pc_data}
   Change Billing Mode    ${pc_data}
   Verify View Catalog Using Catalog Button In WebPOS
   [Teardown]    Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_O_176 Hide Catalog using Hide button in WebPOS
  ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pc_data}=  Fetch Testdata By Id     ${POS_TD}    PC_02
   ${response}     Login With Valid Username And Password | POS    ${pc_data}
   Open The Session    ${pc_data}
   Change Billing Mode    ${pc_data}
   Verify View Catalog Using Catalog Button In WebPOS
   Verify Hide Catalog using Hide button in WebPOS
   [Teardown]    Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_O_177 Refresh Catalog using Refresh button
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pc_data}=  Fetch Testdata By Id     ${POS_TD}    PC_03
   ${response}     Login With Valid Username And Password | POS    ${pc_data}
   Open The Session    ${pc_data}
   Change Billing Mode    ${pc_data}
   Verify View Catalog Using Catalog Button In WebPOS
   Verify Refresh catalog using refresh button
   [Teardown]    Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_O_178 A new category item is allocated to a store
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pc_data}=  Fetch Testdata By Id     ${POS_TD}    PC_04
     Open Application | Admin
     Login With Valid Username And Password  ${pc_data}
     Navigate To Product & Catalogue | Console
     Add New Category | Console   ${pc_data}
     Close Browser
     Open Application | POS
     ${response}     Login With Valid Username And Password | POS    ${pc_data}
     Open The Session    ${pc_data}
     Change Billing Mode    ${pc_data}
     Verify New Category Is Visible   ${pc_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_O_179 A New Item Of Existing Category That Is Already Listed Is Allocated To The Store
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pc_data}=  Fetch Testdata By Id     ${POS_TD}    PC_05
     Open Application | Admin
     Login With Valid Username And Password  ${pc_data}
     Navigate To Products | Console
     Create New Products | Console   ${pc_data}
     Close Browser
     Open Application | POS
     ${response}     Login With Valid Username And Password | POS    ${pc_data}
     Open The Session    ${pc_data}
     Change Billing Mode    ${pc_data}
     Verify New Product Is Visible In Category  ${pc_data}
     [Teardown]    Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_O_180 Item With Multiple Price(existing prices)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
     ${pc_data}=  Fetch Testdata By Id     ${POS_TD}    PC_06
     ${response}     Login With Valid Username And Password | POS   ${pc_data}
     Open The Session    ${pc_data}
     Change Billing Mode    ${pc_data}
     Scan Barcode To Add Item And Quantity To Cart | Multiple MRP    ${pc_data}
     Verify Multiple Price Product Is Added
     [Teardown]    Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_O_181 Item With Multiple Price Creating New Price books
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pc_data}=  Fetch Testdata By Id     ${POS_TD}    PC_07
    Login With Valid Username And Password | POS    ${pc_data}
    Open The Session    ${pc_data}
    Change Billing Mode    ${pc_data}
    ${storename}  Get Store Name | Web POS
    Close Browser
    Open Application | Admin
    Login With Valid Username And Password  ${pc_data}
    Navigate To Retail Price Book | Console
    Create New PriceBook | Console  ${pc_data}
    Close Browser
    Open Application | POS
    ${response}     Login With Valid Username And Password | POS    ${pc_data}
    Open The Session    ${pc_data}
    Change Billing Mode    ${pc_data}
    Verify New PriceBook Product Is Visible  ${pc_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_O_182 All Items in Item With multiple prices added
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pc_data}=  Fetch Testdata By Id     ${POS_TD}    PC_08
    ${response}     Login With Valid Username And Password | POS   ${pc_data}
    Open The Session    ${pc_data}
    Change Billing Mode    ${pc_data}
    Add All Variants Of Multiple Price Books    ${pc_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_O_183 Items allocated with 0 inventory to store
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pc_data}=  Fetch Testdata By Id     ${POS_TD}    PC_09
    ${response}     Login With Valid Username And Password | POS   ${pc_data}
    Open The Session    ${pc_data}
    Change Billing Mode    ${pc_data}
    Verify Items Allocated With 0 Inventory To Store Are Blur    ${pc_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_O_184 Items with some inventory on the store
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pc_data}=  Fetch Testdata By Id     ${POS_TD}    PC_10
    ${response}     Login With Valid Username And Password | POS   ${pc_data}
    Open The Session    ${pc_data}
    Change Billing Mode    ${pc_data}
    Verify Items Allocated With Some Inventory To Store Are Normal    ${pc_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pc_data}