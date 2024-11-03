SELECT 
    p.id_Profissional, 
    u.nome AS Nome,
    COUNT(a.id_Agendamento) AS total_agendamentos,
    SUM(CASE WHEN a.status_Agendamento = 'Cancelado' THEN 1 ELSE 0 END) AS total_cancelamentos,
    (SUM(CASE WHEN a.status_Agendamento = 'Cancelado' THEN 1 ELSE 0 END) / COUNT(a.id_Agendamento) * 100) AS taxa_cancelamento
FROM 
    Profissional AS p
JOIN 
    Agendamento AS a ON p.id_Profissional = a.id_Profissional
JOIN
    Usuario as u ON p.id_Usuario = u.id_Usuario
GROUP BY 
    p.id_Profissional
HAVING
    taxa_cancelamento > 0
ORDER BY 
    taxa_cancelamento ASC;
