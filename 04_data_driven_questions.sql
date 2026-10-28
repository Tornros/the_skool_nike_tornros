-- Fråga 1:
-- Vilka områden är lägst belastade i respektive län?
PROMPT '=== Fråga 1 ==='

PROMPT Lista över samtliga studieområden
SELECT DISTINCT område
FROM tabell3;

PROMPT Lista över studieområdenas fördelning över länen
-- Kan även visas per kommun: ändra då 'län' mot kommun. 
SELECT län, område,
COUNT(*) AS antal_ansökningar
	FROM tabell3
	-- Om man endast vill räkna med platsbundna utbildningar, lägg till:
	--WHERE studieform = 'Bunden'
GROUP BY område, län
ORDER BY län, antal_ansökningar ASC;

PROMPT Lista över studieområden som ej representeras alls i vårt valda län
-- Visar vilka områden som inte representeras alls i ett län
-- Byt 'Blekinge' mot önskat län
SELECT DISTINCT 
område
FROM tabell3
	WHERE område NOT IN (
	    SELECT område
	    FROM tabell3
	    WHERE län = 'Blekinge'
);

-- Fråga 2:
PROMPT '=== Fråga 2 ==='
PROMPT Hur stor andel privata/ kommunala/ regionala utbildningsanordnare beviljas?
SELECT län, område,
	COUNT(*) antal_totalt,
	-- Valfri del, lägg till följande tre rader för att få antalet i siffror:
	--SUM(CASE WHEN huvudmannatyp = 'Privat' THEN 1 ELSE 0 END) AS "#_privat_aktör",
	--SUM(CASE WHEN huvudmannatyp = 'Kommun' THEN 1 ELSE 0 END) AS "#_kommunal_aktör",
	--SUM(CASE WHEN huvudmannatyp = 'Region' THEn 1 ELSE 0 END) AS "#_regional_aktör",
	-- För att få antalet i procentsats:
	ROUND(SUM(CASE WHEN huvudmannatyp = 'Privat' THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS "%_privat_aktör",
	ROUND(SUM(CASE WHEN huvudmannatyp = 'Kommun' THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS "%_kommunal_aktör",
	ROUND(SUM(CASE WHEN huvudmannatyp = 'Region' THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS "%_regional_aktör",
	-- Avslagna vs. beviljade ansökningar för privata aktörer
	-- Endast privata är inräknade här, då The Skool själva är en privat aktör
	ROUND(SUM(CASE WHEN huvudmannatyp = 'Privat' AND beslut = 'Avslag' THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS "%_privat_avslagen",
	ROUND(SUM(CASE WHEN huvudmannatyp = 'Privat' AND beslut = 'Beviljad' THEN 1 ELSE 0 END) / COUNT(*) * 100,1) AS "%_privat_beviljad"
FROM tabell3
-- För att slippa 200+ rader kan vi limitera per t.ex län:
WHERE län = 'Stockholm'
GROUP BY län, område
ORDER BY län, område;


-- Fråga 3:
PROMPT '=== Fråga 3 ==='
PROMPT Vilken mängd omgångar är vanligast att söka? Vilken mängd omgångar blir oftast beviljade?

SELECT sökta_omgångar,
-- Hur många unika utbildningar som har sökt respektive mängd omgångar:
	COUNT(*) AS ansökta_utbildningar,
	COUNT(CASE WHEN beviljade_omgångar > 0 THEN 1 END) antal_beviljade,
	ROUND(COUNT(CASE WHEN beviljade_omgångar > 0 THEN 1 END) / COUNT(*) * 100,1) beviljade_procent
FROM tabell3
GROUP BY sökta_omgångar
ORDER BY sökta_omgångar;

-- Fråga 4:
PROMPT '=== Fråga 4 ==='
PROMPT Vilken SUN5-grupp är minst belastad inom respektive område?

SELECT område, sun5_namn, 
-- Antal ansökningar för respektive sun5 grupp:
	COUNT(*) AS antal_ansökningar,
	ROUND(COUNT(CASE WHEN beviljade_omgångar > 0 THEN 1 END) / COUNT(*) * 100, 1) AS "%_beviljade"
FROM tabell3
-- För att slippa långa svar, sortera på specifika utbildningsområden
-- Ändra 'Data/IT' till önskat område:
WHERE område = 'Data/IT'
GROUP BY område, sun5_namn
ORDER BY område, antal_ansökningar DESC;

-- Fråga 5:
PROMPT '=== Fråga 5 ==='
PROMPT Hur stor andel distansutbildningar blir beviljade jämfört med platsbundna, i de olika områdena?

SELECT område, studieform,
	COUNT(*) AS antal_ansökningar,
	-- Antal beviljade/ avslagna:
	COUNT(CASE WHEN beslut = 'Beviljad' THEN 1 END) AS antal_beviljade,
	COUNT(CASE WHEN beslut = 'Avslag' THEN 1 END) AS antal_avslagna,
	-- Andel beviljade i %:
	ROUND(COUNT(CASE WHEN beslut = 'Beviljad' THEN 1 END) / COUNT(*) * 100, 1) AS "%_beviljade"
FROM tabell3
GROUP BY område, studieform
ORDER BY område, studieform;

EXIT
