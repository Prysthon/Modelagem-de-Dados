-- Consulta para calcular a taxa de cancelamento de agendamentos por profissional
SELECT
    p.id_Profissional AS id_profissional,
    u.Nome AS nome,
    COUNT(a.id_Agendamento) AS total_agendamentos,
    SUM(CASE WHEN a.Cancelado = TRUE THEN 1 ELSE 0 END) AS total_cancelamentos,
    ROUND(
        (SUM(CASE WHEN a.Cancelado = TRUE THEN 1 ELSE 0 END) / COUNT(a.id_Agendamento)) * 100,
        2
    ) AS taxa_cancelamento
FROM
    Profissional p
    INNER JOIN Usuario u ON p.id_Usuario = u.id_Usuario
    INNER JOIN Agendamento a ON p.id_Profissional = a.id_Profissional
GROUP BY
    p.id_Profissional,
    u.Nome
ORDER BY
    taxa_cancelamento ASC;
