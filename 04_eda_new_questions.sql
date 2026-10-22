-- Q1:
-- Vilka områden är lägst belastade i respektive län?
PROMPT === Q1 ===

-- Lista över samtliga studieområden
SELECT DISTINCT område
FROM tabell3;

-- Lista över studieområdens fördelning över länen
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

-- Q2:
-- Hur stor andel privata jämfört med regionala och kommunala utbildningsanordnare beviljas?
--PROMPT === Q2 ===
PROMPT === Q2 ===

SELECT län, område,
COUNT(*) antal_totalt,
SUM(CASE WHEN huvudmannatyp = 'Privat' THEN 1 ELSE 0 END) AS "#_privat_aktör",
SUM(CASE WHEN huvudmannatyp = 'Kommun' THEN 1 ELSE 0 END) AS "#_kommunal_aktör",
SUM(CASE WHEN huvudmannatyp = 'Region' THEn 1 ELSE 0 END) AS "#_regional_aktör",
ROUND(SUM(CASE WHEN huvudmannatyp = 'Privat' THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS "%_privat_aktör",
ROUND(SUM(CASE WHEN huvudmannatyp = 'Kommun' THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS "%_kommunal_aktör",
ROUND(SUM(CASE WHEN huvudmannatyp = 'Region' THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS "%_regional_aktör",
SUM(CASE WHEN huvudmannatyp = 'Privat' AND beslut = 'Avslag' THEN 1 ELSE 0 END) AS privat_avslagen,
SUM(CASE WHEN huvudmannatyp = 'Privat' AND beslut = 'Beviljad' THEN 1 ELSE 0 END) AS privat_beviljad
FROM tabell3
GROUP BY län, område
ORDER BY län, område;




-- Q3:
-- a) Hur många omgångar söks i snitt?
-- b) Vilken mängd omgångar blir oftast beviljade?
--PROMPT === Q3 ===

-- Q4:
-- Vilken SUN5-grupp är minst belastad?
--PROMPT === Q4 ===

--SELECT sun5_namn

-- Q5:
-- Hur stor andel distansutbildningar blir beviljade jämfört med platsbundna, i de olika områdena?
--PROMPT === Q5 =i==



EXIT
