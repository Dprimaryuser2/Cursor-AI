*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../../Resources/CustomKeywords/utilities.py
Variables    ../../../../PageObjects/Web_POS/POS/pos_locators.py
Variables    ../../../../PageObjects/Web_POS/POS/add_customer_locator.py
Variables    ../../../../PageObjects/Web_POS/POS/checkout_locators.py

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
    Add DOB    ${my_dict.dob}
    IF    '${my_dict.tax_invoice}' == 'New GST'
       Add GST Name And Number   ${my_dict}
    ELSE IF    '${my_dict.tax_invoice}' == 'New UIN'
       Add UIN Name And Number    ${my_dict}
    ELSE IF    '${my_dict.tax_invoice}' == 'Delete GST'
       Delete GST   ${customer_data}
    ELSE IF    '${my_dict.tax_invoice}' == 'Delete UIN'
       Delete UIN   ${customer_data}
    END
    Sleep    1
    ${add_line1}=    Generate Random Street Address
    Input Text    ${address_line1}    ${add_line1}
    ${add_line2}=    Generate Random Street Address
    Input Text    ${address_line2}    ${add_line2}
    Select State And City    ${my_dict}
    Sleep    1
    Wait Until Element Is Enabled    ${start_billing_button}    timeout=10s
    Click Button    ${start_billing_button}
    Wait Until Element Is Visible    //div[@class="popup-notification"]    timeout=10s
    Wait Until Element Is Visible    ${payable_amount}
    Wait Until Element Is Visible    ${checkout_button}    timeout=10s
    Wait Until Element Is Visible    ${customer_info_icon}    timeout=10s
    Wait Until Element Is Not Visible    //div[@class="popup-notification"]     timeout=10s
#    Wait Until Element Is Visible    //div[contains(text(),"Customer tagged successfully.")]
     ${customer_information}=    Create Dictionary    first_name=${first_name}    last_name=${last_name}    phone_number= ${mobile}    email=${email_tag}    gender=${gender}    add_line_one= ${add_line1}    add_line_two= ${add_line2}    customer_phone_number=${mobile}
    [Return]    ${customer_information}

Tag Customer And Enter Invalid GST Number
    [Arguments]    ${customer_data}
    ${my_dict}    Create Dictionary   &{customer_data}
    Log    ${my_dict}
    Click Element    ${add_customer_link}
    Wait Until Element Is Visible    ${customer_phone_field}    timeout=10s
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

    Wait Until Page Contains Element    ${tax_invoice}    timeout=10s
    Click Element    ${tax_invoice}
    Wait Until Page Contains Element    ${cg_add_gst_button}    timeout=10s
    Click Element    ${cg_add_gst_button}
    Wait Until Page Contains Element    ${cg_manage_gstin_header}    timeout=10s
    Wait Until Element Is Enabled    ${add_new_gstin_link}    timeout=10s
    Click Element    ${add_new_gstin_link}
    Wait Until Page Contains Element    ${add_gstin_window_header}    timeout=10s
     Wait Until Element Is Enabled    ${gst_radio}    timeout=10s
    Click Element    ${gst_radio}
    Wait Until Page Contains Element    ${enter_legal_name}    timeout=10s
    Input Text    ${enter_legal_name}    ${my_dict.legal_name}
    Wait Until Page Contains Element    ${enter_15digit_gstin}    timeout=10s
    Input Text    ${enter_15digit_gstin}    ${my_dict.gst_number}
    Wait Until Element Is Enabled    ${save_gstin_button}    timeout=10s
    Click Element    ${save_gstin_button}
    Page Should Contain Element  ${invalid_gst_warning_label}


Delete GST
    [Arguments]  ${details}
    ${gst_details}  Create Dictionary   &{details}
    Wait Until Page Contains Element    ${tax_invoice}    timeout=10s
    Click Element    ${tax_invoice}
    Wait Until Page Contains Element    ${cg_add_gst_button}    timeout=10s
    Click Element    ${cg_add_gst_button}
    Wait Until Page Contains Element    ${cg_manage_gstin_header}    timeout=10s
    Wait Until Page Contains Element    //label[contains(text(),"${gst_details.legal_name}")]//ancestor::div[@class="row py-2 mb-2"]//child::div[@class="text-right col"]//*[name()='img']
    Click Element    //label[contains(text(),"${gst_details.legal_name}")]//ancestor::div[@class="row py-2 mb-2"]//child::div[@class="text-right col"]//*[name()='img']
    Wait Until Element Is Enabled    ${confirm_selected_button}    timeout=10s
    Click Element    ${confirm_selected_button}


Delete UIN
    [Arguments]  ${details}
    ${uin_details}  Create Dictionary   &{details}
    Wait Until Page Contains Element    ${tax_invoice}    timeout=10s
    Click Element    ${tax_invoice}
    Wait Until Page Contains Element    ${cg_add_gst_button}    timeout=10s
    Click Element    ${cg_add_gst_button}
    Wait Until Page Contains Element    ${cg_manage_gstin_header}    timeout=10s
    Wait Until Page Contains Element    //label[contains(text(),"${uin_details.legal_name}")]//ancestor::label//preceding-sibling::input[@class="custom-control-input"]
    Click Element    //label[contains(text(),"${uin_details.legal_name}")]//ancestor::label//preceding-sibling::input[@class="custom-control-input"]
    Wait Until Element Is Enabled    ${confirm_selected_button}    timeout=10s
    Click Element    ${confirm_selected_button}


Add Existing GST
    [Arguments]  ${details}
    ${gst_details}  Create Dictionary   &{details}
    Wait Until Page Contains Element    ${tax_invoice}    timeout=10s
    Click Element    ${tax_invoice}
    Wait Until Page Contains Element    ${cg_add_gst_button}    timeout=10s
    Click Element    ${cg_add_gst_button}
    Wait Until Page Contains Element    ${cg_manage_gstin_header}    timeout=10s
    Wait Until Page Contains Element    //label[contains(text(),"${gst_details.legal_name}")]//ancestor::label//preceding-sibling::input[@class="custom-control-input"]        timeout=10s
    Sleep    0.3
    Click Element    //label[contains(text(),"${gst_details.legal_name}")]//ancestor::label//preceding-sibling::input[@class="custom-control-input"]
    Wait Until Element Is Enabled    ${confirm_selected_button}    timeout=10s
    Click Element    ${confirm_selected_button}


Add Existing UIN
    [Arguments]  ${details}
    ${uin_details}  Create Dictionary   &{details}
    Wait Until Page Contains Element    ${tax_invoice}
    Click Element    ${tax_invoice}
    Wait Until Page Contains Element    ${cg_add_gst_button}    timeout=10s
    Click Element    ${cg_add_gst_button}
    Wait Until Page Contains Element    ${cg_manage_gstin_header}    timeout=10s
    Wait Until Page Contains Element    //label[contains(text(),"${uin_details.legal_name}")]//ancestor::label//preceding-sibling::input[@class="custom-control-input"]
    Sleep    0.3
    Click Element    //label[contains(text(),"${uin_details.legal_name}")]//ancestor::label//preceding-sibling::input[@class="custom-control-input"]
    Wait Until Element Is Enabled    ${confirm_selected_button}
    Click Element    ${confirm_selected_button}


Add UIN Name And Number
    [Arguments]  ${details}
    ${uin_details}  Create Dictionary   &{details}
    Sleep    0.5
    Wait Until Page Contains Element    ${tax_invoice}    timeout=10s
    Click Element    ${tax_invoice}
    Wait Until Page Contains Element    ${cg_add_gst_button}    timeout=10s
    Click Element    ${cg_add_gst_button}
    Sleep    0.5
    Wait Until Page Contains Element    ${cg_manage_gstin_header}    timeout=10s
    Wait Until Element Is Enabled    ${add_new_gstin_link}    timeout=10s
    Wait Until Page Contains Element    ${add_new_gstin_link}    timeout=10s
    Click Element    ${add_new_gstin_link}
    Sleep    0.5
    Wait Until Page Contains Element    ${add_gstin_window_header}    timeout=10s
    Wait Until Element Is Enabled    ${uin_radio}    timeout=10s
    Click Element    ${uin_radio}
    Wait Until Page Contains Element    ${enter_legal_name}    timeout=10s
    Input Text    ${enter_legal_name}    ${uin_details.legal_name}
    Wait Until Page Contains Element    ${enter_15digit_gstin}    timeout=10s
    Input Text    ${enter_15digit_gstin}    ${uin_details.uin_number}
    Wait Until Element Is Enabled    ${save_gstin_button}    timeout=10s
    Click Element    ${save_gstin_button}
    Wait Until Element Is Enabled    ${confirm_selected_button}    timeout=10s
    Click Element    ${confirm_selected_button}

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
    Sleep    0.5
    ${state}=    Replace String    ${state_option}     state    ${state_city_data.state}
    Click Element    ${state}
    Click Element    ${select_city}
    ${city}=    Replace String    ${city_option}    city    ${state_city_data.city}

Edit Customer Information
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
    
Verify Customer Untagging
    Click Element    ${customer_info_icon}
    Wait Until Element Is Visible    ${customer_info_window_title}    timeout=10s
    Wait Until Element Is Visible    ${customer_untag_button}    timeout=10s
    Click Element    ${customer_untag_button}
    Wait Until Page Contains Element    ${add_customer_link}    timeout=10s

Edit Customer Group
    [Arguments]    ${customer_info}
    ${customer_group_info}=    Create Dictionary    &{customer_info}
    Click Element    ${customer_info_icon}
    Wait Until Element Is Visible    ${customer_info_window_title}    timeout=10s
    Wait Until Element Is Visible    ${customer_edit_groups_button}    timeout=10s
    Click Element    ${customer_edit_groups_button}
    Wait Until Element Is Visible    ${assign_customer_group_heading}    timeout=10s
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
        [Arguments]    ${pos_data}
        Log    ${pos_data}
        ${my_dict}    Create Dictionary    &{pos_data}
        Wait Until Page Contains Element    ${customer_info_icon}    timeout=10s
        Click Element    ${customer_info_icon}
        Wait Until Page Contains Element    ${personal_info_phone_no}    timeout=10s
        Sleep    1
        ${phone}    Get Text    ${personal_info_phone_no}
        ${int_phone}     Convert To Integer    ${phone}
        Sleep    0.5
        Should Be Equal As Integers    ${int_phone}     ${my_dict.customer_phone_number}
        Wait Until Page Contains Element    ${close_customer_window}    timeout=10s
        Click Element    ${close_customer_window}
        Wait Until Page Does Not Contain Element    ${close_customer_window}    timeout=10s

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
    Wait Until Element Is Visible    ${customer_first_name_field}    timeout=10s
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
    Wait Until Element Is Visible    ${customer_first_name_field}    timeout=10s
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
    Sleep    0.5
    Wait Until Page Contains Element    ${pincode}
    Click Element    ${pincode}
    Input Text    ${pincode}    ${my_dict.pincode}
    Press Keys    ${pincode}    ENTER
    Wait Until Page Contains Element    ${start_billing_button}    timeout=10s
    Click Button    ${start_billing_button}
    Wait Until Element Is Visible    ${payable_amount}
    Wait Until Element Is Visible    ${checkout_button}    timeout=10s
    Sleep    0.5
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
        Convert To String    ${item}
        Convert To Upper Case    ${item}
        Convert To Upper Case    ${item}
        ${uppercase_string}   Evaluate    "${item}".upper()
        Sleep    0.5
        ${group}=    Replace String    //div[@class="d-flex"]//span[text()="REGULAR"]    REGULAR    ${uppercase_string}
        Wait Until Page Contains Element    ${group}
        
    END

Verify Customer Tagged With Tax Invoice GST Number
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${customer_info_icon}    timeout=10s
    Click Element    ${customer_info_icon}
    Wait Until Page Contains Element    ${customer_edit_info_button}    timeout=10s
    Click Element    ${customer_edit_info_button}
    Wait Until Page Contains Element    ${tax_invoice}    timeout=10s
    Sleep    0.5
    Click Element      ${tax_invoice}
    ${edit_gst_icon_not_available}    Run Keyword And Return Status    Page Should Not Contain Element    ${cg_edit_gstin_icon}
    IF  ${edit_gst_icon_not_available}
        Add GST Name And Number    ${my_dict}
    END
    Wait Until Page Contains Element    ${cg_edit_gstin_icon}    timeout=10s
    Click Element    ${cg_edit_gstin_icon}
    Wait Until Page Contains Element    ${gstin_number_in_row}    timeout=10s
    Page Should Contain Element    ${gstin_number_in_row}
    Sleep    0.5
    ${gstin_number}    Get Text    ${gstin_number_in_row}
    Should Be Equal    ${gstin_number}    ${my_dict.gst_number}

Verify Customer Tagged With Tax Invoice UIN Number
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${customer_info_icon}    timeout=10s
    Click Element    ${customer_info_icon}
    Wait Until Page Contains Element    ${customer_edit_info_button}    timeout=10s
    Click Element    ${customer_edit_info_button}
    Wait Until Page Contains Element    ${tax_invoice}    timeout=10s
    Sleep    0.5
    Click Element      ${tax_invoice}
    ${edit_gst_icon_not_available}    Run Keyword And Return Status    Page Should Not Contain Element    ${cg_edit_gstin_icon}
    IF  ${edit_gst_icon_not_available}
        Add UIN Name And Number    ${my_dict}
    END
    Wait Until Page Contains Element    ${cg_edit_gstin_icon}    timeout=10s
    Click Element    ${cg_edit_gstin_icon}
    Wait Until Page Contains Element    ${gstin_number_in_row}    timeout=10s
    Page Should Contain Element    ${gstin_number_in_row}
    ${gstin_number}    Get Text    ${gstin_number_in_row}
    Should Be Equal    ${gstin_number}    ${my_dict.uin_number}

Change Invoice Type From Sales To GST In Customer Information
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${customer_info_icon}    timeout=10s
    Click Element    ${customer_info_icon}
    Wait Until Element Is Enabled    ${customer_edit_info_button}    timeout=10s
    Click Element    ${customer_edit_info_button}
    Add GST Name And Number    ${my_dict}
    Wait Until Page Contains Element    ${pincode}
    Click Element    ${state_select}
    Sleep    0.5
    ${state}=    Replace String    ${state_option}     state    ${my_dict.state}
    Click Element    ${state}
    Click Element    ${select_city}
    ${city}=    Replace String    ${city_option}    city    ${my_dict.new_city}
    Sleep    1
    Input Text    ${pincode}    ${my_dict.pincode}
    Press Keys    ${pincode}    ENTER
    Wait Until Page Contains Element    ${customer_info_update_button}        timeout=10s
    Click Button    ${customer_info_update_button}

Change Invoice Type From Sales To UIN In Customer Information
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${customer_info_icon}    timeout=10s
    Click Element    ${customer_info_icon}
    Wait Until Element Is Enabled    ${customer_edit_info_button}    timeout=10s
    Click Element    ${customer_edit_info_button}
    Add UIN Name And Number    ${my_dict}
    Sleep    0.5
    ${add_line1}=    Generate Random Street Address
    Input Text    ${address_line1}    ${add_line1}
    ${add_line2}=    Generate Random Street Address
    Input Text    ${address_line2}    ${add_line2}
    Wait Until Page Contains Element    ${pincode}
    Select State And City    ${my_dict}
    Sleep    2
    Input Text    ${pincode}    ${my_dict.pincode}
    Press Keys    ${pincode}    ENTER
    Input Text    ${pincode}    ${my_dict.pincode}
    Wait Until Element Is Enabled    ${update_product_button}    timeout=10s
    Click Button    ${update_product_button}
    Wait Until Page Does Not Contain Element    ${update_product_button}   timeout=10s

Verify Change Invoice Type from sales to GST
    Wait Until Page Contains Element    ${customer_info_icon}    timeout=10s
    Click Element    ${customer_info_icon}
    Wait Until Element Is Enabled    ${customer_edit_info_button}    timeout=10s
    Click Element    ${customer_edit_info_button}
    Page Should Contain Element    ${cg_gstin_field}

Change Invoice Type from Tax Invoice to Sales Invoice
    Wait Until Page Contains Element    ${customer_info_icon}    timeout=10s
    Click Element    ${customer_info_icon}
    Wait Until Element Is Enabled    ${customer_edit_info_button}    timeout=10s
    Click Element    ${customer_edit_info_button}
    Sleep    0.5
    Wait Until Page Contains Element    ${sales_invoice}    timeout=10s
    Click Element    ${sales_invoice}
    Wait Until Element Is Enabled    ${customer_info_update_button}   timeout=10s
    Click Element    ${customer_info_update_button}
    Wait Until Page Contains Element    ${customer_tagged_popup}    timeout=10s
    Page Should Contain Element    ${customer_tagged_popup}

Change Tax Invoice Type
    [Arguments]    ${pos_data}
    ${gst_details}   Create Dictionary    &{pos_data}
    Sleep    1
    Discard Items If Present From Previous Session
    Wait Until Page Contains Element    ${customer_info_icon}    timeout=5s
    Click Element    ${customer_info_icon}
    Wait Until Page Contains Element    ${customer_edit_info_button}    timeout=5s
    Click Element    ${customer_edit_info_button}
    Sleep    0.3
    Wait Until Page Contains Element    ${tax_invoice}    timeout=5s
    Click Element    ${tax_invoice}
    ${add_gst_button_present}    Run Keyword And Return Status    Wait Until Page Contains Element     ${cg_add_gst_button}
    IF    ${add_gst_button_present}
        Wait Until Page Contains Element    ${cg_add_gst_button}    timeout=10s
        Click Element    ${cg_add_gst_button}
    ELSE
        Wait Until Page Contains Element    ${cg_edit_gstin_icon}    timeout=10s
        Click Element    ${cg_edit_gstin_icon}
    END
    Sleep    1
    Wait Until Page Contains Element    ${cg_manage_gstin_header}    timeout=5s
    Wait Until Page Contains Element    //label[contains(text(),"${gst_details.legal_name}")]//ancestor::label//preceding-sibling::input[@class="custom-control-input"]
    Click Element    //label[contains(text(),"${gst_details.legal_name}")]//ancestor::label//preceding-sibling::input[@class="custom-control-input"]
    Wait Until Element Is Enabled    ${confirm_selected_button}    timeout=5s
    Click Element    ${confirm_selected_button}
    Wait Until Page Does Not Contain Element    ${confirm_selected_button}    timeout=5s
    Sleep    0.5
    Wait Until Page Contains Element    ${pincode}
    Input Text    ${pincode}    ${gst_details.pincode}
    Press Keys    ${pincode}    ENTER
    Select State And City    ${gst_details}
    Sleep    2
    Wait Until Element Is Enabled    ${update_product_button}    timeout=10s
    Click Button    ${update_product_button}
    Wait Until Page Does Not Contain Element    ${update_product_button}   timeout=10s

Changing Phone Number Not Allowed In Customer Information
    Wait Until Page Contains Element    ${customer_info_icon}    timeout=5s
    Click Element    ${customer_info_icon}
    Wait Until Page Contains Element    ${customer_edit_info_button}    timeout=5s
    Click Element    ${customer_edit_info_button}
    Page Should Contain Element    ${disabled_phone_no_field}

Verify Only Ten Digits Number Is Entered
    Wait Until Page Contains Element    ${customer_info_icon}    timeout=5s
    Click Element    ${customer_info_icon}
    Wait Until Page Contains Element    ${personal_info_phone_no}    timeout=5s
    ${ph_no}    Get Text    ${personal_info_phone_no}
    ${len}    Get Length    ${ph_no}
    Should Be Equal As Integers    ${len}    10
   
Not Allowed Tagging Customer With Phone Number Less Than Ten Digits 
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary   &{pos_data}
    Log    ${my_dict}
    Click Element    ${add_customer_link}
    Wait Until Element Is Visible    ${customer_phone_field}
    ${mobile}=  Set Variable    987654
    Set Test Variable    ${mobile}
    Input Text    ${customer_phone_field}    ${mobile}
    Element Should Be Disabled    ${continue_billing_button}

Add Customer Details Invalid Phone Number
    [Arguments]    ${customer_data}
    ${my_dict}    Create Dictionary   &{customer_data}
    Click Element    ${add_customer_link}
    Wait Until Element Is Visible    ${customer_phone_field}
#    ${mobile}=     Generate Random Phone Number
#    Set Test Variable    ${mobile}
    Input Text    ${customer_phone_field}    ${my_dict.phone_number}
    Click Button    ${continue_billing_button}
    Wait Until Element Is Visible    ${customer_first_name_field}    timeout=10s
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
    Add Customer Group    ${my_dict}
    Select State And City    ${my_dict}
    Wait Until Element Is Enabled    ${start_billing_button}    timeout=10s
    Click Button    ${start_billing_button}
    Wait Until Element Is Visible    ${customer_tagged_popup}    timeout=10s
    Wait Until Element Is Visible    ${payable_amount}    timeout=10s
    Wait Until Element Is Visible    ${checkout_button}    timeout=10s
    Wait Until Element Is Visible    ${customer_info_icon}    timeout=10s
    Wait Until Element Is Not Visible    ${customer_tagged_popup}     timeout=10s
    ${customer_information}=    Create Dictionary    first_name=${first_name}    last_name=${last_name}    phone_number= ${my_dict.phone_number}    email=${email}    gender=${gender}    add_line_one= ${add_line1}    add_line_two= ${add_line2}
    [Return]    ${customer_information}

Verify Customer Phone Number Less Then 10 Digit
    Wait Until Page Contains Element    ${invalid_number_message}
    Page Should Contain Element    ${invalid_number_message}
    Page Should Contain Element    ${disabled_number_continue_button}

Verify Customer Phone Number More Then 10 Digit
    Wait Until Page Contains Element    ${continue_billing_button}
    Page Should Contain Element    ${continue_billing_button}
    ${Phone_number_digits}    Get Text    ${customer_phone_field}
    ${digits}    Get Length  ${Phone_number_digits}
    Should Be Equal As Integers    ${digits}    10

Remove Customer From All Groups
    Wait Until Page Contains Element    ${customer_info_icon}
    Click Element    ${customer_info_icon}
    Wait Until Element Is Enabled    ${customer_edit_groups_button}
    Click Element    ${customer_edit_groups_button}
    Wait Until Page Contains Element    ${customer_group_checkbox}
    ${customer_group_list}  Get WebElements    ${customer_group_checkbox_row}
    FOR    ${group}    IN    @{customer_group_list}
        Log    ${group}
        Unselect Checkbox    ${group}
    END
    Wait Until Element Is Enabled    ${save_button_customer_group}
    Click Element    ${save_button_customer_group}

Add Customer To All Groups
    Wait Until Page Contains Element    ${customer_info_icon}
    Click Element    ${customer_info_icon}
    Wait Until Element Is Enabled    ${customer_edit_groups_button}
    Click Element    ${customer_edit_groups_button}
    Wait Until Page Contains Element    ${customer_group_checkbox}
    ${customer_group_list}  Get WebElements    ${customer_group_checkbox_row}
    ${group_count}    Get Length    ${customer_group_list}
    FOR    ${group}    IN RANGE    1    ${group_count}
        Log    ${group}
        Sleep    0.5
         Select Checkbox    ${customer_group_list}[${group}]
    END
    Wait Until Element Is Enabled    ${save_button_customer_group}
    Click Element    ${save_button_customer_group}
    [Return]    ${group_count}

Verify Customer Removed From All Groups
    Wait Until Page Contains Element    ${group_assigned_name}    timeout=10s
    ${no_of_groups_assigned}    Get WebElements    ${group_assigned_name}
    ${group_count}   Get Length   ${no_of_groups_assigned}
    IF    ${group_count}==1
        ${group_name}  Get Text    ${group_assigned_name}
        Should Be Equal As Strings    ${group_name}    REGULAR
    END

Tag Existing Customer
    [Arguments]    ${customer_data}
    ${my_dict}    Create Dictionary   &{customer_data}
    Click Element    ${add_customer_link}
    Wait Until Element Is Visible    ${customer_phone_field}
    Input Text    ${customer_phone_field}    ${my_dict.customer_phone_number}
    Wait Until Element Is Enabled    ${continue_billing_button}
    Click Button    ${continue_billing_button}
    Wait Until Page Does Not Contain Element    ${continue_billing_button}    timeout=10s
    Wait Until Element Is Visible    ${customer_first_name_field}    timeout=10s
    Wait Until Element Is Enabled    ${start_billing_button}    timeout=10s
    Click Button    ${start_billing_button}
    Wait Until Page Contains Element    ${customer_tagged_popup}    timeout=10s
    Wait Until Page Does Not Contain Element     ${customer_tagged_popup}    timeout=10s

Discard Items If Present From Previous Session
    ${store_item_from_previous_session}    Run Keyword And Return Status    Page Should Contain Element    ${discard_item_previous_session}
    IF    ${store_item_from_previous_session}
        Wait Until Element Is Enabled    ${discard_item_previous_session}    timeout=10
         Click Element    ${discard_item_previous_session}
         Wait Until Page Does Not Contain Element    ${discard_item_previous_session}    timeout=10
    END

Verify Customer Added To All Groups
    [Arguments]     ${previous_group_count}
    Wait Until Page Contains Element    ${group_assigned_name}    timeout=10s
    Sleep    2
    ${no_of_groups_assigned}    Get WebElements    ${group_assigned_name}
    ${current_group_count}    Get Length    ${no_of_groups_assigned}
    Should Be Equal As Integers    ${current_group_count}    ${previous_group_count}

Add GST Name And Number
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

Verify Existing GST Added After Tagging Customer
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${customer_info_icon}    timeout=10s
    Click Element    ${customer_info_icon}
    Wait Until Page Contains Element    ${customer_edit_info_button}    timeout=10s
    Wait Until Element Is Enabled    ${customer_edit_info_button}
    Click Element    ${customer_edit_info_button}
    Add Existing GST    ${my_dict}
    
Verify Existing UIN Added After Tagging Customer
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${customer_info_icon}    timeout=10s
    Click Element    ${customer_info_icon}
    Wait Until Page Contains Element    ${customer_edit_info_button}    timeout=10s
    Wait Until Element Is Enabled    ${customer_edit_info_button}
    Click Element    ${customer_edit_info_button}
    Add Existing UIN    ${my_dict}
    
Verify GST Name Edited
    [Arguments]    ${pos_data}
    ${gst_details}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${customer_info_icon}    timeout=10s
    Click Element    ${customer_info_icon}
    Wait Until Page Contains Element  ${customer_edit_info_button}    timeout=10s
    Click Element    ${customer_edit_info_button}
    Sleep    0.5
    Wait Until Page Contains Element    ${tax_invoice}    timeout=10s
    Click Element    ${tax_invoice}
    ${add_gst_button_present}    Run Keyword And Return Status    Wait Until Page Contains Element     ${cg_add_gst_button}
    IF    ${add_gst_button_present}
        Wait Until Page Contains Element    ${cg_add_gst_button}    timeout=10s
        Click Element    ${cg_add_gst_button}
    ELSE
        Wait Until Page Contains Element    ${cg_edit_gstin_icon}    timeout=10s
        Click Element    ${cg_edit_gstin_icon}
    END
    Wait Until Page Contains Element    //label[contains(text(),"${gst_details.legal_name}")]//ancestor::div[@class="row py-2 mb-2"]//div[@class="col-md-4"]//div//div[@class="text-right col"]//*[name()='svg']
    Click Element    //label[contains(text(),"${gst_details.legal_name}")]//ancestor::div[@class="row py-2 mb-2"]//div[@class="col-md-4"]//div//div[@class="text-right col"]//*[name()='svg']
    Wait Until Page Contains Element    ${enter_legal_name}        timeout=10s
    Input Text    ${enter_legal_name}    ${gst_details.new_legal_name}
    Wait Until Element Is Enabled    ${save_gstin_button}    timeout=10s
    Click Element    ${save_gstin_button}
    Wait Until Page Does Not Contain Element    ${save_gstin_button}    timeout=10s
    Wait Until Page Contains Element    ${confirm_selected_button}    timeout=10s
    Click Element    ${confirm_selected_button}
    Wait Until Page Does Not Contain Element    ${confirm_selected_button}    timeout=10s
    Wait Until Page Contains Element    ${customer_info_update_button}  timeout=10s
    Click Element    ${customer_info_update_button}

Delete And Add Same GST Number Again So That Next Time Test Case Doesnt Fail
    [Arguments]    ${pos_data}
    ${gst_details}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${customer_info_icon}    timeout=10s
    Click Element    ${customer_info_icon}
    Wait Until Page Contains Element  ${customer_edit_info_button}    timeout=10s
    Click Element    ${customer_edit_info_button}
    Sleep    0.5
    Wait Until Page Contains Element    ${tax_invoice}    timeout=10s
    Click Element    ${tax_invoice}
    ${add_gst_button_present}    Run Keyword And Return Status    Wait Until Page Contains Element     ${cg_add_gst_button}
    IF    ${add_gst_button_present}
        Wait Until Page Contains Element    ${cg_add_gst_button}    timeout=10s
        Click Element    ${cg_add_gst_button}
    ELSE
        Wait Until Page Contains Element    ${cg_edit_gstin_icon}    timeout=10s
        Click Element    ${cg_edit_gstin_icon}
    END
    Sleep    2
    Wait Until Page Contains Element    //label[contains(text(),"${gst_details.legal_name}")]//ancestor::div[@class="row py-2 mb-2"]//div[@class="col-md-4"]//div//div[@class="text-right col"]//*[name()='img']        timeout=10s
    Click Element    //label[contains(text(),"${gst_details.legal_name}")]//ancestor::div[@class="row py-2 mb-2"]//div[@class="col-md-4"]//div//div[@class="text-right col"]//*[name()='img']
    Wait Until Page Does Not Contain Element    //label[contains(text(),"${gst_details.legal_name}")]//ancestor::div[@class="row py-2 mb-2"]//div[@class="col-md-4"]//div//div[@class="text-right col"]//*[name()='img']        timeout=10s
    Wait Until Page Contains Element    ${confirm_selected_button}    timeout=10s
    Click Element    ${confirm_selected_button}
    Wait Until Page Does Not Contain Element    ${confirm_selected_button}    timeout=10s
    Wait Until Page Contains Element    ${cg_edit_gstin_icon}
    Click Element    ${cg_edit_gstin_icon}
    Wait Until Page Does Not Contain Element    //label[contains(text(),"${gst_details.legal_name}")]//ancestor::div[@class="row py-2 mb-2"]//div[@class="col-md-4"]//div//div[@class="text-right col"]//*[name()='img']        timeout=10s
    Page Should Not Contain Element    //label[contains(text(),"${gst_details.legal_name}")]//ancestor::div[@class="row py-2 mb-2"]//div[@class="col-md-4"]//div//div[@class="text-right col"]//*[name()='img']
    Wait Until Page Contains Element    ${add_new_gstin_link}        timeout=10s
    Click Element    ${add_new_gstin_link}
    Wait Until Page Contains Element    ${gst_radio}        timeout=10s
    Click Element    ${gst_radio}
    Wait Until Page Contains Element    ${enter_legal_name}        timeout=10s
    Input Text    ${enter_legal_name}    ${gst_details.legal_name}
    Wait Until Page Contains Element    ${enter_15digit_gstin}
    Input Text     ${enter_15digit_gstin}    ${gst_details.gst_number}
    Wait Until Element Is Enabled    ${save_gstin_button}
    Click Element    ${save_gstin_button}
    Wait Until Page Does Not Contain Element    ${save_gstin_button}        timeout=10s
    Sleep    0.5
    Wait Until Page Contains Element    ${confirm_selected_button}    timeout=10s
    Click Element    ${confirm_selected_button}
    Wait Until Page Does Not Contain Element    ${confirm_selected_button}        timeout=10s
    Wait Until Page Contains Element    ${pincode}
    Select State And City    ${gst_details}
    Input Text    ${pincode}    ${gst_details.pincode}
    Press Keys    ${pincode}    ENTER
    Wait Until Page Contains Element    ${customer_info_update_button}        timeout=10s
    Click Element    ${customer_info_update_button}

Delete And Add Same UIN Number Again So That Next Time Test Case Doesnt Fail
    [Arguments]    ${pos_data}
    ${uin_details}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${customer_info_icon}    timeout=10s
    Click Element    ${customer_info_icon}
    Wait Until Page Contains Element  ${customer_edit_info_button}    timeout=10s
    Click Element    ${customer_edit_info_button}
    Sleep    0.5
    Wait Until Page Contains Element    ${tax_invoice}    timeout=10s
    Click Element    ${tax_invoice}
    ${add_gst_button_present}    Run Keyword And Return Status    Wait Until Page Contains Element     ${cg_add_gst_button}
    IF    ${add_gst_button_present}
        Wait Until Page Contains Element    ${cg_add_gst_button}    timeout=10s
        Click Element    ${cg_add_gst_button}
    ELSE
        Wait Until Page Contains Element    ${cg_edit_gstin_icon}    timeout=10s
        Click Element    ${cg_edit_gstin_icon}
    END
    Sleep    0.5
    Wait Until Page Contains Element    //div[@class="col" and contains(text(),"${uin_details.uin_number}")]//following::div//*[name()='img']      timeout=10s
    Click Element    //div[@class="col" and contains(text(),"${uin_details.uin_number}")]//following::div//*[name()='img']
    Wait Until Page Does Not Contain Element    //div[@class="col" and contains(text(),"${uin_details.uin_number}")]//following::div//*[name()='img']            timeout=10s
    Wait Until Page Contains Element    ${confirm_selected_button}    timeout=10s
    Click Element    ${confirm_selected_button}
    Wait Until Page Does Not Contain Element    ${confirm_selected_button}    timeout=10s
    Wait Until Page Contains Element    ${cg_edit_gstin_icon}
    Click Element    ${cg_edit_gstin_icon}
    Wait Until Page Does Not Contain Element    //div[@class="col" and contains(text(),"${uin_details.uin_number}")]//following::div//*[name()='img']        timeout=10s
    Page Should Not Contain Element    //div[@class="col" and contains(text(),"${uin_details.uin_number}")]//following::div//*[name()='img']
    Wait Until Page Contains Element    ${add_new_gstin_link}        timeout=10s
    Click Element    ${add_new_gstin_link}
    Wait Until Page Contains Element    ${uin_radio}        timeout=10s
    Click Element    ${uin_radio}
    Wait Until Page Contains Element    ${enter_legal_name}        timeout=10s
    Input Text    ${enter_legal_name}    ${uin_details.legal_name}
    Wait Until Page Contains Element    ${enter_15digit_gstin}
    Input Text     ${enter_15digit_gstin}    ${uin_details.gst_number}
    Wait Until Element Is Enabled    ${save_gstin_button}
    Click Element    ${save_gstin_button}
    Wait Until Page Does Not Contain Element    ${save_gstin_button}        timeout=10s
    Sleep    0.5
    Wait Until Page Contains Element    ${confirm_selected_button}        timeout=10s
    Click Element    ${confirm_selected_button}
    Wait Until Page Does Not Contain Element    ${confirm_selected_button}        timeout=10s
    Wait Until Page Contains Element    ${pincode}
    Select State And City    ${uin_details}
    Input Text    ${pincode}    ${uin_details.pincode}
    Press Keys    ${pincode}    ENTER
    Wait Until Page Contains Element    ${customer_info_update_button}        timeout=10s
    Click Element    ${customer_info_update_button}

Delete UIN
    [Arguments]  ${details}
    ${uin_details}  Create Dictionary   &{details}
    Wait Until Page Contains Element    ${tax_invoice}    timeout=10s
    Click Element    ${tax_invoice}
    Wait Until Page Contains Element    ${cg_add_gst_button}    timeout=10s
    Click Element    ${cg_add_gst_button}
    Wait Until Page Contains Element    ${cg_manage_gstin_header}    timeout=10s
    Wait Until Page Contains Element    //label[contains(text(),"${uin_details.legal_name}")]//ancestor::label//preceding-sibling::input[@class="custom-control-input"]
    Click Element    //label[contains(text(),"${uin_details.legal_name}")]//ancestor::label//preceding-sibling::input[@class="custom-control-input"]
    Wait Until Element Is Enabled    ${confirm_selected_button}    timeout=10s
    Click Element    ${confirm_selected_button}

Delete GST
    [Arguments]  ${details}
    ${gst_details}  Create Dictionary   &{details}
    Wait Until Page Contains Element    ${tax_invoice}    timeout=10s
    Click Element    ${tax_invoice}
    Wait Until Page Contains Element    ${cg_add_gst_button}    timeout=10s
    Click Element    ${cg_add_gst_button}
    Wait Until Page Contains Element    ${cg_manage_gstin_header}    timeout=10s
    Wait Until Page Contains Element    //label[contains(text(),"${gst_details.legal_name}")]//ancestor::div[@class="row py-2 mb-2"]//child::div[@class="text-right col"]//*[name()='img']
    Click Element    //label[contains(text(),"${gst_details.legal_name}")]//ancestor::div[@class="row py-2 mb-2"]//child::div[@class="text-right col"]//*[name()='img']
    Wait Until Element Is Enabled    ${confirm_selected_button}    timeout=10s
    Click Element    ${confirm_selected_button}

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