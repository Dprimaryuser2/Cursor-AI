view_held_bills = '//button[@id="category-held-bills"]'
recall_bill='(//button[@class="btn mt-1 mr-2 btn-primary" and contains(text(),"Recall Bill")])[1]'
recall_bill_confirmation="//button[@class='btn ml-1 btn-primary btn-block']//child::span"
discard_bill='(//button[@class="btn mt-1 btn-danger" and contains(text(),"Discard Bill")])[1]'
hold_bill = '//button[@id="category-hold-bill"]'
hold_bill_confirmation = '//button[@id="put-hold-bill"]'
hold_bill_cancel = '//button[@id="cancel-hold-bill"]'
discard_bill_confirmation="//button[@class='btn ml-1 btn-danger btn-block']//child::span"
return_to_bill="//button[@class='btn float-right btn-dark btn-sm' and contains(text(),'Return to Bill')]"