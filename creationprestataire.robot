
#si error ne pas arreter test
*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Suite Setup    Set Selenium Speed    0.2s
Library    DateTime
Library    String
Library    Collections
Library    Random
*** Variables ***
${FAILED}    False
@{ERRORS}    # empty list
${URL}                https://kikeoo-presta-prp.si.fr.intraorange/prestations
${VALID_USERNAME}     HFDX8269
${VALID_PASSWORD}     Hanahorange123@@
${BROWSER}    edge
 
${LOGIN_BUTTON_XPATH}    //button[@name='_eventId_proceed']
${SUCCESS_MESSAGE_XPATH}  /html/body/nav/div/div/div/a   # Example of a successful login element
 
 # Example of an error message element

*** Test Cases ***
Create "prestataire"
    [Documentation]    Test case to authenticate successfully via AD-SUBS
    
    Open Browser    ${URL}    ${BROWSER}
    Enter Valid Credentials
    Click Login Button

    
    Click Element    xpath=/html/body/nav/div/div/div/a
    Wait Until Element Is Visible    xpath=/html/body/nav/div/div/div/div/a[2]  
    Click Element     xpath=/html/body/nav/div/div/div/div/a[2]  
    Remplir les champs obligatoires
    Remplir les champs optionnels
    
    Vérifier la création du prestataire
    









*** Keywords ***
Open Login Page
    Open Browser    ${URL}    edge
    Maximize Browser Window

Enter Valid Credentials
    Input Text    id=username    ${VALID_USERNAME}
    Input Text    id=password    ${VALID_PASSWORD}

 
  
                                         
Click Login Button
    Click Button    ${LOGIN_BUTTON_XPATH}

Verify Successful Login
    Wait Until Element Is Visible    ${SUCCESS_MESSAGE_XPATH}
    Page Should Contain Element    ${SUCCESS_MESSAGE_XPATH}
 



Remplir les champs obligatoires
    Test Négatif
    Test Positif

        

Remplir les champs optionnels
    ${resource}=    Generate Random String    6
    Click Element         xpath=/html/body/div/div[2]/form/div/div[2]/div[3]/div/div/span/span[1]/span/ul/li/input
    Wait Until Element Is Visible    xpath=//*[@id="select2-metiers-results"]
    Input Text         xpath=/html/body/div/div[2]/form/div/div[2]/div[3]/div/div/span/span[1]/span/ul/li/input     Administrateur
    Press Keys          xpath=/html/body/div/div[2]/form/div/div[2]/div[3]/div/div/span/span[1]/span/ul/li/input     RETURN 
    

    Click Element         xpath=/html/body/div/div[2]/form/div/div[2]/div[4]/div/div/span/span[1]/span/ul/li/input
    Wait Until Element Is Visible    xpath=//*[@id="select2-domaineTechniques-results"]
    Input Text         xpath=/html/body/div/div[2]/form/div/div[2]/div[4]/div/div/span/span[1]/span/ul/li/input     .NET
    Press Keys          xpath=/html/body/div/div[2]/form/div/div[2]/div[4]/div/div/span/span[1]/span/ul/li/input     RETURN 
    Input Text          xpath=//*[@id="ressourceId"]    ${resource}
    Input Text         xpath=/html/body/div/div[2]/form/div/div[2]/div[8]/div/div/textarea     Details 
    

Vérifier que le bouton Créer est activé
    Click Element    xpath=//*[@id="boutonSoumission"]



Vérifier la création du prestataire
    Click Element       xpath=//*[@id="messages"]/ul/li/a
  #  ${confirmation_message}=    Get Text    xpath=//div[@class='confirmation-message']
  #  Should Contain    ${confirmation_message}    Le prestataire ${NOM} ${PRENOM} a bien été créé
   # ${nom_prestataire}=    Get Text    xpath=//a[@class='prestataire-nom']
   # Should Be Equal As Strings    ${nom_prestataire}    ${NOM} ${PRENOM}

Test Positif

     
    ${random_first_name}=    Generate Random String    5    # Random first name (5 characters)
    ${random_last_name}=    Generate Random String    6    # Random last name (6 characters)
   
    
    Input Text    xpath=//*[@id="nom"]    ${random_last_name}
    

    Input Text    xpath=//*[@id="prenom"]    ${random_first_name}
    
    Input Text    xpath=//*[@id="dateNaissance"]    01/03/2002
   

Test Négatif

      
     Nom invalide - chiffres
     Nom invalide - vide
     Nom invalide - caractères spéciaux
     Prenom invalide - chiffres
     Prenom invalide - vide
     Prenom invalide - caractères spéciaux
     Date invalide - date future
     Date invalide - vide
 



Validation Des Champs Formulaires

    # Test 1 - Nom invalide - chiffres
    Input Text    xpath=//*[@id="nom"]       1234
    Input Text    xpath=//*[@id="prenom"]     Kaissi
    Input Text    xpath=//*[@id="dateNaissance"]      01/01/2000
    ${r1}=    Run Keyword And Ignore Error    Wait Until Element Is Visible    xpath=//*[@id="messages"]/ul/li    timeout=5s
    ${r2}=    Run Keyword And Ignore Error    Element Should Be Visible        xpath=//*[@id="messages"]/ul/li
    Run Keyword If    '${r2}[0]' == 'FAIL'    Append To List    ${ERRORS}    [Nom-chiffres] ${r2}[1]

    # Test 2 - Nom invalide - vide
    Input Text    xpath=//*[@id="nom"]    ${EMPTY}
    Input Text    xpath=//*[@id="prenom"]     Claire
    Input Text    xpath=//*[@id="dateNaissance"]    01/01/2000
    ${r3}=    Run Keyword And Ignore Error    Element Should Not Be Visible    xpath=//*[@id="messages"]/ul/li/a
    Run Keyword If    '${r3}[0]' == 'FAIL'    Append To List    ${ERRORS}    [Nom-vide] ${r3}[1]

    # Test 3 - Nom invalide - caractères spéciaux
    Input Text    xpath=//*[@id="nom"]    @-..
    Input Text    xpath=//*[@id="prenom"]     Kaissi
    Input Text    xpath=//*[@id="dateNaissance"]     01/01/2002
    ${r4}=    Run Keyword And Ignore Error    Wait Until Element Is Visible    xpath=//*[@id="messages"]/ul/li    timeout=5s
    ${r5}=    Run Keyword And Ignore Error    Element Should Be Visible        xpath=//*[@id="messages"]/ul/li
    Run Keyword If    '${r5}[0]' == 'FAIL'    Append To List    ${ERRORS}    [Nom-spéciaux] ${r5}[1]

    # Test 4 - Prénom invalide - chiffres
    Input Text    xpath=//*[@id="nom"]    1234
    Input Text    xpath=//*[@id="prenom"]     Kaissi
    Input Text    xpath=//*[@id="dateNaissance"]     01/01/2000
    ${r6}=    Run Keyword And Ignore Error    Wait Until Element Is Visible    xpath=//*[@id="messages"]/ul/li    timeout=5s
    ${r7}=    Run Keyword And Ignore Error    Element Should Be Visible        xpath=//*[@id="messages"]/ul/li
    Run Keyword If    '${r7}[0]' == 'FAIL'    Append To List    ${ERRORS}    [Prenom-chiffres] ${r7}[1]

    # Test 5 - Prénom invalide - vide
    Input Text    xpath=//*[@id="nom"]     ${EMPTY}
    Input Text    xpath=//*[@id="prenom"]    Claire
    Input Text    xpath=//*[@id="dateNaissance"]    01/01/2000
    ${r8}=    Run Keyword And Ignore Error    Element Should Not Be Visible    xpath=//*[@id="messages"]/ul/li/a
    Run Keyword If    '${r8}[0]' == 'FAIL'    Append To List    ${ERRORS}    [Prenom-vide] ${r8}[1]

    # Test 6 - Prénom invalide - caractères spéciaux
    Input Text    xpath=//*[@id="nom"]     @-..
    Input Text    xpath=//*[@id="prenom"]    Kaissi
    Input Text    xpath=//*[@id="dateNaissance"]     01/01/2002
    ${r9}=    Run Keyword And Ignore Error    Wait Until Element Is Visible    xpath=//*[@id="messages"]/ul/li    timeout=5s
    ${r10}=    Run Keyword And Ignore Error    Element Should Be Visible        xpath=//*[@id="messages"]/ul/li
    Run Keyword If    '${r10}[0]' == 'FAIL'    Append To List    ${ERRORS}    [Prenom-spéciaux] ${r10}[1]

    # Test 7 - Date invalide - date future
    Input Text    xpath=//*[@id="nom"]    Martin
    Input Text    xpath=//*[@id="prenom"]     Claire
    Input Text    xpath=//*[@id="dateNaissance"]    32/13/2029
    ${r11}=    Run Keyword And Ignore Error    Wait Until Element Is Visible    xpath=//*[@id="messages"]/ul/li    timeout=5s
    ${r12}=    Run Keyword And Ignore Error    Element Should Be Visible        xpath=//*[@id="messages"]/ul/li
    Run Keyword If    '${r12}[0]' == 'FAIL'    Append To List    ${ERRORS}    [Date-future] ${r12}[1]

    # Test 8 - Date invalide - vide
    Input Text    xpath=//*[@id="nom"]     Martin
    Input Text    xpath=//*[@id="prenom"]     Claire
    Input Text    xpath=//*[@id="dateNaissance"]    ${EMPTY}
    ${r13}=    Run Keyword And Ignore Error    Element Should Not Be Visible    xpath=//*[@id="messages"]/ul/li/a
    Run Keyword If    '${r13}[0]' == 'FAIL'    Append To List    ${ERRORS}    [Date-vide] ${r13}[1]

    # ⛔ Échec final si erreurs collectées
    ${joined_errors}=    Evaluate    '\\n'.join(${ERRORS})    modules=collections
    Run Keyword If    ${ERRORS}    Fail    Test échoué avec les erreurs suivantes:\n${joined_errors}


Nom invalide - chiffres
     
    Input Text    xpath=//*[@id="nom"]       1234
    Input Text    xpath=//*[@id="prenom"]     Kaissi
    Input Text    xpath=//*[@id="dateNaissance"]      01/01/2000
    Run Keyword And Ignore Error  Wait Until Element Is Visible    xpath=//*[@id="messages"]/ul/li    timeout=5s
    
    Run Keyword And Ignore Error  Element Should Be Visible    xpath=//*[@id="messages"]/ul/li
    
    

Nom invalide - vide
     
    Input Text    xpath=//*[@id="nom"]    ${EMPTY}
    Input Text    xpath=//*[@id="prenom"]     Claire
    Input Text    xpath=//*[@id="dateNaissance"]    01/01/2000
    Run Keyword And Ignore Error    Element Should Not Be Visible    xpath=//*[@id="messages"]/ul/li/a

Nom invalide - caractères spéciaux
     
    Input Text    xpath=//*[@id="nom"]    @-..
    Input Text    xpath=//*[@id="prenom"]     Kaissi
    Input Text    xpath=//*[@id="dateNaissance"]     01/01/2002
    Run Keyword And Ignore Error  Wait Until Element Is Visible    xpath=//*[@id="messages"]/ul/li    timeout=5s
    Run Keyword And Ignore Error  Element Should Be Visible        xpath=//*[@id="messages"]/ul/li

 
Prenom invalide - chiffres
     
    Input Text    xpath=//*[@id="nom"]    1234
    Input Text    xpath=//*[@id="prenom"]     Kaissi
    Input Text    xpath=//*[@id="dateNaissance"]     01/01/2000
    Run Keyword And Ignore Error  Wait Until Element Is Visible    xpath=//*[@id="messages"]/ul/li    timeout=5s
    Run Keyword And Ignore Error  Element Should Be Visible        xpath=//*[@id="messages"]/ul/li

Prenom invalide - vide
    
    Input Text    xpath=//*[@id="nom"]     ${EMPTY}
    Input Text    xpath=//*[@id="prenom"]    Claire
    Input Text    xpath=//*[@id="dateNaissance"]    01/01/2000
    Run Keyword And Ignore Error    Element Should Not Be Visible    xpath=//*[@id="messages"]/ul/li/a

Prenom invalide - caractères spéciaux
     
    Input Text    xpath=//*[@id="nom"]     @-..
    Input Text    xpath=//*[@id="prenom"]    Kaissi
    Input Text    xpath=//*[@id="dateNaissance"]     01/01/2002
    Run Keyword And Ignore Error  Wait Until Element Is Visible    xpath=//*[@id="messages"]/ul/li    timeout=5s
    Run Keyword And Ignore Error  Element Should Be Visible        xpath=//*[@id="messages"]/ul/li


 
Date invalide - date future
    
    Input Text    xpath=//*[@id="nom"]    Martin
    Input Text    xpath=//*[@id="prenom"]     Claire
    Input Text    xpath=//*[@id="dateNaissance"]    32/13/2029
    Run Keyword And Ignore Error  Wait Until Element Is Visible    xpath=//*[@id="messages"]/ul/li    timeout=5s
    Run Keyword And Ignore Error  Element Should Be Visible        xpath=//*[@id="messages"]/ul/li

Date invalide - vide
  
    Input Text    xpath=//*[@id="nom"]     Martin
    Input Text    xpath=//*[@id="prenom"]     Claire
    Input Text    xpath=//*[@id="dateNaissance"]    ${EMPTY}
    Run Keyword And Ignore Error    Element Should Not Be Visible    xpath=//*[@id="messages"]/ul/li/a

 
