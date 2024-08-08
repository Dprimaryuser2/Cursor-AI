*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    ../../../Resources/CustomKeywords/utilities.py
Variables   ../../../PageObjects/AdminConsole/Promo/promo_locators.py
Variables   ../../../PageObjects/AdminConsole/Allocation/promotion_allocation.py
Variables    ../../../PageObjects/AdminConsole/Promo/conditions_locators.py
Variables    ../../../PageObjects/AdminConsole/Promo/new_definition_locators.py
Resource    ../../../Resources/AdminConsole/Allocation/allocation_keywords.robot
Resource    ../../../Resources/AdminConsole/Login/login_keyword.robot


*** Keywords ***
Go To Promo Page
    Click Element    ${promotions_icon}
    Wait Until Element Is Visible    ${promo}
    Click Element    ${promo}
    Wait Until Element Is Visible    ${new_definition}    timeout=20s
    Page Should Contain Element    ${new_definition}
    Page Should Contain Element    ${promo_list_table}
    ${php_debugger}=    Run Keyword And Return Status     Element Should Be Visible    ${php_close_button}
    Run Keyword If    ${php_debugger}     Click Element    ${php_close_button}

Check Promo Availability
    [Arguments]    ${promo_data}
    ${promotion_data}    Create Dictionary    &{promo_data}
    Input Text    ${search_field}    ${promotion_data.promo_name}
    Sleep    0.2s
    ${promo_available}    Run Keyword And Return Status    Element Should Contain     ${first_promo_name}    ${promotion_data.promo_name}
    IF    ${promo_available}
        log     promo already present
    ELSE
        Create New Definition | Promo    ${promo_data}
        Select Promotion Type    ${promo_data}
        Select Buy Specifications Condition    ${promo_data}
        Select Buy Assortment    ${promo_data}
        Select Benefit Type    ${promo_data}
        Select Discount Type   ${promo_data}
        Select Discount On    ${promo_data}
        Save Conditions
        Verify Summary Of Conditions
        Verify Saving Of The Promo
    END

Create New Definition | Promo
    [Arguments]     ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Click Button    ${new_definition}
    Wait Until Element Is Visible    ${definition_title}    timeout=20s
    Page Should Contain Element    ${condition_button}
    ${name}=    Set Variable    ${my_dict.promo_name}
    Set Test Variable    ${name}
    Input Text    ${definition_name}    ${name}
    ${applicability_text}=    Set Variable    ${my_dict.Applicability_Type}
    Set Test Variable    ${applicability_text}
    ${applicability}=    Replace String    ${applicability_type}    level      ${applicability_text}
    Click Element    ${applicability_label}
    Click Element    ${applicability}
    Wait Until Element Is Enabled    ${applicability}
    Input Text    ${description}    ${my_dict.description}

Select Promotion Type
    [Arguments]    ${promotion_data}
    ${promotion_type_data}    Create Dictionary    &{promotion_data}
    IF    '${promotion_type_data.promo_type}' == 'QSIMPLE'
        Double Click Element    ${simple_benifit}
    ELSE IF    '${promotion_type_data.promo_type}' == 'QSLAB'
        Double Click Element    ${qty_slab_benifit_checkbox}
    ELSE IF    '${promotion_type_data.promo_type}' == 'VSLAB'
        Double Click Element    ${value_slab_benifit_checkbox}
    END
    Click Element    ${condition_button}
    Wait Until Element Is Visible    ${condition_text}    timeout=10s

Select Buy Specifications Condition
    [Arguments]    ${condition_data}
    ${test_data}    Create Dictionary   &{condition_data}
    Wait Until Element Is Visible    ${condition_text}    timeout=20s
    Page Should Contain Element    ${condition_text}
    Page Should Contain Element    ${buy_specification_text}
    IF    '${test_data.conditions}' == 'Buy any _'
        Click Element    ${buy_any_option}
        Input Text    ${quantity}    ${test_data.buy_quantity}
    ELSE IF    '${test_data.conditions}' == 'Buy specific quantity in item ratio from Assortment'
        Click Element    ${ratio_assortment_option}
    ELSE IF    '${test_data.conditions}' == 'Buy anyquantity from assortment'
        Click Element    ${quantity_from_assortment_option}
    END

Select Buy Assortment
    [Arguments]    ${condition_data}
    ${test_data}    Create Dictionary   &{condition_data}
    ${condition_type}    Run Keyword And Return Status    Page Should Contain Element    ${ratio_field}
    ${items_list}=    Convert Items To List    ${test_data.buy_assortment}
    ${items_dict} =    Convert Item List To Dictionary    ${test_data.buy_assortment}
    IF    ${condition_type} == True
        FOR    ${i}    IN RANGE    1    ${test_data.buy_assortment_row}+1
            ${no}=    Evaluate    int(${i})-1
            ${no}=    Convert To String    ${no}
            ${keys}=    Evaluate    list($items_dict.keys())
            ${key}=    Set Variable    ${keys}[${no}]
            ${values}=    Evaluate    list($items_dict.values())
            ${value}=    Set Variable    ${values}[${no}]
            ${assortment_name}=    Set Variable    ${key}
            Set Test Variable    ${assortment_name}
            ${assortment_click}=    Set Variable    (//tr[@class="parent-box"]//div[@class="multiselect__tags"])[${i}]
            Click Element    ${assortment_click}
            Input Text    ${assortment_data_field}    ${assortment_name}
            Click Element    (//div[@class="modal-right-space mb-2 left-table"]//tbody)[${i}]//li[@class="multiselect__element"]
            ${ratio_field}=    Set Variable    (//tr[@class='parent-box']//input[@type='number'])[${i}]
            ${ratio}=    Set Variable    ${value}
            Input Text    ${ratio_field}   ${ratio}
            Run Keyword If    ${i} < ${test_data.buy_assortment_row}    Click Element    ${add_row}
        END
    ELSE
         FOR    ${i}    IN RANGE    1    ${test_data.buy_assortment_row}+1
            ${no}=    Evaluate    int(${i})-1
            ${no}=    Convert To String    ${no}
            ${keys}=    Evaluate    list($items_dict.keys())
            ${key}=    Set Variable    ${keys}[${no}]
            ${assortment_name}=    Set Variable    ${key}
            Set Test Variable    ${assortment_name}
            ${assortment_click}=    Set Variable    (//tr[@class="parent-box"]//div[@class="multiselect__tags"])[${i}]
            Click Element    ${assortment_click}
            Input Text    ${assortment_data_field}    ${assortment_name}
            Click Element    (//div[@class="modal-right-space mb-2 left-table"]//tbody)[${i}]//li[@class="multiselect__element"]
            Run Keyword If    ${i} < ${test_data.buy_assortment_row}    Click Element    ${add_row}
        END
    END

Select Benefit Type
    [Arguments]    ${condition_data}
    ${test_data}    Create Dictionary   &{condition_data}
    Sleep    1s
    IF    '${test_data.benefit_type}' == 'Flat Discount'
         Double Click Element    ${flat_discount}
         Log    flat discount
    ELSE IF    '${test_data.benefit_type}' == 'X no of item(s) from BUY Pool'
        Set Focus To Element    ${buy_pool}
        Double Click Element     ${buy_pool}
        Input Text    ${get_any_unit}    ${test_data.get_item}
        ${get_item}=    Set Variable    ${test_data.get_item}
        Set Test Variable    ${get_item}
    ELSE IF    '${test_data.benefit_type}' == 'X unit of item(s) from GET pool'
        Double Click Element     ${get_pool}
        Click Element    ${get_assortment_click_field}
        ${items_list}=    Convert Items To List    ${test_data.get_assortment}
        ${items_dict} =    Convert Item List To Dictionary    ${test_data.get_assortment}
        FOR    ${item}    IN    @{items_dict.items()}
            ${key}=    Set Variable    ${item}[0]
            ${values}=    Set Variable    ${item}[1]
            ${get_assortment_name}=    Set Variable    ${key}
            Input Text    ${get_assortment_data_field}    ${get_assortment_name}
            Wait Until Element Is Visible    ${get_assortment_option_field}    timeout=20s
            Click Element    ${get_assortment_option_field}
            Set Test Variable    ${get_assortment_name}
            IF    '${test_data.get_item}' == 'any'
                Double Click Element    ${get_any_qty_radio}
            ELSE IF    '${test_data.get_item}' != "NULL"
                Double Click Element    ${get_any_unit_radio}
                Input Text    ${get_any_unit_get_pool}    ${test_data.get_item}
                ${get_item}=    Set Variable    ${test_data.get_item}
                Set Test Variable    ${get_item}
            END
        END
    END

Select Discount Type
    [Arguments]    ${condition_data}
    ${test_data}    Create Dictionary   &{condition_data}
    IF    '${test_data.discount_percentage}' != 'NULL'
        Click Element    ${percent_discount_radio}
        Input Text    ${percent_discount_data}    ${test_data.discount_percentage}
        ${discount}=    Set Variable    ${test_data.discount_percentage}
        Click Element    ${discount_on_click_field}
    ELSE IF    '${test_data.discount_free}' != 'NULL'
        Click Element     ${free}    
        ${discount}=    Set Variable    ${test_data.discount_free}
    ELSE IF    '${test_data.discount_rupees}' != 'NULL'
        Click Element     ${rs_discount_radio}
        Input Text    ${rs_discount_data}    ${test_data.discount_rupees}
        ${discount}=    Set Variable    ${test_data.discount_rupees}
        Click Element    ${discount_on_click_field}
    ELSE IF    '${test_data.discount_fixed_price}' != 'NULL'
        Click Element     ${fixed_discount_radio}
        Input Text    ${fixed_discount_data}    ${test_data.discount_fixed_price}
        ${discount}=    Set Variable    ${test_data.discount_fixed_price}
        Click Element    ${discount_on_click_field}
    END
    Set Test Variable    ${discount}

Select Discount On
    [Arguments]    ${condition_data}
    ${test_data}    Create Dictionary   &{condition_data}
    ${discount_on}=    Set Variable    ${test_data.discount_on}
    IF    '${test_data.discount_on}' == 'NULL'
        ${discount_on}=    Set Variable    ${EMPTY}
        Log   100% Discount (free) is selected   
    ELSE IF    '${test_data.discount_on}' == 'SSP'
        Log    in progress
    ELSE IF    '${test_data.discount_on}' == 'RSP'
        Log    in progress
    ELSE IF    '${test_data.discount_on}' == 'MRP'
        Log    in progress
    ELSE IF    '${test_data.discount_on}' == 'Each'
        Click Element    ${fixed_discount_on_each}
    ELSE IF    '${test_data.discount_on}' == 'All'
        Click Element    ${fixed_discount_on_all}
    END
    Set Test Variable    ${discount_on}

Save Conditions
    Sleep    2s
    Click Button    ${conditions_save_button}
    Sleep    2s
    Wait Until Element Is Visible    ${definition_title}    timeout=20s

Verify Summary Of Conditions
    #    User should be able to see entered details in summary "Buy 2/Any/Specific Unit from Assortment [Assortment_name], Get percentage off on SSP"
    Page Should Contain Element    ${summary}
    ${summary_text}=    Get Text    ${summary}
    ${summary_text}=    Replace String    ${summary_text}    [    ${EMPTY}
    ${summary_text}=    Replace String    ${summary_text}    ]    ${EMPTY}
    Should Contain    ${summary_text}    ${assortment_name}
    ${discount_string}=    Convert To String    ${discount}
    Should Contain    ${summary_text}    ${discount_string}
#    Should Contain    ${summary_text}    ${discount_on}
    Click Button    ${save_changes}
    Wait Until Element Is Not Visible    ${apportion_checkbox}    timeout=20s
    Wait Until Element Is Visible    ${new_definition}

Verify Saving Of The Promo
    Wait Until Element Contains    ${promo_list}    ${name}    timeout=20s
    Sleep    2s
    Element Should Contain    ${promo_list}    ${name}
    Element Should Contain    ${promo_list}    ${applicability_text}    ignore_case=True

Verify Promo Details In Summary
    [Arguments]    ${promo_data}
    ${promo_data}    Create Dictionary    &{promo_data}
#    User should be able to see the details in summary.
    Input Text    ${search_field}    ${promo_data.name}
    Sleep    2s
    Wait Until Element Contains    ${first_promo_name}    ${name}    timeout=20s
    Click Element    ${first_promo_number}
    Wait Until Element Is Visible    ${definition_title}    timeout=20s
    Page Should Contain Element    ${summary}
    ${summary_text}=    Get Text    ${summary}
    ${summary_text}=    Replace String    ${summary_text}    [    ${EMPTY}
    ${summary_text}=    Replace String    ${summary_text}    ]    ${EMPTY}
    Should Contain    ${summary_text}    ${assortment_name}
    ${discount_string}=    Convert To String    ${discount}
    Should Contain    ${summary_text}    ${discount_string}
    Should Contain    ${summary_text}    ${discount_on}

Create New Promo
    [Arguments]    ${data}
    ${promo_data}    Create Dictionary   &{data}
    Create New Definition | Promo    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type   ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Click Button    ${save_changes}

Delete Allocated Promo
    [Arguments]    ${promos_list}
    FOR    ${name}    IN    @{promos_list}
        Clear Element Text    ${search_field}
        Input Text    ${search_field}    ${name}
        Sleep    1s
        Click Element    ${delete_icon}
        ${is_visible}    Run Keyword And Return Status    Page Should Contain Element    ${yes_remove_button}
        IF    '${is_visible}' == 'True'
            Click Element    ${yes_remove_button}
        END
    END

Cleaning The Promos
    Open Application | Admin
    Login Into Admin | Zwing
    Go To Allocation Page
    ${list}    Get Name Of ALL Allocated Promotions Of Store    Index9QA
    Go To Promo Page
    Delete Allocated Promo    ${list}

Get Name Of ALL Allocated Promotions Of Store
    [Arguments]    ${store_name}
    ${promos}    Create List
    Input Text     ${Search_field}    ${store_name}
    Sleep    1
    Set Selenium Speed    1
    Click Element    ${view_button}
    Wait Until Element Is Visible    ${promotion_allocation}    timeout=20s
    ${promo_names}=    Get Webelements    ${promo_name_column}
    FOR    ${name}    IN    @{promo_names}
        ${name_text}    Get Text    ${name}
        Append To List    ${promos}    ${name_text}
    END
    RETURN    ${promos}

Delete Promos
    [Arguments]     ${promo_names_file}
    ${list_of_promos}    Fetch Promo Names    ${promo_names_file}
    Log    ${list_of_promos}
    FOR    ${name}    IN    @{list_of_promos}
        Clear Element Text    ${search_field}
        Input Text    ${search_field}    ${name}
        Sleep    1s
        Click Element    ${delete_icon}
        ${is_visible}    Run Keyword And Return Status    Page Should Contain Element    ${yes_remove_button}
        IF    '${is_visible}' == 'True'
            Click Element    ${yes_remove_button}
        END
    END

# quantity based Slab Benifit
Select Slab Definition | Quantity
    [Arguments]    ${slab_data}
    ${slab_test_data}    Create Dictionary   &{slab_data}
    ${items_list}=    Convert Items To List    ${slab_test_data.buy_assortment}
    ${items_dict} =    Convert Item List To Dictionary    ${slab_test_data.buy_assortment}
     FOR    ${i}    IN RANGE    1    ${slab_test_data.slab_row}+1
        Input Text    ${slab_qty_from}    ${slab_test_data.slab_qty_from}
        Input Text    ${slab_qty_to}    ${slab_test_data.slab_qty_to}
        Input Text    ${slab_benifit_description}    ${slab_test_data.slab_description}
        Click Element    ${benifits_slab_element}
        Select Benefit Type    ${slab_test_data}
        Select Discount Type    ${slab_test_data}
        Execute Javascript     window.scrollBy(0, 3800);
        Select Discount On    ${slab_test_data}
        Execute Javascript     window.scrollBy(0, 3800);
        ${php_debugger}=    Run Keyword And Return Status     Element Should Be Visible    ${php_close_button}   
        Run Keyword If    ${php_debugger}     Click Element    ${php_close_button}
        Click Button    ${save_benifits_button}
        Run Keyword If    ${i} < ${slab_test_data.slab_row}    Click Element    ${add_row}
    END

Select Slab Definition | Quantity for VBSLB
    [Arguments]    ${slab_data}
#    Set Selenium Speed    1
    ${slab_test_data}    Create Dictionary   &{slab_data}
    ${items_list}=    Convert Items To List    ${slab_test_data.buy_assortment}
    ${items_dict} =    Convert Item List To Dictionary    ${slab_test_data.buy_assortment}
    ${php_debugger}=    Run Keyword And Return Status     Element Should Be Visible    ${php_close_button}
    Run Keyword If    ${php_debugger}     Click Element    ${php_close_button}
     FOR    ${i}    IN RANGE    1    ${slab_test_data.slab_row}+1
        ${index_value}=     Convert To String    ${i}
        ${slab_qty_from}=   Set Variable    (((//b[contains(text(),"Slab definition")]//ancestor::div[@class="modal-right-space mb-2"]//tbody)[${index_value}]//input[@type="number"])[1])
        ${data_index}=      Evaluate    ${i}-1
        ${slab_data}=   Get From List    ${slab_test_data.slab_qty_from}    ${data_index}
        Input Text    ${slab_qty_from}    ${slab_data}
#        Input Text    ${slab_qty_to}    ${slab_test_data.slab_qty_to}
        Input Text    ${slab_benifit_description}    ${slab_test_data.slab_description}
        ${benifits_slab_action}=    Set Variable    (${benifits_slab_element})[${index_value}]
        Click Element    ${benifits_slab_action}
        Select Benefit Type    ${slab_test_data}
        Execute Javascript     window.scrollBy(0, 3800);
        Select Discount Type    ${slab_test_data}
        Select Discount On    ${slab_test_data}
        Execute Javascript     window.scrollBy(0, 3800);
        Click Button    ${save_benifits_button}
        Run Keyword If    ${i} < ${slab_test_data.slab_row}    Click Element    ${add_slab_row}
    END
    
Delete
    Go To Promo Page
    FOR    ${i}    IN RANGE    1     10
        Click Element    (//i[@class="fa fa-trash-o"])[1]
        Click Element    ${yes_remove_button}
    END