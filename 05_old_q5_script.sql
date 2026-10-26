-- OLD SCRIPT
-- Q5:
-- Hur stor andel distansutbildningar blir beviljade hämfört med platsbundna, i de olika områdena?

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
