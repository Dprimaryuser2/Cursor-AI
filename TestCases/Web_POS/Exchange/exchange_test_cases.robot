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
    Change Billing Mode    ${pos_data}

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
    ${product_price}    Apply Item Manual Discount | Update Product Popup    ${pos_data}
    Apply Item Manual Discount | Select From List    ${pos_data}
    Verify Item Manual Discount   ${product_price}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_E_50 select a exchange product ,apply item level manual discount then check the response.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_49
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
#    Change Billing Mode    ${pos_data}