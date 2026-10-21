-- Q1:
-- Vilka områden är lägst belastade i respektive län?
PROMPT === Q1 ===
SELECT DISTINCT område
FROM tabell3;

SELECT län, område, studieform,
COUNT(*) AS antal_ansökningar
FROM tabell3
WHERE studieform = 'Bunden'
GROUP BY område, län, studieform
ORDER BY län, antal_ansökningar;

-- Visar vilka områden som inte representeras alls i ett län
-- Byt 'Uppsala' mot önskat län
SELECT DISTINCT område
FROM tabell3
WHERE område NOT IN (
    SELECT område
    FROM tabell3
    WHERE län = 'Uppsala'
);

-- Q2:
-- Hur stor andel privata jämfört med kommunala utbildningsanordnare beviljas?
--PROMPT === Q2 ===

-- Q3:
-- a) Hur många omgångar söks i snitt?
-- b) Vilken mängd omgångar blir oftast beviljade?
--PROMPT === Q3 ===

-- Q4:
-- Vilken SUN5-grupp är minst belastad?
--PROMPT === Q4 ===

SELECT sun5_namn

-- Q5:
-- Hur stor andel distansutbildningar blir beviljade jämfört med platsbundna, i de olika områdena?
--PROMPT === Q5 =i==



EXIT
