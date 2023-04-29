
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


-- 20 Selecione o nome do cliente e o nome do produto nas vendas realizadas no mês  01.
-- 21 Selecione os nomes dos produtos do fornecedor Vivian Cabrera
-- 22 Selecione todos os fornecedores com CNPJ que inicie com 4
-- 23 Selecione todos os produtos que começam com consoantes.
-- 24 Selecione todos do item estoque, ordenado por datahora da venda
-- 25 Selecione todos os clientes que possuem compras feitas a partir de 2020.
-- 26Selecione todas as informações dos clientes.
-- 27 Selecione todos os nomes com Camel Case.
-- 28 Quem sobrescrever a query é corno e nerd (essa é massa)
-- 29 Selecione somente o segundo nome das pessoas.










