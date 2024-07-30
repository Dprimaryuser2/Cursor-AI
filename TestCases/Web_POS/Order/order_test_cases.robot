*** Settings ***
Library    SeleniumLibrary
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource   ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Library    ../../../Resources/CustomKeywords/utilities.py
Resource    ../../../Resources/Web_POS/POS/Billing/split_payment_keyword.robot
Resource   ../../../Resources/Web_POS/POS/Billing/manual_discount_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Exchange/exchange_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/keyboard_shortcut_keywords.robot
Resource    ../../../Resources/Web_POS/POS/Return/adhoc_return_keywords.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Order${/}order_test_data.xlsx

*** Test Cases ***
Zwing_MD_O_1 Apply Item Level Manual Discount( Assortmnet Wise)
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_01
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Navigate To Update Product Window    ${pos_data}
     ${product_price}  Apply Item Manual Discount | Update Product Popup    ${pos_data}
     Apply Item Manual Discount | Select From List    ${pos_data}
     Verify Item Manual Discount   ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_2 Apply Item Level Manual Discount | Discount type as Fixed Amount
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_02
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Navigate To Update Product Window    ${pos_data}
     ${product_price}  Apply Item Manual Discount | Update Product Popup    ${pos_data}
     Apply Item Manual Discount | Select From List    ${pos_data}
     Verify Item Manual Discount   ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_3 Apply Item Level Manual Discount | discount type as percentage
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_03
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Navigate To Update Product Window    ${pos_data}
     ${product_price}  Apply Item Manual Discount | Update Product Popup    ${pos_data}
     Apply Item Manual Discount | Select From List    ${pos_data}
     Verify Item Manual Discount   ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_4 Apply Item Level Manual Discount | Discount to Customer Group
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_04
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#     Add Customer Details for partial payment    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify Customer Tagging    ${customer_info}
     Navigate To Update Product Window    ${pos_data}
     ${product_price}  Apply Item Manual Discount | Update Product Popup    ${pos_data}
     Apply Item Manual Discount | Select From List    ${pos_data}
     Verify Item Manual Discount   ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_5 Apply Item Level Manual Discount | Discount to Store
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_05
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Navigate To Update Product Window    ${pos_data}
     ${product_price}  Apply Item Manual Discount | Update Product Popup    ${pos_data}
     Apply Item Manual Discount | Select From List    ${pos_data}
     Verify Item Manual Discount   ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_6 Apply Item Level Manual Discount | effective date and valid upto date
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_06
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Navigate To Update Product Window    ${pos_data}
     ${product_price}  Apply Item Manual Discount | Update Product Popup    ${pos_data}
     Apply Item Manual Discount | Select From List    ${pos_data}
     Verify Item Manual Discount   ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_7 Bill Level manual discount
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_07
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify Customer Tagging    ${customer_info}
     Navigate To Checkout Page
     ${product_price}  Apply Bill Manual Discount | Select From List    ${pos_data}
     Verify Bill Level Manual Discount    ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_8 Bill Level manual discount as Fixed Amount
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_08
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#     Insufficient Inventory Window | Order    ${pos_data}
#     ${customer_info}    Add Customer Details    ${pos_data}
     ${customer_info}  Verify Customer Tagging Is Mandatory With All Fields    ${pos_data}
     Verify Customer Tagging    ${customer_info}
     Navigate To Checkout Page
     ${product_price}  Apply Bill Manual Discount | Select From List    ${pos_data}
     Verify Bill Level Manual Discount    ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_9 Bill level manual discount as Percentage
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_09
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Insufficient Inventory Window | Order    ${pos_data}
#     ${customer_info}    Add Customer Details    ${pos_data}
     ${customer_info}  Verify Customer Tagging Is Mandatory With All Fields    ${pos_data}
     Verify Customer Tagging    ${customer_info}
     Navigate To Checkout Page
     ${product_price}  Apply Bill Manual Discount | Select From List    ${pos_data}
     Verify Bill Level Manual Discount    ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_010 Allocate Discount to Customer Group
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_010
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Insufficient Inventory Window | Order    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Navigate To Checkout Page
     ${product_price}  Apply Bill Manual Discount | Select From List    ${pos_data}
     Verify Bill Level Manual Discount    ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_011 Manual Discount button | Stores
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_011
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Insufficient Inventory Window | Order    ${pos_data}
     Add Customer Details    ${pos_data}
     Navigate To Checkout Page
     ${product_price}  Apply Bill Manual Discount | Select From List    ${pos_data}
     Verify Bill Level Manual Discount    ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_012 Select the effective and valid up to date
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_012
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Insufficient Inventory Window | Order    ${pos_data}
#     ${customer_info}    Add Customer Details    ${pos_data}
     ${customer_info}  Verify Customer Tagging Is Mandatory With All Fields    ${pos_data}
     Verify Customer Tagging    ${customer_info}
     Navigate To Checkout Page
     ${product_price}  Apply Bill Manual Discount | Select From List    ${pos_data}
     Verify Bill Level Manual Discount    ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_013 Item level custom Discount
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_013
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#     Insufficient Inventory Window | Order    ${pos_data}
     Navigate To Update Product Window    ${pos_data}
     ${product_price}  Apply Item Manual Discount | Update Product Popup    ${pos_data}
     Apply Item Manual Discount | Custom Discount     ${pos_data}
     Verify Item Manual Discount   ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_014 Custom Discount with discount type as amount
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_014
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#     Insufficient Inventory Window | Order    ${pos_data}
     Navigate To Update Product Window    ${pos_data}
     ${product_price}  Apply Item Manual Discount | Update Product Popup    ${pos_data}
     Apply Item Manual Discount | Custom Discount    ${pos_data}
     Verify Item Manual Discount   ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_015 Custom Discount with discount type as Percentage
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_014
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
#     Insufficient Inventory Window | Order    ${pos_data}
     Navigate To Update Product Window    ${pos_data}
     ${product_price}  Apply Item Manual Discount | Update Product Popup    ${pos_data}
     Apply Item Manual Discount | Custom Discount    ${pos_data}
     Verify Item Manual Discount   ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_16 Bill level custom discount
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_016
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify Customer Tagging    ${customer_info}
     Navigate To Checkout Page
     ${product_price}  Apply Bill Manual Discount | Custom Discount    ${pos_data}
     Verify Bill Level Manual Discount    ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_017 Custom Discount with discount type as amount
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_017
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify Customer Tagging    ${customer_info}
     Navigate To Checkout Page
     ${product_price}  Apply Bill Manual Discount | Custom Discount    ${pos_data}
     Verify Bill Level Manual Discount    ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_18 Custom Discount with discount type as Percentage
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_017
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify Customer Tagging    ${customer_info}
     Navigate To Checkout Page
     ${product_price}  Apply Bill Manual Discount | Custom Discount    ${pos_data}
     Verify Bill Level Manual Discount    ${product_price}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_19 Apply Manual Discount Button ( Assortmnet Wise)
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_019
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Apply Item Manual Discount | Button
     Verify Item Manual Discount | Button    ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_20 Apply Manual Discount Button, Use Discount type as Fixed Amount
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_019
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Apply Item Manual Discount | Button
     Verify Item Manual Discount | Button    ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_21 Apply Manual Discount Button | discount type as percentage
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_019
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Apply Item Manual Discount | Button
     Verify Item Manual Discount | Button    ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]  Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_22 Apply Manual Discount Button | Discount to Customer Group
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_019
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Apply Item Manual Discount | Button
     Verify Item Manual Discount | Button    ${pos_data}
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_23 Apply Manual Discount Button | Allocate Discount to Stores
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_019
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Apply Item Manual Discount | Button
     Verify Item Manual Discount | Button    ${pos_data}
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_24 Apply Manual Discount Button | Select the effective date and valid upto date
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_019
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Apply Item Manual Discount | Button
     Verify Item Manual Discount | Button    ${pos_data}
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_25 Apply Manual Discount Button |Policy : Allows cashier to apply manual discount on bill level | Disable bill level discount
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_019
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Add Customer Details    ${pos_data}
     Verify Billing Checkout
     Verify Bill Level Discount Button Is Disabled
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_MD_O_26 Apply Manual Discount Button |Policy : Allows cashier to apply manual discount on bill level | Enable bill level discount
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_019
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Navigate To Checkout Page
     Apply Bill Manual Discount | Custom Discount    ${pos_data}

Zwing_MD_O_27 Apply Manual Discount Button Policy : Allow cashier to select bill level discount from given list | Disable bill level discount list
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_019
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Navigate To Checkout Page
     Apply Bill Manual Discount | Custom Discount    ${pos_data}

Zwing_MD_28 Apply Manual Discount Button Policy : Allow cashier to select bill level discount from given list | Enable bill level discount list
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_028
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Add Customer Details    ${pos_data}
     Verify Billing Checkout
     Verify Enable Bill Level Discount List
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_O_29 Apply Manual Discount Button Policy : Allow cashier to enter bill level manual discount as percentage or amount | enable custom bill level discount
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_029
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Add Customer Details    ${pos_data}
     Verify Billing Checkout
     Verify Enable Bill Level Discount List
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_30 Apply Manual Discount Button Policy : Allow cashier to enter bill level manual discount as percentage or amount | disable custom bill level discount
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_029
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Add Customer Details    ${pos_data}
     Verify Billing Checkout
     Verify Enable Bill Level Discount List
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_31 Apply Manual Discount Button Policy : Discount capping (amount) Bill level | Apply Bill level discount percentage more than Limit on discount percentage(Bill level)
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_029
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Add Customer Details    ${pos_data}
     Verify Billing Checkout
     Verify Enable Bill Level Discount List
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_32 Apply Manual Discount Button Policy : Discount capping (amount) Bill level | Apply Bill level discount percentage less than or equal to Limit on discount percentage(Bill level)
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_029
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Add Customer Details    ${pos_data}
     Verify Billing Checkout
     Verify Enable Bill Level Discount List
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_33 Apply Manual Discount Button | Disable Item level discount
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_029
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Navigate To Update Product Window    ${pos_data}
     Verify Disabled Item Level Discount
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_34 Apply Manual Discount Button | Enable Item level discount
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_029
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Navigate To Update Product Window    ${pos_data}
     Verify Enabled Item Level Discount
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_MD_35 Apply Manual Discount Button | Enable Item level discount
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    O_035
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Change Billing Mode    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Navigate To Update Product Window    ${pos_data}
     Verify Enabled Item Level Discount
     Revoke Serial Key    ${pos_data}
     [Teardown]    Tear It Down If Test Case Failed    ${pos_data}
