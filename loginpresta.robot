*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Suite Setup    Set Selenium Speed    0.2s
*** Variables ***
${URL}                https://kikeoo-presta-prp.si.fr.intraorange/prestations
${VALID_USERNAME}     HFDX8269
${VALID_PASSWORD}     Hanahorange123@@
${INVALID_USERNAME}   ABCD1234
${INVALID_PASSWORD}   Password456
${LOGIN_BUTTON_XPATH}    //button[@name='_eventId_proceed']
${SUCCESS_MESSAGE_XPATH}  /html/body/nav/div/div/div/a   # Example of a successful login element
${ERROR_MESSAGE_XPATH}    /html/body/main/div/form/div/div/div/div[2]/div[1]/p
 # Example of an error message element

*** Test Cases ***
Authentification via AD-SUBS (AUT-001)
    [Documentation]    Test case to authenticate successfully via AD-SUBS
    Open Login Page
    Enter Valid Credentials
    Click Login Button
    Verify Successful Login





Authentification échouée via AD-SUBS (AUT-002)
    [Documentation]    Verify authentication failure via AD-SUBS with invalid or empty credentials
    Open Login Page

    Log To Console    \n--- Case 1: Invalid username and invalid password ---
    Enter Invalid Credentials
    Click Login Button
    Verify Error Message    

    Log To Console    \n--- Case 2: Empty username and valid password ---
    Enter Empty Username Credentials    
    Click Login Button
    Verify Error Message     

    Log To Console    \n--- Case 3: Valid username and empty password ---
    Enter Empty Password Credentials    
    Click Login Button
    Verify Error Message     

    Log To Console    \n--- Case 4: Empty username and empty password ---
    Enter Empty Credentials                                       
    Click Login Button
    Verify Error Message    


*** Keywords ***
Open Login Page
    Open Browser    ${URL}    edge
    Maximize Browser Window

Enter Valid Credentials
    Input Text    id=username    ${VALID_USERNAME}
    Input Text    id=password    ${VALID_PASSWORD}

Enter Invalid Credentials
    Input Text    id=username    ${INVALID_USERNAME}
    Input Text    id=password    ${INVALID_PASSWORD}

Enter Empty Username Credentials
    Input Text    id=password    ${VALID_PASSWORD}

Enter Empty Password Credentials 
    Input Text    id=username    ${VALID_USERNAME}

Enter Empty Credentials     
   Input Text    id=username    ${EMPTY}
   Input Text    id=password    ${EMPTY}
  
                                         
Click Login Button
    Click Button    ${LOGIN_BUTTON_XPATH}

Verify Successful Login
    Wait Until Element Is Visible    ${SUCCESS_MESSAGE_XPATH}
    Page Should Contain Element    ${SUCCESS_MESSAGE_XPATH}

Verify Error Message
     
    Click Element     xpath=${ERROR_MESSAGE_XPATH}   




  