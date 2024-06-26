*** Settings ***
Library    SeleniumLibrary
Variables    ../../../Environment/environment.py
Variables    ../../../PageObjects/POS/Login/login_locators.py


*** Keywords ***
Open Application | POS
    Open Browser     ${pos_url}    ${browser}
#    Open Browser     ${pos_url}    ${browser}    options=add_argument("--headless")
    Maximize Browser Window
#    Set Window Size    ${window_width}    ${window_height}

Login With Valid Username And Password | POS
    [Arguments]     ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Input Text    ${serial_key}    ${my_dict.serial_key}
    Click Button    ${register_button}
    Wait Until Element Is Visible    ${pos_username}    timeout=20s
    Input Text    ${pos_username}     ${my_dict.username_pos}
    Click Button    ${pos_continue_button}
    Wait Until Element Is Visible    ${pos_password}    timeout=20s
    Input Text    ${pos_password}    ${my_dict.password_pos}
    Click Button    ${pos_continue_button}
    Wait Until Element Is Visible    ${catalog_update}    timeout=20s
    Page Should Contain Element    ${catalog_update}
#    Page Should Contain Element    ${pos_dashboard}


