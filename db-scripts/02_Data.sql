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

-- Inserindo dados na tabela Usuario
INSERT INTO Usuario (Nome, CPF, Data_Nascimento) VALUES
('João Silva', '12345678901', '1980-01-01'),
('Maria Souza', '23456789012', '1990-02-02'),
('Carlos Lima', '34567890123', '1985-03-03'),
('Ana Pereira', '45678901234', '1992-04-04'),
('Lucas Costa', '56789012345', '1988-05-05');

-- Inserindo dados na tabela Endereco
INSERT INTO Endereco (id_Cidade, CEP, Bairro, Rua, Numero, Complemento, id_Usuario) VALUES
(1, 01001000, 'Centro', 'Rua A', 100, 'Apto 101', 1),
(2, 20020020, 'Copacabana', 'Av. Atlântica', 200, 'Apto 202', 2),
(3, 30130030, 'Savassi', 'Rua B', 300, NULL, 3),
(4, 40040040, 'Pelourinho', 'Rua C', 400, 'Casa', 4),
(5, 50050050, 'Moinhos de Vento', 'Rua D', 500, NULL, 5);

-- Inserindo dados na tabela Telefone
INSERT INTO Telefone (Numero, id_Usuario) VALUES
(111111111, 1),
(222222222, 2),
(333333333, 3),
(444444444, 4),
(555555555, 5);

-- Inserindo dados na tabela Profissional
INSERT INTO Profissional (id_Usuario, Data_Admissao_Profissional) VALUES
(1, '2020-01-15'),
(2, '2020-02-15'),
(3, '2020-03-15'),
(4, '2020-04-15'),
(5, '2020-05-15');

-- Inserindo dados na tabela Credencial
INSERT INTO Credencial (Credencial) VALUES
('CRM'),
('CRO'),
('CRP'),
('COREN'),
('CREFITO');

-- Inserindo dados na tabela Profissional_Credencial
INSERT INTO Profissional_Credencial (id_Profissional, id_Credencial, Codigo) VALUES
(1, 1, 'CRM12345'),
(2, 2, 'CRO23456'),
(3, 3, 'CRP34567'),
(4, 4, 'COREN45678'),
(5, 5, 'CREFITO56789');

-- Inserindo dados na tabela TP_Avaliacao
INSERT INTO TP_Avaliacao (Descricao) VALUES
('Atendimento'),
('Pontualidade'),
('Qualidade'),
('Profissionalismo'),
('Satisfação Geral');

-- Inserindo dados na tabela Cliente
INSERT INTO Cliente (id_Usuario, Data_Admissao_Cliente) VALUES
(1, '2021-01-10'),
(2, '2021-02-10'),
(3, '2021-03-10'),
(4, '2021-04-10'),
(5, '2021-05-10');

-- Inserindo dados na tabela Agendamento
INSERT INTO Agendamento (id_Cliente, id_Profissional, data_Agendamento, Preco) VALUES
(1, 1, '2021-06-01 09:00:00', 100),
(2, 2, '2021-06-02 10:00:00', 150),
(3, 3, '2021-06-03 11:00:00', 200),
(4, 4, '2021-06-04 12:00:00', 250),
(5, 5, '2021-06-05 13:00:00', 300);

-- Inserindo dados na tabela Atendimento
INSERT INTO Atendimento (id_Agendamento, data_Atendimento) VALUES
(1, '2021-06-01 09:30:00'),
(2, '2021-06-02 10:30:00'),
(3, '2021-06-03 11:30:00'),
(4, '2021-06-04 12:30:00'),
(5, '2021-06-05 13:30:00');

-- Inserindo dados na tabela Feedback
INSERT INTO Feedback (id_Atendimento, Atendimento_Nota) VALUES
(1, 5),
(2, 4),
(3, 5),
(4, 3),
(5, 5);

-- Inserindo dados na tabela Avaliacao
INSERT INTO Avaliacao (id_TP_Avaliacao, id_Atendimento, Descricao) VALUES
(1, 1, 'Excelente atendimento, muito atencioso.'),
(2, 2, 'Chegou na hora marcada, sem atrasos.'),
(3, 3, 'Serviço de alta qualidade, superou expectativas.'),
(4, 4, 'Profissionalismo exemplar durante todo o atendimento.'),
(5, 5, 'Muito satisfeito com o resultado final.');
