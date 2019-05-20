SELECT
	tesserato.IdTesserato,
	tesserato.Tessera,
	tesserato.Cognome,
	tesserato.Nome,
	CAST(SUM(CASE WHEN stato_designazione.Nome IN ('Accettata', 'Trasmessa', 'Temporanea') THEN 1 ELSE 0 END) AS CHAR) AS Accettate,
    CAST(SUM(CASE WHEN stato_designazione.Nome = 'Rifiutata' THEN 1 ELSE 0 END) AS CHAR) AS Rifiutate,
	tesserato.Abilitazione,
	DATE_FORMAT(tesserato.DataNascita, '%d/%m/%Y') AS 'Data di nascita',
	DATE_FORMAT(tesserato.ScadenzaCertificatoMedico, '%d/%m/%Y') AS ScadenzaCertificatoMedico,
	UPPER(tesserato.Citta) AS Citta
FROM
	tesserato
LEFT JOIN designazione ON tesserato.IdTesserato = designazione.IdTesserato
LEFT JOIN stato_designazione ON designazione.IdStatoDesignazione = stato_designazione.IdStatoDesignazione
WHERE
	tesserato.IdGruppo = 2 AND
	tesserato.Abilitato = 1 AND
	tesserato.Abilitazione IS NOT NULL AND
	tesserato.ScadenzaCertificatoMedico IS NOT NULL AND 
	tesserato.Citta IS NOT NULL
GROUP BY
	tesserato.IdTesserato
ORDER BY
	tesserato.Cognome