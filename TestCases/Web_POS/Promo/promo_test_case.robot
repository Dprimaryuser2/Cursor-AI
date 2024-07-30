*** Settings ***
Library    SeleniumLibrary
Library    ../../../Resources/CustomKeywords/utilities.py
Resource   ../../../Resources/Web_POS/Login/login_keyword.robot
Resource    ../../../Resources/Web_POS/POS/Billing/promo_keyword.robot
Resource    ../../../Resources/AdminConsole/Login/login_keyword.robot
Resource    ../../../Resources/AdminConsole/Allocation/allocation_keywords.robot
Resource    ../../../Resources/Web_POS/POS/Billing/customer_keyword.robot

#Suite Setup    Allocate All Promos To Store    ${POS_TD}
#Test Setup    Open Application | Admin
Test Teardown   Close Browser

*** Variables ***
${POS_TD}=    ${CURDIR}${/}..${/}..${/}..${/}TestData${/}Web_POS${/}Promo${/}promo_test_data.xlsx

*** Test Cases ***
Buy any one item get flat 50% Discount
    [Documentation]    50% discount promo
    [Tags]    ZWQE-TC-120
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_01
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name    ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Flat Discount | Percentage    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Percentage Discount On Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any 1 item from assortment and get flat Rs. 300 off
    [Documentation]   flat Rs. 300 off
    [Tags]    ZWQE-TC-121
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_02
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name    ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Flat Discount | Rupees    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Flat Discount In Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any 1 item from assortment and get fixed price Rs 300 for each
    [Documentation]    fixed price Rs 300 each
    [Tags]    ZWQE-TC-122
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_03
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name    ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Fixed Discount    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Fixed Discount In Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any 2 item from assortment get fixed price Rs. 300 off for all
    [Documentation]    fixed price Rs 300 all
    [Tags]    ZWQE-TC-123
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_04
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Fixed Discount    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Fixed Discount In Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any 2 from Buy pool and get 1 free
    [Documentation]    Buy 2 get one free
    [Tags]    ZWQE-TC-124
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_05
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Pool | Get Free From Same Assortment    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Pool In Checkout Page | Get Free From Same Assortment    ${pos_data}
    Verify Invoice Details After Payment

Buy any 1 item from BUY pool and get any quantity of item from Get pool
    [Documentation]    Buy 1from buy pool and get any from get pool free
    [Tags]    ZWQE-TC-125
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_06
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy from BUY pool and get any quantity from Get pool    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy from BUY pool and get any quantity from Get pool | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any 1 item from BUY pool and get any 1 quantity of item from Get pool
     [Documentation]    Buy 1from buy pool and get any from get pool free
     [Tags]    ZWQE-TC-126
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_07
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy 1 from BUY pool and get 1 from Get pool    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy from BUY pool and get any quantity from Get pool | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy specific quantity in item ratio and Get 50% Discount
    [Documentation]    Buy 1from buy pool and get any from get pool free
    [Tags]    ZWQE-TC-127
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_08
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy item in ratio and Get Percentage off   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy item in ratio and Get Percentage off | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy specific quantity in item ratio and Get 300 Rs Discount
    [Documentation]    Buy 1from buy pool and get any from get pool free
    [Tags]    ZWQE-TC-128
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_09
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy specific quantity in ratio and Get Discount In Rupees  ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy specific quantity in ratio and Get Discount In Rupees | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity from different assortment and Get 50% Discount
    [Documentation]    Buy 1from buy pool and get any from get pool free
    [Tags]    ZWQE-TC-129
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_10
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy item in ratio and Get Percentage off   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy item in ratio and Get Percentage off | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy 3 Get 50% off on 1 item
    [Documentation]    QBSB-Any___qty-Buypool-Flat-percentage
    [Tags]    ZWQE-TC-130
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_11
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy 3 Get 50 % Off on One Item     ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy 3 Get 50 % Off On One Item | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy 3 Get 300 Rs off on 1 item
    [Documentation]    QBSB-Any____qty-Buypool-Flat-Rupees
    [Tags]    ZWQE-TC-131
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_12
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy 3 Get 300 Rs Off On 1 Item     ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy 3 Get 300 Rs Off On 1 Item | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy 5 Get 2 item for Rs 300 in each
    [Documentation]    QBSB-Any____qty-Buy Pool-fixed-each
    [Tags]    ZWQE-TC-132
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_13
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy 5 Get 2 Item For Rs 300 In Each     ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy 5 Get 2 Item For Rs 300 In Each | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy 5 Get 2 item for Rs 300 on all
    [Documentation]    QBSB-Any Qty-Buy pool-Fixed-all
    [Tags]    ZWQE-TC-133
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_14
#    Login With Valid Username And Password    ${pos_data}
#    Go To Allocation Page
#    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy 5 Get 2 Item For Rs 300 On All     ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Sleep    5s
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy 5 Get 2 Item For Rs 300 On All | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any 1 item from BUY pool and get any 1 quantity with Rs 300 off from Get pool
    [Documentation]    QBSB-Any Qty-get pool-spf-Rupees
    [Tags]    ZWQE-TC-134
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_15
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy 1 Item Get Off On One Item     ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy 1 Item Get Off On One Item | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any 1 item from BUY pool and get any 2 quantity with Rs 300 each from Get pool
    [Documentation]    QQBSB-Any Qty-get pool-spf-Fixed-each
    [Tags]    ZWQE-TC-135
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_16
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Pool 1 And Get Pool 2 At Rs. 300 Each    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Pool 1 And Get Pool 2 At Rs. 300 Each | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any 1 item from BUY pool and get any 2 quantity with Rs 300 all from Get pool
    [Documentation]    QBSB-Any Get pool-spf-Fixed-all-each
    [Tags]    ZWQE-TC-136
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_17
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Pool 1 And Get Pool 2 At Rs. 300 All    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Pool 1 And Get Pool 2 At Rs. 300 All | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy item in ratio of 2:3 and get item at 300 all
    [Documentation]    QBSB-Specificity-Flat-fixed-all
    [Tags]    ZWQE-TC-137
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_18
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Item In 2:3 And Get At Rs. 300 All    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any Quantity Between Slab And Get Rs. Discount On All | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy item in ratio of 2:3 and get item at 300 each
    [Documentation]    QBSB-Specificity-Flat-fixed-each
    [Tags]    ZWQE-TC-138
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_19
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Item In 2:3 And Get At Rs. 300 Each    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Item In 2:3 And Get At Rs. 300 Each | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any 1 item from BUY pool and get any quantity with 50% off from Get pool
    [Documentation]    QBSB-Any____Qty-get pool-any-perc
    [Tags]    ZWQE-TC-139
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_20
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Pool Get Any With % Off     ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Pool Get Any With % Off | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any 2 item from BUY pool and get any quantity of item at Rs 300 discount on Get pool
    [Documentation]    QBSB-Any____Qty-get pool-any-rupees
    [Tags]    ZWQE-TC-140
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_21
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any From Buy pool And Get Discount In Rupees  ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any From Buy pool And Get Discount In Rupees | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any 2 item from BUY pool and get any quantity of item at Rs 300 each on Get pool
    [Documentation]    QBSB-Any____Qty-get pool-any-fixed-each
    [Tags]    ZWQE-TC-141
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_22
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any From Buy pool And Get Fixed Price Each  ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any From Buy pool And Get Fixed Price Each | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any 2 item from BUY pool and get any quantity of item at Rs 300 all in Get pool
    [Documentation]    QBSB-Any____Qty-get pool-any-fixed-all
    [Tags]    ZWQE-TC-142
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_23
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability of BUY pool and get any quantity of item at Rs 300 all in Get pool     ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Invoice Details After Payment

Buy any 1 item from BUY pool and get any 1 quantity with 50% off from Get pool
    [Documentation]    QBSB-Any____Qty-get pool-spf-perc
    [Tags]    ZWQE-TC-143
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_24
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off  ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity from different assortment and Get Rs300 Discount
    [Documentation]    QBSB-Any qty-flat-rupees
    [Tags]    ZWQE-TC-144
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_25
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy From Different Assortment And Get Rupees Discount    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy from different assortment and Get Rupees Discount | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity from different assortment and Get each item at 300
    [Documentation]    QBSB-Any qty-flat-fixed-each
    [Tags]    ZWQE-TC-145
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_26
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Fixed Discount      ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Fixed Discount In Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity from different assortment and Get all item at 300
    [Documentation]    QBSB-Any qty-flat-fixed-all
    [Tags]    ZWQE-TC-146
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_27
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy From Different Assortment And Get All Item At Some Rupees     ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy From Different Assortment And Get All Item At Some Rupees | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity between slab of 2-5 and get all item free in that slab
    [Documentation]    QBSLB-flat-free
    [Tags]    ZWQE-TC-147
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_28
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any Between Slab And Get Free  ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify 100% Free Billing Checkout

Buy any quantity between slab of 2-5 and get item at 50% free in that slab
    [Documentation]    QBSLB-flat-perc
    [Tags]    ZWQE-TC-148
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_29
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Between Slab And Get Percent Discount On SSP    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Between Slab And Get Percent Discount On SSP | Checkout Page   ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity between slab of 2-5 and get item at 300 rs free in that slab
    [Documentation]     QBSlB-flat-rupee
    [Tags]    ZWQE-TC-149
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_30
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any Between Slab And Get Rs. OFF On SSP   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any Between Slab And Get Rs. Discount On Each | Checkout Page  ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity between slab of 2-5 and get item at 300 rs on each item
    [Documentation]     QBSlB-flat-fixed-each
    [Tags]    ZWQE-TC-150
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_31
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any Quantity Between Slab And Get Rs. Discount On Each  ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any Between Slab And Get Rs. Discount On Each | Checkout Page  ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity between slab of 2-5 and get item at 300 rs on all item
    [Documentation]     QBSlB-flat-fixed-all
    [Tags]    ZWQE-TC-151
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_32
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any Quantity Between Slab And Get Rs. Discount On All    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any Quantity Between Slab And Get Rs. Discount On All | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit of item e.g(1) at 100% flat disc from buy pool
    [Documentation]    QBSlB-Buy-100 disc
    [Tags]    ZWQE-TC-152
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_33
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Pool Slab Flat Discount In Percentage   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Pool Slab Flat Discount In Percentage | Checkout Page   ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit of item e.g(1) at 50%disc from buy pool
    [Documentation]    QBSlB-Buy-perc
    [Tags]    ZWQE-TC-153
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_34
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Pool Slab Flat Discount In Percentage   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Pool Slab Flat Discount In Percentage | Checkout Page   ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity between slab of 2-5 from buy bool and get any unit of item e.g(1) at 300 rupees from buy pool
    [Documentation]     QBSlB-Buy-rupee
    [Tags]    ZWQE-TC-154
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_35
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Between Slab Get Discount In Rupees In Buy Pool   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy 3 Get 300 Rs Off On 1 Item | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit of item e.g(1) at 300 rupees for all item from buy pool
    [Documentation]    QBSlB-Buy-fixed-all
    [Tags]    ZWQE-TC-155
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_36
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Pool Slab Fixed Discount In Rupees   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Pool Slab Fixed Discount | Checkout Page   ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit of item e.g(1) at 300 rupees for each item from buy pool
    [Documentation]     QBSlB-Buy-fixed-each
    [Tags]    ZWQE-TC-156
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_37
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Between Slab Get Rs. Discount On Each In Buy Pool     ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Between Slab Get Rs. Discount On Each In Buy Pool | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity betweeb slaab of 2-5 from buy pool and get any quantity from assortment at 100% discount item from get pool
    [Documentation]    QBSlB-Get-any-100 % disc
    [Tags]    ZWQE-TC-157
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_38
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off | Checkout Page   ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity betweeb slaab of 2-5 from buy bool and get any quantity from assortment at 50% discount item from get pool
    [Documentation]    QBSlB-Get-any-perc
    [Tags]    ZWQE-TC-158
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_39
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off | Checkout Page   ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity betweeb slaab of 2-5 from buy pool and get any quantity from assortment at 300rs. discount item from get pool
    [Documentation]    QBSlB-Get-any-rupee
    [Tags]    ZWQE-TC-159
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_40
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy from different assortment and Get Rupees Discount   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Pool Slab and Get Rupees Discount | Checkout Page   ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity betweeb slaab of 2-5 from buy bool get any quantity from assortment at fixed price 300 rupees discount on each item from get pool
    [Documentation]    QBSlB-Get-any-fixed-each
    [Tags]    ZWQE-TC-160
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_41
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At Each  ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At Each | Checkout Page   ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity betweeb slaab of 2-5 from buy bool and get any quantity from assortment at fixed price 300 rupees discount on all item from get pooll
    [Documentation]    QBSlB-Get-any-fixed-all
    [Tags]    ZWQE-TC-161
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_42
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At All  ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At All | Checkout Page   ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit e.g 1 from assortment at 100% discount from get pool
    [Documentation]    QBSlB-Get-any-unit 100% disc
    [Tags]    ZWQE-TC-162
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_43
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off  ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off | Checkout Page   ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit e.g 1 from assortment at 50% discount from get pool
    [Documentation]    QBSlB-Get-any-unit perc
    [Tags]    ZWQE-TC-163
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_44
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off  ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off | Checkout Page   ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit e.g 1 from assortment at 300 rupees discount from get pool
    [Documentation]    QBSlB-Get-any-rupee
    [Tags]    ZWQE-TC-164
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_45
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy from different assortment and Get Rupees Discount  ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy from different assortment and Get Rupees Discount | Checkout Page   ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit e.g 1 from assortment at Fixed each 300 rupees discount from get pool
    [Documentation]    QBSlB-Get-any-unit fixed-each
    [Tags]    ZWQE-TC-165
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_46
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At Each  ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At Each | Checkout Page   ${pos_data}
    Verify Invoice Details After Payment

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit e.g 2 from assortment at Fixed all 300 rupees discount from get pool
    [Documentation]    QBSlB-Get-any-unit fixed-all
    [Tags]    ZWQE-TC-166
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_47
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At All  ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At All | Checkout Page   ${pos_data}
    Verify Invoice Details After Payment

Buy from Assortment, For Slab 1000 : 3999, Get free, For Slab 4000 : , Get free at 100 % disc
    [Documentation]   VBSLB-flat -100% disc
    [Tags]    ZWQE-TC-167
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_48
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any Between Slab And Get Free  ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify 100% Free Billing Checkout

Buy from Assortment , For Slab 1000.00 : 3999.00, Get free, For Slab 4000.00 : 0, Get 50 % off on SSP
    [Documentation]   VBSLB-flat-percent
    [Tags]    ZWQE-TC-168
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_49
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Between Slab And Get Percent Discount On SSP    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Between Slab And Get Percent Discount On SSP | Checkout Page   ${pos_data}
    Verify Invoice Details After Payment

Buy from Assortment, For Slab 1000.00 : 3999, Get 300Rs off on SSP, For Slab 4000 : 0, Get 300Rs off on SSP
    [Documentation]   VBSLB-flat-rupees
    [Tags]    ZWQE-TC-169
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_50
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any Between Slab And Get Rs. OFF On SSP   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any Between Slab And Get Rs. Discount On Each | Checkout Page  ${pos_data}
    Verify Invoice Details After Payment

Buy from Assortment For Slab 1000 : 3999, Get 300Rs and Slab 4000 : 0, Get 300Rs fixed off on Each item
    [Documentation]   VBSLB-flat-fixed each
    [Tags]    ZWQE-TC-170
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_51
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any Quantity Between Slab And Get Rs. Discount On Each  ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any Between Slab And Get Rs. Discount On Each | Checkout Page  ${pos_data}
    Verify Invoice Details After Payment

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00 and For Slab 4000.00 : 0, Get 300Rs fixed off on all item
    [Documentation]   VBSLB-flat-fixed all
    [Tags]    ZWQE-TC-171
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_52
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any Quantity Between Slab And Get Rs. Discount On All    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any Quantity Between Slab And Get Rs. Discount On All | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy from Assortment [WM10], For Slab 1000.00 : 3999, Get from WM11, Get free, For Slab 4000.00 : 0, Get from WM11, Get free
    [Documentation]   VBSLB-Get-any-100
    [Tags]    ZWQE-TC-172
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_53
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00, Get from WM11, Get 50 % off on SSP, For Slab 4000.00 : 0, Get from WM11, Get 50 % off on SSP
    [Documentation]   VBSLB-Get-any-perc
    [Tags]    ZWQE-TC-173
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_54
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00, Get from WM11, Get 300.000Rs off on SSP, For Slab 4000.00 : 0, Get from WM11, Get 300.000Rs off on SSP
    [Documentation]   VBSLB-Get-any-rupee
    [Tags]    ZWQE-TC-174
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_55
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy from different assortment and Get Rupees Discount    ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy from different assortment and Get Rupees Discount | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00, Get from WM11, Get 300.000Rs fixed off on Each, For Slab 4000.00 : 0, Get from WM11, Get 300.000Rs fixed off on Each
    [Documentation]   VBSLB-Get-any-fixed-each
    [Tags]    ZWQE-TC-175
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_56
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At Each   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At Each | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00, Get from WM11, Get 300.000Rs fixed off on Each, For Slab 4000.00 : 0, Get from WM11, Get 300.000Rs fixed off on all
    [Documentation]   VBSLB-Get-any-fixed-all
    [Tags]    ZWQE-TC-176
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_57
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At All   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At All | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00, Get 1 unit from WM11,Get free, For Slab 4000.00 : 0, Get 1 unit from WM11, Get free
    [Documentation]   VBSLB-Get-any-unit- 100
    [Tags]    ZWQE-TC-177
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_58
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00, Get 1 unit from WM11, Get 50 % off on SSP, For Slab 4000.00 : 0, Get 1 unit from WM11, Get 50 % off on SSP
    [Documentation]   VBSLB-Get-any-unit- perc
    [Tags]    ZWQE-TC-178
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_59
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy Any From Buy pool And Get Percent Off | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00, Get 1 unit from WM11, Get 300Rs off on SSP, For Slab 4000.00 : 0, Get 1 unit from WM11, Get 300Rs off on SSP
    [Documentation]   VBSLB-Get-any-unit- rupee
    [Tags]    ZWQE-TC-179
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_60
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy From Different Assortment And Get Rupees Discount   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy From Different Assortment And Get Rupees Discount | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy from Assortment [WM10], For Slab 1000 : 3999,and For Slab 4000 : , Get from WM11, Get 300Rs fixed off on Each Item
    [Documentation]   VBSLB-Get-any-unit- fixed-each
    [Tags]    ZWQE-TC-180
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_61
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At Each   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At Each | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00 and For Slab 4000.00 : 0, Get from WM11, Get 300.000Rs fixed off on all item
    [Documentation]   VBSLB-Get-any-unit- fixed-all
    [Tags]    ZWQE-TC-181
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_62
    Login With Valid Username And Password    ${pos_data}
    Go To Allocation Page
    Set Promotion Priority As Highest    ${pos_data}
    Close Browser
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Apply Item Promo | Manual
    Confirm Promotion Name     ${pos_data}
    Verify Promo Discount In Cart | POS
    Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At All   ${pos_data}
    Verify Promo Discount In Side Cart | POS
    Add Customer Details    ${pos_data}
    Verify Billing Checkout
    Verify Promo Discount On Modal | Checkout Page    ${pos_data}
    Verify Total Payable Amount At Checkout
    Verify Applicability Of Buy From Different Assortment And Get Fixed Discount At All | Checkout Page    ${pos_data}
    Verify Invoice Details After Payment

Verify customer tagging
    ${pos_data}=    Fetch Testdata By Id    ${POS_TD}    TC_01
    Open Application | POS
    Login With Valid Username And Password | POS   ${pos_data}
    Open The Session    ${pos_data}
    Scan Barcode To Add Item And Quantity To Cart    ${pos_data}
    Add Customer Details    ${pos_data}
    Edit Customer Information