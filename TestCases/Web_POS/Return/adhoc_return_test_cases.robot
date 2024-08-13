*** Settings ***
Library    SeleniumLibrary
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/salesperson_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Return/adhoc_return_keywords.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Library    ../../../Resources/CustomKeywords/utilities.py
Resource    ../../../Resources/Web_POS/POS/Billing/split_payment_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/manual_discount_keyword.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
#${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Return${/}adhoc_return_test_data.xlsx
${QA_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Staging${/}Return${/}adhoc_return_test_data_old.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Production${/}Return${/}adhoc_return_test_data_old.xlsx

*** Test Cases ***

Zwing_R_1 Return should be mark enable in policies
   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_1
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Verify Return mark enable in policies    ${pos_data}
   Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_R_2 While Return is off in Policies
   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_2
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Verify Mode Is Disabled    ${pos_data}
   Revoke Licence Key | API   ${response}      ${pos_data}

#Zwing_R_3 When Auto Switch to billing is On
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_3
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Turn Auto Switch To Billing On
#   Auto Switch To Billing
#   Verify Auto Switched To Billing
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#Zwing_R_4 When Auto Switch to billing is Off
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_4
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Turn Auto Switch To Billing Off
#   Change Billing Mode    ${pos_data}
#   Turn Auto Switch To Billing On
#   Verify Auto Switch to billing is Off
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#Zwing_R_5 Adding product by scanning the Barcode
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_5
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Verify Add product
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#Zwing_R_6 Add items to Return by searching the barcode or name of Item
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_6
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Verify Add product
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#Zwing_R_7 Add items to Return by catalog
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_7
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Add Items In Cart | Catalog    ${pos_data}
#   Verify Add product
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#Zwing_R_8 Add Salesperson with return item
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_8
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Assign A Salesperson To An Item    ${pos_data}
#   Verify If Salesperson Is Assigned To An Item    ${pos_data}
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#Zwing_R_9 Add item qty by scanning
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_9
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Verify Quantity Increased
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#Zwing_R_10 Add Qty to the added item
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_10
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Verify Quantity Increased
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#Zwing_R_11 Add items to Return by catalog
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_11
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Add Items In Cart | Catalog    ${pos_data}
#   Verify Add Product
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#Zwing_R_12 Add Qty to the added item
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_12
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Verify Add Product
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_13 Remove item to the cart
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_13
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Delete Item In The Cart
#   Verify Remove item to the cart
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_14 Assign Salesperson to product While returning the product
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_14
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Verify Assign Same Salesperson To All Products Except Last Product    ${pos_data}
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_15 Assign customer to the return when customer Tagging is mandatory
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_15
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   ${customer_details}    Add Customer Details    ${pos_data}
#   Verify Customer Tagging    ${customer_details}
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_16 Assign customer to the return when customer Tagging is optional in policies
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_16
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   ${customer_details}    Add Customer Details    ${pos_data}
#   Verify Customer Tagging    ${customer_details}
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_17 Apply Customized Manual Discount item level
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_17
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Navigate To Update Product Window    ${pos_data}
#   ${product_price}    Apply Item Manual Discount | Update Product Popup    ${pos_data}
#   Apply Item Manual Discount | Select From List    ${pos_data}
#   Verify Item Manual Discount   ${product_price}
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_18 Apply Customised Manual Discount item level
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_18
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Navigate To Update Product Window    ${pos_data}
#   ${product_price}    Apply Item Manual Discount | Update Product Popup    ${pos_data}
#   Apply Item Manual Discount | Select From List    ${pos_data}
#   Verify Item Manual Discount   ${product_price}
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_19 Apply Customised Manual Discount item level by Fixed amount in item level
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_19
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Navigate To Update Product Window    ${pos_data}
#   ${product_price}    Apply Item Manual Discount | Update Product Popup    ${pos_data}
#   Apply Item Manual Discount | Custom Discount    ${pos_data}
#   Verify Item Manual Discount   ${product_price}
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_20 Apply Customised Manual Discount item level by percentage item level
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_20
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Navigate To Update Product Window    ${pos_data}
#   ${product_price}    Apply Item Manual Discount | Update Product Popup    ${pos_data}
#   Apply Item Manual Discount | Custom Discount    ${pos_data}
#   Verify Item Manual Discount   ${product_price}
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_21 Apply Item level Promo
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_21
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Apply Item Level Promos
#   Verify If Item Level Promos Applied
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_22 Check out from POS screen to Payment Collection
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_22
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Verify Billing Checkout
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_23 Allow Refund Against Returned Item | Refund Through Cash only
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_23
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Verify Billing Checkout
#   Pay By Cash | Return Mode
#   Verify If Payment Is Complete Or Not
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_24 Allow Refund Against Returned Item | Refund Through Credit Note
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_24
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Navigate To Checkout Page
#   Pay Through Store Credit Method
#   Verify If Payment Is Complete Or Not
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_25 Allow Refund Against Returned Item | Refund Through both credit note and cash
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_25
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#   Navigate To Checkout Page
#   Pay Through Store Credit Method
#   Verify If Payment Is Complete Or Not
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_26 Click on Confirm button on switch to Billing popup box
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_26
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Auto Switch To Billing
#   Verify Auto Switch To Billing
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_27 Click on Cancel button on switch to Billing popup box
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_27
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Cancel Auto Switch To Billing
#   Verify Billing Mode Present
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_28 Switching Between Return to Billing Will Give Confirmation Popup
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_28
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Auto Switch To Billing
#   Verify Auto Switch To Billing
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_29 Click on Confirm button on switch to Order popup box
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_29
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Switch From Return Mode To Order
#   Verify Switch To Order Mode
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_30 Click on Cancel button on switch to Order popup box
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_30
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Cancel Switch From Return Mode To Order
#   Verify Return Mode Present
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#
#Zwing_R_31 Switching Between Return to Order Will Give Confirmation Popup
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_31
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Switch From Return Mode To Order
#   Verify Switch To Order Mode
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#Zwing_R_32 Click on Confirm button on switch to Exchange popup box
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_32
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Switch From Return Mode To Exchange
#   Verify Exchange Mode Present
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#Zwing_R_33 Click on Cancel button on switch to Exchange popup box
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_33
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Cancel Switch From Return Mode To Exchange
#   Verify Return Mode Present
#   Revoke Licence Key | API   ${response}      ${pos_data}
#
#Zwing_R_34 Switching Between Return to Exchange Will Give Confirmation Popup
#   ${POS_TD}=    Get Test Data File    ${ENV}   ${QA_TD}  ${PROD_TD}
#   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_34
#   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
#   Open The Session    ${pos_data}
#   Change Billing Mode    ${pos_data}
#   Switch From Return Mode To Exchange
#   Verify Exchange Mode Present
#   Revoke Licence Key | API   ${response}      ${pos_data}