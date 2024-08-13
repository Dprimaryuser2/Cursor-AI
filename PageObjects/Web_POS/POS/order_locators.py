insufficient_inventory_cancel_btn = '//button[@class="btn mr-1 btn-outline-primary btn-block"]'
fulfilment_options_heading = '//h6[@class="mb-4" and contains(text(),"Fulfilment Options")]'
fulfilment_due_date_option = '//input[@id="datepicker"]'
fulfilment_calendar_window = '//div[@class="vdp-datepicker__calendar" and @style=""]'
last_date_of_this_month = '(//div[@class="vdp-datepicker__calendar" and @style=""]//div//child::span[contains(text(),"30") or contains(text(),"31") or contains(text(),"29")])[last()]'
continue_fulfilment_button = '//button[@class="btn btn-primary btn-block" and text()="Continue"]'
place_order_button = '//button[@class="btn btn-primary btn-block" and contains(text(),"Place Order")]'
min_acceptance_criteria_fulfilled = '//span[@class="ml-2" and contains(text(),"Minimum order acceptance criteria fulfilled")]'
bill_container = '//div[@class="container p-0"]'
name_invoice = '//div[@class="modal-content"]//td[contains(text(),"Name")]/span'

fulfilment_option = '//h6[@class="mb-4"]'
random_date_fulfilment_option = '(//div[@class="vdp-datepicker__calendar" and @style=""]//div//child::span[contains(text(),"26") or contains(text(),"18") or contains(text(),"16")])[last()]'
stock_point_alert_popup = '//div[@class="popup-notification"]//child::div'
stock_point_popup_confirm_order = "//div[@class='tooltip-inner']"
info_icon_confirm_order = '//td[@class="text-center"]//child::div'
order_confirmation_page_heading = '//h5[@class="mt-2 mr-3"]'
confirm_order_button_order_confirm_page = '//button[contains(@class,"btn btn-primary") and contains(text(),"Confirm Order")]'
pack_order_button = '//button[@id="confirm-order" and text()= "Pack Order"]'
stock_alert_pack_order = '//div[@class="popup-notification"]//div'

# Order Summary
order_summary_page_heading = '//span[contains(text(),"Order Summary")]'
order_summary_status_pending = '//span[contains(text(), "Pending")]'
confirm_order_button = '//button[@class="btn btn-primary btn-block" and contains(text(),"Confirm Order")]'
credit_note_reserved ="//p[text()='Credit Note Reserved']"
credit_note_reserved_amount= '//div[@class="d-flex justify-content-between"]//child::p[@class="text-success"]'
amount_paid_order_summary ='//h5[@class="fw-normal text-right mb-0 text-success"]'
total_amount_order_summary = '//h5[@class="fw-normal text-right mb-0"]'
contact_number_order_summary = '//div[@class="col-md-6"]//child::label[text()="Phone Number"]//following-sibling::p[@class="mb-2"]'
order_options_order_summary = '//button[@class="btn dropdown-toggle btn-outline-primary btn-sm"]'
confirm_order_order_options = "//a[text()='Confirm Order']"
cancel_order_order_options = "//a[text()='Cancel Order']"
customer_name_order_summary = "//label[text()='Customer Name']//following-sibling::p"
amount_due_order_summary='//h5[@class="fw-normal text-right mb-0 text-danger"]'
pack_order_heading = "//h5[text()='Pack Order']"
collect_payment = '//a[@class="dropdown-item text-dark" and contains(text(),"Collect Payment")]'
order_number_order_summary ='//label[text()="Order Number"]//following-sibling::p'
customer_number_order_summary = '//label[text()="Phone Number"]//following-sibling::p'
order_confirm_alert = '//div[@role="alert" and contains(normalize-space(),"Order confirm successfully")]'

# print recipt
print_order_receipt = '//button[@id="print-order-receipt"]'
close_button_print_order = '//button[@id="close" and contains(text(),"Close")]'
order_number_print_recipt = '//td[@valign="top" and contains(normalize-space(),"Order No")]'
print_button_print_recipt = '//button[@class="btn float-right btn-secondary" and contains(text(),"Print")]'
print_recipt_container = '//table[@class="print_invoice_table_start"]'
customer_name_print_recipt = '//td[contains(text(),"Customer")]//child::b'
total_amount_print_recipt = '//b[text()="Total Amount"]//parent::td//following-sibling::td//child::b//b[text()="Total Amount"]//parent::td//following-sibling::td//child::b'

# order confirmation
order_completion_button = '//button[@class="btn btn-primary btn-block"]'
replace_button_order_confirm = '//a[@class="text-blue action-btns px-3 py-2"]'
scan_replace_page = '//input[@id="__BVID__82"]'
search_bar_replace_page = '//div[@class="input-group-append"]'
back_order_confirmation = '//button[@class="btn mr-2 btn-outline-primary"]'
barcode_order_confirmation= '//tr[@class="unavailable"]//td[@role="cell" and @aria-colindex="2"]'
total_price_order_confirmation = '//tr[@class="unavailable"]//td[@role="cell" and @aria-colindex="4"]'
discount_order_confirmation = '//tr[@class="unavailable"]//td[@role="cell" and @aria-colindex="5"]'
quantity_order_confirmation = '//tr[@class="unavailable"]//td[@role="cell" and @aria-colindex="8"]'
order_confirm_alert = '//div[@class="popup-notification"]//child::div'

# discard order popup
discard_button_order_confirmation = '//a[@class="text-danger action-btns px-3 py-2"]'
discard_popup_heading = '//h6[@class="mb-3 fw-normal"]'
cash_button_discard_popup ='//label[@for="invoice_type_BV_option_0"]'
store_credit_button_discard_popup = '//label[@for="invoice_type_BV_option_1"]'
cancel_button_discard_popup = '//button[@class="btn px-4 btn-outline-primary btn-block"]'
continue_button_discard_popup = '//button[@class="btn px-4 btn-primary btn-block"]'
order_cancel_alert = '//div[@class="popup-notification"]//div'
amount_due_cancel_order = '//h5[@class="fw-normal text-right mb-0 text-danger"]'
credit_note_reserved_discard_popup = '//p[@class="text-success"]'
credit_note_released_discard_popup = '//p[@class="text-danger"]'
discard_button_discard_popup = '//button[@class="btn px-4 btn-primary btn-block"]'
remark_button_discard_popup = '//textarea[@id="cancelOrderRemark"]'

# cancel order popup
cancel_order_popup_heading = '//h5[@class="modal-title" and contains(normalize-space(),"Cancel Order")]'
cash_cancel_order_popup = '//label[@class="custom-control-label"]//child::span[text()="Cash"]'
store_credit_cancel_order_popup = '//label[@class="custom-control-label"]//child::span[text()="Store Credit"]'
remark_button_cancel_order_popup = '//textarea[@id="cancelOrderRemark"]'
close_cancel_order_popup = '//button[@class="btn btn-outline-primary btn-block" and contains(text(), "Close")]'
confirm_cancel_order_popup = '//button[contains(@class,"btn w-100 btn-primary btn-block")]//span[text()="Confirm"]'

# pack order
search_bar_pack_order = '//input[@class="search form-control"]'
product_search_pack_order = '//div[@class="product-search"]'
quantity_pack_order = '//select[@class="custom-select custom-select-sm fs-12"]'
confirm_completion_pack_order = '//button[@class="btn btn-primary btn-block"]'
cancel_button_pack_order = '//button[@class="btn btn-outline-primary btn-block"]'
generate_invoice_pack_order = '//div[@class="pr-1 col-lg-6"]'
print_order_receipt_pack_order = '//div[@class="pl-1 col-lg-6"]'


# bill remark
options_checkout_page = '//button[contains(@class,"btn dropdown-toggle btn-light btn-sm")]'
fulfilment_option_dropdown = "//a[contains(@class,'dropdown-item text-dark') and contains(text(),'Fulfilment Options')]"
add_bill_remark_dropdown = '//a[@class="dropdown-item text-dark" and contains(text(),"Add Bill Remark")]'
add_remark_popup_heading = '//h5[@class="modal-title"]'
add_remark_textarea = '//textarea[@id="remark-input"]'
clear_bill_remark = '//button[@id="clear-bill-remark"]'
save_bill_remark ='//button[@id="save-bill-remark"]'
close_bill_remark = '//button[@class="close"]'
add_bill_remark_alert = '//div[@class="popup-notification"]//child::div'
edit_remark_button = '//a[normalize-space()="Edit Remark"]'

# Order Management
search_bar_order_management = '//div[@class="container-fluid"]//following::input[@class="search form-control"]'
order_status_order_management ='//div[@class="row w-100"]'
order_management_page_heading = '//h5[@class="mt-2 mr-3" and contains(text(), "Order Management")]'
negative_inventory_alert_order = '//div[@class="col-11"]//h6[contains(text(),"Insufficient Inventory")]'

# confirm order popup
review_button_confirm_order_popup ='//button[contains(@class, "btn btn-outline-primary btn-block") and contains(text(),"Review")]'
confirm_button_confirm_order_popup = '//button[contains(@class, "btn btn-primary btn-block")]//span[text()="Confirm"]'
confirm_order_heading_confirm_order_popup = '//h5[contains(@class,"modal-title") and contains(text(),"Confirm Order")]'