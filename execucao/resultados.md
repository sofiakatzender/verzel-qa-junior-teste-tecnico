# Resultados da Execução — Verzel Store

## 1. Resumo

Foram executados **16 cenários de teste funcionais**, contemplando as principais regras de negócio da Verzel Store.

A execução foi realizada manualmente na aplicação, utilizando os critérios de aceite e regras descritos na documentação da versão 2.3.0.

### Resultado geral

- **15 cenários aprovados**
- **1 cenário reprovado**
- **1 bug identificado**

O cenário reprovado corresponde ao **CT007**, relacionado ao frete grátis para subtotal exatamente igual a R$ 200,00.

---

## 2. Ambiente de Teste

| Informação | Detalhe |
|---|---|
| Aplicação | Verzel Store |
| Versão da documentação | 2.3.0 |
| Sistema operacional | Windows 11 |
| Navegador | Microsoft Edge |
| Data da execução | 06/10/2026 |
| Tipo de execução | Testes manuais e exploratórios |

---

## 3. Resultado por cenário

| Cenário | Descrição | Status |
|---|---|---|
| CT001 | Aplicar cupom válido | Aprovado |
| CT002 | Aplicar cupom com letras minúsculas | Aprovado |
| CT003 | Aplicar cupom com espaços | Aprovado |
| CT004 | Aplicar cupom inexistente | Aprovado |
| CT005 | Aplicar cupom expirado | Aprovado |
| CT006 | Permitir apenas um cupom por vez | Aprovado |
| CT007 | Frete grátis a partir de R$ 200,00 | Reprovado |
| CT008 | Cobrar frete abaixo de R$ 200,00 | Aprovado |
| CT009 | Frete grátis considerando subtotal antes do desconto | Aprovado |
| CT010 | Desconto não aplicado sobre o frete | Aprovado |
| CT011 | Limite máximo de 5 unidades por produto | Aprovado |
| CT012 | Cálculo do subtotal | Aprovado |
| CT013 | Cálculo do total com cupom e frete | Aprovado |
| CT014 | Validação do nome do cliente | Aprovado |
| CT015 | Validação do e-mail | Aprovado |
| CT016 | Validação do CEP | Aprovado |

---

## 4. Cenário reprovado

### CT007 — Frete grátis a partir de R$ 200,00

**Resultado esperado:**

Para um subtotal de exatamente R$ 200,00, o sistema deve aplicar frete grátis.

**Resultado obtido:**

Com 2 unidades da Mochila Urbana 20L, o subtotal ficou em R$ 200,00.

O sistema cobrou **R$ 19,90 de frete**, apesar de a regra de negócio determinar frete grátis para valores **maiores ou iguais a R$ 200,00**.

Após a aplicação do cupom `BEMVINDO10`, o sistema aplicou corretamente o desconto de R$ 20,00, porém manteve o frete em R$ 19,90.

A aplicação também apresentou a mensagem:

`Faltam R$ 0,00 para o frete grátis.`

**Status:** Reprovado.

**Bug relacionado:** BUG-001.

**Evidências:**

- `evidencias/frete/CT007-R200-sem-cupom.png`
- `evidencias/frete/CT007-R200-com-cupom.png`

---

## 5. Cenários aprovados

Os demais cenários apresentaram comportamento de acordo com os critérios de aceite avaliados.

Foram validados:

- Aplicação de cupom válido.
- Aplicação de cupom sem diferenciação entre letras maiúsculas e minúsculas.
- Tratamento de espaços no código do cupom.
- Tratamento de cupom inexistente.
- Tratamento de cupom expirado.
- Restrição de apenas um cupom por vez.
- Cobrança de frete abaixo de R$ 200,00.
- Consideração do subtotal antes do desconto para cálculo do frete.
- Não aplicação de desconto sobre o valor do frete.
- Limite de 5 unidades por produto.
- Cálculo do subtotal.
- Cálculo do total do pedido.
- Validação do nome completo.
- Validação do formato do e-mail.
- Validação do CEP.

---

## 6. Evidências

As evidências dos testes executados estão organizadas no diretório:

```text
evidencias/
├── login/
├── carrinho/
├── checkout/
├── cupom/
└── frete/
```

Cada evidência possui identificação correspondente ao cenário de teste executado.

---

## 7. Conclusão

A execução apresentou **15 cenários aprovados de um total de 16**, correspondendo a um índice de aprovação de **93,75%**.

O único cenário reprovado foi o **CT007**, que identificou uma inconsistência na regra de frete grátis para o limite exato de R$ 200,00.

O comportamento observado foi registrado como **BUG-001**, com evidências anexadas e detalhamento no arquivo de bugs.

Além da inconsistência identificada, os demais comportamentos avaliados apresentaram resultados compatíveis com os critérios de aceite e regras de negócio analisados.