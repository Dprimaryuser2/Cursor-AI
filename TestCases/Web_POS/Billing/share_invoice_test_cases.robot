*** Settings ***
Library    SeleniumLibrary
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/promo_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Library   ../../../Resources/CustomKeywords/utilities.py
Resource    ../../../Resources/Web_POS/POS/product_catalog_keywords.robot
Resource   ../../../Resources/Web_POS/POS/carry_bag_keyword.robot
Resource   ../../../Resources/Web_POS/POS/share_invoice_keywords.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${share_td}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}share_invoice_test_data.xlsx

*** Test Cases ***
Zwing_SI_1 Add remarks in Add remark popup
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_01
   Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Verify Item Added In Cart
   Add Customer Details    ${share_data}
   Verify Billing Checkout
   Verify Bill Remark Added Is Visible In Bill Remark Textarea   ${share_data}
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

Zwing_SI_2 Clear the remarks using clear button
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_02
   Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Verify Item Added In Cart
   Add Customer Details    ${share_data}
   Verify Billing Checkout
   Verify The Clear Button Of Add Bill Remark   ${share_data}
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

Zwing_SI_3 Save the remarks using save button
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_03
   Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Verify Item Added In Cart
   Add Customer Details    ${share_data}
   Verify Billing Checkout
   Add Bill Remarks    ${share_data}
   Verify Bill Remark Added
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

Zwing_SI_4 Click outside the add remarks popup without saving or clearing the remarks
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_04
   Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Verify Item Added In Cart
   Add Customer Details    ${share_data}
   Verify Billing Checkout
   Verify Bill Remark Added Is Visible In Bill Remark Textarea   ${share_data}
   Verify Remark Is Auto-Populated When Click Outside of Add Remark Popup Window   ${share_data}
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

Zwing_SI_5 Close the add remarks popup using X button
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_05
   Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Verify Item Added In Cart
   Add Customer Details    ${share_data}
   Verify Billing Checkout
   Verify Bill Remark Added Is Visible In Bill Remark Textarea   ${share_data}
   Verify Remark Is Auto-Populated When Click On Close Icon of Add Remark Popup Window  ${share_data}
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

Zwing_SI_6 After checkout click on Print Invoice button
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_06
   Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Verify Item Added In Cart
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify The Print Invoice Button

Zwing_SI_7 Close the Invoice preview using close button
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_07
   Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Verify Item Added In Cart
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify The Print Invoice Button
   Verify The Close Invoice Button

Zwing_SI_8 Click on Print button in Invoice preview popup to redirect to final print preview page
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_08
   Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Verify Item Added In Cart
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify The Print Invoice Button
   Verify The Print Button | Print Invoice

Zwing_SI_9 Click on share invoice button to open share invoice popup
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_09
   Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Verify Item Added In Cart
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify The Share Invoice Button

Zwing_SI_10 Close share invoice pop up using X button
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_10
   Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Verify Item Added In Cart
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify The Share Invoice Button
   Verify The Close Icon | Share Invoice

Zwing_SI_11