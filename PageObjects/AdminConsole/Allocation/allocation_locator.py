# Allocation By Store
allocation = '//a[@href="https://staging.console.gozwing.com/admin/promo/promotion/allocation"]'
new_allocation = '//a[@class="btn pull-right btn-primary"]'
promotion_heading = "//h4[text()='Promotion Allocation']"
valid_from_calendar = '//label[text()="Valid From"]//following-sibling::div//i[@class="fa fa-calendar"]'
valid_from_date = '//div[contains(@aria-label,"date")]'
valid_to_calendar = '//label[text()="Valid To"]//following-sibling::div//i[@class="fa fa-calendar"]'
next_year_button = '//button[@title="Next year"]'
next_month_button = '//button[@title="Next month"]'
valid_to_date = '//div[contains(@aria-label,"May 29, 2025")]'
all_day_validity = '//label[@class="checkbtn mr-4"]/span'
limited_time_period = '//label[@class="checkbtn"]/span'
start_time_input = '//input[@class="form-control start-time" and @placeholder="Select start time"]'
select_time_period = '//div[@class="select-time vertical-scroll"]//li[text()="12 AM"]'  # change the time in text
fifth_slide = '//a[@role="button" and text()="5"]'
store_next_slide = '//div[@class="card px-0 mb-3"]//a[@aria-label="Next"]'
promo_next_slide = '//div[@class="card px-0"]//a[@aria-label="Next"]'
store_check_box = '//div[@class="table-body-cell" and contains(text(),"StoreName")]//preceding-sibling::div//input'  # Change Indexx9QA with other store name
promo_check_box = '//div[@class="table-body-cell" and contains(text(),"Promo")]//preceding-sibling::div//input'
review_allocation = '//button[text()="Review Allocation"]'
confirm_allocation_heading = '//h4[text()="Confirm Allocation"]'
save_allocation = '//button[@class="btn pull-right btn-primary" and contains(text(),"Save Allocation")]'
php_close_button = '//a[@class="phpdebugbar-close-btn"]'
