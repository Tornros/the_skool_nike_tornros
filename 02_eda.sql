DESE iystem.tabell3;

-- Analyzing basic structure of table
-- SELECT * FROM tabell3
-- FETCH FIRST 10 ROWS ONLY;


-- 1
-- a) Antal ansökningar per område, sorterat på flest ansökningar
-- Räknar antalet unika rader i "område", kompilerar datan som "antal_ansökningar"
SELECT område, 
COUNT(*) AS antal_ansökningar
FROM tabell3
GROUP BY område
ORDER BY antal_ansökningar DESC;

--b) Antal beviljade ansökningar per utbildningsområde
-- Samma princip, men med 'Beviljad' som krav
SELECT område,
COUNT(*) AS antal_beviljade_ansökningar
FROM tabell3
WHERE beslut = 'Beviljad'
GROUP BY område
ORDER BY antal_beviljade_ansökningar DESC;

--c) Antal nekade ansökningar per utbildningsområde
-- Samma princip, men med 'Avslag' som krav
SELECT område,
COUNT(*) AS antal_nekade_ansökningar
FROM tabell3
WHERE beslut = 'Avslag'
GROUP BY område
ORDER BY antal_nekade_ansökningar DESC;

--d) Antal beviljade ansökningar per utbildningsnamn Data/IT
-- Samma grundprincip som ovan, men visar indivudella utbildningstitlar SAMT plockar ut två WHERE krav, 'beslut' och 'område'
SELECT utbildning_namn,
COUNT(*) AS antal_beviljade_Data_IT
FROM tabell3
WHERE
(beslut = 'Beviljad') 
AND
(område = 'Data/IT')
GROUP BY utbildning_namn
ORDER BY utbildning_namn DESC;

--e) Antal nekade ansökningar per utbildningsnamn, inom Data/IT
-- Samma kod som d), men beslut = 'Avslag'
SELECT utbildning_namn,
COUNT(*) AS antal_nekade_Data_IT
FROM tabell3
WHERE
(beslut = 'Avslag') 
AND
(område = 'Data/IT')
GROUP BY utbildning_namn
ORDER BY utbildning_namn DESC;

--f) Antal beviljade ansökningar per utbildningsanordnare adm. enhet & utbildningsnamn, inom Data/IT
SELECT utbildning_namn, utbildningsanordnare_adm_enhet,
COUNT(*) AS antal_beviljade_Data_IT
FROM tabell3
WHERE
(beslut = 'Beviljad')
AND
(område = 'Data/IT')
GROUP BY utbildning_namn, utbildningsanordnare_adm_enhet
ORDER BY antal_beviljade_Data_IT DESC;





EXIT
