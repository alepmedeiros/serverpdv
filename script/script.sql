-- api.cest definição

-- Drop table

-- DROP TABLE api.cest;

CREATE TABLE api.cest (
	id varchar(7) NOT NULL,
	ncm varchar(10) NOT NULL,
	descricao varchar(600) NULL,
	CONSTRAINT pk_cest PRIMARY KEY (id, ncm)
);


-- api.cfop definição

-- Drop table

-- DROP TABLE api.cfop;

CREATE TABLE api.cfop (
	id int2 NOT NULL,
	descricao varchar(500) NULL,
	CONSTRAINT pk_cfop PRIMARY KEY (id)
);


-- api.cst definição

-- Drop table

-- DROP TABLE api.cst;

CREATE TABLE api.cst (
	id varchar(3) NOT NULL,
	descricao varchar(250) NULL,
	simples_nacional bpchar(1) NULL,
	CONSTRAINT pk_cst PRIMARY KEY (id)
);


-- api.cstcofins definição

-- Drop table

-- DROP TABLE api.cstcofins;

CREATE TABLE api.cstcofins (
	id bpchar(2) NOT NULL,
	descricao varchar(250) NULL,
	CONSTRAINT pk_cstcofins PRIMARY KEY (id)
);


-- api.cstipi definição

-- Drop table

-- DROP TABLE api.cstipi;

CREATE TABLE api.cstipi (
	id bpchar(2) NOT NULL,
	descricao varchar(250) NULL,
	CONSTRAINT pk_cstipi PRIMARY KEY (id)
);


-- api.cstpis definição

-- Drop table

-- DROP TABLE api.cstpis;

CREATE TABLE api.cstpis (
	id bpchar(2) NOT NULL,
	descricao varchar(250) NULL,
	CONSTRAINT pk_cstpis PRIMARY KEY (id)
);


-- api.empresas definição

-- Drop table

-- DROP TABLE api.empresas;

CREATE TABLE api.empresas (
	id uuid DEFAULT api.uuid_generate_v4() NOT NULL,
	nome varchar(255) NOT NULL,
	cnpj varchar(18) NOT NULL,
	telefone varchar(15) NULL,
	email varchar(255) NULL,
	inscricaoestadual varchar(30) NULL,
	inscricaoestadualst varchar(30) NULL,
	inscricaomunicipal varchar(30) NULL,
	crt int4 DEFAULT 0 NOT NULL,
	logotipo varchar(255) NULL,
	regime int4 NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT empresas_cnpj_key UNIQUE (cnpj),
	CONSTRAINT empresas_email_key UNIQUE (email),
	CONSTRAINT empresas_pkey PRIMARY KEY (id)
);


-- api.ibpt definição

-- Drop table

-- DROP TABLE api.ibpt;

CREATE TABLE api.ibpt (
	id varchar(15) NOT NULL,
	extipi varchar(3) NOT NULL,
	tipo int4 NOT NULL,
	aliq_nacional numeric(5, 2) NULL,
	aliq_importado numeric(5, 2) NULL,
	aliq_estadual numeric(5, 2) NULL,
	aliq_municipal numeric(5, 2) NULL,
	cest varchar(7) NULL,
	CONSTRAINT pk_ibpt PRIMARY KEY (id, extipi, tipo)
);


-- api.origem definição

-- Drop table

-- DROP TABLE api.origem;

CREATE TABLE api.origem (
	id int4 NOT NULL,
	descricao varchar(250) NULL,
	CONSTRAINT pk_origem PRIMARY KEY (id)
);


-- api.uf definição

-- Drop table

-- DROP TABLE api.uf;

CREATE TABLE api.uf (
	id bpchar(2) NOT NULL,
	descricao varchar(50) NULL,
	cod_ibge int4 NULL,
	CONSTRAINT pk_uf PRIMARY KEY (id)
);


-- api.caixa definição

-- Drop table

-- DROP TABLE api.caixa;

CREATE TABLE api.caixa (
	id uuid DEFAULT api.uuid_generate_v4() NOT NULL,
	empresa_id uuid NULL,
	nome varchar(100) NULL,
	CONSTRAINT caixa_pkey PRIMARY KEY (id),
	CONSTRAINT caixa_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES api.empresas(id) ON DELETE CASCADE
);


-- api.cidade definição

-- Drop table

-- DROP TABLE api.cidade;

CREATE TABLE api.cidade (
	cod_ibge int4 NOT NULL,
	descricao varchar(100) NULL,
	id_uf bpchar(2) NOT NULL,
	CONSTRAINT pk_cidade PRIMARY KEY (cod_ibge),
	CONSTRAINT fk_uf FOREIGN KEY (id_uf) REFERENCES api.uf(id)
);


-- api.emissores_fiscais definição

-- Drop table

-- DROP TABLE api.emissores_fiscais;

CREATE TABLE api.emissores_fiscais (
	id uuid DEFAULT api.uuid_generate_v4() NOT NULL,
	empresa uuid NOT NULL,
	tipo_documento_fiscal varchar(10) NOT NULL,
	ambiente_emissao varchar(15) NOT NULL,
	serie_emissao varchar(5) NOT NULL,
	numero_nota_fiscal int4 NOT NULL,
	tipo_emissao varchar(10) NULL,
	tipo_sped varchar(20) NULL,
	certificado_digital bytea NULL,
	senha_certificado varchar(255) NULL,
	CONSTRAINT emissores_fiscais_pkey PRIMARY KEY (id),
	CONSTRAINT emissores_fiscais_empresa_fkey FOREIGN KEY (empresa) REFERENCES api.empresas(id) ON DELETE CASCADE
);


-- api.empresa_cnae definição

-- Drop table

-- DROP TABLE api.empresa_cnae;

CREATE TABLE api.empresa_cnae (
	id uuid DEFAULT api.uuid_generate_v4() NOT NULL,
	empresa uuid NULL,
	principal bpchar(1) NULL,
	ramo_atividade varchar(50) NULL,
	objetivo_social bytea NULL,
	CONSTRAINT empresa_cnae_pkey PRIMARY KEY (id),
	CONSTRAINT empresa_cnae_empresa_fkey FOREIGN KEY (empresa) REFERENCES api.empresas(id) ON DELETE CASCADE
);


-- api.enderecos definição

-- Drop table

-- DROP TABLE api.enderecos;

CREATE TABLE api.enderecos (
	id uuid DEFAULT api.uuid_generate_v4() NOT NULL,
	empresa uuid NULL,
	logradouro varchar(255) NOT NULL,
	numero varchar(10) NULL,
	complemento varchar(100) NULL,
	bairro varchar(100) NULL,
	cidade varchar(100) NULL,
	estado varchar(50) NULL,
	cep varchar(10) NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT enderecos_pkey PRIMARY KEY (id),
	CONSTRAINT enderecos_empresa_fkey FOREIGN KEY (empresa) REFERENCES api.empresas(id) ON DELETE CASCADE
);


-- api.marcas definição

-- Drop table

-- DROP TABLE api.marcas;

CREATE TABLE api.marcas (
	id uuid DEFAULT api.uuid_generate_v4() NOT NULL,
	empresa uuid NULL,
	nome varchar(50) NULL,
	descricao varchar(100) NULL,
	CONSTRAINT marcas_pkey PRIMARY KEY (id),
	CONSTRAINT marcas_empresa_fkey FOREIGN KEY (empresa) REFERENCES api.empresas(id) ON DELETE CASCADE
);


-- api.turno definição

-- Drop table

-- DROP TABLE api.turno;

CREATE TABLE api.turno (
	id uuid DEFAULT api.uuid_generate_v4() NOT NULL,
	empresa_id uuid NULL,
	nome varchar(100) NULL,
	CONSTRAINT turno_pkey PRIMARY KEY (id),
	CONSTRAINT turno_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES api.empresas(id) ON DELETE CASCADE
);


-- api.unidades definição

-- Drop table

-- DROP TABLE api.unidades;

CREATE TABLE api.unidades (
	id uuid DEFAULT api.uuid_generate_v4() NOT NULL,
	empresa uuid NULL,
	sigla varchar(10) NULL,
	descricao varchar(100) NULL,
	CONSTRAINT unidades_pkey PRIMARY KEY (id),
	CONSTRAINT unidades_empresa_fkey FOREIGN KEY (empresa) REFERENCES api.empresas(id) ON DELETE CASCADE
);


-- api.usuarios definição

-- Drop table

-- DROP TABLE api.usuarios;

CREATE TABLE api.usuarios (
	id uuid DEFAULT api.uuid_generate_v4() NOT NULL,
	nome varchar(255) NOT NULL,
	email varchar(255) NOT NULL,
	senha varchar(255) NOT NULL,
	empresa uuid NULL,
	"role" varchar(50) DEFAULT 'usuario'::character varying NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT usuarios_email_key UNIQUE (email),
	CONSTRAINT usuarios_pkey PRIMARY KEY (id),
	CONSTRAINT usuarios_empresa_fkey FOREIGN KEY (empresa) REFERENCES api.empresas(id) ON DELETE CASCADE
);


-- api.auditoria definição

-- Drop table

-- DROP TABLE api.auditoria;

CREATE TABLE api.auditoria (
	id uuid DEFAULT api.uuid_generate_v4() NOT NULL,
	acao varchar(255) NOT NULL,
	usuario_id uuid NULL,
	data_acao timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	detalhes text NULL,
	CONSTRAINT auditoria_pkey PRIMARY KEY (id),
	CONSTRAINT auditoria_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES api.usuarios(id)
);


-- api.caixa_movimento definição

-- Drop table

-- DROP TABLE api.caixa_movimento;

CREATE TABLE api.caixa_movimento (
	id uuid DEFAULT api.uuid_generate_v4() NOT NULL,
	operador uuid NULL,
	empresa_id uuid NULL,
	caixa uuid NULL,
	turno uuid NULL,
	data_abertura date NOT NULL,
	data_fechamento date NULL,
	situacao varchar(1) NULL,
	CONSTRAINT caixa_movimento_pkey PRIMARY KEY (id),
	CONSTRAINT caixa_movimento_caixa_fkey FOREIGN KEY (caixa) REFERENCES api.caixa(id),
	CONSTRAINT caixa_movimento_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES api.empresas(id) ON DELETE CASCADE,
	CONSTRAINT caixa_movimento_operador_fkey FOREIGN KEY (operador) REFERENCES api.usuarios(id),
	CONSTRAINT caixa_movimento_turno_fkey FOREIGN KEY (turno) REFERENCES api.turno(id)
);


-- api.clientes definição

-- Drop table

-- DROP TABLE api.clientes;

CREATE TABLE api.clientes (
	id uuid DEFAULT api.uuid_generate_v4() NOT NULL,
	nome varchar(255) NOT NULL,
	cpf_cnpj varchar(18) NOT NULL,
	telefone varchar(15) NULL,
	email varchar(255) NULL,
	indie int4 DEFAULT 1 NOT NULL,
	inscricaoestadual varchar(30) NULL,
	inscricaomunicipal varchar(30) NULL,
	suframa varchar(30) NULL,
	endereco uuid NULL,
	empresa uuid NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT clientes_cpf_cnpj_key UNIQUE (cpf_cnpj),
	CONSTRAINT clientes_email_key UNIQUE (email),
	CONSTRAINT clientes_pkey PRIMARY KEY (id),
	CONSTRAINT clientes_empresa_fkey FOREIGN KEY (empresa) REFERENCES api.empresas(id) ON DELETE CASCADE,
	CONSTRAINT clientes_endereco_fkey FOREIGN KEY (endereco) REFERENCES api.enderecos(id) ON DELETE SET NULL
);


-- api.notas_fiscais definição

-- Drop table

-- DROP TABLE api.notas_fiscais;

CREATE TABLE api.notas_fiscais (
	id uuid DEFAULT api.uuid_generate_v4() NOT NULL,
	serie int4 NOT NULL,
	numero int4 NOT NULL,
	usuario uuid NULL,
	empresa uuid NULL,
	cliente uuid NULL,
	situacao bpchar(1) NULL,
	chave_acesso bpchar(44) NULL,
	dt_emissao date NULL,
	dthr_saida timestamp NULL,
	tipo_nfe int4 NULL,
	tipo_emissao int4 NULL,
	dest_nome varchar(60) NULL,
	dest_cnpj_cpf varchar(14) NULL,
	dest_fone varchar(14) NULL,
	dest_endereco varchar(60) NULL,
	dest_numero varchar(60) NULL,
	dest_complemento varchar(60) NULL,
	dest_bairro varchar(60) NULL,
	dest_cidade int4 NULL,
	dest_cidade_descricao varchar(60) NULL,
	dest_uf bpchar(2) NULL,
	dest_cep varchar(8) NULL,
	vl_base_icms numeric(15, 2) NULL,
	vl_icms numeric(15, 2) NULL,
	vl_desconto numeric(15, 2) NULL,
	vl_produtos numeric(15, 2) NULL,
	vl_outras numeric(15, 2) NULL,
	vl_total_nf numeric(15, 2) NULL,
	vl_pis numeric(15, 2) NULL,
	vl_cofins numeric(15, 2) NULL,
	vl_troco numeric(15, 2) NULL,
	cstat int4 NULL,
	xmotivo varchar(255) NULL,
	dhrecbto timestamp NULL,
	nprot varchar(50) NULL,
	protocolo int4 NULL,
	observacao bytea NULL,
	"xml" varchar(255) NULL,
	xml_cancelamento varchar(255) NULL,
	caixa_movimento uuid NULL,
	cnf int4 NULL,
	carro_km int4 NULL,
	carro_placa varchar(50) NULL,
	CONSTRAINT notas_fiscais_pkey PRIMARY KEY (id),
	CONSTRAINT notas_fiscais_caixa_movimento_fkey FOREIGN KEY (caixa_movimento) REFERENCES api.caixa_movimento(id),
	CONSTRAINT notas_fiscais_cliente_fkey FOREIGN KEY (cliente) REFERENCES api.clientes(id),
	CONSTRAINT notas_fiscais_empresa_fkey FOREIGN KEY (empresa) REFERENCES api.empresas(id) ON DELETE CASCADE,
	CONSTRAINT notas_fiscais_usuario_fkey FOREIGN KEY (usuario) REFERENCES api.usuarios(id)
);


-- api.produtos definição

-- Drop table

-- DROP TABLE api.produtos;

CREATE TABLE api.produtos (
	id uuid DEFAULT api.uuid_generate_v4() NOT NULL,
	empresa uuid NULL,
	unidade uuid NULL,
	marca uuid NULL,
	gtin varchar(14) NULL,
	codigo_interno varchar(60) NULL,
	ncm varchar(8) NULL,
	nome varchar(100) NULL,
	descricao varchar(100) NULL,
	descricao_pdv varchar(30) NULL,
	valor_compra numeric(18, 6) NULL,
	valor_venda numeric(18, 6) NULL,
	preco_venda_minimo numeric(18, 6) NULL,
	preco_lucro_zero numeric(18, 6) NULL,
	preco_lucro_minimo numeric(18, 6) NULL,
	preco_lucro_maximo numeric(18, 6) NULL,
	quantidade_estoque numeric(18, 6) NULL,
	quantidade_estoque_anterior numeric(18, 6) NULL,
	estoque_minimo numeric(18, 6) NULL,
	estoque_maximo numeric(18, 6) NULL,
	estoque_ideal numeric(18, 6) NULL,
	excluido bpchar(1) NULL,
	inativo bpchar(1) NULL,
	data_cadastro date NULL,
	foto_produto varchar(100) NULL,
	iat bpchar(1) NULL,
	ippt bpchar(1) NULL,
	tipo_item_sped bpchar(2) NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT produtos_pkey PRIMARY KEY (id),
	CONSTRAINT produtos_empresa_fkey FOREIGN KEY (empresa) REFERENCES api.empresas(id) ON DELETE CASCADE,
	CONSTRAINT produtos_marca_fkey FOREIGN KEY (marca) REFERENCES api.marcas(id),
	CONSTRAINT produtos_unidade_fkey FOREIGN KEY (unidade) REFERENCES api.unidades(id)
);


-- api.venda_itens definição

-- Drop table

-- DROP TABLE api.venda_itens;

CREATE TABLE api.venda_itens (
	id uuid DEFAULT api.uuid_generate_v4() NOT NULL,
	produto uuid NULL,
	venda uuid NULL,
	quantidade numeric(18, 6) NULL,
	valor_unitario numeric(18, 6) NULL,
	valor_subtotal numeric(18, 6) NULL,
	taxa_desconto numeric(18, 6) NULL,
	valor_desconto numeric(18, 6) NULL,
	valor_total numeric(18, 6) NULL,
	taxa_comissao numeric(18, 6) NULL,
	valor_comissao numeric(18, 6) NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT venda_itens_pkey PRIMARY KEY (id),
	CONSTRAINT venda_itens_produto_fkey FOREIGN KEY (produto) REFERENCES api.produtos(id),
	CONSTRAINT venda_itens_venda_fkey FOREIGN KEY (venda) REFERENCES api.clientes(id) ON DELETE CASCADE
);


-- api.vendas definição

-- Drop table

-- DROP TABLE api.vendas;

CREATE TABLE api.vendas (
	id uuid DEFAULT api.uuid_generate_v4() NOT NULL,
	cliente_id uuid NULL,
	usuario_id uuid NULL,
	empresa_id uuid NULL,
	total numeric(10, 2) NOT NULL,
	data_venda timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	datahorasaida timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	numero_fatura int4 NULL,
	valor_subtotal numeric(18, 6) NULL,
	taxa_comissao numeric(18, 6) NULL,
	valor_comissao numeric(18, 6) NULL,
	taxa_desconto numeric(18, 6) NULL,
	valor_desconto numeric(18, 6) NULL,
	valor_total numeric(18, 6) NULL,
	tipo_frete bpchar(1) NULL,
	forma_pagamento bpchar(1) NULL,
	valor_frete numeric(18, 6) NULL,
	valor_seguro numeric(18, 6) NULL,
	observacao varchar(255) NULL,
	situacao bpchar(1) NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT vendas_pkey PRIMARY KEY (id),
	CONSTRAINT vendas_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES api.clientes(id),
	CONSTRAINT vendas_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES api.empresas(id) ON DELETE CASCADE,
	CONSTRAINT vendas_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES api.usuarios(id)
);


-- api.notas_fiscais_itens definição

-- Drop table

-- DROP TABLE api.notas_fiscais_itens;

CREATE TABLE api.notas_fiscais_itens (
	serie int4 NOT NULL,
	numero int4 NOT NULL,
	item int4 NOT NULL,
	produto uuid NULL,
	notas_fiscais uuid NULL,
	gtin varchar(14) NULL,
	descricao varchar(120) NULL,
	cfop int4 NULL,
	und varchar(6) NULL,
	quantidade numeric(15, 4) NULL,
	vl_unitario numeric(18, 10) NULL,
	vl_desconto numeric(15, 2) NULL,
	vl_desconto_rateio numeric(15, 2) NULL,
	vl_outros numeric(15, 2) NULL,
	vl_outros_rateio numeric(15, 2) NULL,
	vl_produto numeric(15, 2) NULL,
	vl_total numeric(15, 2) NULL,
	origem int4 NULL,
	cst varchar(3) NULL,
	ncm varchar(8) NULL,
	extipi varchar(3) NULL,
	sn_vbase numeric(15, 2) NULL,
	sn_aliqcredito numeric(5, 2) NULL,
	sn_vcredito numeric(15, 2) NULL,
	icms_vbase numeric(15, 2) NULL,
	icms_aliquota numeric(5, 2) NULL,
	icms_vimposto numeric(15, 2) NULL,
	pis_cst bpchar(2) NULL,
	pis_vbase numeric(15, 2) NULL,
	pis_aliquota numeric(5, 2) NULL,
	pis_vimposto numeric(15, 2) NULL,
	cofins_cst bpchar(2) NULL,
	cofins_vbase numeric(15, 2) NULL,
	cofins_aliquota numeric(5, 2) NULL,
	cofins_vimposto numeric(15, 2) NULL,
	in_aliq_federal numeric(5, 2) NULL,
	in_vl_federal numeric(15, 2) NULL,
	in_aliq_estadual numeric(5, 2) NULL,
	in_vl_estadual numeric(15, 2) NULL,
	in_aliq_municipal numeric(5, 2) NULL,
	in_vl_municipal numeric(15, 2) NULL,
	inf_adicional varchar(500) NULL,
	cest varchar(7) NULL,
	id_codigo_anp int4 NULL,
	CONSTRAINT notas_fiscais_itens_notas_fiscais_fkey FOREIGN KEY (notas_fiscais) REFERENCES api.notas_fiscais(id) ON DELETE CASCADE,
	CONSTRAINT notas_fiscais_itens_produto_fkey FOREIGN KEY (produto) REFERENCES api.produtos(id)
);