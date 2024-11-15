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
Variables   ../../../../PageObjects/Web_POS/POS/checkout_locators.py

*** Keywords ***
Set Fulfillment Date And Continue
    ${insufficient}    Run Keyword And Return Status    Page Should Contain Element    ${insufficient_inventory_continue_btn}
    IF    ${insufficient}
       Click Element    ${insufficient_inventory_continue_btn}
    END
    Sleep    3
    ${fulfilment_visible}    Run Keyword And Return Status    Element Should Be Visible    ${fulfilment_options_heading}    timeout=10s
    IF    ${fulfilment_visible}
        Wait Until Page Contains Element    ${fulfilment_options_heading}    timeout=10
        Wait Until Page Contains Element    ${fulfilment_due_date_option}    timeout=10
        Click Element    ${fulfilment_due_date_option}
        Wait Until Page Contains Element    ${fulfilment_calendar_window}    timeout=5
        Wait Until Page Contains Element    ${last_date_of_this_month}    timeout=5
        Click Element    ${last_date_of_this_month}
        Sleep    2
        Wait Until Element Is Enabled    ${continue_fulfilment_button}    timeout=5
        Click Element    ${continue_fulfilment_button}
    END
    Wait Until Page Does Not Contain Element    ${fulfilment_options_heading}    timeout=5

Verify Delivery Fulfillment Popup
    Reload Page
    Wait Until Page Contains Element   ${min_acceptance_criteria_fulfilled}    timeout=5

Verify Item Manual Discount | Order
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

Verify Item Manual Discount At Cart | Order
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

Verify Bill Level Manual Discount | Order
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

Verify Item Manual Discount | Button | Order
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

Apply Item Manual Discount | Select From List | Order
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

Apply Item Manual Discount | Custom Discount | Order
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

Apply Bill Manual Discount | Select From List | Order
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

Apply Bill Manual Discount | Custom Discount | Order
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

Verify Order Checkout
    ${discard}=    Run Keyword And Return Status    Element Should Be Visible       ${discard_button}
    IF    ${discard}
         Click Button    ${discard_button}
         sleep  1s
    END
    Wait Until Element Is Enabled    ${checkout_button}    timeout=20s
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
        sleep   1
        Click Button    ${checkout_button}
    END
    ${insufficient}=    Run Keyword And Return Status    Element Should Be Visible    ${insufficient_inventory_continue_btn}    timeout=10s
    IF    ${insufficient}
     Set Fulfillment Date And Continue
    END
    Sleep  2s
    ${fulfilment}=  Run Keyword And Return Status  Element Should Be Visible   ${fulfilment_options_heading}
    IF    ${fulfilment}
         Wait Until Page Contains Element    ${fulfilment_options_heading}    timeout=5
         Wait Until Page Contains Element    ${fulfilment_due_date_option}    timeout=5
         Click Element    ${fulfilment_due_date_option}
         Wait Until Page Contains Element    ${fulfilment_calendar_window}    timeout=5
         Wait Until Page Contains Element    ${last_date_of_this_month}    timeout=5
         Click Element    ${last_date_of_this_month}
         Sleep    1
         Wait Until Element Is Enabled    ${continue_fulfilment_button}    timeout=5
         Click Element    ${continue_fulfilment_button}
         Wait Until Page Does Not Contain Element    ${fulfilment_options_heading}    timeout=20s
    END
    Wait Until Element Is Visible    ${checkout_heading}    timeout=20s
    Page Should Contain Element    ${checkout_heading}
    Sleep    1s
    ${feedback}    Run Keyword And Return Status    Element Should Be Visible    //label[text()="Customer Feedback "]
    IF    ${feedback}
        ${text}    Generate Random Name
        Input Text    //label[text()="Customer Feedback "]//following-sibling::div/input    ${text}
        Click Button    //span[text()="Save"]//ancestor::button
    END