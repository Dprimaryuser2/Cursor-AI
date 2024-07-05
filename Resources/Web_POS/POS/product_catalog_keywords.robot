*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../Resources/CustomKeywords/utilities.py
Variables    ../../../PageObjects/Web_POS/POS/hold_bill_locators.py
Variables   ../../../PageObjects/Web_POS/POS/checkout_locators.py
Variables   ../../../PageObjects/Web_POS/POS/pos_locators.py
Variables   ../../../PageObjects/Web_POS/POS/add_customer_locator.py
Resource    ../../AdminConsole/Login/login_keyword.robot
Variables   ../../../PageObjects/AdminConsole/ProductCategories/product_categories.py

*** Keywords ***
Verify View Catalog Using Catalog Button In WebPOS
     Wait Until Page Contains Element    ${view_catalog_button}
     Click Element    ${view_catalog_button}
     Wait Until Page Contains Element    ${hide_catalog_button}
     Page Should Contain Element    ${hide_catalog_button}
     Page Should Contain Element    ${categories_button}
     Page Should Contain Element    ${sub_categories_first_option}
     
Verify Hide Catalog using Hide button in WebPOS     
    Wait Until Page Contains Element    ${hide_catalog_button}
    Click Element    ${hide_catalog_button}
    Wait Until Page Contains Element    ${view_catalog_button}
    Page Should Contain Element    ${view_catalog_button}
    Page Should Contain Element    ${add_carry_bag_button}

Verify Refresh catalog using refresh button
   Wait Until Page Contains Element    ${refresh_button}
   Click Element    ${refresh_button}
   Wait Until Page Contains Element    ${done_progress}
   Page Should Contain Element    ${done_progress}

Navigate To Product & Catalogue | Console
   Wait Until Page Contains Element   ${product_categories_c}  timeout=10s
   Click Element    ${product_categories_c}
   Wait Until Page Contains Element    ${product_categories_sidebar_option_c}  timeout=10s
   Click Element    ${product_categories_sidebar_option_c}
   
Add New Category | Console
   [Arguments]    ${product_data}
   ${product_dict}    Create Dictionary   &{product_data}
   Wait Until Page Contains Element    ${add_category}
   Click Element    ${add_category}
   Wait Until Page Contains Element    ${new_category_title}
   Input Text    ${new_category_name}    ${product_dict.new_category_admin}
   Wait Until Page Contains Element    ${create_new_category_button}
   Click Element    ${create_new_category_button}
#   ${status}  Run Keyword And Return Status    Page Should Contain Element    ${category_created_successfully}
#   IF    ${status}
#       Allocate New Category To Store   ${product_dict}
#   ELSE
#       Wait Until Page Contains Element    ${category_already_exist}
#       Click Element    ${new_category_close_icon}
#       Allocate New Category To Store   ${product_dict}
#   END

Allocate New Category To Store
   [Arguments]    ${product_data}
   ${product_dict}    Create Dictionary   &{product_data}
   Wait Until Page Contains Element    ${inventory_c}   timeout=10s
   Click Element    ${inventory_c}
   Wait Until Page Contains Element    ${item_allocation_c}
   Click Element    ${item_allocation_c}
   Wait Until Page Contains Element    ${item_allocation_title}
   Click Element    ${new_item_allocation_button}
   Wait Until Page Contains Element    ${title_item_allocation}
   Click Element    ${all_stores_dropdown}
   Input Text    ${search_store}    ${product_dict.search_store}
   Sleep  2s
   Wait Until Page Contains Element    ${first_option_store_dropdown}
   Click Element    ${first_option_store_dropdown}

Verify New Category Is Visible
     [Arguments]    ${product_data}
     ${product_dict}    Create Dictionary   &{product_data}
     Wait Until Page Contains Element    ${view_catalog_button}
     Click Element    ${view_catalog_button}
     Wait Until Page Contains Element    ${hide_catalog_button}
     Page Should Contain Element    ${hide_catalog_button}
     Page Should Contain Element    ${categories_button}
     Page Should Contain Element    ${sub_categories_first_option}
     Element Should Contain    ${category_sidebar}    ${product_dict.new_category_admin}

Navigate To Products | Console
    Wait Until Page Contains Element   ${product_categories_c}  timeout=10s
    Click Element    ${product_categories_c}
    Wait Until Page Contains Element    ${product_sidebar_option_c}
    Click Element    ${product_sidebar_option_c}
    Wait Until Page Contains Element    ${product_title}
    Wait Until Page Contains Element    ${new_product_button}
    Click Element    ${new_product_button}
    
Create New Products | Console
    [Arguments]    ${product_data}
    ${product_dict}    Create Dictionary   &{product_data}
    Wait Until Page Contains Element    ${new_product_title}  timeout=15s
    Input Text    ${product_name}    ${product_dict.product_name}
    Input Text    ${product_department}    ${product_dict.product_department}
    Input Text    ${product_description}     ${product_dict.product_description}
    Input Text    ${product_short_description}     ${product_dict.product_description}
    Input Text    ${product_brand}    ${product_dict.product_brand}
    Wait Until Page Contains Element    ${select_category_product}  timeout=15s
    Input Text    ${enter_category_name}    ${product_dict.product_category}
    Press Keys     ${enter_category_name}     ENTER
    Input Text    ${product_mrp}    ${product_dict.product_mrp}
    Input Text    ${product_rsp}    ${product_dict.product_rsp}
    Input Text    ${product_special_price}    ${product_dict.product_special_price}
    Click Element    ${unit_and_inventory}
    Wait Until Page Contains Element    ${choose_unit_inventory}   timeout=15s
    Click Element    ${choose_unit_inventory}
    Press Keys    ${enter_inventory_name}     ${product_dict.uom}
    Click Element    ${product_variant}
    Wait Until Page Contains Element    ${product_barcode_variant}   timeout=15s
    Input Text    ${product_barcode_variant}    ${product_dict.barcode}
    Input Text    ${mrp_variant}    ${product_dict.product_mrp}
    Input Text    ${rsp_variant}    ${product_dict.product_rsp}
    Input Text    ${special_price_variant}    ${product_dict.product_special_price}
    Wait Until Page Contains Element    ${save_product_button}
    Click Element    ${save_product_button}

Verify New Product Is Visible In Category
     [Arguments]    ${product_data}
     ${product_dict}    Create Dictionary   &{product_data}
     Wait Until Page Contains Element    ${view_catalog_button}
     Click Element    ${view_catalog_button}
     Wait Until Page Contains Element    ${hide_catalog_button}
     Page Should Contain Element    ${hide_catalog_button}
     Page Should Contain Element    ${categories_button}
     Page Should Contain Element    ${sub_categories_first_option}
     Element Should Contain    ${category_sidebar}    ${product_dict.new_category_admin}
     ${custom_category}=    Replace String    ${category_sidebar_option}    Body Scrub     ${product_dict.new_category_admin}
     Click Element    ${custom_category}
     Element Should Contain    ${product_catalog_body}     ${product_dict.product_name}
<<<<<<< HEAD
     
Navigate To Retail Price Book | Console
    Wait Until Page Contains Element   ${product_categories_c}  timeout=10s
    Click Element    ${product_categories_c}
    Wait Until Page Contains Element    ${retail_pb_sidebar_option_c}  timeout=10s
    Click Element    ${retail_pb_sidebar_option_c}
    Wait Until Page Contains Element    ${create_new_pb_retail_button}  timeout=10s
    Click Element    ${create_new_pb_retail_button}

Create New PriceBook | Console
    [Arguments]    ${product_data}
    ${product_dict}    Create Dictionary   &{product_data}
    Wait Until Page Contains Element    ${new_pb_option_retail}  timeout=10s
    Click Element    ${new_pb_option_retail}
    Wait Until Page Contains Element    ${new_retail_pb_title}  timeout=10s
    Input Text    ${price_book_name}    ${product_dict.price_book_name}
    Click Element    ${switch_to_search_btn}
    Input Text    ${search_product_retail_pb}    ${product_dict.new_category_admin}
    Wait Until Page Contains Element    ${first_result_product_retail_pb}  timeout=10s
    Click Element    ${first_result_product_retail_pb}
    Wait Until Page Contains Element    ${continue_btn_new_retail_pb}  timeout=10s
    Click Element    ${continue_btn_new_retail_pb}
    ${status}  Run Keyword And Return Status    Element Should Be Visible    ${price_book_created_successfully}
    IF    ${status}
       Allocate Price Book To Store | Console  ${product_data}
    ELSE
       Wait Until Page Contains Element    ${discard_btn_new_retail_pb}  timeout=10s
       Click Element    ${discard_btn_new_retail_pb}
       Wait Until Page Contains Element    ${discard_price_book_window_title}  timeout=10s
       Click Element    ${yes_discard_btn_discard_window}
    END
    
Allocate Price Book To Store | Console
    [Arguments]    ${product_data}
    Wait Until Page Contains Element    ${allocate_pb_window_title}   timeout=10s
    Click Element    ${allocate_pb_window_allocate_btn}
    Wait Until Page Contains Element    ${allocate_retail_pb_title}   timeout=10s
    Input Text    ${store_select_allocate_retail_pb}     ${product_data}
    Wait Until Page Contains Element    ${first_store_select_checkbox}  timeout=10s
    Click Element    ${first_store_select_checkbox}
    Element Should Be Enabled    ${continue_button_allocate_retail_pb}
    Click Element    ${continue_button_allocate_retail_pb}
    
Verify New PriceBook Product Is Visible
     [Arguments]    ${product_data}
     ${product_dict}    Create Dictionary   &{product_data}
     Wait Until Page Contains Element    ${view_catalog_button}
     Click Element    ${view_catalog_button}
     Wait Until Page Contains Element    ${hide_catalog_button}
     Page Should Contain Element    ${hide_catalog_button}
     Page Should Contain Element    ${categories_button}
     Page Should Contain Element    ${sub_categories_first_option}
     Element Should Contain    ${category_sidebar}    ${product_dict.new_category_admin}
     ${custom_category}=    Replace String    ${category_sidebar_option}    Body Scrub     ${product_dict.new_category_admin}
     Click Element    ${custom_category}
     Element Should Contain    ${product_catalog_body}     ${product_dict.price_book_name}
     ${custom_pricebook}=  Replace String    ${product_name_in_catalog}    Ranger Alex     ${product_dict.price_book_name}
     Wait Until Page Contains Element    ${custom_pricebook}  timeout=10s
     Click Element    ${custom_pricebook}
     Wait Until Page Contains Element    ${select_mrp}  timeout=10s
     Element Should Be Visible    ${select_mrp}

Verify Items Allocated With 0 Inventory To Store Are Blur
     [Arguments]    ${product_data}
     ${product_dict}    Create Dictionary   &{product_data}
     Wait Until Page Contains Element    ${view_catalog_button}
     Click Element    ${view_catalog_button}
     Wait Until Page Contains Element    ${hide_catalog_button}
     Page Should Contain Element    ${hide_catalog_button}
     Page Should Contain Element    ${categories_button}
     Page Should Contain Element    ${sub_categories_first_option}
     Element Should Contain    ${category_sidebar}    ${product_dict.new_category_admin}
     ${custom_category}=    Replace String    ${category_sidebar_option}    Body Scrub     ${product_dict.new_category_admin}
     Click Element    ${custom_category}
     Element Should Contain    ${product_catalog_body}     ${product_dict.product_name}
     Page Should Contain Element    //locator_of_0_inventory_product_with_blur

Verify Items Allocated With Some Inventory To Store Are Normal
     [Arguments]    ${product_data}
     ${product_dict}    Create Dictionary   &{product_data}
     Wait Until Page Contains Element    ${view_catalog_button}
     Click Element    ${view_catalog_button}
     Wait Until Page Contains Element    ${hide_catalog_button}
     Page Should Contain Element    ${hide_catalog_button}
     Page Should Contain Element    ${categories_button}
     Page Should Contain Element    ${sub_categories_first_option}
     Element Should Contain    ${category_sidebar}    ${product_dict.new_category_admin}
     ${custom_category}=    Replace String    ${category_sidebar_option}    Body Scrub     ${product_dict.new_category_admin}
     Click Element    ${custom_category}
     Element Should Contain    ${product_catalog_body}     ${product_dict.product_name}
     ${inventory_product}=    Replace String    ${product_with_some_inventory}    Carry bag     ${product_dict.product_name}
     Page Should Contain Element    ${inventory_product}

Add All Variants Of Multiple Price Books
    [Arguments]    ${product_data}
    ${product_dict}    Create Dictionary   &{product_data}
    ${price_list}=    Create List    
    Wait Until Element Is Visible    ${scan_only}    timeout=20s
    ${clear_item_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${clear_all_items}
    IF    ${clear_item_enabled}
      Click Element    ${clear_all_items}
      Wait Until Element Is Not Visible    ${first_item_product_name}     timeout=20s
    END
    ${items_list}=    Convert Items To List    ${product_dict.buy_items}
    ${items_dict} =    Convert Item List To Dictionary    ${product_dict.buy_items}
    FOR    ${item}    IN    @{items_dict.items()}
            ${key}=    Set Variable    ${item}[0]
            ${values}=    Set Variable    ${item}[1]
            ${value}=    Convert To String    ${values}
            Sleep    0.5s
            Click Element    ${product_search_bar}
            Input Text    ${product_search_bar}    ${key}
            Wait Until Element Is Enabled    ${search_add_button}    timeout=20s
            Sleep    0.5s
            Click Element    ${search_add_button}
            Wait Until Element Is Visible    //table[@class="table b-table table-cutom widthfixed b-table-selectable b-table-select-single"]     timeout=10s
            ${count}    Get Element Count    //td[@aria-colindex="4"]/p
            Click Element    ${close_button}
        END
    FOR    ${i}    IN RANGE    1     ${count}+1
        FOR    ${item}    IN    @{items_dict.items()}
            ${key}=    Set Variable    ${item}[0]
            ${values}=    Set Variable    ${item}[1]
            ${value}=    Convert To String    ${values}
            Sleep    0.5s
            Click Element    ${product_search_bar}
            Input Text    ${product_search_bar}    ${key}
            Wait Until Element Is Enabled    ${search_add_button}    timeout=20s
            Sleep    0.5s
            Click Element    ${search_add_button}
        END
        Wait Until Element Is Visible    (//td[@aria-colindex="4"]/p)[${i}]    timeout=20s
        ${price}=    Get Text    (//td[@aria-colindex="4"]/p)[${i}]
        ${price}    Remove Characters    ${price}
        ${price}    Convert To Number    ${price}
        ${values}    Convert To Number    ${values}
        ${price}    Evaluate    ${price}*${values}
        ${price}    Convert To String    ${price}
        Append To List    ${price_list}    ${price}
        Click Element    (//td[@aria-colindex="4"]/p)[${i}]
        Click Button    ${add_to_cart_mrp}
        Wait Until Element Is Visible    ${add_toggle_button}    timeout=10s
        Input Text    ${quantity_input}    ${value}
        Click Element    ${update_cart_quantity}
        Wait Until Element Is Visible    ${table}    timeout=10s
        Sleep    1s
        Element Should Contain    ${table}    ${price}
    END
