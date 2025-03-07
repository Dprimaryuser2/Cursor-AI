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
Library    ../../../../Resources/CustomKeywords/utilities.py
Variables   ../../../../PageObjects/Web_POS/POS/pos_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/add_customer_locator.py
Variables    ../../../../PageObjects/Web_POS/Login/login_locators.py
Resource    ../../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
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
    Wait Until Page Contains Element    ${selected_parameter_invoice_option}   timeout=10s
    Click Element    ${selected_parameter_invoice_option}
    Wait Until Page Contains Element    ${customer_name_search_option}
    Click Element    ${select_search_invoice_option_btn}
    Click Element    ${customer_name_search_option}
    Wait Until Page Contains Element    ${option_selected_invoice}  timeout=10s
    Page Should Contain Element    ${option_selected_invoice}

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
    Wait Until Page Contains Element    ${first_row_invoice}    timeout=30
    Wait Until Keyword Succeeds    2     3    Click Element    ${first_row_invoice}

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
    Sleep    1
    Click Element    ${continue_btn_exchange_window}
    ${exchange_item_info}=    Create Dictionary    name    ${product_name}    price    ${product_cost}
    [Return]    ${exchange_item_info}

Select All Items With Same Qty For Exchange
    [Arguments]    ${qty}
    ${my_dict}    Create Dictionary   &{qty}
    Wait Until Page Contains Element    ${select_item_for_exchange_title}   timeout=10s
    Sleep    1s
    Wait Until Page Contains Element    ${exchange_qty}     timeout=10s
    ${count}    Get Webelements    ${exchange_qty}
    ${len}    Get Length    ${count}
    FOR    ${qty_count}     IN RANGE   1    ${len}+1
        Click Element    (${exchange_qty})[${qty_count}]
        Click Element    (//select[@class="fs-12 custom-select"]//option[contains(text(),"${my_dict.replace_qty}")])[${qty_count}]
        Click Element    ${search_reason_dropdown}
        Wait Until Page Contains Element    ${exchange_reason_option}   timeout=10s
        Click Element    ${exchange_reason_option}
        ${total_quantity}=  Get Text    ${exchange_qty}
        ${product_name}=  Get Text    ${item_name_exchange}
        ${product_cost}=  Get Text    ${item_price_exchange}
    END
    Wait Until Element Is Enabled        ${continue_btn_exchange_window}
    Click Element    ${continue_btn_exchange_window}


Add Product For Exchange
    Wait Until Page Contains Element    ${add_product_for_exchange_btn}     timeout=20s
    Click Element    ${add_product_for_exchange_btn}
    Wait Until Page Contains Element    ${cancel_adding_product_btn}     timeout=10s

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
        Wait Until Page Does Not Contain Element    ${search_add_button}    timeout=20s
        Wait Until Page Contains Element    ${product_name_in_cart_row}    timeout=20s
        ${multiple_product_present}=    Run Keyword And Return Status    Element Should Be Visible    ${select_mrp}
    END
    
Add Alternate Product With Same Quantity As Of Exchange Product
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${initial_product_qty_in_exc_cart}
    ${qty}    Get Text    ${initial_product_qty_in_exc_cart}
    ${clean_aty}    Remove Characters    ${qty}
    FOR    ${index}    IN RANGE    ${clean_aty}
        Add Product For Exchange
        Add Alternate Items In Exchange Cart   ${my_dict}
    END

Add 1 Alternate Product For First Exchanged Product
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${initial_product_qty_in_exc_cart}
    ${qty}    Get Text    ${initial_product_qty_in_exc_cart}
    ${clean_aty}    Remove Characters    ${qty}
    FOR    ${index}    IN RANGE    ${clean_aty}
        ${no_of_buttons}    Get Webelements    ${add_product_for_exchange_btn}
        ${count}    Get Length    ${no_of_buttons}
        FOR    ${button_no}    IN RANGE       1    ${count}-1
            Wait Until Page Contains Element    (${add_product_for_exchange_btn})[${count}]      timeout=10s
            Click Element    (${add_product_for_exchange_btn})[${count}]
            Add Alternate Items In Exchange Cart   ${my_dict}
        END
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
        Wait Until Page Does Not Contain Element    ${search_add_button}    timeout=20s
        Sleep    3
        ${multiple_product_present}=    Run Keyword And Return Status    Element Should Be Visible    ${select_mrp}
        IF    ${multiple_product_present}
            Add Multiple MRP Products
        END
    END

Add Alternate Items In Exchange Cart
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
    Should Not Be Equal As Numbers        ${total_quantity}   ${total_quantity1}

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
    Wait Until Keyword Succeeds    3    2   Click Button    ${start_billing_button}
    Wait Until Page Does Not Contain Element       ${start_billing_button}   timeout=10s
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

Verify Manual Discount Not Applicable To Exc product After Added
    Wait Until Page Contains Element    ${initial_product_in_exc_cart}    timeout=15
    Wait Until Page Contains Element    ${alternate_product_in_exc_cart}    timeout=15
    Click Element    ${initial_product_in_exc_cart}
    Click Element    ${initial_product_in_exc_cart}
    Page Should Not Contain Element    ${manual_discount_arrow}

Verify Manual Discount Not Applicable To Alternate product After Added
    Wait Until Page Contains Element    ${alternate_product_in_exc_cart}
    Click Element    ${alternate_product_in_exc_cart}
    Wait Until Page Contains Element    ${manual_discount_arrow}
    Click Element    ${manual_discount_arrow}
    Click Element    ${manual_discount_arrow}
    Page Should Not Contain Element    ${manual_discount_heading}


Verify Exc Product With Quantity 1 and Alt Product With Same Quantity And More Price Applies Same Manual Discount
    Wait Until Page Contains Element    ${alternate_product_in_exc_cart}
    Wait Until Page Contains Element    ${initial_product_in_exc_cart}
    ${alt_quantity}    Get Text    ${disabled_alternate_product_qty_in_exc_cart}
    ${exc_quantity}    Get Text    ${initial_product_qty_in_exc_cart}
    ${clean_alt_qty}    Remove Characters    ${alt_quantity}
    ${clean_exc_qty}    Remove Characters    ${exc_quantity}
    Should Be Equal    ${clean_alt_qty}    1
    Should Be Equal    ${clean_alt_qty}    ${clean_exc_qty}
    ${alt_product_price}    Get Text    ${alternate_product_net_price}
    ${initial_product_price}    Get Text    ${initial_product_net_price_in_exc_cart}
    ${clean_alt_price}    Remove Characters    ${alt_product_price}
    ${clean_initial_price}    Remove Characters    ${initial_product_price}
    ${result}=     Evaluate    ${clean_alt_price}>${clean_initial_price}
    Log    ${result}
    Should Be True    ${result}
    ${alt_md}    Get Text    ${alternate_product_discount_price}
    ${exc_md}    Get Text    ${initial_product_discount_price}
    ${clean_alt_price}    Remove Characters   ${alt_md}
    ${clean_exc_price}    Remove Characters   ${exc_md}
    Should Be Equal    ${clean_alt_price}    ${clean_exc_price}
    
Verify Exc Product With Quantity more than 1 and Alt Product With Same Quantity And More Price Applies Same Manual Discount
    Wait Until Page Contains Element    ${alternate_product_in_exc_cart}
    Wait Until Page Contains Element    ${initial_product_in_exc_cart}
    ${alt_quantity}    Get Text    ${disabled_alternate_product_qty_in_exc_cart}
    ${exc_quantity}    Get Text    ${initial_product_qty_in_exc_cart}
    ${clean_alt_qty}    Remove Characters    ${alt_quantity}
    ${clean_exc_qty}    Remove Characters    ${exc_quantity}
    Should Not Be Equal    ${clean_alt_qty}    1
    Should Be Equal    ${clean_alt_qty}    ${clean_exc_qty}
    ${alt_product_price}    Get Text    ${alternate_product_net_price}
    ${initial_product_price}    Get Text    ${initial_product_net_price_in_exc_cart}
    ${clean_alt_price}    Remove Characters    ${alt_product_price}
    ${clean_initial_price}    Remove Characters    ${initial_product_price}
#    ${num_alt}    Convert To Number    ${clean_alt_price}
#    ${num_initial}    Convert To Number    ${clean_initial_price}
#    ${int_alt}    Convert To Integer    ${num_alt}
#    ${int_initial}    Convert To Integer    ${num_initial}
    ${result}=     Evaluate    ${clean_alt_price}>${clean_initial_price}
    Log    ${result}
    Should Be True    ${result}
    ${alt_md}    Get Text    ${alternate_product_discount_price}
    ${exc_md}    Get Text    ${initial_product_discount_price}
    ${clean_alt_price}    Remove Characters   ${alt_md}
    ${clean_exc_price}    Remove Characters   ${exc_md}
    Should Be Equal    ${clean_alt_price}    ${clean_exc_price}

Verify Exc Product With Quantity more than 1 and Alt Product With Same Quantity And Less Price Shows Validation
    Wait Until Page Contains Element    ${alternate_product_in_exc_cart}
    Wait Until Page Contains Element    ${initial_product_in_exc_cart}
    ${alt_quantity}    Get Text    ${disabled_alternate_product_qty_in_exc_cart}
    ${exc_quantity}    Get Text    ${initial_product_qty_in_exc_cart}
    ${clean_alt_qty}    Remove Characters    ${alt_quantity}
    ${clean_exc_qty}    Remove Characters    ${exc_quantity}
    Should Not Be Equal    ${clean_alt_qty}    1
    Wait Until Page Contains Element    ${esp_alert}    timeout=10
    Page Should Contain Element    ${esp_alert}

Verify Alt Product Has Less Effective Price But More Net Price
    Wait Until Page Contains Element    ${alternate_product_price}    timeout=10
    Wait Until Page Contains Element    ${initial_product_price_in_exc_cart}    timeout=10
    ${alt_eff_price}    Get Text    ${alternate_product_price}
    ${alt_clean_eff}    Remove Characters    ${alt_eff_price}
    ${exc_eff_price}    Get Text    ${initial_product_price_in_exc_cart}
    ${exc_clean_eff}    Remove Characters    ${exc_eff_price}
    ${eff_result}    Is Greater    ${exc_clean_eff}    ${alt_clean_eff}
    Should Be True    ${eff_result}
    ${alt_net_price}    Get Text    ${alternate_product_net_price}
    ${alt_clean_net}    Remove Characters    ${alt_net_price}
    ${exc_net_price}    Get Text    ${initial_product_net_price_in_exc_cart}
    ${exc_clean_net}    Remove Characters    ${exc_net_price}
    ${net_result}    Is Greater    ${alt_clean_net}    ${exc_clean_net}
    Should Be True    ${net_result}


Verify User Cannot Change Or Remove Manual Discount When Disabled
    Wait Until Page Contains Element    ${alternate_product_in_exc_cart}
    Wait Until Page Contains Element    ${initial_product_in_exc_cart}
    Click Element    ${alternate_product_in_exc_cart}
    Wait Until Page Contains Element    ${disabled_item_level_discount_field}
    Click Element    ${cancel_icon_item_level_discount}
    Click Element    ${cancel_icon_item_level_discount}
    Page Should Contain Element    ${cancel_icon_item_level_discount}


Verify Quantity Cannot Be Increased For The Exchange Product
    Wait Until Page Contains Element    ${disabled_alternate_product_qty_in_exc_cart}
    Page Should Contain Element    ${disabled_alternate_product_qty_in_exc_cart}

Verify User Cannot Apply Item/bill Level Promotions On Alternate Product
    Wait Until Page Contains Element    ${alternate_product_in_exc_cart}
    Click Element    ${alternate_product_in_exc_cart}
    Wait Until Page Contains Element    ${active_promotion}
    Click Element    ${active_promotion}
    Wait Until Page Does Not Contain Element    ${active_promo_dropdown_row}
    Page Should Not Contain Element    ${active_promo_dropdown_row}

Verify Price Override Not Possible For Alternate Product
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${alternate_product_in_exc_cart}
    Click Element    ${alternate_product_in_exc_cart}
    Wait Until Page Contains Element    ${price_override_link}
    Click Element    ${price_override_link}
    Wait Until Page Contains Element    ${price_override_custom_price_field}
    Input Text    ${price_override_custom_price_field}    ${my_dict.price_override}
    Click Element    ${apply_override_button}
    Click Element    ${apply_override_button}
    Page Should Contain Element    ${disabled_apply_override_button}


#Verify Alternate Product With Greater Price was Added To Cart
#    Wait Until Page Contains Element    ${product_name_in_cart_row}
#    Wait Until Page Contains Element    ${alternate_product_net_price}
#    ${alt_product_price}    Get Text    ${alternate_product_net_price}
#    ${initial_product_price}    Get Text    ${initial_product_net_price_in_exc_cart}
#    ${clean_alt}    Remove Characters    ${alt_product_price}
#    ${clean_init}    Remove Characters    ${initial_product_price}
#    ${result}     Is Greater    ${clean_init}    ${clean_alt}
#    Should Be True    ${result}
Verify Alternate Product Has Less Quantity And More Net Price
    Wait Until Page Contains Element    ${alternate_product_net_price}
    ${alt_product_price}    Get Text    ${alternate_product_net_price}
    ${initial_product_price}    Get Text    ${initial_product_net_price_in_exc_cart}
    ${clean_alt}    Remove Characters    ${alt_product_price}
    ${clean_init}    Remove Characters    ${initial_product_price}
    ${result}     Is Greater    ${clean_alt}    ${clean_init}
    Should Be True    ${result}
    Element Should Be Disabled    ${disabled_checkout_button}


Verify Alternate Products With Sum Of Net Price Greater Than Exc Products Was Added To Cart
    Wait Until Page Contains Element    ${alternate_product_net_price}
    ${alt_product_price}    Get Text    ${alternate_product_net_price}
    ${initial_product_price}    Get Text    ${initial_product_net_price_in_exc_cart}
    ${clean_alt}    Remove Characters    ${alt_product_price}
    ${clean_init}    Remove Characters    ${initial_product_price}
    ${result}     Is Greater    ${clean_init}    ${clean_alt}
    Should Be True    ${result}
    Element Should Be Disabled    ${disabled_checkout_button}

Verify Alternate Product With Lesser Price was Added To Cart
    Wait Until Page Contains Element    ${esp_alert}    timeout=10
    Page Should Contain Element    ${esp_alert}
    Wait Until Page Contains Element    ${alternate_product_net_price}
    ${alt_product_price}    Get Text    ${alternate_product_net_price}
    ${initial_product_price}    Get Text    ${initial_product_net_price_in_exc_cart}
    ${clean_alt_price}    Remove Characters   ${alt_product_price}
    ${clean_init_price}    Remove Characters    ${initial_product_price}
    ${num_alt}    Convert To Number    ${clean_alt_price}
    ${num_init}    Convert To Number    ${clean_init_price}
    ${result}    Is Greater    ${num_init}    ${num_alt}
    Should Be True    ${result}
    

Verify Alternate Product With Greater Price was Added To Cart
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Wait Until Page Contains Element    ${alternate_product_net_price}
    ${alt_product_price}    Get Text    ${alternate_product_net_price}
    ${initial_product_price}    Get Text    ${initial_product_net_price_in_exc_cart}
    ${clean_alt_price}    Remove Characters   ${alt_product_price}
    ${clean_init_price}    Remove Characters    ${initial_product_price}
    ${num_alt}    Convert To Number    ${clean_alt_price}
    ${num_init}    Convert To Number    ${clean_init_price}
    ${result}    Is Greater    ${num_alt}    ${num_init}
    Should Be True    ${result}

Search Invoice By Name | Exchange
   [Arguments]    ${first_name}
   Wait Until Page Contains Element    ${search_invoice_field}   timeout=10s
   Input Text    ${search_invoice_field}     ${first_name}
   Press Keys   ${search_invoice_field}   ENTER
   RETURN    ${first_name}

Search Invoice Billing-Exchange
   [Arguments]    ${cust_name}
   Wait Until Page Contains Element    ${search_invoice_field}   timeout=10s
   Input Text    ${search_invoice_field}     ${cust_name.first_name}
   Press Keys   ${search_invoice_field}   ENTER
   RETURN    ${cust_name.first_name}

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
    ${add_item_button}    Run Keyword And Return Status    Page Should Contain Element    ${search_add_button}
    IF    ${add_item_button}
        Click Button    ${search_add_button}
    END
    Wait Until Page Contains Element    ${first_row_invoice}    timeout=10s
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
        Element Should Contain    ${name_element}    ${my_dict.search_invoice}    ignore_case=True
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


#Verify Total QTY Is 0
#


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

Verify Promo Discount Applied In Exchanged Item Also
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
    ${switch_mode}    Set Variable   ${my_dict.Switch_mode} 
    ${clean_switch_mode}     Remove Characters    ${switch_mode}
    Click Element    //a[contains(text(),"${clean_switch_mode}")]

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
    Wait Until Page Contains Element    ${invoice_not_found}    timeout=15s
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
    Wait Until Page Contains Element    ${mode_exchange}
    Click Element    ${mode_exchange}
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

Get Invoice Number
    [Arguments]    ${mode}
    ${my_dict}    Create Dictionary   &{mode}
    ${invoice_ids}    Create List
    Wait Until Page Contains Element    ${payment_complete_heading}
    ${in_id}  Get Text    ${invoice_number_checkout}
    ${in_name}  Get Text    ${invoice_customer_name}
    ${in_number}  Get Text    ${invoice_customer_phone}
    ${in_amount}  Get Text    ${total_amount_checkout}
    ${cust_info_checkout}=  Create Dictionary    invoice_id=${in_id}  invoice_name=${in_name}  phone_number=${in_number}  total_amount=${in_amount}    search_invoice=${in_id}     select_invoice_option=${my_dict.select_invoice_option}
    [RETURN]   ${cust_info_checkout}
    
Get Discount Value
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    ${price_amount_with_rs}=    Get Text    ${price}
    ${price_amount}=    Remove Characters    ${price_amount_with_rs}
    ${price_amount}=    Convert To Number    ${price_amount}  
    ${discount_amount_with_rs}=    Get Text    ${discount_field}
    ${discount_amount}=    Remove Characters    ${discount_amount_with_rs}
    ${discount_amount}=    Convert To Number    ${discount_amount}
    ${net_amount_with_rs}=    Get Text    ${net_price}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${total_value}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${total_value}    Evaluate    ${total_value}+${values}
    END
    ${price_per_item}=    Evaluate    ${discount_amount}/${total_value}
    ${discount_dict}    Create Dictionary    price_per_item=${price_per_item}    replace_qty=${my_dict.replace_qty}
    RETURN    ${discount_dict}

Verify Product Discount
    [Arguments]    ${price_per_item}
    ${my_dict}    Create Dictionary   &{price_per_item}
    ${discount_exchange_item}    Get Text    ${discount_field}
    ${discount_exchange_item}=    Remove Characters    ${discount_exchange_item}
    ${discount_exchange_item}=    Convert To Number    ${discount_exchange_item}
    ${expected_exchange_discount}=    Evaluate    ${my_dict.price_per_item}*${my_dict.replace_qty}
    Should Be Equal As Integers    ${discount_exchange_item}    ${expected_exchange_discount}
    Sleep    3s
    ${total_alternate_discount}    Set Variable    0
    FOR    ${i}    IN RANGE    0    ${my_dict.replace_qty}
        ${alternate_discount}    Get Text   ${alternate_exchange_discount_field}
        ${alternate_discount}    Remove Characters    ${alternate_discount}
        ${alternate_discount}    Convert To Number    ${alternate_discount}
        ${total_alternate_discount}    Evaluate    ${total_alternate_discount}+${alternate_discount}
    END
    Should Be Equal As Integers    ${alternate_discount}    ${discount_exchange_item}

Scan Alternate Product
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.buy_items}
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
    Sleep    1
    ${items_list}=    Convert Items To List    ${my_dict.alternate_product}
    Wait Until Page Contains Element    ${switch_confirm_button}    timeout=27s
    Wait Until Element Is Enabled    ${switch_confirm_button}    timeout=20s
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.alternate_product}
    Click Element    ${switch_confirm_button}
    Wait Until Page Contains Element    //div[@class="dropdown b-dropdown switch-billing fs-12 float-right btn-group"]//button[text()="Exchange"]    timeout=10
    

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
        Sleep    1s
        FOR    ${i}    IN RANGE    0     ${my_dict.replace_qty}
            Add Product For Exchange    
            Click Element    ${product_search_bar}
            Input Text    ${product_search_bar}    ${key}
            Press Keys    ${product_search_bar}    ENTER
            Sleep    1s
            ${multiple_product_present}=    Run Keyword And Return Status    Element Should Be Visible    ${select_mrp}
            IF    ${multiple_product_present}
                Add Multiple MRP Products
            END
        END
    END

Verify Sum Of Product Should Be Greater Than Exchange Product Alert Is Displayed
   Wait Until Element Is Visible    ${alert_sum_esp}    timeout=10s
   Page Should Contain Element   ${alert_sum_esp}
   Page Should Not Contain Button    ${checkout_button}

Verify Checkout Is Enable If Same Quantity And Net Price Is => Then Exchanged Product Net Price
  Element Should Be Enabled    ${checkout_button}

Assign Salesperson | Before Exchange
  [Arguments]    ${pos_data}
  ${details_dict}    Create Dictionary    &{pos_data}
  Wait Until Page Contains Element    ${salesperson_button}
  Click Element    ${salesperson_button}
  Wait Until Page Contains Element    ${assign_salesperson_search}  timeout=10s
  Input Text    ${assign_salesperson_search}     ${details_dict.salesperson_name}
  Wait Until Page Contains Element    ${name_in_assign_salesperson_row}
  Click Element    ${name_in_assign_salesperson_row}
  Wait Until Page Contains Element    ${assign_to_all_button}   timeout=10s
  Click Element    ${assign_to_all_button}
  Wait Until Page Contains Element    ${salesperson_below_product}    timeout=10
  Wait Until Keyword Succeeds    3    3    Click Element    ${close_assign_salesperson_window}


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
        Sleep    0.5s
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

Make Payment By UPI
    [Arguments]    ${paytm_value}
    sleep  1
    ${feedback}    Run Keyword And Return Status    Element Should Be Visible    //label[text()="Customer Feedback "]
    IF    ${feedback}
        ${text}    Generate Random Name
        Input Text    //label[text()="Customer Feedback "]//following-sibling::div/input    ${text}
        Click Button    //span[text()="Save"]//ancestor::button
    END
    ${no_payment_required}    Run Keyword And Return Status    Page Should Contain Element    ${no_payment_required_confirm_button}
    IF    ${no_payment_required}
        Page Should Contain Element     ${no_payment_required_confirm_button}
        Click Element   ${no_payment_required_confirm_button}
    ELSE
        click Element   ${upi_payment}
        ${id}=  Generate Random Phone Number
        Wait Until Page Contains Element    ${enter_paytm_transaction_id}
        Input Text      ${enter_paytm_transaction_id}   ${id}
        Click Element    ${continue_paytm_button}
    END

Scan And Add Product | Alternate
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.alternate_product}
    ${items_list}=    Convert Items To List    ${my_dict.alternate_product}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.alternate_product}
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
        Sleep    1s
        ${multiple_product_present}=    Run Keyword And Return Status    Element Should Be Visible    ${select_mrp}
        IF    ${multiple_product_present}
            Wait Until Page Contains Element    ${select_mrp}   timeout=10s
            Click Element    ${add_to_cart_mrp}
            Wait Until Page Does Not Contain Element    ${select_mrp}
        END
    END
    Wait Until Page Contains Element    ${first_item_product_name}

Add Items In Cart For Exchange | Catalog
    [Arguments]    ${quantity_data}
    ${my_dict}    Create Dictionary   &{quantity_data}
    Wait Until Element Is Visible    ${view_catalog_button}    timeout=20s
    Click Button    ${view_catalog_button}
    Wait Until Element Is Visible    ${category}    timeout=20s
    FOR    ${index}    IN RANGE    1    ${my_dict.assortment}+1
        ${categories_button}=    Replace String    ${category}    1    '${index}'
        Click Element    ${categories_button}
        Click Element    ${sub_categories_first_option}
        ${sub_category_product_name}=    Get Text    ${sub_categories_first_option}
        Wait Until Element Is Visible    ${first_item_product_name}    timeout=20s
#        Element Should Contain    ${item_cart_table}    ${sub_category_product_name}
    END

