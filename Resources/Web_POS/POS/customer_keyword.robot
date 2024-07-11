*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../Resources/CustomKeywords/utilities.py
Variables    ../../../PageObjects/Web_POS/POS/pos_locators.py
Variables    ../../../PageObjects/Web_POS/POS/add_customer_locator.py
Variables    ../../../PageObjects/Web_POS/POS/checkout_locators.py

*** Keywords ***
Add Customer Details
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
    Add DOB    ${my_dict.dob}
    ${add_line1}=    Generate Random Street Address
    Input Text    ${address_line1}    ${add_line1}
    ${add_line2}=    Generate Random Street Address
    Input Text    ${address_line2}    ${add_line2}
#    Input Text    ${pincode}    ${my_dict.pincode}
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

Add DOB
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

Select State And City
    [Arguments]    ${state_city_data}
    Click Element    ${state_select}
    ${state}=    Replace String    ${state_option}     state    ${state_city_data.state}
    Click Element    ${state}
    Click Element    ${select_city}
    ${city}=    Replace String    ${city_option}    city    ${state_city_data.city}

Edit Customer Information
#    [Arguments]    ${customer_info}
#    ${customer_data}    Create Dictionary    &{customer_info}
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
    Wait Until Element Is Visible    ${customer_info_close_element}    timeout=10s
    Click Element    ${customer_info_close_element}
    Wait Until Element Is Visible    ${customer_info_icon}
    ${customer_info}    Create Dictionary    first_name=${first_name}    last_name=${last_name}    email=${email}    addresslinefirst=${addresslinefirst}    addresslinesecond=${addresslinesecond}
    RETURN    ${customer_info}

Verify Customer Untagging
    Click Element    ${customer_info_icon}
    Wait Until Element Is Visible    ${customer_info_window_title}    timeout=10s
    Wait Until Element Is Visible    ${customer_untag_button}    timeout=10s
    Click Element    ${customer_untag_button}
    Page Should Contain Element    ${add_customer_link}

Edit Customer Group
    [Arguments]    ${customer_info}
    ${customer_group_info}=    Create Dictionary    &{customer_info}
    Click Element    ${customer_info_icon}
    Wait Until Element Is Visible    ${customer_info_window_title}    timeout=10s
    Wait Until Element Is Visible    ${customer_edit_groups_button}    timeout=10s
    Click Element    ${customer_edit_groups_button}
    Wait Until Element Is Visible    //h5[@id="customer-group___BV_modal_title_"]    timeout=20s
    ${total_groups_tagged}=    Create List
    ${customer_groups}=    Set Variable    ${customer_group_info.group}
    ${customer_groups}=    Convert Items To List    ${customer_groups}
    ${length_of_list}=    Get Length    ${customer_groups}
    FOR    ${i}    IN RANGE    0    ${length_of_list}
        ${group_name}=    Replace String    ${customer_group_checkbox}    Dummy    ${customer_groups}[${i}]
        Wait Until Element Is Visible    ${group_name}    timeout=10s
        Click Element    ${group_name}
        Append To List      ${total_groups_tagged}       ${customer_groups}[${i}]
    END
    Wait Until Element Is Visible    ${save_button_customer_group}    timeout=10s
    Wait Until Keyword Succeeds    2     1    Click Element    ${save_button_customer_group}
    [Return]    ${total_groups_tagged}

Verify Customer Tagging
    [Arguments]    ${customer_info}
    Log    ${customer_info}
    ${customer_group_info}=    Create Dictionary    &{customer_info}
    ${customer_name}=    Get Text    ${tagged_customer_name}
    ${customer_phone_no}=    Get Text    ${tagged_customer_phone_no}
    ${customer_phone_no}=    Convert To Integer    ${customer_phone_no}
    Should Be Equal As Integers    ${customer_phone_no}    ${customer_group_info.phone_number}
    ${customer_full_name}=    Catenate    ${customer_group_info.first_name}    ${customer_group_info.last_name}
    Should Be Equal As Strings    ${customer_full_name}    ${customer_name}

Verify Customer Tagging Is Not Mandatory 
    Click Button    ${checkout_button}
    Page Should Not Contain Element    ${customer_tagging_mandatory_alert}
    Wait Until Element Is Visible      ${checkout_heading}    timeout=10s
    Page Should Contain Element    ${checkout_heading}
    Page Should Contain Element    ${checkout_payable_amount}

Verify Customer Tagging Is Mandatory
    Click Button    ${checkout_button}
    Wait Until Element Is Visible    ${customer_tagging_mandatory_alert}    timeout=15s
    Page Should Contain Element    ${customer_tagging_mandatory_alert}

Verify Customer Tagging Is Mandatory With Non Mandatory Information
    Click Element    ${add_customer_link}
    Wait Until Element Is Visible    ${customer_phone_field}
    ${mobile}=     Generate Random Phone Number
    Input Text    ${customer_phone_field}    ${mobile}
    Click Button    ${continue_billing_button}
    Wait Until Element Is Visible    ${customer_first_name_field}    timeout=20s
    Element Should Be Enabled    ${start_billing_button}
    Click Button    ${start_billing_button}
    Wait Until Element Is Visible    ${tagged_customer_phone_no}    timeout=10s
    ${customer_phone_no}=    Get Text    ${tagged_customer_phone_no}
    ${customer_phone_no}=    Convert To Integer    ${customer_phone_no}
    Should Be Equal As Integers    ${customer_phone_no}    ${mobile}
    Click Button    ${checkout_button}
    Wait Until Element Is Visible      ${checkout_heading}    timeout=10s
    Page Should Contain Element    ${checkout_heading}

Verify Customer Tagging Is Mandatory With All Fields
    [Arguments]    ${customer_data}
    ${my_dict}    Create Dictionary   &{customer_data}
    Click Button    ${checkout_button}
    Wait Until Element Is Visible    ${customer_tagging_mandatory_alert}    timeout=15s
    Page Should Contain Element    ${customer_tagging_mandatory_alert}
    Click Element    ${add_customer_link}
    Wait Until Element Is Visible    ${customer_phone_field}
    ${mobile}=     Generate Random Phone Number
    Input Text    ${customer_phone_field}    ${mobile}
    Click Button    ${continue_billing_button}
    Wait Until Element Is Visible    ${customer_first_name_field}    timeout=20s
    Element Should Be Disabled    ${start_billing_button}
    ${first_name}=    Generate Random First Name
    Set Test Variable    ${first_name}
    Input Text    ${customer_first_name_field}    ${first_name}
    ${last_name}=    Generate Random Last Name
    Set Test Variable    ${last_name}
    Input Text    ${customer_last_name_field}    ${last_name}
    ${email}=    Generate Random Email
    Input Text    ${customer_email_field}    ${email}
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
    Select State And City    ${my_dict}
    Wait Until Element Is Enabled    ${start_billing_button}    timeout=20s
    Click Button    ${start_billing_button}
    Wait Until Element Is Visible    ${payable_amount}
    Wait Until Element Is Visible    ${checkout_button}    timeout=20s
    Click Button    ${checkout_button}
    Wait Until Element Is Visible      ${checkout_heading}    timeout=10s
    Page Should Contain Element    ${checkout_heading}

Verify And Fetch Customer Information 
    [Arguments]    ${customer_info}
    ${customer_group_info}=    Create Dictionary    &{customer_info}
    Click Element    ${customer_info_icon}
    Wait Until Element Is Visible    ${customer_untag_button}    timeout=10s
    Page Should Contain Element    ${customer_info_window_title}
    ${email}=    Get Text    ${personal_info_email}
    ${customer_name}=    Get Text    ${personal_info_name}
    ${gender}=    Get Text    ${personal_info_gender}
    ${address}=    Get Text    ${personal_info_address}
    ${customer_phone_no}=    Get Text    ${personal_info_phone_no}
    ${customer_phone_no}=    Convert To Integer    ${customer_phone_no}
    Should Be Equal As Integers    ${customer_phone_no}    ${customer_group_info.phone_number}
    ${customer_full_name}=    Catenate    ${customer_group_info.first_name}    ${customer_group_info.last_name}
    Should Be Equal As Strings    ${customer_full_name}    ${customer_name}
    Should Be Equal As Strings    ${email}    ${customer_group_info.email}
    Should Be Equal As Strings    ${gender}    ${customer_group_info.gender}    ignore_case=True

Verify Edited Group
    [Arguments]    ${group_info}
    ${group_dict}=    Create List    @{group_info}
    ${length}=    Get Length    ${group_dict}
    FOR    ${i}    IN RANGE    0    ${length}
        ${item}=    Set Variable    ${group_dict}[${i}]
        ${group}=    Replace String    //div[@class="d-flex"]//span[text()="REGULAR"]    REGULAR    ${item}
        Page Should Contain Element    ${group}
    END

Add Customer Group
    [Arguments]    ${customer_info}
    ${customer_group_info}=    Create Dictionary    &{customer_info}
    Click Element    ${edit_groups_button}
    Wait Until Element Is Visible    //div[@id="customer-group___BV_modal_content_"]    timeout=20s
    ${total_groups_tagged}=    Create List
    ${customer_groups}=    Set Variable    ${customer_group_info.group}
    ${customer_groups}=    Convert Items To List    ${customer_groups}
    ${length_of_list}=    Get Length    ${customer_groups}
    FOR    ${i}    IN RANGE    0    ${length_of_list}
        ${group_name}=    Replace String    ${customer_group_checkbox}    Dummy    ${customer_groups}[${i}]
        Wait Until Element Is Visible    ${group_name}    timeout=10s
        Click Element    ${group_name}
        Append To List      ${total_groups_tagged}       ${customer_groups}[${i}]
    END
    Wait Until Element Is Visible    ${save_button_customer_group}    timeout=10s
    Wait Until Keyword Succeeds    2     1    Click Element    ${save_button_customer_group}
    Sleep    3s
    [Return]    ${total_groups_tagged}