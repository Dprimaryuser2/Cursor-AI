add_customer_link = '(//a[@id="add-new-customer"])[1]'
customer_phone_field = '//input[@id="Cust-Phone"]'
continue_billing_button = '//button[@id="continue-billing"]'
customer_information_title = '//span[text()="Customer Information"]'
customer_information_phone_field = '//input[@id="Cust-Phone"]'
customer_first_name_field = '//input[@id="Customer-Name-input"]'
customer_last_name_field = '//input[@id="Customer-Name-input-2"]'
customer_email_field = '//input[@id="custEmail-input"]'
gender_select_field = '//select[@id="gender-select"]'
male = '//option[@value="Male"]'
female = '//option[@value="Female"]'
dob_field = '//input[@id="date_of_birth"]'
day_month_field = '//span[@class="day__month_btn up"]'
prev_arrow = '(//span[@class="prev"])[2]'
month_year_field = '//span[@class="month__year_btn up"]'
month_field = '//span[text()="month"]'
day_field = '(//div[@class="vdp-datepicker__calendar"])[1]/div/span[text()="day"]'
sales_invoice = '//span[text()="Sales invoice"]//ancestor::div[@class="custom-control custom-control-inline custom-radio"]/input'
address_line1 = '//input[@id="custAddress-1"]'
address_line2 = '//input[@id="custAddress2"]'
landamrk = '//input[@id="input-landmark"]'
pincode = '//input[@id="custPin"]'
start_billing_button = '//button[@id="start-billing"]'
state_select = '//select[@id="select-state"]'
state_option = '//option[@id="state"]' # change state name
select_city = '//select[@id="select-city"]'
city_option = '//option[@id="city"]'

#edit groups locators
edit_groups_button = '//button[@id="edit-groups"]'
edit_groups_window_header = "//header[@class='modal-header']//child::h5[@class='modal-title' and contains(text(),'Assign customer group')]"
customer_group_checkbox = "//div[@class='custom-check hover-color mb-1']//child::div//label[contains(normalize-space(),'Dummy')]"      # replace Dummy with the Group name         # modify
save_button_customer_group = "//button[@id='save-customer-group']//child::span"
cg_saved_successfully_popup= " //div[@class='alert alert-dismissible alert-success fade show' and text()='Customer groups updated successfully.']"

#add tax invoice
tax_invoice = '//span[text()="Tax Invoice"]//ancestor::div[@class="custom-control custom-control-inline custom-radio"]/input'
cg_add_gst_button="//button[@id='add-gst' or @class='btn col-md-12 btn-secondary' and text()='Add GST']"
cg_manage_gstin_header='//header[@id="manage-gst___BV_modal_header_"]//child::h5[contains(text(),"Manage GSTIN")]'
add_new_gstin_link='//a[@id="add-new-gstin"]//child::img'
remove_gstin_icon="//img[@src='/img/remove.3693345b.svg']"
edit_gstin_icon="//div[@class='text-right col']//*[name()='svg']//*[name()='path' and contains(@fill,'currentCol')]"
confirm_selected_button="//button[@id='confirm-selected']//child::span[contains(text(),'Confim Selected')]"

#add new gstin
add_gstin_window_header='//header[@id="add-gst___BV_modal_header_"]//child::h5[contains(text(),"Add GSTIN")]'
close_gstin_window='//header[@id="add-gst___BV_modal_header_"]//child::button[@class="close"]'
gst_radio='//span[contains(text(),"GST")]//ancestor::label[@class="custom-control-label"]'
uin_radio='//span[contains(text(),"UIN")]//ancestor::label[@class="custom-control-label"]'
enter_legal_name='//input[@id="legal-name-input" and @placeholder="Enter legal name"]'
enter_15digit_gstin='//input[@id="input-gstin" and @placeholder="Enter 15 digit GSTIN…"]'
save_gstin_button="//button[@id='save-gstin']//child::span[contains(text(),'Save GSTIN')]"

#more info customer icon
customer_info_icon="//body/div[@id='app']/div[@id='theme']/div[@class='dashboard']/section/div[@class='container-fluid']/div[@class='row']/div[@class='fadein col-md-6 col-lg-6']/div[@class='row mt-2']/div[@class='col-md-6 col-lg-6']/div[@id='customer-info']//a"
customer_info_window_title='//header[contains(@id,"___BV_modal_header_")]//child::h5[text()="Customer Information"]'
customer_infowindow_cancel_button="//header[@id='__BVID__207___BV_modal_header_']//child::button"
customer_edit_info_button="//button[@id='edit-information' and @class='btn w-100 mb-3 btn-secondary']"
customer_edit_groups_button="//button[@id='edit-groups' and @class='btn w-100 mb-3 btn-secondary']"
customer_untag_button="//button[@id='untag-customer' and @class='btn w-100 mb-3 btn-danger']"
personal_info_phone_no="//label[@class='mb-0 pl-0' and contains(text(),'Phone Number')]//following-sibling::p"
personal_info_email="//label[@class='mb-0 pl-0' and contains(text(),'E-mail Address')]//following-sibling::p"
personal_info_name="//label[@class='mb-0 pl-0 fs-12' and contains(text(),'Customer Name')]//following-sibling::p"
personal_info_gender="//label[@class='mb-0 pl-0' and contains(text(),'Gender')]//following-sibling::p"
personal_info_dob="//label[@class='mb-0 pl-0 fs-12' and contains(text(),'Date of Birth')]//following-sibling::p"
personal_info_gstin_info="//label[@class='mb-0 pl-0 fs-12' and contains(text(),'GSTIN Information')]//following-sibling::p"
personal_info_address="//label[@class='mb-0 pl-0 fs-12' and contains(text(),'Address')]//following-sibling::p"
personal_info_pincode="//label[@class='mb-0 pl-0 fs-12' and contains(text(),'Pincode')]//following-sibling::p"
personal_info_state="//label[@class='mb-0 pl-0 fs-12' and contains(text(),'State')]//following-sibling::p"
personal_info_city="//label[@class='mb-0 pl-0 fs-12' and contains(text(),'City')]//following-sibling::p"
personal_info_groups="//div[@class='cust-summary-dark mt-2 mb-3 col-md-12 col-lg-12']//child::div"
account_effective_bal="(//div[@class='cust-summary-dark col-md-6 col-lg-6']//following-sibling::div//child::p//child::b)[1]"
account_due_store_debit="(//div[@class='cust-summary-dark col-md-6 col-lg-6']//following-sibling::div//child::p//child::b)[2]"
account_loyality="(//div[@class='cust-summary-dark col-md-6 col-lg-6']//following-sibling::div//child::p//child::b)[3]"
account_active_store_credit="(//div[@class='cust-summary-dark col-md-6 col-lg-6']//following-sibling::div//child::p//child::b)[4]"
customer_info_update_button = '//button[@id="update-details"]'
customer_tagged_popup = '//div[@class="alert alert-dismissible alert-success" and text()="Customer tagged successfully."]'
customer_untagged = '//div[@class="alert alert-dismissible alert-success fade show" and text()="Customer untagged."]'
available_on_account_limit = '(//p[@class="float-right mb-1"])[1]'
close_customer_window = '//button[@class="close"]'
# tagged customer info at cart page
tagged_customer_phone_no = '(//div[@class="c-number"]//p)[1]'
tagged_customer_name = '(//div[@class="c-number"]//following-sibling::div//p)[1]'
customer_tagging_mandatory_alert = '//div[@role="alert"]//h6[text()="Customer tagging is mandatory"]'
customer_info_close_element = '//button[@class="close"]'


store_credit_issue = '(//p[@class="float-right mb-1"])[13]'
customer_info_loyalty_points = '(//p[@class="float-right mb-1"])[12]'


group_assigned_name = '//span[@class="badge font-normal mr-2 px-2 py-2 badge-secondary"]'
discard_item_previous_session = '//button[@id="discard-items"]//span'
customer_group_checkbox_row = '//label[@class="ml-2"]'
invalid_number_message = '//div[@class="invalid-feedback"]'
disabled_number_continue_button = '//button[@class="btn mt-3 btn-primary disabled"]'
disabled_phone_no_field = '//input[@name="Cust-Phone" and @disabled="disabled"]'
gstin_number_in_row = '//div[@class="col"]'
cg_edit_gstin_icon = '//div[@class="d-flex justify-content-center align-items-center input-group-append"]'
invalid_gst_warning_label = '//p[text()="Invalid GST, must be in the format of "]'
assign_customer_group_heading = '//h5[@id="customer-group___BV_modal_title_"]'
cg_gstin_field = '//input[@id="custGST"]'

