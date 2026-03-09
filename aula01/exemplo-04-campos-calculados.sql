-- ============================================
-- EXEMPLO 04: Campos Calculados - Criando novas colunas
-- ============================================
-- Conceito: Expressões aritméticas para criar colunas derivadas
-- Pergunta de negócio: Qual a receita de cada venda?
-- Conexão com dbt: silver_vendas calcula receita_total = quantidade * preco_unitario

-- ============================================
-- 1. Receita total de cada venda (quantidade × preço)
-- ============================================
-- Esse cálculo é EXATAMENTE o que o silver_vendas faz no dbt

SELECT
    id_venda,
    quantidade,
    preco_unitario,
    quantidade * preco_unitario AS receita_total
FROM vendas
ORDER BY receita_total DESC
LIMIT 20;


-- ============================================
-- 2. Receita com dados completos da venda
-- ============================================
-- Visão que prepara os dados para análise - espelho do silver_vendas

SELECT
    id_venda,
    id_cliente,
    id_produto,
    canal_venda,
    quantidade,
    preco_unitario,
    quantidade * preco_unitario AS receita_total
FROM vendas
ORDER BY receita_total DESC
LIMIT 20;
