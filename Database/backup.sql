--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: calculate_outstanding_fees(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calculate_outstanding_fees() RETURNS json
    LANGUAGE plpgsql
    AS $$
DECLARE
    result JSON;
BEGIN
    SELECT JSON_AGG(
               JSON_BUILD_OBJECT(
                   'student_id', s.student_id,
                   'first_name', s.first_name,
                   'last_name', s.last_name,
                   'outstanding_fees', outstanding_fees.amount_due
               )
           )
    INTO result
    FROM students s
    LEFT JOIN (
        SELECT student_id, 1000.00 - COALESCE(SUM(amount_paid), 0) AS amount_due
        FROM fees_payments
        GROUP BY student_id
    ) AS outstanding_fees ON s.student_id = outstanding_fees.student_id;

    RETURN result;
END;
$$;


ALTER FUNCTION public.calculate_outstanding_fees() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: course_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course_assignments (
    assignment_id integer NOT NULL,
    lecture_id integer,
    course_id character(7)
);


ALTER TABLE public.course_assignments OWNER TO postgres;

--
-- Name: course_assignments_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_assignments_assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.course_assignments_assignment_id_seq OWNER TO postgres;

--
-- Name: course_assignments_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_assignments_assignment_id_seq OWNED BY public.course_assignments.assignment_id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    course_id character(7) NOT NULL,
    course_name character varying(100)
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- Name: enrollments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrollments (
    enrollment_id integer NOT NULL,
    student_id character(8),
    course_id character(7),
    enrollment_date date
);


ALTER TABLE public.enrollments OWNER TO postgres;

--
-- Name: enrollments_enrollment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enrollments_enrollment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enrollments_enrollment_id_seq OWNER TO postgres;

--
-- Name: enrollments_enrollment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enrollments_enrollment_id_seq OWNED BY public.enrollments.enrollment_id;


--
-- Name: fees_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fees_payments (
    payment_id integer NOT NULL,
    student_id character(8),
    amount_paid numeric(10,2),
    payment_date date
);


ALTER TABLE public.fees_payments OWNER TO postgres;

--
-- Name: fees_payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fees_payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fees_payments_payment_id_seq OWNER TO postgres;

--
-- Name: fees_payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fees_payments_payment_id_seq OWNED BY public.fees_payments.payment_id;


--
-- Name: lectures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lectures (
    lecture_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(100),
    title character varying(100)
);


ALTER TABLE public.lectures OWNER TO postgres;

--
-- Name: lectures_lecture_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lectures_lecture_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lectures_lecture_id_seq OWNER TO postgres;

--
-- Name: lectures_lecture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lectures_lecture_id_seq OWNED BY public.lectures.lecture_id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    student_id character(8) NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(100),
    personal_info text
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: ta_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ta_assignments (
    assignment_id integer NOT NULL,
    lecture_id integer,
    student_id character(8)
);


ALTER TABLE public.ta_assignments OWNER TO postgres;

--
-- Name: ta_assignments_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ta_assignments_assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ta_assignments_assignment_id_seq OWNER TO postgres;

--
-- Name: ta_assignments_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ta_assignments_assignment_id_seq OWNED BY public.ta_assignments.assignment_id;


--
-- Name: course_assignments assignment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_assignments ALTER COLUMN assignment_id SET DEFAULT nextval('public.course_assignments_assignment_id_seq'::regclass);


--
-- Name: enrollments enrollment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments ALTER COLUMN enrollment_id SET DEFAULT nextval('public.enrollments_enrollment_id_seq'::regclass);


--
-- Name: fees_payments payment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fees_payments ALTER COLUMN payment_id SET DEFAULT nextval('public.fees_payments_payment_id_seq'::regclass);


--
-- Name: lectures lecture_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lectures ALTER COLUMN lecture_id SET DEFAULT nextval('public.lectures_lecture_id_seq'::regclass);


--
-- Name: ta_assignments assignment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ta_assignments ALTER COLUMN assignment_id SET DEFAULT nextval('public.ta_assignments_assignment_id_seq'::regclass);


--
-- Data for Name: course_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course_assignments (assignment_id, lecture_id, course_id) FROM stdin;
1	1	CPEN201
2	2	CPEN202
3	3	CPEN203
\.


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses (course_id, course_name) FROM stdin;
CPEN201	Data Structures
CPEN202	Operating Systems
CPEN203	Database Systems
CPEN204	Networks
CPEN205	Software Engineering
\.


--
-- Data for Name: enrollments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollments (enrollment_id, student_id, course_id, enrollment_date) FROM stdin;
1	11023456	CPEN201	2024-03-01
2	11023457	CPEN202	2024-03-02
3	11023458	CPEN203	2024-03-03
4	11023459	CPEN204	2024-03-04
5	11023460	CPEN205	2024-03-05
6	10023461	CPEN201	2024-03-06
7	10023462	CPEN202	2024-03-07
8	10023463	CPEN203	2024-03-08
9	10023464	CPEN204	2024-03-09
10	10023465	CPEN205	2024-03-10
\.


--
-- Data for Name: fees_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fees_payments (payment_id, student_id, amount_paid, payment_date) FROM stdin;
1	11023456	500.00	2024-01-10
2	11023457	600.00	2024-01-15
3	11023458	550.00	2024-01-20
4	11023459	700.00	2024-01-25
5	11023460	650.00	2024-02-01
6	10023461	400.00	2024-02-05
7	10023462	450.00	2024-02-10
8	10023463	300.00	2024-02-15
9	10023464	200.00	2024-02-20
10	10023465	350.00	2024-02-25
\.


--
-- Data for Name: lectures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lectures (lecture_id, first_name, last_name, email, title) FROM stdin;
1	Dr.	Smith	drsmith@ug.edu.gh	Professor
2	Dr.	Johnson	drjohnson@ug.edu.gh	Associate Professor
3	Dr.	Williams	drwilliams@ug.edu.gh	Assistant Professor
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (student_id, first_name, last_name, email, personal_info) FROM stdin;
11023456	John	Doe	jodoe123@st.ug.edu.gh	Personal info about John Doe
11023457	Jane	Smith	jasmith234@st.ug.edu.gh	Personal info about Jane Smith
11023458	Alice	Johnson	aljohnson345@st.ug.edu.gh	Personal info about Alice Johnson
11023459	Bob	Brown	bobrown456@st.ug.edu.gh	Personal info about Bob Brown
11023460	Charlie	Davis	chdavis567@st.ug.edu.gh	Personal info about Charlie Davis
10023461	David	Wilson	dawilson678@st.ug.edu.gh	Personal info about David Wilson
10023462	Eve	Miller	evmiller789@st.ug.edu.gh	Personal info about Eve Miller
10023463	Frank	Moore	frmoore890@st.ug.edu.gh	Personal info about Frank Moore
10023464	Grace	Taylor	grtaylor901@st.ug.edu.gh	Personal info about Grace Taylor
10023465	Hank	Anderson	handerson012@st.ug.edu.gh	Personal info about Hank Anderson
\.


--
-- Data for Name: ta_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ta_assignments (assignment_id, lecture_id, student_id) FROM stdin;
1	1	11023456
2	2	11023457
3	3	11023458
\.


--
-- Name: course_assignments_assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_assignments_assignment_id_seq', 3, true);


--
-- Name: enrollments_enrollment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enrollments_enrollment_id_seq', 10, true);


--
-- Name: fees_payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fees_payments_payment_id_seq', 10, true);


--
-- Name: lectures_lecture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lectures_lecture_id_seq', 3, true);


--
-- Name: ta_assignments_assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ta_assignments_assignment_id_seq', 3, true);


--
-- Name: course_assignments course_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_assignments
    ADD CONSTRAINT course_assignments_pkey PRIMARY KEY (assignment_id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (course_id);


--
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (enrollment_id);


--
-- Name: fees_payments fees_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fees_payments
    ADD CONSTRAINT fees_payments_pkey PRIMARY KEY (payment_id);


--
-- Name: lectures lectures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lectures
    ADD CONSTRAINT lectures_pkey PRIMARY KEY (lecture_id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (student_id);


--
-- Name: ta_assignments ta_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ta_assignments
    ADD CONSTRAINT ta_assignments_pkey PRIMARY KEY (assignment_id);


--
-- Name: course_assignments course_assignments_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_assignments
    ADD CONSTRAINT course_assignments_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(course_id);


--
-- Name: course_assignments course_assignments_lecture_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course_assignments
    ADD CONSTRAINT course_assignments_lecture_id_fkey FOREIGN KEY (lecture_id) REFERENCES public.lectures(lecture_id);


--
-- Name: enrollments enrollments_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(course_id);


--
-- Name: enrollments enrollments_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- Name: fees_payments fees_payments_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fees_payments
    ADD CONSTRAINT fees_payments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- Name: ta_assignments ta_assignments_lecture_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ta_assignments
    ADD CONSTRAINT ta_assignments_lecture_id_fkey FOREIGN KEY (lecture_id) REFERENCES public.lectures(lecture_id);


--
-- Name: ta_assignments ta_assignments_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ta_assignments
    ADD CONSTRAINT ta_assignments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- PostgreSQL database dump complete
--

