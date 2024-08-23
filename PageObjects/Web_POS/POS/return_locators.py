cash_popup_heading_return = '//h5[@class="modal-title" and contains(text(),"Cash")]'
continue_cash_popup_button_return = '//button[contains(@id,"process-payment-btn")]'
cross_button_cash_popup_return = "//button[normalize-space()='×']"
return_successful_page = "//span[text()='Return Processed Successfully!']"
print_invoice_button_return = '//button[@id="print-invoice-btn"]'
share_invoice_button_return = '//button[@id="share-invoice-btn"]'
new_bill_button_return = '//button[@id="new-bill-btn" and contains(text(),"New Bill")]'
invoice_options_button_return = '//button[contains(@class,"btn dropdown-toggle btn-light btn-sm")]'
return_page_heading = "//h5[normalize-space()='Return']"
voucher_poppup_heading = "//h5[text()='Voucher']"
store_credit_payment_method = '//button[@id="refund-mode-voucher" and contains(text(),"Store Credit")]'
redeem_voucher_return = "//button[text()='Redeem Voucher']"
upi_payment_text = "//span[text()='Debit Note']"
redeem_voucher_payment_text = "//span[text()='Redeem Voucher']"
total_refund_amount = '//div[@class="p-y-zero-x-25half col-md-6"]//div//div//following-sibling::div//h6'
paytm_card_button_return = '//button[@class="btn text-center mb-2 btn-outline-secondary btn-block" and contains(text(),"PAYTM_CARD")]'
paytm_card_text = "//span[text()='Debit Note']"