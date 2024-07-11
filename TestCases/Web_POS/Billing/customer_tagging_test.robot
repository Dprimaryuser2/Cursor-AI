*** Settings ***
Library    SeleniumLibrary
Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/promo_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Resource    ../../../Resources/Web_POS/POS/customer_keyword.robot

Test Setup    Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}customer_tagging_test_data.xlsx

*** Test Cases ***
TC_C1 Customer Tagging is not mandatory with Bill on POS
     [Tags]    Demo
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_01
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Verify Customer Tagging Is Not Mandatory
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}
     
TC_C2 Customer Tagging is mandatory with Bill on POS
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_02
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Verify Customer Tagging Is Mandatory
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify Customer Tagging    ${customer_info}
     Verify Billing Checkout
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}
     
TC_C3 Customer Tagging is mandatory with non mandatory customer information
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_03
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Verify Customer Tagging Is Mandatory
     Verify Customer Tagging Is Mandatory With Non Mandatory Information
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

TC_C4 Customer Tagging is mandatory with all fields mandatory in customer information
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_04
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     Verify Customer Tagging Is Mandatory With All Fields    ${pos_data}
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

TC_C5 Get the Customer Information of tagged Customer
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_05
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     Verify And Fetch Customer Information    ${customer_info}
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

TC_C6 Edit Customer Information
     ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_06
     Login With Valid Username And Password | POS   ${pos_data}
     Open The Session    ${pos_data}
     Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
     ${customer_info}    Add Customer Details    ${pos_data}
     ${customer_info}    Edit Customer Information
     Verify Customer Tagging    ${customer_info}
     Revoke Serial Key    ${pos_data}
    [Teardown]    Tear It Down If Test Case Failed    ${pos_data}

