DELIMITER $$

CREATE TRIGGER trg_limitar_agendamento
BEFORE INSERT ON Agendamento
FOR EACH ROW
BEGIN
  DECLARE unpaid_payments INT;

  -- Conta o número de pagamentos não pagos pelo cliente
  SELECT COUNT(*) INTO unpaid_payments
  FROM Pagamento
  WHERE id_Cliente = NEW.id_Cliente
    AND status_Pagamento != 'Pago';

  -- Verifica se o cliente tem dois ou mais pagamentos não pagos
  IF unpaid_payments >= 2 THEN
    SIGNAL SQLSTATE '45000' 
    SET MESSAGE_TEXT = 'Não é possível realizar o agendamento: o cliente possui dois pagamentos pendentes.';
  END IF;
END$$

DELIMITER ;