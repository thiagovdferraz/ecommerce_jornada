-- ============================================
-- EXEMPLO 07: JOIN - Combinando tabelas
-- ============================================
-- Conceito: INNER JOIN para conectar vendas com produtos e clientes
-- Pergunta de negócio: Quais produtos foram vendidos? Para quais clientes?
-- Conexão com dbt: silver_vendas_enriquecidas faz JOIN vendas + produtos + clientes
--                  É o modelo central que alimenta todos os KPIs gold

-- ============================================
-- 1. JOIN vendas + produtos (duas tabelas)
-- ============================================
-- Enriquece cada venda com o nome e categoria do produto

SELECT
    v.id_venda,
    v.data_venda,
    v.canal_venda,
    v.quantidade,
    v.preco_unitario,
    p.nome_produto,
    p.categoria,
    p.marca
FROM vendas v
INNER JOIN produtos p
    ON v.id_produto = p.id_produto
ORDER BY v.data_venda DESC
LIMIT 20;


-- ============================================
-- 2. JOIN vendas + clientes (duas tabelas)
-- ============================================
-- Enriquece cada venda com dados do cliente

SELECT
    v.id_venda,
    v.data_venda,
    v.canal_venda,
    v.quantidade,
    v.preco_unitario,
    c.nome_cliente,
    c.estado
FROM vendas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
ORDER BY v.data_venda DESC
LIMIT 20;


-- ============================================
-- 3. Triple JOIN: vendas + produtos + clientes
-- ============================================
-- Essa é a base do silver_vendas_enriquecidas no dbt
-- Combina TUDO numa visão completa para análise

SELECT
    v.id_venda,
    v.data_venda,
    v.canal_venda,
    v.quantidade,
    v.preco_unitario,
    v.quantidade * v.preco_unitario AS receita_total,
    p.nome_produto,
    p.categoria,
    p.marca,
    c.nome_cliente,
    c.estado
FROM vendas v
INNER JOIN produtos p
    ON v.id_produto = p.id_produto
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
ORDER BY receita_total DESC
LIMIT 20;
