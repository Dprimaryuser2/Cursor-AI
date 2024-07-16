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

Search Invoice | Exchange
   [Arguments]    ${mode}
   ${my_dict}    Create Dictionary   &{mode}
   Wait Until Page Contains Element    ${search_invoice_field}   timeout=10s
   Input Text    ${search_invoice_field}    ${my_dict.search_invoice}
   Press Keys   ${search_invoice_field}   ENTER
   Wait Until Page Contains Element    ${searched_invoice_heading_row}  timeout=10s
   Page Should Contain Element    ${searched_invoice_heading_row}

Select Invoice From Search Options
    Wait Until Page Contains Element    ${first_row_invoice}    timeout=30s
    Click Element    ${first_row_invoice}

Select Items For Exchange
    Sleep    1s
    [Arguments]    ${qty}
    ${my_dict}    Create Dictionary   &{qty}
    Wait Until Page Contains Element    ${select_item_for_exchange_title}   timeout=20s
    Sleep    1s
    Wait Until Page Contains Element    ${exchange_qty}     timeout=10s
    Click Element    ${exchange_qty}
    Click Element    //select[@class="fs-12 custom-select"]//option[contains(text(),"${my_dict.replace_qty}")]
    Click Element    ${search_reason_dropdown}
    Click Element    ${exchange_reason_option}
    Click Element    ${continue_btn_exchange_window}

Add Product For Exchange
    Wait Until Page Contains Element    ${add_product_for_exchange_btn}     timeout=10s
    Click Element    ${add_product_for_exchange_btn}

Scan Barcode To Add Item And Quantity To Cart | Exchange
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.buy_items}
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
#    IF    ${clear_item_enabled}
#      Click Element    ${clear_all_items}
#      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
#    END
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        Sleep    1s
        Click Element    ${product_search_bar}
        Input Text    ${product_search_bar}    ${key}
        Wait Until Element Is Enabled    ${search_add_button}    timeout=20s
        Sleep    1s
        Click Element    ${search_add_button}
        ${multiple_product_present}=    Run Keyword And Return Status    Element Should Be Visible    ${select_mrp}
        IF    ${multiple_product_present}
            Add Multiple MRP Products
        END
        Wait Until Element Contains     ${table}    ${key}    timeout=20s
        Element Should Contain    ${item_cart_table}    ${key}
        ${unit_price_amount}=    Get Text    ${price}
        ${unit_price_amount}=    Remove Characters    ${unit_price_amount}
        ${unit_price_amount}=    Convert To Number    ${unit_price_amount}
        Set Test Variable    ${unit_price_amount}
        ${quantity_in_piece}=    Run Keyword And Return Status    Element Should Contain    ${quantity_row}    Piece
        IF    ${quantity_in_piece}
            Wait Until Element Is Enabled    ${quantity_in_piece_button}    timeout=20s
            Click Button    ${quantity_in_piece_button}
            Wait Until Element Is Visible    ${piece_modal}    timeout=10s
            Clear Element Text    ${quantity_input}
            Input Text    ${quantity_input}    ${value}
            Wait Until Element Is Visible    ${update_cart_quantity}    timeout=20s
            Click Button    ${update_cart_quantity}
        ELSE
            Click Element    ${custom_select_quantity_button}
            ${custom_select_option}=    Replace String    ${custom_select_quantity}    option_value    ${value}
            ${custom_select_option}=    Replace String    ${custom_select_option}    ITEM    ${key}
            Wait Until Element Is Visible    ${custom_select_option}    timeout=20s
            Click Element    ${custom_select_option}
        END
        Wait Until Element Is Enabled    ${product_search_bar}    timeout=10s
    END
    ${items_list}=    Convert Items To List    ${my_dict.get_items}
    IF    ${items_list} != ['NULL']
#        ${items_list}=    Convert Items To List    ${my_dict.get_items}
#        Log    ${items_list}
        ${items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
        Log    ${items_dict}
        FOR    ${item}    IN    @{items_dict.items()}
            ${key}=    Set Variable    ${item}[0]
            ${values}=    Set Variable    ${item}[1]
            ${value}=    Convert To String    ${values}
            Input Text    ${product_search_bar}    ${key}
            Wait Until Element Is Enabled    ${search_add_button}    timeout=20s
            Sleep    1s
            Click Element    ${search_add_button}
            ${multiple_product_present}=    Run Keyword And Return Status    Element Should Be Visible    ${select_mrp}
            IF    ${multiple_product_present}
                Add Multiple MRP Products
            END
            Wait Until Element Contains     ${table}    ${key}    timeout=20s
            Element Should Contain    ${item_cart_table}    ${key}
            ${quantity_in_piece}=    Run Keyword And Return Status    Element Should Contain    ${quantity_row}    Piece
            IF    ${quantity_in_piece}
                Wait Until Element Is Enabled    ${quantity_in_piece_button}    timeout=20s
                Click Button    ${quantity_in_piece_button}
                Wait Until Element Is Visible    ${piece_modal}    timeout=10s
                Clear Element Text    ${quantity_input}
                Input Text    ${quantity_input}    ${value}
                Wait Until Element Is Visible    ${update_cart_quantity}    timeout=20s
                Click Button    ${update_cart_quantity}
            ELSE
                Click Element    ${custom_select_quantity_button}
                ${custom_select_option}=    Replace String    ${custom_select_options}    option_value    ${value}
                Wait Until Element Is Visible    ${custom_select_option}    timeout=20s
                Click Element    ${custom_select_option}
            END
            Wait Until Element Is Enabled    ${product_search_bar}    timeout=10s
        END
    END