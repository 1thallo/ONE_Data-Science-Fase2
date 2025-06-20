DROP DATABASE IF EXISTS DB_ONE;
CREATE DATABASE DB_ONE;
USE DB_ONE;

-- Tabela: ONETB003_DEPARTAMENTO
DROP TABLE IF EXISTS ONETB003_DEPARTAMENTO;
CREATE TABLE ONETB003_DEPARTAMENTO (
   ID_DEPARTAMENTO INT(5) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único serial do departamento.',
   ID_GERENTE INT(5) NOT NULL COMMENT 'Identificador único do colaborador que é gerente do departamento.',
   NO_DEPARTAMENTO VARCHAR(150) NOT NULL COMMENT 'Nome do departamento.',
   NR_DEPARTAMENTO INT(10) NOT NULL COMMENT 'Número do departamento.',
  CONSTRAINT PK_ONETB003 PRIMARY KEY (ID_DEPARTAMENTO)
) COMMENT='Armazena dados sobre os departamentos.';

-- Tabela: ONETB001_COLABORADOR
DROP TABLE IF EXISTS ONETB001_COLABORADOR;
CREATE TABLE ONETB001_COLABORADOR (
   ID_COLABORADOR INT(5) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único serial do Colaborador.',
   ID_DEPARTAMENTO INT(5) NULL COMMENT 'Identificador único opcional do departamento do colaborador.',
   NR_CPF_COLABORADOR CHAR(11) NOT NULL COMMENT 'Número do CPF do colaborador.',
   NO_COLABORADOR VARCHAR(200) NOT NULL COMMENT 'Nome do Colaborador.',
   VL_SALARIO DECIMAL(10,2) NOT NULL COMMENT 'Valor do salário do Colaborador.',
   NO_CARGO VARCHAR(100) NOT NULL COMMENT 'Cargo do Colaborador.',
   NR_TELEFONE_COLABORADOR VARCHAR(20) NOT NULL COMMENT 'Número de telefone do Colaborador',
   EE_COLABORADOR VARCHAR(50) NOT NULL COMMENT 'Email eletrônico do Colaborador.',
  CONSTRAINT PK_ONETB001 PRIMARY KEY (ID_COLABORADOR),
  CONSTRAINT UK01_ONETB001 UNIQUE (NR_CPF_COLABORADOR, NO_COLABORADOR)
) COMMENT='Armazena dados sobre os colaboradores.';

-- Tabela: ONETB002_CLIENTE
DROP TABLE IF EXISTS ONETB002_CLIENTE;
CREATE TABLE ONETB002_CLIENTE (
   ID_CLIENTE BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único serial do Cliente.',
   ID_COLABORADOR INT(5) NULL COMMENT 'Identificador único opcional do Colaborador.',
   NR_CPF_CLIENTE CHAR(11) NOT NULL COMMENT 'Número do CPF do Cliente.',
   NO_CLIENTE VARCHAR(100) NOT NULL COMMENT 'Nome do Cliente.',
   ED_COMPLETO VARCHAR(500) NOT NULL COMMENT 'Endereço completo do Cliente.',
   DT_NASCIMENTO DATE NOT NULL COMMENT 'Data de Nascimento do Cliente.',
   NR_TELEFONE_CLIENTE VARCHAR(20) NOT NULL COMMENT 'Número de telefone do Cliente.',
  CONSTRAINT PK_ONETB002 PRIMARY KEY (ID_CLIENTE),
  CONSTRAINT UK01_ONETB002 UNIQUE (NR_CPF_CLIENTE, NO_CLIENTE),
  CONSTRAINT FK01_ONETB002_ONETB001 FOREIGN KEY (ID_COLABORADOR)
    REFERENCES ONETB001_COLABORADOR (ID_COLABORADOR)
) COMMENT='Armazena dados sobre os clientes.';

-- Tabela: ONETB004_SCORE
DROP TABLE IF EXISTS ONETB004_SCORE;
CREATE TABLE ONETB004_SCORE (
   ID_SCORE INT(10) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único serial do Score.',
   ID_CLIENTE BIGINT(20) NOT NULL COMMENT 'Identificador único do cliente.',
   QT_PONTOS DECIMAL(15,0) NOT NULL COMMENT 'Pontuação referente ao Score.',
   NO_FONTE VARCHAR(50) NOT NULL COMMENT 'Nome da fonte.',
   TX_JUSTIFICATIVA VARCHAR(400) NULL COMMENT 'Descrição textual da justificativa.',
   DT_CONSULTA DATE NOT NULL COMMENT 'Data da consulta ao Score.',
  CONSTRAINT PK_ONETB004 PRIMARY KEY (ID_SCORE),
  CONSTRAINT FK01_ONETB004_ONETB002 FOREIGN KEY (ID_CLIENTE)
    REFERENCES ONETB002_CLIENTE (ID_CLIENTE)
) COMMENT='Armazena dados sobre as consultas ao score do cliente.';

-- Tabela: ONETB005_CONTA
DROP TABLE IF EXISTS ONETB005_CONTA;
CREATE TABLE ONETB005_CONTA (
   ID_CONTA INT(10) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único serial da conta.',
   NR_CONTA INT(5) NOT NULL COMMENT 'Número da conta.',
   IC_TIPO_CONTA CHAR(1) NOT NULL COMMENT 'Indicador do tipo de conta: C - Conta Corrente; P - Conta Poupança',
   VL_SALDO DECIMAL(10,3) NOT NULL COMMENT 'Valor do saldo da conta.',
   DT_ABERTURA DATE NOT NULL COMMENT 'Data de abertura da conta.',
  CONSTRAINT PK_ONETB005 PRIMARY KEY (ID_CONTA),
  CONSTRAINT UK01_ONETB005 UNIQUE (NR_CONTA),
  CONSTRAINT CC01_ONETB005 CHECK (IC_TIPO_CONTA IN ('C','P'))
) COMMENT='Armazena dados sobre as contas.';

-- Tabela: ONETB006_EMPRESTIMO
DROP TABLE IF EXISTS ONETB006_EMPRESTIMO;
CREATE TABLE ONETB006_EMPRESTIMO (
   ID_EMPRESTIMO INT(10) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único serial do empréstimo.',
   ID_CLIENTE BIGINT(20) NULL COMMENT 'Identificador único opcional do cliente que fez o empréstimo.',
   VL_EMPRESTIMO DECIMAL(15,3) NOT NULL COMMENT 'Valor do empréstimo.',
   DT_PRAZO DATE NOT NULL COMMENT 'Data do prazo limite do Empréstimo.',
   DT_INICIO DATE NOT NULL COMMENT 'Data de início do empréstimo.',
   IC_TIPO_EMPRESTIMO CHAR(1) NOT NULL DEFAULT 'P' COMMENT 'Indicador do tipo do Empréstimo: E - Empresarial; I - Imobiliário; P - Pessoal',
   IC_STATUS CHAR(1) NOT NULL COMMENT 'Indicador do status do Empréstimo: E - Em Dia; A - Atrasado',
  CONSTRAINT PK_ONETB006 PRIMARY KEY (ID_EMPRESTIMO),
  CONSTRAINT CC01_ONETB006 CHECK (IC_TIPO_EMPRESTIMO IN ('E','I','P')),
  CONSTRAINT CC02_ONETB006 CHECK (IC_STATUS IN ('E','A')),
  CONSTRAINT FK01_ONETB006_ONETB002 FOREIGN KEY (ID_CLIENTE)
    REFERENCES ONETB002_CLIENTE (ID_CLIENTE)
)COMMENT='Armazena dados sobre os empréstimos feitos.';

-- Tabela: ONETB007_PAGAMENTO
DROP TABLE IF EXISTS ONETB007_PAGAMENTO;
CREATE TABLE ONETB007_PAGAMENTO (
   ID_PAGAMENTO INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único serial do Pagamento.',
   ID_EMPRESTIMO INT(10) NULL COMMENT 'Identificador único opcional do empréstimo.',
   VL_PAGAMENTO DECIMAL(20,4) NOT NULL COMMENT 'Valor efetuado do pagamento.',
   DT_PAGAMENTO DATE NOT NULL COMMENT 'Data do pagamento.',
   IC_STATUS_PAGAMENTO CHAR(1) NOT NULL COMMENT 'Indicador do status do pagamento: A - Atrasado; P - Pago',
  CONSTRAINT PK_ONETB007 PRIMARY KEY (ID_PAGAMENTO),
  CONSTRAINT CC01_ONETB007 CHECK (IC_STATUS_PAGAMENTO IN ('A','P')),
  CONSTRAINT FK01_ONETB007_ONETB006 FOREIGN KEY (ID_EMPRESTIMO)
    REFERENCES ONETB006_EMPRESTIMO (ID_EMPRESTIMO)
) COMMENT='Armazena dados sobre os pagamentos.';

-- Tabela: ONETB008_CLIENTE_CONTA
DROP TABLE IF EXISTS ONETB008_CLIENTE_CONTA;
CREATE TABLE ONETB008_CLIENTE_CONTA (
   ID_CLIENTE BIGINT(20) NOT NULL COMMENT 'Identificador único do cliente.',
   ID_CONTA INT(10) NOT NULL COMMENT 'Identificador único da conta.',
  CONSTRAINT PK_ONETB008  PRIMARY KEY (ID_CLIENTE, ID_CONTA),
  CONSTRAINT FK01_ONETB008_ONETB002  FOREIGN KEY (ID_CLIENTE)
    REFERENCES ONETB002_CLIENTE  (ID_CLIENTE),
  CONSTRAINT FK02_ONETB008_ONETB005  FOREIGN KEY (ID_CONTA)
    REFERENCES ONETB005_CONTA  (ID_CONTA)
) COMMENT='Tabela associativa para armazenar clientes e contas.';

-- Tabela: ONETB009_TELEFONE_CLIENTE
DROP TABLE IF EXISTS ONETB009_TELEFONE_CLIENTE;
CREATE TABLE ONETB009_TELEFONE_CLIENTE (
   ID_TELEFONE TINYINT(3) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único serial do Telefone do Cliente (max: 2)',
   ID_CLIENTE BIGINT(20) NOT NULL COMMENT 'Identificador único do Cliente.',
   NR_TELEFONE VARCHAR(20) NOT NULL COMMENT 'Número de telefone do Cliente.',
  CONSTRAINT PK_ONETB009 PRIMARY KEY (ID_TELEFONE),
  CONSTRAINT FK01_ONETB009_ONETB002 FOREIGN KEY (ID_CLIENTE)
    REFERENCES ONETB002_CLIENTE (ID_CLIENTE)
) COMMENT='Armazena dados sobre os telefones do cliente, deve ser no máximo 2.';

ALTER TABLE ONETB001_COLABORADOR
	ADD CONSTRAINT FK01_ONETB001_ONETB003 FOREIGN KEY (ID_DEPARTAMENTO)
    REFERENCES ONETB003_DEPARTAMENTO (ID_DEPARTAMENTO);

ALTER TABLE ONETB003_DEPARTAMENTO
	ADD CONSTRAINT FK01_ONETB003_ONETB001 FOREIGN KEY (ID_GERENTE)
    REFERENCES ONETB001_COLABORADOR (ID_COLABORADOR);
