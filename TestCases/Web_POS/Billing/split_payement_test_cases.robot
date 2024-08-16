*** Settings ***
Library    SeleniumLibrary
Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/billing_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/split_payment_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/manual_discount_keyword.robot
Resource    ../../../Resources/Web_POS/Prerequisites/prerequisite.robot

Test Setup  Open Application | POS
Test Teardown   Close Browser

#*** Variables ***
#${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Billing${/}split_payment_test_data.xlsx

*** Variables ***
${STAGING_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Staging${/}Web_POS${/}Billing${/}split_payment_test_data.xlsx
${PROD_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Production${/}Web_POS${/}Billing${/}split_payment_test_data.xlsx

*** Test Cases ***
Zwing_SP_1 Split payment option is available if policy is enabled
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_1
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Verify Split Payment Option Is Available If Policy Is Enabled
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_SP_2 Split Payment Policy Is Unavailable If Policy Is Disabled
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_2
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Verify Split Payment Policy Is Unavailable If Policy Is Disabled
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_SP_3 split payment toggle is enabled.
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_3
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Verify split payment toggle button is enabled
     [Teardown]   Revoke Licence Key | API   ${response}       ${pos_data}

Zwing_SP_4 split payment toggle is disabled.
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_4
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Verify split payment toggle button is disabled.
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_SP_5 complete payment by MOP as cash
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_5
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Payment By Cash   ${value}
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_SP_6 complete payment by MOP as UPI
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_6
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Split Payment By Paytm  ${value}
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_SP_7 complete payment by MOP as On Account sale
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_7
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Payment By Account On Sales     ${value}
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

#Zwing_SP_8 complete payment by MOP as card
#Due to Physical Card Payment

Zwing_SP_9 complete payment by combination of Cash, on Account sale
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_9
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Split Payment By Different Modes    ${pos_data}
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_SP_10 complete payment by combination of UPI and on Account sale
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_10
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Split Payment By Different Modes    ${pos_data}
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

#Zwing_SP_11 complete payment by combination of card and on Account sale
#Due to Physical Card Payment

#Zwing_SP_12 complete payment by combination of cash, UPI, on Account sale and card
#Due to Physical Card Payment

Zwing_SP_13 complete payment by combination of cash and upi
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_13
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Split Payment By Different Modes    ${pos_data}
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

#Zwing_SP_14 complete payment by combination of upi and card
#Due to Physical Card Payment

#Zwing_SP_15 complete payment by combination of cash and card
#Due to Physical Card Payment

Zwing_SP_16 Add bill discount with split payment
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_16
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    ${bill_data}    Apply Bill Manual Discount | Select From List    ${pos_data}
    Sleep    2
    Enable Split payment mode
    Split Payment By Redeem Voucher
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_SP_17 Redeem Gift voucher with split payment
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_17
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Split Payment By Redeem Voucher
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_SP_18 Redeem Store credit with credit voucher with split payment
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_18
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Collect Payment Using Store Credit  ${pos_data}
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

#Zwing_SP_19 Redeem Store credit with Phone number with split payment
#Due to Phone number otp

Zwing_SP_20 complete payment with combination of store credit, gift voucher and other MOP's
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_20
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Split Payment By Different Modes    ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_SP_21 Validate Total payment and Mop summary MOP's added after completing the payment
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_21
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Split Payment By Different Modes    ${pos_data}
    Verify Mop summaryMOP's added after completing the payment
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_SP_22 validate store credit of customer after using with split payment
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_22
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Collect Payment Using Store Credit  ${pos_data}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

#Zwing_SP_23 validate loyalty points of customer after using with split payment
#Loyality points on hold

Zwing_SP_24 Validate Account balance of customer after using with split payment
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_24
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details for partial payment    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    ${total_balance}    Get Account Balance
    ${balance_after_sale}   Payment By Account On Sales For Validation Of Effective Balance     ${value}
    Click On Back Button | Checkout
#    Add Customer Details for partial payment    ${pos_data}
    ${value1}  Validate Account Balance Are Equal On Tagged Customer Split Payment
    Verify Account Balance After Using Split Payment    ${value1}    ${balance_after_sale}
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_SP_25 Validate payable amount after every payment done in case of split payment.
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_25
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Validate payable amount after every payment     ${value}
    Split Payment By Cash    ${value}
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_SP_26 After enabling split payment enter payable amount more than bill amount
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_26
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    ${value}    Get payable amount
    Verify Billing Checkout
    Enable Split payment mode
    Payment By Cash More Then Payable Amount   ${value}
    Verify More Then Payable Amount Validation
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}

Zwing_SP_27 Make complete payment by discount and generate bill with 0 invoice.
    ${POS_TD}=    Get Test Data File    ${ENV}   ${STAGING_TD}  ${PROD_TD}
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}     TC_27
    ${response}=  Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Navigate To Update Product Window   ${pos_data}
    Apply Item Manual Discount | Update Product Popup   ${pos_data}
    Apply Item Manual Discount | Select From List  ${pos_data}
    Click On Update Product | Manual Discount
    ${value}    Get payable amount
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    No Payment Required | Checkout Page
    Verify If Payment is Complete Or Not
    [Teardown]    Revoke Licence Key | API   ${response}      ${pos_data}