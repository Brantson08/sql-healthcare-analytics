-- 1) Overall no-show rate
SELECT
  ROUND(100.0 * SUM(CASE WHEN NoShow = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS no_show_rate_pct,
  COUNT(*) AS total_appointments
FROM appointments;

-- 2) No-show rate by SMS reminder
SELECT
  SMS_Received,
  ROUND(100.0 * SUM(CASE WHEN NoShow = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS no_show_rate_pct,
  COUNT(*) AS n
FROM appointments
GROUP BY SMS_Received
ORDER BY no_show_rate_pct DESC;

-- 3) No-show rate by chronic conditions
SELECT
  Hypertension,
  Diabetes,
  ROUND(100.0 * SUM(CASE WHEN NoShow = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS no_show_rate_pct,
  COUNT(*) AS n
FROM appointments
GROUP BY Hypertension, Diabetes
ORDER BY no_show_rate_pct DESC, n DESC;

-- 4) Age band analysis
SELECT
  CASE
    WHEN Age < 18 THEN '0-17'
    WHEN Age BETWEEN 18 AND 29 THEN '18-29'
    WHEN Age BETWEEN 30 AND 44 THEN '30-44'
    WHEN Age BETWEEN 45 AND 59 THEN '45-59'
    ELSE '60+'
  END AS age_band,
  ROUND(100.0 * SUM(CASE WHEN NoShow = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS no_show_rate_pct,
  COUNT(*) AS n
FROM appointments
GROUP BY age_band
ORDER BY n DESC;
