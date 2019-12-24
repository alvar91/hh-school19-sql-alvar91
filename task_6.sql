SELECT resume_id, resume_spec, response_spec FROM
    (SELECT resume_id, array_agg(specialization_id) AS resume_spec
    FROM resume
    JOIN resume_specialization USING (resume_id)
    GROUP BY resume_id ORDER BY resume_id) AS table1
JOIN
    (SELECT resume.resume_id, mode() WITHIN group (ORDER BY specialization_id DESC) AS response_spec
    FROM resume
    LEFT JOIN response USING (resume_id)
    LEFT JOIN vacancy_specialization USING (vacancy_id) GROUP BY resume_id) AS table2
USING(resume_id) ORDER BY resume_id;