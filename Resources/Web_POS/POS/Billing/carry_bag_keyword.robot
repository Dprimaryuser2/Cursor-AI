*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../../Resources/CustomKeywords/utilities.py
Variables    ../../../../PageObjects/Web_POS/POS/hold_bill_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/checkout_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/pos_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/add_customer_locator.py
Resource    ../../../AdminConsole/Login/login_keyword.robot
Variables   ../../../../PageObjects/AdminConsole/ProductCategories/product_categories.py

*** Keywords ***
Navigate To Carry Bags | Console
   Wait Until Page Contains Element   ${product_categories_c}  timeout=10s
   Click Element    ${product_categories_c}
   Wait Until Page Contains Element    ${carry_bags_sidebar_option_c}
   Click Element    ${carry_bags_sidebar_option_c }

Verify Carry Bags Are Allocated To Store
   [Arguments]    ${carrybag_data}
   Wait Until Page Contains Element    ${search_store_carry_bag}
   Input Text    ${search_store_carry_bag}    ${carrybag_data}
   Wait Until Page Contains Element    ${barcode_carry_bag}
   Sleep    5s
   ${barcode_list}  Get WebElements    ${barcode_carry_bag}
   ${barcode_name_list}  Create List
   FOR    ${barcode}    IN    @{barcode_list}
       Log    ${barcode}
       ${temp}  Get Text    ${barcode}
       Append To List    ${barcode_name_list}     ${temp}
       Log    ${barcode_name_list}
   END
   RETURN  ${barcode_name_list}

Add Carry Bag By Scanning Barcode
    [Arguments]    ${products}
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
    Click Element    ${scan_only}
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
    END
    FOR    ${element}    IN    @{products}
       Input Text    ${product_search_bar}    ${element}
       Press Keys    ${product_search_bar}    ENTER
       Wait Until Page Contains Element    ${checkout_button}  timeout=40s
    END

Add Carry Bag With Decimal/Negative Integer Value
    [Arguments]    ${carry_bag_data}
    ${carry_bag_td}=    Create Dictionary    &{carry_bag_data}
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
    END
    Click Element    ${add_carry_bag_button}
    Sleep  3s
    ${carry_bag}=   Run Keyword And Return Status    Element Should Be Visible    ${carry_bag_all_input_fields}
    ${items_list}=    Convert Items To List    ${carry_bag_td.carry_bag}
    ${items_dict} =    Convert Item List To Dictionary    ${items_list}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${carry_bag_option}=   Replace String   ${carry_bag_input_field}    Carry bag   ${key}
        Wait Until Page Contains Element    ${carry_bag_option}
        Input Text    ${carry_bag_option}    ${values}
    END
    ${carry_bag_amount}=   Replace String   ${carry_bag_amount_field}    Carry bag   ${key}
    ${amount}  Get Text    ${carry_bag_amount}
    ${amount_c}  Remove Characters    ${amount}
    Set Test Variable   ${amount_c}
    RETURN  ${values}

Verify Carry Bag Window Ignores Decimal/Negative Sign
    [Arguments]    ${values}
    ${int_value}   Evaluate    isinstance(int(${values}), int)
    Should Be True    ${int_value}
    Element Should Be Enabled    ${carry_bag_add}

Verify Add Carry Button Is Disabled If Qty Is Not Entered
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
    END
    Click Element    ${add_carry_bag_button}
    Sleep  3s
    Element Should Be Disabled    ${carry_bag_add}

Add Carry Bag With Negative Inventory By Scanning Barcode
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

Verify 0 Inventory To Cart With Disable Negative Inventory | Carry Bag
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${expected_cart_quantity}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
    END
    Page Should Contain Element    ${negative_inventory_alert}
    Page Should Contain Element    ${cart_0}

Verify 0 Inventory To Cart With Enable Negative Inventory | Carry Bag
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
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

Verify The Details Of Carry Bag Added in Cart
    [Arguments]    ${values}
    Wait Until Page Contains Element    ${carry_bag_add}
    Click Element    ${carry_bag_add}
    Wait Until Page Contains Element    ${cart_last_element}  timeout=5s
    ${cart_count}  Get Text   ${cart_last_element}
    Convert To Integer    ${cart_count}
    ${i}=  Set Variable    1
    ${product_count_for_test}    Set Variable    0
    FOR  ${i}  IN RANGE    1    ${cart_count}+1
           ${is_a_button}    Run Keyword And Return Status    Element Should Be Visible    ${quantity_column_buttons}
           IF    ${is_a_button}
               ${product_count_for_test}=    Evaluate    ${product_count_for_test}+1
               ${carry_bag_amount}=  Evaluate    ${values} * ${amount_c}
               Log    ${product_count_for_test}
           ELSE
               Wait Until Page Contains Element    (${product_name_in_cart_row})[${i}]
               Click Element    (${product_name_in_cart_row})[${i}]
               Wait Until Page Contains Element    ${quantity_product_window}
               ${count}    Get Text    ${quantity_product_window}
               Convert To Integer    ${count}
               ${product_count_for_test}    Evaluate    ${count}+${product_count_for_test}
               Wait Until Page Contains Element    ${close_product_window_button}
               Click Element    ${close_product_window_button}
           END
    END
    ${temp}    Get Text    ${item_quantity_in_cart}
    ${temp}    Remove Characters    ${temp}
    Convert To Integer    ${temp}
    Should Be Equal As Integers     ${temp}    ${product_count_for_test}
    ${unit_price_amount}=    Get Text    ${price}
    ${unit_price_amount}=    Remove Characters    ${unit_price_amount}
    ${unit_price_amount}=    Convert To Number    ${unit_price_amount}
    Should Be Equal    ${carry_bag_amount}    ${unit_price_amount}


