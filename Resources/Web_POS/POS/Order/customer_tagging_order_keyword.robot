*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Resource   ../../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Library    ../../../../Resources/CustomKeywords/utilities.py
Library    utilities
Resource    ../../../../Resources/Web_POS/POS/Billing/split_payment_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/Billing/manual_discount_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/Exchange/exchange_keyword.robot
Variables   ../../../../PageObjects/Web_POS/POS/checkout_locators.py

*** Keywords ***
Add Customer Details | Order
    [Arguments]    ${customer_data}
    ${my_dict}    Create Dictionary   &{customer_data}
    Wait Until Element Is Enabled    ${add_customer_link}   timeout=40s
    Click Element    ${add_customer_link}
    Wait Until Element Is Visible    ${customer_phone_field}
    ${mobile}=     Generate Random Phone Number
    Set Test Variable    ${mobile}
    Input Text    ${customer_phone_field}    ${mobile}
    Click Button    ${continue_billing_button}
    Wait Until Element Is Visible    ${customer_first_name_field}    timeout=10s
    ${first_name}=    Generate Random First Name
    Set Test Variable    ${first_name}
    Input Text    ${customer_first_name_field}    ${first_name}
    ${last_name}=    Generate Random Last Name
    Set Test Variable    ${last_name}
    Input Text    ${customer_last_name_field}    ${last_name}
    ${email_tag}=    Generate Random Email
    Input Text    ${customer_email_field}    ${email_tag}
    Set Test Variable  ${email_tag}
    Click Element    ${gender_select_field}
    ${gender}=    Generate Random Gender
    IF    '${gender}' == 'male'
        Click Element    ${male}
    ELSE IF    '${gender}' == 'female'
        Click Element    ${female}
    END
    Add DOB | Order    ${my_dict.dob}
    Add Customer Group    ${my_dict}
    IF    '${my_dict.tax_invoice}' == 'New GST'
       Add GST Name And Number   ${my_dict}
    ELSE IF    '${my_dict.tax_invoice}' == 'New UIN'
       Add UIN Name And Number    ${my_dict}
    ELSE IF    '${my_dict.tax_invoice}' == 'Delete GST'
       Delete GST   ${customer_data}
    ELSE IF    '${my_dict.tax_invoice}' == 'Delete UIN'
       Delete UIN   ${customer_data}
    ELSE
       Log    Does Not Require Tax
    END
    Sleep    1
    ${add_line1}=    Generate Random Street Address
    Input Text    ${address_line1}    ${add_line1}
    ${add_line2}=    Generate Random Street Address
    Input Text    ${address_line2}    ${add_line2}
    Select State And City | Order    ${my_dict}
    Sleep    1
    Wait Until Element Is Enabled    ${start_billing_button}    timeout=10s
    Click Element    ${start_billing_button}
    Wait Until Element Is Visible    //div[@class="popup-notification"]    timeout=10s
    Wait Until Element Is Visible    ${payable_amount}
    Wait Until Element Is Visible    ${checkout_button}    timeout=10s
    Wait Until Element Is Visible    ${customer_info_icon}    timeout=10s
    Wait Until Element Is Not Visible    //div[@class="popup-notification"]     timeout=10s
    ${customer_information}=    Create Dictionary    first_name=${first_name}    last_name=${last_name}    phone_number= ${mobile}    email=${email_tag}    gender=${gender}    add_line_one= ${add_line1}    add_line_two= ${add_line2}    customer_phone_number=${mobile}
    [Return]    ${customer_information}

Add DOB | Order
    [Arguments]    ${dob_data}
    ${dob}=    Convert To String    ${dob_data}
    ${dob_dict}=    Get Dob Fields    ${dob}
    Click Element    ${dob_field}
    Click Element    ${day_month_field}
    ${year}=    Get From Dictionary    ${dob_dict}    year
    ${birth_year_available}=    Run Keyword And Return Status    Element Should Not Contain    ${month_year_field}    ${year}
    WHILE    ${birth_year_available}
        ${birth_year_available}=    Run Keyword And Return Status    Element Should Not Contain    ${month_year_field}    ${year}
        Click Element    ${prev_arrow}
    END
    ${dob_month}=    Get From Dictionary    ${dob_dict}    month
    ${month}=    Replace String    ${month_field}     month    ${dob_month}
    Click Element    ${month}
    ${dob_day}=    Get From Dictionary    ${dob_dict}    day
    ${dob_day}=    Convert To String    ${dob_day}
    ${day}=    Replace String    ${day_field}    day    ${dob_day}
    Click Element    ${day}

Select State And City | Order
    [Arguments]    ${state_city_data}
    Click Element    ${state_select}
    Sleep    0.5
    ${state}=    Replace String    ${state_option}     state    ${state_city_data.state}
    Click Element    ${state}
    Click Element    ${select_city}
    ${city}=    Replace String    ${city_option}    city    ${state_city_data.city}

Edit Customer Information | Order
    Click Element    ${customer_info_icon}
    Wait Until Element Is Visible    ${customer_info_window_title}    timeout=10s
    Wait Until Element Is Visible    ${customer_edit_info_button}    timeout=10s
    Click Element    ${customer_edit_info_button}
    Wait Until Element Is Visible    ${customer_phone_field}    timeout=10s
    ${first_name}=    Generate Random First Name
    Input Text     ${customer_first_name_field}    ${first_name}
    ${last_name}=    Generate Random Last Name
    Input Text    ${customer_last_name_field}    ${last_name}
    ${email}=    Generate Random Email
    Input Text    ${customer_email_field}    ${email}
    ${addresslinefirst}=     Generate Random Street Address
    Input Text    ${address_line1}    ${addresslinefirst}
    ${addresslinesecond}    Generate Random Street Address
    Input Text    ${address_line2}    ${addresslinesecond}
    Click Button    ${customer_info_update_button}
    Sleep    2
    Discard Items If Present From Previous Session
    Wait Until Element Is Visible    ${customer_info_close_element}    timeout=10s
    Click Element    ${customer_info_close_element}
    Wait Until Element Is Visible    ${customer_info_icon}    timeout=10s
    ${customer_info}    Create Dictionary    first_name=${first_name}    last_name=${last_name}    email=${email}    addresslinefirst=${addresslinefirst}    addresslinesecond=${addresslinesecond}    customer_phone_number=${mobile}
    RETURN    ${customer_info}

Add GST Name And Number | Order
    [Arguments]  ${details}
    ${gst_details}  Create Dictionary   &{details}
    Sleep    0.5
    Wait Until Page Contains Element    ${tax_invoice}    timeout=10s
    Click Element    ${tax_invoice}
    Wait Until Page Contains Element    ${cg_add_gst_button}    timeout=10s
    Click Element    ${cg_add_gst_button}
    Wait Until Page Contains Element    ${cg_manage_gstin_header}    timeout=10s
    Wait Until Element Is Enabled    ${add_new_gstin_link}    timeout=10s
    Wait Until Page Contains Element    ${add_new_gstin_link}
    Sleep    0.5
    Click Element    ${add_new_gstin_link}
    Sleep    0.5
    Wait Until Page Contains Element    ${add_gstin_window_header}    timeout=10s
     Wait Until Element Is Enabled    ${gst_radio}    timeout=10s
    Click Element    ${gst_radio}
    Wait Until Page Contains Element    ${enter_legal_name}    timeout=10s
    Input Text    ${enter_legal_name}    ${gst_details.legal_name}
    Wait Until Page Contains Element    ${enter_15digit_gstin}    timeout=10s
    Input Text    ${enter_15digit_gstin}    ${gst_details.gst_number}
    Wait Until Element Is Enabled    ${save_gstin_button}    timeout=10s
    Click Element    ${save_gstin_button}
    Wait Until Element Is Enabled    ${confirm_selected_button}    timeout=10s
    Click Element    ${confirm_selected_button}