*** Settings ***
Library         Process
Library         String

*** Variables ***
${script_name}          division.py

*** Keywords ***
Division simple
    [Documentation]     Appelle le programme de division avec les arguments fournis, et vérifie l’exactitude du résultat,
    ...                 ainsi que le code de retour et la sortie d’erreur
    [Arguments]         ${numerateur}       ${diviseur}     ${resultat}
    ${res}              Run Process         python      ${script_name}        ${numerateur}       ${diviseur}
    Should Be Equal     ${res.rc}           ${0}        msg=Le programme a planté
    Should Be Empty     ${res.stderr}
    Should Be Equal     ${res.stdout}       ${resultat}


Division euclidienne
    [Documentation]                 Appelle le programme de division avec les arguments fournis, en mode euclidien, et vérifie l’exactitude du résultat,
    ...                             ainsi que le code de retour et la sortie d’erreur
    [Arguments]                     ${numerateur}           ${diviseur}             ${quotient_attendu}         ${reste_attendu}
    ${res}                          Run Process             python                  ${script_name}              ${numerateur}       ${diviseur}         --reste
    Should Be Equal                 ${res.rc}               ${0}                    msg=Le programme a planté
    Should Be Empty                 ${res.stderr}
    ${quotient_obtenu}              Get Line                ${res.stdout}   0
    ${reste_obtenu}                 Get Line                ${res.stdout}    1
    Should Be Equal As Integers     ${quotient_obtenu}      ${quotient_attendu}     msg=Le quotient de ${numerateur}/${diviseur} est incorrect
    Should Be Equal                 ${reste_obtenu}         ${reste_attendu}        msg=Le reste de ${numerateur}/${diviseur} est incorrect
#    Should Be Equal     ${res.stdout}       ${resultat}
#    [Return]            ${res}             # déprécié depuis robot 7.0
#    RETURN              ${res}

Division en erreur
    [Documentation]                 Appelle le programme de division avec des arguments arbitraires, et vérifie que cet appel est
    ...                             incorrect et provoque une erreur
    [Arguments]                     @{prog_arguments}           ${rc_attendu}           ${erreur_attendue}
    ${res}                          Run Process                 python                  ${script_name}          @{prog_arguments}
    Should Not Be Equal             ${res.rc}                   ${0}                    msg=Le programme n’a pas planté
    Should Be Equal As Integers     ${res.rc}                   ${rc_attendu}           msg=Le code de retour est incorrect
    Should Contain                  ${res.stderr}               ${erreur_attendue}      ignore_case=yes

La division de ${numerateur} par ${diviseur} devrait être de ${resultat}
    [Documentation]             Raccourci vers le mot-clé division simple
    Division simple    ${numerateur}    ${diviseur}    ${resultat}