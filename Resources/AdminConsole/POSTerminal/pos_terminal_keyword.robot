*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    ../../../Resources/CustomKeywords/utilities.py
Variables   ../../../PageObjects/AdminConsole/POSTerminal/pos_terminal.py

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}TestData${/}POS${/}Promo${/}pos_test_data.xlsx

*** Keywords ***
Go To Pos Terminal Page
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_01
    ${pos_td}    Create Dictionary    &{pos_data}
    Click Element    ${pos_terminal_link}
    Wait Until Element Is Visible    ${pos_heading}    timeout=10s
    ${serial_key}=    Convert To String    ${pos_td.serial_key}
    Input Text    ${pos_search_bar}    ${serial_key}
    Sleep    2s
    ${tagged_device_edit}=    Replace String    ${tagged_device_edit_link}    Serial_Key    ${serial_key}
    Sleep    0.5s
    Click Element    ${tagged_device_edit}
    Wait Until Element Is Visible    ${edit_modal_body}
    Page Should Contain Element    ${edit_modal_title}
    ${if_device_tagged}=    Run Keyword And Return Status    Element Should Be Visible    ${remove_device_icon}
    IF    ${if_device_tagged}
        Click Element    ${remove_device_icon}
        Wait Until Element Is Visible    ${remove_modal_body}    timeout=10s
        Click Element    ${remove_button}
    END


Change Salesperson Tagging To Mandatory In POS
    Wait Until Page Contains Element    ${setup_and_more}    timeout=20
    Click Element    ${setup_and_more}
    Wait Until Page Contains Element    ${policies}    timeout=20
    Click Element    ${policies}
    Wait Until Page Contains Element    ${pencil_icon_in_policy_p8}    timeout=20
    Click Element    ${pencil_icon_in_policy_p8}
    Wait Until Page Contains Element    ${pos_dropdown_in_policies}    timeout=10
    Click Element    ${pos_dropdown_in_policies}
    Wait Until Page Contains Element    ${tag_salesperson_toggle_on}    timeout=20
    Wait Until Page Contains Element    ${radio_tag_sp_mandatory}    timeout=20
    Click Element    ${radio_tag_sp_mandatory}
    Wait Until Element Is Enabled    ${save_policies}    timeout=20
    Click Element    ${save_policies}
    Wait Until Page Contains Element    ${pencil_icon_in_policy_p8}    timeout=20

Change Salesperson Tagging To Optional In POS
    Wait Until Page Contains Element    ${pencil_icon_in_policy_p8}    timeout=20
    Click Element    ${pencil_icon_in_policy_p8}
    Wait Until Page Contains Element    ${pos_dropdown_in_policies}    timeout=10
    Click Element    ${pos_dropdown_in_policies}
    Wait Until Page Contains Element    ${tag_salesperson_toggle_on}    timeout=20
    Wait Until Page Contains Element    ${radio_tag_sp_optional}    timeout=20
    Click Element    ${radio_tag_sp_optional}
    Wait Until Element Is Enabled    ${save_policies}    timeout=20
    Click Element    ${save_policies}
    Wait Until Page Contains Element    ${pencil_icon_in_policy_p8}    timeout=20
