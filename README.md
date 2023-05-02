# Persistência de dados
Resumo e listas de exercícios sobre banco relacionais | PostgreSQL

# Revisão dos conceitos apresentados na matéria de Modelagem de Banco de dados
<h2>O que é um banco de dados?</h2>
É um conjunto de dados organizados e relacionados entre si, sua linguagem é orientada a tabelas e representa algum aspecto do mundo real (minimundo),
podendo ter qualquer tamanho e complexidade, podendo ser mantido e criado de forma manual.</br>
<h2>Qual a diferença de informação e dado?</h2>
- Os dados são representações de fatos ou conceitos de maneira formalizada;</br>
- As informações são obtidas através de convenções usadas através de dados para a realização de interpretações.</br>
<h2>DDL</h2>
É a linguagem usada para criar e gerenciar objetos em um banco de dados. Os comandos mais utilizados são: </br>
 
        CREATE - criação de tabela, view e etc;
        DROP - exclusão de tabela, view e etc;
        ALTER - modificar ou remover colunas das tabelas, modificar as restrições de integridade etc.
        
<h2>DML</h2>
É a linguagem usada para manipular dados em um Banco de dados. A fim de realizar operações com os dados já existentes:

        SELECT - seleção de dados;
        UPDATE - atualização de dados;
        DELETE - exclusão de dados;
        INSERT - inclusão de dados;
        WHERE - filtro usado na seleção;
        JOIN - para comibinar uma ou mais tabelas.
         ...

# Resumo dos conceitos teóricos apresentados na matéria de Persistência de dados
<h2>Qual a diferença entre relação e relacionamento?</h2>
- Os relacionamentos são mapeados por meio das tabelas e campos. Representam as chaves primárias e estrangeiras, as quais ligam entidades;</br>
- Já as relações são um conjunto resultado de uma seleção composta de tuplas (linhas). Podendo essa seleção ser fruto de uma ou mais tabelas.</br>
<h2>O que são projeções e seleções?</h2>
- As seleções são feitas e operadas em cima das tuplas (linhas), o pré requisito é que a relação possua campos;</br>
- Já as projeções atuam em cima dos campos e indicam quais serão mostrados.</br>

        SELECT nome FROM tbpessoa -> primeiro é feita a seleção de "tbpessoa" e depois a projeção de "nome"
        WHERE id = 1 -> isso indica que temos um filtro na seleção
        
<h2>View</h2>
A view é uma representação virtual dos dados em uma ou mais tabelas, e seu conteúdo é gerado dinamicamente toda vez que é consultada. A diferença principal entre uma view e uma view materializada é que a view é uma consulta armazenada no banco de dados, enquanto que a view materializada é uma cópia física dos dados resultantes da consulta armazenada no disco. Isso significa que ao consultar uma view, o banco de dados executa a consulta em tempo real, o que pode ser lento se a consulta envolver muitas tabelas e operações complexas. Já com uma view materializada, a consulta é executada apenas uma vez e os resultados são armazenados em uma tabela separada no banco de dados. 

       CREATE VIEW vw_notas_alunos AS
       
       CREATE MATERIALIZED VIEW mvw_notas_alunos AS
       
       REFRESH MATERIALIZED VIEW mvw_notas_alunos - para atualizar uma view materialized
       
# Comandos utilizados nas listas de exercícios
1. Limit;
2. Order by;
3. Group by;
4. Inner Join;
5. Left Join;
6. Right Join;
7. Count;
8. Sum;
9. Subquery;
10. Exists/Not Exists;
11. In/ Not In;
12. Any;
13. Some;
14. All;
15. Having;
16. View.
