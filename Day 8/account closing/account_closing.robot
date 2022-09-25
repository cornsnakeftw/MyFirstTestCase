*** Settings ***

Library    SeleniumLibrary

*** Variables ***
    
${close my account button}    //*[contains(@class,'--close-account')]
${cancel close my account button}    //*[contains(@class,'button--cancel')]
${link for security and privacy policy}    //a[contains(@href,'pdf')]
${close button}    //*[contains(@data-testid,'page_overlay_header_close')]
${label checkbox financial priorities}    //*[contains(@name,'financial-priorities')]//parent::label[@class='dc-checkbox closing-account-reasons__checkbox']
${label checkbox stop trading}     //*[contains(@name,'stop-trading')]//parent::label[@class='dc-checkbox closing-account-reasons__checkbox']
${label checkbox not interested}     //*[contains(@name,'not-interested')]//parent::label[@class='dc-checkbox closing-account-reasons__checkbox']
${input field other trading platform}    //*[contains(@name,'other_trading_platforms')]
${input field do to improve}    //*[contains(@name,'do_to_improve')]
${continue button}    //*[contains(@class,'dc-btn dc-btn__effect dc-btn--primary dc-btn__large')]
${disabled continue button}    //*[contains(@class,'dc-btn--primary ') and @disabled]
${back button}    //*[contains(@class,'dc-btn dc-btn__effect dc-btn--secondary dc-btn__large')]


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

Verify close accounts settings
    Wait Until Element Is Visible   //*[@class='dc-icon']    120
    Sleep    3
    Click Element    //a[@class='account-settings-toggle']
    Wait Until Page Contains Element    //*[contains(@id,'dc_close-your-account_link')]    30
    Click Element    //*[contains(@id,'dc_close-your-account_link')]
    Wait Until Page Contains Element    //*[contains(@class,'closing-account__steps')]
    Page Should Contain Element    ${cancel close my account button}
    Page Should Contain Element    ${close my account button}
    Page Should Contain Element    ${link for security and privacy policy}
    Page Should Contain Element    ${close button}

Click cancel button
    Click Element    ${cancel close my account button}
    Wait Until Page Contains Element    //*[contains(@id,'dt_purchase_call_button')]    30
    Page Should Contain Element    //*[contains(@id,'dt_purchase_call_button')]
    
No option
    Page Should Contain Checkbox       //*[contains(@class,'dc-checkbox__input')]
    Page Should Contain Element    //*[contains(@class,'dc-checkbox__input') and @value='false']
    Page Should Contain Element    ${input field other trading platform}
    Page Should Contain Element    ${input field do to improve}
    Page Should Contain Element    ${disabled continue button}
    Page Should Contain Element    ${back button}    

    
Tick 1 option
    Click Element    ${label checkbox financial priorities}
    Page Should Contain Element    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='stop-trading']
    Page Should Contain Element    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='not-interested']
    Page Should Contain Element    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='another-website']
    Page Should Contain Element    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='not-user-friendly']
    Page Should Contain Element    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='difficult-transactions']
    Page Should Contain Element    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='lack-of-features']
    Page Should Contain Element    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='unsatisfactory-service']
    Page Should Contain Element    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='other-reasons']
    Click Element    ${input field other trading platform}    
   Press Keys    ${input field other trading platform}    CTRL+a+BACKSPACE
  
    
    Input Text    ${input field other trading platform}    only 1 input
    Click Element    ${input field do to improve}
    Press Keys    ${input field do to improve}    CTRL+a+BACKSPACE

    Input Text    ${input field do to improve}    1 option chosen


Tick 2 options
    # Click Element    ${label checkbox financial priorities}
    Click Element    ${label checkbox stop trading}
    Page Should Contain Element    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='not-interested']
    Page Should Contain Element    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='another-website']
    Page Should Contain Element    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='not-user-friendly']
    Page Should Contain Element    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='difficult-transactions']
    Page Should Contain Element    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='lack-of-features']
    Page Should Contain Element    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='unsatisfactory-service']
    Page Should Contain Element    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='other-reasons']
    Click Element    ${input field other trading platform}
    Press Keys    ${input field other trading platform}    CTRL+a+BACKSPACE    
    Input Text    ${input field other trading platform}    only 2 input
    Click Element    ${input field do to improve}
    Press Keys    ${input field do to improve}    CTRL+a+BACKSPACE    
    Input Text    ${input field do to improve}    2 option chosen
Tick 3 options
    # Click Element    ${label checkbox financial priorities}
    # Click Element    ${label checkbox stop trading}
    Click Element    ${label checkbox not interested}
    Wait Until Page Contains Element    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='another-website']    30
    Element Should Be Disabled    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='another-website']
    Element Should Be Disabled    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='not-user-friendly']
    Element Should Be Disabled    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='difficult-transactions']
    Element Should Be Disabled    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='lack-of-features']
    Element Should Be Disabled    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='unsatisfactory-service']
    Element Should Be Disabled    //*[contains(@class,'dc-checkbox__input') and @value='false' and @name='other-reasons']
    Click Element    ${input field other trading platform}
    Press Keys    ${input field other trading platform}    CTRL+a+BACKSPACE

    Input Text    ${input field other trading platform}    3 options chosen
    Click Element    ${input field do to improve}
    Press Keys    ${input field do to improve}    CTRL+a+BACKSPACE
  
    Input Text    ${input field do to improve}    3 options chosen
    
    
Check back button functionality
    Click Element    ${back button}
    Wait Until Page Contains Element    ${close my account button}    
    Page Should Contain Element    ${close my account button}
Check continue button functionality
    Click Element    ${continue button}

    
Check prompt message
    Page Should Contain Element    //*[contains(@class,'account-closure-warning-modal')]
    Page Should Contain Element    //*[contains(@class,'dc-btn--secondary dc-btn__large')]//child::span[contains(text(),'Go Back')]
    Page Should Contain Element    //*[contains(@class,'dc-btn--primary')]//child::span[contains(text(),'Close account')]
    # Click Element    //*[contains(@class,'dc-btn--secondary dc-btn__large')]//child::span[contains(text(),'Go Back')]
    # Element Should Be Visible    ${input field other trading platform}
    # Click Element    ${continue button}
    Wait Until Element Is Visible    //*[contains(text(),'Close account')]
    Click Element    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large" and contains(.,'Close account')] 

*** Test Cases ***
Verifying close your account page
    Login To Deriv
    Sleep    2
    Verify close accounts settings
    Click cancel button
    Verify close accounts settings
    Click Element    ${close my account button}
    No option
    Tick 1 option
    Tick 2 options
    Tick 3 options
    Click Element    ${continue button}
    Check prompt message

    



    



   
    

    
