*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Resource   ../../../../Resources/Web_POS/Login/login_keyword.robot
Variables   ../../../../PageObjects/Web_POS/POS/order_locators.py
Library    ../../../../Resources/CustomKeywords/utilities.py

*** Keywords ***

Click On Clear All Items Button
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
    END

Verify Clear All Items Clear the Items From Cart
    Wait Until Page Contains Element    ${cart_0}
    Page Should Contain Element    ${cart_0}
    Page Should Not Contain Element    ${checkout_button}

Add Weighted UOM Products to Cart | Edit Cart Quantity Mode | Order
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
        Sleep    2s
        ${multiple_product_present}=    Run Keyword And Return Status    Element Should Be Visible    ${select_mrp}
        IF    ${multiple_product_present}
            Wait Until Page Contains Element    ${select_mrp}   timeout=10s
            Click Element    ${add_to_cart_mrp}
            Wait Until Page Does Not Contain Element    ${select_mrp}
        END
        Sleep    1s
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

Add Weighted UOM Products to Cart | Add Cart Quantity Mode | Order
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
        Sleep    2s
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

Verify Item Is Added | Order
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

Verify 0 Inventory To Cart With Enable Negative Inventory | Order
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

Discard Previous Added Item | Order
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

Add Items From Previous Session | Order
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

Verify Items Are Added From Previous Session | Order
    [Arguments]    ${session_data}
    ${session_dict}    Create List    @{session_data}
    FOR    ${i}    IN RANGE    0     ${product_count}
        Page Should Contain    ${session_dict}[${i}]
    END

Verify 0 Inventory To Cart With Disable Negative Inventory | Order
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    Wait Until Page Contains Element    ${negative_inventory_alert_order}    timeout=10s
    Page Should Contain Element    ${negative_inventory_alert_order}
    Page Should Contain Element    ${cart_0}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        Page Should Not Contain Element    ${item_cart_table}
    END

Add Weighted UOM Products to Cart | Edit Cart Quantity Mode | Order | Disable Negative Inventory
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
        Sleep    2s
        ${multiple_product_present}=    Run Keyword And Return Status    Element Should Be Visible    ${select_mrp}
        IF    ${multiple_product_present}
            Wait Until Page Contains Element    ${select_mrp}   timeout=10s
            Click Element    ${add_to_cart_mrp}
            Wait Until Page Does Not Contain Element    ${select_mrp}
        END
        Sleep    1s
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