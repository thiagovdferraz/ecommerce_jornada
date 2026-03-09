-- ============================================
-- EXEMPLO 05: Funções de Agregação - Métricas de negócio
-- ============================================
-- Conceito: SUM, COUNT, AVG, MIN, MAX, COUNT DISTINCT
-- Pergunta de negócio: Qual a receita total? Quantas vendas? Qual o ticket médio?
-- Conexão com dbt: Métricas base de TODOS os KPIs gold
--                  receita_total (SUM), total_vendas (COUNT), ticket_medio (AVG),
--                  clientes_unicos (COUNT DISTINCT)

-- ============================================
-- 1. Contando registros
-- ============================================

-- Total de vendas
SELECT COUNT(*) AS total_vendas
FROM vendas;

-- Total de produtos no catálogo
SELECT COUNT(*) AS total_produtos
FROM produtos;

-- Total de clientes
SELECT COUNT(*) AS total_clientes
FROM clientes;


-- ============================================
-- 2. Receita total (SUM)
-- ============================================

SELECT
    SUM(quantidade * preco_unitario) AS receita_total
FROM vendas;


-- ============================================
-- 3. Estatísticas de preço dos produtos (AVG, MIN, MAX)
-- ============================================

SELECT
    AVG(preco_atual) AS preco_medio,
    MIN(preco_atual) AS preco_minimo,
    MAX(preco_atual) AS preco_maximo
FROM produtos;


-- ============================================
-- 4. COUNT DISTINCT - Valores únicos
-- ============================================
-- No dbt gold, total_clientes_unicos usa COUNT(DISTINCT id_cliente)

SELECT
    COUNT(DISTINCT id_cliente) AS clientes_unicos,
    COUNT(DISTINCT id_produto) AS produtos_vendidos,
    COUNT(DISTINCT canal_venda) AS canais_venda
FROM vendas;


-- ============================================
-- 5. Painel completo de métricas - estilo KPI gold
-- ============================================
-- Todas as métricas que os modelos gold calculam, numa única query

SELECT
    COUNT(*) AS total_vendas,
    COUNT(DISTINCT id_cliente) AS clientes_unicos,
    COUNT(DISTINCT id_produto) AS produtos_vendidos,
    SUM(quantidade) AS quantidade_total,
    SUM(quantidade * preco_unitario) AS receita_total,
    AVG(quantidade * preco_unitario) AS ticket_medio,
    MIN(quantidade * preco_unitario) AS menor_venda,
    MAX(quantidade * preco_unitario) AS maior_venda
FROM vendas;
