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
${QA_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Staging${/}Billing${/}product_catalog_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Production${/}Billing${/}product_catalog_test_data.xlsx

*** Test Cases ***
Zwing_CP_1 View Catalog using Catalog button in WebPOS
    [Tags]    Demo
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${pc_data}=  Fetch Testdata By Id   ${POS_TD}    PC_1
   ${response}=  Login With Valid Username And Password | POS   ${pc_data}
   Open The Session    ${pc_data}
   Verify View Catalog Using Catalog Button In WebPOS
  [Teardown]   Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_2 Hide Catalog using Hide button in WebPOS
   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${pc_data}=  Fetch Testdata By Id   ${POS_TD}    PC_2
  ${response}=  Login With Valid Username And Password | POS   ${pc_data}
   Open The Session    ${pc_data}
   Verify View Catalog Using Catalog Button In WebPOS
   Verify Hide Catalog using Hide button in WebPOS
  [Teardown]   Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_3 Refresh Catalog using Refresh button
   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${pc_data}=  Fetch Testdata By Id   ${POS_TD}    PC_3
  ${response}=  Login With Valid Username And Password | POS   ${pc_data}
   Open The Session    ${pc_data}
   Verify View Catalog Using Catalog Button In WebPOS
   Verify Refresh catalog using refresh button
  [Teardown]   Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_4 A new category item is allocated to a store
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
     ${pc_data}=  Fetch Testdata By Id   ${POS_TD}    PC_4
     Open Application | Admin
     Login Again With Same User Id And Password   ${pc_data}
     Navigate To Product & Catalogue | Console
     Add New Category | Console   ${pc_data}
     Close Browser
     Open Application | POS
    ${response}=  Login With Valid Username And Password | POS   ${pc_data}
     Open The Session    ${pc_data}
     Verify New Category Is Visible   ${pc_data}
    [Teardown]   Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_5 A New Item Of Existing Category That Is Already Listed Is Allocated To The Store
     ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
     ${pc_data}=  Fetch Testdata By Id   ${POS_TD}    PC_5
     Open Application | Admin
     Login Again With Same User Id And Password   ${pc_data}
     Navigate To Products | Console
     Create New Products | Console   ${pc_data}
     Close Browser
     Open Application | POS
    ${response}=  Login With Valid Username And Password | POS   ${pc_data}
     Open The Session    ${pc_data}
     Verify New Product Is Visible In Category  ${pc_data}
    [Teardown]   Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_6 Item With Multiple Price(existing prices)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
     ${pc_data}=  Fetch Testdata By Id   ${POS_TD}    PC_6
      ${response}=  Login With Valid Username And Password | POS   ${pc_data}
     Open The Session    ${pc_data}
     Scan Barcode To Add Item And Quantity To Cart | Multiple MRP    ${pc_data}
     Verify Multiple Price Product Is Added
    [Teardown]   Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_7 Item With Multiple Price Creating New Price books
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pc_data}=  Fetch Testdata By Id   ${POS_TD}    PC_7
   Login Again With Same User Id And Password   ${pc_data}
    Open The Session    ${pc_data}
    ${storename}  Get Store Name | Web POS
    Close Browser
    Open Application | Admin
    Login With Valid Username And Password  ${pc_data}
    Navigate To Retail Price Book | Console
    Create New PriceBook | Console  ${pc_data}
    Close Browser
    Open Application | POS
   ${response}=  Login With Valid Username And Password | POS   ${pc_data}
    Open The Session    ${pc_data}
    Verify New PriceBook Product Is Visible  ${pc_data}
   [Teardown]   Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_8 All Items in Item With multiple prices added
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pc_data}=  Fetch Testdata By Id   ${POS_TD}    PC_8
     ${response}=  Login With Valid Username And Password | POS   ${pc_data}
    Open The Session    ${pc_data}
    Add All Variants Of Multiple Price Books    ${pc_data}
   [Teardown]   Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_9 Items allocated with 0 inventory to store
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pc_data}=  Fetch Testdata By Id   ${POS_TD}    PC_9
     ${response}=  Login With Valid Username And Password | POS   ${pc_data}
    Open The Session    ${pc_data}
    Verify Items Allocated With 0 Inventory To Store Are Blur    ${pc_data}
   [Teardown]   Revoke Licence Key | API   ${response}      ${pc_data}

Zwing_CP_10 Items with some inventory on the store
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pc_data}=  Fetch Testdata By Id   ${POS_TD}    PC_10
     ${response}=  Login With Valid Username And Password | POS   ${pc_data}
    Open The Session    ${pc_data}
    Verify Items Allocated With Some Inventory To Store Are Normal    ${pc_data}
   [Teardown]   Revoke Licence Key | API   ${response}      ${pc_data}

