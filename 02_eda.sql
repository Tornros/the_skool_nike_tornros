DESE iystem.tabell3;

-- Analyzing basic structure of table
-- SELECT * FROM tabell3
-- FETCH FIRST 10 ROWS ONLY;

PROMPT === GRUNDLÄGGANDE EDA ===
PROMPT 
PROMPT === a) ===

-- 1
-- a) Antal ansökningar per område, sorterat på flest ansökningar.
-- Räknar antalet unika rader i "område", kompilerar datan som "antal_ansökningar".
SELECT område, 
COUNT(*) AS antal_ansökningar
FROM tabell3
GROUP BY område
ORDER BY antal_ansökningar DESC;

PROMPT === b) ===

--b) Antal beviljade ansökningar per utbildningsområde.
-- Samma princip, men med 'Beviljad' som krav.
SELECT område,
COUNT(*) AS antal_beviljade_ansökningar
FROM tabell3
WHERE beslut = 'Beviljad'
GROUP BY område
ORDER BY antal_beviljade_ansökningar DESC;

PROMPT === c) ===
--c) Antal nekade ansökningar per utbildningsområde.
-- Samma princip, men med 'Avslag' som krav.
SELECT område,
COUNT(*) AS antal_nekade_ansökningar
FROM tabell3
WHERE beslut = 'Avslag'
GROUP BY område
ORDER BY antal_nekade_ansökningar DESC;

PROMPT === d) ===

--d) Antal beviljade ansökningar per utbildningsnamn Data/IT.
-- Samma grundprincip som ovan, men visar indivudella utbildningstitlar SAMT plockar ut två WHERE krav, 'beslut' och 'område'.
SELECT utbildning_namn,
COUNT(*) AS antal_beviljade_Data_IT
FROM tabell3
WHERE
(beslut = 'Beviljad') 
AND
(område = 'Data/IT')
GROUP BY utbildning_namn
ORDER BY utbildning_namn DESC;

PROMPT === e) ===

--e) Antal nekade ansökningar per utbildningsnamn, inom Data/IT.
-- Samma kod som d), men beslut = 'Avslag'.
SELECT utbildning_namn,
COUNT(*) AS antal_nekade_Data_IT
FROM tabell3
WHERE
(beslut = 'Avslag') 
AND
(område = 'Data/IT')
GROUP BY utbildning_namn
ORDER BY utbildning_namn DESC;

PROMPT === f) ===

--f) Antal beviljade ansökningar per utbildningsanordnare adm. enhet & utbildningsnamn, inom Data/IT.
SELECT utbildning_namn, utbildningsanordnare_adm_enhet,
COUNT(*) AS antal_beviljade_Data_IT
FROM tabell3
WHERE
(beslut = 'Beviljad')
AND
(område = 'Data/IT')
GROUP BY utbildningsanordnare_adm_enhet, utbildning_namn
ORDER BY utbildningsanordnare_adm_enhet ASC
;


PROMPT === g) ===

--g) Topp 5 län efter antal beviljade ansökningar.
SELECT län,
COUNT(*) AS antal_beviljade_ansökningar
FROM tabell3
WHERE 
(beslut = 'Beviljad')
--För att räkna bort "Flera kommuner" och endast få individuella kommuner
AND 
(län != 'Flera kommuner')
GROUP BY län
ORDER BY antal_beviljade_ansökningar DESC
-- Alternativt, 'FETCH FIRST 6...', och ta bort '(län != 'Flera kommuner)' för att inkludera multi-kommun utbildningar i listan.
FETCH FIRST 5 ROWS ONLY;

-- "Problemet" är att 


PROMPT === h) ===

--h) Andel distans samt bundna utbildningar inom respektive utbildningsområde
-- EJ KLAR

-- Plockar ut två rader per område, en för distans, en för bunden.
SELECT område, studieform,
COUNT(*) AS antal
FROM tabell3
GROUP BY område, studieform
ORDER BY område, studieform;



PROMPT === i) ===

---i) Listar alla utbildningar som innehåller ordet 'AI'
SELECT område, utbildning_namn, diarienummer, utbildningsanordnare_adm_enhet
FROM tabell3
WHERE utbildning_namn LIKE 'AI %' -- Där titeln börjar på "AI"
OR utbildning_namn LIKE '% AI' -- Där titeln slutar på "AI"
OR utbildning_namn LIKE '% AI %' -- Där titeln innehåller "AI" i mitten
ORDER BY område ASC
;

-- Ger en siffra med antalet utbildningar
SELECT COUNT(*) AS Totala_program_innehåller_AI
FROM tabell3
WHERE utbildning_namn LIKE 'AI %'
OR utbildning_namn LIKE '% AI'
OR utbildning_namn LIKE '% AI %'
;

EXIT
