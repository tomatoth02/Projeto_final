-- =====================================================
-- PROJETO DE BANCO DE DADOS: LOJA DE JOGOS
-- Versão simples para estudar os comandos básicos
-- PostgreSQL
-- =====================================================

-- 1. CRIAR AS TABELAS

CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20)
);

CREATE TABLE produtos (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    preco NUMERIC(8,2) NOT NULL,
    estoque INTEGER NOT NULL
);

CREATE TABLE vendas (
    id_venda SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    data_venda DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Esta tabela liga as vendas aos produtos.
-- Uma venda pode ter mais de um produto.
CREATE TABLE itens_venda (
    id_item SERIAL PRIMARY KEY,
    id_venda INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    FOREIGN KEY (id_venda) REFERENCES vendas(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

-- 2. INSERIR DADOS DE EXEMPLO

INSERT INTO clientes (nome, telefone) VALUES
('Ana Souza', '44999991111'),
('Bruno Lima', '44999992222'),
('Carla Mendes', '44999993333');

INSERT INTO produtos (nome, tipo, preco, estoque) VALUES
('Minecraft', 'JOGO', 100.00, 10),
('FIFA', 'JOGO', 250.00, 5),
('Controle Gamer', 'ACESSORIO', 180.00, 7),
('Headset Gamer', 'ACESSORIO', 120.00, 8),
('God of War', 'JOGO', 200.00, 4);

INSERT INTO vendas (id_cliente, data_venda) VALUES
(1, '2026-09-01'),
(2, '2026-09-02'),
(1, '2026-09-03');

INSERT INTO itens_venda (id_venda, id_produto, quantidade) VALUES
(1, 1, 1),
(1, 4, 2),
(2, 2, 1),
(2, 3, 1),
(3, 5, 1);

-- 3. CONSULTAS SQL
-- Cada consulta responde a uma pergunta da loja.

-- Consulta 1: Mostrar todos os clientes.
SELECT * FROM clientes;

-- Consulta 2: Mostrar os produtos que custam menos de R$ 200.
SELECT nome, preco
FROM produtos
WHERE preco < 200;

-- Consulta 3: Mostrar os produtos do mais caro para o mais barato.
SELECT nome, preco
FROM produtos
ORDER BY preco DESC;

-- Consulta 4: Mostrar os tipos de produto sem repetir.
SELECT DISTINCT tipo
FROM produtos;

-- Consulta 5: Mostrar os três produtos mais baratos.
SELECT nome, preco
FROM produtos
ORDER BY preco ASC
LIMIT 3;

-- Consulta 6: Contar quantos clientes estão cadastrados.
SELECT COUNT(*) AS quantidade_clientes
FROM clientes;

-- Consulta 7: Mostrar o preço médio dos produtos.
SELECT AVG(preco) AS preco_medio
FROM produtos;

-- Consulta 8: Mostrar as vendas com o nome do cliente.
SELECT vendas.id_venda, clientes.nome, vendas.data_venda
FROM vendas
INNER JOIN clientes
ON vendas.id_cliente = clientes.id_cliente;

-- Consulta 9: Mostrar quantas unidades de cada produto foram vendidas.
SELECT produtos.nome, SUM(itens_venda.quantidade) AS unidades_vendidas
FROM produtos
INNER JOIN itens_venda
ON produtos.id_produto = itens_venda.id_produto
GROUP BY produtos.nome;

-- Consulta 10: Mostrar os produtos que tiveram mais de uma unidade vendida.
SELECT produtos.nome, SUM(itens_venda.quantidade) AS unidades_vendidas
FROM produtos
INNER JOIN itens_venda
ON produtos.id_produto = itens_venda.id_produto
GROUP BY produtos.nome
HAVING SUM(itens_venda.quantidade) > 1;

-- Consulta 11: Mostrar produtos que custam mais do que a média de preços.
SELECT nome, preco
FROM produtos
WHERE preco > (SELECT AVG(preco) FROM produtos);

-- =====================================================
-- 4. TESTES SIMPLES
-- Descomente e execute um por vez para testar.
-- Esses comandos devem dar erro, de propósito.
-- =====================================================

-- Teste 1: Deve falhar porque o cliente 999 não existe.
-- INSERT INTO vendas (id_cliente, data_venda)
-- VALUES (999, '2026-09-10');

-- Teste 2: Deve falhar porque o produto 999 não existe.
-- INSERT INTO itens_venda (id_venda, id_produto, quantidade)
-- VALUES (1, 999, 1);

-- =====================================================
-- FIM DO SCRIPT
-- =====================================================
