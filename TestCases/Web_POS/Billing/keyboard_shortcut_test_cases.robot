*** Settings ***
Library    SeleniumLibrary

Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/promo_keyword.robot
Resource  ../../../Resources/Web_POS/POS/keyboard_shortcut_keywords.robot

Test Setup    Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}keyboard_shortcuts_test_data.xlsx

*** Test Cases ***

TC_01 Search product using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_01
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Allows Searching Product    ${pos_data}

TC_02 view/Hide product using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_02
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Displays Catalogue Window

TC_03 Refresh catalog using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_03
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Allows Updating Catalogue

TC_04 view Salesperson using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_04
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Key Displays Salesperson Details

TC_05 view held bills using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_05
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Key Allows Navigating To Held Bills

TC_06 Hold the current bill using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_06
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Key Holds Bill

TC_07 Add manual discount using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_07
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Key Allows Adding Manual Discount

TC_08 Add Carry bags using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_08
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Key Allows Adding Carry Bags

TC_09 Tag a customer using keyboard shortcut before tagging a customer
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_09
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Verify Shortcut Key Allows Tagging Customer    ${pos_data}

TC_10 Tag a customer using keyboard shortcut after tagging a customer
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_10
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Key Allows Tagging Customer    ${pos_data}

TC_11 Cancel current bill using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_11
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Key Clears The Cart

TC_12 Checkout bill using keyboard shortcut when ST is optional
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_12
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Navigates To Checkout Page

TC_13 Checkout bill using keyboard shortcut when ST is mandatory
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_13
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Navigates To Checkout Page When ST Is Mandatory

TC_14 Checkout bill using keyboard shortcut without tagging customer
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_14
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Navigates To Checkout Page When CT Is Mandatory

TC_15 Checkout using shortcut before opening session
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_15
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Verify Shortcut Navigates To Checkout Page When Session Is Closed

TC_16 Search product using keyboard shortcut | Order Mode
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_16
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Navigate To Order Mode
    Verify Shortcut Key Allows Searching Product | Order Mode


