-- se for criar um novo banco, considerar utilizar o deploy,
-- script criado apenas para usar o dbic dump!

create table documento (
	id INTEGER not null primary key ,
	titulo  varchar(100)not null,
	texto varchar not null ,
	created_at timestamp DATE DEFAULT (datetime('now','localtime'))
);
insert into documento(titulo, texto) values ('O que é São Paulo 2022', 'São Paulo 2022 é uma iniciativa de cinco entidade');

insert into documento(titulo, texto) values ('XPTO Melhor nao tentar fazer os cadastros', 'isso mesmo, porque pode causar confusao no povo: atenção com encoding ¬¬ !! ã ẽ ĩ ');



create table visao (
	id INTEGER primary key ,
	id_documento int not null,
	texto_menu varchar(120) not null,
	texto_uri varchar(120) not null,
	
	created_at timestamp DATE DEFAULT (datetime('now','localtime')),
	FOREIGN KEY (id_documento) REFERENCES documento(id)

);

create table diretriz (
	id INTEGER primary key,
	id_documento integer not null
);

create table indicador (
	id INTEGER primary key,
	id_diretriz int,
	descricao varchar
);
create table tema (
	id INTEGER primary key,
	nome varchar not null
);
create table regiao (
	id INTEGER primary key,
	nome varchar not null
)


create table proposta (
	id INTEGER primary key,
	id_tema int not null,
	id_regiao int not null,
	id_documento int not null
);

