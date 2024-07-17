*** Settings ***
Library    SeleniumLibrary
Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/add_to_cart_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot

Test Setup    Open Application | POS
Test Teardown   Close All Browsers

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}add_to_cart_test_data.xlsx

*** Test Cases ***
Zwing_O_1 Add Normal sku with Fixed UOM to cart
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_01
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Item Is Added    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_2 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_02
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify Item Is Added    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_3 Add Normal sku with weighted UOM to cart >> Add Qty mode
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_03
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode    ${pos_data}
    Verify Item Is Added    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_4 Add Normal sku with Fixed UOM and 0 Inventory to cart with enabled negative Inventory
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_04
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_5 Add Normal sku with Fixed UOM and 0 Inventory to cart with disable negative Inventory
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_05
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_6 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with enable Negative Inventory
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_06
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_7 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with disable Negative Inventory
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_07
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_8 Add Normal sku with weighted UOM to cart >> Add Qty mode with enable Negative stock Billing
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_08
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_9 Add Normal sku with weighted UOM to cart >> Add Qty mode with disable Negative Stock Billing
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_09
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_28 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with decimal weight
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_28
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify Item Is Added    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_29 Add Normal sku with weighted UOM to cart >> Add Qty mode with decimal weight
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_29
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode    ${pos_data}
    Verify Item Is Added    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_30 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with enable Negative Inventory with decimal weight
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_30
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_31 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with disable Negative Inventory with decimal weight
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_31
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_32 Add Normal sku with weighted UOM to cart >> Add Qty mode with enable Negative stock Billing with decimal weight
    [Tags]    Demo
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_32
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_33 Add Normal sku with weighted UOM to cart >> Add Qty mode with disable Negative Stock Billing with decimal weight
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_33
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_34 Add item from previous session
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_34
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_info}    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Go Back
    Close The Session    ${pos_data}
    Logout From The POS
    Login Again With Same User Id And Password   ${pos_data}
    Add Previous Customer    ${customer_info}
    ${items}    Add Items From Previous Session
    Verify Items Are Added From Previous Session    ${items}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_35 Add item from previous session>> Discard Button
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_35
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_info}    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Go Back
    Close The Session    ${pos_data}
    Logout From The POS
    Login Again With Same User Id And Password   ${pos_data}
    Add Previous Customer    ${customer_info}
    ${items}    Discard Previous Added Item
    Verify Items Are Added From Previous Session    ${items}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_O_36 Add item from previous session>> Add item to cart
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_36
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_info}    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Go Back
    Close The Session    ${pos_data}
    Logout From The POS
    Login Again With Same User Id And Password   ${pos_data}
    Add Previous Customer    ${customer_info}
    ${items}    Add Items From Previous Session
    Verify Items Are Added From Previous Session    ${items}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}