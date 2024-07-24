# catalog updated
done_progress = '//button[@id="done-progress"]'
closing_balance = '//input[@placeholder="Enter closing balance"]'
force_close_button = '//button[@class="btn ml-1 btn-danger btn-block"]'
force_close_element = "//span[text()='Force Close Session']"
open_session_submit_button = '//button[@id="session-cont"]'
opening_balance = '//input[@id="session-input"]'
in_store = '//a[text()="In-Store"]'
delivery = '//a[text()="Delivery"]'
switch_billing_dropdown = '//div[@class="dropdown b-dropdown switch-billing fs-12 float-right btn-group"]'
billing_option = '//ul[@class="dropdown-menu show"]//a[text()="Billing"]'
return_option = '//ul[@class="dropdown-menu show"]//a[text()="Return"]'
order_option = '//ul[@class="dropdown-menu show"]//a[text()="Order"]'
exchange_option = '//ul[@class="dropdown-menu show"]//a[text()="Exchange"]'
switch_confirm_button = '//button[@id="switch-mode-confirm"]'
switch_cancel_button = '//button[@id="switch-mode-cancel"]'
switch_modal_text = '//div[@class="modal-body"]//span'
clear_all_items = "(//button[@class='btn mr-1 btn-danger btn-block'])[2]"
view_catalog_button = '//button[@id="view-catalog"]'
categories_button = '//ul[@id="infinite-categories"]//li[@class="nav-item"]/a[contains(text(),"Body Oil")]'     # replace body oil with desired data
sub_categories_first_option = '((//div[@class="w-100 position-relative"]//ul[@id="infinite-list"]//div)[1]/h6)[1]'
hide_catalog_button = '//div[@class="catlog-search-pl-6p col-md-3 col-lg-3"]//button[text()="Hide" and @style="padding: 0.61rem 1rem;"]'
refresh_button = '//button[@id="refresh-catalog"]'
product_search_bar = '//input[@id="product-search"]'
search_add_button = '//button[@class="btn alternative add-to-cart btn-info"]'
scan_only = '//div[@class="v-switch-button"]'
salesperson_button = '//button[@id="category-salesperson"]'
salesperson_refresh = "//button[text()='Refresh']"
salesperson_dropdown = '//span[contains(text(),"Select Salesperson")]'
salesperson_search_field = '//input[@placeholder="Search..."]'
salesperson = '//input[@placeholder="Search..."]//ancestor::div[@class="dropdown-body w-100"]//li'
assign_salesperson_window_heading = '//p[@class="mb-0"]//b[text()="Assign Salesperson"]'
assign_salesperson_search = '//input[@class="search pl-0 form-control"]'
name_in_assign_salesperson_row = '//tr[@tabindex="0"]//td[@class="text-left align-middle"]'
assign_to_all_button = '//button[@class="btn btn-primary"]//span[text()="Assign to All"]'
close_assign_salesperson_window = '//div[@class="col-md-6"]//*[name()="svg"]'
salesperson_tagged_message = '//div[@class="alert alert-dismissible alert-success" and contains(text(),"Salesperson tagged successfully")]'
salesperson_mandatory_message = '//div[@class="alert alert-dismissible alert-danger" and text()="Sales Person is Mandatory"]'
salesperson_below_product = '//span[@class="pt-2 fs-12 text-grey"]'
salesperson_exchange = '(//span[@class="pt-2 fs-12 text-grey"])[1]'
salesperson_exchange_alternate = '(//span[@class="pt-2 fs-12 text-grey"])[2]'
close_icon_salesperson_dropdown = '//div[@class="w-100"]//div//*[name()="svg"]'
salesperson_untagged_message = '//div[@class="alert alert-dismissible alert-success" and text()="Salesperson untagged."]'

view_held_bills = '//button[@id="category-held-bills"]'
hold_bill = '//button[@id="category-hold-bill"]'
hold_bill_confirmation = '//button[@id="put-hold-bill"]'
hold_bill_cancel = '//button[@id="cancel-hold-bill"]'
apply_promo = '//button[@id="category-promotions"]'
apply_manual_discount = '//button[@id="category-apply-discount"]'
add_carry_bags = '//button[@id="category-add-carrybags"]'
promo_name = '//span[@class="offer active text-green"]'
quantity_row = '(//td[@aria-colindex="3"])[1]'
weighted_quantity = '//button[@id="weight-btn-null"]'
product_search_dropdown = '//ul[@id="product-list"]'
# piece
quantity_in_piece_button = '(//td[@aria-colindex="3"]//button[@id="weight-btn-null"])[1]'    # this is button which selects the piece of item and a modal comes after clicking this
piece_quantity_value = '(//td[@aria-colindex="3"]//button[@id="weight-btn-null"])[1]/span'
piece_modal = '//div[@class="modal-content"]'
quantity_input = '//input[@id="qtyInput"]'
update_cart_quantity = '//div[@class="modal-content"]//button[@class="btn btn-primary btn-block"]'
switch_edit_add_toggle = '//div[@class="modal-body"]//div[@class="v-switch-button"]'    # This switches between edit cart and add to cart
edit_toggle_on = '//div[@class="modal-body"]//label[@class="my-auto vue-js-switch toggled"]'
add_toggle_button = '//div[@class="modal-body"]//label[@class="my-auto vue-js-switch"]'
# units
custom_select_quantity_button = '(//select[@class="custom-select custom-select-sm"])[1]'      # change the number
custom_select_options = '//select[@class="custom-select custom-select-sm"]//option[@value="option_value"]'     # change the option to the number you want to select
custom_select_quantity = '//span[text()="ITEM"]//ancestor::td//following-sibling::td//option[@value="option_value"]'
price = '(//td[@aria-colindex="4"])[1]'
discount_field = '(//td[@aria-colindex="5"])[1]'
discount_field_row_2 = '(//td[@aria-colindex="5"])[2]'
net_price = '//td[@aria-colindex="6"]'
cancel_item = '(//td[@aria-colindex="6"])[1]'
item_cart_table = '//table[contains(@class,"table b-table table cart-table mt-0 table-dark table-dark-bg b-table-row-selected td:first-child border-bottom-0 b-table-selectable b-table-select-single")]'
table = '//td[@aria-colindex="2"]//ancestor::tbody[@role="rowgroup"]'
first_item_product_name = '(//a[contains(@class,"product-name")])[1]'
second_item_product_name = '(//a[contains(@class,"product-name")])[2]'
sub_total = '//p[contains(text(),"Sub Total")]//ancestor::div[@class="row mb-1"]//following-sibling::div/p'
taxes = '//p//span[contains(text(),"Taxes")]//ancestor::div[@class="row mb-1"]//following-sibling::div/p'
bill_promo_discount = '//span[contains(text(),"Bill Promo Discount")]//ancestor::div[@class="row mb-1"]//following-sibling::div/p'
promo_discount = '//p[contains(text(),"Item Promo Discount")]//ancestor::div[@class="row mb-1"]//following-sibling::div/p'
included_tax_text = '//p[contains(text(),"Tax Total (Included)")]'
excluded_tax_text = '//p[contains(text(),"Tax Total (Excluded)")]'
round_off_text = '//p[contains(text(),"Round Off")]'
onclick_remove_salesperson="//div[@class='w-100']//div//span"
round_off_element = '//p[contains(text(),"Round Off")]//ancestor::div[@class="row mb-1"]//following-sibling::div/p'
tax_amount = '//p[contains(text(),"Tax Total ")]//ancestor::div[@class="row mb-1"]//following-sibling::div/p'
tax_amount_excluded = '//p[contains(text(),"Tax Total (Excluded)")]//ancestor::div[@class="row mb-1"]//following-sibling::div/p'
payable_amount = "//p[text()='Payable Amount']//ancestor::div[@class='col light t_amt']//following-sibling::div[@class='col text-right']//h6[@class='mb-0']"
available_promotions_link = '//img[@src="/img/info.1c91eacc.svg"]'
promo_body = '//div[@class="modal-body"]//tbody'
save_and_close = '//button[@class="btn btn-primary" and text()="Save & Close"]'
# locators for assortment 1
category = '(//ul[@id="infinite-categories"]/li)[1]'
# assortment 2
second_category = '(//ul[@id="infinite-categories"]/li)[2]'

delete_item="//p[contains(text(),'To be exchanged with')]//ancestor::td//following-sibling::td//a"
# dynamic
quantity_column = '//span[contains(text(),"barcode")]//ancestor::tr//td[@aria-colindex="3"]'    # change barcode
price_column = '=//span[contains(text(),"barcode")]//ancestor::tr//td[@aria-colindex="4"]'    # change barcode
discount_column = '//span[contains(text(),"barcode")]//ancestor::tr//td[@aria-colindex"5"]'     # change barcode
net_price_column = '//span[contains(text(),"barcode")]//ancestor::tr//td[@aria-colindex="6"]'    # change barcode
item_link = '//span[contains(text(),"barcode")]//preceding-sibling::a'   # change barcode

# Product modal Dialog box
product_link = '//span[contains(text(),"JVLSpeaker")]//preceding-sibling::a'     # Replace JVLSpeaker with product name     # add
modal_box = '//div[@class="modal-content"]'
modal_qty_in_cart_div = '//label[@id="label-qty-productpopup"]//following-sibling::div'
modal_qty = '//div[contains(@class,"dropdown-body")]//li/span[text()="Quantity"]'   # Replace Quantity with Number you wannt to select
select_batch_arrow = '//input[@placeholder="Select/change batch"]//following-sibling::div'
price_field = '//label[@id="label-price-override-productpopup"]//following-sibling::input'
price_override_link = '//a[@id="price-override-productpopup"]'
price_override_link_disable = '//a[@id="price-override-productpopup" and @class="disabled"]'
price_override_heading = '//h5[contains(text(),"Price Override")]'
price_override_custom_price_field = '//input[@id="Cust-Price"]'
apply_override_button = '//button[@id="apply-price-override-btn"]'
manual_discount_arrow = '//input[@id="item-manual-discount-productpopup"]//following-sibling::div'
manual_discount_heading = '//h5[contains(text(),"Manual Discount")]'
select_from_list_tab = '//a[contains(normalize-space(),"Select from List")]'
list_discount_radio = '//li[@id="disc"]'  # change disc with Manual Discount name
custom_discount_tab = '//a[contains(normalize-space(),"Custom Discount")]'
apply_manual_discount_button = '//button[@id="apply-manual-discount"]'
manual_discount_applied_message = '//div[@class="alert alert-dismissible alert-danger" and @contains(text(),"Applied")]'
discount_type_amount = '//span[contains(text(),"Amount")]//ancestor::div[@class="custom-control custom-control-inline custom-radio"]'
discount_type_percentage = '//span[contains(text(),"Percentage")]//ancestor::div[@class="custom-control custom-control-inline custom-radio"]'
discount_value = '//input[@id="discount-value"]'
apply_percent_discount_button = '//button[@id="apply-percentage"]'
apply_amount_discount_button = '//button[@id="apply-discount"]'
active_promotion = '//span[text()="View Available Promotion(s)"]'

item_remark = '//input[@id="input-remark-productpopup"]'
open_session_before_continuing ='//h6[@class="mb-2 fs-14" and text()="Open Session before continuing"]'
check_inventory_button = '//button[@id="check-inventory-btn"]'
inventory_modal_heading = '//h5[contains(text(),"Inventory")]'
inventory_close_button = '//h5[contains(text(),"Inventory")]//following-sibling::button'
update_product_button = '//button[@id="update-product-btn"]'
quantity= "//input[@id='qtyInput' and @placeholder='Enter Weight']"
cart_product_checkbox = '//div[@class="custom-check pt-0"]//span//input[@type="checkbox"]'
# Carry Bags
carry_bag_heading = '//h5[contains(text(),"Select Carry Bags")]'
carry_bag_input_field = '//h6[@id="label-undefined" and text()="Carry bag"]//ancestor::div[@class="row mb-2"]//input'
carry_bag_amount_field = '//h6[@id="label-undefined" and text()="Carry bag"]//ancestor::div[@class="row mb-2"]//span'
add_carry_bag_unit_button = '//button[@id="add-carry-bags"]'
close_button = '//button[@class="close"]'
open_session_link = '//div[@class="fadein col-md-6 col-lg-6" and not(@style="display: none;")]//div[@id="session-info"]//a'
select_mrp="//h5[@class='modal-title' and contains(text(),'Select MRP')]"
select_mrp_refresh="//button[@class='btn add-to-cart serve-refresh btn-light btn-sm' and contains(text(),'Refresh')]"
add_to_cart_mrp="//button[@id='multiple-mrp-add-to-cart' and @class='btn m-0 custom-btn btn-secondary']"
invoice_not_found='//div[@class="alert alert-dismissible alert-danger"]'
confirm_exchange="//button[@class='btn ml-1 btn-primary btn-block']"
# Discard after half payment
discard_payment_bill = '//p[contains(normalize-space(),"Discard Bill")]'
discard_confirm = '//span[text()="Yes, Discard"]'
cart_0 = "//span[@class='quantity h5 mb-0 mr-1' and contains(text(),'(0)')]"
back_icon_on_checkout = '//img[@class="icon text-white"]'
cart_quantity = "//span[@class='quantity h5 mb-0 mr-1']"
# Manual Discount assertion fields
update_product_subtotal = '//label[contains(text(),"Subtotal")]//following-sibling::p'
update_product_cumulative_discount = '//label[contains(text(),"Cumulative Discount")]//following-sibling::p'
update_product_taxes = '//label[contains(text(),"Product Taxes")]//following-sibling::p'
update_product_total = '//label[contains(text(),"Product Total")]//following-sibling::p'

disabled_select_from_list_tab = '//a[contains(normalize-space(),"Select from List") and @aria-disabled="true"]'
disabled_custom_discount_tab = '//a[contains(normalize-space(),"Custom Discount") and @aria-disabled="true"]'
disabled_item_level_discount_alert = '//div[@class="popup-notification"]/div[contains(text(),"Item level manual discount is disabled from policy.")]'

catalog_update_failed_heading = '//h5[contains(text(),"Catalog Update Failed")]'
catalog_close_button = '//button[@id="close-progress"]'
catalog_retry_button = '//button[@id="retry-progress"]'
manual_close_button = '//h5[text()="Manual Discount(Item)"]//following-sibling::button[@aria-label="Close"]'

add_carry_bag_button='//button[@id="category-add-carrybags"]'
carry_bag_add='//button[@id="add-carry-bags"]'
carry_bag_added_message = '//div[@class="alert alert-dismissible alert-success" and text()="Carry bag(s) added successfully."]'
product_added_successfully = '//div[@class="alert alert-dismissible alert-success" and contains(text(),"Product was successfully added to your cart")]'
product_quantity_updated = '//div[@class="alert alert-dismissible alert-success" and contains(text(),"Product quantity successfully Updated")]'
price_override_successful = '//div[@class="alert alert-dismissible alert-success" and contains(text(),"Price overridden successfully.")]'

# sidebar locators
inventory_option_sidebar = "//a[@title='Inventory']"
cash_management_option_sidebar = "//li[@title='Cash Management']//a//img"
pos_option_sidebar = "//a[@id='nav-pos']//img"
order_management_option_sidebar = "//a[@title='Order Management']//img"
# cash management locators
cash_management_heading = "//h5[text()='Cash Management']"
billing_option_switch_default = '//button[@class="btn dropdown-toggle btn-light" and contains(text(),"Billing")]'
order_option_switch = '//button[@class="btn dropdown-toggle btn-light" and contains(text(),"Order")]'
return_option_switch = '//button[@class="btn dropdown-toggle btn-light" and contains(text(),"Return")]'
exchange_option_switch = '//button[@class="btn dropdown-toggle btn-light" and contains(text(),"Exchange")]'
amount_limit_message = '//p[text()="Amount is greater than limit"]'
item_name = "//a[@class='product-name text-danger']"
cart_last_element = '(//td[@class="text-center align-middle w-5"])[last()]'
product_name_in_cart_row = '//br[@data-v-24c05cb9]//preceding-sibling::a[@data-v-24c05cb9]'
close_product_window_button = '//button[@class="close"]'
item_quantity_in_cart = '//span[@class="quantity h5 mb-0 mr-1"]'
quantity_product_window = '(//span[@data-v-59cb0948])[1]'
quantity_column_count = '//td[@aria-colindex="3"]'
quantity_column_buttons = '//button[@class="btn btn-outline-primary btn-block"]'
select_list_discount_div='//ul[@class="custom-checklist list-unstyled"]'
product_modal_close="//button[@class='close' and contains(text(),'×')]"
carry_bag_all_input_fields = '//div[@class="row mb-2"]//input[@placeholder="0"]'
carry_bag_option_label ='//h6[@id="label-undefined" and text()="Sync39"]'
delete_product_icon = '//a[@title="Delete Product"]//*[name()="svg"]//*[name()="path"]'

# customer_info_icon = "//body/div[@id='app']/div[@id='theme']/div[@class='dashboard']/section/div[@class='container-fluid']/div[@class='row']/div[@class='fadein col-md-6 col-lg-6']/div[@class='row mt-2']/div[@class='col-md-6 col-lg-6']/div[@id='customer-info']//a"
customer_info_icon = "//div[normalize-space(text())='Customer Information']/a[@id='get-customer-info']"
switch_modal_proceed_button = "//button[@class='btn ml-1 btn-primary btn-block']//span"
switch_modal_cancel_button = '//button[@class="btn mr-1 btn-outline-primary btn-block"]'
update_product_md = "//button[@id='update-product-btn' and @class='btn ml-2 btn-primary']//span"

#product preview locators
preview_salesperson_name = '//small[text()="Salesperson"]//following::*[1]'
product_preview = '//span[@class="offer text-muted"]'
product_preview_second = '(//span[@class="offer text-muted"])[2]'
row_in_salesperson_dropdown = '//li[@data-v-59cb0948]'

product_row_in_cart = '//tr[@class="b-table-row-selected table-active"]'
pos_settings = '//img[@id="nav-settings"]'
pos_settings_profile_info = '//h5[@class="fw-normal mb-3" and text()="Profile Information"]'
pos_settings_quick_actions = '//a[@class="nav-link" and text()="Quick Actions"]'
get_new_settings = '//h5[@class="mb-0" and text()="Get new settings"]'
negative_inventory_alert = '//div[@role="alert" and contains(text(),"Negative stock billing is not allowed")]'
close_session_icon = '//a[@id="nav-close-session" and contains(text(),"Close Session")]/img'
close_session_header = '//header[@id="session-box___BV_modal_header_"]//h5[text()="Close Session"]'
closing_balance_field = '//input[@id="session-input"]'
close_session_button = '//button[@id="session-cont"]'
session_closed_popup = '//div[@id="session-box___BV_modal_body_"]//p[contains(text(),"Session Closed")]'
session_close_button = '//button[@id="session-close"]'
session_print_slip_button = '//button[@id="print-session-slip"]'
logout_link = '//a[@id="logout_btn_nav"]/img'
logout_modal = '//div[@id="log_out___BV_modal_body_"]'
logout_cancel_button = '//div[@id="log_out___BV_modal_body_"]//button[contains(text(),"Cancel")]'
logout_button = '//span[contains(text(),"Logout")]//ancestor::button'

# previous session
add_items_from_previous_session = '//div[@class="modal-body"]//h6[contains(text(),"Add items from previous session?")]'
discard_button = '//span[contains(text(),"Discard Items")]//ancestor::button'
add_items_to_cart = '//span[contains(text(),"Add items to cart")]//ancestor::button'
products_from_previous_session = '//ul[@class="list-unstyled"]//li'
products_found = '//div[@class="modal-body"]//p'

store_name_pos = '//div[@class="pt-1 left col-md-6"]//h6'
category_sidebar = '//ul[@class="nav nav-pills card-header-pills list-group vertical-scroll horizontal-scroll w-30"]'
category_sidebar_option = '//li//a[contains(text(),"Body Scrub")]'
product_catalog_body = '//div[@class="w-100 position-relative"]'
product_name_in_catalog = '//h6[@class="mb-0" and contains(text(),"Ranger Alex")]'
product_with_some_inventory = '//div[@class="product-info pull-left"]//h6[text()="Carry bag"]'

ssp_price = ' //td[@aria-colindex="4"]/p'
mrp_table = '//table[@class="table b-table table-cutom widthfixed b-table-selectable b-table-select-single"]'

keyboard_shortcuts_link = '//a[@class="key-link"]'
# insufficient inventory
insufficient_inventory_continue_btn = '//button[@class="btn ml-1 btn-primary btn-block"]'
insufficient_inventory_title = '//h5[@class="modal-title"]'

auto_switch_billing_on = '//h5[contains(text(),"Auto-switch to Billing Mode")]//following-sibling::label[@class="my-auto vue-js-switch toggled"]'
auto_switch_billing_off = '//h5[contains(text(),"Auto-switch to Billing Mode")]//following-sibling::label[@class="my-auto vue-js-switch"]'
auto_switch_billing_toggle = '(//h5[contains(text(),"Auto-switch to Billing Mode")]//following::div[@class="v-switch-core"]//div)[1]'
disabled_product = '//a[@class="d-flex isDisabled"]'

# Exchange Module
add_exchange_item_link = '//a[@class="fs-13"]'
search_invoice_field = '//input[@id="input-default"]'
select_search_invoice_option_btn = '//div[@class="dropdown b-dropdown switch-billing fs-12 mr-3 btn-group"]//button[@class="btn dropdown-toggle btn-light"]'
invoice_number_search_option = '//a[contains(text(),"Invoice Number")]'
customer_name_search_option = '//a[contains(text(),"Customer Name")]'
customer_phone_search_option = '//a[contains(text(),"Customer Phone")]'
div_svg_cross_icon = '//div[@class="row exchange-modal-main"]'
selected_parameter_invoice_option = '//div[@class="dropdown b-dropdown switch-billing fs-12 mr-3 btn-group"]//button[@class="btn dropdown-toggle btn-light" and contains(text(),"Customer Name")]'
searched_invoice_heading_row = '//div[@class="ex-invoice-table my-3 mx-n2"]//div[@class="row header-bar align-content-center"]'
first_row_invoice = '(//div[@class="grey-100 col-2"])[1]'
select_item_for_exchange_title = '//p[@class="fs-16 mb-0" and contains(text(),"Select Items for Exchange")]'
first_product_row_checkbox = '//label[@for="product-0"]'
exchange_qty = '//select[@class="fs-12 custom-select"]'
exchange_qty_option = '//select[@class="fs-12 custom-select"]//option[contains(text(),"1")]'
search_reason_dropdown = '//button[@class="btn dropdown-toggle btn-light" and contains(text(),"Select reason for exchange")]'
exchange_reason_option = '(//ul[@class="dropdown-menu show"]//a[@class="dropdown-item"])[1]'
product_selected_for_exchange_text = '//p[@class="text-primary mb-0 text-left"]'
cancel_btn_exchange_window = '//button[@class="btn mr-3 btn-outline-primary btn-block"]'
continue_btn_exchange_window = '//div[@class="text-right d-flex pr-2 col-4"]//button[contains(@class,"btn btn-primary btn-block")]'
add_product_for_exchange_btn = '//button[@class="primary-light fs-12 my-1 add-prod-exchanged"]'
cancel_adding_product_btn = '//button[@class="primary-light fs-12 my-1 add-prod-exchanged cancel-prod-exchanged"]'
invoice_not_found = '//div[@class="alert alert-dismissible alert-danger" and contains(text(),"Invoice not found")]'
searched_invoice_number_heading = '//div[contains(text(),"Invoice Number")]'
searched_invoice_date_heading = '//div[contains(text(),"Date")]'
searched_invoice_item_heading = '//div[contains(text(),"Items")]'
searched_invoice_amount_heading = '//div[contains(text(),"Amount")]'
searched_invoice_customer_name_heading = '//div[contains(text(),"Customer Name")]'
searched_invoice_phone_number = '//div[contains(text(),"Phone Number")]'
searched_invoice_table = '//div[contains(@class,"ex-invoice-table") and not(contains(@style,"display: none;"))]'
sku_barcode_col_title = '//div[@class="pl-3 d-flex align-items-center col-2"]'
product_name_col_title = '//div[@class="col-3" and contains(text(),"Product Name")]'
reasons_col_title = '//div[@class="col-3" and contains(text(),"Reason* ")]'
qty_col_title = '//div[@class="col-1" and contains(text(),"Qty")]'
unit_price_col_title = '//div[@class="col-1" and contains(text(),"Unit Price")]'
exchange_qty_col_title = '//div[@class="pr-0 col-2" and contains(text(),"Total Exchange Qty")]'
first_row_qty_exchange = '(//div[@class="row fs-13 py-3 rows px-4 fs-12 grey-100 align-items-center"]//div[@class="col-1"])[1]'
exchange_popup="//div[@class='popup-notification']"
item_name_exchange='(//div[@class="pl-1 col-3"])[1]'
item_price_exchange='(//div[@class="pl-1 col-3"]//following-sibling::div)[2]'

all_searched_invoice = '(//div[@class="ex-invoice-table my-3 mx-n2"]//div[@class="vertical-scroll exchange-scroll"])[1]'
searched_invoice_number = '(//div[contains(@class,"exchange-invoices-col rows align-content-center")]/div[not(contains(text(),"AM")) and not(contains(text(),"PM")) and @class="grey-100 col-2"])[1]'
searched_customer_name = '(//div[contains(@class,"exchange-invoices-col rows align-content-center")]/div[contains(@class,"grey-") and contains(@class,"col-3")])[1]'
searched_phone_number = '(//div[contains(@class,"exchange-invoices-col rows align-content-center")]/div[@class="col-2"])[1]'
total_number_of_items = '(//div[contains(@class,"exchange-invoices-col rows align-content-center")]/div[@class="col-1"])[1]'
amount = '(//div[contains(@class,"exchange-invoices-col rows align-content-center")]/div[@class="px-4 col-2"])[1]'
searched_invoice_date = '(//div[contains(@class,"exchange-invoices-col rows align-content-center")]/div[@class="grey-100 col-2" and contains(text(),"PM") or contains(text(),"AM")])'

select_all_items_checkbox = '//input[@id="select-all"]//following-sibling::label'
selected_all_item = '//input[@id="select-all"]'
exchange_item_checkbox = '//input[@id="product-0"]//following-sibling::label'
selected_item = '//input[@id="product-0"]'
ensure_product_message = '//p[contains(text(),"Please ensure the customer has them before your proceed.")]'
product_added_message = '//p[@class="text-primary mb-0 text-left"]'
no_product_selected_message = '//p[contains(text(),"No product selected for exchange")]'

total_qty_of_item = '(//div[contains(text(),"SKU/Barcode")]//ancestor::div[@class="ex-invoice-table my-3 mx-n2"]//div[contains(@class,"vertical-scroll exchange-scroll")]//div[@class="col-1"])[1]'
exchange_product_net_price = '(//td[@aria-colindex="6" and @class="text-right  align-middle"])[1]'
alternate_product_net_price = '(//td[@aria-colindex="6" and @class="text-right  align-middle"])[2]'
