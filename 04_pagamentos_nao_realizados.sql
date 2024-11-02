SELECT 
    a.id_Agendamento, 
    atd.id_Atendimento,
    u.Nome AS Cliente, 
    a.data_Agendamento AS Data_Agendamento,
    COALESCE(p.status_Pagamento, 'Pendente') AS status_Pagamento,
    a.Preco AS Valor_Total,
    p.data_transacao AS Data_Transacao,
    COALESCE(p.status_transacao, 'Não Processada') AS Status_Transacao
FROM 
    Agendamento AS a
JOIN 
    Atendimento AS atd ON a.id_Agendamento = atd.id_Agendamento
JOIN 
    Cliente AS c ON a.id_Cliente = c.id_Cliente
JOIN 
    Usuario AS u ON c.id_Usuario = u.id_Usuario
LEFT JOIN 
    Pagamento AS p ON a.id_Agendamento = p.id_Agendamento
WHERE 
    p.status_Pagamento IS NULL OR p.status_Pagamento = 'Pendente';
