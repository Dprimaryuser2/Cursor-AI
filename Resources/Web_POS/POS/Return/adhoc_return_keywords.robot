*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../../Resources/CustomKeywords/utilities.py
Variables   ../../../../PageObjects/Web_POS/POS/pos_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/add_customer_locator.py
Variables    ../../../../PageObjects/Web_POS/Login/login_locators.py
Variables    ../../../../PageObjects/Web_POS/POS/checkout_locators.py
Resource    ../../../../Resources/Web_POS/POS/promo_keyword.robot

*** Keywords ***


Verify Mode Is Disabled
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
    END
    Wait Until Page Contains Element    ${switch_billing_dropdown}
    Click Element    ${switch_billing_dropdown}
    Wait Until Page Does Not Contain Element    //a[@role="menuitem" and contains(text(),"${my_dict.Mode}")]
    Page Should Not Contain Element    //a[@role="menuitem" and contains(text(),"${my_dict.Mode}")]


Turn Auto Switch To Billing Off
    Wait Until Page Contains Element    ${pos_settings}    timeout=5
    Click Element    ${pos_settings}
    Wait Until Page Contains Element    ${pos_settings_profile_info}    timeout=5
    Click Element    ${pos_settings_profile_info}
    Sleep    1
    Wait Until Page Contains Element    ${pos_settings_quick_actions}    timeout=5
    Click Element    ${pos_settings_quick_actions}
    Wait Until Page Contains Element    ${auto_switch_billing_toggle}    timeout=5
    ${toggle_on}    Run Keyword And Return Status    Page Should Contain Element    ${auto_switch_billing_on}
    IF    ${toggle_on}
        Click Element    ${auto_switch_billing_on}
        Sleep    0.5
    END
    Wait Until Page Contains Element    ${pos_option_sidebar}    timeout=5
    Click Element    ${pos_option_sidebar}
    Wait Until Page Contains Element    ${switch_billing_dropdown}    timeout=5

Turn Auto Switch To Billing On
    Wait Until Page Contains Element    ${pos_settings}    timeout=5
    Click Element    ${pos_settings}
    Wait Until Page Contains Element    ${pos_settings_profile_info}    timeout=5
    Click Element    ${pos_settings_profile_info}
    Sleep    1
    Wait Until Page Contains Element    ${pos_settings_quick_actions}    timeout=5
    Click Element    ${pos_settings_quick_actions}
    Wait Until Page Contains Element    ${auto_switch_billing_toggle}    timeout=5
    ${toggle_off}    Run Keyword And Return Status    Page Should Contain Element    ${auto_switch_billing_off}
    IF    ${toggle_off}
        Click Element    ${auto_switch_billing_off}
        Sleep    0.5
    END
    Wait Until Page Contains Element    ${pos_option_sidebar}    timeout=5
    Click Element    ${pos_option_sidebar}
    Wait Until Page Contains Element    ${switch_billing_dropdown}    timeout=5

Delete Item In The Cart
    Wait Until Page Contains Element    ${product_name_in_cart_row}    timeout=5
    Click Element    ${delete_product_icon}
    Wait Until Page Does Not Contain Element    ${delete_product_icon}    timeout=5

Navigate To Checkout Page
    Wait Until Element Is Enabled    ${checkout_button}    timeout=5
    Click Element    ${checkout_button}
    Wait Until Page Contains Element    ${checkout_heading}    timeout=5
    Page Should Contain Element    ${checkout_heading}    timeout=5

Cancel Auto Switch To Billing
    Click Element    ${order_management_option_sidebar}
    Wait Until Page Contains Element    ${order_management_option_sidebar}    timeout=5
    Click Element    ${pos_option_sidebar}
    Wait Until Page Contains Element    ${switch_modal_text}    timeout=5
    Wait Until Page Contains Element    ${switch_modal_cancel_button}    timeout=5
    Click Element    ${switch_modal_cancel_button}

Switch From Return Mode To Order
    Wait Until Page Contains Element    ${return_option_switch}    timeout=5
    Click Element    ${return_option_switch}
    Wait Until Page Contains Element    ${order_option}    timeout=5
    Click Element    ${order_option}
    Wait Until Page Contains Element    ${switch_confirm_button}    timeout=5
    Click Element    ${switch_confirm_button}
    Wait Until Page Contains Element    ${order_option_switch}    timeout=5
    Page Should Contain Element    ${order_option_switch}

Cancel Switch From Return Mode To Order
    Wait Until Page Contains Element    ${return_option_switch}    timeout=5
    Click Element    ${return_option_switch}
    Wait Until Page Contains Element    ${order_option}    timeout=5
    Click Element    ${order_option}
    Wait Until Page Contains Element    ${switch_cancel_button}    timeout=5
    Click Element    ${switch_cancel_button}
    Page Should Contain Element    ${return_option_switch}
    Page Should Not Contain Element    ${order_option_switch}

Switch From Return Mode To Exchange
    Wait Until Page Contains Element    ${return_option_switch}    timeout=5
    Click Element    ${return_option_switch}
    Wait Until Page Contains Element    ${exchange_option}    timeout=5
    Click Element    ${exchange_option}
    Wait Until Page Contains Element    ${switch_confirm_button}    timeout=5
    Click Element    ${switch_confirm_button}
    Wait Until Page Contains Element   ${exchange_option_switch}    timeout=5
    Page Should Contain Element    ${exchange_option_switch}

Cancel Switch From Return Mode To Exchange
    Wait Until Page Contains Element    ${return_option_switch}    timeout=5
    Click Element    ${return_option_switch}
    Wait Until Page Contains Element    ${exchange_option}    timeout=5
    Click Element    ${exchange_option}
    Wait Until Page Contains Element    ${switch_cancel_button}    timeout=5
    Click Element    ${switch_cancel_button}
    Page Should Contain Element    ${return_option_switch}
    Page Should Not Contain Element    ${exchange_option_switch}

Pay Through Store Credit Method
    Wait Until Page Contains Element    ${refund_method_store_credit_btn}
    Wait Until Page Contains Element    ${payment_method_cash}
    Click Element    ${refund_method_store_credit_btn}
    Wait Until Page Contains Element    ${voucher_continue_button}
    Click Element    ${voucher_continue_button}
    Wait Until Page Contains Element    ${print_invoice_button}
    Page Should Contain Element    ${share_invoice_button}

Pay By Cash | Return Mode
    Wait Until Page Contains Element    ${payment_method_cash}
    Click Element    ${payment_method_cash}
    Wait Until Page Contains Element    ${continue_cash_button}
    Click Element    ${continue_cash_button}
    Wait Until Page Contains Element    ${print_invoice_button}
    Page Should Contain Element    ${share_invoice_button}
