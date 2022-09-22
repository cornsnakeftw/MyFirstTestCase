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
    Input Text    //input[@type='email']    marianne+2@besquare.com.my
    Input Text    //input[@type='password']    Abcd1234
    Click Element    //button[@type='submit']
    Wait Until Page Contains Element   dt_core_account-info_acc-info    30

*** Test Cases ***
Switch to Virtual Account
    Login To Deriv
    Wait Until Page Contains Element    //div[@class='btn-purchase__text_wrapper' and contains(.,'Fall')]    30
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
