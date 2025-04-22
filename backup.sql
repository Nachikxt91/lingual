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
441	54	Adiós	f	\N	spanish_goodbye.mp3
442	54	Gracias	f	\N	spanish_thankyou.mp3
443	55	Hola 	f	\N	spanish_hello.mp3
444	55	Adiós	f	\N	spanish_goodbye.mp3
445	55	Gracias	t	\N	spanish_thankyou.mp3
446	56	Adiós	t	\N	spanish_goodbye.mp3
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
476	66	Ellos están cocinando la cena	t	cooking_dinner.svg	spanish_They_are_cooking_dinner.mp3
477	66	Ella está escribiendo una carta	f	writting_letter.svg	spanish_She_is_writing_a_letter.mp3
478	66	Nosotros estamos viendo una película	f	watching_movie.svg	spanish_We_are_watching_a_movie.mp3
479	67	Nosotros estamos viendo una película	f	watching_movie.svg	spanish_We_are_watching_a_movie.mp3
480	67	Ellos están cocinando la cena	f	cooking_dinner.svg	spanish_They_are_cooking_dinner.mp3
481	67	Ella está escribiendo una carta	t	writting_letter.svg	spanish_She_is_writing_a_letter.mp3
482	68	Nosotros estamos viendo una película	t	watching_movie.svg	spanish_We_are_watching_a_movie.mp3
483	68	Ella está escribiendo una carta	f	writting_letter.svg	spanish_She_is_writing_a_letter.mp3
484	68	Ellos están cocinando la cena	f	cooking_dinner.svg	spanish_They_are_cooking_dinner.mp3
485	69	Ciao	t	\N	italian_hello.mp3
486	69	Grazie	f	\N	italian_thankyou.mp3
487	69	Arrivederci	f	\N	italian_goodbye.mp3
488	70	Grazie	t	\N	italian_thankyou.mp3
489	70	Ciao	f	\N	italian_hello.mp3
490	70	Arrivederci	f	\N	italian_goodbye.mp3
491	71	Arrivederci	t	\N	italian_goodbye.mp3
492	71	Grazie	f	\N	italian_thankyou.mp3
493	71	Ciao	f	\N	italian_hello.mp3
494	72	Mela	t	apple.svg	italian_apple.mp3
495	72	Gatto	f	cat.svg	italian_cat.mp3
496	72	Cane	f	dog.svg	italian_dog.mp3
497	73	Cane	f	dog.svg	italian_dog.mp3
498	73	Gatto	t	cat.svg	italian_cat.mp3
499	73	Mela	f	apple.svg	italian_apple.mp3
500	74	Mela	f	apple.svg	italian_apple.mp3
501	74	Cane	t	dog.svg	italian_dog.mp3
502	74	Gatto	f	cat.svg	italian_cat.mp3
503	75	Je mange une pomme	t	apple.svg	french_I_am_eating_an_apple.mp3
504	75	Je lis un livre	f	reading.svg	french_I_am_reading_a_book.mp3
505	75	Je dors dans mon lit	f	sleeping.svg	french_I_am_sleeping_in_my_bed.mp3
507	76	Je mange une pomme	f	apple.svg	french_I_am_eating_an_apple.mp3
506	76	Je dors dans mon lit	f	sleeping.svg	french_I_am_sleeping_in_my_bed.mp3
508	76	Je lis un livre	t	reading.svg	french_I_am_reading_a_book.mp3
512	78	Je dors dans mon lit	t	sleeping.svg	french_I_am_sleeping_in_my_bed.mp3
513	78	Je lis un livre	f	reading.svg	french_I_am_reading_a_book.mp3
514	78	Je mange une pomme	f	apple.svg	french_I_am_eating_an_apple.mp3
515	79	Nous regardons un film	t	watching_movie.svg	french_We_are_watching_a_movie.mp3
516	79	Elle écrit une lettre	f	writting_letter.svg	french_She_is_writing_a_letter.mp3
517	79	Ils cuisinent le dîner	f	cooking_dinner.svg	french_They_are_cooking_dinner.mp3
521	81	Ja pijem vodu	t	drinking_water.svg	croatia_I_am_drinking_water.mp3
522	81	Ja gledam televiziju	f	watching_movie.svg	croatia_I_am_watching_TV.mp3
523	81	Ja jedem kruh	f	eating.svg	croatia_I_am_eating_bread.mp3
524	82	Ja gledam televiziju	t	watching_movie.svg	croatia_I_am_watching_TV.mp3
525	82	Ja pijem vodu	f	drinking_water.svg	croatia_I_am_drinking_water.mp3
526	82	Ja jedem kruh	f	eating.svg	croatia_I_am_eating_bread.mp3
527	83	Ja jedem kruh	t	eating.svg	croatia_I_am_eating_bread.mp3
528	83	 Ja gledam televiziju	f	watching_movie.svg	croatia_I_am_watching_TV.mp3
529	83	Ja pijem vodu	f	drinking_water.svg	croatia_I_am_drinking_water.mp3
530	84	Ja jedem jabuku	t	apple.svg	croatia_I_am_eating_an_apple.mp3
531	84	Ja čitam knjigu	f	reading.svg	croatia_I_am_reading_a_book.mp3
532	84	Ja spavam u svom krevetu	f	sleeping.svg	croatia_I_am_sleeping_in_my_bed.mp3
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
109	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	54	t
110	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	55	t
111	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	56	t
112	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	57	t
113	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	58	t
114	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	59	t
115	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	60	t
116	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	61	t
117	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	62	t
118	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	63	t
119	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	64	t
120	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	65	t
121	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	66	t
122	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	67	t
123	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	68	t
124	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	69	t
125	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	70	t
126	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	71	t
127	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	72	t
128	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	73	t
129	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	74	t
130	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	75	t
131	user_2vtY3kmaoWVgnx6hYVwENFqSmCs	76	t
133	user_2vwqcnbnFLCTLWw23eq79PitBEo	75	t
134	user_2vwqcnbnFLCTLWw23eq79PitBEo	76	t
135	user_2vwqcnbnFLCTLWw23eq79PitBEo	78	t
136	user_2vwqcnbnFLCTLWw23eq79PitBEo	79	t
137	user_2vwqcnbnFLCTLWw23eq79PitBEo	81	t
138	user_2vwqcnbnFLCTLWw23eq79PitBEo	82	t
139	user_2vwqcnbnFLCTLWw23eq79PitBEo	83	t
140	user_2vwqcnbnFLCTLWw23eq79PitBEo	84	t
141	user_2vwqcnbnFLCTLWw23eq79PitBEo	54	t
142	user_2vwqcnbnFLCTLWw23eq79PitBEo	55	t
143	user_2vwqcnbnFLCTLWw23eq79PitBEo	56	t
144	user_2w4TsNQWK2lSnyYwruZMeuiFrbv	54	t
145	user_2w4TsNQWK2lSnyYwruZMeuiFrbv	55	t
146	user_2w4TsNQWK2lSnyYwruZMeuiFrbv	56	t
147	user_2w4TsNQWK2lSnyYwruZMeuiFrbv	57	t
148	user_2w4TsNQWK2lSnyYwruZMeuiFrbv	58	t
149	user_2w4TsNQWK2lSnyYwruZMeuiFrbv	59	t
150	user_2w4TsNQWK2lSnyYwruZMeuiFrbv	60	t
151	user_2w4TsNQWK2lSnyYwruZMeuiFrbv	61	t
152	user_2w4TsNQWK2lSnyYwruZMeuiFrbv	62	t
153	user_2w4TsNQWK2lSnyYwruZMeuiFrbv	63	t
154	user_2w4sFI8GAi5XW2Bl9nx2LTSa2X8	54	t
155	user_2w4sFI8GAi5XW2Bl9nx2LTSa2X8	55	t
156	user_2w4sFI8GAi5XW2Bl9nx2LTSa2X8	56	t
157	user_2w4sFI8GAi5XW2Bl9nx2LTSa2X8	57	t
158	user_2w4sFI8GAi5XW2Bl9nx2LTSa2X8	58	t
159	user_2w4sFI8GAi5XW2Bl9nx2LTSa2X8	59	t
160	user_2w4sFI8GAi5XW2Bl9nx2LTSa2X8	75	t
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
78	35	SELECT	Which sentence means “I am sleeping in my bed”?	3
64	26	SELECT	Which sentence means “I am eating”?	1
65	27	SELECT	Which sentence means “I am running”?	1
67	29	SELECT	Which sentence means “She is writing a letter”?	1
68	30	SELECT	Which sentence means “We are watching a movie”?	1
69	31	SELECT	How do we say "hello" in Italian?	1
70	31	SELECT	How do we say "thank you" in Italian?	2
71	31	SELECT	How do we say "goodbye" in Italian?	3
72	32	SELECT	Which one is the Italian word for “apple”?	1
73	33	SELECT	Which one is the Italian word for “cat”?	1
74	34	SELECT	Which one is the Italian word for “dog”?	1
63	25	SELECT	Which sentence means - I am sleeping?	1
66	28	SELECT	Which sentence means - They are cooking dinner?	1
75	35	SELECT	Which sentence means “I am eating an apple”?	1
76	35	SELECT	Which sentence means “I am reading a book”?	2
79	36	SELECT	Which sentence means “We are watching a movie”?	1
81	37	SELECT	Which sentence means “I am drinking water”?	1
82	37	SELECT	Which sentence means “I am watching TV”?	2
83	37	SELECT	Which sentence means “I am eating bread”?	3
84	39	SELECT	Which sentence means “I am eating an apple”?	1
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
28	Spanish Lesson 9	14	9
29	Spanish Lesson 10	14	10
30	Spanish Lesson 11	14	11
31	Italian Lesson 1	15	1
32	Italian Lesson 2	15	2
33	Italian Lesson 3	15	3
34	Italian Lesson 4	15	4
35	French Lesson 1	16	1
36	French Lesson 2	16	2
37	Croatian Lesson 1	17	1
39	Croatian Lesson 2	17	2
\.


--
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.units (id, title, description, course_id, "order") FROM stdin;
12	Spanish Unit 1	Basic words	1	1
13	Spanish Unit 2	Sentence	1	2
14	Spanish Unit 3	Difficult sentence	1	3
15	Italian Unit 1	Basic words	2	1
16	French Unit 1	Sentence	3	1
17	Croatian Unit 1	Sentence	4	1
\.


--
-- Data for Name: user_progresss; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_progresss (user_id, user_name, user_image_src, active_course_id, hearts, points) FROM stdin;
\.


--
-- Data for Name: user_subscription; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_subscription (id, user_id, stripe_customer_id, stripe_subscription_id, stripe_price_id, stripe_current_period_end) FROM stdin;
\.


--
-- Name: challengeOptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."challengeOptions_id_seq"', 532, true);


--
-- Name: challengeProgress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."challengeProgress_id_seq"', 160, true);


--
-- Name: challenges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.challenges_id_seq', 84, true);


--
-- Name: courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.courses_id_seq', 1, false);


--
-- Name: lessons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lessons_id_seq', 39, true);


--
-- Name: units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.units_id_seq', 17, true);


--
-- Name: user_subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_subscription_id_seq', 10, true);


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

