checkout_button = "(//button[@class='btn mr-1 btn-success btn-block'])[2]"
disabled_checkout_button = '(//div[@class="action-btns d-flex"]//button[@id="checkout-btn" and @class="btn mr-1 btn-success btn-block disabled" and text()="Checkout"])[2]'
checkout_heading = '//div[@class="col-md-4 col-lg-6 col-4"]/h5'
checkout_payable_amount = '//label[@id="label-amt-pay"]//following-sibling::input'
checkout_loyalty='//button[@class="btn add-to-cart w-auto m-1 btn-light" and contains(text(),"Loyalty")]'
checkout_coupon='//button[@class="btn add-to-cart w-auto m-1 btn-light" and contains(text(),"Coupon")]'
checkout_customer_feedback = '//input[@placeholder="To capture the customer feedback"]'
checkout_save_feedback_button = '//button//span[@class="px-2"]'
checkout_account_balance = '(//p[@class="mb-3"])[1]'
checkout_store_credit = '(//p[@class="mb-3"])[2]'
checkout_loyalty_points = '(//p[@class="mb-3"])[3]'

# payment method
payment_method_cash = '//button[@id="pay-method-cash"]'
upi_payment = '//button[@id="pay-method-undefined"]'
customer_paid_amount = '//input[@id="input-for-customer-paid"]'
transaction_reference_id = '//input[@id="trxn-ref-id"]'
continue_payment_button = '//button[@id="process-payment-btn"]'
payment_cancel_button = '//button[@class="close"]'
# products billing data
product_row = '(//tbody/tr[@role="row"])[row_count]'    # change row_count acc to keys and value pair
checkout_product_name = '(//tbody/tr[@role="row"])[row_count]/td[@aria-colindex="2"]'
checkout_quantity = '(//tbody/tr[@role="row"])[row_count]/td[@aria-colindex="3"]' # change row_count acc to keys and value pair
unit_price = '(//tbody/tr[@role="row"])[row_count]/td[@aria-colindex="4"]'
checkout_discount = '(//tbody/tr[@role="row"])[row_count]/td[@aria-colindex="5"]'
checkout_tax = '(//tbody/tr[@role="row"])[row_count]/td[@aria-colindex="6"]'
checkout_per_item_total = '(//tbody/tr[@role="row"])[row_count]/td[@aria-colindex="7"]'
checkout_net_price = '(//tbody/tr[@role="row"])[row_count]/td[@aria-colindex="8"]'
# sub total area
checkout_sub_total = '//span[contains(text(),"Sub Total")]//ancestor::div[@class="row mb-1"]//div[@class="col text-right"]/p'
checkout_promo_discount = '//span[contains(text(),"Item Promo Discount")]//ancestor::div[@class="row mb-1"]//div[@class="col text-right"]/p'
checkout_tax_text = '//span[contains(text(),"Taxes")]'
checkout_total_tax = '//span[contains(text(),"Taxes")]//ancestor::div[@class="row mb-1"]//div[@class="col text-right"]/p'
checkout_round_off_text = '//span[contains(text(),"Round Off")]'
checkout_round_off = '//span[contains(text(),"Round Off")]//ancestor::div[@class="row mb-1"]//div[@class="col text-right"]/p'
total_payment = '//div[@class="p-y-zero-x-half col-md-6"]//div[@class="col text-right p-0"]/h6'
grand_total = '//div[@class="p-y-zero-x-25half col-md-6"]//div[@class="col text-right p-0"]/h6'
# item promotions
item_promo_link = '//div[@class="col light"]//img[@src="/img/info.1c91eacc.svg"]'
item_promotion_row = '//div[@class="modal-body"]//tbody/tr[@role="row"]'
item_promotion_discount = '(//div[@class="modal-body"]//tbody/tr[@role="row"]//td[@aria-colindex="3"]/div)'
item_promo_body = '//div[@class="modal-body"]//tbody'
promo_close_button = '//button[@class="close"]'
item_promotions_title = '//h5[@class="modal-title"]'
# updating catalog popup
updating_catalog_heading = '//h5[@class="updt-cat ml-2"]'
key_link = '//a[@class="key-link"]'
close_button = '//button[@class="close"]'

# invoice details
payment_complete_heading = '//span[contains(text(),"Payment complete!")]'
invoice_customer_name = '//label[contains(text(),"Customer Name")]//following-sibling::p'
invoice_customer_phone = '//label[contains(text(),"Customer Phone Number")]//following-sibling::p'
split_payment_popup="//div[@class='alert alert-dismissible alert-success' and contains(text(),'Payment saved successfully')]"
# dynamic
checkout_qty_column = '//span[contains(text(),"barcode")]//ancestor::tr//td[@aria-colindex="3"]'
checkout_unit_price_column = '//span[contains(text(),"barcode")]//ancestor::tr//td[@aria-colindex="4"]'
checkout_discount_column = '//span[contains(text(),"barcode")]//ancestor::tr//td[@aria-colindex="5"]'
checkout_discount_tax = '//span[contains(text(),"barcode")]//ancestor::tr//td[@aria-colindex="6"]'
checkout_sub_total_column = '//span[contains(text(),"barcode")]//ancestor::tr//td[@aria-colindex="7"]'
checkout_net_price_column = '//span[contains(text(),"barcode")]//ancestor::tr//td[@aria-colindex="8"]'

# Billing locators
bill_discount = '//button[contains(text(),"Bill Discount")]'
checkout_page_manual_discount = '//span[contains(normalize-space(),"Manual Discount")]//ancestor::div[@class="row mb-1"]/div[@class="col text-right"]/p'

#split payment
enter_split_amount='//label[@id="label-amt-pay"]//following-sibling::input[@class="form-control amtpay"]'
enter_cash='//input[@id="input-for-customer-paid" and @placeholder="Enter Amount"]'
continue_cash_button='//button[@id="process-payment-btn" and @class="btn float-right mt-4 btn-primary"]'
enter_paytm_transaction_id='//input[@id="trxn-ref-id" and @class="form-control form-control-sm"]'
continue_paytm_button='//button[@id="process-payment-btn" and @class="btn float-right mt-4 btn-primary"]'
cancel='//button[@class="btn mr-1 btn-outline-primary btn-block"]'
redeem_voucher_transactionId="//input[@id='trxn-ref-id' and @placeholder='Enter reference id']"
voucher_continue_button="//button[@id='process-payment-btn' and @class='btn float-right mt-4 btn-primary']"
redeem_voucher='//button[@id="pay-method-undefined" and contains(text(),"Redeem Voucher")]'

account_on_sale="//button[@class='btn text-center p-0 h-25 mb-2 btn-outline-secondary btn-block' and contains(text(),'On-Account Sale')]"
balance_after_sale="(//div[@class='mt-3 col-md-6']//p)[2]"
on_account_sale_heading = '//header[@id="on_account_sale___BV_modal_header_"]'
remark_account_on_sale="//textarea[@id='input-account-remark']"
continue_account_on_sale_button="//button[@id='confirm-account-sale' and @class='btn w-20 btn-primary']"
#payment complete
print_invoice="//button[@id='print-invoice-btn' and @class='btn mt-2 btn-primary btn-block']"
share_invoice="//button[@id='share-invoice-btn' and @class='btn mt-4 mt-md-2 btn-primary btn-block']"

no_payment_required='//header[@class="modal-header"]//child::h5[contains(text(),"No Payment Required")]'
no_payment_required_confirm_button="//button[@class='btn ml-1 btn-primary btn-block']//child::span[contains(text(),'Confirm')]"
no_payment_required_cancel_button="//button[@class='btn mr-1 btn-outline-primary btn-block' and contains(text(),'Cancel')]"
checkout_split_payment='//div[@class="v-switch-button"]'
checkout_billing_options='//button[@class="btn dropdown-toggle btn-light btn-sm" and contains(text(),"Billing Options")]'
loyalty_modal_heading= '//h5[@class="modal-title" and contains(text(),"Redeem Loyalty")]'

checkout_billing_add_bill_remark ='(//a[@class="dropdown-item text-dark" and contains(text(),"Add Bill Remark")])[2]'
add_bill_remark_textarea = '//textarea[@placeholder="Add remark... "]'
add_bill_remark_save_button = '//button[@class="btn ml-1 btn-primary"]//span[text()="Save"]'
add_bill_remark_clear_button = '//button[@class="btn mr-1 btn-outline-primary"]//span[text()="Clear"]'
checkout_billing_edit_remark = '(//a[@class="dropdown-item text-dark" and contains(text(),"Edit Remark")])[2]'
add_bill_remark_close_icon = '//button[@class="close"]'
checkout_order_summary = '//h6[@class="mb-0 fw-normal" and contains(text(),"Order Summary")]'
checkout_salesperson_name = '(//span[@class="pt-2 fs-12 text-grey"])'
# payment method

payment_method_credit_card='//button[@id="pay-method-pinelab"]//img[@alt="Credit Card"]'
remark_added_successful = '//div[@class="alert alert-dismissible alert-success" and contains(text(),"Remark added successfully.")]'
checkout_bill_promos='//button[@class="btn add-to-cart w-auto m-1 btn-light" and contains(text(),"Bill Promos")]'
checkout_bill_discount='//button[@class="btn add-to-cart w-auto m-1 btn-light" and contains(text(),"Bill Discount")]'
promos_applied_message = '//div[@class="alert alert-dismissible alert-success" and  text()="Promo applied successfully"]'
#bill discount
bill_discount_select_from_list='//a[@class="nav-link active" and contains(text(),"Select from List")]'
bill_discount_select_from_list_option='//li[@class="py-3" and contains(text(),"abv")]' #change the text according to test data
bill_discount_select_from_list_option_selected='//li[@class="py-3 active" and contains(text(),"sdy")]' #change the text according to test data
select_from_list_option_apply_disc_button='(//button[@class="btn float-right btn-primary"]//span[text()="Apply Discount"])[1]'

# Payment successful page
print_invoice_button = '//button[@id="print-invoice-btn" and contains(text(),"Print Invoice")]'
share_invoice_button = '//button[@id="share-invoice-btn" and contains(text(),"Share Invoice")]'
invoice_modal_heading = '//h3[@class="modal-title" and contains(text(),"Invoice")]'
print_invoice_modal_button = '//button[@class="btn float-right btn-primary" and contains(text(),"Print")]'
close_invoice_modal_button = '//button[@class="btn float-right btn-secondary" and contains(text(),"Close")]'
new_bill_button = '//button[@class="btn mr-2 btn-primary btn-block"]'
share_invoice_title = '//h5[@class="modal-title" and contains(text(),"Share Invoice")]'
cust_number_share_invoice = '//input[@placeholder="Enter your phone number"]'
sms_tab_share_invoice = '//p[text()="SMS"]'
email_tab_share_invoice = '//div[@class="row pl-2 pr-2"]//div[@class="col-md-6 border-inactive"]//p[text()="E-Mail"]'
cust_email_share_invoice = '//input[@placeholder="Enter your E-mail address"]'
send_button_share_invoice = '//button[@class="btn btn-primary btn-block"]'
close_icon_share_invoice = '//button[@class="close"]'
share_invoice_alert_number = '//span[text()="Phone number must be 10 characters long."]'
share_invoice_alert_email = '//div[@class="invalid-feedback" and contains(text(),"Invalid Email")]'
email_send_registered_mail_msg = '//p[contains(text(),"An E-mail with the invoice has been sent to ")]'
dismiss_button_share_invoice = '//button[@id="dismiss-invoice-sms"]'

#redeem store credit
refund_method_store_credit_btn = '//button[@id="refund-mode-voucher"]'
redeem_store_credit_button = '//button[@class="btn text-center p-0 h-25 mb-2 btn-outline-secondary btn-block" and text()="Redeem Store Credit"]'
redeem_with_dropdown = '//select[@id="redeem-types"]'
redeem_with_credit_option = '//select[@id="redeem-types"]//option[@value="voucher"]'
redeem_with_number_option = '//select[@id="redeem-types"]//option[@value="number"]'
input_voucher_code = '//input[@id="voucher-input"]'
store_credit_continue_button = '//button[@id="store-credit-Continue"]'
input_store_credit_opt = '//input[@class="active text-center form-control"]'
store_credit_verify_button = '//button[@id="verify-otp-btn"]'
store_credit_resend_otp_button = '//button[@id="store-credit-Resend OTP"]'
store_credit_validation_message = '//div[@class="alert alert-dismissible alert-danger"]'
apply_store_credit_voucher='//button[@id="apply-voucher-storecredit"]'
active_promo_dropdown_row = '//ul[@class="m-0 filter-dropdown list-unstyled"]//li//span'
promo_name_in_product_row = '//span[@class="offer active text-green"]'
disabled_cash_continue_button = '//span[text()="Continue"]//ancestor::button[@disabled="disabled"]'
payment_mode_label = '(//div[@class="col light"])[1]//span'
paid_amount_by_mop = '(//div[@class="col text-right"])[1]//p'
amount_paid_by_customer = '(//div[@class="col text-right p-0"])[1]//h6'
amount_paid_at_checkout = '(//div[@class="col text-right p-0"])[2]//h6'

# Store Credit
partial_redemption_lapse_alert = '//span[contains(text(),"Partial redemption not allowed")]'
full_redemption_popup = '//div[@id="redeemconfrim___BV_modal_content_"]'
cancel_redeem_lapse_button = '//button[@id="cacnel-redeem-btn"]'
continue_redeem_lapse_button = '//button[@id="confirm-redeem-btn"]'
additional_mop_popup = '//div[@class="modal-content"]'
customer_paid_field = '//input[@id="input-for-customer-paid"]'
customer_paid_label = '//label[@id="label-for-customer-paid__BV_label_"]'
less_account_balance_alert = '//p[contains(normalize-space(),"A mimimum payment of AMOUNT is required to complete this on-account sale.")]'    # Change AMOUNT
minimum_payment_required = '//h6[text()="Minimum Payment Required"]//following-sibling::p'
minimum_order_acceptance_amount = '//span[contains(text(),"Minimum order acceptance amount is")]'
phone_number_redeem_store_credit="//input[@class='mb-2 mr-sm-2 mb-sm-0 form-control']"

greater_amount_popup = "//div[@class='alert alert-dismissible alert-danger' and contains(text(),'Entered amount is greater than bill amount.')]"

cash_order_summary="//div[@class='col light']//child::span[text()='Cash']"
paytm_order_summary="//div[@class='col light']//child::span[text()='Debit Note']"

invoice_number_checkout = '//div[@class="col-md-6"]//label[text()="Invoice Number"]//following-sibling::p'
total_amount_checkout = '//div[@class="col-md-6"]//label[text()="Total Amount"]//following-sibling::p'
bill_container = '//div[@class="print-box"]'
name_invoice = '//div[@class="modal-content"]//td[contains(text(),"Name")]/span'
number_invoice = '//div[@class="modal-content"]//td[contains(text(),"Number")]/span'
invoice_no = '//div[@class="modal-content"]//td[contains(text(),"Invoice No: ")]/span'
invoice_barcode = '//div[@class="modal-content"]//td[contains(text(),"8906118410774")]'
invoice_amount = '(//div[@id="cool"]//tbody[@style="vertical-align: text-bottom;"]/tr/td)[last()]'

fulfilment_option = '//h6[@class="mb-4"]'
payment_saved_successful = '//div[@class="popup-notification"]//div'
fulfilment_options_heading = '//h6[@class="mb-4" and contains(text(),"Fulfilment Options")]'
fulfilment_due_date_option = '//input[@id="datepicker"]'
fulfilment_calendar_window = '//div[@class="vdp-datepicker__calendar" and @style=""]'
last_date_of_this_month = '(//div[@class="vdp-datepicker__calendar" and @style=""]//div//child::span[contains(text(),"30") or contains(text(),"31") or contains(text(),"29")])[last()]'
continue_fulfilment_button = '//button[@class="btn btn-primary btn-block" and text()="Continue"]'
place_order_button = '//button[contains(@class,"btn btn-primary btn-block") and contains(text(),"Place Order")]'
min_acceptance_criteria_fulfilled = '//span[@class="ml-2" and contains(text(),"Minimum order acceptance criteria fulfilled")]'