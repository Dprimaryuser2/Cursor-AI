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
Resource    ../../../Resources/Web_POS/POS/Return/payment_return_keywords.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Return${/}adhoc_return_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Return${/}adhoc_return_test_data.xlsx
${response}=    'NULL'

*** Test Cases ***
Zwing_R_1 Return should be mark enable in policies
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_1
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify Return mark enable in policies    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_2 While Return is off in Policies
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_2
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Verify Mode Is Disabled    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_3 When Auto Switch to billing is On
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_3
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Turn Auto Switch To Billing On
    Auto Switch To Billing
    Verify Auto Switched To Billing
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_4 When Auto Switch to billing is Off
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_4
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Turn Auto Switch To Billing Off
    Change Billing Mode    ${pos_data}
    Turn Auto Switch To Billing On
    Verify Auto Switch to billing is Off
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_5 Adding product by scanning the Barcode
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_5
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Add product
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_6 Add items to Return by searching the barcode or name of Item
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_6
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Add product
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_7 Add items to Return by catalog
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_7
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Items In Cart | Catalog    ${pos_data}
    Verify Add product
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_8 Add Salesperson with return item
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_8
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Assign A Salesperson To An Item    ${pos_data}
    Verify If Salesperson Is Assigned To An Item    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_9 Add item qty by scanning
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_9
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Quantity Increased
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_10 Add Qty to the added item
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_10
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Quantity Increased
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_11 Add items to Return by catalog
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_11
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Items In Cart | Catalog    ${pos_data}
    Verify Add Product
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_12 Add Qty to the added item
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_12
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Add Product
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_R_13 Remove item to the cart
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_13
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Delete Item In The Cart
    Verify Remove item to the cart
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_14 Assign Salesperson to product While returning the product
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_14
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Assign Same Salesperson To All Products Except Last Product    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_15 Assign customer to the return when customer Tagging is mandatory
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_15
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_details}    Add Customer Details    ${pos_data}
    Verify Customer Tagging    ${customer_details}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_R_16 Assign customer to the return when customer Tagging is optional in policies
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_16
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_details}    Add Customer Details    ${pos_data}
    Verify Customer Tagging    ${customer_details}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_R_17 Apply Customized Manual Discount item level
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_17
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Navigate To Update Product Window    ${pos_data}
    ${product_price}    Apply Item Manual Discount | Update Product Popup    ${pos_data}
    Apply Item Manual Discount | Select From List    ${pos_data}
    Verify Item Manual Discount   ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_R_18 Apply Customised Manual Discount item level
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_18
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Navigate To Update Product Window    ${pos_data}
    ${product_price}    Apply Item Manual Discount | Update Product Popup    ${pos_data}
    Apply Item Manual Discount | Select From List    ${pos_data}
    Verify Item Manual Discount   ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_R_19 Apply Customised Manual Discount item level by Fixed amount in item level
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_19
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Navigate To Update Product Window    ${pos_data}
    ${product_price}    Apply Item Manual Discount | Update Product Popup    ${pos_data}
    Apply Item Manual Discount | Custom Discount    ${pos_data}
    Verify Item Manual Discount   ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_R_20 Apply Customised Manual Discount item level by percentage item level
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_20
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Navigate To Update Product Window    ${pos_data}
    ${product_price}    Apply Item Manual Discount | Update Product Popup    ${pos_data}
    Apply Item Manual Discount | Custom Discount    ${pos_data}
    Verify Item Manual Discount   ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_R_21 Apply Item level Promo
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_21
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Level Promos
    Verify If Item Level Promos Applied
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_R_22 Check out from POS screen to Payment Collection
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_22
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan And Add Product    ${pos_data}
    Add Customer Details    ${pos_data}
    Verify Return Checkout
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_R_23 Allow Refund Against Returned Item | Refund Through Cash only
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_23
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan And Add Product    ${pos_data}
    Add Customer Details    ${pos_data}
    Verify Return Checkout
    Pay By Cash | Return Mode
    Verify If Payment Is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_R_24 Allow Refund Against Returned Item | Refund Through Credit Note
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_24
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan And Add Product    ${pos_data}
    Add Customer Details    ${pos_data}
    Navigate To Return Checkout Page
    Pay Through Store Credit Method
    Verify If Payment Is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_R_25 Allow Refund Against Returned Item | Refund Through both credit note and cash
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_25
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan And Add Product    ${pos_data}
    Add Customer Details    ${pos_data}
    Navigate To Return Checkout Page
    Pay Through Store Credit Method
    Verify If Payment Is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_26 Click on Confirm button on switch to Billing popup box
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_26
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switch To Billing
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_27 Click on Cancel button on switch to Billing popup box
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_27
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Cancel Auto Switch To Billing
    Verify Billing Mode Present
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_R_28 Switching Between Return to Billing Will Give Confirmation Popup
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_28
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Auto Switch To Billing
    Verify Auto Switch To Billing
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_R_29 Click on Confirm button on switch to Order popup box
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_29
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Switch From Return Mode To Order
    Verify Switch To Order Mode
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_R_30 Click on Cancel button on switch to Order popup box
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_30
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Cancel Switch From Return Mode To Order
    Verify Return Mode Present
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}


Zwing_R_31 Switching Between Return to Order Will Give Confirmation Popup
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_31
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Switch From Return Mode To Order
    Verify Switch To Order Mode
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_32 Click on Confirm button on switch to Exchange popup box
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_32
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Switch From Return Mode To Exchange
    Verify Exchange Mode Present
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_33 Click on Cancel button on switch to Exchange popup box
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_33
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Cancel Switch From Return Mode To Exchange
    Verify Return Mode Present
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_34 Switching Between Return to Exchange Will Give Confirmation Popup
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_34
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Switch From Return Mode To Exchange
    Verify Exchange Mode Present
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_35 Set variance limit and enter price override less or more than total price but within variance limit
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_35
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Product By Scan Only   ${pos_data}
    Price Override | Billing    ${pos_data}
    Verify Price Overridden | Billing
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_36 Set variance limit and enter price override less or more than total price but out of variance limit
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_36
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Product By Scan Only   ${pos_data}
    Price Override | Billing    ${pos_data}
    Verify Alert Message for Price Overridden | Billing
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_37 Set variance limit and enter price override less or more than total price but equal to variance limit
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}   R_37
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Product By Scan Only   ${pos_data}
    Price Override | Billing    ${pos_data}
    Verify Price Overridden | Billing
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_38 Set variance limit and enter price override less or more than total price but within variance limit. Then try again price override and check the response
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}  R_38
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Product By Scan Only   ${pos_data}
    Price Override | Billing    ${pos_data}
    Verify Price Override Link Is Disabled
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_R_39 Disable price override and try price overriding then check the response
    [Tags]    test:retry(1)
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    R_39
    ${response}     Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Product By Scan Only   ${pos_data}
    Verify Price Override Link Is Disabled
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}
