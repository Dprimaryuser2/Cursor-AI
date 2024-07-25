promotions_icon = '//span[text()="Promotions"]//preceding-sibling::i[normalize-space(@class="fa fa-fw fa-bullhorn")]//ancestor::a'
promo = '//a[@href="https://staging.console.gozwing.com/admin/promo/promotion/manage"]'
promotion_allocation_icon = '//span[text()="Promotions Allocation"]//preceding-sibling::i[normalize-space(@class="fa fa-fw fa-bullhorn")]//ancestor::a'
new_definition = "//button[text()='New definition']"
view_icon = '//i[@class="fa fa-eye"]'
filter_icon = '//i[@class="fa fa-filter"]'
promo_list_table = '//table[@class="table table-striped table-nowrap align-middle"]'

promo_list = '//table[@class="table table-striped table-nowrap align-middle"]//tbody'
search_field = '//input[@placeholder="Enter search query.."]'
first_promo_number = '((//tr[@class="collapse show"])[1]/td)[1]'
first_promo_name = '((//tr[@class="collapse show"])[1]/td)[2]'
first_promo_basis = '((//tr[@class="collapse show"])[1]/td)[3]'
first_promo_type = '((//tr[@class="collapse show"])[1]/td)[4]'

delete_icon = "//i[@class = 'fa fa-trash-o']"
yes_remove_button = "//button[@class= 'btn btn-primary' and text()='Yes Remove']"

select_promotions = '//p[contains(text(),"Select Promotions")]//following-sibling::div[@class="table-responsive-md zw-table"]//select[@class="form-select form-select-sm fs-11"]'
all_promos = '//p[contains(text(),"Select Promotions")]//following-sibling::div[@class="table-responsive-md zw-table"]//select[@class="form-select form-select-sm fs-11"]/option[contains(text(),"All")]'
