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