# Registro de Bugs — Verzel Store

## BUG-001 — Frete grátis não aplicado para subtotal de R$ 200,00

**Status:** Aberto  
**Severidade:** Média  
**Prioridade:** Alta  
**Cenário relacionado:** CT007 — Frete grátis a partir de R$ 200,00  
**Critério de aceite:** CA06

### Descrição

O sistema não aplica frete grátis quando o subtotal do carrinho é exatamente igual a R$ 200,00.

De acordo com o critério CA06, o frete deve ser grátis para pedidos com subtotal **maior ou igual a R$ 200,00**.

### Pré-condições

- Acessar a Verzel Store.
- Possuir a Mochila Urbana 20L disponível.
- Carrinho inicialmente vazio.

### Passos para reprodução

1. Adicionar 2 unidades da Mochila Urbana 20L ao carrinho.
2. Acessar o carrinho.
3. Verificar o subtotal de R$ 200,00.
4. Verificar o valor do frete.

### Resultado esperado

O sistema deve aplicar **frete grátis**, pois o subtotal é exatamente R$ 200,00 e atende ao critério de valor mínimo definido para frete grátis.

### Resultado obtido

O sistema cobra **R$ 19,90 de frete** mesmo com o subtotal exatamente igual a R$ 200,00.

A interface também apresenta a mensagem:

`Faltam R$ 0,00 para o frete grátis.`

### Comportamento após aplicação de cupom

Ao aplicar o cupom `BEMVINDO10`:

- **Subtotal:** R$ 200,00
- **Desconto:** R$ 20,00
- **Frete:** R$ 19,90
- **Total:** R$ 199,90

O frete permanece sendo cobrado, confirmando que o problema ocorre mesmo quando o cupom é aplicado.

### Ambiente

| Informação | Detalhe |
|---|---|
| Aplicação | Verzel Store |
| Versão da documentação | 2.3.0 |
| Sistema operacional | Windows 11 |
| Navegador | Microsoft Edge |
| Data da identificação | 06/10/2026 |

### Severidade

**Média**

O problema não impede a utilização da aplicação ou a finalização do pedido, porém gera cobrança incorreta de frete para pedidos que atendem ao critério de gratuidade.

### Prioridade

**Alta**

A regra de frete é uma regra de negócio diretamente relacionada ao valor final do pedido. O erro pode resultar em cobrança indevida de frete para clientes que atingirem exatamente o limite de R$ 200,00.

### Evidências

- `evidencias/frete/CT007-R200-sem-cupom.png`
- `evidencias/frete/CT007-R200-com-cupom.png`

### Resultado do teste relacionado

**CT007 — Reprovado**

O teste automatizado em Playwright também identifica o comportamento incorreto, mantendo o cenário propositalmente reprovado para evidenciar o defeito.

### Sugestão de correção

Revisar a condição utilizada para determinar o frete grátis, garantindo que o valor **R$ 200,00 seja incluído** na regra.

A condição esperada deve considerar:

```text
subtotal >= R$ 200,00
```

em vez de considerar somente valores superiores a R$ 200,00.

## BUG-002 — API permite quantidade superior ao limite de 5 unidades

**Status:** Aberto  
**Severidade:** Média  
**Prioridade:** Alta  
**Cenário relacionado:** API-011 — Quantidade superior ao limite  
**Critério de aceite:** CA10

### Descrição

A API permite adicionar mais de 5 unidades do mesmo produto, contrariando a regra definida na documentação.

De acordo com o critério CA10, o limite máximo permitido é de **5 unidades por produto**.

### Pré-condições

- API da Verzel Store disponível.
- Produto `P005 — Mochila Urbana 20L` disponível.

### Passos para reprodução

1. Enviar uma requisição `POST /api/carrinho/calcular`.
2. Informar o produto `P005`.
3. Informar quantidade igual a 6.
4. Verificar a resposta da API.

### Resultado esperado

A API deve rejeitar a requisição e retornar o erro:

```text
QUANTIDADE_MAXIMA_EXCEDIDA
```

indicando que o limite máximo de 5 unidades foi ultrapassado.

### Resultado obtido

A API aceita normalmente a quantidade de **6 unidades**.

A resposta retornou:

- **Quantidade:** 6 unidades
- **Subtotal:** R$ 600,00
- **Desconto:** R$ 0,00
- **Frete:** R$ 0,00
- **Total:** R$ 600,00
- **Frete grátis:** `true`

Nenhum erro relacionado à quantidade máxima foi retornado.

### Ambiente

| Informação | Detalhe |
|---|---|
| Aplicação | Verzel Store |
| Endpoint | `POST /api/carrinho/calcular` |
| Produto | P005 — Mochila Urbana 20L |
| Quantidade testada | 6 unidades |
| Versão da documentação | 2.3.0 |
| Data da identificação | 06/10/2026 |

### Impacto

O problema permite que a regra de negócio de limite máximo de 5 unidades seja contornada por meio da API.

Isso pode permitir pedidos com quantidade superior ao limite estabelecido pela aplicação.

### Evidência

`evidencias/api/API-011-6-unidades-bug-002.png`

### Resultado do teste relacionado

**API-011 — Reprovado**

O teste identificou que a API aceita 6 unidades do mesmo produto, quando deveria rejeitar a operação.

### Sugestão de correção

Adicionar ou corrigir a validação da quantidade de itens na API, garantindo que quantidades superiores a 5 sejam rejeitadas.

A condição esperada deve considerar:

```text
quantidade <= 5
```

Caso a quantidade seja maior que 5, a API deve retornar o erro:

```text
QUANTIDADE_MAXIMA_EXCEDIDA
```