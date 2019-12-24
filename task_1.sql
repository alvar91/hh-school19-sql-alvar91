CREATE TABLE IF NOT EXISTS vacancy_body (
    vacancy_body_id serial PRIMARY KEY,
    company_name varchar(150) DEFAULT ''::varchar NOT NULL,
    name varchar(220) DEFAULT ''::varchar NOT NULL,
    text text,
    area_id integer,
    address_id integer,
    work_experience integer DEFAULT 0 NOT NULL,
    compensation_from bigint DEFAULT 0,
    compensation_to bigint DEFAULT 0,
    test_solution_required boolean DEFAULT false NOT NULL,
    work_schedule_type integer DEFAULT 0 NOT NULL,
    employment_type integer DEFAULT 0 NOT NULL,
    compensation_gross boolean DEFAULT true,
    CONSTRAINT vacancy_body_work_experience_validate CHECK ((work_experience = ANY (ARRAY[0, 1, 2, 3]))),
    CONSTRAINT vacancy_body_work_employment_type_validate CHECK ((employment_type = ANY (ARRAY[0, 1, 2, 3, 4]))),
    CONSTRAINT vacancy_body_work_schedule_type_validate CHECK ((work_schedule_type = ANY (ARRAY[0, 1, 2, 3, 4])))
);

CREATE TABLE IF NOT EXISTS vacancy (
    vacancy_id serial PRIMARY KEY,
    creation_time timestamp NOT NULL,
    expire_time timestamp,
    employer_id integer DEFAULT 0 NOT NULL,
    disabled boolean DEFAULT false NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    vacancy_body_id integer REFERENCES vacancy_body(vacancy_body_id),
    area_id integer
);

CREATE TABLE IF NOT EXISTS vacancy_specialization (
    vacancy_id integer NOT NULL,
    specialization_id integer NOT NULL
);

CREATE TABLE IF NOT EXISTS person (
    person_id serial PRIMARY KEY,
    person_name varchar(250) NOT NULL,
    sex boolean DEFAULT true NOT NULL,
    birth_date timestamp NOT NULL,
    area_id integer,
    willingness_to_relocation boolean DEFAULT false,
    willingness_to_travel boolean DEFAULT false,
    phone_number varchar(20),
    email varchar(200)
);

CREATE TABLE IF NOT EXISTS resume_body(
    resume_body_id serial PRIMARY KEY,
    name varchar(220) DEFAULT ''::varchar NOT NULL,
    work_schedule_type integer DEFAULT 0 NOT NULL,
    employment_type integer DEFAULT 0 NOT NULL,
    salary bigint,
    education text,
    work_experience text,
    about text,
    CONSTRAINT vacancy_body_work_employment_type_validate CHECK ((employment_type = ANY (ARRAY[0, 1, 2, 3, 4]))),
    CONSTRAINT vacancy_body_work_schedule_type_validate CHECK ((work_schedule_type = ANY (ARRAY[0, 1, 2, 3, 4])))
);

CREATE TABLE IF NOT EXISTS resume (
    resume_id serial PRIMARY KEY,
    creation_time timestamp NOT NULL,
    expire_time timestamp,
    person_id integer NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person (person_id),
    visible boolean DEFAULT true,
    resume_body_id integer REFERENCES resume_body(resume_body_id) unique
);

CREATE TABLE IF NOT EXISTS resume_specialization (
    resume_id integer NOT NULL,
    specialization_id integer NOT NULL
);

CREATE TABLE IF NOT EXISTS response (
    resume_id integer NOT NULL,
    vacancy_id integer NOT NULL,
    response_time timestamp NOT NULL,
    FOREIGN KEY (resume_id) REFERENCES resume (resume_id),
    FOREIGN KEY (vacancy_id) REFERENCES vacancy (vacancy_id)
);