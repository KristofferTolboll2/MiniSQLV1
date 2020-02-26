CREATE VIEW popularclasses AS
SELECT
  classes.classid,
  COUNT(*) AS amount
FROM
  classes
JOIN classmembers ON classes.classid = classmembers.classid
WHERE ends > DATE(NOW())
GROUP BY
  classes.classid
ORDER BY amount DESC LIMIT 10;
