-- ============================================
-- EXEMPLO 10: Window Functions - Rankings e percentuais
-- ============================================
-- Conceito: ROW_NUMBER(), SUM() OVER() para rankings e cálculos sobre o total
-- Pergunta de negócio: Qual o ranking dos produtos por receita? Qual % de cada canal?
-- Conexão com dbt: gold_kpi_produtos_top_receita usa ROW_NUMBER() para ranking
--                  gold_kpi_receita_por_canal usa SUM() OVER() para percentual

-- ============================================
-- 1. Ranking de produtos por receita total
-- ============================================
-- Essa lógica é usada no gold_kpi_produtos_top_receita

SELECT
    p.nome_produto,
    p.categoria,
    p.marca,
    SUM(v.quantidade * v.preco_unitario) AS receita_total,
    ROW_NUMBER() OVER (ORDER BY SUM(v.quantidade * v.preco_unitario) DESC) AS ranking_receita
FROM vendas v
INNER JOIN produtos p
    ON v.id_produto = p.id_produto
GROUP BY p.nome_produto, p.categoria, p.marca
ORDER BY ranking_receita
LIMIT 10;


-- ============================================
-- 2. Ranking por categoria (PARTITION BY)
-- ============================================
-- No gold_kpi_produtos_top_receita: ranking_receita_categoria
-- PARTITION BY cria um ranking separado para cada categoria

SELECT
    p.nome_produto,
    p.categoria,
    SUM(v.quantidade * v.preco_unitario) AS receita_total,
    ROW_NUMBER() OVER (
        PARTITION BY p.categoria
        ORDER BY SUM(v.quantidade * v.preco_unitario) DESC
    ) AS ranking_na_categoria
FROM vendas v
INNER JOIN produtos p
    ON v.id_produto = p.id_produto
GROUP BY p.nome_produto, p.categoria
ORDER BY p.categoria, ranking_na_categoria;


-- ============================================
-- 3. Percentual de receita por canal
-- ============================================
-- Essa lógica é EXATAMENTE a do gold_kpi_receita_por_canal
-- SUM() OVER() calcula o total geral para usar como denominador

SELECT
    canal_venda,
    SUM(quantidade * preco_unitario) AS receita_total,
    COUNT(*) AS total_vendas,
    AVG(quantidade * preco_unitario) AS ticket_medio,
    SUM(quantidade * preco_unitario) * 100.0 / SUM(SUM(quantidade * preco_unitario)) OVER () AS percentual_receita
FROM vendas
GROUP BY canal_venda
ORDER BY receita_total DESC;


-- ============================================
-- 4. Percentual de receita por categoria
-- ============================================

SELECT
    p.categoria,
    SUM(v.quantidade * v.preco_unitario) AS receita_total,
    COUNT(*) AS total_vendas,
    SUM(v.quantidade * v.preco_unitario) * 100.0 / SUM(SUM(v.quantidade * v.preco_unitario)) OVER () AS percentual_receita
FROM vendas v
INNER JOIN produtos p
    ON v.id_produto = p.id_produto
GROUP BY p.categoria
ORDER BY receita_total DESC;
