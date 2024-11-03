DELIMITER $$

DROP PROCEDURE IF EXISTS TopProfissionaisPremiacao$$

CREATE PROCEDURE TopProfissionaisPremiacao()
BEGIN
    -- Reseta o destaque de todos os profissionais para FALSE
    UPDATE Profissional SET destaque = FALSE;

    -- CTE para calcular o ranking dos profissionais
    WITH RankedProfessionals AS (
        SELECT 
            c.Credencial AS Tipo_Profissional,
            p.id_Profissional,
            u.Nome AS Nome_Profissional,
            AVG(f.Atendimento_Nota) AS Media_Avaliacao,
            ROW_NUMBER() OVER (PARTITION BY c.Credencial ORDER BY AVG(f.Atendimento_Nota) DESC) AS rn
        FROM Profissional p
        INNER JOIN Profissional_Credencial pc ON p.id_Profissional = pc.id_Profissional
        INNER JOIN Credencial c ON pc.id_Credencial = c.id_Credencial
        INNER JOIN Agendamento a ON p.id_Profissional = a.id_Profissional
        INNER JOIN Atendimento at ON a.id_Agendamento = at.id_Agendamento
        INNER JOIN Feedback f ON at.id_Atendimento = f.id_Atendimento
        INNER JOIN Usuario u ON p.id_Usuario = u.id_Usuario
        GROUP BY c.Credencial, p.id_Profissional, u.Nome
    )
    -- Atualiza o destaque para TRUE para os Top 3 profissionais de cada tipo
    UPDATE Profissional p
    INNER JOIN (
        SELECT id_Profissional
        FROM RankedProfessionals
        WHERE rn <= 3
    ) rp ON p.id_Profissional = rp.id_Profissional
    SET p.destaque = TRUE;
END$$

DELIMITER ;

CALL TopProfissionaisPremiacao();
