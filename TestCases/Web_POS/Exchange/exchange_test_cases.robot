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

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Exchange${/}exchange_test_data.xlsx

*** Test Cases ***
Zwing_E_01 Check whether Exchange text is clickable or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_1
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Verify Exchange Text Is Clickable    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_02 Click on Exchange Text and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_2
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Verify Exchange Text Is Clickable    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_03 Click on confirm button and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_3
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Verify Exchange Text Is Clickable    ${pos_data}
    Verify The Confirm Button | Exchange   ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_04 Click on cancel button and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_4
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Verify Exchange Text Is Clickable    ${pos_data}
    Verify The Cancel Button | Exchange   ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_05 Click on "+Add Exchange Items from Invoice" link and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_5
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_06 Verify invoice parameters are clickable or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_6
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Verify The Invoice Parameters Are Clickable
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}



#Zwing_B_46
#Zwing_B_47
#Zwing_B_48

Zwing_E_49 select a alternate product ,apply item level manual discount then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_49
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
#    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Navigate To Update Product Window    ${pos_data}
    Verify Disabled Item Level Discount
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_E_50 select a exchange product ,apply item level manual discount then check the response.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_49
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
#    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Navigate To Update Product Window    ${pos_data}
    Verify Disabled Item Level Discount
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_60 check the behaviour of the system when payment amount is 0
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    E_60
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    # Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Navigate To Update Product Window   ${pos_data}
    Apply Item Manual Discount | Update Product Popup   ${pos_data}
    Apply Item Manual Discount | Select From List  ${pos_data}
    Click On Update Product | Manual Discount
    ${value}    Get payable amount
    Verify Billing Checkout
    No Payment Required | Checkout Page
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_61 click on cancel button of no payment required then check the response.
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    E_61
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    # Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Navigate To Update Product Window   ${pos_data}
    Apply Item Manual Discount | Update Product Popup   ${pos_data}
    Apply Item Manual Discount | Select From List  ${pos_data}
    Click On Update Product | Manual Discount
    ${value}    Get payable amount
    Verify Billing Checkout
    Cancel No Payment Required | Checkout Page
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_62 check whether salesperson tagging option is popup or not for alternate product.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}   E_62
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    # Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Assign A Salesperson To An Item  ${pos_data}
    Verify If Salesperson Is Assigned To An Item    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}