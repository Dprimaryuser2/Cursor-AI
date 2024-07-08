*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../Resources/CustomKeywords/utilities.py
Variables    ../../../Environment/environment.py
Variables    ../../../PageObjects/Web_POS/Settings/serial_information_locators.py
Variables    ../../../PageObjects/AdminConsole/POSTerminal/pos_terminal.py
Resource    ../../../Resources/AdminConsole/Login/login_keyword.robot

*** Keywords ***
Revoke Serial Key
    [Arguments]    ${serial_key}
    ${serial_key_info}    Create Dictionary   &{serial_key} 
    ${serial_key_number}=    Set Variable    ${serial_key_info.serial_key}
    Go To    ${pos_url}
    Wait Until Element Is Visible    ${settings_tab}    timeout=20s
    Set Focus To Element    ${settings_tab}
<<<<<<< HEAD
    Wait Until Keyword Succeeds    5    2     Click Element    ${settings_tab}
=======
    Click Element    ${settings_tab}
>>>>>>> 0bdf806e07539712d559c3bab4be41762fd59b6e
    Set Focus To Element    ${settings_tab}
    ${serial_info_visible}    Run Keyword And Return Status    Element Should Not Be Visible    ${serial_information_tab}
    IF    ${serial_info_visible}
        Click Element    ${settings_tab}
    END
    Wait Until Element Is Visible    ${serial_information_tab}    timeout=20s
<<<<<<< HEAD
    Wait Until Keyword Succeeds    5    2     Click Element    ${profile_info_heading}
    Wait Until Keyword Succeeds    5    2     Click Element    ${serial_information_tab}
    Wait Until Element Is Visible    ${serial_info_heading}    timeout=20s
    Wait Until Element Is Visible    ${revoke_license_button}    timeout=20s
    Scroll Element Into View    ${revoke_license_button}
    Wait Until Keyword Succeeds    5    2     Click Button    ${revoke_license_button}
    Wait Until Element Is Visible    ${revoke_modal_title}    timeout=20s
    Input Text    ${license_key_input}    ${serial_key_number}
    Wait Until Keyword Succeeds    5    2     Click Button    ${revoke_license_confirm_button}
=======
    Click Element    ${profile_info_heading}
    Click Element    ${serial_information_tab}
    Wait Until Element Is Visible    ${serial_info_heading}    timeout=20s
    Wait Until Element Is Visible    ${revoke_license_button}    timeout=20s
    Scroll Element Into View    ${revoke_license_button}
    Click Button    ${revoke_license_button}
    Wait Until Element Is Visible    ${revoke_modal_title}    timeout=20s
    Input Text    ${license_key_input}    ${serial_key_number}
    Click Button    ${revoke_license_confirm_button}
>>>>>>> 0bdf806e07539712d559c3bab4be41762fd59b6e
    Wait Until Element Is Visible    ${activate_device_heading}    timeout=20s

Tear It Down If Test Case Failed
    [Arguments]    ${discount_data}
    Run Keyword If Test Failed    Revoke The Licence Key From Console     ${discount_data}

Revoke The Licence Key From Console
    [Arguments]    ${serial_key}
    ${serial_key_info}    Create Dictionary   &{serial_key}
    ${serial_key_number}=    Set Variable    ${serial_key_info.serial_key}
    Open Application | Admin
    Login Into Admin | Zwing
<<<<<<< HEAD
    Wait Until Keyword Succeeds    8    2    Go To Pos Terminal
=======
    Wait Until Keyword Succeeds    5    2    Go To Pos Terminal
>>>>>>> 0bdf806e07539712d559c3bab4be41762fd59b6e
    Wait Until Element Is Visible    ${pos_heading}    timeout=20s
    Wait Until Element Is Visible    ${pos_search_bar}    timeout=20s
    Input Text    ${pos_search_bar}    ${serial_key_number}
    Sleep    0.5s
    ${tagged_device}=    Replace String    ${tagged_device_edit_link}    Serial_Key    ${serial_key_number}
    Click Element    ${tagged_device}
    Wait Until Element Is Visible    ${remove_device_icon}    timeout=10s
<<<<<<< HEAD
    Wait Until Keyword Succeeds    5    2     Click Element    ${remove_device_icon}
    Wait Until Element Is Visible    ${remove_modal_body}    timeout=10s
    Wait Until Keyword Succeeds    5    2     Click Button    ${remove_button}
=======
    Click Element    ${remove_device_icon}
    Wait Until Element Is Visible    ${remove_modal_body}    timeout=10s
    Click Button    ${remove_button}
>>>>>>> 0bdf806e07539712d559c3bab4be41762fd59b6e
    Wait Until Element Is Not Visible    ${remove_modal_body}    timeout=10s
    Close Browser

Go To Pos Terminal        
<<<<<<< HEAD
    Wait Until Keyword Succeeds    5    2     Click Element    ${pos_terminal_logo}
    Wait Until Element Is Visible    ${pos_terminal_link}
    Wait Until Keyword Succeeds    5    2     Click Element    ${pos_terminal_link}
=======
    Click Element    ${pos_terminal_logo}
    Wait Until Element Is Visible    ${pos_terminal_link}
    Click Element    ${pos_terminal_link}
>>>>>>> 0bdf806e07539712d559c3bab4be41762fd59b6e
