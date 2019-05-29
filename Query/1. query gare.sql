SELECT
    gara.IdGara,
    gara.Numero,
    campionato.Sigla AS Campionato,
	girone.Girone,
    gara.GiornoSettimana AS Giorno,
    DATE_FORMAT(gara.Data, '%d/%m/%Y') AS Data,
    DATE_FORMAT(gara.Ora, '%H:%i') AS Ora,
    squadra_a.Nome AS 'Squadra A',
    squadra_b.Nome AS 'Squadra B',
    campo_di_gioco.Campo,
    campo_di_gioco.Comune,
    campo_di_gioco.Provincia,
	IFNULL(CONCAT(tesserato.Cognome, ' ', SUBSTRING(tesserato.Nome, 1, 1), '.'), '-') AS Arbitro
FROM
    gara
LEFT JOIN campionato ON gara.IdCampionato = campionato.IdCampionato
LEFT JOIN campo_di_gioco ON gara.IdCampoDiGioco = campo_di_gioco.IdCampoDiGioco
LEFT JOIN squadra squadra_a ON gara.IdSquadraA = squadra_a.IdSquadra
LEFT JOIN squadra squadra_b ON gara.IdSquadraB = squadra_b.IdSquadra
LEFT JOIN girone ON gara.IdGirone = girone.IdGirone
LEFT JOIN designazione ON gara.IdGara = designazione.IdGara
LEFT JOIN tesserato ON designazione.IdTesserato = tesserato.IdTesserato
WHERE
	gara.IdGruppo = 2 AND
	gara.IdAnnoSportivo = 1 AND
	campo_di_gioco.Campo IS NOT NULL AND
	gara.Data IS NOT NULL AND
	gara.IdGirone IS NOT NULL
ORDER BY
    gara.Data,
    gara.Ora,
    gara.IdCampoDiGioco,
    gara.Numero,
    gara.IdGara,
	designazione.DataOra ASC
LIMIT 500