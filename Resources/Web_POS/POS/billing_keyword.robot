*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../Resources/CustomKeywords/utilities.py
Variables    ../../../PageObjects/Web_POS/POS/hold_bill_locators.py
Variables   ../../../PageObjects/Web_POS/POS/checkout_locators.py
Variables   ../../../PageObjects/Web_POS/POS/pos_locators.py
Variables   ../../../PageObjects/Web_POS/POS/add_customer_locator.py
Resource    ../../../Resources/Web_POS/POS/split_payment_keyword.robot
Resource    ../../../Resources/Web_POS/POS/manual_discount_keyword.robot
Resource  ../../../Resources/Web_POS/POS/share_invoice_keywords.robot

*** Keywords ***
Hold Bill
    Wait Until Page Contains Element    ${hold_bill}
    Click Element    ${hold_bill}
    Wait Until Page Contains Element    ${hold_bill_confirmation}
    Click Element    ${hold_bill_confirmation}

Recall Bill
    Wait Until Page Contains Element    ${view_held_bills}
    Click Element    ${view_held_bills}
    Wait Until Page Contains Element    ${recall_bill}
    Click Element    ${recall_bill}
    Wait Until Page Contains Element    ${recall_bill_confirmation}
    Click Element    ${recall_bill_confirmation}

Discard Bill
    Wait Until Page Contains Element    ${view_held_bills}
    Click Element    ${view_held_bills}
    Wait Until Page Contains Element    ${discard_bill}
    Click Element    ${discard_bill}
    Wait Until Page Contains Element    ${discard_bill_confirmation}
    Click Element    ${discard_bill_confirmation}

Return To Bill
    Wait Until Page Contains Element    ${view_held_bills}
    Click Element    ${view_held_bills}
    Wait Until Page Contains Element    ${return_to_bill}
    Click Element    ${return_to_bill}

View Held Bill
    Wait Until Page Contains Element    ${view_held_bills}
    Click Element    ${view_held_bills}
    Wait Until Page Contains Element    ${recall_bill}

Verify hold bill
    Wait Until Page Contains Element    ${cart_0}
    Page Should Contain Element    ${cart_0}
    Element Should Be Visible    ${view_held_bills}

Verify View Held Bill
    Wait Until Page Contains Element    ${recall_bill}
    Page Should Contain Element    ${return_to_bill}
    Page Should Contain Element    ${discard_bill}
    Page Should Contain Element    ${recall_bill}

Verify Recall Bill
    Wait Until Page Contains Element    ${hold_bill}
    Page Should Not Contain Element    ${cart_0}
    Page Should Contain Element    ${checkout_button}
    Page Should Contain Element    ${clear_all_items}
    Element Should Be Visible    ${payable_amount}

Verify Discard Bill
    Wait Until Page Contains Element    ${return_to_bill}
    Page Should Contain Element    ${return_to_bill}

Verify Return To Bill
    Wait Until Page Contains Element    ${hold_bill}
    Page Should Contain Element    ${cart_0}
    Page Should Contain Element    ${view_held_bills}

Get payable amount
    Wait Until Page Contains Element    ${payable_amount}   timeout=20s
    ${payable_amount_with_rs}=    Get Text    ${payable_amount}
    ${payable_amt}=    Remove Characters    ${payable_amount_with_rs}
    ${payable_amt}=    Convert To Number    ${payable_amt}
    RETURN  ${payable_amt}


Payment By Cash
    [Arguments]    ${cash_value}
    Click Element   ${payment_method_cash}
    Wait Until Page Contains Element   ${enter_cash}
    Input Text      ${enter_cash}   ${cash_value}
    Click Element    ${continue_cash_button}

Partial Payment
    [Arguments]    ${cash_value}
    ${half_amount}  Evaluate    ${cash_value}/2
    Clear Element Text    ${enter_split_amount}
#    Click Element    ${cancel}
    Input Text    ${enter_split_amount}    ${half_amount}
    Click Element   ${payment_method_cash}
    Wait Until Page Contains Element    ${enter_cash}
    Input Text      ${enter_cash}   ${half_amount}
    Wait Until Element Is Enabled    ${continue_cash_button} 
    Click Element    ${continue_cash_button}

Discard Bill | Checkout
    Wait Until Page Contains Element    ${discard_payment_bill}
    Wait Until Page Contains Element    ${discard_confirm}
    Element Should Be Enabled    ${discard_confirm}
    Click Element    ${discard_confirm}

Verify Discard Bill After Partial Payment
    Wait Until Page Contains Element    ${cart_0}
    Page Should Contain Element    ${cart_0}
    Element Should Be Disabled   ${clear_all_items}

Verify Multiple Price Product Is Added
    sleep   0.5
    Page Should Not Contain Element    ${cart_0}
    Element Should Be Enabled    ${clear_all_items}
    Page Should Contain Element    ${sub_total}
    Page Should Contain Element    ${payable_amount}
    Page Should Contain Element    ${tax_amount} 

Click On Back Button | Checkout
    Wait Until Page Contains Element   ${back_icon_on_checkout}
    Click Element    ${back_icon_on_checkout}

Add Customer Details for partial payment
    [Arguments]    ${customer_data}
    ${my_dict}    Create Dictionary   &{customer_data}
    Wait Until Page Contains Element    ${add_customer_link}    timeout=20s
    Click Element    ${add_customer_link}
    Wait Until Element Is Visible    ${customer_phone_field}
    Input Text    ${customer_phone_field}    ${my_dict.mobile}
    Click Button    ${continue_billing_button}
    Wait Until Element Is Visible    ${customer_first_name_field}    timeout=20s
    Wait Until Element Is Enabled    ${start_billing_button}    timeout=20s
    Click Button    ${start_billing_button}

Payment By Paytm
    [Arguments]    ${paytm_value}
    click Element   ${upi_payment}
    ${id}=  Generate Random Phone Number
    Wait Until Page Contains Element    ${enter_paytm_transaction_id}
    Input Text      ${enter_paytm_transaction_id}   ${id}
    Click Element    ${continue_paytm_button}

Verify split payment toggle button is enabled
    Wait Until Page Contains Element   ${enter_split_amount}
    Page Should Contain Element     ${enter_split_amount}

Verify split payment toggle button is disabled.
    Element Should Be Disabled     ${enter_split_amount}

Verify If Payment is Complete Or Not
#    Wait Until Page Contains Element   ${payment_complete_heading}  timeout=10s
#    Page Should Contain Element     ${payment_complete_heading}
    Wait Until Page Contains Element    ${checkout_sub_total}   timeout=10s
    Page Should Contain Element     ${checkout_sub_total}
    Wait Until Page Contains Element    ${print_invoice}    timeout=10s
    Page Should Contain Element     ${print_invoice}

Apply Item Manual Discount | Custom Discount
    [Arguments]    ${discount_data}
    ${discount_dict}    Create Dictionary   &{discount_data}
    Click Element    ${custom_discount_tab}
#    Wait Until Element Is Visible    ${discount_type_amount}    timeout=10s
#    Wait Until Element Is Visible    ${discount_type_percentage}
    ${discount_list}=    Convert Items To List    ${discount_dict.manual_discount}
    ${discount_dict} =    Convert Item List To Dictionary    ${discount_dict.manual_discount}
    ${key}=    Set Variable    ${discount_dict[0]}
    Log    ${key}
    ${value}=    Set Variable    ${discount_dict[1]}
    Log    ${value}
    IF    '${key}' == 'Custom_Discount_Amount'
        Click Element    ${discount_type_amount}
        Input Text    ${discount_value}    ${value}
        Click Button    ${apply_amount_discount_button}
    ELSE IF    '${key}' == 'Custom_Discount_Percentage'
        Click Element    ${discount_type_percentage}
        Input Text    ${discount_value}    ${value}
        Click Button    ${apply_percent_discount_button}
    END
    Wait Until Element Is Visible    ${update_product_subtotal}

Click On Update Product | Manual Discount
    Wait Until Page Contains Element    ${update_product_md}     timeout=10s
    Click Element   ${update_product_md}

No Payment Required | Checkout Page
    Wait Until Page Contains Element    ${no_payment_required_confirm_button}
    Page Should Contain Element     ${no_payment_required_confirm_button}
    Click Element   ${no_payment_required_confirm_button}

Change Billing Mode
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
    Wait Until Page Contains Element    ${switch_confirm_button}
    Page Should Contain Element    ${switch_modal_text}
    Element Should Be Enabled    ${switch_confirm_button}
    Element Should Be Enabled    ${switch_cancel_button}
    Click Element    ${switch_confirm_button}
    Wait Until Page Contains Element    //div[@class="dropdown b-dropdown switch-billing fs-12 float-right btn-group"]//button[text()="${my_dict.Mode}"]


Auto Switch To Billing
    Click Element    ${order_management_option_sidebar}
    Wait Until Page Contains Element    ${order_management_option_sidebar}
    Click Element    ${pos_option_sidebar}
    Wait Until Page Contains Element    ${switch_modal_text}
    Wait Until Page Contains Element    ${switch_modal_proceed_button}
    Click Element    ${switch_modal_proceed_button}

Price Override | Billing
    [Arguments]    ${price_override}
    ${my_dict}    Create Dictionary   &{price_override}
    Wait Until Page Contains Element    ${first_item_product_name}  timeout=15s
    Sleep  2s
    Click Element  ${first_item_product_name}
    Wait Until Page Contains Element    ${price_override_link}
    Click Element    ${price_override_link}
    Wait Until Page Contains Element    ${price_override_heading}
    ${test_data_price}  Convert To Integer    ${my_dict.Price_Override}
    ${price}  Evaluate  ${unit_price_amount} + ${test_data_price}
    Input Text    ${price_override_custom_price_field}    ${price}
    Click Element    ${apply_override_button}

Apply Bill Loyalty
    Wait Until Page Contains Element    ${checkout_loyalty}
    Click Element  ${checkout_loyalty}
    Wait Until Page Contains Element    ${loyalty_modal_heading}
    Page Should Contain Element     ${loyalty_modal_heading}
    #need to ask client for further process

Apply Bill Coupon
    Wait Until Page Contains Element    ${checkout_coupon}
    Click Element  ${checkout_coupon}
    Wait Until Page Contains Element    ${loyalty_modal_heading}
    Page Should Contain Element     ${loyalty_modal_heading}
    #need to ask client for further process

Add Bill Remarks
   [Arguments]    ${bill_remark}
   ${my_dict}    Create Dictionary   &{bill_remark}
   Wait Until Page Contains Element    ${checkout_billing_options}
   Click Element    ${checkout_billing_options}
   ${remark}  Run Keyword And Return Status    Element Should Be Visible    ${checkout_billing_add_bill_remark}
   IF    ${remark}
       Wait Until Page Contains Element    ${checkout_billing_add_bill_remark}
       Click Element    ${checkout_billing_add_bill_remark}
       Input Text    ${add_bill_remark_textarea}    ${my_dict.Remark}
       Click Element    ${add_bill_remark_save_button}
   ELSE
        Click Element    ${checkout_billing_edit_remark}
        Input Text    ${add_bill_remark_textarea}    ${my_dict.Remark}
        Click Element    ${add_bill_remark_save_button}
   END
   Capture Page Screenshot

Automatic Invoice Generation
   Wait Until Page Contains Element    ${payment_complete_heading}
   ${cust_info_checkout}   Get Customer Details | Checkout
   Click Element    ${print_invoice_button}
   Wait Until Page Contains Element    ${invoice_modal_heading}
   [Return]  ${cust_info_checkout}

Verify The Product Are Added In Cart
    Wait Until Page Contains Element    ${in_store}
    Page Should Contain Element    ${in_store}
    Page Should Contain Element    ${delivery}
    Wait Until Page Contains Element    ${cart_last_element}  timeout=5s
    Wait Until Page Contains Element    //span[@class='quantity h5 mb-0 mr-1' and contains(text(),'${cart_count}')]
    Page Should Contain Element     //span[@class='quantity h5 mb-0 mr-1' and contains(text(),'${cart_count}')]
    Wait Until Page Contains Element    ${payable_amount}
    Page Should Contain Element    ${payable_amount}
    Element Should Be Enabled    ${checkout_button}
    Element Should Be Enabled    ${clear_all_items}

Verify Carry Bag Added In Cart
    Wait Until Page Contains Element    ${in_store}
    Page Should Contain Element    ${in_store}
    Page Should Contain Element    ${delivery}
    Wait Until Page Contains Element    ${cart_last_element}  timeout=5s
    ${cart_count}  Get Text   ${cart_last_element}
    Wait Until Page Contains Element    //span[@class='quantity h5 mb-0 mr-1' and contains(text(),'${cart_count}')]
    Page Should Contain Element     //span[@class='quantity h5 mb-0 mr-1' and contains(text(),'${cart_count}')]
    Wait Until Page Contains Element    ${payable_amount}
    Page Should Contain Element    ${payable_amount}
    Element Should Be Enabled    ${checkout_button}
    Element Should Be Enabled    ${clear_all_items}

Verify Bill Is Reset
    Wait Until Page Contains Element    ${in_store}
    Page Should Contain Element    ${in_store}
    Wait Until Page Contains Element    ${delivery}
    Page Should Contain Element    ${delivery}
    Page Should Contain Element    ${cart_0}
    Page Should Contain Element    ${payable_amount}
    Page Should Not Contain Element    ${clear_all_items}
    Page Should Not Contain Element    ${checkout_button}

Verify Auto Switched To Billing
    ${switch_option}  Get Text    ${switch_billing_dropdown}
    Should Be Equal    ${switch_option}    Billing
    Page Should Contain Element    ${cart_0}
    Page Should Not Contain Element    ${clear_all_items}
    Page Should Not Contain Element    ${checkout_button}

Verify Price Overridden | Billing
    Wait Until Element Is Visible    ${price_override_successful}
    Element Should Be Visible    ${price_override_successful}
    Wait Until Page Contains Element    ${first_item_product_name}  timeout=15s
    Click Element  ${first_item_product_name}
    Wait Until Page Contains Element    ${update_product_button}
    Page Should Contain Element   ${price_override_link_disable}

Verify Bill Remark Added
   Wait Until Element Is Visible    ${remark_added_successful}   timeout=15s
   Page Should Contain Element   ${remark_added_successful}
   Click Element    ${checkout_billing_options}
   Wait Until Page Contains Element    ${checkout_billing_edit_remark}
   Page Should Contain Element    ${checkout_billing_edit_remark}

Verify Invoice Generated Automatically
   Wait Until Page Contains Element    ${invoice_modal_heading}
   Page Should Contain Element    ${invoice_modal_heading}
   Page Should Contain Element    ${close_invoice_modal_button}
   Page Should Contain Element    ${print_invoice_modal_button}

Verify Cancel Button While Switching Mode
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
    Wait Until Page Contains Element    ${switch_cancel_button}
    Element Should Be Enabled    ${switch_confirm_button}
    Element Should Be Enabled    ${switch_cancel_button}
    Click Element    ${switch_cancel_button}

Verify Item Added In Cart
    Wait Until Page Contains Element    ${in_store}   timeout=10s
    Page Should Contain Element    ${in_store}
    Page Should Contain Element    ${delivery}
    Wait Until Page Contains Element    ${cart_last_element}  timeout=5s
    ${cart_count}  Get Text   ${cart_last_element}
    Convert To Integer    ${cart_count}
    ${i}=  Set Variable    1
    ${product_count_for_test}    Set Variable    0
    FOR  ${i}  IN RANGE    1    ${cart_count}+1
           ${is_a_button}    Run Keyword And Return Status    Element Should Be Visible    ${quantity_column_buttons}
           IF    ${is_a_button}
               ${product_count_for_test}=    Evaluate    ${product_count_for_test}+1
               Log    ${product_count_for_test}
           ELSE
               Wait Until Page Contains Element    (${product_name_in_cart_row})[${i}]
               Click Element    (${product_name_in_cart_row})[${i}]
               Wait Until Page Contains Element    ${quantity_product_window}
               ${count}    Get Text    ${quantity_product_window}
               Convert To Integer    ${count}
               ${product_count_for_test}    Evaluate    ${count}+${product_count_for_test}
               Wait Until Page Contains Element    ${update_product_button}
               Click Element    ${update_product_button}
           END
    END
    ${temp}    Get Text    ${item_quantity_in_cart}
    ${temp}    Remove Characters    ${temp}
    Convert To Integer    ${temp}
    Should Be Equal As Integers     ${temp}    ${product_count_for_test}
    Wait Until Page Contains Element    ${payable_amount}   timeout=15s
    Page Should Contain Element    ${payable_amount}
    Element Should Be Enabled    ${checkout_button}
    Element Should Be Enabled    ${clear_all_items}

Verify Alert Message for Price Overridden | Billing
    Wait Until Element Is Visible    ${amount_limit_message}
    Element Should Be Visible    ${amount_limit_message}
    Page Should Contain Element    ${apply_override_button}

Verify Price Override Link Is Disabled
     Wait Until Page Contains Element    ${first_item_product_name}  timeout=15s
     Sleep  2s
     Click Element  ${first_item_product_name}
     Wait Until Page Contains Element    ${price_override_link_disable}
     Page Should Contain Element   ${price_override_link_disable}

Add Product By Scan Only
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.buy_items}
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
    Click Element    ${scan_only}
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
        Input Text    ${product_search_bar}    ${key}
        Press Keys    ${product_search_bar}    ENTER
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
    Set Test Variable   ${unit_price_amount}
    Set Test Variable  ${values}

Click On First Product Row
    Wait Until Page Contains Element    ${first_item_product_name}  timeout=15s
    Click Element  ${first_item_product_name}
    ${cart_count}   Get Text  //span[text()='${values}']
    Wait Until Page Contains Element   ${update_product_button}
    Click Element    ${update_product_button}
    Set Test Variable     ${cart_count}

Add Carry Bags
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
        ${value}=    Convert To Integer    ${values}
        ${carry_bag_option}=   Replace String   ${carry_bag_input_field}    Carry bag   ${key}
        Wait Until Page Contains Element    ${carry_bag_option}
        Input Text    ${carry_bag_option}    ${value}
    END
    Click Element    ${carry_bag_add}
    Set Test Variable    ${values}

Reset Bill | Billing Module
   Wait Until Page Contains Element    ${clear_all_items}  timeout=3s
   Click Element    ${clear_all_items}
   Wait Until Page Does Not Contain Element    ${clear_all_items}
   Wait Until Page Does Not Contain Element    ${checkout_button}
   Page Should Not Contain Element    ${clear_all_items}
   Page Should Not Contain Element    ${checkout_button}


Validate Account Balance Are Equal On Tagged Customer Details and Checkout Page
    Wait Until Page Contains Element    ${customer_info_icon}
    Click Element    ${customer_info_icon}
    Element Should Be Enabled    ${customer_edit_info_button}
    Element Should Be Enabled    ${customer_edit_groups_button}
    Element Should Be Enabled    ${customer_untag_button}
    ${account_limit}    Get Text    ${available_on_account_limit}
    Click Element    ${close_customer_window}
    Wait Until Element Is Enabled    ${checkout_button}
    Click Element    ${checkout_button}
    ${feedback_window}=  Run Keyword And Return Status    Page Should Contain Element    ${checkout_customer_feedback}
    IF    ${feedback_window}
        Input Text    ${checkout_customer_feedback}    Good!
        Wait Until Element Is Enabled    ${checkout_save_feedback_button}
        Click Element    ${checkout_save_feedback_button}
        Wait Until Element Is Enabled    ${checkout_heading}
    ELSE
        ${grand_total}    Get Text    ${checkout_account_balance}
    END
    Should Be Equal    ${grand_total}     ${account_limit}


Validate Store Credit Are Equal On Tagged Customer Details and Checkout Page
    Wait Until Page Contains Element    ${customer_info_icon}
    Click Element    ${customer_info_icon}
    Element Should Be Enabled    ${customer_edit_info_button}
    Element Should Be Enabled    ${customer_edit_groups_button}
    Element Should Be Enabled    ${customer_untag_button}
    ${store_credit}    Get Text    ${store_credit_issue}
    Click Element    ${close_customer_window}
    Wait Until Element Is Enabled    ${checkout_button}
    Click Element    ${checkout_button}
    ${feedback_window}=  Run Keyword And Return Status    Page Should Contain Element    ${checkout_customer_feedback}
    IF    ${feedback_window}
        Input Text    ${checkout_customer_feedback}    Good!
        Wait Until Element Is Enabled    ${checkout_save_feedback_button}
        Click Element    ${checkout_save_feedback_button}
        Wait Until Element Is Enabled    ${checkout_heading}
    ELSE
        ${c_store_credit}    Get Text    ${checkout_store_credit}
    END
    Should Be Equal    ${c_store_credit}     ${store_credit}

Validate Loyalty Points Are Equal On Tagged Customer Details and Checkout Page
    Wait Until Page Contains Element    ${customer_info_icon}
    Click Element    ${customer_info_icon}
    Element Should Be Enabled    ${customer_edit_info_button}
    Element Should Be Enabled    ${customer_edit_groups_button}
    Element Should Be Enabled    ${customer_untag_button}
    ${loyalty_points}    Get Text    ${customer_info_loyalty_points}
    Click Element    ${close_customer_window}
    Wait Until Element Is Enabled    ${checkout_button}
    Click Element    ${checkout_button}
    ${feedback_window}=  Run Keyword And Return Status    Page Should Contain Element    ${checkout_customer_feedback}
    IF    ${feedback_window}
        Input Text    ${checkout_customer_feedback}    Good!
        Wait Until Element Is Enabled    ${checkout_save_feedback_button}
        Click Element    ${checkout_save_feedback_button}
        Wait Until Element Is Enabled    ${checkout_heading}
    ELSE
        ${c_loyalty_points}    Get Text    ${checkout_loyalty_points}
    END
    Should Be Equal    ${c_loyalty_points}     ${loyalty_points}


Verify If Bill Was Calculated | Net Price Same As Payable Amount
    Wait Until Page Contains Element    ${net_price}
    ${n_price}    Get Text    ${net_price}
#    ${hide_button_present}    Run Keyword And Return Status    Page Should Contain Element    ${hide_catalog_button}
#    IF    ${hide_button_present}
#        Click Element    ${hide_catalog_button}
#    END
    Sleep    1
    ${p_amount}    Get Text    ${payable_amount}
    Should Be Equal As Strings    ${n_price}    ${p_amount}


Apply Item Level Promos
    Wait Until Element Is Enabled    ${product_name_in_cart_row}
    Click Element    ${product_name_in_cart_row}
    Sleep    1
    Wait Until Page Contains Element    ${active_promotion}
    Click Element    ${active_promotion}
    Wait Until Page Contains Element    ${active_promo_dropdown_row}
    Click Element    ${active_promo_dropdown_row}
    Wait Until Element Is Enabled    ${update_product_button}
    Click Element    ${update_product_button}


Apply Bill Level Promos
    Wait Until Page Contains Element    ${checkout_bill_promos}
    Click Element    ${checkout_bill_promos}
    Wait Until Page Contains Element    ${promos_applied_message}
    Page Should Contain Element    ${promos_applied_message}


Verify Bill Level Promos Applied
    Page Should Contain Element    ${bill_promo_discount}
    ${bpromo_discount}  Get Text    ${bill_promo_discount}
    ${stotal}    Get Text    ${sub_total}
    ${taxes_value}    Get Text    ${taxes}
    Remove Characters   ${stotal}
    Remove Characters    ${bpromo_discount}
    Remove Characters    ${taxes_value}
    ${result}   Evaluate    ${stotal}  -  ${bpromo_discount}
    ${final_result}    Evaluate    ${result}    +   ${taxes_value}
    ${grand__total}    Get Text    ${grand_total}
    Remove Characters    ${grand__total}
    Should Be Equal    ${grand__total}    ${result}


Verify If Item Level Promos Applied
    Wait Until Element Is Enabled    ${promo_name_in_product_row}
    Page Should Contain Element    ${promo_name_in_product_row}

Assign A Salesperson To An Item
    [Arguments]    ${pos_data}
    ${details_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element   ${first_item_product_name}
    Click Element    ${first_item_product_name}
    Wait Until Page Contains Element    ${salesperson_dropdown}
    Click Element    ${salesperson_dropdown}
    Wait Until Page Contains Element    ${salesperson_search_field}
    Click Element    ${salesperson_search_field}
    Input Text    ${salesperson_search_field}    ${details_dict.salesperson_name}
    Click Element    ${row_in_salesperson_dropdown}
    Wait Until Page Contains Element    ${salesperson_tagged_message}
    Element Should Be Enabled    ${update_product_button}
    Click Element    ${update_product_button}
    Element Should Contain    ${salesperson_below_product}    ${details_dict.salesperson_name}

Assign A different Salesperson To Each Item
    [Arguments]    ${pos_data}
    ${products_list}    Get Webelements    ${product_name_in_cart_row}
    ${product_count}    Get Text    ${cart_last_element}
    ${item}=  Set Variable    1
    FOR  ${item}  IN RANGE    1    ${product_count}+1
           Set Selenium Speed    0.3
           Wait Until Page Contains Element    (${product_name_in_cart_row})[${item}]
           Click Element    (${product_name_in_cart_row})[${item}]
           Wait Until Page Contains Element    ${salesperson_dropdown}
           Click Element    ${salesperson_dropdown}
           Wait Until Page Contains Element    (${row_in_salesperson_dropdown})[${item}]
           Click Element    (${row_in_salesperson_dropdown})[${item}]
           Wait Until Page Contains Element    ${salesperson_tagged_message}
           Element Should Be Enabled    ${update_product_button}
           Click Element    ${update_product_button}
           Wait Until Page Contains Element    ${salesperson_tagged_message}
    END

Verify If Salesperson Is Assigned To An Item
    [Arguments]    ${pos_data}
    ${details_dict}    Create Dictionary    &{pos_data}
    ${hide_button_present}    Run Keyword And Return Status    Page Should Contain Element    ${hide_catalog_button}
    IF    ${hide_button_present}
        Click Element    ${hide_catalog_button}
    END
    Page Should Contain Element    ${first_item_product_name}
    Click Element    ${product_preview}
    Page Should Contain Element    ${preview_salesperson_name}
    Element Should Contain   ${preview_salesperson_name}    ${details_dict.salesperson_name}

Verify If Different Salesperson Was Assigned To Each Person
    Wait Until Page Contains Element    ${salesperson_below_product}
    ${salesperson_list}    Get Webelements    ${salesperson_below_product}
    ${salesperson_count}    Get Length    ${salesperson_list}
    ${new_list}    Create List
    FOR  ${item}   IN RANGE    1    ${salesperson_count}+1
        Wait Until Page Contains Element    (${salesperson_below_product})[${item}]
        ${temp}   Get Text    (${salesperson_below_product})[${item}]
        Should Not Contain    ${new_list}    ${temp}
        Append To List    ${new_list}    ${temp}
    END
    List Should Not Contain Duplicates    ${new_list}

Verify Salesperson Tagging is Disabled
    Element Should Be Disabled    ${salesperson_button}

Get Store Name | Web POS
   Click Element    ${pos_option_sidebar}
   Wait Until Page Contains Element    ${store_name_pos}  timeout=40s
   ${store_name}  Get Text    ${store_name_pos}
   RETURN  ${store_name}
