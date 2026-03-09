-- ============================================
-- EXEMPLO 02: ORDER BY + LIMIT - Ordenação e Top N
-- ============================================
-- Conceito: ORDER BY para ordenar resultados, LIMIT para limitar quantidade
-- Pergunta de negócio: Quais são os produtos mais caros? Quais as maiores vendas?
-- Conexão com dbt: Padrão top N usado nos modelos gold
--                  gold_kpi_produtos_top_receita usa ORDER BY receita DESC LIMIT 10

-- ============================================
-- 1. Produtos mais caros do catálogo
-- ============================================

SELECT
    nome_produto,
    categoria,
    marca,
    preco_atual
FROM produtos
ORDER BY preco_atual DESC
LIMIT 10;


-- ============================================
-- 2. Produtos mais baratos do catálogo
-- ============================================

SELECT
    nome_produto,
    categoria,
    marca,
    preco_atual
FROM produtos
ORDER BY preco_atual ASC
LIMIT 10;


-- ============================================
-- 3. Top 10 vendas por valor unitário
-- ============================================

SELECT
    id_venda,
    data_venda,
    canal_venda,
    quantidade,
    preco_unitario
FROM vendas
ORDER BY preco_unitario DESC
LIMIT 10;


-- ============================================
-- 4. Clientes mais recentes (últimos cadastrados)
-- ============================================

SELECT
    nome_cliente,
    estado,
    data_cadastro
FROM clientes
ORDER BY data_cadastro DESC
LIMIT 10;
