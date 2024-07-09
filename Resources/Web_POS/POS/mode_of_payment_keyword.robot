*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../Resources/CustomKeywords/utilities.py
Variables    ../../../Environment/environment.py
Variables    ../../../PageObjects/Web_POS/Login/login_locators.py
Variables    ../../../PageObjects/Web_POS/POS/pos_locators.py
Variables    ../../../PageObjects/Web_POS/POS/add_customer_locator.py
Variables    ../../../PageObjects/Web_POS/POS/checkout_locators.py

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
        Click Element    ${input_voucher_code}
        Input Text    ${input_voucher_code}    ${details.voucher_code}
        Element Should Be Enabled    ${store_credit_continue_button}
        Click Element    ${store_credit_continue_button}
        Wait Until Page Contains Element    ${store_credit_validation_message}