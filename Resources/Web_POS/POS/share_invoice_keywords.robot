*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../Resources/CustomKeywords/utilities.py
Variables    ../../../PageObjects/Web_POS/POS/hold_bill_locators.py
Variables   ../../../PageObjects/Web_POS/POS/checkout_locators.py
Variables   ../../../PageObjects/Web_POS/POS/pos_locators.py
Variables   ../../../PageObjects/Web_POS/POS/add_customer_locator.py
Resource    ../../AdminConsole/Login/login_keyword.robot
Variables   ../../../PageObjects/AdminConsole/ProductCategories/product_categories.py


*** Keywords ***
Verify Bill Remark Added Is Visible In Bill Remark Textarea
   [Arguments]    ${bill_remark}
   ${my_dict}    Create Dictionary   &{bill_remark}
   Wait Until Page Contains Element    ${checkout_billing_options}
   Click Element    ${checkout_billing_options}
   ${remark}  Run Keyword And Return Status    Element Should Be Visible    ${checkout_billing_add_bill_remark}
   IF    ${remark}
       Wait Until Page Contains Element    ${checkout_billing_add_bill_remark}
       Click Element    ${checkout_billing_add_bill_remark}
       Input Text    ${add_bill_remark_textarea}    ${my_dict.Remark}
   ELSE
        Click Element    ${checkout_billing_edit_remark}
        Input Text    ${add_bill_remark_textarea}    ${my_dict.Remark}
   END
   Page Should Contain Element    ${add_bill_remark_textarea}    ${my_dict.Remark}
   Element Should Be Enabled    ${add_bill_remark_save_button}
   Element Should Be Enabled    ${add_bill_remark_clear_button}

Verify The Clear Button Of Add Bill Remark
   [Arguments]    ${bill_remark}
   ${my_dict}    Create Dictionary   &{bill_remark}
   Wait Until Page Contains Element    ${checkout_billing_options}
   Click Element    ${checkout_billing_options}
   ${remark}  Run Keyword And Return Status    Element Should Be Visible    ${checkout_billing_add_bill_remark}
   IF    ${remark}
       Wait Until Page Contains Element    ${checkout_billing_add_bill_remark}
       Click Element    ${checkout_billing_add_bill_remark}
       Input Text    ${add_bill_remark_textarea}    ${my_dict.Remark}
   ELSE
        Click Element    ${checkout_billing_edit_remark}
        Input Text    ${add_bill_remark_textarea}    ${my_dict.Remark}
   END
   Page Should Contain Element    ${add_bill_remark_textarea}    ${my_dict.Remark}
   Element Should Be Enabled    ${add_bill_remark_save_button}
   Element Should Be Enabled    ${add_bill_remark_clear_button}
   Click Element    ${add_bill_remark_clear_button}
   Element Should Not Contain    ${add_bill_remark_textarea}    ${my_dict.Remark}

Verify Remark Is Auto-Populated When Click Outside of Add Remark Popup Window
    [Arguments]    ${bill_remark}
    ${my_dict}    Create Dictionary   &{bill_remark}
    Click Element At Coordinates    ${add_bill_remark_save_button}    ${150}    ${120}
    Capture Page Screenshot
    Wait Until Page Contains Element    ${checkout_billing_options}
    Click Element    ${checkout_billing_options}
    Wait Until Page Contains Element    ${checkout_billing_add_bill_remark}
    Click Element    ${checkout_billing_add_bill_remark}
    Page Should Contain Element    ${add_bill_remark_textarea}    ${my_dict.Remark}

Verify Remark Is Auto-Populated When Click On Close Icon of Add Remark Popup Window
   [Arguments]    ${bill_remark}
   ${my_dict}    Create Dictionary   &{bill_remark}
   Click Element    ${add_bill_remark_close_icon}
   Wait Until Page Contains Element    ${checkout_billing_options}
   Click Element    ${checkout_billing_options}
   Wait Until Page Contains Element    ${checkout_billing_add_bill_remark}
   Click Element    ${checkout_billing_add_bill_remark}
   Page Should Contain Element    ${add_bill_remark_textarea}    ${my_dict.Remark}

Verify The Print Invoice Button
   Element Should Be Enabled    ${print_invoice_button}
   Wait Until Page Contains Element    ${invoice_modal_heading}
   Element Should Be Enabled    ${print_invoice_modal_button}
   Element Should Be Enabled    ${close_invoice_modal_button}

Verify The Close Invoice Button
   Wait Until Page Contains Element    ${close_invoice_modal_button}  timeout=10s
   Click Element    ${close_invoice_modal_button}
   Wait Until Page Contains Element    ${payment_complete_heading}  timeout=10s
   Page Should Contain Element    ${payment_complete_heading}
   Page Should Contain Element    ${new_bill_button }
   
Verify The Print Button | Print Invoice
   Element Should Be Enabled    ${print_invoice_modal_button}
   Click Element    ${print_invoice_modal_button}
   Wait Until Page Contains Element    ${bill_container}
   Click Element    ${close_invoice_modal_button}
   Close Browser

Verify The Share Invoice Button
   Click Element    ${close_invoice_modal_button}
   Element Should Be Enabled    ${share_invoice_button}
   Click Element    ${share_invoice_button}
   Wait Until Page Contains Element    ${share_invoice_title}
   Page Should Contain Element    ${sms_tab_share_invoice}
   Page Should Contain Element    ${email_tab_share_invoice}
   Page Should Contain Element    ${send_button_share_invoice}

Verify The Close Icon | Share Invoice
   Wait Until Page Contains Element    ${share_invoice_title}
   Click Element    ${close_icon_share_invoice}
   Wait Until Page Contains Element    ${payment_complete_heading}
   Page Should Contain Element    ${payment_complete_heading}

