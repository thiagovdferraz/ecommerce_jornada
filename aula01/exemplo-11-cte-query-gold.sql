-- ============================================
-- EXEMPLO 11: CTE (WITH) - Montando uma query estilo Gold
-- ============================================
-- Conceito: Common Table Expressions para organizar queries complexas em camadas
-- Pergunta de negócio: Como montar um KPI completo do zero, combinando tudo que aprendemos?
-- Conexão com dbt: Cada modelo dbt é basicamente uma CTE!
--                  O dbt organiza queries em camadas (bronze → silver → gold)
--                  Aqui simulamos essa mesma estrutura com CTEs

-- ============================================
-- 1. CTE simples - Preparando dados (camada silver)
-- ============================================
-- Uma CTE funciona como uma "tabela temporária" dentro da query

WITH vendas_com_receita AS (
    SELECT
        id_venda,
        id_cliente,
        id_produto,
        canal_venda,
        quantidade,
        preco_unitario,
        quantidade * preco_unitario AS receita_total
    FROM vendas
)
SELECT *
FROM vendas_com_receita
ORDER BY receita_total DESC
LIMIT 10;


-- ============================================
-- 2. Múltiplas CTEs - Simulando bronze → silver → gold
-- ============================================
-- Aqui mostramos como o dbt pensa: cada camada alimenta a próxima

WITH
-- Camada "silver": limpeza e enriquecimento
silver_vendas AS (
    SELECT
        v.id_venda,
        v.id_cliente,
        v.id_produto,
        v.canal_venda,
        v.quantidade,
        v.preco_unitario,
        v.quantidade * v.preco_unitario AS receita_total,
        p.nome_produto,
        p.categoria,
        p.marca,
        CASE
            WHEN p.preco_atual > 1000 THEN 'PREMIUM'
            WHEN p.preco_atual > 500 THEN 'MEDIO'
            ELSE 'BASICO'
        END AS faixa_preco,
        c.nome_cliente,
        c.estado
    FROM vendas v
    INNER JOIN produtos p ON v.id_produto = p.id_produto
    INNER JOIN clientes c ON v.id_cliente = c.id_cliente
    WHERE v.quantidade > 0
      AND v.preco_unitario > 0
),

-- Camada "gold": KPI de receita por categoria
gold_receita_por_categoria AS (
    SELECT
        categoria,
        faixa_preco,
        SUM(receita_total) AS receita_total,
        SUM(quantidade) AS quantidade_total,
        COUNT(*) AS total_vendas,
        COUNT(DISTINCT id_produto) AS total_produtos,
        AVG(receita_total) AS ticket_medio,
        SUM(receita_total) * 100.0 / SUM(SUM(receita_total)) OVER () AS percentual_receita
    FROM silver_vendas
    GROUP BY categoria, faixa_preco
)

-- Query final: resultado pronto para dashboard
SELECT
    categoria,
    faixa_preco,
    receita_total,
    quantidade_total,
    total_vendas,
    total_produtos,
    ROUND(ticket_medio, 2) AS ticket_medio,
    ROUND(percentual_receita, 2) AS percentual_receita
FROM gold_receita_por_categoria
ORDER BY receita_total DESC;


-- ============================================
-- 3. Query Gold completa: Top produtos com ranking
-- ============================================
-- Essa query simula EXATAMENTE o que o gold_kpi_produtos_top_receita faz
-- CTE para agregar + query final com window function para ranking

WITH vendas_por_produto AS (
    SELECT
        v.id_produto,
        p.nome_produto,
        p.categoria,
        p.marca,
        SUM(v.quantidade * v.preco_unitario) AS receita_total,
        SUM(v.quantidade) AS quantidade_total,
        COUNT(*) AS total_vendas,
        AVG(v.preco_unitario) AS preco_medio_vendido,
        AVG(v.quantidade * v.preco_unitario) AS ticket_medio
    FROM vendas v
    INNER JOIN produtos p ON v.id_produto = p.id_produto
    GROUP BY v.id_produto, p.nome_produto, p.categoria, p.marca
)

SELECT
    id_produto,
    nome_produto,
    categoria,
    marca,
    receita_total,
    quantidade_total,
    total_vendas,
    ROUND(preco_medio_vendido, 2) AS preco_medio_vendido,
    ROUND(ticket_medio, 2) AS ticket_medio,
    ROW_NUMBER() OVER (ORDER BY receita_total DESC) AS ranking_receita,
    ROW_NUMBER() OVER (PARTITION BY categoria ORDER BY receita_total DESC) AS ranking_receita_categoria
FROM vendas_por_produto
ORDER BY receita_total DESC
LIMIT 10;


-- ============================================
-- 4. Query Gold completa: Receita por canal com percentual
-- ============================================
-- Simula o gold_kpi_receita_por_canal

WITH silver_vendas AS (
    SELECT
        id_venda,
        canal_venda,
        quantidade,
        preco_unitario,
        quantidade * preco_unitario AS receita_total
    FROM vendas
    WHERE quantidade > 0
      AND preco_unitario > 0
)

SELECT
    canal_venda,
    SUM(receita_total) AS receita_total,
    SUM(quantidade) AS quantidade_total,
    COUNT(DISTINCT id_venda) AS total_vendas,
    ROUND(AVG(receita_total), 2) AS ticket_medio,
    ROUND(SUM(receita_total) * 100.0 / SUM(SUM(receita_total)) OVER (), 2) AS percentual_receita
FROM silver_vendas
GROUP BY canal_venda
ORDER BY receita_total DESC;
