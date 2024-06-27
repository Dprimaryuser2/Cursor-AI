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
hide_catalog_button = '//button[@id="hide-catalog"]//ancestor::div[@class="catlog-search-pl-6p col-md-3 col-lg-3"]'
refresh_button = '//button[@id="refresh-catalog"]'
product_search_bar = '//input[@id="product-search"]'
search_add_button = '//button[@class="btn alternative add-to-cart btn-info"]'
scan_only = '//div[@class="v-switch-button"]'
salesperson_button = '//button[@id="category-salesperson"]'
view_held_bills = '//button[@id="category-held-bills"]'
hold_bill = '//button[@id="category-hold-bill"]'
hold_bill_confirmation = '//button[@id="put-hold-bill"]'
hold_bill_cancel = '//button[@id="cancel-hold-bill"]'
apply_promo = '//button[@id="category-promotions"]'
apply_manual_discount = '//button[@id="category-apply-discount"]'
add_carry_bags = '//button[@id="category-add-carrybags"]'
promo_name = '//span[@class="offer active text-green"]'
quantity_row = '(//td[@aria-colindex="3"])[1]'
# piece
quantity_in_piece_button = '(//td[@aria-colindex="3"]//button[@id="weight-btn-null"])[1]'    # this is button which selects the piece of item and a modal comes after clicking this
piece_modal = '//div[@class="modal-content"]'
quantity_input = '//input[@id="qtyInput"]'
update_cart_quantity = '//div[@class="modal-content"]//button[@class="btn btn-primary btn-block"]'
switch_edit_add_toggle = '//div[@class="modal-body"]//div[@class="v-switch-button"]'    # This switches between edit cart and add to cart
# units
custom_select_quantity_button = '(//select[@class="custom-select custom-select-sm"])[1]'      # change the number
custom_select_options = '//select[@class="custom-select custom-select-sm"]//option[@value="option_value"]'     # change the option to the number you want to select
custom_select_quantity = '//span[text()="ITEM"]//ancestor::td//following-sibling::td//option[@value="option_value"]'
price = '(//td[@aria-colindex="4"])[1]'
discount_field = '(//td[@aria-colindex="5"])[1]'
net_price = '//td[@aria-colindex="6"]'
cancel_item = '(//td[@aria-colindex="6"])[1]'
item_cart_table = '//table[@class="table b-table table cart-table mt-0 table-dark table-dark-bg b-table-row-selected td:first-child border-bottom-0 b-table-selectable b-table-select-single"]'
table = '//td[@aria-colindex="2"]//ancestor::tbody[@role="rowgroup"]'
first_item_product_name = '(//a[contains(@class,"product-name")])[1]'
sub_total = '//p[contains(text(),"Sub Total")]//ancestor::div[@class="row mb-1"]//following-sibling::div/p'
promo_discount = '//p[contains(text(),"Item Promo Discount")]//ancestor::div[@class="row mb-1"]//following-sibling::div/p'
included_tax_text = '//p[contains(text(),"Tax Total (Included)")]'
excluded_tax_text = '//p[contains(text(),"Tax Total (Excluded)")]'
round_off_text = '//p[contains(text(),"Round Off")]'
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

# dynamic
quantity_column = '//span[contains(text(),"barcode")]//ancestor::tr//td[@aria-colindex="3"]'    # change barcode
price_column = '//span[contains(text(),"barcode")]//ancestor::tr//td[@aria-colindex="4"]'    # change barcode
discount_column = '//span[contains(text(),"barcode")]//ancestor::tr//td[@aria-colindex="5"]'     # change barcode
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
discount_type_amount = '//span[contains(text(),"Amount")]//ancestor::div[@class="custom-control custom-control-inline custom-radio"]'
discount_type_percentage = '//span[contains(text(),"Percentage")]//ancestor::div[@class="custom-control custom-control-inline custom-radio"]'
discount_value = '//input[@id="discount-value"]'
apply_percent_discount_button = '//button[@id="apply-percentage"]'
apply_amount_discount_button = '//button[@id="apply-discount"]'
active_promotion = '//span[text()="View Available Promotion(s)"]'

item_remark = '//input[@id="input-remark-productpopup"]'
salesperson_refresh = "//button[text()='Refresh']"
salesperson_dropdown = '//span[contains(text(),"Select Salesperson")]'
salesperson_search_field = '//input[@placeholder="Search..."]'
salesperson = '//input[@placeholder="Search..."]//ancestor::div[@class="dropdown-body w-100"]//li'
check_inventory_button = '//button[@id="check-inventory-btn"]'
inventory_modal_heading = '//h5[contains(text(),"Inventory")]'
inventory_close_button = '//h5[contains(text(),"Inventory")]//following-sibling::button'
update_product_button = '//button[@id="update-product-btn"]'
quantity= "//input[@id='qtyInput' and @placeholder='Enter Weight']"
# Carry Bags
carry_bag_heading = '//h5[contains(text(),"Select Carry Bags")]'
carry_bag_input_field = '//h6[@id="label-undefined" and text()="Carry bag"]//ancestor::div[@class="row mb-2"]//input'
add_carry_bag_unit_button = '//button[@id="add-carry-bags"]'
close_button = '//button[@class="close"]'
open_session_link = '//div[@class="fadein col-md-6 col-lg-6" and not(@style="display: none;")]//div[@id="session-info"]//a'
select_mrp="//h5[@class='modal-title' and contains(text(),'Select MRP')]"
select_mrp_refresh="//button[@class='btn add-to-cart serve-refresh btn-light btn-sm' and contains(text(),'Refresh')]"
add_to_cart_mrp="//button[@id='multiple-mrp-add-to-cart' and @class='btn m-0 custom-btn btn-secondary']"

# Discard after half payment
discard_payment_bill = '//p[contains(normalize-space(),"Discard Bill")]'
discard_confirm = '//span[text()="Yes, Discard"]'
cart_0 = "//span[@class='quantity h5 mb-0 mr-1' and contains(text(),'(0)')]"
back_icon_on_checkout = '//img[@class="icon text-white"]'
# Manual Discount assertion fields
update_product_subtotal = '//label[contains(text(),"Subtotal")]//following-sibling::p'
update_product_cumulative_discount = '//label[contains(text(),"Cumulative Discount")]//following-sibling::p'
update_product_taxes = '//label[contains(text(),"Product Taxes")]//following-sibling::p'
update_product_total = '//label[contains(text(),"Product Total")]//following-sibling::p'

add_carry_bag_button='//button[@id="category-add-carrybags"]'
carry_bag_add='//button[@id="add-carry-bags"]'
product_added_successfully = '//div[@class="alert alert-dismissible alert-success" and contains(text(),"Product was successfully added to your cart")]'
product_quantity_updated = '//div[@class="alert alert-dismissible alert-success" and contains(text(),"Product quantity successfully Updated")]'
price_override_successful = '//div[@class="alert alert-dismissible alert-success" and contains(text(),"Price overridden successfully.")]'

# sidebar locators
inventory_option_sidebar = "//a[@title='Inventory']"
cash_management_option_sidebar = "//li[@title='Cash Management']//a//img"
pos_option_sidebar = "//a[@id='nav-pos']"
order_management_option_sidebar = "//a[@title='Order Management']//img"
# cash management locators
cash_management_heading = "//h5[text()='Cash Management']"
billing_option_switch_default = '//button[@class="btn dropdown-toggle btn-light" and contains(text(),"Billing")]'
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

# customer_info_icon = "//body/div[@id='app']/div[@id='theme']/div[@class='dashboard']/section/div[@class='container-fluid']/div[@class='row']/div[@class='fadein col-md-6 col-lg-6']/div[@class='row mt-2']/div[@class='col-md-6 col-lg-6']/div[@id='customer-info']//a"
customer_info_icon = "//div[normalize-space(text())='Customer Information']/a[@id='get-customer-info']"
switch_modal_proceed_button = "//button[@class='btn ml-1 btn-primary btn-block']//span"

update_product_md = "//button[@id='update-product-btn' and @class='btn ml-2 btn-primary']//span"