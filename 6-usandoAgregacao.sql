-- 2-) Utilizando o banco de dados de vendas que você criou e os comandos de junção e
-- função de agregação, desenvolva consultas que respondam às questões a seguir
-- A. O número de clientes
SELECT COUNT(*) FROM cliente;

-- B. O número de vendas
SELECT COUNT(*) FROM venda;

-- C. O total (R$) de vendas
SELECT SUM (pr.preco) FROM produto AS pr
	INNER JOIN item_estoque AS ie
	ON pr.id_produto = ie.id_produto
		INNER JOIN venda AS ve
		ON ie.id_venda = ve.id_venda;
	
-- D. O total de produtos em estoque
SELECT COUNT (pr.id_produto) FROM produto AS pr
	INNER JOIN item_estoque AS ie
	ON pr.id_produto = ie.id_produto
	
-- E. O Total de produtos vendido
SELECT COUNT (pr.id_produto) FROM produto AS pr
	INNER JOIN item_estoque AS ie
	ON pr.id_produto = ie.id_produto
		INNER JOIN venda AS ve
		ON ie.id_venda = ve.id_venda;
	
-- F. O Total de clientes que realizou compras
SELECT COUNT (cl.id_cliente) FROM cliente AS cl
	INNER JOIN venda AS ve
	ON cl.id_cliente = ve.id_cliente;
	
-- G. A venda e o total de produtos
SELECT COUNT (pr.id_produto), ve.id_venda FROM produto AS pr
	INNER JOIN item_estoque AS ie
	ON pr.id_produto = ie.id_produto
		INNER JOIN venda AS ve
		ON ie.id_venda = ve.id_venda
		GROUP BY ve.id_venda;

-- H. A venda e o total em R$
SELECT SUM (pr.preco), ve.id_venda FROM produto AS pr
	INNER JOIN item_estoque AS ie
	ON pr.id_produto = ie.id_produto
		INNER JOIN venda AS ve
		ON ie.id_venda = ve.id_venda
		GROUP BY ve.id_venda
		ORDER BY SUM DESC;
	
-- I. O cliente e o número de vendas
SELECT COUNT (ve.id_venda), pe.nome FROM pessoa AS pe
	INNER JOIN cliente AS cl
	ON pe.id_pessoa = cl.id_cliente
		INNER JOIN venda AS ve
		ON cl.id_cliente = ve.id_cliente
		GROUP BY pe.nome
		ORDER BY COUNT DESC;
		
-- a. O Cliente que mais comprou
SELECT COUNT (ve.id_venda), pe.nome FROM pessoa AS pe
	INNER JOIN cliente AS cl
	ON pe.id_pessoa = cl.id_cliente
		INNER JOIN venda AS ve
		ON cl.id_cliente = ve.id_cliente
		GROUP BY pe.nome
		ORDER BY COUNT DESC
		LIMIT 1;
		
-- b. O Cliente que menos comprou
SELECT COUNT (ve.id_venda), pe.nome FROM pessoa AS pe
	INNER JOIN cliente AS cl
	ON pe.id_pessoa = cl.id_cliente
		INNER JOIN venda AS ve
		ON cl.id_cliente = ve.id_cliente
		GROUP BY pe.nome
		ORDER BY COUNT ASC
		LIMIT 1;
	
-- J. O cliente e o total de vendas R$
SELECT pe.nome, SUM(po.preco) FROM cliente AS cl
	INNER JOIN pessoa pe 
		ON cl.id_cliente = pe.id_pessoa
			INNER JOIN venda AS v 
			ON cl.id_cliente = v.id_cliente
				INNER JOIN item_estoque AS ie
				ON ie.id_venda = v.id_venda
					INNER JOIN produto AS po 
					ON ie.id_produto = po.id_produto
					GROUP BY (pe.nome)
					ORDER BY SUM DESC;
	
-- K. O fornecedor e o número de produtos fornecidos
SELECT p.nome, COUNT (pr.id_fornecedor) FROM fornecedor as f
	INNER JOIN pessoa AS p 
	ON f.id_fornecedor = p.id_pessoa
	INNER JOIN produto AS pr
	ON f.id_fornecedor = pr.id_fornecedor 
	GROUP BY (p.nome)
	
-- L. O fornecedor e o número de produtos vendidos
SELECT p.nome, COUNT (pr.id_fornecedor) FROM fornecedor AS f
	INNER JOIN pessoa AS p 
	ON f.id_fornecedor = p.id_pessoa
	INNER JOIN produto AS pr
	ON f.id_fornecedor = pr.id_fornecedor 
	INNER JOIN item_estoque AS ie
	ON ie.id_produto = pr.id_produto
	INNER JOIN venda AS v 
	ON ie.id_venda = v.id_venda
	GROUP BY(p.nome)
	
-- M. O fornecedor e o total vendido de produtos associados á ele
SELECT p.nome, COUNT (pr.id_fornecedor) FROM fornecedor AS f
	INNER JOIN pessoa AS p 
	ON f.id_fornecedor = p.id_pessoa
	INNER JOIN produto AS pr
	ON f.id_fornecedor = pr.id_fornecedor 
	INNER JOIN item_estoque AS ie
	ON ie.id_produto = pr.id_produto
	INNER JOIN venda AS v 
	ON ie.id_venda = v.id_venda
	GROUP BY(p.nome)
	