*** Settings ***
Library    SeleniumLibrary
Variables    ../../../Environment/environment.py
Variables    ../../../PageObjects/Web_POS/Login/login_locators.py
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/add_to_cart_keyword.robot
Library    RequestsLibrary

*** Variables ***
${ENV}    PROD
${STAGING_URL}=      ${pos_url_staging}
${PROD_URL}=    ${pos_url_prod}
#${base_url_PROD}=    https://api.gozwing.com/
#${base_url_STAGING}=     https://staging.api.gozwing.com

*** Keywords ***
Open Application | POS
    Open Browser     ${${ENV}_URL}    ${browser}    options=add_argument("--headless")
    Set Window Size    ${window_width}    ${window_height}

Login With Valid Username And Password | POS
    [Arguments]     ${search_data}
    Inject JavaScript For Fetch
    Inject JavaScript For XHR
    ${my_dict}    Create Dictionary   &{search_data}
    Input Text    ${serial_key}    ${my_dict.serial_key}
    Click Button    ${register_button}
    Wait Until Element Is Visible    ${pos_username}    timeout=15s
    Input Text    ${pos_username}     ${my_dict.username_pos}
    Click Button    ${pos_continue_button}
    Wait Until Element Is Visible    ${pos_password}    timeout=15s
    Input Text    ${pos_password}    ${my_dict.password_pos}
    Click Button    ${pos_continue_button}
    Wait Until Page Does Not Contain Element    ${pos_continue_button}    timeout=20s
    Wait Until Page Does Not Contain Element    ${pos_password}    timeout=10s
    ${logs}    Execute JavaScript   return window.apiLogs;
    ${udidtoken}=    extract_udidtoken    ${logs}
    ${token}        Execute JavaScript    return localStorage.getItem('operations');
    ${extracted_data}    Extract Required Fields    ${token}
    ${updated_data}=    Merge And Update Data With Json Output     ${EXTRACTED_DATA}    ${udidtoken}    ${my_dict.serial_key}
    [Return]    ${updated_data}
    Log    ${updated_data}

Login Again With Same User Id And Password
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
    Open The Session    ${my_dict}
    Clear All Products

Get Test Data File
    [Arguments]    ${env}   ${STAGING_TD}    ${PROD_TD}
    ${test_data_file}=    Run Keyword If    '${env}' == 'PROD'    Set Variable    ${PROD_TD}    ELSE    Set Variable    ${STAGING_TD}
    [Return]    ${test_data_file}
    Log     ${test_data_file}

Inject JavaScript For Fetch
    Execute JavaScript
    ...   window._originalFetch = window.fetch;
    ...   window.fetch = function() {
    ...       return window._originalFetch.apply(this, arguments).then(function(response) {
    ...           response.clone().json().then(function(data) {
    ...               if (!window.apiLogs) window.apiLogs = [];
    ...               window.apiLogs.push({
    ...                   type: 'fetch',
    ...                   request: arguments[1],
    ...                   response: data
    ...               });
    ...           });
    ...           return response;
    ...       });
    ...   };

Inject JavaScript For XHR
    Execute JavaScript
    ...   (function() {
    ...       var originalXhrOpen = XMLHttpRequest.prototype.open;
    ...       var originalXhrSend = XMLHttpRequest.prototype.send;
    ...       XMLHttpRequest.prototype.open = function() {
    ...           this._url = arguments[1];
    ...           return originalXhrOpen.apply(this, arguments);
    ...       };
    ...       XMLHttpRequest.prototype.send = function() {
    ...           this.addEventListener('load', function() {
    ...               if (!window.apiLogs) window.apiLogs = [];
    ...               window.apiLogs.push({
    ...                   type: 'xhr',
    ...                   request: this._url,
    ...                   response: this.responseText
    ...               });
    ...           });
    ...           return originalXhrSend.apply(this, arguments);
    ...       };
    ...   })();

Get API Base URL
    ${environment}    Get Variable Value    ${ENV}
    ${base_url} =    Run Keyword If    '${environment}' == 'STAGING'    Set Variable    ${base_url_staging}
    ...            ELSE IF    '${environment}' == 'PROD'    Set Variable    ${base_url_prod}
    [Return]    ${base_url}

Revoke Licence Key | API
    [Arguments]      ${response}    ${pos_data}
    ${my_dict}    Create Dictionary   &{pos_data}
    ${base_url}    Get API Base URL
    ${body} =    Set Variable    ${response}
    ${status}=    Run Keyword And Return Status    ${body} == 'NULL'
    IF    ${status}
        Tear It Down If Test Case Failed    ${pos_data}
    ELSE
        ${header} =    Create Dictionary    Content-Type=application/json    Connection=keep-alive
        Create Session    revoke    ${base_url}    headers=${header}
        ${api_response} =    POST On Session    revoke    /revoke-licence    data=${body}    headers=${header}
        ${status_code}    Set Variable    ${api_response.status_code}
        IF    '${status_code}' != '200'
            Tear It Down If Test Case Failed    ${pos_data}
        ELSE IF    '${status_code}' == 'None'
            Tear It Down If Test Case Failed    ${pos_data}
        ELSE
            Reload Page
            Logout After Revoke     ${response}     ${my_dict}
            Delete All Cookies
            Execute JavaScript    window.localStorage.clear();
            Execute JavaScript    window.sessionStorage.clear();
            Reload Page
        END
    END
    Close Browser

Logout After Revoke
    [Arguments]    ${response}      ${my_dict}
    ${updated_response}=    modify_json_data    ${response}    ${my_dict.user_mobile}
    ${header}=    Create Dictionary    Content-Type=application/json    Connection=keep-alive
    ${base_url}    Get API Base URL
    Create Session    logout    ${base_url}    headers=${header}
    ${api_response}=    GET On Session    logout    /vendor/logout    data=${updated_response}    headers=${header}
    Log    API Response: ${api_response}
