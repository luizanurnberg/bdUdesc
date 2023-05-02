CREATE TABLE clientes (
  id_cliente SERIAL PRIMARY KEY,
  nome VARCHAR(100),
  cidade VARCHAR(50)
);

CREATE TABLE produtos (
  id_produto SERIAL PRIMARY KEY,
  nome VARCHAR(100),
  preco DECIMAL(10,2),
  estoque INT
);

CREATE TABLE pedidos (
  id_pedido SERIAL PRIMARY KEY,
  id_cliente INT REFERENCES clientes(id_cliente),
  data DATE,
  valor_total DECIMAL(10,2)
);

CREATE TABLE itens_pedidos (
  id_pedido INT REFERENCES pedidos(id_pedido),
  id_produto INT REFERENCES produtos(id_produto),
  quantidade INT,
  PRIMARY KEY (id_pedido, id_produto)
);

INSERT INTO clientes (nome, cidade) VALUES
('João', 'São Paulo'),
('Maria', 'Rio de Janeiro'),
('Pedro', 'Belo Horizonte'),
('Ana', 'Curitiba'),
('Lucas', 'São Paulo'),
('Mariana', 'Rio de Janeiro'),
('Fernando', 'Belo Horizonte'),
('Julia', 'Curitiba'),
('Diego', 'São Paulo'),
('Roberta', 'Rio de Janeiro');

INSERT INTO produtos (nome, preco, estoque) VALUES
('Camiseta', 49.99, 100),
('Calça', 89.99, 50),
('Tênis', 149.99, 30),
('Meia', 9.99, 200),
('Boné', 29.99, 80),
('Jaqueta', 199.99, 20),
('Shorts', 39.99, 70),
('Sapato', 129.99, 40),
('Saia', 59.99, 60),
('Vestido', 79.99, 40);

INSERT INTO pedidos (id_cliente, data, valor_total) VALUES
-- (1, '2022-01-01', 149.98),
-- (2, '2022-01-02', 269.97),
-- (3, '2022-01-03', 89.97),
-- (4, '2022-01-04', 319.96),
-- (5, '2022-01-05', 199.98),
-- (6, '2022-01-06', 139.97),
-- (7, '2022-01-07', 399.96),
-- (8, '2022-01-08', 69.98),
-- (9, '2022-01-09', 149.97),
-- (10, '2022-01-10', 49.98),
(10, '2022-01-10', 49.98);

INSERT INTO itens_pedidos (id_pedido, id_produto, quantidade) VALUES
-- (1, 1, 2),
-- (1, 3, 1),
-- (2, 2, 3),
-- (2, 4, 5),
-- (2, 5, 2),
-- (3, 1, 1),
-- (3, 2, 1),
-- (3, 3, 1),
-- (4, 6, 1),
-- (4, 7, 3),
-- (4, 10, 2),
-- (5, 2, 2),
-- (5, 4, 4),
-- (6, 1, 1),
-- (6, 9, 1),
-- (6, 10, 1),
-- (7, 1, 3),
-- (7, 2, 2),
-- (7, 3, 2),
-- (7, 4, 4),
-- (8, 8, 1),
-- (9, 1, 1),
-- (9, 4, 3),
-- (10, 1, 1),
(11, 1, 1);

-- a) Liste o nome e cidade dos clientes que já fizeram pelo menos um pedido contendo o produto "Camiseta" com preço inferior a R$50,00.
SELECT cl.nome, cl.cidade FROM clientes AS cl
	WHERE EXISTS(
		SELECT 1 
		FROM pedidos AS pe
		WHERE cl.id_cliente = pe.id_cliente
			AND EXISTS(
				SELECT 1
				FROM itens_pedidos AS itpe
				WHERE itpe.id_pedido = pe.id_pedido
				AND itpe.id_produto = 1
				AND pe.valor_total < 50
			)
	);
-- b) Liste os nomes dos produtos que foram comprados pelo menos uma vez em um pedido que tenha sido realizado pelo cliente "João", juntamente com o nome e a cidade do cliente.
SELECT pr.nome FROM produtos AS pr
	WHERE EXISTS(
		SELECT 1
		FROM itens_pedidos AS itpe
		WHERE pr.id_produto = itpe.id_produto
			AND EXISTS(
				SELECT 1
				FROM pedidos AS pe
				WHERE itpe.id_pedido = pe.id_pedido
					AND EXISTS (
						SELECT 1
						FROM clientes AS cl
						WHERE cl.id_cliente = 1
						AND pe.id_cliente = cl.id_cliente
					)
			)
	)
-- c) Liste o nome dos clientes que já fizeram mais de um pedido no mês de janeiro de 2023.
SELECT cl.nome FROM clientes AS cl
	WHERE EXISTS(
		SELECT 1 
		FROM pedidos AS pr
		WHERE cl.id_cliente = pr.id_cliente
		AND pr.data BETWEEN '2022/01/01' AND '2022/01/31'
	)
	GROUP BY cl.nome
	
-- d) Liste o nome e cidade dos clientes que já fizeram pelo menos um pedido de um produto que não esteja mais disponível em estoque.

INSERT INTO produtos (nome, preco, estoque)
VALUES ('Produto Sem Estoque', 10.50, 0);

INSERT INTO clientes (nome, cidade)
VALUES ('Fulano de Tal', 'São Paulo');

INSERT INTO pedidos (id_cliente, data, valor_total)
VALUES ((SELECT id_cliente FROM clientes WHERE nome = 'Fulano de Tal'), '2022-01-01', 10.50);

INSERT INTO itens_pedidos (id_pedido, id_produto, quantidade)
VALUES ((SELECT id_pedido FROM pedidos WHERE id_cliente = (SELECT id_cliente FROM clientes WHERE nome = 'Fulano de Tal')), (SELECT id_produto FROM produtos WHERE nome = 'Produto Sem Estoque'), 1);

SELECT cl.nome, cl.cidade FROM clientes AS cl
	WHERE EXISTS(
		SELECT 1 
		FROM itens_pedidos AS ip
		INNER JOIN produtos AS pr
		ON ip.id_produto = pr.id_produto
		INNER JOIN pedidos AS pe
		ON ip.id_pedido = pe.id_pedido
		AND pr.estoque = 0
	)
	
-- e) Liste o nome dos clientes que já fizeram pelo menos um pedido contendo um produto que tenha sido comprado pelo cliente "Maria", mas não tenha sido comprado pelo cliente "João".

-- f) Liste o nome dos produtos que já foram comprados pelo menos uma vez por todos os clientes que moram na cidade de "São Paulo".

-- g) Liste o nome dos clientes que fizeram um pedido contendo pelo menos um produto com estoque inferior a 10 unidades, ordenados pelo número de produtos pedidos.

-- h) Liste o nome dos clientes que já fizeram pelo menos um pedido contendo um produto que custe mais do que o preço médio dos produtos comprados por todos os clientes.

-- i) Liste o nome dos clientes que já fizeram pelo menos um pedido contendo um produto que tenha sido comprado pelo menos uma vez em um pedido que tenha sido realizado pela cliente "Maria".

-- j) Liste o nome dos produtos que foram comprados em um pedido cujo valor total foi superior a R$500,00 e a quantidade total de itens vendidos do produto foi inferior a 5 unidades.

-- k) Liste o nome dos produtos que foram comprados em todos os pedidos realizados pelo cliente "José".

-- l) Liste o nome dos clientes que já fizeram pelo menos um pedido de um produto que tenha sido comprado por todos os clientes que já fizeram algum pedido.


