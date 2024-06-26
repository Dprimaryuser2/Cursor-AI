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
