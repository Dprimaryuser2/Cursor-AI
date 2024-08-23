*** Settings ***
Library    SeleniumLibrary
Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/manual_discount_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Resource   ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource   ../../../Resources/Web_POS/POS/Order/manual_discount_order_keyword.robot

Test Setup    Open Application | POS
Test Teardown   Close Browser

#*** Variables ***
#${DISCOUNT_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Order${/}manual_discount_order_test_data.xlsx

*** Variables ***
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Order${/}manual_discount_order_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Order${/}manual_discount_order_test_data.xlsx
${response}=    'NULL'

*** Test Cases ***
Zwing_O_MD_1 Apply Item Level Manual Discount Assortment Wise
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_01
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Select From List | Order    ${discount_data}
     Verify Item Manual Discount | Order   ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_2 Apply Item Level Manual Discount | Discount type as Fixed Amount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_02
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Select From List | Order    ${discount_data}
     Verify Item Manual Discount | Order   ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_3 Apply Item Level Manual Discount | Discount type as percentage
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_03
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Select From List | Order    ${discount_data}
     Verify Item Manual Discount | Order   ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_4 Apply Item Level Manual Discount | Discount to Customer Group
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_04
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Select From List | Order    ${discount_data}
     Verify Item Manual Discount | Order   ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_5 Apply Item Level Manual Discount | Discount to Store
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_05
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Select From List | Order    ${discount_data}
     Verify Item Manual Discount | Order   ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_6 Apply Item Level Manual Discount | Effective date and valid up to date
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_06
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Select From List | Order    ${discount_data}
     Verify Item Manual Discount | Order   ${product_price}
     Verify Item Manual Discount At Cart | Order    ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_7 Bill Level manual discount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_07
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     ${bill_data}    Apply Bill Manual Discount | Select From List | Order    ${discount_data}
     Verify Bill Level Manual Discount | Order    ${bill_data}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_8 Bill Level manual discount as Fixed Amount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_08
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     ${bill_data}    Apply Bill Manual Discount | Select From List | Order    ${discount_data}
     Verify Bill Level Manual Discount | Order    ${bill_data}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_9 Bill level manual discount as Percentage
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_09
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     ${bill_data}    Apply Bill Manual Discount | Select From List | Order    ${discount_data}
     Verify Bill Level Manual Discount | Order    ${bill_data}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_10 Allocate Discount to Customer Group
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_10
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     ${bill_data}    Apply Bill Manual Discount | Select From List | Order    ${discount_data}
     Verify Bill Level Manual Discount | Order    ${bill_data}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_11 Manual Discount button | Stores
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_11
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     ${bill_data}    Apply Bill Manual Discount | Select From List | Order    ${discount_data}
     Verify Bill Level Manual Discount | Order    ${bill_data}
     [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_12 Select the effective and valid up to date
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_12
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     ${bill_data}    Apply Bill Manual Discount | Select From List | Order    ${discount_data}
     Verify Bill Level Manual Discount | Order    ${bill_data}
     [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_13 Item level custom Discount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_13
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Custom Discount | Order    ${discount_data}
     Verify Item Manual Discount | Order   ${product_price}
     Verify Item Manual Discount At Cart | Order    ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_14 Custom Discount with discount type as amount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_14
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Custom Discount | Order    ${discount_data}
     Verify Item Manual Discount | Order   ${product_price}
     Verify Item Manual Discount At Cart | Order    ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_15 Custom Discount with discount type as Percentage
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_15
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Custom Discount | Order    ${discount_data}
     Verify Item Manual Discount | Order   ${product_price}
     Verify Item Manual Discount At Cart | Order    ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_16 Bill level custom discount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_16
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     ${bill_level}    Apply Bill Manual Discount | Custom Discount | Order    ${discount_data}
     Verify Bill Level Manual Discount | Order    ${bill_level}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_17 Bill Level Custom Discount with discount type as amount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=    Fetch Testdata By Id    ${DISCOUNT_TD}    TC_17
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     ${bill_level}    Apply Bill Manual Discount | Custom Discount | Order    ${discount_data}
     Verify Bill Level Manual Discount | Order    ${bill_level}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_18 Bill Level Custom Discount with discount type as Percentage
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_18
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     ${bill_level}    Apply Bill Manual Discount | Custom Discount | Order    ${discount_data}
     Verify Bill Level Manual Discount | Order    ${bill_level}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_19 Apply Manual Discount Button | Assortment Wise | Button
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_19
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Apply Item Manual Discount | Button
     Verify Item Manual Discount | Button | Order    ${discount_data}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_20 Apply Manual Discount Button, Use Discount type as Fixed Amount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_20
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Apply Item Manual Discount | Button
     Verify Item Manual Discount | Button | Order    ${discount_data}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_21 Apply Manual Discount Button | discount type as percentage
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_21
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Apply Item Manual Discount | Button
     Verify Item Manual Discount | Button | Order    ${discount_data}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_22 Apply Manual Discount Button | Discount to Customer Group
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_22
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Apply Item Manual Discount | Button
     Verify Item Manual Discount | Button | Order    ${discount_data}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_23 Apply Manual Discount Button | Allocate Discount to Stores
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_23
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Apply Item Manual Discount | Button
     Verify Item Manual Discount | Button | Order    ${discount_data}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_24 Apply Manual Discount Button | Select the effective date and valid upto date
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_24
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Apply Item Manual Discount | Button
     Verify Item Manual Discount | Button | Order    ${discount_data}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_25 Apply Manual Discount Button |Policy : Allows cashier to apply manual discount on bill level | Disable bill level discount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_25
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     Verify Bill Level Discount Button Is Disabled
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_26 Apply Manual Discount Button |Policy : Allows cashier to apply manual discount on bill level | Enable bill level discount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_26
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     Verify Bill Level Discount Button Is Enabled
     [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_27 Apply Manual Discount Button Policy : Allow cashier to select bill level discount from given list | Disable bill level discount list
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_27
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     Verify Disable Bill Level Discount List
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_28 Apply Manual Discount Button Policy : Allow cashier to select bill level discount from given list | Enable bill level discount list
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_28
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     Verify Enable Bill Level Discount List
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_29 Apply Manual Discount Button Policy : Allow cashier to enter bill level manual discount as percentage or amount | enable custom bill level discount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_29
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     Verify Enable Bill Level Custom Discount
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_30 Apply Manual Discount Button Policy : Allow cashier to enter bill level manual discount as percentage or amount | disable custom bill level discount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_30
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     Verify Disable Bill Level Custom Discount
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_31 Apply Manual Discount Button Policy : Discount capping (amount) Bill level | Apply Bill level discount percentage more than Limit on discount percentage(Bill level)
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_31
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     ${bill_data}    Apply Bill Manual Discount | Custom Discount | Order    ${discount_data}
     Verify Bill Level Custom Discount More Than Percentage Limit    ${bill_data}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_32 Apply Manual Discount Button Policy : Discount capping (amount) Bill level | Apply Bill level discount percentage less than or equal to Limit on discount percentage(Bill level)
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_32
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     ${bill_data}    Apply Bill Manual Discount | Custom Discount | Order    ${discount_data}
     Verify Bill Level Custom Discount More Than Capping Amount Limit    ${bill_data}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_33 Apply Manual Discount Button | Disable Item level discount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_33
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     Verify Disabled Item Level Discount
     [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_34 Apply Manual Discount Button | Enable Item level discount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_34
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     Verify Enabled Item Level Discount
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_35 Apply Manual Discount Button | Enable Item level discount | Disable Item level discount list
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_35
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     Verify Enabled Item Level Discount
     Verify Disable Item Level Discount List
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_36 Apply Manual Discount Button | Enable Item level discount | Enable Item level discount list
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_36
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     Verify Enabled Item Level Discount
     Verify Enable Item Level Discount List
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_37 Apply Manual Discount Button | Enable Item level discount | Enable Custom Item level discount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_37
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     Verify Enabled Item Level Discount
     Verify Enable Item Level Custom Discount
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_38 Apply Manual Discount Button | Enable Item level discount | Disable Custom Item level discount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_38
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     Verify Enabled Item Level Discount
     Verify Disable Item Level Custom Discount
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_39 Apply Manual Discount Button | Apply Item level discount percentage more than Limit on discount percentage(Item level)
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_39
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Custom Discount | Order    ${discount_data}
     Verify Item Level Custom Discount More Than Percentage Limit    ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_40 Apply Manual Discount Button | Apply Item level discount percentage less than or equal to Limit on discount percentage(Item level)
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_40
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Custom Discount | Order    ${discount_data}
     Verify Item Manual Discount | Order   ${product_price}
     Verify Item Manual Discount At Cart | Order    ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_41 Apply Manual Discount Button | Apply Item level discount amount more than the Limit on discount amount (Item level)
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_41
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Custom Discount | Order    ${discount_data}
     Verify Item Level Custom Discount More Than Capping Amount Limit    ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_42 Apply Manual Discount Button | Apply Item level discount amount less than or equal to the Limit on discount amount (Item level)
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_42
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount | Update Product Popup    ${discount_data}
     Apply Item Manual Discount | Custom Discount | Order    ${discount_data}
     Verify Item Manual Discount | Order   ${product_price}
     Verify Item Manual Discount At Cart | Order    ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_43 Apply Manual Discount Button | Apply Bill level custom discount more than bill amount when limit is greater than Bill amount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_43
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     ${bill_data}    Apply Bill Manual Discount More Than Bill Amount And Less Than Capping Amount | Custom Discount    ${discount_data}
     Verify Bill Level Discount Can Not Be Greater Than Payable Amount     ${bill_data}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_44 Apply Manual Discount Button | Apply Bill level custom discount less than or equal to bill amount when limit is greater than Bill amount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_44
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Add Customer Details    ${discount_data}
     Verify Order Checkout
     ${bill_data}     Apply Bill Manual Discount Less Than Bill Amount And Less Than Capping Amount | Custom Discount    ${discount_data}
     Verify Bill Manual Discount Less Than Item Amount    ${bill_data}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_45 Apply Manual Discount Button | Apply item level custom discount more than the line item amount when limit is greater than line item amount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_45
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount More Than Item Amount And Less Than Capping Amount | Custom Discount    ${discount_data}
     Verify Item Level Discount Can Not Be Greater Than Item Amount    ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}

Zwing_O_MD_46 Apply Manual Discount Button | Apply item level custom discount less than or equal to line item amount when limit is greater than line item amount
    ${DISCOUNT_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${discount_data}=  Fetch Testdata By Id   ${DISCOUNT_TD}    TC_46
     ${response}    Login With Valid Username And Password | POS   ${discount_data}
     Open The Session    ${discount_data}
     Change Billing Mode    ${discount_data}
     Scan Barcode To Add Item And Quantity To Cart    ${discount_data}
     Navigate To Update Product Window    ${discount_data}
     ${product_price}    Apply Item Manual Discount Less Than Item Amount And Less Than Capping Amount | Custom Discount    ${discount_data}
     Verify Item Manual Discount Less Than Item Amount    ${product_price}
    [Teardown]    Revoke Licence Key | API   ${response}    ${discount_data}