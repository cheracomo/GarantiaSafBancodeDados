CREATE TABLE "especie_vegetal" (
	"id_especie"	INTEGER NOT NULL,
	"nome_cientifico"	TEXT,
	"resiliencia_especie"	INTEGER,
	"estrato"	TEXT,
	"colheita_poda_dias"	TEXT,
	"colheita_poda_anos"	TEXT,
	PRIMARY KEY("id_especie")
);

CREATE TABLE "sistema" (
	"id_sistema"	INTEGER NOT NULL,
	"descricao_sist" TEXT,
	"cartilha"	TEXT,
	PRIMARY KEY("id_sistema")
);

CREATE TABLE "cult_principal" (
	"id_cult_principal"	INTEGER NOT NULL,
	"id_especie"	INTEGER,
	PRIMARY KEY("id_cult_principal"),
	FOREIGN KEY("id_especie") REFERENCES "especie_vegetal"("id_especie")
);

CREATE TABLE "nome_popular" (
	"id_nome_pop"	INTEGER NOT NULL,
	"id_especie"	INTEGER,
	"nome_pop" TEXT,
	PRIMARY KEY("id_nome_pop"),
	FOREIGN KEY("id_especie") REFERENCES "especie_vegetal"("id_especie")
);


CREATE TABLE "canteiro" (
	"id_canteiro"	INTEGER NOT NULL,
	"id_cult_principal"	INTEGER,
	"id_sistema" INTEGER,
	"funcao_canteiro" TEXT,
	"descricao" TEXT,
	PRIMARY KEY("id_canteiro"),
	FOREIGN KEY("id_cult_principal") REFERENCES "cult_principal"("id_cult_principal"),
	FOREIGN KEY("id_sistema") REFERENCES "sistema"("id_sistema")
);

CREATE TABLE "especie_canteiro" (
	"id_canteiro_especie"	INTEGER NOT NULL,
	"id_canteiro"	INTEGER,
	"id_especie"	INTEGER,
	FOREIGN KEY("id_canteiro") REFERENCES "canteiro"("id_canteiro"),
	FOREIGN KEY("id_especie") REFERENCES "especie_vegetal"("id_especie")
);


CREATE TABLE ctrl_biologico_pragas (
  id_praga INTEGER PRIMARY KEY NOT NULL,
  id_praga_cien INTEGER,
  descricao_praga TEXT,
  descricao_sintoma TEXT,
  insumo_ctrl_bio TEXT,
  descricao_crtl_bio TEXT,
  FOREIGN KEY(id_praga_cien) REFERENCES pragas(id_praga_cien) ON DELETE NO ACTION
);

CREATE TABLE pragas_pop (
  id_praga_pop INTEGER PRIMARY KEY NOT NULL,
  id_praga_cien INTEGER,
  praga_pop TEXT,
  FOREIGN KEY(id_praga_cien) REFERENCES pragas(id_praga_cien) ON DELETE NO ACTION
);

CREATE TABLE animal (
	id_animal INTEGER PRIMARY KEY NOT NULL,
	nome_animal TEXT,
	raca_animal TEXT,
	exigencia_alimentacao TEXT
	);
	
CREATE TABLE patogenos (
	id_patogeno INTEGER PRIMARY KEY NOT NULL,
	id_animal INTEGER,
	patogeno_cien TEXT,
	descricao_patogeno TEXT,
	descricao_pat_sintoma TEXT,
	FOREIGN KEY ("id_animal") REFERENCES "animal"("id_animal") ON DELETE NO ACTION
	);

CREATE TABLE controle_patogenos (
	id_patogeno_ctrl INTEGER PRIMARY KEY NOT NULL,
	id_patogeno INTEGER,
	insumo_pat TEXT,
	descricao_pat_ctrl TEXT,
	FOREIGN KEY ("id_patogeno") REFERENCES "patogenos"("id_patogeno") ON DELETE NO ACTION
	);
	
CREATE TABLE patogenos_nome_pop (
	id_patogeno_pop INTEGER PRIMARY KEY NOT NULL,
	id_patogeno INTEGER,
	patogeno_pop TEXT,
	FOREIGN KEY ("id_patogeno") REFERENCES "patogenos"("id_patogeno") ON DELETE NO ACTION
	);
	
CREATE TABLE sistema_animal (
	id_sistema_animal INTEGER PRIMARY KEY NOT NULL,
	id_sistema INTEGER,
	id_animal INTEGER,
	funcao_animal TEXT,
	ciclo_animal TEXT,
	FOREIGN KEY ("id_sistema") REFERENCES "sistema"("id_sistema") ON DELETE NO ACTION,
	FOREIGN KEY ("id_animal") REFERENCES "animal"("id_animal") ON DELETE NO ACTION
	);


-----------------------------------------------------------------

INSERT or REPLACE INTO especie_vegetal (id_especie,nome_cientifico, resiliencia_especie, estrato, colheita_poda_dias, colheita_poda_anos)
VALUES 
(1, 'Zea Mays', 1, 'emergente', '90 a 120', '-'),
(2, 'Vigna unguiculata', 2, 'alto', '90', '-'),
(3, 'Cajanus cajon', 2, 'alto', '180 a 540', '0,5 a 1,5'),
(4, 'Phaseolos vulgaris', 2, 'baixo', '80 a 90', '-'),
(5, 'Crotalaria juncea', 2, 'emergente', '120', '-'),
(6, 'Megathyrsus maximus', 2, 'médio', '180', '-'),
(7, 'Phaseolos vulgaris', 2, 'baixo', '50 a 80', '-'),
(8, 'Vicia faba', 2, 'médio', '100 a 240', '-'),
(9, 'Gossypium hirstum', 2, 'alto', '140 a 180', '-'),
(10, 'Crotalaria spectabilis', 2, 'emergente', '120', '-');

INSERT or REPLACE INTO nome_popular (id_nome_pop,id_especie,nome_pop)
VALUES
(1, 1, 'milho'),
(2, 2, 'feijao de corda'),
(3, 2, 'feijao caupi'),
(4, 2, 'feijao fradinho'),
(5, 3, 'feijao guandu'),
(6, 3, 'guandu'),
(7, 3, 'feijao de arvore'),
(8, 4, 'feijao faseolo'),
(9, 4, 'feijao de arranque'),
(10, 4, 'feijao carioca'),
(11, 4, 'feijao preto'),
(12, 5, 'crotalaria'),
(13, 5, 'crotalaria juncea'),
(14, 6, 'campim mombaça'),
(15, 6, 'mombaça'),
(16, 7, 'vagem rasteira'),
(17, 8, 'fava'),
(18, 8, 'feijao manteiga'),
(19, 8, 'feijao espadinho'),
(20, 8, 'feijao favona'),
(21, 8, 'feijao verde'),
(22, 9, 'algodao'),
(23, 10, 'crotalaria'),
(24, 10, 'crotalaria spectabilis')
;

INSERT or REPLACE INTO sistema (id_sistema, descricao_sist, cartilha)
VALUES
(1, 'Sistema de milho com consórcio simples utilizando entrelinhas de mombaça + crotalária para fornecimento de matéria organica', 'cartilha 1');


INSERT INTO cult_principal (id_cult_principal,id_especie)
VALUES
(1, 1);


INSERT or replace INTO canteiro (id_canteiro,id_cult_principal,id_sistema, funcao_canteiro, descricao)
VALUES
(1,1,1,'1.1 - canteiro principal','Milho-feijão: Canteiro com 3m de largura. Linha central de guandú (espaçamento:0,75 m); duas linhas de milho intercalado com feijão de corda (espaçamento entre linhas 1,5m e entreplantas (milho-feijão de corda) 0,5m); feijão faseolo com espaçamento de monocultura nas bordas do canteiro (0,3 m x 0,3 m)'),
(2,1,1,'entrelinha adubadora','fazer uma muvuca com as sementes na porporção de 20kg/ha de crotalária juncea e 10kg/ha de mombaça'),
(3,1,1,'1.2 - canteiro principal','Milho-feijão-vagem: Canteiro com 3m de largura. Linha central de guandú (espaçamento:0,75 m); duas linhas de milho intercalado com feijão de corda (espaçamento entre linhas 1,5m e entreplantas (milho-feijão de corda) 0,5m); vagem rasteira com espaçamento de monocultura nas bordas do canteiro (0,3 m x 0,3 m)'),
(4,1,1,'1.3 - canteiro principal','Milho-algodão-fava-feijão: Canteiro com 3m de largura. Linha central de algodão (espaçamento: 1,0 m); duas linhas de milho intercalado com fava (espaçamento entre linhas 1,5m e entreplantas (milho-fava) 0,5m); feijão faseolo com espaçamento de monocultura nas bordas do canteiro (0,3 m x 0,3 m)'),
(5,1,1,'1.4 - canteiro principal','Milho-algodão-fava-vagem: Canteiro com 3m de largura. Linha central de algodão (espaçamento: 1,0 m); duas linhas de milho intercalado com fava (espaçamento entre linhas 1,5m e entreplantas (milho-fava) 0,5m); vagem rasteira com espaçamento de monocultura nas bordas do canteiro (0,3 m x 0,3 m)'),
(6,1,1,'entrelinha adubadora','fazer uma muvuca com as sementes na porporção de 10kg/ha de crotalária juncea, 10kg/ha de crotalaria spectabilis e 10kg/ha de mombaça'),
(7,1,1,'entrelinha adubadora','fazer uma muvuca com as sementes na porporção de 20kg/ha de crotalária spectabilis e 10kg/ha de mombaça'),
(10,1,1,'1.5 - canteiro principal','Milho-fava-feijao: Canteiro com 3m de largura. Duas linhas de milho intercalado com fava (espaçamento entre linhas 1,5m e entreplantas (milho-fava) 0,5m); duas linhas de feijão nas bordas do canteiro com espaçamento de monocultura e tres linhas entre as linhas de milho e fava (0,3 m x 0,3 m)');

INSERT or REPLACE INTO especie_canteiro (id_canteiro_especie,id_canteiro,id_especie)
VALUES
(1, 1, 1), 
(2, 1, 2),
(3, 1, 3),
(4,1,4), 

(5,2,5), 
(6,2,6),

(7, 3, 1), 
(8, 3, 2),
(9, 3, 3),
(10,3,7),

(11, 4, 1), 
(12, 4, 8),
(13, 4, 9),
(14, 4, 4),

(15, 5, 1), 
(16, 5, 8),
(17, 5, 9),
(18, 5, 7),

(19,6,5), 
(20,6,6),
(21,6,10),

(22,7,6),
(23,7,10),

(32, 10, 1),
(33, 10, 4),
(34, 10, 8);

----------------------------------------------------------------------------------------
INSERT or REPLACE INTO especie_vegetal (id_especie,nome_cientifico, resiliencia_especie, estrato, colheita_poda_dias, colheita_poda_anos)
VALUES 
(11, 'Manihot esculenta', 3 , 'alto', '180 a 720', '0,5 a 2');

INSERT or REPLACE INTO nome_popular (id_nome_pop,id_especie,nome_pop)
VALUES
(25, 11, 'mandioca'),
(26, 11, 'macaxeira'),
(27, 11, 'aipim');

INSERT or replace INTO canteiro (id_canteiro,id_cult_principal,id_sistema, funcao_canteiro, descricao)
VALUES
(8,1,1,'1.5 - canteiro principal','Milho-mandioca-feijão: Canteiro com 3m de largura. Linha central de mandioca (espaçamento:1,5 m); duas linhas de milho intercalado com feijão de corda (espaçamento entre linhas 1,5m e entreplantas (milho-feijão de corda) 0,5m); feijão faseolo com espaçamento de monocultura nas bordas do canteiro (0,3 m x 0,3 m)'),
(9,1,1,'1.6 - canteiro principal','Milho-mandioca-feijão-vagem: Canteiro com 3m de largura. Linha central de mandioca (espaçamento:1,5 m); duas linhas de milho intercalado com feijão de corda (espaçamento entre linhas 1,5m e entreplantas (milho-feijão de corda) 0,5m); vagem rasteira com espaçamento de monocultura nas bordas do canteiro (0,3 m x 0,3 m)');


INSERT or REPLACE INTO especie_canteiro (id_canteiro_especie,id_canteiro,id_especie)
VALUES
(24, 8, 1), 
(25, 8, 2),
(26, 8, 11),
(27,8,4),

(28, 9, 1), 
(29, 9, 2),
(30, 9, 11),
(31,9,7);
----------------------------------------------------------------------------------------

INSERT or REPLACE INTO especie_vegetal (id_especie,nome_cientifico, resiliencia_especie, estrato, colheita_poda_dias, colheita_poda_anos)
VALUES 
(12, 'Anadenanthera macrocarpa', 3 , 'emergente', '-', '3'),
(13, 'Leucaena leucocephala', 3 , 'alto', '360', '1'),
(14, 'Licania rigida', 3 , 'medio', '-', '3'),
(15, 'Arachis hypogaea', 3 , 'baixo', '180', '0,5'),
(16, 'Ananas comosus', 3 , 'baixo', '360', '1'),
(17, 'Amburana cearensis', 3 , 'alto', '-', '3'),
(18, 'Agave sisalana', 3 , 'baixo', '-', '3 a 8'),
(19, 'Cereus jamacaru', 3 , 'alto', '-', '3'),
(20, 'Spondias tuberosa', 3 , 'medio', '-', '8');

INSERT or REPLACE INTO nome_popular (id_nome_pop,id_especie,nome_pop)
VALUES
(25, 11, 'mandioca'),
(26, 11, 'macaxeira'),
(27, 11, 'aipim'),
(28, 12, 'angico'),
(29, 12, 'arapiraca'),
(30, 12, 'curupai'),
(31, 13, 'leucena'),
(32, 13, 'arvore-do-conflito'),
(33, 13, 'deserto-verde'),
(34, 14, 'oiticica'),
(35, 15, 'amendoim'),
(36, 16, 'abacaxi'),
(37, 17, 'emburana-de-cheiro'),
(38, 17, 'emburana'),
(39, 17, 'imburana'),
(40, 18, 'sisal'),
(41, 18, 'agave'),
(42, 19, 'mandacaru'),
(43, 20, 'umbu')
;

INSERT or replace INTO canteiro (id_canteiro,id_cult_principal,id_sistema, funcao_canteiro, descricao)
VALUES
(8,1,1,'1.5 - canteiro principal','Milho-mandioca-feijão: Canteiro com 3m de largura. Linha central de mandioca (espaçamento:1,5 m); duas linhas de milho intercalado com feijão de corda (espaçamento entre linhas 1,5m e entreplantas (milho-feijão de corda) 0,5m); feijão faseolo com espaçamento de monocultura nas bordas do canteiro (0,3 m x 0,3 m)'),
(9,1,1,'1.6 - canteiro principal','Milho-mandioca-feijão-vagem: Canteiro com 3m de largura. Linha central de mandioca (espaçamento:1,5 m); duas linhas de milho intercalado com feijão de corda (espaçamento entre linhas 1,5m e entreplantas (milho-feijão de corda) 0,5m); vagem rasteira com espaçamento de monocultura nas bordas do canteiro (0,3 m x 0,3 m)'),
(10,1,1,'1.7 - arvores do futuro','Angico-leucena-oiticica: Canteiro com 3m de largura. Linha central de angico, leucena e oiticica (espaçamento:6 m entre cada angico 6 m entre cada leucena e 3 m entre cada oiticica); duas linhas de milho intercalado com fava (espaçamento entre linhas 1,5m e entreplantas (milho-fava) 0,5m); duas linhas de abacaxi (0,5m entre plantas) e quatro linhas de amendoim (0,5 entre linhas e 0,5 m entre plantas)'),
(11,1,1,'1.8 - arvores do futuro','Angico-leucena-umbu: Canteiro com 3m de largura. Linha central de angico, leucena e umbu (espaçamento:6 m entre cada angico 6 m entre cada leucena e 3 m entre cada umbu); duas linhas de milho intercalado com fava (espaçamento entre linhas 1,5m e entreplantas (milho-fava) 0,5m); duas linhas de abacaxi (0,5m entre plantas) e quatro linhas de amendoim (0,5 entre linhas e 0,5 m entre plantas)'),
(12,1,1,'1.9 - arvores do futuro','Mandacaru-leucena-sisal: Canteiro com 3m de largura. Linha central de mandacaru e leucena (espaçamento:6 m entre cada leucena e 1,5 a cada mandacaru); duas linhas de milho intercalado com fava (espaçamento entre linhas 1,5m e entreplantas (milho-fava) 0,5m); duas linhas de abacaxi (0,5m entre plantas) e tres linhas de amendoim (0,5 entre linhas e 0,5 m entre plantas); duas linhas de sisal bem proximas a linha central com 0,5 m de espaçamento entre plantas'),
(13,1,1,'1.10 - arvores do futuro','Emburana-leucena-sisal: Canteiro com 3m de largura. Linha central de emburana e leucena (espaçamento:6 m entre cada leucena e 6 m a cada emburana); duas linhas de milho intercalado com fava (espaçamento entre linhas 1,5m e entreplantas (milho-fava) 0,5m); duas linhas de abacaxi (0,5m entre plantas) e tres linhas de amendoim (0,5 entre linhas e 0,5 m entre plantas)duas linhas de sisal bem proximas a linha central com 0,5 m de espaçamento entre plantas');



INSERT or REPLACE INTO especie_canteiro (id_canteiro_especie,id_canteiro,id_especie)
VALUES
(24, 8, 1), 
(25, 8, 2),
(26, 8, 11),
(27,8,4),

(28, 9, 1), 
(29, 9, 2),
(30, 9, 11),
(31,9,7),

(32, 10, 1), 
(33, 10, 12),
(34, 10, 13),
(35,10,14),
(36, 10, 15), 
(37, 10, 16),

(38, 11, 1), 
(39, 11, 12),
(40, 11, 13),
(41, 11, 20),
(42, 11, 15), 
(43, 11, 16),

(44, 12, 1), 
(45, 12, 19),
(46, 12, 13),
(47, 12, 18),
(48, 12, 15), 
(49, 12, 16),

(50, 13, 1), 
(51, 13, 17),
(52, 13, 13),
(53, 13, 20),
(54, 13, 15), 
(55, 13, 16);





-- Exemplo de consulta
 select id_sistema, nome_cientifico, funcao_planta
	from sistema
	natural join sistema_especie
	natural join especie_vegetal;


-- consulta com o nome popular.
-- Pegando o primeiro resultado do nome popular
-- Outros bancos aceitam usar o first como função agregadora.
-- no SQLite é preciso buscar coluna com o menor ROWID

select id_sistema, nome_pop, nome_cientifico, funcao_planta
	from sistema
	natural join sistema_especie
	natural join especie_vegetal
	natural join nome_popular
	group by id_sistema, nome_cientifico, funcao_planta
	having min(nome_popular.ROWID)


SELECT id_sistema, nome_pop, nome_cientifico
FROM sistema
natural join  

SELECT id_canteiro, funcao_canteiro, descricao,nome_cientifico, colheita_poda_dias
from sistema
	natural join canteiro
	natural join especie_canteiro
	natural join especie_vegetal
	order by id_canteiro;