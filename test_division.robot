
#dans quel cas valeur fausse (il y a des bugs !!)

*** Variables ***


*** Test Cases ***
Test Division_decimale via Template + données en paramètres
#limite 1 seul test !!
    [Template]  Division_decimale_resultat
    #retour numerateur  diviseur  resultat
    ${res}      5       2       2.50
    ${res}      10      2       5.00

Test Division_decimale via Template + données en paramètres
    [Template]  Division_entiere_resultat
    #numerateur  diviseur  resultat
    ${res}      5       2       2       1.00

Test aucun paramètre (maj)
    ${res}  Run Process    python   division.py
    Check_Exec_KO_stdout_msg       ${res}      usage: division.py [-h] [--reste] numerateur diviseur

Test 1 paramètre (maj)
    ${res}  Run Process    python   division.py 2
    Check_Exec_KO_stdout_msg       ${res}      usage: division.py [-h] [--reste] numerateur diviseur

Test 2 paramètres
    ${res}  Run Process    python   division.py     10  2
    Check_Exec_OK       ${res}

#python ./division.py --reste
#usage: division.py [-h] [--reste] numerateur diviseur
#division.py: error: the following arguments are required: numerateur, diviseur
Test param reste seulement
    ${res}  Run Process    python   division.py     --reste
    Should Not Be Equal     ${res.rc}    ${0}       msg=le programme a planté
    Should Be Empty         ${res.stdout}       msg=le programme a planté
    Should Not Be Empty     ${res.stderr}       msg=le programme a planté
    ${line1}    Get Line    ${res.stderr}       0
    ${line2}    Get Line    ${res.stderr}       1
    Should Be Equal     ${line1}        usage: division.py [-h] [--reste] numerateur diviseur
    Should Be Equal     ${line2}        division.py: error: the following arguments are required: numerateur, diviseur

#python ./division.py 1  --reste
#usage: division.py [-h] [--reste] numerateur diviseur
#division.py: error: the following arguments are required: diviseur
Test paramètre numerateur non string
    #${res}  Run Process    python   division.py     A  2
    Division_decimale   A  2
    Check_Exec_KO_stdout_msg       ${res}      usage: division.py [-h] [--reste] numerateur diviseur



Test paramètre diviseur non string
    ${res}  Run Process    python   division.py     10  A
    Check_Exec_KO_stdout_msg       ${res}      usage: division.py [-h] [--reste] numerateur diviseur

Test diviseur zero (maj)
    ${res}  Run Process    python   division.py     10  0
    Check_Exec_KO_stderr_msg       ${res}      Erreur: float division by zero
    #Should Not Be Equal     ${res.rc}    ${0}       msg=le programme a planté
    #Should Be Empty         ${res.stdout}       msg=le programme a planté
    #Should Not Be Empty     ${res.stderr}       Erreur: float division by zero

Test diviseur trop grand (maj)
    Division_decimale_resultat   10  100     0.10
    #${res}  Run Process    python   division.py     10  100
    #Should Be Equal     ${res.rc}    ${0}       msg=le programme a planté
    #Should Not Be Empty     ${res.stdout}       msg=le programme a planté
    #Should Be Empty     ${res.stderr}       Erreur: float division by zero
    #Should Be Equal     ${res.stdout}       0.10

Test diviseur > numerateur, diviseur=0 reste=numerateur
    Division_entiere_resultat   10  100    0   10.00
    #${res}  Run Process    python   division.py     10  100     --reste
    #Should Be Equal     ${res.rc}    ${0}       msg=le programme a planté
    #Should Be Empty     ${res.stderr}       msg=le programme a planté
    #Should Not Be Empty     ${res.stdout}       msg=le programme a planté
    #${line1}    Get Line    ${res.stdout}       0
    #${line2}    Get Line    ${res.stdout}       1
    #Should Be Equal     ${line1}        0
    #Should Be Equal     ${line2}        10.00
    #Should Be Equal As Integers      ${line2}        10

Test numerateur zero avec reste (diviseur=0 reste=0) (maj)
    Division_entiere_resultat   0  3    0   0.00
    #${res}  Run Process    python   division.py     0  3     --reste
    #Should Be Equal     ${res.rc}    ${0}       msg=le programme a planté
    #Should Be Empty     ${res.stderr}       msg=le programme a planté
    #Should Not Be Empty     ${res.stdout}       msg=le programme a planté
    #${line1}    Get Line    ${res.stdout}       0
    #${line2}    Get Line    ${res.stdout}       1
    #Should Be Equal     ${line1}        0
    #Should Be Equal     ${line2}        0.00

Test numerateur zero sans reste (result=0) (maj)
    Division_decimale_resultat  0  3    0.00
    #${res}  Run Process    python   division.py     0  3
    #Check_Exec_OK   ${res}
    #Should Be Equal     ${res.rc}    ${0}       msg=le programme a planté
    #Should Be Empty     ${res.stderr}       msg=le programme a planté
    #Should Not Be Empty     ${res.stdout}       msg=le programme a planté
    #${line1}    Get Line    ${res.stdout}       0
    #Should Be Equal     ${line1}        0.00

Test numerateur diviseur decimal (maj) PB
    Division_entiere_resultat   10.0  5.5   1   4.50
    #${res}  Run Process    python   division.py     10.0  5.5
    #Should Be Equal     ${res.rc}    ${0}       msg=le programme a planté
    #Should Be Empty     ${res.stderr}       msg=le programme a planté
    #Should Not Be Empty     ${res.stdout}       msg=le programme a planté
    #${line1}    Get Line    ${res.stdout}       0
    #${line2}    Get Line    ${res.stdout}       1
    #Should Be Equal     ${line1}        1       #erreur réponse=2 !!!
    #Should Be Equal     ${line2}        4.50

*** Keywords ***
#eviter de passer des paramètres optionnels qui peuvent être vide !!
Division_decimale_resultat
    [Documentation]    division décimale sans reste
    [Arguments]     ${numerateur}       ${diviseur}     ${resultat}
    ${res}  Run Process    python   division.py     ${numerateur}  ${diviseur}
    Should Be Equal         ${res.rc}    ${0}   msg=le programme a planté
    Should Be Empty         ${res.stderr}       msg=le programme a planté
    Should Not Be Empty     ${res.stdout}       msg=le programme a planté
    ${line1}    Get Line    ${res.stdout}       0
    Should Be Equal     ${line1}        ${resultat}
    #[Return]     ${res}

Division_decimale
    [Documentation]    division décimale sans reste
    [Arguments]     ${numerateur}       ${diviseur}
    ${res}  Run Process    python   division.py     ${numerateur}  ${diviseur}
    [Return]     ${res}

Division_entiere_resultat
    [Documentation]    division entière avec reste
    [Arguments]     ${numerateur}       ${diviseur}     ${resultat1}     ${resultat2}
    ${res}  Run Process    python   division.py     ${numerateur}  ${diviseur}      --reste
    Should Be Equal         ${res.rc}    ${0}   msg=le programme a planté
    Should Be Empty         ${res.stderr}       msg=le programme a planté
    Should Not Be Empty     ${res.stdout}       msg=le programme a planté
    ${line1}    Get Line    ${res.stdout}       0
    ${line2}    Get Line    ${res.stdout}       1
    Should Be Equal     ${line1}        ${resultat1}
    Should Be Equal     ${line2}        ${resultat2}
    #[Return]     ${res}

Division_entiere   #eviter de passer des paramètres optionnels qui peuvent être vide !!
    [Documentation]    division entière avec reste
    [Arguments]     ${numerateur}       ${diviseur}
    ${res}  Run Process    python   division.py     ${numerateur}  ${diviseur}      --reste
    [Return]     ${res}

Check_Exec_KO_stdout_msg
    [Documentation]     retour ko avec message attendu dans stdout
    [Arguments]     ${res}      ${msg_attendu}
    Should Not Be Equal     ${res.rc}    ${0}   msg=le programme a planté
    Should Not Be Empty     ${res.stderr}       msg=le programme a planté
    Should Not Be Equal     ${res.stdout}       ${msg_attendu}

Check_Exec_KO_stderr_msg
    [Documentation]     retour ko avec message attendu dans stderr
    [Arguments]     ${res}      ${msg_attendu}
    Should Not Be Equal     ${res.rc}    ${0}       msg=le programme a planté
    Should Be Empty         ${res.stdout}       msg=le programme a planté
    Should Not Be Empty     ${res.stderr}       ${msg_attendu}

Check_Exec_OK
    [Documentation]     retour ok sans message attendu
    [Arguments]     ${res}
    Should Be Equal         ${res.rc}    ${0}   msg=le programme a planté
    Should Be Empty         ${res.stderr}       msg=le programme a planté
    Should Not Be Empty     ${res.stdout}       msg=le programme a planté

Check_Stdout_Lines12
    [Documentation]     test le contenu des 2 lignes du stdout
    [Arguments]     ${stdout}       ${valueL1}          ${valueL2}
    ${line1}    Get Line    ${stdout}       0
    ${line2}    Get Line    ${stdout}       1
    Should Be Equal     ${line1}        ${valueL1}
    Should Be Equal     ${line2}        ${valueL2}