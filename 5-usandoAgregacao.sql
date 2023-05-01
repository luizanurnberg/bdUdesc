-- a. Qual o número de locação?
SELECT COUNT (*) FROM rental;

-- b. Qual o número de locações que foram pagas?
SELECT COUNT (*) FROM rental AS rt
	INNER JOIN payment AS pm
	ON rt.rental_id = pm.rental_id;
	
-- c. Qual o valor total que a locadora movimentou?
SELECT SUM (pm.amount) FROM payment AS pm;

-- d. Qual o valor total movimentado de 07/07/2005 até 23/08/2005?
SELECT SUM (pm.amount) FROM payment AS pm
WHERE pm.payment_date BETWEEN '2005/07/07' AND '2005/08/23';
	
-- e. Qual a média do valor movimentado de 07/07/2005 até 23/08/2005?
SELECT AVG (pm.amount) FROM payment AS pm
WHERE pm.payment_date BETWEEN '2005/07/07' AND '2005/08/23';
	
-- f. Quantos filmes existem por categoria?
SELECT COUNT (fm.film_id), ct.name FROM film AS fm
	INNER JOIN film_category AS fmct
	ON fm.film_id = fmct.film_id
		INNER JOIN category AS ct
		ON ct.category_id = fmct.category_id
		GROUP BY ct.name
		ORDER BY ct.name;
		 
-- g. Quantos atores existem por categoria?
SELECT COUNT (ac.actor_id), ct.name FROM film AS fm
	INNER JOIN film_category AS fmct
	ON fm.film_id = fmct.film_id
		INNER JOIN category AS ct
		ON fmct.category_id = ct.category_id
			INNER JOIN film_actor AS fmac
				ON fm.film_id = fmac.film_id
					INNER JOIN actor AS ac
						ON fmac.actor_id = ac.actor_id
						GROUP BY ct.name
						ORDER BY ct.name;

-- h. Quantos idiomas tem por filme?
SELECT COUNT (language_id), fm.title FROM film AS fm
GROUP BY fm.title;
		 
-- i. Quais atores fizeram mais filmes?
SELECT COUNT (fm.film_id), ac.first_name FROM film AS fm
	INNER JOIN film_actor AS fmac
	ON fm.film_id = fmac.film_id
		INNER JOIN actor AS ac
		ON fmac.actor_id = ac.actor_id
		GROUP BY ac.first_name
		ORDER BY COUNT DESC
		LIMIT 5;
		
-- j. Qual o número de cliente por cidade?
SELECT COUNT (cu.customer_id), cty.city FROM customer AS cu
	INNER JOIN address AS adr
	ON cu.address_id = adr.address_id
		INNER JOIN city AS cty
		ON adr.city_id = cty.city_id
		GROUP BY city
		ORDER BY COUNT DESC;
		
-- k. Qual a quantidade de filme por categoria?
SELECT COUNT (fm.film_id), ct.name FROM film AS fm
	INNER JOIN film_category AS fmct
	ON fm.film_id = fmct.film_id
		INNER JOIN category AS ct
		ON fmct.category_id = ct.category_id
			GROUP BY ct.name
			ORDER BY COUNT DESC;
		 
-- l. Quais foram as 10 categorias mais locadas?
SELECT COUNT (ct.category_id), ct.name FROM category AS ct
	INNER JOIN film_category AS fmct
	ON ct.category_id = fmct.category_id
		INNER JOIN film AS fm
		ON fmct.film_id = fm.film_id
			INNER JOIN inventory AS invt
			ON fm.film_id = invt.film_id
				INNER JOIN rental AS rt
				ON rt.inventory_id = invt.inventory_id
				GROUP BY ct.name 
				ORDER BY COUNT DESC
				LIMIT 10;
	
-- m. Quais foram as 10 categorias mais rentáveis?
SELECT COUNT (ct.category_id), ct.name FROM category AS ct
	INNER JOIN film_category AS fmct
	ON ct.category_id = fmct.category_id
		INNER JOIN film AS fm
		ON fmct.film_id = fm.film_id
			INNER JOIN inventory AS invt
			ON fm.film_id = invt.film_id
				INNER JOIN rental AS rt
				ON rt.inventory_id = invt.inventory_id
					INNER JOIN payment AS pm
					ON pm.rental_id = rt.rental_id
					GROUP BY ct.name 
					ORDER BY COUNT DESC
					LIMIT 10;
					
	
-- n. Quais foram os 10 filmes mais locados?
SELECT COUNT (fm.film_id), fm.title FROM film AS fm
	INNER JOIN inventory AS invt
	ON fm.film_id = invt.film_id
		INNER JOIN rental AS rt
		ON rt.inventory_id = invt.inventory_id
		GROUP BY fm.title 
		ORDER BY COUNT DESC
		LIMIT 10;
	
-- o. Quais foram os 10 filmes mais rentáveis?
SELECT COUNT (fm.film_id), fm.title FROM film AS fm
	INNER JOIN inventory AS invt
	ON fm.film_id = invt.film_id
		INNER JOIN rental AS rt
		ON rt.inventory_id = invt.inventory_id
			INNER JOIN payment AS pm
			ON pm.rental_id = rt.rental_id
			GROUP BY fm.title 
			ORDER BY COUNT DESC
			LIMIT 10;
	
-- p. Quais foram os 10 filmes menos locados?
SELECT COUNT (fm.film_id), fm.title FROM film AS fm
	INNER JOIN inventory AS invt
	ON fm.film_id = invt.film_id
		INNER JOIN rental AS rt
		ON rt.inventory_id = invt.inventory_id
		GROUP BY fm.title 
		ORDER BY COUNT ASC
		LIMIT 10;
	
-- q. Quais foram os 10 filmes menos rentáveis?
SELECT COUNT (fm.film_id), fm.title FROM film AS fm
	INNER JOIN inventory AS invt
	ON fm.film_id = invt.film_id
		INNER JOIN rental AS rt
		ON rt.inventory_id = invt.inventory_id
			INNER JOIN payment AS pm
			ON pm.rental_id = rt.rental_id
			GROUP BY fm.title 
			ORDER BY COUNT ASC
			LIMIT 10;
	
-- r. Quais os 10 clientes que mais alugam filmes?
SELECT COUNT (rt.rental_id), ctm.first_name FROM customer AS ctm
	INNER JOIN rental AS rt
	ON rt.customer_id = ctm.customer_id
	GROUP BY ctm.first_name
	ORDER BY COUNT DESC
	LIMIT 10;
	
-- s. Quais os 10 clientes que mais dão lucro?
SELECT SUM (amount), ctm.first_name FROM customer AS ctm
	INNER JOIN rental AS rt
	ON rt.customer_id = ctm.customer_id
		INNER JOIN payment AS pm
		ON pm.rental_id = rt.rental_id
		GROUP BY ctm.first_name
		ORDER BY SUM DESC
		LIMIT 10;
	
-- t. Quais os 10 clientes que menos alugam filmes?
SELECT COUNT (rt.rental_id), ctm.first_name FROM customer AS ctm
	INNER JOIN rental AS rt
	ON rt.customer_id = ctm.customer_id
	GROUP BY ctm.first_name
	ORDER BY COUNT ASC
	LIMIT 10;
	
-- u. Quais os 10 clientes que menos dão lucro?
SELECT SUM (pm.amount), ctm.first_name FROM customer AS ctm
	INNER JOIN rental AS rt
	ON rt.customer_id = ctm.customer_id
		INNER JOIN payment AS pm
		ON pm.rental_id = rt.rental_id
		GROUP BY ctm.first_name
		ORDER BY SUM ASC
		LIMIT 10;
	
-- v. Quais os 10 funcionários que mais alugam filmes?
SELECT COUNT (rt.rental_id), st.first_name FROM rental AS rt
	INNER JOIN staff AS st
	ON rt.staff_id = st.staff_id
	GROUP BY st.first_name
	ORDER BY COUNT DESC
	LIMIT 10;
	
-- w. Quais os 10 funcionários que mais dão lucro?
SELECT SUM (pm.amount), st.first_name FROM rental AS rt
	INNER JOIN payment AS pm
	ON rt.rental_id = pm.rental_id
		INNER JOIN staff AS st
		ON pm.staff_id = st.staff_id
		GROUP BY st.first_name
		ORDER BY SUM DESC
		LIMIT 10;
	
-- x. Quais os 10 funcionários que menos alugam filmes?
SELECT COUNT (rt.rental_id), st.first_name FROM rental AS rt
	INNER JOIN staff AS st
	ON rt.staff_id = st.staff_id
	GROUP BY st.first_name
	ORDER BY COUNT ASC
	LIMIT 10;
	
-- y. Quais os 10 funcionários que menos dão lucro?
SELECT SUM (pm.amount), st.first_name FROM rental AS rt
	INNER JOIN payment AS pm
	ON rt.rental_id = pm.rental_id
		INNER JOIN staff AS st
		ON pm.staff_id = st.staff_id
		GROUP BY st.first_name
		ORDER BY SUM ASC
		LIMIT 10;
	
-- z. Quais os 10 endereços onde mais residem pessoas?
SELECT COUNT (adr.address_id), cty.city FROM customer AS cu
	INNER JOIN address AS adr
	ON cu.address_id = adr.address_id
		INNER JOIN city AS cty
		ON adr.city_id = cty.city_id
		GROUP BY city
		ORDER BY COUNT DESC
		LIMIT 10;