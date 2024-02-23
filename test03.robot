*** Settings ***
Library     Process
Documentation      contient des test du programme hello.py

*** Variables ***


*** Test Cases ***
Test d'appel du programme
    ${res}  Run Process    python   hello.py
    Log    ${res.stdout}
    Log    ${res.rc}
    #${zero}     Convert To Integer    0
    Should Be Equal As Integers    ${res.rc}    ${0}       msg=le programme a planté
    #Should Be Equal     ${res.sterr}    ${EMPTY}       msg=le programme a planté
    Should Be Empty     ${res.stderr}       msg=le programme a planté
    Should Be Equal     ${res.stdout}       hello world
*** Keywords ***
