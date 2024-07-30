*** Settings ***
Library    SeleniumLibrary
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Library   ../../../Resources/CustomKeywords/utilities.py
Resource    ../../../Resources/Web_POS/POS/Billing/product_catalog_keywords.robot
Resource   ../../../Resources/Web_POS/POS/Billing/carry_bag_keyword.robot
Resource   ../../../Resources/Web_POS/POS/Billing/share_invoice_keywords.robot

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
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

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
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

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
   ${cust_info_checkout}  Automatic Invoice Generation
   Verify The Print Invoice Button
   ${cust_info_invoice}   Get Customer Details | Print Invoice
   Verify Customer Details | Print Invoice  ${cust_info_checkout}    ${cust_info_invoice}
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

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
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

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
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

Zwing_SI_11 Navigate from email id tab to phone No. tab and vice versa in share invoice popup
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_11
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
   Navigate from email id tab to phone No. tab  ${share_data}
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

Zwing_SI_12 Validate the phone No. should get auto populated with the no. tagged while customer tagging
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_12
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
   Verify Customer Number Is Auto-Populated | Share Invoice
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

Zwing_SI_13 Validate the Email address should get auto populated with the Email id tagged while customer tagging
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_13
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
   Verify Customer Email Is Auto-Populated | Share Invoice   ${share_data}
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

Zwing_SI_14 Update the phone No. while sharing the Invoice
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_14
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
   Update The Phone No. While Sharing The Invoice  ${share_data}
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

Zwing_SI_15 While updating the phoneNo, send button should be disabled and error message should be displayed if phoneNo is not of 10 characters
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_15
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
   Verify Alert Message Is Displayed For Invalid Number | Share Invoice   ${share_data}
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

Zwing_SI_16 Update the Email address while sharing the Invoice
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_16
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
   Update The Email While Sharing The Invoice  ${share_data}
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

Zwing_SI_17 While updating the Email address, send button should be disabled and error message should be displayed if emailId is not valid. Valid format.
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_17
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
   Verify Alert Message Is Displayed For Invalid Email | Share Invoice  ${share_data}
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

#Zwing_SI_18 Send Invoice using phone No.

Zwing_SI_19 Send Invoice using email Id.
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_19
   Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Verify Item Added In Cart
   ${store_name}  Get Store Name | Web POS
   Add Customer Details | Share Invoice    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   ${cust_info_checkout}  Automatic Invoice Generation
   Verify The Share Invoice Button
   Verify Customer Email Is Auto-Populated | Share Invoice   ${share_data}
   Send Invoice To Email | Share Invoice
   Verify Invoice Generated Received On Email  ${store_name}    ${cust_info_checkout}
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

Zwing_SI_20 Navigate to billing page using new bill button on checkout page
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_20
   Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Verify Item Added In Cart
   Add Customer Details | Share Invoice    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify New Bill Button
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

Zwing_SI_21 Update the Email address while sharing the Invoice and send invoice
   ${share_data}=  Fetch Testdata By Id   ${share_td}    SI_21
   Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Verify Item Added In Cart
   ${store_name}  Get Store Name | Web POS
   Add Customer Details | Share Invoice    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   ${cust_info_checkout}  Automatic Invoice Generation
   Verify The Share Invoice Button
   Update The Email While Sharing The Invoice  ${share_data}
   Send Invoice To Email | Share Invoice
   Verify Invoice Generated Received On Email  ${store_name}    ${cust_info_checkout}
   Revoke Serial Key    ${share_data}
   [Teardown]    Tear It Down If Test Case Failed    ${share_data}

#Zwing_SI_22 Update the phone No. while sharing the Invoice and send invoice