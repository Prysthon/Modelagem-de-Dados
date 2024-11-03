SELECT 
    u.Nome AS Profissional, 
    p.Data_Admissao_Profissional, 
    anos.ano
FROM 
    Profissional p
JOIN 
    Usuario u ON p.id_Usuario = u.id_Usuario
CROSS JOIN 
    (SELECT 2021 AS ano UNION ALL SELECT 2022 UNION ALL SELECT 2023 UNION ALL SELECT 2024) AS anos
LEFT JOIN (
    SELECT 
        a.id_Profissional, 
        YEAR(at.data_Atendimento) AS ano
    FROM 
        Agendamento a
    JOIN 
        Atendimento at ON a.id_Agendamento = at.id_Agendamento
    GROUP BY 
        a.id_Profissional, YEAR(at.data_Atendimento)
) AS atendimentos ON 
    p.id_Profissional = atendimentos.id_Profissional AND 
    anos.ano = atendimentos.ano
WHERE 
    atendimentos.id_Profissional IS NULL AND 
    anos.ano >= YEAR(p.Data_Admissao_Profissional)
ORDER BY 
    u.Nome, anos.ano;
