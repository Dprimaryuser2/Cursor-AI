*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../Resources/CustomKeywords/utilities.py
Variables   ../../../PageObjects/Web_POS/POS/pos_locators.py
Variables   ../../../PageObjects/Web_POS/POS/add_customer_locator.py

*** Keywords ***

Add Weighted UOM Products to Cart | Edit Cart Quantity Mode
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    Log    ${my_dict.buy_items}
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
    END
    ${items_list}=    Convert Items To List    ${my_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${my_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
        ${key}=    Set Variable    ${item}[0]
        ${values}=    Set Variable    ${item}[1]
        ${value}=    Convert To String    ${values}
        Click Element    ${product_search_bar}
        Input Text    ${product_search_bar}    ${key}
        Wait Until Element Is Enabled    ${search_add_button}    timeout=20s
        Click Element    ${search_add_button}
    END
    # edit cart

Update Product Quantity | Edit Cart Quantity Mode
    [Arguments]    ${products}
    ${my_dict}    Create Dictionary   &{products}
    ${edit_toggle_enabled}    Run Keyword And Return Status    Element Should Be Visible    ${edit_toggle_on}
    IF    ${edit_toggle_enabled}
        Input Text    ${quantity_input}    ${my_dict.}

Update Product Quantity | Add Cart Quantity Mode

Add Items From Previous Session
