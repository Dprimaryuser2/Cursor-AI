*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../../Resources/CustomKeywords/utilities.py
Variables    ../../../../PageObjects/Web_POS/POS/hold_bill_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/checkout_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/pos_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/add_customer_locator.py
Resource    ../../../AdminConsole/Login/login_keyword.robot
Variables   ../../../../PageObjects/AdminConsole/ProductCategories/product_categories.py
Resource    ../../../../Resources/Web_POS/POS/Billing/customer_keyword.robot

*** Variables ***
${IMAP_SERVER}        imap.gmail.com
${IMAP_PORT}          993
${USER}               dprimaryuser@gmail.com
${PASSWORD_EMAIL}           aqwb qaoi bkwd jqbb

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
   Wait Until Page Contains Element    ${print_invoice_modal_button}
   ${cust_name}  Get Text   ${name_invoice}
   Log    ${cust_name}
   Click Element    ${print_invoice_modal_button}

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

Navigate from email id tab to phone No. tab
   [Arguments]    ${share_invoice}
   ${my_dict}    Create Dictionary   &{share_invoice}
   Wait Until Page Contains Element    ${share_invoice_title}
   ${button_status}  Run Keyword And Return Status    Element Should Be Enabled    ${sms_tab_share_invoice}
   IF     ${button_status} 
       Click Element    ${email_tab_share_invoice}
       Wait Until Page Contains Element    ${cust_email_share_invoice}  timeout=10s
       Input Text    ${cust_email_share_invoice}    ${my_dict.cust_email}
       Wait Until Page Contains Element    ${send_button_share_invoice}  timeout=10s
       Element Should Be Enabled    ${send_button_share_invoice}
       Click Element    ${sms_tab_share_invoice}
   ELSE
       Click Element    ${sms_tab_share_invoice}
       Wait Until Page Contains Element    ${cust_number_share_invoice}  timeout=10s
       Input Text    ${cust_number_share_invoice}    ${my_dict.mobile}
       Wait Until Page Contains Element    ${send_button_share_invoice}  timeout=10s
       Element Should Be Enabled    ${send_button_share_invoice}
       Click Element    ${cust_email_share_invoice}
   END
    
Verify Customer Number Is Auto-Populated | Share Invoice
   Wait Until Page Contains Element    ${cust_number_share_invoice}  timeout=10s
   Page Should Contain Element     ${cust_number_share_invoice}   ${mobile}

Verify Customer Email Is Auto-Populated | Share Invoice
   [Arguments]    ${share_invoice}
   ${my_dict}    Create Dictionary   &{share_invoice}
   Click Element    ${email_tab_share_invoice}
   Wait Until Page Contains Element    ${cust_email_share_invoice}  timeout=10s
   Page Should Contain Element    ${cust_email_share_invoice}   ${my_dict.cust_email}

Update The Phone No. While Sharing The Invoice
   [Arguments]    ${share_invoice}
   ${my_dict}    Create Dictionary   &{share_invoice}
   Wait Until Page Contains Element    ${cust_number_share_invoice}  timeout=10s
   Clear Element Text    ${cust_number_share_invoice}
   Input Text    ${cust_number_share_invoice}    ${my_dict.mobile}
   Page Should Contain Element    ${cust_number_share_invoice}    ${my_dict.mobile}
   Element Should Be Enabled    ${send_button_share_invoice}
   
Verify Alert Message Is Displayed For Invalid Number | Share Invoice
   [Arguments]    ${share_invoice}
   ${my_dict}    Create Dictionary   &{share_invoice}
   Wait Until Page Contains Element    ${cust_number_share_invoice}  timeout=10s
   Clear Element Text    ${cust_number_share_invoice}
   Input Text    ${cust_number_share_invoice}    ${my_dict.mobile}
   Page Should Contain Element    ${cust_number_share_invoice}    ${my_dict.mobile}
   Wait Until Page Contains Element    ${share_invoice_alert_number}
   Element Should Be Visible     ${share_invoice_alert_number}
   
Update The Email While Sharing The Invoice
   [Arguments]    ${share_invoice}
   ${my_dict}    Create Dictionary   &{share_invoice}
   Click Element    ${email_tab_share_invoice}
   Wait Until Page Contains Element    ${cust_email_share_invoice}  timeout=10s
   Click Element    ${cust_email_share_invoice}
   Clear Element Text    ${cust_email_share_invoice}
   Input Text    ${cust_email_share_invoice}    ${my_dict.update_email}
   Page Should Contain Element    ${cust_email_share_invoice}    ${my_dict.update_email}
   Element Should Be Enabled    ${send_button_share_invoice}

Verify Alert Message Is Displayed For Invalid Email | Share Invoice
   [Arguments]    ${share_invoice}
   ${my_dict}    Create Dictionary   &{share_invoice}
   Click Element    ${email_tab_share_invoice}
   Wait Until Page Contains Element    ${cust_email_share_invoice}  timeout=10s
   Clear Element Text    ${cust_email_share_invoice}
   Input Text    ${cust_email_share_invoice}    ${my_dict.cust_email}
   Page Should Contain Element    ${cust_email_share_invoice}    ${my_dict.cust_email}
   Wait Until Page Contains Element    ${share_invoice_alert_email}
   Element Should Be Visible   ${share_invoice_alert_email}

Add Customer Details | Share Invoice
    [Arguments]    ${customer_data}
    ${my_dict}    Create Dictionary   &{customer_data}
    Wait Until Element Is Enabled    ${add_customer_link}   timeout=40s
    Click Element    ${add_customer_link}
    Wait Until Element Is Visible    ${customer_phone_field}
    ${mobile}=     Generate Random Phone Number
    Set Test Variable    ${mobile}
    Input Text    ${customer_phone_field}    ${mobile}
    Click Button    ${continue_billing_button}
    Wait Until Element Is Visible    ${customer_first_name_field}    timeout=20s
    ${first_name}=    Generate Random First Name
    Set Test Variable    ${first_name}
    Input Text    ${customer_first_name_field}    ${first_name}
    ${last_name}=    Generate Random Last Name
    Set Test Variable    ${last_name}
    Input Text    ${customer_last_name_field}    ${last_name}
    Input Text    ${customer_email_field}    ${my_dict.cust_email}
    Click Element    ${gender_select_field}
    ${gender}=    Generate Random Gender
    IF    '${gender}' == 'male'
        Click Element    ${male}
    ELSE IF    '${gender}' == 'female'
        Click Element    ${female}
    END
    Add DOB    ${my_dict.dob}
    ${add_line1}=    Generate Random Street Address
    Input Text    ${address_line1}    ${add_line1}
    ${add_line2}=    Generate Random Street Address
    Input Text    ${address_line2}    ${add_line2}
    Add Customer Group    ${my_dict}
    Select State And City    ${my_dict}
    Wait Until Element Is Enabled    ${start_billing_button}    timeout=20s
    Click Button    ${start_billing_button}
    Wait Until Element Is Visible    //div[@class="popup-notification"]    timeout=10s
    Wait Until Element Is Visible    ${payable_amount}
    Wait Until Element Is Visible    ${checkout_button}    timeout=20s
    Wait Until Element Is Visible    ${customer_info_icon}    timeout=20s
    Wait Until Element Is Not Visible    //div[@class="popup-notification"]     timeout=10s
     ${customer_information}=    Create Dictionary    first_name=${first_name}    last_name=${last_name}    phone_number= ${mobile}    email=${email}    gender=${gender}    add_line_one= ${add_line1}    add_line_two= ${add_line2}    mobile_no=${mobile}
     [Return]    ${customer_information}

Verify New Bill Button
   Wait Until Page Contains Element    ${print_invoice_modal_button}  timeout=20s
   Click Element    ${close_invoice_modal_button}
   Wait Until Page Contains Element    ${new_bill_button}   timeout=20s
   Click Element    ${new_bill_button}
   Wait Until Page Contains Element    ${in_store}  timeout=20s
   Page Should Contain Element    ${in_store}
   Page Should Contain Element    ${delivery}

Send Invoice To Email | Share Invoice
   Wait Until Page Contains Element    ${send_button_share_invoice}
   Click Element    ${send_button_share_invoice}
   Wait Until Page Contains Element   ${email_send_registered_mail_msg}
   Page Should Contain Element     ${email_send_registered_mail_msg}
   Element Should Be Enabled    ${dismiss_button_share_invoice}

Verify Invoice Generated Received On Email
    [Arguments]    ${store_name}    ${cust_info_checkout}
    ${subject} =  Set Variable  Your ${store_name} Invoice Receipt | ${cust_info_checkout.invoice_id}
    ${email_body}=  Search And Fetch Email    ${IMAP_SERVER}    ${IMAP_PORT}    ${USER}    ${PASSWORD_EMAIL}    ${subject}
    Run Keyword If  ${email_body} is not None  Log  Email with subject contains "${subject}" is received
    ...  ELSE  Log  Email with subject contains "${subject}" is not found
    [Return]  ${email_body}

Initialize Invoice List
    ${invoice_ids}=  Create List
    Set Global Variable    ${invoice_ids}

Get Customer Details | Checkout
    ${invoice_ids}    Create List
    Wait Until Page Contains Element    ${payment_complete_heading}
    ${in_id}  Get Text    ${invoice_number_checkout}
    ${in_name}  Get Text    ${invoice_customer_name}
    ${in_number}  Get Text    ${invoice_customer_phone}
    ${in_amount}  Get Text    ${total_amount_checkout}
    ${cust_info_checkout}=  Create Dictionary    invoice_id=${in_id}  invoice_name=${in_name}  phone_number=${in_number}  total_amount=${in_amount}    search_invoice=${in_id}
    Append To List    ${invoice_ids}    ${in_id}
    Set Global Variable    ${invoice_ids}
    [RETURN]   ${cust_info_checkout}

Get Customer Details | Print Invoice
   Wait Until Page Contains Element    ${bill_container}
   ${inp_id}  Get Text    ${invoice_no}
   ${inp_name}  Get Text    ${name_invoice}
   ${inp_number}  Get Text    ${number_invoice}
   ${inp_amount}  Get Text    ${invoice_amount}
   ${cust_info_invoice}=  Create Dictionary    pinvoice_id=${inp_id}  pinvoice_name=${inp_name}  pphone_number=${inp_number}  ptotal_amount=${inp_amount}
   [RETURN]   ${cust_info_invoice}

Verify Customer Details | Print Invoice
   [Arguments]    ${cust_info_checkout}    ${cust_info_invoice}
   Should Be Equal   ${cust_info_checkout.invoice_id}   ${cust_info_invoice.pinvoice_id}
   Should Be Equal    ${cust_info_checkout.invoice_name}   ${cust_info_invoice.pinvoice_name}
   Should Be Equal    ${cust_info_checkout.phone_number}   ${cust_info_invoice.pphone_number}
   Should Be Equal   ${cust_info_checkout.total_amount}   ${cust_info_invoice.ptotal_amount}