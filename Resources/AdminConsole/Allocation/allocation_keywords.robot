*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    ../../../Resources/CustomKeywords/utilities.py
Variables   ../../../PageObjects/AdminConsole/Promo/promo_locators.py
Variables    ../../../PageObjects/AdminConsole/Promo/conditions_locators.py
Variables    ../../../PageObjects/AdminConsole/Allocation/allocation_locator.py
Variables    ../../../PageObjects/AdminConsole/Allocation/promotion_allocation.py
Resource    ../Login/login_keyword.robot
Resource    ../../../Resources/AdminConsole/POSTerminal/pos_terminal_keyword.robot

*** Keywords ***
Go To Allocation Page
    Click Element    //i[@class="fa fa-fw fa-gift "]//ancestor::a
    Click Element    ${promotion_allocation_icon}
#    Wait Until Element Is Visible    ${allocation}
#    Click Element    ${allocation}
    Wait Until Element Is Visible    ${new_allocation}    timeout=20s
    Page Should Contain Element    ${new_allocation}
    Page Should Contain Element    ${promotion_heading}

Apply Validation Period ON Selected Promos
    Wait Until Element Is Visible    ${valid_from_calendar}    timeout=20s
    Page Should Contain Element    ${valid_from_calendar}
    Click Element    ${valid_from_calendar}
    ${valid_date}=    Get Formatted Date
    ${valid_from_date_field}=    Replace String    ${valid_from_date}    date    ${valid_date}
    Click Element    ${valid_from_date_field}
    Click Element    ${valid_to_calendar}
    Sleep    2s
    Click Element    ${next_year_button}
    Click Element    ${valid_to_date}

Allocation Of Promo To Store | Store Selection
    [Arguments]     ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    ${index}=    Set Variable    0
    ${element_present}=    Run Keyword And Return Status    Page Should Contain Element    	${my_dict.store_name}
    FOR    ${index}    IN RANGE    10
        ${element_present}=    Run Keyword And Return Status    Page Should Contain Element    ${my_dict.store_name}
        Run Keyword Unless    ${element_present}    Click Element    ${store_next_slide}
        Exit For Loop If    ${element_present}
    END
    Run Keyword If    not ${element_present}    Log    Target element not found after clicking next button multiple times.
    ${store_checkbox}=    Replace String    ${store_check_box}    StoreName    ${my_dict.store_name}
    Wait Until Element Is Visible    ${store_checkbox}    timeout=20s
    Click Element    ${store_checkbox}

Allocation Of Promo To Store 
    [Arguments]     ${search_data}
    ${index}=    Set Variable    0
    ${element_present}=    Run Keyword And Return Status    Page Should Contain Element    	${search_data}
    FOR    ${index}    IN RANGE    0    10
        ${element_present}=    Run Keyword And Return Status    Page Should Contain Element    ${search_data}
        Run Keyword Unless    ${element_present}    Click Element    ${promo_next_slide}
        Exit For Loop If    ${element_present}
    END
    Run Keyword If    not ${element_present}    Log    Target element not found after clicking next button multiple times.  
    ${promo-checkbox}=    Replace String    ${promo_check_box}    Promo    ${search_data}
    Click Element    ${promo-checkbox}
    Execute Javascript    window.scrollTo(0,0)

Review And Save Allocation
    Click Element    ${review_allocation}
    Wait Until Element Is Visible    ${confirm_allocation_heading}
    Click Element    ${save_allocation}
    Wait Until Element Is Visible    ${promotion_allocation}    timeout=20s

Allocate All Promos To Store
    [Arguments]     ${promo_names_file}
    Open Application | Admin
    Login Into Admin | Zwing
    ${list_of_promos}    Get Promo Names     ${promo_names_file}
    Log    ${list_of_promos}
    ${php_debugger}=    Run Keyword And Return Status     Element Should Be Visible    ${php_close_button}
    Run Keyword If    ${php_debugger}     Click Element    ${php_close_button}
    FOR    ${keys1}    IN    @{list_of_promos.keys()}
        Go To Allocation Page
        ${val}     Get Dictionary Value    ${list_of_promos}    ${keys1}
        Clear Element Text    ${search_field}
        Input Text    ${search_field}    ${keys1}
        Sleep    1
        Click Element    ${view_button}
        Wait Until Element Is Visible    ${promotion_allocation}    timeout=20s
#        ${allocation_enabled}    Run Keyword And Return Status    Element Should Be Enabled    ${allocate_more}
#        IF    ${allocation_enabled}
        Sleep    1s
        Click Element    ${allocate_more}
        Apply Validation Period ON Selected Promos
        ${php_debugger}=    Run Keyword And Return Status     Element Should Be Visible    ${php_close_button}
        Run Keyword If    ${php_debugger}     Click Element    ${php_close_button}
        Click Element    ${select_promotions}
        Click Element    ${all_promos}
        Review And Save Allocation
#        END
    END
    Go To Pos Terminal Page

Set Promotion Priority As Highest
    [Arguments]    ${promo_data}
    ${my_dict}    Create Dictionary   &{promo_data}
    ${store_name}=     Set Variable        ${my_dict.store_name}
    ${promo_name}=    Set Variable    ${my_dict.promo_name}
    Log    ${promo_name}
    Wait Until Page Contains Element    ${search_field}
    Input Text    ${search_field}    ${store_name}
    Sleep    2
    Click Element    ${view_button}
#    ${high}=    Set Variable    0
#    Sleep    2
#    Click Button    //i[@class="fa fa-eye"]//ancestor::button
#    Sleep    0.2s
#    Wait Until Element Is Visible    //li/a[text()="100"]
#    Click Element    //li/a[text()="100"]
#    Sleep    1s
#    Wait Until Page Contains Element    (//table[@class = 'table table-striped table-nowrap align-middle'])/descendant::tr/td[2]
#    ${priorities}    Get Webelements    (//table[@class = 'table table-striped table-nowrap align-middle'])/descendant::tr/td[2]
#    FOR    ${priority}    IN    @{priorities}
#        ${priority_val}    Get Text    ${priority}
#        ${priority_val}    Convert To Integer    ${priority_val}
#        IF    ${priority_val} > ${high}
#            ${high}=    Set Variable    ${priority_val}
#        ELSE
#            Log    Skip
#        END
#    END
   # search and update priority
   Input Text    ${search_field}    ${promo_name}
   Sleep    3s
   # Click on edit icon
   Click Element    //i[@class = 'fa fa-pencil']
   Wait Until Element Is Visible    //p[contains(text(),"Higest Prority is")]    timeout=10s
   Sleep    0.5s
   ${high_text}=    Get Text    //p[contains(text(),"Higest Prority is")]
   ${high_list}=    Split String    ${high_text}    is
   ${high}=    Get From List    ${high_list}    1
   # update priority field
   Clear Element Text    //input[@placeholder='Priority in store']
   Input Text    //input[@placeholder='Priority in store']    ${high}
   # Save
   Click Element    //button[@class = 'btn pull-right btn-primary']
   Wait Until Element Is Visible    //i[@class = 'fa fa-pencil']    timeout=10s
   Sleep    3s


