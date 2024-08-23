*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../../Resources/CustomKeywords/utilities.py
Variables   ../../../../PageObjects/Web_POS/POS/pos_locators.py
Variables    ../../../../PageObjects/Web_POS/POS/add_customer_locator.py
Variables    ../../../../PageObjects/Web_POS/POS/checkout_locators.py
Variables    ../../../../PageObjects/Web_POS/POS/order_locators.py
Variables    ../../../../PageObjects/Web_POS/POS/checkout_locators.py
Variables    ../../../../PageObjects/Web_POS/Login/login_locators.py
Variables   ../../../../Environment/environment.py
Resource    ../../../../Resources/Web_POS/POS/Order/add_to_cart_order_keyword.robot

*** Keywords ***
Click Continue Button Of Insufficient Inventory And Set Fulfillment Date
    Wait Until Element Is Enabled    ${checkout_button}    timeout=10
    Click Element    ${checkout_button}
    ${insufficient}    Run Keyword And Return Status    Wait Until Element Is Visible    ${insufficient_inventory_continue_btn}
    IF    ${insufficient}
       Wait Until Element Is Enabled    ${insufficient_inventory_continue_btn}
       Click Element    ${insufficient_inventory_continue_btn}
    END
    Wait Until Page Contains Element    ${fulfilment_options_heading}    timeout=10
    Wait Until Page Contains Element    ${fulfilment_due_date_option}    timeout=10
    Click Element    ${fulfilment_due_date_option}
    Wait Until Page Contains Element    ${fulfilment_calendar_window}    timeout=10
    Wait Until Page Contains Element    ${last_date_of_this_month}    timeout=10
    Click Element    ${last_date_of_this_month}
    Sleep    1
    Wait Until Element Is Enabled    ${continue_fulfilment_button}    timeout=10
    Click Element    ${continue_fulfilment_button}
    Wait Until Page Does Not Contain Element    ${fulfilment_options_heading}    timeout=10


Verify Order Can Be Placed Without Payment
    Wait Until Element Is Enabled    ${place_order_button}
    Click Element    ${place_order_button}
    Wait Until Page Contains Element    ${order_summary_page_heading}
    Page Should Contain Element    ${order_summary_status_pending}
    Wait Until Element Is Enabled    ${confirm_order_button}
    Page Should Contain Element    ${print_order_receipt}

Place Order With Minimum Amount
    Wait Until Page Contains Element    ${checkout_split_payment}
    Click Element    ${checkout_split_payment}
    Wait Until Element Is Enabled    ${checkout_payable_amount}
    ${total}    Get Text    ${grand_total}
    ${number_only}    Remove Characters    ${total}
    ${ten_percent}=    Evaluate    ${number_only} * 0.1
    Sleep    0.5
    Input Text    ${checkout_payable_amount}    ${ten_percent}
    Wait Until Element Is Enabled    ${payment_method_cash}    timeout=10
    Click Element    ${payment_method_cash}
    Wait Until Page Contains Element    ${enter_cash}    timeout=10
    Clear Element Text    ${enter_cash}
    Input Text    ${enter_cash}     ${ten_percent}
    Wait Until Element Is Enabled    ${continue_cash_button}    timeout=10
    Click Element    ${continue_cash_button}
    Wait Until Page Contains Element    ${payment_saved_successful}    timeout=10
    Wait Until Page Does Not Contain Element    ${payment_saved_successful}    timeout=10
    Wait Until Element Is Enabled    ${place_order_button}    timeout=10
    Click Element    ${place_order_button}
    Wait Until Page Does Not Contain    ${place_order_button}
    Wait Until Page Contains Element    ${order_summary_page_heading}    timeout=20

Verify Insufficient Inventory Buttons
    Wait Until Element Is Visible    ${checkout_button}  timeout=10
    Click Element    ${checkout_button}
    Wait Until Element Is Visible    ${insufficient_inventory_title}  timeout=15s
    Wait Until Element Is Enabled    ${insufficient_inventory_continue_btn}     timeout=5
    Wait Until Element Is Enabled    ${insufficient_inventory_cancel_btn}   timeout=5
    Element Should Be Enabled    ${insufficient_inventory_continue_btn}
    Element Should Be Enabled    ${insufficient_inventory_cancel_btn}

Cancel Insufficient Inventory Popup
    Wait Until Element Is Visible    ${insufficient_inventory_cancel_btn}   timeout=20
    Click Element    ${insufficient_inventory_cancel_btn}
    Page Should Contain Element    ${product_search_bar}
    
Verify Checkout Page Redirection
    Wait Until Element Is Visible    ${checkout_heading}    timeout=20s
    Wait Until Element Is Visible    ${checkout_split_payment}
    Wait Until Element Is Visible    ${checkout_order_summary}
    Wait Until Element Is Enabled   ${options_checkout_page}
    Element Should Be Disabled    ${place_order_button}

Verify Stock Not Available Popup | Order Is Created
    Wait Until Element Is Enabled    ${place_order_button}
    Element Should Be Enabled    ${place_order_button}
    Click Element    ${place_order_button}
    Wait Until Element Is Visible    ${stock_point_alert_popup}
    Page Should Contain Element    ${stock_point_alert_popup}

Verify Stock Not Available Popup | Order Is Confirmed
    Wait Until Element Is Enabled    ${place_order_button}
    Element Should Be Enabled    ${place_order_button}
    Click Element    ${place_order_button}
    Wait Until Element Is Visible    ${order_summary_page_heading}  timeout=20s
    Wait Until Element Is Enabled    ${confirm_order_button}
    Element Should Be Enabled    ${confirm_order_button}
    Click Element    ${confirm_order_button}
    ${confirm_order_popup_visible}  Run Keyword And Return Status    Wait Until Page Contains Element    ${confirm_order_heading_confirm_order_popup}  timeout=5
    IF    ${confirm_order_popup_visible}
         Verify Confirm Order Popup
         Click Element    ${review_button_confirm_order_popup}
    END
    Wait Until Element Is Visible    ${order_confirmation_page_heading}     timeout=20s
    Sleep    1s
    Wait Until Element Is Visible    ${info_icon_confirm_order}
    Mouse Over    ${info_icon_confirm_order}
    Element Should Be Visible    ${stock_point_popup_confirm_order}

Navigate To Pack Order Page | Order Is Packed
    ${place_order_visible}  run keyword and return status   Wait Until Element Is Visible   ${place_order_button}
    IF    ${place_order_visible}
        Wait Until Element Is Enabled    ${place_order_button}  timeout=20s
        Element Should Be Enabled    ${place_order_button}
        Click Element    ${place_order_button}
    END
    Wait Until Element Is Visible    ${order_summary_page_heading}  timeout=20s
    Wait Until Element Is Enabled    ${confirm_order_button}
    Element Should Be Enabled    ${confirm_order_button}
    Click Element    ${confirm_order_button}
        ${confirm_order_popup_visible}  Run Keyword And Return Status    Wait Until Page Contains Element    ${confirm_order_heading_confirm_order_popup}  timeout=5s
    IF    ${confirm_order_popup_visible}
         Verify Confirm Order Popup
         Click Element    ${review_button_confirm_order_popup}
    END
    Wait Until Element Is Visible    ${order_confirmation_page_heading}     timeout=20s
    Wait Until Element Is Enabled    ${confirm_order_button_order_confirm_page}
    Click Element    ${confirm_order_button_order_confirm_page}
    Wait Until Element Is Enabled    ${pack_order_button}
    Click Element    ${pack_order_button}
    Wait Until Element Is Visible    ${pack_order_heading}

Verify Stock Not Available Popup | Order Is Packed
    Wait Until Element Is Visible    ${stock_alert_pack_order}
    Page Should Contain Element    ${stock_alert_pack_order}

Verify Stock Not Available Popup | When Invoices Is Generated
    Wait Until Element Is Enabled    ${order_completion_button}
    Click Element    ${order_completion_button}

Navigate To Discard Order Popup | Discard Order
    ${place_order_button_checkout}   Run Keyword And Return Status    Element Should Be Enabled    ${place_order_button}
    IF     ${place_order_button_checkout}
         Click Element    ${place_order_button}
    END
    Wait Until Element Is Visible    ${confirm_order_button}    timeout=10s
    Wait Until Element Is Enabled    ${confirm_order_button}
    Click Element     ${confirm_order_button}
   ${confirm_order_popup_visible}  Run Keyword And Return Status    Wait Until Page Contains Element    ${confirm_order_heading_confirm_order_popup}  timeout=10
    IF    ${confirm_order_popup_visible}
         Verify Confirm Order Popup
         Click Element    ${review_button_confirm_order_popup}
    END
    Wait Until Element Is Visible    ${discard_button_order_confirmation}   timeout=20s
    Sleep    1s
    Wait Until Element Is Enabled    ${discard_button_order_confirmation}
    Click Element    ${discard_button_order_confirmation}

Verify Discard Order Popup
    Wait Until Element Is Visible    ${discard_popup_heading}   timeout=20s
    Page Should Contain Element    ${cash_button_discard_popup}
    Page Should Contain Element    ${store_credit_button_discard_popup}
    Element Should Be Enabled    ${cancel_button_discard_popup}
    Element Should Be Enabled    ${continue_button_discard_popup}
    Click Element    ${continue_button_discard_popup}
    Wait Until Element Is Visible    ${order_cancel_alert}
    Page Should Contain Element    ${order_cancel_alert}
    Wait Until Element Is Visible    ${amount_due_cancel_order}     timeout=20s
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

Verify Discard Order Popup With Different Method
    [Arguments]     ${refund_method}
    Wait Until Element Is Visible    ${discard_popup_heading}   timeout=20s
    Page Should Contain Element    ${cash_button_discard_popup}
    Page Should Contain Element    ${store_credit_button_discard_popup}
    Element Should Be Enabled    ${cancel_button_discard_popup}
    Element Should Be Enabled    ${continue_button_discard_popup}
    Element Should Be Enabled    ${refund_method}
    Click Element    ${refund_method}
    ${remark_present}  Run Keyword And Return Status    Element Should Be Visible    ${remark_button_discard_popup}
    IF    ${remark_present}
         Click Element    ${remark_button_discard_popup}
         Input Text    ${remark_button_discard_popup}    good
    END
    Click Element    ${continue_button_discard_popup}
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

Scan Barcode To Add Item And Quantity To Cart | Pack Order
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.buy_items}
    Wait Until Element Is Visible    ${search_bar_pack_order}    timeout=20s
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        Sleep    1s
        Click Element    ${search_bar_pack_order}
        Input Text    ${search_bar_pack_order}    ${key}
        Wait Until Element Is Visible    ${product_search_pack_order}    timeout=20s
        Sleep    1s
        Click Element    ${product_search_pack_order}
    END

Verify Discard Product | No Advance Payment
    Wait Until Element Is Visible    ${discard_popup_heading}      timeout=10
    Element Should Be Enabled    ${discard_button_discard_popup}
    Click Element    ${discard_button_discard_popup}
    Wait Until Element Is Visible    ${order_cancel_alert}
    Page Should Contain Element    ${order_cancel_alert}
    Click Element    ${order_cancel_alert}
    Wait Until Element Is Visible    ${amount_due_cancel_order}     timeout=10
    Page Should Contain Element    ${amount_due_cancel_order}
    ${index}=    Set Variable    0
    ${index_value}=  Convert To Number  ${index}
    Sleep    2
    ${value}  Get Text    ${amount_due_cancel_order}
    ${amount_due}  Remove Characters    ${value}
    ${amount_due_value}=  Convert To Number    ${amount_due}
    Log    ${amount_due_value}
    Should Be Equal As Integers       ${amount_due_value}    ${index}
    Page Should Not Contain Element    ${credit_note_reserved_discard_popup}
    Page Should Not Contain Element    ${credit_note_released_discard_popup}

Verify Bill Remark Added Is Visible In Bill Remark Textarea | Order
   [Arguments]    ${bill_remark}
   ${my_dict}    Create Dictionary   &{bill_remark}
   Wait Until Page Contains Element    ${options_checkout_page}
   Click Element    ${options_checkout_page}
   ${remark}  Run Keyword And Return Status    Element Should Be Visible    ${add_bill_remark_dropdown}
   IF    ${remark}
       Wait Until Page Contains Element    ${add_bill_remark_dropdown}
       Click Element    ${add_bill_remark_dropdown}
       Input Text    ${add_bill_remark_textarea}    ${my_dict.Remark}
   ELSE
        Click Element    ${edit_remark_button}
        Input Text    ${add_bill_remark_textarea}    ${my_dict.Remark}
   END
   Page Should Contain Element    ${add_bill_remark_textarea}    ${my_dict.Remark}
   Element Should Be Enabled    ${add_bill_remark_save_button}
   Element Should Be Enabled    ${add_bill_remark_clear_button}

Add Bill Remarks | Order
   [Arguments]    ${bill_remark}
   ${my_dict}    Create Dictionary   &{bill_remark}
   Wait Until Page Contains Element    ${options_checkout_page}
   Click Element    ${options_checkout_page}
   ${remark}  Run Keyword And Return Status    Element Should Be Visible    ${add_bill_remark_dropdown}
   IF    ${remark}
       Wait Until Page Contains Element    ${add_bill_remark_dropdown}
       Click Element    ${add_bill_remark_dropdown}
       Input Text    ${add_bill_remark_textarea}    ${my_dict.Remark}
       Click Element    ${add_bill_remark_save_button}
   ELSE
        Click Element    ${edit_remark_button}
        Input Text    ${add_bill_remark_textarea}    ${my_dict.Remark}
        Click Element    ${add_bill_remark_save_button}
   END
   Capture Page Screenshot

Verify Bill Remark Added | Order
   Wait Until Element Is Visible    ${remark_added_successful}   timeout=15s
   Page Should Contain Element   ${remark_added_successful}
   Click Element    ${options_checkout_page}
   Wait Until Page Contains Element    ${edit_remark_button}
   Page Should Contain Element    ${edit_remark_button}

Verify The Clear Button Of Add Bill Remark | Order
   [Arguments]    ${bill_remark}
   ${my_dict}    Create Dictionary   &{bill_remark}
   Wait Until Page Contains Element    ${options_checkout_page}
   Click Element    ${options_checkout_page}
   ${remark}  Run Keyword And Return Status    Element Should Be Visible    ${add_bill_remark_dropdown}
   IF    ${remark}
       Wait Until Page Contains Element    ${add_bill_remark_dropdown}
       Click Element    ${add_bill_remark_dropdown}
       Input Text    ${add_bill_remark_textarea}    ${my_dict.Remark}
   ELSE
        Click Element    ${edit_remark_button}
        Input Text    ${add_bill_remark_textarea}    ${my_dict.Remark}
   END
   Page Should Contain Element    ${add_bill_remark_textarea}    ${my_dict.Remark}
   Element Should Be Enabled    ${add_bill_remark_save_button}
   Element Should Be Enabled    ${add_bill_remark_clear_button}
   Click Element    ${add_bill_remark_clear_button}
   Element Should Not Contain    ${add_bill_remark_textarea}    ${my_dict.Remark}

Verify Payment By Cash Popup
    [Arguments]    ${cash_value}
    ${discard}=    Run Keyword And Return Status    Element Should Be Enabled    ${discard_item_previous_session}
    IF  ${discard}
     Discard Previous Added Item
    END
    ${no_payment}=    Run Keyword And Return Status    Element Should Be Enabled    ${no_payment_required_confirm_button}
    IF  ${no_payment}
     No Payment Required | Checkout Page
    ELSE
      Click Element   ${payment_method_cash}
      Wait Until Page Contains Element   ${enter_cash}
      Input Text      ${enter_cash}   ${cash_value}
      Wait Until Element Is Visible    ${continue_cash_button}
      Wait Until Element Is Enabled    ${continue_cash_button}
      Element Should Be Enabled    ${continue_cash_button}
    END

Verify 10 Percent Amount Payment By Cash Popup
    [Arguments]    ${cash_value}
    ${discard}=    Run Keyword And Return Status    Element Should Be Enabled    ${discard_item_previous_session}
    IF  ${discard}
     Discard Previous Added Item
    END
    ${no_payment}=    Run Keyword And Return Status    Element Should Be Enabled    ${no_payment_required_confirm_button}
    IF  ${no_payment}
     No Payment Required | Checkout Page
    ELSE
      ${new_amount} =  Evaluate    ${cash_value} * 0.1
      ${amount_value}   Convert To Integer    ${new_amount}
      ${new_amount_value}   Evaluate   ${amount_value}+1
      Click Element   ${payment_method_cash}
      Wait Until Page Contains Element   ${enter_cash}
      Input Text      ${enter_cash}   ${new_amount}
      Wait Until Element Is Visible    ${continue_cash_button}
      Wait Until Element Is Enabled    ${continue_cash_button}
      Element Should Be Enabled    ${continue_cash_button}
    END

Verify More Than 10 Percent Amount Payment By Cash Popup
    [Arguments]    ${cash_value}
    ${discard}=    Run Keyword And Return Status    Element Should Be Enabled    ${discard_item_previous_session}
    IF  ${discard}
     Discard Previous Added Item
    END
    ${no_payment}=    Run Keyword And Return Status    Element Should Be Enabled    ${no_payment_required_confirm_button}
    IF  ${no_payment}
     No Payment Required | Checkout Page
    ELSE
      ${new_amount} =  Evaluate    ${cash_value} * 0.1 + 5
      Click Element   ${payment_method_cash}
      Wait Until Page Contains Element   ${enter_cash}
      Input Text      ${enter_cash}   ${new_amount}
      Wait Until Element Is Visible    ${continue_cash_button}
      Wait Until Element Is Enabled    ${continue_cash_button}
      Element Should Be Enabled    ${continue_cash_button}
    END

Verify Update Of Fulfillment Options Due Date
    Wait Until Element Is Visible     ${options_checkout_page}   timeout=10
    Wait Until Element Is Enabled    ${options_checkout_page}
    Click Element  ${options_checkout_page}
    Wait Until Element Is Visible    ${fulfilment_option_dropdown}  timeout=5
    Click Element    ${fulfilment_option_dropdown}
    Wait Until Element Is Visible   ${fulfilment_options_heading}    timeout=10
    Wait Until Page Contains Element    ${fulfilment_options_heading}    timeout=5
    Wait Until Page Contains Element    ${fulfilment_due_date_option}    timeout=5
    ${previous_date}    Get Value    ${fulfilment_due_date_option}
    Click Element    ${fulfilment_due_date_option}
    Wait Until Page Contains Element    ${fulfilment_calendar_window}    timeout=5
    Wait Until Page Contains Element    ${random_date_fulfilment_option}    timeout=5
    Click Element    ${random_date_fulfilment_option}
    Sleep    1
    Wait Until Element Is Enabled    ${continue_fulfilment_button}    timeout=5
    Click Element    ${continue_fulfilment_button}
    Wait Until Page Does Not Contain Element    ${fulfilment_options_heading}    timeout=5
    Wait Until Element Is Visible     ${options_checkout_page}   timeout=10
    Wait Until Element Is Enabled    ${options_checkout_page}
    Click Element  ${options_checkout_page}
    Wait Until Element Is Visible    ${fulfilment_option_dropdown}  timeout=5
    Click Element    ${fulfilment_option_dropdown}
    Wait Until Element Is Visible   ${fulfilment_options_heading}    timeout=10
    Wait Until Page Contains Element    ${fulfilment_options_heading}    timeout=5
    Wait Until Page Contains Element    ${fulfilment_due_date_option}    timeout=5
    Sleep   0.5
    ${new_date}  Get Value  ${fulfilment_due_date_option}
    Should Not Be Equal    ${previous_date}    ${new_date}

Place Order With Minimum Amount | Continue Button Enabled
    Wait Until Page Contains Element    ${checkout_split_payment}
    Click Element    ${checkout_split_payment}
    Wait Until Element Is Enabled    ${checkout_payable_amount}
    ${total}    Get Text    ${grand_total}
    ${number_only}    Remove Characters    ${total}
    ${ten_percent}=    Evaluate    ${number_only} * 0.1
    Sleep    0.5
    Input Text    ${checkout_payable_amount}    ${ten_percent}
    Wait Until Element Is Enabled    ${payment_method_cash}    timeout=5
    Click Element    ${payment_method_cash}
    Wait Until Page Contains Element    ${enter_cash}    timeout=5
    Clear Element Text    ${enter_cash}
    Input Text    ${enter_cash}     ${ten_percent}
    Wait Until Element Is Enabled    ${continue_cash_button}    timeout=5
    Element Should Be Enabled    ${continue_cash_button}

Place Order With Minimum Percentage | Continue Button Enabled
    Wait Until Page Contains Element    ${checkout_split_payment}
    Click Element    ${checkout_split_payment}
    Wait Until Element Is Enabled    ${checkout_payable_amount}
    ${total}    Get Text    ${grand_total}
    ${number_only}    Remove Characters    ${total}
    ${ten_percent}=    Evaluate    ${number_only} * 0.1
    Sleep    0.5
    Input Text    ${checkout_payable_amount}    ${ten_percent}
    Wait Until Element Is Enabled    ${payment_method_cash}    timeout=5
    Click Element    ${payment_method_cash}
    Wait Until Page Contains Element    ${enter_cash}    timeout=5
    Clear Element Text    ${enter_cash}
    Input Text    ${enter_cash}     ${ten_percent}
    Wait Until Element Is Enabled    ${continue_cash_button}    timeout=5

Pay 10 percent Amount of total Payable Amount By Cash
    [Arguments]     ${total_amount}
    ${new_amount} =  Evaluate    ${total_amount} * 0.1
    Sleep    1
    Input Text    ${enter_cash}    ${new_amount}
    Wait Until Element Is Enabled  ${continue_cash_button}
    Click Element    ${continue_cash_button}

Verify Confirm Order Popup
    Wait Until Element Is Visible    ${confirm_order_heading_confirm_order_popup}   timeout=10s
    Wait Until Element Is Enabled    ${review_button_confirm_order_popup}
    Wait Until Element Is Enabled    ${confirm_button_confirm_order_popup}

Navigate To Order Confirmation Page From Order Summary Page
    Wait Until Element Is Visible    ${confirm_order_button}    timeout=10
    Wait Until Element Is Enabled    ${confirm_order_button}
    Click Element    ${confirm_order_button}
        ${confirm_order_popup_visible}  Run Keyword And Return Status    Element Should Be Visible    ${confirm_order_heading_confirm_order_popup}
    IF    ${confirm_order_popup_visible}
         Verify Confirm Order Popup
         Click Element    ${review_button_confirm_order_popup}
    END

Verify Replace Product | Order Is Packed
    Wait Until Element Is Visible    ${replace_button_order_confirm}    timeout=10
    Wait Until Element Is Enabled    ${replace_button_order_confirm}
    Click Element    ${replace_button_order_confirm}
    Wait Until Element Is Visible    ${replace_popup_heading}   timeout=10

Scan Barcode To Add Item And Quantity To Cart | Replace Product
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.replace_items}
    Wait Until Element Is Visible    ${search_bar_replace_page}    timeout=20s
    ${items_list}=    Convert Items To List    ${my_dict.replace_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.replace_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        Sleep    1s
        Click Element    ${search_bar_replace_page}
        Input Text    ${search_bar_replace_page}    ${key}
        Wait Until Element Is Visible    ${search_product_result_replace_page}    timeout=20s
        Sleep    1s
        Click Element    ${search_product_result_replace_page}
    END

Verify Product Replace Button Functionality
    Wait Until Element Is Visible    ${replace_button_replace_popup}
    Wait Until Element Is Enabled    ${replace_button_replace_popup}
    Element Should Be Enabled    ${replace_button_replace_popup}

Verify Invoice Generation When Advance Payment Is Off | When Inovices Is Generated
    Wait Until Element Is Visible    ${confirm_completion_pack_order}   timeout=10
    Wait Until Element Is Enabled    ${confirm_completion_pack_order}
    Click Element    ${confirm_completion_pack_order}
    Wait Until Element Is Visible    ${order_options_order_summary}  timeout=10
    Wait Until Element Is Enabled    ${order_options_order_summary}
    Click Element    ${order_options_order_summary}
    Wait Until Element Is Visible    ${generate_invoice_order_options}  timeout=10
    Wait Until Element Is Enabled    ${generate_invoice_order_options}
    Click Element    ${generate_invoice_order_options}
    Page Should Contain    invoice_details
