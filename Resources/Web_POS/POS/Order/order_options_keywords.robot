*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../../Resources/CustomKeywords/utilities.py
Variables   ../../../../PageObjects/Web_POS/POS/pos_locators.py
Variables    ../../../../PageObjects/Web_POS/POS/add_customer_locator.py
Variables    ../../../../PageObjects/Web_POS/POS/checkout_locators.py
Variables    ../../../../PageObjects/Web_POS/POS/order_locators.py
Variables    ../../../../PageObjects/Web_POS/Login/login_locators.py
Variables   ../../../../Environment/environment.py
Resource    ../../../../Resources/Web_POS/POS/Order/add_to_cart_order_keyword.robot

*** Keywords ***
Verify Stock Not Available alert | Order Created | Advance Payment On
    Wait Until Element Is Visible    ${stock_point_alert_popup}
    Page Should Contain Element    ${stock_point_alert_popup}

Verify Redirection To Order Confirmation Page
    Wait Until Element Is Visible    ${order_confirmation_page_heading}   timeout=10
    Wait Until Element Is Enabled    ${back_order_confirmation}
    Element Should Be Enabled    ${back_order_confirmation}
    Element Should Be Disabled    ${confirm_order_button}
    Element Should Be Enabled    ${replace_button_order_confirm}
    Element Should Be Enabled    ${discard_button_order_confirmation}

Review Order Before Order Confirmation
#    Wait Until Element Is Visible    ${order_confirmation_page_heading}   timeout=10
#    ${barcode}  Get Text    ${barcode_order_confirmation}
#    ${product_price}  Get Text    ${total_price_order_confirmation}
#    ${quantity}     Get Text    ${quantity_order_confirmation}
#    ${discount}     Get Text    ${discount_order_confirmation}


Navigate To Order Confirmation Page From Checkout Page
    ${place_order_button_visible}   Run Keyword And Return Status    Wait Until Element Is Visible    ${place_order_button}
    IF    ${place_order_button_visible}
         Wait Until Element Is Enabled    ${place_order_button}
         Click Element  ${place_order_button}
    END
    Wait Until Element Is Visible    ${confirm_order_button}    timeout=10
    Wait Until Element Is Enabled    ${confirm_order_button}
    Click Element    ${confirm_order_button}
    Wait Until Element Is Visible    ${confirm_order_button_order_confirm_page}    timeout=10
    Wait Until Element Is Enabled    ${confirm_order_button_order_confirm_page}
    Click Element    ${confirm_order_button_order_confirm_page}

Navigate To Order Confirmation Page From Order Summary Page
    Wait Until Element Is Visible    ${confirm_order_button}    timeout=10
    Wait Until Element Is Enabled    ${confirm_order_button}
    Click Element    ${confirm_order_button}
    Wait Until Element Is Visible    ${confirm_order_button_order_confirm_page}    timeout=10
    Wait Until Element Is Enabled    ${confirm_order_button_order_confirm_page}
    Click Element    ${confirm_order_button_order_confirm_page}

Enter 10 Percent Amount In Payable Amount
    [Arguments]     ${total_amount}
    ${new_amount} =  Evaluate    ${total_amount} * 0.1
    Sleep    1
    Input Text    ${enter_split_amount}    ${new_amount}
    RETURN  ${new_amount}

Verify Order Confirm Alert
    Wait Until Element Is Visible   ${order_confirm_alert}
    Element Should Be Visible    ${order_confirm_alert}

Payment By Cash Less Than Payable Amount
    [Arguments]    ${cash_value}
    ${discard}=    Run Keyword And Return Status    Element Should Be Enabled    ${discard_item_previous_session}
    IF    ${discard}
     Discard Previous Added Item
    END
    ${no_payment}=    Run Keyword And Return Status    Element Should Be Enabled    ${no_payment_required_confirm_button}
    IF    ${no_payment}
     No Payment Required | Checkout Page
    ELSE
      Click Element   ${payment_method_cash}
      Wait Until Page Contains Element   ${enter_cash}
      Clear Element Text    ${enter_cash}
      ${lesser_amount} =  Evaluate    ${cash_value} - 30
      ${lesser_amount_value}    Convert To Integer    ${lesser_amount}
      Input Text      ${enter_cash}   ${lesser_amount_value}
    END

Navigate To Order Summary Page From Checkout Page
    Wait Until Element Is Visible    ${place_order_button}
    Wait Until Element Is Enabled    ${place_order_button}
    Click Element    ${place_order_button}

Verify Redirection To Checkout Page After Advance Payment
    ${place_order_button_visible}   Run Keyword And Return Status    Wait Until Element Is Visible    ${place_order_button}  timeout=10
    IF    ${place_order_button_visible}
         Wait Until Element Is Enabled    ${place_order_button}
         Click Element  ${place_order_button}
    END
    Wait Until Element Is Visible    ${confirm_order_button}    timeout=10
    Wait Until Element Is Enabled    ${confirm_order_button}
    Click Element    ${confirm_order_button}
    Wait Until Element Is Visible    ${confirm_order_button_order_confirm_page}    timeout=10
    Wait Until Element Is Enabled    ${confirm_order_button_order_confirm_page}
    Click Element    ${confirm_order_button_order_confirm_page}
    Wait Until Element Is Visible    ${order_options_order_summary}    timeout=10
    Wait Until Element Is Enabled    ${order_options_order_summary}
    Click Element    ${order_options_order_summary}
    Wait Until Element Is Visible    ${collect_payment}
    Click Element    ${collect_payment}
    Wait Until Element Is Visible    ${checkout_heading}    timeout=10

Get Amount From Payable Amount After Partial Payment
    Wait Until Element Is Visible    ${enter_split_amount}  timeout=10
    Wait Until Page Contains Element    ${enter_split_amount}
    Sleep    2
    ${remaining_amount}     Get Value    ${enter_split_amount}
    RETURN  ${remaining_amount}

Get Order Number
    Wait Until Element Is Visible    ${order_number_print_recipt}   timeout=10
    ${order_number_text}  Get Text    ${order_number_print_recipt}
    ${order_number_list}   Split String    ${order_number_text}    :
    Log    ${order_number_list}[2]
    Click Element    ${close_button_print_order}
    RETURN  ${order_number_list}[2]

Navigate To Order Management And Redirect To Checkout Page Using Order Number
    [Arguments]     ${order_number}
    Wait Until Element Is Visible    ${order_management_option_sidebar}   timeout=10
    Wait Until Element Is Enabled    ${order_management_option_sidebar}
    Click Element    ${order_management_option_sidebar}
    Wait Until Element Is Visible    ${order_management_page_heading}   timeout=10
    Wait Until Element Is Enabled    ${search_bar_order_management}
    Click Element    ${search_bar_order_management}
    Input Text    ${search_bar_order_management}    ${order_number}
    Wait Until Element Is Visible    ${order_status_order_management}
    Click Element    ${order_status_order_management}
    Wait Until Element Is Visible    ${order_summary_page_heading}    timeout=10s

Navigate To Print Recipt Container
    Wait Until Element Is Visible    ${print_order_receipt}     timeout=10
    Wait Until Element Is Enabled     ${print_order_receipt}
    Click Element      ${print_order_receipt}

Cancel Order
    Wait Until Element Is Visible    ${order_options_order_summary}
    Wait Until Element Is Enabled    ${order_options_order_summary}
    Click Element    ${order_options_order_summary}
    Wait Until Element Is Visible    ${cancel_order_order_options}
    Wait Until Element Is Enabled    ${cancel_order_order_options}
    Click Element    ${cancel_order_order_options}

Verify Discard Order Popup With Different Method | Cancel Order Popup
    [Arguments]     ${refund_method}
    Wait Until Element Is Visible    ${cancel_order_popup_heading}  timeout=10
    Page Should Contain Element    ${cash_cancel_order_popup}
    Page Should Contain Element    ${store_credit_cancel_order_popup}
    Element Should Be Enabled    ${close_cancel_order_popup}
    Element Should Be Enabled    ${confirm_cancel_order_popup}
    Element Should Be Enabled    ${refund_method}
    Click Element    ${refund_method}
    ${remark_present}  Run Keyword And Return Status    Element Should Be Visible    ${remark_button_discard_popup}
    IF    ${remark_present}
         Click Element    ${remark_button_discard_popup}
         Input Text    ${remark_button_discard_popup}    good
    END
    Click Element    ${confirm_cancel_order_popup}
    Wait Until Element Is Visible    ${order_cancel_alert}  timeout=10s
    Page Should Contain Element    ${order_cancel_alert}
    Wait Until Element Is Visible    ${amount_due_cancel_order}
    Page Should Contain Element    ${amount_due_cancel_order}
    ${index}=    Set Variable    0
    ${index_value}=  Convert To Number  ${index}
    Sleep    1
    ${value}  Get Text    ${amount_due_cancel_order}
    ${amount_due}  Remove Characters    ${value}
    ${amount_due_value}=  Convert To Number    ${amount_due}
    Log    ${amount_due_value}
    Should Be Equal As Integers       ${amount_due_value}    ${index}
    ${value1}  Get Text    ${credit_note_reserved_discard_popup}
    ${credit_note_reserved}  Remove Characters    ${value1}
    ${credit_note_reserved_value}  Convert To String    ${credit_note_reserved}
    ${value2}  Get Text    ${credit_note_released_discard_popup}
    ${credit_note_released}  Remove Characters    ${value2}
    ${credit_note_released_value}  Convert To String    ${credit_note_released}
    Should Be Equal As Strings     ${credit_note_reserved_value}    ${credit_note_released_value}

Verify If Payment Is Complete Or Not After Full Payment | Order
    Wait Until Element Is Visible     ${order_summary_page_heading}   timeout=10s
    Page Should Contain Element    ${order_summary_page_heading}
    Wait Until Element Is Visible    ${pack_order_button}    timeout=10
    Page Should Contain Element    ${pack_order_button}
    Page Should Contain Element    ${print_order_receipt}
    Wait Until Element Is Visible    ${credit_note_reserved}    timeout=10
    Page Should Contain Element    ${credit_note_reserved}
    Page Should Contain Element    ${amount_paid_order_summary}
    Page Should Contain Element    ${total_amount_order_summary}

Verify Successful Payment After Full Payment | Order
    [Arguments]    ${cash_value}
    ${payable_amount}=    Get Text    ${total_amount_order_summary}
    ${payable_amount}     Remove Characters    ${payable_amount}
    ${payable_amount}    Convert To Number    ${payable_amount}
    ${customer_paid_amount}    Get Text    ${amount_paid_order_summary}
    ${customer_paid_amount}    Remove Characters    ${customer_paid_amount}
    ${customer_paid_amount}    Convert To Number    ${customer_paid_amount}
    Should Be Equal As Integers    ${customer_paid_amount}    ${payable_amount}

Click On Print Recipt Button
    Wait Until Element Is Visible    ${print_order_receipt}     timeout=10
    Wait Until Element Is Enabled    ${print_order_receipt}
    Click Element    ${print_order_receipt}
    Wait Until Element Is Visible  ${order_number_print_recipt}     timeout=10

Verify Recipt Content | Order
   Wait Until Page Contains Element    ${order_summary_page_heading}    timeout=10
   ${cust_info_checkout}   Get Customer Details | Checkout | Order
   Click Element    ${print_order_receipt}
   Wait Until Page Contains Element    ${order_number_print_recipt}
   [Return]  ${cust_info_checkout}

Get Customer Details | Checkout | Order
    ${invoice_ids}    Create List
    Wait Until Page Contains Element    ${order_summary_page_heading}
    ${in_id}  Get Value    ${order_number_order_summary}
    ${in_name}  Get Value    ${customer_name_order_summary}
    ${in_number}  Get Value    ${customer_number_order_summary}
    ${in_amount}  Get Value    ${total_amount_order_summary}
    ${cust_info_checkout}=  Create Dictionary    invoice_id=${in_id}  invoice_name=${in_name}  phone_number=${in_number}  total_amount=${in_amount}    search_invoice=${in_id}
    Append To List    ${invoice_ids}    ${in_id}
    Set Global Variable    ${invoice_ids}
    [RETURN]   ${cust_info_checkout}

Get Customer Details | Print Invoice | Order
   Wait Until Page Contains Element    ${print_recipt_container}
   ${inp_id}  Get Order Number
   ${inp_name}  Get Text    ${customer_name_print_recipt}
   ${inp_number}  Get Text    ${number_invoice}
   ${inp_amount}  Get Text    ${total_amount_print_recipt}
   ${cust_info_invoice}=  Create Dictionary    pinvoice_id=${inp_id}  pinvoice_name=${inp_name}  pphone_number=${inp_number}  ptotal_amount=${inp_amount}
   [RETURN]   ${cust_info_invoice}

