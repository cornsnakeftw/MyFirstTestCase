*** Settings ***

Library    SeleniumLibrary

*** Variables ***
${login_button}    //button[@id='dt_login_button']

*** Keywords ***
Login To Deriv 
    Open Browser    https://app.deriv.com/    Chrome
    Maximize Browser Window
    ## to include the button id after the page has been loaded, so that the robot does not click
    ## before the page is loaded fully
    Wait Until Page Contains Element    //div[@class='btn-purchase__text_wrapper' and contains(.,'Fall')]    30
    Click Element    dt_login_button
    Wait Until Page Contains Element    //input[@type='email']    10
    Input Text    //input[@type='email']    marianne+5@besquare.com.my
    Input Text    //input[@type='password']    Abcd1234
    Click Element    //button[@type='submit']
    Wait Until Page Contains Element   dt_core_account-info_acc-info    30

Switch to Virtual Account
    Wait Until Page Contains Element    //div[@class='btn-purchase__text_wrapper' and contains(.,'Fall')]    40
    Click Element    //div[@id='dt_core_account-info_acc-info']
    Click Element    //li[@id='real_account_tab']
    #Verify Real account using ID
    Page Should Contain Element    //div[contains(@class,'acc-switcher__account--selected') and contains(@id,'dt_CR')]
    Wait Until Page Contains Element    //li[@id='dt_core_account-switcher_demo-tab']    30
    #Click on Demo Tab
    Click Element    //li[@id='dt_core_account-switcher_demo-tab']
    #click on Demo Account with ID
    Click Element    //div[@class='dc-content-expander__content']
    #verify demo using ID
    Page Should Contain Element    //div[contains(@id,"dt_VRTC")]

Select underlying contract
    Wait Until Page Contains Element    //div[@class='btn-purchase__text_wrapper' and contains(.,'Rise')]    30
    Click Element    //div[@class='cq-symbol-select-btn']
    Wait Until Page Contains Element    //*[@class="sc-dialog cq-menu-dropdown cq-menu-dropdown-enter-done"]    30


Select contract type
    Click Element    //*[@class='sc-mcd__filter__item ' and contains(.,'Forex')]
    Wait Until Page Contains Element    //*[@class="sc-dialog cq-menu-dropdown cq-menu-dropdown-enter-done"]    30
    Click Element    //div[@class='sc-mcd__item sc-mcd__item--frxAUDUSD ']
    
Buy rise contract
    Login To Deriv
    Switch to Virtual Account
    Wait Until Page Contains Element    //div[@class='btn-purchase__text_wrapper' and contains(.,'Rise')]    30
    Click Element    //div[@class='cq-symbol-select-btn']
    Wait Until Page Contains Element    //*[@class="sc-dialog cq-menu-dropdown cq-menu-dropdown-enter-done"]    30
    #Click Volatility 10 (1s) Index
    Click Element    //div[@class="sc-mcd__item sc-mcd__item--1HZ10V "]
    Wait Until Page Contains Element    //div[contains(@class,'contract-type-widget__display')]    30
    #Verify the default contract info to buy
    Page Should Contain Element    //div[@class='contract-type-widget__display' and contains(.,'Rise/Fall')]
    Page Should Contain Element    //input[@class='input trade-container__input range-slider__track' and contains(@value,'5')]
    Page Should Contain Element    //button[@id='dc_stake_toggle_item' and contains(@class,'dc-btn dc-btn__toggle dc-button-menu__button dc-button-menu__button--active')]
    Page Should Contain Element    //input[@id='dt_amount_input' and contains(@value,'10')]
    Page Should Contain Element    //button[@id='dt_purchase_call_button']
    Page Should Contain Element    //button[@id='dt_purchase_put_button']
    Click Element    //button[@id='dt_purchase_call_button']


*** Test Cases ***
Buy lower contract
    Login To Deriv
    Switch to Virtual Account
    Select underlying contract
    Select contract type
    Wait Until Page Contains Element    //div[@class='btn-purchase__text_wrapper' and contains(.,'Rise')]    30
    Click Element    //div[@class='contract-type-widget__display']    
    Wait Until Page Contains Element    //div[@id="dt_contract_high_low_item"]    30
    Click Element    //div[@id="dt_contract_high_low_item"]
    Wait Until Page Contains Element    //span[@name='contract_type' and contains(@value,'high_low')]    30
    Textfield Should Contain    //input[@class='dc-input__field']    10
    Press Keys    //input[@id='dt_amount_input']    CTRL+a+BACKSPACE
    Input Text    //input[@class='dc-input__field']    4
    Click Element    //*[contains(@id,'dt_barrier_1_input')]
    Input Text    //*[contains(@id,'dt_barrier_1_input')]    '+0.01'
    Page Should Contain Element    //button[@id='dc_stake_toggle_item' and contains(@class,'--active')]
    Click Element    //button[@id='dc_payout_toggle_item' and contains(@class,'button')]
    Press Keys    //input[@id='dt_amount_input']    CTRL+a+BACKSPACE
    Input Text    //input[@id='dt_amount_input']    10
    Wait Until Page Contains Element    //*[contains(@data-tooltip,'Contracts more than')]    30
    Page Should Contain Element    //*[contains(@data-tooltip,'Contracts more than')]    


