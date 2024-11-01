-- Consulta para identificar os clientes com maior quantidade de atendimentos por trimestre
SELECT
    CONCAT(sub.Ano, ' - Trimestre ', sub.Trimestre) AS Periodo_Trimestral,
    sub.Cliente,
    sub.Total_Atendimentos
FROM (
    SELECT
        YEAR(at.data_Atendimento) AS Ano,
        QUARTER(at.data_Atendimento) AS Trimestre,
        u.Nome AS Cliente,
        COUNT(at.id_Atendimento) AS Total_Atendimentos
    FROM
        Atendimento at
        INNER JOIN Agendamento ag ON at.id_Agendamento = ag.id_Agendamento
        INNER JOIN Cliente c ON ag.id_Cliente = c.id_Cliente
        INNER JOIN Usuario u ON c.id_Usuario = u.id_Usuario
    GROUP BY
        YEAR(at.data_Atendimento),
        QUARTER(at.data_Atendimento),
        u.Nome
) AS sub
ORDER BY
    sub.Ano,
    sub.Trimestre,
    sub.Total_Atendimentos DESC;

-- Precisa mudar a tabela de atendimento pois está com NULL, possível motivo de "erro"