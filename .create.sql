-- se for criar um novo banco, considerar utilizar o deploy,
-- script criado apenas para usar o dbic dump!

create table documento (
	id INTEGER not null primary key ,
	titulo  varchar(100)not null,
	texto varchar not null ,
	created_at timestamp DATE DEFAULT (datetime('now','localtime'))
);
insert into documento(titulo, texto) values ('O que é São Paulo 2022', 'São Paulo 2022 é uma iniciativa de cinco entidade');

insert into documento(titulo, texto) values (' 1 XPTO Melhor nao tentar fazer os cadastros', 'isso mesmo, porque pode causar confusao no povo: atenção com encoding ¬¬ !! ã ẽ ĩ ');

insert into documento(titulo, texto) values ('2', 'texto 2');

insert into documento(titulo, texto) values ('3', 'texto 3');

insert into documento(titulo, texto) values ('4', 'texto 4');

insert into documento(titulo, texto) values ('5', 'texto 5');


create table visao (
	id INTEGER primary key ,
	id_documento int not null,
	texto_menu varchar(120) not null,
	texto_uri varchar(120) not null,
	
	created_at timestamp DATE DEFAULT (datetime('now','localtime')),
	FOREIGN KEY (id_documento) REFERENCES documento(id)

);

insert into visao (id_documento,texto_uri,  texto_menu) values (
	2, 'democratica,participativa,descentralizada',
'Democrática
Participativa
Descentralizada'
);
insert into visao (id_documento,texto_uri,  texto_menu) values (
	3, 'saudavel,ambientalmente-sustentavel',
'Saudável
Ambientalmente sustentável'
);
insert into visao (id_documento,texto_uri,  texto_menu) values (
	4, 'compacta,agil,policentrica',
'Compacta
Ágil
Policêntrica'
);

insert into visao (id_documento,texto_uri,  texto_menu) values (
	5, 'inclusiva,segura,prospera',
'Inclusiva
Segura
Próspera'
);
insert into visao (id_documento,texto_uri,  texto_menu) values (
	6, 'educadora,criativa,conectada',
'Educadora
Criativa
Conectada'
);


create table diretriz (
	id INTEGER primary key,
	id_visao integer not null,
	id_documento integer not null,
	FOREIGN KEY (id_documento) REFERENCES documento(id),
	FOREIGN KEY (id_visao) REFERENCES visao(id)
);

insert into documento(titulo, texto) values ('primeira diretriz', 'primeira diretriz !! estou começando a achar que vou errar o id');
insert into documento(titulo, texto) values ('segunda diretriz', 'segunda diretriz Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. Se popularizou na década de 60, quando a Letraset lançou decalques contendo passagens de Lorem Ipsum, e mais recentemente quando passou a ser integrado a softwares de editoração eletrônica como Aldus PageMaker.');
insert into diretriz (id_visao, id_documento) values (1, 7);
insert into diretriz (id_visao, id_documento) values (1, 8);


create table indicador (
	id INTEGER primary key,
	id_diretriz int,
	descricao varchar,
	FOREIGN KEY (id_diretriz) REFERENCES diretriz(id)
);

insert into indicador (id_diretriz, descricao) values (1, 'abc');
insert into indicador (id_diretriz, descricao) values (1, 'eee xxx');
insert into indicador (id_diretriz, descricao) values (1, '98654');

insert into indicador (id_diretriz, descricao) values (2, '888888');
insert into indicador (id_diretriz, descricao) values (2, 'HHHHH');

alter table indicador add meta varchar not null default 'meta';

create table tema (
	id INTEGER primary key,
	nome varchar not null
);

create table regiao (
	id INTEGER primary key,
	nome varchar not null
);


create table proposta (
	id INTEGER primary key,
	id_tema int not null,
	id_regiao int not null,
	id_diretriz int not null,
	id_documento int not null,
	FOREIGN KEY (id_tema) REFERENCES tema(id),
	FOREIGN KEY (id_regiao) REFERENCES regiao(id),
	FOREIGN KEY (id_documento) REFERENCES documento(id),
	FOREIGN KEY (id_diretriz) REFERENCES diretriz(id)
);

insert into tema (nome) values ('tema 1');
insert into regiao (nome) values ('regiao 1');

insert into documento(titulo, texto) values ('doc primeira proposta', 'rand() <script>alert("i cant")</script>');
insert into proposta(id_tema, id_regiao, id_diretriz, id_documento) values(1,1,1,9);



create table boa_pratica (
	id INTEGER primary key,
	id_proposta int not null,
	texto varchar not null,
	FOREIGN KEY (id_proposta) REFERENCES proposta(id)
);
