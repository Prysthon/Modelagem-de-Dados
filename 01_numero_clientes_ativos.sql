WITH ProfissionaisClientes AS (
    SELECT
        p.id_Profissional,
        u.nome AS Profissional,
        pc.Codigo AS Tipo_do_Profissional,
        COUNT(DISTINCT c.id_Cliente) AS Clientes_no_ano
    FROM 
        Profissional AS p
    JOIN 
        Agendamento AS a ON p.id_Profissional = a.id_Profissional
    JOIN 
        Cliente AS c ON a.id_Cliente = c.id_Cliente
    JOIN 
        Usuario AS u ON p.id_Profissional = u.id_Usuario
    LEFT JOIN
        Profissional_Credencial AS pc ON p.id_Profissional = pc.id_Profissional
    GROUP BY 
        p.id_Profissional, u.nome, pc.Codigo
),
MediaClientes AS (
    SELECT AVG(Clientes_no_ano) AS Media_Clientes FROM ProfissionaisClientes
)
SELECT
    Profissional,
    Tipo_do_Profissional,
    Clientes_no_ano
FROM
    ProfissionaisClientes, MediaClientes
WHERE
    Clientes_no_ano > Media_Clientes
ORDER BY 
    Clientes_no_ano DESC;
