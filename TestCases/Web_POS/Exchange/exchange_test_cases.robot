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
Resource   ../../../Resources/Web_POS/POS/Billing/mode_of_payment_keyword.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Exchange${/}exchange_test_data.xlsx

*** Test Cases ***
Zwing_E_01 Check whether Exchange text is clickable or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_1
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Click On Exchange Text In Dropdown   ${pos_data}
    Verify Exchange Text Is Clickable
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_02 Click on Exchange Text and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_2
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Click On Exchange Text In Dropdown   ${pos_data}
    Verify Exchange Text Is Clickable
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_03 Click on confirm button and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_3
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Click On Exchange Text In Dropdown   ${pos_data}
    Verify Exchange Text Is Clickable
    Click On Confirm Button | Exchange   ${pos_data}
    Verify The Confirm Button | Exchange   ${pos_data}  
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_04 Click on cancel button and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_4
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Click On Exchange Text In Dropdown   ${pos_data}
    Verify Exchange Text Is Clickable
    Click On Cancel Button | Exchange
    Verify The Cancel Button | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_05 Click on +Add Exchange Items from Invoice link and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_5
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_06 Verify invoice parameters are clickable or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_6
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_07 Click on close tab cross(X) then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_7
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Click On The Close Tab Cross(X) | Exchange
    Verify The Close Tab Cross(X) | Exchange   ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_08 Select customer name,enter valid name then check the Response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_8
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Verify The Search Invoice Response | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_09 Select customer phone,enter valid Mobile no then check the Response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_9
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Verify The Search Invoice Response | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_10 Select customer phone, Enter invalid data -alphabet ,special character and more than 10 digit number then check the response.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_10
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Verify Invoice Search By Invalid Customer Data
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_11 Select Invoice number,enter valid Invoice no then check the Response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_11
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Verify The Search Invoice Response | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_12 Check all columns are present in item exchange window or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_12
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Verify The Search Invoice Response | Exchange
    Verify All Columns Are Present In Item Exchange Window   ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_13 Check quantity dropdown in popup is working or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_13
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Verify The Search Invoice Response | Exchange
    Verify All Columns Are Present In Item Exchange Window   ${pos_data}
    Verify Exchange Quantity Dopdown In Popup Is Working
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_14 Check continue button is clickable or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_14
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Verify The Search Invoice Response | Exchange
    Verify All Columns Are Present In Item Exchange Window   ${pos_data}
    Select Items For Exchange   ${pos_data}
    Verify Continue Button | Exchange Item Window   ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_15 Check cancel button is clickable or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_15
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Verify The Search Invoice Response | Exchange
    Verify All Columns Are Present In Item Exchange Window   ${pos_data}
    Select Items For Exchange   ${pos_data}
    Verify Cancel Button | Exchange Item Window   ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_16 Validate check list is clickable or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_16
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Verify The Search Invoice Response | Exchange
    Verify All Columns Are Present In Item Exchange Window   ${pos_data}
    Verify Checklist Is Clickable | Exchange Item Window  ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_17 Make a invoice without entering name, make another invoice with same number and enter name, search that name in exchange search bar then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_17
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Add Product By Scan Only    ${pos_data}
    Verify Item Added In Cart
    ${customer_number}  Tag Customer Without Name  ${pos_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    Verify Successful Payment    ${value}    ${customer_number}
    Click on New Bill Button
    Add Product By Scan Only    ${pos_data}
    Verify Item Added In Cart
    ${customer_name}  Enter Customer Name For Previously Used Number
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    Verify Successful Payment    ${value}    ${customer_number}
    Click on New Bill Button
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}




Zwing_E_21 exchanged less quantity of a invoice , again search for the invoice then check the response.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_21
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    ${total_quantity}   Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange    ${pos_data}
    Verify Billing Checkout
    Split Payment By Redeem Voucher
    Click on New Bill Button
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    ${total_quantity1}   Select Items For Exchange   ${pos_data}
    Verify Count of Items For Exchange After Payment    ${total_quantity}   ${total_quantity1}

Zwing_E_22 check whether double digit number are selecting in quantity dropdown in select exchange popup window bar or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_22
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Verify Exchange Item Is Added In The Cart


#Zwing_E_23 Repeated

Zwing_E_24 check all the information about product in cart is correct or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_24
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Verify Exchange Item Is Added In The Cart

Zwing_E_25 select invoice which have multiply quantity of a single product for exchange, click on confirm button and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_25
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Verify Exchange Item Is Added In The Cart

Zwing_E_26 select invoice which have multiple products for exchange with quantity >1 , click on confirm button and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_26
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Verify Exchange Item Is Added In The Cart

Zwing_E_27 select + add product for exchange button and add alternate item from catalog
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_27
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Add Items In Cart | Catalog   ${pos_data}
    Verify Item Added In Cart | Exchange

Zwing_E_28 select a alternate product that UOM does not match with the exchange product UOM then check the response.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_28
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart By Name | Exchange  ${pos_data}
    Verify Validation Message Popup | Exchange


Zwing_E_29 select a alternate product that UOM matches with the exchange product UOM then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_29
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Item Added In Cart | Exchange

Zwing_E_30 search a valid alternate product by barcode in search bar during exchange process
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_30
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Item Added In Cart | Exchange

Zwing_E_31 search a valid alternate product by name in search bar during exchange process
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_31
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart By Name | Exchange   ${pos_data}
    Verify Item Added In Cart | Exchange

Zwing_E_32 select invoice from search bar, click on confirm button, refresh the page then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_32
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Reload Page
    Verify Exchange Page After Reload

Zwing_E_33 Add a exchange product, add a alternate product, remove exchange product ,again add same product, add alternate product then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_33
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Remove Exchange Product From Cart
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Item Added In Cart | Exchange


#Zwing_E_34 Add a serial/batch product as alternate product against a normal product then check the response
#    Serial and Batch Product.

Zwing_E_35 add a invoice which have multiple product,add opposite product of exchange product then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_35
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Item Added In Cart | Exchange

E_36 elect a exchanged product which have no discount and quantity is 1,select a alternate product with same quantity and Net price
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_36
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart By Name | Exchange  ${pos_data}
    Verify Item Added In Cart | Exchange


E_37 select a alternate product with same quantity and Net price >then the exchange product net price
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_37
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Item Added In Cart | Exchange

E_38 select a alternate product with same quantity and Net price less than the exchange product net price
    #need prodocut less then exchange item
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_38
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Sleep    10s



Zwing_E_60 check the behaviour of the system when payment amount is 0
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    E_60
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    # Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Navigate To Update Product Window   ${pos_data}
    Apply Item Manual Discount | Update Product Popup   ${pos_data}
    Apply Item Manual Discount | Select From List  ${pos_data}
    Click On Update Product | Manual Discount
    ${value}    Get payable amount
    Verify Billing Checkout
    No Payment Required | Checkout Page
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_61 click on cancel button of no payment required then check the response.
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    E_61
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    # Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Navigate To Update Product Window   ${pos_data}
    Apply Item Manual Discount | Update Product Popup   ${pos_data}
    Apply Item Manual Discount | Select From List  ${pos_data}
    Click On Update Product | Manual Discount
    ${value}    Get payable amount
    Verify Billing Checkout
    Cancel No Payment Required | Checkout Page
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_62 check whether salesperson tagging option is popup or not for alternate product.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}   E_62
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    # Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Assign A Salesperson To An Item  ${pos_data}
    Verify If Salesperson Is Assigned To An Item    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


 #testcase 29 same product under UOM | update test data
 # 38 jvlearphone less then price under same UOM   | update test data
 # inclusive and exclusive tax
