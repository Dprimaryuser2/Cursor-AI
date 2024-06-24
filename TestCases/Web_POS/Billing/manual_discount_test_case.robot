*** Settings ***
Library    SeleniumLibrary
Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/promo_keyword.robot
Resource    ../../../Resources/Web_POS/POS/manual_discount_keyword.robot
Resource    ../../../Resources/Web_POS/POS/customer_keyword.robot

#Suite Setup    Allocate All Promos To Store    ${POS_TD}
Test Setup    Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${DISCOUNT_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}manual_discount_test_data.xlsx

*** Test Cases ***
Zwing_MD_1 Apply Item Level Manual Discount Assortment Wise
     ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_01
     Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Select From List    ${discount_data}
     Verify Item Manual Discount   ${product_price}

Zwing_MD_2 Apply Item Level Manual Discount | Discount type as Fixed Amount
     ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_02
     Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Select From List    ${discount_data}
     Verify Item Manual Discount   ${product_price}

Zwing_MD_3 Apply Item Level Manual Discount | Discount type as percentage
     ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_03
     Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Select From List    ${discount_data}
     Verify Item Manual Discount   ${product_price}

Zwing_MD_4 Apply Item Level Manual Discount | Discount to Customer Group
     ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_04
     Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Select From List    ${discount_data}
     Verify Item Manual Discount   ${product_price}

Zwing_MD_5 Apply Item Level Manual Discount | Discount to Store
     ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_05
     Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Select From List    ${discount_data}
     Verify Item Manual Discount   ${product_price}

Zwing_MD_6 Apply Item Level Manual Discount | Effective date and valid up to date
     ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_06
     Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Select From List    ${discount_data}
     Verify Item Manual Discount   ${product_price}
     Verify Item Manual Discount At Cart    ${product_price}

Zwing_MD_7 Bill Level manual discount
    ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_07
     Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Billing Checkout
     ${bill_data}    Apply Bill Manual Discount | Select From List    ${discount_data}
     Verify Bill Level Manual Discount    ${bill_data}

Zwing_MD_8 Bill Level manual discount as Fixed Amount
     ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_08
     Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Billing Checkout
     ${bill_data}    Apply Bill Manual Discount | Select From List    ${discount_data}
     Verify Bill Level Manual Discount    ${bill_data}

Zwing_MD_9 Bill level manual discount as Percentage
     ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_09
     Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Billing Checkout
     ${bill_data}    Apply Bill Manual Discount | Select From List    ${discount_data}
     Verify Bill Level Manual Discount    ${bill_data}

Zwing_MD_10 Allocate Discount to Customer Group
     ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_10
     Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Billing Checkout
     ${bill_data}    Apply Bill Manual Discount | Select From List    ${discount_data}
     Verify Bill Level Manual Discount    ${bill_data}

Zwing_MD_11 Manual Discount button | Stores
    ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_11
     Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Billing Checkout
     ${bill_data}    Apply Bill Manual Discount | Select From List    ${discount_data}
     Verify Bill Level Manual Discount    ${bill_data}
     
Zwing_MD_12 Select the effective and valid up to date
     ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_12
     Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Billing Checkout
     ${bill_data}    Apply Bill Manual Discount | Select From List    ${discount_data}
     Verify Bill Level Manual Discount    ${bill_data}
     
Zwing_MD_13 Item level custom Discount
     ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_13
     Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Custom Discount    ${discount_data}
     Verify Item Manual Discount   ${product_price}
     Verify Item Manual Discount At Cart    ${product_price}

Zwing_MD_14 Custom Discount with discount type as amount
     ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_14
     Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Custom Discount    ${discount_data}
     Verify Item Manual Discount   ${product_price}
     Verify Item Manual Discount At Cart    ${product_price}

Zwing_MD_15 Custom Discount with discount type as Percentage

Zwing_MD_16 Bill level custom discount

Zwing_MD_17 Bill Level Custom Discount with discount type as amount

Zwing_MD_18 Bill Level Custom Discount with discount type as Percentage

Zwing_MD_19 Apply Manual Discount Button | Assortment Wise | Button


Zwing_MD_20 Apply Manual Discount Button, Use Discount type as Fixed Amount

Zwing_MD_21 Apply Manual Discount Button | discount type as percentage


Zwing_MD_22 Apply Manual Discount Button | Discount to Customer Group

Zwing_MD_23 Apply Manual Discount Button | Allocate Discount to Stores

Zwing_MD_24 Apply Manual Discount Button | Select the effective date and valid upto date

Zwing_MD_25 Apply Manual Discount Button |Policy : Allows cashier to apply manual discount on bill level | Disable bill level discount

Zwing_MD_26 Apply Manual Discount Button |Policy : Allows cashier to apply manual discount on bill level | Enable bill level discount

Zwing_MD_27 Apply Manual Discount Button Policy : Allow cashier to select bill level discount from given list | Disable bill level discount list

Zwing_MD_28 Apply Manual Discount Button Policy : Allow cashier to select bill level discount from given list | Enable bill level discount list

Zwing_MD_29 Apply Manual Discount Button Policy : Allow cashier to enter bill level manual discount as percentage or amount | enable custom bill level discount

Zwing_MD_30 Apply Manual Discount Button Policy : Allow cashier to enter bill level manual discount as percentage or amount | disable custom bill level discount

Zwing_MD_31 Apply Manual Discount Button Policy : Discount capping (amount) Bill level | Apply Bill level discount percentage more than Limit on discount percentage(Bill level)

Zwing_MD_32 Apply Manual Discount Button Policy : Discount capping (amount) Bill level | Apply Bill level discount percentage less than or equal to Limit on discount percentage(Bill level)

Zwing_MD_33 Apply Manual Discount Button | Disable Item level discount

Zwing_MD_34 Apply Manual Discount Button | Enable Item level discount

Zwing_MD_35 Apply Manual Discount Button | Enable Item level discount | Disable Item level discount list

Zwing_MD_36 Apply Manual Discount Button | Enable Item level discount | Enable Item level discount list

Zwing_MD_37 Apply Manual Discount Button | Enable Item level discount | Enable Custom Item level discount

Zwing_MD_38 Apply Manual Discount Button | Enable Item level discount | Disable Custom Item level discount

Zwing_MD_39 Apply Manual Discount Button | Apply Item level discount percentage more than Limit on discount percentage(Item level)

Zwing_MD_40 Apply Manual Discount Button | Apply Item level discount percentage less than or equal to Limit on discount percentage(Item level)

Zwing_MD_41 Apply Manual Discount Button | Apply Item level discount amount more than the Limit on discount amount (Item level)

Zwing_MD_42 Apply Manual Discount Button | Apply Item level discount amount less than or equal to the Limit on discount amount (Item level)

Zwing_MD_43 Apply Manual Discount Button | Apply Bill level custom discount more than bill amount when limit is greater than Bill amount

Zwing_MD_44 Apply Manual Discount Button | Apply Bill level custom discount less than or equal to bill amount when limit is greater than Bill amount

Zwing_MD_45 Apply Manual Discount Button | Apply item level custom discount more than the line item amount when limit is greater than line item amount

Zwing_MD_46 Apply Manual Discount Button | Apply item level custom discount less than or equal to line item amount when limit is greater than line item amount