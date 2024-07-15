*** Settings ***
Library    SeleniumLibrary
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/promo_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Return/adhoc_return_keywords.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Library    ../../../Resources/CustomKeywords/utilities.py
Resource    ../../../Resources/Web_POS/POS/split_payment_keyword.robot
Resource    ../../../Resources/Web_POS/POS/manual_discount_keyword.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Return${/}adhoc_return_test_data.xlsx

*** Test Cases ***

Zwing_R_1 Return should be mark enable in policies
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_1
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}


Zwing_R_2 While Return is off in Policies
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_2
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Verify Mode Is Disabled    ${pos_data}

Zwing_R_3 When Auto Switch to billing is On
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_3
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Turn Auto Switch To Billing On
   Auto Switch To Billing
   Verify Auto Switched To Billing

Zwing_R_4 When Auto Switch to billing is Off
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_4
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Set Selenium Speed    1
   Turn Auto Switch To Billing Off
   Change Billing Mode    ${pos_data}
   Turn Auto Switch To Billing On

Zwing_R_5 Adding product by scanning the Barcode
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_5
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}

Zwing_R_6 Add items to Return by searching the barcode or name of Item
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_6
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}

Zwing_R_7 Add items to Return by catalog
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_7
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Add Items In Cart | Catalog    ${pos_data}

Zwing_R_8 Add Salesperson with return item
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_8
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Assign A Salesperson To An Item    ${pos_data}

Zwing_R_9 Add item qty by scanning
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_9
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Verify Item Added In Cart

Zwing_R_10 Add Qty to the added item
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_10
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Verify Item Added In Cart

