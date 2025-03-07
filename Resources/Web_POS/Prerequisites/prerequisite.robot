*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../Resources/CustomKeywords/utilities.py
Variables    ../../../Environment/environment.py
Variables    ../../../PageObjects/Web_POS/Settings/serial_information_locators.py
Variables    ../../../PageObjects/AdminConsole/POSTerminal/pos_terminal.py
Resource    ../../../Resources/AdminConsole/Login/login_keyword.robot
Variables    ../../../PageObjects/Web_POS/POS/pos_locators.py
Resource   ../../../Resources/Web_POS/POS/Billing/add_to_cart_keyword.robot

*** Variables ***
${ENV}    PROD
${STAGING_URL}=      ${pos_url_staging}
${PROD_URL}=    ${pos_url_prod}

*** Keywords ***
Revoke Serial Key
    [Arguments]    ${serial_key}
    ${serial_key_info}    Create Dictionary   &{serial_key}
    ${serial_key_number}=    Set Variable    ${serial_key_info.serial_key}
    Go To    ${${ENV}_URL}
    Wait Until Element Is Visible    ${settings_tab}    timeout=40s
    Set Focus To Element    ${settings_tab}
    Wait Until Keyword Succeeds    5    2     Click Element    ${settings_tab}
    ${serial_info_visible}    Run Keyword And Return Status    Element Should Be Visible    ${serial_info_heading}
    IF    '${serial_info_visible}' == 'False'
         Wait Until Keyword Succeeds    5    2     Click Element    ${settings_tab}
    END
    ${closing_balance_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${closing_balance}
    IF    ${closing_balance_visible}
        Input Text    ${closing_balance}    ${serial_key_info.closing_balance}
        Click Element    ${open_session_submit_button}
    END
    ${opening_session_present}=    Run Keyword And Return Status    Element Should Be Visible    ${opening_balance}    timeout=10s
    IF    ${opening_session_present}
        Wait Until Page Contains Element    ${opening_balance}
        Clear Element Text    ${opening_balance}
        Input Text    ${opening_balance}    ${serial_key_info.opening_balance}
        Click Element    ${open_session_submit_button}
    END
    Wait Until Keyword Succeeds    5    3     Click Element    ${profile_info_heading}
    Wait Until Keyword Succeeds    5    3     Click Element    ${serial_information_tab}
    Wait Until Element Is Visible    ${serial_info_heading}    timeout=10s
    Wait Until Element Is Visible    ${revoke_license_button}    timeout=10s
    Scroll Element Into View    ${revoke_license_button}
    Wait Until Keyword Succeeds    5    3     Click Button    ${revoke_license_button}
    Wait Until Element Is Visible    ${revoke_modal_title}    timeout=10s
    Wait Until Page Contains Element    ${license_key_input}     timeout=10s
    Sleep    0.5
    Input Text    ${license_key_input}    ${serial_key_number}
    Wait Until Page Contains Element    ${license_key_input}   timeout=20s
    Wait Until Keyword Succeeds    5    4     Click Button    ${revoke_license_confirm_button}
    Wait Until Page Does Not Contain Element    ${revoke_license_confirm_button}  timeout=10s
    Wait Until Element Is Visible    ${activate_device_heading}    timeout=10s
    Delete All Cookies
    Execute JavaScript    window.localStorage.clear();
    Execute JavaScript    window.sessionStorage.clear();
    Reload Page
    Close All Browsers

Tear It Down If Test Case Failed
    [Arguments]    ${pos_data}
    Run Keyword If Test Failed    Revoke The Licence Key From Console      ${pos_data}   
    Sleep    0.2
    ${status}=  Run Keyword And Return Status    Page Should Contain Element    ${pos_option_sidebar}
    IF    ${status}
        Close All Browsers
    END

Revoke The Licence Key From Console 
    [Arguments]     ${pos_data}
    ${pos_data_dict}=    Create Dictionary    &{pos_data}
    Open Application | Admin
    Input Text    ${email}      ${pos_data_dict.username_admin}
    Wait Until Element Is Visible    ${password}    timeout=20s
    Input Text    ${password}    ${pos_data_dict.password_admin}
    Click Button    ${continue_button}
    Wait Until Page Contains Element    ${dashboard}    timeout=20s
    Page Should Contain Element    ${invoice_icon}
    Page Should Contain Element    ${product_icon}
    Wait Until Keyword Succeeds    2    2    Go To Pos Terminal
    Wait Until Element Is Visible    ${pos_heading}    timeout=20s
    Wait Until Element Is Visible    ${pos_search_bar}    timeout=20s
    Input Text    ${pos_search_bar}   i9_store
    Sleep    2s
    ${status}=  Run Keyword And Return Status   Element Should Be Visible    ${last_most_page_icon}
    IF    ${status}
         Click Element    ${last_most_page_icon}
         Wait Until Page Contains Element    ${last_page_number}   timeout=20s
         ${last_number}=   Get Text    ${last_page_number}
         ${last_number}=  Convert To Integer    ${last_number}
         Log    ${last_number}
         Click Element    ${first_most_page_icon}
         Sleep   1s
         FOR    ${counter}    IN RANGE    0    ${last_number}
            ${tag_device}=    Run Keyword And Return Status     Wait Until Page Contains Element    ${tagged_device_icon}   timeout=3s
            IF   ${tag_device}
                Click Element    ${tagged_device_icon}
                ${status_icon}   Run Keyword And Return Status    Wait until Page contains element   ${remove_device_icon}
                 IF    ${status_icon}
                     Wait Until Element Is Visible    ${remove_device_icon}    timeout=10s
                     Wait Until Keyword Succeeds    5    2     Click Element    ${remove_device_icon}
                     Wait Until Element Is Visible    ${remove_modal_body}    timeout=10s
                     Wait Until Keyword Succeeds    5    2     Click Button    ${remove_button}
                     Wait Until Element Is Not Visible    ${remove_modal_body}    timeout=10s
                 END
             Input Text    ${pos_search_bar}   i9_store
             Sleep    2s
            END
          Wait Until Page Contains Element    ${next_page_icon}   timeout=20s
          Click Element    ${next_page_icon}
          Sleep    1
         END
    ELSE
         Wait Until Page Contains Element    ${last_page_number}   timeout=20s
         ${last_number}=   Get Text    ${last_page_number}
         ${last_number}=  Convert To Integer    ${last_number}
         Log    ${last_number}
         Sleep   1s
         FOR    ${counter}    IN RANGE    0    ${last_number}
            ${tag_device}=    Run Keyword And Return Status     Wait Until Page Contains Element    ${tagged_device_icon}   timeout=3s
            IF  ${tag_device}
                Click Element    ${tagged_device_icon}
                ${status_icon}   Run Keyword And Return Status    Wait until Page contains element   ${remove_device_icon}
                 IF    ${status_icon}
                     Wait Until Element Is Visible    ${remove_device_icon}    timeout=10s
                     Wait Until Keyword Succeeds    5    2     Click Element    ${remove_device_icon}
                     Wait Until Element Is Visible    ${remove_modal_body}    timeout=10s
                     Wait Until Keyword Succeeds    5    2     Click Button    ${remove_button}
                     Wait Until Element Is Not Visible    ${remove_modal_body}    timeout=10s
                 END
            Input Text    ${pos_search_bar}   i9_store
            Sleep    2s
            END
          Wait Until Page Contains Element    ${next_page_icon}   timeout=20s
          Click Element    ${next_page_icon}
          Sleep    1
         END
    END
     Close Window
     Switch Browser    1

Go To Pos Terminal
    Wait Until Keyword Succeeds    5    2     Click Element    ${pos_terminal_logo}
    ${environment}=     Set Variable    ${ENV}
    Run Keyword If    '${environment}' == 'STAGING'    Click POS terminal Link
        
Click POS terminal Link
    Wait Until Element Is Visible    ${pos_terminal_link}
    Wait Until Keyword Succeeds    5    2     Click Element    ${pos_terminal_link}

Close Session With Clear Cache
   [Arguments]    ${pos_data}
   ${pos_data}    Create Dictionary   &{pos_data}
   ${status}=  Run Keyword And Return Status    Wait Until Element Is Enabled    ${done_progress}
   IF    ${status}
        Open The Session    ${pos_data}
        Sleep  0.5s
   END
   ${status_done}=  Run Keyword And Return Status    Element Should Be Visible    ${opening_balance}
    IF    ${status_done}
        Open The Session    ${pos_data}
        Sleep  0.5s
   END
   ${status3}=  Run Keyword And Return Status   Page Should Contain Element    ${checkout_heading}
    IF    ${status3}
        Click Element    ${back_icon_on_checkout}
   END
   Close The Session    ${pos_data}
   Logout From The POS
   Delete All Cookies
   Execute JavaScript    window.localStorage.clear();
   Execute JavaScript    window.sessionStorage.clear();
   Reload Page
   Revoke The Licence Key From Console
   Sleep  0.5s
