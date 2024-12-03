select * from ocorrencia;

select * from fator_contribuinte fc ;

select * from aeronave a ;

select * from ocorrencia_tipo ot  ;

select * from recomendacao r ;

drop  MATERIALIZED VIEW big_fact_ocorrencias; 
create MATERIALIZED VIEW big_fact_ocorrencias as 
select 
o.codigo_ocorrencia,
o.ocorrencia_longitude,
o.ocorrencia_latitude,
o.ocorrencia_dia,
o.ocorrencia_hora,
DENSE_RANK()  over ( order by o.ocorrencia_classificacao asc ) as codigo_ocorrencia_classificacao,
o.ocorrencia_classificacao ,
DENSE_RANK()  over ( order by ot.ocorrencia_tipo asc ) as codigo_ocorrencia_tipo,
ot.ocorrencia_tipo ,
DENSE_RANK()  over ( order by ot.ocorrencia_tipo_categoria,ot.taxonomia_tipo_icao  asc ) as codigo_ocorrencia_tipo_categoria,
ot.ocorrencia_tipo_categoria,
ot.taxonomia_tipo_icao,
dense_rank () over (order by o.ocorrencia_uf) as codigo_ocorrencia_uf,
o.ocorrencia_uf ,
dense_rank () over (order by o.ocorrencia_cidade) as codigo_ocorrencia_cidade,
o.ocorrencia_cidade,
dense_rank () over (order by o.ocorrencia_pais) as codigo_ocorrencia_pais,
o.ocorrencia_pais,
dense_rank () over (order by o.ocorrencia_aerodromo) as codigo_ocorrencia_aerodromo,
o.ocorrencia_aerodromo,
dense_rank () over (order by o.investigacao_status) as codigo_investigacao_status,
o.investigacao_status,
dense_rank () over (order by o.investigacao_aeronave_liberada) as codigo_investigacao_aeronave_liberada,
o.investigacao_aeronave_liberada,
dense_rank () over (order by o.divulgacao_relatorio_publicado) as codigo_divulgacao_relatorio_publicado,
o.divulgacao_relatorio_publicado,
dense_rank () over (order by o.ocorrencia_saida_pista) as codigo_ocorrencia_saida_pista,
o.ocorrencia_saida_pista,  
dense_rank () over (order by a.aeronave_tipo_veiculo ) as codigo_aeronave_tipo_veiculo,
a.aeronave_tipo_veiculo ,
dense_rank () over (order by a.aeronave_fabricante ) as codigo_aeronave_fabricante,
a.aeronave_fabricante,
dense_rank () over (order by a.aeronave_modelo ) as codigo_aeronave_modelo,
a.aeronave_modelo ,
dense_rank () over (order by a.aeronave_tipo_icao ) as codigo_aeronave_tipo_icao,
a.aeronave_tipo_icao,
dense_rank () over (order by a.aeronave_motor_tipo ) as codigo_aeronave_motor_tipo,
a.aeronave_motor_tipo,
dense_rank () over (order by a.aeronave_motor_quantidade ) as codigo_aeronave_motor_quantidade,
a.aeronave_motor_quantidade,
dense_rank () over (order by a.aeronave_pmd ) as codigo_aeronave_pmd,
a.aeronave_pmd,
dense_rank () over (order by a.aeronave_ano_fabricacao ) as codigo_aeronave_ano_fabricacao,
a.aeronave_ano_fabricacao,
dense_rank () over (order by a.aeronave_assentos ) as codigo_aeronave_assentos,
a.aeronave_assentos,
dense_rank () over (order by a.aeronave_pais_fabricante ) as codigo_aeronave_pais_fabricante,
a.aeronave_pais_fabricante,
dense_rank () over (order by a.aeronave_pais_registro ) as codigo_aeronave_pais_registro,
a.aeronave_pais_registro,
dense_rank () over (order by a.aeronave_registro_categoria ) as codigo_aeronave_registro_categoria,
a.aeronave_registro_categoria,
dense_rank () over (order by a.aeronave_registro_segmento ) as codigo_aeronave_registro_segmento,
a.aeronave_registro_segmento,
dense_rank () over (order by a.aeronave_voo_origem ) as codigo_aeronave_voo_origem,
a.aeronave_voo_origem,
dense_rank () over (order by a.aeronave_voo_destino ) as codigo_aeronave_voo_destino,
a.aeronave_voo_destino,
dense_rank () over (order by a.aeronave_fase_operacao ) as codigo_aeronave_fase_operacao,
a.aeronave_fase_operacao,
dense_rank () over (order by a.aeronave_tipo_operacao ) as codigo_aeronave_tipo_operacao,
a.aeronave_tipo_operacao,
dense_rank () over (order by a.aeronave_nivel_dano ) as codigo_aeronave_nivel_dano,
a.aeronave_nivel_dano,
dense_rank () over (order by fc.fator_condicionante ) as codigo_fator_condicionante,
fc.fator_condicionante,
dense_rank () over (order by fc.fator_aspecto ) as codigo_fator_aspecto,
fc.fator_aspecto,
dense_rank () over (order by fc.fator_area ) as codigo_fator_area,
fc.fator_area,
dense_rank () over (order by r.recomendacao_destinatario_sigla ) as codigo_recomendacao_destinatario_sigla,
r.recomendacao_destinatario_sigla,
dense_rank () over (order by r.recomendacao_destinatario, r.recomendacao_conteudo ) as codigo_recomendacao_destinatario,
r.recomendacao_destinatario,
r.recomendacao_conteudo 
from ocorrencia o 
left join ocorrencia_tipo ot on o.codigo_ocorrencia1 = ot.codigo_ocorrencia1
left join aeronave a on o.codigo_ocorrencia2 = a.codigo_ocorrencia2
left join fator_contribuinte fc on o.codigo_ocorrencia3 = fc.codigo_ocorrencia3
left join recomendacao r on o.codigo_ocorrencia4 = r.codigo_ocorrencia4  

 
select * from big_fact_ocorrencias limit 10;

 
create table dimension_ocorrencia_tipo as 
select distinct codigo_ocorrencia_tipo,ocorrencia_tipo from big_fact_ocorrencias;


drop table dimension_ocorrencia_tipo_categoria;

create table dimension_ocorrencia_tipo_categoria as 
select distinct codigo_ocorrencia_tipo_categoria,ocorrencia_tipo_categoria, b.taxonomia_tipo_icao  from big_fact_ocorrencias b;


create table dimensao_ocorrencia_cidade as
select distinct codigo_ocorrencia_cidade, ocorrencia_cidade from big_fact_ocorrencias b;


create table dimensao_ocorrencia_pais as
select distinct codigo_ocorrencia_pais, ocorrencia_pais from big_fact_ocorrencias b;

create table dimensao_ocorrencia_aerodromo as
select distinct codigo_ocorrencia_aerodromo, ocorrencia_aerodromo from big_fact_ocorrencias b;


create table dimensao_investigacao_status as
select distinct codigo_investigacao_status, investigacao_status from big_fact_ocorrencias b;

 
create table dimensao_investigacao_aeronave_liberada as
select distinct codigo_investigacao_aeronave_liberada, investigacao_aeronave_liberada from big_fact_ocorrencias;



 
create table dimensao_divulgacao_relatorio_publicado as
select distinct codigo_divulgacao_relatorio_publicado, divulgacao_relatorio_publicado from big_fact_ocorrencias;



create table dimensao_ocorrencia_saida_pista as
select distinct codigo_ocorrencia_saida_pista, ocorrencia_saida_pista from big_fact_ocorrencias;



create table dimensao_aeronave_tipo_veiculo as
select distinct codigo_aeronave_tipo_veiculo, aeronave_tipo_veiculo from big_fact_ocorrencias;


create table dimensao_aeronave_modelo as
select distinct codigo_aeronave_modelo, aeronave_modelo from big_fact_ocorrencias;



create table dimensao_aeronave_tipo_icao as
select distinct codigo_aeronave_tipo_icao, aeronave_tipo_icao from big_fact_ocorrencias;



create table dimensao_aeronave_motor_tipo as
select distinct codigo_aeronave_motor_tipo, aeronave_motor_tipo from big_fact_ocorrencias;


create table dimensao_aeronave_motor_quantidade as
select distinct codigo_aeronave_motor_quantidade, aeronave_motor_quantidade from big_fact_ocorrencias;



create table dimensao_aeronave_pmd as
select distinct codigo_aeronave_pmd, aeronave_pmd from big_fact_ocorrencias;


create table dimensao_aeronave_ano_fabricacao as
select distinct codigo_aeronave_ano_fabricacao, aeronave_ano_fabricacao from big_fact_ocorrencias;


create table dimensao_aeronave_assentos as
select distinct codigo_aeronave_assentos, aeronave_assentos from big_fact_ocorrencias;


create table dimensao_aeronave_pais_fabricante as
select distinct codigo_aeronave_pais_fabricante, aeronave_pais_fabricante from big_fact_ocorrencias;



create table dimensao_aeronave_pais_registro as
select distinct codigo_aeronave_pais_registro, aeronave_pais_registro from big_fact_ocorrencias;


create table dimensao_aeronave_registro_categoria as
select distinct codigo_aeronave_registro_categoria, aeronave_registro_categoria from big_fact_ocorrencias;


create table dimensao_aeronave_registro_segmento as
select distinct codigo_aeronave_registro_segmento, aeronave_registro_segmento from big_fact_ocorrencias;



create table dimensao_aeronave_registro_segmento as
select distinct codigo_aeronave_registro_segmento, aeronave_registro_segmento from big_fact_ocorrencias;

 
create table dimensao_aeronave_voo_origem as
select distinct codigo_aeronave_voo_origem, aeronave_voo_origem from big_fact_ocorrencias;

 

create table dimensao_aeronave_voo_destino as
select distinct codigo_aeronave_voo_destino, aeronave_voo_destino from big_fact_ocorrencias;


create table dimensao_aeronave_fase_operacao as
select distinct codigo_aeronave_voo_destino, aeronave_fase_operacao from big_fact_ocorrencias;



create table dimensao_aeronave_tipo_operacao as
select distinct codigo_aeronave_tipo_operacao, aeronave_tipo_operacao from big_fact_ocorrencias;

 

create table dimensao_aeronave_tipo_operacao as
select distinct codigo_aeronave_tipo_operacao, aeronave_tipo_operacao from big_fact_ocorrencias;


create table dimensao_aeronave_nivel_dano as
select distinct codigo_aeronave_nivel_dano, aeronave_nivel_dano from big_fact_ocorrencias;

 
create table dimensao_fator_condicionante as
select distinct codigo_fator_condicionante, fator_condicionante from big_fact_ocorrencias;

 
 
create table dimensao_fator_aspecto as
select distinct codigo_fator_aspecto, fator_aspecto from big_fact_ocorrencias;

  

 
create table dimensao_fator_area as
select distinct codigo_fator_area, fator_area from big_fact_ocorrencias;

  
 %%sql



copy ( select * from db.dimensao_aeronave_ano_fabricacao        ) to 's3://lord-duckdb/bi/dimensao_aeronave_ano_fabricacao.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_aeronave_assentos              ) to 's3://lord-duckdb/bi/dimensao_aeronave_assentos.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_aeronave_fase_operacao         ) to 's3://lord-duckdb/bi/dimensao_aeronave_fase_operacao.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_aeronave_modelo                ) to 's3://lord-duckdb/bi/dimensao_aeronave_modelo.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_aeronave_motor_quantidade      ) to 's3://lord-duckdb/bi/dimensao_aeronave_motor_quantidade.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_aeronave_motor_tipo            ) to 's3://lord-duckdb/bi/dimensao_aeronave_nivel_dano.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_aeronave_nivel_dano            ) to 's3://lord-duckdb/bi/dimensao_aeronave_nivel_dano.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_aeronave_pais_fabricante       ) to 's3://lord-duckdb/bi/dimensao_aeronave_pais_fabricante.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_aeronave_pais_registro         ) to 's3://lord-duckdb/bi/dimensao_aeronave_pais_registro.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_aeronave_pmd                   ) to 's3://lord-duckdb/bi/dimensao_aeronave_pmd.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_aeronave_registro_categoria    ) to 's3://lord-duckdb/bi/dimensao_aeronave_registro_segmento.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_aeronave_registro_segmento     ) to 's3://lord-duckdb/bi/dimensao_aeronave_registro_segmento.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_aeronave_tipo_icao             ) to 's3://lord-duckdb/bi/dimensao_aeronave_tipo_operacao.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_aeronave_tipo_operacao         ) to 's3://lord-duckdb/bi/dimensao_aeronave_tipo_operacao.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_aeronave_tipo_veiculo          ) to 's3://lord-duckdb/bi/dimensao_aeronave_tipo_veiculo.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_aeronave_voo_destino           ) to 's3://lord-duckdb/bi/dimensao_codigo_aeronave_motor_tipo.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_aeronave_voo_origem            ) to 's3://lord-duckdb/bi/dimensao_codigo_aeronave_motor_tipo.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_codigo_aeronave_motor_tipo     ) to 's3://lord-duckdb/bi/dimensao_codigo_aeronave_motor_tipo.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_divulgacao_relatorio_publicado ) to 's3://lord-duckdb/bi/dimensao_divulgacao_relatorio_publicado.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_fator_area                     ) to 's3://lord-duckdb/bi/dimensao_fator_area.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_fator_aspecto                  ) to 's3://lord-duckdb/bi/dimensao_fator_aspecto.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_fator_condicionante            ) to 's3://lord-duckdb/bi/dimensao_fator_condicionante.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_investigacao_aeronave_liberada ) to 's3://lord-duckdb/bi/dimensao_investigacao_aeronave_liberada.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_investigacao_status            ) to 's3://lord-duckdb/bi/dimensao_investigacao_status.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_ocorrencia_aerodromo           ) to 's3://lord-duckdb/bi/dimensao_ocorrencia_aerodromo.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_ocorrencia_cidade              ) to 's3://lord-duckdb/bi/dimensao_ocorrencia_cidade.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_ocorrencia_pais                ) to 's3://lord-duckdb/bi/dimensao_ocorrencia_pais.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_ocorrencia_saida_pista         ) to 's3://lord-duckdb/bi/dimensao_ocorrencia_saida_pista.csv' with (FORMAT CSV);
copy ( select * from db.dimensao_ocorrencia_uf                  ) to 's3://lord-duckdb/bi/dimensao_ocorrencia_uf.csv' with (FORMAT CSV);
copy ( select * from db.dimension_ocorrencia_tipo               ) to 's3://lord-duckdb/bi/dimension_ocorrencia_tipo.csv' with (FORMAT CSV);
copy ( select * from db.dimension_ocorrencia_tipo_categoria     ) to 's3://lord-duckdb/bi/dimension_ocorrencia_tipo_categoria.csv' with (FORMAT CSV);
copy ( select * from db.big_fact_ocorrencias     ) to 's3://lord-duckdb/bi/big_fact_ocorrencias.csv' with (FORMAT CSV);
copy ( select * from db.calendario     ) to 's3://lord-duckdb/bi/calendario.parquet' with (FORMAT parquet);





create table fato_ocorrencia        as select * from 's3://lord-duckdb/bi/big_fact_ocorrencias.csv';
create table calendario        as select * from 's3://lord-duckdb/bi/calendario.parquet';
create table dimensao_aeronave_ano_fabricacao        as select * from 's3://lord-duckdb/bi/dimensao_aeronave_ano_fabricacao.csv';
create table dimensao_aeronave_assentos              as select * from 's3://lord-duckdb/bi/dimensao_aeronave_assentos.csv';
create table dimensao_aeronave_fase_operacao         as select * from 's3://lord-duckdb/bi/dimensao_aeronave_fase_operacao.csv';
create table dimensao_aeronave_modelo                as select * from 's3://lord-duckdb/bi/dimensao_aeronave_modelo.csv';
create table dimensao_aeronave_motor_quantidade      as select * from 's3://lord-duckdb/bi/dimensao_aeronave_motor_quantidade.csv';
create table dimensao_aeronave_motor_tipo            as select * from 's3://lord-duckdb/bi/dimensao_aeronave_nivel_dano.csv';
create table dimensao_aeronave_nivel_dano            as select * from 's3://lord-duckdb/bi/dimensao_aeronave_nivel_dano.csv';
create table dimensao_aeronave_pais_fabricante       as select * from 's3://lord-duckdb/bi/dimensao_aeronave_pais_fabricante.csv';
create table dimensao_aeronave_pais_registro         as select * from 's3://lord-duckdb/bi/dimensao_aeronave_pais_registro.csv';
create table dimensao_aeronave_pmd                   as select * from 's3://lord-duckdb/bi/dimensao_aeronave_pmd.csv';
create table dimensao_aeronave_registro_categoria    as select * from 's3://lord-duckdb/bi/dimensao_aeronave_registro_segmento.csv';
create table dimensao_aeronave_registro_segmento     as select * from 's3://lord-duckdb/bi/dimensao_aeronave_registro_segmento.csv';
create table dimensao_aeronave_tipo_icao             as select * from 's3://lord-duckdb/bi/dimensao_aeronave_tipo_operacao.csv';
create table dimensao_aeronave_tipo_operacao         as select * from 's3://lord-duckdb/bi/dimensao_aeronave_tipo_operacao.csv';
create table dimensao_aeronave_tipo_veiculo          as select * from 's3://lord-duckdb/bi/dimensao_aeronave_tipo_veiculo.csv';
create table dimensao_aeronave_voo_destino           as select * from 's3://lord-duckdb/bi/dimensao_codigo_aeronave_motor_tipo.csv';
create table dimensao_aeronave_voo_origem            as select * from 's3://lord-duckdb/bi/dimensao_codigo_aeronave_motor_tipo.csv';
create table dimensao_codigo_aeronave_motor_tipo     as select * from 's3://lord-duckdb/bi/dimensao_codigo_aeronave_motor_tipo.csv';
create table dimensao_divulgacao_relatorio_publicado as select * from 's3://lord-duckdb/bi/dimensao_divulgacao_relatorio_publicado.csv';
create table dimensao_fator_area                     as select * from 's3://lord-duckdb/bi/dimensao_fator_area.csv';
create table dimensao_fator_aspecto                  as select * from 's3://lord-duckdb/bi/dimensao_fator_aspecto.csv';
create table dimensao_fator_condicionante            as select * from 's3://lord-duckdb/bi/dimensao_fator_condicionante.csv';
create table dimensao_investigacao_aeronave_liberada as select * from 's3://lord-duckdb/bi/dimensao_investigacao_aeronave_liberada.csv';
create table dimensao_investigacao_status            as select * from 's3://lord-duckdb/bi/dimensao_investigacao_status.csv';
create table dimensao_ocorrencia_aerodromo           as select * from 's3://lord-duckdb/bi/dimensao_ocorrencia_aerodromo.csv';
create table dimensao_ocorrencia_cidade              as select * from 's3://lord-duckdb/bi/dimensao_ocorrencia_pais.csv';
create table dimensao_ocorrencia_pais                as select * from 's3://lord-duckdb/bi/dimensao_ocorrencia_pais.csv';
create table dimensao_ocorrencia_saida_pista         as select * from 's3://lord-duckdb/bi/dimensao_ocorrencia_saida_pista.csv';
create table dimensao_ocorrencia_uf                  as select * from 's3://lord-duckdb/bi/dimensao_ocorrencia_uf.csv';
create table dimension_ocorrencia_tipo               as select * from 's3://lord-duckdb/bi/dimension_ocorrencia_tipo.csv';
create table dimension_ocorrencia_tipo_categoria     as select * from 's3://lord-duckdb/bi/dimension_ocorrencia_tipo_categoria.csv';


create table calendario     as select * from 's3://lord-duckdb/bi/calendario.parquet';





--padronizar tabela campos data da tabela ocorrencia
--criar chaves nas dimensoes, e atualizar os fatos com as referencias
--trocar valores nulos com N/A ou Unknow 






