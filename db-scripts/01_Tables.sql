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
  Nome VARCHAR(20) NOT NULL,
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
  Numero INT(9) UNIQUE NOT NULL,
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
  Preco INT NOT NULL,
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
