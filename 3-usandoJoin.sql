
-- 1 Selecione todas as informações de todos os fornecedores
select * from fornecedor

-- 2 elecione todos os produtos com preço maior que R$50,00
select * from produto where preco > 50

-- 3 Selecione o nome de todos os clientes em ordem alfabética
select nome
from pessoa as p,
cliente as c
where c.id_cliente = p.id_pessoa
order by nome

-- 4 Selecione todos os itens do estoque com seu respectivo nome (produto)
select nome from item_estoque as it, produto as prod

-- 5 Selecione todos os produtos com preço menor que 50
select * from produto
where preco < 50

-- 6 Selecione todos os itens do estoque com valor maior que 100 e retorne o nome do produto 
select nome from item_estoque as it, produto as p  
where preco > 100

-- 7 Selecione todos os produtos com preço ordenado do maior para o menor
select * from produto 
order by preco desc

-- 8 não era para fazer

-- 9 ordena todos os produtos por preço
select * from produto 
order by preco asc

-- 10 Selecione o valor total dos produtos
select sum(preco) from produto p 

-- 11 Selecione todos os clientes, cujo o nome começa com 'A'
select nome from cliente c, pessoa p 
where c.id_cliente = p.id_pessoa  
and p.nome like 'a%'

-- 12  Selecione todas as vendas realizadas no mês 01
select * from venda 
where data_hora 
between '2022-01-01' and '2022-01-31'

-- 13 Selecione o nome dos clientes que compraram no mês de fevereiro de 2022.
select nome from pessoa p, cliente c, venda v  
where p.id_pessoa = c.id_cliente 
and v.id_cliente = c.id_cliente 


-- 14 não era para fazer

-- 15 Selecione todos os produtos vendidos em um intervalo de datas
select * from produto p, venda v
where v.data_hora 
BETWEEN '2022-01-01' and '2022-01-31'

-- 16 Selecione todos os clientes que fizeram compra em  30/03/2022
select c.id_cliente from cliente c, venda v 
where v.id_cliente = c.id_cliente 
and v.data_hora = '2022-03-30'

-- 17 Selecione todas as vendas realizadas no mês 3 cujo clientes possuem a letra “a” no nome 
select nome from venda v, cliente c, pessoa p 
where v.id_cliente = c.id_cliente 
and v.data_hora BETWEEN '2022-01-03' and '2022-31-03'
and p.nome LIKE 'a%'


----------------------------------------------

-- a. Todas as vendas e o nome do cliente
select p.nome as nome_pessoa, v.id_venda as venda from pessoa as p
	inner join cliente as c 
		on p.id_pessoa = c.id_cliente 
	inner join venda as v
		on c.id_cliente = v.id_cliente

-- b. O nome do produto
select id_item, nome from item_estoque ie 
	inner join produto as p 
		on ie.id_produto = p.id_produto 
		
		
-- c. O nome do produto que foi lançado no estoque
select id_item, nome from item_estoque ie 
	inner join produto as p 
		on ie.id_produto = p.id_produto 
		
-- d. O nome do produto que foi vendido
select p.nome from produto as p
	inner join venda v 
		on p.id_produto = v.id_venda 
	inner join item_estoque ie 
		on ie.id_venda = v.id_venda 
	
-- e. O nome das pessoas que são clientes mas não são fornecedores
select p.nome from pessoa as p
 inner join cliente as c 
 	on p.id_pessoa = c.id_cliente 
	 left join fornecedor as f 
		on p.id_pessoa = f.id_fornecedor 
			where f.id_fornecedor is NULL 
				
-- f. O nome das pessoas que são clientes e são fornecedores
select p.nome from pessoa as p
 inner join cliente as c 
 	on p.id_pessoa = c.id_cliente 
	 RIGHT join fornecedor as f 
		on p.id_pessoa = f.id_fornecedor 

-- g. Os produtos que não estão em estoque
select id_item, nome from item_estoque as ie 
	left join produto as p 
		on ie.id_produto = p.id_produto 
		 where p.id_produto is NULL 

			
-- h. Os produtos que estão em estoque mas nunca foram vendidos
select p.* from produto as p 
	left join item_estoque as ie
		on p.id_produto = ie.id_produto 
		 where ie.id_venda is NULL 
	
	
-- i. As vendas sem produtos
select * from venda as v
	left join item_estoque ie 
	 on v.id_venda = ie.id_venda 
	 where ie.id_produto is NULL 
	 
-- j. Os clientes que nunca compraram
select * from cliente as c
	left join venda as v 
	on c.id_cliente = v.id_cliente 
	where v.id_venda is NULL 
	
-- k. As pessoas que não são clientes
select id_pessoa, nome from pessoa as p
	left join cliente c 
      on p.id_pessoa = c.id_cliente 
       where c.id_cliente is NULL 
       
-- l. As pessoas que não são fornecedores
 select id_pessoa, nome from pessoa as p
	left join fornecedor f  
      on p.id_pessoa = f.id_fornecedor  
       where f.id_fornecedor  is NULL     

-- m. As pessoas que não são clientes, nem fornecedores
select p.nome from pessoa as p
 left join cliente as c 
 	on p.id_pessoa = c.id_cliente 
	 left join fornecedor as f 
		on p.id_pessoa = f.id_fornecedor 
       
-- n. Os fornecedores que não tem produto
select * from fornecedor as f
	left join produto as p
	 on f.id_fornecedor = p.id_fornecedor 
	 where p.id_produto is NULL 
	 
-- o. Os nome dos clientes que nunca realizaram uma compra
select p.nome from venda as v
	right join cliente as c 
		on v.id_cliente = c.id_cliente 
	join pessoa as p 
		on c.id_cliente =p.id_pessoa 
		where id_venda is null
	
	




