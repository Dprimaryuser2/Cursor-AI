*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../../Resources/CustomKeywords/utilities.py
Variables    ../../../../Environment/environment.py
Variables    ../../../../PageObjects/Web_POS/Login/login_locators.py
Variables    ../../../../PageObjects/Web_POS/POS/pos_locators.py
Variables    ../../../../PageObjects/Web_POS/POS/add_customer_locator.py
Variables    ../../../../PageObjects/Web_POS/POS/checkout_locators.py
Resource   ../../../../Resources/Web_POS/POS/Order/manual_discount_order_keyword.robot
Resource    add_to_cart_keyword.robot

*** Keywords ***
# Generic Keywords for All
Open The Session
    [Arguments]    ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
#    Wait Until Element Is Visible    ${pos_dashboard}
    Sleep    2s
    ${catalog_update_failed}=    Run Keyword And Return Status    Element Should Be Visible    ${catalog_update_failed_heading}
    IF    ${catalog_update_failed}
        Click Button    ${catalog_close_button}
    END
    ${catalog_update}=    Run Keyword And Return Status    Element Should Be Visible    ${done_progress}
    IF    ${catalog_update}
        Click Button    ${done_progress}
    END
    ${closing_balance_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${closing_balance}
    IF    ${closing_balance_visible}
        Input Text    ${closing_balance}    ${my_dict.closing_balance}
        Click Element    ${force_close_button}
        Wait Until Element Is Visible    ${opening_balance}    timeout=20s
    END
    ${opening_session_present}=    Run Keyword And Return Status    Element Should Be Visible    ${opening_balance}    timeout=10s
    IF    ${opening_session_present}
        Clear Element Text    ${opening_balance}
        Input Text    ${opening_balance}    ${my_dict.opening_balance}
        Click Element    ${open_session_submit_button}
        Wait Until Element Is Not Visible    ${opening_balance}    timeout=10s
    END


Scan Barcode To Add Item And Quantity To Cart
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.buy_items}
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Wait Until Keyword Succeeds    3    3    Click Element    ${clear_all_items}
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

Add Multiple MRP Products
    Wait Until Page Contains Element    ${select_mrp}   timeout=10s
    Click Element    ${add_to_cart_mrp}
    Wait Until Page Does Not Contain Element    ${select_mrp}


Scan Barcode To Add Item And Quantity To Cart | Multiple MRP
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

Add Items In Cart | Catalog
    [Arguments]    ${quantity_data}
    ${my_dict}    Create Dictionary   &{quantity_data}
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
    END
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
    
Change Quantity Of Item
    [Arguments]    ${quantity_data}
    ${my_dict}    Create Dictionary   &{quantity_data}
    ${quantity_in_piece}=    Run Keyword And Return Status    Element Should Contain    ${quantity_row}    Piece
    IF    ${quantity_in_piece}
#        Sleep    1s
        Wait Until Element Is Visible    ${quantity_in_piece}    timeout=20s
        Click Button    ${quantity_in_piece_button}
        Wait Until Element Is Visible    ${piece_modal}    timeout=10s
        Clear Element Text    ${quantity_input}
        Input Text    ${quantity_input}    ${my_dict.a1_quantity}
#        Sleep    1s
        Wait Until Element Is Enabled    ${update_cart_quantity}    timeout=20s
        Click Button    ${update_cart_quantity}
    ELSE
        Click Element    ${custom_select_quantity_button}
        Wait Until Element Is Visible    ${custom_select_options}    timeout=20s
        Click Element    ${custom_select_options}
    END

Verify Invoice Details After Payment
    Wait Until Element Is Visible    ${upi_payment}    timeout=10s
    Click Button    ${upi_payment}
    Wait Until Element Is Visible    ${transaction_reference_id}    timeout=20s
    ${reference_id}=    Generate Random Number
    Input Text    ${transaction_reference_id}    ${reference_id}
    Click Button    ${continue_payment_button}
    Wait Until Element Is Visible    ${payment_complete_heading}    timeout=20s
    ${customer_phone}=    Get Text    ${invoice_customer_phone}
    Should Be Equal As Strings    ${customer_phone}    ${mobile}
    Element Should Contain    ${invoice_customer_name}    ${first_name}
    Element Should Contain    ${invoice_customer_name}    ${last_name}

# Billing Test Specific keywords for Promos

Confirm Promotion Name
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    Sleep    2
    Click Element    ${available_promotions_link}
    Wait Until Element Is Visible    ${promo_body}    timeout=10s
    Element Should Contain    ${promo_body}    ${my_dict.promo_name}
    Click Button    ${save_and_close}
    Wait Until Element Is Not Visible    ${save_and_close}    timeout=10s
    
Verify Applicability Of Flat Discount | Percentage
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=    Remove Characters    ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    (${price_amount}*${my_dict.discount_percentage})/100
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
        # expected net amount
        ${net_price_with_rs}=    Get Text    ${net_price}
        ${net_price_amount}=    Remove Characters    ${net_price_with_rs}
        ${net_amount}=    Convert To Number    ${net_price_amount}
        ${expected_net_amount}=    Evaluate    (${price_amount}*${values})-${discount_amount}
        Should Be Equal As Integers    ${expected_net_amount}    ${net_amount}
    END

Verify Applicability Of Flat Discount | Rupees
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    (${my_dict.discount_rupees}*${values})
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
        # expected net amount
        ${net_price_with_rs}=    Get Text    ${net_price}
        ${net_price_amount}=    Remove Characters    ${net_price_with_rs}
        ${net_amount}=    Convert To Number    ${net_price_amount}
        ${expected_net_amount}=    Evaluate    (${price_amount}*${values})-${discount_amount}
        Should Be Equal As Integers    ${expected_net_amount}    ${net_amount}
    END

Verify Applicability Of Fixed Discount
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    IF    '${my_dict.discount_on}' == "Each"
        FOR    ${item}    IN    @{items_dict.items()}
            ${key}=    Set Variable    ${item}[0]
            ${values}=    Set Variable    ${item}[1]
            ${price_element}=    Replace String    ${price_column}    barcode    ${key}
            ${price_amount_with_rs}=    Get Text    ${price_element}
            ${price_amount}=    Remove Characters    ${price_amount_with_rs}
            ${price_amount}=    Convert To Number    ${price_amount}
            ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
            ${discount_amount_with_rs}=    Get Text    ${discount_element}
            ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
            ${discount_amount}=    Convert To Number    ${discount_amount}
            ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
            ${net_amount_with_rs}=    Get Text    ${net_price_element}
            ${net_amount_without_rs}=    Split String     ${net_amount_with_rs}
            ${net_amount_string}=    Get From List    ${net_amount_without_rs}    1
            ${net_amount}=    Convert To Number    ${net_amount_string}
            ${expected_net_amount}=    Evaluate    ${my_dict.fixed_price}*${values}
            Should Be Equal As Integers    ${net_amount}    ${expected_net_amount}
        END
        ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
        ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
        FOR    ${item}    IN    @{get_items_dict.items()}
            ${key}=    Set Variable    ${item}[0]
            ${values}=    Set Variable    ${item}[1]
            ${price_element}=    Replace String    ${price_column}    barcode    ${key}
            ${price_amount_with_rs}=    Get Text    ${price_element}
            ${price_amount}=    Remove Characters    ${price_amount_with_rs}
            ${price_amount}=    Convert To Number    ${price_amount}
            ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
            ${discount_amount_with_rs}=    Get Text    ${discount_element}
            ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
            ${discount_amount}=    Convert To Number    ${discount_amount}
            ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
            ${net_amount_with_rs}=    Get Text    ${net_price_element}
            ${net_amount_without_rs}=    Split String     ${net_amount_with_rs}
            ${net_amount_string}=    Get From List    ${net_amount_without_rs}    1
            ${net_amount}=    Convert To Number    ${net_amount_string}
            ${expected_net_amount}=    Evaluate    ${my_dict.fixed_price}*${values}
            Should Be Equal As Integers    ${net_amount}    ${expected_net_amount}
        END
    ELSE IF    '${my_dict.discount_on}' == "All"
        FOR    ${item}    IN    @{items_dict.items()}
            ${key}=    Set Variable    ${item}[0]
            ${values}=    Set Variable    ${item}[1]
            ${price_element}=    Replace String    ${price_column}    barcode    ${key}
            ${price_amount_with_rs}=    Get Text    ${price_element}
            ${price_amount}=    Remove Characters    ${price_amount_with_rs}
            ${price_amount}=    Convert To Number    ${price_amount}
            ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
            ${discount_amount_with_rs}=    Get Text    ${discount_element}
            ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
            ${discount_amount}=    Convert To Number    ${discount_amount}
            ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
            ${net_amount_with_rs}=    Get Text    ${net_price_element}
            ${net_amount_without_rs}=    Split String     ${net_amount_with_rs}
            ${net_amount_string}=    Get From List    ${net_amount_without_rs}    1
            ${net_amount}=    Convert To Number    ${net_amount_string}
            # expected discount amount
            ${expected_net_amount}=    Evaluate    (${values}/2)*${my_dict.fixed_price}
            Should Be Equal As Integers    ${net_amount}    ${expected_net_amount}
        END
        ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
        ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
        FOR    ${item}    IN    @{get_items_dict.items()}
            ${key}=    Set Variable    ${item}[0]
            ${values}=    Set Variable    ${item}[1]
            ${price_element}=    Replace String    ${price_column}    barcode    ${key}
            ${price_amount_with_rs}=    Get Text    ${price_element}
            ${price_amount}=    Remove Characters    ${price_amount_with_rs}
            ${price_amount}=    Convert To Number    ${price_amount}
            ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
            ${discount_amount_with_rs}=    Get Text    ${discount_element}
            ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
            ${discount_amount}=    Convert To Number    ${discount_amount}
            ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
            ${net_amount_with_rs}=    Get Text    ${net_price_element}
            ${net_amount_without_rs}=    Split String     ${net_amount_with_rs}
            ${net_amount_string}=    Get From List    ${net_amount_without_rs}    1
            ${net_amount}=    Convert To Number    ${net_amount_string}
            # expected discount amount
            ${expected_net_amount}=    Evaluate    (${values}/2)*${my_dict.fixed_price}
            Should Be Equal As Integers    ${net_amount}    ${expected_net_amount}
        END
    END
    
Verify Applicability Of Buy Pool | Get Free From Same Assortment
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${price_amount}-(${price_amount}/${values})
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END

Verify Applicability Of Get Any Quantity Free From Another Assortment | Buy Pool
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${price_amount}-(${price_amount}/${values})
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END

Verify Application Of Promo Data
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    Sleep    1s
    Click Element    ${available_promotions_link}
    Wait Until Element Is Visible    ${promo_body}    timeout=10s
    Element Should Contain    ${promo_body}    ${my_dict.promo_name}
    Click Button    ${save_and_close}
    Wait Until Element Is Not Visible    ${save_and_close}    timeout=10s
    IF    '${my_dict.discount_percentage}' != "NULL"
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount_without_rs}=    Split String     ${price_amount_with_rs}
        ${price_amount}=    Get From List    ${price_amount_without_rs}    1
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount_without_rs}=    Split String     ${discount_amount_with_rs}
        ${discount_amount}=    Get From List    ${discount_amount_without_rs}    1
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    (${price_amount}*${my_dict.discount_percentage})/100
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    ELSE IF    '${my_dict.discount_rupees}' != "NULL"
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount_without_rs}=    Split String     ${price_amount_with_rs}
        ${price_amount}=    Get From List    ${price_amount_without_rs}    1
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount_without_rs}=    Split String     ${discount_amount_with_rs}
        ${discount_amount}=    Get From List    ${discount_amount_without_rs}    1
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${price_amount}-${my_dict.discount_rupees}
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    ELSE IF    '${my_dict.fixed_price}' != "NULL"
        IF    '${my_dict.discount_on}' == "Each"
            ${expected_net_amount}=    Evaluate    ${my_dict.fixed_price}*${my_dict.a1_quantity}
            ${net_amount_with_rs}=    Get Text    ${net_price}
            ${net_amount_without_rs}=    Split String     ${net_amount_with_rs}
            ${net_amount_string}=    Get From List    ${net_amount_without_rs}    1
            ${net_amount}=    Convert To Number    ${net_amount_string}  
            Should Be Equal As Integers    ${net_amount}    ${expected_net_amount}
        ELSE IF    '${my_dict.discount_on}' == "All"    
            ${net_amount_with_rs}=    Get Text    ${net_price}
            ${net_amount_without_rs}=    Split String     ${net_amount_with_rs}
            ${net_amount_string}=    Get From List    ${net_amount_without_rs}    1
            ${net_amount}=    Convert To Number    ${net_amount_string}
            Should Be Equal As Integers    ${net_amount}    ${my_dict.fixed_price}
        END
    END
    
Apply Item Promo | Manual
    Wait Until Element Is Enabled    ${apply_promo}    timeout=10s
    Click Element    ${apply_promo}
    Wait Until Element Is Enabled    ${available_promotions_link}    timeout=10s
    
Verify Promo Discount In Cart | POS
    ${price_amount_with_rs}=    Get Text    ${price}
#    ${price_amount_without_rs}=    Split String     ${price_amount_with_rs}
    ${price_amount}=    Remove Characters    ${price_amount_with_rs}
    ${price_amount}=    Convert To Number    ${price_amount}  
    ${discount_amount_with_rs}=    Get Text    ${discount_field}
#    ${discount_amount_without_rs}=    Split String     ${discount_amount_with_rs}
    ${discount_amount}=    Remove Characters    ${discount_amount_with_rs}
    ${discount_amount}=    Convert To Number    ${discount_amount}
    ${net_amount_with_rs}=    Get Text    ${net_price}
    # tax present 
    ${excluded_tax}=    Set Variable    0
    ${tax_present}=    Run Keyword And Return Status    Element Should Be Visible    ${excluded_tax_text}
    IF    ${tax_present}
        ${tax_amount_with_rs}=    Get Text    ${tax_amount_excluded}
        ${excluded_tax}=    Remove Characters    ${tax_amount_with_rs}
        ${excluded_tax}=    Convert To Number    ${excluded_tax}
    END
#    ${net_amount_without_rs}=    Split String     ${net_amount_with_rs}
    ${net_amount_string}=    Remove Characters    ${net_amount_with_rs}
    ${net_amount}=    Convert To Number    ${net_amount_string}
    ${expected_net_amount}=    Evaluate    (${price_amount}+${excluded_tax}) - ${discount_amount}
    Should Be Equal As Integers    ${net_amount}    ${expected_net_amount}

Verify Promo Discount In Side Cart | POS
    # Sub total
    ${sub_total_with_rs}=    Get Text    ${sub_total}
    ${sub_total_amount}=    Remove Characters    ${sub_total_with_rs}
    ${sub_total_amount}=    Convert To Number    ${sub_total_amount}
    # promo discount
    ${promo_discount_with_rs}=    Get Text    ${promo_discount}
    ${promo_discount_amount}=    Remove Characters    ${promo_discount_with_rs}
    ${promo_discount_amount}=    Convert To Number    ${promo_discount_amount}
    # tax if present
    ${included_tax}=    Set Variable    0
    ${tax_present}=    Run Keyword And Return Status    Element Should Be Visible    ${included_tax_text}
    IF    ${tax_present}
        ${tax_amount_with_rs}=    Get Text    ${tax_amount}
        ${included_tax}=    Remove Characters    ${tax_amount_with_rs}
        ${included_tax}=    Convert To Number    ${included_tax}
    END
    ${excluded_tax}=    Set Variable    0
    ${tax_present}=    Run Keyword And Return Status    Element Should Be Visible    ${excluded_tax_text}
    IF    ${tax_present}
        ${tax_amount_with_rs}=    Get Text    ${tax_amount_excluded}
        ${excluded_tax}=    Remove Characters    ${tax_amount_with_rs}
        ${excluded_tax}=    Convert To Number    ${excluded_tax}
    END
    ${round_off}=    Set Variable    0
    ${round_off_present}=    Run Keyword And Return Status    Element Should Be Visible    ${round_off_text}
    IF    ${round_off_present}
        ${round_off_with_rs}=    Get Text    ${round_off_element}
        ${round_off}=    Remove Characters    ${round_off_with_rs}
    END
    # actual payable amount
    ${payable_amount_with_rs}=    Get Text    ${payable_amount}
    ${payable_amt}=    Remove Characters    ${payable_amount_with_rs}
    ${payable_amt}=    Convert To Number    ${payable_amt}
    # expected payable amount
    ${expected_payable_amount}=    Evaluate    (${included_tax}+${excluded_tax}+ ${sub_total_amount}+${round_off}) - ${promo_discount_amount}
    #verification
    Should Be Equal As Integers   ${expected_payable_amount}    ${payable_amt}

Verify Billing Checkout
    Sleep    0.5
    Wait Until Element Is Enabled    ${checkout_button}    timeout=20s
    ${discard}=    Run Keyword And Return Status    Element Should Be Enabled    ${discard_item_previous_session}
    IF    ${discard}
     Discard Previous Added Item
    END
    Click Button    ${checkout_button}
    ${popup_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${updating_catalog_heading}
    IF    ${popup_visible}
        Wait Until Element Is Visible    ${key_link}    timeout=10s
        Click Element    ${key_link}
        Wait Until Element Is Visible    ${close_button}
        Click Button    ${close_button}
        Wait Until Element Is Not Visible    ${updating_catalog_heading}    timeout=20s
        Sleep    2
        Wait Until Element Is Enabled    ${checkout_button}    timeout=20s
        Click Button    ${checkout_button}
    END
    ${insufficient}=    Run Keyword And Return Status    Element Should Be Enabled    ${insufficient_inventory_continue_btn}
    IF    ${insufficient}
     Set Fulfillment Date And Continue
    END
    Wait Until Element Is Visible    ${checkout_heading}    timeout=20s
    Page Should Contain Element    ${checkout_heading}
    Sleep    1s

Verify Promo Discount On Modal | Checkout Page
    [Arguments]    ${promo_data}
    ${my_dict}    Create Dictionary   &{promo_data}
    ${promo_name}=    Set Variable    ${my_dict.promo_name}
    Sleep    1s
    Wait Until Element Is Enabled    ${item_promo_link}    timeout=30s
    Click Element    ${item_promo_link}
    Wait Until Element Is Visible    ${item_promotions_title}    timeout=20s
    Element Should Contain    ${item_promo_body}    ${promo_name}
    ${modal_discount}=    Get Text    ${item_promotion_discount}
    ${modal_discount_without_characters}=    Remove Characters    ${modal_discount}
    ${modal_discount_amount}=    Convert To Number    ${modal_discount_without_characters}
    Wait Until Keyword Succeeds    4    1    Click Element    ${promo_close_button}
    ${promo_modal_visible}    Run Keyword And Return Status    Page Should Contain Element    ${item_promotions_title}
    IF    ${promo_modal_visible}
        Click Element    ${promo_close_button}
    END
    Wait Until Element Is Not Visible    ${item_promotions_title}    timeout=20s
    ${promo_total_discount}=    Get Text    ${checkout_promo_discount}
    ${promo_discount_amount}=    Remove Characters    ${promo_total_discount}
    ${promo_discount_amount}=    Convert To Number    ${promo_discount_amount}
#    Should Be Equal As Integers    ${modal_discount_amount}    ${promo_discount_amount}

Verify Total Payable Amount At Checkout
    ${sub_total}=    Get Text    ${checkout_sub_total}
    ${sub_total_amount}=    Remove Characters    ${sub_total}
    ${sub_total_amount}=    Convert To Number    ${sub_total_amount}
    # promo discount
    ${promo_discount}=    Get Text    ${checkout_promo_discount}
    ${promo_discount_amount}=    Remove Characters     ${promo_discount}
    ${promo_discount_amount}=    Convert To Number    ${promo_discount_amount}
    # tax if present
    ${tax}=    Set Variable    0
    ${tax_present}=    Run Keyword And Return Status    Element Should Be Visible    ${checkout_tax_text}
    IF    ${tax_present}
        ${tax_amount}=    Get Text    ${checkout_total_tax}
        ${tax}=    Remove Characters    ${tax_amount}
        ${tax}=    Convert To Number    ${tax}
    END
    ${round_off}=    Set Variable    0
    ${round_off_present}=    Run Keyword And Return Status    Element Should Be Visible    ${checkout_round_off_text}
    IF    ${round_off_present}
        ${round_off_text}=    Get Text    ${checkout_round_off}
        ${round_off_value}=    Remove Characters    ${round_off_text}
        ${round_off}=    Convert To Number    ${round_off_value}
    END
    # actual payable amount
    ${checkout_grand_total}=    Get Text    ${grand_total}
    ${grand_total_amount}=    Remove Characters    ${checkout_grand_total}
    ${grand_total_amount}=    Convert To Number    ${grand_total_amount}
    # expected payable amount
    ${expected_payable_amount}=    Evaluate    (${tax} + ${sub_total_amount}+${round_off}) - ${promo_discount_amount}
    #verification
    Should Be Equal As Integers   ${expected_payable_amount}    ${grand_total_amount}
    
Verify Applicability Percentage Discount On Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${item_length}=    Get Length    ${items_dict}
    FOR    ${row}    IN RANGE    1    ${item_length}+1
        ${row}=    Convert To String    ${row}
        ${product_name_element}=    Replace String    ${checkout_product_name}    row_count    ${row}  
        ${product_name}=    Get Text    ${product_name_element}
        ${qty_element}=    Replace String    ${checkout_quantity}    row_count    ${row}
        ${quantity}=    Get Text    ${qty_element}
        Set To Dictionary    ${product_dictionary}    ${product_name}    ${quantity}    
        ${unit_price_element}=    Replace String    ${unit_price}    row_count    ${row}
        ${unit_price_with_rs}=    Get Text    ${unit_price_element}
        ${unit_price_amount}=    Remove Characters    ${unit_price_with_rs}
        ${unit_amount}=    Convert To Number    ${unit_price_amount}

        ${checkout_discount_element}=    Replace String    ${checkout_discount}    row_count    ${row}
        ${checkout_discount_with_rs}=    Get Text    ${checkout_discount_element}
        ${checkout_discount_amt}=    Remove Characters    ${checkout_discount_with_rs}
        ${checkout_discount_amount}=    Convert To Number    ${checkout_discount_amt}

        ${checkout_tax_element}=    Replace String    ${checkout_tax}    row_count    ${row}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_per_item_total}    row_count    ${row}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price}    row_count    ${row}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        # assertion for qty*unit price = subtotal
        ${expected_subtotal}=    Evaluate    ${quantity}*${unit_amount}
        Should Be Equal As Integers    ${expected_subtotal}    ${checkout_per_item_total_amt}
        # assertion for (subtotal+tax) - discount = net price
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${checkout_discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount for percentage
        ${expected_discount_amount}=    Evaluate    (${checkout_per_item_total_amt}*${my_dict.discount_percentage})/100
        Should Be Equal As Integers    ${expected_discount_amount}    ${checkout_discount_amount}
    END
    Wait Until Element Is Visible    ${upi_payment}
#    Should Be Equal As Strings    ${items_dict}    ${product_dictionary}

Verify Applicability Flat Discount In Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${item_length}=    Get Length    ${items_dict}
    FOR    ${row}    IN RANGE    1    ${item_length}+1
        ${row}=    Convert To String    ${row}
        ${product_name_element}=    Replace String    ${checkout_product_name}    row_count    ${row}
        ${product_name}=    Get Text    ${product_name_element}
        ${qty_element}=    Replace String    ${checkout_quantity}    row_count    ${row}
        ${quantity}=    Get Text    ${qty_element}
        Set To Dictionary    ${product_dictionary}    ${product_name}    ${quantity}
        ${unit_price_element}=    Replace String    ${unit_price}    row_count    ${row}
        ${unit_price_with_rs}=    Get Text    ${unit_price_element}
        ${unit_price_amount}=    Remove Characters    ${unit_price_with_rs}
        ${unit_amount}=    Convert To Number    ${unit_price_amount}

        ${checkout_discount_element}=    Replace String    ${checkout_discount}    row_count    ${row}
        ${checkout_discount_with_rs}=    Get Text    ${checkout_discount_element}
        ${checkout_discount_amt}=    Remove Characters    ${checkout_discount_with_rs}
        ${checkout_discount_amount}=    Convert To Number    ${checkout_discount_amt}

        ${checkout_tax_element}=    Replace String    ${checkout_tax}    row_count    ${row}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_per_item_total}    row_count    ${row}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price}    row_count    ${row}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        # assertion for qty*unit price = subtotal
        ${expected_subtotal}=    Evaluate    ${quantity}*${unit_amount}
        Should Be Equal As Integers    ${expected_subtotal}    ${checkout_per_item_total_amt}
        # assertion for (subtotal+tax) - discount = net price
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${checkout_discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount for rupees
        ${expected_discount_amount}=    Evaluate    ${my_dict.discount_rupees}*int(${quantity})
        Should Be Equal As Integers    ${expected_discount_amount}    ${checkout_discount_amount}
    END

Verify Applicability Of Fixed Discount In Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        # assertion for (subtotal+tax) - discount = net price
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount for rupees
        IF    '${my_dict.discount_on}' == "Each"
            ${expected_net_amount}=    Evaluate    ${my_dict.fixed_price}*${quantity}
            Should Be Equal As Integers    ${checkout_net_amount}    ${expected_net_amount}
        ELSE IF    '${my_dict.discount_on}' == "All"
            Log    progress
            ${expected_net_amount}=    Evaluate    (${quantity}/2)*${my_dict.fixed_price}
            Should Be Equal As Integers    ${checkout_net_amount}    ${expected_net_amount}
        END
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}

        # assertion for (subtotal+tax) - discount = net price
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount for rupees
        IF    '${my_dict.discount_on}' == "Each"
            ${expected_net_amount}=    Evaluate    ${my_dict.fixed_price}*${quantity}
            Should Be Equal As Integers    ${checkout_net_amount}    ${expected_net_amount}
        ELSE IF    '${my_dict.discount_on}' == "All"
            Log    progress
            ${expected_net_amount}=    Evaluate    (${quantity}/2)*${my_dict.fixed_price}
            Should Be Equal As Integers    ${checkout_net_amount}    ${expected_net_amount}
        END
    END

Verify Applicability Of Buy Pool In Checkout Page | Get Free From Same Assortment
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${item_length}=    Get Length    ${items_dict}
    FOR    ${row}    IN RANGE    1    ${item_length}+1
        ${row}=    Convert To String    ${row}
        ${product_name_element}=    Replace String    ${checkout_product_name}    row_count    ${row}
        ${product_name}=    Get Text    ${product_name_element}
        ${qty_element}=    Replace String    ${checkout_quantity}    row_count    ${row}
        ${quantity}=    Get Text    ${qty_element}
        Set To Dictionary    ${product_dictionary}    ${product_name}    ${quantity}
        ${unit_price_element}=    Replace String    ${unit_price}    row_count    ${row}
        ${unit_price_with_rs}=    Get Text    ${unit_price_element}
        ${unit_price_amount}=    Remove Characters    ${unit_price_with_rs}
        ${unit_amount}=    Convert To Number    ${unit_price_amount}

        ${checkout_discount_element}=    Replace String    ${checkout_discount}    row_count    ${row}
        ${checkout_discount_with_rs}=    Get Text    ${checkout_discount_element}
        ${checkout_discount_amt}=    Remove Characters    ${checkout_discount_with_rs}
        ${checkout_discount_amount}=    Convert To Number    ${checkout_discount_amt}

        ${checkout_tax_element}=    Replace String    ${checkout_tax}    row_count    ${row}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_per_item_total}    row_count    ${row}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price}    row_count    ${row}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        # assertion for qty*unit price = subtotal
        ${expected_subtotal}=    Evaluate    ${quantity}*${unit_amount}
        Should Be Equal As Integers    ${expected_subtotal}    ${checkout_per_item_total_amt}
        # assertion for (subtotal+tax) - discount = net price
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${checkout_discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount for rupees
        ${expected_discount_amount}=    Evaluate    ${checkout_per_item_total_amt}-${unit_amount}
        Should Be Equal As Integers    ${expected_discount_amount}    ${checkout_discount_amount}
    END

Verify Applicability Of Buy from BUY pool and get any quantity from Get pool
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        Should Be Equal As Integers    ${price_amount}    ${discount_amount}
    END

Verify Applicability Of Buy from BUY pool and get any quantity from Get pool | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}
        
        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        
        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        
        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]    
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}
        
        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        
        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        
        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}

        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount
        Should Be Equal As Integers    ${price_amount}    ${discount_amount}
    END

Verify Applicability Of Buy 1 from BUY pool and get 1 from Get pool
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        Should Be Equal As Integers    ${price_amount}    ${discount_amount}
    END

Verify Applicability Of Buy item in ratio and Get Percentage off
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    (${price_amount}*${my_dict.discount_percentage})/100
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    
Verify Applicability Of Buy item in ratio and Get Percentage off | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    (${checkout_per_item_total_amt})-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    (${quantity}*${price_amount}*${my_dict.discount_percentage})/100
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    
Verify Applicability Of Buy specific quantity in ratio and Get Discount In Rupees
     [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${expected_discount_amount}=    Set Variable    0
    ${expected_discount_amount}=    Convert To Number    ${expected_discount_amount}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${discount_amount}+${expected_discount_amount}
    END
    Should Be Equal As Integers    ${expected_discount_amount}    ${my_dict.discount_rupees}

Verify Applicability Of Buy specific quantity in ratio and Get Discount In Rupees | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${expected_discount_amount}=    Set Variable    0
    ${expected_discount_amount}=    Convert To Number    ${expected_discount_amount}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    (${checkout_per_item_total_amt})-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${discount_amount}+${expected_discount_amount}
    END
    Should Be Equal As Integers    ${expected_discount_amount}    ${my_dict.discount_rupees}
    
Verify Applicability Of Buy 3 Get 50 % Off on One Item
    [Arguments]    ${price_data}
    ${price_dict}    Create Dictionary   &{price_data}
    ${expected_discount}=     Evaluate    (${unit_price_amount}*${price_dict.discount_percentage})/100
    ${actual_discount}=    Get Text    ${discount_field}
    ${actual_discount}=    Remove Characters    ${actual_discount}
    ${actual_discount}=     Convert To Number    ${actual_discount}
    Should Be Equal As Integers    ${expected_discount}    ${actual_discount}

Verify Applicability Of Buy 3 Get 50 % Off On One Item | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    (${checkout_per_item_total_amt})-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
    END
        ${expected_discount}=     Evaluate    (${price_amount}*${my_dict.discount_percentage})/100
        Should Be Equal As Integers    ${expected_discount}    ${discount_amount}

Verify Applicability Of Buy 3 Get 300 Rs Off On 1 Item
    [Arguments]    ${price_data}
    ${price_dict}    Create Dictionary   &{price_data}
    ${expected_discount}=     Set Variable    ${price_dict.discount_rupees}
    ${expected_discount}=    Convert To Number    ${expected_discount}
    ${actual_discount}=    Get Text    ${discount_field}
    ${actual_discount}=    Remove Characters    ${actual_discount}
    ${actual_discount}=     Convert To Number    ${actual_discount}
    Should Be Equal As Integers    ${expected_discount}    ${actual_discount}

Verify Applicability Of Buy 3 Get 300 Rs Off On 1 Item | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    (${checkout_per_item_total_amt})-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
    END
        ${expected_discount}=     Set Variable    ${my_dict.discount_rupees}
        ${expected_discount}=    Convert To Number    ${expected_discount}
        Should Be Equal As Integers    ${expected_discount}    ${discount_amount}

Verify Applicability Of Buy 5 Get 2 item for Rs 300 in each
    [Arguments]    ${price_data}
    ${price_dict}    Create Dictionary   &{price_data}
    ${expected_discount}=     Evaluate    (${unit_price_amount}-${price_dict.discount_rupees})*2
    ${actual_discount}=    Get Text    ${discount_field}
    ${actual_discount}=    Remove Characters    ${actual_discount}
    ${actual_discount}=     Convert To Number    ${actual_discount}
    Should Be Equal As Integers    ${expected_discount}    ${actual_discount}  

Verify Applicability Of Buy 5 Get 2 item for Rs 300 in each | Checkout Page  
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    (${checkout_per_item_total_amt})-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
    END
        ${expected_discount}=     Evaluate    (${price_amount}-${my_dict.discount_rupees})*2
        ${expected_discount}=    Convert To Number    ${expected_discount}
        Should Be Equal As Integers    ${expected_discount}    ${discount_amount}
        
Verify Applicability Of Buy 5 Get 2 Item For Rs 300 On All
    [Arguments]    ${price_data}
    ${price_dict}    Create Dictionary   &{price_data}
    ${price_amount}=    Get Text    ${price}
    ${price_amount}=    Remove Characters    ${price_amount}
    ${price_amount}=    Convert To Number    ${price_amount}
    ${net_price_amount}=    Get Text    ${net_price}
    ${net_price_amount}=    Remove Characters    ${net_price_amount}
    ${net_amount}=    Convert To Number    ${net_price_amount}
    ${expected_net_amount}=     Evaluate    (${price_amount}-(${unit_price_amount}*2))+${price_dict.discount_rupees}
    ${expected_discount}=    Evaluate    ${price_amount}-${expected_net_amount}
    ${actual_discount}=    Get Text    ${discount_field}
    ${actual_discount}=    Remove Characters    ${actual_discount}
    ${actual_discount}=     Convert To Number    ${actual_discount}
    Should Be Equal As Integers    ${expected_net_amount}    ${net_amount}
    Should Be Equal As Integers    ${expected_discount}    ${actual_discount}

Verify Applicability Of Buy 5 Get 2 Item For Rs 300 On All | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    (${checkout_per_item_total_amt})-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
    END
        ${expected_discount}=     Evaluate    ${checkout_per_item_total_amt}-${expected_net_price}
        ${expected_discount}=    Convert To Number    ${expected_discount}
        Should Be Equal As Integers    ${expected_discount}    ${discount_amount}

Verify Applicability Of Buy 1 Item Get Off On One Item
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        Should Be Equal As Integers    ${discount_amount}    ${my_dict.discount_rupees}
    END

Verify Applicability Of Buy 1 Item Get Off On One Item | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}

        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount
        Should Be Equal As Integers    ${my_dict.discount_rupees}    ${discount_amount}
    END

Verify Applicability Of Buy Pool 1 And Get Pool 2 At Rs. 300 Each
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        
        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}
        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount}=    Evaluate    ${price_amount}-${my_dict.discount_rupees}
        Should Be Equal As Integers    ${discount_amount}    ${expected_discount}
        # expected net price
        Should Be Equal As Integers    ${net_price_amount}    ${my_dict.discount_rupees}
    END

Verify Applicability Of Buy Pool 1 And Get Pool 2 At Rs. 300 Each | Checkout Page 
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}

        Should Be Equal As Integers    ${my_dict.discount_rupees}    ${checkout_net_amount}
        # expected discount amount
        ${expected_discount}=    Evaluate    ${checkout_per_item_total_amt}-${my_dict.discount_rupees}
        Should Be Equal As Integers    ${expected_discount}    ${discount_amount}
    END

Verify Applicability Of Buy Pool 1 And Get Pool 2 At Rs. 300 All
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    ${no_of_products}=    Get Length    ${get_items_dict}
    ${total_items_count}=    Set Variable    0
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${total_items_count}=    Evaluate    ${total_items_count}+int(${values})
    END
    ${total_payable_amount}=    Set Variable    0
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}
        
        ${total_payable_amount}=    Evaluate    ${total_payable_amount}+${net_price_amount}
        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected net price
        ${amount_per_item}=    Evaluate    ${my_dict.fixed_price}/${total_items_count}
        ${expected_net_price}=    Evaluate    ${amount_per_item}*${values}
        Should Be Equal As Integers    ${net_price_amount}    ${expected_net_price}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${price_amount}-${expected_net_price}
        Should Be Equal As Integers    ${discount_amount}    ${expected_discount_amount}
    END

Verify Applicability Of Buy Pool 1 And Get Pool 2 At Rs. 300 All | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${total_payable_amount}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}

        ${total_payable_amount}=    Evaluate    ${total_payable_amount}+${checkout_net_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}

        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${checkout_per_item_total_amt}-${checkout_net_amount}
        Should Be Equal As Integers    ${discount_amount}    ${expected_discount_amount}
    END
    
Verify Applicability Of Buy Item In 2:3 And Get At Rs. 300 All
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${total_payable_amount}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${total_payable_amount}=    Evaluate    ${total_payable_amount}+${net_price_amount}
        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${price_amount}-${net_price_amount}
        Should Be Equal As Integers    ${discount_amount}    ${expected_discount_amount}
    END
    # expected net price
    Should Be Equal As Integers    ${total_payable_amount}    ${my_dict.fixed_price}

Verify Applicability Of Buy Any Quantity Between Slab And Get Rs. Discount On All | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${total_payable_amount}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}

        ${total_payable_amount}=    Evaluate    ${total_payable_amount}+${checkout_net_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}

        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${checkout_per_item_total_amt}-${checkout_net_amount}
        Should Be Equal As Integers    ${discount_amount}    ${expected_discount_amount}

    END
    # expected net price
    Should Be Equal As Integers    ${total_payable_amount}    ${my_dict.fixed_price}
    
Verify Applicability Of Buy Item In 2:3 And Get At Rs. 300 Each
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${no_of_products}=    Get Length    ${items_dict}
    ${total_items_count}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${total_items_count}=    Evaluate    ${total_items_count}+int(${values})
    END
    ${total_discount_amount}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected net price
        ${expected_net_price}=    Evaluate    ${my_dict.fixed_price}*${values}
        Should Be Equal As Integers    ${net_price_amount}    ${expected_net_price}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${price_amount}-${expected_net_price}
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END

Verify Applicability Of Buy Item In 2:3 And Get At Rs. 300 Each | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${total_payable_amount}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}

        # expected net price
        ${expected_net_price}=    Evaluate    ${my_dict.fixed_price}*${values}
        Should Be Equal As Integers    ${checkout_net_amount}    ${expected_net_price}
        
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${checkout_per_item_total_amt}-${expected_net_price}
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END

Verify Applicability Of Buy Pool Get Any With % Off
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected net price
        ${expected_net_price}=    Evaluate    (${my_dict.discount_percentage}*${price_amount})/100
        Should Be Equal As Integers    ${expected_net_price}    ${net_price_amount}
        #expected discount
        ${expected_discount}=    Evaluate    (${my_dict.discount_percentage}*${price_amount})/100
        Should Be Equal As Integers    ${expected_discount}    ${discount_amount}
    END

Verify Applicability Of Buy Pool Get Any With % Off | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}

        # expected net price
        ${expected_net_price}=    Evaluate    (${my_dict.discount_percentage}*${checkout_per_item_total_amt})/100
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        #expected discount
        ${expected_discount}=    Evaluate    (${my_dict.discount_percentage}*${checkout_per_item_total_amt})/100
        Should Be Equal As Integers    ${expected_discount}    ${discount_amount}
    END

Verify Applicability Of Buy Any From Buy pool And Get Discount In Rupees
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    ${no_of_products}=    Get Length    ${items_dict}
    ${total_items_count}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${total_items_count}=    Evaluate    ${total_items_count}+int(${values})
    END
    ${total_discount_amount}=    Evaluate    ${my_dict.discount_rupees}/${total_items_count}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected net price
        ${expected_net_price}=    Evaluate    ${price_amount}-(${total_discount_amount}*${values})
        Should Be Equal As Integers    ${expected_net_price}    ${net_price_amount}
        #expected discount
        ${expected_discount}=    Evaluate    ${total_discount_amount}*${values}
        Should Be Equal As Integers    ${expected_discount}    ${discount_amount}
    END

Verify Applicability Of Buy Any From Buy pool And Get Discount In Rupees | Checkout Page
     [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    ${total_items_count}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${total_items_count}=    Evaluate    ${total_items_count}+int(${values})
    END
    ${total_discount_amount}=    Evaluate    ${my_dict.discount_rupees}/${total_items_count}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        # expected net price
        ${expected_net_price}=    Evaluate    ${price_amount}-(${total_discount_amount}*${values})
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        #expected discount
        ${expected_discount}=    Evaluate    ${total_discount_amount}*${values}
        Should Be Equal As Integers    ${expected_discount}    ${discount_amount}

    END

Verify Applicability Of Buy Any From Buy pool And Get Fixed Price Each
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    ${no_of_products}=    Get Length    ${items_dict}
    ${total_items_count}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${total_items_count}=    Evaluate    ${total_items_count}+int(${values})
    END
#    ${total_discount_amount}=    Evaluate    ${my_dict.fixed_price}/${total_items_count}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected net price
        ${expected_net_price}=    Evaluate    ${my_dict.fixed_price}*${values}
        Should Be Equal As Integers    ${expected_net_price}    ${net_price_amount}
        #expected discount
        ${expected_discount}=    Evaluate    ${price_amount}-${expected_net_price}
        Should Be Equal As Integers    ${expected_discount}    ${discount_amount}
    END

Verify Applicability Of Buy Any From Buy pool And Get Fixed Price Each | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    ${total_items_count}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${total_items_count}=    Evaluate    ${total_items_count}+int(${values})
    END
#    ${total_discount_amount}=    Evaluate    ${my_dict.fixed_price}/${total_items_count}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        # expected net price
        ${expected_net_price}=    Evaluate    ${my_dict.fixed_price}*${values}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        #expected discount
        ${expected_discount}=    Evaluate    ${checkout_per_item_total_amt}-${expected_net_price}
        Should Be Equal As Integers    ${expected_discount}    ${discount_amount}
    END

Verify Applicability Of Buy Any From Buy pool And Get Percent Off
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    ${no_of_products}=    Get Length    ${items_dict}
    ${total_items_count}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${total_items_count}=    Evaluate    ${total_items_count}+int(${values})
    END
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        #expected discount
        ${expected_discount_amount}=    Evaluate    (${price_amount}*${my_dict.discount_percentage})/100
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
        # expected net price
        ${expected_net_price}=    Evaluate    ${price_amount}-${expected_discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${net_price_amount}
    END

Verify Applicability Of Buy Any From Buy pool And Get Percent Off | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        #expected discount
        ${expected_discount_amount}=    Evaluate    (${price_amount}*${my_dict.discount_percentage})/100
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
        # expected net price
        ${expected_net_price}=    Evaluate    ${price_amount}-${expected_discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
    END

Verify Applicability Of Buy from different assortment and Get Rupees Discount
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${expected_discount_amount}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${expected_discount_amount}+${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    ${no_of_products}=    Get Length    ${items_dict}
    ${total_items_count}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${total_items_count}=    Evaluate    ${total_items_count}+int(${values})
    END
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        #expected discount
        ${expected_discount_amount}=    Evaluate    ${expected_discount_amount}+${discount_amount}
        # expected net price
        ${expected_net_price}=    Evaluate    ${price_amount}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${net_price_amount}
    END
    #expected discount
    Should Be Equal As Integers    ${expected_discount_amount}    ${my_dict.discount_rupees}

Verify Applicability Of Buy from different assortment and Get Rupees Discount | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${expected_discount_amount}=    Set Variable    0
#    FOR    ${item}    IN    @{items_dict.items()}
#        ${key}=    Set Variable    ${item}[0]
#        ${values}=    Set Variable    ${item}[1]
#        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
#        ${quantity}=    Get Text    ${qty_element}
#        ${quantity}=    Remove Characters    ${quantity}
#        ${quantity}=    Convert To Number    ${quantity}
#        Should Be Equal As Integers    ${values}    ${quantity}
#
#        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
#        ${price_amount_with_rs}=    Get Text    ${price_element}
#        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
#        ${price_amount}=    Convert To Number    ${price_amount}
#
#        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
#        ${discount_amount_with_rs}=    Get Text    ${discount_element}
#        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
#        ${discount_amount}=    Convert To Number    ${discount_amount}
#
#        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
#        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
#        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
#        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}
#
#        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
#        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
#        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
#        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}
#
#        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
#        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
#        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
#        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
#
#        ${expected_discount_amount}=    Evaluate    ${expected_discount_amount}+${discount_amount}
#        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
#        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
#
#        # expected discount amount
#        ${expected_checkout_discount_amount}=    Evaluate    ${checkout_per_item_total_amt}-${checkout_net_amount}
#        Should Be Equal As Integers    ${discount_amount}    ${expected_checkout_discount_amount}
#    END
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}

        ${expected_discount_amount}=    Evaluate    ${expected_discount_amount}+${discount_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}

        # expected discount amount
        ${expected_checkout_discount_amount}=    Evaluate    ${checkout_per_item_total_amt}-${checkout_net_amount}
        Should Be Equal As Integers    ${discount_amount}    ${expected_checkout_discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}

        ${expected_discount_amount}=    Evaluate    ${expected_discount_amount}+${discount_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}

        # expected discount amount
        ${expected_checkout_discount_amount}=    Evaluate    ${checkout_per_item_total_amt}-${checkout_net_amount}
        Should Be Equal As Integers    ${discount_amount}    ${expected_checkout_discount_amount}
    END
    # expected net price
    Should Be Equal As Integers    ${expected_discount_amount}    ${my_dict.discount_rupees}

Verify Applicability Of Buy From Different Assortment And Get All Item At Some Rupees
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${total_payable_amount}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${total_payable_amount}=    Evaluate    ${total_payable_amount}+${net_price_amount}
        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected net price
#        ${amount_per_item}=    Evaluate    ${my_dict.fixed_price}/${total_items_count}
#        ${expected_net_price}=    Evaluate    ${amount_per_item}*${values}
#        Should Be Equal As Integers    ${net_price_amount}    ${expected_net_price}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${price_amount}-${net_price_amount}
        Should Be Equal As Integers    ${discount_amount}    ${expected_discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    ${no_of_products}=    Get Length    ${get_items_dict}
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${total_payable_amount}=    Evaluate    ${total_payable_amount}+${net_price_amount}
        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected net price
#        ${amount_per_item}=    Evaluate    ${my_dict.fixed_price}/${total_items_count}
#        ${expected_net_price}=    Evaluate    ${amount_per_item}*${values}
#        Should Be Equal As Integers    ${net_price_amount}    ${expected_net_price}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${price_amount}-${net_price_amount}
        Should Be Equal As Integers    ${discount_amount}    ${expected_discount_amount}
    END
    Should Be Equal As Integers    ${total_payable_amount}    ${my_dict.fixed_price}

Verify Applicability Of Buy From Different Assortment And Get All Item At Some Rupees | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${total_payable_amount}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}

        ${total_payable_amount}=    Evaluate    ${total_payable_amount}+${checkout_net_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}

        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${checkout_per_item_total_amt}-${checkout_net_amount}
        Should Be Equal As Integers    ${discount_amount}    ${expected_discount_amount}
    END
    # expected net price
    Should Be Equal As Integers    ${total_payable_amount}    ${my_dict.fixed_price}

Verify Applicability Of Buy Pool Slab Flat Discount In Percentage
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${expected_discount_amount}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ((${price_amount}/${values})*${my_dict.discount_percentage})/100
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
        # expected net price
        ${expected_net_price}=    Evaluate    ${price_amount}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${net_price_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    ${no_of_products}=    Get Length    ${items_dict}
    ${total_items_count}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${total_items_count}=    Evaluate    ${total_items_count}+int(${values})
    END
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ((${price_amount}/${values})*${my_dict.discount_percentage})/100
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
        # expected net price
        ${expected_net_price}=    Evaluate    ${price_amount}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${net_price_amount}
    END

Verify Applicability Of Buy Pool Slab Flat Discount In Percentage | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${total_payable_amount}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}

        ${total_payable_amount}=    Evaluate    ${total_payable_amount}+${checkout_net_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}

        # assertion for qty*unit price = subtotal
        ${expected_subtotal}=    Evaluate    ${quantity}*${price_amount}
        Should Be Equal As Integers    ${expected_subtotal}    ${checkout_per_item_total_amt}
        # assertion for (subtotal+tax) - discount = net price
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount for rupees
        ${expected_discount_amount}=    Evaluate    (${price_amount}*${my_dict.discount_percentage})/100
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END

Verify Applicability Of Buy Pool Slab Fixed Discount In Rupees
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ((${price_amount}/${values})*${my_dict.discount_item_count})-${my_dict.fixed_price}
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
        # expected net price
        ${expected_net_price}=    Evaluate    ${price_amount}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${net_price_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    ${no_of_products}=    Get Length    ${items_dict}
    ${total_items_count}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${total_items_count}=    Evaluate    ${total_items_count}+int(${values})
    END
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ((${price_amount}/${values})*${my_dict.discount_item_count})-${my_dict.fixed_price}
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
        # expected net price
        ${expected_net_price}=    Evaluate    ${price_amount}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${net_price_amount}
    END

Verify Applicability Of Buy Pool Slab Fixed Discount | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${total_payable_amount}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}

        ${total_payable_amount}=    Evaluate    ${total_payable_amount}+${checkout_net_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}

        # assertion for qty*unit price = subtotal
        ${expected_subtotal}=    Evaluate    ${quantity}*${price_amount}
        Should Be Equal As Integers    ${expected_subtotal}    ${checkout_per_item_total_amt}
        # assertion for (subtotal+tax) - discount = net price
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount for rupees
        ${expected_discount_amount}=    Evaluate    (${price_amount}*${my_dict.discount_item_count})-${my_dict.fixed_price}
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END

Verify Applicability Of Buy Pool Slab and Get Rupees Discount | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    ${expected_discount_amount}=    Set Variable    0
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_discount_amount}=    Evaluate    ${expected_discount_amount}+${discount_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}

        # expected discount amount
        ${expected_checkout_discount_amount}=    Evaluate    ${checkout_per_item_total_amt}-${checkout_net_amount}
        Should Be Equal As Integers    ${discount_amount}    ${expected_checkout_discount_amount}
    END

# new
Verify Applicability of BUY pool and get any quantity of item at Rs 300 all in Get pool
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    ${no_of_products}=    Get Length    ${items_dict}
    ${total_items_count}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${total_items_count}=    Evaluate    ${total_items_count}+int(${values})
    END
    ${total_discount_amount}=    Evaluate    ${my_dict.fixed_price}/${total_items_count}
    ${total_payable_amount}=    Set Variable    0
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        ${total_payable_amount}=    Evaluate    ${total_payable_amount}+${net_price_amount}
        Log    ${total_payable_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${price_amount}-${net_price_amount}
        Should Be Equal As Integers    ${discount_amount}    ${expected_discount_amount}
    END
    # expected net price
    Should Be Equal As Integers    ${total_payable_amount}    ${my_dict.fixed_price}

Verify Applicability Of Buy Any Between Slab And Get Free
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${no_of_products}=    Get Length    ${items_dict}
    ${total_items_count}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${total_items_count}=    Evaluate    ${total_items_count}+int(${values})

    END
    ${total_discount_amount}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected net price
        ${expected_net_price}   Set Variable  0
        Should Be Equal As Integers    ${net_price_amount}    ${expected_net_price}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${price_amount}-${expected_net_price}
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END

Verify Applicability Of Buy Any Between Slab And Get Rs. OFF On SSP
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${expected_discount_amount}=    Set Variable    0
    ${expected_discount_amount}=    Convert To Number    ${expected_discount_amount}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${values_as_int}=    Convert To Integer    ${values}
#    Run Keyword If    ${values_as_int} >= 2 and ${values_as_int} <= 5    Run Keywords
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${discount_amount}+${expected_discount_amount}
    END

Verify Applicability Of Buy Between Slab And Get Percent Discount On SSP
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${values_as_int}=    Convert To Integer    ${values}
#    Run Keyword If    ${values_as_int} >= 2 and ${values_as_int} <= 5    Run Keywords
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    (${price_amount} -(${price_amount} * ${my_dict.discount_percentage})/100)
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END

Verify 100% Free Billing Checkout
     Wait Until Element Is Visible  ${checkout_button}  timeout=5s
     Element Should Be Disabled    ${checkout_button}

Verify Applicability Of Buy Between Slab And Get Percent Discount On SSP | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${item_length}=    Get Length    ${items_dict}
    FOR    ${row}    IN RANGE    1    ${item_length}+1
        ${row}=    Convert To String    ${row}
        ${product_name_element}=    Replace String    ${checkout_product_name}    row_count    ${row}
        ${product_name}=    Get Text    ${product_name_element}
        ${qty_element}=    Replace String    ${checkout_quantity}    row_count    ${row}
        ${quantity}=    Get Text    ${qty_element}
        Set To Dictionary    ${product_dictionary}    ${product_name}    ${quantity}
        ${unit_price_element}=    Replace String    ${unit_price}    row_count    ${row}
        ${unit_price_with_rs}=    Get Text    ${unit_price_element}
        ${unit_price_amount}=    Remove Characters    ${unit_price_with_rs}
        ${unit_amount}=    Convert To Number    ${unit_price_amount}

        ${checkout_discount_element}=    Replace String    ${checkout_discount}    row_count    ${row}
        ${checkout_discount_with_rs}=    Get Text    ${checkout_discount_element}
        ${checkout_discount_amt}=    Remove Characters    ${checkout_discount_with_rs}
        ${checkout_discount_amount}=    Convert To Number    ${checkout_discount_amt}

        ${checkout_tax_element}=    Replace String    ${checkout_tax}    row_count    ${row}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_per_item_total}    row_count    ${row}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price}    row_count    ${row}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        # assertion for qty*unit price = subtotal
        ${expected_subtotal}=    Evaluate    ${quantity}*${unit_amount}
        Should Be Equal As Integers    ${expected_subtotal}    ${checkout_per_item_total_amt}
        # assertion for (subtotal+tax) - discount = net price
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${checkout_discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount for rupees
        IF    '${my_dict.discount_on}' == "Each"
            ${expected_net_amount}=    Evaluate    ${my_dict.fixed_price}*${quantity}
            Should Be Equal As Integers    ${checkout_net_amount}    ${expected_net_amount}
        ELSE IF    '${my_dict.discount_on}' == "All"
            Log    progress

            ${expected_net_amount}=    Evaluate    ${checkout_per_item_total_amt}/2
            Should Be Equal As Integers    ${checkout_net_amount}    ${expected_net_amount}
        END
    END

Verify Applicability Of Buy Any Between Slab And Get Rs. Discount On Each | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${item_length}=    Get Length    ${items_dict}
    FOR    ${row}    IN RANGE    1    ${item_length}+1
        ${row}=    Convert To String    ${row}
        ${product_name_element}=    Replace String    ${checkout_product_name}    row_count    ${row}
        ${product_name}=    Get Text    ${product_name_element}
        ${qty_element}=    Replace String    ${checkout_quantity}    row_count    ${row}
        ${quantity}=    Get Text    ${qty_element}
        Set To Dictionary    ${product_dictionary}    ${product_name}    ${quantity}
        ${unit_price_element}=    Replace String    ${unit_price}    row_count    ${row}
        ${unit_price_with_rs}=    Get Text    ${unit_price_element}
        ${unit_price_amount}=    Remove Characters    ${unit_price_with_rs}
        ${unit_amount}=    Convert To Number    ${unit_price_amount}

        ${checkout_discount_element}=    Replace String    ${checkout_discount}    row_count    ${row}
        ${checkout_discount_with_rs}=    Get Text    ${checkout_discount_element}
        ${checkout_discount_amt}=    Remove Characters    ${checkout_discount_with_rs}
        ${checkout_discount_amount}=    Convert To Number    ${checkout_discount_amt}

        ${checkout_tax_element}=    Replace String    ${checkout_tax}    row_count    ${row}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_per_item_total}    row_count    ${row}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price}    row_count    ${row}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        # assertion for qty*unit price = subtotal
        ${expected_subtotal}=    Evaluate    ${quantity}*${unit_amount}
        Should Be Equal As Integers    ${expected_subtotal}    ${checkout_per_item_total_amt}
        # assertion for (subtotal+tax) - discount = net price
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${checkout_discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount for rupees
        IF    '${my_dict.discount_on}' == "Each"
            ${expected_net_amount}=    Evaluate    ${my_dict.fixed_price}*${quantity}
            Should Be Equal As Integers    ${checkout_net_amount}    ${expected_net_amount}
        ELSE IF    '${my_dict.discount_on}' == "All"
            ${expected_net_amount}=    Evaluate    ${checkout_per_item_total_amt}-${my_dict.fixed_price}
            Should Be Equal As Integers    ${checkout_net_amount}    ${expected_net_amount}
        END
    END

Verify Applicability Of Buy Any Quantity Between Slab And Get Rs. Discount On Each
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${values_as_int}=    Convert To Integer    ${values}
#    Run Keyword If    ${values_as_int} >= 2 and ${values_as_int} <= 5    Run Keywords
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${price_amount} - (${my_dict.fixed_price} * ${values})
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END

Verify Applicability Of Buy Any Quantity Between Slab And Get Rs. Discount On All
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${values_as_int}=    Convert To Integer    ${values}
#    Run Keyword If    ${values_as_int} >= 2 and ${values_as_int} <= 5    Run Keywords
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${price_amount}-${net_price_amount}
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END

Verify Applicability Of Buy Between Slab Get Discount In Rupees In Buy Pool
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_amount_with_rs}=    Get Text    ${price}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}
        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}
        ${discount_amount_with_rs}=    Get Text    ${discount_field}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${price_amount}-${net_price_amount}
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END

Verify Applicability Of Buy Between Slab Get Rs. Discount On Each In Buy Pool
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${no_of_products}=    Get Length    ${items_dict}
    ${total_items_count}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${total_items_count}=    Evaluate    ${total_items_count}+int(${values})
    END
    ${total_discount_amount}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected net price
        ${expected_net_price}=    Evaluate   ${price_amount}-((${price_amount}/${values})- ${my_dict.discount_rupees})
        Should Be Equal As Integers    ${net_price_amount}    ${expected_net_price}
        # expected discount amount
        ${expected_discount_amount}=    Evaluate    ${price_amount}-${expected_net_price}
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END

Verify Applicability Of Buy Between Slab Get Rs. Discount On Each In Buy Pool | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    (${checkout_per_item_total_amt})-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
    END
        ${expected_discount}=     Set Variable    ${my_dict.discount_rupees}
        ${expected_discount}=    Convert To Number    ${expected_discount}
        ${total_discount}=  Evaluate    ${price_amount}-${discount_amount}
        Should Be Equal As Integers    ${expected_discount}    ${total_discount}

# after 40
Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At Each
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    ${no_of_products}=    Get Length    ${items_dict}
    ${total_items_count}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${total_items_count}=    Evaluate    ${total_items_count}+int(${values})
    END
    ${expected_discounted_net_price}    Set Variable    0
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected net price
        ${expected_discounted_net_price}=    Evaluate    ${my_dict.fixed_price}*${values}
        # expected net price
        ${expected_net_price}=    Evaluate    ${price_amount}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${net_price_amount}
        Should Be Equal As Integers    ${expected_discounted_net_price}    ${net_price_amount}
    END
    
Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At Each | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    ${expected_discounted_net_price}=    Set Variable    0
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
         # expected net price
        ${expected_discounted_net_price}=    Evaluate    ${my_dict.fixed_price}*${values}
        # expected net price
        ${expected_net_price}=    Evaluate    ${price_amount}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        Should Be Equal As Integers    ${expected_discounted_net_price}    ${checkout_net_amount}
    END

Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At All
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}

    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    ${no_of_products}=    Get Length    ${items_dict}
    ${total_items_count}=    Set Variable    0
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${total_items_count}=    Evaluate    ${total_items_count}+int(${values})
    END
    ${expected_discounted_net_price}    Set Variable    0
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${price_element}=    Replace String    ${price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${net_price_element}=    Replace String    ${net_price_column}    barcode    ${key}
        ${net_price_amount_with_rs}=    Get Text    ${net_price_element}
        ${net_price_amount}=    Remove Characters    ${net_price_amount_with_rs}
        ${net_price_amount}=    Convert To Number    ${net_price_amount}

        ${discount_element}=    Replace String    ${discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}
        #expected discount
        ${expected_discounted_net_price}=    Evaluate    ${expected_discounted_net_price}+${net_price_amount}
        # expected net price
        ${expected_net_price}=    Evaluate    ${price_amount}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${net_price_amount}
    END
    #expected discount
    Should Be Equal As Integers    ${expected_discounted_net_price}    ${my_dict.fixed_price}

Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At All | Checkout Page
    [Arguments]    ${discount_data}
    ${my_dict}    Create Dictionary   &{discount_data}
    ${product_dictionary}=    Create Dictionary
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
        # expected discount amount
        ${expected_discount_amount}=    Set Variable    0
        Should Be Equal As Integers    ${expected_discount_amount}    ${discount_amount}
    END
    ${get_items_list}=    Convert Items To List    ${my_dict.get_items}
    ${get_items_dict} =    Convert Item List To Dictionary    ${my_dict.get_items}
    ${expected_discounted_net_price}=    Set Variable    0
    FOR    ${item}    IN    @{get_items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${qty_element}=    Replace String    ${checkout_qty_column}    barcode    ${key}
        ${quantity}=    Get Text    ${qty_element}
        ${quantity}=    Remove Characters    ${quantity}
        ${quantity}=    Convert To Number    ${quantity}
        Should Be Equal As Integers    ${values}    ${quantity}

        ${price_element}=    Replace String    ${checkout_unit_price_column}    barcode    ${key}
        ${price_amount_with_rs}=    Get Text    ${price_element}
        ${price_amount}=    Remove Characters    ${price_amount_with_rs}
        ${price_amount}=    Convert To Number    ${price_amount}

        ${discount_element}=    Replace String    ${checkout_discount_column}    barcode    ${key}
        ${discount_amount_with_rs}=    Get Text    ${discount_element}
        ${discount_amount}=     Remove Characters     ${discount_amount_with_rs}
        ${discount_amount}=    Convert To Number    ${discount_amount}

        ${checkout_tax_element}=    Replace String    ${checkout_discount_tax}    barcode    ${key}
        ${checkout_tax_with_rs}=    Get Text    ${checkout_tax_element}
        ${checkout_tax_amount}=    Remove Characters    ${checkout_tax_with_rs}
        ${checkout_taxes_amount}=    Convert To Number    ${checkout_tax_amount}

        ${checkout_per_item_total_element}=    Replace String    ${checkout_sub_total_column}    barcode    ${key}
        ${checkout_per_item_total_with_rs}=    Get Text    ${checkout_per_item_total_element}
        ${checkout_per_item_total_amount}=    Remove Characters    ${checkout_per_item_total_with_rs}
        ${checkout_per_item_total_amt}=    Convert To Number    ${checkout_per_item_total_amount}

        ${checkout_net_price_element}=    Replace String    ${checkout_net_price_column}    barcode    ${key}
        ${checkout_net_price_with_rs}=    Get Text    ${checkout_net_price_element}
        ${checkout_net_price_amount}=    Remove Characters    ${checkout_net_price_with_rs}
        ${checkout_net_amount}=    Convert To Number    ${checkout_net_price_amount}
        #expected discount
        ${expected_discounted_net_price}=    Evaluate    ${expected_discounted_net_price}+${checkout_net_amount}
        # expected net price
        ${expected_net_price}=    Evaluate    ${checkout_per_item_total_amt}-${discount_amount}
        Should Be Equal As Integers    ${expected_net_price}    ${checkout_net_amount}
    END
    #expected discount
    Should Be Equal As Integers    ${expected_discounted_net_price}    ${my_dict.fixed_price}

# Order Module Generic Keywords
# Switch between in store and delivery and switch between order, exchange, billing and return
Select Billing Option
    [Arguments]    ${option_data}
    ${option_td}=    Create Dictionary    &{option_data}
    IF    '${option_td.billing_option}' == 'InStore'
        Click Element    ${in_store}
    ELSE IF    '${option_td.billing_option}' == 'Delivery'
        Click Element    ${delivery}
    ELSE
        Log    "By Default In-store is selected"
    END

Select Cart Mode
    [Arguments]    ${cart_data}
    ${cart_td}=    Create Dictionary    &{cart_data}
    Click Element    ${switch_billing_dropdown}
    IF    '${cart_td.Cart_mode}' == 'Billing'
        Click Element    ${billing_option}
    ELSE IF    '${cart_td.Cart_mode}' == 'Return'
        Click Element    ${return_option}
    ELSE IF    '${cart_td.Cart_mode}' == 'Exchange'
        Click Element    ${exchange_option}
    ELSE IF    '${cart_td.Cart_mode}' == 'Order'
        Click Element    ${order_option}
    END
    Click Button    ${switch_confirm_button}
