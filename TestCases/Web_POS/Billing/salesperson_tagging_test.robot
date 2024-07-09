*** Settings ***
Library    SeleniumLibrary

Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/promo_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Resource    ../../../Resources/Web_POS/POS/salesperson_keyword.robot
Library    ../../../Resources/CustomKeywords/utilities.py

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}salesperson_test_data.xlsx

*** Test Cases ***
Zwing_ST_1 Salesperson Tagging is Enabled and Salesperson Tagging is Mandatory in Policies
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_1
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Verify Salesperson Tagging is Enabled and Salesperson Tagging is Mandatory in Policies
   Revoke Serial Key    ${pos_data}


Zwing_ST_2 Salesperson Tagging is Enabled and Salesperson Tagging is Optional in Policies
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_2
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Set Selenium Speed    1
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Verify Salesperson Tagging is Enabled and Salesperson Tagging is Optional in Policies    ${pos_data}
   Revoke Serial Key    ${pos_data}


Zwing_ST_3 Salesperson Tagging is Enabled and Salesperson Tagging is Mandatory after adding the product in Policies
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_3
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Sleep    2
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Salesperson Tagging is Enabled and Salesperson Tagging is Mandatory in Policies after adding the product    ${pos_data}
    Revoke Serial Key    ${pos_data}

Zwing_ST_4 Salesperson Tagging Item Level
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_4
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Assign A Salesperson To An Item  ${pos_data}
    Verify If Salesperson Is Assigned To An Item    ${pos_data}
    Revoke Serial Key    ${pos_data}

Zwing_ST_5 Salesperson Tagging Bill Level
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_5
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Assign A Salesperson All Items   ${pos_data}
    Set Selenium Speed    1
    Verify Salesperson Tagged At Bill Level    ${pos_data}

Zwing_ST_6 Tag Single Salesperson To multiple Items
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_6
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Assign Same Salesperson To All Products Except Last Product And Verify   ${pos_data}

Zwing_ST_7 Tag Different salesperson for each item
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_7
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Assign A different Salesperson To Each Item  ${pos_data}
    Verify If Different Salesperson Was Assigned To Each Person

Zwing_ST_8 Change Salesperson tagging for item
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_8
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Assign A Salesperson All Items   ${pos_data}
    Verify Change Salesperson tagging for item    ${pos_data}

Zwing_ST_9 Change Salesperson tagging for bill
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_9
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Assign A Salesperson All Items   ${pos_data}
    Verify Change Salesperson tagging for bill   ${pos_data}

Zwing_ST_10 Tagged Sales person view below the tagged Item
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_10
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Assign A Salesperson All Items   ${pos_data}
    Set Selenium Speed    1
    Verify Salesperson Tagged At Bill Level    ${pos_data}

Zwing_ST_11
    Pass Execution
    #on hold from client side

Zwing_ST_12 Salesperson Tagging is Disabled in policies
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_10
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Verify Salesperson Tagging is Disabled
