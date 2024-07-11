*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
#Resource    ../../../Resources/Web_POS/POS/promo_keyword.robot
#Resource    ../../AdminConsole/Login/login_keyword.robot
#Resource    ../../AdminConsole/POSTerminal/pos_terminal_keyword.robot
Variables    ../../../PageObjects/Web_POS/POS/hold_bill_locators.py
Variables    ../../../PageObjects/AdminConsole/POSTerminal/pos_terminal.py
Variables   ../../../PageObjects/Web_POS/POS/checkout_locators.py
Variables   ../../../PageObjects/Web_POS/POS/pos_locators.py
Variables   ../../../PageObjects/Web_POS/POS/add_customer_locator.py
Variables   ../../../Environment/environment.py

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

Verify Shortcut Key Displays Catalogue Window
    Wait Until Page Contains Element    ${view_catalog_button}
    Press Keys    CTRL+g
    Page Should Contain Element    ${product_catalog_body}

Verify Shortcut Key Allows Updating Catalogue
    Wait Until Page Contains Element    ${view_catalog_button}
    Press Keys    CTRL+g
    Page Should Contain Element    ${product_catalog_body}
    Press Keys    CTRL+ALT+r
    Wait Until Page Contains Element    ${catalog_update}

Verify Shortcut Key Displays Salesperson Details
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Wait Until Element Is Enabled    ${checkout_button}
    Press Keys    CTRL+1
    Wait Until Page Contains Element    ${assign_salesperson_window_heading}
    Wait Until Page Contains Element    ${name_in_assign_salesperson_row}

Verify Shortcut Key Allows Navigating To Held Bills
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Wait Until Element Is Enabled    ${hold_bill}
    Click Element    ${hold_bill}
    Wait Until Element Is Enabled    ${hold_bill_confirmation}
    Click Element    ${hold_bill_confirmation}
    Wait Until Page Contains Element    ${bill_held_successful_message}
    Wait Until Page Contains Element    ${view_held_bills}
    Press Keys    CTRL+2
    Wait Until Page Contains Element    ${recall_bill}

Verify Shortcut Key Holds Bill
    Wait Until Page Contains Element    ${hold_bill}
    Press Keys    CTRL+3
    Wait Until Page Contains Element    ${hold_bill_confirmation}
    Click Element    ${hold_bill_confirmation}
    Wait Until Page Contains Element    ${bill_held_successful_message}

Verify Shortcut Key Allows Adding Manual Discount
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Press Keys    CTRL+5
    Wait Until Page Contains Element    ${manual_discount_heading}
    Wait Until Element Is Enabled    ${apply_manual_discount_button}
    Click Element    ${apply_manual_discount_button}
    Wait Until Page Contains Element    ${manual_discount_applied_message}

Verify Shortcut Key Allows Adding Carry Bags
    Wait Until Page Contains Element    ${product_search_bar}
    Press Keys    CTRL+6
    Wait Until Page Contains Element    ${carry_bag_input_field}
    Click Element    ${carry_bag_input_field}
    Input Text    ${carry_bag_input_field}    1
    Wait Until Element Is Enabled    ${add_carry_bag_unit_button}
    Click Element    ${add_carry_bag_unit_button}
    Wait Until Page Contains Element    ${carry_bag_added_message}

Verify Shortcut Key Allows Tagging Customer
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${product_search_bar}
    Press Keys    CTRL+a
    Wait Until Page Contains Element    ${customer_phone_field}
    Click Element    ${customer_phone_field}
    Input Text    ${customer_phone_field}    ${my_dict.customer_phone_number}
    Wait Until Element Is Enabled    ${continue_billing_button}
    Click Element    ${continue_billing_button}
    Wait Until Page Contains Element    ${start_billing_button}
    Wait Until Element Is Enabled    ${start_billing_button}
    Click Element    ${start_billing_button}
    Wait Until Page Contains Element    ${customer_tagged_popup}

Verify Shortcut Key Clears The Cart
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Press Keys    CTRL+x
    Wait Until Page Does Not Contain Element    ${product_name_in_cart_row}

Verify Shortcut Navigates To Checkout Page
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Press Keys    CTRL+b
    Wait Until Page Contains Element    ${checkout_heading}

Verify Shortcut Navigates To Checkout Page When ST Is Mandatory
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Press Keys    CTRL+b
    Wait Until Page Contains Element    ${salesperson_mandatory_message}
    Page Should Not Contain Element    ${checkout_heading}

Verify Shortcut Navigates To Checkout Page When CT Is Mandatory
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Press Keys    CTRL+b
    Wait Until Page Contains Element


Verify Shortcut Key Allows Tagging Customer
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${product_search_bar}
    Press Keys    CTRL+a
    Wait Until Page Contains Element    ${customer_phone_field}
    Click Element    ${customer_phone_field}
    Input Text    ${customer_phone_field}    ${my_dict.customer_phone_number}
    Wait Until Element Is Enabled    ${continue_billing_button}
    Click Element    ${continue_billing_button}
    Wait Until Page Contains Element    ${start_billing_button}
    Wait Until Element Is Enabled    ${start_billing_button}
    Click Element    ${start_billing_button}
    Wait Until Page Contains Element    ${customer_tagged_popup}

Verify Shortcut Key Clears The Cart
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Press Keys    CTRL+x
    Wait Until Page Does Not Contain Element    ${product_name_in_cart_row}

Verify Shortcut Navigates To Checkout Page
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Press Keys    CTRL+b
    Wait Until Page Contains Element    ${checkout_heading}

Verify Shortcut Navigates To Checkout Page When ST Is Mandatory
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Press Keys    CTRL+b
    Wait Until Page Contains Element    ${salesperson_mandatory_message}
    Page Should Not Contain Element    ${checkout_heading}

Verify Shortcut Navigates To Checkout Page When CT Is Mandatory
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Press Keys    CTRL+b
    Wait Until Page Contains Element    ${customer_tagging_mandatory_alert}
    Page Should Not Contain Element    ${checkout_heading}

Verify Shortcut Navigates To Checkout Page When Session Is Closed
    Wait Until Page Contains Element    ${close_session_icon}
    Click Element    ${close_session_icon}
    Wait Until Page Contains Element    ${closing_balance_field}
    Input Text    ${closing_balance_field}    100
    Wait Until Element Is Enabled    ${close_session_button}
    Click Element    ${close_session_button}
    Press Keys    CTRL+b
    Wait Until Page Contains Element

Verify Shortcut Key Allows Searching Product | Order Mode
    Wait Until Page Contains Element    ${product_search_bar}
    Element Should Be Focused    ${product_search_bar}


Press Shortcut Key
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    ${shortcut_keys}=    Set Variable    ${my_dict.shortcut_key}
    ${keys}=    Get Key Combination    ${shortcut_keys}
    Press Keys    None    ${keys}