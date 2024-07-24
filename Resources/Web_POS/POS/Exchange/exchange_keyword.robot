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
Variables  ../../../../PageObjects/Web_POS/POS/add_customer_locator.py

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

Search Invoice By Invoice Number
    [Arguments]    ${cust_info_checkout}
    Wait Until Page Contains Element    ${search_invoice_field}   timeout=10s
   Input Text    ${search_invoice_field}    ${cust_info_checkout.invoice_id}
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
    [Arguments]    ${qty}
    ${my_dict}    Create Dictionary   &{qty}
    Wait Until Page Contains Element    ${select_item_for_exchange_title}   timeout=20s
    Sleep    2s
    Wait Until Page Contains Element    ${exchange_qty}     timeout=10s
    Click Element    ${exchange_qty}
    Click Element    //select[@class="fs-12 custom-select"]//option[contains(text(),"${my_dict.replace_qty}")]
    Click Element    ${search_reason_dropdown}
    Wait Until Page Contains Element    ${exchange_reason_option}   timeout=10s
    Click Element    ${exchange_reason_option}
    ${total_quantity}=  Get Text    ${exchange_qty}
    ${product_name}=  Get Text    ${item_name_exchange}
    ${product_cost}=  Get Text    ${item_price_exchange}
    Click Element    ${continue_btn_exchange_window}
    ${exchange_item_info}=    Create Dictionary    name    ${product_name}    price    ${product_cost}
    [Return]    ${exchange_item_info}

Add Product For Exchange
    Wait Until Page Contains Element    ${add_product_for_exchange_btn}     timeout=20s
    Click Element    ${add_product_for_exchange_btn}

Scan Barcode To Add Item And Quantity To Cart By Name | Exchange
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.buy_items}
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


Verify Exchange Item Info In Cart Is Correct Or Not
    [Arguments]     ${exchange_item_info}
    ${my_dict}    Create Dictionary   &{exchange_item_info}
    Wait Until Page Contains Element    ${payable_amount}   timeout=10s
    Wait Until Page Contains Element    ${add_product_for_exchange_btn}     timeout=10s
    Should Match Regexp    ${my_dict.name}    (?i).*${my_dict['name']}.*
    Should Match Regexp    ${my_dict.price}    (?i).*${my_dict['price']}.*

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
    Input Text    ${customer_phone_field}    ${my_dict.mobile}
    Click Button    ${continue_billing_button}
    Wait Until Element Is Visible    ${customer_first_name_field}    timeout=10s
    Wait Until Element Is Enabled    ${start_billing_button}    timeout=10s
    Click Button    ${start_billing_button}
    Wait Until Element Is Visible    //div[@class="popup-notification"]    timeout=10s
    Wait Until Element Is Visible    ${payable_amount}
    Wait Until Element Is Visible    ${checkout_button}    timeout=10s
    Wait Until Element Is Visible    ${customer_info_icon}    timeout=10s
    Wait Until Element Is Not Visible    //div[@class="popup-notification"]     timeout=10s
    ${customer_information}=    Create Dictionary   phone_number= ${my_dict.mobile}
    [Return]    ${customer_information}

Enter Customer Name For Previously Used Number
    [Arguments]    ${customer_data}
    ${my_dict}    Create Dictionary   &{customer_data}
    Wait Until Element Is Enabled    ${add_customer_link}   timeout=40s
    Click Element    ${add_customer_link}
    Wait Until Element Is Visible    ${customer_phone_field}
    Input Text    ${customer_phone_field}    ${my_dict.mobile}
    Click Button    ${continue_billing_button}
    Wait Until Element Is Visible    ${customer_first_name_field}    timeout=10s
    ${first_name}=  Generate Random First Name
    Input Text     ${customer_first_name_field}     ${first_name}
    Click Button    ${start_billing_button}
    Sleep    2
    ${store_item_from_previous_session}    Run Keyword And Return Status    Page Should Contain Element    ${discard_item_previous_session}
    IF    ${store_item_from_previous_session}
       Discard Items If Present From Previous Session
    END
    Wait Until Element Is Visible    ${customer_info_icon}    timeout=10s
#    ${customer_info}    Create Dictionary    first_name=${first_name}
    RETURN    ${first_name}

Verify All The Invoices Under Customer Name Are Visible
    [Arguments]    @{invoice_ids}
    Sleep  5s
    Wait Until Page Contains Element    ${all_searched_invoice}    timeout=20s
    ${invoice_texts}    Get Text    ${all_searched_invoice}
    Capture Page Screenshot
    FOR    ${invoice}    IN    @{invoice_ids}
        Should Contain    ${invoice_texts}    ${invoice}
    END

Update Customer Name | Exchange
    [Arguments]    ${customer_data}
    ${my_dict}    Create Dictionary   &{customer_data}
    Wait Until Element Is Enabled    ${add_customer_link}   timeout=40s
    Click Element    ${add_customer_link}
    Wait Until Element Is Visible    ${customer_phone_field}
    Input Text    ${customer_phone_field}    ${my_dict.mobile}
    Click Button    ${continue_billing_button}
    Wait Until Element Is Visible    ${customer_first_name_field}    timeout=10s
    Clear Element Text    ${customer_first_name_field}
    ${first_name}=  Generate Random First Name
    Input Text     ${customer_first_name_field}     ${first_name}
    Click Button    ${start_billing_button}
    Sleep    2
    Discard Items If Present From Previous Session
    Wait Until Element Is Visible    ${customer_info_icon}    timeout=10s
#    ${customer_info}    Create Dictionary    first_name=${my_dict.cust_name_tag}
    RETURN    ${first_name}

Search Invoice By Name| Exchange
   [Arguments]    ${first_name}
   Wait Until Page Contains Element    ${search_invoice_field}   timeout=10s
   Input Text    ${search_invoice_field}     ${first_name}
   Press Keys   ${search_invoice_field}   ENTER
   RETURN    ${first_name}

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
    Wait Until Page Contains Element    ${searched_invoice_table}    timeout=20s
    Page Should Contain Element    ${searched_invoice_number_heading}
    Page Should Contain Element    ${searched_invoice_date_heading}
    Page Should Contain Element    ${searched_invoice_item_heading}
    Page Should Contain Element    ${searched_invoice_amount_heading}
    Page Should Contain Element    ${searched_invoice_customer_name_heading}
    Page Should Contain Element    ${searched_invoice_phone_number}
    Element Should Contain    ${searched_invoice_table}    ${my_dict.search_invoice}

Add Exchange Items From Invoice
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    Click Element    ${add_exchange_item_link}
    Wait Until Page Contains Element    ${select_search_invoice_option_btn}   timeout=10s
    Click Element    ${select_search_invoice_option_btn}
    IF   '${my_dict.select_invoice_option}' == 'Customer Name'
        Click Element    ${customer_name_search_option}
    ELSE IF    '${my_dict.select_invoice_option}' == 'Customer Phone'
        Click Element    ${customer_phone_search_option}
    ELSE IF     '${my_dict.select_invoice_option}' == 'Invoice Number'
        Click Element    ${invoice_number_search_option}
    END
    Wait Until Page Contains Element    ${search_invoice_field}   timeout=10s
    Input Text    ${search_invoice_field}    ${my_dict.search_invoice}
    Press Keys   ${search_invoice_field}   ENTER
    Wait Until Page Contains Element    ${first_row_invoice}    timeout=30s
    ${invoice_number}=    Get Text    ${searched_invoice_number}
    ${customer_name}=    Get Text    ${searched_customer_name}
    ${phone_number}=    Get Text    ${searched_phone_number}
    ${item_quantity}=    Get Text    ${total_number_of_items}
    ${item_amount}=    Get Text    ${amount}
    ${invoice_details}=    Create Dictionary    invoice_number=${invoice_number}        customer_name=${customer_name}     phone_number=${phone_number}     item_quantity=${item_quantity}     item_amount=${item_amount}
    [Return]    ${invoice_details}

Verify Items Are Searched By 3 Digits Of Name
    [Arguments]    ${searched_product}
    ${my_dict}    Create Dictionary   &{searched_product}
    ${count}=    Get Element Count    ${searched_invoice_date}
    FOR    ${i}    IN RANGE    1     ${count}+1
        ${index}    Convert To String    ${i}
        ${name_element}=    Replace String    ${searched_customer_name}    1     ${index}
        Element Should Contain    ${name_element}    ${my_dict.search_invoice}
    END

Verify Items Are Not Searched By 2 Digits Only
    Element Should Not Be Visible    ${searched_invoice_amount_heading}
    Element Should Not Be Visible   ${searched_invoice_customer_name_heading}
    Element Should Not Be Visible    ${searched_invoice_date}
    Element Should Not Be Visible    ${searched_invoice_table}

Select All Items At Once
    Wait Until Page Contains Element    ${select_item_for_exchange_title}   timeout=20s
    Wait Until Page Contains Element    ${exchange_qty}     timeout=10s
    Click Element    ${select_all_items_checkbox}

Verify All Items Are Selected
    Checkbox Should Be Selected    ${selected_all_item}
    Page Should Contain Element    ${product_added_message}
    Page Should Contain Element    ${ensure_product_message}

Unselect All Items At Once
    Wait Until Page Contains Element    ${select_item_for_exchange_title}   timeout=20s
    Wait Until Page Contains Element    ${exchange_qty}     timeout=10s
    Click Element    ${select_all_items_checkbox}

Verify All Items Are Unselected
    Checkbox Should Not Be Selected    ${selected_all_item}
    Page Should Contain Element    ${no_product_selected_message}

Select Individual Item
    Wait Until Page Contains Element    ${select_item_for_exchange_title}   timeout=20s
    Wait Until Page Contains Element    ${exchange_qty}     timeout=10s
    Click Element    ${exchange_item_checkbox}

Verify Individual Item Is Selected
    Checkbox Should Be Selected    ${selected_item}
    Page Should Contain Element    ${product_added_message}
    Page Should Contain Element    ${ensure_product_message}

Unselect Individual Item
    Wait Until Page Contains Element    ${select_item_for_exchange_title}   timeout=20s
    Wait Until Page Contains Element    ${exchange_qty}     timeout=10s
    Click Element    ${exchange_item_checkbox}

Verify Individual Item Is Unselected
    Checkbox Should Not Be Selected    ${selected_item}
    Page Should Contain Element    ${no_product_selected_message}
#
#Verify Total QTY Auto Populated


Select The Invoice By Invoice Name | Exchange
   [Arguments]    ${invoice_id}
   Wait Until Page Contains Element    ${select_search_invoice_option_btn}   timeout=10s
   Click Element    ${select_search_invoice_option_btn}
   Wait Until Page Contains Element    ${invoice_number_search_option}
   Click Element    ${invoice_number_search_option}
   Wait Until Page Contains Element    ${search_invoice_field}   timeout=10s
   Input Text    ${search_invoice_field}     ${invoice_id}
   Press Keys   ${search_invoice_field}   ENTER
   Wait Until Page Contains Element    ${first_row_invoice}  timeout=15s

Customer Billing For Invoice Generation | Exchange
   [Arguments]    ${customer_billing}
   Scan And Add Product   ${customer_billing}
   Verify Item Added In Cart
   Tag Customer Without Name    ${customer_billing}
   ${value}    Get payable amount
   Verify Billing Checkout
   Wait Until Element Is Visible    ${payment_method_cash}
   Payment By Cash   ${value}
   Wait Until Page Contains Element    ${payment_complete_heading}
   ${cust_invoice_1}  Get Customer Details | Checkout
   Click on New Bill Button
   [Return]   ${cust_invoice_1}

Verify Already Used Exchange Invoice Response
   [Arguments]    ${invoice_id}
   Wait Until Page Contains Element    //div[@class="grey-100 col-2" and contains(text(),"${invoice_id}")]//following-sibling::div[@class="col-1"]   timeout=20s
   ${qty_value}   Get Text     //div[@class="grey-100 col-2" and contains(text(),"${invoice_id}")]//following-sibling::div[@class="col-1"]
   Should Be Equal    ${qty_value}    0

Select The Item Qty
    Wait Until Page Contains Element    ${select_item_for_exchange_title}   timeout=20s
    Wait Until Page Contains Element    ${exchange_qty}     timeout=10s
    Click Element    ${exchange_qty}

Verify QTY DropDown
    Page Should Contain Element    ${exchange_qty_option}
    ${max_qty}=    Get Text    ${total_qty_of_item}
    Page Should Contain Element    //select[@class="fs-12 custom-select"]//option[contains(text(),"${max_qty}")]

Verify QTY DropDown Does Not Have More Values
    Page Should Contain Element    ${exchange_qty_option}
    ${max_qty}=    Get Text    ${total_qty_of_item}
    Page Should Contain Element    //select[@class="fs-12 custom-select"]//option[contains(text(),"${max_qty}")]
    ${more_than_max}    Evaluate    int(${max_qty})+1
    Page Should Not Contain Element    //select[@class="fs-12 custom-select"]//option[contains(text(),"${more_than_max}")]

Select Item QTY From Drop Down
    [Arguments]    ${qty}
    ${my_dict}    Create Dictionary   &{qty}
    Wait Until Page Contains Element    ${select_item_for_exchange_title}   timeout=20s
    Sleep    1s
    Wait Until Page Contains Element    ${exchange_qty}     timeout=10s
    Click Element    ${exchange_qty}
    Click Element    //select[@class="fs-12 custom-select"]//option[contains(text(),"${my_dict.replace_qty}")]

Select Reason For Exchange
    Wait Until Page Contains Element    ${select_item_for_exchange_title}   timeout=20s
    Wait Until Page Contains Element    ${search_reason_dropdown}    timeout=20s
    Click Element    ${search_reason_dropdown}
    Wait Until Page Contains Element    ${exchange_reason_option}   timeout=10s
    Click Element    ${exchange_reason_option}

Verify User Should Be Able To See Reason Dropdown
    Click Element    ${search_reason_dropdown}
    Wait Until Page Contains Element    ${exchange_reason_option}   timeout=10s
    Page Should Contain Element        ${exchange_reason_option}

Verify User Should Be Able To Select Reason Dropdown
    Click Element    ${search_reason_dropdown}
    Wait Until Page Contains Element    ${exchange_reason_option}   timeout=10s
    Click Element    ${exchange_reason_option}
    Element Should Be Enabled    ${continue_btn_exchange_window}

Verify Continue Button Is Disabled | Exchange
    Wait Until Page Contains Element    ${exchange_qty_col_title}   timeout=10s
    Element Should Be Disabled    ${continue_btn_exchange_window}

Verify Continue Button Is Enabled Without Reason | Exchange
    Wait Until Page Contains Element    ${exchange_qty_col_title}   timeout=10s
    Element Should Be Enabled        ${continue_btn_exchange_window}

Cancel The Exchange Of Items
    Wait Until Page Contains Element    ${cancel_btn_exchange_window}   timeout=10s
    Click Element    ${cancel_btn_exchange_window}

Verify Canceling Of Exchange Item
    Page Should Contain Element    ${add_exchange_item_link}
    Element Should Not Be Visible   ${exchange_qty_col_title}
    Element Should Not Be Visible   ${reasons_col_title}
    Element Should Not Be Visible   ${qty_col_title}
    Element Should Not Be Visible   ${unit_price_col_title}
    Element Should Not Be Visible   ${exchange_qty_col_title}

Verify The Confirmation Of item To Be Exchanged
    Wait Until Page Contains Element    ${add_product_for_exchange_btn}    timeout=20s
    Page Should Contain Element    ${add_product_for_exchange_btn}
    Element Should Not Be Visible    ${exchange_qty_col_title}
    Element Should Not Be Visible    ${exchange_reason_option}

Assign A Salesperson To An Item | For Exchange
    [Arguments]    ${pos_data}
    ${details_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element   ${second_item_product_name}
    Click Element    ${second_item_product_name}
    Wait Until Page Contains Element    ${salesperson_dropdown}
    Click Element    ${salesperson_dropdown}
    Wait Until Page Contains Element    ${salesperson_search_field}
    Click Element    ${salesperson_search_field}
    Input Text    ${salesperson_search_field}    ${details_dict.salesperson_name}
    Click Element    ${row_in_salesperson_dropdown}
    Wait Until Page Contains Element    ${salesperson_tagged_message}
    Element Should Be Enabled    ${update_product_button}
    Click Element    ${update_product_button}

Verify If Salesperson Is Assigned To An Item | For Exchange
    [Arguments]    ${pos_data}
    ${details_dict}    Create Dictionary    &{pos_data}
    ${hide_button_present}    Run Keyword And Return Status    Page Should Contain Element    ${hide_catalog_button}
    IF    ${hide_button_present}
        Click Element    ${hide_catalog_button}
    END
    Page Should Contain Element    ${second_item_product_name}
    Click Element    ${product_preview_second}
    Page Should Contain Element    ${preview_salesperson_name}
    Element Should Contain   ${preview_salesperson_name}    ${details_dict.salesperson_name}

Verify Tag Sales Person In Exchange Product Is Correct Or Not
    Wait Until Page Contains Element    ${salesperson_exchange_alternate}   timeout=10s
    ${salesperson_1}=  Get Text    ${salesperson_exchange}
    ${salesperson_2}=   Get Text    ${salesperson_exchange_alternate}
    Should Be Equal As Strings    ${salesperson_1}    ${salesperson_2}


Verify whether user can edit or remove the sales person from exchanged product
    Wait Until Page Contains Element   ${second_item_product_name}  timeout=10s
    Click Element    ${second_item_product_name}
    Click Element    ${onclick_remove_salesperson}
    Wait Until Page Contains Element    ${salesperson_untagged_message}     timeout=10s
    Page Should Contain Element    ${salesperson_untagged_message}

Verify Refresh Button Functionality In Sales Person Tagging Is Working Or Not
    Wait Until Page Contains Element   ${second_item_product_name}  timeout=10s
    Click Element    ${second_item_product_name}
    Wait Until Page Contains Element    ${salesperson_refresh}  timeout=10S
    Click Element    ${salesperson_refresh}
    Page Should Contain Element    ${onclick_remove_salesperson}

Verify Promo Discount Apcplied In Exchanged Item Also
    Wait Until Page Contains Element    ${discount_field}
    ${price_1}=  Get Text    ${discount_field}
    ${price_2}=  Get Text    ${discount_field_row_2}
    ${clean_price_1}=    Replace String    ${price_1}    ₹    ${EMPTY}
    ${clean_price_2}=    Replace String    ${price_2}    ₹    ${EMPTY}
    ${clean_price_1}=    Replace String    ${clean_price_1}    ,    ${EMPTY}
    ${clean_price_2}=    Replace String    ${clean_price_2}    ,    ${EMPTY}
    ${abs_price_1}=    Evaluate    abs(float(${clean_price_1}))
    ${abs_price_2}=    Evaluate    abs(float(${clean_price_2}))
    Should Be Equal As Numbers    ${abs_price_1}    ${abs_price_2}


Verify Exchanged Product And Alternate Product Prices Is Correct Or Not
   ${exchange_net_price}=  Get Text     ${exchange_product_net_price}
   ${alternate_net_price}=  Get Text    ${alternate_product_net_price}
   Should Not Be Equal    ${exchange_net_price}    ${alternate_net_price}

Verify Total Amount Of Exchange and Alternate Product
   ${exchange_net_price}=  Get Text     ${exchange_product_net_price}
   ${alternate_net_price}=  Get Text    ${alternate_product_net_price}
   ${total_amount}=  Get Text    ${payable_amount}
   ${exchange}  Remove Characters    ${exchange_net_price}
   ${alternate}  Remove Characters     ${alternate_net_price}
   ${product_price}=  Evaluate    ${alternate}-${exchange}
   ${total}  Remove Characters    ${total_amount}
   Should Not Be Equal    ${product_price}    ${total}

Verify Bill Discount Is Disabled Or Not
   Element Should Be Disabled    ${bill_discount}

Verify No Payment Required | Checkout Page
    Wait Until Element Is Visible    ${no_payment_required}
    Wait Until Page Contains Element    ${no_payment_required_confirm_button}
    Page Should Contain Element    ${no_payment_required}
    Page Should Contain Element     ${no_payment_required_confirm_button}
    Page Should Contain Button    ${no_payment_required_cancel_button}

Switch From Exchange Module
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    Log    ${my_dict}
    Wait Until Page Contains Element    ${switch_billing_dropdown}
    Click Element    ${switch_billing_dropdown}
    Click Element    //a[contains(text(),"${my_dict.Switch_mode}")]

Scan Barcode To Add Item And Quantity To Cart | Multiple MRP | Exchange
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.buy_items}
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
    END
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        Sleep    0.5s
        Click Element    ${product_search_bar}
        Input Text    ${product_search_bar}    ${key}
        Wait Until Element Is Enabled    ${search_add_button}    timeout=20s
        Sleep    0.5s
        Click Element    ${search_add_button}
        Wait Until Page Contains Element    ${select_mrp}   timeout=10s
        Click Element    ${add_to_cart_mrp}
#        Wait Until Page Contains Element    @{quantity_input}   timeout=10s
        Input Text    ${quantity}   1
        Click Element   ${update_cart_quantity}
        sleep   1
    END
    
 
Verify Invoice After Complete Exchange
    Wait Until Page Contains Element    ${invoice_not_found}    timeout=10s
    Page Should Contain Element    ${invoice_not_found}
 
Verify Void Invoice For Exchange
    Wait Until Page Contains Element    ${invoice_not_found}
    Page Should Contain Element    ${invoice_not_found}
    Page Should Not Contain Element    ${first_item_product_name}


Change Billing Mode | From Return To Exchange
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
    END
    Wait Until Page Contains Element    ${switch_billing_dropdown}
    Click Element    ${switch_billing_dropdown}
    Click Element    //a[contains(text(),"Exchange")]
    Wait Until Page Contains Element    ${switch_modal_text}
    Wait Until Page Contains Element    ${switch_confirm_button}
    Page Should Contain Element    ${switch_modal_text}
    Element Should Be Enabled    ${switch_confirm_button}
    Element Should Be Enabled    ${switch_cancel_button}

Verify Confirmation Popup
    Wait Until Page Contains Element    ${switch_modal_text}
    Wait Until Page Contains Element    ${switch_confirm_button}
    Page Should Contain Element    ${switch_modal_text}
    Element Should Be Enabled    ${switch_confirm_button}
    Element Should Be Enabled    ${switch_cancel_button}

Verify Confirm Button On Switching
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    Wait Until Page Contains Element    //div[@class="dropdown b-dropdown switch-billing fs-12 float-right btn-group"]//button[text()="${my_dict.Switch_mode}"]
    Page Should Contain Element    //div[@class="dropdown b-dropdown switch-billing fs-12 float-right btn-group"]//button[text()="${my_dict.Switch_mode}"]

Verify The Cancel Button On Switch From Exchange
    Page Should Contain Element    ${add_exchange_item_link}
    Page Should Not Contain Element    ${billing_option_switch_default}
    Click Element    ${switch_confirm_button}
    Wait Until Page Contains Element    //div[@class="dropdown b-dropdown switch-billing fs-12 float-right btn-group"]//button[text()="Exchange"]
    

Verify Confirm Button For Switch To Exchange
    Click Element    ${confirm_exchange}


Verify User Is Able To Edit Or Untag Customer After Adding Exchange Product
   Wait Until Element Is Visible     ${customer_info_icon}
   Click Element    ${customer_info_icon}
   Wait Until Element Is Visible    ${customer_info_window_title}    timeout=10s
   Element Should Be Disabled    ${customer_untag_button_exchange}
   Wait Until Element Is Visible    ${customer_edit_info_button}    timeout=10s
   Click Element    ${customer_edit_info_button}
   Wait Until Element Is Visible    ${customer_phone_field}    timeout=10s
   ${first_name}=    Generate Random First Name
   Clear Element Text    ${customer_first_name_field}
   Input Text     ${customer_first_name_field}    ${first_name}
   Element Should Be Disabled    ${customer_info_update_button}

Close The Product Window
   Sleep  3s
   Click Element    ${close_product_window_button}
   Element Should Be Enabled    ${checkout_button}

Get The Net Price Of Product
   [Arguments]    ${products}
   ${my_dict}    Create Dictionary   &{products}
   ${items_list}=    Convert Items To List    ${my_dict.buy_items}
   ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
   FOR    ${item}    IN    @{items_dict.items()}
       ${key}=    Set Variable    ${item}[0]
       ${values}=    Set Variable    ${item}[1]
       ${value}=    Convert To Integer   ${values}
   END
   Sleep  1s
   ${before}=  Get Text    ${net_price}
   ${before}=  Remove Characters    ${before}
   ${net_price}=  Evaluate    ${before}/${value}
   RETURN   ${net_price}

Get The Net Price Of Product | Exchange
  Sleep  2s
  ${unit}=  Get Text    ${unit_price_of_product_ex}
  ${unit}=  Remove Characters    ${unit}
  RETURN  ${unit}

Verify The Net Price
  [Arguments]  ${net_price}  ${unit}
  Should Not Be Equal    ${net_price}    ${unit}

Add Product With Less Price Than Exchange Product
   [Arguments]    ${products}
   ${my_dict}    Create Dictionary   &{products}
    ${items_list}=    Convert Items To List    ${my_dict.add_product}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.add_product}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        Input Text    ${product_search_bar}    ${key}
        Press Keys    ${product_search_bar}    ENTER
    END
    Sleep  5s

Verify Sum Of Product Should Be Greater Than Exchange Product Alert Is Displayed
   Sleep  10s
   Page Should Contain Element   ${alert_sum_esp}
   Page Should Not Contain Button    ${checkout_button}

Verify Checkout Is Enable If Same Quantity And Net Price Is => Then Exchanged Product Net Price
  Element Should Be Enabled    ${checkout_button}

Assign Saleseperson | Before Exchange
  [Arguments]    ${pos_data}
  ${details_dict}    Create Dictionary    &{pos_data}
  Wait Until Page Contains Element    ${salesperson_button}
  Click Element    ${salesperson_button}
  Wait Until Page Contains Element    ${salesperson_search_field}  timeout=10s
  Input Text    ${salesperson_search_field}     ${details_dict.salesperson_name}
  Wait Until Page Contains Element    ${name_in_assign_salesperson_row}
  Click Element    ${name_in_assign_salesperson_row}
  Wait Until Page Contains Element    ${assign_to_all_button}   timeout=10s
  Click Element    ${assign_to_all_button}
  Click Element    ${close_assign_salesperson_window}

Add Multiple MRP Product | Exchange
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.buy_items}
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
    ${items_list}=    Convert Items To List    ${my_dict.add_product}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.add_product}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        Sleep    0.5s
        Click Element    ${product_search_bar}
        Input Text    ${product_search_bar}    ${key}
        Wait Until Element Is Enabled    ${search_add_button}    timeout=20s
        Sleep    0.5s
        Click Element    ${search_add_button}
        Wait Until Page Contains Element    ${select_mrp}   timeout=10s
        Click Element    ${mrp_product_2_row}
        Click Element    ${add_to_cart_mrp}
        Input Text    ${quantity}   ${value}
        Click Element   ${update_cart_quantity}
        sleep   1
    END

Add Multiple MRP Product
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.buy_items}
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
    END
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        Sleep    0.5s
        Click Element    ${product_search_bar}
        Input Text    ${product_search_bar}    ${key}
        Wait Until Element Is Enabled    ${search_add_button}    timeout=20s
        Sleep    0.5s
        Click Element    ${search_add_button}
        Wait Until Page Contains Element    ${select_mrp}   timeout=10s
        Click Element    ${add_to_cart_mrp}
        Input Text    ${quantity}   ${value}
        Click Element   ${update_cart_quantity}
        sleep   1
    END

Select QTY For MRP Exchange
    Wait Until Page Contains Element    ${select_item_for_exchange_title}   timeout=20s
    Sleep    1s
    Click Element    ${search_reason_dropdown}
    Wait Until Page Contains Element    ${exchange_reason_option}   timeout=10s
    Click Element    ${exchange_reason_option}
    Click Element    ${first_product_row_checkbox}
    ${total_quantity}=  Get Text    ${first_row_qty_exchange}
    ${total_quantity}  Convert To String     ${total_quantity}
    ${product_selected_title}=  Get Text    ${product_selected_for_exchange_text}
    Element Should Be Enabled    ${continue_btn_exchange_window}
    Click Element    ${continue_btn_exchange_window}
    [Return]    ${total_quantity}


Verify Salesperson Should Not Allow To Edit Or Remove From Added Alternative Product
   Wait Until Page Contains Element    ${product_row_exchange}
   ${salesperson_ex}=  Get Text    ${assigned_salesperson}
   ${salesperson_alternate}=  Get Text    ${assigned_Salesperson_alternate}
   Should Be Equal    ${salesperson_ex}    ${salesperson_alternate}
   Click Element     ${product_row_exchange}
   Wait Until Page Contains Element    ${assign_salesperson_field_disable}   timeout=2s
   Element Should Be Disabled   ${assign_salesperson_field_disable}
   Close The Product Window