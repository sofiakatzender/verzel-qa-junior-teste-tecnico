# Cenários de Teste — Verzel Store

## 1. Objetivo

Validar as principais funcionalidades da Verzel Store relacionadas à aplicação de cupons de desconto, cálculo de frete, cálculo de valores do pedido, limite de quantidade de produtos e validações do checkout.

Os testes foram elaborados com base nos critérios de aceite, regras de negócio e dados disponibilizados na documentação da versão 2.3.0 da aplicação.

A execução foi realizada de forma manual, exploratória e por meio de testes de API, sendo posteriormente complementada por testes automatizados utilizando Playwright.

---

## 2. Cenários de Teste

### CT001 — Aplicar cupom válido

**Pré-condições:**

- Acessar a Verzel Store.
- Possuir pelo menos um produto no carrinho.
- Possuir o cupom `BEMVINDO10`.

**Passos:**

1. Acessar a loja.
2. Adicionar um produto ao carrinho.
3. Acessar o carrinho.
4. Informar o cupom `BEMVINDO10`.
5. Aplicar o cupom.

**Resultado esperado:**

O cupom deve ser aplicado com sucesso e conceder 10% de desconto sobre o subtotal dos produtos.

**Resultado obtido:**

O cupom `BEMVINDO10` foi aplicado corretamente. O sistema apresentou desconto de 10% sobre o subtotal.

Para o produto de R$ 59,90:

- Subtotal: R$ 59,90
- Desconto: R$ 5,99
- Frete: R$ 19,90
- Total: R$ 73,81

**Status:** Aprovado.

**Evidência:**

- `evidencias/cupom/CT001-cupom-valido.png`

---

### CT002 — Aplicar cupom com letras minúsculas

**Pré-condições:**

- Possuir produto no carrinho.
- Possuir o cupom válido `BEMVINDO10`.

**Passos:**

1. Adicionar um produto ao carrinho.
2. Acessar o carrinho.
3. Informar o cupom utilizando letras minúsculas: `bemvindo10`.
4. Aplicar o cupom.

**Resultado esperado:**

O cupom deve ser reconhecido normalmente, pois o código não diferencia letras maiúsculas de minúsculas.

**Resultado obtido:**

O cupom `bemvindo10`, informado em letras minúsculas, foi aceito corretamente pelo sistema.

Com 2 unidades da Calça Jeans Slim:

- Subtotal: R$ 279,80
- Desconto: R$ 27,98
- Frete: Grátis
- Total: R$ 251,82

O comportamento está de acordo com o critério CA02.

**Status:** Aprovado.

**Evidência:**

- `evidencias/cupom/CT002-cupom-minusculo.png`

---

### CT003 — Aplicar cupom com espaços no início e no fim

**Pré-condições:**

- Possuir produto no carrinho.
- Possuir o cupom válido `BEMVINDO10`.

**Passos:**

1. Adicionar um produto ao carrinho.
2. Acessar o carrinho.
3. Informar o cupom com espaços antes e depois do código.
4. Aplicar o cupom.

**Resultado esperado:**

O sistema deve ignorar os espaços no início e no fim e aplicar o cupom normalmente.

**Resultado obtido:**

O cupom `BEMVINDO10` foi aplicado corretamente mesmo com espaços no início e no fim do código.

Com 2 unidades da Calça Jeans Slim:

- Subtotal: R$ 279,80
- Desconto: R$ 27,98
- Frete: Grátis
- Total: R$ 251,82

O comportamento está de acordo com o critério CA02.

**Status:** Aprovado.

**Evidência:**

- `evidencias/cupom/CT003-cupom-com-espacos-inicio-fim.png`

---

### CT004 — Aplicar cupom inexistente

**Pré-condições:**

- Possuir produto no carrinho.

**Passos:**

1. Adicionar um produto ao carrinho.
2. Acessar o carrinho.
3. Informar o código de cupom inexistente `TESTE123`.
4. Aplicar o cupom.

**Resultado esperado:**

O sistema deve exibir a mensagem `Cupom inválido.` e nenhum desconto deve ser aplicado.

**Resultado obtido:**

Ao informar o cupom inexistente `TESTE123`, o sistema exibiu a mensagem `Cupom inválido.` e não aplicou nenhum desconto.

O subtotal permaneceu em R$ 279,80, o frete permaneceu grátis e o total permaneceu em R$ 279,80.

O comportamento está de acordo com o critério CA03.

**Status:** Aprovado.

**Evidência:**

- `evidencias/cupom/CT004-cupom-invalido.png`

---

### CT005 — Aplicar cupom expirado

**Pré-condições:**

- Possuir produto no carrinho.
- Possuir o cupom expirado `VERAO2026`.

**Passos:**

1. Adicionar um produto ao carrinho.
2. Acessar o carrinho.
3. Informar `VERAO2026`.
4. Aplicar o cupom.

**Resultado esperado:**

O sistema deve exibir a mensagem `Cupom expirado.` e nenhum desconto deve ser aplicado.

**Resultado obtido:**

Ao informar o cupom expirado `VERAO2026`, o sistema exibiu a mensagem `Cupom expirado.` e não aplicou nenhum desconto.

O subtotal permaneceu em R$ 279,80, o desconto permaneceu em R$ 0,00, o frete permaneceu grátis e o total permaneceu em R$ 279,80.

O comportamento está de acordo com o critério CA04.

**Status:** Aprovado.

**Evidência:**

- `evidencias/cupom/CT005-cupom-expirado.png`

---

### CT006 — Permitir apenas um cupom por vez

**Pré-condições:**

- Possuir produto no carrinho.
- Possuir os cupons `BEMVINDO10` e `VERAO2026` disponíveis para teste.

**Passos:**

1. Adicionar um produto ao carrinho.
2. Aplicar o cupom `BEMVINDO10`.
3. Verificar a existência da opção para remover o cupom aplicado.
4. Remover o cupom `BEMVINDO10`.
5. Tentar aplicar o cupom `VERAO2026`.

**Resultado esperado:**

O sistema deve permitir apenas um cupom aplicado por vez. Para utilizar outro cupom, o cupom atualmente aplicado deve ser removido primeiro.

**Resultado obtido:**

Após aplicar o cupom `BEMVINDO10`, o sistema apresentou a opção `Remover cupom`. O cupom foi removido antes da tentativa de aplicação do segundo cupom.

Após a remoção, foi realizada uma tentativa de aplicação do cupom `VERAO2026`, que foi corretamente identificada como expirado.

O comportamento observado está de acordo com o critério CA05.

**Status:** Aprovado.

**Evidência:**

- `evidencias/cupom/CT006-apenas-um-cupom.png`

---

### CT007 — Frete grátis a partir de R$ 200,00

**Pré-condições:**

- Carrinho vazio.
- Produtos disponíveis.

**Passos:**

1. Adicionar 2 unidades da Mochila Urbana 20L, no valor de R$ 100,00 cada.
2. Acessar o carrinho.
3. Verificar se o subtotal é exatamente R$ 200,00.
4. Verificar o valor do frete.
5. Aplicar o cupom `BEMVINDO10`.
6. Verificar novamente o valor do frete.

**Resultado esperado:**

- Um subtotal de R$ 200,00 deve resultar em frete grátis.
- O frete deve permanecer grátis após a aplicação do cupom, pois a regra de frete considera o subtotal antes do desconto.

**Resultado obtido:**

Com 2 unidades da Mochila Urbana 20L, o subtotal ficou em R$ 200,00.

Sem cupom, o sistema cobrou R$ 19,90 de frete, embora a documentação determine frete grátis para valores a partir de R$ 200,00, inclusive.

Após aplicar o cupom `BEMVINDO10`, foi aplicado desconto de R$ 20,00, porém o frete continuou em R$ 19,90.

A tela também informou `Faltam R$ 0,00 para o frete grátis`.

**Status:** Reprovado — BUG-001.

**Evidências:**

- `evidencias/frete/CT007-R200-sem-cupom.png`
- `evidencias/frete/CT007-R200-com-cupom.png`

---

### CT008 — Cobrar frete abaixo de R$ 200,00

**Pré-condições:**

- Possuir produtos cujo subtotal seja inferior a R$ 200,00.

**Passos:**

1. Adicionar produtos ao carrinho.
2. Garantir que o subtotal seja inferior a R$ 200,00.
3. Acessar o carrinho.
4. Verificar o valor do frete.

**Resultado esperado:**

O sistema deve cobrar frete fixo de R$ 19,90 e informar quanto falta para atingir o valor necessário para frete grátis.

**Resultado obtido:**

Com 1 unidade da Mochila Urbana 20L, o subtotal ficou em R$ 100,00.

O sistema aplicou corretamente o frete fixo de R$ 19,90, informou que faltam R$ 100,00 para o frete grátis e apresentou o total de R$ 119,90.

**Status:** Aprovado.

**Evidência:**

- `evidencias/frete/CT008-abaixo-R200.png`

---

### CT009 — Frete grátis considerando subtotal antes do desconto

**Pré-condições:**

- Possuir produtos cujo subtotal seja igual ou superior a R$ 200,00.
- Possuir o cupom `BEMVINDO10`.

**Passos:**

1. Adicionar produtos cujo subtotal seja igual ou superior a R$ 200,00.
2. Verificar o subtotal.
3. Aplicar o cupom `BEMVINDO10`.
4. Verificar o valor do frete.

**Resultado esperado:**

O frete deve permanecer grátis, pois a regra considera o subtotal antes da aplicação do desconto.

**Resultado obtido:**

Com 2 unidades da Calça Jeans Slim, o subtotal ficou em R$ 279,80.

Após aplicar o cupom `BEMVINDO10`, foi aplicado desconto de R$ 27,98 e o frete permaneceu grátis.

O total ficou em R$ 251,82.

**Status:** Aprovado.

**Evidência:**

- `evidencias/frete/CT009-frete-subtotal-antes-cupom.png`

---

### CT010 — Desconto não aplicado sobre o frete

**Pré-condições:**

- Possuir produtos com subtotal inferior a R$ 200,00.
- Possuir o cupom `BEMVINDO10`.

**Passos:**

1. Adicionar produtos ao carrinho com subtotal inferior a R$ 200,00.
2. Aplicar o cupom `BEMVINDO10`.
3. Verificar o desconto.
4. Verificar o valor do frete.
5. Verificar o total do pedido.

**Resultado esperado:**

O desconto de 10% deve ser aplicado somente sobre o subtotal dos produtos. O frete de R$ 19,90 não deve sofrer desconto.

**Resultado obtido:**

Com 1 unidade da Calça Jeans Slim, o subtotal ficou em R$ 139,90.

Após aplicar o cupom `BEMVINDO10`, foi aplicado desconto de R$ 13,99.

O frete permaneceu em R$ 19,90, sem aplicação do desconto, e o total ficou em R$ 145,81.

**Status:** Aprovado.

**Evidência:**

- `evidencias/frete/CT010-desconto-nao-aplica-frete.png`

---

### CT011 — Limite máximo de 5 unidades por produto

**Pré-condições:**

- Possuir um produto disponível na loja.

**Passos:**

1. Adicionar 5 unidades do mesmo produto ao carrinho.
2. Verificar a quantidade.
3. Tentar adicionar uma sexta unidade.

**Resultado esperado:**

O sistema deve permitir no máximo 5 unidades do mesmo produto por pedido.

**Resultado obtido:**

Foi possível adicionar até 5 unidades da Calça Jeans Slim.

Ao atingir 5 unidades, o sistema informou `Limite de 5 unidades por produto` e não permitiu adicionar uma sexta unidade.

**Status:** Aprovado.

**Evidência:**

- `evidencias/carrinho/CT011-limite-5-unidades.png`

---

### CT012 — Cálculo do subtotal

**Pré-condições:**

- Possuir pelo menos um produto no carrinho.

**Passos:**

1. Adicionar um produto com quantidade conhecida.
2. Calcular manualmente o valor dos produtos.
3. Comparar o cálculo manual com o subtotal apresentado pela aplicação.

**Resultado esperado:**

O subtotal deve corresponder à soma do preço unitário multiplicado pela quantidade de cada produto.

**Resultado obtido:**

Com 2 unidades da Calça Jeans Slim, no valor de R$ 139,90 cada, o cálculo manual resultou em R$ 279,80.

O subtotal apresentado pela aplicação também foi de R$ 279,80.

**Status:** Aprovado.

**Evidência:**

- `evidencias/carrinho/CT012-calculo-subtotal.png`

---

### CT013 — Cálculo do total com cupom e frete

**Pré-condições:**

- Possuir produtos no carrinho.
- Possuir o cupom `BEMVINDO10`.

**Passos:**

1. Adicionar produtos ao carrinho.
2. Aplicar o cupom.
3. Verificar o subtotal.
4. Verificar o desconto.
5. Verificar o frete.
6. Verificar o total.

**Resultado esperado:**

O total deve seguir a fórmula:

`total = subtotal - desconto + frete`

Os valores devem ser apresentados com duas casas decimais.

**Resultado obtido:**

Com 1 unidade da Calça Jeans Slim:

- Subtotal: R$ 139,90
- Desconto: R$ 13,99
- Frete: R$ 19,90
- Total: R$ 145,81

O total apresentado correspondeu corretamente à fórmula do pedido.

**Status:** Aprovado.

**Evidência:**

- `evidencias/carrinho/CT013-calculo-total.png`

---

### CT014 — Validação do nome do cliente

**Pré-condições:**

- Possuir produtos no carrinho.
- Acessar o fluxo de finalização do pedido.

**Passos:**

1. Acessar a tela de checkout.
2. Informar somente Sofia no campo "Nome completo".
3. Preencher os demais campos com informações válidas.
4. Tentar finalizar o pedido.

**Resultado esperado:**

O sistema deve impedir a finalização e informar que o nome precisa conter nome e sobrenome.

**Resultado obtido:**

Ao informar somente Sofia no campo "Nome completo", o sistema não permitiu a confirmação do pedido e manteve a mensagem `Informe nome e sobrenome.`.

**Status:** Aprovado.

**Evidência:**

- `evidencias/checkout/CT014-nome-invalido.png`

---

### CT015 — Validação do e-mail

**Pré-condições:**

- Possuir produtos no carrinho.
- Acessar o fluxo de finalização do pedido.

**Passos:**

1. Acessar a tela de checkout.
2. Informar um nome válido.
3. Informar `sofia@` no campo de e-mail.
4. Preencher o CEP com um valor válido.
5. Tentar finalizar o pedido.

**Resultado esperado:**

O sistema deve impedir a finalização e informar que o e-mail precisa possuir um formato válido.

**Resultado obtido:**

Ao informar `sofia@` no campo de e-mail, o sistema impediu a confirmação do pedido e apresentou a mensagem `Informe um e-mail válido.`.

**Status:** Aprovado.

**Evidência:**

- `evidencias/checkout/CT015-email-invalido.png`

---

### CT016 — Validação do CEP

**Pré-condições:**

- Possuir produtos no carrinho.
- Acessar o fluxo de finalização do pedido.

**Passos:**

1. Acessar a tela de checkout.
2. Informar um nome válido.
3. Informar um e-mail válido.
4. Informar `123` no campo de CEP.
5. Tentar finalizar o pedido.

**Resultado esperado:**

O sistema deve impedir a finalização quando o CEP não possuir 8 dígitos.

**Resultado obtido:**

Ao informar um CEP com apenas 3 dígitos, o sistema impediu a confirmação do pedido e apresentou a mensagem `Informe um CEP com 8 dígitos.`.

**Status:** Aprovado.

**Evidência:**

- `evidencias/checkout/CT016-cep-invalido.png`

---

# 3. Cenários de API

Os cenários abaixo foram executados diretamente na API disponibilizada pela Verzel Store, utilizando os endpoints descritos na documentação da versão 2.3.0.

### API-001 — Listar produtos

**Endpoint:** `GET /api/produtos`

**Resultado esperado:**

A API deve retornar status HTTP 200 e listar os produtos disponíveis.

**Resultado obtido:**

A API retornou status 200 e apresentou os 8 produtos cadastrados.

**Status:** Aprovado.

**Evidência:**

- `evidencias/api/API-001-listar-produtos-1.png`
- `evidencias/api/API-001-listar-produtos-2.png`

---

### API-002 — Consultar produto existente

**Endpoint:** `GET /api/produtos/P001`

**Resultado esperado:**

A API deve retornar status HTTP 200 e os dados do produto `P001`.

**Resultado obtido:**

A API retornou corretamente o produto `P001 — Camiseta Essencial`, com preço de R$ 59,90.

**Status:** Aprovado.

**Evidência:**

- `evidencias/api/API-002-produto-existente.png`

---

### API-003 — Consultar produto inexistente

**Endpoint:** `GET /api/produtos/P999`

**Resultado esperado:**

A API deve retornar erro informando que o produto não foi encontrado.

**Resultado obtido:**

A API retornou o erro `PRODUTO_NAO_ENCONTRADO` com a mensagem `Produto P999 não encontrado.`.

**Status:** Aprovado.

**Evidência:**

- `evidencias/api/API-003-produto-inexistente.png`

---

### API-004 — Calcular carrinho válido

**Endpoint:** `POST /api/carrinho/calcular`

**Dados utilizados:**

- P002 — quantidade 1
- P004 — quantidade 2

**Resultado esperado:**

A API deve calcular corretamente subtotal, desconto, frete e total.

**Resultado obtido:**

- Subtotal: R$ 239,70
- Desconto: R$ 0,00
- Frete: R$ 0,00
- Frete grátis: `true`
- Total: R$ 239,70

**Status:** Aprovado.

**Evidência:**

- `evidencias/api/API-004-carrinho-valido.png`

---

### API-005 — Calcular carrinho com cupom válido

**Endpoint:** `POST /api/carrinho/calcular`

**Cupom:** `BEMVINDO10`

**Resultado esperado:**

A API deve aplicar 10% de desconto sobre o subtotal.

**Resultado obtido:**

- Subtotal: R$ 239,70
- Desconto: R$ 23,97
- Frete: R$ 0,00
- Frete grátis: `true`
- Total: R$ 215,73
- Cupom aplicado: `true`

**Status:** Aprovado.

**Evidência:**

- `evidencias/api/API-005-cupom-valido.png`

---

### API-006 — Calcular carrinho com cupom inexistente

**Endpoint:** `POST /api/carrinho/calcular`

**Cupom:** `TESTE123`

**Resultado esperado:**

A API deve retornar a operação com o cupom não aplicado e informar `Cupom inválido.`.

**Resultado obtido:**

A API retornou:

- Subtotal: R$ 239,70
- Desconto: R$ 0,00
- Frete: R$ 0,00
- Total: R$ 239,70
- Cupom aplicado: `false`
- Mensagem: `Cupom inválido.`

**Status:** Aprovado.

**Evidência:**

- `evidencias/api/API-006-cupom-invalido.png`

---

### API-007 — Calcular carrinho com cupom expirado

**Endpoint:** `POST /api/carrinho/calcular`

**Cupom:** `VERAO2026`

**Resultado esperado:**

A API deve manter o cupom não aplicado e informar que o cupom está expirado.

**Resultado obtido:**

A API retornou:

- Subtotal: R$ 239,70
- Desconto: R$ 0,00
- Frete: R$ 0,00
- Total: R$ 239,70
- Cupom aplicado: `false`
- Mensagem: `Cupom expirado.`

**Status:** Aprovado.

**Evidência:**

- `evidencias/api/API-007-cupom-expirado.png`

---

### API-008 — Frete grátis para subtotal exatamente igual a R$ 200,00

**Endpoint:** `POST /api/carrinho/calcular`

**Dados utilizados:**

- P005 — Mochila Urbana 20L
- Quantidade: 2
- Subtotal esperado: R$ 200,00

**Resultado esperado:**

Para subtotal maior ou igual a R$ 200,00, a API deve retornar frete grátis.

**Resultado obtido:**

A API retornou:

- Subtotal: R$ 200,00
- Desconto: R$ 0,00
- Frete: R$ 19,90
- Frete grátis: `false`
- Total: R$ 219,90

O comportamento reproduz o BUG-001 identificado durante os testes manuais.

**Status:** Reprovado — BUG-001.

**Evidência:**

- `evidencias/api/API-008-frete-r200-bug-001.png`

---

### API-009 — Frete para subtotal abaixo de R$ 200,00

**Endpoint:** `POST /api/carrinho/calcular`

**Dados utilizados:**

- P005 — Mochila Urbana 20L
- Quantidade: 1
- Subtotal: R$ 100,00

**Resultado esperado:**

A API deve cobrar R$ 19,90 de frete e informar o valor faltante para frete grátis.

**Resultado obtido:**

- Subtotal: R$ 100,00
- Frete: R$ 19,90
- Frete grátis: `false`
- Valor faltante para frete grátis: R$ 100,00
- Total: R$ 119,90

**Status:** Aprovado.

**Evidência:**

- `evidencias/api/API-009-frete-abaixo-r200.png`

---

### API-010 — Permitir 5 unidades do mesmo produto

**Endpoint:** `POST /api/carrinho/calcular`

**Dados utilizados:**

- P005 — Mochila Urbana 20L
- Quantidade: 5

**Resultado esperado:**

A API deve aceitar até 5 unidades do mesmo produto.

**Resultado obtido:**

A API aceitou 5 unidades e retornou:

- Subtotal: R$ 500,00
- Frete: R$ 0,00
- Frete grátis: `true`
- Total: R$ 500,00

**Status:** Aprovado.

**Evidência:**

- `evidencias/api/API-010-5-unidades.png`

---

### API-011 — Rejeitar quantidade superior a 5 unidades

**Endpoint:** `POST /api/carrinho/calcular`

**Dados utilizados:**

- P005 — Mochila Urbana 20L
- Quantidade: 6

**Resultado esperado:**

A API deve rejeitar a quantidade superior ao limite de 5 unidades e retornar o erro `QUANTIDADE_MAXIMA_EXCEDIDA`.

**Resultado obtido:**

A API aceitou 6 unidades e calculou normalmente:

- Quantidade: 6
- Subtotal: R$ 600,00
- Frete: R$ 0,00
- Frete grátis: `true`
- Total: R$ 600,00

Nenhum erro relacionado à quantidade máxima foi retornado.

**Status:** Reprovado — BUG-002.

**Evidência:**

- `evidencias/api/API-011-6-unidades-bug-002.png`

---

### API-012 — Criar pedido válido

**Endpoint:** `POST /api/pedidos`

**Dados utilizados:**

- P001 — Camiseta Essencial
- Quantidade: 1
- Nome: Sofia Katzender
- E-mail: sofia@example.com
- CEP: 11600-000

**Resultado esperado:**

A API deve criar o pedido e retornar status HTTP 201 com o número do pedido.

**Resultado obtido:**

O pedido foi criado com sucesso e a API retornou o número `VZ-818016`.

Valores retornados:

- Subtotal: R$ 59,90
- Frete: R$ 19,90
- Total: R$ 79,80
- CEP normalizado: `11600000`

**Status:** Aprovado.

**Evidência:**

- `evidencias/api/API-012-pedido-valido.png`

---

### API-013 — Criar pedido com cupom inexistente

**Endpoint:** `POST /api/pedidos`

**Cupom:** `TESTE123`

**Resultado esperado:**

A API deve rejeitar o pedido e retornar o erro `CUPOM_INVALIDO`.

**Resultado obtido:**

A API retornou:

- Código: `CUPOM_INVALIDO`
- Mensagem: `Cupom inválido.`
- Campo: `cupom`

**Status:** Aprovado.

**Evidência:**

- `evidencias/api/API-013-pedido-cupom-invalido.png`

---

### API-014 — Criar pedido com cupom expirado

**Endpoint:** `POST /api/pedidos`

**Cupom:** `VERAO2026`

**Resultado esperado:**

A API deve rejeitar o pedido e retornar o erro `CUPOM_EXPIRADO`.

**Resultado obtido:**

A API retornou:

- Código: `CUPOM_EXPIRADO`
- Mensagem: `Cupom expirado.`
- Campo: `cupom`

**Status:** Aprovado.

**Evidência:**

- `evidencias/api/API-014-pedido-cupom-expirado.png`

---

# 4. Testes Exploratórios

Além dos cenários previamente definidos, foram realizados testes exploratórios com foco em comportamentos de fronteira, consistência dos cálculos, manipulação do carrinho, aplicação de cupons e validações.

Foram explorados os seguintes comportamentos:

- Alteração da quantidade de produtos.
- Remoção de produtos do carrinho.
- Carrinho vazio.
- Adição e remoção de produtos após aplicação de cupom.
- Aplicação e remoção de cupom.
- Tentativa de aplicar diferentes cupons.
- Aplicação de cupom em letras minúsculas.
- Aplicação de cupom com espaços no início e no fim.
- Utilização de cupom inexistente.
- Utilização de cupom expirado.
- Valores abaixo de R$ 200,00.
- Valor exatamente igual a R$ 200,00.
- Valores acima de R$ 200,00.
- Quantidades próximas ao limite de 5 unidades.
- Tentativa de ultrapassar o limite de 5 unidades.
- Conferência de subtotal, desconto, frete e total.
- Conferência dos arredondamentos monetários.
- Alteração do subtotal após aplicação de cupom.
- Comportamento da interface após mensagens de erro.
- Validações de nome, e-mail e CEP.
- Tentativas de confirmação do pedido com campos obrigatórios inválidos ou incompletos.
- Comparação dos comportamentos observados na interface com os resultados retornados pela API.

Os comportamentos divergentes das regras de negócio foram registrados como bugs e documentados com suas respectivas evidências.

---

# 5. Ambiguidades e interpretações

Durante a análise da documentação e execução dos testes, algumas regras foram interpretadas conforme os critérios de aceite e comportamentos descritos na documentação.

### Aplicação de múltiplos cupons

A documentação estabelece que apenas um cupom pode estar aplicado por vez.

A interpretação adotada foi que, para utilizar outro cupom, o cupom atualmente aplicado deve ser removido primeiro.

Essa interpretação foi validada no CT006.

### Frete grátis e aplicação de cupom

A regra de frete grátis considera o subtotal antes da aplicação do desconto do cupom.

Dessa forma, um pedido que atinja R$ 200,00 de subtotal deve permanecer elegível ao frete grátis mesmo após a aplicação de um desconto.

Essa regra foi validada no CT009 e também considerada na análise do CT007.

### Limite de quantidade por produto

A documentação estabelece o limite máximo de 5 unidades do mesmo produto.

Foi considerado que essa regra deve ser aplicada tanto pela interface quanto pela API.

Na interface, a regra foi respeitada no CT011.

Na API, a regra apresentou divergência no API-011, resultando no BUG-002.

### Pedidos pela API

Foi considerado que a API deve respeitar as mesmas regras de negócio descritas na documentação, inclusive validações de cupom, frete e quantidade máxima.

---

# 6. Resumo da execução manual

| Cenário | Descrição | Status |
|---|---|---|
| CT001 | Cupom válido | Aprovado |
| CT002 | Cupom em letras minúsculas | Aprovado |
| CT003 | Cupom com espaços | Aprovado |
| CT004 | Cupom inexistente | Aprovado |
| CT005 | Cupom expirado | Aprovado |
| CT006 | Apenas um cupom por vez | Aprovado |
| CT007 | Frete grátis a partir de R$ 200,00 | **Reprovado — BUG-001** |
| CT008 | Frete abaixo de R$ 200,00 | Aprovado |
| CT009 | Frete considerando subtotal antes do desconto | Aprovado |
| CT010 | Desconto não aplicado sobre frete | Aprovado |
| CT011 | Limite de 5 unidades | Aprovado |
| CT012 | Cálculo do subtotal | Aprovado |
| CT013 | Cálculo do total | Aprovado |
| CT014 | Validação do nome | Aprovado |
| CT015 | Validação do e-mail | Aprovado |
| CT016 | Validação do CEP | Aprovado |

**Resultado:** 15 cenários aprovados e 1 cenário reprovado.

---

# 7. Resumo da execução da API

Foram executados 14 cenários de API.

| Cenário | Descrição | Status |
|---|---|---|
| API-001 | Listar produtos | Aprovado |
| API-002 | Consultar produto existente | Aprovado |
| API-003 | Consultar produto inexistente | Aprovado |
| API-004 | Calcular carrinho válido | Aprovado |
| API-005 | Calcular com cupom válido | Aprovado |
| API-006 | Calcular com cupom inexistente | Aprovado |
| API-007 | Calcular com cupom expirado | Aprovado |
| API-008 | Frete para subtotal de R$ 200,00 | **Reprovado — BUG-001** |
| API-009 | Frete abaixo de R$ 200,00 | Aprovado |
| API-010 | Quantidade de 5 unidades | Aprovado |
| API-011 | Quantidade de 6 unidades | **Reprovado — BUG-002** |
| API-012 | Criar pedido válido | Aprovado |
| API-013 | Pedido com cupom inexistente | Aprovado |
| API-014 | Pedido com cupom expirado | Aprovado |

**Resultado:** 12 cenários aprovados e 2 cenários reprovados.

---

# 8. Resultado geral

### Testes manuais

- 16 cenários executados
- 15 aprovados
- 1 reprovado
- Taxa de aprovação: **93,75%**

### Testes de API

- 14 cenários executados
- 12 aprovados
- 2 reprovados

### Bugs identificados

- **BUG-001:** Frete grátis não aplicado para subtotal exatamente igual a R$ 200,00.
- **BUG-002:** API permite quantidade superior ao limite de 5 unidades.

O API-008 reproduziu o BUG-001 já identificado durante os testes manuais, portanto não representa um terceiro bug.

A execução dos testes demonstrou que a maior parte das regras de negócio está sendo respeitada, porém foram identificadas duas divergências relevantes: a regra de frete grátis no limite exato de R$ 200,00 e a ausência de validação do limite máximo de unidades na API.