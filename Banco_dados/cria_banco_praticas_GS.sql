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

CREATE TABLE especie_vegetal (
  id_especie INTEGER PRIMARY KEY NOT NULL,
  nome_cientifico TEXT,
  funcao TEXT,
  resiliencia_especie INTEGER,
  estrato TEXT,
  colheita_poda_dias TEXT,
  colheita_poda_anos TEXT,
  );

CREATE TABLE nome_popular (
  id_nome_pop INTEGER PRIMARY KEY NOT NULL,
  id_especie INTEGER NOT NULL,
  nome_pop TEXT NOT NULL,
  FOREIGN KEY(id_especie) REFERENCES especie_vegetal(id_especie) ON DELETE NO ACTION
);

CREATE TABLE cult_principal (
  id_cult_principal INTEGER PRIMARY KEY NOT NULL,
  id_especie INTEGER NOT NULL,
  FOREIGN KEY(id_especie) REFERENCES especie_vegetal(id_especie) ON DELETE NO ACTION
);

CREATE TABLE sistema (
  id_sistema INTEGER PRIMARY KEY NOT NULL,
  descricao TEXT,
  cartilha TEXT
);

CREATE TABLE canteiro (
  id_canteiro INTEGER PRIMARY KEY NOT NULL,
  id_cult_principal INTEGER,
  id_sistema INTEGER,
  funcao TEXT,
  ciclo TEXT
  descricao TEXT
 FOREIGN KEY("id_cult_principal") REFERENCES "cult_principal"("id_cult_principal") ON DELETE NO ACTION,
  FOREIGN KEY("id_sistema") REFERENCES "sistema"("id_sistema") ON DELETE NO ACTION

  );

CREATE TABLE canteiro_especie (
  id_canteiro_especie INTEGER PRIMARY KEY NOT NULL,
  id_canteiro INTEGER,
  id_especie INTEGER,
  FOREIGN KEY("id_canteiro") REFERENCES "canteiro"("id_canteiro") ON DELETE NO ACTION,
  FOREIGN KEY("id_especie") REFERENCES "especie_vegetal"("id_especie") ON DELETE NO ACTION
);

CREATE TABLE animal (
	id_animal INTEGER PRIMARY KEY NOT NULL,
	nome_animal TEXT,
	raca_animal TEXT
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


INSERT INTO [especie_vegetal] ([id_especie],[nome_cientifico],[resiliencia_especie],[estrato], [colheita_poda_dias], [colheita_poda_anos])
VALUES
(1, 'Zea Mays', '1', 'emergente', '90 a 120', '-'),
(2, 'Vigna unguiculata', '2', 'alto', '90', '-'),
(3, 'Cajanus cajon', '2', 'alto', '180 a 540', '0,5 a 1,5'),
(4, 'Phaseolos vulgaris', '2', 'baixo', '60 a 90', '-'),
(5, 'Crotalaria juncea', '2', 'emergente', '120', '-'),
(6, 'Megathyrsus maximus', '2', 'médio', '180', '-');

INSERT INTO [nome_popular] ([id_nome_pop],[id_especie],[nome_pop])
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
(10, 4, 'feijao carioca')
(11, 4, 'feijao preto')
(12, 5, 'crotalaria')
(13, 5, 'crotalaria juncea')
(14, 6, 'campim mombaça')
(15, 4, 'mombaça');

INSERT INTO [sistema] ([id_sistema], [descrição], [cartilha])
VALUES
(1, 'Sistema de consórcio simples (algodão + feijões) com entrelinhas de mombaça + crotalária para fornecimento de matéria organica', 'cartilha 1');


INSERT INTO [canteiro_especie] ([id_canteiro_especie],[id_canteiro],[id_especie])
VALUES
(1, 1, 1), 
(2, 1, 2),
(3, 1, 3),
(4,1,4), 
(5,2,5), 
(6,2,6);



INSERT INTO [canteiro] ([id_canteiro],[id_cult_principal],[id_sistema], [funcao],[ciclo],[descricao])
VALUES
(1,1,1,'canteiro principal','anual','Canteiro com 3m de largura: Linha central de guandú (espaçamento:0,75 m); duas linhas de milho intercalado com feijão de corda (espaçamento entre linhas 1,5m e entreplantas 0,5m); feijão faseolo com espaçamento de monocultura nas bordas do canteiro (0,3 m x 0,3 m)'),
(2,1,1,'entrelinha adubadora','anual','fazer uma muvuca com as sementes na porporção de 20kg/ha de crotalária e 10kg/ha de mombaça')
;




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
