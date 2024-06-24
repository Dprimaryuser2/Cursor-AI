*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ../../../Resources/CustomKeywords/utilities.py
Variables    ../../../PageObjects/Web_POS/POS/hold_bill_locators.py

*** Keywords ***
Hold Bill
    Wait Until Page Contains Element    ${hold_bill}
    Click Element    ${hold_bill}
    Wait Until Page Contains Element    ${hold_bill_confirmation}
    Click Element    ${hold_bill_confirmation}

Recall Bill
    Wait Until Page Contains Element    ${view_held_bills}
    Click Element    ${view_held_bills}
    Wait Until Page Contains Element    ${recall_bill}
    Click Element    ${recall_bill}
    Wait Until Page Contains Element    ${recall_bill_confirmation}
    Click Element    ${recall_bill_confirmation}

Discard Bill
    Wait Until Page Contains Element    ${view_held_bills}
    Click Element    ${view_held_bills}
    Wait Until Page Contains Element    ${discard_bill}
    Click Element    ${discard_bill}
    Wait Until Page Contains Element    ${discard_bill_confirmation}
    Click Element    ${discard_bill_confirmation}

Return To Bill
    Wait Until Page Contains Element    ${view_held_bills}
    Click Element    ${view_held_bills}
    Wait Until Page Contains Element    ${return_to_bill}
    Click Element    ${return_to_bill}


