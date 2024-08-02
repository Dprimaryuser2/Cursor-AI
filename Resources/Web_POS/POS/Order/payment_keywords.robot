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

*** Keywords ***
Click Continue Button Of Insufficient Inventory And Set Fullfilment Date
    Wait Until Element Is Enabled    ${checkout_button}    timeout=5
    Click Element    ${checkout_button}
    ${insufficient}    Run Keyword And Return Status    Page Should Contain Element    ${insufficient_inventory_continue_btn}
    IF    ${insufficient}
       Click Element    ${insufficient_inventory_continue_btn}
    END
    Wait Until Page Contains Element    ${fulfilment_options_heading}    timeout=5
    Wait Until Page Contains Element    ${fulfilment_due_date_option}    timeout=5
    Click Element    ${fulfilment_due_date_option}
    Wait Until Page Contains Element    ${fulfilment_calendar_window}    timeout=5
    Wait Until Page Contains Element    ${last_date_of_this_month}    timeout=5
    Click Element    ${last_date_of_this_month}
    Sleep    1
    Wait Until Element Is Enabled    ${continue_fulfilment_button}    timeout=5
    Click Element    ${continue_fulfilment_button}
    Wait Until Page Does Not Contain Element    ${fulfilment_options_heading}    timeout=5


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
    Wait Until Element Is Enabled    ${payment_method_cash}    timeout=5
    Click Element    ${payment_method_cash}
    Wait Until Page Contains Element    ${enter_cash}    timeout=5
    Clear Element Text    ${enter_cash}
    Input Text    ${enter_cash}     ${ten_percent}
    Wait Until Element Is Enabled    ${continue_cash_button}    timeout=5
    Click Element    ${continue_cash_button}
    Wait Until Page Contains Element    ${payment_saved_successful}    timeout=5
    Wait Until Page Does Not Contain Element    ${payment_saved_successful}    timeout=5
    Wait Until Element Is Enabled    ${place_order_button}    timeout=5
    Click Element    ${place_order_button}
    Wait Until Page Contains Element    ${order_summary_page_heading}    timeout=5


Verify Insufficient Inventory Buttons
    Wait Until Element Is Visible    ${checkout_button} 
    Click Element    ${checkout_button}
    Wait Until Element Is Visible    ${insufficient_inventory_title}  timeout=5s
    Wait Until Element Is Enabled    ${insufficient_inventory_continue_btn}     timeout=5
    Wait Until Element Is Enabled    ${insufficient_inventory_cancel_btn}   timeout=5
    Element Should Be Enabled    ${insufficient_inventory_continue_btn}
    Element Should Be Enabled    ${insufficient_inventory_cancel_btn}

Cancel Insufficient Inventory Popup
    Wait Until Element Is Visible    ${insufficient_inventory_cancel_btn}
    Click Element    ${insufficient_inventory_cancel_btn}
    Page Should Contain Element    ${product_search_bar}

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
    Wait Until Element Is Visible    ${order_summary_page_heading}
    Wait Until Element Is Enabled    ${confirm_order_button}
    Element Should Be Enabled    ${confirm_order_button}
    Click Element    ${confirm_order_button}
    Wait Until Element Is Visible    ${order_confirmation_page_heading}
    Mouse Over    ${info_icon_confirm_order}
    Element Should Be Visible    ${stock_point_popup_confirm_order}

Navigate To Pack Order Page | Order Is Packed
    Wait Until Element Is Enabled    ${place_order_button}
    Element Should Be Enabled    ${place_order_button}
    Click Element    ${place_order_button}
    Wait Until Element Is Visible    ${order_summary_page_heading}
    Wait Until Element Is Enabled    ${confirm_order_button}
    Element Should Be Enabled    ${confirm_order_button}
    Click Element    ${confirm_order_button}
    Wait Until Element Is Visible    ${order_confirmation_page_heading}
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

Verify Replace Product | Order Is Packed  #incomplete
    Wait Until Element Is Enabled    ${confirm_order_button}
    Click Element    ${confirm_order_button}

Navigate To Discard Order Popup | Discard Order
    Wait Until Element Is Visible    ${confirm_order_button}    timeout=10s
    Wait Until Element Is Enabled    ${confirm_order_button}
    Click Element     ${confirm_order_button}
    Wait Until Element Is Visible    ${discard_button_order_confirmation}   timeout=10s
    Wait Until Element Is Enabled    ${discard_button_order_confirmation}
    Click Element    ${discard_button_order_confirmation}

Verify Discard Order Popup
    ${index}    Set Variable    0
    Wait Until Element Is Visible    ${cancel_order_popup_heading}
    Page Should Contain Element    ${cash_button_cancel_order}
    Page Should Contain Element    ${store_credit_button_cancel_order}
    Element Should Be Enabled    ${cancel_button_cancel_order}
    Element Should Be Enabled    ${continue_button_cancel_order}
    Click Element    ${continue_button_cancel_order}
    Page Should Contain Element    ${order_cancel_alert}
    Page Should Contain Element    ${amount_due_cancel_order}
    ${value}  Get Text    ${amount_due_cancel_order}
    ${amount_due}  Remove Characters    ${value}
    ${amount_due_value}  Convert To String    ${amount_due}
    Should Be Equal As Strings     ${amount_due_value}    ${index}
    ${value1}  Get Text    ${credit_note_reserved_cancel_order}
    ${credit_note_reserved}  Remove Characters    ${value1}
    ${credit_note_reserved_value}  Convert To String    ${credit_note_reserved}
    ${value2}  Get Text    ${credit_note_released_cancel_order}
    ${credit_note_released}  Remove Characters    ${value2}
    ${credit_note_released_value}  Convert To String    ${credit_note_released}
    Should Be Equal As Strings     ${credit_note_reserved_value}    ${credit_note_released_value}

Verify Discard Order Popup With Different Method
    [Arguments]     ${refund_method}
    ${index}    Set Variable    0
    Wait Until Element Is Visible    ${cancel_order_popup_heading}
    Page Should Contain Element    ${cash_button_cancel_order}
    Page Should Contain Element    ${store_credit_button_cancel_order}
    Element Should Be Enabled    ${cancel_button_cancel_order}
    Element Should Be Enabled    ${continue_button_cancel_order}
    Element Should Be Enabled    ${refund_method}
    Click Element    ${refund_method}
    Click Element    ${continue_button_cancel_order}
    Wait Until Element Is Visible    ${order_cancel_alert}  timeout=10s
    Page Should Contain Element    ${order_cancel_alert}
    Wait Until Element Is Visible    ${amount_due_cancel_order}
    Page Should Contain Element    ${amount_due_cancel_order}
    Sleep    1
    ${value}  Get Text    ${amount_due_cancel_order}
    ${amount_due}  Remove Characters    ${value}
    ${amount_due_value}  Convert To String    ${amount_due}
    Should Be Equal As Strings     ${amount_due_value}    ${index}
    ${value1}  Get Text    ${credit_note_reserved_cancel_order}
    ${credit_note_reserved}  Remove Characters    ${value1}
    ${credit_note_reserved_value}  Convert To String    ${credit_note_reserved}
    ${value2}  Get Text    ${credit_note_released_cancel_order}
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
    ${index}    Set Variable    0
    Wait Until Element Is Visible    ${cancel_order_popup_heading}
    Page Should Contain Element    ${cash_button_cancel_order}
    Page Should Contain Element    ${store_credit_button_cancel_order}
    Element Should Be Enabled    ${cancel_button_cancel_order}
    Element Should Be Enabled    ${continue_button_cancel_order}
    Click Element    ${continue_button_cancel_order}
    Page Should Contain Element    ${order_cancel_alert}
    Page Should Contain Element    ${amount_due_cancel_order}
    ${value}  Get Text    ${amount_due_cancel_order}
    ${amount_due}  Remove Characters    ${value}
    ${amount_due_value}  Convert To String    ${amount_due}
    Should Be Equal As Strings     ${amount_due_value}    ${index}
    Page Should Not Contain Element    ${credit_note_reserved_cancel_order}
    Page Should Not Contain Element    ${credit_note_released_cancel_order}

Verify Add Bill Remark | Order
    Wait Until Element Is Enabled    ${options_checkout_page}