*** Settings ***
Library         SeleniumLibrary

*** Test Cases ***
Test installation Selenium
    Open Browser        https://saucedemo.com           browser=firefox
    Input Text          name:user-name                  standard_user
