
-- Tabelas principais com melhorias e novas entidades

CREATE TABLE Usuario (
    id_usuario SERIAL PRIMARY KEY,
    login VARCHAR(50) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo_usuario VARCHAR(20) NOT NULL,
    id_professor INT,
    id_responsavel INT,
    CONSTRAINT fk_usuario_professor FOREIGN KEY (id_professor) REFERENCES Professor(id_professor),
    CONSTRAINT fk_usuario_responsavel FOREIGN KEY (id_responsavel) REFERENCES Responsavel(id_responsavel)
);

CREATE TABLE Professor (
    id_professor SERIAL PRIMARY KEY,
    nome_completo VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    habilidades TEXT,
    certificacoes TEXT
);

CREATE TABLE Responsavel (
    id_responsavel SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    permissao VARCHAR(50),
    situacao_financeira VARCHAR(20)
);

CREATE TABLE Turma (
    id_turma SERIAL PRIMARY KEY,
    nome_turma VARCHAR(50),
    id_professor INT REFERENCES Professor(id_professor),
    horario VARCHAR(100),
    local VARCHAR(100)
);

CREATE TABLE Aluno (
    id_aluno SERIAL PRIMARY KEY,
    nome_completo VARCHAR(255),
    data_nascimento DATE,
    id_turma INT REFERENCES Turma(id_turma),
    id_responsavel INT REFERENCES Responsavel(id_responsavel),
    observacoes TEXT,
    status_financeiro VARCHAR(20)
);

CREATE TABLE Presenca (
    id_presenca SERIAL PRIMARY KEY,
    id_aluno INT REFERENCES Aluno(id_aluno),
    data DATE,
    presente BOOLEAN
);

CREATE TABLE Pagamento (
    id_pagamento SERIAL PRIMARY KEY,
    id_aluno INT REFERENCES Aluno(id_aluno),
    data_pagamento DATE,
    valor DECIMAL(10,2),
    forma_pagamento VARCHAR(50),
    referencia VARCHAR(100),
    status VARCHAR(20),
    tipo VARCHAR(50)
);

CREATE TABLE Caixa (
    id_caixa SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES Usuario(id_usuario),
    data_abertura TIMESTAMP,
    saldo_inicial DECIMAL(10,2),
    data_fechamento TIMESTAMP,
    saldo_final DECIMAL(10,2)
);

CREATE TABLE Log_Sistema (
    id_log SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES Usuario(id_usuario),
    data_hora TIMESTAMP,
    tipo_acao VARCHAR(50),
    entidade_afetada VARCHAR(50),
    descricao TEXT
);

CREATE TABLE Cardapio (
    id_cardapio SERIAL PRIMARY KEY,
    data DATE,
    turno VARCHAR(20),
    titulo VARCHAR(100),
    id_turma INT REFERENCES Turma(id_turma)
);

CREATE TABLE Item_Cardapio (
    id_item SERIAL PRIMARY KEY,
    id_cardapio INT REFERENCES Cardapio(id_cardapio),
    descricao VARCHAR(255)
);

CREATE TABLE Tag_Atencao (
    id_tag SERIAL PRIMARY KEY,
    id_aluno INT REFERENCES Aluno(id_aluno),
    tipo VARCHAR(50),
    descricao TEXT
);

CREATE TABLE Evento (
    id_evento SERIAL PRIMARY KEY,
    titulo VARCHAR(100),
    descricao TEXT,
    data_inicio DATE,
    data_fim DATE,
    publico VARCHAR(50),
    id_usuario INT REFERENCES Usuario(id_usuario)
);

CREATE TABLE Material (
    id_material SERIAL PRIMARY KEY,
    titulo VARCHAR(100),
    descricao TEXT,
    data_upload DATE,
    tipo VARCHAR(50),
    url TEXT,
    id_usuario INT REFERENCES Usuario(id_usuario)
);

CREATE TABLE Horario (
    id_horario SERIAL PRIMARY KEY,
    id_turma INT REFERENCES Turma(id_turma),
    dia_semana VARCHAR(20),
    horario_inicio TIME,
    horario_fim TIME
);

CREATE TABLE Comunicado (
    id_comunicado SERIAL PRIMARY KEY,
    titulo VARCHAR(100),
    descricao TEXT,
    data_envio DATE,
    publico VARCHAR(50),
    id_usuario INT REFERENCES Usuario(id_usuario)
);

CREATE TABLE Relatorio (
    id_relatorio SERIAL PRIMARY KEY,
    tipo VARCHAR(50),
    periodo VARCHAR(50),
    data_geracao DATE,
    id_usuario INT REFERENCES Usuario(id_usuario)
);

CREATE TABLE Fa_Coin (
    id_coin SERIAL PRIMARY KEY,
    id_responsavel INT REFERENCES Responsavel(id_responsavel),
    origem VARCHAR(50),
    valor DECIMAL(10,2),
    data_credito DATE,
    motivo TEXT
);

CREATE TABLE Atividade (
    id_atividade SERIAL PRIMARY KEY,
    descricao TEXT,
    data_realizacao DATE
);

CREATE TABLE Atividade_Aluno (
    id_atividade INT REFERENCES Atividade(id_atividade),
    id_aluno INT REFERENCES Aluno(id_aluno),
    PRIMARY KEY (id_atividade, id_aluno)
);
