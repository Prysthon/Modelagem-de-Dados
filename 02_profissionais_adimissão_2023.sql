-- Definir o ano inicial
SET @ano_inicial = 2023;

-- Consulta para listar profissionais sem atendimentos a partir de 2023
SELECT
    u.Nome AS Nome,
    p.Data_Admissao_Profissional AS dt_admissao
FROM
    Profissional p
    INNER JOIN Usuario u ON p.id_Usuario = u.id_Usuario
WHERE
    p.Data_Admissao_Profissional >= DATE(CONCAT(@ano_inicial, '-01-01'))
    AND NOT EXISTS (
        SELECT 1
        FROM
            Atendimento at
            INNER JOIN Agendamento ag ON at.id_Agendamento = ag.id_Agendamento
        WHERE
            ag.id_Profissional = p.id_Profissional
            AND YEAR(at.data_Atendimento) >= @ano_inicial
    );
