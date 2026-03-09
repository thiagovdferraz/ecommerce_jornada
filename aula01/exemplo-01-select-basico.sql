-- ============================================
-- EXEMPLO 01: SELECT Básico - Conhecendo as tabelas
-- ============================================
-- Conceito: SELECT para explorar dados brutos
-- Pergunta de negócio: Que dados temos disponíveis no nosso sistema de vendas?
-- Conexão com dbt: Camada bronze - views que expõem as tabelas raw sem transformação
--                  No dbt, bronze_vendas.sql faz exatamente: SELECT * FROM source('vendas')

-- ============================================
-- 1. Conhecendo a tabela VENDAS
-- ============================================
-- Cada linha é uma transação de venda
-- Colunas: id_venda, data_venda, id_cliente, id_produto, canal_venda, quantidade, preco_unitario

SELECT *
FROM vendas
LIMIT 10;


-- ============================================
-- 2. Conhecendo a tabela PRODUTOS
-- ============================================
-- Cada linha é um produto do catálogo
-- Colunas: id_produto, nome_produto, categoria, marca, preco_atual, data_criacao

SELECT *
FROM produtos
LIMIT 10;


-- ============================================
-- 3. Conhecendo a tabela CLIENTES
-- ============================================
-- Cada linha é um cliente cadastrado
-- Colunas: id_cliente, nome_cliente, estado, pais, data_cadastro

SELECT *
FROM clientes
LIMIT 10;
