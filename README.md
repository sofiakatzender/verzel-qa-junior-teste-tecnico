# Teste Técnico QA Junior — Verzel Store

## Sobre o projeto

Este repositório apresenta a execução do **teste técnico para a vaga de QA Junior da Verzel**, realizado sobre a aplicação **Verzel Store**.

O objetivo foi validar as principais regras de negócio da aplicação por meio de **testes funcionais manuais, testes exploratórios e automação com Playwright**, registrando os resultados, evidências e defeitos encontrados durante a execução.

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

---

## Resultado dos testes

Foram executados **16 cenários de teste manuais**.

| Resultado | Quantidade |
|---|---:|
| Aprovados | 15 |
| Reprovados | 1 |
| Bugs identificados | 1 |

**Taxa de aprovação: 93,75%**

O único cenário reprovado foi o **CT007**, relacionado à regra de frete grátis para um subtotal exatamente igual a **R$ 200,00**.

O defeito foi registrado como **BUG-001**.

---

## Bug identificado

### BUG-001 — Frete grátis não aplicado para subtotal de R$ 200,00

De acordo com a regra de negócio, pedidos com subtotal **maior ou igual a R$ 200,00** devem possuir frete grátis.

Durante a execução, um carrinho com subtotal exatamente igual a **R$ 200,00** continuou apresentando frete de **R$ 19,90**.

O comportamento foi reproduzido manualmente e também identificado pela automação com Playwright.

**Severidade:** Média  
**Prioridade:** Alta  
**Status:** Aberto

O detalhamento completo está disponível em [`bugs/bugs.md`](bugs/bugs.md).

---

## Automação

Foram automatizados 3 cenários utilizando **Playwright**:

| Cenário | Resultado |
|---|---|
| CT001 — Aplicar cupom válido | PASSOU |
| CT004 — Aplicar cupom inexistente | PASSOU |
| CT007 — Frete grátis para subtotal de R$ 200,00 | FALHOU — BUG-001 |

O **CT007 falhou propositalmente**, pois a automação foi criada para validar a regra de frete grátis para subtotal de R$ 200,00. Como a aplicação apresentou o comportamento incorreto identificado no **BUG-001**, o teste automatizado falhou, confirmando a existência do defeito.

Os outros dois cenários automatizados foram executados com sucesso.

A documentação da automação está disponível em [`automacao/README.md`](automacao/README.md).

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
│   ├── login/
│   ├── carrinho/
│   ├── checkout/
│   ├── cupom/
│   └── frete/
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
| [`execucao/resultados.md`](execucao/resultados.md) | Resultados e evidências da execução |
| [`bugs/bugs.md`](bugs/bugs.md) | Registro e detalhamento dos bugs encontrados |
| [`automacao/README.md`](automacao/README.md) | Documentação dos testes automatizados |

As evidências dos testes estão organizadas no diretório `evidencias/`, separadas por funcionalidade.

---

## Conclusão

A execução apresentou **93,75% de aprovação**, com 15 dos 16 cenários manuais aprovados.

O principal ponto identificado foi uma inconsistência na regra de **frete grátis para o subtotal de R$ 200,00**, registrada como **BUG-001**.

Além dos testes manuais, o comportamento foi reproduzido por meio de automação com Playwright. A falha do **CT007** confirmou que o defeito identificado manualmente também pode ser detectado automaticamente.

O projeto demonstra a aplicação de um fluxo de QA envolvendo **planejamento, execução, registro de evidências, identificação de defeitos e automação de testes**.