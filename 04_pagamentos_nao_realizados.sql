SELECT
    a.id_Agendamento AS "ID Agendamento",
    at.id_Atendimento AS "ID Atendimento",
    u.Nome AS "Cliente",
    DATE_FORMAT(a.data_Agendamento, '%Y-%m-%d') AS "Data Agendamento",
    a.Status_Pagamento AS "Status Pagamento",
    FORMAT(a.Preco, 2) AS "Valor Total",
    DATE_FORMAT(a.Data_Transacao, '%Y-%m-%d') AS "Data Transação",
    a.Status_Transacao AS "Status Transação"
FROM
    Agendamento a
    LEFT JOIN Atendimento at ON a.id_Agendamento = at.id_Agendamento
    INNER JOIN Cliente c ON a.id_Cliente = c.id_Cliente
    INNER JOIN Usuario u ON c.id_Usuario = u.id_Usuario
WHERE
    a.Status_Pagamento IN ('Pendente', 'Não realizado')
ORDER BY
    a.id_Agendamento;
