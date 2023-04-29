-- A. Nome da Categoria
select c.name from category as c

-- B. Nome do filme
select f.title from film as f

-- C. Nome do idiomas
select l.name from language as l

-- D. Nome do ator
select a.first_name, a.last_name from actor as a

-- E. Nome do Filme | Categoria (ordenado pelo nome do filme)
select f.title, c.name from film as f
	join film_category as fc
		on f.film_id = fc.film_id
	join category as c
		on fc.category_id = c.category_id
		 order by f.title
		 
-- F. Categoria | Nome do Filme (ordenado pela categoria)
select c.name, f.title from film as f
	join film_category as fc
		on f.film_id = fc.film_id
	join category as c
		on fc.category_id = c.category_id
		 order by c.name
		 
-- G. Nome do Filme | Idioma (ordenado pelo nome do filme)
select f.title, l.name from film as f
	join language as l
		on f.language_id = l.language_id
		order by f.title
		
-- H. Idioma | Nome do Filme (ordenado pelo idioma)
select l.name, f.title from film as f
	join language as l
		on f.language_id = l.language_id
		order by l.name
		
-- I. Categoria | Nome do Filme | Idioma (ordenado pela categoria)
select c.name, f.title, l.name from film as f
	join language as l
		on f.language_id = l.language_id
	join film_category as fc
		on f.film_id = fc.film_id
	join category as c
		on fc.category_id = c.category_id
		 order by c.name
	
-- J. Nome do Filme | Categoria | Idioma (ordenado pelo nome do filme)
select f.title, c.name, l.name from film as f
	join language as l
		on f.language_id = l.language_id
	join film_category as fc
		on f.film_id = fc.film_id
	join category as c
		on fc.category_id = c.category_id
		 order by f.title
		 
-- K. Idioma | Nome do Filme | Categoria (ordenado pelo idioma)
select l.name, f.title, c.name from film as f
	join language as l
		on f.language_id = l.language_id
	join film_category as fc
		on f.film_id = fc.film_id
	join category as c
		on fc.category_id = c.category_id
		 order by l.name
		 
-- L. Nome do Ator | Nome do Filme (ordenado pelo nome do ator)
select ac.first_name, ac.last_name, f.title from film as f
	join film_actor as fa
		on fa.film_id = f.film_id
	join actor as ac
		on fa.actor_id = ac.actor_id
		order by ac.first_name

-- M. Nome do Filme | Nome do Ator (ordenado pelo nome do filme)
select f.title, ac.first_name, ac.last_name from film as f
	join film_actor as fa
		on fa.film_id = f.film_id
	join actor as ac
		on fa.actor_id = ac.actor_id
		order by f.title

-- N. Categoria | Nome do Filme | Ator (ordenado pela categoria)
select c.name, f.title, ac.first_name, ac.last_name from film as f
	join film_actor as fa
		on fa.film_id = f.film_id
	join actor as ac
		on fa.actor_id = ac.actor_id
	join film_category as fc
		on f.film_id = fc.film_id
	join category as c
		on fc.category_id = c.category_id
		 order by c.name
		 
-- O. Ator | Categoria (ordenado pelo autor)
select ac.first_name, ac.last_name, c.name from film as f
	join film_actor as fa
		on fa.film_id = f.film_id
	join actor as ac
		on fa.actor_id = ac.actor_id
	join film_category as fc
		on f.film_id = fc.film_id
	join category as c
		on fc.category_id = c.category_id
		 order by ac.first_name

-- P. Nome da Cidade | Nome do País (ordenado pelo nome da cidade)
select c.city, p.country from country as p
	join city as c 
		on p.country_id = c.country_id
		order by c.city
		
-- Q. Nome do País | Nome da Cidade (ordenado pelo nome do país)
select p.country, c.city from country as p
	join city as c 
		on p.country_id = c.country_id
		order by p.country

-- R. Os idiomas que não tem filmes
select l.name from language as l
	left join film as f
			on f.language_id = l.language_id
			 where f.title is null
		 
-- S. Os atores que não tem filme em estoque
select ac.first_name, ac.last_name, f.title from film as f
	join film_actor as fa
		on fa.film_id = f.film_id
	join actor as ac
		on fa.actor_id = ac.actor_id
	left join inventory as inv
		on f.film_id = inv.film_id
		where inv.film_id is null
	
-- T. As categorias que não tem filmes
select c.name from category as c
	inner join film_category as fc
		on c.category_id = fc.category_id
		 where fc.film_id is null