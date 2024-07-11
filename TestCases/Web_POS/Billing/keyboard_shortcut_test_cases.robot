*** Settings ***
Library    SeleniumLibrary

Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/promo_keyword.robot
Resource  ../../../Resources/Web_POS/POS/keyboard_shortcut_keywords.robot
Resource  ../../../Resources/Web_POS/POS/billing_keyword.robot

Test Setup    Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}keyboard_shortcuts_test_data.xlsx

*** Test Cases ***
Zwing_KB_01 Search product using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_1
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Allows Searching Product    ${pos_data}

Zwing_KB_02 view/Hide product using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_02
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Displays Catalogue Window

Zwing_KB_03 Refresh catalog using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_03
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Press Shortcut Key    ${pos_data}
    Verify Shortcut Key Allows Updating Catalogue

Zwing_KB_04 view Salesperson using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_04
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Key Displays Salesperson Details

Zwing_KB_05 view held bills using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_05
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Key Allows Navigating To Held Bills

Zwing_KB_06 Hold the current bill using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_06
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Key Holds Bill

Zwing_KB_07 Add manual discount using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_07
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Key Allows Adding Manual Discount

Zwing_KB_08 Add Carry bags using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_08
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Key Allows Adding Carry Bags

Zwing_KB_09 Tag a customer using keyboard shortcut before tagging a customer
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_09
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Verify Shortcut Key Allows Tagging Customer    ${pos_data}

Zwing_KB_10 Tag a customer using keyboard shortcut after tagging a customer
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_10
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Key Allows Tagging Customer    ${pos_data}

Zwing_KB_11 Cancel current bill using keyboard shortcut
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_11
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Key Clears The Cart

Zwing_KB_12 Checkout bill using keyboard shortcut when ST is optional
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_12
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Navigates To Checkout Page

Zwing_KB_13 Checkout bill using keyboard shortcut when ST is mandatory
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_13
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Navigates To Checkout Page When ST Is Mandatory

Zwing_KB_14 Checkout bill using keyboard shortcut without tagging customer
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_14
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Shortcut Navigates To Checkout Page When CT Is Mandatory

Zwing_KB_15 Checkout using shortcut before opening session
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_15
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Verify Shortcut Navigates To Checkout Page When Session Is Closed

Zwing_KB_16 Search product using keyboard shortcut | Order Mode
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_16
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switched To Billing
    Verify Shortcut Key Allows Searching Product | Order Mode

Zwing_KB_17 View/Hide product using keyboard shortcut | Order Mode
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_17
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switched To Billing

Zwing_KB_18 Refresh catalog using keyboard shortcut | Order Mode
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_18
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switched To Billing

Zwing_KB_19 view Salesperson using keyboard shortcut | Order Mode
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_19
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switched To Billing

Zwing_KB_20 Add manual discount using keyboard shortcut | Order Mode
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_20
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switched To Billing

Zwing_KB_21 Add Carry bags using keyboard shortcut | Order Mode
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_21
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switched To Billing

Zwing_KB_22 On Order screen before tagging a customer, press Ctrl + A | Order Mode
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_22
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switched To Billing

Zwing_KB_23 On Order screen after tagging a customer, press Ctrl + A | Order Mode
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_23
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switched To Billing

Zwing_KB_24 Cancel current bill using keyboard shortcut on Order Screen | Order Mode
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_24
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switched To Billing

Zwing_KB_25 Checkout bill using keyboard shortcut-After adding product when policies for salesperson and customer tagging is optional, press Ctrl + B on Order Screen
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_25
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switched To Billing

Zwing_KB_26 Checkout bill using keyboard shortcut-Without tagging salesperson when policy for salesperson is mandatory, press Ctrl + B on Order Screen
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_26
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switched To Billing

Zwing_KB_27 Checkout bill using keyboard shortcut-Without tagging customer when policy for customer is mandatory, press Ctrl + B on Order Screen
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_27
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switched To Billing

Zwing_KB_28 Checkout using shortcut before opening session | Order Mode
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_28
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switched To Billing

Zwing_KB_29 Search product using keyboard shortcut On Return Screen
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_29
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switched To Billing

Zwing_KB_30 View/Hide product using keyboard shortcut On Return Screen
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    KB_30
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switched To Billing