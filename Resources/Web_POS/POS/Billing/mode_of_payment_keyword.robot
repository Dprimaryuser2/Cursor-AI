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
Collecting Payment Through Cash | Less Than Payable Amount
    [Arguments]    ${cash_value}
    Click Element   ${payment_method_cash}
    Wait Until Page Contains Element   ${enter_cash}
    ${cash_amount}=    Evaluate    ${cash_value}-1
    Input Text      ${enter_cash}   ${cash_amount}

Collecting Payment Through Cash | More Than Payable Amount
    [Arguments]    ${cash_value}
    Click Element   ${payment_method_cash}
    Wait Until Page Contains Element   ${enter_cash}
    ${cash_amount}=    Evaluate    ${cash_value}+1
    Input Text      ${enter_cash}   ${cash_amount}
    Click Element    ${continue_cash_button}

Verify Continue Button Is Disabled
    Page Should Not Contain Element     ${payment_complete_heading}
    Page Should Not Contain Element     ${share_invoice}
    Page Should Not Contain Element    ${print_invoice}
    Page Should Contain Element    ${disabled_cash_continue_button}

Verify Successful Payment
    [Arguments]    ${cash_value}    ${customer_details}
    ${customer_details_dict}    Create Dictionary    &{customer_details}
    ${customer_name}    Catenate    ${customer_details_dict.first_name}    ${customer_details_dict.last_name}
    ${customer_name_at_invoice_page}    Get Text    ${invoice_customer_name}
    Should Be Equal As Strings    ${customer_name_at_invoice_page}      ${customer_name}
    ${customer_phone_number}=    Get Text    ${invoice_customer_phone}
    ${customer_phone_number}    Convert To Number    ${customer_phone_number}
    ${entered_customer_phone_number}    Convert To Number    ${customer_details_dict.phone_number}
    Should Be Equal As Integers        ${customer_phone_number}    ${entered_customer_phone_number}
    ${payable_amount}=    Get Text    ${amount_paid_at_checkout}
    ${payable_amount}     Remove Characters    ${payable_amount} 
    ${payable_amount}    Convert To Number    ${payable_amount}
    ${customer_paid_amount}    Get Text    ${amount_paid_by_customer}
    ${customer_paid_amount}    Remove Characters    ${customer_paid_amount}
    ${customer_paid_amount}    Convert To Number    ${customer_paid_amount}
    Should Be Equal As Integers    ${customer_paid_amount}    ${payable_amount}
    ${amount_paid_via_mop}    Get Text    ${paid_amount_by_mop}
    ${amount_paid_via_mop}    Remove Characters    ${amount_paid_via_mop}
    ${amount_paid_via_mop}    Convert To Number    ${amount_paid_via_mop}
    Should Be Equal As Integers    ${amount_paid_via_mop}    ${payable_amount}
    ${mode_of_payment}    Get Text    ${payment_mode_label}

Collect Payment Using Store Credit | Partial Redemption Not Allowed
        [Arguments]    ${pos_dict}
        ${details}    Create Dictionary    &{pos_dict}
        Wait Until Page Contains Element    ${redeem_store_credit_button}
        Click Element    ${redeem_store_credit_button}
        Wait Until Page Contains Element    ${redeem_with_dropdown}
        Click Element    ${redeem_with_dropdown}
        Click Element    ${redeem_with_credit_option}
        Wait Until Page Contains Element    ${input_voucher_code}
        Page Should Contain Element    ${partial_redemption_lapse_alert}
        Click Element    ${input_voucher_code}
        Input Text    ${input_voucher_code}    ${details.voucher_code}
        Element Should Be Enabled    ${apply_store_credit_voucher}
        Click Element    ${apply_store_credit_voucher}

Collect Payment Using Store Credit | Partial Redemption Allowed
    [Arguments]    ${pos_dict}
    ${details}    Create Dictionary    &{pos_dict}
    Sleep    0.5
    Wait Until Page Contains Element    ${redeem_store_credit_button}   timeout=10s
    Click Element    ${redeem_store_credit_button}
    Wait Until Page Contains Element    ${redeem_with_dropdown}
    Click Element    ${redeem_with_dropdown}
    Click Element    ${redeem_with_credit_option}
    Wait Until Page Contains Element    ${input_voucher_code}
#    Page Should Not Contain Element    ${partial_redemption_lapse_alert}
    Click Element    ${input_voucher_code}
    Input Text    ${input_voucher_code}    ${details.voucher_code}
    Wait Until Keyword Succeeds    4    2   Click Element    ${apply_store_credit_voucher}

Verify Partial Redemption Allowed
    Page Should Not Contain Element    ${full_redemption_popup}
    Page Should Not Contain Element    ${cancel_redeem_lapse_button}
    Wait Until Page Contains Element   ${payment_complete_heading}  timeout=10s
    Page Should Contain Element     ${payment_complete_heading}
    Page Should Contain Element     ${share_invoice}
    Page Should Contain Element     ${print_invoice}

Verify Partial Redemption Not Allowed
    Page Should Contain Element    ${partial_redemption_lapse_alert}
    Wait Until Page Contains Element    ${full_redemption_popup}    timeout=20s
    Page Should Contain Element    ${full_redemption_popup}
    Page Should Contain Element    ${cancel_redeem_lapse_button}

Collect Payment Via On Account Sale
    Click Button    ${account_on_sale}
    Wait Until Page Contains Element    ${on_account_sale_heading}    timeout=10s
    ${remark}    Generate Random String
    Input Text    ${remark_account_on_sale}    ${remark}
    Click Button    ${continue_account_on_sale_button}
    Wait Until Page Does Not Contain Element    ${on_account_sale_heading}

Payment Via Additional MOP
    Click Element   ${upi_payment}
    ${id}=  Generate Random Phone Number
    Wait Until Page Contains Element    ${enter_paytm_transaction_id}
    Input Text      ${enter_paytm_transaction_id}   ${id}
    Click Element    ${continue_paytm_button}

Verify Additional MOP Reference Id Popup
    Click Element   ${upi_payment}
    Wait Until Page Contains Element    ${additional_mop_popup}    timeout=20s
    ${id}=  Generate Random Phone Number
    Wait Until Page Contains Element    ${enter_paytm_transaction_id}
    Input Text      ${enter_paytm_transaction_id}   ${id}
    Page Should Contain Element    ${enter_paytm_transaction_id}
    Page Should Contain Element    ${customer_paid_field}
    Page Should Contain Element    ${customer_paid_label}
    Element Should Be Enabled    ${continue_payment_button}

Verify Amount AutoPopulated
    [Arguments]    ${amount}
    Page Should Contain Element    ${enter_paytm_transaction_id}
    Page Should Contain Element    ${customer_paid_field}
    Page Should Contain Element    ${customer_paid_label}
    Element Should Contain    ${customer_paid_field}    ${amount}
        
Verify Entered Transaction ID
    ${reference_id}    Generate Random String
    Click Element   ${upi_payment}
    Wait Until Page Contains Element    ${additional_mop_popup}    timeout=20s
    Wait Until Page Contains Element    ${enter_paytm_transaction_id}
    Input Text    ${transaction_reference_id}    ${reference_id}
    Sleep    1
    ${reference_id_text}  Get Value    ${transaction_reference_id}
    Should Be Equal As Strings    ${reference_id}     ${reference_id_text}
    Element Should Be Enabled    ${continue_payment_button}
    Click Button    ${continue_payment_button}
    Wait Until Page Contains Element   ${payment_complete_heading}  timeout=10s

Close The Transaction Popup
    Wait Until Page Contains Element    ${additional_mop_popup}    timeout=20s
    Page Should Contain Element    ${enter_paytm_transaction_id}
    Page Should Contain Element    ${customer_paid_field}
    Wait Until Keyword Succeeds    3    2     Click Button    ${close_button}
    Wait Until Page Does Not Contain Element     ${additional_mop_popup}

Verify Close (X) Button Of Transaction Id
    Page Should Not Contain Element    ${additional_mop_popup}
    Page Should Not Contain Element         ${enter_paytm_transaction_id} 
    Page Should Not Contain Element    ${continue_payment_button}
    Page Should Contain Element    ${checkout_heading}

Verify Customer Paid Field Is Non-editable
    Wait Until Page Contains Element    ${additional_mop_popup}    timeout=20s
    Page Should Contain Element    ${enter_paytm_transaction_id}
    Page Should Contain Element    ${customer_paid_field}
    Element Should Be Disabled    ${customer_paid_field}

Complete Payment Without Reference ID
    Click Element   ${upi_payment}
    Page Should Contain Element    ${enter_paytm_transaction_id}
    Page Should Contain Element    ${customer_paid_field}
    Page Should Contain Element    ${customer_paid_label}
    Element Should Be Enabled    ${continue_payment_button}
    Click Button    ${continue_payment_button}

Verify Unable To Pay Via On Account Sale With Less Account Balance
    Click Button    ${account_on_sale}
    Wait Until Page Contains Element    ${on_account_sale_heading}    timeout=10s
    ${amount}    Get Text    ${minimum_payment_required}
    ${alert}=    Replace String    ${less_account_balance_alert}    AMOUNT    ${amount}
    Element Should Be Visible    ${alert}