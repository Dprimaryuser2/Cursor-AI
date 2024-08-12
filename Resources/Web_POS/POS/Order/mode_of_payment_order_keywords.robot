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
Verify If Payment Is Complete Or Not | Order
    Wait Until Element Is Visible     ${order_summary_page_heading}   timeout=10s
    Page Should Contain Element    ${order_summary_page_heading}
    Wait Until Element Is Visible    ${confirm_order_button}    timeout=10
    Page Should Contain Element    ${confirm_order_button}
    Page Should Contain Element    ${print_order_receipt}
    Wait Until Element Is Visible    ${credit_note_reserved}    timeout=10
    Page Should Contain Element    ${credit_note_reserved}
#    Page Should Contain Element    ${amount_paid_order_summary}
    Page Should Contain Element    ${total_amount_order_summary}

Verify Successful Payment | Order
    [Arguments]    ${cash_value}    ${customer_details}
    ${customer_details_dict}    Create Dictionary    &{customer_details}
    ${customer_name}    Catenate    ${customer_details_dict.first_name}    ${customer_details_dict.last_name}
    ${customer_name_at_invoice_page}    Get Text    ${customer_name_order_summary}
    Should Be Equal As Strings    ${customer_name_at_invoice_page}      ${customer_name}
    ${customer_phone_number}=    Get Text    ${contact_number_order_summary}
    ${customer_phone_number}    Convert To Number    ${customer_phone_number}
    ${entered_customer_phone_number}    Convert To Number    ${customer_details_dict.phone_number}
    Should Be Equal As Integers        ${customer_phone_number}    ${entered_customer_phone_number}
    ${payable_amount}=    Get Text    ${total_amount_order_summary}
    ${payable_amount}     Remove Characters    ${payable_amount}
    ${payable_amount}    Convert To Number    ${payable_amount}
    ${customer_paid_amount}    Get Text    ${amount_paid_order_summary}
    ${customer_paid_amount}    Remove Characters    ${customer_paid_amount}
    ${customer_paid_amount}    Convert To Number    ${customer_paid_amount}
    Should Be Equal As Integers    ${customer_paid_amount}    ${payable_amount}
    ${amount_paid_via_mop}    Get Text    ${credit_note_reserved_amount}
    ${amount_paid_via_mop}    Remove Characters    ${amount_paid_via_mop}
    ${amount_paid_via_mop}    Convert To Number    ${amount_paid_via_mop}
    Should Be Equal As Integers    ${amount_paid_via_mop}    ${payable_amount}

Verify Partial Redemption Allowed | Order
    Page Should Not Contain Element    ${full_redemption_popup}
    Page Should Not Contain Element    ${cancel_redeem_lapse_button}
    Wait Until Page Contains Element   ${order_summary_page_heading}  timeout=10s
    Page Should Contain Element     ${order_summary_page_heading}
    Page Should Contain Element     ${confirm_order_button}
    Page Should Contain Element     ${print_order_receipt}

Verify If Partial Payment Is Complete Or Not | Checkout Page
    Wait Until Element Is Visible     ${confirm_order_button}   timeout=10s
    Page Should Contain Element    ${order_summary_page_heading}
    Page Should Contain Element    ${confirm_order_button}
    Page Should Contain Element    ${print_order_receipt}
    Page Should Contain Element    ${credit_note_reserved}
    Page Should Contain Element    ${amount_paid_order_summary}
    Page Should Contain Element    ${total_amount_order_summary}

Verify Entered Transaction ID | Order
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
    Wait Until Page Contains Element   ${order_summary_page_heading}  timeout=10s
