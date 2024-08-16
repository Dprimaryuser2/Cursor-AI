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
${QA_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Staging${/}Billing${/}share_invoice_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Production${/}Billing${/}share_invoice_test_data.xlsx

*** Test Cases ***
Zwing_SI_1 Add remarks in Add remark popup
  ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_01
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   Verify Billing Checkout
   Verify Bill Remark Added Is Visible In Bill Remark Textarea   ${share_data}
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_2 Clear the remarks using clear button
  ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_02
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   Verify Billing Checkout
   Verify The Clear Button Of Add Bill Remark   ${share_data}
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_3 Save the remarks using save button
  ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_03
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   Verify Billing Checkout
   Add Bill Remarks    ${share_data}
   Verify Bill Remark Added
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_4 Click outside the add remarks popup without saving or clearing the remarks
  ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_04
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   Verify Billing Checkout
   Verify Bill Remark Added Is Visible In Bill Remark Textarea   ${share_data}
   Verify Remark Is Auto-Populated When Click Outside of Add Remark Popup Window   ${share_data}
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_5 Close the add remarks popup using X button
   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_05
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   Verify Billing Checkout
   Verify Bill Remark Added Is Visible In Bill Remark Textarea   ${share_data}
   Verify Remark Is Auto-Populated When Click On Close Icon of Add Remark Popup Window  ${share_data}
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_6 After checkout click on Print Invoice button
   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_06
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify The Print Invoice Button
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_7 Close the Invoice preview using close button
  ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_07
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify The Print Invoice Button
   Verify The Close Invoice Button
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_8 Click on Print button in Invoice preview popup to redirect to final print preview page
  ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_08
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   ${cust_info_checkout}  Automatic Invoice Generation
   Verify The Print Invoice Button
   ${cust_info_invoice}   Get Customer Details | Print Invoice
   Verify Customer Details | Print Invoice  ${cust_info_checkout}    ${cust_info_invoice}
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_9 Click on share invoice button to open share invoice popup
   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_09
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify The Share Invoice Button
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_10 Close share invoice pop up using X button
  ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_10
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify The Share Invoice Button
   Verify The Close Icon | Share Invoice
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_11 Navigate from email id tab to phone No. tab and vice versa in share invoice popup
   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_11
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify The Share Invoice Button
   Navigate from email id tab to phone No. tab  ${share_data}
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_12 Validate the phone No. should get auto populated with the no. tagged while customer tagging
   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_12
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify The Share Invoice Button
   Verify Customer Number Is Auto-Populated | Share Invoice
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_13 Validate the Email address should get auto populated with the Email id tagged while customer tagging
   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_13
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify The Share Invoice Button
   Verify Customer Email Is Auto-Populated | Share Invoice   ${share_data}
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_14 Update the phone No. while sharing the Invoice
   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_14
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify The Share Invoice Button
   Update The Phone No. While Sharing The Invoice  ${share_data}
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_15 While updating the phoneNo, send button should be disabled and error message should be displayed if phoneNo is not of 10 characters
   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_15
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify The Share Invoice Button
   Verify Alert Message Is Displayed For Invalid Number | Share Invoice   ${share_data}
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_16 Update the Email address while sharing the Invoice
  ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_16
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify The Share Invoice Button
   Update The Email While Sharing The Invoice  ${share_data}
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_17 While updating the Email address, send button should be disabled and error message should be displayed if emailId is not valid. Valid format.
   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_17
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify The Share Invoice Button
   Verify Alert Message Is Displayed For Invalid Email | Share Invoice  ${share_data}
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

#Zwing_SI_18 Send Invoice using phone No.

Zwing_SI_19 Send Invoice using email Id.
   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_19
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
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
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_20 Navigate to billing page using new bill button on checkout page
  ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_20
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
   Add Customer Details | Share Invoice    ${share_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify New Bill Button
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

Zwing_SI_21 Update the Email address while sharing the Invoice and send invoice
  ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${share_data}=  Fetch Testdata By Id    ${POS_TD}    SI_21
     ${response}=  Login With Valid Username And Password | POS    ${share_data}
   Open The Session    ${share_data}
   Add Product By Scan Only   ${share_data}
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
  [Teardown]   Revoke Licence Key | API   ${response}       ${share_data}

#Zwing_SI_22 Update the phone No. while sharing the Invoice and send invoice