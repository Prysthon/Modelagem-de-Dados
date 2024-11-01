-- Consulta para identificar os profissionais com o maior número de clientes
SELECT
    u.Nome AS Profissional,
    cred.Tipos_Credencial AS Tipo_Profissional,
    contador.Clientes_no_ano,
    COALESCE(atendimentos.Atendimentos_no_ano, 0) AS Atendimentos_no_ano
FROM
    (
        SELECT
            a.id_Profissional,
            COUNT(DISTINCT a.id_Cliente) AS Clientes_no_ano
        FROM
            Agendamento a
        WHERE
            YEAR(a.data_Agendamento) = 2024
        GROUP BY
            a.id_Profissional
        HAVING
            COUNT(DISTINCT a.id_Cliente) >= 10
    ) AS contador
    INNER JOIN Profissional p ON contador.id_Profissional = p.id_Profissional
    INNER JOIN Usuario u ON p.id_Usuario = u.id_Usuario
    LEFT JOIN (
        SELECT
            pc.id_Profissional,
            GROUP_CONCAT(c.Credencial SEPARATOR ', ') AS Tipos_Credencial
        FROM
            Profissional_Credencial pc
            INNER JOIN Credencial c ON pc.id_Credencial = c.id_Credencial
        GROUP BY
            pc.id_Profissional
    ) AS cred ON p.id_Profissional = cred.id_Profissional
    LEFT JOIN (
        SELECT
            a.id_Profissional,
            COUNT(at.id_Atendimento) AS Atendimentos_no_ano
        FROM
            Atendimento at
            INNER JOIN Agendamento a ON at.id_Agendamento = at.id_Agendamento
        WHERE
            YEAR(at.data_Atendimento) = 2024
        GROUP BY
            a.id_Profissional
    ) AS atendimentos ON contador.id_Profissional = atendimentos.id_Profissional
ORDER BY
    contador.Clientes_no_ano DESC;
