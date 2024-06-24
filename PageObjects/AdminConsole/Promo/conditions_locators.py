condition_text = "//h5[text()='Conditions']"
buy_specification_text = '//h5[text()="Buy specifications"]'
get_specification_text = '//h5[text()="Get specifications"]'
quantity_radio = '//input[@value="replace"]'
quantity = '//input[@class="form-control" and @type="number"]'

assortment_click_field = '(//tr[@class="parent-box"]//div[@class="multiselect__tags"])'
assortment_data_field = '//input[@class="multiselect__input" and @style="width: 100%;"]'
assortment_first_option = '(//li[@class="multiselect__element"])[3]'

# ratio_field = "//tr[@class='parent-box']//input[@type='number']"
add_row = "//button[text()='Add row']"

benifit_type = '//div[@class="right-side-space"]'
flat_discount = "//input[@name='Flat Discount']"
buy_pool = "//label[text()='X  no of Item(s) from BUY Pool']"
get_pool = '//input[@name="X unit of item(s) from GET pool"]'

# 100 % discount
free = '//input[@value="100_P"]'

# click field of discount on
discount_on_click_field = '//div[@class="discount d-flex w-100 align-items-center"]//select[@class="form-select fs-12" and not(@disabled)]'

# percent
percent_discount_radio = '//input[@value="UNIT_P"]'
percent_discount_data = '//input[@value="UNIT_P"]//following-sibling::input[@class="form-control percent"]'
discount_on_click_field = '//input[@value="UNIT_P"]//following-sibling::select[@class="form-select fs-12"]'
discount_on_type = '//input[@value="UNIT_P"]//following-sibling::select[@class="form-select fs-12"]/option[@value="S"]'

# Rs Discount on
rs_discount_radio = '//input[@value="UNIT_A"]'
rs_discount_data = '//input[@value="UNIT_A"]//following-sibling::input[@class="form-control percent"]'
rs_discount_on_click_field = '//input[@value="UNIT_A"]//following-sibling::select[@class="form-select fs-12"]'
rs_discount_on_type = '//input[@value="UNIT_A"]//following-sibling::select[@class="form-select fs-12"]/option[@value="S"]'


# Fixed Discount on
fixed_discount_radio = '//input[@value="UNIT_F"]'
fixed_discount_data = '//input[@value="UNIT_F"]//following-sibling::input[@class="form-control percent"]'
fixed_discount_on_click_field = '//input[@value="UNIT_F"]//following-sibling::select[@class="form-select fs-12"]'
fixed_discount_on_each = '//input[@value="UNIT_F"]//following-sibling::select[@class="form-select fs-12"]/option[@value="E"]'
fixed_discount_on_all = '//input[@value="UNIT_F"]//following-sibling::select[@class="form-select fs-12"]/option[@value="A"]'

# get assortment
get_assortment_click_field = '//div[@class="parent-box"]//div[@class="multiselect__tags"]'
get_assortment_data_field = '//div[@class="parent-box"]//div[@class="multiselect__tags"]/input'
get_assortment_option_field = '(//li[@class="multiselect__element" and @id="null-0"])[3]'

# buy pool
get_any_unit = "//p[contains(text(),'Get any ')]//input"

# get pool
get_any_unit_radio = '//input[@value="UNIT_QTY"]'
get_any_unit_get_pool = '//input[@value="UNIT_QTY"]//following-sibling::label//input'
get_any_qty_radio = '//input[@value="ANY_QTY"]'

conditions_save_button = '//button[text()="Save"]'

buy_any_option = "//input[@value= 'S']"
ratio_assortment_option = "//input[@value= 'R']"
quantity_from_assortment_option = "//input[@value= 'A']"
ratio_field = "//tr[@class='parent-box']//input[@type='number']"

# slab definition
slab_qty_from = '((//b[contains(text(),"Slab definition")]//ancestor::div[@class="modal-right-space mb-2"]//tbody)[1]//input[@type="number"])[1]'
slab_qty_to = '((//b[contains(text(),"Slab definition")]//ancestor::div[@class="modal-right-space mb-2"]//tbody)[1]//input[@type="number"])[2]'
slab_benifit_description = '(//b[contains(text(),"Slab definition")]//ancestor::div[@class="modal-right-space mb-2"]//tbody)[1]//input[@type="text"]'
add_slab_row = "//button[text()='Add Row']"
benifits_slab_element = '//i[@class="fa fa-cogs"]'
save_benifits_button = '//h5[text()="Benefits"]//ancestor::div[@class="modal-content"]//button[text()="Save"]'

#  php debugger
php_close_button = '//a[@class="phpdebugbar-close-btn"]'