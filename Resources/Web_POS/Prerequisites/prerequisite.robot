*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../Resources/CustomKeywords/utilities.py
Variables    ../../../Environment/environment.py
Variables    ../../../PageObjects/Web_POS/Settings/serial_information_locators.py

*** Keywords ***
Revoke Serial Key
    [Arguments]    ${serial_key}
    ${serial_key_info}    Create Dictionary   &{serial_key} 
    ${serial_key_number}=    Set Variable    ${serial_key_info.serial_key}
    Go To    ${pos_url}
    Wait Until Element Is Visible    ${settings_tab}    timeout=20s
    Click Element    ${settings_tab}
    ${serial_info_visible}    Run Keyword And Return Status    Element Should Not Be Visible    ${serial_information_tab}
    IF    ${serial_info_visible}
        Click Element    ${settings_tab}
    END
    Wait Until Element Is Visible    ${serial_information_tab}    timeout=20s
    Click Element    ${profile_info_heading}
    Click Element    ${serial_information_tab}
    Wait Until Element Is Visible    ${serial_info_heading}    timeout=20s
    Wait Until Element Is Visible    ${revoke_license_button}    timeout=20s
    Scroll Element Into View    ${revoke_license_button}
    Click Button    ${revoke_license_button}
    Wait Until Element Is Visible    ${revoke_modal_title}    timeout=20s
    Input Text    ${license_key_input}    ${serial_key_number}
    Click Button    ${revoke_license_confirm_button}
    Wait Until Element Is Visible    ${activate_device_heading}    timeout=20s