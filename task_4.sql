SELECT
    (SELECT date_part('month', creation_time) AS creation_month
    FROM resume GROUP BY creation_month ORDER BY count(*) DESC LIMIT 1)
    AS resume_creation_month,
    (SELECT date_part('month', creation_time) AS creation_month
    FROM vacancy GROUP BY creation_month ORDER BY count(*) DESC LIMIT 1)
    AS vacancy_creation_month;