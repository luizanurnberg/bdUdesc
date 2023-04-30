-- 1 Selecione todas as informações de todos os fornecedores
SELECT * FROM fornecedor;

-- 2 Selecione todos os produtos com preço maior que R$50,00
SELECT * FROM produto AS pr
WHERE pr.preco > 50;

-- 3 Selecione o nome de todos os clientes em ordem alfabética
SELECT nome FROM pessoa AS pe 
INNER JOIN cliente AS cl
	ON pe.id_pessoa = cl.id_cliente
	ORDER BY nome;

-- 4 Selecione todos os itens do estoque com seu respectivo nome (produto)
SELECT ie.id_produto, pr.nome FROM produto AS pr
INNER JOIN item_estoque AS ie 
	ON pr.id_produto = ie.id_produto
	GROUP BY ie.id_produto, pr.nome
	ORDER BY ie.id_produto;
	
-- 5 Selecione todos os produtos com preço menor que 50
SELECT pr.nome, pr.preco FROM produto AS pr
WHERE pr.preco < 50
	ORDER BY pr.preco;

-- 6 Selecione todos os itens do estoque com valor maior que 100 e retorne o nome do produto 
INSERT INTO produto (id_produto, id_fornecedor, nome, preco) VALUES (13, 7, 'MacBook', 7000);
INSERT INTO item_estoque (id_item, id_produto, id_venda) VALUES (48, 13, 9);
SELECT pr.nome, pr.preco FROM item_estoque AS ie
INNER JOIN produto AS pr 
	ON ie.id_produto = pr.id_produto
	WHERE pr.preco > 100;

-- 7 Selecione todos os produtos com preço ordenado do maior para o menor
SELECT pr.nome, pr.preco FROM produto AS pr
ORDER BY pr.preco DESC;

-- 9 Ordenar todos os produtos por preço
SELECT pr.nome, pr.preco FROM produto AS pr
ORDER BY pr.preco;

-- 10 Selecione o valor total dos produtos
SELECT SUM(pr.preco) FROM produto AS pr;

-- 11 Selecione todos os clientes, cujo o nome começa com 'A'
SELECT pe.nome FROM pessoa AS pe
INNER JOIN cliente AS cl 
	ON pe.id_pessoa = cl.id_cliente
	WHERE pe.nome LIKE 'A%';
	
-- 12  Selecione todas as vendas realizadas no mês 01
SELECT * FROM venda
SELECT ve.id_venda, ve.data_hora FROM venda AS ve
WHERE ve.data_hora BETWEEN '2022/01/01' AND '2022/01/31';

-- 13 Selecione o nome dos clientes que compraram no mês de fevereiro de 2022.
SELECT pe.nome, ve.data_hora FROM pessoa AS pe
INNER JOIN cliente AS cl 
	ON pe.id_pessoa = cl.id_cliente
		INNER JOIN venda AS ve
			ON cl.id_cliente = ve.id_cliente 
			WHERE ve.data_hora BETWEEN '2022/02/01' AND '2022/02/28';

-- 15 Selecione todos os produtos vendidos em um intervalo de datas
SELECT pr.nome, ve.data_hora FROM produto AS pr
INNER JOIN item_estoque AS ie
	ON pr.id_produto = ie.id_produto
		INNER JOIN venda AS ve
			ON ie.id_venda = ve.id_venda
			WHERE ve.data_hora BETWEEN '2022/03/01' AND '2022/03/31';

-- 16 Selecione todos os clientes que fizeram compra em  30/03/2022
SELECT pe.nome, ve.data_hora FROM pessoa AS pe
INNER JOIN cliente AS cl 
	ON pe.id_pessoa = cl.id_cliente
		INNER JOIN venda AS ve
			ON cl.id_cliente = ve.id_cliente 
			WHERE ve.data_hora = '2022/03/30';

-- 17 Selecione todas as vendas realizadas no mês 3 cujo clientes possuem a letra “a” no nome 
SELECT pe.nome, ve.data_hora FROM pessoa AS pe
INNER JOIN cliente AS cl 
	ON pe.id_pessoa = cl.id_cliente
		INNER JOIN venda AS ve
			ON cl.id_cliente = ve.id_cliente 
			WHERE ve.data_hora = '2022/03/30'
			AND pe.nome LIKE 'A%';
----------------------------------------------

-- a. Todas as vendas e o nome do cliente
SELECT pe.nome, ve.id_venda FROM pessoa AS pe
INNER JOIN cliente AS cl 
	ON pe.id_pessoa = cl.id_cliente
		INNER JOIN venda AS ve
			ON cl.id_cliente = ve.id_cliente;
			
-- b. O nome do produto
SELECT pr.nome FROM produto AS pr
ORDER BY pr.nome;	
		
-- c. O nome do produto que foi lançado no estoque
SELECT pr.nome, ie.id_produto FROM produto AS pr
INNER JOIN item_estoque AS ie
	ON pr.id_produto = ie.id_produto;
		
-- d. O nome do produto que foi vendido
SELECT pr.nome, ve.id_venda FROM produto AS pr
INNER JOIN item_estoque AS ie
	ON pr.id_produto = ie.id_produto
		INNER JOIN venda AS ve
			ON ie.id_venda = ve.id_venda;
	
-- e. O nome das pessoas que são clientes mas não são fornecedores
SELECT pe.nome FROM pessoa AS pe 
INNER JOIN cliente AS cl
	ON pe.id_pessoa = cl.id_cliente
		LEFT JOIN fornecedor AS fo
			ON pe.id_pessoa = fo.id_fornecedor;
				
-- f. O nome das pessoas que são clientes e são fornecedores
SELECT pe.nome FROM pessoa AS pe 
INNER JOIN cliente AS cl
	ON pe.id_pessoa = cl.id_cliente
		INNER JOIN fornecedor AS fo
			ON pe.id_pessoa = fo.id_fornecedor;

-- g. Os produtos que não estão em estoque
SELECT id_item, nome FROM item_estoque AS ie 
	LEFT JOIN produto AS p 
		ON ie.id_produto = p.id_produto 
		 WHERE p.id_produto IS NULL 

			
-- h. Os produtos que estão em estoque mas nunca foram vendidos
SELECT p.* FROM produto AS p 
	LEFT JOIN item_estoque AS ie
		ON p.id_produto = ie.id_produto 
		 WHERE ie.id_venda IS NULL 
	
	
-- i. As vendas sem produtos
SELECT * FROM venda AS v
	LEFT JOIN item_estoque ie 
	ON v.id_venda = ie.id_venda 
	WHERE ie.id_produto IS NULL 
	 
-- j. Os clientes que nunca compraram
SELECT * FROM cliente AS c
	LEFT JOIN venda AS v 
	ON c.id_cliente = v.id_cliente 
	WHERE v.id_venda IS NULL 
	
-- k. As pessoas que não são clientes
SELECT id_pessoa, nome FROM pessoa AS p
	LEFT JOIN cliente c 
      on p.id_pessoa = c.id_cliente 
       where c.id_cliente is NULL 
       
-- l. As pessoas que não são fornecedores
 SELECT id_pessoa, nome FROM pessoa AS p
	LEFT JOIN fornecedor f  
      ON p.id_pessoa = f.id_fornecedor  
       WHERE f.id_fornecedor  IS NULL     

-- m. As pessoas que não são clientes, nem fornecedores
SELECT p.nome FROM pessoa AS p
 LEFT JOIN cliente AS c 
 	ON p.id_pessoa = c.id_cliente 
	 LEFT JOIN fornecedor AS f 
		ON p.id_pessoa = f.id_fornecedor 
       
-- n. Os fornecedores que não tem produto
SELECT * FROM fornecedor AS f
	LEFT JOIN produto AS p
	 ON f.id_fornecedor = p.id_fornecedor 
	 WHERE p.id_produto IS NULL 
	 
-- o. Os nome dos clientes que nunca realizaram uma compra
SELECT p.nome FROM venda AS v
	RIGHT JOIN cliente AS c 
		ON v.id_cliente = c.id_cliente 
	INNER JOIN pessoa AS p 
		ON c.id_cliente = p.id_pessoa 
		WHERE id_venda IS NULL
	
	

