INSERT INTO vacancy_body (
    company_name, name, text, area_id, address_id, work_experience,
    compensation_from, test_solution_required,
    work_schedule_type, employment_type, compensation_gross
)
SELECT
    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
            (random() * 77)::integer + 1, 1
        ),
        '')
    FROM generate_series(1, 1 + (random() * 100 + i % 10)::integer)) AS company_name,

    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
            (random() * 77)::integer + 1, 1
        ),
        '')
    FROM generate_series(1, 1 + (random() * 25 + i % 10)::integer)) AS name,

    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
            (random() * 77)::integer + 1, 1
        ),
        '')
    FROM generate_series(1, 1 + (random() * 50 + i % 10)::integer)) AS text,

    (random() * 1000)::int AS area_id,
    (random() * 50000)::int AS address_id,
    floor(random()*4)::int AS work_experience,
    (CASE (random() > 0.5) WHEN true
        THEN (18000 + (random() * 150000)::int)
        ELSE NULL
    END) AS compensation_from,
    (random() > 0.5) AS test_solution_required,
    floor(random() * 5)::int AS work_schedule_type,
    floor(random() * 5)::int AS employment_type,
    (random() > 0.5) AS compensation_gross
FROM generate_series(1, 10000) AS g(i);

UPDATE vacancy_body
SET compensation_to = (
CASE (random() > 0.5) WHEN true
    THEN (compensation_from + (random() * 150000)::int)
    ELSE NULL
END);

INSERT INTO vacancy (creation_time, employer_id, disabled, visible, vacancy_body_id, area_id)
SELECT
    now()-(random() * 365 * 24 * 3600 * 5) * '1 second'::interval AS creation_time,
    (random() * 1000000)::int AS employer_id,
    (random() > 0.5) AS disabled,
    (random() > 0.5) AS visible,
    (i) AS vacancy_body_id,
    (random() * 1000)::int AS area_id
FROM generate_series(1, 10000) AS g(i);

UPDATE vacancy SET
    expire_time = creation_time + (random()*3600*24*365) * '1 second'::interval;

INSERT INTO vacancy_specialization (vacancy_id, specialization_id)
SELECT vacancy_id, (random()*30)::int AS specialization_id FROM vacancy;

INSERT INTO vacancy_specialization (vacancy_id, specialization_id)
SELECT (vacancy_id + (random()*5)::int - 5) AS vacancy_id,
 (random()*30)::int AS specialization_id
FROM vacancy ORDER BY vacancy_id asc offset 5;

INSERT INTO person (
    person_name, sex, birth_date, area_id,
    willingness_to_relocation, willingness_to_travel,
    phone_number, email)
SELECT
    (SELECT string_agg(
        substr(
            ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
            (random() * 71)::integer + 1, 1
        ),
        '')
    FROM generate_series(1, 1 + (random() * 200 + i % 10)::integer)) AS person_name,
    (SELECT random() > 0.5) AS sex,
    (now() - 65*'1 year'::interval + (random()*365*50)*'1 day'::interval) AS birth_date,
    (random() * 1000)::int AS area_id,
    (SELECT random() > 0.8) AS willingness_to_relocation,
    (SELECT random() > 0.4) AS willingness_to_travel,
    (SELECT string_agg(
        substr(
            '0123456789',
            (random() * 9)::integer + 1, 1
        ),
        '')
    FROM generate_series(1, 12)) AS phone_number,
    (SELECT string_agg(
        substr(
            'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
            (random() * 71)::integer + 1, 1
        ),
        '') || '@gmail.com'
    FROM generate_series(1, 1 + (random() * 20 + i % 10)::integer)) AS email
FROM generate_series(1, 50000) AS g(i);

INSERT INTO resume_body (
    name, work_schedule_type, employment_type,
    salary, education, work_experience, about
)
SELECT
    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
            (random() * 77)::integer + 1, 1
        ),
        '')
    FROM generate_series(1, 1 + (random() * 50 + i % 10)::integer)) AS name,
    floor(random() * 5)::int AS work_schedule_type,
    floor(random() * 5)::int AS employment_type,
    (18000 + (random() * 150000)::int) AS salary,
    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
            (random() * 77)::integer + 1, 1
        ),
        '')
    FROM generate_series(1, 1 + (random() * 50 + i % 10)::integer)) AS education,
    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
            (random() * 77)::integer + 1, 1
        ),
        '')
    FROM generate_series(1, 1 + (random() * 50 + i % 10)::integer)) AS work_experience,
     (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
            (random() * 77)::integer + 1, 1
        ),
        '')
    FROM generate_series(1, 1 + (random() * 50 + i % 10)::integer)) AS about
FROM generate_series(1, 100000) AS g(i);

INSERT INTO resume (creation_time, person_id, visible, resume_body_id)
SELECT
    (now()-(random() * 365 * 24 * 3600 * 5) * '1 second'::interval) AS creation_time,
    ((random()*49999)::int+1) AS person_id,
    (SELECT random() > 0.5) AS visible,
    i AS resume_body_id
FROM generate_series(1, 100000) AS g(i);

UPDATE resume SET
    expire_time = creation_time + (random()*3600*24*365) * '1 second'::interval;

INSERT INTO resume_specialization (resume_id, specialization_id)
SELECT resume_id, (random()*30)::int AS specialization_id FROM resume;

INSERT INTO resume_specialization (resume_id, specialization_id)
SELECT (resume_id + (random()*5)::int - 5) AS resume_id,
 (random()*30)::int AS specialization_id
FROM resume ORDER BY resume_id asc offset 5;

INSERT INTO response (resume_id, vacancy_id, response_time)
SELECT
    (random()*99999::integer + 1) AS resume_id,
    (random()*9999::integer + 1) AS vacancy_id,
    now()-(random() * 365 * 24 * 3600 * 5) * '1 second'::interval AS response_time
FROM generate_series(1, 10000000);

delete FROM response WHERE (response_time < (SELECT creation_time FROM vacancy WHERE vacancy.vacancy_id = response.vacancy_id) OR
                            response_time < (SELECT creation_time FROM resume WHERE resume.resume_id = response.resume_id) OR
                            response_time > (SELECT expire_time FROM vacancy WHERE vacancy.vacancy_id = response.vacancy_id) OR
                            response_time > (SELECT expire_time FROM resume WHERE resume.resume_id = response.resume_id)
                            );