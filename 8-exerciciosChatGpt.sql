CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nome TEXT,
    cidade TEXT
);

CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY,
    id_cliente INTEGER,
    data DATE,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

INSERT INTO clientes (id_cliente, nome, cidade) VALUES
-- (1, 'Ana', 'São Paulo'),
-- (2, 'João', 'Rio de Janeiro'),
-- (3, 'Maria', 'Curitiba'),
-- (4, 'Pedro', 'São Paulo'),
-- (5, 'Lucas', 'Curitiba'),
-- (6, 'Carla', 'São Paulo'),
-- (7, 'Márcio', 'Curitiba'),
-- (8, 'Juliana', 'Rio de Janeiro'),
-- (9, 'Luiz', 'São Paulo'),
-- (10, 'Fernanda', 'Curitiba'),
(11, 'cliente sem pedido', 'udesc');

INSERT INTO pedidos (id_pedido, id_cliente, data, valor_total) VALUES
(1, 1, '2021-05-01', 100.00),
(2, 2, '2022-01-15', 50.00),
(3, 3, '2022-03-20', 75.00),
(4, 4, '2022-02-10', 200.00),
(5, 5, '2021-11-30', 300.00),
(6, 6, '2022-04-02', 150.00),
(7, 7, '2022-05-10', 80.00),
(8, 8, '2021-09-20', 120.00),
(9, 9, '2022-06-05', 90.00),
(10, 10, '2022-04-25', 60.00),
(11, 1, '2022-03-15', 50.00),
(12, 3, '2021-07-01', 80.00),
(13, 5, '2022-01-10', 120.00),
(14, 7, '2021-10-25', 40.00),
(15, 9, '2021-12-05', 70.00);

-- a) Escreva uma consulta que retorne todos os clientes que moram na cidade "São Paulo", ordenados pelo nome em ordem alfabética.
SELECT cl.nome FROM clientes AS cl
WHERE cl.cidade = 'São Paulo'
ORDER BY cl.nome;

-- b) Escreva uma consulta que retorne os 5 primeiros clientes que moram em "Rio de Janeiro" e que já fizeram pelo menos um pedido.
SELECT COUNT(pe.id_pedido) AS total_pedidos, cl.nome FROM clientes AS cl
	INNER JOIN pedidos AS pe
	ON cl.id_cliente = pe.id_cliente 
	WHERE cl.cidade = 'Rio de Janeiro'
	GROUP BY cl.nome
	HAVING COUNT (*) > 0
	ORDER BY COUNT (*) DESC LIMIT 5;
	
-- c) Escreva uma consulta que retorne o número total de pedidos feitos pelos clientes que moram em "Curitiba".
SELECT COUNT(pe.id_pedido) FROM pedidos AS pe
	INNER JOIN clientes AS cl
	ON pe.id_cliente = cl.id_cliente
	WHERE cl.cidade = 'Curitiba';
	
-- d) Escreva uma consulta que retorne o valor total de pedidos feitos pelos clientes que moram em "São Paulo" e que foram realizados em 2022.
SELECT COUNT(pe.id_pedido) FROM pedidos AS pe
	INNER JOIN clientes AS cl
	ON pe.id_cliente = cl.id_cliente
	WHERE cl.cidade = 'São Paulo'
	AND pe.data BETWEEN '2022-01-01' AND '2022-01-31';
	
-- e) Escreva uma consulta que retorne o nome dos clientes que fizeram pelo menos um pedido, juntamente com o valor total de seus pedidos.
SELECT COUNT(pe.id_pedido), SUM(pe.valor_total), cl.nome FROM clientes AS cl
	INNER JOIN pedidos AS pe
	ON cl.id_cliente = pe.id_cliente 
	GROUP BY cl.nome
	ORDER BY COUNT(*) DESC LIMIT 5;
	
-- f) Escreva uma consulta que retorne o nome dos clientes que fizeram pelo menos um pedido em 2021, juntamente com a quantidade total de pedidos feitos por cada um deles.
SELECT cl.nome, COUNT(pe.id_pedido) FROM clientes AS cl
	INNER JOIN pedidos AS pe
	ON cl.id_cliente = pe.id_cliente 
	WHERE pe.data BETWEEN '2021/01/01' AND '2021/01/31'
	GROUP BY cl.nome
	HAVING COUNT(*) > 0
	ORDER BY COUNT(*) DESC LIMIT 5;
	
-- g) Escreva uma consulta que retorne o nome dos clientes que nunca fizeram um pedido.
SELECT cl.nome FROM clientes AS cl
	LEFT JOIN pedidos AS pe
	ON cl.id_cliente = pe.id_cliente
	WHERE pe.id_pedido IS NULL;
	
-- h) Escreva uma consulta que retorne o nome dos clientes que fizeram pelo menos um pedido e a data do seu primeiro pedido, ordenados pelo nome em ordem alfabética.
SELECT cl.nome, MIN(pe.data) FROM clientes AS cl
	INNER JOIN pedidos AS pe 
	ON cl.id_cliente = pe.id_cliente 
	GROUP BY cl.nome
	ORDER BY cl.nome;
