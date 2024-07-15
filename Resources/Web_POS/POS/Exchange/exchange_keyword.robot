*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../Resources/CustomKeywords/utilities.py
Variables    ../../../../PageObjects/Web_POS/POS/hold_bill_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/checkout_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/pos_locators.py
Variables   ../../../../PageObjects/Web_POS/POS/add_customer_locator.py
Resource    ../../../../Resources/Web_POS/POS/split_payment_keyword.robot
Resource    ../../../../Resources/Web_POS/POS/manual_discount_keyword.robot
Resource  ../../../../Resources/Web_POS/POS/share_invoice_keywords.robot

*** Keywords ***
Cancel No Payment Required | Checkout Page
    Wait Until Page Contains Element    ${no_payment_required_confirm_button}
    Page Should Contain Element     ${no_payment_required_confirm_button}
    Click Element   ${no_payment_required_cancel_button}