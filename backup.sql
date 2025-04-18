--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.type AS ENUM (
    'SELECT',
    'ASSIST'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: challenge_options; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.challenge_options (
    id integer NOT NULL,
    challenge_id integer NOT NULL,
    text text NOT NULL,
    correct boolean NOT NULL,
    image_src text,
    audio_src text
);


--
-- Name: challengeOptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."challengeOptions_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: challengeOptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."challengeOptions_id_seq" OWNED BY public.challenge_options.id;


--
-- Name: challenge_progress; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.challenge_progress (
    id integer NOT NULL,
    user_id text NOT NULL,
    challenge_id integer NOT NULL,
    completed boolean DEFAULT false NOT NULL
);


--
-- Name: challengeProgress_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."challengeProgress_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: challengeProgress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."challengeProgress_id_seq" OWNED BY public.challenge_progress.id;


--
-- Name: challenges; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.challenges (
    id integer NOT NULL,
    lesson_id integer NOT NULL,
    type public.type NOT NULL,
    question text NOT NULL,
    "order" integer NOT NULL
);


--
-- Name: challenges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.challenges_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: challenges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.challenges_id_seq OWNED BY public.challenges.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.courses (
    id integer NOT NULL,
    title text NOT NULL,
    image_src text NOT NULL
);


--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.courses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;


--
-- Name: lessons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lessons (
    id integer NOT NULL,
    title text NOT NULL,
    unit_id integer NOT NULL,
    "order" integer NOT NULL
);


--
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lessons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;


--
-- Name: units; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.units (
    id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    course_id integer NOT NULL,
    "order" integer NOT NULL
);


--
-- Name: units_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.units_id_seq OWNED BY public.units.id;


--
-- Name: user_progresss; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_progresss (
    user_id text NOT NULL,
    user_name text DEFAULT 'User'::text NOT NULL,
    user_image_src text DEFAULT '/talking-person-svgrepo-com.svg'::text NOT NULL,
    active_course_id integer,
    hearts integer DEFAULT 5 NOT NULL,
    points integer DEFAULT 0 NOT NULL
);


--
-- Name: user_subscription; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_subscription (
    id integer NOT NULL,
    user_id text NOT NULL,
    stripe_customer_id text NOT NULL,
    stripe_subscription_id text NOT NULL,
    stripe_price_id text NOT NULL,
    stripe_current_period_end timestamp without time zone NOT NULL
);


--
-- Name: user_subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_subscription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_subscription_id_seq OWNED BY public.user_subscription.id;


--
-- Name: challenge_options id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.challenge_options ALTER COLUMN id SET DEFAULT nextval('public."challengeOptions_id_seq"'::regclass);


--
-- Name: challenge_progress id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.challenge_progress ALTER COLUMN id SET DEFAULT nextval('public."challengeProgress_id_seq"'::regclass);


--
-- Name: challenges id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.challenges ALTER COLUMN id SET DEFAULT nextval('public.challenges_id_seq'::regclass);


--
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- Name: lessons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);


--
-- Name: units id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units ALTER COLUMN id SET DEFAULT nextval('public.units_id_seq'::regclass);


--
-- Name: user_subscription id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_subscription ALTER COLUMN id SET DEFAULT nextval('public.user_subscription_id_seq'::regclass);


--
-- Data for Name: challenge_options; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.challenge_options (id, challenge_id, text, correct, image_src, audio_src) FROM stdin;
440	54	Hola 	t	\N	spanish_hello.mp3
441	54	Adi├│s	f	\N	spanish_goodbye.mp3
442	54	Gracias	f	\N	spanish_thankyou.mp3
443	55	Hola 	f	\N	spanish_hello.mp3
444	55	Adi├│s	f	\N	spanish_goodbye.mp3
445	55	Gracias	t	\N	spanish_thankyou.mp3
446	56	Adi├│s	t	\N	spanish_goodbye.mp3
447	56	Gracias	f	\N	spanish_thankyou.mp3
448	56	Hola 	f	\N	spanish_hello.mp3
449	57	Manzana 	t	apple.svg	spanish_apple.mp3
450	57	Gato 	f	cat.svg	spanish_cat.mp3
451	57	Perro 	f	dog.svg	spanish_dog.mp3
452	58	Perro 	f	dog.svg	spanish_dog.mp3
453	58	Gato 	t	cat.svg	spanish_cat.mp3
454	58	Manzana 	f	apple.svg	spanish_apple.mp3
455	59	Manzana 	f	apple.svg	spanish_apple.mp3
456	59	Gato 	f	cat.svg	spanish_cat.mp3
457	59	Perro 	t	dog.svg	spanish_dog.mp3
458	60	Comer 	t	eating.svg	eating.mp3
459	60	Dormir 	f	sleeping.svg	sleeping.mp3
460	60	Correr 	f	running.svg	running.mp3
461	61	Correr 	t	running.svg	running.mp3
462	61	Dormir 	f	sleeping.svg	sleeping.mp3
463	61	Comer 	f	eating.svg	eating.mp3
464	62	Comer 	f	eating.svg	eating.mp3
465	62	Dormir	t	sleeping.svg	sleeping.mp3
466	62	Correr 	f	running.svg	running.mp3
467	63	Estoy durmiendo	t	sleeping.svg	spanish_i_am_sleeping.mp3
468	63	Estoy comiendo	f	eating.svg	spanish_i_am_eating.mp3
469	63	Estoy corriendo	f	running.svg	spanish_i_am_running.mp3
470	64	Estoy durmiendo	f	sleeping.svg	spanish_i_am_sleeping.mp3
471	64	Estoy comiendo	t	eating.svg	spanish_i_am_eating.mp3
472	64	Estoy corriendo	f	running.svg	spanish_i_am_running.mp3
473	65	Estoy corriendo	t	running.svg	spanish_i_am_running.mp3
474	65	Estoy comiendo	f	eating.svg	spanish_i_am_eating.mp3
475	65	Estoy durmiendo	f	sleeping.svg	spanish_i_am_sleeping.mp3
\.


--
-- Data for Name: challenge_progress; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.challenge_progress (id, user_id, challenge_id, completed) FROM stdin;
94	user_2uE0ZARMpL5j9kKciM73eUayuzZ	54	t
95	user_2uE0ZARMpL5j9kKciM73eUayuzZ	55	t
96	user_2uE0ZARMpL5j9kKciM73eUayuzZ	56	t
97	user_2r78jJEUV6Xu7kSyHU5wbvJaY6r	54	t
98	user_2r78jJEUV6Xu7kSyHU5wbvJaY6r	55	t
99	user_2r78jJEUV6Xu7kSyHU5wbvJaY6r	56	t
100	user_2r78jJEUV6Xu7kSyHU5wbvJaY6r	57	t
101	user_2r78jJEUV6Xu7kSyHU5wbvJaY6r	58	t
102	user_2r78jJEUV6Xu7kSyHU5wbvJaY6r	59	t
103	user_2r78jJEUV6Xu7kSyHU5wbvJaY6r	60	t
104	user_2r78jJEUV6Xu7kSyHU5wbvJaY6r	61	t
105	user_2r78jJEUV6Xu7kSyHU5wbvJaY6r	62	t
106	user_2r78jJEUV6Xu7kSyHU5wbvJaY6r	63	t
107	user_2r78jJEUV6Xu7kSyHU5wbvJaY6r	64	t
108	user_2r78jJEUV6Xu7kSyHU5wbvJaY6r	65	t
\.


--
-- Data for Name: challenges; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.challenges (id, lesson_id, type, question, "order") FROM stdin;
54	20	SELECT	How do we say "hello" in Spanish?	1
55	20	SELECT	How do we say "thank you" in Spanish?	2
56	20	SELECT	How do we say "goodbye" in Spanish?	3
57	21	SELECT	Which one is the Spanish word for "apple"?	1
58	21	SELECT	Which one is the Spanish word for "cat"?	2
59	21	SELECT	Which one is the Spanish word for "dog"?	3
60	22	SELECT	Which one is the Spanish word for "to eat"?	1
61	23	SELECT	Which one is the Spanish word for "to run"?	1
62	24	SELECT	Which one is the Spanish word for "to sleep"?	1
63	25	SELECT	Which sentence means ΓÇ£I am sleepingΓÇ¥?	1
64	26	SELECT	Which sentence means ΓÇ£I am eatingΓÇ¥?	1
65	27	SELECT	Which sentence means ΓÇ£I am runningΓÇ¥?	1
\.


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.courses (id, title, image_src) FROM stdin;
1	Spanish	/ES.svg
2	Italian	/IT.svg
3	French	/FR.svg
4	Croatian	/HR.svg
\.


--
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lessons (id, title, unit_id, "order") FROM stdin;
25	Spanish Lesson 6	13	6
26	Spanish Lesson 7	13	7
20	Spanish Lesson 1	12	1
21	Spanish Lesson 2	12	2
22	Spanish Lesson 3	12	3
23	Spanish Lesson 4	12	4
24	Spanish Lesson 5	12	5
27	Spanish Lesson 8	13	8
\.


--
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.units (id, title, description, course_id, "order") FROM stdin;
12	Spanish Unit 1	Basic words	1	1
13	Spanish Unit 2	Sentence	1	2
\.


--
-- Data for Name: user_progresss; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_progresss (user_id, user_name, user_image_src, active_course_id, hearts, points) FROM stdin;
user_2vnfASdQE31DHHNANmEfsUIMQ5v	NACHIKET	https://img.clerk.com/eyJ0eXBlIjoicHJveHkiLCJzcmMiOiJodHRwczovL2ltYWdlcy5jbGVyay5kZXYvb2F1dGhfZ29vZ2xlL2ltZ18ydm5mQVNnQ2VHNGdEaTVGdzdDelU4Qlk3RjkifQ	1	5	0
user_2uE0ZARMpL5j9kKciM73eUayuzZ	Nachiket	https://img.clerk.com/eyJ0eXBlIjoicHJveHkiLCJzcmMiOiJodHRwczovL2ltYWdlcy5jbGVyay5kZXYvb2F1dGhfZ29vZ2xlL2ltZ18ydUUwWjRDT1R4bk5uMm5MYlJMZ0VWSWlhSkkifQ	1	4	80
user_2r78jJEUV6Xu7kSyHU5wbvJaY6r	Anuj	https://img.clerk.com/eyJ0eXBlIjoicHJveHkiLCJzcmMiOiJodHRwczovL2ltYWdlcy5jbGVyay5kZXYvb2F1dGhfZ29vZ2xlL2ltZ18ycjc4aksyQ2thVlJsQnNNSHl2WVpoNU5FTDQifQ	1	5	130
\.


--
-- Data for Name: user_subscription; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_subscription (id, user_id, stripe_customer_id, stripe_subscription_id, stripe_price_id, stripe_current_period_end) FROM stdin;
\.


--
-- Name: challengeOptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."challengeOptions_id_seq"', 475, true);


--
-- Name: challengeProgress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."challengeProgress_id_seq"', 108, true);


--
-- Name: challenges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.challenges_id_seq', 65, true);


--
-- Name: courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.courses_id_seq', 1, false);


--
-- Name: lessons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lessons_id_seq', 27, true);


--
-- Name: units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.units_id_seq', 13, true);


--
-- Name: user_subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_subscription_id_seq', 6, true);


--
-- Name: challenge_options challengeOptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.challenge_options
    ADD CONSTRAINT "challengeOptions_pkey" PRIMARY KEY (id);


--
-- Name: challenge_progress challengeProgress_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.challenge_progress
    ADD CONSTRAINT "challengeProgress_pkey" PRIMARY KEY (id);


--
-- Name: challenges challenges_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.challenges
    ADD CONSTRAINT challenges_pkey PRIMARY KEY (id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- Name: user_progresss user_progresss_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_progresss
    ADD CONSTRAINT user_progresss_pkey PRIMARY KEY (user_id);


--
-- Name: user_subscription user_subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_subscription
    ADD CONSTRAINT user_subscription_pkey PRIMARY KEY (id);


--
-- Name: user_subscription user_subscription_stripe_customer_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_subscription
    ADD CONSTRAINT user_subscription_stripe_customer_id_unique UNIQUE (stripe_customer_id);


--
-- Name: user_subscription user_subscription_stripe_subscription_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_subscription
    ADD CONSTRAINT user_subscription_stripe_subscription_id_unique UNIQUE (stripe_subscription_id);


--
-- Name: user_subscription user_subscription_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_subscription
    ADD CONSTRAINT user_subscription_user_id_unique UNIQUE (user_id);


--
-- Name: challenge_options challenge_options_challenge_id_challenges_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.challenge_options
    ADD CONSTRAINT challenge_options_challenge_id_challenges_id_fk FOREIGN KEY (challenge_id) REFERENCES public.challenges(id) ON DELETE CASCADE;


--
-- Name: challenge_progress challenge_progress_challenge_id_challenges_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.challenge_progress
    ADD CONSTRAINT challenge_progress_challenge_id_challenges_id_fk FOREIGN KEY (challenge_id) REFERENCES public.challenges(id) ON DELETE CASCADE;


--
-- Name: challenges challenges_lesson_id_lessons_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.challenges
    ADD CONSTRAINT challenges_lesson_id_lessons_id_fk FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE;


--
-- Name: lessons lessons_unit_id_units_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_unit_id_units_id_fk FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE;


--
-- Name: units units_course_id_courses_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_course_id_courses_id_fk FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- Name: user_progresss user_progresss_active_course_id_courses_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_progresss
    ADD CONSTRAINT user_progresss_active_course_id_courses_id_fk FOREIGN KEY (active_course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

