SELECT avg((compensation_from + compensation_to)
    *(CASE
        WHEN compensation_gross
        THEN 0.87
        ELSE 1
        END
    )/2)::bigint AS avg_compensation_mid,
    avg(compensation_from
    *(CASE
        WHEN compensation_gross
        THEN 0.87
        ELSE 1
        END
    ))::bigint AS avg_compensation_from,
    avg(compensation_to
    *(CASE
        WHEN compensation_gross
        THEN 0.87
        ELSE 1
        END
    ))::bigint AS avg_compensation_to,
    area_id
FROM vacancy_body GROUP BY area_id ORDER BY area_id asc;
