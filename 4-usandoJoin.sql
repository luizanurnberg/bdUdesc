-- A. Nome da Categoria
SELECT ct.name FROM category AS ct;

-- B. Nome do filme
SELECT fm.title FROM film AS fm;

-- C. Nome do idiomas
SELECT la.name FROM language AS la;

-- D. Nome do ator
SELECT ac.first_name, ac.last_name FROM actor AS ac;

-- E. Nome do Filme | Categoria (ordenado pelo nome do filme)
SELECT fm.title, ct.name FROM film AS fm
	INNER JOIN film_category AS fmct
	ON fm.film_id = fmct.film_id
		INNER JOIN category AS ct
		ON fmct.category_id = ct.category_id
		ORDER BY fm.title;
		 
-- F. Categoria | Nome do Filme (ordenado pela categoria)
SELECT ct.name, fm.title FROM film AS fm
	INNER JOIN film_category AS fmct
	ON fm.film_id = fmct.film_id
		INNER JOIN category AS ct
		ON fmct.category_id = ct.category_id
		ORDER BY ct.name;
		 
-- G. Nome do Filme | Idioma (ordenado pelo nome do filme)
SELECT fm.title, la.name FROM film AS fm
	INNER JOIN language AS la
	ON fm.language_id = la.language_id
	ORDER BY fm.title;
		
-- H. Idioma | Nome do Filme (ordenado pelo idioma)
SELECT la.name, fm.title FROM film AS fm
	INNER JOIN language AS la
	ON fm.language_id = la.language_id
	ORDER BY la.name;


-- I. Categoria | Nome do Filme | Idioma (ordenado pela categoria)
SELECT ct.name, fm.title, la.name FROM film AS fm
	INNER JOIN language AS la
	ON fm.language_id = la.language_id
		INNER JOIN film_category AS fmct
		ON fm.film_id = fmct.film_id
			INNER JOIN category AS ct
			ON fmct.category_id = ct.category_id
			ORDER BY ct.name;
	
-- J. Nome do Filme | Categoria | Idioma (ordenado pelo nome do filme)
SELECT fm.title, ct.name, la.name FROM film AS fm
	INNER JOIN language AS la
	ON fm.language_id = la.language_id
		INNER JOIN film_category AS fmct
		ON fm.film_id = fmct.film_id
			INNER JOIN category AS ct
			ON fmct.category_id = ct.category_id
			ORDER BY fm.title;
		 
-- K. Idioma | Nome do Filme | Categoria (ordenado pelo idioma)
SELECT la.name, fm.title, ct.name FROM film AS fm
	INNER JOIN language AS la
	ON fm.language_id = la.language_id
		INNER JOIN film_category AS fmct
		ON fm.film_id = fmct.film_id
			INNER JOIN category AS ct
			ON fmct.category_id = ct.category_id
			ORDER BY la.name;
		 
-- L. Nome do Ator | Nome do Filme (ordenado pelo nome do ator)
SELECT ac.first_name, ac.last_name, fm.title FROM film AS fm
	INNER JOIN film_actor AS fmac
	ON fm.film_id = fmac.film_id
		INNER JOIN actor AS ac
		ON fmac.actor_id = ac.actor_id
		ORDER BY ac.first_name;

-- M. Nome do Filme | Nome do Ator (ordenado pelo nome do filme)
SELECT fm.title, ac.first_name, ac.last_name FROM film AS fm
	INNER JOIN film_actor AS fmac
	ON fm.film_id = fmac.film_id
		INNER JOIN actor AS ac
		ON fmac.actor_id = ac.actor_id
		ORDER BY fm.title;

-- N. Categoria | Nome do Filme | Ator (ordenado pela categoria)
SELECT ct.name, fm.title, ac.first_name, ac.last_name FROM film AS fm
		INNER JOIN film_category AS fmct
		ON fm.film_id = fmct.film_id
			INNER JOIN category AS ct
			ON fmct.category_id = ct.category_id
				INNER JOIN film_actor AS fmac
				ON fm.film_id = fmac.film_id
					INNER JOIN actor AS ac
					ON fmac.actor_id = ac.actor_id
					ORDER BY ct.name;
			
-- O. Ator | Categoria (ordenado pelo autor)
SELECT ac.first_name, ac.last_name, ct.name FROM film AS fm
	INNER JOIN film_category AS fmct
	ON fm.film_id = fmct.film_id
		INNER JOIN category AS ct
		ON fmct.category_id = ct.category_id
			INNER JOIN film_actor AS fmac
			ON fm.film_id = fmac.film_id
				INNER JOIN actor AS ac
				ON fmac.actor_id = ac.actor_id
				ORDER BY ct.name;

-- P. Nome da Cidade | Nome do País (ordenado pelo nome da cidade)
SELECT cty.city, ctry.country FROM country AS ctry
	INNER JOIN city AS cty
	ON cty.country_id = ctry.country_id
	ORDER BY cty.city;
		
-- Q. Nome do País | Nome da Cidade (ordenado pelo nome do país)
SELECT ctry.country, cty.city FROM country AS ctry
	INNER JOIN city AS cty
	ON cty.country_id = ctry.country_id
	ORDER BY cty.city;

-- R. Os idiomas que não tem filmes
SELECT la.name FROM language AS la
	LEFT JOIN film AS fm
	ON la.language_id = fm.language_id
	WHERE fm.title is null;
	
-- S. Os atores que não tem filme em estoque
SELECT ac.first_name, ac.last_name, f.title FROM film AS f
	INNER JOIN film_actor AS fa
	ON fa.film_id = f.film_id
		INNER JOIN actor AS ac
		ON fa.actor_id = ac.actor_id
			LEFT JOIN inventory AS inv
			ON f.film_id = inv.film_id
			WHERE inv.film_id is null;
	
-- T. As categorias que não tem filmes
SELECT c.name FROM category AS c
	INNER JOIN film_category AS fc
		ON c.category_id = fc.category_id
		 WHERE fc.film_id IS null;