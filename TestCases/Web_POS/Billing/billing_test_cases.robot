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

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}billing_test_data.xlsx

*** Test Cases ***
Zwing_B_1 Auto Switch To Billing
   [Tags]    Demo
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_1
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Auto Switch To Billing
   Verify Auto Switched To Billing
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_2 Add Product to cart by scanning barcode
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_2
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_03 Add Product to cart by searching Product Name / barcode
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_03
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Item Added In Cart
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_04 Add product from catalog
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_04
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Items In Cart | Catalog   ${pos_data}
    Verify Item Added In Cart
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_5 Add Multiple price products to cart
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_05
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart | Multiple MRP    ${pos_data}
     Verify Multiple Price Product Is Added
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_6 Tag a New customer to a bill
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_06
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_info}    Add Customer Details    ${pos_data}
    Verify Customer Tagging    ${customer_info}
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_7 Tag a Existing customer to a bill
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_07
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_info}    Add Customer Details for partial payment    ${pos_data}
    Verify Customer Tagging    ${customer_info}
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_08 Tag Single Sales Person To A Bill With Respect To Items
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_08
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Assign A Salesperson To An Item  ${pos_data}
    Verify If Salesperson Is Assigned To An Item    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_09 Tag Multiple Sales Person To A Bill With Respect To Items
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_09
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Assign A different Salesperson To Each Item  ${pos_data}
    Verify If Different Salesperson Was Assigned To Each Person
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_10 Hold On-going Bill | Billing
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_10
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Hold Bill
    Verify hold bill
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_11 View Held Bill
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_11
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Hold Bill
    View Held Bill
    Verify View Held Bill
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_12 Recall bill
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_12
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Hold Bill
    Recall Bill
    Verify Recall Bill
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_13 Discard to bill
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_13
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Hold Bill
    Discard Bill
    Verify Discard Bill
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_14 Return to bill
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_14
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Hold Bill
    Return To Bill
    Verify Return To Bill
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_15 Apply Item level Promos
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_15
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Level Promos
    Verify If Item Level Promos Applied
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_16 Apply manual Discount | item level
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_16
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Navigate To Update Product Window    ${pos_data}
    ${product_price}    Apply Item Manual Discount | Update Product Popup    ${pos_data}
    Apply Item Manual Discount | Select From List    ${pos_data}
    Verify Item Manual Discount     ${product_price}
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_17 Add Carry Bag
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_17
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Carry Bags    ${pos_data}
   Verify Item Added In Cart
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_18 Validate Bill calculation
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_18
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify If Bill Was Calculated | Net Price Same As Payable Amount
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_19 Reset Bill
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_19
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Reset Bill | Billing Module
   Verify Bill Is Reset
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_20 Navigate To CheckOut Page
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_20
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Add Customer Details    ${pos_data}
   Verify Billing Checkout
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_21 Collect payment by cash
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_21
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Payment By Cash   ${value}
    Verify If Payment is Complete Or Not
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_22 Collect payment by UPI
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_22
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Payment By Paytm   ${value}
    Verify If Payment is Complete Or Not
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_23 Collect payment by redeem voucher
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_23
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Split Payment By Redeem Voucher
    Verify If Payment is Complete Or Not
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_24 Collect payment using Credit Store
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_24
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Collect Payment Using Store Credit   ${pos_data}
    Verify If Payment is Complete Or Not
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_25 Collect payment using account sale
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_25
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Payment By Account On Sales   ${value}
    Verify If Payment is Complete Or Not
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_26 Payable amount should become editable when split payment toggle is enabled.
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_26
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout    
    Enable Split payment mode
    Verify split payment toggle button is enabled
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_27 Payable amount should be disabled when split payment toggle is disabled.
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_27
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Verify split payment toggle button is disabled.
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_28 Pay Bill Amount With multiple MOP
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_28
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Split Payment By Different Modes     ${pos_data}
    Verify If Payment is Complete Or Not
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_29 Pay Bill Amount With single MOP
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_29
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Split Payment By Paytm   ${value}
    Verify If Payment is Complete Or Not
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_30 Discard Bill after Partial payment
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_30
    Login With Valid Username And Password | POS   ${pos_data}
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
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_31 Automatic Invoice Generation
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_31
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Add Customer Details    ${pos_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Payment By Cash   ${value}
   Automatic Invoice Generation
   Verify Invoice Generated Automatically
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_32 Generate Invoice with Zero bill amount
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_32
    Login With Valid Username And Password | POS   ${pos_data}
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
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_B_33 Apply Bill level Promos
   ${pos_data}=    Fetch Testdata By Id   ${POS_TD}    TC_33
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Verify Item Added In Cart
   Add Customer Details    ${pos_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   Apply Bill Level Promos
   Verify Bill Level Promos Applied
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_34 Apply Bill level discount
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_34
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    ${bill_level}    Apply Bill Manual Discount | Custom Discount   ${pos_data}
    Verify Bill Level Manual Discount    ${bill_level}
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_35 Add Bill Remark
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_35
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Add Customer Details    ${pos_data}
   Verify Billing Checkout
   Add Bill Remarks   ${pos_data}
   Verify Bill Remark Added
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_36 Apply Bill Level Coupon
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_36
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Add Customer Details    ${pos_data}
   Verify Billing Checkout
   Apply Bill Coupon
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_37 Apply Bill Level Loyalty
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_37
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Add Customer Details    ${pos_data}
   Verify Billing Checkout
   Apply Bill Loyalty
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_38 Validate Account balance
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_38
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   ${customer_info}    Add Customer Details    ${pos_data}
   Validate Account Balance Are Equal On Tagged Customer Details and Checkout Page
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_39 Validate Store Credit
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_39
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   ${customer_info}    Add Customer Details    ${pos_data}
   Validate Store Credit Are Equal On Tagged Customer Details and Checkout Page
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_40 Validate Loyalty Points
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_40
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   ${customer_info}    Add Customer Details    ${pos_data}
   Validate Loyalty Points Are Equal On Tagged Customer Details and Checkout Page
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_41 Auto Switch To Billing From Return Mode
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_41
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Auto Switch To Billing
   Verify Auto Switched To Billing
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_B_42 Auto Switch To Billing From Exchange Mode
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_42
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Auto Switch To Billing
   Verify Auto Switched To Billing
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_43 Click on Confirm button on switch to Order popup box
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_43
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_44 Click on Cancel button on switch to Order popup box
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_44
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Verify Cancel Button While Switching Mode  ${pos_data}
   Verify Auto Switched To Billing
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_45 Switching Between Billing to Order Will Give Confirmation Popup
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_45
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Verify Cancel Button While Switching Mode  ${pos_data}
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_46 Click on Confirm button on switch to Return popup box
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_46
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_47 Click on Cancel button on switch to Return popup box
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_47
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Verify Cancel Button While Switching Mode  ${pos_data}
   Verify Auto Switched To Billing
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_48 Switching Between Billing to Return Will Give Confirmation Popup
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_48
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Verify Cancel Button While Switching Mode  ${pos_data}
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_49 Set variance limit and enter price override less or more than total price but within variance limit
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_49
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Price Overridden | Billing
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_50 Set variance limit and enter price override less or more than total price but out of variance limit
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_50
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Alert Message for Price Overridden | Billing
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_51 Set variance limit and enter price override less or more than total price but equal to variance limit
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_51
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Price Overridden | Billing
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_52 Set variance limit and enter price override less or more than total price but within variance limit. Then try again price override and check the response
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_52
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Price Override Link Is Disabled
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_53 Disable price override and try price overriding then check the response
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_53
   Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Verify Price Override Link Is Disabled
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}
