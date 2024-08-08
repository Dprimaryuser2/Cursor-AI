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
Resource    ../../../Resources/Web_POS/POS/Return/adhoc_return_keywords.robot
Resource   ../../../Resources/Web_POS/POS/Billing/mode_of_payment_keyword.robot
Resource    ../../../Resources/AdminConsole/Allocation/allocation_keywords.robot
Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Exchange${/}exchange_test_data.xlsx

*** Test Cases ***
Zwing_E_01 Check whether Exchange text is clickable or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_01
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Click On Exchange Text In Dropdown    ${pos_data}
    Verify Exchange Text Is Clickable    
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_02 Click on Exchange Text and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_02
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Click On Exchange Text In Dropdown    ${pos_data}
    Verify Exchange Text Is Clickable
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_03 Click on confirm button and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_03
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Click On Exchange Text In Dropdown   ${pos_data}
    Verify Exchange Text Is Clickable
    Click On Confirm Button | Exchange
    Verify The Confirm Button | Exchange   ${pos_data}  
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_04 Click on cancel button and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_04
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Click On Exchange Text In Dropdown   ${pos_data}
    Verify Exchange Text Is Clickable
    Click On Cancel Button | Exchange
    Verify The Cancel Button | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_05 Click on +Add Exchange Items from Invoice link and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_05
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_06 Verify invoice parameters are clickable or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_06
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
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_07
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
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_08
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
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_09
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
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_17 Make a invoice without entering name, make another invoice with same number and enter name, search that name in exchange search bar then check the response
    [Tags]    valid failure
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_17
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan And Add Product    ${pos_data}
    ${customer_number}  Tag Customer Without Name  ${pos_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    ${cust_invoice_1}  Get Customer Details | Checkout
    Click on New Bill Button
    Scan And Add Product    ${pos_data}
    ${customer_name}  Enter Customer Name For Previously Used Number  ${pos_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    ${cust_invoice_2}  Get Customer Details | Checkout
    Click on New Bill Button
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice By Name | Exchange     ${customer_name}
    Verify All The Invoices Under Customer Name Are Visible    ${invoice_ids}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_18 Make a Invoice with name like (Sunil), make another invoice with same number and update the name like (Sunil-> Vaibhav), search by name in exchange module search bar then check the response
    [Tags]    valid failure
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_18
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan And Add Product    ${pos_data}
    Enter Customer Name For Previously Used Number  ${pos_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    ${cust_invoice_1}  Get Customer Details | Checkout
    Click on New Bill Button
    Scan And Add Product    ${pos_data}
    ${customer_name}  Update Customer Name | Exchange  ${pos_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    ${cust_invoice_2}  Get Customer Details | Checkout
    Click on New Bill Button
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice By Name | Exchange     ${customer_name}
    Verify All The Invoices Under Customer Name Are Visible    ${invoice_ids}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_19 Search by previous name (sunil) in exchange module then check the response
    [Tags]    valid failure
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_19
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan And Add Product    ${pos_data}
    ${customer_name}  Enter Customer Name For Previously Used Number  ${pos_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    ${cust_invoice_1}  Get Customer Details | Checkout
    Click on New Bill Button
    Scan And Add Product    ${pos_data}
    Update Customer Name | Exchange  ${pos_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    ${cust_invoice_2}  Get Customer Details | Checkout
    Click on New Bill Button
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice By Name | Exchange     ${customer_name}
    Verify Invoice Search By Invalid Customer Data
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_20 Search for a already used exchange invoice in search bar then check the response
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_20
   Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   ${invoice_id}  Customer Billing For Invoice Generation | Exchange  ${pos_data}
   Change Billing Mode    ${pos_data}
   Click On +Add Exchange Items from Invoice Link
   Verify The +Add Exchange Items from Invoice Link
   Click On Invoice Parameters
   Verify The Invoice Parameters Are Clickable
   Select The Invoice By Invoice Name | Exchange    ${invoice_id.invoice_id}
   Select Invoice From Search Options
   Select Items For Exchange     ${pos_data}
   Add Product For Exchange
   Scan Barcode To Add Item And Quantity To Cart By Name | Exchange     ${pos_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   No Payment Required | Checkout Page
   Get Customer Details | Checkout
   Click on New Bill Button
   Auto Switch To Billing
   Verify Auto Switched To Billing
   Change Billing Mode    ${pos_data}
   Click On +Add Exchange Items from Invoice Link
   Verify The +Add Exchange Items from Invoice Link
   Click On Invoice Parameters
   Verify The Invoice Parameters Are Clickable
   Select The Invoice By Invoice Name | Exchange    ${invoice_id.invoice_id}
   Verify Already Used Exchange Invoice Response    ${invoice_id.invoice_id}
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_E_21 exchanged less quantity of a invoice , again search for the invoice then check the response.
    [Tags]    retry
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_21
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_name}  Add Customer Details      ${pos_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    Click on New Bill Button
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice Billing-Exchange    ${customer_name}
    Select Invoice From Search Options
    ${total_quantity}   Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan And Add Product | Alternate     ${pos_data}
    Verify Billing Checkout
    Split Payment By Redeem Voucher
    Click on New Bill Button
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice Billing-Exchange    ${customer_name}
    Select Invoice From Search Options
    ${total_quantity1}   Select Items For Exchange   ${pos_data}
    Verify Count of Items For Exchange After Payment    ${total_quantity}   ${total_quantity1}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_E_22 check whether double digit number are selecting in quantity dropdown in select exchange popup window bar or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_22
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Verify Exchange Item Is Added In The Cart
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


#Zwing_E_23 Repeated

Zwing_E_24 check all the information about product in cart is correct or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_24
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    ${exchange_item_info}     Select Items For Exchange   ${pos_data}
    Verify Exchange Item Info In Cart Is Correct Or Not     ${exchange_item_info}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_25 select invoice which have multiply quantity of a single product for exchange, click on confirm button and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_25
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Verify Exchange Item Is Added In The Cart
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_26 select invoice which have multiple products for exchange with quantity >1 , click on confirm button and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_26
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Verify Exchange Item Is Added In The Cart
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_27 select + add product for exchange button and add alternate item from catalog
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_27
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Add Items In Cart For Exchange | Catalog   ${pos_data}
    Verify Item Added In Cart | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_28 select a alternate product that UOM does not match with the exchange product UOM then check the response.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_28
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart By Name | Exchange  ${pos_data}
    Verify Validation Message Popup | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_E_29 select a alternate product that UOM matches with the exchange product UOM then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_29
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Item Added In Cart | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_30 search a valid alternate product by barcode in search bar during exchange process
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_30
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Item Added In Cart | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_31 search a valid alternate product by name in search bar during exchange process
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_31
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart By Name | Exchange   ${pos_data}
    Verify Item Added In Cart | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_32 select invoice from search bar, click on confirm button, refresh the page then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_32
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Reload Page
    Verify Exchange Page After Reload
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_33 Add a exchange product, add a alternate product, remove exchange product ,again add same product, add alternate product then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_33
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Remove Exchange Product From Cart
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Item Added In Cart | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


#Zwing_E_34 Add a serial/batch product as alternate product against a normal product then check the response
#    Serial and Batch Product.

Zwing_E_35 add a invoice which have multiple product,add opposite product of exchange product then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_35
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Item Added In Cart | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_36 Select a exchanged product which have no discount and quantity is 1,select a alternate product with same quantity and Net price
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_36
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart By Name | Exchange  ${pos_data}
    Verify Item Added In Cart | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_37 select a alternate product with same quantity and Net price >then the exchange product net price
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_37
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Item Added In Cart | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_38 select a alternate product with same quantity and Net price less than the exchange product net price
    #need product less then exchange item
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_38
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart By Name | Exchange    ${pos_data}
    Verify Validation Message Popup | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_39 select a alternate product which have EXC tax and net price greater exchange product price
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_39
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Item Added In Cart | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_41 check whether manual discount is applied on alternate product after adding or not.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_41
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Manual Discount Not Applicable To Exc product After Added
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_42 check whether user can update the quantity of alternate product or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_42
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Quantity Cannot Be Increased For The Exchange Product
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_43 check whether user can apply item level/ bill level promotion on alternate product or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_43
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify User Cannot Apply Item/bill Level Promotions On Alternate Product
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_44 check whether user can apply price override on alternate product and exchange product or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_44
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Price Override Not Possible For Alternate Product    ${pos_data}
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_E_45 Select a exchanged product which have no discount and quantity is >1 (suppose 4 qty),select a alternate product with less quantity and Net price => to the exchange product net price. then check the response.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_45
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Alternate Product Has Less Quantity And More Net Price
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_46 Select a exchanged product which have no discount and quantity is >1 (suppose 4 qty), select a alternate product with same quantity and Net price less than the exchange product net price. then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_46
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Alternate Product With Same Quantity As Of Exchange Product    ${pos_data}
    Verify Alternate Product With Lesser Price was Added To Cart
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_47 Select a exchanged product which have no discount and quantity is >1 (suppose 4 qty),select a alternate product with same quantity and Net price >= to the exchange product net price. then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_47
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Alternate Product With Same Quantity As Of Exchange Product    ${pos_data}
    Verify Alternate Product With Greater Price was Added To Cart
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_B_48 select a invoice which have multiple product for exchange , add them to cart, select alternate products whose sum of qty is not equal to the sum of exchanged product quantity and sum of net price >= to the exchanged product net price then check the response.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_48
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select All Items With Same Qty For Exchange   ${pos_data}
    Add 1 Alternate Product For First Exchanged Product     ${pos_data}
    Verify Alternate Products With Sum Of Net Price Greater Than Exc Products Was Added To Cart
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_49 select a alternate product ,apply item level manual discount then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_49
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Manual Discount Not Applicable To Exc product After Added
    Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_E_50 select a exchange product ,apply item level manual discount then check the response.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_50
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_E_51 Select a exchanged product which have item level manual discount and quantity is 1 ,select a alternate product with same quantity and net price is => then exchanged product net price then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_51
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Alternate Product With Same Quantity As Of Exchange Product     ${pos_data}
    Verify Exc Product With Quantity 1 and Alt Product With Same Quantity And More Price Applies Same Manual Discount
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_52 Select a exchanged product which have item level manual discount and quantity is >1 ,select a alternate product with same quantity and net price is => then exchanged product net price then check the response.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_52
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Alternate Product With Same Quantity As Of Exchange Product     ${pos_data}
    Verify Exc Product With Quantity more than 1 and Alt Product With Same Quantity And More Price Applies Same Manual Discount
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_E_53 Select a exchanged product which have item level manual discount and quantity is >1 ,select a alternate product with less quantity and net price is => then exchanged product net price then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_53
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Exc Product With Quantity 1 and Alt Product With Same Quantity And More Price Applies Same Manual Discount
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_54 Select a exchanged product which have item level manual discount and quantity is >1 ,select a alternate product with less quantity and net price is => then exchanged product net price then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_54
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Alternate Product With Same Quantity As Of Exchange Product     ${pos_data}
    Verify Exc Product With Quantity more than 1 and Alt Product With Same Quantity And Less Price Shows Validation
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_55 Select a alternate product have less effective price than the effective price of exchange item and Net price >= than the net price of exchange item
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_55
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Alt Product Has Less Effective Price But More Net Price
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_56 check whether user is able to edit or remove manual discount of exchanged product( Item level manual discount should be disabled)
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_56
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify User Cannot Change Or Remove Manual Discount When Disabled
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_E_57 add a product which have promo, add a alternate product then check the response.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_57
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart By Name | Exchange  ${pos_data}
    Verify Item Added In Cart | Exchange
    Verify Promo Discount Applied In Exchanged Item Also
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

#Zwing_E_58  Blank test case

Zwing_E_59 add a product which total amount is in decimal, add a alternate product with same total amount in decimal then check the response.
    [Tags]    valid failure
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_59
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart By Name | Exchange  ${pos_data}
    Verify Item Added In Cart | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_E_60 check the behaviour of the system when payment amount is 0
   ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_60
   Login With Valid Username And Password | POS   ${pos_data}
   Open The Session    ${pos_data}
   Change Billing Mode    ${pos_data}
   Click On +Add Exchange Items from Invoice Link
   Select The Invoice Option Type  ${pos_data}
   Search Invoice | Exchange   ${pos_data}
   Select Invoice From Search Options
   Select Items For Exchange   ${pos_data}
   Add Product For Exchange
   Scan Barcode To Add Item And Quantity To Cart By Name | Exchange     ${pos_data}
   ${value}    Get payable amount
   Verify Billing Checkout
   No Payment Required | Checkout Page
   Automatic Invoice Generation
   Revoke Serial Key    ${pos_data}
   [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_E_61 click on cancel button of no payment required then check the response.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_60
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart By Name | Exchange     ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Cancel No Payment Required | Checkout Page
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_62 check whether salesperson tagging option is popup or not for alternate product.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}   E_62
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Assign A Salesperson To An Item | For Exchange  ${pos_data}
    Verify If Salesperson Is Assigned To An Item | For Exchange    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_63 check whether tag sales person in exchange product is correct or not. tagged salesperson should be same to original product invoice
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}   E_63
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Tag Sales Person In Exchange Product Is Correct Or Not
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_64 check whether user can edit or remove the sales person from exchanged product.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}   E_64
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify whether user can edit or remove the sales person from exchanged product
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

#Zwing_E_65 delete salesperson invalid test case

Zwing_E_66 check the refresh button functionality in sales person tagging is working or not.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}   E_66
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Refresh Button Functionality In Sales Person Tagging Is Working Or Not
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_67 check salesperson dropdown search functionality is working or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}   E_67
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Assign A Salesperson To An Item | For Exchange  ${pos_data}
    Verify If Salesperson Is Assigned To An Item | For Exchange    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_68 Select a valid product with no discount click on checkout button then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_68
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Verify Billing Checkout
    Verify No Payment Required | Checkout Page
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_69 Check whether exchanged product and alternate product prices is correct or not.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_69
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange  ${pos_data}
    Verify Exchanged Product And Alternate Product Prices Is Correct Or Not
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_70 Select a valid product with no discount, take net price greater than exchanged product price, click on checkout button then check the response.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_70
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    ${value}  Get payable amount
    Verify Billing Checkout
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_71 Select a valid product with no discount, take net price greater than exchanged product price, click on checkout button then check the response(total amount should be like (alternate product net price - exchanged product net price))
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_71
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode     ${pos_data}
    Add Exchange Items From Invoice   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange  ${pos_data}
    Verify Total Amount Of Exchange and Alternate Product
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_72 Check whether bill discount option is disabled or not in checkout page.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_72
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode     ${pos_data}
    Add Exchange Items From Invoice   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange  ${pos_data}
    Verify Billing Checkout
    Verify Bill Discount Is Disabled Or Not
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_73 Apply a bill discount on a product exchange it with alternate product then check the response.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_73
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode     ${pos_data}
    Add Exchange Items From Invoice   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange  ${pos_data}
    Verify Billing Checkout
    Verify Bill Discount Is Disabled Or Not
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_74 Check whether user is able to edit or untag customer after adding exchange product or not
    [Tags]    Valid Failure
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_74
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode     ${pos_data}
    Add Exchange Items From Invoice   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange  ${pos_data}
    Verify User Is Able To Edit Or Untag Customer After Adding Exchange Product
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_75 Create sales invoice of one product (4qty) with manual discount and select invoice for exchange with 2qty then product net price is displaying incorrect
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_75
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Navigate To Update Product Window    ${pos_data}
    ${product_price}    Apply Item Manual Discount | Update Product Popup    ${pos_data}
    Apply Item Manual Discount | Select From List    ${pos_data}
    Close The Product Window
    ${net_price}  Get The Net Price Of Product  ${pos_data}
    ${customer_name}  Enter Customer Name For Previously Used Number  ${pos_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    Click on New Bill Button
    Change Billing Mode     ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice By Name | Exchange     ${customer_name}
    Select Invoice From Search Options
    ${unit}  Get The Net Price Of Product | Exchange
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Verify The Net Price  ${net_price}  ${unit}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_76 Create sales invoice by applying item level promo and manual discount in one product then exchange with less price product then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_76
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Product By Scan Only    ${pos_data}
    Apply Item Level Promos
    Navigate To Update Product Window    ${pos_data}
    ${product_price}    Apply Item Manual Discount | Update Product Popup    ${pos_data}
    Apply Item Manual Discount | Select From List    ${pos_data}
    Close The Product Window
    ${customer_name}  Enter Customer Name For Previously Used Number  ${pos_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    Click on New Bill Button
    Change Billing Mode     ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice By Name | Exchange    ${customer_name}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product With Less Price Than Exchange Product  ${pos_data}
    Verify Sum Of Product Should Be Greater Than Exchange Product Alert Is Displayed
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_77 Create sales invoice by applying item level promo and manual discount in one product, select a alternate product with same quantity and net price is => then exchanged product net price then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_77
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Product By Scan Only   ${pos_data}
    Apply Item Level Promos
    Navigate To Update Product Window    ${pos_data}
    ${product_price}    Apply Item Manual Discount | Update Product Popup    ${pos_data}
    Apply Item Manual Discount | Custom Discount    ${pos_data}
    Close The Product Window
    ${customer_name}  Enter Customer Name For Previously Used Number  ${pos_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    Click on New Bill Button
    Change Billing Mode     ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice By Name | Exchange     ${customer_name}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product With Less Price Than Exchange Product  ${pos_data}
    Verify Checkout Is Enable If Same Quantity And Net Price Is => Then Exchanged Product Net Price
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_78 Exchange || If salesperson is tagged in exchanged product then Salesperson should not allow to edit or remove from added alternative product.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_78
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Add Product By Scan Only   ${pos_data}
    ${customer_name}  Enter Customer Name For Previously Used Number  ${pos_data}
    Assign Salesperson | Before Exchange  ${pos_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    Click on New Bill Button
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice By Name | Exchange     ${customer_name}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product With Less Price Than Exchange Product  ${pos_data}
    Verify Salesperson Should Not Allow To Edit Or Remove From Added Alternative Product
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_79 Select salesperson and click on assign to all then salesperson needs to be tagged in alternative product
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_79
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_name}  Enter Customer Name For Previously Used Number  ${pos_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    Click on New Bill Button
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice By Name | Exchange     ${customer_name}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange   ${pos_data}
    Assign Salesperson | Before Exchange   ${pos_data}
    Verify If Salesperson Is Assigned To An Item | For Exchange    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_80 Select exchange product which has netprice > replacement multiple price products one row only then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_80
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Add Multiple MRP Product  ${pos_data}
    ${net_price}  Get The Net Price Of Product  ${pos_data}
    ${customer_name}  Enter Customer Name For Previously Used Number  ${pos_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    Click on New Bill Button
    Change Billing Mode     ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Verify The +Add Exchange Items from Invoice Link
    Click On Invoice Parameters
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice By Name | Exchange     ${customer_name}
    Select Invoice From Search Options
    ${unit}  Get The Net Price Of Product | Exchange
    Select QTY For MRP Exchange
    Add Product For Exchange
    Add Multiple MRP Product | Exchange    ${pos_data}
    Verify Billing Checkout
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_E_81 Select exchange product which has netprice =< replacement multiple price products one row only then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_81
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Verify Validation Message Popup | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_82 Apply a item level Promo Buy 1 Get 20% off discount of item create a sale invoice then exchange it with similar item
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_82
    Open Application | Admin
    Login Into Admin | Zwing
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    ${price_per_item}    Get Discount Value    ${pos_data}
    Add Customer Details for partial payment    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Payment By Paytm    ${value}
    ${get_cust_info}    Get Invoice Number    ${pos_data}
    Click On Back Button | Checkout
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${get_cust_info}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange    ${pos_data}
    Verify Product Discount     ${price_per_item}
    Verify Billing Checkout
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_83 Apply a slab based promo on item level , add multiple item in cart with total bill value as per promo , create a sales invoice then exchange only 1 item in the invoice
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_83
    Open Application | Admin
    Login Into Admin | Zwing
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    ${price_per_item}    Get Discount Value    ${pos_data}
    Add Customer Details for partial payment    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Payment By Paytm    ${value}
    ${get_cust_info}    Get Invoice Number    ${pos_data}
    Click On Back Button | Checkout
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${get_cust_info}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange    ${pos_data}
    Verify Product Discount     ${price_per_item}
    Verify Billing Checkout
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_84 Apply a item level Promo Buy 4 Get 20% off discount of item , create a sale invoice with item then exchange it then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_84
    Open Application | Admin
    Login Into Admin | Zwing
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    ${price_per_item}    Get Discount Value    ${pos_data}
    Add Customer Details for partial payment    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Payment By Paytm    ${value}
    ${get_cust_info}    Get Invoice Number    ${pos_data}
    Click On Back Button | Checkout
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${get_cust_info}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart | Exchange    ${pos_data}
    Verify Product Discount     ${price_per_item}
    Verify Billing Checkout
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_85 Apply a slab based promo on item level ,add multiple unique item in cart with total bill value as per promo ,create a sales invoice then exchange all product
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_85
    Open Application | Admin
    Login Into Admin | Zwing
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    ${price_per_item}    Get Discount Value    ${pos_data}
    Add Customer Details for partial payment    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Make Payment By UPI    ${value}
    ${get_cust_info}    Get Invoice Number    ${pos_data}
    Click On Back Button | Checkout
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${get_cust_info}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Scan Alternate Product    ${pos_data}
    Verify Product Discount     ${price_per_item}
    Verify Billing Checkout
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_86 Create a sale bill which have any bill level promo select similar promotion item in exchange mode,then check in exchange mode promo is applying or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_86
    Open Application | Admin
    Login Into Admin | Zwing
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details for partial payment    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Apply Bill Level Promos
    Make Payment By UPI    ${value}
    ${get_cust_info}    Get Invoice Number    ${pos_data}
    Click On Back Button | Checkout
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${get_cust_info}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Scan Alternate Product    ${pos_data}
    Verify Exchange Item Is Added In The Cart
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_87 Create different value based slab on bill level , enable auto - promotion , add promo item as alternate item in exchange , click on checkout page and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_87
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${price_per_item}    Get Discount Value    ${pos_data}
    Add Customer Details for partial payment    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Payment By Cash       ${value}
    ${get_cust_info}    Get Invoice Number    ${pos_data}
    Click On Back Button | Checkout
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${get_cust_info}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Scan Alternate Product    ${pos_data}
    Verify Product Discount     ${price_per_item}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

#88 repeated

Zwing_E_89 Return sales invoice then select Return invoice for exchange then check the response.
    [Tags]  Valid Failure
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_89
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart   ${pos_data}
    Add Customer Details for partial payment    ${pos_data}
    Verify Billing Checkout
    Pay By Cash | Return Mode
    Click On Back Button | Checkout
    Change Billing Mode | From Return To Exchange
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Verify Void Invoice For Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_90 Void sale invoice then select sales invoice for exchange then check the response.
    [Tags]  Valid Failure
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_90
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Verify Void Invoice For Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_91 Once invoice is exchange then enter invoice no. of exchange invoice then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_91
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    ${customer_number}  Tag Customer Without Name  ${pos_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    ${cust_info_checkout}    Get Customer Details | Checkout
    Click on New Bill Button
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type    ${pos_data}
    Search Invoice By Invoice Number    ${cust_info_checkout}
    Select Invoice From Search Options
    Select Items For Exchange   ${pos_data}
    Add Product For Exchange
    Scan Barcode To Add Item And Quantity To Cart By Name | Exchange    ${pos_data}
    Verify Billing Checkout
    No Payment Required | Checkout Page
    ${cust_info_checkout}    Get Customer Details | Checkout
    Click on New Bill Button
    Switch To Exchange Mode    ${pos_data}
    Verify Confirm Button For Switch To Exchange
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type  ${pos_data}
    Search Invoice By Invoice Number    ${cust_info_checkout}
    Verify Invoice After Complete Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_92 From dropdown on billing screen, select Exchange option
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_92
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Switch To Exchange Mode    ${pos_data}
    Verify Exchange Option Popup
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_93 Click on Confirm button on switch to Exchange popup box
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_93
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify Switching To Exchange Mode    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_94 Click on Cancel button on switch to Exchange popup box
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_94
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Switch To Exchange Mode    ${pos_data}
    Verify Cancel Button On Switch To Exchange Popup
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_95 Disable the allow Exchange Policy, and click on dropdown to change the module
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_95
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Verify Exchange Mode Is Disabled    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_96 Search invoice by customer name to add exchange items
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_96
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type    ${pos_data}
    Search Invoice | Exchange    ${pos_data}
    Verify Item To Be Exchanged Are Visible    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_97 Search invoice by customer phone No. to add exchange items
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_97
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type    ${pos_data}
    Search Invoice | Exchange    ${pos_data}
    Verify Item To Be Exchanged Are Visible    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_98 Search invoice by customer Invoice Number to add exchange items
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_98
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Scan And Add Product    ${pos_data}
    Verify Item Added In Cart
    ${customer_number}  Tag Customer Without Name  ${pos_data}
    ${value}    Get Payable Amount
    Verify Billing Checkout
    Payment By Cash    ${value}
    Verify If Payment Is Complete Or Not
    ${cust_info_checkout}    Get Customer Details | Checkout
    Click on New Bill Button
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type    ${pos_data}
    Search Invoice By Invoice Number    ${cust_info_checkout}
    Verify Item To Be Exchanged Are Visible    ${cust_info_checkout}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_99 Search invoice by Entering Invoice No. when Customer Name is selected
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_99
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type    ${pos_data}
    Search Invoice | Exchange    ${pos_data}
    Verify Invoice Search By Invalid Customer Data
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_100 Search invoice by Entering Invoice No. when Customer Phone No. is selected
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_100
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type    ${pos_data}
    Search Invoice | Exchange    ${pos_data}
    Verify Invoice Search By Invalid Customer Data
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_101 Search invoice by Entering Customer Phone No. when Invoice No. is selected
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_101
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type    ${pos_data}
    Search Invoice | Exchange    ${pos_data}
    Verify Invoice Search By Invalid Customer Data
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_102 Search invoice by Entering Customer Phone No. when Customer Name. is selected
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_102
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type    ${pos_data}
    Search Invoice | Exchange    ${pos_data}
    Verify Invoice Search By Invalid Customer Data
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_103 Search invoice by Entering Customer Name when Invoice No. is selected
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_103
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type    ${pos_data}
    Search Invoice | Exchange    ${pos_data}
    Verify Invoice Search By Invalid Customer Data
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_104 Search Invoice by Entering Customer Name when Customer Phone No. is selected
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_104
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type    ${pos_data}
    Search Invoice | Exchange    ${pos_data}
    Verify Invoice Search By Invalid Customer Data
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_105 Entering minimum 3 digits while searching should list down all the invoices having those digits in same sequence.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_105
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice    ${pos_data}
    Verify Items Are Searched By 3 Digits Of Name    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_106 No invoices should be filtered while searching till only 2 digits are entered in the text search field
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_106
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Click On +Add Exchange Items from Invoice Link
    Select The Invoice Option Type    ${pos_data}
    Search Invoice | Exchange    ${pos_data}
    Verify Items Are Not Searched By 2 Digits Only
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_107 Select the invoice for the product that needs to be exchanged
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_107
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice    ${pos_data}
    Select Invoice From Search Options
    Select Individual Item
    Verify Individual Item Is Selected
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_108 User should be able to select/unselect all the items at once
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_108
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice    ${pos_data}
    Select Invoice From Search Options
    Select All Items At Once
    Verify All Items Are Selected
    Unselect All Items At Once
    Verify All Items Are Unselected
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_109 User should be able to select/unselect individual items
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_109
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice    ${pos_data}
    Select Invoice From Search Options
    Select Individual Item
    Verify Individual Item Is Selected
    Unselect Individual Item
    Verify Individual Item Is Unselected
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_110 Selecting items should auto populate the invoice qty of that item to total exchange qty
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_110
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice    ${pos_data}
    Select Invoice From Search Options
    Select Individual Item
#    Verify Total QTY Auto Populated
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_111 Deselecting the item should reset the qty to 0
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_110
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice    ${pos_data}
    Select Invoice From Search Options
    Select Individual Item
#    Verify Total QTY Auto Populated
    Unselect Individual Item
#    Verify Total QTY Is 0
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_112 Total exchange qty should be dropdown field
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_112
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice    ${pos_data}
    Select Invoice From Search Options
    Select The Item Qty
    Verify QTY DropDown
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_113 Total exchange qty dropdown should not have values more than the invoiced qty

    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_113
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice    ${pos_data}
    Select Invoice From Search Options
    Select The Item Qty
    Verify QTY DropDown Does Not Have More Values
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_114 Selecting the total exchange qty to 0 should deselect the item

    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_114
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice    ${pos_data}
    Select Invoice From Search Options
    Select Individual Item
    Select Item QTY From Drop Down   ${pos_data}
    Verify Individual Item Is Unselected
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_115 Reasons field should be a dropdown field
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_115
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice    ${pos_data}
    Select Invoice From Search Options
    Select Individual Item
    Select Item QTY From Drop Down   ${pos_data}
    Verify User Should Be Able To See Reason Dropdown
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_116 User should be able to select the Reason
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_116
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice    ${pos_data}
    Select Invoice From Search Options
    Select Individual Item
    Select Item QTY From Drop Down   ${pos_data}
    Verify User Should Be Able To Select Reason Dropdown
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_117 Continue button should be disabled if Total exchange qty is not selected.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_117
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice    ${pos_data}
    Select Invoice From Search Options
    Select Reason For Exchange
    Verify Continue Button Is Disabled | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_118 Continue button should be enabled if reason not selected | Non Mandatory in Policy
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_118
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice    ${pos_data}
    Select Invoice From Search Options
    Select Individual Item
    Verify Continue Button Is Enabled Without Reason | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_119 Continue button should be disable if reason not selected
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_119
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice    ${pos_data}
    Select Invoice From Search Options
    Select Individual Item
    Verify Continue Button Is Disabled | Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_120 Click on Cancel button on Select Items to exchange popup box
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_120
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice    ${pos_data}
    Select Invoice From Search Options
    Select Individual Item
    Cancel The Exchange Of Items
    Verify Canceling Of Exchange Item
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_121 Click Confirm button on Select Items to exchange popup box
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_121
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Add Exchange Items From Invoice    ${pos_data}
    Select Invoice From Search Options
    Select Items For Exchange    ${pos_data}
    Verify The Confirmation Of item To Be Exchanged
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_122 Switching Between Billing to Exchange Will Give Confirmation Popup
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_122
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Click On Exchange Text In Dropdown    ${pos_data}
    Verify Confirmation Popup
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_123 Click on Confirm button on switch to Billing popup box
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_123
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Switch From Exchange Module    ${pos_data}
    Click On Confirm Button | Exchange
    Verify Confirm Button On Switching    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_124 Click on Cancel button on switch to Billing popup box
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_124
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Switch From Exchange Module    ${pos_data}
    Click On Cancel Button | Exchange
    Verify The Cancel Button On Switch From Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_125 Switching Between Exchange to Billing Will Give Confirmation Popup
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_125
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Switch From Exchange Module    ${pos_data}
    Verify Confirmation Popup
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_126 Click on Confirm button on switch to Order popup box
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_126
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Switch From Exchange Module    ${pos_data}
    Click On Confirm Button | Exchange
    Verify Confirm Button On Switching    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_127 Click on Cancel button on switch to Order popup box
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_127
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Switch From Exchange Module    ${pos_data}
    Click On Cancel Button | Exchange
    Verify The Cancel Button On Switch From Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_128 Switching Between Exchange to Order Will Give Confirmation Popup
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_128
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Switch From Exchange Module    ${pos_data}
    Verify Confirmation Popup
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_129 Click on Confirm button on switch to Return popup box
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_129
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Switch From Exchange Module    ${pos_data}
    Click On Confirm Button | Exchange
    Verify Confirm Button On Switching    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_130 Click on Cancel button on switch to Return popup box
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_130
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Switch From Exchange Module    ${pos_data}
    Click On Cancel Button | Exchange
    Verify The Cancel Button On Switch From Exchange
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_131 Switching Between Exchange to Return Will Give Confirmation Popup
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_131
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Switch From Exchange Module    ${pos_data}
    Verify Confirmation Popup
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}
