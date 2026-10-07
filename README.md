# Teste Técnico QA Junior — Verzel Store

## Sobre o projeto

Este repositório apresenta a execução do **teste técnico para a vaga de QA Junior da Verzel**, realizado sobre a aplicação **Verzel Store**.

O objetivo foi validar as principais regras de negócio da aplicação por meio de **testes funcionais manuais, testes exploratórios, testes de API e automação com Playwright**, registrando os resultados, evidências e defeitos encontrados durante a execução.

---

## Escopo

Durante a execução foram avaliados:

- Aplicação e validação de cupons de desconto.
- Cupons válidos, inválidos e expirados.
- Tratamento de letras maiúsculas/minúsculas e espaços.
- Restrição de apenas um cupom por vez.
- Regra de frete grátis a partir de R$ 200,00.
- Cálculo do frete abaixo do limite de gratuidade.
- Aplicação do frete considerando o subtotal antes do desconto.
- Aplicação do desconto somente sobre o subtotal.
- Limite máximo de 5 unidades por produto.
- Cálculo do subtotal e valor total.
- Validação de nome, e-mail e CEP no checkout.
- Consulta de produtos por API.
- Cálculo de carrinho por API.
- Validação de cupons por API.
- Criação de pedidos por API.
- Validação das regras de negócio diretamente na API.

---

## Resultado dos testes

### Testes manuais

Foram executados **16 cenários de teste manuais**.

| Resultado | Quantidade |
|---|---:|
| Aprovados | 15 |
| Reprovados | 1 |
| Bugs identificados | 1 |

**Taxa de aprovação: 93,75%**

O único cenário manual reprovado foi o **CT007**, relacionado à regra de frete grátis para um subtotal exatamente igual a **R$ 200,00**.

O defeito foi registrado como **BUG-001**.

### Testes de API

Foram executados **14 cenários de teste diretamente na API**.

| Resultado | Quantidade |
|---|---:|
| Aprovados | 12 |
| Reprovados | 2 |
| Bugs distintos identificados | 1 |

Os cenários reprovados foram:

- **API-008** — reproduziu o BUG-001.
- **API-011** — identificou o BUG-002.

O API-008 não representa um novo bug, pois reproduz o mesmo comportamento encontrado no CT007.

### Automação

Foram automatizados **3 cenários utilizando Playwright**.

| Cenário | Resultado |
|---|---|
| CT001 — Aplicar cupom válido | PASSOU |
| CT004 — Aplicar cupom inexistente | PASSOU |
| CT007 — Frete grátis para subtotal de R$ 200,00 | FALHOU — BUG-001 |

O **CT007 falhou propositalmente**, pois a automação foi criada para validar a regra de frete grátis para subtotal de R$ 200,00. Como a aplicação apresentou o comportamento incorreto identificado no **BUG-001**, o teste automatizado falhou, confirmando a existência do defeito.

---

## Bugs identificados

### BUG-001 — Frete grátis não aplicado para subtotal de R$ 200,00

De acordo com a regra de negócio, pedidos com subtotal **maior ou igual a R$ 200,00** devem possuir frete grátis.

Durante a execução, um carrinho com subtotal exatamente igual a **R$ 200,00** continuou apresentando frete de **R$ 19,90**.

O comportamento foi:

- identificado no teste manual **CT007**;
- reproduzido pela API no **API-008**;
- reproduzido pela automação com Playwright no **CT007**.

**Severidade:** Média  
**Prioridade:** Alta  
**Status:** Aberto

O detalhamento completo está disponível em [`bugs/bugs.md`](bugs/bugs.md).

### BUG-002 — API permite quantidade superior ao limite de 5 unidades

A regra de negócio estabelece limite máximo de **5 unidades do mesmo produto**.

Durante o teste **API-011**, a API aceitou **6 unidades da Mochila Urbana 20L**, calculando normalmente o carrinho em vez de retornar o erro `QUANTIDADE_MAXIMA_EXCEDIDA`.

O comportamento foi identificado exclusivamente na API, enquanto a interface manualmente testada respeitou o limite de 5 unidades.

**Severidade:** Média  
**Prioridade:** Alta  
**Status:** Aberto

O detalhamento completo está disponível em [`bugs/bugs.md`](bugs/bugs.md).

---

## Automação

A automação foi desenvolvida utilizando **Playwright**, com execução em **Chromium**.

Os cenários automatizados foram selecionados a partir dos testes funcionais realizados manualmente.

Os testes automatizados são:

- **CT001** — Aplicar cupom válido.
- **CT004** — Aplicar cupom inexistente.
- **CT007** — Validar frete grátis para subtotal de R$ 200,00.

O CT007 permanece reprovado propositalmente para reproduzir o **BUG-001**.

A documentação completa da automação está disponível em [`automacao/README.md`](automacao/README.md).

As evidências da execução automatizada estão disponíveis em:

```text
evidencias/automacao/
├── CT007-automacao-bug-001-001.png
└── CT007-automacao-bug-001-002.png
```

---

## Estrutura do projeto

```text
verzel-qa-junior-teste-tecnico/
│
├── README.md
│
├── cenarios/
│   └── cenarios.md
│
├── execucao/
│   └── resultados.md
│
├── bugs/
│   └── bugs.md
│
├── evidencias/
│   ├── api/
│   ├── automacao/
│   ├── frete/
│   ├── carrinho/
│   ├── checkout/
│   └── cupom/
│
└── automacao/
    ├── tests/
    │   ├── cupom.spec.js
    │   ├── cupom-invalido.spec.js
    │   └── frete.spec.js
    ├── playwright.config.js
    ├── package.json
    └── README.md
```

---

## Tecnologias

- **JavaScript**
- **Node.js**
- **Playwright**
- **Chromium**
- **Markdown**
- **Git / GitHub**

---

## Documentação

| Documento | Descrição |
|---|---|
| [`cenarios/cenarios.md`](cenarios/cenarios.md) | Cenários e casos de teste executados |
| [`execucao/resultados.md`](execucao/resultados.md) | Resultados, evidências e detalhes da execução |
| [`bugs/bugs.md`](bugs/bugs.md) | Registro e detalhamento dos bugs encontrados |
| [`automacao/README.md`](automacao/README.md) | Documentação dos testes automatizados |

As evidências dos testes estão organizadas no diretório `evidencias/`, separadas por tipo de teste e funcionalidade.

---

## Conclusão

A execução dos testes demonstrou que a maior parte das regras de negócio avaliadas está sendo respeitada.

Nos testes manuais, foram aprovados **15 dos 16 cenários**, resultando em uma taxa de aprovação de **93,75%**.

Nos testes de API, foram aprovados **12 dos 14 cenários**.

Na automação com Playwright, foram aprovados **2 dos 3 cenários automatizados**, sendo o CT007 reprovado propositalmente por reproduzir o BUG-001.

Foram identificados **2 bugs distintos**:

1. **BUG-001:** frete grátis não aplicado quando o subtotal é exatamente R$ 200,00.
2. **BUG-002:** API permite quantidade superior ao limite de 5 unidades por produto.

O **API-008 e a automação do CT007 não representam novos bugs**, pois reproduzem o BUG-001 já identificado no teste manual CT007.

O projeto demonstra a aplicação de um fluxo de QA envolvendo **planejamento, execução de testes manuais e de API, registro de evidências, identificação e documentação de defeitos e automação de testes**.