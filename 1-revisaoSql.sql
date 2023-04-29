CREATE TABLE fabricante (
	id_fabricante integer not null,
	nome_fabricante varchar not null,
	
	primary key(id_fabricante)
);

CREATE TABLE vacina (
	id_vacina integer not null,
	id_fabricante integer not null,
	nome_vacina varchar not null,
	
	foreign key(id_fabricante) references fabricante(id_fabricante),
	primary key (id_vacina)
);

CREATE TABLE lote (
	id_lote integer not null,
	id_vacina integer not null,
	data_fabricacao date not null,
	data_validade date not null,
	
	foreign key(id_vacina) references vacina(id_vacina),
	primary key(id_lote)
);

CREATE TABLE dose (
	id_dose integer not null,
	id_lote integer not null,
	
	foreign key(id_lote) references lote(id_lote),
	primary key(id_dose)
);

CREATE TABLE grupo (
	id_grupo integer not null,
	nome_grupo varchar not null,
	
	primary key(id_grupo)
);

CREATE TABLE pessoa (
	id_pessoa integer not null,
	id_grupo integer not null,
	nome_pessoa varchar not null,
	sobrenome_pessoa varchar not null,
	
	foreign key(id_grupo) references grupo(id_grupo),
	primary key(id_pessoa)
);

CREATE TABLE aplicacao (
	id_aplicacao integer not null,
	id_dose integer not null,
	id_pessoa integer not null,
	data_aplicacao date not null,
	
	foreign key(id_dose) references dose(id_dose),
	foreign key(id_pessoa) references pessoa(id_pessoa),
	primary key(id_aplicacao)
);


INSERT INTO fabricante (nome_fabricante)
	values ('P-fizer'), ('Oxford'), ('Butantan'), ('Janssen');

INSERT INTO fabricante (id_fabricante)
	values (1), (2), (3), (4);


UPDATE fabricante 
	set nome_fabricante = 'José'
	where id_fabricante = 1;

UPDATE fabricante 
	set nome_fabricante = 'Nicolas'
	where id_fabricante = 2;

DELETE FROM fabricante where id_fabricante = 1;
DELETE FROM fabricante where id_fabricante = 2;




