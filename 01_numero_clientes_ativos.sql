SELECT 
    u.nome AS Profissional,
    COUNT(DISTINCT c.id_Cliente) AS Clientes_no_ano
FROM 
    Profissional AS p
JOIN 
    Agendamento AS a ON p.id_Profissional = a.id_Profissional
JOIN 
    Cliente AS c ON a.id_Cliente = c.id_Cliente
JOIN 
	Usuario AS u on p.id_Profissional=u.id_Usuario
WHERE 
    YEAR(a.data_Agendamento) = 2021
GROUP BY 
    p.id_Profissional
HAVING 
    Clientes_no_ano >= 1
ORDER BY 
    Clientes_no_ano DESC;
