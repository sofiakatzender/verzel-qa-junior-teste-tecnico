# Resultados da Execução — Verzel Store

## 1. Resumo

Foram executados **16 cenários de teste funcionais manuais** e **14 cenários de teste de API**, contemplando as principais regras de negócio da Verzel Store.

A execução foi realizada com base nos critérios de aceite, regras de negócio e dados descritos na documentação da versão 2.3.0.

### Resultado dos testes manuais

- **15 cenários aprovados**
- **1 cenário reprovado**
- **BUG-001 identificado**

### Resultado dos testes de API

- **12 cenários aprovados**
- **2 cenários reprovados**
- **BUG-001 reproduzido**
- **BUG-002 identificado**

O BUG-001 foi identificado inicialmente no teste manual CT007 e posteriormente reproduzido por meio do teste API-008 e da automação do CT007.

---

## 2. Ambiente de Teste

| Informação | Detalhe |
|---|---|
| Aplicação | Verzel Store |
| Versão da documentação | 2.3.0 |
| Sistema operacional | Windows 11 |
| Navegador | Microsoft Edge |
| Data da execução | 06/10/2026 |
| Tipos de execução | Testes manuais, exploratórios, API e automação com Playwright |

---

## 3. Resultado dos testes manuais

| Cenário | Descrição | Status |
|---|---|---|
| CT001 | Aplicar cupom válido | Aprovado |
| CT002 | Aplicar cupom com letras minúsculas | Aprovado |
| CT003 | Aplicar cupom com espaços | Aprovado |
| CT004 | Aplicar cupom inexistente | Aprovado |
| CT005 | Aplicar cupom expirado | Aprovado |
| CT006 | Permitir apenas um cupom por vez | Aprovado |
| CT007 | Frete grátis a partir de R$ 200,00 | **Reprovado — BUG-001** |
| CT008 | Cobrar frete abaixo de R$ 200,00 | Aprovado |
| CT009 | Frete grátis considerando subtotal antes do desconto | Aprovado |
| CT010 | Desconto não aplicado sobre o frete | Aprovado |
| CT011 | Limite máximo de 5 unidades por produto | Aprovado |
| CT012 | Cálculo do subtotal | Aprovado |
| CT013 | Cálculo do total com cupom e frete | Aprovado |
| CT014 | Validação do nome do cliente | Aprovado |
| CT015 | Validação do e-mail | Aprovado |
| CT016 | Validação do CEP | Aprovado |

**Resultado:** 15 cenários aprovados e 1 cenário reprovado.

---

## 4. Cenário manual reprovado

### CT007 — Frete grátis a partir de R$ 200,00

**Resultado esperado:**

Para um subtotal de exatamente R$ 200,00, o sistema deve aplicar frete grátis.

**Resultado obtido:**

Com 2 unidades da Mochila Urbana 20L, o subtotal ficou em R$ 200,00.

O sistema cobrou **R$ 19,90 de frete**, apesar de a regra de negócio determinar frete grátis para valores maiores ou iguais a R$ 200,00.

Após a aplicação do cupom `BEMVINDO10`, o sistema aplicou corretamente o desconto de R$ 20,00, porém manteve o frete em R$ 19,90.

A aplicação também apresentou a mensagem:

`Faltam R$ 0,00 para o frete grátis.`

**Status:** Reprovado.

**Bug relacionado:** BUG-001.

**Evidências do teste manual:**

- `evidencias/frete/CT007-R200-sem-cupom.png`
- `evidencias/frete/CT007-R200-com-cupom.png`

---

# 5. Resultado dos testes de API

Foram executados **14 cenários de teste diretamente na API** disponibilizada pela Verzel Store.

| Cenário | Descrição | Status |
|---|---|---|
| API-001 | Listar produtos | Aprovado |
| API-002 | Consultar produto existente | Aprovado |
| API-003 | Consultar produto inexistente | Aprovado |
| API-004 | Calcular carrinho válido | Aprovado |
| API-005 | Calcular carrinho com cupom válido | Aprovado |
| API-006 | Calcular carrinho com cupom inexistente | Aprovado |
| API-007 | Calcular carrinho com cupom expirado | Aprovado |
| API-008 | Frete para subtotal de R$ 200,00 | **Reprovado — BUG-001** |
| API-009 | Frete abaixo de R$ 200,00 | Aprovado |
| API-010 | Quantidade de 5 unidades | Aprovado |
| API-011 | Quantidade de 6 unidades | **Reprovado — BUG-002** |
| API-012 | Criar pedido válido | Aprovado |
| API-013 | Pedido com cupom inexistente | Aprovado |
| API-014 | Pedido com cupom expirado | Aprovado |

**Resultado:** 12 cenários aprovados e 2 cenários reprovados.

---

# 6. Detalhamento dos testes de API

### API-001 — Listar produtos

**Endpoint:** `GET /api/produtos`

**Resultado esperado:**

Retornar status HTTP 200 e listar os produtos disponíveis.

**Resultado obtido:**

A API retornou status 200 e apresentou os 8 produtos cadastrados.

**Status:** Aprovado.

**Evidências:**

- `evidencias/api/API-001-listar-produtos-1.png`
- `evidencias/api/API-001-listar-produtos-2.png`

---

### API-002 — Consultar produto existente

**Endpoint:** `GET /api/produtos/P001`

**Resultado esperado:**

Retornar status HTTP 200 e os dados do produto `P001`.

**Resultado obtido:**

A API retornou corretamente o produto `P001 — Camiseta Essencial`, com preço de R$ 59,90.

**Status:** Aprovado.

**Evidência:**

- `evidencias/api/API-002-produto-existente.png`

---

### API-003 — Consultar produto inexistente

**Endpoint:** `GET /api/produtos/P999`

**Resultado esperado:**

Retornar erro informando que o produto não foi encontrado.

**Resultado obtido:**

A API retornou o código `PRODUTO_NAO_ENCONTRADO` com a mensagem `Produto P999 não encontrado.`.

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

Calcular corretamente subtotal, desconto, frete e total.

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

Aplicar 10% de desconto sobre o subtotal.

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

O cupom não deve ser aplicado e a API deve informar `Cupom inválido.`.

**Resultado obtido:**

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

O cupom não deve ser aplicado e a API deve informar que está expirado.

**Resultado obtido:**

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
- Subtotal: R$ 200,00

**Resultado esperado:**

Para subtotal maior ou igual a R$ 200,00, a API deve retornar frete grátis.

**Resultado obtido:**

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

Cobrar R$ 19,90 de frete e informar o valor faltante para frete grátis.

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

A API deve rejeitar a quantidade superior ao limite de 5 unidades e retornar `QUANTIDADE_MAXIMA_EXCEDIDA`.

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

**Resultado esperado:**

Criar o pedido e retornar status HTTP 201 com o número do pedido.

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

Rejeitar o pedido e retornar o código `CUPOM_INVALIDO`.

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

Rejeitar o pedido e retornar o código `CUPOM_EXPIRADO`.

**Resultado obtido:**

A API retornou:

- Código: `CUPOM_EXPIRADO`
- Mensagem: `Cupom expirado.`
- Campo: `cupom`

**Status:** Aprovado.

**Evidência:**

- `evidencias/api/API-014-pedido-cupom-expirado.png`

---

# 7. Resultado dos testes automatizados

Foram automatizados 3 cenários funcionais utilizando **Playwright**:

| Cenário | Descrição | Status |
|---|---|---|
| CT001 | Aplicar cupom válido | Aprovado |
| CT004 | Aplicar cupom inexistente | Aprovado |
| CT007 | Frete grátis a partir de R$ 200,00 | **Reprovado — BUG-001** |

### CT001 — Cupom válido

A automação validou a aplicação do cupom `BEMVINDO10` e a apresentação do desconto esperado.

**Status:** Aprovado.

### CT004 — Cupom inexistente

A automação validou a apresentação da mensagem `Cupom inválido.` e a ausência de desconto.

**Status:** Aprovado.

### CT007 — Frete grátis a partir de R$ 200,00

A automação adicionou 2 unidades da Mochila Urbana 20L, totalizando R$ 200,00, e verificou se o sistema apresentaria frete grátis.

O teste falhou porque o sistema não apresentou o frete como grátis, reproduzindo o comportamento identificado no BUG-001.

**Status:** Reprovado — BUG-001.

**Evidências da automação:**

- `evidencias/automacao/CT007-automacao-bug-001.png`
- `evidencias/automacao/CT007-automacao-bug-002.png`

A reprovação do CT007 é **intencional**, pois o objetivo da automação é validar o comportamento esperado e identificar a ocorrência do BUG-001.

---

# 8. Evidências

As evidências dos testes executados estão organizadas nos seguintes diretórios:

```text
evidencias/
├── api/
├── automacao/
├── carrinho/
├── checkout/
├── cupom/
└── frete/
```

As evidências da API estão identificadas pelo código de cada cenário, de `API-001` a `API-014`.

As evidências dos testes manuais estão organizadas de acordo com as funcionalidades avaliadas.

As evidências da automação estão organizadas na pasta `automacao/` e contemplam a execução do CT007, responsável pela reprodução automatizada do BUG-001.

---

# 9. Bugs identificados

### BUG-001 — Frete grátis não aplicado para subtotal de R$ 200,00

Identificado inicialmente no **CT007**, reproduzido posteriormente no **API-008** e também na automação do CT007.

**Resultado:** Aberto.

**Evidências:**

- `evidencias/frete/CT007-R200-sem-cupom.png`
- `evidencias/frete/CT007-R200-com-cupom.png`
- `evidencias/api/API-008-frete-r200-bug-001.png`
- `evidencias/automacao/CT007-automacao-bug-001.png`
- `evidencias/automacao/CT007-automacao-bug-002.png`

### BUG-002 — API permite quantidade superior ao limite de 5 unidades

Identificado no **API-011**.

**Resultado:** Aberto.

**Evidência:**

- `evidencias/api/API-011-6-unidades-bug-002.png`

---

# 10. Conclusão

A execução dos testes demonstrou que a maior parte das regras de negócio avaliadas está sendo respeitada.

Nos testes manuais, foram aprovados **15 dos 16 cenários**, resultando em uma taxa de aprovação de **93,75%**.

Nos testes de API, foram aprovados **12 dos 14 cenários**.

Na automação com Playwright, foram aprovados **2 dos 3 cenários automatizados**, sendo o CT007 reprovado propositalmente por reproduzir o BUG-001.

Foram identificados **2 bugs distintos**:

1. **BUG-001:** frete grátis não aplicado quando o subtotal é exatamente R$ 200,00.
2. **BUG-002:** API permite quantidade superior ao limite de 5 unidades por produto.

O **API-008 e a automação do CT007 não representam novos bugs**, pois reproduzem o BUG-001 já identificado no teste manual CT007.

Os resultados, evidências, cenários automatizados e bugs encontrados foram documentados nos respectivos arquivos do projeto.