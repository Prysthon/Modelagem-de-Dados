-- Drop tables if they already exist to ensure a clean setup
DROP TABLE IF EXISTS Avaliacao;
DROP TABLE IF EXISTS Feedback;
DROP TABLE IF EXISTS Atendimento;
DROP TABLE IF EXISTS Agendamento;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS TP_Avaliacao;
DROP TABLE IF EXISTS Profissional_Credencial;
DROP TABLE IF EXISTS Credencial;
DROP TABLE IF EXISTS Profissional;
DROP TABLE IF EXISTS Telefone;
DROP TABLE IF EXISTS Endereco;
DROP TABLE IF EXISTS Usuario;
DROP TABLE IF EXISTS Cidade;
DROP TABLE IF EXISTS UF;

-- Tabela UF
CREATE TABLE UF (
  id_UF INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
  sigla VARCHAR(250) NOT NULL
);

-- Tabela Cidade
CREATE TABLE Cidade (
  id_Cidade INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
  id_UF INT,
  FOREIGN KEY (id_UF) REFERENCES UF(id_UF)
);

-- Tabela Usuario
CREATE TABLE Usuario (
  id_Usuario INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
  Nome VARCHAR(50) NOT NULL,
  CPF VARCHAR(11) UNIQUE NOT NULL,
  Data_Nascimento DATE NOT NULL
);

-- Tabela Endereco
CREATE TABLE Endereco (
  id_Endereco INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
  id_Cidade INT,
  CEP INT(8) NOT NULL,
  Bairro VARCHAR(50) NOT NULL,
  Rua VARCHAR(100) NOT NULL,
  Numero INT(5) NOT NULL,
  Complemento VARCHAR(250),
  id_Usuario INT,
  FOREIGN KEY (id_Cidade) REFERENCES Cidade(id_Cidade),
  FOREIGN KEY (id_Usuario) REFERENCES Usuario(id_Usuario)
);

-- Tabela Telefone
CREATE TABLE Telefone (
  id_Telefone INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
  Numero VARCHAR(15) UNIQUE NOT NULL,
  id_Usuario INT,
  FOREIGN KEY (id_Usuario) REFERENCES Usuario(id_Usuario)
);

-- Tabela Profissional
CREATE TABLE Profissional (
  id_Profissional INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
  id_Usuario INT,
  Data_Admissao_Profissional DATE NOT NULL,
  FOREIGN KEY (id_Usuario) REFERENCES Usuario(id_Usuario)
);

-- Tabela Credencial
CREATE TABLE Credencial (
  id_Credencial INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
  Credencial VARCHAR(100) UNIQUE NOT NULL
);

-- Tabela Profissional_Credencial
CREATE TABLE Profissional_Credencial (
  id_Profissional_Credencial INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
  id_Profissional INT,
  id_Credencial INT,
  Codigo VARCHAR(50) NOT NULL,
  FOREIGN KEY (id_Profissional) REFERENCES Profissional(id_Profissional),
  FOREIGN KEY (id_Credencial) REFERENCES Credencial(id_Credencial)
);

-- Tabela TP_Avaliacao
CREATE TABLE TP_Avaliacao (
  id_TP_Avaliacao INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
  Descricao VARCHAR(250) NOT NULL
);

-- Tabela Cliente
CREATE TABLE Cliente (
  id_Cliente INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
  id_Usuario INT,
  Data_Admissao_Cliente DATE NOT NULL,
  FOREIGN KEY (id_Usuario) REFERENCES Usuario(id_Usuario)
);

-- Tabela Agendamento
CREATE TABLE Agendamento (
  id_Agendamento INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
  id_Cliente INT,
  id_Profissional INT,
  data_Agendamento DATETIME NOT NULL,
  Preco DECIMAL(10,2) NOT NULL,
  Status_Pagamento VARCHAR(50),
  Data_Transacao DATETIME,
  Status_Transacao VARCHAR(50),
  Cancelado BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (id_Cliente) REFERENCES Cliente(id_Cliente),
  FOREIGN KEY (id_Profissional) REFERENCES Profissional(id_Profissional)
);

-- Tabela Atendimento
CREATE TABLE Atendimento (
  id_Atendimento INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
  id_Agendamento INT,
  data_Atendimento DATETIME,
  FOREIGN KEY (id_Agendamento) REFERENCES Agendamento(id_Agendamento)
);

-- Tabela Feedback
CREATE TABLE Feedback (
  id_Feedback INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
  id_Atendimento INT,
  Atendimento_Nota INT,
  FOREIGN KEY (id_Atendimento) REFERENCES Atendimento(id_Atendimento)
);

-- Tabela Avaliacao
CREATE TABLE Avaliacao (
  id_Avaliacao INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
  id_TP_Avaliacao INT,
  id_Atendimento INT,
  Descricao VARCHAR(250) NOT NULL,
  FOREIGN KEY (id_TP_Avaliacao) REFERENCES TP_Avaliacao(id_TP_Avaliacao),
  FOREIGN KEY (id_Atendimento) REFERENCES Atendimento(id_Atendimento)
);

-- Inserindo dados na tabela UF
INSERT INTO UF (sigla) VALUES
('SP'),
('RJ'),
('MG'),
('BA'),
('RS');

-- Inserindo dados na tabela Cidade
INSERT INTO Cidade (id_UF) VALUES
(1), -- Cidade associada ao UF 'SP'
(2), -- Cidade associada ao UF 'RJ'
(3), -- Cidade associada ao UF 'MG'
(4), -- Cidade associada ao UF 'BA'
(5); -- Cidade associada ao UF 'RS'

-- Inserir as credenciais corretas
INSERT INTO Credencial (Credencial) VALUES
('Fisiculturista'),
('Nutricionista'),
('Personal');

-- Inserindo usuários (profissionais e clientes)
INSERT INTO Usuario (Nome, CPF, Data_Nascimento) VALUES
('João da Silva', '12345678901', '1980-01-01'),
('Maria Oliveira', '90123456789', '1989-09-09'),
('Rafael Costa', '67890123456', '1982-06-06'),
('Fernanda Souza', '78901234567', '1985-07-07'),
('Ricardo Pereira', '89012345678', '1987-08-08'),
('DBA', '99900000001', '1990-04-01'),
('Jordan', '99900000002', '1990-04-02'),
('Dodói', '99900000003', '1990-04-03'),
('Estagiário', '99900000004', '1990-04-04'),
('sem apelido', '99900000005', '1990-04-05'),
('Lionel Messi', '12345123451', '1987-06-24'),
('Cristiano Ronaldo Aveiro', '23456234562', '1985-02-05'),
('Lucas Paquetá', '34567345673', '1997-08-27'),
('Carlos Eduardo', '45678456784', '1990-01-15'),
('Carlos Santos', '99999999901', '1991-01-01'),
('Ana Costa', '99999999902', '1992-02-02'),
('Dr. Carlos', '88888888801', '1980-05-01'),
('Dra. Ana', '88888888802', '1981-06-01'),
('Dr. Pedro', '88888888803', '1982-07-01');

-- Inserindo profissionais na tabela Profissional
INSERT INTO Profissional (id_Usuario, Data_Admissao_Profissional) VALUES
((SELECT id_Usuario FROM Usuario WHERE Nome = 'João da Silva'), '2020-01-15'),
((SELECT id_Usuario FROM Usuario WHERE Nome = 'Maria Oliveira'), '2020-09-15'),
((SELECT id_Usuario FROM Usuario WHERE Nome = 'Rafael Costa'), '2020-06-15'),
((SELECT id_Usuario FROM Usuario WHERE Nome = 'Fernanda Souza'), '2020-07-15'),
((SELECT id_Usuario FROM Usuario WHERE Nome = 'Ricardo Pereira'), '2020-08-15'),
((SELECT id_Usuario FROM Usuario WHERE Nome = 'DBA'), '2023-05-14'),
((SELECT id_Usuario FROM Usuario WHERE Nome = 'Jordan'), '2023-12-18'),
((SELECT id_Usuario FROM Usuario WHERE Nome = 'Dodói'), '2023-11-03'),
((SELECT id_Usuario FROM Usuario WHERE Nome = 'Estagiário'), '2023-11-05'),
((SELECT id_Usuario FROM Usuario WHERE Nome = 'sem apelido'), '2023-09-18'),
((SELECT id_Usuario FROM Usuario WHERE Nome = 'Dr. Carlos'), '2020-05-01'),
((SELECT id_Usuario FROM Usuario WHERE Nome = 'Dra. Ana'), '2020-06-01'),
((SELECT id_Usuario FROM Usuario WHERE Nome = 'Dr. Pedro'), '2020-07-01');

-- Inserindo credenciais para os profissionais
INSERT INTO Profissional_Credencial (id_Profissional, id_Credencial, Codigo) VALUES
((SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'João da Silva')), 1, 'FIS12345'),
((SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Maria Oliveira')), 2, 'NUT23456'),
((SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Rafael Costa')), 3, 'PER34567'),
((SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Fernanda Souza')), 1, 'FIS45678'),
((SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Ricardo Pereira')), 2, 'NUT56789'),
((SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'DBA')), 3, 'PER67890'),
((SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Jordan')), 1, 'FIS78901'),
((SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Dodói')), 2, 'NUT89012'),
((SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Estagiário')), 3, 'PER90123'),
((SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'sem apelido')), 1, 'FIS01234'),
((SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Dr. Carlos')), 1, 'FIS11223'),
((SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Dra. Ana')), 2, 'NUT22334'),
((SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Dr. Pedro')), 3, 'PER33445');

-- Inserindo clientes para João da Silva
INSERT INTO Usuario (Nome, CPF, Data_Nascimento)
SELECT CONCAT('Cliente_Joao_', seq) AS Nome, CONCAT('100000000', LPAD(seq, 2, '0')) AS CPF, '1990-01-01'
FROM (
    SELECT seq FROM (
        SELECT 1 AS seq UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
        UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
        UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15
        UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL SELECT 20
        UNION ALL SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24 UNION ALL SELECT 25
    ) AS numbers
) AS seq_table;

INSERT INTO Cliente (id_Usuario, Data_Admissao_Cliente)
SELECT id_Usuario, '2022-01-01' FROM Usuario WHERE Nome LIKE 'Cliente_Joao_%';

-- Inserindo agendamentos para João da Silva
INSERT INTO Agendamento (id_Cliente, id_Profissional, data_Agendamento, Preco)
SELECT 
    (SELECT id_Cliente FROM Cliente WHERE id_Usuario = data.id_Usuario),
    (SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'João da Silva')),
    DATE_ADD('2024-01-01', INTERVAL data.seq DAY),
    100
FROM (
    SELECT seq, u.id_Usuario FROM (
        SELECT seq FROM (
            SELECT 1 AS seq UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
            UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
            UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15
            UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL SELECT 20
            UNION ALL SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24 UNION ALL SELECT 25
        ) AS numbers
    ) AS seq_table
    JOIN Usuario u ON u.Nome = CONCAT('Cliente_Joao_', seq)
) AS data;

-- Repita o processo de inserção de clientes e agendamentos para os demais profissionais ajustando os números conforme necessário.

-- Inserindo clientes mais ativos em termos de agendamentos
INSERT INTO Cliente (id_Usuario, Data_Admissao_Cliente)
SELECT id_Usuario, '2022-06-01' FROM Usuario WHERE Nome IN ('Lionel Messi', 'Cristiano Ronaldo Aveiro', 'Lucas Paquetá', 'Carlos Eduardo');

-- Agendamentos para Lionel Messi (10 agendamentos)
INSERT INTO Agendamento (id_Cliente, id_Profissional, data_Agendamento, Preco)
SELECT 
    (SELECT id_Cliente FROM Cliente WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Lionel Messi')),
    (SELECT id_Profissional FROM Profissional ORDER BY RAND() LIMIT 1),
    DATE_ADD('2024-01-01', INTERVAL (seq*7) DAY),
    100
FROM (
    SELECT seq FROM (
        SELECT 0 AS seq UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
        UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
    ) AS numbers
) AS seq_table;

-- Inserindo dados para análise de pagamentos não realizados
-- Inserindo clientes Carlos Santos e Ana Costa
INSERT INTO Cliente (id_Usuario, Data_Admissao_Cliente)
SELECT id_Usuario, '2024-01-01' FROM Usuario WHERE Nome IN ('Carlos Santos', 'Ana Costa');

-- Inserindo agendamentos com status de pagamento
INSERT INTO Agendamento (id_Cliente, id_Profissional, data_Agendamento, Preco, Status_Pagamento, Data_Transacao, Status_Transacao) VALUES
((SELECT id_Cliente FROM Cliente WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'João da Silva')), (SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'João da Silva')), '2024-10-01 09:00:00', 150.00, 'Pendente', NULL, 'Não Processada'),
((SELECT id_Cliente FROM Cliente WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Maria Oliveira')), (SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Maria Oliveira')), '2024-10-02 10:00:00', 200.00, 'Pendente', '2024-10-03 10:00:00', 'Processada'),
((SELECT id_Cliente FROM Cliente WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Carlos Santos')), NULL, '2024-10-04 11:00:00', 150.00, 'Não realizado', NULL, 'Não Processada'),
((SELECT id_Cliente FROM Cliente WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Ana Costa')), NULL, '2024-10-05 12:00:00', 100.00, 'Pendente', NULL, 'Não Processada');

-- Inserindo atendimentos correspondentes
INSERT INTO Atendimento (id_Agendamento, data_Atendimento) VALUES
((SELECT id_Agendamento FROM Agendamento WHERE id_Cliente = (SELECT id_Cliente FROM Cliente WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'João da Silva')) AND data_Agendamento = '2024-10-01 09:00:00'), '2024-10-01 09:30:00'),
((SELECT id_Agendamento FROM Agendamento WHERE id_Cliente = (SELECT id_Cliente FROM Cliente WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Maria Oliveira')) AND data_Agendamento = '2024-10-02 10:00:00'), '2024-10-02 10:30:00'),
((SELECT id_Agendamento FROM Agendamento WHERE id_Cliente = (SELECT id_Cliente FROM Cliente WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Carlos Santos')) AND data_Agendamento = '2024-10-04 11:00:00'), NULL),
((SELECT id_Agendamento FROM Agendamento WHERE id_Cliente = (SELECT id_Cliente FROM Cliente WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'Ana Costa')) AND data_Agendamento = '2024-10-05 12:00:00'), NULL);

-- Inserindo dados para profissionais com menor taxa de cancelamento
-- Agendamentos para João da Silva com 50 agendamentos e 5 cancelamentos
INSERT INTO Agendamento (id_Cliente, id_Profissional, data_Agendamento, Preco, Cancelado)
SELECT 
    (SELECT id_Cliente FROM Cliente ORDER BY RAND() LIMIT 1),
    (SELECT id_Profissional FROM Profissional WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE Nome = 'João da Silva')),
    DATE_ADD('2024-01-01', INTERVAL seq DAY),
    100,
    IF(seq <= 5, TRUE, FALSE)
FROM (
    SELECT seq FROM (
        SELECT 1 AS seq UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
        UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10
        UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15
        UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL SELECT 20
        UNION ALL SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24 UNION ALL SELECT 25
        UNION ALL SELECT 26 UNION ALL SELECT 27 UNION ALL SELECT 28 UNION ALL SELECT 29 UNION ALL SELECT 30
        UNION ALL SELECT 31 UNION ALL SELECT 32 UNION ALL SELECT 33 UNION ALL SELECT 34 UNION ALL SELECT 35
        UNION ALL SELECT 36 UNION ALL SELECT 37 UNION ALL SELECT 38 UNION ALL SELECT 39 UNION ALL SELECT 40
        UNION ALL SELECT 41 UNION ALL SELECT 42 UNION ALL SELECT 43 UNION ALL SELECT 44 UNION ALL SELECT 45
        UNION ALL SELECT 46 UNION ALL SELECT 47 UNION ALL SELECT 48 UNION ALL SELECT 49 UNION ALL SELECT 50
    ) AS numbers
) AS seq_table;

-- Inserindo tipos de avaliação
INSERT INTO TP_Avaliacao (Descricao) VALUES
('Atendimento'),
('Pontualidade'),
('Qualidade'),
('Profissionalismo'),
('Satisfação Geral');

-- Inserindo feedbacks e avaliações para os atendimentos
INSERT INTO Feedback (id_Atendimento, Atendimento_Nota)
SELECT id_Atendimento, 5 FROM Atendimento WHERE data_Atendimento IS NOT NULL;

INSERT INTO Avaliacao (id_TP_Avaliacao, id_Atendimento, Descricao)
SELECT 1, id_Atendimento, 'Excelente atendimento, muito atencioso.'
FROM Atendimento WHERE data_Atendimento IS NOT NULL LIMIT 1;

-- Inserindo endereços para os usuários
INSERT INTO Endereco (id_Cidade, CEP, Bairro, Rua, Numero, Complemento, id_Usuario) VALUES
(1, 01001000, 'Centro', 'Rua A', 100, 'Apto 101', (SELECT id_Usuario FROM Usuario WHERE Nome = 'João da Silva')),
(2, 20020020, 'Copacabana', 'Av. Atlântica', 200, 'Apto 202', (SELECT id_Usuario FROM Usuario WHERE Nome = 'Maria Oliveira')),
(3, 30130030, 'Savassi', 'Rua B', 300, NULL, (SELECT id_Usuario FROM Usuario WHERE Nome = 'Rafael Costa')),
(4, 40040040, 'Pelourinho', 'Rua C', 400, 'Casa', (SELECT id_Usuario FROM Usuario WHERE Nome = 'Fernanda Souza')),
(5, 50050050, 'Moinhos de Vento', 'Rua D', 500, NULL, (SELECT id_Usuario FROM Usuario WHERE Nome = 'Ricardo Pereira'));

-- Inserindo telefones para os usuários
INSERT INTO Telefone (Numero, id_Usuario) VALUES
('111111111', (SELECT id_Usuario FROM Usuario WHERE Nome = 'João da Silva')),
('222222222', (SELECT id_Usuario FROM Usuario WHERE Nome = 'Maria Oliveira')),
('333333333', (SELECT id_Usuario FROM Usuario WHERE Nome = 'Rafael Costa')),
('444444444', (SELECT id_Usuario FROM Usuario WHERE Nome = 'Fernanda Souza')),
('555555555', (SELECT id_Usuario FROM Usuario WHERE Nome = 'Ricardo Pereira'));