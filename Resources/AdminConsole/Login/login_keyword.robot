*** Settings ***
Library    SeleniumLibrary
Variables  ../../../Environment/environment.py
Variables   ../../../PageObjects/AdminConsole/Login/login.py


*** Keywords ***
Open Application | Admin
#    Open Browser     ${admin_console_url}    ${browser}
    Open Browser     ${admin_console_url}    ${browser}    options=add_argument("--headless")
    Maximize Browser Window
    Set Window Size    ${window_width}    ${window_height}

Login With Valid Username And Password
    [Arguments]     ${search_data}
    ${my_dict}    Create Dictionary   &{search_data}
    Input Text    ${email}    ${my_dict.username_admin}
    Wait Until Element Is Visible    ${password}    timeout=20s
    Input Text    ${password}    ${my_dict.password_admin}
    Click Button    ${continue_button}
    Wait Until Page Contains Element    ${dashboard}    timeout=20s
    Page Should Contain Element    ${invoice_icon}
    Page Should Contain Element    ${product_icon}
    Page Should Contain Element    ${promotion_icon}

Login Into Admin | Zwing
    Input Text    ${email}      zwshashank.agrawal@teampureplay.com
    Wait Until Element Is Visible    ${password}    timeout=20s
    Input Text    ${password}    123456
    Click Button    ${continue_button}
    Wait Until Page Contains Element    ${dashboard}    timeout=20s
    Page Should Contain Element    ${invoice_icon}
    Page Should Contain Element    ${product_icon}
    Page Should Contain Element    ${promotion_icon}
