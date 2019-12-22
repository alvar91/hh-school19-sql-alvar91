SELECT vac.name AS vacancy_name FROM
    (SELECT count(response.vacancy_id) AS vac_count, name, vacancy_id
    FROM vacancy
    JOIN vacancy_body USING (vacancy_body_id)
    LEFT JOIN response USING (vacancy_id)
    WHERE (vacancy.creation_time + '1 week'::interval) > response.response_time
    GROUP BY vacancy_id, name) AS vac
WHERE vac.vac_count < 5 ORDER BY vac.name;