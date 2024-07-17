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

Click On Exchange Text In Dropdown
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

Verify Exchange Text Is Clickable
    Wait Until Page Contains Element    ${switch_modal_text}
    Page Should Contain Element    ${switch_modal_text}
    Element Should Be Enabled    ${switch_confirm_button}
    Element Should Be Enabled    ${switch_cancel_button}

Click On Confirm Button | Exchange
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    Wait Until Page Contains Element    ${switch_confirm_button}    timeout=20s
    Element Should Be Enabled    ${switch_confirm_button}
    Click Element    ${switch_confirm_button}

Verify The Confirm Button | Exchange
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    Wait Until Page Contains Element    //div[@class="dropdown b-dropdown switch-billing fs-12 float-right btn-group"]//button[text()="${my_dict.Mode}"]
    Page Should Contain Element    //div[@class="dropdown b-dropdown switch-billing fs-12 float-right btn-group"]//button[text()="${my_dict.Mode}"]

Click On Cancel Button | Exchange
    Wait Until Page Contains Element    ${switch_cancel_button}    timeout=20s
    Element Should Be Enabled    ${switch_cancel_button}
    Click Element    ${switch_cancel_button}

Verify The Cancel Button | Exchange
    Wait Until Page Contains Element    ${billing_option_switch_default}
    Page Should Contain Element    ${billing_option_switch_default}

Click On +Add Exchange Items from Invoice Link
    Wait Until Page Contains Element    ${add_exchange_item_link}  timeout=30s
    Page Should Contain Element    ${add_exchange_item_link}
    Click Element    ${add_exchange_item_link}

Verify The +Add Exchange Items from Invoice Link
    Wait Until Page Contains Element    ${search_invoice_field}  timeout=30s
    Page Should Contain Element    ${search_invoice_field}
    Wait Until Page Contains Element    ${select_search_invoice_option_btn}   timeout=30s
    Page Should Contain Element    ${select_search_invoice_option_btn}

Click On Invoice Parameters
    Wait Until Page Contains Element    ${select_search_invoice_option_btn}  timeout=20s
    Page Should Contain Element    ${select_search_invoice_option_btn}
    Click Element    ${select_search_invoice_option_btn}

Verify The Invoice Parameters Are Clickable
    Wait Until Page Contains Element    ${invoice_number_search_option}   timeout=10s
    Page Should Contain Element    ${invoice_number_search_option}
    Page Should Contain Element    ${customer_name_search_option}
    Page Should Contain Element    ${customer_phone_search_option}
    Click Element    ${customer_name_search_option}
    Wait Until Page Contains Element    ${selected_parameter_invoice_option}  timeout=10s
    Page Should Contain Element    ${selected_parameter_invoice_option}

Click On The Close Tab Cross(X) | Exchange
    Wait Until Page Contains Element    ${div_svg_cross_icon}  timeout=5s
    Click Element At Coordinates    ${div_svg_cross_icon}    ${352}    ${512}

Verify The Close Tab Cross(X) | Exchange
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
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

Verify The Search Invoice Response | Exchange
   Wait Until Page Contains Element    ${searched_invoice_heading_row}  timeout=20s
   Page Should Contain Element    ${searched_invoice_heading_row}

Verify Invoice Search By Invalid Customer Data
   Wait Until Page Contains Element    ${invoice_not_found}
   Page Should Contain Element    ${invoice_not_found}
   
Verify All Columns Are Present In Item Exchange Window
   [Arguments]    ${mode}
   ${my_dict}    Create Dictionary   &{mode}
   Wait Until Page Contains Element    ${first_row_invoice}
   Click Element    ${first_row_invoice}
   Sleep  2s
   Wait Until Page Contains Element    ${select_item_for_exchange_title}  timeout=10s
   Page Should Contain Element    ${sku_barcode_col_title}
   Page Should Contain Element    ${product_name_col_title}
   Page Should Contain Element    ${qty_col_title}
   Page Should Contain Element    ${unit_price_col_title}
   Page Should Contain Element    ${exchange_qty_col_title}
   Page Should Contain Element    ${reasons_col_title}

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
    Wait Until Page Contains Element    ${exchange_reason_option}   timeout=10s
    Click Element    ${exchange_reason_option}
    ${total_quantity}=  Get Text    ${exchange_qty}
    Click Element    ${continue_btn_exchange_window}
    [Return]    ${total_quantity}

Add Product For Exchange
    Wait Until Page Contains Element    ${add_product_for_exchange_btn}     timeout=20s
    Click Element    ${add_product_for_exchange_btn}

Scan Barcode To Add Item And Quantity To Cart By Name | Exchange
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.buy_items}
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
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
    END

Scan Barcode To Add Item And Quantity To Cart | Exchange
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.buy_items}
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
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

Click on New Bill Button
    Wait Until Page Contains Element    ${new_bill_button}
    Click Element    ${new_bill_button}
    Wait Until Page Contains Element    ${cart_0}   timeout=10s

Verify Item Added In Cart | Exchange
    Wait Until Page Contains Element    ${in_store}   timeout=10s
    Page Should Contain Element    ${in_store}
    Page Should Contain Element    ${delivery}
    Wait Until Page Contains Element    ${cart_last_element}  timeout=5s
    Wait Until Page Contains Element    ${payable_amount}   timeout=15s
    Page Should Contain Element    ${payable_amount}
    Page Should Contain Element    ${sub_total}
    Page Should Contain Element    ${net_price}
    Wait Until Element Is Enabled    ${checkout_button}     timeout=20s
    Element Should Be Enabled    ${checkout_button}
    Element Should Be Enabled    ${clear_all_items}
    
Verify Exchange Page After Reload
    Wait Until Page Contains Element    ${in_store}     timeout=10s
    Page Should Contain Element    ${in_store}
#    Page Should Contain Element    ${add_exchange_item_link}

Remove Exchange Product From Cart
    Wait Until Page Contains Element    ${delete_item}  timeout=10s
    Click Element    ${delete_item}
    Sleep    0.3s

Verify Validation Message Popup | Exchange
    Wait Until Page Contains Element    ${exchange_popup}   timeout=20s
    Page Should Contain Element    ${exchange_popup}

Verify Exchange Item Is Added In The Cart
    Wait Until Page Contains Element    ${cart_last_element}    timeout=10s
    Wait Until Page Contains Element    ${add_product_for_exchange_btn}   timeout=10s
    Page Should Contain Element    ${add_product_for_exchange_btn}
    Page Should Contain Element    ${payable_amount}
    Page Should Contain Element    ${sub_total}

Verify Count of Items For Exchange After Payment
    [Arguments]     ${total_quantity}   ${total_quantity1}
    Should Not Be Equal As Numbers    ${total_quantity}    ${total_quantity1}

Verify Exchange Quantity Dopdown In Popup Is Working
   Wait Until Page Contains Element    ${select_item_for_exchange_title}  timeout=15s
   Click Element    ${exchange_qty}
   Wait Until Page Contains Element    ${exchange_qty_option}   timeout=10s
   Page Should Contain Element    ${exchange_qty_option}

Verify Continue Button | Exchange Item Window
   [Arguments]    ${mode}
   ${my_dict}    Create Dictionary   &{mode}
   Wait Until Page Contains Element    ${add_product_for_exchange_btn}  timeout=10s
   Page Should Contain Element    ${add_product_for_exchange_btn}
   Page Should Contain Element    //div[@class="dropdown b-dropdown switch-billing fs-12 float-right btn-group"]//button[text()="${my_dict.Mode}"]
   Page Should Contain Element    ${in_store}
   Page Should Contain Element    ${delivery}
   Element Should Be Enabled    ${clear_all_items}

Verify Cancel Button | Exchange Item Window
   [Arguments]    ${mode}
   ${my_dict}    Create Dictionary   &{mode}
   Wait Until Page Contains Element    ${cancel_btn_exchange_window}   timeout=10s
   Click Element    ${cancel_btn_exchange_window}
   Wait Until Page Contains Element    ${add_exchange_item_link}
   Page Should Contain Element    //div[@class="dropdown b-dropdown switch-billing fs-12 float-right btn-group"]//button[text()="${my_dict.Mode}"]
   Page Should Contain Element    ${in_store}
   Page Should Contain Element    ${delivery}

Verify Checklist Is Clickable | Exchange Item Window
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    Wait Until Page Contains Element    ${select_item_for_exchange_title}   timeout=20s
    Sleep    1s
    Click Element    ${search_reason_dropdown}
    Wait Until Page Contains Element    ${exchange_reason_option}   timeout=10s
    Click Element    ${exchange_reason_option}
    Click Element    ${first_product_row_checkbox}
    ${total_quantity}=  Get Text    ${first_row_qty_exchange}
    ${total_quantity}  Convert To String     ${total_quantity}
    ${product_selected_title}=  Get Text    ${product_selected_for_exchange_text}
    ${total_qty_message}    Replace String    //p[@class="text-primary mb-0 text-left" and contains(text(),"TOTAL products selected for exchange.")]    TOTAL    ${total_quantity}
    Wait Until Page Contains Element   ${total_qty_message}
    [Return]    ${total_quantity}

Tag Customer Without Name
    [Arguments]    ${customer_data}
    ${my_dict}    Create Dictionary   &{customer_data}
    Wait Until Element Is Enabled    ${add_customer_link}   timeout=40s
    Click Element    ${add_customer_link}
    Wait Until Element Is Visible    ${customer_phone_field}
    ${mobile}=     Generate Random Phone Number
    Set Test Variable    ${mobile}
    Input Text    ${customer_phone_field}    ${mobile}
    Click Button    ${continue_billing_button}
    Wait Until Element Is Visible    ${customer_first_name_field}    timeout=10s
    Wait Until Element Is Enabled    ${start_billing_button}    timeout=10s
    Click Button    ${start_billing_button}
    Wait Until Element Is Visible    //div[@class="popup-notification"]    timeout=10s
    Wait Until Element Is Visible    ${payable_amount}
    Wait Until Element Is Visible    ${checkout_button}    timeout=10s
    Wait Until Element Is Visible    ${customer_info_icon}    timeout=10s
    Wait Until Element Is Not Visible    //div[@class="popup-notification"]     timeout=10s
    ${customer_information}=    Create Dictionary   phone_number= ${mobile}
    [Return]    ${customer_information}

Enter Customer Name For Previously Used Number
    Click Element    ${customer_info_icon}
    Wait Until Element Is Visible    ${customer_info_window_title}    timeout=10s
    Wait Until Element Is Visible    ${customer_edit_info_button}    timeout=10s
    Click Element    ${customer_edit_info_button}
    Wait Until Element Is Visible    ${customer_phone_field}    timeout=10s
    ${first_name}=    Generate Random First Name
    Input Text     ${customer_first_name_field}    ${first_name}
    ${last_name}=    Generate Random Last Name
    Input Text    ${customer_last_name_field}    ${last_name}
    Click Button    ${customer_info_update_button}
    Sleep    2
    Discard Items If Present From Previous Session
    Wait Until Element Is Visible    ${customer_info_close_element}    timeout=10s
    Click Element    ${customer_info_close_element}
    Wait Until Element Is Visible    ${customer_info_icon}    timeout=10s
    ${customer_info}    Create Dictionary    first_name=${first_name}    last_name=${last_name}
    RETURN    ${customer_info}
    
Switch To Exchange Mode
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

Verify Exchange Option Popup
    Wait Until Page Contains Element    ${switch_confirm_button}    timeout=10s
    Page Should Contain Element    ${switch_modal_text}
    Element Should Be Enabled    ${switch_confirm_button}
    Element Should Be Enabled    ${switch_cancel_button}

Verify Switching To Exchange Mode
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    Page Should Contain Element    ${add_exchange_item_link}
    Page Should Contain     ${my_dict.Mode}

Verify Cancel Button On Switch To Exchange Popup
    Click Button    ${switch_cancel_button}
    Page Should Not Contain Element    ${add_exchange_item_link}

Verify Exchange Mode Is Disabled
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    Wait Until Page Contains Element    ${switch_billing_dropdown}
    Click Element    ${switch_billing_dropdown}
    Page Should Not Contain Element      //a[contains(text(),"${my_dict.Mode}")]

Verify Item To Be Exchanged Are Visible
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    Wait Until Page Contains Element    ${searched_invoice_number_heading}
    Page Should Contain Element    ${searched_invoice_number_heading}
    Page Should Contain Element    ${searched_invoice_date_heading}
    Page Should Contain Element    ${searched_invoice_item_heading}
    Page Should Contain Element    ${searched_invoice_amount_heading}
    Page Should Contain Element    ${searched_invoice_customer_name_heading}
    Page Should Contain Element    ${searched_invoice_phone_number}
    Element Should Contain    ${searched_invoice_table}    ${my_dict.search_invoice}

