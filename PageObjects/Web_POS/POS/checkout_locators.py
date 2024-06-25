checkout_button = "(//button[@id='checkout-btn'])[2]"
checkout_heading = '//div[@class="col-md-4 col-lg-6 col-4"]/h5'
checkout_payable_amount = '//label[@id="label-amt-pay"]//following-sibling::input'
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
remark_account_on_sale="//textarea[@id='input-account-remark']"
continue_account_on_sale_button="//button[@id='confirm-account-sale' and @class='btn w-20 btn-primary']"
#payment complete
print_invoice="//button[@id='print-invoice-btn' and @class='btn mt-2 btn-primary btn-block']"
share_invoice="//button[@id='share-invoice-btn' and @class='btn mt-4 mt-md-2 btn-primary btn-block']"

no_payment_required="//header[@id='__BVID__1628___BV_modal_header_']//child::h5[contains(text(),'No Payment Required')]"
no_payment_required_confirm_button="//button[@class='btn ml-1 btn-primary btn-block']//child::span[contains(text(),'Confirm')]"
checkout_split_payment='//div[@class="v-switch-button"]'