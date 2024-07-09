*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../Resources/CustomKeywords/utilities.py
Variables    ../../../PageObjects/Web_POS/POS/hold_bill_locators.py
Variables   ../../../PageObjects/Web_POS/POS/checkout_locators.py
Variables   ../../../PageObjects/Web_POS/POS/pos_locators.py
Variables   ../../../PageObjects/Web_POS/POS/add_customer_locator.py

*** Keywords ***

Verify Split Payment Option Is Available If Policy Is Enabled
    Wait Until Page Contains Element    ${checkout_split_payment}   timeout=10s
    Page Should Contain Element    ${checkout_split_payment}

Verify Split Payment Policy Is Unavailable If Policy Is Disabled
    Sleep    0.2
    Page Should Not Contain Element    ${checkout_split_payment}

Payment By credit_card
    Wait Until Page Contains Element    ${payment_method_credit_card}   timeout=10s
    Page Should Contain Element    ${payment_method_credit_card}
    Click Element    ${payment_method_credit_card}

Payment By Cash More Then Payable Amount
    [Arguments]    ${cash_value}
    ${greater_amount} =  Evaluate    ${cash_value} + 500
    Clear Element Text    ${enter_split_amount}
    Sleep    0.5
    Input Text    ${enter_split_amount}    ${greater_amount}

Verify More Then Payable Amount Validation
    Wait Until Page Contains Element    ${greater_amount_popup}  timeout=10s
    Page Should Contain Element    ${greater_amount_popup}

Validate payable amount after every payment
    [Arguments]     ${amount}
    Page Should Contain    ${amount}

Get Account Balance
    ${account_balance}  Get Text    ${checkout_account_balance}
    [Return]    ${account_balance}

Verify Account Balance After Using Split Payment
    [Arguments]     ${value}    ${value1}
     ${amount}=    Replace String    ${value}    ,    ${EMPTY}
    Should Be Equal    ${amount}    ${value1}

Validate Account Balance Are Equal On Tagged Customer Split Payment
    Sleep    1s
    Wait Until Page Contains Element    ${customer_info_icon}   timeout=20s
    Click Element    ${customer_info_icon}
    Sleep    1s
    ${account_limit}    Get Text    ${available_on_account_limit}
    Click Element    ${close_customer_window}
#    Wait Until Element Is Enabled    ${checkout_button}
    [Return]    ${account_limit}

Verify Split By Single MOP
    Wait Until Page Contains Element    ${split_payment_popup}
    Page Should Contain Element    ${split_payment_popup}

Verify Mop summaryMOP's added after completing the payment
    Sleep    1.5
    Wait Until Page Contains Element    ${checkout_order_summary}
    Wait Until Page Contains Element    ${cash_order_summary}   timeout=10s
    Page Should Contain Element    ${cash_order_summary}
    Wait Until Page Contains Element    ${paytm_order_summary}   timeout=10s
    Page Should Contain Element    ${paytm_order_summary}

Enable Split payment mode
    Wait Until Page Contains Element    ${checkout_split_payment}   timeout=20s
    Sleep    0.5
    Click Element    ${checkout_split_payment}

Split Payment By Different Modes
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    ${items_list}=    Convert Items To List    ${my_dict.payment}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.payment}
    log     ${items_dict}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
    Run Keyword If    '${key}' == 'cash'    Split Payment By Cash    ${value}
        ...    ELSE IF    '${key}' == 'paytm'    Split Payment By Paytm    ${value}
         ...    ELSE IF    '${key}' == 'voucher'    Split Payment By Redeem Voucher
          ...    ELSE IF    '${key}' == 'on-account'    Payment By Account On Sales     ${value}
          ...    ELSE IF    '${key}' == 'voucher'    Split Payment By Redeem Voucher
           ...    ELSE IF    '${key}' == 'store-credit'    Collect Payment Using Store Credit   ${my_dict}
            ...    ELSE IF    '${key}' == 'card'    Payment By credit_card
    END


Split Payment By Cash
    Sleep    0.3
    [Arguments]    ${cash_value}
    Clear Element Text    ${enter_split_amount}
    Input Text    ${enter_split_amount}    ${cash_value}
    Click Element   ${payment_method_cash}
    Wait Until Page Contains Element   ${enter_cash}
    Input Text      ${enter_cash}   ${cash_value}
    Click Element    ${continue_cash_button}

Split Payment By Paytm
    [Arguments]    ${paytm_value}
    Sleep    1
    Wait Until Element Is Visible    ${enter_split_amount}  timeout=20s
    Clear Element Text    ${enter_split_amount}
    Input Text    ${enter_split_amount}    ${paytm_value}
    click Element   ${upi_payment}
    ${id}=  Generate Random Phone Number
    Wait Until Page Contains Element    ${enter_paytm_transaction_id}
    Input Text      ${enter_paytm_transaction_id}   ${id}
    Click Element    ${continue_paytm_button}

Split Payment By Redeem Voucher
    Sleep    0.3
    Click Element    ${redeem_voucher}
    ${id}=  Generate Random Phone Number
    Wait Until Page Contains Element    ${redeem_voucher_transactionId}
    Wait Until Page Contains Element    ${redeem_voucher_transactionId}
    Input Text    ${redeem_voucher_transactionId}    ${id}
    Click Element    ${voucher_continue_button}

Payment By Account On Sales
    Sleep    1
    [Arguments]     ${value}
    Wait Until Element Is Visible    ${enter_split_amount}
    Clear Element Text    ${enter_split_amount}
    Input Text    ${enter_split_amount}    ${value}
    Click Element   ${account_on_sale}
    ${id}=  Generate Random Street Address
    Wait Until Page Contains Element    ${remark_account_on_sale}
    Input Text      ${remark_account_on_sale}   ${id}
    Click Element    ${continue_account_on_sale_button}

Payment By Account On Sales For Validation Of Effective Balance
    Sleep    1
    [Arguments]     ${value}
    Wait Until Element Is Visible    ${enter_split_amount}
    Clear Element Text    ${enter_split_amount}
    Input Text    ${enter_split_amount}    ${value}
    Click Element   ${account_on_sale}
    ${id}=  Generate Random Street Address
    ${balance_after_sale_amount}   Get Text    ${balance_after_sale}
    Wait Until Page Contains Element    ${remark_account_on_sale}
    Input Text      ${remark_account_on_sale}   ${id}
    Click Element    ${continue_account_on_sale_button}
    [Return]    ${balance_after_sale_amount}

Collect Payment Using Store Credit
    [Arguments]    ${pos_dict}
    ${details}    Create Dictionary    &{pos_dict}
    Sleep    0.5
    Wait Until Page Contains Element    ${redeem_store_credit_button}   timeout=10s
    Click Element    ${redeem_store_credit_button}
    Wait Until Page Contains Element    ${redeem_with_dropdown}
    Click Element    ${redeem_with_dropdown}
    Click Element    ${redeem_with_credit_option}
    Wait Until Page Contains Element    ${input_voucher_code}
    Click Element    ${input_voucher_code}
    Input Text    ${input_voucher_code}    ${details.voucher_code}
#    Element Should Be Enabled    ${apply_store_credit_voucher}
    Wait Until Keyword Succeeds    4    2   Click Element    ${apply_store_credit_voucher}
#    Wait Until Page Contains Element    ${store_credit_validation_message}

Collect Payment Using Store Credit Using Phone Number
    [Arguments]    ${pos_dict}
    ${details}    Create Dictionary    &{pos_dict}
    Wait Until Page Contains Element    ${redeem_store_credit_button}
    Click Element    ${redeem_store_credit_button}
    Wait Until Page Contains Element    ${redeem_with_dropdown}
    Click Element    ${redeem_with_dropdown}
    Click Element    ${redeem_with_number_option}
    Sleep    0.5
    Input Text    ${phone_number_redeem_store_credit}    ${pos_dict.mobile}
    Wait Until Keyword Succeeds    4    2   Click Element    ${store_credit_continue_button}
