# language: pt

Funcionalidade: Verzel Store

  Como usuário da Verzel Store
  Quero realizar operações de compra
  Para validar as regras de negócio da aplicação

  @CT001
  Cenário: Aplicar cupom válido
    Dado que o carrinho possui um produto
    Quando eu informar o cupom "BEMVINDO10"
    E aplicar o cupom
    Então o cupom deve ser aplicado com sucesso
    E o desconto de 10% deve ser apresentado

  @CT002
  Cenário: Aplicar cupom em letras minúsculas
    Dado que o carrinho possui um produto
    Quando eu informar o cupom "bemvindo10"
    E aplicar o cupom
    Então o cupom deve ser aplicado com sucesso

  @CT003
  Cenário: Aplicar cupom com espaços no início e no fim
    Dado que o carrinho possui um produto
    Quando eu informar o cupom " BEMVINDO10 "
    E aplicar o cupom
    Então o cupom deve ser aplicado com sucesso

  @CT004
  Cenário: Aplicar cupom inexistente
    Dado que o carrinho possui um produto
    Quando eu informar o cupom "TESTE123"
    E aplicar o cupom
    Então deve ser apresentada a mensagem "Cupom inválido."
    E nenhum desconto deve ser aplicado

  @CT005
  Cenário: Aplicar cupom expirado
    Dado que o carrinho possui um produto
    Quando eu informar o cupom "VERAO2026"
    E aplicar o cupom
    Então deve ser apresentada a mensagem de cupom expirado
    E nenhum desconto deve ser aplicado

  @CT006
  Cenário: Aplicar somente um cupom
    Dado que o carrinho possui um produto
    Quando eu informar um cupom válido
    E tentar aplicar um segundo cupom
    Então somente um cupom deve permanecer aplicado

  @CT007 @BUG-001
  Cenário: Aplicar frete grátis para subtotal de R$ 200,00
    Dado que o carrinho possui 2 unidades da Mochila Urbana 20L
    Quando o subtotal do carrinho for de R$ 200,00
    Então o frete deve ser grátis

  @CT008
  Cenário: Cobrar frete para subtotal abaixo de R$ 200,00
    Dado que o subtotal do carrinho seja inferior a R$ 200,00
    Quando o carrinho for calculado
    Então o frete de R$ 19,90 deve ser aplicado

  @CT009
  Cenário: Calcular frete grátis com base no subtotal antes do desconto
    Dado que o subtotal do carrinho seja igual ou superior a R$ 200,00
    E um cupom de desconto seja aplicado
    Quando o carrinho for calculado
    Então o frete deve permanecer grátis

  @CT010
  Cenário: Não aplicar desconto do cupom sobre o frete
    Dado que o carrinho possui um valor de frete
    E um cupom de desconto válido foi aplicado
    Quando o carrinho for calculado
    Então o desconto deve ser aplicado somente sobre os produtos
    E o valor do frete não deve sofrer desconto

  @CT011
  Cenário: Permitir no máximo 5 unidades do mesmo produto
    Dado que o carrinho possui um produto
    Quando eu adicionar 5 unidades do mesmo produto
    Então as 5 unidades devem ser aceitas
    E uma sexta unidade não deve ser permitida pela interface

  @CT012
  Cenário: Calcular corretamente o subtotal
    Dado que o carrinho possui produtos com quantidades definidas
    Quando o carrinho for calculado
    Então o subtotal deve corresponder à soma dos preços dos produtos multiplicados pelas respectivas quantidades

  @CT013
  Cenário: Calcular corretamente o total da compra
    Dado que o carrinho possui produtos
    E pode possuir desconto e frete
    Quando o carrinho for calculado
    Então o total deve ser igual ao subtotal menos o desconto mais o frete

  @CT014
  Cenário: Validar nome completo no checkout
    Dado que estou no checkout
    Quando eu informar um nome que não possua nome e sobrenome
    Então o sistema deve rejeitar o valor informado

  @CT015
  Cenário: Validar formato do e-mail no checkout
    Dado que estou no checkout
    Quando eu informar um endereço de e-mail inválido
    Então o sistema deve rejeitar o valor informado

  @CT016
  Cenário: Validar formato do CEP no checkout
    Dado que estou no checkout
    Quando eu informar um CEP inválido
    Então o sistema deve rejeitar o valor informado
    E um CEP válido deve possuir 8 dígitos, podendo conter hífen

  @API-001
  Cenário: Listar produtos pela API
    Dado que a API está disponível
    Quando eu enviar uma requisição GET para "/api/produtos"
    Então a resposta deve possuir status 200
    E a resposta deve retornar a lista de produtos

  @API-002
  Cenário: Consultar produto existente pela API
    Dado que o produto "P001" existe
    Quando eu enviar uma requisição GET para "/api/produtos/P001"
    Então a resposta deve possuir status 200
    E os dados do produto devem ser retornados corretamente

  @API-003
  Cenário: Consultar produto inexistente pela API
    Dado que o produto "P999" não existe
    Quando eu enviar uma requisição GET para "/api/produtos/P999"
    Então a resposta deve possuir status 404
    E o código do erro deve ser "PRODUTO_NAO_ENCONTRADO"

  @API-004
  Cenário: Calcular carrinho válido pela API
    Dado que o carrinho possui 1 unidade do produto "P002"
    E 2 unidades do produto "P004"
    Quando eu enviar uma requisição POST para "/api/carrinho/calcular"
    Então a resposta deve possuir status 200
    E o subtotal deve ser calculado corretamente
    E o total deve ser calculado corretamente

  @API-005
  Cenário: Calcular carrinho com cupom válido pela API
    Dado que o carrinho possui produtos
    E o cupom "BEMVINDO10" é válido
    Quando eu enviar uma requisição POST para "/api/carrinho/calcular"
    Então a resposta deve possuir status 200
    E um desconto de 10% deve ser aplicado

  @API-006
  Cenário: Calcular carrinho com cupom inexistente pela API
    Dado que o carrinho possui produtos
    E o cupom "TESTE123" não existe
    Quando eu enviar uma requisição POST para "/api/carrinho/calcular"
    Então a resposta deve possuir status 200
    E nenhum desconto deve ser aplicado
    E a mensagem do cupom deve informar "Cupom inválido."

  @API-007
  Cenário: Calcular carrinho com cupom expirado pela API
    Dado que o carrinho possui produtos
    E o cupom "VERAO2026" está expirado
    Quando eu enviar uma requisição POST para "/api/carrinho/calcular"
    Então a resposta deve possuir status 200
    E nenhum desconto deve ser aplicado
    E a mensagem do cupom deve informar que o cupom está expirado

  @API-008 @BUG-001
  Cenário: Aplicar frete grátis para subtotal de R$ 200,00 pela API
    Dado que o carrinho possui 2 unidades do produto "P005"
    Quando eu enviar uma requisição POST para "/api/carrinho/calcular"
    Então a resposta deve possuir status 200
    E o subtotal deve ser de R$ 200,00
    E o frete deve ser grátis
    E o valor do frete deve ser R$ 0,00

  @API-009
  Cenário: Aplicar frete para subtotal abaixo de R$ 200,00 pela API
    Dado que o carrinho possui 1 unidade do produto "P005"
    Quando eu enviar uma requisição POST para "/api/carrinho/calcular"
    Então a resposta deve possuir status 200
    E o frete deve ser de R$ 19,90
    E o valor restante para frete grátis deve ser informado

  @API-010
  Cenário: Permitir 5 unidades do mesmo produto pela API
    Dado que o carrinho possui 5 unidades do produto "P005"
    Quando eu enviar uma requisição POST para "/api/carrinho/calcular"
    Então a resposta deve possuir status 200
    E as 5 unidades devem ser aceitas

  @API-011 @BUG-002
  Cenário: Impedir mais de 5 unidades do mesmo produto pela API
    Dado que o carrinho possui 6 unidades do produto "P005"
    Quando eu enviar uma requisição POST para "/api/carrinho/calcular"
    Então a resposta deve possuir status 422
    E o código do erro deve ser "QUANTIDADE_MAXIMA_EXCEDIDA"

  @API-012
  Cenário: Criar pedido válido pela API
    Dado que o carrinho possui produtos válidos
    E os dados do cliente são válidos
    Quando eu enviar uma requisição POST para "/api/pedidos"
    Então a resposta deve possuir status 201
    E um número de pedido deve ser retornado

  @API-013
  Cenário: Criar pedido com cupom inexistente pela API
    Dado que o carrinho possui produtos válidos
    E o cupom informado é "TESTE123"
    Quando eu enviar uma requisição POST para "/api/pedidos"
    Então a resposta deve possuir status 422
    E o código do erro deve ser "CUPOM_INVALIDO"

  @API-014
  Cenário: Criar pedido com cupom expirado pela API
    Dado que o carrinho possui produtos válidos
    E o cupom informado é "VERAO2026"
    Quando eu enviar uma requisição POST para "/api/pedidos"
    Então a resposta deve possuir status 422
    E o código do erro deve ser "CUPOM_EXPIRADO"