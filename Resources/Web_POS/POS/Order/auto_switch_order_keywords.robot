*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections

Library    ../../../../Resources/CustomKeywords/utilities.py
Variables   ../../../../PageObjects/Web_POS/POS/pos_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/order_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/add_customer_locator.py
Variables    ../../../../PageObjects/Web_POS/Login/login_locators.py


*** Keywords ***
Verify Order Mode Is Disable In Policies
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    Wait Until Page Contains Element    ${switch_billing_dropdown}
    Click Element    ${switch_billing_dropdown}
    Page Should Not Contain Element    //a[contains(text(),"${my_dict.Mode}")]

Verify Order Option In Dropdown
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    Wait Until Page Contains Element    ${switch_billing_dropdown}
    Click Element    ${switch_billing_dropdown}
    Page Should Contain Element    //a[contains(text(),"${my_dict.Mode}")]

Cancel Switch From Order Mode To Billing
    Wait Until Page Contains Element    ${order_option_switch}    timeout=5
    Click Element    ${order_option_switch}
    Wait Until Page Contains Element    ${billing_option}    timeout=5
    Click Element    ${billing_option}
    Wait Until Page Contains Element    ${switch_cancel_button}    timeout=5
    Click Element    ${switch_cancel_button}
    Page Should Contain Element    ${order_option_switch}

Switch From Order Mode To Billing
    Wait Until Page Contains Element    ${order_option_switch}    timeout=5
    Click Element    ${order_option_switch}
    Wait Until Page Contains Element    ${billing_option}    timeout=5
    Click Element    ${billing_option}
    Wait Until Page Contains Element    ${switch_confirm_button}    timeout=5
    Click Element    ${switch_confirm_button}
    Wait Until Page Contains Element    ${billing_option_switch_default}    timeout=5
    Page Should Contain Element    ${billing_option_switch_default}

Verify Mode Option Popup
    [Arguments]     ${mode}
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
    END
    Wait Until Page Contains Element    ${order_option_switch}
    Click Element    ${order_option_switch}
    Click Element    ${mode}
    Wait Until Page Contains Element    ${switch_modal_text}
    Wait Until Page Contains Element    ${switch_cancel_button}
    Element Should Be Enabled    ${switch_confirm_button}
    Element Should Be Enabled    ${switch_cancel_button}

Switch From Order Mode To Exchange
    Wait Until Page Contains Element    ${order_option_switch}    timeout=5
    Click Element    ${order_option_switch}
    Wait Until Page Contains Element    ${exchange_option}    timeout=5
    Click Element    ${exchange_option}
    Wait Until Page Contains Element    ${switch_confirm_button}    timeout=5
    Click Element    ${switch_confirm_button}
    Wait Until Page Contains Element    ${exchange_option_switch}    timeout=5
    Page Should Contain Element    ${exchange_option_switch}

Cancel Switch From Order Mode To Exchange
    Wait Until Page Contains Element    ${order_option_switch}    timeout=5
    Click Element    ${order_option_switch}
    Wait Until Page Contains Element    ${exchange_option}    timeout=5
    Click Element    ${exchange_option}
    Wait Until Page Contains Element    ${switch_cancel_button}    timeout=5
    Click Element    ${switch_cancel_button}
    Page Should Contain Element    ${order_option_switch}

Switch From Order Mode To Return
    Wait Until Page Contains Element    ${order_option_switch}    timeout=5
    Click Element    ${order_option_switch}
    Wait Until Page Contains Element    ${return_option}    timeout=5
    Click Element    ${return_option}
    Wait Until Page Contains Element    ${switch_confirm_button}    timeout=5
    Click Element    ${switch_confirm_button}
    Wait Until Page Contains Element    ${return_option_switch}    timeout=5
    Page Should Contain Element    ${return_option_switch}

Cancel Switch From Order Mode To Return
    Wait Until Page Contains Element    ${order_option_switch}    timeout=5
    Click Element    ${order_option_switch}
    Wait Until Page Contains Element    ${return_option}    timeout=5
    Click Element    ${return_option}
    Wait Until Page Contains Element    ${switch_cancel_button}    timeout=5
    Click Element    ${switch_cancel_button}
    Page Should Contain Element    ${order_option_switch}

Verify Auto Switch to billing is Off | Order
    Click Element    ${customers_option_sidebar}
    Wait Until Page Contains Element    ${customers_option_sidebar}
    Click Element    ${pos_option_sidebar}
    Page Should Not Contain Element    ${switch_modal_text}
    Element Should Be Visible    ${order_option_switch}

Cancel Switch From Billing Mode To Return
    Wait Until Page Contains Element    ${billing_option_switch_default}    timeout=5
    Click Element    ${billing_option_switch_default}
    Wait Until Page Contains Element    ${return_option}    timeout=5
    Click Element    ${return_option}
    Wait Until Page Contains Element    ${switch_cancel_button}    timeout=5
    Click Element    ${switch_cancel_button}
    Page Should Contain Element    ${billing_option_switch_default}

Cancel Switch From Billing Mode To Order
    Wait Until Page Contains Element    ${billing_option_switch_default}    timeout=5
    Click Element    ${billing_option_switch_default}
    Wait Until Page Contains Element    ${order_option}    timeout=5
    Click Element    ${order_option}
    Wait Until Page Contains Element    ${switch_cancel_button}    timeout=5
    Click Element    ${switch_cancel_button}
    Page Should Contain Element    ${billing_option_switch_default}

Cancel Switch From Billing Mode To Exchange
    Wait Until Page Contains Element    ${billing_option_switch_default}    timeout=5
    Click Element    ${billing_option_switch_default}
    Wait Until Page Contains Element    ${exchange_option}    timeout=5
    Click Element    ${exchange_option}
    Wait Until Page Contains Element    ${switch_cancel_button}    timeout=5
    Click Element    ${switch_cancel_button}
    Page Should Contain Element    ${billing_option_switch_default}
