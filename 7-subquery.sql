CREATE TABLE pessoa (
id_pessoa SERIAL NOT NULL,
nome VARCHAR(100) NOT NULL,
endereco VARCHAR(100) NOT NULL,
PRIMARY KEY (id_pessoa)
);

INSERT INTO pessoa (nome, endereco)
VALUES
-- ('Lynn Avery','4891 Commodo St.'),
-- ('Bernard Mccall','473-2587 Imperdiet St.'),
-- ('Andrew Thomas','510-1455 Curabitur St.'),
-- ('Brock Roth','Ap #561-8577 Sem. Avenue'),
-- ('Wallace Vincent','100-9568 Ornare, Rd.'),
-- ('Vivian Cabrera','Ap #681-1378 Ullamcorper St.'),
-- ('Silas Donaldson','506 Mauris Street'),
-- ('Basil Haney','Ap #200-562 Nec, St.'),
-- ('Barclay Ramsey','181-8758 Consectetuer Rd.'),
-- ('Cruz Yang','487-7590 At Road'),
-- ('teste fornecedor sem produto', 'udesc'),
('teste pessoa !cliente && !fornecedor', 'rio rafael');

CREATE TABLE cliente (
id_cliente INT NOT NULL,
cpf VARCHAR(11),
PRIMARY KEY (id_cliente),
FOREIGN KEY (id_cliente) REFERENCES pessoa (id_pessoa)
);

INSERT INTO cliente (id_cliente, cpf)
VALUES
-- (1, '27391387096'),
-- (2, '46610745056'),
-- (3, '30918461057'),
-- (4, '08405369090'),
-- (5, '61441956026'),
-- (6, '14152284935'),
-- (7, null),
(8, '00000000000');

CREATE TABLE fornecedor (
id_fornecedor INT NOT NULL,
cnpj VARCHAR(14),
PRIMARY KEY (id_fornecedor),
FOREIGN KEY (id_fornecedor) REFERENCES pessoa (id_pessoa)
);

INSERT INTO fornecedor (id_fornecedor, cnpj)
VALUES
-- (6, '28532254000170'),
-- (7, '92519032000116'),
-- (8, '76409047000175'),
-- (9, '56453271000157'),
-- (10, '26825648000190'),
(11, '00000000000000');


CREATE TABLE produto (
id_produto SERIAL NOT NULL,
id_fornecedor INT NOT NULL,
nome VARCHAR(100) NOT NULL,
preco FLOAT NOT NULL,
PRIMARY KEY (id_produto),
FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id_fornecedor)
);


INSERT INTO produto (id_fornecedor, nome, preco)
VALUES
-- (6, 'Leite Vida Longa', 10.99),
-- (6, 'Iogurte Charmanito', 25),
-- (7, 'Nescatoddy', 40),
-- (7, 'Mortadela de Cavalo', 50),
-- (8, 'Pinho Lua', 70),
-- (8, 'Sab�o Cracra', 40.5),
-- (9, 'Frango Bovino', 20.75),
-- (9, 'Creme Dental Sorrizin', 80.60),
-- (10, 'Frango Bovino', 15.50),
-- (10, 'Coleira Segura Pe�o', 17.20),
-- (7, 'Guitarra', 18.000),
(7, 'Bateria', 10.000);


CREATE TABLE venda (
id_venda SERIAL NOT NULL,
id_cliente INT NOT NULL,
data_hora DATE NOT NULL,
PRIMARY KEY (id_venda),
FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);



INSERT INTO venda (id_cliente, data_hora)
VALUES
-- (1, '09/03/2022'),
-- (1, '01/25/2022'),
-- (2, '02/18/2022'),
-- (2, '01/16/2022'),
-- (3, '03/27/2022'),
-- (3, '03/30/2022'),
-- (4, '02/18/2022'),
-- (4, '02/02/2022'),
-- (5, '02/20/2022'),
-- (5, '05/01/2022'),
(7, '01/01/2023');



CREATE TABLE item_estoque (
id_item SERIAL NOT NULL,
id_produto INT NOT NULL,
id_venda INT,
PRIMARY KEY (id_item),
FOREIGN KEY (id_produto) REFERENCES produto (id_produto),
FOREIGN KEY (id_venda) REFERENCES venda (id_venda)
);


INSERT INTO item_estoque (id_produto, id_venda)
VALUES
(1, 1),
(1, 1),
(1, 1),
(1, 1),
(1, 1),
(2, 2),
(2, 2),
(2, 2),
(2, 2),
(2, 2),
(3, 3),
(3, 3),
(3, 3),
(3, 3),
(3, 3),
(4, 4),
(4, 4),
(4, 4),
(4, 4),
(4, 4),
(5, 5),
(5, 5),
(5, 5),
(5, 5),
(5, 5),
(6, 6),
(6, 6),
(6, 6),
(6, 6),
(6, 6),
(7, 7),
(7, 7),
(7, 7),
(7, 7),
(7, 7),
(8, 8),
(8, 8),
(8, 8),
(8, 8),
(8, 8),
(9, 9),
(9, 9),
(9, 9),
(9, 9),
(9, 9),
(12, null);


--   a. O nome das pessoas que são clientes e são fornecedores 
SELECT pe.nome FROM pessoa AS pe
WHERE id_pessoa IN(
	SELECT id_pessoa FROM cliente
		WHERE id_pessoa IN(
			SELECT id_pessoa FROM fornecedor
		)
);

--   b. Os produtos que não estão em estoque
SELECT id_produto FROM produto 
WHERE id_produto NOT IN(
	SELECT id_produto FROM item_estoque
);
--   c. Os produtos que estão em estoque mas nunca foram vendidos
SELECT id_produto FROM item_estoque AS ie
WHERE NOT EXISTS(
	SELECT 1
	FROM venda AS ve
	WHERE ie.id_venda = ve.id_venda
);

--   d. As vendas sem produtos
SELECT * FROM venda AS ve
	WHERE NOT EXISTS(
		SELECT 1 
		FROM item_estoque AS ie
		WHERE ie.id_venda = ve.id_venda
	);
	
--   e. Os clientes que nunca compraram
SELECT * FROM cliente AS cl
	WHERE NOT EXISTS(
		SELECT 1
		FROM venda AS ve
		WHERE ve.id_cliente = cl.id_cliente
	);

--   f. As pessoas que não são clientes
SELECT nome FROM pessoa AS pe
WHERE NOT EXISTS(
	SELECT 1 
	FROM cliente AS cl
	WHERE pe.id_pessoa = cl.id_cliente
);

--   g. As pessoas que não são fornecedores
SELECT nome FROM pessoa AS pe
WHERE NOT EXISTS(
	SELECT 1 
	FROM fornecedor AS fo
	WHERE pe.id_pessoa = fo.id_fornecedor
);
--   h. As pessoas que não são clientes, nem fornecedores
SELECT nome FROM pessoa AS pe 
WHERE NOT EXISTS(
	SELECT 1 
	FROM fornecedor AS fo
	WHERE pe.id_pessoa = fo.id_fornecedor
	AND NOT EXISTS(
		SELECT 1 
		FROM cliente AS cl
		WHERE pe.id_pessoa = cl.id_cliente
	)
);
--   i. Os fornecedores que não tem produto
SELECT nome FROM pessoa AS pe
WHERE EXISTS(
	SELECT 1 
	FROM fornecedor AS fo
	WHERE pe.id_pessoa = fo.id_fornecedor
	AND NOT EXISTS (
		SELECT 1 
		FROM produto AS pr 
		WHERE fo.id_fornecedor = pr.id_fornecedor
	)
);
--   j. Os nome dos clientes que nunca realizaram uma compra
SELECT pe.nome FROM pessoa AS pe 
WHERE EXISTS(
	SELECT 1 
	FROM cliente AS cl
	WHERE pe.id_pessoa = cl.id_cliente
	AND NOT EXISTS(
		SELECT 1 
		FROM venda AS ve
		WHERE cl.id_cliente = ve.id_cliente
	)
);
--   k. Liste o nome e o endereço dos fornecedores que não possuem nenhum produto cadastrado na tabela produto
SELECT pe.nome, pe.endereco FROM pessoa AS pe
WHERE EXISTS(
	SELECT 1 
	FROM fornecedor AS fo
	WHERE pe.id_pessoa = fo.id_fornecedor
	AND NOT EXISTS(
		SELECT 1 
		FROM produto AS pr
		WHERE fo.id_fornecedor = pr.id_fornecedor 
	)
);
--   l. Liste os clientes que não possuem CPF cadastrado na tabela cliente.
SELECT pe.nome FROM pessoa AS pe
WHERE EXISTS(
	SELECT 1
	FROM cliente AS cl
	WHERE pe.id_pessoa = cl.id_cliente
	AND cl.cpf IS NULL
);

--   m. Liste os clientes que fizeram alguma compra e que possuem CPF cadastrado na tabela cliente.
SELECT pe.nome FROM pessoa AS pe
WHERE EXISTS(
	SELECT 1
	FROM cliente AS cl
	WHERE pe.id_pessoa = cl.id_cliente
	AND cl.cpf IS NOT NULL
	AND EXISTS (
		SELECT 1 
		FROM venda AS ve
		WHERE cl.id_cliente = ve.id_cliente
	)
);
--   n. Liste o nome dos produtos e sua quantidade em estoque
SELECT pr.nome, COUNT(*) AS quantidade_estoque FROM produto AS pr
	INNER JOIN item_estoque AS ie
	ON pr.id_produto = ie.id_produto
	GROUP BY pr.nome
	ORDER BY pr.nome;
	
--   o. Liste o nome dos produtos e sua quantidade em estoque, dos produtos que tenham a maior quantidade. Ou seja, que seu estoque seja igual ao máximo (sem utilizar Limit)
SELECT pr.nome, COUNT(*) AS quantidade_estoque FROM produto AS pr
	INNER JOIN item_estoque AS ie
	ON pr.id_produto = ie.id_produto
	GROUP BY pr.nome
	HAVING COUNT(*) = (
		SELECT MAX(qe) FROM(
			SELECT COUNT(*) AS qe FROM produto AS pr
			INNER JOIN item_estoque AS ie
			ON pr.id_produto = ie.id_produto
			GROUP BY pr.nome
		)subquery_alias
	)
	
--   p. Liste o nome dos produtos e o valor total vendido, dos produtos que tenham a maior quantidade. Ou seja, que seu estoque seja igual ao máximo (sem utilizar Limit)
SELECT pr.nome, COUNT(*) as quantidade_estoque, SUM(pr.preco) AS valor_total
FROM produto pr
JOIN item_estoque ie ON pr.id_produto = ie.id_produto
GROUP BY pr.nome
HAVING COUNT(*) = (
    SELECT MAX(qe)
    FROM (
        SELECT COUNT(*) AS qe
        FROM produto pr
        JOIN item_estoque ie ON pr.id_produto = ie.id_produto
        GROUP BY pr.nome
    ) subquery_alias
);