*** Settings ***
Library    SeleniumLibrary
Library    ../../Resources/CustomKeywords/utilities.py
Resource   ../../Resources/AdminConsole/Login/login_keyword.robot
Resource    ../../Resources/AdminConsole/Promo/promo_keyword.robot
Test Setup      Open Application | Admin
Test Teardown   Close Browser

*** Variables ***
${PROMO_TD}=    ${CURDIR}${/}..${/}..${/}TestData${/}AdminConsole${/}Promo${/}promo_test_data.xlsx

*** Test Cases ***
Buy any one item get flat 50% Discount
    [Documentation]    50% discount promo
    [Tags]    ZWQE-TC-62
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-01
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type   ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any 1 item from assortment and get flat Rs. 100 off
    [Documentation]   flat Rs. 300 off
    [Tags]    ZWQE-TC-63
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-02
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type   ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any 1 item from assortment and get fixed price Rs 100 for each
    [Documentation]    fixed price Rs 300 each
    [Tags]    ZWQE-TC-64
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-03
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any 2 item from assortment get fixed price Rs. 300 off for all
    [Documentation]    fixed price Rs 300 all
    [Tags]    ZWQE-TC-65
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-04
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any 2 from Buy pool and get 1 free
    [Documentation]    Buy 2 get one free
    [Tags]    ZWQE-TC-66
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-05
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any 1 item from BUY pool and get any quantity of item from Get pool
    [Documentation]    Buy 1from buy pool and get any from get pool free
    [Tags]    ZWQE-TC-183
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-06
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any 1 item from BUY pool and get any 1 quantity of item from Get pool
     [Documentation]    Buy 1from buy pool and get any from get pool free
     [Tags]    ZWQE-TC-67
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-07
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy specific quantity in item ratio and Get 50% Discount
    [Documentation]    Buy 1from buy pool and get any from get pool free
    [Tags]    ZWQE-TC-68
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-08
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy specific quantity in item ratio and Get 300 Rs Discount
    [Documentation]    Buy 1from buy pool and get any from get pool free
    [Tags]    ZWQE-TC-69
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-09
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity from different assortment and Get 50% Discount
    [Documentation]    Buy 1from buy pool and get any from get pool free
    [Tags]    ZWQE-TC-70
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-10
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy 3 Get 50% off on 1 item
    [Documentation]    QBSB-Any___qty-Buypool-Flat-percentage
    [Tags]    ZWQE-TC-71
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-11
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy 3 Get 300 Rs off on 1 item
    [Documentation]    QBSB-Any____qty-Buypool-Flat-Rupees
    [Tags]    ZWQE-TC-72
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-12
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy 5 Get 2 item for Rs 300 in each
    [Documentation]    QBSB-Any____qty-Buy Pool-fixed-each
    [Tags]    ZWQE-TC-73
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-13
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy 5 Get 2 item for Rs 300 on all
    [Documentation]    QBSB-Any Qty-Buy pool-Fixed-all
    [Tags]    ZWQE-TC-74
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-14
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any 1 item from BUY pool and get any 1 quantity with Rs 300 off from Get pool
    [Documentation]    QBSB-Any Qty-get pool-spf-Rupees
    [Tags]    ZWQE-TC-75
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-15
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any 1 item from BUY pool and get any 2 quantity with Rs 300 each from Get pool
    [Documentation]    QQBSB-Any Qty-get pool-spf-Fixed-each
    [Tags]    ZWQE-TC-76
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-16
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any 1 item from BUY pool and get any 2 quantity with Rs 300 all from Get pool
    [Documentation]    QBSB-Any Get pool-spf-Fixed-all-each
    [Tags]    ZWQE-TC-77
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-17
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any specific quantity in item ratio for all item
    [Documentation]    QBSB-Specificity-Flat-fixed-all
    [Tags]    ZWQE-TC-78
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-18
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any specific quantity in item ratio for each item
    [Documentation]    QBSB-Specificity-Flat-fixed-each
    [Tags]    ZWQE-TC-79
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-19
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any 1 item from BUY pool and get any quantity with 50% off from Get pool
    [Documentation]    QBSB-Any____Qty-get pool-any-perc
    [Tags]    ZWQE-TC-80
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-20
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any 2 item from BUY pool and get any quantity of item at Rs 300 discount on Get pool
    [Documentation]    QBSB-Any____Qty-get pool-any-rupees
    [Tags]    ZWQE-TC-81
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-21
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any 2 item from BUY pool and get any quantity of item at Rs 300 each on Get pool
    [Documentation]    QBSB-Any____Qty-get pool-any-fixed-each
    [Tags]    ZWQE-TC-82
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-22
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any 2 item from BUY pool and get any quantity of item at Rs 300 all in Get pool
    [Documentation]    QBSB-Any____Qty-get pool-any-fixed-all
    [Tags]    ZWQE-TC-83
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-23
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any 1 item from BUY pool and get any 1 quantity with 50% off from Get pool
    [Documentation]    QBSB-Any____Qty-get pool-spf-perc
    [Tags]    ZWQE-TC-84
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-24
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity from different assortment and Get Rs300 Discount
    [Documentation]    QBSB-Any qty-flat-rupees
    [Tags]    ZWQE-TC-182
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-25
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity from different assortment and Get each item at 300
    [Documentation]    QBSB-Any qty-flat-fixed-each
    [Tags]    ZWQE-TC-85
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-26
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity from different assortment and Get all item at 300
    [Documentation]    QBSB-Any qty-flat-fixed-all
    [Tags]    ZWQE-TC-86
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-27
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Specifications Condition    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Benefit Type    ${promo_data}
    Select Discount Type    ${promo_data}
    Select Discount On    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity between slab of 2-5 and get all item free in that slab
    [Documentation]    QBSLB-flat-free
    [Tags]    ZWQE-TC-87
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-28
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity between slab of 2-5 and get item at 50% free in that slab
    [Documentation]    QBSLB-flat-perc
    [Tags]    ZWQE-TC-88
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-29
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity between slab of 2-5 and get item at 300 rs free in that slab
    [Documentation]     QBSlB-flat-rupee
    [Tags]    ZWQE-TC-89
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-30
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity between slab of 2-5 and get item at 300 rs on each item
    [Documentation]     QBSlB-flat-fixed-each
    [Tags]    ZWQE-TC-90
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-31
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity between slab of 2-5 and get item at 300 rs on all item
    [Documentation]     QBSlB-flat-fixed-all
    [Tags]    ZWQE-TC-91
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-32
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit of item e.g(1) at 100% flat disc from buy pool
    [Documentation]    QBSlB-Buy-100 disc
    [Tags]    ZWQE-TC-92
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-33
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit of item e.g(1) at 50%disc from buy pool
    [Documentation]    QBSlB-Buy-perc
    [Tags]    ZWQE-TC-93
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-34
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity between slab of 2-5 from buy bool and get any unit of item e.g(1) at 300 rupees from buy pool
    [Documentation]     QBSlB-Buy-rupee
    [Tags]    ZWQE-TC-94
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-35
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit of item e.g(1) at 300 rupees for all item from buy pool
    [Documentation]    QBSlB-Buy-fixed-all
    [Tags]    ZWQE-TC-95
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-36
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit of item e.g(1) at 300 rupees for each item from buy pool
    [Documentation]     QBSlB-Buy-fixed-each
    [Tags]    ZWQE-TC-96
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-37
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity betweeb slaab of 2-5 from buy pool and get any quantity from assortment at 100% discount item from get pool
    [Documentation]    QBSlB-Get-any-100 % disc
    [Tags]    ZWQE-TC-97
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-38
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity betweeb slaab of 2-5 from buy bool and get any quantity from assortment at 50% discount item from get pool
    [Documentation]    QBSlB-Get-any-perc
    [Tags]    ZWQE-TC-98
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-39
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity betweeb slaab of 2-5 from buy pool and get any quantity from assortment at 300rs. discount item from get pool
    [Documentation]    QBSlB-Get-any-rupee
    [Tags]    ZWQE-TC-99
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-40
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity betweeb slaab of 2-5 from buy bool get any quantity from assortment at fixed price 300 rupees discount on each item from get pool
    [Documentation]    QBSlB-Get-any-fixed-each
    [Tags]    ZWQE-TC-100
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-41
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity betweeb slaab of 2-5 from buy bool and get any quantity from assortment at fixed price 300 rupees discount on all item from get pooll
    [Documentation]    QBSlB-Get-any-fixed-all
    [Tags]    ZWQE-TC-101
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-42
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit e.g 1 from assortment at 100% discount from get pool
    [Documentation]    QBSlB-Get-any-unit 100% disc
    [Tags]    ZWQE-TC-102
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-43
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit e.g 1 from assortment at 50% discount from get pool
    [Documentation]    QBSlB-Get-any-unit perc
    [Tags]    ZWQE-TC-103
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-44
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit e.g 1 from assortment at 300 rupees discount from get pool
    [Documentation]    QBSlB-Get-any-rupee
    [Tags]    ZWQE-TC-104
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-45
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit e.g 1 from assortment at Fixed each 300 rupees discount from get pool
    [Documentation]    QBSlB-Get-any-unit fixed-each
    [Tags]    ZWQE-TC-105
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-46
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy any quantity betweeb slaab of 2-5 from buy bool and get any unit e.g 2 from assortment at Fixed all 300 rupees discount from get pool
    [Documentation]    QBSlB-Get-any-unit fixed-all
    [Tags]    ZWQE-TC-106
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-47
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy from Assortment, For Slab 1000 : 3999, Get free, For Slab 4000 : , Get free at 100 % disc
    [Documentation]   VBSLB-flat -100% disc
    [Tags]    ZWQE-TC-107
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-48
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment   ${promo_data}
    Select Slab Definition | Quantity for VBSLB    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy from Assortment , For Slab 1000.00 : 3999.00, Get free, For Slab 4000.00 : 0, Get 50 % off on SSP
    [Documentation]   VBSLB-flat-percent
    [Tags]    ZWQE-TC-108
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-49
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity for VBSLB    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy from Assortment, For Slab 1000.00 : 3999, Get 300Rs off on SSP, For Slab 4000 : 0, Get 300Rs off on SSP
    [Documentation]   VBSLB-flat-rupees
    [Tags]    ZWQE-TC-109
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-50
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity for VBSLB    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy from Assortment For Slab 1000 : 3999, Get 300Rs and Slab 4000 : 0, Get 300Rs fixed off on Each item
    [Documentation]   VBSLB-flat-fixed each
    [Tags]    ZWQE-TC-110
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-51
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity for VBSLB    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00 and For Slab 4000.00 : 0, Get 300Rs fixed off on all item
    [Documentation]   VBSLB-flat-fixed all
    [Tags]    ZWQE-TC-111
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-52
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity for VBSLB    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy from Assortment [WM10], For Slab 1000.00 : 3999, Get from WM11, Get free, For Slab 4000.00 : 0, Get from WM11, Get free
    [Documentation]   VBSLB-Get-any-100
    [Tags]    ZWQE-TC-112
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-53
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity for VBSLB    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00, Get from WM11, Get 50 % off on SSP, For Slab 4000.00 : 0, Get from WM11, Get 50 % off on SSP
    [Documentation]   VBSLB-Get-any-perc
    [Tags]    ZWQE-TC-113
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-54
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity for VBSLB    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00, Get from WM11, Get 300.000Rs off on SSP, For Slab 4000.00 : 0, Get from WM11, Get 300.000Rs off on SSP
    [Documentation]   VBSLB-Get-any-rupee
    [Tags]    ZWQE-TC-114
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-55
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity for VBSLB    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00, Get from WM11, Get 300.000Rs fixed off on Each, For Slab 4000.00 : 0, Get from WM11, Get 300.000Rs fixed off on Each
    [Documentation]   VBSLB-Get-any-fixed-each
    [Tags]    ZWQE-TC-115
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-56
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity for VBSLB    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00, Get from WM11, Get 300.000Rs fixed off on Each, For Slab 4000.00 : 0, Get from WM11, Get 300.000Rs fixed off on all
    [Documentation]   VBSLB-Get-any-fixed-all
    [Tags]    ZWQE-TC-116
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-57
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity for VBSLB    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00, Get 1 unit from WM11,Get free, For Slab 4000.00 : 0, Get 1 unit from WM11, Get free
    [Documentation]   VBSLB-Get-any-unit- 100
    [Tags]    ZWQE-TC-117
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-58
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity for VBSLB    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00, Get 1 unit from WM11, Get 50 % off on SSP, For Slab 4000.00 : 0, Get 1 unit from WM11, Get 50 % off on SSP
    [Documentation]   VBSLB-Get-any-unit- perc
    [Tags]    ZWQE-TC-118
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-59
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity for VBSLB    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00, Get 1 unit from WM11, Get 300Rs off on SSP, For Slab 4000.00 : 0, Get 1 unit from WM11, Get 300Rs off on SSP
    [Documentation]   VBSLB-Get-any-unit- rupee
    [Tags]    ZWQE-TC-119
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-60
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity for VBSLB    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy from Assortment [WM10], For Slab 1000 : 3999,and For Slab 4000 : , Get from WM11, Get 300Rs fixed off on Each Item
    [Documentation]   VBSLB-Get-any-unit- fixed-each
    [Tags]    ZWQE-TC-185
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-61
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity for VBSLB    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

Buy from Assortment [WM10], For Slab 1000.00 : 3999.00 and For Slab 4000.00 : 0, Get from WM11, Get 300.000Rs fixed off on all item
    [Documentation]   VBSLB-Get-any-unit- fixed-all
    [Tags]    ZWQE-TC-184
    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-62
    Login With Valid Username And Password    ${promo_data}
    Go To Promo Page
    Create New Definition | Promo    ${promo_data}
    Select Promotion Type    ${promo_data}
    Select Buy Assortment    ${promo_data}
    Select Slab Definition | Quantity for VBSLB    ${promo_data}
    Save Conditions
    Verify Summary Of Conditions
    Verify Saving Of The Promo
    Verify Promo Details In Summary

#TC_63 VBSLB Flat 100%
#    [Documentation]   VBSLB Flat 100%
#    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-63
#    Login With Valid Username And Password    ${promo_data}
#    Go To Promo Page
#    Create New Definition | Promo    ${promo_data}
#    Select Promotion Type    ${promo_data}
#    Select Buy Assortment    ${promo_data}
#    Select Slab Definition | Quantity for VBSLB    ${promo_data}
#    Save Conditions
#    Verify Summary Of Conditions
#    Verify Saving Of The Promo
#    Verify Promo Details In Summary
#
#TC_64 VBSLB Flat perc
#    [Documentation]   VBSLB Flat perc
#    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-64
#    Login With Valid Username And Password    ${promo_data}
#    Go To Promo Page
#    Create New Definition | Promo    ${promo_data}
#    Select Promotion Type    ${promo_data}
#    Select Buy Assortment    ${promo_data}
#    Select Slab Definition | Quantity for VBSLB    ${promo_data}
#    Save Conditions
#    Verify Summary Of Conditions
#    Verify Saving Of The Promo
#    Verify Promo Details In Summary
#
#TC_65 VBSLB Flat Rupees
#    [Documentation]   VBSLB Flat Rupees
#    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-65
#    Login With Valid Username And Password    ${promo_data}
#    Go To Promo Page
#    Create New Definition | Promo    ${promo_data}
#    Select Promotion Type    ${promo_data}
#    Select Buy Assortment    ${promo_data}
#    Select Slab Definition | Quantity for VBSLB    ${promo_data}
#    Save Conditions
#    Verify Summary Of Conditions
#    Verify Saving Of The Promo
#    Verify Promo Details In Summary
#
#TC_66 VBSLB Flat Fixed price all
#    [Documentation]   VBSLB Flat Fixed price all
#    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-66
#    Login With Valid Username And Password    ${promo_data}
#    Go To Promo Page
#    Create New Definition | Promo    ${promo_data}
#    Select Promotion Type    ${promo_data}
#    Select Buy Assortment    ${promo_data}
#    Select Slab Definition | Quantity for VBSLB    ${promo_data}
#    Save Conditions
#    Verify Summary Of Conditions
#    Verify Saving Of The Promo
#    Verify Promo Details In Summary
#
#TC_67 VBSLB Flat Fixed price each
#    [Documentation]   VBSLB Flat Fixed price each
#    ${promo_data}=    Fetch Testdata By Id    ${PROMO_TD}    TC-67
#    Login With Valid Username And Password    ${promo_data}
#    Go To Promo Page
#    Create New Definition | Promo    ${promo_data}
#    Select Promotion Type    ${promo_data}
#    Select Buy Assortment    ${promo_data}
#    Select Slab Definition | Quantity for VBSLB    ${promo_data}
#    Save Conditions
#    Verify Summary Of Conditions
#    Verify Saving Of The Promo
#    Verify Promo Details In Summary
