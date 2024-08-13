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
${Product_td}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Order${/}Product_catalog_order_test_data.xlsx

*** Test Cases ***
Zwing_CP_O_175 View Catalog using Catalog button in WebPOS
    [Tags]    Demo
   ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_01
   Login With Valid Username And Password | POS    ${pc_data}
   Open The Session    ${pc_data}
   Change Billing Mode    ${pc_data}
   Verify View Catalog Using Catalog Button In WebPOS
   Revoke Serial Key    ${pc_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pc_data}

Zwing_CP_O_176 Hide Catalog using Hide button in WebPOS
   ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_02
   Login With Valid Username And Password | POS    ${pc_data}
   Open The Session    ${pc_data}
   Change Billing Mode    ${pc_data}
   Verify View Catalog Using Catalog Button In WebPOS
   Verify Hide Catalog using Hide button in WebPOS
   Revoke Serial Key    ${pc_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pc_data}

Zwing_CP_O_177 Refresh Catalog using Refresh button
   ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_03
   Login With Valid Username And Password | POS    ${pc_data}
   Open The Session    ${pc_data}
   Change Billing Mode    ${pc_data}
   Verify View Catalog Using Catalog Button In WebPOS
   Verify Refresh catalog using refresh button
   Revoke Serial Key    ${pc_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pc_data}

Zwing_CP_O_178 A new category item is allocated to a store
     ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_04
     Open Application | Admin
     Login With Valid Username And Password  ${pc_data}
     Navigate To Product & Catalogue | Console
     Add New Category | Console   ${pc_data}
     Close Browser
     Open Application | POS
     Login With Valid Username And Password | POS    ${pc_data}
     Open The Session    ${pc_data}
     Change Billing Mode    ${pc_data}
     Verify New Category Is Visible   ${pc_data}
     Revoke Serial Key    ${pc_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pc_data}

Zwing_CP_O_179 A New Item Of Existing Category That Is Already Listed Is Allocated To The Store
     ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_05
     Open Application | Admin
     Login With Valid Username And Password  ${pc_data}
     Navigate To Products | Console
     Create New Products | Console   ${pc_data}
     Close Browser
     Open Application | POS
     Login With Valid Username And Password | POS    ${pc_data}
     Open The Session    ${pc_data}
     Change Billing Mode    ${pc_data}
     Verify New Product Is Visible In Category  ${pc_data}
     Revoke Serial Key    ${pc_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pc_data}

Zwing_CP_O_180 Item With Multiple Price(existing prices)
     ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_06
     Login With Valid Username And Password | POS   ${pc_data}
     Open The Session    ${pc_data}
     Change Billing Mode    ${pc_data}
     Scan Barcode To Add Item And Quantity To Cart | Multiple MRP    ${pc_data}
     Verify Multiple Price Product Is Added
     Revoke Serial Key    ${pc_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pc_data}

Zwing_CP_O_181 Item With Multiple Price Creating New Price books
    ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_07
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
    Login With Valid Username And Password | POS    ${pc_data}
    Open The Session    ${pc_data}
    Change Billing Mode    ${pc_data}
    Verify New PriceBook Product Is Visible  ${pc_data}
    Revoke Serial Key    ${pc_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pc_data}

Zwing_CP_O_182 All Items in Item With multiple prices added
    ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_08
    Login With Valid Username And Password | POS   ${pc_data}
    Open The Session    ${pc_data}
    Change Billing Mode    ${pc_data}
    Add All Variants Of Multiple Price Books    ${pc_data}
    Revoke Serial Key    ${pc_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pc_data}

Zwing_CP_O_183 Items allocated with 0 inventory to store
    ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_09
    Login With Valid Username And Password | POS   ${pc_data}
    Open The Session    ${pc_data}
    Change Billing Mode    ${pc_data}
    Verify Items Allocated With 0 Inventory To Store Are Blur    ${pc_data}
    Revoke Serial Key    ${pc_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pc_data}

Zwing_CP_O_184 Items with some inventory on the store
    ${pc_data}=  Fetch Testdata By Id   ${Product_td}    PC_10
    Login With Valid Username And Password | POS   ${pc_data}
    Open The Session    ${pc_data}
    Change Billing Mode    ${pc_data}
    Verify Items Allocated With Some Inventory To Store Are Normal    ${pc_data}
    Revoke Serial Key    ${pc_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pc_data}

