*** Settings ***
Library             String
Documentation       Démos de boucles, listes, collections


*** Variables ***
${truc}         a       b       c
@{machin}       a       b       c
&{products}         sauce-labs-backpack=Sauce Labs Backpack
...                 sauce-labs-bike-light=Sauce Labs Bike Light
...                 sauce-labs-bolt-t-shirt=Sauce Labs Bolt T-Shirt
...                 sauce-labs-fleece-jacket=Sauce Labs Fleece Jacket
...                 sauce-labs-onesie=Sauce Labs Onesie
...                 test.allthethings()-t-shirt-(red)=Test.allTheThings() T-Shirt (Red)

*** Test Cases ***
Exemple d’arguments variables
    Log Many        foo         bar         baz
    ${elements}     Split String            foo,bar,baz     separator=,
    Log             ${elements}
    Log Many        ${elements}
    Log Many        @{elements}

Exemples de boucles simples
    VAR     @{elements}     foo     bar     baz
    FOR     ${element}      IN              @{elements}
            Log             ${element}
    END

    FOR         ${counter}       IN RANGE    5       10
        Log     ${counter}
    END

Exemple de liste globale
    Log     ${truc}
    Log     ${machin}

Test du mot-clé
    Mot-clé acceptant un nombre variable d’arguments        foo     bar     baz

Test de dictionnaire
    Log             ${products}
    FOR    ${key}       ${value}    IN    &{products}
        Log    ${value}

    END


*** Keywords ***
Mot-clé acceptant un nombre variable d’arguments
    [Arguments]         @{args}
    FOR    ${element}    IN    @{args}
        Log    ${element}

    END