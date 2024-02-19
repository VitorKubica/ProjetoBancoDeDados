--Lívia Freitas RM99892
--Luiza Nunes RM99768
--Renan de Amorim RM551553
--Vitor Kubica RM98903


CREATE TABLE t_rhstu_bairro (
    id_bairro NUMBER(8) NOT NULL,
    id_cidade NUMBER(8) NOT NULL,
    nm_bairro VARCHAR2(45) NOT NULL,
    nm_zona_bairro VARCHAR2(20) NOT NULL
);

ALTER TABLE t_rhstu_bairro ADD CONSTRAINT uk_rhstu_bairro_zona CHECK ( nm_zona_bairro IN (
    'CENTRO', 
    'ZONA LESTE', 
    'ZONA NORTE', 
    'ZONA OESTE', 
    'ZONA SUL'
) );

COMMENT ON COLUMN t_rhstu_bairro.id_bairro IS 'Esta coluna irá receber o codigo interno para garantir o 
    cadastro dos Bairros da Cidade do Estado do Brasil. 
    Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_bairro.nm_bairro IS 'Esta coluna irá receber o nome do Bairro  pertencente Cidade do Estado Brasileiro. 
    O padrão de armazenmento é  InitCap e seu conteúdo é obrigatório. Essa tabela já será preenchida pela área responsável. 
    Novas inseções necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_rhstu_bairro.nm_zona_bairro IS 'Esta coluna irá receber a localização da zona onde se encontra o bairro. 
    Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro.';

ALTER TABLE t_rhstu_bairro ADD CONSTRAINT pk__rhstu_bairro PRIMARY KEY ( id_bairro );

CREATE TABLE t_rhstu_cidade (
    id_cidade  NUMBER(8) NOT NULL,
    id_estado  NUMBER(2) NOT NULL,
    nm_cidade  VARCHAR2(60) NOT NULL,
    cd_ibge    NUMBER(8) NOT NULL,
    nr_ddd     NUMBER(3) NOT NULL
);

COMMENT ON COLUMN t_rhstu_cidade.id_cidade IS 'Esta coluna irá receber o codigo da cidade e seu conteúdo é obrigatório e 
    será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_cidade.id_estado IS 'Esta coluna irá receber o codigo interno para garantir unicidade dos Estados do Brasil.
Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_cidade.nm_cidade IS 'Esta coluna irá receber o nome do Cidade pertencente ao Estado Brasileiro. 
    O padrão de armazenmento é  InitCap e seu conteúdo é obrigatório. Essa tabela já será preenchida pela área responsável. 
    Novas inseções necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_rhstu_cidade.cd_ibge IS 'Esta coluna irá receber o código do IBGE que fornece informações para geração da NFe.';

ALTER TABLE t_rhstu_cidade ADD CONSTRAINT pk_rhstu_cidade PRIMARY KEY ( id_cidade );

CREATE TABLE t_rhstu_consulta (
    id_unid_hospital  NUMBER(9) NOT NULL,
    nr_consulta       NUMBER NOT NULL,
    id_paciente       NUMBER(9) NOT NULL,
    cd_medico         NUMBER NOT NULL,
    dt_hr_consulta    DATE NOT NULL,
    nr_consultorio    NUMBER(5) NOT NULL
);

ALTER TABLE t_rhstu_consulta ADD CONSTRAINT pk_rhstu_consulta PRIMARY KEY ( nr_consulta, id_unid_hospital );

CREATE TABLE t_rhstu_consulta_forma_pagto (
    id_consulta_forma_pagto  NUMBER NOT NULL,
    id_unid_hospital         NUMBER(9) NOT NULL,
    nr_consulta              NUMBER NOT NULL,
    id_paciente_ps           NUMBER(10) NOT NULL,
    id_forma_pagto           NUMBER NOT NULL,
    dt_cadastro              DATE NOT NULL,
    dt_pagto_consulta        DATE,
    st_pagto_consulta        CHAR(1) NOT NULL
);

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT uk_rhstu_status_pagto_paci CHECK ( st_pagto_consulta IN (
        'A',
        'C',
        'P'
    ) );

ALTER TABLE t_rhstu_consulta_forma_pagto ADD CONSTRAINT pk_rhstu_consulta_forma_pagto PRIMARY KEY ( id_consulta_forma_pagto );

CREATE TABLE t_rhstu_contato_paciente (
    id_paciente      NUMBER(9) NOT NULL,
    id_contato       NUMBER(9) NOT NULL,
    id_tipo_contato  NUMBER(5) NOT NULL,
    nm_contato       VARCHAR2(40) NOT NULL,
    nr_ddi           NUMBER(3),
    nr_ddd           NUMBER(3),
    nr_telefone      NUMBER(10)
);

COMMENT ON COLUMN t_rhstu_contato_paciente.id_paciente IS 'Esse atributo irá receber a chave primária do paciente. 
    Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_contato_paciente.id_contato IS 'Esse atributo irá receber a chave primária do contato do paciente. 
    Esse número é sequencial e inicia sempre com 1 a partir do id do paciente e é gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_contato_paciente.id_tipo_contato IS 'Esse atributo irá receber a chave primária do tipo do contato. 
    Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_contato_paciente.nm_contato IS 'Este atributo irá receber o nome do contato do paciente. 
    Seu conteudo é obrigatório.';

COMMENT ON COLUMN t_rhstu_contato_paciente.nr_ddi IS 'Este atributo irá receber o número do DDI do telefone do contato do paciente. 
    Seu conteudo é opcional.';

COMMENT ON COLUMN t_rhstu_contato_paciente.nr_ddd IS 'Este atributo irá receber o número do DDD  do telefone do contato do paciente. 
    Seu conteudo é opcional.';

COMMENT ON COLUMN t_rhstu_contato_paciente.nr_telefone IS 'Este atributo irá receber o número do telefone do contato do paciente. 
    Seu conteudo é opcional.';

ALTER TABLE t_rhstu_contato_paciente ADD CONSTRAINT pk_rhstu_contato_emerg_pac PRIMARY KEY ( id_contato, id_paciente );

CREATE TABLE t_rhstu_email_paciente (
    id_email     NUMBER(9) NOT NULL,
    id_paciente  NUMBER(9) NOT NULL,
    ds_email     VARCHAR2(100) NOT NULL,
    tp_email     VARCHAR2(20) NOT NULL,
    st_email     CHAR(1) NOT NULL
);

ALTER TABLE t_rhstu_email_paciente
    ADD CONSTRAINT uk_rhstu_status_email_pac CHECK ( st_email IN (
        'A',
        'I'
    ) );

COMMENT ON COLUMN t_rhstu_email_paciente.id_email IS 'Esse atributo irá receber a chave primária do email do paciente. 
    Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_email_paciente.id_paciente IS 'Esse atributo irá receber a chave primária do paciente. 
    Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_email_paciente.ds_email IS 'Esse atributo irá receber o email do paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_email_paciente.tp_email IS 'Esse atributo irá receber o tipo email do paciente.  
    Seu conteúdo é obrigatório e deve possuir os seguintes valores: Pessoal ou Profissional.';

COMMENT ON COLUMN t_rhstu_email_paciente.st_email IS 'Esse atributo irá receber o status do email do paciente.  
    Seu conteúdo é obrigatório e deve possuir os seguintes valores: (A)tivo ou (I)nativo.';

ALTER TABLE t_rhstu_email_paciente ADD CONSTRAINT pk_rhstu_email_paciente PRIMARY KEY ( id_email );

CREATE TABLE t_rhstu_endereco_paciente (
    id_endereco            NUMBER(9) NOT NULL,
    id_paciente            NUMBER(9) NOT NULL,
    id_logradouro          NUMBER(10) NOT NULL,
    nr_logradouro          NUMBER(7),
    ds_complemento_numero  VARCHAR2(30),
    ds_ponto_referencia    VARCHAR2(50),
    dt_inicio              DATE NOT NULL,
    dt_fim                 DATE
);

COMMENT ON COLUMN t_rhstu_endereco_paciente.id_endereco IS 'Esse atributo irá receber a chave primária do endereco do paciente. 
    Esse número é sequencia e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.id_paciente IS 'Esse atributo irá receber a chave primária do paciente. 
    Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.nr_logradouro IS 'Esse atributo irá receber o número do logradouro do endereco do paciente. 
    Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.ds_complemento_numero IS 'Esse atributo irá receber o complemeneto  do logradouro do 
    endereco do paciente caso ele exista. Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.ds_ponto_referencia IS 'Esse atributo irá receber o ponto de referência  do logradouro do 
    endereco do paciente.  Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.dt_inicio IS 'Esse atributo irá receber a data inicio do paciente associado ao endereço 
    (logradouro). Seu conteúdo é obrigatorio.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.dt_fim IS 'Esse atributo irá receber a data fim do paciente associado ao endereço 
    (logradouro), ou seja, ele não reside mais nesse endereço.  Seu conteúdo é opcional.';

ALTER TABLE t_rhstu_endereco_paciente ADD CONSTRAINT pk_rhstu_endereco_paciente PRIMARY KEY ( id_endereco );

CREATE TABLE t_rhstu_estado (
    id_estado  NUMBER(2) NOT NULL,
    sg_estado  CHAR(2) NOT NULL,
    nm_estado  VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_estado.id_estado IS
    'Esta coluna irá receber o codigo interno para garantir unicidade dos Estados do Brasil. 
    Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_estado.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_estado.nm_estado IS
    'Esta coluna irá receber o nome do estado. O padrão de armazenmento é  InitCap e seu conteúdo é obrigatório. 
    Essa tabela já será preenchida pela área responsável. Novas inseções necessitam ser avaladas pelos gestores.';

ALTER TABLE t_rhstu_estado ADD CONSTRAINT pk_rhstu_estado PRIMARY KEY ( id_estado );

CREATE TABLE t_rhstu_forma_pagamento (
    id_forma_pagto  NUMBER NOT NULL,
    nm_forma_pagto  VARCHAR2(60) NOT NULL,
    ds_forma_pagto  VARCHAR2(500),
    st_forma_pagto  CHAR(1) DEFAULT 'A' NOT NULL
);

ALTER TABLE t_rhstu_forma_pagamento
    ADD CONSTRAINT uk_rhstu_status_forma_pagto CHECK ( st_forma_pagto IN (
        'A',
        'I'
    ) );

ALTER TABLE t_rhstu_forma_pagamento ADD CONSTRAINT pk_rhstu_forma_pagto PRIMARY KEY ( id_forma_pagto );

CREATE TABLE t_rhstu_logradouro (
    id_logradouro  NUMBER(10) NOT NULL,
    id_bairro      NUMBER(8) NOT NULL,
    nm_logradouro  VARCHAR2(100) NOT NULL,
    nr_cep         NUMBER(8) NOT NULL
);

COMMENT ON COLUMN t_rhstu_logradouro.id_logradouro IS
    'Esta coluna irá receber o codigo interno para garantir o lograouro, que esta localizado no  cadastro dos  Bairros da Cidade do 
    Estado do Brasil. Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_logradouro.id_bairro IS
    'Esta coluna irá receber o codigo interno para garantir o cadastro dos  Bairros da Cidade do Estado do Brasil. 
    Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_logradouro.nm_logradouro IS
    'Esta coluna irá receber o nome do lograoduro. O padrão de armazenmento é  InitCap e seu conteúdo é obrigatório. 
    Essa tabela já será preenchida pela área responsável. Novas inseções necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_rhstu_logradouro.nr_cep IS
    'Esta coluna irá receber o número do CEP do lograoduro. O padrão de armazenmento é  numérico  e seu conteúdo é obrigatório. 
    Essa tabela já será preenchida pela área responsável. Novas inseções necessitam ser avaladas pelos gestores.';

ALTER TABLE t_rhstu_logradouro ADD CONSTRAINT pk_rhstu_logradouro PRIMARY KEY ( id_logradouro );

CREATE TABLE t_rhstu_medicamento (
    id_medicamento            NUMBER NOT NULL,
    nm_medicamento            VARCHAR2(50) NOT NULL,
    ds_detalhada_medicamento  VARCHAR2(4000),
    nr_codigo_barras          NUMBER NOT NULL
);

ALTER TABLE t_rhstu_medicamento ADD CONSTRAINT pk_rhstu_medicamento PRIMARY KEY ( id_medicamento );

CREATE TABLE t_rhstu_medico (
    cd_medico         NUMBER NOT NULL,
    nm_medico         VARCHAR2(90) NOT NULL,
    nr_crm            NUMBER(10) NOT NULL,
    ds_especialidade  VARCHAR2(50) NOT NULL
);

ALTER TABLE t_rhstu_medico ADD CONSTRAINT pk_rhstu_medico PRIMARY KEY ( cd_medico );

CREATE TABLE t_rhstu_paciente (
    id_paciente         NUMBER(9) NOT NULL,
    nm_paciente         VARCHAR2(80) NOT NULL,
    nr_cpf              NUMBER(12) NOT NULL,
    nm_rg               VARCHAR2(15),
    dt_nascimento       DATE NOT NULL,
    fl_sexo_biologico   CHAR(1) NOT NULL,
    ds_escolaridade     VARCHAR2(40) NOT NULL,
    ds_estado_civil     VARCHAR2(25) NOT NULL,
    nm_grupo_sanguineo  VARCHAR2(6) NOT NULL,
    nr_altura           NUMBER(3, 2) DEFAULT 0.1 NOT NULL,
    nr_peso             NUMBER(4, 1) DEFAULT 1 NOT NULL
);

ALTER TABLE t_rhstu_paciente
    ADD CONSTRAINT ck_rhstu_paciente_sexo CHECK ( fl_sexo_biologico IN (
        'F',
        'I',
        'M'
    ) );

ALTER TABLE t_rhstu_paciente
    ADD CONSTRAINT ck_rhstu_paciente_altura CHECK ( nr_altura BETWEEN 0.1 AND 2.99 );

ALTER TABLE t_rhstu_paciente
    ADD CONSTRAINT uk_rhstu_paciente_peso CHECK ( nr_peso BETWEEN 1 AND 800 );

COMMENT ON COLUMN t_rhstu_paciente.id_paciente IS
    'Esse atributo irá receber a chave primária do paciente. Esse número é sequencial e gerado automaticamente pelo sistema. 
    Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente.nm_paciente IS
    'Esse atributo irá receber o nome completo do  paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente.nr_cpf IS
    'Esse atributo irá receber o número do  CPF paciente.  Seu conteúdo é obrigatório
    e será validado de acordo com regras de negócio.';

COMMENT ON COLUMN t_rhstu_paciente.nm_rg IS
    'Esse atributo irá receber o número do  RG  paciente.  Seu conteúdo é obrigatório e será validado de acordo com regras de negócio.';

COMMENT ON COLUMN t_rhstu_paciente.dt_nascimento IS
    'Esse atributo irá receber a data de nascimento do  paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente.fl_sexo_biologico IS
    'Esse atributo irá receber a flag do sexo biológico de nascimento do Paciente. 
    Os valores possíveis são (F)emea  ou (M)acho ou (I)ntersexual. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente.ds_escolaridade IS
    'Esse atributo irá receber a Escolaridade do  paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente.ds_estado_civil IS
    'Esse atributo irá receber o Estado Civil  do  paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente.nm_grupo_sanguineo IS
    'Esse atributo irá receber o grupo sanguineo do  paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente.nr_altura IS
    'Esse atributo irá receber a altura do  paciente.  Seu conteúdo é obrigatório e o limite de altura deve ficar entre 0.1 e 2.99.';

COMMENT ON COLUMN t_rhstu_paciente.nr_peso IS
    'Esse atributo irá receber o peso  do  paciente.  Seu conteúdo é obrigatório. A faixa de valores permitidos está entre 1 e 800kg.';

ALTER TABLE t_rhstu_paciente ADD CONSTRAINT pk_rhstu_paciente PRIMARY KEY ( id_paciente );

ALTER TABLE t_rhstu_paciente ADD CONSTRAINT uk_rhstu_cpf_paciente UNIQUE ( nr_cpf );

ALTER TABLE t_rhstu_paciente ADD CONSTRAINT uk_rhstu_rg_paciente UNIQUE ( nm_rg );

CREATE TABLE t_rhstu_paciente_plano_saude (
    id_paciente_ps  NUMBER(10) NOT NULL,
    id_paciente     NUMBER(9) NOT NULL,
    id_plano_saude  NUMBER(5) NOT NULL,
    nr_carteira_ps  NUMBER(15),
    dt_inicio       DATE NOT NULL,
    dt_fim          DATE
);

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.id_paciente_ps IS
    'Esse atributo irá receber a chave primária do plano de saúde do paciente. 
    Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.id_paciente IS
    'Esse atributo irá receber a chave primária do paciente. Esse número é sequencial e gerado automaticamente pelo sistema. 
    Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.dt_inicio IS
    'Esse atributo irá receber a data de início para atendimento do plano de saúde do cliente aceito na RHSTU. 
     Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.dt_fim IS
    'Esse atributo irá receber a data de encerramento do plano de saúde aceito na RHSTU. Seu conteúdo é opcional.';

ALTER TABLE t_rhstu_paciente_plano_saude ADD CONSTRAINT pk_rhstu_pac_plano_saude PRIMARY KEY ( id_paciente_ps );

CREATE TABLE t_rhstu_plano_saude (
    id_plano_saude           NUMBER(5) NOT NULL,
    ds_razao_social          VARCHAR2(70) NOT NULL,
    nm_fantasia_plano_saude  VARCHAR2(80),
    ds_plano_saude           VARCHAR2(100) NOT NULL,
    nr_cnpj                  NUMBER(14) NOT NULL,
    nm_contato               VARCHAR2(30),
    ds_telefone              VARCHAR2(30),
    dt_inicio                DATE NOT NULL,
    dt_fim                   DATE
);

COMMENT ON COLUMN t_rhstu_plano_saude.id_plano_saude IS
    'Esse atributo irá receber a chave primária do plano de saúde. Esse número é sequencial e gerado automaticamente pelo sistema. 
    Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_plano_saude.ds_razao_social IS
    'Esse atributo irá receber Razão Social do plano de saúde aceito na RHSTU. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_plano_saude.nm_fantasia_plano_saude IS
    'Esse atributo irá receber o nome Fantasia do plano de saúde aceito na RHSTU. Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_plano_saude.ds_plano_saude IS
    'Esse atributo irá receber a descrição do  plano de saúde aceito na RHSTU. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_plano_saude.nr_cnpj IS
    'Esse atributo irá receber o numero do CNPJ do plano de saúde aceito na RHSTU. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_plano_saude.nm_contato IS
    'Esse atributo irá receber o nome  do contato dentro do plano de saúde aceito na RHSTU. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_plano_saude.ds_telefone IS
    'Esse atributo irá receber os dados do telefone para contato no plano de saúde aceito na RHSTU. Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_plano_saude.dt_inicio IS
    'Esse atributo irá receber a data de início para atendimento do plano de saúde aceito na RHSTU. Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_plano_saude.dt_fim IS
    'Esse atributo irá receber a data de encerramento do plano de saúde aceito na RHSTU. Seu conteúdo é opcional.';

ALTER TABLE t_rhstu_plano_saude ADD CONSTRAINT pk_rhstu_plano_saude PRIMARY KEY ( id_plano_saude );

CREATE TABLE t_rhstu_prescicao_medica (
    id_prescricao_medica  NUMBER NOT NULL,
    id_unid_hospital      NUMBER(9) NOT NULL,
    nr_consulta           NUMBER NOT NULL,
    id_medicamento        NUMBER NOT NULL,
    ds_posologia          VARCHAR2(150) NOT NULL,
    ds_via                VARCHAR2(40) NOT NULL,
    ds_observacao_uso     VARCHAR2(100),
    qt_medicamento        NUMBER(10, 4)
);

ALTER TABLE t_rhstu_prescicao_medica ADD CONSTRAINT pk_rhstu_prescicao_medica PRIMARY KEY ( id_prescricao_medica );

CREATE TABLE t_rhstu_telefone_paciente (
    id_paciente  NUMBER(9) NOT NULL,
    id_telefone  NUMBER(9) NOT NULL,
    nr_ddi       NUMBER(3) NOT NULL,
    nr_ddd       NUMBER(3) NOT NULL,
    nr_telefone  NUMBER(10) NOT NULL,
    tp_telefone  VARCHAR2(20) NOT NULL,
    st_telefone  CHAR(1) NOT NULL
);

ALTER TABLE t_rhstu_telefone_paciente
    ADD CONSTRAINT uk_rhstu_status_telef_paciente CHECK ( st_telefone IN (
        'A',
        'I'
    ) );

COMMENT ON COLUMN t_rhstu_telefone_paciente.id_paciente IS
    'Esse atributo irá receber a chave primária do paciente. Esse número é sequencial e gerado automaticamente pelo sistema.
    Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.id_telefone IS
    'Esse atributo irá receber a chave primária do telefone do paciente. 
    Esse número é sequencial iniciando com 1 a partir do id do paciente e é  gerado automaticamente pelo sistema. 
    Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.nr_ddi IS
    'Este atributo irá receber o número do DDI do telefone do  paciente. Seu conteudo é obrigatório.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.nr_ddd IS
    'Esse atributo irá receber o número do DDD do telefone paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.nr_telefone IS
    'Esse atributo irá receber o número do telefone do  DDD do telefone paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.tp_telefone IS
    'Esse atributo irá receber o tipo do  telefone  do telefone paciente.  
    Seu conteúdo é obrigatório e os valores possiveis são: Comercial, Residencial, Recado e Celular';

COMMENT ON COLUMN t_rhstu_telefone_paciente.st_telefone IS
    'Esse atributo irá receber o status do telefone do paciente.  
    Seu conteúdo é obrigatório e deve possuir os seguintes valores: (A)tivo ou (I)nativo.';

ALTER TABLE t_rhstu_telefone_paciente ADD CONSTRAINT pk_rhstu_telefone_paciente PRIMARY KEY ( id_telefone,
                                                                                              id_paciente );

CREATE TABLE t_rhstu_tipo_contato (
    id_tipo_contato  NUMBER(5) NOT NULL,
    nm_tipo_contato  VARCHAR2(80) NOT NULL,
    dt_inicio        DATE NOT NULL,
    dt_fim           DATE
);

COMMENT ON COLUMN t_rhstu_tipo_contato.id_tipo_contato IS
    'Esse atributo irá receber a chave primária do tipo do contato. 
    Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_tipo_contato.nm_tipo_contato IS
    'Este atributo irá  receber o nome  do tipo de contato (Mãe, Pai, Prima(o), Irmã(o), Amiga(o), Colega de trabalho) entre outros.
    Seu conteudo é obrigatório.
';

COMMENT ON COLUMN t_rhstu_tipo_contato.dt_inicio IS
    'Este atributo irá  receber a data de início de validade do tipo do contato. Seu conteudo é obrigatório.';

COMMENT ON COLUMN t_rhstu_tipo_contato.dt_fim IS
    'Este atributo irá  receber a data de término  de validade do tipo do contato. Seu conteudo é obrigatório.';

ALTER TABLE t_rhstu_tipo_contato ADD CONSTRAINT pk_rhstu_tipo_contato PRIMARY KEY ( id_tipo_contato );

CREATE TABLE t_rhstu_unid_hospitalar (
    id_unid_hospital           NUMBER(9) NOT NULL,
    id_logradouro              NUMBER(10) NOT NULL,
    nm_unid_hospitalar         VARCHAR2(80) NOT NULL,
    nm_razao_social_unid_hosp  VARCHAR2(80) NOT NULL,
    dt_fundacao                DATE,
    nr_logradouro              NUMBER(7),
    ds_complemento_numero      VARCHAR2(30),
    ds_ponto_referencia        VARCHAR2(50),
    dt_inicio                  DATE NOT NULL,
    dt_termino                 DATE
);

COMMENT ON COLUMN t_rhstu_unid_hospitalar.id_unid_hospital IS
    'Esse atributo irá receber a chave primária da Unidade Hospitalar. Esse número é sequencia e gerado automaticamente pelo sistema. 
    Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.nr_logradouro IS
    'Esse atributo irá receber o número do logradouro do endereco da Unidade Hospitalar.  Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.ds_complemento_numero IS
    'Esse atributo irá receber o complemeneto  do logradouro do endereco da Unidade Hospitalar caso ele exista. 
    Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.ds_ponto_referencia IS
    'Esse atributo irá receber o ponto de referência  do logradouro do endereco da Unidade Hospitalar.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.dt_inicio IS
    'Esse atributo irá receber a data inicio do endereço da Unidade Hospitalar associado ao endereço (logradouro). 
    Seu conteúdo é obrigatorio.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.dt_termino IS
    'Esse atributo irá receber a data término  do endereço da Unidade Hospitalar associado ao endereço (logradouro). 
    Seu conteúdo é opcional.';

ALTER TABLE t_rhstu_unid_hospitalar ADD CONSTRAINT pk_rhstu_uni_hosp_end PRIMARY KEY ( id_unid_hospital );

ALTER TABLE t_rhstu_unid_hospitalar
    ADD CONSTRAINT fk_logr_end_unid_hospitalar FOREIGN KEY ( id_logradouro )
        REFERENCES t_rhstu_logradouro ( id_logradouro );

ALTER TABLE t_rhstu_contato_paciente
    ADD CONSTRAINT fk_paciente_contato_emerg FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_endereco_paciente
    ADD CONSTRAINT fk_paciente_endereco FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_logradouro
    ADD CONSTRAINT fk_rhstu_bairro_logradouro FOREIGN KEY ( id_bairro )
        REFERENCES t_rhstu_bairro ( id_bairro );

ALTER TABLE t_rhstu_bairro
    ADD CONSTRAINT fk_rhstu_cidade_bairro FOREIGN KEY ( id_cidade )
        REFERENCES t_rhstu_cidade ( id_cidade );

ALTER TABLE t_rhstu_cidade
    ADD CONSTRAINT fk_rhstu_estado_cidade FOREIGN KEY ( id_estado )
        REFERENCES t_rhstu_estado ( id_estado );

ALTER TABLE t_rhstu_endereco_paciente
    ADD CONSTRAINT fk_rhstu_logr_end_paciente FOREIGN KEY ( id_logradouro )
        REFERENCES t_rhstu_logradouro ( id_logradouro );

ALTER TABLE t_rhstu_paciente_plano_saude
    ADD CONSTRAINT fk_rhstu_pac_plano_saude FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_email_paciente
    ADD CONSTRAINT fk_rhstu_paciente_email FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_telefone_paciente
    ADD CONSTRAINT fk_rhstu_paciente_telef FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_paciente_plano_saude
    ADD CONSTRAINT fk_rhstu_plano_saude_pac FOREIGN KEY ( id_plano_saude )
        REFERENCES t_rhstu_plano_saude ( id_plano_saude );

ALTER TABLE t_rhstu_contato_paciente
    ADD CONSTRAINT fk_rhstu_tipo_contato FOREIGN KEY ( id_tipo_contato )
        REFERENCES t_rhstu_tipo_contato ( id_tipo_contato );

ALTER TABLE t_rhstu_consulta
    ADD CONSTRAINT fk_rhstu_unid_hosp_consulta FOREIGN KEY ( id_unid_hospital )
        REFERENCES t_rhstu_unid_hospitalar ( id_unid_hospital );

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT fk_stu_consulta_forma_pagto FOREIGN KEY ( nr_consulta,
                                                             id_unid_hospital )
        REFERENCES t_rhstu_consulta ( nr_consulta,
                                      id_unid_hospital );

ALTER TABLE t_rhstu_prescicao_medica
    ADD CONSTRAINT fk_stu_consulta_presc_medica FOREIGN KEY ( nr_consulta,
                                                              id_unid_hospital )
        REFERENCES t_rhstu_consulta ( nr_consulta,
                                      id_unid_hospital );

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT fk_stu_forma_pagto_consulta FOREIGN KEY ( id_forma_pagto )
        REFERENCES t_rhstu_forma_pagamento ( id_forma_pagto );

ALTER TABLE t_rhstu_consulta
    ADD CONSTRAINT fk_stu_med_consulta FOREIGN KEY ( cd_medico )
        REFERENCES t_rhstu_medico ( cd_medico );

ALTER TABLE t_rhstu_prescicao_medica
    ADD CONSTRAINT fk_stu_medicamento_pm FOREIGN KEY ( id_medicamento )
        REFERENCES t_rhstu_medicamento ( id_medicamento );

ALTER TABLE t_rhstu_consulta
    ADD CONSTRAINT fk_stu_pac_consulta FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT fk_stu_pac_ps_cnst_fp FOREIGN KEY ( id_paciente_ps )
        REFERENCES t_rhstu_paciente_plano_saude ( id_paciente_ps );


--COMEÇO DO CHECKPOINT 2 - SEGUNDO SEMESTRE


--CRIANDO AS SEQUENCES

CREATE SEQUENCE SQ_RHSTU_ESTADO
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE SQ_RHSTU_CIDADE
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE SQ_RHSTU_BAIRRO
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE SQ_RHSTU_LOGRADOURO
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE SQ_RHSTU_TIPO_CONTATO
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE SQ_RHSTU_ENDERECO_PACIENTE
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE SQ_RHSTU_UNID_HOSPITALAR
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE SQ_RHSTU_MEDICO
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE SQ_RHSTU_MEDICAMENTO
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE SQ_RHSTU_PRESCRICAO_MEDICA
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE SQ_RHSTU_PACIENTE
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE SQ_RHSTU_EMAIL_PACIENTE

    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE SQ_RHSTU_PLANO_SAUDE

    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE SQ_RHSTU_PACIENTE_PLANO_SAUDE
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE SQ_RHSTU_FORMA_PAGAMENTO
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
CREATE SEQUENCE SQ_RHSTU_CONSULTA_FORMA_PAGTO
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE SQ_RHSTU_CONTATO_PACIENTE
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;


CREATE SEQUENCE SQ_RHSTU_TELEFONE_PACIENTE
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE SQ_RHSTU_CONSULTA
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
--Inserindo na tabela T_RHSTU_PACIENTE

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento,
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'João da Silva', 123456789061, TO_DATE('10/08/1990', 'DD/MM/YYYY'), 'M', 'Ensino Médio', 'Solteiro', 'O+', 1.75, 80);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Maria Santos', 987654321098, TO_DATE('20/03/1982', 'DD/MM/YYYY'), 'F', 'Ensino Fundamental', 'Divorciada', 'A+', 1.60, 65);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Carlos Oliveira', 345678907123, TO_DATE('05/12/1995', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'B-', 1.80, 70);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Amanda Ferreira', 567890152345, TO_DATE('30/09/1993', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Casada', 'O-', 1.65, 58);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Paulo Lima', 678901234565, TO_DATE('15/11/1988', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Divorciado', 'AB+', 1.78, 85);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Fernanda Costa', 123456789127, TO_DATE('25/07/1991', 'DD/MM/YYYY'), 'F', 'Ensino Fundamental', 'Solteira', 'A+', 1.63, 62);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Ricardo Almeida', 789012345676, TO_DATE('12/04/1987', 'DD/MM/YYYY'), 'M', 'Ensino Médio', 'Casado', 'O+', 1.75, 75);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Larissa Aragão', 890123456785, TO_DATE('18/09/1994', 'DD/MM/YYYY'), 'F', 'Ensino Superior', 'Solteira', 'B+', 1.68, 60);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'André Gonçalves', 234567890125, TO_DATE('08/03/1996', 'DD/MM/YYYY'), 'M', 'Ensino Médio', 'Solteiro', 'AB-', 1.85, 88);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Daniela Cristina Freitas', 880522676929, TO_DATE('15/05/1985', 'DD/MM/YYYY'), 'F', 'Ensino Superior', 'Casada', 'AB-', 1.62, 75  );

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Rafael Souza', 456789012340, TO_DATE('03/02/1990', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'A-', 1.75, 78);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Mariana Alves', 567890123459, TO_DATE('12/11/1987', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Casada', 'B+', 1.68, 62);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Matheus Jesus', 678901234566, TO_DATE('25/06/1995', 'DD/MM/YYYY'), 'M', 'Ensino Médio', 'Solteiro', 'O-', 1.80, 75);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Luciana Santoro ', 789012374567, TO_DATE('15/09/1984', 'DD/MM/YYYY'), 'F', 'Ensino Superior', 'Casada', 'AB+', 1.65, 60);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Eduardo Yuzuki', 890123456768, TO_DATE('22/03/1993', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'A-', 1.78, 85);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Nicole Ferrarini', 123456789126, TO_DATE('14/07/1992', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Divorciada', 'B+', 1.63, 63);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Alexandre Silveira', 234567869012, TO_DATE('28/05/1991', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'O+', 1.85, 88);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Isabela Gomes', 345678901243, TO_DATE('05/12/1994', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB-', 1.70, 70);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Pedro Franco', 456789012347, TO_DATE('10/08/1990', 'DD/MM/YYYY'), 'M', 'Ensino Médio', 'Casado', 'O-', 1.75, 80);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Ana Nunes', 567490123457, TO_DATE('20/03/1982', 'DD/MM/YYYY'), 'F', 'Ensino Fundamental', 'Divorciada', 'A+', 1.60, 65);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Guilherme Amorin', 123456779012, TO_DATE('05/11/1990', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'A-', 1.75, 78);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Maria Fernanda', 987657321098, TO_DATE('15/03/1985', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Casada', 'B+', 1.68, 62);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Nicolas Alberto', 345678903234, TO_DATE('25/09/1993', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.80, 75);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Sofia Correia', 567890125456, TO_DATE('18/04/1992', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB+', 1.65, 60);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Caio Lagos', 378901234567, TO_DATE('12/08/1987', 'DD/MM/YYYY'), 'M', 'Ensino Médio', 'Solteiro', 'A+', 1.78, 85);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Luiza Molina', 123416789012, TO_DATE('14/07/1994', 'DD/MM/YYYY'), 'F', 'Ensino Superior', 'Casada', 'B+', 1.63, 63);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Miguel Malverde', 234567090123, TO_DATE('28/05/1993', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'O+', 1.85, 88);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Carol Valverde', 98901234, TO_DATE('05/12/1995', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB-', 1.70, 70);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Jorge Lopes', 456889012345, TO_DATE('10/08/1986', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.75, 80);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Beatriz Nakamura', 547890123456, TO_DATE('20/03/1984', 'DD/MM/YYYY'), 'F', 'Ensino Fundamental', 'Divorciada', 'A+', 1.60, 65);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Gabriel Melo', 123456989012, TO_DATE('05/11/1991', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'A-', 1.75, 78);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Lucia Ortiz', 348654321098, TO_DATE('15/03/1986', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Casada', 'B+', 1.68, 62);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Antonio Cardoso', 345778901234, TO_DATE('25/09/1992', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.80, 75);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Livia Torres', 567898123456, TO_DATE('18/04/1990', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB+', 1.65, 60);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Ricardo Pereira', 678901234567, TO_DATE('12/08/1989', 'DD/MM/YYYY'), 'M', 'Ensino Médio', 'Divorciado', 'A+', 1.78, 85);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Aline Correia', 123456789012, TO_DATE('14/07/1993', 'DD/MM/YYYY'), 'F', 'Ensino Superior', 'Casada', 'B+', 1.63, 63);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Vitor Dias', 234567890123, TO_DATE('28/05/1994', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'O+', 1.85, 88);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Monica Almeida', 355678901234, TO_DATE('05/12/1996', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB-', 1.70, 70);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Marcio da Costa', 455789012345, TO_DATE('10/08/1987', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.75, 80);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Raissa da Cruz', 567890123406, TO_DATE('20/03/1985', 'DD/MM/YYYY'), 'F', 'Ensino Fundamental', 'Divorciada', 'A+', 1.60, 65);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Samuel Martin', 123056789012, TO_DATE('05/11/1990', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'A-', 1.75, 78);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Leticia Alexander', 987654891098, TO_DATE('15/03/1986', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Casada', 'B+', 1.68, 62);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Fernando Barbosa ', 345678981234, TO_DATE('25/09/1992', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.80, 75);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Mariane Albuquerque', 567893123456, TO_DATE('18/04/1990', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB+', 1.65, 60);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'João Batista', 678801234567, TO_DATE('12/08/1989', 'DD/MM/YYYY'), 'M', 'Ensino Médio', 'Divorciado', 'A+', 1.78, 85);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Lucia Coelho ', 123459189012, TO_DATE('14/07/1993', 'DD/MM/YYYY'), 'F', 'Ensino Superior', 'Casada', 'B+', 1.63, 63);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Diogo Wen', 234517890123, TO_DATE('28/05/1994', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'O+', 1.85, 88);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Abey Pacheco', 345078901234, TO_DATE('05/12/1996', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB-', 1.70, 70);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Arthur Alonso', 456089012345, TO_DATE('10/08/1987', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.75, 80);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Nicole Teixeira', 567834823456, TO_DATE('20/03/1985', 'DD/MM/YYYY'), 'F', 'Ensino Fundamental', 'Divorciada', 'A+', 1.60, 65);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Gustavo Rosas', 123456789022, TO_DATE('05/11/1987', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'A-', 1.75, 78);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Isabeli Oliveira', 987654321032, TO_DATE('15/03/1984', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Casada', 'B+', 1.68, 62);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Felipe Rivera', 345678901254, TO_DATE('25/09/1991', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.80, 75);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Giovanna Rives', 567890123478, TO_DATE('18/04/1989', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB+', 1.65, 60);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Leonardo Silveira', 678901234569, TO_DATE('12/08/1988', 'DD/MM/YYYY'), 'M', 'Ensino Médio', 'Divorciado', 'A+', 1.78, 85);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Lucia Alonso ', 123456789045, TO_DATE('14/07/1995', 'DD/MM/YYYY'), 'F', 'Ensino Superior', 'Casada', 'B+', 1.63, 63);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Giovanne Cavalcante', 234567890166, TO_DATE('28/05/1993', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'O+', 1.85, 88);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Elisa Reis', 345678901277, TO_DATE('05/12/1997', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB-', 1.70, 70);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Peter Yu', 456789012380, TO_DATE('10/08/1986', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.75, 80);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Natalia Figueredo', 567890123489, TO_DATE('20/03/1987', 'DD/MM/YYYY'), 'F', 'Ensino Fundamental', 'Divorciada', 'A+', 1.60, 65);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Davi Ortega', 123456789098, TO_DATE('05/11/1986', 'DD/MM/YYYY'), 'M', 'Ensino Fundamental', 'Solteiro', 'A-', 1.70, 75);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Marcela Takeda', 987654321087, TO_DATE('15/03/1983', 'DD/MM/YYYY'), 'F', 'Ensino Superior', 'Casada', 'B+', 1.65, 62);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Alberto Vieira', 345678901211, TO_DATE('25/09/1990', 'DD/MM/YYYY'), 'M', 'Ensino Médio', 'Solteiro', 'O-', 1.75, 80);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Juliana Pires', 018890123489, TO_DATE('18/04/1987', 'DD/MM/YYYY'), 'F', 'Ensino Superior', 'Casada', 'AB+', 1.68, 65);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Paulo Santana', 678901234544, TO_DATE('12/08/1986', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'A+', 1.78, 85);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Lúcia Rocha', 123456789076, TO_DATE('14/07/1991', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Divorciada', 'B+', 1.70, 68);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Murilo Mendes', 234567890145, TO_DATE('28/05/1992', 'DD/MM/YYYY'), 'M', 'Ensino Médio', 'Solteiro', 'O+', 1.85, 88);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Alessandra Branco', 345678901299, TO_DATE('05/12/1988', 'DD/MM/YYYY'), 'F', 'Ensino Superior', 'Solteira', 'AB-', 1.68, 72);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Raul Nascimento', 456789012350, TO_DATE('10/08/1989', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.75, 80);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Olinda Guerra', 567890123411, TO_DATE('20/03/1989', 'DD/MM/YYYY'), 'F', 'Ensino Fundamental', 'Divorciada', 'A+', 1.63, 65);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Breno Neves', 123456789088, TO_DATE('05/11/1987', 'DD/MM/YYYY'), 'M', 'Ensino Médio', 'Solteiro', 'A-', 1.75, 78);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Rosa Luna', 987654321078, TO_DATE('15/03/1985', 'DD/MM/YYYY'), 'F', 'Ensino Superior', 'Casada', 'B+', 1.68, 62);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Theo Assis', 345678901223, TO_DATE('25/09/1991', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.80, 75);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Debora Dias', 567890123422, TO_DATE('18/04/1993', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB+', 1.65, 60);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Heitor Francisco', 678901234577, TO_DATE('12/08/1988', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'A+', 1.78, 85);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Emily Cruz', 123456789065, TO_DATE('14/07/1994', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Divorciada', 'B+', 1.70, 68);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Manuel Isis', 234567890199, TO_DATE('28/05/1992', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'O+', 1.85, 88);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Paloma Alice', 345678901255, TO_DATE('05/12/1994', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB-', 1.68, 72);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'André Almada', 456789012322, TO_DATE('10/08/1990', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.75, 80);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Fabiana Vicente', 567890123444, TO_DATE('20/03/1987', 'DD/MM/YYYY'), 'F', 'Ensino Fundamental', 'Divorciada', 'A+', 1.63, 65);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Elias Marcos', 123456789077, TO_DATE('05/11/1986', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'A-', 1.75, 78);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Alana Marli', 987654321089, TO_DATE('15/03/1984', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Casada', 'B+', 1.68, 62);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Rubens Pietro', 345678901288, TO_DATE('25/09/1990', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.80, 75);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Camila Nogueira', 567890123455, TO_DATE('18/04/1989', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB+', 1.65, 60);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Lucas Machado', 678901234533, TO_DATE('12/08/1988', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'A+', 1.78, 85);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Erica Gomez', 123456789067, TO_DATE('14/07/1991', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Divorciada', 'B+', 1.70, 68);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Geraldo Ramos', 234567890100, TO_DATE('28/05/1992', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'O+', 1.85, 88);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Milena Silverio', 345678901266, TO_DATE('05/12/1994', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB-', 1.68, 72);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Pietro José', 456789012333, TO_DATE('10/08/1990', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.75, 80);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Jeniffer Pinto', 567890123466, TO_DATE('20/03/1987', 'DD/MM/YYYY'), 'F', 'Ensino Fundamental', 'Divorciada', 'A+', 1.63, 65);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Danilo Mota', 123456789066, TO_DATE('05/11/1986', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'A-', 1.75, 78);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Sarah Vicente', 987654321099, TO_DATE('15/03/1984', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Casada', 'B+', 1.68, 62);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Henry Hermindo', 568678901299, TO_DATE('25/09/1990', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.80, 75);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Luma Cardoso', 567890123477, TO_DATE('18/04/1989', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB+', 1.65, 60);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Julio Porto', 678901234522, TO_DATE('12/08/1988', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'A+', 1.78, 85);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Vitória Figueiredo', 123456789055, TO_DATE('14/07/1991', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Divorciada', 'B+', 1.70, 68);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Noah Silva', 234567890188, TO_DATE('28/05/1992', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'O+', 1.85, 88);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Juliana Almeida', 545678901211, TO_DATE('05/12/1994', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB-', 1.68, 72);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Hugo Galvão', 456789012344, TO_DATE('10/08/1990', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.75, 80);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Catarina Castro', 567890123499, TO_DATE('20/03/1987', 'DD/MM/YYYY'), 'F', 'Ensino Fundamental', 'Divorciada', 'A+', 1.63, 65);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Tomás Assunção', 123456789044, TO_DATE('05/11/1986', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'A-', 1.75, 78);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Marcela Onodera', 987654321010, TO_DATE('15/03/1984', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Casada', 'B+', 1.68, 62);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Denilson Mendes', 345678901244, TO_DATE('25/09/1990', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.80, 75);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Helena Amorin', 567890123488, TO_DATE('18/04/1989', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB+', 1.65, 60);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Gael Mota', 678901234511, TO_DATE('12/08/1988', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'A+', 1.78, 85);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Luciana Monteiro', 123456789033, TO_DATE('14/07/1991', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Divorciada', 'B+', 1.70, 68);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Marcel Augusto', 234567890177, TO_DATE('28/05/1992', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'O+', 1.85, 88);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Juliana Cabral', 345678901233, TO_DATE('05/12/1994', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB-', 1.68, 72);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Alexandre Ricardo', 456789012355, TO_DATE('10/08/1990', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.75, 80);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Marta Nair', 157890123422, TO_DATE('20/03/1987', 'DD/MM/YYYY'), 'F', 'Ensino Fundamental', 'Divorciada', 'A+', 1.63, 65);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Renan Tuzo', 984456789022, TO_DATE('05/11/1986', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'A-', 1.75, 78);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Rafaela Benedito', 987654321011, TO_DATE('15/03/1984', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Casada', 'B+', 1.68, 62);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Oliver Yuri', 345678901200, TO_DATE('25/09/1990', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.80, 75);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Amanda Henoch', 893890123411, TO_DATE('18/04/1989', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB+', 1.65, 60);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Andresson Quental', 678901234500, TO_DATE('12/08/1988', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'A+', 1.78, 85);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Ester das Neves', 123456789011, TO_DATE('14/07/1991', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Divorciada', 'B+', 1.70, 68);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Fábio Alessandro', 234931890166, TO_DATE('28/05/1992', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Solteiro', 'O+', 1.85, 88);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Giovanna Lopes', 345678901222, TO_DATE('05/12/1994', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'AB-', 1.68, 72);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Nathan Nascimento', 456789012366, TO_DATE('10/08/1990', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.75, 80);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Tatiana Olivera', 567890123433, TO_DATE('20/03/1987', 'DD/MM/YYYY'), 'F', 'Ensino Fundamental', 'Divorciada', 'A+', 1.63, 65);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Sebastião Viana', 234567890155, TO_DATE('10/01/1993', 'DD/MM/YYYY'), 'M', 'Ensino Médio', 'Solteiro', 'B+', 1.75, 77);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Heloisa de Deus', 456789012377, TO_DATE('05/05/1991', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'O+', 1.70, 65);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Thiago Cortes', 578390123444, TO_DATE('15/09/1990', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'A-', 1.78, 80);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Vera Aluisio', 234567890144, TO_DATE('20/12/1988', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Divorciada', 'B+', 1.68, 70);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Renato Silveira', 926678901266, TO_DATE('02/06/1992', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'O-', 1.75, 82);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Rose Francisco', 456789012388, TO_DATE('18/03/1991', 'DD/MM/YYYY'), 'F', 'Ensino Médio', 'Solteira', 'A+', 1.65, 60);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Kevin Fernandes', 234567890133, TO_DATE('30/07/1993', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'AB+', 1.85, 88);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Vanessa Assunção', 216678901277, TO_DATE('05/12/1989', 'DD/MM/YYYY'), 'F', 'Ensino Superior', 'Solteira', 'O+', 1.68, 72);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Mauro Assis', 456789012399, TO_DATE('10/08/1991', 'DD/MM/YYYY'), 'M', 'Ensino Superior', 'Casado', 'AB-', 1.75, 80);

INSERT INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, 
fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
VALUES (SQ_RHSTU_PACIENTE.NEXTVAL, 'Carolina Silva', 567890123400, TO_DATE('20/03/1987', 'DD/MM/YYYY'), 'F', 'Ensino Fundamental', 'Divorciada', 'A+', 1.63, 65);


--Inserindo na tabela T_RHSTU_MEDICO

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Carlos Moraes', 354789, 'Pediatria');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Renata Ribeiro', 458761, 'Obstetricia');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Bruna Marinho', 156874, 'Nutrição');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Jose Alberto', 356897, 'Clínica Geral');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Diego Moura', 489546, 'Cirurgia Geral');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Alex Santos', 647305, 'Cardiologia');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Marcela Oliveira', 547601, 'Anestesia');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Sandra Amaral', 034670, 'Cirurgia Plástica');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Gabriela Silva', 647812, 'Dermatologia');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Silvia Amorim', 123456, 'Endocrinologia');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Julia Yaki', 654321, 'Neurocirurgia');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Elisa Gomes', 987456, 'Psiquiatria');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Raul Sousa', 654789, 'Psicologia');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Manuela Luz', 268410, 'Infectologia');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Matheus Vieira', 134745, 'Urologia');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Cecília Cardoso', 1014026, 'Pneumologia');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Heloisa Fernanda', 880645, 'Radioterapia');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Gustavo Cabral', 114115, 'Otorrinolaringologia');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Tatiane Lima', 460231, 'Medicina do Trabalho');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Yuri Barbosa', 315696, 'Coloproctolgia');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Rita Barros', 057122, 'Imunologia');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Adriana Rocha', 4576101, 'Cirurgia Toraxica');

INSERT INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
VALUES (SQ_RHSTU_MEDICO.NEXTVAL, 'Rafael Assis', 269386, 'Endoscopia');


--Inserindo na tabela T_RHSTU_MEDICAMENTO

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Paracetamol', 123456789012);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Ibuprofeno', 234567890123);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Omeprazol', 345678901234);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Amoxicilina', 456789012345);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Aspirina', 567890123456);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Diazepam', 678901234567);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Loratadina', 789012345678);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Cetirizina', 890123456789);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Simvastatina', 901234567890);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Metformina', 123451234567);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Losartan', 234562345678);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Atenolol', 345673456789);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Pantoprazol', 456784567890);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Metoclopramida', 567895678901);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Sertralina', 678906789012);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Fluoxetina', 789017890123);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Clonazepam', 890128901234);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Tramadol', 901239012345);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Oxicodona', 123450123456);

INSERT INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
VALUES (SQ_RHSTU_MEDICAMENTO.NEXTVAL, 'Ciprofloxacino', 234561234567);


--Inserindo na tabela T_RHSTU_TIPO_CONTATO

INSERT INTO T_RHSTU_TIPO_CONTATO (id_tipo_contato, nm_tipo_contato, dt_inicio)
VALUES (SQ_RHSTU_TIPO_CONTATO.NEXTVAL, 'Mãe', SYSDATE); 

INSERT INTO T_RHSTU_TIPO_CONTATO (id_tipo_contato, nm_tipo_contato, dt_inicio)
VALUES (SQ_RHSTU_TIPO_CONTATO.NEXTVAL, 'Pai', SYSDATE);

INSERT INTO T_RHSTU_TIPO_CONTATO (id_tipo_contato, nm_tipo_contato, dt_inicio)
VALUES (SQ_RHSTU_TIPO_CONTATO.NEXTVAL, 'Primo', SYSDATE);

INSERT INTO T_RHSTU_TIPO_CONTATO (id_tipo_contato, nm_tipo_contato, dt_inicio)
VALUES (SQ_RHSTU_TIPO_CONTATO.NEXTVAL, 'Prima', SYSDATE);

INSERT INTO T_RHSTU_TIPO_CONTATO (id_tipo_contato, nm_tipo_contato, dt_inicio)
VALUES (SQ_RHSTU_TIPO_CONTATO.NEXTVAL, 'Tio', SYSDATE);

INSERT INTO T_RHSTU_TIPO_CONTATO (id_tipo_contato, nm_tipo_contato, dt_inicio)
VALUES (SQ_RHSTU_TIPO_CONTATO.NEXTVAL, 'Tia', SYSDATE);

INSERT INTO T_RHSTU_TIPO_CONTATO (id_tipo_contato, nm_tipo_contato, dt_inicio)
VALUES (SQ_RHSTU_TIPO_CONTATO.NEXTVAL, 'Esposa', SYSDATE);

INSERT INTO T_RHSTU_TIPO_CONTATO (id_tipo_contato, nm_tipo_contato, dt_inicio)
VALUES (SQ_RHSTU_TIPO_CONTATO.NEXTVAL, 'Esposo', SYSDATE);

INSERT INTO T_RHSTU_TIPO_CONTATO (id_tipo_contato, nm_tipo_contato, dt_inicio)
VALUES (SQ_RHSTU_TIPO_CONTATO.NEXTVAL, 'Filho', SYSDATE);

INSERT INTO T_RHSTU_TIPO_CONTATO (id_tipo_contato, nm_tipo_contato, dt_inicio)
VALUES (SQ_RHSTU_TIPO_CONTATO.NEXTVAL, 'Filha', SYSDATE);

INSERT INTO T_RHSTU_TIPO_CONTATO (id_tipo_contato, nm_tipo_contato, dt_inicio)
VALUES (SQ_RHSTU_TIPO_CONTATO.NEXTVAL, 'Irmão', SYSDATE);

INSERT INTO T_RHSTU_TIPO_CONTATO (id_tipo_contato, nm_tipo_contato, dt_inicio)
VALUES (SQ_RHSTU_TIPO_CONTATO.NEXTVAL, 'Irmã', SYSDATE);


--Inserindo na tabela T_RHSTU_PLANO_SAUDE

INSERT INTO T_RHSTU_PLANO_SAUDE (id_plano_saude, ds_razao_social, ds_plano_saude, nr_cnpj, dt_inicio)
VALUES (SQ_RHSTU_PLANO_SAUDE.NEXTVAL, 'Bradesco', 'Plano Bronze', '12345678901234', TO_DATE('01/01/2023', 'DD/MM/YYYY'));

INSERT INTO T_RHSTU_PLANO_SAUDE (id_plano_saude, ds_razao_social, ds_plano_saude, nr_cnpj, dt_inicio)
VALUES (SQ_RHSTU_PLANO_SAUDE.NEXTVAL, 'Amil', 'Plano Prata', '09876543210987', TO_DATE('01/01/2023', 'DD/MM/YYYY'));

INSERT INTO T_RHSTU_PLANO_SAUDE (id_plano_saude, ds_razao_social, ds_plano_saude, nr_cnpj, dt_inicio)
VALUES (SQ_RHSTU_PLANO_SAUDE.NEXTVAL, 'Porto Seguro', 'Plano Ouro', '54321098764532', TO_DATE('01/01/2023', 'DD/MM/YYYY'));


--Inserindo na tabela T_RHSTU_FORMA_PAGAMENTO

-- Forma de pagamento: Gratuito
INSERT INTO T_RHSTU_FORMA_PAGAMENTO (id_forma_pagto, nm_forma_pagto, st_forma_pagto)
VALUES (SQ_RHSTU_FORMA_PAGAMENTO.NEXTVAL, 'Gratuito', 'A');

-- Forma de pagamento: Plano de saúde
INSERT INTO T_RHSTU_FORMA_PAGAMENTO (id_forma_pagto, nm_forma_pagto, st_forma_pagto)
VALUES (SQ_RHSTU_FORMA_PAGAMENTO.NEXTVAL, 'Plano de saúde', 'A');

-- Forma de pagamento: Dinheiro
INSERT INTO T_RHSTU_FORMA_PAGAMENTO (id_forma_pagto, nm_forma_pagto, st_forma_pagto)
VALUES (SQ_RHSTU_FORMA_PAGAMENTO.NEXTVAL, 'Dinheiro', 'A');

-- Forma de pagamento: Cartão de Crédito
INSERT INTO T_RHSTU_FORMA_PAGAMENTO (id_forma_pagto, nm_forma_pagto, st_forma_pagto)
VALUES (SQ_RHSTU_FORMA_PAGAMENTO.NEXTVAL, 'Cartão de Crédito', 'A');

-- Forma de pagamento: Cartão de Débito
INSERT INTO T_RHSTU_FORMA_PAGAMENTO (id_forma_pagto, nm_forma_pagto, st_forma_pagto)
VALUES (SQ_RHSTU_FORMA_PAGAMENTO.NEXTVAL, 'Cartão de Débito', 'A');

-- Forma de pagamento: Pix
INSERT INTO T_RHSTU_FORMA_PAGAMENTO (id_forma_pagto, nm_forma_pagto, st_forma_pagto)
VALUES (SQ_RHSTU_FORMA_PAGAMENTO.NEXTVAL, 'Pix', 'A');


--Inserindo na tabela T_RHSTU_ESTADO

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'AC', 'Acre');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'AL', 'Alagoas');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'AP', 'Amapá');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'AM', 'Amazonas');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'BA', 'Bahia');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'CE', 'Ceará');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'DF', 'Distrito Federal');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'ES', 'Espírito Santo');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'GO', 'Goiás');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'MA', 'Maranhão');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'MT', 'Mato Grosso');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'MS', 'Mato Grosso do Sul');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'MG', 'Minas Gerais');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'PA', 'Pará');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'PB', 'Paraíba');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'PR', 'Paraná');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'PE', 'Pernambuco');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'PI', 'Piauí');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'RJ', 'Rio de Janeiro');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'RN', 'Rio Grande do Norte');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'RS', 'Rio Grande do Sul');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'RO', 'Rondônia');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'RR', 'Roraima');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'SC', 'Santa Catarina');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'SP', 'São Paulo');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'SE', 'Sergipe');

INSERT INTO T_RHSTU_ESTADO (id_estado, sg_estado, nm_estado)
VALUES (SQ_RHSTU_ESTADO.NEXTVAL, 'TO', 'Tocantins');


----Inserindo na tabela T_RHSTU_CIDADE

-- Acre
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 1, 'Rio Branco', 1200401, 68);
       
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 1, 'Cruzeiro do Sul', 1200203, 68);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 1, 'Sena Madureira', 1200451, 68);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 1, 'Feijó', 1200253, 68);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 1, 'Tarauacá', 1200600, 68);

-- Alagoas
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 2, 'Maceió', 2704302, 82);
       
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 2, 'Arapiraca', 2700409, 82);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 2, 'Santana do Ipanema', 2708402, 82);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 2, 'Penedo', 2707107, 82);
       
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 2, 'Palmeira dos Índios', 2706109, 82);

-- Amapá
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 3, 'Macapá', 1600303, 96);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 3, 'Santana', 1600600, 96);
    
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 3, 'Laranjal do Jari', 1600279, 96);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 3, 'Oiapoque', 1600501, 96);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 3, 'Mazagão', 1600402, 96);

-- Amazonas
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 4, 'Manaus', 1302603, 92);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 4, 'Parintins', 1303403, 92);
       
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 4, 'Itacoatiara', 1302009, 92);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 4, 'Manacapuru', 1302504, 92);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 4, 'Coari', 1301209, 92);

-- Bahia
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 5, 'Salvador', 2927408, 71);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 5, 'Feira de Santana', 2910800, 75);
    
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 5, 'Vitória da Conquista', 2933307, 77);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 5, 'Camaçari', 2903203, 71);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 5, 'Itabuna', 2914803, 73);

-- Ceará
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 6, 'Fortaleza', 2304400, 85);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES(SQ_RHSTU_CIDADE.NEXTVAL, 6, 'Caucaia', 2303709, 85);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 6, 'Juazeiro do Norte', 2307304, 88);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 6, 'Maracanaú', 2307650, 85);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 6, 'Sobral', 2312908, 88);

-- Distrito Federal
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 7, 'Brasília', 5300108, 61);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 7, 'Ceilândia', 5300108, 61);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 7, 'Taguatinga', 5300108, 61);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 7, 'Gama', 5300108, 61);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 7, 'Brazlândia', 5300108, 61);

-- Espírito Santo
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 8, 'Vitória', 3205309, 27);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 8, 'Vila Velha', 3205002, 27);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 8, 'Cariacica', 3201307, 27);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 8, 'Serra', 3205002, 27);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 8, 'Linhares', 3203205, 27);

-- Goiás
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 9, 'Goiânia', 5208707, 62);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 9, 'Aparecida de Goiânia', 5201405, 62);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 9, 'Anápolis', 5201108, 62);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 9, 'Rio Verde', 5218806, 64);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 9, 'Luziânia', 5212502, 61);

-- Maranhão
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 10, 'São Luís', 2111300, 98);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 10, 'Imperatriz', 2105302, 99);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 10, 'Timon', 2112209, 86);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 10, 'Caxias', 2103000, 99);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 10, 'Codó', 2103208, 99);

-- Mato Grosso
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 11, 'Cuiabá', 5103403, 65);
      
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 11, 'Várzea Grande', 5108402, 65);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 11, 'Rondonópolis', 5107602, 66);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 11, 'Sinop', 5107909, 66);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 11, 'Tangará da Serra', 5107925, 65);

-- Mato Grosso do Sul
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 12, 'Campo Grande', 5002704, 67);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 12, 'Dourados', 5003702, 67);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 12, 'Três Lagoas', 5007935, 67);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 12, 'Corumbá', 5003206, 67);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 12, 'Ponta Porã', 5007504, 67);

-- Minas Gerais
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 13, 'Belo Horizonte', 3106200, 31);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 13, 'Contagem', 3118601, 31);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 13, 'Uberlândia', 3170207, 34);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 13, 'Juiz de Fora', 3136708, 32);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 13, 'Betim', 3106705, 31);

-- Pará
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 14, 'Belém', 1501402, 91);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 14, 'Ananindeua', 1500800, 91);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 14, 'Santarém', 1506807, 93);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 14, 'Marabá', 1504207, 94);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 14, 'Castanhal', 1502508, 91);

-- Paraíba
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 15, 'João Pessoa', 2507507, 83);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 15, 'Campina Grande', 2504009, 83);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 15, 'Santa Rita', 2513703, 83);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 15, 'Patos', 2510808, 83);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 15, 'Bayeux', 2501806, 83);

-- Paraná
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 16, 'Curitiba', 4106902, 41);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 16, 'Londrina', 4113700, 43);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 16, 'Maringá', 4115200, 44);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 16, 'Ponta Grossa', 4119905, 42);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES(SQ_RHSTU_CIDADE.NEXTVAL, 16, 'Cascavel', 4104806, 45);

-- Pernambuco
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 17, 'Recife', 2611606, 81);
      
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 17, 'Jaboatão dos Guararapes', 2607900, 81);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 17, 'Olinda', 2609609, 81);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 17, 'Caruaru', 2604105, 81);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 17, 'Petrolina', 2611102, 87);

-- Piauí
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 18, 'Teresina', 2211001, 86);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 18, 'Parnaíba', 2207701, 86);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 18, 'Picos', 2208204, 89);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 18, 'Floriano', 2203908, 89);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 18, 'Campo Maior', 2201902, 86);

-- Rio de Janeiro
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 19, 'Rio de Janeiro', 3304557, 21);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 19, 'São Gonçalo', 3304904, 21);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 19, 'Duque de Caxias', 3301702, 21);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 19, 'Nova Iguaçu', 3303500, 21);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES(SQ_RHSTU_CIDADE.NEXTVAL, 19, 'Niterói', 3303302, 21);

-- Rio Grande do Norte
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 20, 'Natal', 2408102, 84);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 20, 'Mossoró', 2408003, 84);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 20, 'Parnamirim', 2403251, 84);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 20, 'São Gonçalo do Amarante', 2412005, 84);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 20, 'Macaíba', 2407202, 84);

-- Rio Grande do Sul
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 21, 'Porto Alegre', 4314902, 51);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 21, 'Caxias do Sul', 4305108, 54);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 21, 'Pelotas', 4314407, 53);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 21, 'Canoas', 4304607, 51);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 21, 'Santa Maria', 4316907, 55);

-- Rondônia
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 22, 'Porto Velho', 1100205, 69);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 22, 'Ji-Paraná', 1100122, 69);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 22, 'Cacoal', 1100049, 69);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 22, 'Vilhena', 1100452, 69);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 22, 'Ariquemes', 1100023, 69);

-- Roraima
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 23, 'Boa Vista', 1400100, 95);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 23, 'Rorainópolis', 1400472, 95);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 23, 'Canta', 1400175, 95);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 23, 'Alto Alegre', 1400050, 95);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 23, 'Mucajaí', 1400308, 95);

-- Santa Catarina
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 24, 'Florianópolis', 4205407, 48);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 24, 'Joinville', 4209102, 47);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 24, 'Blumenau', 4202404, 47);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 24, 'São José', 4216602, 48);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 24, 'Criciúma', 4204608, 48);

-- São Paulo
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 25, 'São Paulo', 3550308, 11);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 25, 'Guarulhos', 3518800, 11);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 25, 'Campinas', 3509502, 19);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 25, 'São Bernardo do Campo', 3548702, 11);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 25, 'Santo André', 3547803, 11);

-- Sergipe
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 26, 'Aracaju', 2800308, 79);
    
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 26, 'Nossa Senhora do Socorro', 2805208, 79);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 26, 'Lagarto', 2804003, 79);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 26, 'Itabaiana', 2802908, 79);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 26, 'Estância', 2802106, 79);

-- Tocantins
INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 27, 'Palmas', 1721000, 63);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 27, 'Araguaína', 1702100, 63);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 27, 'Gurupi', 1709501, 63);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES(SQ_RHSTU_CIDADE.NEXTVAL, 27, 'Porto Nacional', 1717504, 63);

INSERT INTO T_RHSTU_CIDADE (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd)
VALUES (SQ_RHSTU_CIDADE.NEXTVAL, 27, 'Paraíso do Tocantins', 1716100, 63);


--Inserindo na tabela T_RHSTU_BAIRRO

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 1, 'Bosque', 'ZONA SUL');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 1, 'Cidade Nova', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 2, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 2, 'Remanso', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 3, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 3, 'Bom Sucesso', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 4, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 4, 'Vila Nova', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 5, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 5, 'Triângulo', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 6, 'Ponta Verde', 'ZONA LESTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 6, 'Farol', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 7, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 7, 'Baixa Grande', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 8, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 8, 'Santa Esperança', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 9, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 9, 'Santa Luzia', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 10, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 10, 'São Francisco', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 11, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 11, 'Buritizal', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 12, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 12, 'Nova Brasília', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 13, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 13, 'Cidade Livre', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 14, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 14, 'Cidade Nova', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 15, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 15, 'Vila Nova', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 16, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 16, 'Cidade Nova', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 17, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 17, 'Palmares', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 18, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 18, 'Flores', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 19, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 19, 'Novo Manacá', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 20, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 20, 'Urucu', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 21, 'Barra', 'ZONA OESTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 21, 'Canela', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 22, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 22, 'São João', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 23, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 23, 'Candeias', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 24, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 24, 'Abrantes', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 25, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 25, 'Góes Calmon', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 26, 'Aldeota', 'ZONA LESTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 26, 'Messejana', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 27, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 27, 'Jurema', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 28, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 28, 'Franciscanos', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 29, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 29, 'Jereissati', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 30, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 30, 'Junco', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 31, 'Asa Sul', 'ZONA SUL');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 31, 'Asa Norte', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 32, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 32, 'Guariroba', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 33, 'Taguatinga Sul', 'ZONA SUL');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 33, 'Taguatinga Norte', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 34, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 34, 'Setor Leste', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 35, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 35, 'Brazlândia Sul', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 36, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 36, 'Praia do Canto', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 37, 'Itapuã', 'ZONA LESTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 37, 'Praia da Costa', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 38, 'Campo Grande', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 38, 'Porto de Santana', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 39, 'Laranjeiras', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 39, 'Jardim Limoeiro', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 40, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 40, 'Aviso', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 41, 'Setor Central', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 41, 'Setor Bueno', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 42, 'Jardim Luz', 'ZONA SUL');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 42, 'Setor Garavelo', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 43, 'Jardim das Américas', 'ZONA NORTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 43, 'Bairro de Lourdes', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 44, 'Setor Pauzanes', 'ZONA LESTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 44, 'Setor Morada do Sol', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 45, 'Jardim Ingá', 'ZONA LESTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 45, 'Setor Central', 'CENTRO');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 46, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 46, 'Renascença', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 47, 'Vila Redenção', 'ZONA NORTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 47, 'Parque Alvorada', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 48, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 48, 'Parque Piauí', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 49, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 49, 'Vila Lobão', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 50, 'São Benedito', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 50, 'Codó Novo', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 51, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 51, 'Bosque da Saúde', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 52, 'Jardim dos Estados', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 52, 'Mangabeira', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 53, 'Jardim Itapuã', 'ZONA LESTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 53, 'Vila Operária', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 54, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 54, 'Jardim das Oliveiras', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 55, 'Vila Alta', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 55, 'Jardim São Paulo', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 56, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 56, 'Jardim dos Estados', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 57, 'Vila Industrial', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 57, 'Jardim Água Boa', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 58, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 58, 'Jardim das Acácias', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 59, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 59, 'Bairro da Nova', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 60, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 60, 'Jardim dos Estados', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 61, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 61, 'Savassi', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 62, 'Eldorado', 'ZONA LESTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 62, 'Riacho das Pedras', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 63, 'Martins', 'ZONA NORTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 63, 'Jardim Karaíba', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 64, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 64, 'São Mateus', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 65, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 65, 'Imbiruçu', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 66, 'Batista Campos', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 66, 'Jurunas', 'CENTRO');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 67, 'Cidade Nova', 'ZONA LESTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 67, 'Águas Lindas', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 68, 'Aldeia', 'ZONA NORTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 68, 'Caranazal', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 69, 'Nova Marabá', 'ZONA LESTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 69, 'Cidade Nova', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 70, 'Estrela', 'ZONA LESTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 70, 'Saudade', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 71, 'Manaíra', 'ZONA LESTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 71, 'Tambaú', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 72, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 72, 'Bodocongó', 'CENTRO');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 73, 'Várzea Nova', 'ZONA NORTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 73, 'Popular', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 74, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 74, 'Belo Horizonte', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 75, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 75, 'Imaculada', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 76, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 76, 'Batel', 'CENTRO');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 77, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 77, 'Jardim Shangri-La', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 78, 'Zona 01', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 78, 'Zona 03', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 79, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 79, 'Oficinas', 'CENTRO');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 80, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 80, 'Neva', 'CENTRO');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 81, 'Boa Viagem', 'ZONA SUL');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 81, 'Casa Amarela', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 82, 'Piedade', 'ZONA SUL');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 82, 'Cavaleiro', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 83, 'Bairro Novo', 'ZONA NORTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 83, 'Ouro Preto', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 84, 'Salgado', 'ZONA OESTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 84, 'Maurício de Nassau', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 85, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 85, 'Atrás da Banca', 'CENTRO');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 86, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 86, 'Buenos Aires', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 87, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 87, 'Santa Luzia', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 88, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 88, 'Junco', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 89, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 89, 'Mangueira', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 90, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 90, 'São Luís', 'CENTRO');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 91, 'Copacabana', 'ZONA SUL');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 91, 'Tijuca', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 92, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 92, 'Neves', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 93, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 93, 'Parque Lafaiete', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 94, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 94, 'Comendador Soares', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 95, 'Icaraí', 'ZONA SUL');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 95, 'Santa Rosa', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 96, 'Lagoa Nova', 'ZONA SUL');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 96, 'Petrópolis', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 97, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 97, 'Abolição', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 98, 'Nova Parnamirim', 'ZONA LESTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 98, 'Centro', 'CENTRO');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 99, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 99, 'Jardins', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 100, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 100, 'Vila São José', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 101, 'Centro Histórico', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 101, 'Moinhos de Vento', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 102, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 102, 'São Pelegrino', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 103, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 103, 'Fragata', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 104, 'Nossa Senhora das Graças', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 104, 'Igara', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 105, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 105, 'Camobi', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 106, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 106, 'Agenor de Carvalho', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 107, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 107, 'Nova Brasília', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 108, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 108, 'Princesa Isabel', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 109, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 109, 'Jardim Social', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 110, 'Setor 01', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 110, 'Jardim Paulista', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 111, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 111, 'Tancredo Neves', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 112, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 112, 'Jardim Primavera', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 113, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 113, 'São José', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 114, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 114, 'Jardim Tropical', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 115, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 115, 'São Sebastião', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 116, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 116, 'Trindade', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 117, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 117, 'Boa Vista', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 118, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 118, 'Vila Nova', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 119, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 119, 'Forquilhas', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 120, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 120, 'Próspera', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 121, 'Vila Mariana', 'ZONA SUL');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 121, 'Pinheiros', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 122, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 122, 'Vila Galvão', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 123, 'Cambuí', 'ZONA SUL');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 123, 'Barão Geraldo', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 124, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 124, 'Rudge Ramos', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 125, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 125, 'Vila Assunção', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 126, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 126, 'Atalaia', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 127, 'Parque dos Faróis', 'ZONA NORTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 127, 'Jardim', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 128, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 128, 'Jardim Campo Novo', 'ZONA OESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 129, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 129, 'Anísio Amâncio de Oliveira', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 130, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 130, 'Cidade Nova', 'ZONA LESTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 131, 'Plano Diretor Sul', 'ZONA SUL');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 131, 'Plano Diretor Norte', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 132, 'Setor Central', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 132, 'Setor Noroeste', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 133, 'Setor Central', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 133, 'Setor Vila Nova', 'ZONA SUL');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 134, 'Centro', 'CENTRO');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 134, 'Jardim Querido', 'ZONA NORTE');


INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 135, 'Setor Oeste', 'ZONA OESTE');

INSERT INTO T_RHSTU_BAIRRO (id_bairro, id_cidade, nm_bairro, nm_zona_bairro)
VALUES (SQ_RHSTU_BAIRRO.NEXTVAL, 135, 'Setor Sul', 'ZONA SUL');


--Inserindo na tabela T_RHSTU_LOGRADOURO

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 1, 'Rua das Acácias', 08673173);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 1, 'Avenida dos Alpes', 45693722);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 2, 'Praça das Palmeiras', 14204533);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 2, 'Alameda das Hortênsias', 58103335);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 3, 'Rua das Violetas', 02524120);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 3, 'Avenida dos Girassóis', 85305441);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 4, 'Travessa das Margaridas', 67527387);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 4, 'Rua das Orquídeas', 28723981);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 5, 'Alameda dos Lírios', 66256056);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 5, 'Avenida das Rosas', 37972336);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 6, 'Praça das Bromélias', 72355096);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 6, 'Rua das Tulipas', 95033625);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 7, 'Alameda das Begônias', 88575136);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 7, 'Avenida das Camélias', 25065860);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 8, 'Rua das Dálias', 36682012);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 8, 'Praça das Azaléias', 74011568);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 9, 'Rua dos Jardins', 12627730);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 9, 'Alameda das Magnólias', 35332811);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 10, 'Avenida das Gardênias', 63284380);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 10, 'Rua das Flores', 74382896);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 11, 'Rua das Samambaias', 36609689);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 11, 'Avenida das Palmas', 70371878);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 12, 'Praça das Violetas', 97702359);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 12, 'Rua das Margaridas', 23586197);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 13, 'Alameda das Papoulas', 31518445);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 13, 'Rua dos Cravos', 74278295);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 14, 'Avenida dos Jasmins', 44619123);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 14, 'Praça dos Lírios', 25406212);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 15, 'Rua das Hortênsias', 92217142);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 15, 'Alameda dos Gerânios', 44172378);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 16, 'Rua das Begônias', 67956177);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 16, 'Avenida das Tulipas', 13265744);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 17, 'Praça das Camélias', 69894352);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 17, 'Rua das Rosas', 91713537);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 18, 'Alameda das Orquídeas', 90124333);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 18, 'Avenida das Violetas', 58388252);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 19, 'Rua das Papoulas', 34006964);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 19, 'Praça das Margaridas', 10699128);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 20, 'Rua dos Manacás', 09147452);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 20, 'Alameda das Azaléias', 04448483);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 21, 'Rua das Bromélias', 56669560);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 21, 'Avenida das Dálias', 89075618);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 22, 'Praça das Tulipas', 97345932);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 22, 'Rua das Camélias', 01765486);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 23, 'Alameda dos Cravos', 20152081);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 23, 'Avenida dos Girassóis', 30914533);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 24, 'Rua das Magnólias', 70383592);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 24, 'Praça das Orquídeas', 31013990);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 25, 'Rua das Samambaias', 76816197);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 25, 'Alameda das Palmeiras', 41785514);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 26, 'Avenida das Acácias', 72993422);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 26, 'Rua dos Ipês', 27408149);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 27, 'Praça dos Manacás', 38795632);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 27, 'Rua dos Lírios', 26808150);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 28, 'Alameda das Rosas', 73091776);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 28, 'Rua das Margaridas', 74998747);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 29, 'Avenida das Hortênsias', 62862639);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 29, 'Praça das Papoulas', 30707921);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 30, 'Rua das Azaléias', 67804214);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 30, 'Alameda das Violetas', 05756077);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 31, 'Avenida das Bromélias', 47507410);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 31, 'Rua das Orquídeas', 65718330);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 32, 'Praça das Camélias', 15453419);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 32, 'Rua das Dálias', 85649297);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 33, 'Alameda das Begônias', 30552874);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 33, 'Avenida das Tulipas', 42710061);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 34, 'Rua das Rosas', 38582518);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 34, 'Praça das Azaléias', 58836932);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 35, 'Rua dos Jardins', 49432954);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 35, 'Alameda das Magnólias', 87477541);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 36, 'Avenida das Gardênias', 05640892);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 36, 'Rua das Flores', 68370679);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 37, 'Rua das Samambaias', 10629131);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 37, 'Avenida das Palmas', 06857887);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 38, 'Praça das Violetas', 02037810);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 38, 'Rua das Margaridas', 23551640);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 39, 'Alameda das Papoulas', 85515324);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 39, 'Rua dos Cravos', 92209415);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 40, 'Avenida dos Jasmins', 09554571);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 40, 'Praça dos Lírios', 44952144);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 41, 'Rua das Hortênsias', 07618234);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 41, 'Alameda dos Gerânios', 74907435);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 42, 'Rua das Begônias', 13845324);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 42, 'Avenida das Tulipas', 68625066);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 43, 'Praça das Camélias', 74272647);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 43, 'Rua das Rosas', 98754892);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 44, 'Alameda das Orquídeas', 99563162);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 44, 'Avenida das Violetas', 29371951);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 45, 'Rua das Papoulas', 62569732);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 45, 'Praça das Margaridas', 89974707);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 46, 'Rua dos Manacás', 71009473);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 46, 'Alameda das Azaléias', 56389569);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 47, 'Rua das Bromélias', 18678174);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 47, 'Avenida das Dálias', 06586014);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 48, 'Praça das Tulipas', 64025857);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 48, 'Rua das Camélias', 50180125);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 49, 'Alameda dos Cravos', 28981414);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 49, 'Avenida dos Girassóis', 12406466);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 50, 'Rua das Magnólias', 25477911);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 50, 'Praça das Orquídeas', 54727326);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 51, 'Rua das Samambaias', 94173246);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 51, 'Alameda das Palmeiras', 82889212);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 52, 'Avenida das Acácias', 85983458);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 52, 'Rua dos Ipês', 13113181);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 53, 'Praça dos Manacás', 71583187);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 53, 'Rua dos Lírios', 11218104);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 54, 'Alameda das Rosas', 18674122);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 54, 'Rua das Margaridas', 06247280);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 55, 'Avenida das Hortênsias', 49097186);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 55, 'Praça das Papoulas', 40384122);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 56, 'Rua das Azaléias', 30743408);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 56, 'Alameda das Violetas', 33477075);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 57, 'Avenida das Bromélias', 63341171);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 57, 'Rua das Orquídeas', 62879595);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 58, 'Praça das Camélias', 65337685);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 58, 'Rua das Dálias', 20184106);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 59, 'Alameda das Begônias', 47384393);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 59, 'Avenida das Tulipas', 78755-464);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 60, 'Rua das Rosas', 26226434);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 60, 'Praça das Azaléias', 65754620);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 61, 'Rua dos Jardins', 92673764);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 61, 'Alameda das Magnólias', 60687152);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 62, 'Avenida das Gardênias', 33858985);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 62, 'Rua das Flores', 51594787);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 63, 'Rua das Samambaias', 91123446);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 63, 'Avenida das Palmas', 65422629);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 64, 'Praça das Violetas', 84047723);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 64, 'Rua das Margaridas', 80575859);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 65, 'Alameda das Papoulas', 62147283);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 65, 'Rua dos Cravos', 52721971);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 66, 'Avenida dos Jasmins', 87848992);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 66, 'Praça dos Lírios', 42343179);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 67, 'Rua das Hortênsias', 17773701);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 67, 'Alameda dos Gerânios', 16235449);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 68, 'Rua das Begônias', 93600673);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 68, 'Avenida das Tulipas', 42985507);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 69, 'Praça das Camélias', 45739118);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 69, 'Rua das Rosas', 10307379);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 70, 'Alameda das Orquídeas', 18272867);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 70, 'Avenida das Violetas', 03622910);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 71, 'Rua das Papoulas', 47181266);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 71, 'Praça das Margaridas', 96766492);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 72, 'Rua dos Manacás', 69001781);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 72, 'Alameda das Azaléias', 94722651);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 73, 'Rua das Bromélias', 46801121);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 73, 'Avenida das Dálias', 42822330);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 74, 'Praça das Tulipas', 30072181);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 74, 'Rua das Camélias', 83902616);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 75, 'Alameda dos Cravos', 38633387);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 75, 'Avenida dos Girassóis', 29576133);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 76, 'Rua das Magnólias', 67559757);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 76, 'Praça das Orquídeas', 22439090);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 77, 'Rua das Samambaias', 97360321);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 77, 'Alameda das Palmeiras', 87461658);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 78, 'Avenida das Acácias', 00053532);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 78, 'Rua dos Ipês', 36506793);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 79, 'Praça dos Manacás', 59829452);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 79, 'Rua dos Lírios', 86317419);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 80, 'Alameda das Rosas', 48124695);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 80, 'Rua das Margaridas', 19045052);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 81, 'Avenida das Hortênsias', 17174050);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 81, 'Praça das Papoulas', 40752878);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 82, 'Rua das Azaléias', 07004221);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 82, 'Alameda das Violetas', 82516434);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 83, 'Avenida das Bromélias', 53546771);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 83, 'Rua das Orquídeas', 03322167);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 84, 'Praça das Camélias', 62221887);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 84, 'Rua das Dálias', 01744782);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 85, 'Alameda das Begônias', 42818687);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 85, 'Avenida das Tulipas', 58504415);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 86, 'Rua das Rosas', 09533059);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 86, 'Praça das Azaléias', 79469946);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 87, 'Rua dos Jardins', 87411972);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 87, 'Alameda das Magnólias', 75501660);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 88, 'Avenida das Gardênias', 32051891);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 88, 'Rua das Flores', 70547788);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 89, 'Rua das Samambaias', 18549549);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 89, 'Avenida das Palmas', 03557959);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 90, 'Praça das Violetas', 81599697);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 90, 'Rua das Margaridas', 17594505);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 91, 'Alameda das Papoulas', 33148743);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 91, 'Rua dos Cravos', 16225913);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 92, 'Avenida dos Jasmins', 42836080);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 92, 'Praça dos Lírios', 68475955);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 93, 'Rua das Hortênsias', 89016514);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 93, 'Alameda dos Gerânios', 87774050);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 94, 'Rua das Begônias', 68748370);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 94, 'Avenida das Tulipas', 13664096);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 95, 'Praça das Camélias', 86137686);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 95, 'Rua das Rosas', 58012598);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 96, 'Alameda das Orquídeas', 15328843);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 96, 'Avenida das Violetas', 83320655);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 97, 'Rua das Papoulas', 69341581);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 97, 'Praça das Margaridas', 06244277);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 98, 'Rua dos Manacás', 85239786);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 98, 'Alameda das Azaléias', 04188265);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 99, 'Rua das Bromélias', 84004616);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 99, 'Avenida das Dálias', 23246172);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 100, 'Praça das Tulipas', 87603677);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 100, 'Rua das Camélias', 31584259);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 101, 'Alameda dos Cravos', 13974427);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 101, 'Avenida dos Girassóis', 72583980);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 102, 'Rua das Magnólias', 90416092);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 102, 'Praça das Orquídeas', 37654429);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 103, 'Rua das Samambaias', 92807897);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 103, 'Alameda das Palmeiras', 51052527);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 104, 'Avenida das Acácias', 80164068);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 104, 'Rua dos Ipês', 65901763);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 105, 'Praça dos Manacás', 45164284);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 105, 'Rua dos Lírios', 36435733);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 106, 'Alameda das Rosas', 30971261);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 106, 'Rua das Margaridas', 16025670);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 107, 'Avenida das Hortênsias', 74107166);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 107, 'Praça das Papoulas', 60561446);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 108, 'Rua das Azaléias', 18961120);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 108, 'Alameda das Violetas', 84442760);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 109, 'Avenida das Bromélias', 36163194);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 109, 'Rua das Orquídeas', 94045568);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 110, 'Praça das Camélias', 87196932);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 110, 'Rua das Dálias', 96914441);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 111, 'Alameda das Begônias', 06254887);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 111, 'Avenida das Tulipas', 23533163);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 112, 'Rua das Rosas', 32249517);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 112, 'Praça das Azaléias', 35343065);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 113, 'Rua dos Jardins', 65895904);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 113, 'Alameda das Magnólias', 09122077);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 114, 'Avenida das Gardênias', 38026761);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 114, 'Rua das Flores', 69060571);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 115, 'Rua das Samambaias', 69313914);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 115, 'Avenida das Palmas', 96642322);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 116, 'Praça das Violetas', 21457582);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 116, 'Rua das Margaridas', 64470587);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 117, 'Alameda das Papoulas', 24520074);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 117, 'Rua dos Cravos', 78751358);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 118, 'Avenida dos Jasmins', 61287535);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 118, 'Praça dos Lírios', 73875520);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 119, 'Rua das Hortênsias', 67345520);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 119, 'Alameda dos Gerânios', 22345834);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 120, 'Rua das Begônias', 53113918);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 120, 'Avenida das Tulipas', 38938136);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 121, 'Praça das Camélias', 35237866);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 121, 'Rua das Rosas', 77202313);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 122, 'Alameda das Orquídeas', 43218906);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 122, 'Avenida das Violetas', 49230409);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 123, 'Rua das Papoulas', 53694232);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 123, 'Praça das Margaridas', 05685186);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 124, 'Rua dos Manacás', 10184057);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 124, 'Alameda das Azaléias', 90796111);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 125, 'Rua das Bromélias', 21873383);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 125, 'Avenida das Dálias', 19571350);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 126, 'Praça das Tulipas', 41740949);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 126, 'Rua das Camélias', 79711141);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 127, 'Alameda dos Cravos', 18085333);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 127, 'Avenida dos Girassóis', 87076028);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 128, 'Rua das Magnólias', 47082348);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 128, 'Praça das Orquídeas', 52961791);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 129, 'Rua das Samambaias', 73900144);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 129, 'Alameda das Palmeiras', 20135761);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 130, 'Avenida das Acácias', 25876526);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 130, 'Rua dos Ipês', 27218502);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 131, 'Praça dos Manacás', 64752221);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 131, 'Rua dos Lírios', 44916715);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 132, 'Alameda das Rosas', 64628142);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 132, 'Rua das Margaridas', 70550326);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 133, 'Avenida das Hortênsias', 91530615);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 133, 'Praça das Papoulas', 24654659);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 134, 'Rua das Azaléias', 47347028);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 134, 'Alameda das Violetas', 66907290);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 135, 'Avenida das Bromélias', 93006162);

INSERT INTO T_RHSTU_LOGRADOURO (id_logradouro, id_bairro, nm_logradouro, nr_cep)
VALUES (SQ_RHSTU_LOGRADOURO.NEXTVAL, 135, 'Rua das Orquídeas', 60100649);


--Inserindo na tabela T_RHSTU_ENDERECO_PACIENTE

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 1, 1, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 2, 2, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 3, 3, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 4, 4, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 5, 5, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 6, 6, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 7, 7, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 8, 8, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 9, 9, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 10, 10, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 11, 11, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 12, 12, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 13, 13, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 14, 14, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 15, 15, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 16, 16, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 17, 17, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 18, 18, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 19, 19, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 20, 20, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 21, 21, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 22, 22, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 23, 23, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 24, 24, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 25, 25, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 26, 26, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 27, 27, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 28, 28, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 29, 29, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 30, 30, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 31, 31, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 32, 32, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 33, 33, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 34, 34, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 35, 35, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 36, 36, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 37, 37, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 38, 38, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 39, 39, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 40, 40, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 41, 41, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 42, 42, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 43, 43, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 44, 44, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 45, 45, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 46, 46, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 47, 47, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 48, 48, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 49, 49, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 50, 50, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 51, 51, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 52, 52, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 53, 53, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 54, 54, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 55, 55, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 56, 56, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 57, 57, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 58, 58, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 59, 59, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 60, 60, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 61, 61, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 62, 62, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 63, 63, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 64, 64, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 65, 65, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 66, 66, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 67, 67, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 68, 68, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 69, 69, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 70, 70, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 71, 71, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 72, 72, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 73, 73, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 74, 74, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 75, 75, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 76, 76, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 77, 77, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 78, 78, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 79, 79, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 80, 80, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 81, 81, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 82, 82, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 83, 83, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 84, 84, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 85, 85, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 86, 86, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 87, 87, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 88, 88, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 89, 89, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 90, 90, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 91, 91, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 92, 92, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 93, 93, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 94, 94, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 95, 95, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 96, 96, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 97, 97, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 98, 98, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 99, 99, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 100, 100, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 101, 101, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 102, 102, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 103, 103, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 104, 104, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 105, 105, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 106, 106, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 107, 107, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 108, 108, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 109, 109, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 110, 110, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 111, 111, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 112, 112, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 113, 113, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 114, 114, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 115, 115, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 116, 116, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 117, 117, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 118, 118, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 119, 119, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 120, 120, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 121, 121, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 122, 122, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 123, 123, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 124, 124, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 125, 125, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 126, 126, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 127, 127, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 128, 128, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 129, 129, SYSDATE);

INSERT INTO T_RHSTU_ENDERECO_PACIENTE (id_endereco, id_paciente, id_logradouro, dt_inicio)
VALUES (SQ_RHSTU_ENDERECO_PACIENTE.NEXTVAL, 130, 130, SYSDATE);


--Inserindo na tabela T_RHSTU_UNID_HOSPITALAR

INSERT INTO T_RHSTU_UNID_HOSPITALAR (id_unid_hospital, id_logradouro, nm_unid_hospitalar, nm_razao_social_unid_hosp, dt_inicio)
VALUES (SQ_RHSTU_UNID_HOSPITALAR.NEXTVAL, 5, 'Albert Einstein', 'Sociedade Beneficiente Albert Einstein', TO_DATE ('25/02/1980', 'DD/MM/YYYY'));


--Inserindo na tabela T_RHSTU_CONTATO_PACIENTE


INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 1, 1, 'Maria da Silva');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 2, 2, 'Dirceu Santos');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 3, 12, 'Mariana Oliveira');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 4, 11, 'Matheus Ferreira');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 5, 3, 'Renato Machado');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 6, 4, 'Luiza Costa');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 7, 9, 'Maite Almeida');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 8, 5, 'Ricardo Aragão');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 9, 7, 'Gustavo Amorin');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 10, 11, 'Nicolas Freitas');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 11, 1, 'Carla Souza');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 12, 4, 'Daniela Alves');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 13, 2, 'Ednaldo Jesus');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 14, 10, 'Orlando Santoro');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 15, 1, 'Ana Yuzuki');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 16, 5, 'Miguel Ferrarini');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 17, 8, 'Sofia Kim');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 18, 5, 'Nicolau Silveira');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 19, 7, 'Abel Albuquerque');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 20, 9, 'Anais Franco');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 21, 12, 'Carol Nunes');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 22, 3, 'Marcelo Amorin');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 23, 10, 'Alberto Marfim');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 24, 9, 'Elisa Maria');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 25, 7, 'Jorge Salvati');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 26, 2, 'Mauricio Lagos');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 27, 10, 'Bruno Molina');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 28, 1, 'Rosa Malverde');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 29, 4, 'Julia Valverde');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 30, 9, 'Nicole Lopes');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 31, 12, 'Amanda Nakamura');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 32, 7, 'Carlos Eduardo');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 33, 9, 'Maria Ortiz');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 34, 9, 'Ana Cardoso');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 35, 1, 'Luzia Torres');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 36, 5, 'Daniel Pereira');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 37, 10, 'Alex Correia');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 38, 4, 'Sofia Dias');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 39, 12, 'Giovanna Almeida');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 40, 9, 'Livia da Costa');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 41, 6, 'Natalia da Cruz');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 42, 3, 'Ayrton Martin');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 43, 10, 'Matheus Alexander');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 44, 9, 'Fernanda Barbosa');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 45, 4, 'Mariane Albuquerque');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 46, 1, 'Patricia Batista');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 47, 10, 'Caio Coelho');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 48, 2, 'Hui Wen');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 49, 2, 'Jurandir Pacheco');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 50, 9, 'Bruna Alonso');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 51, 11, 'Lucca Teixeira');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 52, 8, 'Eduarda Silva');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 53, 10, 'Armando Oliveira');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 54, 9, 'Roseli Rivera');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 55, 1, 'Ana Rives');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 56, 2, 'Paulo Silveira');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 57, 10, 'Leonardo Alonso');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 58, 5, 'Elias Cavalcante');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 59, 5, 'Douglas Reis');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 60, 9, 'Marta Yu');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 61, 12, 'Fabiana Figueredo');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 62, 2, 'Rubens Ortega');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 63, 10, 'André Takeda');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 64, 1, 'Thais Vieira');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 65, 10, 'Juliano Pires');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 66, 9, 'Diana Santana');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 67, 6, 'Marcela Rocha');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 68, 1, 'Luiza Mendes');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 69, 2, 'Heitor Branco');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 70, 9, 'Isabela Nascimento');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 71, 12, 'Luiza Guerra');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 72, 11, 'Gustavo Neves');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 73, 10, 'Kaue Luna');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 74, 9, 'Paloma Assis');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 75, 12, 'Emily Dias');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 76, 9, 'Laura Francisco');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 77, 11, 'Pedro Cruz');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 78, 8, 'Nubia Santos');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 79, 1, 'Valentina Alice');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 80, 9, 'Maria Almada');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 81, 11, 'Natan Vicente');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 82, 2, 'Edair Marques');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 83, 10, 'Alan Marli');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 84, 9, 'Raissa Pietro');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 85, 3, 'Diogo Nogueira');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 86, 9, 'Marina Machado');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 87, 11, 'Erica Gomez');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 88, 1, 'Brenda Ramos');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 89, 2, 'Dorival Silverio');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 90, 9, 'Maria José');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 91, 12, 'Paula Pinto');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 92, 6, 'Roberta Mota');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 93, 10, 'Guilherme Vicente');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 94, 9, 'Thamires Hermindo');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 95, 12, 'Leticia Cardoso');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 96, 9, 'Julia Porto');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 97, 3, 'Caio Figueiredo');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 98, 1, 'Eva Silva');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 99, 2, 'Carlos Almeida');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 100, 9, 'Solange Galvão');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 101, 12, 'Denise Castro');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 102, 2, 'Douglas Assunção');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 103, 10, 'Jorge Onodera');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 104, 9, 'Catarina Mendes');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 105, 1, 'Marcica Amorin');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 106, 9, 'Valentina Mota');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 107, 12, 'Alessandra Monteiro');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 108, 11, 'Mario Augusto');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 109, 2, 'Juliano Cabral');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 110, 9, 'Rita Ricardo');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 111, 1, 'Cris Nair');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 112, 8, 'Cristina Tuzo');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 113, 10, 'Bruno Benedito');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 114, 9, 'Olivia Yuri');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 115, 12, 'Maria Henoch');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 116, 9, 'Alice Quental');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 117, 1, 'Luma Neves');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 118, 2, 'Marcelo Alessandro');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 119, 6, 'Gabriela Lopes');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 120, 9, 'Elisa Nascimento');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 121, 3, 'Nicolas Olivera');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 122, 5, 'Marcos Viana');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 123, 4, 'Giovanna de Deus');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 124, 9, 'Sarah Cortes');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 125, 2, 'Felipe Aluisio');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 126, 9, 'Maria Silveira');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 127, 12, 'Amanda Francisco');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 128, 9, 'Keyla Fernandes');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 129, 12, 'Anais Assunção');

INSERT INTO T_RHSTU_CONTATO_PACIENTE (id_contato, id_paciente, id_tipo_contato, nm_contato)
VALUES (SQ_RHSTU_CONTATO_PACIENTE.NEXTVAL, 130, 9, 'Carla Assis');


--Inserindo na tabela T_RHSTU_TELFONE_PACIENTE

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (1, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 68, 622043450, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (1, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 68, 822910089, 'comercial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (2, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 82, 167507758, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (2, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 82, 338170239, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (3, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 96, 277955026, 'comercial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (3, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 96, 473996827, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (4, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 92, 52149876, 'residencial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (4, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 92, 625886754, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (5, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 71, 752898208, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (5, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 71, 830099255, 'comercial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (6, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 86, 36217894, 'residencial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (6, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 72, 364065282, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (7, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 16, 127869926, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (7, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 58, 204536448, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (8, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 56, 261015686, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (8, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 49, 359495176, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (9, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 96, 29700241, 'residencial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (9, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 25, 407434096, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (10, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 54, 195042001, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (10, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 50, 502845004, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (11, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 76, 508121577, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (11, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 23, 941355262, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (12, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 36, 525382287, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (12, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 90, 983867941, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (13, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 64, 275859470, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (13, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 45, 10287963, 'residencial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (14, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 26, 546018160, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (14, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 29, 197813945, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (15, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 86, 887920384, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (15, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 88, 208779996, 'comercial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (16, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 49, 106527942, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (16, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 96, 648066283, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (17, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 29, 85756920, 'residencial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (17, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 63, 984613145, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (18, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 81, 559648457, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (18, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 71, 481280771, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (19, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 25, 988449464, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (19, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 23, 149397525, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (20, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 26, 927962267, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (20, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 22, 251064506, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (21, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 22, 743602973, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (21, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 64, 233487520, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (22, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 72, 928673980, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (22, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 18, 895839557, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (23, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 30, 69874520, 'residencial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (23, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 53, 270431256, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (24, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 49, 563363013, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (24, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 74, 564397427, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (25, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 62, 403373381, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (25, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 46, 374221071, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (26, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 76, 326286802, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (26, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 84, 872917003, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (27, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 36, 193948326, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (27, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 95, 698240956, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (28, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 16, 638970803, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (28, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 84, 678715558, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (29, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 55, 713799507, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (29, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 90, 597029636, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (30, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 93, 313937228, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (30, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 17, 774723045, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (31, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 77, 814401619, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (31, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 19, 988212962, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (32, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 89, 692864202, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (32, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 19, 418290971, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (33, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 29, 881789192, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (33, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 22, 779451130, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (34, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 16, 665478954, 'residencial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (34, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 85, 785965544, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (35, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 71, 181535680, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (35, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 18, 976288146, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (36, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 64, 200583525, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (36, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 49, 710212327, 'comercial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (37, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 52, 972680719, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (37, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 50, 510983258, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (38, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 42, 311604612, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (38, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 60, 364953428, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (39, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 82, 934178009, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (39, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 35, 130684866, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (40, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 33, 158523471, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (40, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 96, 496244199, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (41, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 80, 134425393, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (41, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 43, 881853428, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (42, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 51, 38165974, 'residencial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (42, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 72, 354711720, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (43, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 99, 509868534, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (43, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 65, 305666390, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (44, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 69, 560150217, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (44, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 78, 781430907, 'comercial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (45, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 57, 962225454, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (45, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 33, 773835483, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (46, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 83, 896341601, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (46, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 55, 115183150, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (47, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 30, 882560287, 'residencial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (47, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 71, 217922394, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (48, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 53, 840897164, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (48, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 45, 399821402, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (49, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 68, 931639283, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (49, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 58, 864743415, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (50, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 81, 548443062, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (50, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 86, 651896558, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (51, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 57, 292079002, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (51, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 74, 237581961, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (52, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 96, 159054677, 'residencial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (52, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 86, 404022302, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (53, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 42, 155166803, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (53, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 27, 311425655, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (54, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 12, 828693125, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (54, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 78, 789866963, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (55, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 46, 687922328, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (55, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 24, 602741377, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (56, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 36, 910064406, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (56, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 15, 327609344, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (57, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 34, 65400320, 'residencial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (57, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 60, 536264391, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (58, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 97, 836937439, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (58, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 71, 971201589, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (59, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 20, 366260290, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (59, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 42, 893723226, 'comercial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (60, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 51, 878033328, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (60, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 49, 883836215, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (61, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 58, 170426255, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (61, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 75, 164964182, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (62, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 34, 210491648, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (62, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 52, 732560247, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (63, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 70, 743392522, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (63, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 53, 452569641, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (64, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 93, 956279752, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (64, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 55, 179312048, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (65, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 62, 789243121, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (65, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 37, 111385383, 'comercial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (66, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 84, 241414844, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (66, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 19, 316724963, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (67, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 59, 473390692, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (67, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 38, 985437689, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (68, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 63, 389588404, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (68, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 29, 72015860, 'residencial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (69, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 64, 601626371, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (69, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 96, 992074811, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (70, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 53, 162278660, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (70, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 44, 463467126, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (71, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 12, 529765262, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (71, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 52, 669318148, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (72, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 43, 139272732, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (72, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 19, 457941085, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (73, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 15, 564816572, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (73, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 72, 100575006, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (74, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 75, 581435397, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (74, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 13, 377394784, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (75, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 64, 491623062, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (75, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 21, 593037160, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (76, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 49, 794050785, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (76, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 13, 101038596, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (77, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 48, 614635717, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (77, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 27, 921847473, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (78, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 33, 85123311, 'residencial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (78, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 64, 652213804, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (79, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 78, 581805812, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (79, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 62, 361691261, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (80, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 36, 863659560, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (80, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 48, 588517003, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (81, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 99, 551116184, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (81, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 54, 539741936, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (82, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 69, 505969877, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (82, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 66, 281538413, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (83, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 80, 725487947, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (83, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 26, 180090352, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (84, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 39, 161385375, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (84, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 48, 219431146, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (85, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 15, 677880406, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (85, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 12, 663999271, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (86, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 96, 915887620, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (86, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 11, 947977839, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (87, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 88, 733674793, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (87, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 83, 327183388, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (88, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 85, 607117480, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (88, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 87, 194909211, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (89, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 64, 886835097, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (89, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 87, 109637151, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (90, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 18, 961128655, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (90, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 14, 91875421, 'residencial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (91, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 21, 242496179, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (91, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 18, 852373574, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (92, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 30, 664187961, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (92, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 68, 952188204, 'reidencial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (93, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 48, 816214232, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (93, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 47, 399814002, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (94, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 59, 659918194, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (94, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 93, 202015092, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (95, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 75, 828054454, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (95, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 77, 941842675, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (96, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 54, 972490308, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (96, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 52, 229469761, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (97, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 83, 534576411, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (97, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 39, 712924649, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (98, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 66, 114271238, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (98, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 20, 509259040, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (99, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 32, 466357274, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (99, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 76, 30256989, 'residencial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (100, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 27, 511716183, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (100, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 70, 220545076, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (101, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 55, 133989998, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (101, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 55, 790803420, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (102, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 27, 240354491, 'comercial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (102, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 97, 718253496, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (103, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 14, 416171681, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (103, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 17, 620293267, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (104, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 22, 214287153, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (104, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 71, 511995409, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (105, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 32, 233238768, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (105, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 68, 316217895, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (106, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 96, 922336585, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (106, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 77, 628050359, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (107, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 36, 877398080, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (107, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 88, 151349809, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (108, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 38, 385308831, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (108, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 86, 337110920, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (109, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 84, 683228842, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (109, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 85, 792438675, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (110, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 84, 271686296, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (110, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 53, 22423090, 'residencial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (111, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 65, 961873165, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (111, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 19, 974830675, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (112, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 96, 136750730, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (112, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 51, 487072772, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (113, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 17, 347303448, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (113, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 55, 212179696, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (114, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 58, 477055893, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (114, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 80, 801643009, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (115, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 22, 416358374, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (115, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 64, 930651539, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (116, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 75, 982214650, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (116, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 57, 743665803, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (117, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 57, 552305100, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (117, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 52, 337783306, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (118, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 36, 831254082, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (118, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 70, 968199170, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (119, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 68, 341439525, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (119, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 62, 28801331, 'reidencial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (120, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 96, 421364334, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (120, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 57, 747537538, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (121, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 12, 738444838, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (121, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 11, 770898709, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (122, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 43, 324288566, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (122, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 99, 786794843, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (123, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 53, 997648986, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (123, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 32, 401572366, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (124, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 77, 876590552, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (124, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 50, 805907536, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (125, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 97, 822258015, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (125, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 16, 278481918, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (126, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 12, 613841869, 'comercial', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (126, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 54, 939164778, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (127, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 90, 282639912, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (127, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 28, 967544670, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (128, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 58, 281726627, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (128, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 46, 37942159, 'residencial', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (129, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 54, 631806515, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (129, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 66, 422934376, 'pessoal', 'I');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (130, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 86, 813782790, 'pessoal', 'A');

INSERT INTO T_RHSTU_TELEFONE_PACIENTE (id_paciente, id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone)
VALUES (130, SQ_RHSTU_TELEFONE_PACIENTE.NEXTVAL, 55, 15, 973321922, 'comercial', 'A');


--Inserindo na tabela T_RHSTU_PACIENTE_PLANO_SAUDE

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 1, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 2, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 3, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 4, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 5, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 6, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 7, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 8, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 9, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 10, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 11, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 12, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 13, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 14, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 15, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 16, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 17, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 18, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 19, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 20, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 21, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 22, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 23, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 24, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 25, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 26, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 27, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 28, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 29, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 30, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 31, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 32, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 33, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 34, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 35, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 36, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 37, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 38, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 39, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 40, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 41, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 42, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 43, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 44, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 45, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 46, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 47, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 48, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 49, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 50, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 51, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 52, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 53, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 54, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 55, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 56, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 57, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 58, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 59, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 60, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 61, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 62, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 63, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 64, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 65, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 66, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 67, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 68, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 69, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 70, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 71, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 72, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 73, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 74, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 75, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 76, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 77, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 78, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 79, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 80, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 81, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 82, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 83, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 84, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 85, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 86, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 87, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 88, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 89, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 90, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 91, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 92, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 93, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 94, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 95, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 96, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 97, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 98, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 99, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 100, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 101, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 102, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 103, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 104, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 105, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 106, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 107, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 108, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 109, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 110, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 111, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 112, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 113, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 114, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 115, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 116, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 117, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 118, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 119, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 120, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 121, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 122, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 123, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 124, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 125, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 126, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 127, 3, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 128, 1, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 129, 2, SYSDATE);

INSERT INTO T_RHSTU_PACIENTE_PLANO_SAUDE (id_paciente_ps, id_paciente, id_plano_saude, dt_inicio)
VALUES (SQ_RHSTU_PACIENTE_PLANO_SAUDE.NEXTVAL, 130, 3, SYSDATE);

--Inserindo na tabela T_RHSTU_CONSULTA

ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy hh24:mi:ss';

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 1, 1, TO_DATE('19/10/2017 19:49:00', 'DD/MM/YYYY HH24:MI:SS'), 1);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 2, 2, TO_DATE('23/10/2023 13:00:00', 'DD/MM/YYYY HH24:MI:SS'), 2);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 3, 3, TO_DATE('19/10/2023 13:15:00', 'DD/MM/YYYY HH24:MI:SS'), 3);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 4, 4, TO_DATE('19/07/2023 13:30:00', 'DD/MM/YYYY HH24:MI:SS'), 4);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 5, 5, TO_DATE('09/08/2023 13:45:00', 'DD/MM/YYYY HH24:MI:SS'), 5);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 6, 6, TO_DATE('09/07/2023 14:00:00', 'DD/MM/YYYY HH24:MI:SS'), 6);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 7, 7, TO_DATE('30/07/2023 14:15:00', 'DD/MM/YYYY HH24:MI:SS'), 7);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 8, 18, TO_DATE('20/07/2023 15:00:00', 'DD/MM/YYYY HH24:MI:SS'), 11);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 9, 19, TO_DATE('01/07/2023 15:15:00', 'DD/MM/YYYY HH24:MI:SS'), 12);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 10, 20, TO_DATE('03/07/2023 15:30:00', 'DD/MM/YYYY HH24:MI:SS'), 13);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 11, 21, TO_DATE('10/09/2023 15:45:00', 'DD/MM/YYYY HH24:MI:SS'), 14);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 12, 22, TO_DATE('20/09/2023 16:00:00', 'DD/MM/YYYY HH24:MI:SS'), 15);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 13, 23, TO_DATE('01/09/2023 16:15:00', 'DD/MM/YYYY HH24:MI:SS'), 16);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 14, 11, TO_DATE('03/09/2023 16:30:00', 'DD/MM/YYYY HH24:MI:SS'), 17);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 15, 12, TO_DATE('04/09/2023 16:45:00', 'DD/MM/YYYY HH24:MI:SS'), 18);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 16, 13, TO_DATE('05/09/2023 17:00:00', 'DD/MM/YYYY HH24:MI:SS'), 19);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 17, 14, TO_DATE('06/09/2023 17:15:00', 'DD/MM/YYYY HH24:MI:SS'), 20);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 18, 15, TO_DATE('07/09/2023 17:30:00', 'DD/MM/YYYY HH24:MI:SS'), 1);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 19, 16, TO_DATE('08/09/2023 17:45:00', 'DD/MM/YYYY HH24:MI:SS'), 2);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 20, 17, TO_DATE('09/09/2023 18:00:00', 'DD/MM/YYYY HH24:MI:SS'), 3);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 21, 18, TO_DATE('10/09/2023 18:15:00', 'DD/MM/YYYY HH24:MI:SS'), 4);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 22, 19, TO_DATE('11/09/2023 18:30:00', 'DD/MM/YYYY HH24:MI:SS'), 5);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 23, 20, TO_DATE('12/09/2023 18:45:00', 'DD/MM/YYYY HH24:MI:SS'), 6);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 24, 21, TO_DATE('13/09/2023 19:00:00', 'DD/MM/YYYY HH24:MI:SS'), 7);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 25, 22, TO_DATE('14/09/2023 19:15:00', 'DD/MM/YYYY HH24:MI:SS'), 8);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 26, 23, TO_DATE('15/09/2023 19:30:00', 'DD/MM/YYYY HH24:MI:SS'), 9);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 27, 11, TO_DATE('16/09/2023 19:45:00', 'DD/MM/YYYY HH24:MI:SS'), 10);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 28, 12, TO_DATE('20/07/2023 20:00:00', 'DD/MM/YYYY HH24:MI:SS'), 11);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 29, 13, TO_DATE('17/09/2023 20:15:00', 'DD/MM/YYYY HH24:MI:SS'), 12);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 30, 14, TO_DATE('18/09/2023 20:30:00', 'DD/MM/YYYY HH24:MI:SS'), 13);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 31, 15, TO_DATE('19/09/2023 20:45:00', 'DD/MM/YYYY HH24:MI:SS'), 14);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 32, 16, TO_DATE('20/09/2023 21:00:00', 'DD/MM/YYYY HH24:MI:SS'), 15);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 33, 17, TO_DATE('21/09/2023 21:15:00', 'DD/MM/YYYY HH24:MI:SS'), 16);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 34, 18, TO_DATE('22/09/2023 21:30:00', 'DD/MM/YYYY HH24:MI:SS'), 17);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 35, 19, TO_DATE('23/09/2023 21:45:00', 'DD/MM/YYYY HH24:MI:SS'), 18);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 36, 20, TO_DATE('24/09/2023 22:00:00', 'DD/MM/YYYY HH24:MI:SS'), 19);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 37, 21, TO_DATE('25/09/2023 22:15:00', 'DD/MM/YYYY HH24:MI:SS'), 20);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 38, 22, TO_DATE('21/07/2023 08:00:00', 'DD/MM/YYYY HH24:MI:SS'), 1);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 39, 23, TO_DATE('26/09/2023 08:15:00', 'DD/MM/YYYY HH24:MI:SS'), 2);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 40, 1, TO_DATE('27/09/2023 08:30:00', 'DD/MM/YYYY HH24:MI:SS'), 3);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 41, 2, TO_DATE('28/09/2023 08:45:00', 'DD/MM/YYYY HH24:MI:SS'), 4);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 42, 3, TO_DATE('29/09/2023 09:00:00', 'DD/MM/YYYY HH24:MI:SS'), 5);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 43, 4, TO_DATE('30/09/2023 09:15:00', 'DD/MM/YYYY HH24:MI:SS'), 6);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 44, 5, TO_DATE('01/10/2023 09:30:00', 'DD/MM/YYYY HH24:MI:SS'), 7);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 45, 6, TO_DATE('02/10/2023 09:45:00', 'DD/MM/YYYY HH24:MI:SS'), 8);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 46, 7, TO_DATE('03/10/2023 10:00:00', 'DD/MM/YYYY HH24:MI:SS'), 9);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 47, 8, TO_DATE('04/10/2023 10:15:00', 'DD/MM/YYYY HH24:MI:SS'), 10);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 48, 9, TO_DATE('05/10/2023 10:30:00', 'DD/MM/YYYY HH24:MI:SS'), 11);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 49, 10, TO_DATE('06/10/2023 10:45:00', 'DD/MM/YYYY HH24:MI:SS'), 12);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 50, 11, TO_DATE('07/10/2023 11:00:00', 'DD/MM/YYYY HH24:MI:SS'), 13);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 51, 12, TO_DATE('08/10/2023 11:15:00', 'DD/MM/YYYY HH24:MI:SS'), 14);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 52, 13, TO_DATE('09/10/2023 11:30:00', 'DD/MM/YYYY HH24:MI:SS'), 15);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 53, 14, TO_DATE('10/10/2023 11:45:00', 'DD/MM/YYYY HH24:MI:SS'), 16);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 54, 15, TO_DATE('11/10/2023 12:00:00', 'DD/MM/YYYY HH24:MI:SS'), 17);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 55, 16, TO_DATE('12/10/2023 12:15:00', 'DD/MM/YYYY HH24:MI:SS'), 18);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 56, 17, TO_DATE('13/10/2023 12:30:00', 'DD/MM/YYYY HH24:MI:SS'), 19);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 57, 18, TO_DATE('14/10/2023 12:45:00', 'DD/MM/YYYY HH24:MI:SS'), 20);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 58, 19, TO_DATE('15/10/2023 08:00:00', 'DD/MM/YYYY HH24:MI:SS'), 1);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 59, 20, TO_DATE('16/10/2023 08:15:00', 'DD/MM/YYYY HH24:MI:SS'), 2);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 60, 21, TO_DATE('17/10/2023 08:30:00', 'DD/MM/YYYY HH24:MI:SS'), 3);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 61, 22, TO_DATE('18/10/2023 08:45:00', 'DD/MM/YYYY HH24:MI:SS'), 4);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 62, 23, TO_DATE('19/10/2023 09:00:00', 'DD/MM/YYYY HH24:MI:SS'), 5);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 63, 1, TO_DATE('20/10/2023 09:15:00', 'DD/MM/YYYY HH24:MI:SS'), 6);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 64, 2, TO_DATE('21/10/2023 09:30:00', 'DD/MM/YYYY HH24:MI:SS'), 7);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 65, 3, TO_DATE('22/10/2023 09:45:00', 'DD/MM/YYYY HH24:MI:SS'), 8);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 66, 4, TO_DATE('22/10/2023 10:00:00', 'DD/MM/YYYY HH24:MI:SS'), 9);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 67, 5, TO_DATE('23/10/2023 10:15:00', 'DD/MM/YYYY HH24:MI:SS'), 10);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 68, 6, TO_DATE('24/10/2023 10:30:00', 'DD/MM/YYYY HH24:MI:SS'), 11);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 69, 7, TO_DATE('25/10/2023 10:45:00', 'DD/MM/YYYY HH24:MI:SS'), 12);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 70, 8, TO_DATE('26/10/2023 11:00:00', 'DD/MM/YYYY HH24:MI:SS'), 13);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 71, 9, TO_DATE('27/10/2023 11:15:00', 'DD/MM/YYYY HH24:MI:SS'), 14);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 72, 10, TO_DATE('28/10/2023 11:30:00', 'DD/MM/YYYY HH24:MI:SS'), 15);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 73, 11, TO_DATE('29/10/2023 11:45:00', 'DD/MM/YYYY HH24:MI:SS'), 16);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 74, 12, TO_DATE('30/10/2023 12:00:00', 'DD/MM/YYYY HH24:MI:SS'), 17);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 75, 13, TO_DATE('30/10/2023 12:15:00', 'DD/MM/YYYY HH24:MI:SS'), 18);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 76, 14, TO_DATE('01/11/2023 12:30:00', 'DD/MM/YYYY HH24:MI:SS'), 19);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 77, 15, TO_DATE('02/11/2023 12:45:00', 'DD/MM/YYYY HH24:MI:SS'), 20);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 78, 16, TO_DATE('03/11/2023 08:00:00', 'DD/MM/YYYY HH24:MI:SS'), 1);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 79, 17, TO_DATE('04/11/2023 08:15:00', 'DD/MM/YYYY HH24:MI:SS'), 2);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 80, 18, TO_DATE('05/11/2023 08:30:00', 'DD/MM/YYYY HH24:MI:SS'), 3);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 81, 19, TO_DATE('06/11/2023 08:45:00', 'DD/MM/YYYY HH24:MI:SS'), 4);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 82, 20, TO_DATE('07/11/2023 09:00:00', 'DD/MM/YYYY HH24:MI:SS'), 5);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 83, 21, TO_DATE('07/11/2023 09:15:00', 'DD/MM/YYYY HH24:MI:SS'), 6);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 84, 22, TO_DATE('08/11/2023 09:30:00', 'DD/MM/YYYY HH24:MI:SS'), 7);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 85, 23, TO_DATE('08/11/2023 09:45:00', 'DD/MM/YYYY HH24:MI:SS'), 8);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 86, 1, TO_DATE('09/11/2023 10:00:00', 'DD/MM/YYYY HH24:MI:SS'), 9);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 87, 2, TO_DATE('10/11/2023 10:15:00', 'DD/MM/YYYY HH24:MI:SS'), 10);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 88, 3, TO_DATE('10/11/2023 10:30:00', 'DD/MM/YYYY HH24:MI:SS'), 11);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 89, 4, TO_DATE('11/11/2023 10:45:00', 'DD/MM/YYYY HH24:MI:SS'), 12);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 90, 5, TO_DATE('12/11/2023 11:00:00', 'DD/MM/YYYY HH24:MI:SS'), 13);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 91, 6, TO_DATE('12/11/2023 11:15:00', 'DD/MM/YYYY HH24:MI:SS'), 14);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 92, 7, TO_DATE('13/11/2023 11:30:00', 'DD/MM/YYYY HH24:MI:SS'), 15);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 93, 8, TO_DATE('14/11/2023 11:45:00', 'DD/MM/YYYY HH24:MI:SS'), 16);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 94, 9, TO_DATE('14/11/2023 12:00:00', 'DD/MM/YYYY HH24:MI:SS'), 17);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 95, 10, TO_DATE('15/11/2023 12:15:00', 'DD/MM/YYYY HH24:MI:SS'), 18);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 96, 11, TO_DATE('15/11/2023 12:30:00', 'DD/MM/YYYY HH24:MI:SS'), 19);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 97, 12, TO_DATE('16/11/2023 12:45:00', 'DD/MM/YYYY HH24:MI:SS'), 20);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 98, 13, TO_DATE('17/11/2023 13:00:00', 'DD/MM/YYYY HH24:MI:SS'), 1);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 99, 14, TO_DATE('18/11/2023 13:15:00', 'DD/MM/YYYY HH24:MI:SS'), 2);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 100, 15, TO_DATE('19/11/2023 13:30:00', 'DD/MM/YYYY HH24:MI:SS'), 3);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 101, 16, TO_DATE('20/11/2023 13:45:00', 'DD/MM/YYYY HH24:MI:SS'), 4);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 102, 17, TO_DATE('20/11/2023 14:00:00', 'DD/MM/YYYY HH24:MI:SS'), 5);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 103, 18, TO_DATE('21/11/2023 14:15:00', 'DD/MM/YYYY HH24:MI:SS'), 6);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 104, 19, TO_DATE('21/11/2023 14:30:00', 'DD/MM/YYYY HH24:MI:SS'), 7);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 105, 20, TO_DATE('22/11/2023 14:45:00', 'DD/MM/YYYY HH24:MI:SS'), 8);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 106, 21, TO_DATE('23/11/2023 15:00:00', 'DD/MM/YYYY HH24:MI:SS'), 9);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 107, 22, TO_DATE('23/11/2023 15:15:00', 'DD/MM/YYYY HH24:MI:SS'), 10);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 108, 23, TO_DATE('24/11/2023 15:30:00', 'DD/MM/YYYY HH24:MI:SS'), 11);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 109, 1, TO_DATE('25/11/2023 15:45:00', 'DD/MM/YYYY HH24:MI:SS'), 12);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 110, 2, TO_DATE('26/11/2023 16:00:00', 'DD/MM/YYYY HH24:MI:SS'), 13);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 111, 3, TO_DATE('27/11/2023 16:15:00', 'DD/MM/YYYY HH24:MI:SS'), 14);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 112, 4, TO_DATE('28/11/2023 16:30:00', 'DD/MM/YYYY HH24:MI:SS'), 15);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 113, 5, TO_DATE('29/11/2023 16:45:00', 'DD/MM/YYYY HH24:MI:SS'), 16);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 114, 6, TO_DATE('29/11/2023 17:00:00', 'DD/MM/YYYY HH24:MI:SS'), 17);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 115, 7, TO_DATE('30/11/2023 17:15:00', 'DD/MM/YYYY HH24:MI:SS'), 18);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 116, 8, TO_DATE('01/12/2023 17:30:00', 'DD/MM/YYYY HH24:MI:SS'), 19);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 117, 9, TO_DATE('02/12/2023 17:45:00', 'DD/MM/YYYY HH24:MI:SS'), 20);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 118, 10, TO_DATE('03/12/2023 09:00:00', 'DD/MM/YYYY HH24:MI:SS'), 1);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 119, 11, TO_DATE('03/12/2023 09:15:00', 'DD/MM/YYYY HH24:MI:SS'), 2);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 120, 12, TO_DATE('04/12/2023 09:30:00', 'DD/MM/YYYY HH24:MI:SS'), 3);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 121, 13, TO_DATE('04/12/2023 09:45:00', 'DD/MM/YYYY HH24:MI:SS'), 4);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 122, 14, TO_DATE('05/12/2023 10:00:00', 'DD/MM/YYYY HH24:MI:SS'), 5);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 123, 15, TO_DATE('06/12/2023 10:15:00', 'DD/MM/YYYY HH24:MI:SS'), 6);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 124, 16, TO_DATE('07/12/2023 10:30:00', 'DD/MM/YYYY HH24:MI:SS'), 7);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 125, 17, TO_DATE('08/12/2023 10:45:00', 'DD/MM/YYYY HH24:MI:SS'), 8);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 126, 18, TO_DATE('09/12/2023 11:00:00', 'DD/MM/YYYY HH24:MI:SS'), 9);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 127, 19, TO_DATE('10/12/2023 11:15:00', 'DD/MM/YYYY HH24:MI:SS'), 10);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 128, 20, TO_DATE('11/12/2023 11:30:00', 'DD/MM/YYYY HH24:MI:SS'), 11);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 129, 21, TO_DATE('12/12/2023 11:45:00', 'DD/MM/YYYY HH24:MI:SS'), 12);

INSERT INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
VALUES (1, SQ_RHSTU_CONSULTA.NEXTVAL, 130, 22, TO_DATE('13/12/2023 12:00:00', 'DD/MM/YYYY HH24:MI:SS'), 13);


--Inserindo na tabela T_RHSTU_CONSULTA_FORMA_PAGTO

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 1, 1, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 2, 2, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 3, 3, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 4, 4, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 5, 5, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 6, 6, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 7, 7, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 8, 8, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 9, 9, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 10, 10, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 11, 11, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 12, 12, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 13, 13, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 14, 14, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 15, 15, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 16, 16, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 17, 17, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 18, 18, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 19, 19, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 20, 20, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 21, 21, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 22, 22, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 23, 23, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 24, 24, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 25, 25, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 26, 26, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 27, 27, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 28, 28, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 29, 29, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 30, 30, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 31, 31, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 32, 32, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 33, 33, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 34, 34, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 35, 35, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 36, 36, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 37, 37, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 38, 38, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 39, 39, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 40, 40, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 41, 41, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 42, 42, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 43, 43, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 44, 44, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 45, 45, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 46, 46, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 47, 47, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 48, 48, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 49, 49, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 50, 50, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 51, 51, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 52, 52, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 53, 53, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 54, 54, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 55, 55, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 56, 56, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 57, 57, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 58, 58, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 59, 59, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 60, 60, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 61, 61, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 62, 62, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 63, 63, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 64, 64, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 65, 65, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 66, 66, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 67, 67, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 68, 68, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 69, 69, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 70, 70, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 71, 71, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 72, 72, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 73, 73, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 74, 74, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 75, 75, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 76, 76, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 77, 77, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 78, 78, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 79, 79, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 80, 80, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 81, 81, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 82, 82, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 83, 83, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 84, 84, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 85, 85, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 86, 86, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 87, 87, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 88, 88, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 89, 89, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 90, 90, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 91, 91, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 92, 92, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 93, 93, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 94, 94, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 95, 95, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 96, 96, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 97, 97, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 98, 98, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 99, 99, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 100, 100, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 101, 101, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 102, 102, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 103, 103, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 104, 104, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 105, 105, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 106, 106, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 107, 107, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 108, 108, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 109, 109, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 110, 110, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 111, 111, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 112, 112, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 113, 113, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 114, 114, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 115, 115, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 116, 116, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 117, 117, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 118, 118, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 119, 119, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 120, 120, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 121, 121, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 122, 122, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 123, 123, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 124, 124, 4, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 125, 125, 5, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 126, 126, 6, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 127, 127, 1, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 128, 128, 2, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 129, 129, 3, SYSDATE, 'A');

INSERT INTO T_RHSTU_CONSULTA_FORMA_PAGTO (id_consulta_forma_pagto, id_unid_hospital, nr_consulta, id_paciente_ps, id_forma_pagto, dt_cadastro, st_pagto_consulta)
VALUES (SQ_RHSTU_CONSULTA_FORMA_PAGTO.NEXTVAL, 1, 130, 130, 4, SYSDATE, 'A');


--Inserindo na tabela T_RHSTU_EMAIL_PACIENTE;

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 1, 'joaoSilva', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 1, 'silvaJoao', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 2, 'mariaSantos', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 2, 'santosMaria', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 3, 'carlosOliveira', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 3, 'oliveiraCarlos', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 4, 'amandaFerreira', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 4, 'ferreirAmanda', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 5, 'pauloLima', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 5, 'limaPaulo', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 6, 'fernandaCosta', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 6, 'costaFernanda', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 7, 'ricardoAlmeida', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 7, 'Almeidaricardo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 8, 'larissaAragão', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 8, 'AragãoLarissa', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 9, 'andréGonçalves', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 9, 'gonçalvesAndré', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 10, 'danielaCristinaFreitas', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 10, 'cristinaFreitasDaniela', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 11, 'rafaelSouza', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 11, 'souzaRafael', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 12, 'marianaAlves', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 12, 'alvesMariana', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 13, 'matheusJesus', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 13, 'jesusMatheus', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 14, 'santoroLuciana', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 14, 'lucianaSantoro', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 15, 'eduardoYuzuki', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 15, 'yuzukiEduardo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 16, 'nicoleFerrarini', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 16, 'ferrariniNicole', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 17, 'alexandreSilveira', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 17, 'silveiraAlexandre', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 18, 'isabelaGomes', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 18, 'gomesIsabela', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 19, 'pedroFranco', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 19, 'francoPedro', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 20, 'anaNunes', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 20, 'nunesAna', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 21, 'guilhermeAmorin', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 22, 'amorinGuilherme', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 22, 'mariaFernanda', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 22, 'fernandaMaria', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 23, 'nicolasAlberto', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 23, 'albertoNicolas', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 24, 'sofiaCorreia', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 24, 'correiaSofia', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 25, 'caioLagos', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 25, 'lagosCaio', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 26, 'luizaMolina', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 26, 'molinaLuiza', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 27, 'miguelMalverde', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 27, 'malverdeMiguel', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 28, 'carolValverde', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 28, 'valverdeCarol', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 29, 'jorgeLopes', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 29, 'lopesJorge', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 30, 'beatrizNakamura', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 30, 'nakamuraBeatriz', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 31, 'gabrielMelo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 31, 'meloGabriel', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 32, 'luciaOrtiz', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 32, 'ortizLucia', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 33, 'Antonio Cardoso', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 33, 'Antonio Cardoso', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 34, 'liviaTorres', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 34, 'torresLivia', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 35, 'ricardoPereira', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 35, 'pereiraRicardo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 36, 'alineCorreia', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 36, 'correiaAline', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 37, 'vitorDias', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 37, 'diasVitor', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 38, 'monicaAlmeida', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 38, 'almeidaMonica', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 39, 'marcioCosta', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 39, 'costaMarcio', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 40, 'raissaCruz', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 40, 'cruzRaissa', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 41, 'samuelMartin', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 41, 'martinSamuel', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 42, 'leticiaAlexander', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 42, 'alexanderLeticia', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 43, 'fernandoBarbosa', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 43, 'barbosaFernando', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 44, 'marianeAlbuquerque', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 44, 'albuquerqueMariane', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 45, 'joãoBatista', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 45, 'BatistaJoão', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 46, 'luciaCoelho', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 46, 'coelhoLucia', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 47, 'diogoWen', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 47, 'wenDiogo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 48, 'abeyPacheco', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 48, 'pachecoAbey', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 49, 'arthurAlonso', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 49, 'alonsoArthur', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 50, 'nicoleTeixeira', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 50, 'teixeiraNicole', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 51, 'gustavoRosas', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 51, 'rosasGustavo', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 52, 'isabeliOliveira', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 52, 'oliveiraIsabeli', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 53, 'felipeRivera', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 53, 'riveraFelipe', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 54, 'giovannaRives', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 54, 'rivesGiovanna', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 55, 'leonardoSilveira', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 55, 'silveiraLeonardo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 56, 'luciaAlonso', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 56, 'alonsoLucia', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 57, 'giovanneCavalcante', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 57, 'cavalcanteGiovanne', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 58, 'elisaReis', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 58, 'reisElisa', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 59, 'peterYu', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 59, 'yuPeter', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 60, 'nataliaFigueredo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 60, 'figueredoNatalia', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 61, 'daviOrtega', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 61, 'ortegaDavi', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 62, 'marcelaTakeda', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 62, 'takedaMarcela', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 63, 'albertoVieira', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 63, 'vieiraAlberto', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 64, 'julianaPires', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 64, 'piresJuliana', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 65, 'pauloSantana', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 65, 'santanaPaulo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 66, 'lúciaRocha', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 66, 'rochaLúcia', '@gmail.com', 'I' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 67, 'muriloMendes', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 67, 'mendesMurilo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 68, 'alessandraBranco', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 68, 'brancoAlessandra', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 69, 'RaulNascimento', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 69, 'nascimentoRaul', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 70, 'olindaGuerra', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 70, 'guerraOlinda', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 71, 'brenoNeves', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 71, 'nevesBreno', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 72, 'rosaLuna', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 72, 'lunaRosa', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 73, 'theoAssis', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 73, 'assisTheo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 74, 'deboraDias', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 74, 'diasDebora', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 75, 'heitorFrancisco', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 75, 'franciscoHeitor', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 76, 'emilyCruz', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 76, 'cruzEmily', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 77, 'manuelIsis', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 77, 'isisManuel', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 78, 'palomaAlice', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 78, 'alicePaloma', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 79, 'andréAlmada', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 79, 'almadaAndré', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 80, 'fabianaVicente', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 80, 'vicenteFabiana', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 81, 'eliasMarcos', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 81, 'marcosElias', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 82, 'alanaMarli', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 82, 'marliAlana', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 83, 'rubensPietro', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 83, 'pietroRubens', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 84, 'camilaNogueira', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 84, 'nogueiraCamila', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 85, 'lucasMachado', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 85, 'MachadoLucas', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 86, 'ericaGomez', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 86, 'gomezErica', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 87, 'geraldoRamos', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 87, 'ramosGeraldo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 88, 'milenaSilverio', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 88, 'silverioMilena', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 89, 'pietroJosé', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 89, 'joséPietro', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 90, 'jenifferPinto', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 90, 'pintoJeniffer', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 91, 'daniloMota', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 91, 'motaDanilo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 92, 'sarahVicente', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 92, 'vicenteSarah', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 93, 'henryHermindo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 93, 'hermindoHenry', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 94, 'lumaCardoso', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 94, 'cardosoLuma', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 95, 'julioPorto', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 95, 'portoJulio', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 96, 'vitóriaFigueiredo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 96, 'figueiredoVitória', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 97, 'noahSilva', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 97, 'silvaNoah', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 98, 'juliana Almeida', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 98, 'almeidaJuliana', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 99, 'hugoGalvão', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 99, 'galvãoHugo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 100, 'catarinaCastro', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 100, 'castroCatarina', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 101, 'tomásAssunção', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 101, 'assunçãoTomás', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 102, 'marcelaOnodera', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 102, 'onoderaMarcela', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 103, 'denilsonMendes', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 103, 'mendesDenilson', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 104, 'helenaAmorin', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 104, 'amorinHelena', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 105, 'gaelMota', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 105, 'motaGael', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 106, 'Luciana Monteiro', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 106, 'Luciana Monteiro', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 107, 'Marcel Augusto', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 107, 'Marcel Augusto', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 108, 'julianaCabral', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 108, 'cabralJuliana', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 109, 'alexandreRicardo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 109, 'ricardoAlexandre', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 110, 'martaNair', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 110, 'nairMarta', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 111, 'renanTuzo', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 111, 'tuzoRenan', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 112, 'rafaelaBenedito', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 112, 'beneditoRafaela', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 113, 'oliverYuri', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 113, 'yuriOliver', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 114, 'amandaHenoch', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 114, 'henochAmanda', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 115, 'andressonQuental', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 115, 'quentalAndresson', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 116, 'esterNeves', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 116, 'nevesEster', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 117, 'fábioAlessandro', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 117, 'alessandroFábio', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 118, 'giovannaLopes', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 118, 'lopesGiovanna', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 119, 'nathanNascimento', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 119, 'nascimentoNathan', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 120, 'tatianaOlivera', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 120, 'oliveraTatiana', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 121, 'sebastiãoViana', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 121, 'vianaSebastião', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 122, 'heloisaDeus', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 122, 'deusHeloisa', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 123, 'thiagoCortes', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 123, 'cortesThiago', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 124, 'veraAluisio', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 124, 'aluisioVera', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 125, 'renatoSilveira', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 125, 'silveiraRenato', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 126, 'roseFrancisco', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 126, 'franciscoRose', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 127, 'kevinFernandes', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 127, 'fernandesKevin', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 128, 'vanessaAssunção', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 128, 'assunçãoVanessa', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 129, 'mauroAssis', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 129, 'assisMauro', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 130, 'carolinaSilva', '@gmail.com', 'A' );

INSERT INTO T_RHSTU_EMAIL_PACIENTE (id_email, id_paciente, ds_email, tp_email, st_email)
VALUES (SQ_RHSTU_EMAIL_PACIENTE.NEXTVAL, 130, 'silvaCarolina', '@gmail.com', 'A' );


--Inserindo na tabela T_RHSTU_PRESCRICAO_MEDICA

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 1, 1, '20 mg a cada 8 horas', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 2, 2, '1 comprimido a cada 6 horas', 'sublingual');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 3, 3, '20 mg uma vez ao dia antes do café da manhã.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 4, 4, '500 mg a cada 12 horas.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 5, 5, '325 mg a cada 4 horas', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 6, 6, '5 mg a cada 8 horas', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 7, 7, '10 mg uma vez ao dia.', 'sublingual');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 8, 8, '10 mg uma vez ao dia, preferência para a noite.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 9, 9, '500 mg duas vezes ao dia', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 10, 10, '20 mg à noite.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 11, 11, '50 mg uma vez ao dia.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 12, 12, '50 mg uma vez ao dia.', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 13, 13, '40 mg uma vez ao dia antes do café da manhã.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 14, 14, '10 mg a cada 8 horas, conforme necessário para náuseas e vômitos.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 15, 15, '50 mg uma vez ao dia, de preferência pela manhã.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 16, 16, '20 mg uma vez ao dia pela manhã.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 17, 17, '1 mg a cada 12 horas', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 18, 18, '50 mg a cada 6 horas', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 19, 19, '10 mg a cada 4 horas, conforme necessário para dor intensa', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 20, 20, '500 mg duas vezes ao dia', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 21, 1, '500 mg por a cada 6 horas.', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 22, 2, '400 mg a cada 8 horas.', 'intramuscular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 23, 3, '40 mg uma vez ao dia.', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 24, 4, '500 mg a cada 12 horas.', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 25, 5, '325 mg a cada 4 horas.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 26, 6, '5 mg a cada 8 horas', 'intramuscular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 27, 7, '10 mg uma vez ao dia.', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 28, 8, '10 mg uma vez ao dia.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 29, 9, '20 mg por à noite.', 'intramuscular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 30, 10, '500 mg duas vezes ao dia', 'sublingual');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 31, 11, '50 mg por uma vez ao dia.', 'intramuscular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 32, 12, '50 mg uma vez ao dia.', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 33, 13, '40 mg uma vez ao dia antes do café da manhã.', 'sublingual');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 34, 14, '10 mg a cada 8 horas, conforme necessário para náuseas e vômitos.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 35, 15, '50 mg por uma vez ao dia', 'intramuscular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 36, 16, '20 mg uma vez ao dia pela manhã.', 'intramuscular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 37, 17, '1 mg a cada 12 horas, para ansiedade.', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 38, 18, '50 mg a cada 6 horas, conforme necessário para dor', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 39, 19, '10 mg a cada 4 horas, para dor intensa.', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 40, 20, '500 mg duas vezes ao dia', 'intramuscular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 41, 1, '500 mg a cada 6 horas.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 42, 2, '200 mg a cada 8 horas', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 43, 3, '20 mg uma vez ao dia.', 'sublingual');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 44, 4, '500 mg a cada 12 horas.', 'intranasal');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 45, 5, '15 gotas a cada 4 horas ', 'oftálmico');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 46, 6, '5 mg a cada 8 horas', 'transdérmico');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 47, 7, '10 mg uma vez ao dia (inalador)', 'inalatório');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 48, 8, '1 comprimido uma vez ao dia ', 'sublingual');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 49, 9, '20 mg à noite.', 'intravaginal');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 50, 10, '45 gotas duas vezes ao dia', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 51, 11, '10 gotas uma vez ao dia (colírio).', 'oftálmico');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 52, 12, '50 mg uma vez ao dia', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 53, 13, '40 mg uma vez ao dia.', 'intranasal');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 54, 14, '30 gotas a cada 8 horas (para uso nos olhos)', 'oftálmico');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 55, 15, '50 mg uma vez ao dia', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 56, 16, '20 mg uma vez ao dia', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 57, 17, '1 mg a cada 12 horas (uso na bexiga)', 'intravesical');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 58, 18, '50 mg a cada 6 horas', 'sublingual');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 59, 19, '10 mg a cada 4 horas (uso em articulações)', 'intraarticular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 60, 20, '500 mg duas vezes ao dia (inalador).', 'inalatório');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 61, 1, '1 comprimido a cada 6 horas.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 62, 2, '400 mg a cada 8 horas.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 63, 3, '40 mg a cada 24 horas.', 'retal');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 64, 4, '500 mg a cada 12 horas.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 65, 5, '325 mg a cada 4 horas', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 66, 6, '5 mg a cada 8 horas (uso em articulações)', 'intraarticular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 67, 7, '10 mg uma vez ao dia (uso no ouvido)', 'intraauricular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 68, 8, '10 mg uma vez ao dia', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 69, 9, '20 mg à noite uso', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 70, 10, '500 mg duas vezes ao dia.', 'intraarticular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 71, 11, '10 mg uma vez ao dia', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 72, 12, '15 gotas antes de dormir', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 73, 13, '50 mg a cada 24 horas', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 74, 14, '50 mg a cada 24 horas ', 'intraarticular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 75, 15, '10 mg a cada 8 horas', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 76, 16, '50 mg uma vez ao dia', 'intravaginal');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 77, 17, '20 gotas a cada 24 horas', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 78, 18, '1 mg a cada 12 horas.', 'sublingual');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 79, 19, '50 mg a cada 6 horas', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 80, 20, '500 mg uma vez ao dia', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 81, 1, '2 comprimidos a cada 6 horas', 'sublingual');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 82, 2, '1 g a cada 6 horas.', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 83, 3, '400 mg a cada 8 horas', 'intramuscular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 84, 4, '40 mg uma vez ao dia antes do café da manhã.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 85, 5, '1 comprimido a cada 12 horas', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 86, 6, '10 mg a cada 8 horas, conforme necessário para ansiedade.', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 87, 7, '10 mg uma vez ao dia.', 'intramuscular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 88, 8, '10 mg uma vez a noite', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 89, 9, '20 mg à noite.', 'sublingual');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 90, 10, '50 mg uma vez ao dia.', 'intramuscular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 91, 11, '50 mg uma vez ao dia.', 'sublingual');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 92, 12, '15 gotas a cada 8 horas em caso de dor', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 93, 13, '40 mg uma vez ao dia antes do café da manhã.', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 94, 14, '10 mg a cada 8 horas, conforme necessário para náuseas e vômitos', 'intramuscular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 95, 15, '5 gotas uma vez ao dia,', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 96, 16, '20 mg uma vez ao dia pela manhã.', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 97, 17, '1 mg a cada 12 horas, conforme necessário para ansiedade', 'sublingual');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 98, 18, '50 mg a cada 6 horas, conforme necessário para dor.', 'intramuscular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 99, 19, '400 mg duas vezes ao dia, com comida.', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 100, 20, '500 mg a cada 6 horas.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 101, 1, '2 comprimidos a cada 8 horas.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 102, 2, '20 mg uma vez ao dia antes do café da manhã.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 103, 3, '500 mg a cada 12 horas.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 104, 4, '325 mg a cada 4 horas, com comida.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 105, 5, '15 gotas a cada 8 horas', 'oftálmico');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 106, 6, '1 comprimidoa cada 8 horas, conforme necessário para insonia', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 107, 7, '10 mg uma vez ao dia', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 108, 8, '10 mg uma vez ao dia, de preferência à noite', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 109, 9, '20 mg à noite.', 'intraveoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 110, 10, '500 mg duas vezes ao dia', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 111, 11, '50 mg uma vez ao dia', 'intraarticular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 112, 12, '20 gotas a cada 6 horas', 'oftálmico');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 113, 13, '50 mg uma vez ao dia.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 114, 14, '1 g a cada 6 horas.', 'intravenosa');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 115, 15, '400 mg a cada 8 horas', 'intramuscular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 116, 16, '40 mg uma vez ao dia', 'intravenoso');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 117, 17, '1 comprimido a cada 12 horas', 'sublingual');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 118, 18, '10 mg a cada 8 horas, conforme necessário para ansiedade.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 119, 19, '10 mg uma vez ao dia', 'intramuscular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 120, 20, '20 mg à noite.', 'sublingual');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 121, 1, '50 mg uma vez ao dia.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 122, 2, '40 mg uma vez ao dia antes do café da manhã.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 123, 3, '10 gotas a cada 8 horas, conforme necessário para náuseas e vômitos.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 124, 4, '50 mg uma vez ao dia', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 125, 5, '10 mg a cada 12 horas, conforme necessário para ansiedade.', 'sublingual');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 126, 6, '50 mg a cada 6 horas, conforme necessário para dor.', 'intramuscular');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 127, 7, '10 mg a cada 4 horas, conforme necessário para dor intensa.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 128, 8, '500 mg a cada 6 horas.', 'oral');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 129, 9, '15 gotas a cada 4 horas', 'oftálmico');

INSERT INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
VALUES (SQ_RHSTU_PRESCRICAO_MEDICA.NEXTVAL, 1, 130, 10, '400 mg a cada 8 horas', 'oral');

COMMIT; 

--2° PARTE (UPDATE)

UPDATE T_RHSTU_FORMA_PAGAMENTO SET  st_forma_pagto = 'I' WHERE  id_forma_pagto = 6;

UPDATE T_RHSTU_TIPO_CONTATO SET dt_fim = TO_DATE ('18/12/2023', 'DD/MM/YYYY') WHERE id_tipo_contato = 5;


--3° PARTE (DELETE)

DELETE FROM T_RHSTU_PACIENTE WHERE id_paciente = 1;
--Não foi possível excluir o paciente de ID 1 pois ele possui uma informação na tabela T_RHSTU_CONTATO_PACIENTE 
--que é dependente dele, ou seja, é uma informação filha da tabela paciente. 
--Apresentando o erro: integrity constraint (RM99768.FK_PACIENTE_CONTATO_EMERG) violated - child record found

DELETE FROM T_RHSTU_TELEFONE_PACIENTE WHERE id_paciente = 2;
--A exclusão do telefone do paciente foi possível sem erros, pois a tabela é independente.  


COMMIT; 


--4° PARTE (INSERT ALL)

INSERT ALL
    INTO T_RHSTU_PACIENTE (id_paciente, nm_paciente, nr_cpf, dt_nascimento, fl_sexo_biologico, ds_escolaridade, ds_estado_civil, nm_grupo_sanguineo, nr_altura, nr_peso)
    VALUES (131, 'Camila Queiroz', 324875960187, TO_DATE('01/01/1999', 'DD/MM/YYYY'), 'F', 'ensino superior', 'solteira', 'O+', 1.70, 68)
    INTO T_RHSTU_MEDICO (cd_medico, nm_medico, nr_crm, ds_especialidade)
    VALUES(24, 'João Silva', 974587, 'cardiologista')
    INTO T_RHSTU_MEDICAMENTO (id_medicamento, nm_medicamento, nr_codigo_barras)
    VALUES (21, 'Vaslip', 365478942105)
    INTO T_RHSTU_CONSULTA (id_unid_hospital, nr_consulta, id_paciente, cd_medico, dt_hr_consulta, nr_consultorio)
    VALUES (1, 131, 131, 24, TO_DATE('31/12/2023 09:00:00', 'DD/MM/YYYY HH24:MI:SS'), 5)
    INTO T_RHSTU_PRESCICAO_MEDICA (id_prescricao_medica, id_unid_hospital, nr_consulta, id_medicamento, ds_posologia, ds_via)
    VALUES (131, 1, 131, 21, '50 mg a cada 8 horas, em caso de dor', 'oral')
    SELECT * FROM DUAL;
    

    

    


