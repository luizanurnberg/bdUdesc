CREATE TABLE pessoa (
id_pessoa SERIAL NOT NULL,
nome VARCHAR(100) NOT NULL,
endereco VARCHAR(100) NOT NULL,
PRIMARY KEY (id_pessoa)
);

INSERT INTO pessoa (nome, endereco)
VALUES
('Lynn Avery','4891 Commodo St.'),
('Bernard Mccall','473-2587 Imperdiet St.'),
('Andrew Thomas','510-1455 Curabitur St.'),
('Brock Roth','Ap #561-8577 Sem. Avenue'),
('Wallace Vincent','100-9568 Ornare, Rd.'),
('Vivian Cabrera','Ap #681-1378 Ullamcorper St.'),
('Silas Donaldson','506 Mauris Street'),
('Basil Haney','Ap #200-562 Nec, St.'),
('Barclay Ramsey','181-8758 Consectetuer Rd.'),
('Cruz Yang','487-7590 At Road');

CREATE TABLE cliente (
id_cliente INT NOT NULL,
cpf VARCHAR(11),
PRIMARY KEY (id_cliente),
FOREIGN KEY (id_cliente) REFERENCES pessoa (id_pessoa)
);

INSERT INTO cliente (id_cliente, cpf)
VALUES
(1, '27391387096'),
(2, '46610745056'),
(3, '30918461057'),
(4, '08405369090'),
(5, '61441956026');

CREATE TABLE fornecedor (
id_fornecedor INT NOT NULL,
cnpj VARCHAR(14),
PRIMARY KEY (id_fornecedor),
FOREIGN KEY (id_fornecedor) REFERENCES pessoa (id_pessoa)
);

INSERT INTO fornecedor (id_fornecedor, cnpj)
VALUES
(6, '28532254000170'),
(7, '92519032000116'),
(8, '76409047000175'),
(9, '56453271000157'),
(10, '26825648000190');


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
(6, 'Leite Vida Longa', 10.99),
(6, 'Iogurte Charmanito', 25),
(7, 'Nescatoddy', 40),
(7, 'Mortadela de Cavalo', 50),
(8, 'Pinho Lua', 70),
(8, 'Sab�o Cracra', 40.5),
(9, 'Frango Bovino', 20.75),
(9, 'Creme Dental Sorrizin', 80.60),
(10, 'Frango Bovino', 15.50),
(10, 'Coleira Segura Pe�o', 17.20);


CREATE TABLE venda (
id_venda SERIAL NOT NULL,
id_cliente INT NOT NULL,
data_hora DATE NOT NULL,
PRIMARY KEY (id_venda),
FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);



INSERT INTO venda (id_cliente, data_hora)
VALUES
(1, '2022/03/18'),
(1, '2022/01/25'),
(2, '2022/01/18'),
(2, '2022/01/16'),
(3, '2022/01/27'),
(3, '2022/03/22'),
(4, '2022/02/18'),
(4, '2022/02/02'),
(5, '2022/02/20'),
(5, '2022/01/05');



CREATE TABLE item_estoque (
id_item SERIAL NOT NULL,
id_produto INT NOT NULL,
id_venda INT NOT NULL,
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
(10, 10),
(10, 10),
(10, 10),
(10, 10),
(10, 10);

-- 2-) Utilizando o banco de dados de vendas que você criou e os comandos de junção e
-- função de agregação, desenvolva consultas que respondam às questões a seguir
-- A. O número de clientes
select count (id_cliente) from cliente 

-- B. O número de vendas
select count (id_venda) from venda

-- C. O total (R$) de vendas
select sum (p.preco) from produto as p
	inner join item_estoque as ie
	on p.id_produto = ie.id_produto
	inner join venda as v
	on ie.id_venda = v.id_venda
	
-- D. O total de produtos em estoque
select sum (p.id_produto) from produto as p 
	right join item_estoque as ie
	on p.id_produto = ie.id_produto 
	
-- E. O Total de produtos vendido
select sum (p.preco) from produto as p
	left join item_estoque as ie
	on p.id_produto = ie.id_produto
	inner join venda as v
	on ie.id_venda = v.id_venda
	
-- F. O Total de clientes que realizou compras
select sum(c.id_cliente) from cliente as c
	right join venda as v 
	on c.id_cliente = v.id_cliente 
	
-- G. A venda e o total de produtos
select v.id_venda, sum(p.id_produto) from venda as v
	inner join item_estoque as ie
	on ie.id_venda = v.id_venda
	inner join produto as p 
	on ie.id_produto = p.id_produto
	group by (v.id_venda)
	order by (v.id_venda)
	
-- H. A venda e o total em R$
select v.id_venda, sum(p.preco) from venda as v
	inner join item_estoque as ie
	on ie.id_venda = v.id_venda
	inner join produto as p 
	on ie.id_produto = p.id_produto
	group by (v.id_venda)
	order by (v.id_venda)
	
-- I. O cliente e o número de vendas
select p.nome, count(v.id_venda) from cliente as c
	inner join pessoa p 
	on c.id_cliente = p.id_pessoa
	right join venda as v 
	on c.id_cliente = v.id_cliente
	group by (p.nome)
	order by count desc 
	
-- a. O Cliente que mais comprou
select p.nome, count(v.id_venda) from cliente as c
	inner join pessoa p 
	on c.id_cliente = p.id_pessoa
	right join venda as v 
	on c.id_cliente = v.id_cliente
	group by (p.nome)
	order by count desc limit 1
	
-- b. O Cliente que menos comprou
select p.nome, count(v.id_venda) from cliente as c
	inner join pessoa p 
	on c.id_cliente = p.id_pessoa
	right join venda as v 
	on c.id_cliente = v.id_cliente
	group by (p.nome)
	order by count asc limit 1
	
-- J. O cliente e o total de vendas R$
select p.nome, sum(po.preco) from cliente as c
	inner join pessoa p 
	on c.id_cliente = p.id_pessoa
	right join venda as v 
	on c.id_cliente = v.id_cliente
	inner join item_estoque as ie
	on ie.id_venda = v.id_venda
	inner join produto as po 
	on ie.id_produto = po.id_produto
	group by (p.nome)
	order by count desc limit 1
	
-- K. O fornecedor e o número de produtos fornecidos
select p.nome, count (pr.id_fornecedor) from fornecedor as f
	right join pessoa as p 
	on f.id_fornecedor = p.id_pessoa
	inner join produto as pr
	on f.id_fornecedor = pr.id_fornecedor 
	group by (p.nome)
	
-- L. O fornecedor e o número de produtos vendidos
select p.nome, count (pr.id_fornecedor) from fornecedor as f
	right join pessoa as p 
	on f.id_fornecedor = p.id_pessoa
	inner join produto as pr
	on f.id_fornecedor = pr.id_fornecedor 
	right join item_estoque as ie
	on ie.id_produto = pr.id_produto
	right join venda as v 
	on ie.id_venda = v.id_venda
	group by (p.nome)
	
-- M. O fornecedor e o total vendido de produtos associados á ele
select p.nome, count (pr.id_fornecedor) from fornecedor as f
	right join pessoa as p 
	on f.id_fornecedor = p.id_pessoa
	inner join produto as pr
	on f.id_fornecedor = pr.id_fornecedor 
	right join item_estoque as ie
	on ie.id_produto = pr.id_produto
	right join venda as v 
	on ie.id_venda = v.id_venda
	group by (p.nome)
	