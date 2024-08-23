*** Settings ***
Library    SeleniumLibrary
Library    ../../../Resources/CustomKeywords/utilities.py
Library    RequestsLibrary
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/add_to_cart_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot

Test Setup    Open Application | POS
Test Teardown   Close All Browsers

*** Variables ***
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Billing${/}add_to_cart_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Billing${/}add_to_cart_test_data.xlsx
${response}=    'NULL'

*** Test Cases ***
Zwing_O_1 Add Normal sku with Fixed UOM to cart
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_01
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Item Is Added    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_2 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_02
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify Item Is Added    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_3 Add Normal sku with weighted UOM to cart >> Add Qty mode
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_03
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode    ${pos_data}
    Verify Item Is Added    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_4 Add Normal sku with Fixed UOM and 0 Inventory to cart with enabled negative Inventory
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_04
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_5 Add Normal sku with Fixed UOM and 0 Inventory to cart with disable negative Inventory
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_05
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Normal SKU Product    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_6 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with enable Negative Inventory
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_06
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_7 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with disable Negative Inventory
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_07
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_8 Add Normal sku with weighted UOM to cart >> Add Qty mode with enable Negative stock Billing
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_08
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_9 Add Normal sku with weighted UOM to cart >> Add Qty mode with disable Negative Stock Billing
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_09
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_28 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with decimal weight
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_28
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify Item Is Added    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_29 Add Normal sku with weighted UOM to cart >> Add Qty mode with decimal weight
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_29
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Add Cart Quantity Mode    ${pos_data}
    Verify Item Is Added    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_30 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with enable Negative Inventory with decimal weight
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_30
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_31 Add Normal sku with weighted UOM to cart >> Edit Cart Qty mode with disable Negative Inventory with decimal weight
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_31
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_32 Add Normal sku with weighted UOM to cart >> Add Qty mode with enable Negative stock Billing with decimal weight
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_32
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Enable Negative Inventory    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_33 Add Normal sku with weighted UOM to cart >> Add Qty mode with disable Negative Stock Billing with decimal weight
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_33
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Weighted UOM Products to Cart | Edit Cart Quantity Mode    ${pos_data}
    Verify 0 Inventory To Cart With Disable Negative Inventory    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_34 Add item from previous session
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_34
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan And Add Product    ${pos_data}
    ${customer_info}    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Go Back To POS Dashboard
    Close The Session For Adding The Item From Previous Session    ${pos_data}
    Logout From The POS For Adding The Item From Previous Session
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Previous Customer    ${customer_info}
    ${items}    Add Items From Previous Session
    Verify Items Are Added From Previous Session    ${items}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_35 Add item from previous session>> Discard Button
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_35
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_info}    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Go Back To POS Dashboard
    Close The Session For Adding The Item From Previous Session    ${pos_data}
    Logout From The POS For Adding The Item From Previous Session
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Previous Customer    ${customer_info}
    ${items}    Discard Previous Added Item
    Verify Items Are Added From Previous Session    ${items}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_O_36 Add item from previous session>> Add item to cart
    [Tags]    test:retry(1)
     ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_36
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_info}    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Go Back To POS Dashboard
    Close The Session For Adding The Item From Previous Session       ${pos_data}
    Logout From The POS For Adding The Item From Previous Session
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Previous Customer    ${customer_info}
    ${items}    Add Items From Previous Session
    Verify Items Are Added From Previous Session    ${items}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}