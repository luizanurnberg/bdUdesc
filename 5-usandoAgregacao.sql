-- 1-) Utilizando o banco de dados de dvdrenral e os comandos de junção e função de
-- agregação, desenvolva consultas que respondam às questões a seguir
-- a. Qual o número de locação?
select count (*) from rental 

-- b. Qual o número de locações que foram pagas?
select count (rental_id) from payment 

-- c. Qual o valor total que a locadora movimentou?
select sum (amount) from payment 

-- d. Qual o valor total movimentado de 07/07/2005 até 23/08/2005?
select sum (amount) from payment 
	where payment_date between '2005/07/07' and '2005/08/23'
	
-- e. Qual a média do valor movimentado de 07/07/2005 até 23/08/2005?
select avg (amount) from payment 
	where payment_date between '2005/07/07' and '2005/08/23'
	
-- f. Quantos filmes existem por categoria?
select sum (f.film_id), c.name from film as f
	join film_category as fc
		on f.film_id = fc.film_id
	join category as c
		on fc.category_id = c.category_id
		 group by (c.name)
		 order by (c.name)
		 
-- g. Quantos atores existem por categoria?
select sum(ac.actor_id), c.name from film as f
	join film_actor as fa
		on fa.film_id = f.film_id
	join actor as ac
		on fa.actor_id = ac.actor_id
	join film_category as fc
		on f.film_id = fc.film_id
	join category as c
		on fc.category_id = c.category_id
		 group by (c.name)
		 order by (c.name)

-- h. Quantos idiomas tem por filme?
select sum (l.language_id), f.title from film as f
	join language as l
		on f.language_id = l.language_id
	join film_category as fc
		on f.film_id = fc.film_id
		group by (f.title)
		 order by (f.title)
		 
-- i. Quais atores fizeram mais filmes?
select sum (f.film_id), ac.first_name, ac.last_name from film as f
	join film_actor as fa
		on fa.film_id = f.film_id
	join actor as ac
		on fa.actor_id = ac.actor_id
		group by (ac.first_name, ac.last_name)
		order by sum desc
				
-- j. Qual o número de cliente por cidade?
select sum(co.customer_id), city from city as c 
	inner join address as a  
	on c.city_id = a.city_id
	inner join customer as co
	on a.address_id = co.address_id
	group by (city)
		
-- k. Qual a quantidade de filme por categoria?
select sum (f.film_id), c.name from film as f
	join film_category as fc
		on f.film_id = fc.film_id
	join category as c
		on fc.category_id = c.category_id
		 group by (c.name)
		 order by (c.name)
		 
-- l. Quais foram as 10 categorias mais locadas?
select sum(rental_id), ca.name from rental as r 
	inner join inventory as i
	on r.inventory_id = i.inventory_id 
	inner join film_category as fc
	on i.film_id = fc.film_id
	inner join category as ca 
	on fc.category_id = ca.category_id
	group by (ca.name)
	order by sum desc limit 10
	
-- m. Quais foram as 10 categorias mais rentáveis?
select sum (amount), ca.name from payment as p
	inner join rental as r
	on p.rental_id = r.rental_id
	inner join inventory as i
	on r.inventory_id = i.inventory_id 
	inner join film_category as fc
	on i.film_id = fc.film_id
	inner join category as ca 
	on fc.category_id = ca.category_id
	group by (ca.name)
	order by sum desc limit 10
	
-- n. Quais foram os 10 filmes mais locados?
select sum(rental_id), f.title from rental as r
	inner join inventory as i
	on r.inventory_id = i.inventory_id 
	inner join film as f
	on i.film_id = f.film_id
	group by(f.title)
	order by sum desc limit 10
	
-- o. Quais foram os 10 filmes mais rentáveis?
select sum (amount), ca.name from payment as p
	inner join rental as r
	on p.rental_id = r.rental_id
	inner join inventory as i
	on r.inventory_id = i.inventory_id 
	inner join film_category as fc
	on i.film_id = fc.film_id
	inner join category as ca 
	on fc.category_id = ca.category_id
	group by (ca.name)
	order by sum desc limit 10
	
-- p. Quais foram os 10 filmes menos locados?
select sum(rental_id), f.title from rental as r
	inner join inventory as i
	on r.inventory_id = i.inventory_id 
	inner join film as f
	on i.film_id = f.film_id
	group by(f.title)
	order by sum asc limit 10
	
-- q. Quais foram os 10 filmes menos rentáveis?
select sum (amount), ca.name from payment as p
	inner join rental as r
	on p.rental_id = r.rental_id
	inner join inventory as i
	on r.inventory_id = i.inventory_id 
	inner join film_category as fc
	on i.film_id = fc.film_id
	inner join category as ca 
	on fc.category_id = ca.category_id
	group by (ca.name)
	order by sum asc limit 10
	
-- r. Quais os 10 clientes que mais alugam filmes?
select sum(rental_id), c.first_name from rental as r
	inner join customer as c
	on r.customer_id = c.customer_id
	group by (c.first_name)
	order by sum desc limit 10
	
-- s. Quais os 10 clientes que mais dão lucro?
select sum (amount), c.first_name from payment as p
	inner join rental as r
	on p.rental_id = r.rental_id
	inner join customer as c
	on r.customer_id = c.customer_id
	group by (c.first_name)
	order by sum desc limit 10
	
-- t. Quais os 10 clientes que menos alugam filmes?
select sum(rental_id), c.first_name from rental as r
	inner join customer as c
	on r.customer_id = c.customer_id
	group by (c.first_name)
	order by sum asc limit 10
	
-- u. Quais os 10 clientes que menos dão lucro?
select sum (amount), c.first_name from payment as p
	inner join rental as r
	on p.rental_id = r.rental_id
	inner join customer as c
	on r.customer_id = c.customer_id
	group by (c.first_name)
	order by sum asc limit 10
	
-- v. Quais os 10 funcionários que mais alugam filmes?
select sum(rental_id), s.first_name from rental as r
	inner join staff as s
	on r.staff_id = s.staff_id
	group by (s.first_name)
	order by sum desc limit 10
	
-- w. Quais os 10 funcionários que mais dão lucro?
select sum (amount), s.first_name from payment as p
	inner join rental as r
	on p.rental_id = r.rental_id
	inner join staff as s
	on r.staff_id = s.staff_id
	group by (s.first_name)
	order by sum desc limit 10
	
-- x. Quais os 10 funcionários que menos alugam filmes?
select sum(rental_id), c.first_name from rental as r
	inner join customer as c
	on r.customer_id = c.customer_id
	group by (c.first_name)
	order by sum asc limit 10
	
-- y. Quais os 10 funcionários que menos dão lucro?
select sum (amount), s.first_name from payment as p
	inner join rental as r
	on p.rental_id = r.rental_id
	inner join staff as s
	on r.staff_id = s.staff_id
	group by (s.first_name)
	order by sum asc limit 10
	
-- z. Quais os 10 endereços onde mais residem pessoas?
select sum(co.customer_id), city from city as c 
	inner join address as a  
	on c.city_id = a.city_id
	inner join customer as co
	on a.address_id = co.address_id
	group by (city)
	order by sum desc limit 10