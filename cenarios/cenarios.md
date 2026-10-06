# Cenários de Teste — Verzel Store

## 1. Objetivo

Validar as principais funcionalidades da Verzel Store relacionadas à aplicação de cupons de desconto, cálculo de frete, cálculo de valores do pedido, limite de quantidade de produtos e validações do checkout.

Os testes foram elaborados com base nos critérios de aceite, regras de negócio e dados disponibilizados na documentação da versão 2.3.0 da aplicação.

A execução foi realizada de forma manual e exploratória, sendo posteriormente complementada por testes automatizados utilizando Playwright.

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

- `evidencias/cupom/CT003-cupom-espacos.png`

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

**Status:** Reprovado.

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

## 3. Testes Exploratórios

Após a execução dos cenários funcionais definidos, foram considerados testes exploratórios com foco em comportamentos de fronteira, consistência dos cálculos, manipulação do carrinho e tratamento de entradas inesperadas.

Os testes exploratórios tiveram como foco:

- Alteração da quantidade de produtos.
- Remoção de produtos do carrinho.
- Carrinho vazio.
- Adição e remoção de produtos após aplicação de cupom.
- Aplicação e remoção de cupom.
- Tentativas de aplicação de diferentes cupons.
- Valores próximos ao limite de R$ 200,00.
- Valores exatamente iguais ao limite de R$ 200,00.
- Valores acima do limite de R$ 200,00.
- Quantidades próximas ao limite de 5 unidades.
- Tentativa de ultrapassar o limite de 5 unidades.
- Valores monetários e arredondamentos.
- Alteração do subtotal após aplicação de cupom.
- Comportamento da interface após mensagens de erro.
- Consistência entre os valores apresentados no carrinho e os cálculos esperados.
- Comportamento do checkout após dados inválidos.
- Tentativas de confirmação do pedido com campos obrigatórios incompletos.

Os resultados dos testes exploratórios foram registrados conforme a execução. Quando identificados comportamentos inesperados ou violações de regras de negócio, foram registrados como bugs com evidências correspondentes.

---

## 4. Resumo da execução

| Cenário | Descrição | Status |
|---|---|---|
| CT001 | Cupom válido | Aprovado |
| CT002 | Cupom em letras minúsculas | Aprovado |
| CT003 | Cupom com espaços | Aprovado |
| CT004 | Cupom inexistente | Aprovado |
| CT005 | Cupom expirado | Aprovado |
| CT006 | Apenas um cupom por vez | Aprovado |
| CT007 | Frete grátis a partir de R$ 200,00 | **Reprovado** |
| CT008 | Frete abaixo de R$ 200,00 | Aprovado |
| CT009 | Frete considerando subtotal antes do desconto | Aprovado |
| CT010 | Desconto não aplicado sobre frete | Aprovado |
| CT011 | Limite de 5 unidades | Aprovado |
| CT012 | Cálculo do subtotal | Aprovado |
| CT013 | Cálculo do total | Aprovado |
| CT014 | Validação do nome | Aprovado |
| CT015 | Validação do e-mail | Aprovado |
| CT016 | Validação do CEP | Aprovado |

**Resultado geral:** 15 cenários aprovados e 1 cenário reprovado.

**Principal inconsistência identificada:** o sistema não aplica frete grátis quando o subtotal é exatamente R$ 200,00, contrariando o critério CA06.