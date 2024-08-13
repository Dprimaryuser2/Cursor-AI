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

#*** Variables ***
#${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Order${/}add_to_cart_order_test_data.xlsx

*** Variables ***
${QA_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Staging${/}Order${/}add_to_cart_order_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Production${/}Order${/}add_to_cart_order_test_data.xlsx

*** Test Cases ***
Zwing_ATC_1 Add Normal sku with Fixed UOM to cart
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_01
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Item Is Added | Order    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_2 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_02
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode | Order    ${pos_data}
    Verify Item Is Added | Order    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_3 Add Normal sku with weighted UOM to cart >> Add Qty mode
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_03
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode | Order    ${pos_data}
    Verify Item Is Added | Order    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_4 Add Normal sku with Fixed UOM and 0 Inventory to cart with enabled negative Inventory
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_04
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory | Order    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_5 Add Normal sku with Fixed UOM and 0 Inventory to cart with disable negative Inventory
    [Tags]    Valid Failure
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_05
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Normal SKU Product    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory | Order      ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_6 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with enable Negative Inventory
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_06
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode | Order    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory | Order    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_7 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with disable Negative Inventory
    [Tags]    Valid Failure
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_07
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode | Order | Disable Negative Inventory    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_8 Add Normal sku with weighted UOM to cart >> Add Qty mode with enable Negative stock Billing
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_08
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode | Order    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory | Order    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_9 Add Normal sku with weighted UOM to cart >> Add Qty mode with disable Negative Stock Billing
    [Tags]    Valid Failure
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_09
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode | Order | Disable Negative Inventory    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_10 Validate the count of total no. of items added to the cart.
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_10
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode | Order    ${pos_data}
    Verify Item Is Added | Order    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_11 Remove items from cart by clicking on cross button
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_11
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode | Order    ${pos_data}
    Delete Item In The Cart
    Verify Remove item to the cart | Order
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_12 Remove items from cart by clicking on clear button
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_12
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Click On Clear All Items Button
    Verify Clear All Items Clear the Items From Cart
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_13 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with decimal weight
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_13
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode | Order    ${pos_data}
    Verify Item Is Added | Order    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_14 Add Normal sku with weighted UOM to cart >> Add Qty mode with decimal weight
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_14
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode | Order    ${pos_data}
    Verify Item Is Added | Order    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_15 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with enable Negative Inventory with decimal weight
    [Tags]    retry
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_15
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode | Order    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory | Order    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_16 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with disable Negative Inventory with decimal weight
    [Tags]    valid failure
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_16
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode | Order | Disable Negative Inventory     ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_17 Add Normal sku with weighted UOM to cart >> Add Qty mode with enable Negative stock Billing with decimal weight
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_17
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode | Order    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory | Order    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_18 Add Normal sku with weighted UOM to cart >> Add Qty mode with disable Negative Stock Billing with decimal weight
    [Tags]    valid failure
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_18
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode | Order | Disable Negative Inventory    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_19 Add item from previous session
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_19
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_info}    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Go Back To POS Dashboard
    Close The Session For Adding The Item From Previous Session    ${pos_data}
    Logout From The POS For Adding The Item From Previous Session
    Login Again With Same User Id And Password   ${pos_data}
    Add Previous Customer    ${customer_info}
    ${items}    Add Items From Previous Session
    Verify Items Are Added From Previous Session | Order    ${items}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_20 Add item from previous session>> Discard Button
    [Tags]    retry
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_20
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_info}    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Go Back To POS Dashboard
    Close The Session For Adding The Item From Previous Session    ${pos_data}
    Logout From The POS For Adding The Item From Previous Session
    Login Again With Same User Id And Password   ${pos_data}
    Add Previous Customer    ${customer_info}
    ${items}    Discard Previous Added Item | Order
    Verify Items Are Added From Previous Session | Order    ${items}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_ATC_21 Add item from previous session>> Add item to cart
    ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    ATC_21
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_info}    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Go Back To POS Dashboard
    Close The Session For Adding The Item From Previous Session    ${pos_data}
    Logout From The POS For Adding The Item From Previous Session
    Login Again With Same User Id And Password   ${pos_data}
    Add Previous Customer    ${customer_info}
    ${items}    Add Items From Previous Session | Order
    Verify Items Are Added From Previous Session | Order    ${items}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}