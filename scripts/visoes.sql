/* Item 3.c- Visões */

/* 1- Visão para exibir usuários e os totalizadores para o número reservas por mês e ano */
create or replace view reservasPorMesAno (cliente, mes, ano, "Total de reservas") as 
    select usuario.nome, extract(month from entrada) mes, extract(year from entrada) ano, count (id_reserva) as "total" from reserva 
        join usuario on reserva.fk_idusuario=usuario.id_usuario  
    group by rollup ((mes, ano, usuario.nome)) order by mes, usuario.nome;

select * from reservasPorMesAno;

/* 2- Uma visão de todos os imóveis que ainda não possuem reservas, exibir informacoes sobre 
nome, cidade, bairro, preco, descricao da acomodacao, o tipo e quantidade para acomodar */
create or replace view atributosImoveisSemReserva ("Nome do imóvel", cidade, bairro, caracteristicas, tipo, qtd) as    
    select  i.nome, i.cidade, i.bairro, a.preco, a.descricao, t.descricao, a.quantidade from reserva r 
        right join imovel i on r.fk_idimovel=i.id_imovel 
        join imovel_acomodacao ia on i.id_imovel=ia.fk_idimovel 
        join acomodacao a on ia.fk_idacomodacao=a.id_acomodacao  
        join tipo t on a.fk_idtipo =t.id_tipo where r.fk_idimovel is null;

select * from atributosImoveisSemReserva;

/* 3-  */



