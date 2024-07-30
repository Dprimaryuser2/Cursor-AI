*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Resource   ../../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Library    ../../../../Resources/CustomKeywords/utilities.py
Library    utilities
Resource    ../../../../Resources/Web_POS/POS/Billing/split_payment_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/Billing/manual_discount_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/Exchange/exchange_keyword.robot
Variables   ../../../../PageObjects/Web_POS/POS/checkout_locators.py

*** Keywords ***
Assign A Salesperson All Items | Order
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    ${products}    Get Webelements    ${product_name_in_cart_row}
    ${product_count}    Get Length    ${products}
    Convert To Integer    ${product_count}
    Should Not Be Equal As Integers     ${product_count}    1
    Wait Until Element Is Enabled    ${salesperson_button}
    Click Element    ${salesperson_button}
    Wait Until Page Contains Element    ${assign_salesperson_window_heading}
    Wait Until Page Contains Element    ${assign_salesperson_search}
    Click Element    ${assign_salesperson_search}
    Input Text    ${assign_salesperson_search}    ${my_dict.salesperson_name}
    Wait Until Page Contains Element    ${name_in_assign_salesperson_row}
    Click Element    ${name_in_assign_salesperson_row}
    Wait Until Element Is Enabled    ${assign_to_all_button}
    Click Element    ${assign_to_all_button}
    Wait Until Page Contains Element    ${salesperson_tagged_message}
    Wait Until Page Contains Element    ${close_assign_salesperson_window}
    Click Element    ${close_assign_salesperson_window}

Navigate To Salesperson Tagging Popup | Order
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Click Element    ${product_name_in_cart_row}
    Wait Until Page Contains Element    ${salesperson_dropdown}

