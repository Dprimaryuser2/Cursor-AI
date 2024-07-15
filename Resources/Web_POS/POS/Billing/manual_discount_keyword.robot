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

*** Keywords ***
Navigate To Update Product Window
    [Arguments]    ${product_data}
    ${product_dict}    Create Dictionary   &{product_data}
    ${items_list}=    Convert Items To List    ${product_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${product_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${product}=    Replace String    ${item_link}    barcode    ${key}
        Click Element    ${product}
        Wait Until Page Contains Element   ${update_product_button}
    END

Apply Item Manual Discount | Update Product Popup
    [Arguments]    ${product_price}
    ${product_price_dict}    Create Dictionary   &{product_price}
    ${subtotal_amount}=    Get Text    ${update_product_subtotal}
    ${subtotal_amount}    Remove Characters    ${subtotal_amount}
    ${cumulative_disc}=    Get Text    ${update_product_cumulative_discount}
    ${cumulative_disc}    Remove Characters    ${cumulative_disc}
    ${product_taxes}    Get Text    ${update_product_taxes}
    ${product_taxes}    Remove Characters    ${product_taxes}
    ${product_total}=    Get Text    ${update_product_total}
    ${product_total}    Remove Characters    ${product_total}
    Click Element    ${manual_discount_arrow}
    Wait Until Element Is Visible    ${manual_discount_heading}    timeout=10s
    Page Should Contain Element    ${select_from_list_tab}
    Page Should Contain Element    ${custom_discount_tab}
    ${price_without_discount}=    Create Dictionary    subtotal= ${subtotal_amount}    cumulative_discount = ${cumulative_disc}    product_taxes= ${product_taxes}    product_total= ${product_total}    discount= ${product_price_dict.discount_value}
    RETURN    ${price_without_discount}

Apply Item Manual Discount | Select From List
    [Arguments]    ${discount_data}
    ${discount_dict}    Create Dictionary   &{discount_data}
    Click Element    ${select_from_list_tab}
    ${discount_list}=    Convert Items To List    ${discount_dict.manual_discount}
    ${discount_dict} =    Convert Item List To Dictionary    ${discount_dict.manual_discount}
    FOR    ${item}    IN    @{discount_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        ${discount_list}=    Replace String    ${list_discount_radio}    disc    ${values}
        Click Element    ${discount_list}
        Click Button    ${apply_manual_discount_button}
    END

Apply Item Manual Discount | Custom Discount
    [Arguments]    ${discount_data}
    ${discount_dict}    Create Dictionary   &{discount_data}
    Click Element    ${custom_discount_tab}
    Wait Until Element Is Visible    ${discount_type_amount}    timeout=10s
    Wait Until Element Is Visible    ${discount_type_percentage}
    ${discount_list}=    Convert Items To List    ${discount_dict.manual_discount}
    ${discount_dict} =    Convert Item List To Dictionary    ${discount_dict.manual_discount}
    FOR    ${item}    IN    @{discount_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        IF    '${key}' == 'Custom_Discount_Amount'
            Click Element    ${discount_type_amount}
            Input Text    ${discount_value}    ${value}
            Click Button    ${apply_amount_discount_button}
        ELSE IF    '${key}' == 'Custom_Discount_Percentage'
            Click Element    ${discount_type_percentage}
            Input Text    ${discount_value}    ${value}
            Click Button    ${apply_percent_discount_button}
        END
    END
    Wait Until Element Is Visible    ${update_product_subtotal}

Apply Bill Manual Discount | Select From List
    [Arguments]    ${discount_data}
    ${discount_dict_data}    Create Dictionary   &{discount_data}
    ${grand_total_amt}=    Get Text    ${grand_total}
    ${grand_total_amt}    Remove Characters    ${grand_total_amt}
    ${grand_total_amt}    Convert To Number    ${grand_total_amt}
    Click Button    ${bill_discount}
    Wait Until Element Is Visible    ${select_from_list_tab}    timeout=10s
    Click Element    ${select_from_list_tab}
    ${discount_list}=    Convert Items To List    ${discount_dict_data.manual_discount}
    ${discount_dict} =    Convert Item List To Dictionary    ${discount_dict_data.manual_discount}
    FOR    ${item}    IN    @{discount_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        ${discount_list}=    Replace String    ${list_discount_radio}    disc    ${values}
        Click Element    ${discount_list}
    END
    Click Button    ${apply_manual_discount_button}
    ${bill_discount_data}    Create Dictionary     grand_total=${grand_total_amt}    discount_value=${discount_dict_data.discount_value}
    RETURN    ${bill_discount_data}         

Apply Bill Manual Discount | Custom Discount
    [Arguments]    ${discount_data}
    ${discount_dict_data}    Create Dictionary   &{discount_data}
    ${grand_total_amt}=    Get Text    ${grand_total}
    ${grand_total_amt}    Remove Characters    ${grand_total_amt}
    ${grand_total_amt}    Convert To Number    ${grand_total_amt}
    Click Button    ${bill_discount}
    Wait Until Element Is Visible    ${custom_discount_tab}    timeout=10s
    Click Element    ${custom_discount_tab}
    Wait Until Element Is Visible    ${discount_type_amount}    timeout=10s
    Wait Until Element Is Visible    ${discount_type_percentage}
    ${discount_list}=    Convert Items To List    ${discount_dict_data.manual_discount}
    ${discount_dict} =    Convert Item List To Dictionary    ${discount_dict_data.manual_discount}
    FOR    ${item}    IN    @{discount_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        IF    '${key}' == 'Custom_Discount_Amount'
            Click Element    ${discount_type_amount}
            Input Text    ${discount_value}    ${value}
            Click Button    ${apply_amount_discount_button}
        ELSE IF    '${key}' == 'Custom_Discount_Percentage'
            Click Element    ${discount_type_percentage}
            Input Text    ${discount_value}    ${value}
            Click Button    ${apply_percent_discount_button}
        END
    END
    ${bill_discount_data}    Create Dictionary     grand_total=${grand_total_amt}    discount_value=${discount_dict_data.discount_value}    discount=${value}
    RETURN    ${bill_discount_data}

Verify Item Manual Discount
    [Arguments]    ${product_price}
    Sleep    2s
    ${product_price_dict}    Create Dictionary   &{product_price}
    ${discount_list}=    Convert Items To List    ${product_price_dict.discount}
    ${discount_dict} =    Convert Item List To Dictionary    ${product_price_dict.discount}
    FOR    ${item}    IN    @{discount_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        IF    '${key}' == 'Percentage'
           ${expected_discount}    Evaluate    (${product_price_dict.product_total}*${values})/100
           ${expected_product_total}=    Evaluate    ${product_price_dict.product_total}-((${product_price_dict.product_total}*${values})/100)
        ELSE IF    '${key}' == 'Amount'
           ${values}=    Convert To Number    ${values}
           ${expected_discount}    Set Variable        ${values}
           ${expected_product_total}=    Evaluate    ${product_price_dict.product_total}- ${values}
        END
    END
    ${subtotal_amount}=    Get Text    ${update_product_subtotal}
    ${subtotal_amount}    Remove Characters    ${subtotal_amount}
    ${cumulative_disc}=    Get Text    ${update_product_cumulative_discount}
    ${cumulative_disc}   Remove Characters       ${cumulative_disc}
    ${cumulative_disc}    Convert To Number    ${cumulative_disc}
    ${product_taxes}    Get Text    ${update_product_taxes}
    ${product_taxes}    Remove Characters    ${product_taxes}
    ${product_total}=    Get Text    ${update_product_total}
    ${product_total}    Remove Characters    ${product_total}
    ${product_total}    Convert To Number    ${product_total}
    Should Be Equal As Strings    ${expected_product_total}    ${product_total}
    Should Be Equal As Strings    ${expected_discount}    ${cumulative_disc}
    Click Button    ${update_product_button}
    Wait Until Element Is Not Visible    ${update_product_button}    timeout=10s

Verify Item Manual Discount At Cart
    [Arguments]    ${product_price}
    ${product_price_dict}    Create Dictionary   &{product_price}
    ${discount_list}=    Convert Items To List    ${product_price_dict.discount}
    ${discount_dict} =    Convert Item List To Dictionary    ${product_price_dict.discount}
    FOR    ${item}    IN    @{discount_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        IF    '${key}' == 'Percentage'
           ${expected_discount}    Evaluate    (${product_price_dict.product_total}*${values})/100
        ELSE IF    '${key}' == 'Amount'
           ${values}=    Convert To Number    ${values}
           ${expected_discount}    Set Variable        ${values}
        END
    END
    ${manual_discount}=    Get Text    ${discount_field}
    ${manual_discount}    Remove Characters    ${manual_discount}
    ${manual_discount}    Convert To Number    ${manual_discount}
    Should Be Equal As Strings    ${manual_discount}    ${expected_discount}

Verify Bill Level Manual Discount
    [Arguments]    ${product_price}
    Sleep    1s
    ${product_price_dict}    Create Dictionary   &{product_price}
    ${discount_list}=    Convert Items To List    ${product_price_dict.discount_value}
    ${discount_dict} =    Convert Item List To Dictionary    ${product_price_dict.discount_value}
    FOR    ${item}    IN    @{discount_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        IF    '${key}' == 'Percentage'
           ${expected_discount}    Evaluate    (${product_price_dict.grand_total}*${values})/100
           ${expected_product_total}=    Evaluate    ${product_price_dict.grand_total}-((${product_price_dict.grand_total}*${values})/100)
        ELSE IF    '${key}' == 'Amount'
           ${values}=    Convert To Number    ${values}
           ${expected_discount}    Set Variable        ${values}
           ${expected_product_total}=    Evaluate    ${product_price_dict.grand_total}- ${values}
        END
    END
    Wait Until Element Is Visible    ${checkout_page_manual_discount}    timeout=10s
    ${grand_total_amt}=    Get Text    ${grand_total}
    ${grand_total_amt}    Remove Characters    ${grand_total_amt}
    ${grand_total_amt}    Convert To Number    ${grand_total_amt}
    Should Be Equal As Strings    ${grand_total_amt}    ${expected_product_total}
    ${discount}=    Get Text    ${checkout_page_manual_discount}
    ${discount}=    Remove Characters    ${discount}
    ${discount}    Convert To Number    ${discount}
    Should Be Equal As Strings    ${discount}    ${expected_discount}


Apply Item Manual Discount | Button
    Click Button    ${apply_manual_discount_button}

Verify Item Manual Discount | Button
    [Arguments]    ${product_price}
    ${product_price_dict}    Create Dictionary   &{product_price}
    ${discount}=    Get Text    ${discount_field}
    ${discount}    Remove Characters    ${discount}
    ${discount}    Convert To Number    ${discount}
    ${net_price_amount}=    Get Text    ${net_price}
    ${net_price_amount}    Remove Characters    ${net_price_amount}
    ${net_price_amount}    Convert To Number    ${net_price_amount}
    ${discount_list}=    Convert Items To List    ${product_price_dict.discount_value}
    ${discount_dict} =    Convert Item List To Dictionary    ${product_price_dict.discount_value}
    FOR    ${item}    IN    @{discount_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        IF    '${key}' == 'Percentage'
           ${expected_discount}    Evaluate    (${net_price_amount}*${values})/100
           ${expected_product_total}=    Evaluate    ${net_price_amount}-((${net_price_amount}*${values})/100)
        ELSE IF    '${key}' == 'Amount'
           ${values}=    Convert To Number    ${values}
           ${expected_discount}    Set Variable        ${values}
           ${expected_product_total}=    Evaluate    ${net_price_amount}- ${values}
        END
    END
    Should Be Equal As Strings    ${expected_discount}    ${discount}
    Should Be Equal As Strings    ${expected_product_total}    ${net_price_amount}

Verify Bill Level Discount Button Is Disabled
    Page Should Contain Element    ${bill_discount}
    Element Should Be Disabled    ${bill_discount}

Verify Bill Level Discount Button Is Enabled
    Page Should Contain Element    ${bill_discount}
    Element Should Be Enabled    ${bill_discount}

Verify Disable Bill Level Discount List
    Page Should Contain Element    ${bill_discount}
    Element Should Be Enabled    ${bill_discount}
    Click Button    ${bill_discount}
    Wait Until Element Is Visible    ${select_from_list_tab}
    Page Should Contain Element    ${disabled_select_from_list_tab}

Verify Enable Bill Level Discount List
    Page Should Contain Element    ${bill_discount}
    Element Should Be Enabled    ${bill_discount}
    Click Button    ${bill_discount}
    Wait Until Element Is Visible    ${select_from_list_tab}
    Page Should Not Contain Element    ${disabled_select_from_list_tab}
    Page Should Not Contain    ${select_from_list_tab}

Verify Enable Bill Level Custom Discount
    Page Should Contain Element    ${bill_discount}
    Element Should Be Enabled    ${bill_discount}
    Click Button    ${bill_discount}
    Wait Until Element Is Visible    ${custom_discount_tab}
    Page Should Not Contain Element    ${disabled_custom_discount_tab}
    Page Should Not Contain    ${custom_discount_tab}

Verify Disable Bill Level Custom Discount
    Page Should Contain Element    ${bill_discount}
    Element Should Be Enabled    ${bill_discount}
    Click Button    ${bill_discount}
    Wait Until Element Is Visible    ${custom_discount_tab}
    Page Should Contain Element    ${disabled_custom_discount_tab}

Verify Bill Level Custom Discount More Than Percentage Limit
    [Arguments]    ${product_price}
    ${product_price_dict}    Create Dictionary   &{product_price}
    Element Should Be Disabled     ${apply_percent_discount_button}
    ${grand_total_amt}=    Get Text    ${grand_total}
    ${grand_total_amt}    Remove Characters    ${grand_total_amt}
    ${grand_total_amt}    Convert To Number    ${grand_total_amt}
    Should Be Equal As Strings    ${grand_total_amt}    ${product_price_dict.grand_total}
    Page Should Not Contain Element    ${checkout_page_manual_discount}

Verify Bill Level Custom Discount More Than Capping Amount Limit
    [Arguments]    ${product_price}
    ${product_price_dict}    Create Dictionary   &{product_price}
    Element Should Be Disabled     ${apply_amount_discount_button}
    ${grand_total_amt}=    Get Text    ${grand_total}
    ${grand_total_amt}    Remove Characters    ${grand_total_amt}
    ${grand_total_amt}    Convert To Number    ${grand_total_amt}
    Should Be Equal As Strings    ${grand_total_amt}    ${product_price_dict.grand_total}
    Page Should Not Contain Element    ${checkout_page_manual_discount}

Verify Disabled Item Level Discount
    Click Element    ${manual_discount_arrow}
    Page Should Contain Element    ${disabled_item_level_discount_alert}

Verify Enabled Item Level Discount
    Click Element    ${manual_discount_arrow}
    Wait Until Element Is Visible    ${manual_discount_heading}    timeout=20s
    Page Should Contain Element    ${manual_discount_heading}
    Page Should Contain Element    ${select_from_list_tab}
    Page Should Contain Element    ${custom_discount_tab}

Verify Disable Item Level Discount List
    Wait Until Element Is Visible    ${select_from_list_tab}
    Page Should Contain Element    ${disabled_select_from_list_tab}

Verify Enable Item Level Discount List
    Wait Until Element Is Visible    ${select_from_list_tab}
    Page Should Not Contain Element    ${disabled_select_from_list_tab}

Verify Enable Custom Item Level Discount
    Wait Until Element Is Visible    ${custom_discount_tab}
    Page Should Not Contain Element    ${disabled_custom_discount_tab}

Verify Enable Item Level Custom Discount
    Wait Until Element Is Visible    ${custom_discount_tab}
    Page Should Not Contain Element    ${disabled_custom_discount_tab}
    Page Should Not Contain    ${custom_discount_tab}

Verify Disable Item Level Custom Discount
    Wait Until Element Is Visible    ${custom_discount_tab}
    Page Should Contain Element    ${disabled_custom_discount_tab}

Verify Item Level Custom Discount More Than Percentage Limit
    [Arguments]    ${product_price}
    ${product_price_dict}    Create Dictionary   &{product_price}
    Element Should Be Disabled    ${apply_percent_discount_button}
    Click Button    ${manual_close_button}
    ${subtotal_amount}=    Get Text    ${update_product_subtotal}
    ${subtotal_amount}    Remove Characters    ${subtotal_amount}
    ${cumulative_disc}=    Get Text    ${update_product_cumulative_discount}
    ${cumulative_disc}   Remove Characters       ${cumulative_disc}
    ${cumulative_disc}    Convert To Number    ${cumulative_disc}
    ${product_taxes}    Get Text    ${update_product_taxes}
    ${product_taxes}    Remove Characters    ${product_taxes}
    ${product_total}=    Get Text    ${update_product_total}
    ${product_total}    Remove Characters    ${product_total}
    ${product_total}    Convert To Number    ${product_total}
    ${expected_discount}    Set Variable    0
    ${expected_discount}    Convert To Number    ${expected_discount}
    ${expected_product_total}    Set Variable    ${product_price_dict.product_total}
    ${expected_product_total}    Convert To Number    ${expected_product_total}
    Should Be Equal As Strings    ${expected_product_total}    ${product_total}
    Should Be Equal As Strings    ${expected_discount}    ${cumulative_disc}

Verify Item Level Custom Discount More Than Capping Amount Limit
    [Arguments]    ${product_price}
    ${product_price_dict}    Create Dictionary   &{product_price}
    Element Should Be Disabled    ${apply_amount_discount_button}
    Click Button    ${manual_close_button}
    ${subtotal_amount}=    Get Text    ${update_product_subtotal}
    ${subtotal_amount}    Remove Characters    ${subtotal_amount}
    ${cumulative_disc}=    Get Text    ${update_product_cumulative_discount}
    ${cumulative_disc}   Remove Characters       ${cumulative_disc}
    ${cumulative_disc}    Convert To Number    ${cumulative_disc}
    ${product_taxes}    Get Text    ${update_product_taxes}
    ${product_taxes}    Remove Characters    ${product_taxes}
    ${product_total}=    Get Text    ${update_product_total}
    ${product_total}    Remove Characters    ${product_total}
    ${product_total}    Convert To Number    ${product_total}
    ${expected_discount}    Set Variable    0
    ${expected_discount}    Convert To Number    ${expected_discount}
    ${expected_product_total}    Set Variable    ${product_price_dict.product_total}
    ${expected_product_total}    Convert To Number    ${expected_product_total}
    Should Be Equal As Strings    ${expected_product_total}    ${product_total}
    Should Be Equal As Strings    ${expected_discount}    ${cumulative_disc}

Apply Bill Manual Discount More Than Bill Amount And Less Than Capping Amount | Custom Discount
    [Arguments]    ${discount_data}
    ${discount_dict_data}    Create Dictionary   &{discount_data}
    ${grand_total_amt}=    Get Text    ${grand_total}
    ${grand_total_amt}    Remove Characters    ${grand_total_amt}
    ${grand_total_amt}    Convert To Number    ${grand_total_amt}
    Click Button    ${bill_discount}
    Wait Until Element Is Visible    ${custom_discount_tab}    timeout=10s
    Click Element    ${custom_discount_tab}
    ${values}=    Evaluate    ${grand_total_amt}+1
    ${value}=    Convert To String    ${values}
    Click Element    ${discount_type_amount}
    Input Text    ${discount_value}    ${value}
    Click Button    ${apply_amount_discount_button}
    ${bill_discount_data}    Create Dictionary     grand_total=${grand_total_amt}    discount_value=${discount_dict_data.discount_value}    discount=${value}
    RETURN    ${bill_discount_data}

Verify Bill Level Discount Can Not Be Greater Than Payable Amount
    [Arguments]    ${product_price}
    ${product_price_dict}    Create Dictionary   &{product_price}
    Element Should Be Disabled     ${apply_amount_discount_button}
    ${grand_total_amt}=    Get Text    ${grand_total}
    ${grand_total_amt}    Remove Characters    ${grand_total_amt}
    ${grand_total_amt}    Convert To Number    ${grand_total_amt}
    Should Be Equal As Strings    ${grand_total_amt}    ${product_price_dict.grand_total}
    Page Should Not Contain Element    ${checkout_page_manual_discount}

Apply Bill Manual Discount Less Than Bill Amount And Less Than Capping Amount | Custom Discount
    [Arguments]    ${discount_data}
    ${discount_dict_data}    Create Dictionary   &{discount_data}
    ${grand_total_amt}=    Get Text    ${grand_total}
    ${grand_total_amt}    Remove Characters    ${grand_total_amt}
    ${grand_total_amt}    Convert To Number    ${grand_total_amt}
    Click Button    ${bill_discount}
    Wait Until Element Is Visible    ${custom_discount_tab}    timeout=10s
    Click Element    ${custom_discount_tab}
    ${values}=    Evaluate    ${grand_total_amt}-1
    ${value}=    Convert To String    ${values}
    Click Element    ${discount_type_amount}
    Input Text    ${discount_value}    ${value}
    Click Button    ${apply_amount_discount_button}
    ${bill_discount_data}    Create Dictionary     grand_total=${grand_total_amt}    discount_value=${discount_dict_data.discount_value}    discount=${value}
    RETURN    ${bill_discount_data}

Apply Item Manual Discount More Than Item Amount And Less Than Capping Amount | Custom Discount
    [Arguments]    ${discount_data}
    ${discount_dict}    Create Dictionary   &{discount_data}
    ${subtotal_amount}=    Get Text    ${update_product_subtotal}
    ${subtotal_amount}    Remove Characters    ${subtotal_amount}
    ${cumulative_disc}=    Get Text    ${update_product_cumulative_discount}
    ${cumulative_disc}    Remove Characters    ${cumulative_disc}
    ${product_taxes}    Get Text    ${update_product_taxes}
    ${product_taxes}    Remove Characters    ${product_taxes}
    ${product_total}=    Get Text    ${update_product_total}
    ${product_total}    Remove Characters    ${product_total}
    ${product_total_amount}    Convert To Number    ${product_total}
    Click Element    ${manual_discount_arrow}
    Wait Until Element Is Visible    ${custom_discount_tab}    timeout=10s
    Click Element    ${custom_discount_tab}
    Wait Until Element Is Visible    ${discount_type_amount}    timeout=10s
    Wait Until Element Is Visible    ${discount_type_percentage}
    ${values}=    Evaluate    ${product_total_amount}+1
    ${value}=    Convert To String    ${values}
    Click Element    ${discount_type_amount}
    Input Text    ${discount_value}    ${value}
    Click Button    ${apply_amount_discount_button}
    Wait Until Element Is Visible    ${update_product_subtotal}
    ${price_without_discount}=    Create Dictionary    subtotal= ${subtotal_amount}    cumulative_discount = ${cumulative_disc}    product_taxes= ${product_taxes}    product_total= ${product_total}    discount= ${value}
    RETURN    ${price_without_discount}

Verify Item Level Discount Can Not Be Greater Than Item Amount
    [Arguments]    ${product_price}
    ${product_price_dict}    Create Dictionary   &{product_price}
    Element Should Be Disabled    ${apply_amount_discount_button}
    Click Button    ${manual_close_button}
    ${cumulative_disc}=    Get Text    ${update_product_cumulative_discount}
    ${cumulative_disc}   Remove Characters       ${cumulative_disc}
    ${cumulative_disc}    Convert To Number    ${cumulative_disc}
    ${product_total}=    Get Text    ${update_product_total}
    ${product_total}    Remove Characters    ${product_total}
    ${product_total}    Convert To Number    ${product_total}
    ${expected_discount}    Set Variable    0
    ${expected_discount}    Convert To Number    ${expected_discount}
    ${expected_product_total}    Set Variable    ${product_price_dict.product_total}
    ${expected_product_total}    Convert To Number    ${expected_product_total}
    Should Be Equal As Strings    ${expected_product_total}    ${product_total}
    Should Be Equal As Strings    ${expected_discount}    ${cumulative_disc}

Verify Item Manual Discount Less Than Item Amount
    [Arguments]    ${product_price}
    Sleep    1s
    ${product_price_dict}    Create Dictionary   &{product_price}
    ${expected_product_total}=    Evaluate    ${product_price_dict.product_total}- ${product_price_dict.discount}
    ${subtotal_amount}=    Get Text    ${update_product_subtotal}
    ${subtotal_amount}    Remove Characters    ${subtotal_amount}
    ${cumulative_disc}=    Get Text    ${update_product_cumulative_discount}
    ${cumulative_disc}   Remove Characters       ${cumulative_disc}
    ${cumulative_disc}    Convert To Number    ${cumulative_disc}
    ${product_taxes}    Get Text    ${update_product_taxes}
    ${product_taxes}    Remove Characters    ${product_taxes}
    ${product_total}=    Get Text    ${update_product_total}
    ${product_total}    Remove Characters    ${product_total}    
    ${product_total}    Convert To Number    ${product_total}
    Should Be Equal As Strings    ${expected_product_total}    ${product_total}
    ${expected_discount}    Set Variable        ${product_price_dict.discount}
    ${expected_discount}    Convert To Number    ${expected_discount}
    Should Be Equal As Strings    ${expected_discount}    ${cumulative_disc}
    Click Button    ${update_product_button}
    Wait Until Element Is Not Visible    ${update_product_button}    timeout=10s
    ${manual_discount}=    Get Text    ${discount_field}
    ${manual_discount}    Remove Characters    ${manual_discount}
    ${manual_discount}    Convert To Number    ${manual_discount}
    Should Be Equal As Strings    ${manual_discount}    ${expected_discount}

Apply Item Manual Discount Less Than Item Amount And Less Than Capping Amount | Custom Discount
    [Arguments]    ${discount_data}
    ${discount_dict}    Create Dictionary   &{discount_data}
    ${subtotal_amount}=    Get Text    ${update_product_subtotal}
    ${subtotal_amount}    Remove Characters    ${subtotal_amount}
    ${cumulative_disc}=    Get Text    ${update_product_cumulative_discount}
    ${cumulative_disc}    Remove Characters    ${cumulative_disc}
    ${product_taxes}    Get Text    ${update_product_taxes}
    ${product_taxes}    Remove Characters    ${product_taxes}
    ${product_total}=    Get Text    ${update_product_total}
    ${product_total}    Remove Characters    ${product_total}
    ${product_total_amount}    Convert To Number    ${product_total}
    Click Element    ${manual_discount_arrow}
    Wait Until Element Is Visible    ${custom_discount_tab}    timeout=10s
    Click Element    ${custom_discount_tab}
    Wait Until Element Is Visible    ${discount_type_amount}    timeout=10s
    Wait Until Element Is Visible    ${discount_type_percentage}
    ${values}=    Evaluate    ${product_total_amount}-1
    ${value}=    Convert To String    ${values}
    Click Element    ${discount_type_amount}
    Input Text    ${discount_value}    ${value}
    Click Button    ${apply_amount_discount_button}
    Wait Until Element Is Visible    ${update_product_subtotal}
    ${price_without_discount}=    Create Dictionary    subtotal= ${subtotal_amount}    cumulative_discount = ${cumulative_disc}    product_taxes= ${product_taxes}    product_total= ${product_total}    discount= ${value}
    RETURN    ${price_without_discount}

Verify Bill Manual Discount Less Than Item Amount
    [Arguments]    ${product_price}
    Sleep    1s
    ${product_price_dict}    Create Dictionary   &{product_price}
    ${expected_discount}    Set Variable    ${product_price_dict.discount}
    ${expected_discount}=    Convert To Number    ${expected_discount}
    ${expected_product_total}=    Evaluate    ${product_price_dict.grand_total}- ${expected_discount}
    Wait Until Element Is Visible    ${checkout_page_manual_discount}    timeout=10s
    ${grand_total_amt}=    Get Text    ${grand_total}
    ${grand_total_amt}    Remove Characters    ${grand_total_amt}
    ${grand_total_amt}    Convert To Number    ${grand_total_amt}
    Should Be Equal As Strings    ${grand_total_amt}    ${expected_product_total}
    ${discount}=    Get Text    ${checkout_page_manual_discount}
    ${discount}=    Remove Characters    ${discount}
    ${discount}    Convert To Number    ${discount}
    Should Be Equal As Strings    ${discount}    ${expected_discount}
