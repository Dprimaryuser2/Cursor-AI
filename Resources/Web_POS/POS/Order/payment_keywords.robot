*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../../Resources/CustomKeywords/utilities.py
Variables   ../../../../PageObjects/Web_POS/POS/pos_locators.py
Variables    ../../../../PageObjects/Web_POS/POS/add_customer_locator.py
Variables    ../../../../PageObjects/Web_POS/POS/checkout_locators.py
Variables    ../../../../PageObjects/Web_POS/POS/order_locators.py
Variables    ../../../../PageObjects/Web_POS/Login/login_locators.py
Variables   ../../../../Environment/environment.py

*** Keywords ***
Set Fulfillment Date And Continue
    Wait Until Element Is Enabled    ${checkout_button}    timeout=5
    Click Element    ${checkout_button}
    Wait Until Page Contains Element    ${insufficient_inventory_title}    timeout=5
    Wait Until Element Is Enabled    ${insufficient_inventory_continue_btn}    timeout=5
    Click Element    ${insufficient_inventory_continue_btn}
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

Verify Order Can Be Placed Without Payment
    Wait Until Element Is Enabled    ${place_order_button}
    Click Element    ${place_order_button}
    Wait Until Page Contains Element    ${order_summary_page_heading}
    Page Should Contain Element    ${order_summary_status_pending}
    Wait Until Element Is Enabled    ${confirm_order_button}
    Page Should Contain Element    ${print_order_receipt}

Place Order With Minimum Amount
    Wait Until Page Contains Element    ${checkout_split_payment}
    Click Element    ${checkout_split_payment}
    Wait Until Element Is Enabled    ${checkout_payable_amount}
    ${total}    Get Text    ${grand_total}
    ${number_only}    Remove Characters    ${total}
    ${ten_percent}=    Evaluate    ${number_only} * 0.1
    Sleep    0.5
    Input Text    ${checkout_payable_amount}    ${ten_percent}
    Wait Until Element Is Enabled    ${payment_method_cash}    timeout=5
    Click Element    ${payment_method_cash}
    Wait Until Page Contains Element    ${enter_cash}    timeout=5
    Clear Element Text    ${enter_cash}
    Input Text    ${enter_cash}     ${ten_percent}
    Wait Until Element Is Enabled    ${continue_cash_button}    timeout=5
    Click Element    ${continue_cash_button}
    Wait Until Page Contains Element    ${payment_saved_successful}    timeout=5
    Wait Until Page Does Not Contain Element    ${payment_saved_successful}    timeout=5
    Wait Until Element Is Enabled    ${place_order_button}    timeout=5
    Click Element    ${place_order_button}
    Wait Until Page Contains Element    ${order_summary_page_heading}    timeout=5

Verify Insufficient Inventory Buttons
    Wait Until Element Is Visible    ${checkout_button} 
    Click Element    ${checkout_button}
    Wait Until Element Is Visible    ${insufficient_inventory_title}  timeout=5s
    Wait Until Element Is Enabled    ${insufficient_inventory_continue_btn}     timeout=5
    Wait Until Element Is Enabled    ${insufficient_inventory_cancel_btn}   timeout=5
    Element Should Be Enabled    ${insufficient_inventory_continue_btn}
    Element Should Be Enabled    ${insufficient_inventory_cancel_btn}

Cancel Insufficient Inventory Popup
    Wait Until Element Is Visible    ${insufficient_inventory_cancel_btn}
    Click Element    ${insufficient_inventory_cancel_btn}
    Page Should Contain Element    ${product_search_bar}