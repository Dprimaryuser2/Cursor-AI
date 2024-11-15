*** Settings ***
Library    SeleniumLibrary
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../../Resources/CustomKeywords/utilities.py
Variables   ../../../../PageObjects/Web_POS/POS/pos_locators.py
Variables    ../../../../PageObjects/Web_POS/POS/add_customer_locator.py
Variables    ../../../../PageObjects/Web_POS/POS/checkout_locators.py
Variables    ../../../../PageObjects/Web_POS/POS/order_locators.py
Variables    ../../../../PageObjects/Web_POS/Login/login_locators.py
Resource    ../../../../Resources/Web_POS/POS/Billing/add_to_cart_keyword.robot
Variables   ../../../../Environment/environment.py
Library    ../../../Resources/CustomKeywords/utilities.py
Variables   ../../../../PageObjects/Web_POS/POS/return_locators.py

*** Keywords ***
Refund By UPI
      Wait Until Element Is Visible    ${return_page_heading}   timeout=10s
      Wait Until Element Is Enabled    ${upi_payment}
      Wait Until Element Is Enabled    ${upi_payment}
      Click Element   ${upi_payment}
      Wait Until Element Is Visible    ${continue_cash_popup_button_return}
      Wait Until Element Is Enabled    ${continue_cash_popup_button_return}
      Click Element    ${continue_cash_popup_button_return}
    
Verify Refund By MOP
    [Arguments]     ${payment_method}
    Wait Until Element Is Visible    ${return_successful_page}  timeout=10
    Wait Until Element Is Enabled    ${print_invoice_button_return}
    Element Should Be Enabled    ${invoice_options_button_return}
    Element Should Be Enabled    ${new_bill_button_return}
    Element Should Be Enabled    ${print_invoice_button_return}
    Element Should Be Enabled    ${share_invoice_button_return}

Refund By Redeem Voucher
      Wait Until Element Is Visible    ${return_page_heading}   timeout=10s
      Wait Until Element Is Enabled    ${redeem_voucher_return}
      Click Element   ${redeem_voucher_return}
      Wait Until Element Is Visible    ${continue_cash_popup_button_return}
      Wait Until Element Is Enabled    ${continue_cash_popup_button_return}
      Click Element    ${continue_cash_popup_button_return}

Refund By Paytm Card
      Wait Until Element Is Visible    ${return_page_heading}   timeout=10s
      Wait Until Element Is Enabled    ${paytm_card_button_return}
      Wait Until Element Is Enabled    ${paytm_card_button_return}
      Click Element   ${paytm_card_button_return}
      Wait Until Element Is Visible    ${continue_cash_popup_button_return}
      Wait Until Element Is Enabled    ${continue_cash_popup_button_return}
      Click Element    ${continue_cash_popup_button_return}

Automatic Invoice Generation | Return
   Wait Until Page Contains Element    ${return_successful_page}    timeout=10
   ${cust_info_checkout}   Get Customer Details | Checkout | Return
   Click Element    ${print_invoice_button_return}
   Wait Until Page Contains Element    ${invoice_modal_heading}
   [Return]  ${cust_info_checkout}

Get Customer Details | Checkout | Return
    ${invoice_ids}    Create List
    Wait Until Page Contains Element    ${return_successful_page}
    ${in_id}  Get Text    ${invoice_number_checkout}
    ${in_name}  Get Text    ${invoice_customer_name}
    ${in_number}  Get Text    ${invoice_customer_phone}
    ${in_amount}  Get Text    ${total_amount_checkout}
    ${cust_info_checkout}=  Create Dictionary    invoice_id=${in_id}  invoice_name=${in_name}  phone_number=${in_number}  total_amount=${in_amount}    search_invoice=${in_id}
    Append To List    ${invoice_ids}    ${in_id}
    Set Global Variable    ${invoice_ids}
    [RETURN]   ${cust_info_checkout}

Verify The Close Invoice Button | Return
   Wait Until Page Contains Element    ${close_invoice_modal_button}  timeout=10s
   Click Element    ${close_invoice_modal_button}
   Wait Until Page Contains Element    ${return_successful_page}  timeout=10s
   Page Should Contain Element    ${return_successful_page}
   Page Should Contain Element    ${new_bill_button }

Verify The Close Icon | Share Invoice | Return
   Wait Until Page Contains Element    ${share_invoice_title}
   Click Element    ${close_icon_share_invoice}
   Wait Until Page Contains Element    ${return_successful_page}
   Page Should Contain Element    ${return_successful_page}

Verify New Bill Button | Return
   Wait Until Page Contains Element    ${print_invoice_modal_button}  timeout=20s
   Click Element    ${close_invoice_modal_button}
   Wait Until Page Contains Element    ${new_bill_button}   timeout=20s
   Click Element    ${new_bill_button}
   Wait Until Page Contains Element    ${return_option_switch}  timeout=20s
   Page Should Contain Element    ${return_option_switch}
   Page Should Contain Element    ${view_catalog_button}

Verify Return Checkout
    ${discard}=    Run Keyword And Return Status    Element Should Be Visible       ${discard_button}
    ${discard}=    Run Keyword And Return Status    Element Should Be Visible       ${discard_button}
    IF    ${discard}
         Click Button    ${discard_button}
         Click Button    ${discard_button}
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
        Wait Until Element Is Enabled    ${checkout_heading_return}    timeout=20s
        Click Button    ${checkout_heading_return}
    END
    ${insufficient}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${insufficient_inventory_continue_btn}    timeout=20s
    IF    ${insufficient}
     Set Fulfillment Date And Continue
    END
    Wait Until Element Is Visible    ${checkout_heading_return}    timeout=20s
    Page Should Contain Element    ${checkout_heading_return}
    Sleep    1s
    ${feedback}    Run Keyword And Return Status    Element Should Be Visible    //label[text()="Customer Feedback "]
    IF    ${feedback}
        ${text}    Generate Random Name
        Input Text    //label[text()="Customer Feedback "]//following-sibling::div/input    ${text}
        Click Button    //span[text()="Save"]//ancestor::button
    END
