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
Resource    ../../../../Resources/Web_POS/POS/Billing/split_payment_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/Billing/manual_discount_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/Exchange/exchange_keyword.robot
Variables   ../../../../PageObjects/Web_POS/POS/checkout_locators.py

*** Keywords ***
Assign A Salesperson All Items | Order
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

Navigate To Salesperson Tagging Popup | Order
    Wait Until Page Contains Element    ${product_name_in_cart_row}
    Click Element    ${product_name_in_cart_row}
    Wait Until Page Contains Element    ${salesperson_dropdown}

Verify Salesperson Tagging is Enabled and Salesperson Tagging is Optional in Policies | Order
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
    ${insufficient}=    Run Keyword And Return Status    Element Should Be Enabled    ${insufficient_inventory_continue_btn}
    IF    ${insufficient}
     Set Fulfillment Date And Continue
    END
    Wait Until Element Is Visible    ${checkout_heading}    timeout=20s
    Page Should Contain Element    ${checkout_heading}

Verify Salesperson Tagging is Enabled and Salesperson Tagging is Mandatory in Policies | Order
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
    ${insufficient}=    Run Keyword And Return Status    Element Should Be Enabled    ${insufficient_inventory_continue_btn}
    IF    ${insufficient}
     Set Fulfillment Date And Continue
    END
    Wait Until Page Contains Element    ${salesperson_mandatory_message}
    Page Should Not Contain Element    ${checkout_heading}

Verify Salesperson Tagged At Bill Level | Order
    [Arguments]    ${pos_data}
    ${my_dict}    Create Dictionary     &{pos_data}
    Wait Until Element Is Enabled    ${checkout_button}
    Click Element    ${checkout_button}
    ${insufficient}=    Run Keyword And Return Status    Element Should Be Enabled    ${insufficient_inventory_continue_btn}
    IF    ${insufficient}
     Set Fulfillment Date And Continue
    END
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

Verify Change Salesperson tagging for bill | Order
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
    ${insufficient}=    Run Keyword And Return Status    Element Should Be Enabled    ${insufficient_inventory_continue_btn}
    IF    ${insufficient}
     Set Fulfillment Date And Continue
    END
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
