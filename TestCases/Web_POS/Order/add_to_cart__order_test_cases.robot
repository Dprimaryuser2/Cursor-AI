*** Settings ***
Library    SeleniumLibrary
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource   ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot
Library    ../../../Resources/CustomKeywords/utilities.py
Resource    ../../../Resources/Web_POS/POS/Billing/split_payment_keyword.robot
Resource   ../../../Resources/Web_POS/POS/Billing/manual_discount_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Exchange/exchange_keyword.robot
Resource   ../../../Resources/Web_POS/POS/Billing/mode_of_payment_keyword.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Order${/}add_to_cart_order_test_data.xlsx

*** Test Cases ***
Zwing_O_1 

Zwing_O_2 

Zwing_O_3 

Zwing_O_4 

Zwing_O_5 

Zwing_O_6 

Zwing_O_7 

Zwing_O_8

Zwing_O_9

Zwing_O_10

Zwing_O_11

Zwing_O_12

Zwing_O_13

Zwing_O_14

Zwing_O_15

Zwing_O_16

Zwing_O_17

Zwing_O_18

Zwing_O_19

Zwing_O_20
