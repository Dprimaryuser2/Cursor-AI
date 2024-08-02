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

stock_point_alert_popup = '//div[@class="popup-notification"]//child::div'
stock_point_popup_confirm_order = "//div[@class='tooltip-inner']"
info_icon_confirm_order = '//td[@class="text-center"]//child::div'
order_confirmation_page_heading = '//h5[@class="mt-2 mr-3"]'
confirm_order_button_order_confirm_page = '//button[@class="btn btn-primary" and contains(text(),"Confirm Order")]'
pack_order_button = '//button[@id="confirm-order" and text()= "Pack Order"]'
stock_alert_pack_order = '//div[@class="popup-notification"]//div'

# Order Summary
order_summary_page_heading = '//span[contains(text(),"Order Summary")]'
order_summary_status_pending = '//span[@data-v-682f3abc and contains(text(),"Order Summary")]//span[contains(text(),"Pending")]'
confirm_order_button = '//button[@class="btn btn-primary btn-block" and contains(text(),"Confirm Order")]'
print_order_receipt = '//button[@id="print-order-receipt"]'
credit_note_reserved ='//div[@class="d-flex justify-content-between"]//child::p[text()="Credit Note Reserved"]'
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
order_completion_button = '//button[@class="btn btn-primary btn-block"]'
replace_button_order_confirm = '//a[@class="text-blue action-btns px-3 py-2"]'
scan_replace_page = '//input[@id="__BVID__82"]'
search_bar_replace_page = '//div[@class="input-group-append"]'

# discard order popup
discard_button_order_confirmation = '//a[@class="text-danger action-btns px-3 py-2"]'
cancel_order_popup_heading = '//h6[@class="mb-3 fw-normal"]'
cash_button_cancel_order ='//label[@for="invoice_type_BV_option_0"]'
store_credit_button_cancel_order = '//label[@for="invoice_type_BV_option_1"]'
cancel_button_cancel_order = '//button[@class="btn px-4 btn-outline-primary btn-block"]'
continue_button_cancel_order = '//button[@class="btn px-4 btn-primary btn-block"]'
order_cancel_alert = '//div[@class="popup-notification"]//div'
amount_due_cancel_order = '//h5[@class="fw-normal text-right mb-0 text-danger"]'
credit_note_reserved_cancel_order = '//p[@class="text-success"]'
credit_note_released_cancel_order = '//p[@class="text-danger"]'

# pack order
search_bar_pack_order = '//input[@class="search form-control"]'
product_search_pack_order = '//div[@class="product-search"]'
quantity_pack_order = '//select[@class="custom-select custom-select-sm fs-12"]'
confirm_completion_pack_order = '//button[@class="btn btn-primary btn-block"]'
cancel_button_pack_order = '//button[@class="btn btn-outline-primary btn-block"]'
generate_invoice_pack_order = '//div[@class="pr-1 col-lg-6"]'
print_order_receipt_pack_order = '//div[@class="pl-1 col-lg-6"]'

# bill remark
options_checkout_page = '//button[@class="btn dropdown-toggle btn-light btn-sm"]'
fulfilment_option_dropdown = '//a[@class="dropdown-item text-dark" and contains(text(),"Fulfilment Options")]'
add_bill_remark_dropdown = '//a[@class="dropdown-item text-dark" and contains(text(),"Add Bill Remark")]'
add_remark_popup_heading = '//h5[@class="modal-title"]'
add_remark_textarea = '//textarea[@id="remark-input"]'
clear_bill_remark = '//button[@id="clear-bill-remark"]'
save_bill_remark ='//button[@id="save-bill-remark"]'
close_bill_remark = '//button[@class="close"]'