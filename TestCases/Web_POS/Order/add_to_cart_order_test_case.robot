*** Settings ***
Library    SeleniumLibrary
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource   ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Library    ../../../Resources/CustomKeywords/utilities.py
Resource    ../../../Resources/Web_POS/POS/Billing/split_payment_keyword.robot
Resource   ../../../Resources/Web_POS/POS/Billing/manual_discount_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Exchange/exchange_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Return/adhoc_return_keywords.robot
Resource   ../../../Resources/Web_POS/POS/Billing/mode_of_payment_keyword.robot
Resource    ../../../Resources/AdminConsole/Allocation/allocation_keywords.robot
Resource    ../../../Resources/Web_POS/POS/Order/add_to_cart_order_keyword.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Order${/}add_to_cart_order_test_data.xlsx

*** Test Cases ***
Zwing_ATC_1 Add Normal sku with Fixed UOM to cart
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    ATC_01
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Item Is Added    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_2 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    ATC_02
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify Item Is Added    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_3 Add Normal sku with weighted UOM to cart >> Add Qty mode
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    ATC_03
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode    ${pos_data}
    Verify Item Is Added    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_4 Add Normal sku with Fixed UOM and 0 Inventory to cart with enabled negative Inventory
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    ATC_04
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_5 Add Normal sku with Fixed UOM and 0 Inventory to cart with disable negative Inventory
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    ATC_05
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_6 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with enable Negative Inventory
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    ATC_06
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_7 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with disable Negative Inventory
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    ATC_07
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_8 Add Normal sku with weighted UOM to cart >> Add Qty mode with enable Negative stock Billing
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    ATC_08
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_9 Add Normal sku with weighted UOM to cart >> Add Qty mode with disable Negative Stock Billing
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    ATC_09
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_10 Add Normal sku with weighted UOM to cart >> Add Qty mode with disable Negative Stock Billing
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    ATC_10
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

