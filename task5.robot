*** Settings ***

Library    SeleniumLibrary

*** Variables ***
${login_button}    //button[@id='dt_login_button']
${synthetic_indices}    //div[@class='sc-mcd__filter__item sc-mcd__filter__item--selected']
${volatility50}    //div[@class='sc-mcd__item sc-mcd__item--R_50 ']
${take_profit}    //label[@class='dc-checkbox take_profit-checkbox__input']    
${stop_loss}    //label[@class='dc-checkbox stop_loss-checkbox__input']
${deal_cancellation}    //label[@for='dt_cancellation-checkbox_input']
${tp_checkbox}    //input[@id='dc_take_profit-checkbox_input']
${sl_checkbox}    //input[@id='dc_stop_loss-checkbox_input']
${dc_checkbox}    //input[@id='dt_cancellation-checkbox_input']
${checked dc_checkbox}    //*[@id='dt_cancellation-checkbox_input' and @checked]
${take_profit input field}    //input[@id='dc_take_profit_input']
${stop_loss input field}    //input[@id='dc_stop_loss_input']
${multiplier_stake_amount_input}    //input[@id='dt_amount_input' and contains(@value,'')]
${deal cancellation fee}    //*[contains(@class,'trade-container__price-info-currency')]
${take_profit plus button}    //button[@id='dc_take_profit_input_add']
${take_profit minus button}    //button[@id='dc_take_profit_input_sub']
${take_profit input field value}    //input[@id='dc_take_profit_input' and contains(@value,'')]
    


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
   
    Wait Until Element Is Visible    //button[@id='dt_purchase_call_button']    40
    Click Element    dt_core_account-info_acc-info
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
    Wait Until Element Is Visible    //div[@class='btn-purchase__text_wrapper' and contains(.,'Rise')]    30
    Wait Until Page Contains Element    //div[@class='cq-symbol-select-btn']    30
    Click Element    //div[@class='cq-symbol-select-btn']
    Wait Until Page Contains Element   //*[@class="sc-dialog cq-menu-dropdown cq-menu-dropdown-enter-done"]    30


Select contract type
    Wait Until Page Contains Element    //div[@class='btn-purchase__text_wrapper' and contains(.,'Rise')]    30
    Click Element    //div[@class='contract-type-widget__display']
    Wait Until Page Contains Element    //div[@class='dc-vertical-tab__content-container']    30
    
    
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

Check take profit checkbox
    Click Element    ${take_profit}        
    Checkbox Should Be Selected    ${tp_checkbox}
    Checkbox Should Not Be Selected    ${dc_checkbox}
    Wait Until Page Contains Element    ${take_profit input field}    30

Check deal cancellation checkbox

    Click Element    ${deal_cancellation}
    Wait Until Page Contains Element   ${checked dc_checkbox}    60
    Wait Until Page Does Not Contain Element    ${take_profit input field}  60
    Wait Until Page Does Not Contain Element    ${stop_loss input field}    60
    #to uncheck
    Click Element    ${deal_cancellation}

Check stop loss checkbox
    Click Element    ${stop_loss}
    Checkbox Should Be Selected    ${sl_checkbox}
    Checkbox Should Not Be Selected    ${dc_checkbox}
    Wait Until Page Contains Element    ${stop_loss input field}    30

Verifying multiplier options
    Wait Until Page Contains Element    //span[@class='dc-text dc-dropdown__display-text' and @name='multiplier']    30
    Click Element    //span[@class='dc-text dc-dropdown__display-text' and @name='multiplier']
    Wait Until Element Is Visible    //div[@class='dc-list__item dc-list__item--selected' and contains(@id,'20')]    60
    Element Should Contain    //div[@class='dc-list__item dc-list__item--selected']    x20
    Element Should Contain    //div[@class='dc-list__item' and contains(@id,'40')]    x40
    Element Should Contain    //div[@class='dc-list__item' and contains(@id,'60')]    x60
    Element Should Contain    //div[@class='dc-list__item' and contains(@id,'100')]    x100
    Element Should Contain    //div[@class='dc-list__item' and contains(@id,'200')]    x200
    
    
Verifying deal cancellation fee more expensive than stake value
    Click Element    ${deal_cancellation}
    Wait Until Page Contains Element    ${checked dc_checkbox}
    Click Element    ${multiplier_stake_amount_input}
    Press Keys    ${multiplier_stake_amount_input}    CTRL+a+BACKSPACE
    Input Text    ${multiplier_stake_amount_input}    10
    Wait Until Element Is Visible    ${deal cancellation fee}
    # Should Be Equal    ${deal cancellation fee}
    # ${multiplier_stake_amount_input}    Convert To String    ${multiplier_stake_amount_input}
    # Should Be True ${}

Maximum stake is 2000 USD
    Click Element    ${multiplier_stake_amount_input}
    Press Keys    ${multiplier_stake_amount_input}    CTRL+a+BACKSPACE
    Input Text    ${multiplier_stake_amount_input}    2001
    Wait Until Page Contains Element    //*[contains(text(),'Maximum stake allowed is 2000.00.')]    30
    
    
Minimum stake is 1 USD
    Click Element    ${multiplier_stake_amount_input}
    Press Keys    ${multiplier_stake_amount_input}    CTRL+a+BACKSPACE
    Input Text    ${multiplier_stake_amount_input}    0
    Wait Until Page Contains Element    //*[contains(@data-tooltip,'1')]    30
Plus button of take profit field increase the stake value by 1 USD
    
    Click Element    ${take_profit}
    Wait Until Page Contains Element    ${take_profit input field}
    Press Keys    ${take_profit input field}    CTRL+a+BACKSPACE
    Input Text    ${take_profit input field}    0
    Click Element    ${take_profit plus button}
    Element Attribute Value Should Be    ${take_profit input field}    value    1

Minus button of take profit decrease the stake value by 1 USD    
    
    Wait Until Page Contains Element    ${take_profit input field}
    Press Keys    ${take_profit input field}    CTRL+a+BACKSPACE
    Input Text    ${take_profit input field}    1
    Click Element    ${take_profit minus button}
    Element Attribute Value Should Be    ${take_profit input field}    value    0
    

Deal cancellation duration only has certain options
    Click Element    ${deal_cancellation}
    


*** Test Cases ***
Check multiplier contract parameter
    Login To Deriv
    Switch to Virtual Account
    Select underlying contract
    Click Element    ${synthetic_indices}
    Wait Until Element Is Visible    ${volatility50}    30
    Click Element    ${volatility50}
    Select contract type
    Click Element    //div[@id='dt_contract_multiplier_item']
    Wait Until Page Contains Element       //button[@id='dt_purchase_multup_button']    30
    Element Text Should Be    //span[contains(@class,'-info--left')]    Stake
    Element Text Should Not Be    //span[contains(@class,'-info--left')]    Payout
    Check take profit checkbox
    Check stop loss checkbox
    Check deal cancellation checkbox
    Verifying multiplier options
    # Verifying deal cancellation fee more expensive than stake value
    Maximum stake is 2000 USD
    Minimum stake is 1 USD
    Plus button of take profit field increase the stake value by 1 USD
    Minus button of take profit decrease the stake value by 1 USD
    #Deal cancellation duration only has certain options

    


    
    

    
    






