*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../../Resources/CustomKeywords/utilities.py
Resource   ../../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Variables    ../../../../PageObjects/Web_POS/POS/hold_bill_locators.py
Variables    ../../../../PageObjects/AdminConsole/POSTerminal/pos_terminal.py
Variables   ../../../../PageObjects/Web_POS/POS/checkout_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/pos_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/add_customer_locator.py
Variables   ../../../../Environment/environment.py

*** Keywords ***
Verify Shortcut Key Allows Searching Product
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Element Should Be Focused    ${product_search_bar}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        Input Text    ${product_search_bar}    ${key}
        Wait Until Page Contains Element    ${product_search_dropdown}
        Page Should Contain    ${key}
    END
    Page Should Contain Element    ${product_search_dropdown}

Verify Shortcut Key Displays And Hide Catalogue Window
    [Arguments]    ${pos_data}
    Wait Until Page Contains Element    ${product_catalog_body}
    Page Should Contain Element    ${product_catalog_body}
    Page Should Contain Element    ${hide_catalog_button}
    Press Shortcut Key    ${pos_data}
    Page Should Contain Element    ${view_catalog_button}
    Page Should Not Contain Element    ${hide_catalog_button}

Verify Shortcut Key Allows Updating Catalogue
    Wait Until Page Contains Element    ${catalog_update}    timeout=20s
    Page Should Contain Element    ${catalog_update}
    Page Should Contain Element    ${keyboard_shortcuts_link}
    Page Should Contain Element    ${done_progress}

Verify Shortcut Key Displays Salesperson Details
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Wait Until Element Is Enabled    ${checkout_button}
    Page Should Contain Element    ${assign_salesperson_window_heading}
    Page Should Contain Element    ${name_in_assign_salesperson_row}

Verify Shortcut Key Allows Navigating To Held Bills
    Wait Until Page Contains Element    ${recall_bill}
    Page Should Contain Element    ${discard_bill}
    Page Should Contain Element    ${return_to_bill}
    Page Should Not Contain Element    ${hold_bill}

Verify Shortcut Key Holds Bill
    Wait Until Page Contains Element    ${hold_bill_confirmation}
    Click Element    ${hold_bill_confirmation}
    Wait Until Page Contains Element    ${bill_held_successful_message}

Verify Shortcut Key Allows Adding Manual Discount
    Wait Until Page Contains Element    ${manual_discount_heading}    timeout=20s
    Element Should Be Enabled    ${apply_manual_discount_button}
    Click Element    ${apply_manual_discount_button}
    Wait Until Page Does Not Contain Element    ${apply_manual_discount_button}    timeout=10
    Wait Until Page Contains Element    ${manual_discount_applied_message}    timeout=30s

Verify Shortcut Key Allows Adding Carry Bags
    [Arguments]    ${pos_data}
    ${carry_bag_dict}    Create Dictionary    &{pos_data}
    ${items_list}=    Convert Items To List    ${carry_bag_dict.carry_bag}
    ${items_dict} =    Convert Item List To Dictionary    ${items_list}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To Integer    ${values}
        ${carry_bag_option}=   Replace String   ${carry_bag_input_field}    Carry bag   ${key}
        Wait Until Page Contains Element    ${carry_bag_option}
        Input Text    ${carry_bag_option}    ${value}
    END
    Wait Until Element Is Enabled    ${add_carry_bag_unit_button}
    Click Element    ${add_carry_bag_unit_button}
    Wait Until Page Contains Element    ${carry_bag_added_message}

Verify Shortcut Key Allows Tagging Customer
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${customer_phone_field}
    Click Element    ${customer_phone_field}
    Input Text    ${customer_phone_field}    ${my_dict.mobile}
    Wait Until Element Is Enabled    ${continue_billing_button}
    Click Element    ${continue_billing_button}
    Wait Until Page Contains Element    ${start_billing_button}
    Wait Until Element Is Enabled    ${start_billing_button}
    Click Element    ${start_billing_button}
    Wait Until Page Contains Element    ${customer_tagged_popup}

Verify Customer Information Is Displayed For Tag A Customer After Tagging Customer
    Wait Until Page Contains Element    ${customer_untag_button}     timeout=10s
    Page Should Contain Element    ${customer_untag_button}
    Page Should Contain Element    ${customer_edit_groups_button}
    Page Should Contain Element    ${customer_edit_info_button}

Verify Shortcut Key Clears The Cart
    Wait Until Page Does Not Contain Element    ${product_name_in_cart_row}
    Page Should Not Contain Element    ${checkout_button}
    Page Should Not Contain Element    ${clear_all_items}
    Page Should Not Contain Element    ${first_item_product_name}

Verify Shortcut Navigates To Checkout Page
    Wait Until Page Contains Element    ${checkout_heading}
    Page Should Contain Element    ${checkout_payable_amount}
    Page Should Contain Element    ${checkout_account_balance}
    Page Should Contain Element    ${checkout_bill_discount}

Verify Shortcut Navigates To Checkout Page When ST Is Mandatory
    Wait Until Page Contains Element    ${salesperson_mandatory_message}
    Page Should Not Contain Element    ${checkout_heading}

Verify Shortcut Navigates To Checkout Page When CT Is Mandatory
    Wait Until Page Contains Element    ${customer_tagging_mandatory_alert}
    Page Should Contain Element    ${customer_tagging_mandatory_alert}
    Element Should Be Visible      ${customer_tagging_mandatory_alert}
    Page Should Not Contain Element    ${checkout_heading}

Press Shortcut Key
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    ${shortcut_keys}=    Set Variable    ${my_dict.shortcut_key}
    ${keys}=    Get Key Combination    ${shortcut_keys}
    Press Keys    None    ${keys}

Verify Shortcut Navigates To Checkout Page When Session Is Closed
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${close_session_icon}  timeout=5s
    Click Element    ${close_session_icon}
    Wait Until Page Contains Element    ${closing_balance_money_field}  timeout=5s
    Sleep  1s
    ${items_list}=    Convert Items To List    ${my_dict.closing_balance}
        ${items_dict} =    Convert Item List To Dictionary    ${my_dict.closing_balance}
        FOR    ${item}    IN    @{items_dict.items()}
            ${key}=    Set Variable    ${item}[0]
            ${key}    Convert To String    ${key}
            ${values}=    Set Variable    ${item}[1]
            ${value}=    Convert To String    ${values}
            ${balance_field}    Replace String    ${money_input_field}    AMOUNT      ${key}
            Input Text    ${balance_field}    ${value}
        END
        Click Element    ${open_session_submit_button}
        Wait Until Element Is Not Visible    ${closing_balance_note_tab}    timeout=20s
    Wait Until Element Is Enabled    ${session_close_button}  timeout=5s
    Click Element    ${session_close_button}
    Press Shortcut Key    ${pos_data}
    ${status}=  Run Keyword And Return Status    Element Should Be Visible    ${insufficient_inventory_title}
    IF    ${status}
         Click Element    ${insufficient_inventory_continue_btn}
         Press Shortcut Key    ${pos_data}
    END

Verify Shortcut Does Not Navigates To Checkout Page When Session Is Closed
    Wait Until Page Contains Element    ${open_session_before_continuing}    timeout=15s
    Page Should Contain Element    ${open_session_before_continuing} 

Open Session Before Revoking Serial Key
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Press Keys    None     CTRL+2
    Sleep    1s
    ${opening_session_present}=    Run Keyword And Return Status    Element Should Be Visible    ${opening_balance}    timeout=10s
    IF    ${opening_session_present}
        Input Text    ${opening_balance}    ${my_dict.closing_balance}
        Click Element    ${open_session_submit_button}
        Wait Until Element Is Not Visible    ${opening_balance}    timeout=10s
    END

Verify Shortcut Key Allows Searching Product | Order Mode
    Wait Until Page Contains Element    ${product_search_bar}
    Element Should Be Focused    ${product_search_bar}

Verify Customer Tagging Is Mandatory Using Shortcut
    [Arguments]    ${pos_data}
    Press Shortcut Key    ${pos_data}
    ${status}=  Run Keyword And Return Status    Element Should Be Visible    ${insufficient_inventory_title}
    IF    ${status}
         Click Element    ${insufficient_inventory_continue_btn}
         Press Shortcut Key    ${pos_data}
    END
    Wait Until Element Is Visible    ${customer_tagging_mandatory_alert}    timeout=15s
    Page Should Contain Element    ${customer_tagging_mandatory_alert}

Verify Salesperson Tagging is Mandatory Using Shortcut
    [Arguments]    ${pos_data}
    Wait Until Page Contains Element    ${checkout_button}   timeout=15s
    Element Should Be Enabled    ${checkout_button}
    Press Shortcut Key    ${pos_data}
    Wait Until Page Contains Element    ${salesperson_mandatory_message}
    Page Should Not Contain Element    ${checkout_heading}

Insufficient Inventory Window | Order
    [Arguments]    ${pos_data}
    Click Element At Coordinates    ${item_cart_table}    ${20}    ${100}
    Press Shortcut Key    ${pos_data}
    Sleep    1s
    Wait Until Keyword Succeeds    5    2    Click Element    ${insufficient_inventory_continue_btn}
    Press Shortcut Key    ${pos_data}

Verify Fulfilment Option is Visible
   Wait Until Page Contains Element    ${fulfilment_option}
   Page Should Contain Element    ${fulfilment_option}