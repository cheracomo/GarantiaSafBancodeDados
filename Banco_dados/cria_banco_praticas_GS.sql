CREATE TABLE ctrl_biologico_pragas (
  id_ctrl_biologico INTEGER PRIMARY KEY NOT NULL,
  id_praga_cien INTEGER,
  insumo_ctrl_bio TEXT,
  descricao_crtl_bio TEXT,
  FOREIGN KEY(id_praga_cien) REFERENCES pragas(id_praga_cien) ON DELETE NO ACTION
);

CREATE TABLE especie_vegetal (
  id_especie INTEGER PRIMARY KEY NOT NULL,
  nome_cientifico TEXT,
  estrato TEXT,
  exigencia_fert TEXT,
  ciclo TEXT,
  alimento_humano TEXT,
  medicinal TEXT,
  bioma_caract TEXT
);

CREATE TABLE nome_popular (
  id_nome_pop INTEGER PRIMARY KEY NOT NULL,
  id_especie INTEGER NOT NULL,
  nome_pop TEXT NOT NULL,
  FOREIGN KEY(id_especie) REFERENCES especie_vegetal(id_especie) ON DELETE NO ACTION
);

CREATE TABLE pragas (
  id_praga_cien INTEGER PRIMARY KEY NOT NULL,
  id_planta INTEGER,
  praga_cientifico TEXT,
  descricao_praga TEXT,
  descricao_sintoma TEXT,
  FOREIGN KEY(id_planta) REFERENCES especie_vegetal
);

CREATE TABLE pragas_pop (
  id_praga_pop INTEGER PRIMARY KEY NOT NULL,
  id_praga_cien INTEGER,
  praga_pop TEXT,
  FOREIGN KEY(id_praga_cien) REFERENCES pragas(id_praga_cien) ON DELETE NO ACTION
);

CREATE TABLE sistema (
  id_sistema INTEGER PRIMARY KEY NOT NULL,
  nome TEXT,
  descricao TEXT,
  complexidade TEXT,
  referencias TEXT,
  cartilha TEXT
);

CREATE TABLE sistema_especie (
  id_sistema_especie INTEGER PRIMARY KEY NOT NULL,
  id_sistema INTEGER,
  id_especie INTEGER,
  funcao_planta TEXT,
  espacamento_entreplantas TEXT,
  espacamento_entrelinhas TEXT,
  FOREIGN KEY("id_especie") REFERENCES "especie_vegetal"("id_especie") ON DELETE NO ACTION,
  FOREIGN KEY("id_sistema") REFERENCES "sistema"("id_sistema") ON DELETE NO ACTION
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

INSERT INTO [especie_vegetal] ([id_especie],[nome_cientifico],[estrato], [exigencia_fert], [ciclo], [alimento_humano], [medicinal],[bioma_caract])
VALUES
(1, 'Zea Mays', 'alto', 'media/alta', 'semestral', 'sim', 'nao', 'indet'),
(2, 'Cajanus cajon', 'alto', 'media', 'bianual', 'sim', 'sim', 'cerrado/caatinga'),
(3, 'Crotalaria sp', 'emergente', 'media', 'anual', 'nao', 'sim', 'cerrado/caatinga'),
(4, 'Gliricidia Sepium', 'alto', 'alta', 'perene', 'nao', 'sim', 'cerrado/caatinga');

INSERT INTO [nome_popular] ([id_nome_pop],[id_especie],[nome_pop])
VALUES
(1, 1, 'milho'),
(2, 2, 'feijao guandu'),
(3, 2, 'guandu'),
(4, 2, 'feijao de arvore'),
(5, 3, 'crotalaria'),
(6, 3, 'crotalaria juncea'),
(7, 4, 'gliricidia'),
(8, 4, 'coiote'),
(9, 4, 'madre de cacau'),
(10, 4, 'mata raton');

INSERT INTO [sistema] ([id_sistema],[descricao],[complexidade], [referencias], [cartilha])
VALUES
(1, 'Sistema consorciado de milho como cultura principal, guandu junto com milho na linha, crotalaria como cultura de entrelinha e gliricidia como planta adubadora', 'Complexidade nivel 2: 2L,1E,1A', 'Sistema Santa Brígida – Tecnologia Embrapa: Consorciação de Milho com Leguminosas, EFEITO DA Gliricidia sepium SOBRE
NUTRIENTES DO SOLO, MICROCLIMA E
PRODUTIVIDADE DO MILHO EM SISTEMA
AGROFLORESTAL NO AGRESTE PARAIBANO', 'cartilha 1');

INSERT INTO [sistema_especie] ([id_sistema_especie],[id_sistema],[id_especie],[funcao_planta],[espacamento_entreplantas],[espacamento_entrelinhas])
VALUES
(1, 1, 1, 'cultura principal', '0,2', '1,0')
(2, 1, 2, 'consorcio-linha', 'nd', 'nd'),
(3, 1, 3, 'consorcio-entrelinha', 'nd', 'nd'),
(4, 1, 4, 'consorcio-adubadora', 'nd', 'nd');


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
