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
     

