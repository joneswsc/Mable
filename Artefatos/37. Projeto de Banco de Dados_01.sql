/*

IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.ENDERECOPESSOA') )  		DROP TABLE ENDERECOPESSOA;
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.ENDERECO') )				DROP TABLE ENDERECO;
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.PARAMETROS')  )			DROP TABLE PARAMETROS;
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.CONTATO')	)				DROP TABLE DBO.CONTATO 
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.CONTRATO')	)				DROP TABLE DBO.CONTRATO
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.TIPO') )					DROP TABLE DBO.TIPO 
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.CANDIDATO_NECESSIDADE'))	DROP TABLE DBO.CANDIDATO_NECESSIDADE
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.NECESSIDADE') )			DROP TABLE DBO.NECESSIDADE 
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.ACOMPANHAMENTO'))			DROP TABLE DBO.ACOMPANHAMENTO 
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.EMPRESA') )				DROP TABLE DBO.EMPRESA 
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.DOCUMENTO'))				DROP TABLE DBO.DOCUMENTO
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.ALUNO'))					DROP TABLE DBO.ALUNO 
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.CANDIDATO') )				DROP TABLE DBO.CANDIDATO 
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.USUARIO') )				DROP TABLE DBO.USUARIO
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.GRUPOACESSO_PERMISSOES'))	DROP TABLE DBO.GRUPOACESSO_PERMISSOES
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.PERMISSOES') )				DROP TABLE DBO.PERMISSOES
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.GRUPOACESSO'))				DROP TABLE DBO.GRUPOACESSO
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.FUNCIONARIO')	)			DROP TABLE DBO.FUNCIONARIO 
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.PROFISSAO') )				DROP TABLE DBO.PROFISSAO
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.GENERO') )					DROP TABLE DBO.GENERO
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.PESSOA'))					DROP TABLE DBO.PESSOA 
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.UF') )						DROP TABLE DBO.UF
IF EXISTS(SELECT 1 FROM SYSCOLUMNS WHERE ID = OBJECT_ID('DBO.LOCALIDADE'))				DROP TABLE DBO.LOCALIDADE 
*/

CREATE TABLE DBO.UF(
 UF INT IDENTITY(1,1)
,NOME_UF VARCHAR(50)
,SIGLA VARCHAR(15)
)
ALTER TABLE DBO.UF ADD CONSTRAINT PK_UF PRIMARY KEY (UF)

CREATE TABLE DBO.LOCALIDADE(
 LOCALIDADE INT IDENTITY(1,1)
,UF INT
,NOME_LOCALIDADE VARCHAR(100)
)
ALTER TABLE DBO.LOCALIDADE ADD CONSTRAINT PK_LOCALIDADE PRIMARY KEY (LOCALIDADE)


CREATE TABLE DBO.PARAMETROS(
 PARAMETROS INT IDENTITY(1,1)
,PARAMETRO VARCHAR(255)
,VALOR VARCHAR(1000)
,SITUACAO INT
)


CREATE TABLE DBO.TIPO(
 TIPO INT IDENTITY(1,1)
,VALOR INT
,DESCRICAO VARCHAR(255)
,TABELA_ORIGEM VARCHAR(255)
)

CREATE TABLE DBO.PESSOA(
 PESSOA INT IDENTITY(1,1)
,CPF_CNPJ VARCHAR(15)
,RG VARCHAR(150)
,EMAIL VARCHAR(255)
)
ALTER TABLE DBO.PESSOA ADD CONSTRAINT PK_PESSOA PRIMARY KEY (PESSOA)




CREATE TABLE DBO.ENDERECO(
 ENDERECO INT IDENTITY(1,1)
,TIPO VARCHAR(15)
,LOCATARIO VARCHAR(255)
,LOCALIDADE INT
,UF INT
,CEP VARCHAR(11)
,BAIRRO  VARCHAR(100)
,NUMERO VARCHAR(20)
)
ALTER TABLE DBO.ENDERECO ADD CONSTRAINT PK_ENDERECO PRIMARY KEY (ENDERECO)
ALTER TABLE DBO.ENDERECO ADD CONSTRAINT FK_ENDERECO_UF FOREIGN KEY (UF) REFERENCES DBO.UF(UF) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE DBO.ENDERECO ADD CONSTRAINT FK_ENDERECO_LOCALIDADE FOREIGN KEY (LOCALIDADE) REFERENCES DBO.LOCALIDADE(LOCALIDADE) ON DELETE CASCADE ON UPDATE CASCADE
 


CREATE TABLE DBO.ENDERECOPESSOA(
 ENDERECOPESSOA INT IDENTITY(1,1)
,ENDERECO INT
,PESSOA INT
)
ALTER TABLE DBO.ENDERECOPESSOA ADD CONSTRAINT PK_CONTATOENDERECOPESSOA PRIMARY KEY (ENDERECOPESSOA)
ALTER TABLE DBO.ENDERECOPESSOA ADD CONSTRAINT FK_ENDERECOPESSOA_PESSOA FOREIGN KEY (PESSOA) REFERENCES DBO.PESSOA(PESSOA) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE DBO.ENDERECOPESSOA ADD CONSTRAINT FK_ENDERECOPESSOA_ENDERECO FOREIGN KEY (ENDERECO) REFERENCES DBO.ENDERECO(ENDERECO) ON DELETE CASCADE ON UPDATE CASCADE
 
 
CREATE TABLE DBO.CONTATO(
 CONTATO INT IDENTITY(1,1)
,PESSOA INT 
,TIPO INT
,VALOR VARCHAR(255)
)

ALTER TABLE DBO.CONTATO ADD CONSTRAINT PK_CONTATO PRIMARY KEY (CONTATO)
ALTER TABLE DBO.CONTATO ADD CONSTRAINT FK_CONTATO_PESSOA FOREIGN KEY (PESSOA) REFERENCES DBO.PESSOA(PESSOA) ON DELETE CASCADE ON UPDATE CASCADE
 

CREATE TABLE DBO.GENERO(
 GENERO INT IDENTITY 
,DESCRICAO VARCHAR(50)
)
ALTER TABLE DBO.GENERO ADD CONSTRAINT PK_GENERO PRIMARY KEY (GENERO)

CREATE TABLE DBO.CANDIDATO(
 CANDIDATO INT IDENTITY(1,1)
,PESSOA INT
,NOME VARCHAR(255)
,DATA_CADASTRO DATETIME
,DATA_NASCIMENTO DATE
,NOME_PAI VARCHAR(255)
,NOME_MAE VARCHAR(255)
,ETINIA INT
,GENERO INT
)
ALTER TABLE DBO.CANDIDATO ADD CONSTRAINT PK_CANDIDATO PRIMARY KEY (CANDIDATO)
ALTER TABLE DBO.CANDIDATO ADD CONSTRAINT FK_CANDIDATO_PESSOA FOREIGN KEY (PESSOA) REFERENCES DBO.PESSOA(PESSOA) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE DBO.CANDIDATO ADD CONSTRAINT FK_CANDIDATO_GENERO FOREIGN KEY (GENERO) REFERENCES DBO.GENERO(GENERO) ON DELETE CASCADE ON UPDATE CASCADE



CREATE TABLE DBO.NECESSIDADE(
 NECESSIDADE INT IDENTITY(1,1)
,ATIVA INT
,DESCRICAO VARCHAR(255)
)
ALTER TABLE DBO.NECESSIDADE ADD CONSTRAINT PK_NECESSIDADE PRIMARY KEY (NECESSIDADE)



CREATE TABLE DBO.CANDIDATO_NECESSIDADE(
 CANDIDATO_NECESSIDADE INT IDENTITY (1,1)
,NECESSIDADE INT 
,CANDIDATO INT
)
ALTER TABLE DBO.CANDIDATO_NECESSIDADE ADD CONSTRAINT PK_CANDIDATO_NECESSIDADE PRIMARY KEY (CANDIDATO_NECESSIDADE)
ALTER TABLE DBO.CANDIDATO_NECESSIDADE ADD CONSTRAINT FK_CANDIDATO_NECESSIDADE_CANDIDATO FOREIGN KEY (CANDIDATO) REFERENCES DBO.CANDIDATO(CANDIDATO) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE DBO.CANDIDATO_NECESSIDADE ADD CONSTRAINT FK_CANDIDATO_NECESSIDADE_NECESSIDADE FOREIGN KEY (NECESSIDADE) REFERENCES DBO.NECESSIDADE(NECESSIDADE) ON DELETE CASCADE ON UPDATE CASCADE


CREATE TABLE DBO.ALUNO(
 ALUNO INT IDENTITY(1,1)
,CANDIDATO INT
,MATRICULA INT
,DATA_MATRICULA DATETIME
,SITUACAO INT
)
ALTER TABLE DBO.ALUNO ADD CONSTRAINT PK_ALUNO PRIMARY KEY (ALUNO)
ALTER TABLE DBO.ALUNO ADD CONSTRAINT FK_ALUNO_CANDIDATO FOREIGN KEY (CANDIDATO) REFERENCES DBO.CANDIDATO(CANDIDATO) ON DELETE CASCADE ON UPDATE CASCADE


CREATE TABLE DOCUMENTO(
 DOCUMENTO INT IDENTITY(1,1)
,ANEXO VARCHAR(MAX)
,DATAANEXO DATETIME
,ALUNO INT
)
ALTER TABLE DBO.DOCUMENTO ADD CONSTRAINT PK_DOCUMENTO PRIMARY KEY (DOCUMENTO)
ALTER TABLE DBO.DOCUMENTO ADD CONSTRAINT FK_ALUNO_DOCUMENTO FOREIGN KEY (ALUNO) REFERENCES DBO.ALUNO(ALUNO) ON DELETE CASCADE ON UPDATE CASCADE


CREATE TABLE DBO.PROFISSAO(
 PROFISSAO INT IDENTITY(1,1)
,DESCRICAO VARCHAR(255)
)
ALTER TABLE DBO.PROFISSAO ADD CONSTRAINT PK_PROFISSAO PRIMARY KEY (PROFISSAO)

CREATE TABLE DBO.FUNCIONARIO(
 FUNCIONARIO INT IDENTITY(1,1)
,PESSOA INT
,ADMISSAO DATETIME
,DEMISSAO DATETIME
,PROFISSAO INT
,NOME VARCHAR(255)
,DTNASCIMENTO DATETIME
)
ALTER TABLE DBO.FUNCIONARIO ADD CONSTRAINT PK_FUNCIONARIO PRIMARY KEY (FUNCIONARIO)
ALTER TABLE DBO.FUNCIONARIO ADD CONSTRAINT FK_FUNCIONARIO_PROFISSAO FOREIGN KEY (PROFISSAO) REFERENCES DBO.PROFISSAO(PROFISSAO) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE DBO.FUNCIONARIO ADD CONSTRAINT FK_FUNCIONARIO_PESSOA FOREIGN KEY (PESSOA) REFERENCES DBO.PESSOA(PESSOA) ON DELETE CASCADE ON UPDATE CASCADE




CREATE TABLE DBO.EMPRESA(
 EMPRESA INT IDENTITY(1,1)
,PESSOA INT
,RAZAO VARCHAR(255)
,FANTASIA VARCHAR(255)
)
ALTER TABLE DBO.EMPRESA ADD CONSTRAINT PK_EMPRESA PRIMARY KEY (EMPRESA)
ALTER TABLE DBO.EMPRESA ADD CONSTRAINT FK_EMPRESA_PESSOA FOREIGN KEY (PESSOA) REFERENCES DBO.PESSOA(PESSOA) ON DELETE CASCADE ON UPDATE CASCADE





CREATE TABLE DBO.CONTRATO(
 CONTRATO INT IDENTITY(1,1)
,ALUNO INT
,EMPRESA INT
,DATA_ADMISSAO DATETIME
,OBSERVACOES VARCHAR(MAX)
)
ALTER TABLE DBO.CONTRATO ADD CONSTRAINT PK_CONTRATO PRIMARY KEY (CONTRATO)
ALTER TABLE DBO.CONTRATO ADD CONSTRAINT FK_CONTRATO_ALUNO FOREIGN KEY (ALUNO) REFERENCES DBO.ALUNO(ALUNO) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE DBO.CONTRATO ADD CONSTRAINT FK_CONTRATO_EMPRESA FOREIGN KEY (EMPRESA) REFERENCES DBO.EMPRESA(EMPRESA) --ON DELETE CASCADE ON UPDATE CASCADE



CREATE TABLE DBO.GRUPOACESSO(
 GRUPOACESSO INT IDENTITY(1,1)
,NOME VARCHAR(100)
)
ALTER TABLE DBO.GRUPOACESSO ADD CONSTRAINT PK_GRUPOACESSO PRIMARY KEY (GRUPOACESSO)

CREATE TABLE DBO.PERMISSOES(
 PERMISSOES INT IDENTITY(1,1)
,TIPO INT  -- 0 = TELA / 1 = BOTAO / 2 = ????
,NOME VARCHAR(255)  -- EX. Cadastro de aluno
,COMPONENTE VARCHAR(255) -- uCadAluno 
,SITUACAO INT  -- Ativo ou inativa recurso
)
ALTER TABLE DBO.PERMISSOES ADD CONSTRAINT PK_PERMISSOES PRIMARY KEY (PERMISSOES)


CREATE TABLE DBO.GRUPOACESSO_PERMISSOES(
 GRUPOACESSO_PERMISSOES INT IDENTITY(1,1)
,GRUPOACESSO INT
,PERMISSOES INT
)
ALTER TABLE DBO.GRUPOACESSO_PERMISSOES ADD CONSTRAINT PK_GRUPOACESSO_PERMISSOES PRIMARY KEY (GRUPOACESSO_PERMISSOES)
ALTER TABLE DBO.GRUPOACESSO_PERMISSOES ADD CONSTRAINT FK_GRUPOACESSO_PERMISSOES_GRUPOACESSO FOREIGN KEY (GRUPOACESSO) REFERENCES DBO.GRUPOACESSO(GRUPOACESSO) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE DBO.GRUPOACESSO_PERMISSOES ADD CONSTRAINT FK_GRUPOACESSO_PERMISSOES_PERMISSOES FOREIGN KEY (PERMISSOES) REFERENCES DBO.PERMISSOES(PERMISSOES) ON DELETE CASCADE ON UPDATE CASCADE



CREATE TABLE DBO.USUARIO(
 USUARIO INT IDENTITY(1,1)
,USR_LOGIN VARCHAR(100)
,USR_SENHA VARCHAR(100)
,PESSOA INT
,GRUPOACESSO INT
,FUNCIONARIO INT
,SITUACAO INT
)
ALTER TABLE DBO.USUARIO ADD CONSTRAINT PK_USUARIO PRIMARY KEY (USUARIO)
ALTER TABLE DBO.USUARIO ADD CONSTRAINT FK_USUARIO_GRUPOACESSO FOREIGN KEY (GRUPOACESSO) REFERENCES DBO.GRUPOACESSO(GRUPOACESSO) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE DBO.USUARIO ADD CONSTRAINT FK_USUARIO_FUNCIONARIO FOREIGN KEY (FUNCIONARIO) REFERENCES DBO.FUNCIONARIO(FUNCIONARIO) ON DELETE CASCADE ON UPDATE CASCADE



CREATE TABLE DBO.ACOMPANHAMENTO(
 ACOMPANHAMENTO INT IDENTITY(1,1)
,ALUNO INT
,FUNCIONARIO INT
,DATA DATETIME
,DATARETORNO DATETIME
,OBSERVACOES VARCHAR(500)
)
ALTER TABLE DBO.ACOMPANHAMENTO ADD CONSTRAINT PK_ACOMPANHAMENTO PRIMARY KEY (ACOMPANHAMENTO)
ALTER TABLE DBO.ACOMPANHAMENTO ADD CONSTRAINT FK_ACOMPANHAMENTO_ALUNO FOREIGN KEY (ALUNO) REFERENCES DBO.ALUNO(ALUNO) ON DELETE CASCADE ON UPDATE CASCADE
ALTER TABLE DBO.ACOMPANHAMENTO ADD CONSTRAINT FK_ACOMPANHAMENTO_FUNCIONARIO FOREIGN KEY (FUNCIONARIO) REFERENCES DBO.FUNCIONARIO(FUNCIONARIO) --ON DELETE CASCADE ON UPDATE CASCADE

