pos_terminal_link = '//span[text()="POS Terminals"]//ancestor::a'
pos_heading = '//h4[text()="POS Terminals "]'
tagged_device_edit_link = '//td[contains(text(),"Serial_Key")]//ancestor::tr//i'    # Replace Serial_Key with id
remove_device_icon = '//i[@class="fa fa-times fs-2x text-danger"]'
update_button = '//button[@class="btn pull-right btn-primary"]'
edit_modal_body = '//div[@id="show___BV_modal_content_"]'
edit_modal_title = '//h5[@id="show___BV_modal_title_" and text()="Edit POS Terminal"]'
pos_search_bar = '//input[@placeholder="Enter search query.."]'
remove_modal_body = '//div[contains(@id,"BV_modal_content_")]'
remove_button = '//button[@class="btn btn-primary" and text()="Remove"]'
tagged_device_column = '(//tr//td[@data-v-02c9d4fc][8])//span[@class=""]'
last_most_page_icon = '//li//a[@role="button" and @aria-label="Last"]'
last_page_number = '(//li//a[@role="button" and not(descendant::span)])[last()]'
tagged_device_icon = '(//tr//td[@data-v-02c9d4fc][8])//span[@class=""]//ancestor::tr//i'
first_most_page_icon = '//li//a[@role="button" and @aria-label="First"]'
next_page_icon = '//li//a[@role="button" and @aria-label="Next"]'

#Setup and more
setup_and_more = '//span[contains(text(),"Setup & More")]//ancestor::li[@class="treeview"]'
policies = '//ul[@class="treeview-menu"]//following-sibling::span[text()="Policies"]'
template_update_message = '//div[@role="alert"]//div[@class="toast-body" and  contains(text(),"Template updated successfully")]'
template_name_in_policies_row = '//tr[@class="collapse show"]//td[2]'
pencil_icon_in_policies_row = '//tr[@class="collapse show"]//td//following::i[@class="fa fa-pencil"]'
pencil_icon_in_policy_p8 = '(//tr[@class="collapse show"]//td[text()=" Policy P8"]//following::i[@class="fa fa-pencil"])[1]'
policy_search_field = '//input[@class="input is-rounded"]'
pos_dropdown_in_policies = '//h5[@class="panel-title mb-0" and text()="Pos"]'
tag_salesperson_toggle_on = '//div[text()="Tagging salesperson at POS"]//ancestor::div[@class="row mb-3 align-items-center mx-2"]//div[@class="col-md-1"]/div/span[@aria-checked="true"]/span[@class="toggle-indicator"]'
tag_salesperson_toggle_off = '//div[text()="Tagging salesperson at POS"]//ancestor::div[@class="row mb-3 align-items-center mx-2"]//div[@class="col-md-1"]/div/span[@aria-checked="false"]/span[@class="toggle-indicator"]'
radio_tag_sp_optional = '//div[text()="Tagging salesperson at POS"]//ancestor::div[@class="row mb-3 align-items-center mx-2"]//label[@class="checkbtn" and contains(text(),"Optional")]'
radio_tag_sp_mandatory = '//div[text()="Tagging salesperson at POS"]//ancestor::div[@class="row mb-3 align-items-center mx-2"]//label[@class="checkbtn" and contains(text(),"Mandatory")]'
save_policies = '//button[@class="btn btn btn-primary btn-md pull-right btn-primary" and text()="Save"]'

# Revoke from Console
tagged_device_column = '(//tr//td[@data-v-02c9d4fc][8])//span[@class=""]'
last_most_page_icon = '//li//a[@role="button" and @aria-label="Last"]'
last_page_number = '(//li//a[@role="button" and not(descendant::span)])[last()]'
tagged_device_icon = '(//tr//td[@data-v-02c9d4fc][8])//span[@class=""]//ancestor::tr//i'
first_most_page_icon = '//li//a[@role="button" and @aria-label="First"]'
next_page_icon = '//li//a[@role="button" and @aria-label="Next"]'