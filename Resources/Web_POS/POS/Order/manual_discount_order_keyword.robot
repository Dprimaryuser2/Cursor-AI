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
Set Fulfillment Date And Continue
    ${insufficient}    Run Keyword And Return Status    Page Should Contain Element    ${insufficient_inventory_continue_btn}
    IF    ${insufficient}
       Click Element    ${insufficient_inventory_continue_btn}
    END
    Wait Until Page Contains Element    ${fulfilment_options_heading}    timeout=5
    Wait Until Page Contains Element    ${fulfilment_due_date_option}    timeout=5
    Click Element    ${fulfilment_due_date_option}
    Wait Until Page Contains Element    ${fulfilment_calendar_window}    timeout=5
    Wait Until Page Contains Element    ${last_date_of_this_month}    timeout=5
    Click Element    ${last_date_of_this_month}
    Sleep    1
    Wait Until Element Is Enabled    ${continue_fulfilment_button}    timeout=5
    Click Element    ${continue_fulfilment_button}
    Wait Until Page Does Not Contain Element    ${fulfilment_options_heading}    timeout=5

Verify Delivery Fulfillment
    Reload Page
    Wait Until Element Is Enabled    ${place_order_button}    timeout=5
    Wait Until Page Contains Element    ${min_acceptance_criteria_fulfilled}    timeout=5