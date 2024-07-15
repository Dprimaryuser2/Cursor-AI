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
Resource    ../../../../Resources/Web_POS/POS/Billing/split_payment_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/Billing/manual_discount_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/Exchange/exchange_keyword.robot

*** Keywords ***
Cancel No Payment Required | Checkout Page
    Wait Until Page Contains Element    ${no_payment_required_confirm_button}
    Page Should Contain Element     ${no_payment_required_confirm_button}
    Click Element   ${no_payment_required_cancel_button}

Verify Exchange Text Is Clickable
   [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
    END
    Wait Until Page Contains Element    ${switch_billing_dropdown}
    Click Element    ${switch_billing_dropdown}
    Click Element    //a[contains(text(),"${my_dict.Mode}")]
    Wait Until Page Contains Element    ${switch_modal_text}
    Page Should Contain Element    ${switch_modal_text}
    Element Should Be Enabled    ${switch_confirm_button}
    Element Should Be Enabled    ${switch_cancel_button}

Verify The Confirm Button | Exchange
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    Wait Until Page Contains Element    ${switch_confirm_button}    timeout=20s
    Element Should Be Enabled    ${switch_confirm_button}
    Click Element    ${switch_confirm_button}
    Wait Until Page Contains Element    //div[@class="dropdown b-dropdown switch-billing fs-12 float-right btn-group"]//button[text()="${my_dict.Mode}"]
    Page Should Contain Element    //div[@class="dropdown b-dropdown switch-billing fs-12 float-right btn-group"]//button[text()="${my_dict.Mode}"]

Verify The Cancel Button | Exchange
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    Wait Until Page Contains Element    ${switch_cancel_button}    timeout=20s
    Element Should Be Enabled    ${switch_cancel_button}
    Click Element    ${switch_cancel_button}
    Wait Until Page Contains Element    ${billing_option_switch_default}
    Page Should Contain Element    ${billing_option_switch_default}

Verify The +Add Exchange Items from Invoice Link
    Wait Until Page Contains Element    ${add_exchange_item_link}  timeout=30s
    Page Should Contain Element    ${add_exchange_item_link}
    Click Element    ${add_exchange_item_link}
    Wait Until Page Contains Element    ${search_invoice_field}  timeout=30s
    Page Should Contain Element    ${search_invoice_field}
    Wait Until Page Contains Element    ${select_search_invoice_option_btn}   timeout=30s
    Page Should Contain Element    ${select_search_invoice_option_btn}

Verify The Invoice Parameters Are Clickable
    Wait Until Page Contains Element    ${select_search_invoice_option_btn}  timeout=20s
    Page Should Contain Element    ${select_search_invoice_option_btn}
    Click Element    ${select_search_invoice_option_btn}
    Wait Until Page Contains Element    ${invoice_number_search_option}   timeout=10s
    Page Should Contain Element    ${invoice_number_search_option}
    Page Should Contain Element    ${customer_name_search_option}
    Page Should Contain Element    ${customer_phone_search_option}
    Click Element    ${customer_name_search_option}
    Wait Until Page Contains Element    ${selected_parameter_invoice_option}  timeout=10s
    Page Should Contain Element    ${selected_parameter_invoice_option}

Verify The Close Tab Cross(X) | Exchange
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    Click Element At Coordinates    ${div_svg_cross_icon}    ${352}    ${512}
    Wait Until Page Contains Element    ${add_exchange_item_link}  timeout=10s
    Element Should Be Visible    ${add_exchange_item_link}
    Page Should Contain Element    //div[@class="dropdown b-dropdown switch-billing fs-12 float-right btn-group"]//button[text()="${my_dict.Mode}"]
    Page Should Contain Element    ${delivery}
    Page Should Contain Element    ${in_store}

Select The Invoice Option Type
   [Arguments]    ${mode}
   ${my_dict}    Create Dictionary   &{mode}
   Wait Until Page Contains Element    ${select_search_invoice_option_btn}   timeout=10s
   Click Element    ${select_search_invoice_option_btn}
   Wait Until Page Contains Element    ${invoice_number_search_option}
   Click Element    //ul[@class="dropdown-menu dropdown-menu-right show"]//li//a[contains(text(),"${my_dict.select_invoice_option}")]
   Wait Until Page Contains Element   //div[@class="dropdown b-dropdown switch-billing fs-12 mr-3 btn-group"]//button[@class="btn dropdown-toggle btn-light" and contains(text(),"${my_dict.select_invoice_option}")]  timeout=10s
   Page Should Contain Element    //div[@class="dropdown b-dropdown switch-billing fs-12 mr-3 btn-group"]//button[@class="btn dropdown-toggle btn-light" and contains(text(),"${my_dict.select_invoice_option}")]

