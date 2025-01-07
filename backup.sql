--
-- PostgreSQL database dump
--

-- Dumped from database version 17.1
-- Dumped by pg_dump version 17.1

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: healthkeeper
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO healthkeeper;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: healthkeeper
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_attachments_id_seq OWNER TO healthkeeper;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: healthkeeper
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: healthkeeper
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO healthkeeper;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: healthkeeper
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_blobs_id_seq OWNER TO healthkeeper;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: healthkeeper
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: healthkeeper
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO healthkeeper;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: healthkeeper
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNER TO healthkeeper;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: healthkeeper
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: healthkeeper
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO healthkeeper;

--
-- Name: biomarkers; Type: TABLE; Schema: public; Owner: healthkeeper
--

CREATE TABLE public.biomarkers (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.biomarkers OWNER TO healthkeeper;

--
-- Name: biomarkers_id_seq; Type: SEQUENCE; Schema: public; Owner: healthkeeper
--

CREATE SEQUENCE public.biomarkers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.biomarkers_id_seq OWNER TO healthkeeper;

--
-- Name: biomarkers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: healthkeeper
--

ALTER SEQUENCE public.biomarkers_id_seq OWNED BY public.biomarkers.id;


--
-- Name: health_records; Type: TABLE; Schema: public; Owner: healthkeeper
--

CREATE TABLE public.health_records (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.health_records OWNER TO healthkeeper;

--
-- Name: health_records_id_seq; Type: SEQUENCE; Schema: public; Owner: healthkeeper
--

CREATE SEQUENCE public.health_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.health_records_id_seq OWNER TO healthkeeper;

--
-- Name: health_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: healthkeeper
--

ALTER SEQUENCE public.health_records_id_seq OWNED BY public.health_records.id;


--
-- Name: lab_tests; Type: TABLE; Schema: public; Owner: healthkeeper
--

CREATE TABLE public.lab_tests (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    biomarker_id bigint NOT NULL,
    value numeric,
    unit character varying,
    reference_range_id bigint NOT NULL,
    recordable_type character varying,
    recordable_id integer,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.lab_tests OWNER TO healthkeeper;

--
-- Name: lab_tests_id_seq; Type: SEQUENCE; Schema: public; Owner: healthkeeper
--

CREATE SEQUENCE public.lab_tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lab_tests_id_seq OWNER TO healthkeeper;

--
-- Name: lab_tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: healthkeeper
--

ALTER SEQUENCE public.lab_tests_id_seq OWNED BY public.lab_tests.id;


--
-- Name: measurements; Type: TABLE; Schema: public; Owner: healthkeeper
--

CREATE TABLE public.measurements (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    measurement_type integer,
    value numeric,
    source character varying,
    recordable_type character varying,
    recordable_id integer,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    unit character varying
);


ALTER TABLE public.measurements OWNER TO healthkeeper;

--
-- Name: measurements_id_seq; Type: SEQUENCE; Schema: public; Owner: healthkeeper
--

CREATE SEQUENCE public.measurements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.measurements_id_seq OWNER TO healthkeeper;

--
-- Name: measurements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: healthkeeper
--

ALTER SEQUENCE public.measurements_id_seq OWNED BY public.measurements.id;


--
-- Name: pdfs; Type: TABLE; Schema: public; Owner: healthkeeper
--

CREATE TABLE public.pdfs (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    scan_method character varying,
    status character varying DEFAULT 'pending'::character varying,
    processed_data jsonb DEFAULT '{}'::jsonb,
    notes text,
    health_record_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.pdfs OWNER TO healthkeeper;

--
-- Name: pdfs_id_seq; Type: SEQUENCE; Schema: public; Owner: healthkeeper
--

CREATE SEQUENCE public.pdfs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pdfs_id_seq OWNER TO healthkeeper;

--
-- Name: pdfs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: healthkeeper
--

ALTER SEQUENCE public.pdfs_id_seq OWNED BY public.pdfs.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: healthkeeper
--

CREATE TABLE public.posts (
    id bigint NOT NULL,
    title character varying,
    body text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.posts OWNER TO healthkeeper;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: healthkeeper
--

CREATE SEQUENCE public.posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_id_seq OWNER TO healthkeeper;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: healthkeeper
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: reference_ranges; Type: TABLE; Schema: public; Owner: healthkeeper
--

CREATE TABLE public.reference_ranges (
    id bigint NOT NULL,
    biomarker_id bigint NOT NULL,
    min_value numeric,
    max_value numeric,
    unit character varying,
    source character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.reference_ranges OWNER TO healthkeeper;

--
-- Name: reference_ranges_id_seq; Type: SEQUENCE; Schema: public; Owner: healthkeeper
--

CREATE SEQUENCE public.reference_ranges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reference_ranges_id_seq OWNER TO healthkeeper;

--
-- Name: reference_ranges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: healthkeeper
--

ALTER SEQUENCE public.reference_ranges_id_seq OWNED BY public.reference_ranges.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: healthkeeper
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying,
    resource_type character varying,
    resource_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.roles OWNER TO healthkeeper;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: healthkeeper
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO healthkeeper;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: healthkeeper
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: healthkeeper
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO healthkeeper;

--
-- Name: users; Type: TABLE; Schema: public; Owner: healthkeeper
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    first_name character varying,
    last_name character varying,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    age integer
);


ALTER TABLE public.users OWNER TO healthkeeper;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: healthkeeper
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO healthkeeper;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: healthkeeper
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: healthkeeper
--

CREATE TABLE public.users_roles (
    user_id bigint,
    role_id bigint
);


ALTER TABLE public.users_roles OWNER TO healthkeeper;

--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: biomarkers id; Type: DEFAULT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.biomarkers ALTER COLUMN id SET DEFAULT nextval('public.biomarkers_id_seq'::regclass);


--
-- Name: health_records id; Type: DEFAULT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.health_records ALTER COLUMN id SET DEFAULT nextval('public.health_records_id_seq'::regclass);


--
-- Name: lab_tests id; Type: DEFAULT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.lab_tests ALTER COLUMN id SET DEFAULT nextval('public.lab_tests_id_seq'::regclass);


--
-- Name: measurements id; Type: DEFAULT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.measurements ALTER COLUMN id SET DEFAULT nextval('public.measurements_id_seq'::regclass);


--
-- Name: pdfs id; Type: DEFAULT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.pdfs ALTER COLUMN id SET DEFAULT nextval('public.pdfs_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: reference_ranges id; Type: DEFAULT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.reference_ranges ALTER COLUMN id SET DEFAULT nextval('public.reference_ranges_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: healthkeeper
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
208	file	Pdf	49	208	2025-01-06 02:21:39.320436
209	file	Pdf	50	209	2025-01-06 02:32:39.176923
210	file	Pdf	51	210	2025-01-06 09:12:05.953237
157	pdf_file	HealthRecord	157	157	2025-01-03 11:59:55.857351
189	file	Pdf	30	189	2025-01-03 22:11:30.794692
190	file	Pdf	31	190	2025-01-05 06:30:00.676526
191	file	Pdf	32	191	2025-01-05 11:29:13.155504
192	file	Pdf	33	192	2025-01-05 19:28:02.473406
193	file	Pdf	34	193	2025-01-05 19:28:05.124923
194	file	Pdf	35	194	2025-01-05 19:31:13.491966
195	file	Pdf	36	195	2025-01-05 19:35:25.847553
196	file	Pdf	37	196	2025-01-05 19:40:15.498947
197	file	Pdf	38	197	2025-01-05 21:51:19.720145
198	file	Pdf	39	198	2025-01-05 23:07:31.137872
199	file	Pdf	40	199	2025-01-05 23:09:04.5778
200	file	Pdf	41	200	2025-01-05 23:13:24.241639
201	file	Pdf	42	201	2025-01-05 23:16:47.659868
202	file	Pdf	43	202	2025-01-05 23:18:44.610446
203	file	Pdf	44	203	2025-01-05 23:27:23.821854
204	file	Pdf	45	204	2025-01-05 23:27:53.446304
205	file	Pdf	46	205	2025-01-05 23:28:46.035802
206	file	Pdf	47	206	2025-01-05 23:32:42.143214
207	file	Pdf	48	207	2025-01-06 00:48:33.679208
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: healthkeeper
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at) FROM stdin;
198	mxh697f7lqzfzzrjatc17uqrcd6p	Cumulative-sample-report-with-notes-2017_2-#2.pdf	application/pdf	{"identified":true,"analyzed":true}	local	160483	kkM3DTe9GBHfa3uERWdGCA==	2025-01-05 23:07:31.132736
189	9k0sqobxsgbokonczc8eo050tvzj	sterling-accuris-pathology-sample-report-#1.pdf	application/pdf	{"identified":true,"analyzed":true}	local	6908257	kPmsvYCTQ6SotpaTft5Y3g==	2025-01-03 22:11:30.788278
199	u2t6wfoz6omab0g73vzkhugm3a88	Cumulative-sample-report-with-notes-2017_2-#2.pdf	application/pdf	{"identified":true,"analyzed":true}	local	160483	kkM3DTe9GBHfa3uERWdGCA==	2025-01-05 23:09:04.573077
200	ivtlfslxwuu20pb1cg7m09fvxhm1	sterling-accuris-pathology-sample-report-#1.pdf	application/pdf	{"identified":true,"analyzed":true}	local	6908257	kPmsvYCTQ6SotpaTft5Y3g==	2025-01-05 23:13:24.23593
201	xur672f0ilcrbkuzy4ane7rtautc	sterling-accuris-pathology-sample-report-#1.pdf	application/pdf	{"identified":true,"analyzed":true}	local	6908257	kPmsvYCTQ6SotpaTft5Y3g==	2025-01-05 23:16:47.655915
202	tpcwcn89zyip5nwc3wjz955isrv2	sterling-accuris-pathology-sample-report-#1.pdf	application/pdf	{"identified":true,"analyzed":true}	local	6908257	kPmsvYCTQ6SotpaTft5Y3g==	2025-01-05 23:18:44.604244
190	tr33jpo1rz5hdlab6g7n5z7cfevo	Cumulative-sample-report-with-notes-2017_2-#2.pdf	application/pdf	{"identified":true,"analyzed":true}	local	160483	kkM3DTe9GBHfa3uERWdGCA==	2025-01-05 06:30:00.66904
191	189k5fyitgtkhov7weesskg4kuqj	Cumulative-sample-report-with-notes-2017_2-#2.pdf	application/pdf	{"identified":true,"analyzed":true}	local	160483	kkM3DTe9GBHfa3uERWdGCA==	2025-01-05 11:29:13.138398
192	pb1t7a87xg6hanofh7js9fk9txbv	Cumulative-sample-report-with-notes-2017_2-#2.pdf	application/pdf	{"identified":true,"analyzed":true}	local	160483	kkM3DTe9GBHfa3uERWdGCA==	2025-01-05 19:28:02.464152
193	kzndeb0l2l1mspml6a766qnp3teo	Cumulative-sample-report-with-notes-2017_2-#2.pdf	application/pdf	{"identified":true,"analyzed":true}	local	160483	kkM3DTe9GBHfa3uERWdGCA==	2025-01-05 19:28:05.116069
194	1gs0p0qm2ocshjk5nlrdp8slrpua	Cumulative-sample-report-with-notes-2017_2-#2.pdf	application/pdf	{"identified":true,"analyzed":true}	local	160483	kkM3DTe9GBHfa3uERWdGCA==	2025-01-05 19:31:13.483197
195	l1a96586o50b4s114cgdxibvq05h	Cumulative-sample-report-with-notes-2017_2-#2.pdf	application/pdf	{"identified":true,"analyzed":true}	local	160483	kkM3DTe9GBHfa3uERWdGCA==	2025-01-05 19:35:25.840409
196	qr2d4jlorra98e7hskwhkvpp8m4o	Cumulative-sample-report-with-notes-2017_2-#2.pdf	application/pdf	{"identified":true,"analyzed":true}	local	160483	kkM3DTe9GBHfa3uERWdGCA==	2025-01-05 19:40:15.488423
197	og4k5rte58vn9l336qf6v3xqn795	Cumulative-sample-report-with-notes-2017_2-#2.pdf	application/pdf	{"identified":true,"analyzed":true}	local	160483	kkM3DTe9GBHfa3uERWdGCA==	2025-01-05 21:51:19.706799
203	i8k72znjp3vwoxn3aq39im93tw9t	sterling-accuris-pathology-sample-report-#1.pdf	application/pdf	{"identified":true,"analyzed":true}	local	6908257	kPmsvYCTQ6SotpaTft5Y3g==	2025-01-05 23:27:23.817483
204	7umc6wncb4nev2lhmh9srs0rvnxk	sterling-accuris-pathology-sample-report-#1.pdf	application/pdf	{"identified":true,"analyzed":true}	local	6908257	kPmsvYCTQ6SotpaTft5Y3g==	2025-01-05 23:27:53.441479
205	gprhozyq2o5qhox5im65p687npn8	sterling-accuris-pathology-sample-report-#1.pdf	application/pdf	{"identified":true,"analyzed":true}	local	6908257	kPmsvYCTQ6SotpaTft5Y3g==	2025-01-05 23:28:46.030329
206	de0fayh1gldo5midp5220pwg1w5o	sterling-accuris-pathology-sample-report-#1.pdf	application/pdf	{"identified":true,"analyzed":true}	local	6908257	kPmsvYCTQ6SotpaTft5Y3g==	2025-01-05 23:32:42.136311
207	c97p03h8uo9dat2d0q9ols4ya2nc	sterling-accuris-pathology-sample-report-#1.pdf	application/pdf	{"identified":true,"analyzed":true}	local	6908257	kPmsvYCTQ6SotpaTft5Y3g==	2025-01-06 00:48:33.674934
208	3ugkb9yvp3wu7ti5sbbehiyoknzp	sterling-accuris-pathology-sample-report-#1.pdf	application/pdf	{"identified":true,"analyzed":true}	local	6908257	kPmsvYCTQ6SotpaTft5Y3g==	2025-01-06 02:21:39.309388
157	t01c0rncqe03pbvcanzjmmw0dd46	sterling-accuris-pathology-sample-report-#1.pdf	application/pdf	{"identified":true,"analyzed":true}	local	6908257	kPmsvYCTQ6SotpaTft5Y3g==	2025-01-03 11:59:55.849369
209	wsvtge87e2o7tveo5hgow10u9l5r	sterling-accuris-pathology-sample-report-#1.pdf	application/pdf	{"identified":true,"analyzed":true}	local	6908257	kPmsvYCTQ6SotpaTft5Y3g==	2025-01-06 02:32:39.170699
210	4qeoq1n9sbbz3qvdi2nlmmi5k5d7	sterling-accuris-pathology-sample-report-#1.pdf	application/pdf	{"identified":true,"analyzed":true}	local	6908257	kPmsvYCTQ6SotpaTft5Y3g==	2025-01-06 09:12:05.94792
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: healthkeeper
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: healthkeeper
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2024-12-31 01:21:37.532669	2024-12-31 01:21:37.532674
\.


--
-- Data for Name: biomarkers; Type: TABLE DATA; Schema: public; Owner: healthkeeper
--

COPY public.biomarkers (id, name, created_at, updated_at) FROM stdin;
2	Hemoglobin	2024-12-31 02:07:26.463905	2024-12-31 02:07:26.463905
1	Hemoglobin Colorimetric	2024-12-31 01:59:45.022365	2024-12-31 02:15:42.864523
4	Hematocrit Calculated	2024-12-31 02:15:42.974475	2024-12-31 02:15:42.991947
5	MCV Derived	2024-12-31 02:15:43.031916	2024-12-31 02:15:43.063908
6	MCH Calculated	2024-12-31 02:15:43.099479	2024-12-31 02:15:43.121301
7	MCHC	2024-12-31 02:15:43.158856	2024-12-31 02:15:43.178133
9	• Total haemoglobin A1 c is continuously synthesized in the red blood cell throught its	2024-12-31 02:15:43.259898	2024-12-31 02:15:43.279791
10	Cholesterol	2024-12-31 02:15:43.316442	2024-12-31 02:15:43.335286
11	Triglyceride H	2024-12-31 02:15:43.477831	2024-12-31 02:15:43.505294
12	HDL Cholesterol	2024-12-31 02:15:43.540191	2024-12-31 02:15:43.557323
13	VLDL	2024-12-31 02:15:43.592072	2024-12-31 02:15:43.614892
14	CHOL/HDL Ratio	2024-12-31 02:15:43.654483	2024-12-31 02:15:43.675243
15	LDL/HDL Ratio	2024-12-31 02:15:43.707761	2024-12-31 02:15:43.724546
16	Fasting Blood Sugar H	2024-12-31 02:15:43.757558	2024-12-31 02:15:43.774774
17	pr Calculated Glucose	2024-12-31 02:15:43.809698	2024-12-31 02:15:43.831107
18	T3 - Triiodothyronine	2024-12-31 02:15:43.872643	2024-12-31 02:15:43.896733
19	T4 - Thyroxine	2024-12-31 02:15:43.9363	2024-12-31 02:15:43.956729
20	RDW CV              Calculated	2025-01-01 11:01:11.334039	2025-01-01 11:01:11.402344
53	RDW CV	2025-01-01 11:13:58.097879	2025-01-01 11:13:58.180399
3	RBC Count Electrical impedance million/cmm	2024-12-31 02:15:42.920443	2025-01-01 11:57:30.695061
8	a WBC Count SF Cube cell analysis /cmm	2024-12-31 02:15:43.210518	2025-01-01 11:57:30.929926
54	RBC Count	2025-01-01 12:08:12.309848	2025-01-01 12:08:12.338797
55	WBC Count	2025-01-01 12:08:12.596762	2025-01-01 12:08:12.621932
56	Glucose	2025-01-03 12:16:33.140731	2025-01-03 12:16:33.239431
57	Hemoglobin A1c (A1c)	2025-01-03 12:16:33.414716	2025-01-03 12:16:33.458765
58	Hemoglobin (HB/Hgb)	2025-01-03 12:16:33.907574	2025-01-03 12:16:34.033956
59	Hematocrit (HCT)	2025-01-03 12:16:34.132919	2025-01-03 12:16:34.171392
60	White Blood Cell (WBC)	2025-01-03 12:21:55.085749	2025-01-03 12:21:55.129773
61	Mean Cell Volume (MCV) L	2025-01-03 12:21:55.250857	2025-01-03 12:21:55.283205
62	Mean Cell Hemoglobin (MCH) P	2025-01-03 12:21:55.345105	2025-01-03 12:21:55.381147
63	Mean Cell Hb Conc (MCHC)	2025-01-03 12:21:55.445839	2025-01-03 12:21:55.489621
64	Comment: **Hgb of	2025-01-03 12:21:55.553627	2025-01-03 12:21:55.593814
\.


--
-- Data for Name: health_records; Type: TABLE DATA; Schema: public; Owner: healthkeeper
--

COPY public.health_records (id, user_id, notes, created_at, updated_at) FROM stdin;
163	1	Auto-generated for existing PDF 20	2025-01-03 21:48:47.214436	2025-01-03 21:48:47.214436
164	1	Auto-generated for existing PDF 21	2025-01-03 21:48:47.260795	2025-01-03 21:48:47.260795
165	1	Auto-generated for existing PDF 22	2025-01-03 21:48:47.273303	2025-01-03 21:48:47.273303
167	1	Health record for PDF upload	2025-01-03 21:52:33.44996	2025-01-03 21:52:33.44996
168	1	Health record for PDF upload	2025-01-03 21:54:29.418481	2025-01-03 21:54:29.418481
169	1	Health record for PDF upload	2025-01-03 21:54:35.75106	2025-01-03 21:54:35.75106
170	1	Health record for PDF upload	2025-01-03 22:01:30.313412	2025-01-03 22:01:30.313412
171	1	Health record for PDF upload	2025-01-03 22:05:53.021236	2025-01-03 22:05:53.021236
157	1		2025-01-03 11:59:55.832618	2025-01-03 12:00:16.624138
172	1	Health record for PDF upload	2025-01-03 22:05:57.875549	2025-01-03 22:05:57.875549
173	1	Health record for PDF upload	2025-01-03 22:11:30.729031	2025-01-03 22:11:30.729031
174	1	Health record for PDF upload	2025-01-05 06:30:00.474247	2025-01-05 06:30:00.474247
175	1	Health record for PDF upload	2025-01-05 11:29:12.983673	2025-01-05 11:29:12.983673
176	1	Health record for PDF upload	2025-01-05 19:28:02.375745	2025-01-05 19:28:02.375745
177	1	Health record for PDF upload	2025-01-05 19:28:05.084382	2025-01-05 19:28:05.084382
178	1	Health record for PDF upload	2025-01-05 19:31:13.420292	2025-01-05 19:31:13.420292
179	1	Health record for PDF upload	2025-01-05 19:35:25.782696	2025-01-05 19:35:25.782696
180	1	Health record for PDF upload	2025-01-05 19:40:15.356965	2025-01-05 19:40:15.356965
181	1	Health record for PDF upload	2025-01-05 21:51:19.542833	2025-01-05 21:51:19.542833
182	1	Health record for PDF upload	2025-01-05 23:27:23.690771	2025-01-05 23:27:23.690771
183	1	Health record for PDF upload	2025-01-05 23:27:53.388637	2025-01-05 23:27:53.388637
184	1	Health record for PDF upload	2025-01-05 23:28:45.851813	2025-01-05 23:28:45.851813
185	1	Health record for PDF upload	2025-01-05 23:32:41.923853	2025-01-05 23:32:41.923853
186	1	Health record for PDF upload	2025-01-06 00:48:33.581665	2025-01-06 00:48:33.581665
187	1	Health record for PDF upload	2025-01-06 02:21:39.173256	2025-01-06 02:21:39.173256
188	1	Health record for PDF upload	2025-01-06 02:32:39.085156	2025-01-06 02:32:39.085156
189	1	Auto-generated for existing PDF 30	2025-01-06 09:10:06.57007	2025-01-06 09:10:06.57007
190	1	Auto-generated for existing PDF 31	2025-01-06 09:10:06.599906	2025-01-06 09:10:06.599906
191	1	Auto-generated for existing PDF 32	2025-01-06 09:10:06.607827	2025-01-06 09:10:06.607827
192	1	Auto-generated for existing PDF 33	2025-01-06 09:10:06.623796	2025-01-06 09:10:06.623796
193	1	Auto-generated for existing PDF 34	2025-01-06 09:10:06.632744	2025-01-06 09:10:06.632744
194	1	Auto-generated for existing PDF 35	2025-01-06 09:10:06.6397	2025-01-06 09:10:06.6397
195	1	Auto-generated for existing PDF 36	2025-01-06 09:10:06.64906	2025-01-06 09:10:06.64906
196	1	Auto-generated for existing PDF 37	2025-01-06 09:10:06.657436	2025-01-06 09:10:06.657436
197	1	Auto-generated for existing PDF 38	2025-01-06 09:10:06.665291	2025-01-06 09:10:06.665291
198	1	Auto-generated for existing PDF 39	2025-01-06 09:10:06.672519	2025-01-06 09:10:06.672519
199	1	Auto-generated for existing PDF 40	2025-01-06 09:10:06.683821	2025-01-06 09:10:06.683821
200	1	Auto-generated for existing PDF 41	2025-01-06 09:10:06.694348	2025-01-06 09:10:06.694348
201	1	Auto-generated for existing PDF 42	2025-01-06 09:10:06.702903	2025-01-06 09:10:06.702903
202	1	Auto-generated for existing PDF 43	2025-01-06 09:10:06.711084	2025-01-06 09:10:06.711084
203	1	Auto-generated for existing PDF 44	2025-01-06 09:10:06.718482	2025-01-06 09:10:06.718482
204	1	Auto-generated for existing PDF 45	2025-01-06 09:10:06.726409	2025-01-06 09:10:06.726409
205	1	Auto-generated for existing PDF 46	2025-01-06 09:10:06.735535	2025-01-06 09:10:06.735535
206	1	Auto-generated for existing PDF 47	2025-01-06 09:10:06.742363	2025-01-06 09:10:06.742363
207	1	Auto-generated for existing PDF 48	2025-01-06 09:10:06.754357	2025-01-06 09:10:06.754357
208	1	Auto-generated for existing PDF 49	2025-01-06 09:10:06.762945	2025-01-06 09:10:06.762945
209	1	Auto-generated for existing PDF 50	2025-01-06 09:10:06.770574	2025-01-06 09:10:06.770574
210	1	Health record for PDF upload	2025-01-06 09:12:05.823638	2025-01-06 09:12:05.823638
\.


--
-- Data for Name: lab_tests; Type: TABLE DATA; Schema: public; Owner: healthkeeper
--

COPY public.lab_tests (id, user_id, biomarker_id, value, unit, reference_range_id, recordable_type, recordable_id, notes, created_at, updated_at) FROM stdin;
924	1	1	14.5	g/dL	1	HealthRecord	157	\N	2025-01-03 12:00:15.091429	2025-01-03 12:00:15.091429
925	1	54	4.5	million/cmm	55	HealthRecord	157	Electrical impedance	2025-01-03 12:00:15.184893	2025-01-03 12:00:15.184893
926	1	4	43.3	%	3	HealthRecord	157	\N	2025-01-03 12:00:15.255505	2025-01-03 12:00:15.255505
927	1	5	90.3	fL	4	HealthRecord	157	\N	2025-01-03 12:00:15.326774	2025-01-03 12:00:15.326774
928	1	6	30.2	pg	5	HealthRecord	157	\N	2025-01-03 12:00:15.387741	2025-01-03 12:00:15.387741
929	1	7	33.4	g/dL	6	HealthRecord	157	Calculated	2025-01-03 12:00:15.443822	2025-01-03 12:00:15.443822
930	1	53	13.6	%	52	HealthRecord	157	Calculated	2025-01-03 12:00:15.520345	2025-01-03 12:00:15.520345
931	1	55	4000.0	thousand/cmm	56	HealthRecord	157	Electrical impedance	2025-01-03 12:00:15.586315	2025-01-03 12:00:15.586315
932	1	9	120.0	days	8	HealthRecord	157	\N	2025-01-03 12:00:15.655852	2025-01-03 12:00:15.655852
933	1	10	189.0	mg/dL	9	HealthRecord	157	Colorimetric	2025-01-03 12:00:15.728714	2025-01-03 12:00:15.728714
934	1	11	168.0	mg/dL	10	HealthRecord	157	\N	2025-01-03 12:00:15.783842	2025-01-03 12:00:15.783842
935	1	12	60.0	mg/dL	11	HealthRecord	157	Colorimetric	2025-01-03 12:00:15.83847	2025-01-03 12:00:15.83847
936	1	13	33.6	mg/dL	12	HealthRecord	157	Calculated	2025-01-03 12:00:15.899412	2025-01-03 12:00:15.899412
937	1	14	3.1	Up	13	HealthRecord	157	\N	2025-01-03 12:00:15.955873	2025-01-03 12:00:15.955873
938	1	15	1.7	Up	14	HealthRecord	157	\N	2025-01-03 12:00:16.014352	2025-01-03 12:00:16.014352
939	1	16	141.0	mg/dL	15	HealthRecord	157	\N	2025-01-03 12:00:16.070971	2025-01-03 12:00:16.070971
940	1	17	157.07	mg/dL	16	HealthRecord	157	\N	2025-01-03 12:00:16.136021	2025-01-03 12:00:16.136021
941	1	18	1.01	ng/mL	17	HealthRecord	157	\N	2025-01-03 12:00:16.204113	2025-01-03 12:00:16.204113
942	1	19	7.84	mg/mL	18	HealthRecord	157	\N	2025-01-03 12:00:16.611913	2025-01-03 12:00:16.611913
651	1	1	14.5	g/dL	1	HealthRecord	112	\N	2025-01-01 12:49:27.766868	2025-01-01 12:49:27.766868
652	1	54	4.5	million/cmm	55	HealthRecord	112	Electrical impedance	2025-01-01 12:49:27.854731	2025-01-01 12:49:27.854731
653	1	4	43.3	%	3	HealthRecord	112	\N	2025-01-01 12:49:27.931005	2025-01-01 12:49:27.931005
654	1	5	90.3	fL	4	HealthRecord	112	\N	2025-01-01 12:49:28.000306	2025-01-01 12:49:28.000306
655	1	6	30.2	pg	5	HealthRecord	112	\N	2025-01-01 12:49:28.062764	2025-01-01 12:49:28.062764
656	1	7	33.4	g/dL	6	HealthRecord	112	Calculated	2025-01-01 12:49:28.113624	2025-01-01 12:49:28.113624
657	1	53	13.6	%	52	HealthRecord	112	Calculated	2025-01-01 12:49:28.171811	2025-01-01 12:49:28.171811
658	1	9	120.0	days	8	HealthRecord	112	\N	2025-01-01 12:49:28.236542	2025-01-01 12:49:28.236542
659	1	10	189.0	mg/dL	9	HealthRecord	112	Colorimetric	2025-01-01 12:49:28.300644	2025-01-01 12:49:28.300644
660	1	11	168.0	mg/dL	10	HealthRecord	112	\N	2025-01-01 12:49:28.377773	2025-01-01 12:49:28.377773
661	1	12	60.0	mg/dL	11	HealthRecord	112	Colorimetric	2025-01-01 12:49:28.446041	2025-01-01 12:49:28.446041
662	1	13	33.6	mg/dL	12	HealthRecord	112	Calculated	2025-01-01 12:49:28.510044	2025-01-01 12:49:28.510044
663	1	14	3.1	Up	13	HealthRecord	112	\N	2025-01-01 12:49:28.575433	2025-01-01 12:49:28.575433
664	1	15	1.7	Up	14	HealthRecord	112	\N	2025-01-01 12:49:28.643715	2025-01-01 12:49:28.643715
665	1	16	141.0	mg/dL	15	HealthRecord	112	\N	2025-01-01 12:49:28.711404	2025-01-01 12:49:28.711404
666	1	17	157.07	mg/dL	16	HealthRecord	112	\N	2025-01-01 12:49:28.774286	2025-01-01 12:49:28.774286
667	1	18	1.01	ng/mL	17	HealthRecord	112	\N	2025-01-01 12:49:28.841834	2025-01-01 12:49:28.841834
668	1	19	7.84	mg/mL	18	HealthRecord	112	\N	2025-01-01 12:49:28.900779	2025-01-01 12:49:28.900779
\.


--
-- Data for Name: measurements; Type: TABLE DATA; Schema: public; Owner: healthkeeper
--

COPY public.measurements (id, user_id, measurement_type, value, source, recordable_type, recordable_id, notes, created_at, updated_at, unit) FROM stdin;
\.


--
-- Data for Name: pdfs; Type: TABLE DATA; Schema: public; Owner: healthkeeper
--

COPY public.pdfs (id, created_at, updated_at, scan_method, status, processed_data, notes, health_record_id, user_id) FROM stdin;
30	2025-01-03 22:11:30.771977	2025-01-03 22:11:55.592604	sterling_accuris	completed	{"Protein": [{"name": "Unconjugated Bilirubin", "unit": "mg/dL", "value": "0.2", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "Delta Bilirubin", "unit": "mg/dL", "value": "0.2", "method": "Standard Method", "biological_ref_interval": "0"}], "Blood Group": [{"name": "ABO Type", "unit": "-", "value": "\\"A\\"", "method": "Blood Typing", "biological_ref_interval": "-"}, {"name": "Rh (D) Type", "unit": "-", "value": "Positive", "method": "Blood Typing", "biological_ref_interval": "-"}], "Immunoassay": [{"name": "Homocysteine, Serum", "unit": "micromol/L", "value": "0", "method": "Standard Method", "biological_ref_interval": "6"}, {"name": "25(OH) Vitamin D", "unit": "ng/mL", "value": "8.98", "method": "HPLC", "biological_ref_interval": "Deficiency"}, {"name": "Vitamin B12", "unit": "pg/mL", "value": "0", "method": "HPLC", "biological_ref_interval": "187"}, {"name": "Vitamin B12", "unit": "-", "value": "is essential in DNA synthesis, hematopoiesis, and CNS integrity.", "method": "HPLC", "biological_ref_interval": "-"}, {"name": "PSA-Prostate Specific Antigen, Total", "unit": "ng/mL", "value": "0.57", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "IgE", "unit": "IU/mL", "value": "0", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "HIV I & II Ab/Ag with P24 Ag", "unit": "S/Co", "value": "0.07", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "HBsAg", "unit": "S/Co", "value": "0.29", "method": "Standard Method", "biological_ref_interval": "0"}], "Biochemistry": [{"name": "Fasting Blood Sugar", "unit": "mg/dL", "value": "0", "method": "Hexokinase", "biological_ref_interval": "74"}, {"name": "Microalbumin (per urine volume)", "unit": "mg/L", "value": "10.5", "method": "Spectrophotometry", "biological_ref_interval": "0"}, {"name": "Creatinine, Serum", "unit": "mg/dL", "value": "0.83", "method": "Standard Method", "biological_ref_interval": "0.66"}, {"name": "Urea", "unit": "mg/dL", "value": "0", "method": "Standard Method", "biological_ref_interval": "19.3"}, {"name": "Blood Urea Nitrogen", "unit": "mg/dL", "value": "0", "method": "Standard Method", "biological_ref_interval": "9"}, {"name": "Uric Acid", "unit": "mg/dL", "value": "4.9", "method": "Standard Method", "biological_ref_interval": "3.5"}, {"name": "Calcium", "unit": "mg/dL", "value": "9.1", "method": "Standard Method", "biological_ref_interval": "8.4"}], "Electrolytes": [{"name": "Sodium (Na+)", "unit": "mmol/L", "value": "143", "method": "Standard Method", "biological_ref_interval": "136"}, {"name": "Potassium (K+)", "unit": "mmol/L", "value": "4.9", "method": "Standard Method", "biological_ref_interval": "3.5"}, {"name": "Chloride (Cl-)", "unit": "mmol/L", "value": "105", "method": "Standard Method", "biological_ref_interval": "98"}], "Iron Studies": [{"name": "Iron", "unit": "micro g/dL", "value": "103", "method": "Standard Method", "biological_ref_interval": "49"}, {"name": "Total Iron Binding Capacity (TIBC)", "unit": "261", "value": "352", "method": "Standard Method", "biological_ref_interval": "-"}], "Lipid Profile": [{"name": "Cholesterol", "unit": "mg/dL", "value": "189", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "Cholesterol", "unit": "-", "value": "oxidase – Peroxidase method", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Triglyceride", "unit": "mg/dL", "value": "0", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "HDL Cholesterol", "unit": "mg/dL", "value": "60", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "VLDL", "unit": "mg/dL", "value": "33.6", "method": "Standard Method", "biological_ref_interval": "15"}, {"name": "CHOL/HDL Ratio", "unit": "0", "value": "3.1", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "LDL/HDL Ratio", "unit": "0", "value": "1.7", "method": "Standard Method", "biological_ref_interval": "-"}], "Differential Count": [{"name": "Neutrophils", "unit": "%", "value": "73", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Lymphocytes", "unit": "%", "value": "19", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Eosinophils", "unit": "%", "value": "2", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Monocytes", "unit": "%", "value": "6", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Basophils", "unit": "%", "value": "0", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Platelet Count", "unit": "150000", "value": "/cmm", "method": "0", "biological_ref_interval": "-"}, {"name": "MPV", "unit": "14", "value": "H", "method": "Calculated", "biological_ref_interval": "-"}], "Complete Blood Count": [{"name": "Hemoglobin", "unit": "g/dL", "value": "14.5", "method": "Colorimetric", "biological_ref_interval": "13"}, {"name": "RBC Count", "unit": "4.5", "value": "million/cmm", "method": "Electrical impedance", "biological_ref_interval": "-"}, {"name": "Hematocrit", "unit": "%", "value": "43.3", "method": "Calculated", "biological_ref_interval": "40"}, {"name": "MCV", "unit": "fL", "value": "90.3", "method": "Derived", "biological_ref_interval": "83"}, {"name": "MCH", "unit": "pg", "value": "30.2", "method": "Calculated", "biological_ref_interval": "27.1"}, {"name": "MCHC", "unit": "32.5", "value": "g/dL", "method": "33.4", "biological_ref_interval": "-"}, {"name": "RDW CV", "unit": "%", "value": "13.6", "method": "Calculated", "biological_ref_interval": "11.6"}], "Thyroid Function Test": [{"name": "T3 - Triiodothyronine", "unit": "ng/mL", "value": "1.01", "method": "CLIA", "biological_ref_interval": "0.58"}, {"name": "T4 - Thyroxine", "unit": "mg/mL", "value": "7.84", "method": "CLIA", "biological_ref_interval": "4.87"}], "Microscopic Examination": [{"name": "Pus Cells", "unit": "Absent", "value": "1", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Red Cells", "unit": "/hpf", "value": "Not Detected", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "Epithelial Cells", "unit": "/hpf", "value": "1", "method": "Standard Method", "biological_ref_interval": "."}, {"name": "Casts", "unit": "/hpf", "value": "Absent", "method": "Standard Method", "biological_ref_interval": "Absent"}, {"name": "Crystals", "unit": "/hpf", "value": "Absent", "method": "Standard Method", "biological_ref_interval": "Absent"}, {"name": "Amorphous Material", "unit": "-", "value": "Absent", "method": "Standard Method", "biological_ref_interval": "-"}], "HB Electrophoresis By HPLC": [{"name": "Hb A", "unit": "%", "value": "0", "method": "Standard Method", "biological_ref_interval": "96.8"}, {"name": "Hb A2", "unit": "%", "value": "2.8", "method": "Standard Method", "biological_ref_interval": "2.2"}, {"name": "P2 Peak", "unit": "%", "value": "5.5", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "P3 Peak", "unit": "%", "value": "5.2", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Foetal Hb", "unit": "%", "value": "0.3", "method": "Standard Method", "biological_ref_interval": "0"}], "Peripheral Smear Examination": [{"name": "RBC Morphology", "unit": null, "value": "Normochromic Normocytic", "method": "Microscopy", "biological_ref_interval": "-"}, {"name": "WBC Morphology", "unit": null, "value": "WBCs Series Shows Normal Morphology", "method": "Microscopy", "biological_ref_interval": "-"}, {"name": "Platelets Morphology", "unit": null, "value": "Platelets are adequate with normal morphology.", "method": "Microscopy", "biological_ref_interval": "-"}, {"name": "Parasites", "unit": null, "value": "Malarial parasite is not detected.", "method": "Microscopy", "biological_ref_interval": "-"}], "Erythrocyte Sedimentation Rate": [{"name": "ESR", "unit": "0", "value": "Capillary photometry", "method": "Standard Method", "biological_ref_interval": "0"}], "HbA1c (Glycosylated Hemoglobin)": [{"name": "HbA1c", "unit": "-", "value": "assay Interferences", "method": "Standard Method", "biological_ref_interval": "-"}], "Physical & Chemical (Dip strip) examination": [{"name": "Colour", "unit": "Pale Yellow", "value": "Pale Yellow", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Clearity", "unit": "Clear", "value": "Clear", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "pH", "unit": "4.6", "value": "6", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Specific Gravity", "unit": "1", "value": "1.03", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Urine Glucose", "unit": "Absent", "value": "Present (+)", "method": "Hexokinase", "biological_ref_interval": "-"}]}	\N	189	1
31	2025-01-05 06:30:00.621465	2025-01-05 06:30:02.094308	umc_pathology	completed	{}	\N	190	1
32	2025-01-05 11:29:13.099398	2025-01-05 11:29:15.519995	umc_pathology	completed	{"categories": {}, "patient_info": {"dob": "01/01/1941", "name": null, "medical_record_number": null}}	\N	191	1
33	2025-01-05 19:28:02.43819	2025-01-05 19:28:04.755432	umc_pathology	completed	{"categories": {}, "patient_info": {"dob": "01/01/1941"}}	\N	192	1
34	2025-01-05 19:28:05.098751	2025-01-05 19:28:07.308456	umc_pathology	completed	{"categories": {}, "patient_info": {"dob": "01/01/1941"}}	\N	193	1
38	2025-01-05 21:51:19.671717	2025-01-05 21:51:22.581002	umc_pathology	completed	{"categories": {"have_b_en_made_up_for_illustrative_purposes_o_ly._this_report_is_an_ex_mple_of_a_cumulative_report,_which": [{"flag": "University", "name": "1", "unit": null, "value": 123.0, "status": "Final", "reference_range": "Not provided"}, {"flag": null, "name": "4  Patient ID", "unit": "Status", "value": 987654321.0, "status": "Final", "reference_range": "Not provided"}, {"flag": "3", "name": "N                                      Folaten B12 (B12)", "unit": null, "value": 250.0, "status": "Final", "reference_range": "Not provided"}, {"flag": null, "name": "14", "unit": "16", "value": 15.0, "status": "Final", "reference_range": "17"}, {"flag": "Comment", "name": "BASIC METABOLIC PANEL (BMP)", "unit": null, "value": 21.0, "status": "Final", "reference_range": "Not provided"}, {"flag": "E", "name": "Sodium (Na)", "unit": null, "value": 124.0, "status": "Final", "reference_range": "Not provided"}, {"flag": null, "name": "Carbon Dioxide (CO2)", "unit": "L", "value": 25.0, "status": "Final", "reference_range": "5.8"}, {"flag": "P", "name": "Chloride (Cl)", "unit": null, "value": 101.0, "status": "Final", "reference_range": "Not provided"}, {"flag": "H", "name": "Glucose", "unit": "mg/dL", "value": 107.0, "status": "Final", "reference_range": "74-100"}, {"flag": null, "name": "Blood Urea Nitrogen (BUN)", "unit": "mg/dL", "value": 1171.0, "status": "Final", "reference_range": "8-2310.2"}, {"flag": null, "name": "Creatinine                       M", "unit": "mg/dL", "value": 0.9, "status": "Final", "reference_range": "0.8-1.3"}, {"flag": "L", "name": "Hemoglobin (HB/Hgb)", "unit": null, "value": 7.0, "status": "Final", "reference_range": "Not provided"}, {"flag": "L", "name": "Hematocrit (HCT)", "unit": null, "value": 21.1, "status": "Final", "reference_range": "Not provided"}]}, "debug_info": ["[21:51:21.509] Opening PDF file: /tmp/temp_pdf20250105-46-814n5k.pdf", "[21:51:21.528] Processing page 1", "[21:51:22.049] Raw text sample:                                                                                                                                                                                                          ...", "[21:51:22.051] Found 47 lines to process", "[21:51:22.053] Parsing patient information", "[21:51:22.055] Found dob: 01/01/1941", "[21:51:22.059] Starting to parse test results", "[21:51:22.061] Raw lines sample: 1.  Name and address of the lab where the test was performed. Tests may be run\\\\nhttps://labtestsonline.org                                                                                           in a physician office lab, a lab located in a clinic or hospital, and/or samples\\\\nCUMULATIVE SAMPLE REPORT                                                                                                                                                                                       may be sent to a reference laboratory for analysis.\\\\nDifferent laboratories generate reports that can vary greatly in appearance and in the order and kind of                                                                                                                                     2.  Date this copy of the report was printed. This date may be different than the\\\\ninformation included. This is one example of what a lab report may look like. Names and places used                                                                                                                                              include results of several different tests run on different days).(those that\\\\nhave b en made up for illustrative purposes o ly. This report is an ex mple of a cumulative report, which", "[21:51:22.063] Processing line: '1.  Name and address of the lab where the test was performed. Tests may be run'", "[21:51:22.064] Processing line: 'https://labtestsonline.org                                                                                           in a physician office lab, a lab located in a clinic or hospital, and/or samples'", "[21:51:22.066] Processing line: 'CUMULATIVE SAMPLE REPORT                                                                                                                                                                                       may be sent to a reference laboratory for analysis.'", "[21:51:22.069] Processing line: 'Different laboratories generate reports that can vary greatly in appearance and in the order and kind of                                                                                                                                     2.  Date this copy of the report was printed. This date may be different than the'", "[21:51:22.070] Processing line: 'information included. This is one example of what a lab report may look like. Names and places used                                                                                                                                              include results of several different tests run on different days).(those that'", "[21:51:22.072] Processing line: 'have b en made up for illustrative purposes o ly. This report is an ex mple of a cumulative report, which'", "[21:51:22.074] Found category header: have_b_en_made_up_for_illustrative_purposes_o_ly._this_report_is_an_ex_mple_of_a_cumulative_report,_which", "[21:51:22.077] Processing line: 'ris a report that includes results of several different tests run on different days. Point your cursor at a                                                               Reported Date/Time:        02/12/14      14:40                     4.  Patient identifier and identification number. Links results to the correct person.'", "[21:51:22.081] Attempting to match line: ris a report that includes results of several different tests run on different days. Point your cursor at a                                                               Reported Date/Time:        02/12/14      14:40                     4.  Patient identifier and identification number. Links results to the correct person.", "[21:51:22.083] Processing line: 'number to learn about the different report elements.                                                                    SPECIMEN:       Plasma                                                                                              5.  practitioners listed.ab will send the results to the doctor(s) or other health'", "[21:51:22.085] Attempting to match line: number to learn about the different report elements.                                                                    SPECIMEN:       Plasma                                                                                              5.  practitioners listed.ab will send the results to the doctor(s) or other health", "[21:51:22.087] Processing line: 'ORDERED:        Human Immunodeficiency Virus RNA, Quantitative (HIV-1 RNA Quant)             Reference'", "[21:51:22.088] Attempting to match line: ORDERED:        Human Immunodeficiency Virus RNA, Quantitative (HIV-1 RNA Quant)             Reference", "[21:51:22.090] Processing line: '1  123 University Way, City, ST 12345f Pathology                      02/14/2014e/Time:   16:13    2                       Test                                Normal          Abnormal        Flag       Units           Range                6.  are affected by medications, vitamins and other health supplements, soults'", "[21:51:22.093] Attempting to match line: 1  123 University Way, City, ST 12345f Pathology                      02/14/2014e/Time:   16:13    2                       Test                                Normal          Abnormal        Flag       Units           Range                6.  are affected by medications, vitamins and other health supplements, soults", "[21:51:22.094] Matched pattern for: 1", "[21:51:22.096] Found test data: {:name=>\\"1\\", :value=>123.0, :flag=>\\"University\\", :unit=>nil, :reference_range=>\\"Not provided\\", :status=>\\"Final\\"}", "[21:51:22.097] Processing line: 'HIV-1 RNA Quant                  Less than 75                                 Copies/mL     Less than 75                laboratories may obtain this information from the test request form and'", "[21:51:22.100] Attempting to match line: HIV-1 RNA Quant                  Less than 75                                 Copies/mL     Less than 75                laboratories may obtain this information from the test request form and", "[21:51:22.101] Processing line: '3  Name:           Doe, John Q.          Age/Sex: 73/M                DOB:                01/01/1941                       Flag Key: L= Abnormal Low, H= Abnormal High, *= critical value                                                          transcribe it onto the lab report.'", "[21:51:22.103] Attempting to match line: 3  Name:           Doe, John Q.          Age/Sex: 73/M                DOB:                01/01/1941                       Flag Key: L= Abnormal Low, H= Abnormal High, *= critical value                                                          transcribe it onto the lab report.", "[21:51:22.104] Processing line: '4  Patient ID:     987654321                                          Status:             Routine    7                                                                                                                                         7.  Status of the test request, such as Routine or STAT (perform test as rapidly as'", "[21:51:22.106] Attempting to match line: 4  Patient ID:     987654321                                          Status:             Routine    7                                                                                                                                         7.  Status of the test request, such as Routine or STAT (perform test as rapidly as", "[21:51:22.107] Matched pattern for: 4  Patient ID", "[21:51:22.110] Found test data: {:name=>\\"4  Patient ID\\", :value=>987654321.0, :flag=>nil, :unit=>\\"Status\\", :reference_range=>\\"Not provided\\", :status=>\\"Final\\"}", "[21:51:22.112] Processing line: '5  Ordering Dr:    Smith, Peter MD                         Physician Copy for:            Smith, Jane MD               20  Comment: Test performed by PDQ Reference Laboratory, 2222 University Way, City, ST 12345                                possible).'", "[21:51:22.113] Attempting to match line: 5  Ordering Dr:    Smith, Peter MD                         Physician Copy for:            Smith, Jane MD               20  Comment: Test performed by PDQ Reference Laboratory, 2222 University Way, City, ST 12345                                possible).", "[21:51:22.115] Processing line: '6  Patient Medications:     multivitamins                                                                                                  223460                           Collection Date/Time:      02/10/14      14:30                     8.  arrives at the laboratory.er(s). Number(s) assigned to the sample(s) when it'", "[21:51:22.116] Attempting to match line: 6  Patient Medications:     multivitamins                                                                                                  223460                           Collection Date/Time:      02/10/14      14:30                     8.  arrives at the laboratory.er(s). Number(s) assigned to the sample(s) when it", "[21:51:22.118] Processing line: '223456                           Collection Date/Time:      02/10/14   14:30                            SPEC #:                                          Received Date/Time:        02/10/14      15:00'", "[21:51:22.119] Attempting to match line: 223456                           Collection Date/Time:      02/10/14   14:30                            SPEC #:                                          Received Date/Time:        02/10/14      15:00", "[21:51:22.120] Processing line: '8  SPEC #:                                          Received Date/Time:        02/10/14   15:00  11                                                                         Reported Date/Time:        02/11/14      11:40                     9.  sample (such as blood, serum, plasma, cerebrospinal fluid, etc.).e of'", "[21:51:22.121] Attempting to match line: 8  SPEC #:                                          Received Date/Time:        02/10/14   15:00  11                                                                         Reported Date/Time:        02/11/14      11:40                     9.  sample (such as blood, serum, plasma, cerebrospinal fluid, etc.).e of", "[21:51:22.124] Processing line: 'Reported Date/Time:        02/10/14   16:40  12Y                       ORDERED::       Vitamin B12, Folate                                                               Y                 10. Information about the patient or the sample. Any pertinent information'", "[21:51:22.125] Attempting to match line: Reported Date/Time:        02/10/14   16:40  12Y                       ORDERED::       Vitamin B12, Folate                                                               Y                 10. Information about the patient or the sample. Any pertinent information", "[21:51:22.126] Processing line: '9  ORDERED::       Basic Metabolic Panel (BMP)                                                L                                                                                                                         Reference                  regarding the patient’s test preparation or the condition of specimen may be'", "[21:51:22.128] Attempting to match line: 9  ORDERED::       Basic Metabolic Panel (BMP)                                                L                                                                                                                         Reference                  regarding the patient’s test preparation or the condition of specimen may be", "[21:51:22.130] Processing line: '10  COMMENTS:       Specimen is non-fasting: slight hemolysis                                                               Test                                Normal          Abnormal        Flag       Units           Range                    noted here.'", "[21:51:22.131] Attempting to match line: 10  COMMENTS:       Specimen is non-fasting: slight hemolysis                                                               Test                                Normal          Abnormal        Flag       Units           Range                    noted here.", "[21:51:22.132] Processing line: 'N                                      Folaten B12 (B12)                    250                3.2           L       ng/mLN      See Evaluation            11. The date and time of sample collection and the date and time that the sample'", "[21:51:22.133] Attempting to match line: N                                      Folaten B12 (B12)                    250                3.2           L       ng/mLN      See Evaluation            11. The date and time of sample collection and the date and time that the sample", "[21:51:22.135] Matched pattern for: N                                      Folaten B12 (B12)", "[21:51:22.137] Found test data: {:name=>\\"N                                      Folaten B12 (B12)\\", :value=>250.0, :flag=>\\"3\\", :unit=>nil, :reference_range=>\\"Not provided\\", :status=>\\"Final\\"}", "[21:51:22.139] Processing line: '14                15           16        17              18                                                                                                                                               was received into the laboratory'", "[21:51:22.140] Attempting to match line: 14                15           16        17              18                                                                                                                                               was received into the laboratory", "[21:51:22.143] Matched pattern for: 14", "[21:51:22.145] Found test data: {:name=>\\"14\\", :value=>15.0, :flag=>nil, :unit=>\\"16\\", :reference_range=>\\"17\\", :status=>\\"Final\\"}", "[21:51:22.146] Processing line: '13  Test                                Normal          Abnormal        FlOg      Units     Reference Range                 Flag Key: L= Abnormal Low, H= Abnormal High, *= critical value          O                                           12. Test report date. This is the date the tests results were generated and'", "[21:51:22.147] Attempting to match line: 13  Test                                Normal          Abnormal        FlOg      Units     Reference Range                 Flag Key: L= Abnormal Low, H= Abnormal High, *= critical value          O                                           12. Test report date. This is the date the tests results were generated and", "[21:51:22.149] Processing line: 'BASIC METABOLIC PANEL (BMP)                                                                                         21  Comment: Evaluation: ˃5.4 ng/mL = Normal                                                                                reported for this particular sample.'", "[21:51:22.150] Attempting to match line: BASIC METABOLIC PANEL (BMP)                                                                                         21  Comment: Evaluation: ˃5.4 ng/mL = Normal                                                                                reported for this particular sample.", "[21:51:22.151] Matched pattern for: BASIC METABOLIC PANEL (BMP)", "[21:51:22.152] Found test data: {:name=>\\"BASIC METABOLIC PANEL (BMP)\\", :value=>21.0, :flag=>\\"Comment\\", :unit=>nil, :reference_range=>\\"Not provided\\", :status=>\\"Final\\"}", "[21:51:22.154] Processing line: 'Sodium (Na)                                            124 E          L       mEq/L         136-145                                 Evaluation: 3.4-5.4 ng/mL = Borderline          E                                                       13. abbreviated on lab reports. You can look for these test names in the'", "[21:51:22.155] Attempting to match line: Sodium (Na)                                            124 E          L       mEq/L         136-145                                 Evaluation: 3.4-5.4 ng/mL = Borderline          E                                                       13. abbreviated on lab reports. You can look for these test names in the", "[21:51:22.158] Matched pattern for: Sodium (Na)", "[21:51:22.159] Found test data: {:name=>\\"Sodium (Na)\\", :value=>124.0, :flag=>\\"E\\", :unit=>nil, :reference_range=>\\"Not provided\\", :status=>\\"Final\\"}", "[21:51:22.162] Processing line: 'Carbon Dioxide (CO2)                  25            L   5.8           H       mEq/L         23-29.1                                 Evaluation: <3.4 ng/mL = Low              L                                                                 pull-down menu on the home page of this site or type the name into the'", "[21:51:22.165] Attempting to match line: Carbon Dioxide (CO2)                  25            L   5.8           H       mEq/L         23-29.1                                 Evaluation: <3.4 ng/mL = Low              L                                                                 pull-down menu on the home page of this site or type the name into the", "[21:51:22.168] Matched pattern for: Carbon Dioxide (CO2)", "[21:51:22.172] Found test data: {:name=>\\"Carbon Dioxide (CO2)\\", :value=>25.0, :flag=>nil, :unit=>\\"L\\", :reference_range=>\\"5.8\\", :status=>\\"Final\\"}", "[21:51:22.173] Processing line: 'Chloride (Cl)                        101    P                                 mEq/L         98-107                                                                    P                                                                         search box to find information on specific tests.'", "[21:51:22.178] Attempting to match line: Chloride (Cl)                        101    P                                 mEq/L         98-107                                                                    P                                                                         search box to find information on specific tests.", "[21:51:22.180] Matched pattern for: Chloride (Cl)", "[21:51:22.182] Found test data: {:name=>\\"Chloride (Cl)\\", :value=>101.0, :flag=>\\"P\\", :unit=>nil, :reference_range=>\\"Not provided\\", :status=>\\"Final\\"}", "[21:51:22.183] Processing line: 'Glucose                                                107            H       mg/dL         74-100                                      223725                           Collection Date/Time:      02/11/14      12:30                     14. A listing of the results that are normal.'", "[21:51:22.184] Attempting to match line: Glucose                                                107            H       mg/dL         74-100                                      223725                           Collection Date/Time:      02/11/14      12:30                     14. A listing of the results that are normal.", "[21:51:22.185] Matched pattern for: Glucose", "[21:51:22.190] Found test data: {:name=>\\"Glucose\\", :value=>107.0, :flag=>\\"H\\", :unit=>\\"mg/dL\\", :reference_range=>\\"74-100\\", :status=>\\"Final\\"}", "[21:51:22.192] Processing line: 'Blood Urea Nitrogen (BUN)            1171                                     mg/dL         8-2310.2                    SPEC #:                                          Received Date/Time:        02/11/14      13:00                     15. A listing of the results that are abnormal.'", "[21:51:22.194] Attempting to match line: Blood Urea Nitrogen (BUN)            1171                                     mg/dL         8-2310.2                    SPEC #:                                          Received Date/Time:        02/11/14      13:00                     15. A listing of the results that are abnormal.", "[21:51:22.195] Matched pattern for: Blood Urea Nitrogen (BUN)", "[21:51:22.196] Found test data: {:name=>\\"Blood Urea Nitrogen (BUN)\\", :value=>1171.0, :flag=>nil, :unit=>\\"mg/dL\\", :reference_range=>\\"8-2310.2\\", :status=>\\"Final\\"}", "[21:51:22.201] Processing line: 'Creatinine                       M    0.9                                     mg/dL         0.8-1.3                                                       M              Reported Date/Time:        02/12/14      16:20                     16. An ‘H’ in this column may mean that the result is higher than the reference'", "[21:51:22.203] Attempting to match line: Creatinine                       M    0.9                                     mg/dL         0.8-1.3                                                       M              Reported Date/Time:        02/12/14      16:20                     16. An ‘H’ in this column may mean that the result is higher than the reference", "[21:51:22.204] Matched pattern for: Creatinine                       M", "[21:51:22.206] Found test data: {:name=>\\"Creatinine                       M\\", :value=>0.9, :flag=>nil, :unit=>\\"mg/dL\\", :reference_range=>\\"0.8-1.3\\", :status=>\\"Final\\"}", "[21:51:22.207] Processing line: 'A                                                                                                ORDERED::       Throat Culture for Beta Hemolytic Streptococci (Strep Throat Test)                                      range. ‘L’ may mean ‘low.’ Either represents a result outside the reference'", "[21:51:22.208] Attempting to match line: A                                                                                                ORDERED::       Throat Culture for Beta Hemolytic Streptococci (Strep Throat Test)                                      range. ‘L’ may mean ‘low.’ Either represents a result outside the reference", "[21:51:22.212] Processing line: 'Test                                             Results                          Reference Range                       range/value.'", "[21:51:22.213] Attempting to match line: Test                                             Results                          Reference Range                       range/value.", "[21:51:22.214] Processing line: 'Flag Key: L= Abnormal Low, H= Abnormal High, *= critical value                                                          Throat Culture for Beta                                                     Negative for group A                    17. labs use to report your results can vary from lab to lab. Regardless of the units'", "[21:51:22.216] Attempting to match line: Flag Key: L= Abnormal Low, H= Abnormal High, *= critical value                                                          Throat Culture for Beta                                                     Negative for group A                    17. labs use to report your results can vary from lab to lab. Regardless of the units", "[21:51:22.221] Processing line: 'E                                                                                                                Hemolytic Streptococci               Positive for group A streptococcus     streptococcus                               that the lab uses, your results will be interpreted in relation to the reference'", "[21:51:22.221] Attempting to match line: E                                                                                                                Hemolytic Streptococci               Positive for group A streptococcus     streptococcus                               that the lab uses, your results will be interpreted in relation to the reference", "[21:51:22.223] Processing line: '223457                           Collection Date/Time:      02/10/14   14:30                                                                                                                                                    ranges supplied by the laboratory.'", "[21:51:22.226] Attempting to match line: 223457                           Collection Date/Time:      02/10/14   14:30                                                                                                                                                    ranges supplied by the laboratory.", "[21:51:22.227] Processing line: 'SPEC #:                                          Received Date/Time:        02/10/14   15:00                                                                                                                                                18. Reference intervals (or reference ranges). These are the ranges in which'", "[21:51:22.228] Attempting to match line: SPEC #:                                          Received Date/Time:        02/10/14   15:00                                                                                                                                                18. Reference intervals (or reference ranges). These are the ranges in which", "[21:51:22.229] Processing line: 'Reported Date/Time:        02/10/14   15:30                                                                                                                                                    “normal” values are expected to fall. The ranges that appear on your report'", "[21:51:22.230] Attempting to match line: Reported Date/Time:        02/10/14   15:30                                                                                                                                                    “normal” values are expected to fall. The ranges that appear on your report", "[21:51:22.231] Processing line: 'ORDERED::       Hemoglobin and Hematocrit, A1c                                                                                                                                                                                                  are established and supplied by the laboratory that performed your test.'", "[21:51:22.232] Attempting to match line: ORDERED::       Hemoglobin and Hematocrit, A1c                                                                                                                                                                                                  are established and supplied by the laboratory that performed your test.", "[21:51:22.233] Processing line: 'Test                                Normal          Abnormal        Flag      Units     Reference Range                                                           ** END OF REPORT **                                                       19. immediately to the responsible person, such as the ordering physician. The'", "[21:51:22.234] Attempting to match line: Test                                Normal          Abnormal        Flag      Units     Reference Range                                                           ** END OF REPORT **                                                       19. immediately to the responsible person, such as the ordering physician. The", "[21:51:22.236] Processing line: 'Hemoglobin (HB/Hgb)                                     7.0          L**      gm/dL         14.0-18.0                                                                                                                                           laboratory will often draw attention to such results with an asterisk (*) or'", "[21:51:22.237] Attempting to match line: Hemoglobin (HB/Hgb)                                     7.0          L**      gm/dL         14.0-18.0                                                                                                                                           laboratory will often draw attention to such results with an asterisk (*) or", "[21:51:22.238] Matched pattern for: Hemoglobin (HB/Hgb)", "[21:51:22.243] Found test data: {:name=>\\"Hemoglobin (HB/Hgb)\\", :value=>7.0, :flag=>\\"L\\", :unit=>nil, :reference_range=>\\"Not provided\\", :status=>\\"Final\\"}", "[21:51:22.245] Processing line: 'Hematocrit (HCT)                                       21.1          L**      %             42.0-52.0                                                                                                                                           something similar and will usually note on the report the date and time the'", "[21:51:22.247] Attempting to match line: Hematocrit (HCT)                                       21.1          L**      %             42.0-52.0                                                                                                                                           something similar and will usually note on the report the date and time the", "[21:51:22.248] Matched pattern for: Hematocrit (HCT)", "[21:51:22.251] Found test data: {:name=>\\"Hematocrit (HCT)\\", :value=>21.1, :flag=>\\"L\\", :unit=>nil, :reference_range=>\\"Not provided\\", :status=>\\"Final\\"}", "[21:51:22.254] Processing line: 'Hemoglobin A1c (A1c)                  4.8                                     %             4.3-6.1                                                                                                                                             responsible person was notified.'", "[21:51:22.256] Attempting to match line: Hemoglobin A1c (A1c)                  4.8                                     %             4.3-6.1                                                                                                                                             responsible person was notified.", "[21:51:22.260] Processing line: 'Flag Key: L= Abnormal Low, H= Abnormal High, **= critical value                                                                                                                                                                             20. address of the lab will often be inserted next to the results or otherwise noted'", "[21:51:22.262] Attempting to match line: Flag Key: L= Abnormal Low, H= Abnormal High, **= critical value                                                                                                                                                                             20. address of the lab will often be inserted next to the results or otherwise noted", "[21:51:22.262] Processing line: 'Doe, John Q.                             Patient ID:  987654321                02/14/2014        16:13                  on the report.'", "[21:51:22.263] Attempting to match line: Doe, John Q.                             Patient ID:  987654321                02/14/2014        16:13                  on the report.", "[21:51:22.264] Processing line: '19  Comment: **Critical results Hgb of 7.0 and Hct of 21.1 reported to Dr. J Smith at 15:15 on 2/10/14 by M. Peters                                                                                                                             21. Interpretation of results. In certain circumstances, the lab may note on the'", "[21:51:22.265] Attempting to match line: 19  Comment: **Critical results Hgb of 7.0 and Hct of 21.1 reported to Dr. J Smith at 15:15 on 2/10/14 by M. Peters                                                                                                                             21. Interpretation of results. In certain circumstances, the lab may note on the", "[21:51:22.266] Processing line: 'report what certain test results may indicate.'", "[21:51:22.267] Attempting to match line: report what certain test results may indicate.", "[21:51:22.268] === Parsing completed ===", "[21:51:22.269] Categories found: have_b_en_made_up_for_illustrative_purposes_o_ly._this_report_is_an_ex_mple_of_a_cumulative_report,_which", "[21:51:22.270] Total tests parsed: 13"], "patient_info": {"dob": "01/01/1941"}}	\N	197	1
39	2025-01-05 23:07:31.117905	2025-01-05 23:07:32.637504	umc_pathology	failed	{"categories": {}, "patient_info": {}}	\N	198	1
41	2025-01-05 23:13:24.223722	2025-01-05 23:13:27.073992	sterling_accuris	completed	{"Protein": [{"name": "Unconjugated Bilirubin", "unit": "mg/dL", "value": "0.2", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "Delta Bilirubin", "unit": "mg/dL", "value": "0.2", "method": "Standard Method", "biological_ref_interval": "0"}], "Blood Group": [{"name": "ABO Type", "unit": "-", "value": "\\"A\\"", "method": "Blood Typing", "biological_ref_interval": "-"}, {"name": "Rh (D) Type", "unit": "-", "value": "Positive", "method": "Blood Typing", "biological_ref_interval": "-"}], "Immunoassay": [{"name": "Homocysteine, Serum", "unit": "micromol/L", "value": "0", "method": "Standard Method", "biological_ref_interval": "6"}, {"name": "25(OH) Vitamin D", "unit": "ng/mL", "value": "8.98", "method": "HPLC", "biological_ref_interval": "Deficiency"}, {"name": "Vitamin B12", "unit": "pg/mL", "value": "0", "method": "HPLC", "biological_ref_interval": "187"}, {"name": "Vitamin B12", "unit": "-", "value": "is essential in DNA synthesis, hematopoiesis, and CNS integrity.", "method": "HPLC", "biological_ref_interval": "-"}, {"name": "PSA-Prostate Specific Antigen, Total", "unit": "ng/mL", "value": "0.57", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "IgE", "unit": "IU/mL", "value": "0", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "HIV I & II Ab/Ag with P24 Ag", "unit": "S/Co", "value": "0.07", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "HBsAg", "unit": "S/Co", "value": "0.29", "method": "Standard Method", "biological_ref_interval": "0"}], "Biochemistry": [{"name": "Fasting Blood Sugar", "unit": "mg/dL", "value": "0", "method": "Hexokinase", "biological_ref_interval": "74"}, {"name": "Microalbumin (per urine volume)", "unit": "mg/L", "value": "10.5", "method": "Spectrophotometry", "biological_ref_interval": "0"}, {"name": "Creatinine, Serum", "unit": "mg/dL", "value": "0.83", "method": "Standard Method", "biological_ref_interval": "0.66"}, {"name": "Urea", "unit": "mg/dL", "value": "0", "method": "Standard Method", "biological_ref_interval": "19.3"}, {"name": "Blood Urea Nitrogen", "unit": "mg/dL", "value": "0", "method": "Standard Method", "biological_ref_interval": "9"}, {"name": "Uric Acid", "unit": "mg/dL", "value": "4.9", "method": "Standard Method", "biological_ref_interval": "3.5"}, {"name": "Calcium", "unit": "mg/dL", "value": "9.1", "method": "Standard Method", "biological_ref_interval": "8.4"}], "Electrolytes": [{"name": "Sodium (Na+)", "unit": "mmol/L", "value": "143", "method": "Standard Method", "biological_ref_interval": "136"}, {"name": "Potassium (K+)", "unit": "mmol/L", "value": "4.9", "method": "Standard Method", "biological_ref_interval": "3.5"}, {"name": "Chloride (Cl-)", "unit": "mmol/L", "value": "105", "method": "Standard Method", "biological_ref_interval": "98"}], "Iron Studies": [{"name": "Iron", "unit": "micro g/dL", "value": "103", "method": "Standard Method", "biological_ref_interval": "49"}, {"name": "Total Iron Binding Capacity (TIBC)", "unit": "261", "value": "352", "method": "Standard Method", "biological_ref_interval": "-"}], "Lipid Profile": [{"name": "Cholesterol", "unit": "mg/dL", "value": "189", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "Cholesterol", "unit": "-", "value": "oxidase – Peroxidase method", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Triglyceride", "unit": "mg/dL", "value": "0", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "HDL Cholesterol", "unit": "mg/dL", "value": "60", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "VLDL", "unit": "mg/dL", "value": "33.6", "method": "Standard Method", "biological_ref_interval": "15"}, {"name": "CHOL/HDL Ratio", "unit": "0", "value": "3.1", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "LDL/HDL Ratio", "unit": "0", "value": "1.7", "method": "Standard Method", "biological_ref_interval": "-"}], "Differential Count": [{"name": "Neutrophils", "unit": "%", "value": "73", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Lymphocytes", "unit": "%", "value": "19", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Eosinophils", "unit": "%", "value": "2", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Monocytes", "unit": "%", "value": "6", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Basophils", "unit": "%", "value": "0", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Platelet Count", "unit": "150000", "value": "/cmm", "method": "0", "biological_ref_interval": "-"}, {"name": "MPV", "unit": "14", "value": "H", "method": "Calculated", "biological_ref_interval": "-"}], "Complete Blood Count": [{"name": "Hemoglobin", "unit": "g/dL", "value": "14.5", "method": "Colorimetric", "biological_ref_interval": "13"}, {"name": "RBC Count", "unit": "4.5", "value": "million/cmm", "method": "Electrical impedance", "biological_ref_interval": "-"}, {"name": "Hematocrit", "unit": "%", "value": "43.3", "method": "Calculated", "biological_ref_interval": "40"}, {"name": "MCV", "unit": "fL", "value": "90.3", "method": "Derived", "biological_ref_interval": "83"}, {"name": "MCH", "unit": "pg", "value": "30.2", "method": "Calculated", "biological_ref_interval": "27.1"}, {"name": "MCHC", "unit": "32.5", "value": "g/dL", "method": "33.4", "biological_ref_interval": "-"}, {"name": "RDW CV", "unit": "%", "value": "13.6", "method": "Calculated", "biological_ref_interval": "11.6"}], "Thyroid Function Test": [{"name": "T3 - Triiodothyronine", "unit": "ng/mL", "value": "1.01", "method": "CLIA", "biological_ref_interval": "0.58"}, {"name": "T4 - Thyroxine", "unit": "mg/mL", "value": "7.84", "method": "CLIA", "biological_ref_interval": "4.87"}], "Microscopic Examination": [{"name": "Pus Cells", "unit": "Absent", "value": "1", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Red Cells", "unit": "/hpf", "value": "Not Detected", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "Epithelial Cells", "unit": "/hpf", "value": "1", "method": "Standard Method", "biological_ref_interval": "."}, {"name": "Casts", "unit": "/hpf", "value": "Absent", "method": "Standard Method", "biological_ref_interval": "Absent"}, {"name": "Crystals", "unit": "/hpf", "value": "Absent", "method": "Standard Method", "biological_ref_interval": "Absent"}, {"name": "Amorphous Material", "unit": "-", "value": "Absent", "method": "Standard Method", "biological_ref_interval": "-"}], "HB Electrophoresis By HPLC": [{"name": "Hb A", "unit": "%", "value": "0", "method": "Standard Method", "biological_ref_interval": "96.8"}, {"name": "Hb A2", "unit": "%", "value": "2.8", "method": "Standard Method", "biological_ref_interval": "2.2"}, {"name": "P2 Peak", "unit": "%", "value": "5.5", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "P3 Peak", "unit": "%", "value": "5.2", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Foetal Hb", "unit": "%", "value": "0.3", "method": "Standard Method", "biological_ref_interval": "0"}], "Peripheral Smear Examination": [{"name": "RBC Morphology", "unit": null, "value": "Normochromic Normocytic", "method": "Microscopy", "biological_ref_interval": "-"}, {"name": "WBC Morphology", "unit": null, "value": "WBCs Series Shows Normal Morphology", "method": "Microscopy", "biological_ref_interval": "-"}, {"name": "Platelets Morphology", "unit": null, "value": "Platelets are adequate with normal morphology.", "method": "Microscopy", "biological_ref_interval": "-"}, {"name": "Parasites", "unit": null, "value": "Malarial parasite is not detected.", "method": "Microscopy", "biological_ref_interval": "-"}], "Erythrocyte Sedimentation Rate": [{"name": "ESR", "unit": "0", "value": "Capillary photometry", "method": "Standard Method", "biological_ref_interval": "0"}], "HbA1c (Glycosylated Hemoglobin)": [{"name": "HbA1c", "unit": "-", "value": "assay Interferences", "method": "Standard Method", "biological_ref_interval": "-"}], "Physical & Chemical (Dip strip) examination": [{"name": "Colour", "unit": "Pale Yellow", "value": "Pale Yellow", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Clearity", "unit": "Clear", "value": "Clear", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "pH", "unit": "4.6", "value": "6", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Specific Gravity", "unit": "1", "value": "1.03", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Urine Glucose", "unit": "Absent", "value": "Present (+)", "method": "Hexokinase", "biological_ref_interval": "-"}]}	\N	200	1
42	2025-01-05 23:16:47.644127	2025-01-05 23:16:50.471316	sterling_accuris	completed	{}	\N	201	1
44	2025-01-05 23:27:23.807831	2025-01-05 23:27:25.1065	sterling_accuris	failed	{}	\N	203	1
51	2025-01-06 09:12:05.93541	2025-01-06 09:12:08.869619	sterling_accuris	completed	{"Protein": [{"name": "Unconjugated Bilirubin", "unit": "mg/dL", "value": "0.2", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "Delta Bilirubin", "unit": "mg/dL", "value": "0.2", "method": "Standard Method", "biological_ref_interval": "0"}], "Blood Group": [{"name": "ABO Type", "unit": "-", "value": "\\"A\\"", "method": "Blood Typing", "biological_ref_interval": "-"}, {"name": "Rh (D) Type", "unit": "-", "value": "Positive", "method": "Blood Typing", "biological_ref_interval": "-"}], "Immunoassay": [{"name": "Homocysteine, Serum", "unit": "micromol/L", "value": "0", "method": "Standard Method", "biological_ref_interval": "6"}, {"name": "25(OH) Vitamin D", "unit": "ng/mL", "value": "8.98", "method": "HPLC", "biological_ref_interval": "Deficiency"}, {"name": "Vitamin B12", "unit": "pg/mL", "value": "0", "method": "HPLC", "biological_ref_interval": "187"}, {"name": "Vitamin B12", "unit": "-", "value": "is essential in DNA synthesis, hematopoiesis, and CNS integrity.", "method": "HPLC", "biological_ref_interval": "-"}, {"name": "PSA-Prostate Specific Antigen, Total", "unit": "ng/mL", "value": "0.57", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "IgE", "unit": "IU/mL", "value": "0", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "HIV I & II Ab/Ag with P24 Ag", "unit": "S/Co", "value": "0.07", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "HBsAg", "unit": "S/Co", "value": "0.29", "method": "Standard Method", "biological_ref_interval": "0"}], "Biochemistry": [{"name": "Fasting Blood Sugar", "unit": "mg/dL", "value": "0", "method": "Hexokinase", "biological_ref_interval": "74"}, {"name": "Microalbumin (per urine volume)", "unit": "mg/L", "value": "10.5", "method": "Spectrophotometry", "biological_ref_interval": "0"}, {"name": "Creatinine, Serum", "unit": "mg/dL", "value": "0.83", "method": "Standard Method", "biological_ref_interval": "0.66"}, {"name": "Urea", "unit": "mg/dL", "value": "0", "method": "Standard Method", "biological_ref_interval": "19.3"}, {"name": "Blood Urea Nitrogen", "unit": "mg/dL", "value": "0", "method": "Standard Method", "biological_ref_interval": "9"}, {"name": "Uric Acid", "unit": "mg/dL", "value": "4.9", "method": "Standard Method", "biological_ref_interval": "3.5"}, {"name": "Calcium", "unit": "mg/dL", "value": "9.1", "method": "Standard Method", "biological_ref_interval": "8.4"}], "Electrolytes": [{"name": "Sodium (Na+)", "unit": "mmol/L", "value": "143", "method": "Standard Method", "biological_ref_interval": "136"}, {"name": "Potassium (K+)", "unit": "mmol/L", "value": "4.9", "method": "Standard Method", "biological_ref_interval": "3.5"}, {"name": "Chloride (Cl-)", "unit": "mmol/L", "value": "105", "method": "Standard Method", "biological_ref_interval": "98"}], "Iron Studies": [{"name": "Iron", "unit": "micro g/dL", "value": "103", "method": "Standard Method", "biological_ref_interval": "49"}, {"name": "Total Iron Binding Capacity (TIBC)", "unit": "261", "value": "352", "method": "Standard Method", "biological_ref_interval": "-"}], "Lipid Profile": [{"name": "Cholesterol", "unit": "mg/dL", "value": "189", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "Cholesterol", "unit": "-", "value": "oxidase – Peroxidase method", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Triglyceride", "unit": "mg/dL", "value": "0", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "HDL Cholesterol", "unit": "mg/dL", "value": "60", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "VLDL", "unit": "mg/dL", "value": "33.6", "method": "Standard Method", "biological_ref_interval": "15"}, {"name": "CHOL/HDL Ratio", "unit": "0", "value": "3.1", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "LDL/HDL Ratio", "unit": "0", "value": "1.7", "method": "Standard Method", "biological_ref_interval": "-"}], "Differential Count": [{"name": "Neutrophils", "unit": "%", "value": "73", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Lymphocytes", "unit": "%", "value": "19", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Eosinophils", "unit": "%", "value": "2", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Monocytes", "unit": "%", "value": "6", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Basophils", "unit": "%", "value": "0", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Platelet Count", "unit": "150000", "value": "/cmm", "method": "0", "biological_ref_interval": "-"}, {"name": "MPV", "unit": "14", "value": "H", "method": "Calculated", "biological_ref_interval": "-"}], "Complete Blood Count": [{"name": "Hemoglobin", "unit": "g/dL", "value": "14.5", "method": "Colorimetric", "biological_ref_interval": "13"}, {"name": "RBC Count", "unit": "4.5", "value": "million/cmm", "method": "Electrical impedance", "biological_ref_interval": "-"}, {"name": "Hematocrit", "unit": "%", "value": "43.3", "method": "Calculated", "biological_ref_interval": "40"}, {"name": "MCV", "unit": "fL", "value": "90.3", "method": "Derived", "biological_ref_interval": "83"}, {"name": "MCH", "unit": "pg", "value": "30.2", "method": "Calculated", "biological_ref_interval": "27.1"}, {"name": "MCHC", "unit": "32.5", "value": "g/dL", "method": "33.4", "biological_ref_interval": "-"}, {"name": "RDW CV", "unit": "%", "value": "13.6", "method": "Calculated", "biological_ref_interval": "11.6"}], "Thyroid Function Test": [{"name": "T3 - Triiodothyronine", "unit": "ng/mL", "value": "1.01", "method": "CLIA", "biological_ref_interval": "0.58"}, {"name": "T4 - Thyroxine", "unit": "mg/mL", "value": "7.84", "method": "CLIA", "biological_ref_interval": "4.87"}], "Microscopic Examination": [{"name": "Pus Cells", "unit": "Absent", "value": "1", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Red Cells", "unit": "/hpf", "value": "Not Detected", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "Epithelial Cells", "unit": "/hpf", "value": "1", "method": "Standard Method", "biological_ref_interval": "."}, {"name": "Casts", "unit": "/hpf", "value": "Absent", "method": "Standard Method", "biological_ref_interval": "Absent"}, {"name": "Crystals", "unit": "/hpf", "value": "Absent", "method": "Standard Method", "biological_ref_interval": "Absent"}, {"name": "Amorphous Material", "unit": "-", "value": "Absent", "method": "Standard Method", "biological_ref_interval": "-"}], "HB Electrophoresis By HPLC": [{"name": "Hb A", "unit": "%", "value": "0", "method": "Standard Method", "biological_ref_interval": "96.8"}, {"name": "Hb A2", "unit": "%", "value": "2.8", "method": "Standard Method", "biological_ref_interval": "2.2"}, {"name": "P2 Peak", "unit": "%", "value": "5.5", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "P3 Peak", "unit": "%", "value": "5.2", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Foetal Hb", "unit": "%", "value": "0.3", "method": "Standard Method", "biological_ref_interval": "0"}], "Peripheral Smear Examination": [{"name": "RBC Morphology", "unit": null, "value": "Normochromic Normocytic", "method": "Microscopy", "biological_ref_interval": "-"}, {"name": "WBC Morphology", "unit": null, "value": "WBCs Series Shows Normal Morphology", "method": "Microscopy", "biological_ref_interval": "-"}, {"name": "Platelets Morphology", "unit": null, "value": "Platelets are adequate with normal morphology.", "method": "Microscopy", "biological_ref_interval": "-"}, {"name": "Parasites", "unit": null, "value": "Malarial parasite is not detected.", "method": "Microscopy", "biological_ref_interval": "-"}], "Erythrocyte Sedimentation Rate": [{"name": "ESR", "unit": "0", "value": "Capillary photometry", "method": "Standard Method", "biological_ref_interval": "0"}], "HbA1c (Glycosylated Hemoglobin)": [{"name": "HbA1c", "unit": "-", "value": "assay Interferences", "method": "Standard Method", "biological_ref_interval": "-"}], "Physical & Chemical (Dip strip) examination": [{"name": "Colour", "unit": "Pale Yellow", "value": "Pale Yellow", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Clearity", "unit": "Clear", "value": "Clear", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "pH", "unit": "4.6", "value": "6", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Specific Gravity", "unit": "1", "value": "1.03", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Urine Glucose", "unit": "Absent", "value": "Present (+)", "method": "Hexokinase", "biological_ref_interval": "-"}]}		210	1
35	2025-01-05 19:31:13.469653	2025-01-05 19:31:15.295078	umc_pathology	completed	{"categories": {}, "debug_info": ["[19:31:14.751] Opening PDF file: /tmp/temp_pdf20250105-46-lxmb27.pdf", "[19:31:14.769] Processing page 1", "[19:31:15.267] Raw text sample:                                                                                                                                                                                                          ...", "[19:31:15.269] Found 47 lines to process", "[19:31:15.270] Parsing patient information", "[19:31:15.271] Found dob: 01/01/1941", "[19:31:15.275] === Parsing completed ===", "[19:31:15.276] Categories found: ", "[19:31:15.277] Total tests parsed: 0"], "patient_info": {"dob": "01/01/1941"}}	\N	194	1
36	2025-01-05 19:35:25.82598	2025-01-05 19:35:27.618918	umc_pathology	completed	{"categories": {}, "debug_info": ["[19:35:27.056] Opening PDF file: /tmp/temp_pdf20250105-46-g2pmko.pdf", "[19:35:27.075] Processing page 1", "[19:35:27.590] Raw text sample:                                                                                                                                                                                                          ...", "[19:35:27.591] Found 47 lines to process", "[19:35:27.593] Parsing patient information", "[19:35:27.594] Found dob: 01/01/1941", "[19:35:27.596] === Parsing completed ===", "[19:35:27.599] Categories found: ", "[19:35:27.601] Total tests parsed: 0"], "patient_info": {"dob": "01/01/1941"}}	\N	195	1
37	2025-01-05 19:40:15.455221	2025-01-05 19:40:17.838233	umc_pathology	completed	{"categories": {}, "debug_info": ["[19:40:16.880] Opening PDF file: /tmp/temp_pdf20250105-46-w6gc9e.pdf", "[19:40:16.901] Processing page 1", "[19:40:17.798] Raw text sample:                                                                                                                                                                                                          ...", "[19:40:17.800] Found 47 lines to process", "[19:40:17.801] Parsing patient information", "[19:40:17.803] Found dob: 01/01/1941", "[19:40:17.805] === Parsing completed ===", "[19:40:17.806] Categories found: ", "[19:40:17.811] Total tests parsed: 0"], "patient_info": {"dob": "01/01/1941"}}	\N	196	1
40	2025-01-05 23:09:04.561275	2025-01-05 23:09:05.684927	umc_pathology	failed	{"error": "undefined method `parse_patient_info' for #<PdfParsers::UmcPathologyParser:0x00007f92e00d58c0 @pdf_path=\\"/tmp/temp_pdf20250105-46-ulxxst.pdf\\", @processed_data={\\"patient_info\\"=>{}, \\"categories\\"=>{\\"Basic Metabolic Panel\\"=>[], \\"Complete Blood Count\\"=>[], \\"Other Tests\\"=>[]}}, @current_category=nil, @debug_info=[]>", "categories": {}, "patient_info": {}}	\N	199	1
43	2025-01-05 23:18:44.593401	2025-01-05 23:18:48.894796	sterling_accuris	completed	{"categories": {"Chemistry": [{"flag": null, "name": "Fasting Blood Sugar                                              H", "unit": "mg/dL", "value": "141.0", "method": "Laboratory", "status": "Final", "reference_range": {"max": "106", "min": "74"}}, {"flag": null, "name": "T3 - Triiodothyronine", "unit": "ng/mL", "value": "1.01", "method": "Laboratory", "status": "Final", "reference_range": {"max": "1.59", "min": "0.58"}}, {"flag": null, "name": "T4 - Thyroxine", "unit": "mg/mL", "value": "7.84", "method": "Laboratory", "status": "Final", "reference_range": {"max": "11.72", "min": "4.87"}}, {"flag": null, "name": "Chemiluminescencemulating Hormone", "unit": "microIU/mL", "value": "0.8199", "method": "Laboratory", "status": "Final", "reference_range": {"max": "4.94", "min": "0.35"}}, {"flag": null, "name": "Copper tartrate to colour complex", "unit": "g/dL", "value": "7.00", "method": "Laboratory", "status": "Final", "reference_range": {"max": "8.2", "min": "6.3"}}, {"flag": null, "name": "Bromocresol Green Method", "unit": "g/dL", "value": "4.20", "method": "Laboratory", "status": "Final", "reference_range": {"max": "5.0", "min": "3.5"}}, {"flag": null, "name": "Calculated", "unit": "g/dL", "value": "2.80", "method": "Laboratory", "status": "Final", "reference_range": {"max": "3.5", "min": "2.3"}}, {"flag": null, "name": "-              Total Bilirubin", "unit": "mg/dL", "value": "0.70", "method": "Laboratory", "status": "Final", "reference_range": {"max": "1.3", "min": "0.2"}}, {"flag": null, "name": "2-             Conjugated Bilirubin", "unit": "mg/dL", "value": "0.30", "method": "Laboratory", "status": "Final", "reference_range": {"max": "0.3", "min": "0.0"}}, {"flag": null, "name": "Unconjugated Bilirubin", "unit": "mg/dL", "value": "0.20", "method": "Laboratory", "status": "Final", "reference_range": {"max": "1.1", "min": "0.0"}}, {"flag": null, "name": "Delta Bilirubin", "unit": "mg/dL", "value": "0.20", "method": "Laboratory", "status": "Final", "reference_range": {"max": "0.2", "min": "0.0"}}, {"flag": null, "name": "Urea                                              L", "unit": "mg/dL", "value": "18.0", "method": "Laboratory", "status": "Final", "reference_range": {"max": "43.0", "min": "19.3"}}, {"flag": null, "name": "Blood Urea Nitrogen                               L", "unit": "mg/dL", "value": "8.41", "method": "Laboratory", "status": "Final", "reference_range": {"max": "20.0", "min": "9.0"}}, {"flag": null, "name": "Uric Acid", "unit": "mg/dL", "value": "4.90", "method": "Laboratory", "status": "Final", "reference_range": {"max": "8.5", "min": "3.5"}}, {"flag": null, "name": "Calcium", "unit": "mg/dL", "value": "9.10", "method": "Chemistry", "status": "Final", "reference_range": {"max": "10.2", "min": "8.4"}}, {"flag": null, "name": "0             UV with P5P", "unit": "U/L", "value": "27.0", "method": "Laboratory", "status": "Final", "reference_range": {"max": "59", "min": "17"}}, {"flag": null, "name": "Chloride (Cl-)", "unit": "mmol/L", "value": "105.0", "method": "Chemistry", "status": "Final", "reference_range": {"max": "107", "min": "98"}}, {"flag": null, "name": "IgE                                                     H", "unit": "IU/mL", "value": "492.30", "method": "Laboratory", "status": "Final", "reference_range": {"max": "87", "min": "0"}}, {"flag": null, "name": "Hb A                         L", "unit": "%", "value": "84.4", "method": "Laboratory", "status": "Final", "reference_range": {"max": "97.8", "min": "96.8"}}, {"flag": null, "name": "Hb A2", "unit": "%", "value": "2.8", "method": "Laboratory", "status": "Final", "reference_range": {"max": "3.2", "min": "2.2"}}, {"flag": null, "name": "Foetal Hb", "unit": "%", "value": "0.3", "method": "Laboratory", "status": "Final", "reference_range": {"max": "1.0", "min": "0.0"}}], "Hematology": [], "Urinalysis": []}, "patient_info": {"patient_id": "Injection"}}	\N	202	1
45	2025-01-05 23:27:53.429143	2025-01-05 23:27:54.036545	sterling_accuris	failed	{}	\N	204	1
46	2025-01-05 23:28:45.98167	2025-01-05 23:28:46.673211	sterling_accuris	failed	{}	\N	205	1
47	2025-01-05 23:32:42.084909	2025-01-05 23:32:42.866599	sterling_accuris	failed	{}	\N	206	1
48	2025-01-06 00:48:33.663142	2025-01-06 00:48:37.394678	sterling_accuris	completed	{"categories": {}, "patient_info": {}}	\N	207	1
49	2025-01-06 02:21:39.287558	2025-01-06 02:21:44.329117	sterling_accuris	completed	{"categories": {}, "patient_info": {"dob": "Report Generated:       02/20/2023 14:04:40"}}	\N	208	1
50	2025-01-06 02:32:39.155347	2025-01-06 02:32:43.795841	sterling_accuris	completed	{"Protein": [{"name": "Unconjugated Bilirubin", "unit": "mg/dL", "value": "0.2", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "Delta Bilirubin", "unit": "mg/dL", "value": "0.2", "method": "Standard Method", "biological_ref_interval": "0"}], "Blood Group": [{"name": "ABO Type", "unit": "-", "value": "\\"A\\"", "method": "Blood Typing", "biological_ref_interval": "-"}, {"name": "Rh (D) Type", "unit": "-", "value": "Positive", "method": "Blood Typing", "biological_ref_interval": "-"}], "Immunoassay": [{"name": "Homocysteine, Serum", "unit": "micromol/L", "value": "0", "method": "Standard Method", "biological_ref_interval": "6"}, {"name": "25(OH) Vitamin D", "unit": "ng/mL", "value": "8.98", "method": "HPLC", "biological_ref_interval": "Deficiency"}, {"name": "Vitamin B12", "unit": "pg/mL", "value": "0", "method": "HPLC", "biological_ref_interval": "187"}, {"name": "Vitamin B12", "unit": "-", "value": "is essential in DNA synthesis, hematopoiesis, and CNS integrity.", "method": "HPLC", "biological_ref_interval": "-"}, {"name": "PSA-Prostate Specific Antigen, Total", "unit": "ng/mL", "value": "0.57", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "IgE", "unit": "IU/mL", "value": "0", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "HIV I & II Ab/Ag with P24 Ag", "unit": "S/Co", "value": "0.07", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "HBsAg", "unit": "S/Co", "value": "0.29", "method": "Standard Method", "biological_ref_interval": "0"}], "Biochemistry": [{"name": "Fasting Blood Sugar", "unit": "mg/dL", "value": "0", "method": "Hexokinase", "biological_ref_interval": "74"}, {"name": "Microalbumin (per urine volume)", "unit": "mg/L", "value": "10.5", "method": "Spectrophotometry", "biological_ref_interval": "0"}, {"name": "Creatinine, Serum", "unit": "mg/dL", "value": "0.83", "method": "Standard Method", "biological_ref_interval": "0.66"}, {"name": "Urea", "unit": "mg/dL", "value": "0", "method": "Standard Method", "biological_ref_interval": "19.3"}, {"name": "Blood Urea Nitrogen", "unit": "mg/dL", "value": "0", "method": "Standard Method", "biological_ref_interval": "9"}, {"name": "Uric Acid", "unit": "mg/dL", "value": "4.9", "method": "Standard Method", "biological_ref_interval": "3.5"}, {"name": "Calcium", "unit": "mg/dL", "value": "9.1", "method": "Standard Method", "biological_ref_interval": "8.4"}], "Electrolytes": [{"name": "Sodium (Na+)", "unit": "mmol/L", "value": "143", "method": "Standard Method", "biological_ref_interval": "136"}, {"name": "Potassium (K+)", "unit": "mmol/L", "value": "4.9", "method": "Standard Method", "biological_ref_interval": "3.5"}, {"name": "Chloride (Cl-)", "unit": "mmol/L", "value": "105", "method": "Standard Method", "biological_ref_interval": "98"}], "Iron Studies": [{"name": "Iron", "unit": "micro g/dL", "value": "103", "method": "Standard Method", "biological_ref_interval": "49"}, {"name": "Total Iron Binding Capacity (TIBC)", "unit": "261", "value": "352", "method": "Standard Method", "biological_ref_interval": "-"}], "Lipid Profile": [{"name": "Cholesterol", "unit": "mg/dL", "value": "189", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "Cholesterol", "unit": "-", "value": "oxidase – Peroxidase method", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Triglyceride", "unit": "mg/dL", "value": "0", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "HDL Cholesterol", "unit": "mg/dL", "value": "60", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "VLDL", "unit": "mg/dL", "value": "33.6", "method": "Standard Method", "biological_ref_interval": "15"}, {"name": "CHOL/HDL Ratio", "unit": "0", "value": "3.1", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "LDL/HDL Ratio", "unit": "0", "value": "1.7", "method": "Standard Method", "biological_ref_interval": "-"}], "Differential Count": [{"name": "Neutrophils", "unit": "%", "value": "73", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Lymphocytes", "unit": "%", "value": "19", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Eosinophils", "unit": "%", "value": "2", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Monocytes", "unit": "%", "value": "6", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Basophils", "unit": "%", "value": "0", "method": "Microscopic", "biological_ref_interval": "-"}, {"name": "Platelet Count", "unit": "150000", "value": "/cmm", "method": "0", "biological_ref_interval": "-"}, {"name": "MPV", "unit": "14", "value": "H", "method": "Calculated", "biological_ref_interval": "-"}], "Complete Blood Count": [{"name": "Hemoglobin", "unit": "g/dL", "value": "14.5", "method": "Colorimetric", "biological_ref_interval": "13"}, {"name": "RBC Count", "unit": "4.5", "value": "million/cmm", "method": "Electrical impedance", "biological_ref_interval": "-"}, {"name": "Hematocrit", "unit": "%", "value": "43.3", "method": "Calculated", "biological_ref_interval": "40"}, {"name": "MCV", "unit": "fL", "value": "90.3", "method": "Derived", "biological_ref_interval": "83"}, {"name": "MCH", "unit": "pg", "value": "30.2", "method": "Calculated", "biological_ref_interval": "27.1"}, {"name": "MCHC", "unit": "32.5", "value": "g/dL", "method": "33.4", "biological_ref_interval": "-"}, {"name": "RDW CV", "unit": "%", "value": "13.6", "method": "Calculated", "biological_ref_interval": "11.6"}], "Thyroid Function Test": [{"name": "T3 - Triiodothyronine", "unit": "ng/mL", "value": "1.01", "method": "CLIA", "biological_ref_interval": "0.58"}, {"name": "T4 - Thyroxine", "unit": "mg/mL", "value": "7.84", "method": "CLIA", "biological_ref_interval": "4.87"}], "Microscopic Examination": [{"name": "Pus Cells", "unit": "Absent", "value": "1", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Red Cells", "unit": "/hpf", "value": "Not Detected", "method": "Standard Method", "biological_ref_interval": "0"}, {"name": "Epithelial Cells", "unit": "/hpf", "value": "1", "method": "Standard Method", "biological_ref_interval": "."}, {"name": "Casts", "unit": "/hpf", "value": "Absent", "method": "Standard Method", "biological_ref_interval": "Absent"}, {"name": "Crystals", "unit": "/hpf", "value": "Absent", "method": "Standard Method", "biological_ref_interval": "Absent"}, {"name": "Amorphous Material", "unit": "-", "value": "Absent", "method": "Standard Method", "biological_ref_interval": "-"}], "HB Electrophoresis By HPLC": [{"name": "Hb A", "unit": "%", "value": "0", "method": "Standard Method", "biological_ref_interval": "96.8"}, {"name": "Hb A2", "unit": "%", "value": "2.8", "method": "Standard Method", "biological_ref_interval": "2.2"}, {"name": "P2 Peak", "unit": "%", "value": "5.5", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "P3 Peak", "unit": "%", "value": "5.2", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Foetal Hb", "unit": "%", "value": "0.3", "method": "Standard Method", "biological_ref_interval": "0"}], "Peripheral Smear Examination": [{"name": "RBC Morphology", "unit": null, "value": "Normochromic Normocytic", "method": "Microscopy", "biological_ref_interval": "-"}, {"name": "WBC Morphology", "unit": null, "value": "WBCs Series Shows Normal Morphology", "method": "Microscopy", "biological_ref_interval": "-"}, {"name": "Platelets Morphology", "unit": null, "value": "Platelets are adequate with normal morphology.", "method": "Microscopy", "biological_ref_interval": "-"}, {"name": "Parasites", "unit": null, "value": "Malarial parasite is not detected.", "method": "Microscopy", "biological_ref_interval": "-"}], "Erythrocyte Sedimentation Rate": [{"name": "ESR", "unit": "0", "value": "Capillary photometry", "method": "Standard Method", "biological_ref_interval": "0"}], "HbA1c (Glycosylated Hemoglobin)": [{"name": "HbA1c", "unit": "-", "value": "assay Interferences", "method": "Standard Method", "biological_ref_interval": "-"}], "Physical & Chemical (Dip strip) examination": [{"name": "Colour", "unit": "Pale Yellow", "value": "Pale Yellow", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Clearity", "unit": "Clear", "value": "Clear", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "pH", "unit": "4.6", "value": "6", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Specific Gravity", "unit": "1", "value": "1.03", "method": "Standard Method", "biological_ref_interval": "-"}, {"name": "Urine Glucose", "unit": "Absent", "value": "Present (+)", "method": "Hexokinase", "biological_ref_interval": "-"}]}	\N	209	1
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: healthkeeper
--

COPY public.posts (id, title, body, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: reference_ranges; Type: TABLE DATA; Schema: public; Owner: healthkeeper
--

COPY public.reference_ranges (id, biomarker_id, min_value, max_value, unit, source, created_at, updated_at) FROM stdin;
1	1	13.0	16.5	g/dL	Lab Report	2024-12-31 02:15:42.848852	2024-12-31 02:15:42.848852
2	3	4.5	5.5	-	Lab Report	2024-12-31 02:15:42.932986	2024-12-31 02:15:42.932986
3	4	40.0	49.0	%	Lab Report	2024-12-31 02:15:42.986775	2024-12-31 02:15:42.986775
4	5	83.0	101.0	fL	Lab Report	2024-12-31 02:15:43.057541	2024-12-31 02:15:43.057541
5	6	27.1	32.5	pg	Lab Report	2024-12-31 02:15:43.112811	2024-12-31 02:15:43.112811
6	7	32.5	36.7	g/dL	Lab Report	2024-12-31 02:15:43.172105	2024-12-31 02:15:43.172105
7	8	4000.0	10000.0	-	Lab Report	2024-12-31 02:15:43.222008	2024-12-31 02:15:43.222008
8	9	0.0	100.0	days	Lab Report	2024-12-31 02:15:43.273587	2024-12-31 02:15:43.273587
9	10	0.0	100.0	mg/dL	Lab Report	2024-12-31 02:15:43.329496	2024-12-31 02:15:43.329496
10	11	0.0	100.0	mg/dL	Lab Report	2024-12-31 02:15:43.498313	2024-12-31 02:15:43.498313
11	12	0.0	100.0	mg/dL	Lab Report	2024-12-31 02:15:43.552824	2024-12-31 02:15:43.552824
12	13	15.0	35.0	mg/dL	Lab Report	2024-12-31 02:15:43.60683	2024-12-31 02:15:43.60683
13	14	0.0	100.0	Up	Lab Report	2024-12-31 02:15:43.667732	2024-12-31 02:15:43.667732
14	15	0.0	100.0	Up	Lab Report	2024-12-31 02:15:43.720002	2024-12-31 02:15:43.720002
15	16	74.0	106.0	mg/dL	Lab Report	2024-12-31 02:15:43.769685	2024-12-31 02:15:43.769685
16	17	0.0	100.0	mg/dL	Lab Report	2024-12-31 02:15:43.824156	2024-12-31 02:15:43.824156
17	18	0.58	1.59	ng/mL	Lab Report	2024-12-31 02:15:43.8893	2024-12-31 02:15:43.8893
18	19	4.87	11.72	mg/mL	Lab Report	2024-12-31 02:15:43.950088	2024-12-31 02:15:43.950088
19	20	11.6	14.0	%	Lab Report	2025-01-01 11:01:11.377226	2025-01-01 11:01:11.377226
52	53	11.6	14.0	%	Lab Report	2025-01-01 11:13:58.140847	2025-01-01 11:13:58.140847
53	3	4.5	5.5	million/cmm	Lab Report	2025-01-01 11:57:30.68627	2025-01-01 11:57:30.68627
54	8	4000.0	10000.0	thousand/cmm	Lab Report	2025-01-01 11:57:30.924345	2025-01-01 11:57:30.924345
55	54	4.5	5.5	million/cmm	Lab Report	2025-01-01 12:08:12.329106	2025-01-01 12:08:12.329106
56	55	4000.0	10000.0	thousand/cmm	Lab Report	2025-01-01 12:08:12.613586	2025-01-01 12:08:12.613586
57	56	74.0	100.0	H	Lab Report	2025-01-03 12:16:33.213595	2025-01-03 12:16:33.213595
58	57	4.3	6.1	%	Lab Report	2025-01-03 12:16:33.442148	2025-01-03 12:16:33.442148
59	58	14.0	18.0	L**	Lab Report	2025-01-03 12:16:34.011051	2025-01-03 12:16:34.011051
60	59	42.0	52.0	L**	Lab Report	2025-01-03 12:16:34.158708	2025-01-03 12:16:34.158708
61	60	4.8	10.8	thousand/cmm	Lab Report	2025-01-03 12:21:55.118927	2025-01-03 12:21:55.118927
62	61	80.0	100.0	H	Lab Report	2025-01-03 12:21:55.270225	2025-01-03 12:21:55.270225
63	62	27.0	32.0	H	Lab Report	2025-01-03 12:21:55.369484	2025-01-03 12:21:55.369484
64	63	32.0	36.0	g/dL	Lab Report	2025-01-03 12:21:55.46732	2025-01-03 12:21:55.46732
65	64	0.0	100.0	and	Lab Report	2025-01-03 12:21:55.582008	2025-01-03 12:21:55.582008
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: healthkeeper
--

COPY public.roles (id, name, resource_type, resource_id, created_at, updated_at) FROM stdin;
1	user	User	1	2024-12-31 01:22:57.510995	2024-12-31 01:22:57.563
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: healthkeeper
--

COPY public.schema_migrations (version) FROM stdin;
20241006005518
20241006010248
20241006010335
20241006011525
20241006011535
20241006011739
20241007003859
20241009062825
20241126065249
20241209124418
20241209124420
20241209231115
20241210001556
20250103
20240105000001
20240105000003
20250103235959
20250104000001
20250105000001
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: healthkeeper
--

COPY public.users (id, email, first_name, last_name, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at, age) FROM stdin;
1	haothai064@gmail.com	Hao	Thai	$2a$12$oOlECSMsc/mJCK4XwgnwaOduVD.9MqtTScI8wsfAN665g8QsTfqA.	\N	\N	\N	2024-12-31 01:22:57.3623	2024-12-31 01:22:57.3623	\N
\.


--
-- Data for Name: users_roles; Type: TABLE DATA; Schema: public; Owner: healthkeeper
--

COPY public.users_roles (user_id, role_id) FROM stdin;
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: healthkeeper
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 210, true);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: healthkeeper
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 210, true);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: healthkeeper
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Name: biomarkers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: healthkeeper
--

SELECT pg_catalog.setval('public.biomarkers_id_seq', 64, true);


--
-- Name: health_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: healthkeeper
--

SELECT pg_catalog.setval('public.health_records_id_seq', 210, true);


--
-- Name: lab_tests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: healthkeeper
--

SELECT pg_catalog.setval('public.lab_tests_id_seq', 972, true);


--
-- Name: measurements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: healthkeeper
--

SELECT pg_catalog.setval('public.measurements_id_seq', 2, true);


--
-- Name: pdfs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: healthkeeper
--

SELECT pg_catalog.setval('public.pdfs_id_seq', 51, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: healthkeeper
--

SELECT pg_catalog.setval('public.posts_id_seq', 1, false);


--
-- Name: reference_ranges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: healthkeeper
--

SELECT pg_catalog.setval('public.reference_ranges_id_seq', 65, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: healthkeeper
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: healthkeeper
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: biomarkers biomarkers_pkey; Type: CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.biomarkers
    ADD CONSTRAINT biomarkers_pkey PRIMARY KEY (id);


--
-- Name: health_records health_records_pkey; Type: CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.health_records
    ADD CONSTRAINT health_records_pkey PRIMARY KEY (id);


--
-- Name: lab_tests lab_tests_pkey; Type: CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.lab_tests
    ADD CONSTRAINT lab_tests_pkey PRIMARY KEY (id);


--
-- Name: measurements measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.measurements
    ADD CONSTRAINT measurements_pkey PRIMARY KEY (id);


--
-- Name: pdfs pdfs_pkey; Type: CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.pdfs
    ADD CONSTRAINT pdfs_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: reference_ranges reference_ranges_pkey; Type: CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.reference_ranges
    ADD CONSTRAINT reference_ranges_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_biomarkers_on_name; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE UNIQUE INDEX index_biomarkers_on_name ON public.biomarkers USING btree (name);


--
-- Name: index_health_records_on_user_id; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_health_records_on_user_id ON public.health_records USING btree (user_id);


--
-- Name: index_lab_tests_on_biomarker_id; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_lab_tests_on_biomarker_id ON public.lab_tests USING btree (biomarker_id);


--
-- Name: index_lab_tests_on_reference_range_id; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_lab_tests_on_reference_range_id ON public.lab_tests USING btree (reference_range_id);


--
-- Name: index_lab_tests_on_user_id; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_lab_tests_on_user_id ON public.lab_tests USING btree (user_id);


--
-- Name: index_measurements_on_user_id; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_measurements_on_user_id ON public.measurements USING btree (user_id);


--
-- Name: index_pdfs_on_health_record_id; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_pdfs_on_health_record_id ON public.pdfs USING btree (health_record_id);


--
-- Name: index_pdfs_on_processed_data; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_pdfs_on_processed_data ON public.pdfs USING gin (processed_data);


--
-- Name: index_pdfs_on_scan_method; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_pdfs_on_scan_method ON public.pdfs USING btree (scan_method);


--
-- Name: index_pdfs_on_status; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_pdfs_on_status ON public.pdfs USING btree (status);


--
-- Name: index_pdfs_on_user_id; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_pdfs_on_user_id ON public.pdfs USING btree (user_id);


--
-- Name: index_reference_ranges_on_biomarker_id; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_reference_ranges_on_biomarker_id ON public.reference_ranges USING btree (biomarker_id);


--
-- Name: index_roles_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_roles_on_name_and_resource_type_and_resource_id ON public.roles USING btree (name, resource_type, resource_id);


--
-- Name: index_roles_on_resource; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_roles_on_resource ON public.roles USING btree (resource_type, resource_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_roles_on_role_id; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_users_roles_on_role_id ON public.users_roles USING btree (role_id);


--
-- Name: index_users_roles_on_user_id; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_users_roles_on_user_id ON public.users_roles USING btree (user_id);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: healthkeeper
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON public.users_roles USING btree (user_id, role_id);


--
-- Name: lab_tests fk_rails_1ddbb23561; Type: FK CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.lab_tests
    ADD CONSTRAINT fk_rails_1ddbb23561 FOREIGN KEY (reference_range_id) REFERENCES public.reference_ranges(id);


--
-- Name: lab_tests fk_rails_33d83230e0; Type: FK CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.lab_tests
    ADD CONSTRAINT fk_rails_33d83230e0 FOREIGN KEY (biomarker_id) REFERENCES public.biomarkers(id);


--
-- Name: health_records fk_rails_59cd2511ce; Type: FK CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.health_records
    ADD CONSTRAINT fk_rails_59cd2511ce FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: pdfs fk_rails_5d5ba95593; Type: FK CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.pdfs
    ADD CONSTRAINT fk_rails_5d5ba95593 FOREIGN KEY (health_record_id) REFERENCES public.health_records(id);


--
-- Name: reference_ranges fk_rails_60015dbb62; Type: FK CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.reference_ranges
    ADD CONSTRAINT fk_rails_60015dbb62 FOREIGN KEY (biomarker_id) REFERENCES public.biomarkers(id);


--
-- Name: pdfs fk_rails_6edf1da306; Type: FK CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.pdfs
    ADD CONSTRAINT fk_rails_6edf1da306 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: measurements fk_rails_b199c8b9fc; Type: FK CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.measurements
    ADD CONSTRAINT fk_rails_b199c8b9fc FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: lab_tests fk_rails_b760cef9e1; Type: FK CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.lab_tests
    ADD CONSTRAINT fk_rails_b760cef9e1 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: healthkeeper
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- PostgreSQL database dump complete
--

