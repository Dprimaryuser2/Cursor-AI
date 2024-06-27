*** Settings ***
Library    SeleniumLibrary
Library    ../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/promo_keyword.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}billing_test_data.xlsx

*** Test Cases ***
Zwing_B_1 Auto Switch To Billing
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_66
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Auto Switch To Billing
   Verify Auto Switched To Billing

Zwing_B_2 Add Product to cart by scanning barcode
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_64
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Click On First Product Row
   Verify Item Added In Cart

Zwing_B_5 Add Multiple price products to cart
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_05
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart | Multiple MRP    ${pos_data}
     Verify Multiple Price Product Is Added

Zwing_B_6 Tag a New customer to a bill
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_06
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_info}    Add Customer Details    ${pos_data}
    Verify Customer Tagging    ${customer_info}

Zwing_B_7 Tag a Existing customer to a bill
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_07
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_info}    Add Customer Details for partial payment    ${pos_data}
    Verify Customer Tagging    ${customer_info}

Zwing_B_10 Hold On-going Bill | Billing
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_10
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Hold Bill
    Verify hold bill

Zwing_B_11 View Held Bill
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_11
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Hold Bill
    View Held Bill
    Verify View Held Bill

Zwing_B_12 Recall bill
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_12
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Hold Bill
    Recall Bill
    Verify Recall Bill

Zwing_B_13 Discard to bill
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_13
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Hold Bill
    Discard Bill
    Verify Discard Bill

Zwing_B_14 Return to bill
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_14
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Hold Bill
    Return To Bill
    Verify Return To Bill

Zwing_B_16 Apply manual Discount | item level
    ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_16
    Login With Valid Username And Password | POS   ${discount_data}
    Open The Session    ${discount_data}
    Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
    Navigate To Update Product Window    ${discount_data}
    ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
    Apply Item Manual Discount | Select From List    ${discount_data}
    Verify Item Manual Discount   ${product_price}

Zwing_B_17 Add Carry Bag
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_63
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Carry Bags    ${pos_data}
   Verify Item Added In Cart

Zwing_B_19 Reset Bill
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_65
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Reset Bill | Billing Module
   Verify Bill Is Reset

Zwing_B_20 Navigate To CheckOut Page
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_71
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Add Customer Details    ${pos_data}
   Verify Billing Checkout

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

Zwing_B_23 Collect payment by redeem voucher
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_23
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Split Payment By Reedem Voucher
    Verify If Payment is Complete Or Not

Zwing_B_24 Collect payment using Credit Score
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_24
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Collect Payment Using Store Credit  ${pos_data}
    Verify If Payment is Complete Or Not

Zwing_B_25 Collect payment using account sale
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_25
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Payment By Account On Sales
    Verify If Payment is Complete Or Not

Zwing_B_26 Payable amount should become editable when split payment toggle is enabled.
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_26
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Verify split payment toggle button is eneabled

Zwing_B_27 Payable amount should be disabled when split payment toggle is disabled.
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_27
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Verify split payment toggle button is disabled.

Zwing_B_28 Pay Bill Amount With multiple MOP
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_28
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Split Payment By Diffrent Modes     ${pos_data}
    Verify If Payment is Complete Or Not

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

Zwing_B_31 Automatic Invoice Generation
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_84
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

Zwing_B_34 Apply Bill level discount
    ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_34
    Login With Valid Username And Password | POS   ${discount_data}
    Open The Session    ${discount_data}
    Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
    Add Customer Details    ${discount_data}
    Verify Billing Checkout
    ${bill_level}    Apply Bill Manual Discount | Custom Discount    ${discount_data}
    Verify Bill Level Manual Discount    ${bill_level}

Zwing_B_35 Add Bill Remark
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_70
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Add Customer Details    ${pos_data}
   Verify Billing Checkout
   Add Bill Remarks   ${pos_data}
   Verify Bill Remark Added

Zwing_B_36 Apply Bill Level Coupon
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_69
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Add Customer Details    ${pos_data}
   Verify Billing Checkout
   Apply Bill Coupon

Zwing_B_37 Apply Bill Level Loyalty
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_68
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Add Customer Details    ${pos_data}
   Verify Billing Checkout
   Apply Bill Loyalty

Zwing_B_41 Auto Switch To Billing From Return Mode
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_72
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Auto Switch To Billing
   Verify Auto Switched To Billing

Zwing_B_42 Auto Switch To Billing From Exchange Mode
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_73
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Auto Switch To Billing
   Verify Auto Switched To Billing

Zwing_B_43 Click on Confirm button on switch to Order popup box
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_74
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}

Zwing_B_44 Click on Cancel button on switch to Order popup box
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_75
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Verify Cancel Button While Switching Mode  ${pos_data}
   Verify Auto Switched To Billing

Zwing_B_45 Switching Between Billing to Order Will Give Confirmation Popup
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_76
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Verify Cancel Button While Switching Mode  ${pos_data}

Zwing_B_46 Click on Confirm button on switch to Return popup box
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_77
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}

Zwing_B_47 Click on Cancel button on switch to Return popup box
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_78
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Verify Cancel Button While Switching Mode  ${pos_data}
   Verify Auto Switched To Billing

Zwing_B_48 Switching Between Billing to Return Will Give Confirmation Popup
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_79
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Verify Cancel Button While Switching Mode  ${pos_data}

Zwing_B_49 Set variance limit and enter price override less or more than total price but within variance limit
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_80
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Click On First Product Row
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Price Overriden | Billing

Zwing_B_50 Set variance limit and enter price override less or more than total price but out of variance limit
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_81
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Click On First Product Row
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Alert Message for Price Overriden | Billing

Zwing_B_51 Set variance limit and enter price override less or more than total price but equal to variance limit
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_67
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Verify Item Added In Cart
   Click On First Product Row
   Price Override | Billing    ${pos_data}
   Verify Price Overriden | Billing

Zwing_B_52 Set variance limit and enter price override less or more than total price but within variance limit. Then try again price override and check the response
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_82
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Click On First Product Row
   Verify Item Added In Cart
   Price Override | Billing    ${pos_data}
   Verify Price Override Link Is Disabled

Zwing_B_53 Disable price override and try price overriding then check the response
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    TC_83
   Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Add Product By Scan Only   ${pos_data}
   Click On First Product Row
   Verify Item Added In Cart
   Verify Price Override Link Is Disabled
