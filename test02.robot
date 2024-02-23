*** Settings ***
Library    OperatingSystem
Documentation   suite de tests sur fichier
Test Setup  Log    debut test   #set up par defaut qui peut etre surchargé par test
Suite Setup     Log     test suite debut
Suite TearDown  Log     test suite fin

*** Variables ***
${NOM_FICHIER}  test.txt
${TEXTE}    contenu du fichier

*** Test Cases ***
Test creation fichier
    [Documentation]     description du test
    [Tags]  bidule,toto     PGS     2024    bug_found
    [Setup]     File Should Not Exist    ${NOM_FICHIER}        msg=fichier existe deja
    [TearDown]  Mon TearDown perso
    # ${texte}    Set Variable    contenu du fichier
    # VAR   ${texte}    contenu du fichier
    Create File     test.txt        ${TEXTE}    # creation fichier
    File Should Exist    test.txt   msg=fichier aurait du etre créé
    ${contenu}        Get File    ${NOM_FICHIER}
    Should Be Equal    ${contenu}    ${TEXTE}
    # Fail  # pour faire échouer
    # delete fichier pour la reproductibilite du test

Test setup 1
    Log    test setup 1

Test setup 2
    Log    test setup 2

*** Keywords ***   # creation de keyword
Mon TearDown perso
     Remove File    ${NOM_FICHIER}
     Log    fichier nettoyé
