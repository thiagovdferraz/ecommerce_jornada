-- ============================================
-- EXEMPLO 08: JOIN + GROUP BY - Análises dimensionais
-- ============================================
-- Conceito: Combinar tabelas E agrupar para criar métricas por dimensão
-- Pergunta de negócio: Qual a receita por categoria? E por marca?
-- Conexão com dbt: gold_kpi_receita_por_categoria e gold_kpi_receita_por_marca
--                  Ambos fazem JOIN + GROUP BY sobre silver_vendas_enriquecidas

-- ============================================
-- 1. Receita por categoria de produto
-- ============================================
-- Esse é o gold_kpi_receita_por_categoria

SELECT
    p.categoria,
    SUM(v.quantidade * v.preco_unitario) AS receita_total,
    SUM(v.quantidade) AS quantidade_total,
    COUNT(*) AS total_vendas,
    COUNT(DISTINCT p.id_produto) AS total_produtos,
    AVG(v.quantidade * v.preco_unitario) AS ticket_medio
FROM vendas v
INNER JOIN produtos p
    ON v.id_produto = p.id_produto
GROUP BY p.categoria
ORDER BY receita_total DESC;


-- ============================================
-- 2. Receita por marca
-- ============================================
-- Esse é o gold_kpi_receita_por_marca

SELECT
    p.marca,
    SUM(v.quantidade * v.preco_unitario) AS receita_total,
    SUM(v.quantidade) AS quantidade_total,
    COUNT(*) AS total_vendas,
    COUNT(DISTINCT p.id_produto) AS total_produtos,
    AVG(v.quantidade * v.preco_unitario) AS ticket_medio
FROM vendas v
INNER JOIN produtos p
    ON v.id_produto = p.id_produto
GROUP BY p.marca
ORDER BY receita_total DESC;


-- ============================================
-- 3. Receita por estado do cliente
-- ============================================

SELECT
    c.estado,
    SUM(v.quantidade * v.preco_unitario) AS receita_total,
    COUNT(*) AS total_vendas,
    COUNT(DISTINCT v.id_cliente) AS total_clientes,
    AVG(v.quantidade * v.preco_unitario) AS ticket_medio
FROM vendas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
GROUP BY c.estado
ORDER BY receita_total DESC;


-- ============================================
-- 4. Receita por categoria e canal (duas dimensões)
-- ============================================
-- Análise cruzada: como cada categoria performa em cada canal

SELECT
    p.categoria,
    v.canal_venda,
    SUM(v.quantidade * v.preco_unitario) AS receita_total,
    COUNT(*) AS total_vendas
FROM vendas v
INNER JOIN produtos p
    ON v.id_produto = p.id_produto
GROUP BY p.categoria, v.canal_venda
ORDER BY p.categoria, receita_total DESC;
