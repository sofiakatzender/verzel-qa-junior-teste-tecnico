# Automação de Testes — Verzel Store

Automação de testes funcionais desenvolvida como parte do teste técnico para a vaga de QA Junior da Verzel.

Os testes foram implementados utilizando Playwright e foram selecionados a partir dos cenários executados durante os testes manuais da aplicação.

## Tecnologias

- Playwright
- JavaScript
- Node.js
- Chromium

## Cenários automatizados

### CT001 — Aplicar cupom válido

Valida a aplicação do cupom `BEMVINDO10` e verifica se o desconto de R$ 5,99 é aplicado corretamente.

**Resultado:** PASSOU

### CT004 — Aplicar cupom inexistente

Valida a aplicação de um cupom inexistente (`TESTE123`), verificando a mensagem `Cupom inválido.` e a ausência de desconto.

**Resultado:** PASSOU

### CT007 — Frete grátis para subtotal de R$ 200,00

Adiciona 2 unidades da Mochila Urbana 20L, totalizando exatamente R$ 200,00, e verifica se o frete grátis é aplicado.

**Resultado:** FALHOU — BUG-001

O teste identificou que, para um subtotal exatamente igual a R$ 200,00, o sistema continua cobrando R$ 19,90 de frete.

A reprovação é intencional, pois o teste automatizado foi desenvolvido para validar a regra de negócio e identificar o BUG-001 encontrado durante os testes manuais.

## Como executar

### Instalar as dependências

Dentro da pasta `automacao`:

```bash
npm install
```

### Instalar os navegadores do Playwright

```bash
npx playwright install
```

### Executar todos os testes

```bash
npm test
```

Também é possível executar diretamente:

```bash
npx playwright test
```

### Executar um teste específico

```bash
npx playwright test tests/cupom.spec.js
```

### Abrir o relatório

Após a execução dos testes:

```bash
npx playwright show-report
```

## Resultado da execução

| Teste | Resultado |
|---|---|
| CT001 — Cupom válido | PASSOU |
| CT004 — Cupom inexistente | PASSOU |
| CT007 — Frete grátis R$ 200,00 | FALHOU — BUG-001 |

**Total: 2 testes aprovados e 1 teste reprovado.**

O CT007 permanece reprovado propositalmente, pois a automação foi criada para identificar o BUG-001 encontrado durante os testes manuais.

## Evidências

As evidências da execução automatizada estão disponíveis no diretório:

```text
evidencias/automacao/
```

Para o CT007, foram geradas as seguintes evidências:

- `CT007-automacao-bug-001.png`
- `CT007-automacao-bug-002.png`

As evidências demonstram a execução do teste automatizado e a reprodução do comportamento relacionado ao BUG-001.

## Estrutura

```text
automacao/
├── tests/
│   ├── cupom.spec.js
│   ├── cupom-invalido.spec.js
│   └── frete.spec.js
├── playwright.config.js
├── package.json
└── README.md
```