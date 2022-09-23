*** Settings ***

Library    SeleniumLibrary

*** Variables ***
    
${scope read checkbox}    //*[contains(@name,'read')]//parent::label[@class='dc-checkbox']
${scope trade checkbox}    //*[contains(@name,'trade')]//parent::label[@class='dc-checkbox']
${scope payments checkbox}    //*[contains(@name,'payment')]//parent::label[@class='dc-checkbox']
${scope trading information checkbox}    //*[contains(@name,'trading')]//parent::label[@class='dc-checkbox']
${scope admin checkbox}    //*[contains(@name,'admin')]//parent::label[@class='dc-checkbox']
${ticked scope read checkbox}    //*[contains(@name,'read') and contains(@value,'true')]//parent::label[@class='dc-checkbox']
${ticked scope trade checkbox}    //*[contains(@name,'trade') and contains(@value,'true')]//parent::label[@class='dc-checkbox']
${ticked scope payments checkbox}    //*[contains(@name,'payment') and contains(@value,'true')]//parent::label[@class='dc-checkbox']
${ticked scope trading information checkbox}    //*[contains(@name,'trading') and contains(@value,'true')]//parent::label[@class='dc-checkbox']
${ticked scope admin checkbox}    //*[contains(@name,'admin') and contains(@value,'true')]//parent::label[@class='dc-checkbox']
${token name input field}    //input[@class='dc-input__field']
${create button disabled}    //*[contains(@class,'da-api-token__button') and @disabled]
${cancel delete button}    //*[contains(@class,'dc-btn--secondary')]
${confirm delete button}    //*[contains(@class,'dc-btn--primary dc-btn__large dc-dialog__button')]


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

Multiple checkboxes can be ticked
    Click Element    ${scope read checkbox}
    Click Element    ${scope trade checkbox}
    Click Element    ${scope payments checkbox}
    Click Element    ${scope admin checkbox}
    Click Element    ${scope trading information checkbox}

    Page Should Contain Element    ${scope read checkbox}    ${ticked scope read checkbox}
    Page Should Contain Element    ${scope trade checkbox}    ${ticked scope trade checkbox}
    Page Should Contain Element    ${scope payments checkbox}    ${ticked scope payments checkbox}
    Page Should Contain Element    ${scope admin checkbox}    ${ticked scope admin checkbox}
    Page Should Contain Element    ${scope trading information checkbox}    ${ticked scope trading information checkbox}


Reset checkboxes
    Click Element    ${scope read checkbox}
    Click Element    ${scope trade checkbox}
    Click Element    ${scope payments checkbox}
    Click Element    ${scope admin checkbox}
    Click Element    ${scope trading information checkbox}

NO tick and NO input
    #NO tick and NO input
    Page Should Contain Element    ${create button disabled}
    
NO tick and NO 2-32 characters    
    #NO tick and NO 2-32 characters
    Press Keys    ${token name input field}    CTRL+a+BACKSPACE
    Input Text    ${token name input field}    a
    Page Should Contain Element    ${create button disabled}
    Input Text    ${token name input field}    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    Page Should Contain Element    ${create button disabled}
    Press Keys    ${token name input field}    CTRL+a+BACKSPACE
    
NO tick and 2-32 characters    
    #NO tick and 2-32 characters
    Press Keys    ${token name input field}    CTRL+a+BACKSPACE
    Input Text    ${token name input field}    aa
    Page Should Contain Element    ${create button disabled}
    Press Keys    ${token name input field}    CTRL+a+BACKSPACE
    Input Text    ${token name input field}    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    Page Should Contain Element    ${create button disabled}
     
At least 1 tick and 2-32 characters
    #at least 1 tick and 2-32 characters

    Click Element    ${scope read checkbox}
    Page Should Contain Element    ${scope read checkbox}    ${ticked scope read checkbox}
    Press Keys    ${token name input field}    CTRL+a+BACKSPACE
    Input Text    ${token name input field}    ab
    Page Should Not Contain Element    ${create button disabled}
    Press Keys    ${token name input field}    CTRL+a+BACKSPACE
    Input Text    ${token name input field}    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    Page Should Not Contain Element    ${create button disabled}


At least 1 tick and NO 2-32 characters
    #at least 1 tick and NO 2-32 characters
    Page Should Contain Element    ${scope read checkbox}    ${ticked scope read checkbox}
    Press Keys    ${token name input field}    CTRL+a+BACKSPACE
    Input Text    ${token name input field}    a
    Page Should Contain Element    ${create button disabled}
    Press Keys    ${token name input field}    CTRL+a+BACKSPACE
    Input Text    ${token name input field}    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    Page Should Contain Element    ${create button disabled}
    Click Element    ${scope read checkbox}

Multiple ticks and 2-32 characters
    Multiple checkboxes can be ticked
    Press Keys    ${token name input field}    CTRL+a+BACKSPACE
    Input Text    ${token name input field}    aa
    Page Should Not Contain Element    ${create button disabled}
    Press Keys    ${token name input field}    CTRL+a+BACKSPACE
    Input Text    ${token name input field}    test123
    Page Should Not Contain Element    ${create button disabled}


Multiple ticks and NO 2-32 characters
    Press Keys    ${token name input field}    CTRL+a+BACKSPACE
    Input Text    ${token name input field}    a
    Page Should Contain Element    ${create button disabled}
    Press Keys    ${token name input field}    CTRL+a+BACKSPACE
    Input Text    ${token name input field}    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    Page Should Contain Element    ${create button disabled}
    
    

    
Press 'Enter' to create
    #Press 'Enter' to create
    Press Keys     ${token name input field}   RETURN
    Wait Until Page Contains Element    ${create button disabled}

Check token name
    Sleep    5
    Element Should Contain    //*[contains(@class,'da-api-token__table-cell-row')]    test123
         
Check token hidden by default
    
    Page Should Contain Element    //*[@class='da-api-token__pass-dot-container']
    Click Element    //*[@class='dc-icon da-api-token__visibility-icon']
    Page Should Contain Element    //div[@class='da-api-token__clipboard-wrapper']//child::p[@class='dc-text']

Check scope
    Scroll Element Into View    //*[@class='da-api-token__table-scope-cell da-api-token__table-scope-cell-admin' and contains(text(),'Admin')]
    Page Should Contain Element    //*[@class='da-api-token__table-scope-cell' and contains(text(),'Trade')]
    Page Should Contain Element    //*[@class='da-api-token__table-scope-cell' and contains(text(),'Payments')]    
    Page Should Contain Element    //*[@class='da-api-token__table-scope-cell' and contains(text(),'Trading information')]
    Page Should Contain Element    //*[@class='da-api-token__table-scope-cell' and contains(text(),'Read')]
    Page Should Contain Element    //*[@class='da-api-token__table-scope-cell da-api-token__table-scope-cell-admin' and contains(text(),'Admin')]
    # Page Should Contain Element    //*[@class='da-api-token__table-scope-cell da-api-token__table-scope-cell-admin' and contains(text(),'Admin')]
    # Page Should Contain Element    //*[@class='da-api-token__table-scope-cell da-api-token__table-scope-cell-admin' and contains(text(),'Trade')]
    # Page Should Contain Element    //*[@class='da-api-token__table-scope-cell da-api-token__table-scope-cell-admin' and contains(text(),'Payments')]
    # Page Should Contain Element    //*[@class='da-api-token__table-scope-cell da-api-token__table-scope-cell-admin' and contains(text(),'Trading information')]
    # Page Should Contain Element    //*[@class='da-api-token__table-scope-cell da-api-token__table-scope-cell-admin' and contains(text(),'Rise')]
    
Check last used    
    Sleep    1
    Page Should Contain Element    //td[@class='da-api-token__table-cell']//child::span[@class='dc-text' and contains(text(),'Never')]

Check delete token
    Page Should Contain Element    //*[contains(@class, 'dc-icon dc-clipboard da-api-token__delete-icon')]
    Click Element    //*[contains(@class, 'dc-icon dc-clipboard da-api-token__delete-icon')]
    Sleep    2
    Click Element    ${cancel delete button}
    Sleep    2
    Click Element    //*[contains(@class, 'dc-icon dc-clipboard da-api-token__delete-icon')]
    Click Element    ${confirm delete button}


*** Test Cases ***
Verifying API token page
    Login To Deriv
    Wait Until Page Contains Element   //*[@class='dc-icon']    30
    Sleep    3
    Click Element    //a[@class='account-settings-toggle']
    Wait Until Page Contains Element    //a[@id='dc_api-token_link']    30
    Click Element    //a[@id='dc_api-token_link']
    Page Should Contain Element    //*[contains(@class,'dc-vertical-tab__header--active') and @id='dc_api-token_link']
    Wait Until Page Contains Element    //*[contains(@name,'read')]//parent::label[@class='dc-checkbox']
    Checkbox Should Not Be Selected    //input[@class='dc-checkbox__input']
    Multiple checkboxes can be ticked
    Reset checkboxes
    NO tick and NO input
    NO tick and NO 2-32 characters
    NO tick and 2-32 characters
    At least 1 tick and 2-32 characters
    At least 1 tick and NO 2-32 characters
    Multiple ticks and NO 2-32 characters
    Multiple ticks and 2-32 characters    
    Press 'Enter' to create
    Check token name
    Check token hidden by default
    Check scope
    Check last used
    Check delete token



   
    

    
