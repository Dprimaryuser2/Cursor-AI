*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../../Resources/CustomKeywords/utilities.py
Resource   ../../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/promo_keyword.robot
Resource    ../../../AdminConsole/Login/login_keyword.robot
Resource    ../../../AdminConsole/POSTerminal/pos_terminal_keyword.robot
Variables    ../../../../PageObjects/Web_POS/POS/hold_bill_locators.py
Variables    ../../../../PageObjects/AdminConsole/POSTerminal/pos_terminal.py
Variables   ../../../../PageObjects/Web_POS/POS/checkout_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/pos_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/add_customer_locator.py
Variables   ../../../../Environment/environment.py

*** Keywords ***
Verify Salesperson Tagging is Enabled and Salesperson Tagging is Mandatory in Policies
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Click Element    ${product_name_in_cart_row}
    Wait Until Page Contains Element    ${salesperson_dropdown}
    Click Element    ${salesperson_dropdown}
    Wait Until Page Contains Element    ${row_in_salesperson_dropdown}
    Page Should Contain Element    ${row_in_salesperson_dropdown}
    Click Element    ${salesperson_dropdown}
    Wait Until Element Is Enabled    ${update_product_button}
    Click Element    ${update_product_button}
    Wait Until Page Does Not Contain Element    ${update_product_button}
    Wait Until Element Is Enabled    ${checkout_button}
    Click Element    ${checkout_button}
    Wait Until Page Contains Element    ${salesperson_mandatory_message}
    Page Should Not Contain Element    ${checkout_heading}


Verify Salesperson Tagging is Enabled and Salesperson Tagging is Optional in Policies
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Click Element    ${product_name_in_cart_row}
    Wait Until Page Contains Element    ${salesperson_dropdown}
    Click Element    ${salesperson_dropdown}
    Wait Until Page Contains Element    ${row_in_salesperson_dropdown}
    Page Should Contain Element    ${row_in_salesperson_dropdown}
    Click Element    ${salesperson_dropdown}
    Wait Until Element Is Enabled    ${update_product_button}
    Click Element    ${update_product_button}
    Wait Until Page Does Not Contain Element    ${update_product_button}
    Wait Until Element Is Enabled    ${checkout_button}
    Click Element    ${checkout_button}
    Wait Until Page Contains Element    ${checkout_heading}    timeout=20

Verify Salesperson Tagging is Enabled and Salesperson Tagging is Mandatory in Policies after adding the product
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${product_name_in_cart_row}    timeout=20
    Open Browser    ${admin_console_url}    ${browser}
    ${admin_id}    Get Browser Ids
    Maximize Browser Window
    Login With Valid Username And Password    ${my_dict}
    Change Salesperson Tagging To Mandatory In POS
    Switch Browser    1
    Wait Until Page Contains Element    ${pos_settings}    timeout=20
    Click Element    ${pos_settings}
    Click Element    ${pos_settings_profile_info}
    Wait Until Page Contains Element    ${pos_settings_quick_actions}    timeout=20
    Click Element    ${pos_settings_quick_actions}
    Wait Until Page Contains Element    ${get_new_settings}    timeout=20
    Click Element    ${get_new_settings}
    Sleep    2
    Wait Until Page Contains Element    ${pos_option_sidebar}    timeout=20
    Click Element    ${pos_option_sidebar}
    Wait Until Page Contains Element    ${checkout_button}    timeout=20
    Click Element    ${checkout_button}
    Page Should Not Contain Element    ${checkout_heading}    timeout=20
    Switch Browser    2
    Sleep    2
    Change Salesperson Tagging To Optional In POS
    

Assign A Salesperson All Items
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    ${products}    Get Webelements    ${product_name_in_cart_row}
    ${product_count}    Get Length    ${products}
    Convert To Integer    ${product_count}
    Should Not Be Equal As Integers     ${product_count}    1
    Wait Until Element Is Enabled    ${salesperson_button}
    Click Element    ${salesperson_button}
    Wait Until Page Contains Element    ${assign_salesperson_window_heading}
    Wait Until Page Contains Element    ${assign_salesperson_search}
    Click Element    ${assign_salesperson_search}
    Input Text    ${assign_salesperson_search}    ${my_dict.salesperson_name}
    Wait Until Page Contains Element    ${name_in_assign_salesperson_row}
    Click Element    ${name_in_assign_salesperson_row}
    Wait Until Element Is Enabled    ${assign_to_all_button}
    Click Element    ${assign_to_all_button}
    Wait Until Page Contains Element    ${salesperson_tagged_message}
    Wait Until Page Contains Element    ${close_assign_salesperson_window}
    Click Element    ${close_assign_salesperson_window}


Verify Salesperson Tagged At Bill Level
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary     &{pos_data}
    Wait Until Element Is Enabled    ${checkout_button}
    Click Element    ${checkout_button}
    Wait Until Page Contains Element    ${checkout_heading}
    Page Should Contain Element    ${checkout_salesperson_name}
    ${salesperson_list}    Get Webelements    ${checkout_salesperson_name}
    ${product_salesperson_count}   Get Length    ${salesperson_list}
    ${count}    Convert To Integer    ${product_salesperson_count}
    Log    ${count}
    Sleep    1
    FOR   ${i}  IN RANGE       ${count}
        ${temp}   Get Text     ${salesperson_list}[${i}]
        Should Contain    ${temp}    ${my_dict.salesperson_name}
    END

Assign Same Salesperson To All Products Except Last Product And Verify
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    ${products_list}    Get Webelements    ${product_name_in_cart_row}
    ${product_count}    Get Length    ${products_list}
    Wait Until Page Contains Element    ${salesperson_button}    timeout=10
    Click Element    ${salesperson_button}
    Wait Until Page Contains Element    ${assign_salesperson_search}    timeout=10
    Input Text    ${assign_salesperson_search}    ${my_dict.salesperson_name}
    Wait Until Page Contains Element    ${name_in_assign_salesperson_row}    timeout=10
    Click Element    ${name_in_assign_salesperson_row}
    Wait Until Element Is Enabled    ${assign_to_all_button}    timeout=10
    Click Element    ${assign_to_all_button}
    Wait Until Page Contains Element    ${salesperson_tagged_message}    timeout=10
    Wait Until Page Does Not Contain Element    ${salesperson_tagged_message}    timeout=10
    Wait Until Page Contains Element    (${product_name_in_cart_row})[${product_count}]
    Click Element    (${product_name_in_cart_row})[${product_count}]
    Wait Until Page Contains Element    ${close_icon_salesperson_dropdown}    timeout=10
    Click Element    ${close_icon_salesperson_dropdown}
    Wait Until Page Contains Element    ${salesperson_untagged_message}    timeout=10
    Wait Until Element Is Enabled    ${update_product_button}    timeout=10
    Wait Until Page Does Not Contain Element    ${salesperson_untagged_message}    timeout=10
    
    Click Element    ${update_product_button}    
    Wait Until Page Contains Element    ${cart_product_checkbox}    timeout=10
    
    Page Should Contain Element    ${cart_product_checkbox}
    Wait Until Page Does Not Contain Element     (${salesperson_below_product})[${product_count}]    timeout=10



Verify Change Salesperson tagging for item
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${first_item_product_name}
    Click Element    ${product_name_in_cart_row}
    Wait Until Page Contains Element    ${close_icon_salesperson_dropdown}
    Click Element    ${close_icon_salesperson_dropdown}
    Wait Until Page Contains Element    ${salesperson_untagged_message}
    Wait Until Page Contains Element    ${salesperson_dropdown}
    Click Element    ${salesperson_dropdown}
    Wait Until Page Contains Element    ${row_in_salesperson_dropdown}
    Click Element    ${salesperson_search_field}
    Input Text    ${salesperson_search_field}    ${my_dict.new_salesperson_name}
    Wait Until Page Contains Element    ${row_in_salesperson_dropdown}
    Click Element    ${row_in_salesperson_dropdown}
    Wait Until Page Contains Element    ${salesperson_tagged_message}
    Wait Until Element Is Enabled    ${update_product_button}
    Click Element    ${update_product_button}
    Wait Until Page Contains Element    ${salesperson_below_product}
    ${new_s_name}    Get Text    ${salesperson_below_product}
    Should Contain    ${new_s_name}    ${my_dict.new_salesperson_name}

Verify Change Salesperson tagging for bill
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary    &{pos_data}
    Wait Until Page Contains Element    ${product_name_in_cart_row}    timeout=10
    ${products}    Get Webelements    ${product_name_in_cart_row}
    ${product_count}    Get Length    ${products}
    Should Not Be Equal As Integers     ${product_count}    1
    Wait Until Element Is Enabled    ${salesperson_button}    timeout=10
    Click Element    ${salesperson_button}
    Wait Until Page Contains Element    ${assign_salesperson_window_heading}    timeout=10
    Wait Until Page Contains Element    ${assign_salesperson_search}    timeout=10
    Click Element    ${assign_salesperson_search}
    Input Text    ${assign_salesperson_search}    ${my_dict.new_salesperson_name}
    Wait Until Page Contains Element    ${name_in_assign_salesperson_row}    timeout=10
    Click Element    ${name_in_assign_salesperson_row}
    Click Element    ${name_in_assign_salesperson_row}
    Wait Until Element Is Enabled    ${assign_to_all_button}    timeout=10
    Click Element    ${assign_to_all_button}
    Wait Until Page Contains Element    ${salesperson_tagged_message}    timeout=10
    Wait Until Page Does Not Contain Element    ${salesperson_tagged_message}    timeout=10
    Wait Until Page Contains Element    ${close_assign_salesperson_window}    timeout=10
    Click Element    ${close_assign_salesperson_window}
    Wait Until Page Contains Element    ${salesperson_button}    timeout=10

    Wait Until Element Is Enabled    ${checkout_button}    timeout=10
    Click Element    ${checkout_button}
    Wait Until Page Contains Element    ${checkout_heading}    timeout=10
    Page Should Contain Element    ${checkout_salesperson_name}
    ${salesperson_list}    Get Webelements    ${checkout_salesperson_name}
    ${product_salesperson_count}    Get Length    ${salesperson_list}
    FOR    ${index}    IN RANGE      1    ${product_salesperson_count}+1
        ${no}    Evaluate    ${index}-1
        Wait Until Page Contains Element        (${checkout_salesperson_name})[${index}]    timeout=10
        ${temp}    Get Text     ${salesperson_list}[${no}]
        Should Contain    ${temp}    ${my_dict.new_salesperson_name}
    END
