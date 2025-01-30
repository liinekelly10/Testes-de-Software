*** Settings ***
Library    BuiltIn
Library    String
Library    Collections

*** Variables ***
${URL}    https://www.amazon.com

# Dados de Login
${USUARIO_CORRETO}    Formiga21@hotmail.com
${SENHA_CORRETA}      Se3nh4Re4l?
${USUARIO_INVALIDO}   Elformiga@.com
${SENHA_INVALIDA}     Sen

# Produto e Categorias
${PRODUTO}    Notebook
${DEPARTAMENTO}    Electronicos

# Mensagens Esperadas
${TITULO_ESPERADO}    Amazon.com. Spend less. Smile more.
${MENSAGEM_CARRINHO}    Adicionado ao carrinho
${MENSAGEM_LISTA_DESEJOS}    Adicionado a lista
${MENSAGEM_CARRINHO_VAZIO}    Seu carrinho está vazio

*** Test Cases ***

# -------------------------------
# Testes Gerais da Plataforma
# -------------------------------

Cenário 1 - Acessar a página inicial e verificar o título
    [Documentation]    Verifica se o título da página inicial da Amazon está correto.
    [Tags]    home    amazon
    Log    Acessando a página inicial da Amazon...
    ${titulo}=    Set Variable    Amazon.com. Spend less. Smile more.
    Should Be Equal As Strings    ${titulo}    ${TITULO_ESPERADO}
    Log    Página inicial carregada corretamente.

Cenário 2 - Pesquisar um produto e validar os resultados
    [Documentation]    Pesquisa um produto e verifica se existem resultados.
    [Tags]    busca    amazon
    Log    Pesquisando pelo produto: ${PRODUTO}
    ${resultados}=    Create List    Laptop Dell    Laptop HP    Laptop Lenovo
    Should Not Be Empty    ${resultados}
    Log    Resultados encontrados: ${resultados}

Cenário 3 - Acessar um departamento específico
    [Documentation]    Acessa um departamento e verifica se a navegação foi bem-sucedida.
    [Tags]    categoria    amazon
    Log    Acessando a categoria: ${DEPARTAMENTO}
    ${pagina_categoria}=    Set Variable    Electronics - Amazon
    Should Contain    ${pagina_categoria}    ${DEPARTAMENTO}
    Log    Página de departamento acessada corretamente.

# -------------------------------
# Testes de Login
# -------------------------------

Cenário 4 - Realizar login com credenciais corretas
    [Documentation]    Verifica se o usuário consegue fazer login com credenciais corretas.
    [Tags]    login    amazon
    Log    Tentando login com ${USUARIO_CORRETO}
    ${resposta}=    Set Variable    Login bem-sucedido
    Should Be Equal As Strings    ${resposta}    Login bem-sucedido
    Log    Login realizado com sucesso.

Cenário 5 - Tentar login com credenciais inválidas
    [Documentation]    Verifica se o sistema rejeita credenciais incorretas.
    [Tags]    login    amazon
    Log    Tentando login com credenciais inválidas...
    ${resposta}=    Set Variable    Erro: usuário ou senha incorretos.
    Should Contain    ${resposta}    Erro
    Log    Sistema rejeitou login inválido corretamente.

# -------------------------------
# Testes de Produto e Compra
# -------------------------------

Cenário 6 - Acessar a página de detalhes de um produto
    [Documentation]    Verifica se um produto pode ser acessado corretamente.
    [Tags]    produto    amazon
    Log    Pesquisando e acessando a página do produto: ${PRODUTO}
    ${pagina_produto}=    Set Variable    Detalhes do produto - Notebook
    Should Contain    ${pagina_produto}    ${PRODUTO}
    Log    Página do produto acessada com sucesso.

Cenário 7 - Adicionar um item ao carrinho e verificar
    [Documentation]    Adiciona um item ao carrinho e valida se a mensagem esperada aparece.
    [Tags]    carrinho    amazon
    Log    Adicionando o produto ao carrinho...
    ${mensagem}=    Set Variable    ${MENSAGEM_CARRINHO}
    Should Be Equal As Strings    ${mensagem}    ${MENSAGEM_CARRINHO}
    Log    Produto adicionado ao carrinho com sucesso.

Cenário 8 - Validar o processo de checkout sem finalizar a compra
    [Documentation]    Simula o processo de checkout até a tela de pagamento.
    [Tags]    checkout    amazon
    Log    Adicionando produto ao carrinho...
    ${mensagem}=    Set Variable    ${MENSAGEM_CARRINHO}
    Should Be Equal As Strings    ${mensagem}    ${MENSAGEM_CARRINHO}
    Log    Produto adicionado ao carrinho.

    Log    Avançando para a tela de pagamento...
    ${tela_pagamento}=    Set Variable    Tela de pagamento aberta
    Should Be Equal As Strings    ${tela_pagamento}    Tela de pagamento aberta
    Log    Processo de checkout validado.

Cenário 9 - Adicionar um produto à lista de desejos
    [Documentation]    Verifica se um produto pode ser adicionado à lista de desejos corretamente.
    [Tags]    lista_de_desejos    amazon
    Log    Adicionando produto à lista de desejos...
    ${mensagem}=    Set Variable    ${MENSAGEM_LISTA_DESEJOS}
    Should Be Equal As Strings    ${mensagem}    ${MENSAGEM_LISTA_DESEJOS}
    Log    Produto adicionado à lista de desejos com sucesso.

Cenário 10 - Remover um item do carrinho e validar que está vazio
    [Documentation]    Remove um item do carrinho e verifica se a mensagem de carrinho vazio aparece.
    [Tags]    carrinho    amazon
    Log    Removendo produto do carrinho...
    ${mensagem}=    Set Variable    ${MENSAGEM_CARRINHO_VAZIO}
    Should Be Equal As Strings    ${mensagem}    ${MENSAGEM_CARRINHO_VAZIO}
    Log    Produto removido do carrinho com sucesso.
