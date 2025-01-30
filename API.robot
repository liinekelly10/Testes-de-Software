*** Settings ***
Library     RequestsLibrary
Library     String
Library     BuiltIn

*** Variables ***
${HOST}    https://dummyjson.com

# ROTAS
${GET_ALL_PRODUCTS}    products
${GET_SINGLE_PRODUCT}    products/{id}

*** Keywords ***
Criar sessão
    Create Session    mysession    ${HOST}

Pegar todos os produtos
    [Arguments]    ${session}=mysession
    &{headers}    Create Dictionary    Content-Type=application/json
    ${response}    GET On Session    ${session}    ${GET_ALL_PRODUCTS}    headers=&{headers}
    Log    ${response.content}
    Should Be Equal As Strings    ${response.status_code}    200

Pegar um único produto de id
    [Arguments]    ${id}    ${session}=mysession
    &{headers}    Create Dictionary    Content-Type=application/json
    ${endpoint}    Replace String    ${GET_SINGLE_PRODUCT}    {id}    ${id}
    ${response}    GET On Session    ${session}    ${endpoint}    headers=&{headers}
    Log    ${response.content}
    Should Be Equal As Strings    ${response.status_code}    200

Verificar se Produto Existe
    [Arguments]    ${id}    ${session}=mysession
    Run Keyword And Ignore Error    Pegar um único produto de id    ${id}    ${session}
    ${status}=    Run Keyword And Return Status    Pegar um único produto de id    ${id}    ${session}
    Run Keyword If    '${status}' == 'FAIL'    Log    Produto não encontrado com ID: ${id}
    Run Keyword If    '${status}' == 'FAIL'    Should Be Equal As Strings    ${status}    FAIL

*** Test Cases ***
Cenário 1 - Realizar a busca por todos os produtos
    Criar sessão
    Pegar todos os produtos

Cenário 2 - Realizar busca por um único produto
    Criar sessão
    Verificar se Produto Existe    72   # Produto com ID 72 que existe
    Verificar se Produto Existe    99999   # Produto com ID inexistente, deve gerar erro
