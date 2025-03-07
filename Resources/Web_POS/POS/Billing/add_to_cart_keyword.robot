*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../../Resources/CustomKeywords/utilities.py
Variables   ../../../../PageObjects/Web_POS/POS/pos_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/add_customer_locator.py
Variables    ../../../../PageObjects/Web_POS/Login/login_locators.py
Resource    ../../../../Resources/Web_POS/POS/Billing/promo_keyword.robot

*** Keywords ***

Add Weighted UOM Products to Cart | Edit Cart Quantity Mode
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.buy_items}
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
      Wait Until Page Contains Element    ${cart_0}   timeout=20s
    END
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        Click Element    ${product_search_bar}
        Input Text    ${product_search_bar}    ${key}
        Wait Until Element Is Enabled    ${search_add_button}    timeout=20s
        Sleep    1s
        Click Element    ${search_add_button}
        Wait Until Page Contains Element    ${search_add_button}    timeout=10s
        ${multiple_product_present}=    Run Keyword And Return Status    Element Should Be Visible    ${select_mrp}
        IF    ${multiple_product_present}
            Wait Until Page Contains Element    ${select_mrp}   timeout=10s
            Click Element    ${add_to_cart_mrp}
            Wait Until Page Does Not Contain Element    ${select_mrp}
        END
        Sleep    1s
        Wait Until Page Contains Element    ${switch_edit_add_toggle}    timeout=15s
        # edit cart
        ${edit_toggle_enabled}    Run Keyword And Return Status    Element Should Be Visible    ${edit_toggle_on}
        IF    ${edit_toggle_enabled}
            Input Text    ${quantity_input}    ${value}
        ELSE
            Click Element    ${add_toggle_button}
            Input Text    ${quantity_input}    ${value}
        END
        Click Element    ${update_cart_quantity}
    END

Add Weighted UOM Products to Cart | Add Cart Quantity Mode
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.buy_items}
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Sleep  0.5
      ${first_item}=   Run Keyword And Return Status    Element Should Be Visible    ${first_item_product_name}   timeout=20s
      IF    ${first_item}
           Click Element    //a[@title="Delete Product"]
      END
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
      Wait Until Page Contains Element    ${cart_0}   timeout=20s
    END
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        Click Element    ${product_search_bar}
        Input Text    ${product_search_bar}    ${key}
        Wait Until Element Is Enabled    ${search_add_button}    timeout=20s
        Click Element    ${search_add_button}
        Sleep    3s
        ${multiple_product_present}=    Run Keyword And Return Status    Element Should Be Visible    ${select_mrp}
        IF    ${multiple_product_present}
            Wait Until Page Contains Element    ${select_mrp}   timeout=10s
            Click Element    ${add_to_cart_mrp}
            Wait Until Page Does Not Contain Element    ${select_mrp}
        END
        Wait Until Page Contains Element    ${switch_edit_add_toggle}    timeout=15s
        ${add_toggle_enabled}    Run Keyword And Return Status    Element Should Be Visible    ${add_toggle_button}
        IF    ${add_toggle_enabled}
            Input Text    ${quantity_input}    ${value}
        ELSE
            Click Element    ${add_toggle_button}
            Input Text    ${quantity_input}    ${value}
        END
        Click Element    ${update_cart_quantity}
        Wait Until Page Does Not Contain Element    ${update_cart_quantity}    timeout=10s
    END

Update Product Quantity | Edit Cart Quantity Mode
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    ${edit_toggle_enabled}    Run Keyword And Return Status    Element Should Be Visible    ${edit_toggle_on}
    IF    ${edit_toggle_enabled}
        Input Text    ${quantity_input}    ${my_dict.Update_Quantity}
    ELSE
        Click Element    ${add_toggle_button}
        Input Text    ${quantity_input}    ${my_dict.Update_Quantity}
    END
    Click Element    ${update_cart_quantity}

Update Product Quantity | Add Cart Quantity Mode
     [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    ${add_toggle_enabled}    Run Keyword And Return Status    Element Should Be Visible    ${add_toggle_button}
    IF    ${add_toggle_enabled}
        Input Text    ${quantity_input}    ${my_dict.Update_Quantity}
    ELSE
        Click Element    ${add_toggle_button}
        Input Text    ${quantity_input}    ${my_dict.Update_Quantity}
    END
    Click Element    ${update_cart_quantity}

Verify Item Is Added
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    Sleep    2
    ${expected_cart_quantity}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        ${quantity_in_piece}=    Run Keyword And Return Status    Page Should Contain Element    ${quantity_in_piece_button}
        IF    ${quantity_in_piece}
            ${values}    Convert To Number    ${values}
            ${expected_cart_quantity}=    Evaluate    ${expected_cart_quantity}+1
        ELSE
            ${expected_cart_quantity}=    Evaluate    ${expected_cart_quantity}+${values}
        END
        Page Should Contain    ${key}
    END
    ${expected_cart_quantity}=    Convert To String    ${expected_cart_quantity}
    Sleep    1s
    ${items_cart_quantity}    Get Text    ${cart_quantity}
    ${items_cart_quantity}    Remove Characters    ${items_cart_quantity}
    Should Be Equal As Strings    ${expected_cart_quantity}    ${items_cart_quantity}

Scan And Add Product
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.buy_items}
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
      Wait Until Page Contains Element    ${cart_0}   timeout=20s
    END
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
        Sleep    1s
        ${multiple_product_present}=    Run Keyword And Return Status    Element Should Be Visible    ${select_mrp}
        IF    ${multiple_product_present}
            Wait Until Page Contains Element    ${select_mrp}   timeout=10s
            Click Element    ${add_to_cart_mrp}
            Wait Until Page Does Not Contain Element    ${select_mrp}
        END
    END
    Wait Until Page Contains Element    ${first_item_product_name}

Verify 0 Inventory To Cart With Disable Negative Inventory
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    Wait Until Page Contains Element    ${negative_inventory_alert}    timeout=10s
    Page Should Contain Element    ${negative_inventory_alert}
    Page Should Contain Element    ${cart_0}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        Page Should Not Contain Element    ${item_cart_table}
    END

Verify 0 Inventory To Cart With Enable Negative Inventory
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Sleep    1s
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${expected_cart_quantity}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        Sleep    1s
        ${quantity_in_piece}=    Run Keyword And Return Status    Page Should Contain Element    ${weighted_quantity}
        IF    ${quantity_in_piece}
            ${expected_cart_quantity}=    Evaluate    ${expected_cart_quantity}+1
        ELSE
            ${expected_cart_quantity}=    Evaluate    ${expected_cart_quantity}+${values}
        END
        Page Should Contain    ${key}
    END
    ${expected_cart_quantity}=    Convert To String    ${expected_cart_quantity}
    ${items_cart_quantity}    Get Text    ${cart_quantity}
    ${items_cart_quantity}    Remove Characters    ${items_cart_quantity}
    Should Be Equal As Strings    ${expected_cart_quantity}    ${items_cart_quantity}
    Page Should Not Contain Element    ${negative_inventory_alert}

Add Items From Previous Session
    ${product_found_text}    Get Text    ${products_found}
    ${product_found_text}    Split String    ${product_found_text}
    ${product_count}=    Get From List    ${product_found_text}    0
    Set Test Variable    ${product_count}
    ${total_products}    Create List    
    FOR    ${i}    IN RANGE    1    ${product_count}+1
        ${product_field}    Set Variable    (${products_from_previous_session})[${i}]
        ${products}=    Get Text    ${product_field}
        Append To List    ${total_products}    ${products}
    END
    Click Button    ${add_items_to_cart}
    [Return]    ${total_products}

Close The Session
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Wait Until Keyword Succeeds    5    1    Click Element    ${close_session_icon}
    Wait Until Element Is Visible    ${close_session_header}    timeout=20s
    Input Text    ${closing_balance_field}    ${my_dict.closing_balance}
    Wait Until Element Is Enabled    ${close_session_button}    timeout=20s
    Click Button    ${close_session_button}
    Wait Until Page Does Not Contain Element    ${close_session_button}     timeout=10s
    Wait Until Element Is Visible    ${session_closed_popup}    timeout=10s
    Click Button    ${session_close_button}
    Wait Until Element Is Not Visible    ${session_closed_popup}    timeout=20s
    Wait Until Element Is Visible    ${open_session_link}   timeout=20s

Close The Session For Adding The Item From Previous Session
   [Arguments]    ${products}
   ${my_dict}    Create Dictionary   &{products}
   ${close_session}=  Run Keyword And Return Status    Element Should Be Visible    ${close_session_icon}
   IF   ${close_session}
      Wait Until Keyword Succeeds    3    5    Click Element    ${close_session_icon}
      Wait Until Element Is Visible    ${close_session_header}    timeout=20s
      ${closing_balance_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${closing_balance}
      IF    ${closing_balance_visible}
            ${items_list}=    Convert Items To List    ${my_dict.closing_balance}
            ${items_dict} =    Convert Item List To Dictionary    ${my_dict.closing_balance}
            FOR    ${item}    IN    @{items_dict.items()}
                ${key}=    Set Variable    ${item}[0]
                ${key}    Convert To String    ${key}
                ${values}=    Set Variable    ${item}[1]
                Input Text    ${closing_balance}    ${key}
            END
            Wait Until Keyword Succeeds    3    5    Click Button    ${close_session_button}
            Wait Until Page Does Not Contain Element    ${close_session_button}     timeout=10s
            Wait Until Element Is Visible    ${session_closed_popup}    timeout=10s
            Click Button    ${session_close_button}
            Wait Until Element Is Not Visible    ${session_closed_popup}    timeout=20s
            Wait Until Element Is Visible    ${open_session_link}   timeout=20s
      END
      ${closing_balance_specify_denomination_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${closing_balance_note_tab}
      IF    ${closing_balance_specify_denomination_visible}
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
           Wait Until Element Is Not Visible    ${closing_balance_note_tab}    timeout=10s
       END
   END

Logout From The POS For Adding The Item From Previous Session
    ${logout_link_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${logout_link}
    IF    ${logout_link_visible}
        Wait Until Keyword Succeeds    4    5    Click Element    ${logout_link}
        Sleep  0.5
        Click Element    ${logout_link}
        Wait Until Element Is Visible    ${logout_modal}    timeout=20s
        Click Button    ${logout_button}
        Wait Until Element Is Visible    ${pos_username}    timeout=20s
    END
   Delete All Cookies
   Execute JavaScript    window.localStorage.clear();
   Execute JavaScript    window.sessionStorage.clear();
   Reload Page

Logout From The POS
    ${logout_link_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${logout_link}
    IF    ${logout_link_visible}
        Wait Until Keyword Succeeds    3    5    Click Element    ${logout_link}
        Sleep  0.5
        Click Element    ${logout_link}
        Wait Until Element Is Visible    ${logout_modal}    timeout=20s
        Click Button    ${logout_button}
        Wait Until Element Is Visible    ${pos_username}    timeout=20s
    END
    
Add Previous Customer
    [Arguments]    ${customer_data}
    Wait Until Element Is Enabled    ${add_customer_link}
    Wait Until Keyword Succeeds    5     3      Click Element    ${add_customer_link}
    Wait Until Element Is Visible    ${customer_phone_field}
    Click Element    ${customer_phone_field}
    Sleep  1s
    Input Text    ${customer_phone_field}    ${customer_data.phone_number}
    Wait Until Element Is Enabled    ${continue_billing_button}  timeout=20s
    Wait Until Keyword Succeeds    3     3    Click Element    ${continue_billing_button}
    Wait Until Element Is Visible    ${customer_first_name_field}    timeout=20s
    Wait Until Element Is Enabled    ${start_billing_button}    timeout=20s
    Wait Until Keyword Succeeds    3     3    Click Button    ${start_billing_button}
    Wait Until Element Is Visible    ${add_items_from_previous_session}    timeout=20s

Verify Items Are Added From Previous Session
    [Arguments]    ${session_data}
    ${session_dict}    Create List    @{session_data}
    FOR    ${i}    IN RANGE    0     ${product_count}
        Page Should Contain    ${session_dict}[${i}]
    END

Discard Previous Added Item
    ${product_found_text}    Get Text    ${products_found}
    ${product_found_text}    Split String    ${product_found_text}
    ${product_count}=    Get From List    ${product_found_text}    0
    Set Test Variable    ${product_count}
    ${total_products}    Create List
    FOR    ${i}    IN RANGE    1    ${product_count}+1
        ${product_field}    Set Variable    (${products_from_previous_session})[${i}]
        ${products}=    Get Text    ${product_field}
        Append To List    ${total_products}    ${products}
    END
    Click Button    ${discard_button}
    [Return]    ${total_products}

Verify Items Are Deleted From Previous Session
    [Arguments]    ${session_data}
    ${session_dict}    Create List    @{session_data}
    FOR    ${i}    IN RANGE    0     ${product_count}
        Page Should Not Contain    ${session_dict}[${i}]
    END

Clear All Products
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Wait Until Keyword Succeeds    3     3    Click Element    ${clear_all_items}
      ${clear_button_status}    Run Keyword And Return Status    Page Should Contain Element    ${clear_all_items}
      IF    ${clear_button_status}
          Wait Until Keyword Succeeds    3     3    Click Element    ${clear_all_items}
      END
      Wait Until Page Does Not Contain Element       ${clear_all_items}    timeout=20s
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
    END

Verify Remove item to the cart | Order
    Wait Until Page Does Not Contain Element    ${product_name_in_cart_row}    timeout=5
    Page Should Not Contain Element    ${product_name_in_cart_row}

Add Normal SKU Product
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.buy_items}
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
      Wait Until Page Contains Element    ${cart_0}   timeout=20s
    END
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
        Sleep    1s
        ${multiple_product_present}=    Run Keyword And Return Status    Element Should Be Visible    ${select_mrp}
        IF    ${multiple_product_present}
            Wait Until Page Contains Element    ${select_mrp}   timeout=10s
            Click Element    ${add_to_cart_mrp}
            Wait Until Page Does Not Contain Element    ${select_mrp}
        END
    END

Go Back To POS Dashboard
   Wait Until Page Contains Element    ${back_icon_on_checkout}   timeout=10s
   Click Element    ${back_icon_on_checkout}