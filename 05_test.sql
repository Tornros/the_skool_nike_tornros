SELECT
 område,
 studieform,
 -- Antal ansökningar för området och studieformen
 COUNT(*) AS antal_ansökningar,
 -- Antal beviljade respektive avslagna
 COUNT(CASE WHEN beslut = 'Beviljad' THEN 1 END) AS antal_beviljade,
 COUNT(CASE WHEN beslut = 'Avslag' THEN 1 END) AS antal_avslagna,
 -- Andel beviljade i procent
 ROUND(COUNT(CASE WHEN beslut = 'Beviljad' THEN 1 END) / COUNT(*) * 100, 1) AS andel_beviljade_procent
FROM tabell3
GROUP BY område, studieform
ORDER BY område, studieform;
