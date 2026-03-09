# 📚 Dia 1: SQL & Analytics | Jornada de Dados

Bem-vindo ao **primeiro dia da imersão Jornada de Dados**! Hoje você vai aprender SQL do zero, pensando como um analista de dados que precisa responder perguntas de negócio.

> **Domínio:** Sistema de vendas (e-commerce + loja física)
> **Conexão:** Cada exemplo SQL prepara você para conceitos que vai reencontrar na **aula-03-dbt** (arquitetura medalhão: bronze, silver, gold).

---

## 📖 O que é SQL?

**SQL** (Structured Query Language) é a linguagem padrão para trabalhar com bancos de dados relacionais. É a ferramenta que permite:

- ✅ **Consultar dados** - Extrair informações de tabelas
- ✅ **Analisar dados** - Calcular métricas, agregações e estatísticas
- ✅ **Manipular dados** - Inserir, atualizar e deletar registros
- ✅ **Estruturar dados** - Criar tabelas, relacionamentos e índices

**SQL não é uma linguagem de programação tradicional.** É uma linguagem declarativa: você descreve **o que quer**, não **como fazer**. O banco de dados decide a melhor forma de executar.

```sql
-- Você diz: "Quero os produtos mais caros"
SELECT nome_produto, preco_atual
FROM produtos
ORDER BY preco_atual DESC
LIMIT 10;

-- O banco decide como buscar isso de forma eficiente
```

---

## 💼 Mercado de SQL

SQL é uma das habilidades mais demandadas no mercado de dados e tecnologia:

### 📊 Por que SQL é importante?

1. **Universalidade**: Quase todos os bancos de dados relacionais usam SQL
2. **Demanda de mercado**: Uma das habilidades mais procuradas em vagas de dados
3. **Base para outras ferramentas**: BI tools (Power BI, Tableau), Python (pandas), dbt, etc.
4. **Carreira**: Analista de Dados, Cientista de Dados, Engenheiro de Dados — todos precisam de SQL

### 🎯 Onde SQL é usado?

- **Análise de Negócio** — Responder perguntas estratégicas
- **Business Intelligence** — Criar dashboards e relatórios
- **Data Science** — Preparar e explorar dados
- **Data Engineering** — Transformar dados com dbt, pipelines ETL/ELT
- **Desenvolvimento** — Backend de aplicações

---

## 🛠️ Plataforma: Supabase

Neste curso, vamos usar **[Supabase](https://supabase.com/)** porque:

- ✅ **PostgreSQL completo** — Banco de dados profissional e robusto
- ✅ **Interface web** — Editor SQL integrado, fácil de usar
- ✅ **Gratuito** — Plano free generoso para aprender
- ✅ **Fácil setup** — Criação de projeto em minutos

**Supabase é essencialmente PostgreSQL com uma interface moderna.** Tudo que você aprender aqui funciona em qualquer PostgreSQL.

---

## 🗄️ Nossas Tabelas

📎 Nossos dados: [Google Sheets](https://docs.google.com/spreadsheets/d/1V_ICue9zOznu-8WlCUpb0ZmHEE5NZcqgV1_Gw4RIJp4/edit?usp=sharing)

O banco tem **4 tabelas** de um sistema de vendas:

```
Banco de Dados: E-commerce
├── vendas               (~3.000 registros)  — Transações de venda
├── produtos             (200 registros)     — Catálogo de produtos
├── clientes             (50 registros)      — Clientes cadastrados
└── preco_competidores   (~680 registros)    — Preços dos concorrentes
```

> **Nota:** Nos 11 exemplos desta aula focamos nas 3 tabelas principais (`vendas`, `produtos`, `clientes`). A tabela `preco_competidores` é explorada na **aula-03-dbt** nos modelos gold de pricing.

### 📋 vendas

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| `id_venda` | TEXT | ID único da venda |
| `data_venda` | TIMESTAMP | Data e hora da venda |
| `id_cliente` | TEXT | FK → clientes |
| `id_produto` | TEXT | FK → produtos |
| `canal_venda` | TEXT | `ecommerce` ou `loja_fisica` |
| `quantidade` | INTEGER | Unidades vendidas |
| `preco_unitario` | NUMERIC | Preço unitário na venda (R$) |

### 📋 produtos

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| `id_produto` | TEXT | ID único do produto |
| `nome_produto` | TEXT | Nome do produto |
| `categoria` | TEXT | Categoria (Eletrônicos, Cozinha, Tênis...) |
| `marca` | TEXT | Marca do produto |
| `preco_atual` | NUMERIC | Preço atual em R$ |
| `data_criacao` | TIMESTAMP | Data de criação |

### 📋 clientes

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| `id_cliente` | TEXT | ID único do cliente |
| `nome_cliente` | TEXT | Nome do cliente |
| `estado` | TEXT | Estado (UF) |
| `pais` | TEXT | País |
| `data_cadastro` | TIMESTAMP | Data de cadastro |

### 📋 preco_competidores

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| `id_produto` | TEXT | FK → produtos |
| `nome_concorrente` | TEXT | Nome do concorrente |
| `preco_concorrente` | NUMERIC | Preço do concorrente (R$) |
| `data_coleta` | TIMESTAMP | Data da coleta do preço |

### 🔗 Relacionamentos

```
vendas.id_produto ──────→ produtos.id_produto
vendas.id_cliente ──────→ clientes.id_cliente
preco_competidores.id_produto ──→ produtos.id_produto
```

---

## 🎯 Progressão de Aprendizado

Os 11 exemplos seguem uma progressão didática onde cada um usa conceitos dos anteriores. Todos focam no domínio **Sales** e preparam para o dbt.

```
SQL Básico              →  Transformações         →  Análises complexas
(exemplos 01-03)           (exemplos 04-06)          (exemplos 07-11)

SELECT, WHERE,             Campos calculados,        JOIN, JOIN+GROUP BY,
ORDER BY, LIMIT            Agregações, GROUP BY      CASE WHEN, Window, CTE
```

### 🔄 Conexão SQL → dbt (Arquitetura Medalhão)

| Camada dbt | O que faz | Exemplos SQL relacionados |
|:----------:|-----------|:-------------------------:|
| 🥉 **Bronze** | Views das tabelas raw, sem transformação | Exemplo 01 |
| 🥈 **Silver** | Limpeza, campos calculados, JOINs, classificações | Exemplos 04, 07, 09 |
| 🥇 **Gold** | KPIs, agregações, rankings, percentuais | Exemplos 06, 08, 10, 11 |

---

## 📝 Exemplos

---

### 01 — SELECT Básico

📄 `exemplo-01-select-basico.sql`

| | |
|---|---|
| **Conceito** | SELECT para explorar dados brutos |
| **Pergunta de negócio** | Que dados temos disponíveis no nosso sistema de vendas? |
| **Conexão dbt** | Camada bronze — views que expõem as tabelas raw sem transformação |

**O que você aprende:**
- Sintaxe básica do `SELECT`
- Conhecer as 3 tabelas (vendas, produtos, clientes)
- Usar `LIMIT` para limitar resultados

---

### 02 — ORDER BY + LIMIT

📄 `exemplo-02-order-by-limit.sql`

| | |
|---|---|
| **Conceito** | Ordenação e top N |
| **Pergunta de negócio** | Quais são os produtos mais caros? Quais as maiores vendas? |
| **Conexão dbt** | Padrão top N usado nos modelos gold (ex: `gold_kpi_produtos_top_receita`) |

**O que você aprende:**
- `ORDER BY ASC` e `DESC`
- `LIMIT` para top N
- Combinar `ORDER BY` + `LIMIT` para rankings

---

### 03 — WHERE

📄 `exemplo-03-where.sql`

| | |
|---|---|
| **Conceito** | Filtros com operadores `=`, `>`, `<`, `IN`, `BETWEEN`, `AND`/`OR` |
| **Pergunta de negócio** | Como filtrar vendas por canal, preço e validações? |
| **Conexão dbt** | Filtros de validação do `silver_vendas` (`quantidade > 0`, `preco > 0`, `IS NOT NULL`) |

**O que você aprende:**
- Operadores de comparação (`=`, `>`, `<`, `>=`, `<=`)
- `IN` para listas de valores
- `BETWEEN` para faixas
- `AND`/`OR` para combinar condições
- Validação de dados (encontrar registros inválidos)

---

### 04 — Campos Calculados

📄 `exemplo-04-campos-calculados.sql`

| | |
|---|---|
| **Conceito** | Criar colunas derivadas com aritmética |
| **Pergunta de negócio** | Qual a receita de cada venda? |
| **Conexão dbt** | `silver_vendas` calcula `receita_total = quantidade * preco_unitario` |

**O que você aprende:**
- Expressões aritméticas (`quantidade * preco_unitario`)
- Criar colunas com `AS` (alias)
- Receita como campo calculado

---

### 05 — Funções de Agregação

📄 `exemplo-05-funcoes-agregacao.sql`

| | |
|---|---|
| **Conceito** | `SUM`, `COUNT`, `AVG`, `MIN`, `MAX`, `COUNT DISTINCT` |
| **Pergunta de negócio** | Qual a receita total? Quantas vendas? Qual o ticket médio? |
| **Conexão dbt** | Métricas base de TODOS os KPIs gold (`receita_total`, `total_vendas`, `ticket_medio`, `clientes_unicos`) |

**O que você aprende:**
- `COUNT(*)` vs `COUNT(DISTINCT)`
- `SUM`, `AVG`, `MIN`, `MAX`
- Combinar múltiplas agregações numa query
- Montar um painel de métricas estilo KPI

---

### 06 — GROUP BY

📄 `exemplo-06-group-by.sql`

| | |
|---|---|
| **Conceito** | Agrupar resultados por dimensão |
| **Pergunta de negócio** | Qual a receita por canal de venda? E por categoria? |
| **Conexão dbt** | `gold_kpi_receita_por_canal` agrupa receita por `canal_venda` |

**O que você aprende:**
- `GROUP BY` para agrupar
- Combinar `GROUP BY` com funções de agregação
- Regra: toda coluna no `SELECT` deve estar no `GROUP BY` ou ser agregação

---

### 07 — JOIN

📄 `exemplo-07-join.sql`

| | |
|---|---|
| **Conceito** | `INNER JOIN` para combinar tabelas |
| **Pergunta de negócio** | Quais produtos foram vendidos? Para quais clientes? |
| **Conexão dbt** | `silver_vendas_enriquecidas` faz JOIN vendas + produtos + clientes |

**O que você aprende:**
- `INNER JOIN` entre duas tabelas
- Aliases de tabela (`v`, `p`, `c`)
- Triple JOIN (vendas + produtos + clientes)
- Essa é a base do modelo mais importante do dbt

---

### 08 — JOIN + GROUP BY

📄 `exemplo-08-join-group-by.sql`

| | |
|---|---|
| **Conceito** | Combinar tabelas E agrupar para análises dimensionais |
| **Pergunta de negócio** | Qual a receita por categoria? E por marca? E por estado? |
| **Conexão dbt** | `gold_kpi_receita_por_categoria` e `gold_kpi_receita_por_marca` |

**O que você aprende:**
- `JOIN` + `GROUP BY` juntos
- Métricas por categoria, marca, estado
- Análise cruzada (categoria × canal)
- Métricas completas: receita, quantidade, total_vendas, ticket_medio

---

### 09 — CASE WHEN

📄 `exemplo-09-case-when.sql`

| | |
|---|---|
| **Conceito** | Classificações e categorizações condicionais |
| **Pergunta de negócio** | Como classificar produtos por faixa de preço? |
| **Conexão dbt** | `silver_produtos` classifica `faixa_preco` (`PREMIUM`/`MEDIO`/`BASICO`) |

**O que você aprende:**
- Sintaxe `CASE WHEN` / `THEN` / `ELSE` / `END`
- Classificar produtos por faixa de preço (mesma lógica do dbt)
- Classificar vendas por tamanho
- Criar flags de validação (`TRUE`/`FALSE`)

---

### 10 — Window Functions

📄 `exemplo-10-window-functions.sql`

| | |
|---|---|
| **Conceito** | `ROW_NUMBER()`, `SUM() OVER()` para rankings e percentuais |
| **Pergunta de negócio** | Qual o ranking dos produtos por receita? Qual % de cada canal? |
| **Conexão dbt** | `gold_kpi_produtos_top_receita` (ROW_NUMBER), `gold_kpi_receita_por_canal` (percentual) |

**O que você aprende:**
- `ROW_NUMBER() OVER (ORDER BY ...)` para rankings
- `PARTITION BY` para rankings por grupo
- `SUM() OVER ()` para calcular percentual do total
- Diferença entre agregação normal e window function

---

### 11 — CTE (WITH) — Query estilo Gold

📄 `exemplo-11-cte-query-gold.sql`

| | |
|---|---|
| **Conceito** | Common Table Expressions para montar queries complexas em camadas |
| **Pergunta de negócio** | Como montar um KPI completo do zero? |
| **Conexão dbt** | Cada modelo dbt é basicamente uma CTE! O dbt organiza queries em camadas (bronze → silver → gold) |

**O que você aprende:**
- Sintaxe `WITH ... AS (query)`
- Múltiplas CTEs encadeadas
- Simular a arquitetura medalhão (silver CTE → gold CTE → query final)
- Combinar tudo: JOIN, GROUP BY, CASE WHEN, Window Functions
- **Essa é a ponte direta para entender como o dbt funciona**

---

## 📊 Resumo dos Conceitos

| Exemplo | Conceito | Conexão dbt |
|:-------:|----------|-------------|
| 01 | SELECT básico | 🥉 bronze (views raw) |
| 02 | ORDER BY + LIMIT | 🥇 top N dos gold KPIs |
| 03 | WHERE | 🥈 filtros de validação do silver |
| 04 | Campos calculados | 🥈 `silver_vendas` (receita_total) |
| 05 | Funções de agregação | 🥇 métricas base dos gold KPIs |
| 06 | GROUP BY | 🥇 `gold_kpi_receita_por_canal` |
| 07 | JOIN | 🥈 `silver_vendas_enriquecidas` |
| 08 | JOIN + GROUP BY | 🥇 `gold_kpi_receita_por_categoria` |
| 09 | CASE WHEN | 🥈 `silver_produtos` (faixa_preco) |
| 10 | Window Functions | 🥇 gold rankings e percentuais |
| 11 | CTE (WITH) | 🥇 arquitetura medalhão completa |

---

## ❓ Perguntas de Negócio Respondidas

### 🔍 Explorar dados
1. Que dados temos disponíveis? *(Exemplo 01)*
2. Quais os produtos mais caros? *(Exemplo 02)*
3. Quais as maiores vendas? *(Exemplo 02)*

### 🔎 Filtrar e transformar
4. Quais vendas são do e-commerce? *(Exemplo 03)*
5. Quais produtos custam entre R$ 100 e R$ 500? *(Exemplo 03)*
6. Existem vendas com dados inválidos? *(Exemplo 03)*
7. Qual a receita de cada venda? *(Exemplo 04)*

### 📈 Métricas e agrupamentos
8. Qual a receita total e ticket médio? *(Exemplo 05)*
9. Quantos clientes únicos compraram? *(Exemplo 05)*
10. Qual a receita por canal de venda? *(Exemplo 06)*

### 🔗 Análises com JOINs
11. Quais produtos foram vendidos e para quem? *(Exemplo 07)*
12. Qual a receita por categoria? *(Exemplo 08)*
13. Qual a receita por marca? *(Exemplo 08)*
14. Qual a receita por estado? *(Exemplo 08)*

### 🏷️ Classificações e rankings
15. Qual a faixa de preço de cada produto? *(Exemplo 09)*
16. Qual o ranking dos produtos por receita? *(Exemplo 10)*
17. Qual o percentual de receita por canal? *(Exemplo 10)*

### 🏆 Análise completa
18. Como montar um KPI completo estilo dashboard? *(Exemplo 11)*

---

## ✅ Checklist de Aprendizado

Após completar os 11 exemplos, você deve ser capaz de:

- [ ] Selecionar e explorar dados (`SELECT`, `LIMIT`)
- [ ] Ordenar resultados (`ORDER BY`)
- [ ] Filtrar registros (`WHERE`, `IN`, `BETWEEN`, `AND`/`OR`)
- [ ] Criar campos calculados (aritmética)
- [ ] Calcular agregações (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`)
- [ ] Agrupar dados (`GROUP BY`)
- [ ] Combinar tabelas (`INNER JOIN`, triple join)
- [ ] Fazer análises dimensionais (`JOIN` + `GROUP BY`)
- [ ] Criar classificações (`CASE WHEN`)
- [ ] Usar window functions (`ROW_NUMBER`, `SUM OVER`)
- [ ] Organizar queries com CTEs (`WITH`)
- [ ] Entender a conexão SQL → dbt (bronze, silver, gold)

---

## 💡 Dicas

- **Execute em ordem** — Cada exemplo usa conceitos dos anteriores
- **Leia os comentários** — Cada query tem `-- Conceito:`, `-- Pergunta de negócio:` e `-- Conexão com dbt:`
- **Modifique** — Tente adaptar as queries para responder outras perguntas
- **Valide** — Sempre verifique se os resultados fazem sentido
- **Pense no dbt** — Quando chegar na aula 03, você vai reconhecer tudo

---

## 🚀 Próximos Passos

Depois de dominar os 11 exemplos:

1. Pratique criando suas próprias queries
2. Combine conceitos de diferentes exemplos
3. Avance para a **Aula 02: Python & Ingestão de Dados**
4. Na **Aula 03: dbt**, você vai reencontrar todos esses conceitos organizados em modelos

---

**Total: 11 exemplos progressivos · 18 perguntas de negócio · tudo conectado com dbt** 🚀