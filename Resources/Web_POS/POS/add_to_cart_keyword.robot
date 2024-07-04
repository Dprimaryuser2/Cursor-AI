*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../Resources/CustomKeywords/utilities.py
Variables   ../../../PageObjects/Web_POS/POS/pos_locators.py
Variables   ../../../PageObjects/Web_POS/POS/add_customer_locator.py
Variables    ../../../PageObjects/Web_POS/Login/login_locators.py
Resource    ../../../Resources/Web_POS/POS/promo_keyword.robot

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
        Sleep    0.5s
        Click Element    ${search_add_button}
        Sleep    1s
        ${multiple_product_present}=    Run Keyword And Return Status    Element Should Be Visible    ${select_mrp}
        IF    ${multiple_product_present}
            Wait Until Page Contains Element    ${select_mrp}   timeout=10s
            Click Element    ${add_to_cart_mrp}
            Wait Until Page Does Not Contain Element    ${select_mrp}
        END
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
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
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
        Sleep    1s
        ${multiple_product_present}=    Run Keyword And Return Status    Element Should Be Visible    ${select_mrp}
        IF    ${multiple_product_present}
            Wait Until Page Contains Element    ${select_mrp}   timeout=10s
            Click Element    ${add_to_cart_mrp}
            Wait Until Page Does Not Contain Element    ${select_mrp}
        END
        ${add_toggle_enabled}    Run Keyword And Return Status    Element Should Be Visible    ${add_toggle_button}
        IF    ${add_toggle_enabled}
            Input Text    ${quantity_input}    ${value}
        ELSE
            Click Element    ${add_toggle_button}
            Input Text    ${quantity_input}    ${value}
        END
        Click Element    ${update_cart_quantity}
        Sleep    1s
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
        ${quantity_in_piece}=    Run Keyword And Return Status    Element Should Contain    ${quantity_row}    Piece
        IF    ${quantity_in_piece}
            ${expected_product_quantity}=    Get Text    ${piece_quantity_value}
            ${expected_product_quantity}    Split String    ${expected_product_quantity}
            ${expected_product_quantity}    Get From List    ${expected_product_quantity}    0
            ${expected_product_quantity}    Remove Characters    ${expected_product_quantity}
            ${expected_product_quantity}    Convert To Number    ${expected_product_quantity}
            ${values}    Convert To Number    ${values}
            Should Be Equal As Integers    ${values}    ${expected_product_quantity}
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

Verify 0 Inventory To Cart With Disable Negative Inventory
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${expected_cart_quantity}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        Element Should Not Contain    ${table}    ${key}
    END
    Page Should Contain Element    ${negative_inventory_alert}
    Page Should Contain Element    ${cart_0}

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
        ${quantity_in_piece}=    Run Keyword And Return Status    Element Should Contain    ${quantity_row}    Piece
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
    Click Button    ${close_session_button}
    Wait Until Element Is Visible    ${session_closed_popup}    timeout=10s
    Click Button    ${session_close_button}
    Wait Until Element Is Not Visible    ${session_closed_popup}    timeout=10s

Logout From The POS
    Wait Until Keyword Succeeds    5    1    Click Element    ${logout_link}
    Wait Until Element Is Visible    ${logout_modal}    timeout=20s
    Click Button    ${logout_button}
    Wait Until Element Is Visible    ${pos_username}    timeout=20s

Add Previous Customer
    [Arguments]    ${customer_data}
    ${my_dict}    Create Dictionary   &{customer_data}
    Wait Until Element Is Enabled    ${add_customer_link}
    Wait Until Keyword Succeeds    5     1      Click Element    ${add_customer_link}
    Wait Until Element Is Visible    ${customer_phone_field}
    Input Text    ${customer_phone_field}    ${my_dict.mobile_no}
    Click Button    ${continue_billing_button}
    Wait Until Element Is Visible    ${customer_first_name_field}    timeout=20s
    Wait Until Element Is Enabled    ${start_billing_button}    timeout=20s
    Click Button    ${start_billing_button}
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
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
    END