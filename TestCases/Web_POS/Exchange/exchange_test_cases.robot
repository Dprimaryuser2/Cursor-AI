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

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Exchange${/}exchange_test_data.xlsx

*** Test Cases ***
Zwing_E_01 Check whether Exchange text is clickable or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_1
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Verify Exchange Text Is Clickable    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_02 Click on Exchange Text and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_2
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Verify Exchange Text Is Clickable    ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_03 Click on confirm button and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_3
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Verify Exchange Text Is Clickable    ${pos_data}
    Verify The Confirm Button | Exchange   ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_04 Click on cancel button and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_4
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Verify Exchange Text Is Clickable    ${pos_data}
    Verify The Cancel Button | Exchange   ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_05 Click on +Add Exchange Items from Invoice link and check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_5
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_06 Verify invoice parameters are clickable or not
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_6
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Verify The Invoice Parameters Are Clickable
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_07 Click on close tab cross(X) then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_7
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Verify The Invoice Parameters Are Clickable
    Verify The Close Tab Cross(X) | Exchange   ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_08 Select customer name,enter valid name then check the Response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_8
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_09 Select customer phone,enter valid Mobile no then check the Response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_9
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

Zwing_E_10 Select customer phone, Enter invalid data -alphabet ,special character and more than 10 digit number then check the response.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_10
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link
    Verify The Invoice Parameters Are Clickable
    Select The Invoice Option Type  ${pos_data}
    Search Invoice | Exchange   ${pos_data}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


#Zwing_B_46
#Zwing_B_47
#Zwing_B_48

Zwing_E_49 select a alternate product ,apply item level manual discount then check the response
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_49
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
#    Change Billing Mode    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Navigate To Update Product Window    ${pos_data}
    ${product_price}    Apply Item Manual Discount | Update Product Popup    ${pos_data}
    Apply Item Manual Discount | Select From List    ${pos_data}
    Verify Item Manual Discount   ${product_price}
    Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}


Zwing_E_50 select a exchange product ,apply item level manual discount then check the response.
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_49
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
#    Change Billing Mode    ${pos_data}

Zwing_E_92 From dropdown on billing screen, select Exchange option
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_92
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Switch To Exchange Mode    ${pos_data}
    Verify Exchange Option Popup

Zwing_E_93 Click on Confirm button on switch to Exchange popup box
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_93
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify Switching To Exchange Mode    ${pos_data}

Zwing_E_94 Click on Cancel button on switch to Exchange popup box
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_94
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Switch To Exchange Mode    ${pos_data}
    Verify Cancel Button On Switch To Exchange Popup

Zwing_E_95 Disable the allow Exchange Policy, and click on dropdown to change the module
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_95
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Verify Exchange Mode Is Disabled    ${pos_data}

Zwing_E_96 Search invoice by customer name to add exchange items
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_96
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link    ${pos_data}
    Select The Invoice Option Type    ${pos_data}
    Search Invoice | Exchange    ${pos_data}
    Verify Item To Be Exchanged Are Visible    ${pos_data}

Zwing_E_97 Search invoice by customer phone No. to add exchange items
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_97
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link    ${pos_data}
    Select The Invoice Option Type    ${pos_data}
    Search Invoice | Exchange    ${pos_data}
    Verify Item To Be Exchanged Are Visible    ${pos_data}

#Zwing_E_98 Search invoice by customer Invoice Number to add exchange items
#    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_98
#    Login With Valid Username And Password | POS    ${pos_data}
#    Open The Session    ${pos_data}
#    Change Billing Mode    ${pos_data}
#    Verify The +Add Exchange Items from Invoice Link    ${pos_data}
#    Select The Invoice Option Type    ${pos_data}
#    Search Invoice | Exchange    ${pos_data}
#    Verify Item To Be Exchanged Are Visible    ${pos_data}                HOLD

Zwing_E_99 Search invoice by Entering Invoice No. when Customer Name is selected
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_99
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}
    Verify The +Add Exchange Items from Invoice Link    ${pos_data}
    Select The Invoice Option Type    ${pos_data}
    Search Invoice | Exchange    ${pos_data}

Zwing_E_100 Search invoice by Entering Invoice No. when Customer Phone No. is selected
    ${pos_data}=  Fetch Testdata By Id   ${POS_TD}    E_100
    Login With Valid Username And Password | POS    ${pos_data}
    Open The Session    ${pos_data}
    Change Billing Mode    ${pos_data}

Zwing_E_101 Search invoice by Entering Customer Phone No. when Invoice No. is selected

Zwing_E_102 Search invoice by Entering Customer Phone No. when Customer Name. is selected

Zwing_E_103 Search invoice by Entering Customer Name when Invoice No. is selected

Zwing_E_104 Search Invoice by Entering Customer Name when Customer Phone No. is selected

Zwing_E_105 Entering minimum 3 digits while searching should list down all the invoices having those digits in same sequence.

Zwing_E_106 No invoices should be filtered while searching till only 2 digits are entered in the text search field

Zwing_E_107 Select the invoice for the product that needs to be exchanged

Zwing_E_108 User should be able to select/unselect all the items at once

Zwing_E_109 User should be able to select/unselect individual items

Zwing_E_110 Selecting items should auto populate the invoice qty of that item to total exchange qty

Zwing_E_111 Deselecting the item should reset the qty to 0

Zwing_E_112 Total exchange qty should be dropdown field

Zwing_E_113 Total exchange qty dropdown should not have values more than the invoiced qty

Zwing_E_114 Selecting the total exchange qty to 0 should deselect the item

Zwing_E_115 Reasons field should be a dropdown field

Zwing_E_116 User should be able to select the Reason

Zwing_E_117 Continue button should be disabled if Total exchange qty is not selected.

Zwing_E_118 User should be able to select the Reason

Zwing_E_119 Continue button should be disable if reason not selected

Zwing_E_120 Click on Cancel button on Select Items to exchange popup box

Zwing_E_121 Click Confirm button on Select Items to exhance popup box

Zwing_E_122 Switching Between Billing to Exchange Will Give Confirmation Popup

Zwing_E_123 Click on Confirm button on switch to Billing popup box

Zwing_E_124 Click on Cancel button on switch to Billing popup box

Zwing_E_125 Switching Between Exchange to Billing Will Give Confirmation Popup

Zwing_E_126 Click on Confirm button on switch to Order popup box

Zwing_E_127 Click on Cancel button on switch to Order popup box

Zwing_E_128 Switching Between Exchange to Order Will Give Confirmation Popup

Zwing_E_129 Click on Confirm button on switch to Return popup box

Zwing_E_130 Click on Cancel button on switch to Return popup box

Zwing_E_131 Switching Between Exchange to Return Will Give Confirmation Popup
