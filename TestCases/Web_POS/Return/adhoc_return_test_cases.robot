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
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Return${/}adhoc_return_test_data.xlsx

*** Test Cases ***

Zwing_R_1 Return should be mark enable in policies
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_1
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_2 While Return is off in Policies
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_2
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Verify Mode Is Disabled    ${pos_data}
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_R_3 When Auto Switch to billing is On
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_3
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Turn Auto Switch To Billing On
   Auto Switch To Billing
   Verify Auto Switched To Billing
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_R_4 When Auto Switch to billing is Off
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_4
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Turn Auto Switch To Billing Off
   Change Billing Mode    ${pos_data}
   Turn Auto Switch To Billing On
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_R_5 Adding product by scanning the Barcode
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_5
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_R_6 Add items to Return by searching the barcode or name of Item
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_6
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_R_7 Add items to Return by catalog
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_7
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Add Items In Cart | Catalog    ${pos_data}
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_R_8 Add Salesperson with return item
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_8
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Assign A Salesperson To An Item    ${pos_data}
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_R_9 Add item qty by scanning
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_9
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Verify Item Added In Cart
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_R_10 Add Qty to the added item
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_10
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Verify Item Added In Cart
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_R_11 Add items to Return by catalog
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_11
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Add Items In Cart | Catalog    ${pos_data}
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_R_12 Add Qty to the added item
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_12
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_13 Remove item to the cart
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_13
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Delete Item In The Cart
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_14 Assign Salesperson to product While returning the product
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_14
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Assign Same Salesperson To All Products Except Last Product And Verify
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_15 Assign customer to the return when customer Tagging is mandatory
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_15
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Add Customer Details    ${pos_data}
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_16 Assign customer to the return when customer Tagging is optional in policies
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_16
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Add Customer Details    ${pos_data}
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_17 Apply Customised Manual Discount item level
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_17
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Apply Item Manual Discount | Custom Discount
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_18 Apply Customised Manual Discount item level
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_18
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Apply Item Manual Discount | Custom Discount
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_19 Apply Customised Manual Discount item level by Fixed amount in item level
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_19
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Apply Bill Manual Discount | Select From List     ${pos_data}
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_20 Apply Customised Manual Discount item level by percentage item level
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_20
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Apply Bill Manual Discount | Select From List    ${pos_data}
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_21 Apply Item level Promo
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_21
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Apply Item Level Promos
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_22 Check out from POS screen to Payment Collection
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_21
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Verify Billing Checkout
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_23 Allow Refund Against Returned Item | Refund Through Cash only
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_23
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Verify Billing Checkout
   Pay By Cash | Return Mode
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_24 Allow Refund Against Returned Item | Refund Through Credit Note
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_24
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Navigate To Checkout Page
   Pay Through Store Credit Method
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_25 Allow Refund Against Returned Item | Refund Through both credit note and cash
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_25
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
   Navigate To Checkout Page
   Pay Through Store Credit Method
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_26 Click on Confirm button on switch to Billing popup box
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_26
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Auto Switch To Billing
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_27 Click on Cancel button on switch to Billing popup box
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_27
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Cancel Auto Switch To Billing
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_28 Switching Between Return to Billing Will Give Confirmation Popup
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_26
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Auto Switch To Billing
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_29 Click on Confirm button on switch to Order popup box
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_29
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Switch From Return Mode To Order
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_30 Click on Cancel button on switch to Order popup box
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_30
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Cancel Switch From Return Mode To Order
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_R_31 Switching Between Return to Order Will Give Confirmation Popup
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_31
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Switch From Return Mode To Order
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_R_32 Click on Confirm button on switch to Exchange popup box
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_32
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Switch From Return Mode To Exchange
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_R_33 Click on Cancel button on switch to Exchange popup box
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_33
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Cancel Switch From Return Mode To Exchange
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_R_34 Switching Between Return to Exchange Will Give Confirmation Popup
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    R_34
   Login With Valid Username And Password | POS    ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Switch From Return Mode To Exchange
   Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}