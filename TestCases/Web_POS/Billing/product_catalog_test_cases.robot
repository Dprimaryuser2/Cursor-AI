*** Settings ***
Library    SeleniumLibrary
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/promo_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Library   ../../../Resources/CustomKeywords/utilities.py
Resource    ../../../Resources/Web_POS/POS/product_catalog_keywords.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${Product_td}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}product_catalog_test_data.xlsx

*** Test Cases ***
Zwing_CP_1 View Catalog using Catalog button in WebPOS
   ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_1
   Login With Valid Username And Password | POS    ${pc_data}
   Open The Session    ${pc_data}
   Verify View Catalog Using Catalog Button In WebPOS

Zwing_CP_2 Hide Catalog using Hide button in WebPOS
   ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_2
   Login With Valid Username And Password | POS    ${pc_data}
   Open The Session    ${pc_data}
   Verify View Catalog Using Catalog Button In WebPOS
   Verify Hide Catalog using Hide button in WebPOS

Zwing_CP_3 Refresh Catalog using Refresh button
   ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_3
   Login With Valid Username And Password | POS    ${pc_data}
   Open The Session    ${pc_data}
   Verify View Catalog Using Catalog Button In WebPOS
   Verify Refresh catalog using refresh button

Zwing_CP_4 A new category item is allocated to a store
     ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_4
     Open Application | Admin
     Login With Valid Username And Password  ${pc_data}
     Navigate To Product & Catalogue | Console
     Add New Category | Console   ${pc_data}
     Close Browser
     Open Application | POS
     Login With Valid Username And Password | POS    ${pc_data}
     Open The Session    ${pc_data}
     Verify New Category Is Visible   ${pc_data}

Zwing_CP_5 A New Item Of Existing Category That Is Already Listed Is Allocated To The Store
     ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_5
     Open Application | Admin
     Login With Valid Username And Password  ${pc_data}
     Navigate To Products | Console
     Create New Products | Console   ${pc_data}
     Close Browser
     Open Application | POS
     Login With Valid Username And Password | POS    ${pc_data}
     Open The Session    ${pc_data}
     Verify New Product Is Visible In Category  ${pc_data}

Zwing_CP_6 Item With Multiple Price(existing prices)
     ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_6
     Login With Valid Username And Password | POS   ${pc_data}
     Open The Session    ${pc_data}
     Scan Barcode To Add Item And Quantity To Cart | Multiple MRP    ${pc_data}
     Verify Multiple Price Product Is Added

Zwing_CP_7 Item With Multiple Price Creating New Pricebooks
    ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_7

