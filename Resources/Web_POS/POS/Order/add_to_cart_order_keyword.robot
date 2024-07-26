*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Resource   ../../../../Resources/Web_POS/Login/login_keyword.robot
Library    ../../../../Resources/CustomKeywords/utilities.py
Library    utilities

*** Keywords ***

Click On Clear All Items Button
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
    END
    

Verify Clear All Items Clear the Items From Cart
    Wait Until Page Contains Element    ${cart_0}
    Page Should Contain Element    ${cart_0}
    Element Should Be Disabled    ${checkout_button}