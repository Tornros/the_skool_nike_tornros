-- Fråga 1:
-- Vilka områden är lägst belastade i respektive län?
PROMPT '=== Fråga 1 ==='

-- Lista över samtliga studieområden
SELECT DISTINCT område
FROM tabell3;

-- Lista över studieområdens fördelning över länen
-- Kan även visas per kommun: ändra då 'län' mot kommun. 
SELECT län, område,
COUNT(*) AS antal_ansökningar
	FROM tabell3
	-- Om man endast vill räkna med platsbundna utbildningar, lägg till:
	--WHERE studieform = 'Bunden'
GROUP BY område, län
ORDER BY län, antal_ansökningar ASC;

-- Visar vilka områden som inte representeras alls i ett län
-- Byt 'Blekinge' mot önskat län

SELECT DISTINCT område
FROM tabell3
	WHERE område NOT IN (
	    SELECT område
	    FROM tabell3
	    WHERE län = 'Blekinge'
);

-- Fråga 2:
-- Hur stor andel privata jämfört med regionala och kommunala utbildningsanordnare beviljas?
PROMPT '=== Fråga 2 ==='

SELECT län, område,
COUNT(*) antal_totalt,
-- För att få antalet i siffror:
--SUM(CASE WHEN huvudmannatyp = 'Privat' THEN 1 ELSE 0 END) AS "#_privat_aktör",
--SUM(CASE WHEN huvudmannatyp = 'Kommun' THEN 1 ELSE 0 END) AS "#_kommunal_aktör",
--SUM(CASE WHEN huvudmannatyp = 'Region' THEn 1 ELSE 0 END) AS "#_regional_aktör",
-- För att få antalet i procentsats:
ROUND(SUM(CASE WHEN huvudmannatyp = 'Privat' THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS "%_privat_aktör",
ROUND(SUM(CASE WHEN huvudmannatyp = 'Kommun' THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS "%_kommunal_aktör",
ROUND(SUM(CASE WHEN huvudmannatyp = 'Region' THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS "%_regional_aktör",
-- Avslagna vs. beviljade ansökningar för privata aktörer
SUM(CASE WHEN huvudmannatyp = 'Privat' AND beslut = 'Avslag' THEN 1 ELSE 0 END) AS privat_avslagen,
SUM(CASE WHEN huvudmannatyp = 'Privat' AND beslut = 'Beviljad' THEN 1 ELSE 0 END) AS privat_beviljad
FROM tabell3
-- För att slippa 200+ rader kan vi limitera per t.ex län:
WHERE län = 'Blekinge'
GROUP BY län, område
ORDER BY län, område
;


-- Fråga 3:
-- Hur många omgångar är vanligast att söka? Vilken mängd omgångar blir oftast beviljade?
PROMPT '=== Fråga 3 ==='

SELECT sökta_omgångar,
-- Hur många unika utbildningar som har sökt respektive mängd omgångar:
COUNT(*) AS ansökta_utbildningar,
COUNT(CASE WHEN beviljade_omgångar > 0 THEN 1 END) antal_beviljade,
ROUND(COUNT(CASE WHEN beviljade_omgångar > 0 THEN 1 END) / COUNT(*) * 100, 1) AS andel_beviljade_procent
FROM tabell3
GROUP BY sökta_omgångar
ORDER BY sökta_omgångar
;

-- Q4:
-- Vilken SUN5-grupp är minst belastad?
PROMPT '=== Fråga 4 ==='

SELECT område, sun5_namn, 
-- Antal ansökningar för respektive sun5 grupp:
COUNT(*) AS antal_ansökningar,
ROUND(COUNT(CASE WHEN beviljade_omgångar > 0 THEN 1 END) / COUNT(*) * 100, 1) AS "%_beviljade"
FROM tabell3
-- För att se specifika utbildningsområden, ändra 'Data/IT' till önskat område:
WHERE område = 'Data/IT'
GROUP BY område, sun5_namn
ORDER BY område, antal_ansökningar DESC
;

-- Q5:
-- Hur stor andel distansutbildningar blir beviljade jämfört med platsbundna, i de olika områdena?
PROMPT '=== Fråga 5 ==='

SELECT område, studieform,
COUNT(*) AS antal_ansökningar,
COUNT(CASE WHEN beslut = 'Beviljad' THEN 1 END) AS antal_beviljade,
COUNT(CASE WHEN beslut = 'Avlas' THEN 1 END) AS antal_avslagna,
ROUND(COUNT(CASE WHEN beslut = 'Beviljad' THEN 1 END) / COUNT(*) * 100, 1) AS "%_beviljade"
FROM tabell3
GROUP BY område, studieform
ORDER BY område, studieform;


SELECT område, studieform,
COUNT(*) antal_ansökningar,
ROUND(SUM(CASE WHEN studieform = 'Distans' THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS "%_Distans",
ROUND(SUM(CASE WHEN studieform = 'Bunden' THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS "%_Platsbunden",
SUM(CASE WHEN studieform = 'Distans' AND beslut = 'Beviljad' THEN 1 ELSE 0 END) AS distans_beviljad,
SUM(CASE WHEN studieform = 'Distans' AND beslut = 'Avslag' THEN 1 ELSE 0 END) AS distans_avslagen,
SUM(CASE WHEN studieform = 'Bunden' AND beslut = 'Beviljad' THEN 1 ELSE 0 END) AS bunden_beviljad,
SUM(CASE WHEN studieform = 'Bunden' AND beslut = 'Avslag' THEN 1 ELSE 0 END) AS bunden_avslagen
FROM tabell3
GROUP BY område, studieform
ORDER BY område, studieform
;


EXIT
