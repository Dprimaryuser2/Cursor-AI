*** Settings ***
Library    SeleniumLibrary
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Library    ../../../Resources/CustomKeywords/utilities.py
Resource    ../../../Resources/Web_POS/POS/Billing/split_payment_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/manual_discount_keyword.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

#*** Variables ***
#${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}billing_test_data.xlsx

*** Variables ***
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Billing${/}billing_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Billing${/}billing_test_data.xlsx

*** Test Cases ***
Zwing_B_01 Auto Switch To Billing
   [Tags]    Demo
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_01
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Auto Switch To Billing
   Verify Auto Switched To Billing
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_02 Add Product to cart by scanning barcode
    [Tags]    retry
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_02
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_03 Add Product to cart by searching Product Name / barcode
    [Tags]    retry
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_03
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Item Added In Cart
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_04 Add product from catalog
    [Tags]    retry
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_04
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Items In Cart | Catalog   ${pos_data}
    Verify Item Added In Cart
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_05 Add Multiple price products to cart
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_05
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart | Multiple MRP    ${pos_data}
    Verify Multiple Price Product Is Added
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_06 Tag a New customer to a bill
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_06
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_info}    Add Customer Details    ${pos_data}
    Verify Customer Tagging    ${customer_info}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_07 Tag a Existing customer to a bill
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_07
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_info}    Add Customer Details for partial payment    ${pos_data}
    Verify Customer Tagging    ${customer_info}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_08 Tag Single Sales Person To A Bill With Respect To Items
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_08
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Assign A Salesperson To An Item  ${pos_data}
    Verify If Salesperson Is Assigned To An Item    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_09 Tag Multiple Sales Person To A Bill With Respect To Items
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_09
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Assign A different Salesperson To Each Item  ${pos_data}
    Verify If Different Salesperson Was Assigned To Each Person
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_10 Hold On-going Bill | Billing
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_10
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Hold Bill
    Verify hold bill
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_11 View Held Bill
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_11
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Hold Bill
    View Held Bill
    Verify View Held Bill
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_12 Recall bill
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_12
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Hold Bill
    Recall Bill
    Verify Recall Bill
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_13 Discard Bill
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_13
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Hold Bill
    Discard Bill
    Verify Discard Bill
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_14 Return To Bill
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_14
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Hold Bill
    Return To Bill
    Verify Return To Bill
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_15 Apply Item level Promos
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_15
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Level Promos
    Verify If Item Level Promos Applied
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_16 Apply manual Discount | item level
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_16
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Navigate To Update Product Window    ${pos_data}
    ${product_price}    Apply Item Manual Discount | Update Product Popup    ${pos_data}
    Apply Item Manual Discount | Select From List    ${pos_data}
    Verify Item Manual Discount     ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_17 Add Carry Bag
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_17
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Add Carry Bags    ${pos_data}
   Verify Item Added In Cart
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_18 Validate Bill calculation
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_18
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify If Bill Was Calculated | Net Price Same As Payable Amount
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_19 Reset Bill
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_19
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Reset Bill | Billing Module
   Verify Bill Is Reset
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_20 Navigate To CheckOut Page
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_20
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Add Customer Details    ${pos_data}
   Verify Billing Checkout
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_21 Collect payment by cash
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_21
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Payment By Cash   ${value}
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_22 Collect payment by UPI
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_22
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Payment By Paytm   ${value}
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_23 Collect payment by redeem voucher
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_23
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Split Payment By Redeem Voucher
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_24 Collect payment using Credit Store
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_24
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Collect Payment Using Store Credit   ${pos_data}
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_25 Collect payment by on account sale
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_25
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Payment By Account On Sales   ${value}
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_26 Payable amount should become editable when split payment toggle is enabled.
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_26
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Verify split payment toggle button is enabled
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_27 Payable amount should be disabled when split payment toggle is disabled.
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_27
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Verify split payment toggle button is disabled.
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_28 Pay Bill Amount With multiple MOP
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_28
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Split Payment By Different Modes     ${pos_data}
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_29 Pay Bill Amount With single MOP
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_29
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Split Payment By Paytm   ${value}
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_30 Discard Bill after Partial payment
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_30
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details for partial payment    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Partial Payment   ${value}
    Click On Back Button | Checkout
    Discard Bill | Checkout
    Verify Discard Bill After Partial Payment
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_31 Automatic Invoice Generation
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_31
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Add Customer Details    ${pos_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify Invoice Generated Automatically
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_32 Generate Invoice with Zero bill amount
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_32
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Navigate To Update Product Window   ${pos_data}
    Apply Item Manual Discount | Update Product Popup   ${pos_data}
    Apply Item Manual Discount | Select From List  ${pos_data}
    Click On Update Product | Manual Discount
    ${value}    Get payable amount
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    No Payment Required | Checkout Page
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_B_33 Apply Bill level Promos
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id   ${POS_TD}    TC_33
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Verify Item Added In Cart
   Add Customer Details    ${pos_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Apply Bill Level Promos
   Verify Bill Level Promos Applied
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_34 Apply Bill level discount
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_34
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    ${bill_level}    Apply Bill Manual Discount | Custom Discount   ${pos_data}
    Verify Bill Level Manual Discount    ${bill_level}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_35 Add Bill Remark
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_35
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Add Customer Details    ${pos_data}
   Verify Billing Checkout
   Add Bill Remarks   ${pos_data}
   Verify Bill Remark Added
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_36 Apply Bill Level Coupon
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_36
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Add Customer Details    ${pos_data}
   Verify Billing Checkout
   Apply Bill Coupon
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_37 Apply Bill Level Loyalty
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_37
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Add Customer Details    ${pos_data}
   Verify Billing Checkout
   Apply Bill Loyalty
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_38 Validate Account balance
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_38
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   ${customer_info}    Add Customer Details    ${pos_data}
   Validate Account Balance Are Equal On Tagged Customer Details and Checkout Page
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_39 Validate Store Credit
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_39
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   ${customer_info}    Add Customer Details    ${pos_data}
   Validate Store Credit Are Equal On Tagged Customer Details and Checkout Page
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_40 Validate Loyalty Points
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_40
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   ${customer_info}    Add Customer Details    ${pos_data}
   Validate Loyalty Points Are Equal On Tagged Customer Details and Checkout Page
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_41 Auto Switch To Billing From Return Mode
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_41
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Auto Switch To Billing
   Verify Auto Switched To Billing
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_B_42 Auto Switch To Billing From Exchange Mode
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_42
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Auto Switch To Billing
   Verify Auto Switched To Billing
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_43 Click on Confirm button on switch to Order popup box
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_43
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_44 Click on Cancel button on switch to Order popup box
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_44
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Verify Cancel Button While Switching Mode  ${pos_data}
   Verify Auto Switched To Billing
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_45 Switching Between Billing to Order Will Give Confirmation Popup
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_45
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Verify Cancel Button While Switching Mode  ${pos_data}
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_46 Click on Confirm button on switch to Return popup box
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_46
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_47 Click on Cancel button on switch to Return popup box
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_47
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Verify Cancel Button While Switching Mode  ${pos_data}
   Verify Auto Switched To Billing
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_48 Switching Between Billing to Return Will Give Confirmation Popup
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_48
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Verify Cancel Button While Switching Mode  ${pos_data}
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_49 Set variance limit and enter price override less or more than total price but within variance limit
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_49
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Price Overridden | Billing
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_50 Set variance limit and enter price override less or more than total price but out of variance limit
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_50
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Alert Message for Price Overridden | Billing
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_51 Set variance limit and enter price override less or more than total price but equal to variance limit
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_51
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Price Overridden | Billing
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_52 Set variance limit and enter price override less or more than total price but within variance limit. Then try again price override and check the response
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_52
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Price Override Link Is Disabled
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_B_53 Disable price override and try price overriding then check the response
   ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
   ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_53
   ${response}=  Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Verify Price Override Link Is Disabled
   [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}
