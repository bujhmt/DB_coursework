--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE bujhm9;
ALTER ROLE bujhm9 WITH NOSUPERUSER INHERIT NOCREATEROLE CREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5771898ebf5b610cf153ec4485485b30a';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5594c19d9fbc8aea31dfd68aeff466cf0';
CREATE ROLE replica;
ALTER ROLE replica WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN REPLICATION NOBYPASSRLS PASSWORD 'md5acee3b0676df84997af82164ddf39073';






--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5 (Ubuntu 12.5-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.5 (Ubuntu 12.5-0ubuntu0.20.04.1)

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
-- PostgreSQL database dump complete
--

--
-- Database "coursework" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5 (Ubuntu 12.5-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.5 (Ubuntu 12.5-0ubuntu0.20.04.1)

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
-- Name: coursework; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE coursework WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE coursework OWNER TO postgres;

\connect coursework

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
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: generatedate(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generatedate() RETURNS date
    LANGUAGE plpgsql
    AS $$ declare outputDate date; begin select date (timestamp '2000-01-01' + random() * (timestamp '2020-12-31' - timestamp '2000-01-01')) into outputDate; return outputDate; end; $$;


ALTER FUNCTION public.generatedate() OWNER TO postgres;

--
-- Name: generateint(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generateint(max integer) RETURNS text
    LANGUAGE plpgsql
    AS $$ declare outputInt int; begin select trunc(random() * max + 1) into outputInt; return outputInt; end; $$;


ALTER FUNCTION public.generateint(max integer) OWNER TO postgres;

--
-- Name: generatestring(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generatestring(length integer) RETURNS text
    LANGUAGE plpgsql
    AS $$ declare outputString text; begin select string_agg(chr(trunc(97 + random()*25)::int), '') from generate_series(1, length) into outputString; return outputString; end; $$;


ALTER FUNCTION public.generatestring(length integer) OWNER TO postgres;

--
-- Name: getrandomrow(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getrandomrow(table_name text) RETURNS text
    LANGUAGE plpgsql
    AS $$ declare output int; begin EXECUTE format('select id from "%s" ORDER BY random() LIMIT 1', table_name) into output; return output; end; $$;


ALTER FUNCTION public.getrandomrow(table_name text) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Category" (
    id integer NOT NULL,
    name character varying,
    type character varying
);


ALTER TABLE public."Category" OWNER TO postgres;

--
-- Name: Category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Category_id_seq" OWNER TO postgres;

--
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Category_id_seq" OWNED BY public."Category".id;


--
-- Name: Client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Client" (
    id integer NOT NULL,
    name character varying,
    birthday_date date,
    email character varying
);


ALTER TABLE public."Client" OWNER TO postgres;

--
-- Name: Client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Client_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Client_id_seq" OWNER TO postgres;

--
-- Name: Client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Client_id_seq" OWNED BY public."Client".id;


--
-- Name: Link_Product-Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Link_Product-Category" (
    product_id integer,
    category_id integer
);


ALTER TABLE public."Link_Product-Category" OWNER TO postgres;

--
-- Name: Link_Product-Order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Link_Product-Order" (
    product_id integer,
    order_id integer
);


ALTER TABLE public."Link_Product-Order" OWNER TO postgres;

--
-- Name: Order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Order" (
    id integer NOT NULL,
    transaction_date date,
    taxes_sum numeric,
    client_id integer
);


ALTER TABLE public."Order" OWNER TO postgres;

--
-- Name: Order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Order_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Order_id_seq" OWNER TO postgres;

--
-- Name: Order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_id_seq" OWNED BY public."Order".id;


--
-- Name: Product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Product" (
    id integer NOT NULL,
    name character varying,
    brand character varying,
    manufacturer character varying,
    manufacture_date date,
    cost numeric
);


ALTER TABLE public."Product" OWNER TO postgres;

--
-- Name: Product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Product_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Product_id_seq" OWNER TO postgres;

--
-- Name: Product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Product_id_seq" OWNED BY public."Product".id;


--
-- Name: Category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category" ALTER COLUMN id SET DEFAULT nextval('public."Category_id_seq"'::regclass);


--
-- Name: Client id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client" ALTER COLUMN id SET DEFAULT nextval('public."Client_id_seq"'::regclass);


--
-- Name: Order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order" ALTER COLUMN id SET DEFAULT nextval('public."Order_id_seq"'::regclass);


--
-- Name: Product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Category" (id, name, type) FROM stdin;
1	Audio & Video Accessories	Electronics
2	TV Mounts	Electronics
3	TV Accessories & Parts	Electronics
4	Electronics	Electronics
5	A/V Presentation	Electronics
6	Accessories & Supplies	Electronics
7	TV Ceiling & Wall Mounts	Electronics
8	Stereos	Electronics
9	Portable Bluetooth Speakers	Electronics
10	TV	Electronics
11	 Video & Home Audio	Electronics
12	Speaker Systems	Electronics
13	Portable Audio & Video	Electronics
14	See more Black BOYTONE Bt-210f 30 Watt FM Radio Bluetoo...	Electronics
15	Speakers	Electronics
16	Home Audio & Theater	Electronics
17	All Home Speakers	Electronics
18	Consumer Electronics	Electronics
19	See more BOYTONE Bt-210f Bluetooth Wireless Speaker Mp3...	Electronics
20	Home Theater Systems	Electronics
21	MP3 Player Accessories	Electronics
22	Home Audio	Electronics
23	Audio	Electronics
24	Cell	Electronics
25	Stereo Shelf Systems	Electronics
26	Computers	Electronics
27	Office	Electronics
28	Computer Accessories	Electronics
29	Computer Accessories & Peripherals	Electronics
30	Laptop Accessories	Electronics
31	Laptop Chargers & Adapters	Electronics
32	Computers & Tablets	Electronics
33	Battery Chargers	Electronics
34	Batteries	Electronics
35	Office Technology	Electronics
36	Bluetooth & Wireless Speakers	Electronics
37	Portable Speakers & Docks	Electronics
38	Surround Speakers	Electronics
39	Electronics Features	Electronics
40	Surround Sound Systems	Electronics
41	Frys	Electronics
42	All Home Theater Systems	Electronics
43	TVs Entertainment	Electronics
44	Home Electronics	Electronics
45	TV Sound Systems rxxbwxxcscxuvutetd	Electronics
46	Home & Kitchen Features	Electronics
47	Audio Speakers	Electronics
48	TV Sound Systems	Electronics
49	Home Theater	Electronics
50	Electrical	Electronics
51	Remote Controls	Electronics
52	TV Remote Controls	Electronics
53	Universal Remote Controls	Electronics
54	TV & Home Theater	Electronics
55	TV & Home Theater Accessories	Electronics
56	Audio & Home Theatre	Electronics
57	Internal Solid State Drives	Electronics
58	Solid State Drives	Electronics
59	Computers & Accessories	Electronics
60	Hard Drives & Storage	Electronics
61	Data Storage	Electronics
62	Memory (RAM)	Electronics
63	Computer Components	Electronics
64	Memory Upgrades	Electronics
65	Memory	Electronics
66	Computer Cards & Components	Electronics
67	MP3 & MP4 Player Accessories	Electronics
68	Portable Speakers	Electronics
69	Cameras & Camcorders	Electronics
70	All Camcorders	Electronics
71	Home	Electronics
72	 Garage & Office	Electronics
73	Pet Supplies & Technology	Electronics
74	Pet Cameras & Technology	Electronics
75	Wearable Pet Cameras	Electronics
76	Webcams	Electronics
77	Housewares	Electronics
78	Pet Cameras	Electronics
79	Dog	Electronics
80	Training Aids	Electronics
81	Training & Behavior	Electronics
82	Networking	Electronics
83	Routers	Electronics
84	pet	Electronics
85	Security & Surveillance	Electronics
86	Surveillance Video Equipment	Electronics
87	Security Monitors & Displays	Electronics
88	Headphones	Electronics
89	Bluetooth Headphones	Electronics
90	All Headphones	Electronics
91	Portable Audio & Headphones	Electronics
92	Earbud Headphones	Electronics
93	Mobile	Electronics
94	Internal Hard Drives	Electronics
95	Internal Drives	Electronics
96	Drives	Electronics
97	 Storage & Blank Media	Electronics
98	Hard Drives (HDD	Electronics
99	 SSD & NAS)	Electronics
100	Internal Hard Disk Drives	Electronics
101	Drives Storage	Electronics
102	Computers/Tablets & Networking	Electronics
103	Audio Power Conditioners	Electronics
104	A/V Surge Protectors & Power	Electronics
105	Musical Instruments & Gear	Electronics
106	Pro Audio Equipment	Electronics
107	Extension Cords & Surge Protectors	Electronics
108	Multipurpose Batteries & Power	Electronics
109	Surge Protectors	Electronics
110	 Power Strips	Electronics
111	Parts & Accessories	Electronics
112	Car Speakers	Electronics
113	6.5\\\\ Car Speakers	Electronics
114	Car Electronics	Electronics
115	eBay Motors	Electronics
116	Car Audio	Electronics
117	Auto & Tires	Electronics
118	All Car Speakers & Subwoofers	Electronics
119	Coaxial Speakers	Electronics
120	Speakers & Speaker Systems	Electronics
121	Car & Vehicle Electronics	Electronics
122	Auto Electronics	Electronics
123	Car Speakers & Speaker Systems	Electronics
124	Car Speakers and Subwoofers	Electronics
125	Vehicle Electronics & GPS	Electronics
126	Car Electronics & GPS	Electronics
127	Hard Drives	Electronics
128	Solid State Drives (SSDs)	Electronics
129	Data Storage Products	Electronics
130	Accessories	Electronics
131	Portable Power Banks	Electronics
132	Portable Chargers/Power Packs	Electronics
133	Cell Phones & Accessories	Electronics
134	Cell Phones	Electronics
135	Portable Battery Packs	Electronics
136	Cell Phone Accessories	Electronics
137	Cell Phone Batteries & Power	Electronics
138	Batteries & Battery Packs	Electronics
139	cell	Electronics
140	Power	Electronics
141	Chargers & Cradles	Electronics
142	Bluetooth Headsets	Electronics
143	Wireless Headphones	Electronics
144	In-Wall & In-Ceiling Speakers	Electronics
145	In-Ceiling Speakers	Electronics
146	Projectors & Presentation Equipment	Electronics
147	Audio Visual Presentation	Electronics
148	TV Stands	Electronics
149	 Mounts & Furniture	Electronics
150	Projector Mounts Accessories	Electronics
151	Projector Mounts & Screens	Electronics
152	Projector Mounts	Electronics
153	Mounts Carts	Electronics
154	Mounting Plates	Electronics
155	Projectors & Screens	Electronics
156	Networking Products	Electronics
157	Powerline Network Adapters	Electronics
158	Network Adapters	Electronics
159	Marine Audio	Electronics
160	Fishing	Electronics
161	Powersports Audio	Electronics
162	Automotive	Electronics
163	Outdoor Sports	Electronics
164	Marine & Powersports	Electronics
165	Marine Electronics	Electronics
166	Marine Speakers	Electronics
167	PDUs	Electronics
168	Surge Protectors & Power	Electronics
169	 Chargers & Accessories	Electronics
170	Keyboards	Electronics
171	 Mice & Joysticks	Electronics
172	All Keyboards	Electronics
173	 Mice & Accessories	Electronics
174	iPad & Tablet Accessories	Electronics
175	Tablet Cases	Electronics
176	 Covers & Keyboard Folios	Electronics
177	Computer Peripherals	Electronics
178	Keyboards Accessories	Electronics
179	Computers Features	Electronics
180	Cases	Electronics
181	Name Brands	Electronics
182	Microsoft	Electronics
183	Microsoft Surface	Electronics
184	Microsoft Surface Accessories	Electronics
185	Microsoft Surface Cases & Covers	Electronics
186	Microsoft Surface Tablets	Electronics
187	Tablets	Electronics
188	All Bluetooth & Wireless Speakers	Electronics
189	Speaker Accessories	Electronics
190	Selector Switch Boxes	Electronics
191	Speaker Selector Switches	Electronics
192	Home Improvement	Electronics
193	Distribution	Electronics
194	In-Dash Stereos	Electronics
195	Home Audio Accessories	Electronics
196	Ceiling & In-Wall Speakers	Electronics
197	Straps & Hand Grips	Electronics
198	Camera & Photo Accessories	Electronics
199	Camera Accessories	Electronics
200	Cameras & Photo	Electronics
201	Digital Camera Accessories	Electronics
202	Camera Straps	Electronics
203	Photography	Electronics
204	Other Camera Accessories	Electronics
205	Camera Straps Harnesses	Electronics
206	Photography Bags Cases	Electronics
207	Camera Bags	Electronics
208	 Cases & Straps	Electronics
209	Backpacks ffvzrevebzuqvcddwzzxeuwva	Electronics
210	Camera Bags & Cases	Electronics
211	Bag & Case Accessories	Electronics
212	Camera Backpacks	Electronics
213	Camera & Photo	Electronics
214	Hiking Daypacks	Electronics
215	Camera Cases	Electronics
216	Backpacking Packs	Electronics
217	Camera & Photo Features	Electronics
218	Backpacks	Electronics
219	Bags & Cases	Electronics
220	Outdoor Recreation	Electronics
221	LCD TVs	Electronics
222	Samsung TVs	Electronics
223	Shop TVs by Type	Electronics
224	Televisions	Electronics
225	TVs by Brand	Electronics
226	All Flat-Panel TVs	Electronics
227	All TVs	Electronics
228	LED & LCD TVs	Electronics
229	TVs	Electronics
230	TV & Video	Electronics
231	Television & Video	Electronics
232	LED TVs	Electronics
233	Portable Audio	Electronics
234	Portable Wireless & Bluetooth Speakers	Electronics
235	Wireless and Bluetooth Speakers	Electronics
236	Wireless & Portable Bluetooth Speakers	Electronics
237	Computer Speakers	Electronics
238	Car Subwoofers	Electronics
239	Subwoofers	Electronics
240	Subwoofer Speakers	Electronics
241	Refurbished Tablets	Electronics
242	See more Apple iPad 3rd Generation 64GB	Electronics
243	 Wi-Fi	Electronics
244	 A1416	Electronics
245	 ...	Electronics
246	Tablets & eBook Readers	Electronics
247	Laptop Memory	Electronics
248	Monitor Wall Mounts	Electronics
249	Monitor Mounts Stands	Electronics
250	In-Wall Speakers	Electronics
251	Install Outdoor Speakers	Electronics
252	TVs Entertainment rurzqfuttdttut	Electronics
253	Receivers Amplifiers	Electronics
254	Receivers	Electronics
255	Home Theater Receivers	Electronics
256	Receivers & Amplifiers	Electronics
257	AV Receivers & Amplifiers	Electronics
258	Batteries & A	Electronics
259	Tools	Electronics
260	C Adapters	Electronics
261	Car Battery Chargers	Electronics
262	 Chargers & Jumper Cables	Electronics
263	Electric Screens (Wide Formats) drabtxtysaxdbf	Electronics
264	Projector Screens	Electronics
265	Projection Screens	Electronics
266	Electric Screens (Wide Formats)	Electronics
267	Electric Screens (Wide Formats) rcrbftadsasbvtdtaddybarcyxyr	Electronics
268	Projection Screens edqcqwqd	Electronics
269	Electric Screens (Wide Formats) baesfadqwexxbctqsw	Electronics
270	Projection Screens (by Type)	Electronics
271	Mobile Bluetooth Speakers	Electronics
272	Mobile Speakers	Electronics
273	Outdoor Speakers	Electronics
274	Speaker Separates	Electronics
275	6\\\\ x 8\\\\ Car Speakers	Electronics
276	4K Hisense TVs	Electronics
277	4K TVs by Brand	Electronics
278	Network Attached Storage	Electronics
279	Internal Drives awwrreydetdbtcseaw	Electronics
280	Internal Drives dyvcuetbawyvbsytuvtzvtdabqtvcawudqty	Electronics
281	PC Components	Electronics
282	Hard Drives - Internal	Electronics
283	Internal Drives wcxaeeveystbtzftbafuee	Electronics
284	Internal Drives ceefrfsraebcuusavwfbwty	Electronics
285	Earbud & In-Ear Headphones	Electronics
286	All Portable Speakers	Electronics
287	Portable AM/FM Radios	Electronics
288	Docks	Electronics
289	 Radios & Boomboxes	Electronics
290	Radios	Electronics
291	Shortwave Radios	Electronics
292	MP3 Accessories	Electronics
293	Car Receivers	Electronics
294	All In-Dash Stereos	Electronics
295	Car Video	Electronics
296	In-Dash DVD & Video Receivers	Electronics
297	Car Stereo Receivers	Electronics
298	All Car Stereo Receivers	Electronics
299	Auto Accessories	Electronics
300	All Auto Accessories	Electronics
301	iPod	Electronics
302	 Audio Player Accessories	Electronics
303	Remotes	Electronics
304	Car Electronics Accessories	Electronics
305	Audio/Video Remotes	Electronics
306	Other Car Audio	Electronics
307	Car Installation Parts & Accessories	Electronics
308	Bluetooth/Hands-Free Car Kits	Electronics
309	Used:Monitors Accessories	Electronics
310	Used:Other Monitor Accessories	Electronics
311	Used:Video	Electronics
312	LCD Television Mounts	Electronics
313	Office Equipment Supplies	Electronics
314	Home Audio & Video Accessories	Electronics
315	Audio-Video Shelving	Electronics
316	Shelving	Electronics
317	Speaker Wall Mounts	Electronics
318	Mount Accessories	Electronics
319	Furniture	Electronics
320	TV Accessories	Electronics
321	Home & Kitchen	Electronics
322	Audio Visual Presentation reuqrtetbvuyusedwxvswsdrrqcb	Electronics
323	Mount Add-Ons	Electronics
324	Home Entertainment Furniture	Electronics
325	Storage & Organization	Electronics
326	Video Games & Consoles	Electronics
327	Video Game Accessories	Electronics
328	Headsets	Electronics
329	Video Games	Electronics
330	Gaming Headsets	Electronics
331	Audio & Video Components	Electronics
332	Microphone & Headsets	Electronics
333	Audio Cables	Electronics
334	RCA Cables	Electronics
335	Speaker Cables & Wire	Electronics
336	Cables & Interconnects	Electronics
337	Tools & Home Improvement	Electronics
338	Wireless & Streaming Audio	Electronics
339	Wireless Speakers	Electronics
340	Wireless Multi-Room Speakers	Electronics
341	Wireless Multi-Room Speakers dusrsqqdtddevtxfaxsqbcdbucserurxzcfzu	Electronics
342	In-Home Speakers	Electronics
343	Bookshelf Speakers	Electronics
344	Satellite Radio	Electronics
345	Satellite Radios	Electronics
346	Car Satellite Radios	Electronics
347	SIRIUS XM Satellite Radio	Electronics
348	Desktop Memory	Electronics
349	Computer Components & Parts	Electronics
350	Memory (RAM	Electronics
351	Samsung Tax Time Savings	Electronics
352	Refurbished TVs	Electronics
353	Smart TVs	Electronics
354	Sports & Outdoors	Electronics
355	Kicker	Electronics
356	Speaker Separates xdxucwferurybaydybbz	Electronics
357	Powered Speakers	Electronics
358	 Headsets	Electronics
359	 Mics Webcams	Electronics
360	Tabletop Audio	Electronics
361	Mini Hi-Fi Systems	Electronics
362	Install Outdoor Speakers rrrxazwwfbsa	Electronics
363	Outdoor Speakers rxxbwxxcscxuvutetd	Electronics
364	Floor Speakers	Electronics
365	Media Streaming Players	Electronics
366	New Technology	Electronics
367	Streaming Media Players	Electronics
368	Internet TV Broadcasters	Electronics
369	Streaming Media	Electronics
370	All Streaming Media Players	Electronics
371	Blank Media	Electronics
372	Data Cartridges	Electronics
373	Camcorder Tapes & Discs	Electronics
374	Camcorder Accessories	Electronics
375	Blank DVDs & Tapes	Electronics
376	 Video & Audio Accessories	Electronics
377	Other TV	Electronics
378	 Video & Audio Accs	Electronics
379	Mini DVs	Electronics
380	Audio Cassettes	Electronics
381	Audio Docks & Mini Speakers	Electronics
382	Used:TV Entertainment	Electronics
383	Used:Portable Audio	Electronics
384	Sony SRS-HG1	Electronics
385	Used:Speakers	Electronics
386	Wireless Home Speakers	Electronics
387	Home & Garden	Electronics
388	Wireless	Electronics
389	Security Cameras	Electronics
390	Wireless Cameras	Electronics
391	Security Cameras & Surveillance	Electronics
392	Surveillance Video	Electronics
393	Home Security	Electronics
394	Smart Home	Electronics
395	Surveillance	Electronics
396	Surveillance Equipment	Electronics
397	Mesh Wi-Fi	Electronics
398	Wi-Fi & Networking	Electronics
399	Home Automation	Electronics
400	Networking & Wireless	Electronics
401	Home Automation Kits	Electronics
402	Whole Home Smart Wi-Fi	Electronics
403	Home Automation & Security	Electronics
404	Home Networking & Connectivity	Electronics
405	Wireless Networking	Electronics
406	Home Automation and Security	Electronics
407	Whole Home Smart Wi-Fi vsfwsaywuaxvyz	Electronics
408	Wireless Routers	Electronics
409	Home Automation Hub	Electronics
410	Automation Packs	Electronics
411	Whole Home Wi-Fi Systems	Electronics
412	Smart Home Assistants	Electronics
413	 Controllers & Hubs	Electronics
414	Smart Home Kits and Hubs	Electronics
415	Whole Home Smart Wi-Fi zdztuauwxcwwrb	Electronics
416	Whole Home Smart Wi-Fi rzfbqsbddwuyywwqdvdzdvxasb	Electronics
417	Car Stereos	Electronics
418	In-Dash DVD Players	Electronics
419	In-Dash DVD Receivers	Electronics
420	Headrest DVD Players	Electronics
421	Backup Cameras	Electronics
422	car electronics	Electronics
423	Vehicle Backup Cameras	Electronics
424	Auto Safety Accessories	Electronics
425	Wireless & Multiroom Audio	Electronics
426	Wireless Multiroom Speakers	Electronics
427	Tripod Screens	Electronics
428	External Drives szwzcatdryyexyswev	Electronics
429	External Drives	Electronics
430	External Solid State Drives	Electronics
431	10\\\\ Car Subwoofer	Electronics
432	All Car Subwoofers	Electronics
433	Car Subwoofers & Enclosures	Electronics
434	Component Subwoofers	Electronics
435	Subwoofers & Enclosures	Electronics
436	See more Novatel Jetpack MiFi 6620l Hotspot 4G LTE Veri...	Electronics
437	Mobile Broadband	Electronics
438	Mobile Broadband Devices	Electronics
439	Access Points	Electronics
440	 Hubs & Switches	Electronics
441	Verizon Hotspots	Electronics
442	Mobile Hotspots	Electronics
443	On-Ear Headphones	Electronics
444	Phones & Accessories	Electronics
445	Headsets & Accessories	Electronics
446	 Tech Toys	Electronics
447	 Movies	Electronics
448	 Music	Electronics
449	Over the Ear	Electronics
450	Computer Monitors ardbvbarzuftq	Electronics
451	LCD Monitors	Electronics
452	Monitors	Electronics
453	 Projectors & Accs	Electronics
454	Monitors Displays	Electronics
455	Laptops	Electronics
456	Computer Monitors	Electronics
457	External Drives yaxcrfezbsbyucxcacwxfzcywcaueuqbquu	Electronics
458	Subwoofers yytusrxxusszazawxruwdtbeucyzda	Electronics
459	External Hard Disk Drives	Electronics
460	Hard Drive Accessories	Electronics
461	External Hard Drives	Electronics
462	Hard Drive Bags & Cases	Electronics
463	Tablet Docking Stations	Electronics
464	Docking Stations	Electronics
465	Notebook Accessories	Electronics
466	Docking Stations Port Replicators	Electronics
467	DVD Drives	Electronics
468	computers & tablets	Electronics
469	External Components	Electronics
470	Optical Drives	Electronics
471	Disc Duplicators	Electronics
472	Technology	Electronics
473	LED Monitors	Electronics
474	Sound Bars	Electronics
475	Portfolio Cases tfqvddravsdxfrevbrcayzywwsdxvrrfbewb	Electronics
476	Cell Phone & Tablet Accessories	Electronics
477	Portfolio Cases bwvwfaaerfwzcuwtaxtfztsbfbeurbfwtds	Electronics
478	iPad & Tablets	Electronics
479	Apple iPad Accessories	Electronics
480	Portfolio Cases syeetfbwuy	Electronics
481	Form Fitting Cases	Electronics
482	Tablet Computer Cases	Electronics
483	iPad Cases	Electronics
484	 Sleeves & Bags	Electronics
485	Portfolio Cases sqwdyuebzb	Electronics
486	Portfolio Cases	Electronics
487	Portfolio Cases csvwwceq	Electronics
488	Pro Audio	Electronics
489	RCA to RCA Cables	Electronics
490	Speaker Cables	Electronics
491	Cables Adapters	Electronics
492	A/V Cables & Connectors	Electronics
493	Towers	Electronics
494	Lenovo	Electronics
495	Desktops By Brand	Electronics
496	All Desktops	Electronics
497	Desktops	Electronics
498	Desktop & All-in-One Computers	Electronics
499	Desktop Computers	Electronics
500	All-in-One Computers	Electronics
501	Desktops Workstations	Electronics
502	Desktop Computers wbeszexzzxeteywxtzby	Electronics
503	Desktops & All-In-Ones	Electronics
504	PC Desktops & All-In-Ones	Electronics
505	Computer Speakers xcbsztzedbfwuy	Electronics
506	Computer Speakers rxbctasrurctsc	Electronics
507	PC Computers	Electronics
508	Computer Speakers bezecfsy	Electronics
509	See more Samsung Ubd-m9500 4k Ultra HD Blu-ray Player	Electronics
510	Blu-ray DVD Players	Electronics
511	Test	Electronics
512	 Measurement & Inspection	Electronics
513	Blu-ray Disc Players	Electronics
514	Electrical & Test Equipment	Electronics
515	Blu-ray Players & Recorders	Electronics
516	Portable DVD Players	Electronics
517	DVD & Blu-ray Players	Electronics
518	Used:Blu-ray Disc Players	Electronics
519	Used:Players Recorders	Electronics
520	Blu Ray and DVD Players	Electronics
521	Other Test Meters & Detectors	Electronics
522	Media Players & Recorders	Electronics
523	Business & Industrial	Electronics
524	See more Samsung Ubd-m8500 4k WiFi Ultra HD Blu-ray DVD...	Electronics
525	Blu-ray Players	Electronics
526	Blu-ray DVD Players sdxexcebrx	Electronics
527	Test Meters & Detectors	Electronics
528	Blu-ray & DVD Players	Electronics
529	Compact & Shelf Stereos	Electronics
530	Home Audio Stereos	Electronics
531	 Components	Electronics
532	Boomboxes	Electronics
533	Gaming Monitors	Electronics
534	All Monitors	Electronics
535	CD Players & Digital Media Receivers	Electronics
536	Motors	Electronics
537	Marine Stereos	Electronics
538	CD Players	Electronics
539	Digital Media Receivers	Electronics
540	Digital Cameras	Electronics
541	Point & Shoot Cameras	Electronics
542	All Point & Shoot Cameras	Electronics
543	All Cameras	Electronics
544	Point Shoot Cameras	Electronics
545	Point & Shoot Digital Cameras	Electronics
546	All Home Stereos	Electronics
547	TVs & Electronics	Electronics
548	Subwoofer Cables	Electronics
549	Cables	Electronics
550	Over-Ear Headphones	Electronics
551	Over-Ear & On-Ear Headphones	Electronics
552	Wireless Adapters Cards	Electronics
553	USB Wi-Fi Adapters/Dongles	Electronics
554	Networking Cables & Accessories	Electronics
555	USB Network Adapters	Electronics
556	Wireless Networking rwtaqbstbwzzteq	Electronics
557	USB Wi-Fi Adapters	Electronics
558	Cameras	Electronics
559	 Camcorders & Optics	Electronics
560	 Bags & Covers	Electronics
561	Universal Camera Bags & Cases	Electronics
562	Shoulder Bags	Electronics
563	Controllers	Electronics
564	Video Game Racing Wheels for PC	Electronics
565	 Nintendo	Electronics
566	 Xbox or PlayStation	Electronics
567	Gaming Peripherals	Electronics
568	Xbox One	Electronics
569	Xbox One Accessories	Electronics
570	Xbox One Controllers	Electronics
571	Gaming Controllers svurybvfds	Electronics
572	Racing Wheels	Electronics
573	PC Gaming	Electronics
574	PC Gaming ftdzsbvfbetarvufrccysccfxybxctt	Electronics
575	Gaming Controllers zuxbbweveteztffywrybecztecqtezfbc	Electronics
576	Controllers & Attachments	Electronics
577	Gaming Controllers	Electronics
578	Gaming	Electronics
579	Used:Film Camera Lens Accessories	Electronics
580	Used:Filters	Electronics
581	Used:UV	Electronics
582	 Haze	Electronics
583	 Protection Clear	Electronics
584	Used:35mm Lens Accessories	Electronics
585	UV	Electronics
586	 Clear Skylight	Electronics
587	Filters	Electronics
588	Protective Polarizing Filters	Electronics
589	Skylight & UV Filters	Electronics
590	Used:Film Photography	Electronics
591	Used:Standard Filters	Electronics
592	PC Range Extenders	Electronics
593	Wi-Fi Extenders	Electronics
594	Powerline Networking	Electronics
595	Projection Screens & Material	Electronics
596	Projectors and Screens	Electronics
597	Projection Screens (by Type) baesfadqwexxbctqsw	Electronics
598	Slide & Movie Projection	Electronics
599	Fixed Frame Screens	Electronics
600	Office Electronics Accessories	Electronics
601	Film Photography	Electronics
602	Camera Chargers & Adapters	Electronics
603	Batteries & Chargers	Electronics
604	Camera	Electronics
605	Camera Batteries & Power	Electronics
606	Microphones & Headsets	Electronics
607	PC & Digital Gaming	Electronics
608	PC Gaming USB Controllers & Joysticks	Electronics
609	PC Gaming Headsets	Electronics
610	Gaming Accessories & Peripherals	Electronics
611	Headsets & Microphones	Electronics
612	PC Headsets	Electronics
613	Computer Headsets	Electronics
614	Shop Headphones by Type	Electronics
615	Over-Ear and On-Ear Headphones	Electronics
616	Home Theater & Audio	Electronics
617	Used:Headphones	Electronics
618	Used:Pro Audio	Electronics
619	Used:Audio Monitoring	Electronics
620	Shelf Systems	Electronics
621	#34          in	Electronics
622	Manual Screens	Electronics
623	#55	Electronics
624	901          in	Electronics
625	#736          in	Electronics
626	Center Channel Speakers	Electronics
627	Center-Channel Speakers	Electronics
628	Speaker Separates baesfadqwexxbctqsw	Electronics
629	Receivers xxsdxrxxsxubbsxbrfszdwautssv	Electronics
630	Vintage Speakers	Electronics
631	Vintage Electronics	Electronics
632	Home Speakers & Subwoofers	Electronics
633	Bookshelf Speakers yytusrxxusszazawxruwdtbeucyzda	Electronics
634	Mirrorless System Lenses	Electronics
635	See more Panasonic LUMIX 100-400mm F/4-22 UED ED Lens F...	Electronics
636	Mirrorless Lenses	Electronics
637	Lenses & Filters	Electronics
638	Camcorders	Electronics
639	Digital Camera Lenses	Electronics
640	Camera Lenses	Electronics
641	Photo Accessories	Electronics
642	Lenses	Electronics
643	Samsung Smart TVs	Electronics
644	Smart TVs by Brand	Electronics
645	4K Ultra HDTVs	Electronics
646	Internal Power Supplies	Electronics
647	Power Supplies	Electronics
648	Mice & Mice Pads	Electronics
649	All Mice & Mice Pads	Electronics
650	Mice Touchpads	Electronics
651	Mice	Electronics
652	 Trackballs & Touchpads	Electronics
653	Mice Touchpads dfttcvcdsazbuztqfecurburvtwvaaxu	Electronics
654	Mice Touchpads tdzfbcftbtrvtdescffxwcbq	Electronics
655	 Mice & Pointers	Electronics
656	Mice Touchpads dzxtwwcywtuatsferbucxdutzzbf	Electronics
657	Mice & Keyboards	Electronics
658	Mice Pointing devices	Electronics
659	Wireless & Bluetooth Mice	Electronics
660	Laptop Batteries	Electronics
661	computers	Electronics
662	Walmart for Business	Electronics
663	Office Electronics	Electronics
664	Phones	Electronics
665	Telephones & Communication	Electronics
666	Special Needs Telephones	Electronics
667	Categories	Electronics
668	Big Button & Amplified Telephones	Electronics
669	Connected Home & Housewares	Electronics
670	Phones Video Conferencing	Electronics
671	Analog Phones Accessories	Electronics
672	Phone Accessories	Electronics
673	Collaboration IP Telephony	Electronics
674	Bluetooth Headphones rydyqsaxrbrdyuquyetsrydxefvucsr	Electronics
675	Home Audio Components	Electronics
676	CD Players Changers	Electronics
677	Compact Radios & Stereos	Electronics
678	Repeaters	Electronics
679	4K Ultra HD TVs	Electronics
680	4K LG TVs	Electronics
681	Portable Battery Packs yxdasxffaabvrfusya	Electronics
682	Portable Battery Packs ccbdtucwsuccsbzvxsect	Electronics
683	Mobile Power	Electronics
684	Power Accessories	Electronics
685	Rechargeable Batteries	Electronics
686	Portable Battery Packs bcxsstqzbavv	Electronics
687	 Cooling Racks	Electronics
688	Receivers utxxbvrw	Electronics
689	Traditional Laptops	Electronics
690	Windows 10 Laptops	Electronics
691	All Laptops	Electronics
692	PC Laptops	Electronics
693	Touch-Screen All-in-One Computers	Electronics
694	Desktop Barebones	Electronics
695	Car Safety & Convenience	Electronics
696	Vehicle Diagnostics	Electronics
697	6\\\\ x 9\\\\ Car Speakers	Electronics
698	Install Outdoor Speakers wbdadzefwwsbvcrtwtvxqqdxsqdwtdtrwt	Electronics
699	In-Wall and In-Ceiling Speakers	Electronics
700	all electronics	Electronics
701	Android Auto Receivers	Electronics
702	Cables & Accessories	Electronics
703	Input Devices	Electronics
704	Mice Trackballs	Electronics
705	Power Conditioners	Electronics
706	GPS & Navigation	Electronics
707	Handheld GPS Units	Electronics
708	Vehicle GPS	Electronics
709	GPS Accessories	Electronics
710	GPS Navigation & Accessories	Electronics
711	Portable GPS	Electronics
712	Televisions Video Equipment	Electronics
713	KVM	Electronics
714	DVI/VGA KVM Extenders	Electronics
715	Modem Cables	Electronics
716	TV Cables & Connectors	Electronics
717	Interface / Add-On Cards	Electronics
718	KVM Extenders	Electronics
719	Other	Electronics
720	Home Theater Projectors	Electronics
721	Pico Projectors	Electronics
722	Video Projectors	Electronics
723	Projectors	Electronics
724	Used:Multimedia Projectors	Electronics
725	Used:A/V Presentation	Electronics
726	Wireless Multi-Room Speakers uytueusqxdvcfrxftfeefvcxudq	Electronics
727	Wireless Multiroom Audio Systems	Electronics
728	Speakers (Wall/Ceiling/PA)	Electronics
729	Speaker Systems Accessories	Electronics
730	See more Samsung R1 Wireless Audio Radiant 360 Wi-Fi Bl...	Electronics
731	Wireless Multiroom Systems	Electronics
732	Tablet Keyboard Folios	Electronics
733	Tablet Accessories	Electronics
734	Bags	Electronics
735	 Cases & Sleeves	Electronics
736	Keyboard Folios	Electronics
737	Logitech	Electronics
738	Tablet Keyboards	Electronics
739	Memory Cards	Electronics
740	Memory Cards Accessories	Electronics
741	Secure Digital (SD	Electronics
742	 SDHC	Electronics
743	 SDXC)	Electronics
744	SD Cards	Electronics
745	Computer Cables & Connectors	Electronics
746	Flash Memory	Electronics
747	Secure Digital (SDHC)	Electronics
748	Flash Memory Cards	Electronics
749	Switches	Electronics
750	Wired Networking	Electronics
751	Ethernet Switches	Electronics
752	Enterprise Networking	Electronics
753	 Servers	Electronics
754	Network Switches	Electronics
755	Switches & Hubs	Electronics
756	 Bridges Hubs	Electronics
757	Sports & Handheld GPS	Electronics
758	Smartwatch Bands	Electronics
759	Wearable Technology	Electronics
760	Smartwatches & Accessories	Electronics
761	Smartwatch Accessories	Electronics
762	Watch Bands	Electronics
763	Marine Electronics Accessories	Electronics
764	Marine Decks	Electronics
765	Laptop Replacement Parts	Electronics
766	Internal Network Cards	Electronics
767	Shop Laptops by Type	Electronics
768	Touchscreen Laptops	Electronics
769	Acer Laptops	Electronics
770	Laptops By Brand	Electronics
771	Acer	Electronics
772	PC Laptops & Netbooks	Electronics
773	Laptops & Netbooks	Electronics
774	Chromebooks	Electronics
775	See more Samsung 960 EVO 500gb NVMe M.2 Internal SSD	Electronics
776	Internal Drives szwzcatdryyexyswev	Electronics
777	Solid State Drives - SSD	Electronics
778	Tabletop Radios	Electronics
779	Laptop & Desktop Accessories	Electronics
780	Video Surveillance	Electronics
781	Surveillance Systems	Electronics
782	Remote Home Monitoring Systems	Electronics
783	Smart Security Cameras	Electronics
784	Connected Home	Electronics
785	The Well Chosen Event	Electronics
786	Exercise Equipment & Wearables	Electronics
787	Electronics Deals	Electronics
788	See more Sony Wireless Headphones Wh-1000xm2 Black	Electronics
789	Well Chosen Headphones	Electronics
790	Ways To Shop	Electronics
791	Micro SD (SD	Electronics
792	microSD (SDHC	Electronics
793	Micro SDXC	Electronics
794	microSDXC	Electronics
795	Health & Household	Electronics
796	Fitness & Activity Monitors	Electronics
797	Wellness & Relaxation	Electronics
798	Earbuds and In-ear Headphones	Electronics
799	True Wireless Earbud Headphones	Electronics
800	PC Gaming Accessories	Electronics
801	All PC Headsets	Electronics
802	See more Razer Kraken Pro V2 Analog Gaming Headset for ...	Electronics
803	Photography brqwasseuwbxvrwtdreewezqfxycfsdyzrceza	Electronics
804	Photography wqctvrrvbybxwsxf	Electronics
805	Mirrorless System Cameras	Electronics
806	All Mirrorless Cameras	Electronics
807	Mirrorless Cameras	Electronics
808	Mid Range Speakers	Electronics
809	All Car Speakers	Electronics
810	See more Alpine SPS-610C 2-Way 6.5in. Car Speakers Syst...	Electronics
811	Prime Lenses	Electronics
812	All Camera Lenses	Electronics
813	SLR Lenses	Electronics
814	DSLR Lenses	Electronics
815	In-Dash Audio Players	Electronics
816	Digital Media and CD Player Receivers	Electronics
817	In-Dash with DVD	Electronics
818	Graphics Cards	Electronics
819	GPUs/Video Graphics Cards	Electronics
820	Graphics/Video Cards	Electronics
821	PC to TV	Electronics
822	General Accessories	Electronics
823	Home Theater Networking	Electronics
824	TVs & Entertainment	Electronics
825	Desktop Computers By Type	Electronics
826	Shop Desktops By Type	Electronics
827	Gaming Desktops	Electronics
828	Towers Only	Electronics
829	All Laptop Computers	Electronics
830	Featured Laptops	Electronics
831	Notebooks	Electronics
832	Amplifiers	Electronics
833	iPad Keyboards	Electronics
834	Computer & Tablet Accessories	Electronics
835	iPad Accessories	Electronics
836	Technology & Services	Electronics
837	Solar & Wind Power	Electronics
838	Generators & Portable Power	Electronics
839	Solar Chargers	Electronics
840	Patio	Electronics
841	 Lawn & Garden	Electronics
842	Solar Panels	Electronics
843	Solar Portable Power	Electronics
844	Soundbar Speakers	Electronics
845	360 Degree Cameras	Electronics
846	Body Mounted Cameras	Electronics
847	Shop Cameras by Brand	Electronics
848	Smartphone Add-On Cameras	Electronics
849	Samsung Cameras	Electronics
850	Video	Electronics
851	Unlocked Cell Phones	Electronics
852	See more Samsung Gear 360 Camcorder -  White	Electronics
853	Sports & Action Video Cameras	Electronics
854	Mobile Photo Video Accessories	Electronics
855	Sennheiser Headphones	Electronics
856	 Audio / Video	Electronics
857	 Gaming & Wearables	Electronics
858	Earphones	Electronics
859	In-Ear Headphones	Electronics
860	mobiles	Electronics
861	Shop Headphones by Brand	Electronics
862	Headphones & Headsets	Electronics
863	Digital Cameras Lenses	Electronics
864	Other Electronics	Electronics
865	Digital Cine Cameras	Electronics
866	Lenses zrvzcfdefdtafswscwwz	Electronics
867	Professional Video	Electronics
868	Mirrorless Camera Lenses	Electronics
869	DSL Modems	Electronics
870	Modem Router Combos	Electronics
871	Used:Computers Accessories	Electronics
872	Modem-Router Combos	Electronics
873	See more Actiontec GT784WN 300 Mbps 4-Port 10/100 Wirel...	Electronics
874	Modems	Electronics
875	Used:Computer Hardware	Electronics
876	Used:Network Cards Adapters	Electronics
877	iMac	Electronics
878	All-in-Ones	Electronics
879	Keyboard Cases	Electronics
880	Other Car Electronics Accs	Electronics
881	Portable Satellite Radios	Electronics
882	Single Din Car Stereos	Electronics
883	MP3 & MP4 Players	Electronics
884	iPod & MP3 Players	Electronics
885	iPods Media Players	Electronics
886	iPod and MP3 Players	Electronics
887	iPods	Electronics
888	iPod touch	Electronics
889	Apple iPods	Electronics
890	iPod Touch	Electronics
891	See more Logitech Harmony Home Hub Remote Control Adapt...	Electronics
892	All PC Microphones	Electronics
893	DJ Equipment	Electronics
894	DJ & Monitoring Headphones	Electronics
895	On Camera Lights	Electronics
896	On-Camera Video Lights	Electronics
897	Lighting	Electronics
898	LED Lighting	Electronics
899	Flashes	Electronics
900	 Lighting & Studio	Electronics
901	On Camera Lighting	Electronics
902	Car Audio Installation Kits	Electronics
903	Car Speaker & Subwoofer Enclosures	Electronics
904	Car Speaker Accessories	Electronics
905	Subwoofer Boxes and Enclosures	Electronics
906	Subwoofer Enclosures	Electronics
907	Portable Stereos	Electronics
908	 Boomboxes	Electronics
909	See more Aiwa Exos-9 Portable Bluetooth Speaker Fast Sh...	Electronics
910	iPad Kits & Accessories	Electronics
911	Chargers & Adapters	Electronics
912	Clothing	Electronics
913	Handbags	Electronics
914	Bags & Accessories	Electronics
915	Outdoor TVs	Electronics
916	All Flat-Screen TVs	Electronics
917	Hi-Res Home Theater Receivers	Electronics
918	High-Resolution Audio	Electronics
919	In-Wall Speaker Accessories	Electronics
920	2-in-1 Laptops	Electronics
921	2 in 1 Laptops	Electronics
922	Laptop Add-On Cards	Electronics
923	Laptop Network Cards	Electronics
924	Computers & Laptops	Electronics
925	Keyboard & Mice Accessories	Electronics
926	Mouse & Wrist Pads	Electronics
927	Gaming Mice & Mice Pads	Electronics
928	Monitor Accessories	Electronics
929	Earbuds	Electronics
930	Under Armour	Electronics
931	CD & Media Storage	Electronics
932	Studio Environment	Electronics
933	Furniture Racks	Electronics
934	Musical Instruments	Electronics
935	Studio Recording Equipment	Electronics
936	Shelves	Electronics
937	Recording Equipment	Electronics
938	Rack Accessories	Electronics
939	Recording Furniture & Stands	Electronics
940	Outdoor TV Covers	Electronics
941	 Stands & Mounts	Electronics
942	Built-in Speakers	Electronics
943	Computer Monitors uyzxswry	Electronics
944	Used:Computer Monitors Accessories	Electronics
945	Used:Computer Monitors	Electronics
946	Smart Home Safety and Security	Electronics
947	Surveillance Cameras & Video Recorders	Electronics
948	Home Safety and Security	Electronics
949	Smart Home Security and Surveillance	Electronics
950	Network Attached Storage Drives yrvqqcvayqftceubtyruyuavwsus	Electronics
951	Network Attached Storage (NAS	Electronics
952	Workgroup NAS Servers	Electronics
953	Network Attached Storage Drives rwtaqbstbwzzteq	Electronics
954	Network Attached Storage Drives xrzwzdaycetcccwzdxyrbvbdyeefvsrc	Electronics
955	Networked Attached Storage (NAS)	Electronics
956	Network Attached Storage (NAS)	Electronics
957	NAS Servers	Electronics
958	Network Attached Storage Drives	Electronics
959	NAS/Personal Cloud Storage	Electronics
960	Accessory Kits	Electronics
961	Tripods Support	Electronics
962	Tripods with Heads	Electronics
963	Tripods & Monopods	Electronics
964	Tripods	Electronics
965	Carrying Cases	Electronics
966	Carrying Cases axfcytwyxvswaf	Electronics
967	Briefcase Shoulder Bags	Electronics
968	Carrying Cases cbvvbfzac	Electronics
969	Electronics Certified Refurbished	Electronics
970	Tvs & Home Theater	Electronics
971	TVs - Certified Refurbished	Electronics
972	Tvs	Electronics
973	Other Camcorder Accessories	Electronics
974	Skins	Electronics
975	 Skeletons Frames	Electronics
976	Professional Video Accessories	Electronics
977	Action Cameras Accessories	Electronics
978	Other GoPro Accessories	Electronics
979	GoPro Camera Accessories	Electronics
980	Action Cam Accessories	Electronics
981	GoPro	Electronics
982	Stereo Receivers	Electronics
983	Mirrorless System Lenses ebczxycadtybtuuraqzbzvaxdfcvsuzscetvxr	Electronics
984	See more Sigma DG 35-35mm F/1.4 Lens For Canon	Electronics
985	Film SLR Lenses	Electronics
986	Floor-Standing Speakers	Electronics
987	Floor-Standing Speakers vvtxtswwzcywufetbrwvxy	Electronics
988	Internal TV Tuner & Capture Cards	Electronics
989	Digital TV Tuners & Converters	Electronics
990	Headphones tbbdsbrwdwubyyzayufatvsfbbwz	Electronics
991	Used:Home Theater Systems	Electronics
992	Used:A/V Receivers	Electronics
993	Portable Computer Accessories	Electronics
994	Laptop Bags & Cases	Electronics
995	MacBook and Notebook Cover Cases exxestuevqvvserwac	Electronics
996	Sleeves	Electronics
997	MacBook and Notebook Cover Cases	Electronics
998	MacBook Accessories	Electronics
999	MacBook and Notebook Cover Cases wffrzrubvczvcexrsraaeqwtyftztftqdqzsbc	Electronics
1000	Apple	Electronics
1001	MacBook and Notebook Cover Cases dtcfasvwuxuwccuercftezcrdurveuvcs	Electronics
1002	MacBook and Notebook Cover Cases txssuebqxu	Electronics
1003	Stereo Component Combos	Electronics
1004	Home Theater in a Box	Electronics
1005	Home Theater in a Box rxxbwxxcscxuvutetd	Electronics
1006	Stereo System Components	Electronics
1007	Receivers wdaebvzucdyaaftsaqwqecu	Electronics
1008	Replacement Faceplates	Electronics
1009	See more Kenwood KDCBT365 CD Receiver with AM FM Tuner ...	Electronics
1010	Car Stereo	Electronics
1011	In-Dash Navigation	Electronics
1012	Car Navigation	Electronics
1013	In-Dash with GPS	Electronics
1014	Video In-Dash Units w/GPS	Electronics
1015	Floorstanding Speakers	Electronics
1016	Fans CPU Coolers rxvsqzbcdsxrafbuqffzs	Electronics
1017	Fans CPU Coolers wdbuxuvzsdbsaa	Electronics
1018	Fans CPU Coolers csqqvbectsuxesruz	Electronics
1019	Fans & Cooling	Electronics
1020	Fans CPU Coolers srffdauezsxzcwbfycwvwuxsdduxdvxwvdezw	Electronics
1021	Fans CPU Coolers	Electronics
1022	Fans CPU Coolers xwycbdtrcwywtcuyvacazbryeftcxscza	Electronics
1023	Fans	Electronics
1024	 Heatsinks & Cooling	Electronics
1025	Case Fans	Electronics
1026	Desktop Components	Electronics
1027	Computer Hardware	Electronics
1028	Used:Computer Memory	Electronics
1029	Other Drives	Electronics
1030	 Storage & Media	Electronics
1031	See more Samsung 960 PRO NVMe M.2 512GB Internal SSD	Electronics
1032	Power Amplifiers	Electronics
1033	Computer Cases	Electronics
1034	Desktop Computer Cases	Electronics
1035	Powered Subwoofers	Electronics
1036	Enclosed Subwoofer Systems	Electronics
1037	Micro SD Cards	Electronics
1038	SD & SDHC Cards	Electronics
1039	See more Samsung (MB-MC256DA/AM) MicroSDXC EVO Memory ...	Electronics
1040	Micro SDHC	Electronics
1041	USB-to-VGA Adapters	Electronics
1042	USB Adapters	Electronics
1043	Monitor Cables/Adapters	Electronics
1044	USB Adapters uuuxvuqdvtfx	Electronics
1045	Tablet Chargers & Sync Cables	Electronics
1046	Chargers & Sync Cables	Electronics
1047	See more Apple Lightning to VGA Adapter for iPad iPhone...	Electronics
1048	Audio/Video Cable Products	Electronics
1049	A/V Cables & Adapters	Electronics
1050	Tablet & eBook Reader Accs	Electronics
1051	Computer Cable Adapters	Electronics
1052	iPhone Accessories	Electronics
1053	See more Original Genuine Apple Lightning to VGA Adapte...	Electronics
1054	Recievers	Electronics
1055	See more Yamaha R-S202 Natural Sound Bluetooth 100-Watt...	Electronics
1056	Car DVD and Video	Electronics
1057	Overhead DVD Players	Electronics
1058	Overhead Video	Electronics
1059	See more Sony STR DN860 7.2 Channel 165 Watt Receiver	Electronics
1060	Audio/Stereo Equipment	Electronics
1061	Audio Receivers/CD Cassette Players	Electronics
1062	Dashcams yexzywbdwfcwvezrcxur	Electronics
1063	On-Dash Video	Electronics
1064	Dashcams	Electronics
1065	Back-Up & Dash Cameras	Electronics
1066	Dashcams ywwwdubutyzyfqwzextu	Electronics
1067	Vehicle Cameras GPS Tracking	Electronics
1068	Dash Cameras vcdfxwyxxudrfaxvzcbvxwvbctvrytvfzad	Electronics
1069	Dash Cameras	Electronics
1070	Turntables & Accessories	Electronics
1071	See more Pyle PP-999 Pre-Amp/Processor Amplifier	Electronics
1072	Pretend Play & Dress Up	Electronics
1073	Satellite TV Equipment	Electronics
1074	CD Players & Turntables	Electronics
1075	Mixers	Electronics
1076	Kids Instruments	Electronics
1077	Amplifiers & Preamps	Electronics
1078	Phono Preamplifiers	Electronics
1079	Turntables Accessories	Electronics
1080	Toys	Electronics
1081	Turntables Players	Electronics
1082	Satellite Television	Electronics
1083	No-Contract Phones & Plans	Electronics
1084	Carrier Cell Phones	Electronics
1085	Prepaid Phones	Electronics
1086	Unlocked Phones	Electronics
1087	Cell Phones & Smartphones	Electronics
1088	Prepaid & No-Contract Phones	Electronics
1089	Shop all No-Contract Phones	Electronics
1090	All Prepaid Phones	Electronics
1091	4K Sony TVs	Electronics
1092	OLED TVs	Electronics
1093	Sony Smart TVs	Electronics
1094	 Holsters & Clips	Electronics
1095	Flip Cases	Electronics
1096	Cell Phone Cases	Electronics
1097	Cell Phone Cases Covers	Electronics
1098	Cell Phone Cases xfayeeuudrd	Electronics
1099	Computer Peripherals xvdbctbtactd	Electronics
1100	Computer Speakers xczcyxfu	Electronics
1101	Computer Speakers vqdfzcrwbaewbvfvxzfsfdbfwfaeyscvb	Electronics
1102	See more SteelSeries Arctis 7 Wireless DTS 7.1 Headset ...	Electronics
1103	Accessories for Nintendo	Electronics
1104	 PC	Electronics
1105	 Xbox and PlayStation Systems	Electronics
1106	See more SteelSeries Arctis 7 Lag- Wireless Gaming Head...	Electronics
1107	Stylus Pens	Electronics
1108	Mice Pointing devices cwfsbfcxudarvcff	Electronics
1109	Stylus	Electronics
1110	Tablet Stylus Pens	Electronics
1111	Digital Pens	Electronics
1112	Styluses	Electronics
1113	Remote Controls & Accessories	Electronics
1114	Projector Lamps	Electronics
1115	Video Projectors & Accessories	Electronics
1116	Video Projector Accessories	Electronics
1117	See more Viper 7153V 1-way 5-button Supercode Replaceme...	Electronics
1118	See more Viper 1 Way Supercode Remote Replacement Trans...	Electronics
1119	Car Safety & Car Security	Electronics
1120	Lamps	Electronics
1121	Replacement Remotes	Electronics
1122	Anti-Theft Devices	Electronics
1123	Office Products	Electronics
1124	Remote Transmitters	Electronics
1125	Projector Accessories	Electronics
1126	Car Security & Remote Starters	Electronics
1127	See more Viper 7153V Replacement 5-button Transmitter	Electronics
1128	Alarms & Security	Electronics
1129	Car Alarms & Security	Electronics
1130	automotive	Electronics
1131	Projector Mounts Accessories ydvebaxszzqrvayzu	Electronics
1132	Mounts	Electronics
1133	Used:Multimedia Projector Accessories	Electronics
1134	Printer Accessories	Electronics
1135	Printer Ink & Toner	Electronics
1136	Wireless & Multiroom Components	Electronics
1137	Robot Check	Electronics
1138	portable audio & accessories	Electronics
1139	Bluetooth Transmitters	Electronics
1140	iPod and MP3 Accessories	Electronics
1141	Memory Card Readers	Electronics
1142	Memory Card Readers & Adapters	Electronics
1143	See more Leef iAccess IOS Micro SD RDR LIACMWK000E1	Electronics
1144	Portable Digital Storage for Cell Phones	Electronics
1145	Memory Card Accessories	Electronics
1146	Computer Keyboards	Electronics
1147	Wired & USB Keyboards	Electronics
1148	Keyboards & Keypads	Electronics
1149	Gaming Keyboards	Electronics
1150	Gaming Laptops	Electronics
1151	Computer Memory	Electronics
1152	Audio In-Dash Units	Electronics
1153	Car Audio In-Dash Units	Electronics
1154	Blueooth Car Stereos	Electronics
1155	MacBook	Electronics
1156	MacBooks	Electronics
1157	LG TVs	Electronics
1158	External Drives dcbzsfbefybdfavaxwrwxqys	Electronics
1159	Virtual Reality for PC	Electronics
1160	VR-Ready GPUs/Video Graphics Cards	Electronics
1161	Virtual Reality-Ready Components for PC	Electronics
1162	Racks	Electronics
1163	 Mounts & Accessories	Electronics
1164	TV Sound Systems yytusrxxusszazawxruwdtbeucyzda	Electronics
1165	Loaded Enclosures	Electronics
1166	Integrated Amplifiers	Electronics
1167	Car Amplifiers	Electronics
1168	External TV Tuners	Electronics
1169	Antennas & Tuners	Electronics
1170	TV Tuner & Video Capture	Electronics
1171	Video Capture & TV Tuner Cards	Electronics
1172	HD Television Tuners	Electronics
1173	TV Tuners	Electronics
1174	Home Audio & Video	Electronics
1175	TV Antennas	Electronics
1176	Speaker Separates rcefscbxezbxtvfzvfrvuxeubcywszzfasvz	Electronics
1177	No-Contract Cell Phones	Electronics
1178	Voice Recorders	Electronics
1179	Mastering Recorders	Electronics
1180	Portable Recorders	Electronics
1181	Recorders Duplicators	Electronics
1182	Digital Voice Recorders	Electronics
1183	Audio Recorders	Electronics
1184	Minidisc Recorders	Electronics
1185	Audio for Video	Electronics
1186	Portable Digital Recorders	Electronics
1187	Recording	Electronics
1188	Musical	Electronics
1189	Duplicators	Electronics
1190	Recorders	Electronics
1191	See more VXI BlueParrott B450-xt Noise Cancelling Bluet...	Electronics
1192	Bluetooth Headsets szzbrusxstedwdyebx	Electronics
1193	More Mobile Accessories	Electronics
1194	Streaming Media Player Accessories	Electronics
1195	Media Player Recorder Accessories	Electronics
1196	NVIDIA SHIELD	Electronics
1197	Streaming Devices	Electronics
1198	Retro Gaming & Microconsoles	Electronics
1199	External Drives adrrryytsauvvzcbyacwz	Electronics
1200	Kitchen & Dining Features	Electronics
1201	Speaker Stands & Mounts	Electronics
1202	Stands	Electronics
1203	Speaker Stands	Electronics
1204	Asus Laptops	Electronics
1205	Asus	Electronics
1206	Monitor Display Accessories	Electronics
1207	Computer Display Cables Adapters	Electronics
1208	Computer Monitor Adapters	Electronics
1209	Computer Monitor Adapters yarvwwadcbyfaurwezec	Electronics
1210	Computer Monitor Adapters etauxszrwcxuwyxrvvsffretcztaeqzadufr	Electronics
1211	Specialty Audio Accessories	Electronics
1212	See more Onkyo SKW-204 Powered Subwoofer	Electronics
1213	PC gaming accessories	Electronics
1214	Headsets & Earpieces	Electronics
1215	Radio Communication	Electronics
1216	Used:Digital Photography	Electronics
1217	Interchangeable Lens Cameras	Electronics
1218	Mirrorless System Cameras bubcccruayaywadxvuuf	Electronics
1219	Used:Mirrorless System Cameras	Electronics
1220	Mirrorless System Cameras xeeasdybvsfvcywdzy	Electronics
1221	See more Sennheiser HD 558 Headband Headphones - Black	Electronics
1222	Headphones/Earphones Accessories	Electronics
1223	System Memory (RAM)	Electronics
1224	Doorbells	Electronics
1225	Smart Door Bells	Electronics
1226	Surveillance Security Systems	Electronics
1227	Wireless Doorbell Cameras	Electronics
1228	Hardware	Electronics
1229	Home Surveillance	Electronics
1230	Sensors & Motion Detectors	Electronics
1231	Wired	Electronics
1232	Doors & Door Hardware	Electronics
1233	Building & Hardware	Electronics
1234	Security Cameras and Security Camera Systems	Electronics
1235	Smart Home Access	Electronics
1236	Door Viewers	Electronics
1237	Door Hardware & Locks	Electronics
1238	Sony Headphones	Electronics
1239	Used:Internal Drives	Electronics
1240	Used:Drives Storage	Electronics
1241	Radar Detectors	Electronics
1242	Vehicle Electronics Accessories	Electronics
1243	Radar & Laser Detectors	Electronics
1244	Team Sports	Electronics
1245	Baseball	Electronics
1246	Baseball Field Equipment & Maintenance	Electronics
1247	See more AOC E1659FWU 16\\\\ LED LCD Monitor	Electronics
1248	DVRs	Electronics
1249	 Hard Drive Recorders	Electronics
1250	See more TiVo Bolt 4k UHD Unified Entertainment System ...	Electronics
1251	Shotgun Microphones	Electronics
1252	Condenser Microphones	Electronics
1253	Wired Microphones	Electronics
1254	Location Sound	Electronics
1255	Microphones	Electronics
1256	Seasonal	Electronics
1257	Action Cams	Electronics
1258	VR 360 Video	Electronics
1259	Father's Day	Electronics
1260	All 360 Video Cameras	Electronics
1261	Action Camcorders	Electronics
1262	Used:Aerial Imaging Action Cams	Electronics
1263	Used:Action Cams	Electronics
1264	Father's Day Electronics	Electronics
1265	Featured Brands	Electronics
1266	College Speakers	Electronics
1267	Wireless & Bluetooth Speakers	Electronics
1268	Audio Docks & Speakers	Electronics
1269	College Electronics	Electronics
1270	Sound Systems	Electronics
1271	Target Finds	Electronics
1272	Back To College	Electronics
1273	Battery Cases	Electronics
1274	Portable Audio & Electronics	Electronics
1275	Electric Screens (Wide Formats) ufqbfwta	Electronics
1276	Screens	Electronics
1277	Electric Screens (Wide Formats) dusrsqqdtddevtxfaxsqbcdbucserurxzcfzu	Electronics
1278	Presentation	Electronics
1279	 A/V & Projectors	Electronics
1280	Electric Screens (Wide Formats) fqezzsxafwy	Electronics
1281	See more Samsung 960 EVO SSD PCIe NVMe M.2 250GB	Electronics
1282	Docking Stations & Locks	Electronics
1283	Other Computers & Networking	Electronics
1284	iPhones	Electronics
1285	All Cell Phones with Plans	Electronics
1286	iPhone SE	Electronics
1287	Shop Phones by Operating System	Electronics
1288	Android	Electronics
1289	Portable DVD Players & Accessories	Electronics
1290	Microphones & Accessories	Electronics
1291	Microphones & Headphones	Electronics
1292	Musical Instruments & Karaoke	Electronics
1293	Wireless Microphones	Electronics
1294	Microphones & Live Sound	Electronics
1295	Handheld Wireless Microphones	Electronics
1296	Live Sound	Electronics
1297	Wireless Microphones yafezqvsfqarsqxrcqfsyq	Electronics
1298	Wireless Systems	Electronics
1299	Wireless and Bluetooth Headphones	Electronics
1300	Camera Flashes	Electronics
1301	DSLR Flashes	Electronics
1302	On Camera Flashes dxvaycaabr	Electronics
1303	Flashes & Accessories	Electronics
1304	Flashes On Camera Lighting	Electronics
1305	On Camera Flashes	Electronics
1306	Jensen	Electronics
1307	CD Changers & Turntables	Electronics
1308	Turntables	Electronics
1309	Speakers & Audio Systems	Electronics
1310	All-in-One Turntables	Electronics
1311	Wireless Routers dbvdtvuydreuasvayvtaaaxsr	Electronics
1312	NETGEAR	Electronics
1313	Wireless Routers ufqbfwta	Electronics
1314	Wireless Routers uqdrfxruuvwrtfvraryubbwv	Electronics
1315	See more Netgear R9000 7200 Mbps 7-Port 10/100 Wireless...	Electronics
1316	Networking rrcsvtuqdaurzwax	Electronics
1317	Home Theater Projectors ducedafwcusetvzfaabv	Electronics
1318	Epson PowerLite 740	Electronics
1319	Mobile Power Packs	Electronics
1320	Mobile Power uxddsfxreyyc	Electronics
1321	Used:Mobile	Electronics
1322	All Unlocked Cell Phones	Electronics
1323	Used:Cell Phones	Electronics
1324	Sony HT-XT2	Electronics
1325	Used:Computer Peripherals	Electronics
1326	Used:Mice Keyboards	Electronics
1327	Yamaha Receivers	Electronics
1328	Yamaha	Electronics
1329	Stereo Accessories	Electronics
1330	Composite Video Cables	Electronics
1331	Compact Stereos	Electronics
1332	Desktop Computer Cases rvzbsxezfazu	Electronics
1333	Cases & Towers	Electronics
1334	Computer Cases & Accessories	Electronics
1335	Computer Cases xtevftetxdevatxwysyrfw	Electronics
1336	Monitor Table Top Stand Mounts zfeytsbdcteyyedtvbuw	Electronics
1337	Monitor & Screen Accessories	Electronics
1338	Monitor Table Top Stand Mounts	Electronics
1339	Monitor Mounts & Stands	Electronics
1340	Monitor Mounts Stands zcawxqxyctzvvrvu	Electronics
1341	Speicherkarten	Electronics
1342	ZubehÃ¶r	Electronics
1343	Secure Digital (SDXC)	Electronics
1344	SecureDigital-Cards	Electronics
1345	Apple MacBook Pro	Electronics
1346	Notebook Computers	Electronics
1347	Mac Laptops	Electronics
1348	MacBook Pro	Electronics
1349	Apple Laptops	Electronics
1350	TV Headphones	Electronics
1351	Camera Batteries Chargers	Electronics
1352	See more Canon LP-E6N Rechargeable Lithium-Ion Battery ...	Electronics
1353	Video Accessories	Electronics
1354	Camera Batteries	Electronics
1355	Batteries Power Accessories	Electronics
1356	See more Zmodo Mini 720p HD IP Wi-Fi Network Camera wit...	Electronics
1357	See more Zmodo Mini IPC WiFi 720p Camera With 2-way Aud...	Electronics
1358	Home Security & Video Surveillance	Electronics
1359	Wired Security Cameras	Electronics
1360	Cases & Bags	Electronics
1361	iPad/Tablet/eBook Accessories	Electronics
1362	 Covers	Electronics
1363	 Keyboard Folios	Electronics
1364	Keyboards Accessories uyfytxvdzbxuterwcsstdayxtwubrfzscursyt	Electronics
1365	Keyboards Accessories cacfwzcvuryefwstesyzywrcyusbayfr	Electronics
1366	See more Sony Cyber-shot WX220 18.2 MP Digital Camera -...	Electronics
1367	Sony Cameras	Electronics
1368	Point Shoot Cameras rzbezzsqsxqectqfxxzsfwfyasufbzv	Electronics
1369	camera	Electronics
1370	Wireless Multi-Room Speakers xduyydqczswc	Electronics
1371	SIRIUS XM Satellite Radio Accessories	Electronics
1372	Home Satellite Radios	Electronics
1373	Desktop Computer Cases btwcttecfvyb	Electronics
1374	Desktop Computer Cases ezsdxyabe	Electronics
1375	Computer Cases rvzbsxezfazu	Electronics
1376	Power Amps	Electronics
1377	Multichannel Amplifiers	Electronics
1378	Installation Sound	Electronics
1379	Tuners A/V Receivers	Electronics
1380	Audio Sources	Electronics
1381	Optics Straps	Electronics
1382	Binocular	Electronics
1383	 Camera & Camcorder Straps	Electronics
1384	Extension Cords	Electronics
1385	Adapters	Electronics
1386	 Cables & Chargers	Electronics
1387	iPad/iPod Accessories	Electronics
1388	MP3 Players Recorders	Electronics
1389	MP3 Players Accessories	Electronics
1390	QLED TVs	Electronics
1391	4K Samsung TVs	Electronics
1392	Used:Televisions Accessories	Electronics
1393	Used:Flat Panel Televisions	Electronics
1394	VIZIO P55-C1	Electronics
1395	NAS / Personal Cloud Storage	Electronics
1396	Other Hard Drives	Electronics
1397	Speaker Separates tdrbbzebscxdcufzwattw	Electronics
1398	See more Samsung Un65mu9000 65 Inch UHD 4k Smart TV and...	Electronics
1399	Non-Touch-Screen All-in-One Computers	Electronics
1400	HP Desktop Computers	Electronics
1401	Projector Mounts efrzfauzcdteryffuqcbtwtzstbwytexb	Electronics
1402	Projector Mounts ycrbqrrrsdcfuv	Electronics
1403	Monitors Projectors	Electronics
1404	Projector Mounts & Stands	Electronics
1405	Projector Remotes & Accessories	Electronics
1406	Projector Mounts Accessories fadsqtwrfa	Electronics
1407	Car Equalizers & Processors	Electronics
1408	EQ	Electronics
1409	 Crossovers & Processors	Electronics
1410	CPU Processors	Electronics
1411	Processors Only	Electronics
1412	All Car Amplifiers	Electronics
1413	Signal Processors	Electronics
1414	Multi-Channel Amps	Electronics
1415	Computer Speakers & Headsets	Electronics
1416	Graphics Tablets	Electronics
1417	Graphic Tablets Digital Pens	Electronics
1418	Graphics Tablets & Digital Pens	Electronics
1419	See more Razer Mano'war Wireless 7.1 Surround Sound Gam...	Electronics
1420	Network Attached Storage Drives etryvwsrbvvvvxfutbey	Electronics
1421	See more Corsair Void Pro Wireless Carbon Headband Head...	Electronics
1422	Smart Watches	Electronics
1423	See more Samsung Gear Fit2 Pro (Large) Black Aluminum C...	Electronics
1424	Activity Trackers	Electronics
1425	Smartwatches	Electronics
1426	Water Cooling Systems	Electronics
1427	Processors (CPU)	Electronics
1428	Fan	Electronics
1429	 Heat Sink Brackets & Accs	Electronics
1430	 Heat Sinks & Cooling	Electronics
1431	CPU Fans & Heat Sinks	Electronics
1432	Water Cooling	Electronics
1433	See more Corsair Hydro Series H100i Extreme Performance...	Electronics
1434	Projection TV Lamps	Electronics
1435	All TV Accessories	Electronics
1436	Memory Cards xctasbtfavbexdfzfvzztebrcuxffa	Electronics
1437	Computer Cables Adapters	Electronics
1438	Computer Cables	Electronics
1439	Ethernet Cables	Electronics
1440	Electronics Fan Shop	Electronics
1441	Keyboards and Mice	Electronics
1442	Mice Pointing devices xcbsztzedbfwuy	Electronics
1443	See more Razer Naga Chroma Gaming Mouse with 12 Button ...	Electronics
1444	See more Razer Naga Chroma Professional Grade Ergonomic...	Electronics
1445	Gaming Mice	Electronics
1446	Sports Fan Shop	Electronics
1447	GPS Units	Electronics
1448	Navigation	Electronics
1449	Car GPS	Electronics
1450	See more Garmin dÄzl 770LMTHD GPS Receiver	Electronics
1451	Field Accessories	Electronics
1452	Trucking GPS	Electronics
1453	Optics	Electronics
1454	Navigation xwedbzbsfrbfazxzazcwxtdfsf	Electronics
1455	See more Garmin dzl 770LMTHD GPS Receiver	Electronics
1456	5.25\\\\ Car Speakers	Electronics
1457	Interior	Electronics
1458	Interior Door Panels & Parts	Electronics
1459	Car & Truck Parts	Electronics
1460	See more Pioneer TSG1345R 5.25-Inch 2-Way 250W Car Spea...	Electronics
1461	Headphone & In-Ear Audio Monitors	Electronics
1462	#13540 in	Electronics
1463	#413 in	Electronics
1464	#503 in	Electronics
1465	Studio Speaker Stands	Electronics
1466	4\\\\ Car Speakers	Electronics
1467	Multimedia Projectors	Electronics
1468	Audio Visual Presentation ubdtfdye	Electronics
1469	Tripod & Monopod Accessories	Electronics
1470	Tabletop Mini Tripods tbbbweszcuruwfdtfq	Electronics
1471	Tabletop Mini Tripods	Electronics
1472	Tripods & Supports	Electronics
1473	Tablet Computer Cases yzyvvfbvwrrsyufvyxcxfte	Electronics
1474	MacBook and Notebook Cover Cases zcbtreqesxytuyxtxdb	Electronics
1475	MacBook and Notebook Cover Cases sefcaszxexrzxarewt	Electronics
1476	Used:Computer Accessories	Electronics
1477	Used:Computer Cases	Electronics
1478	Tablet Cases Covers	Electronics
1479	Other Components & Parts	Electronics
1480	Internal Modems	Electronics
1481	Modems & Gateways	Electronics
1482	See more ARRIS Surfboard SVG2482AC DOCSIS 3.0 Cable Mod...	Electronics
1483	Sony TVs	Electronics
1484	In-Mirror Video	Electronics
1485	Back-Up Cameras	Electronics
1486	Car Audio Accessories	Electronics
1487	Power Outlets	Electronics
1488	Wireless Range Extenders	Electronics
1489	Works with Google Assistant	Electronics
1490	Wall Switches	Electronics
1491	Network Hubs & Routers - Works with Google Assistant	Electronics
1492	Smart Home Assistants & Voice Control	Electronics
1493	Light Switches	Electronics
1494	Internal Desktop Hard Drives	Electronics
1495	Portable Radios	Electronics
1496	Internet Radios	Electronics
1497	CD	Electronics
1498	 DVD & Blu-ray Drives	Electronics
1499	External DVD Drives	Electronics
1500	Headphones rydyqsaxrbrdyuquyetsrydxefvucsr	Electronics
1501	Sony HT-ST9	Electronics
1502	See more Logitech G403 Wireless Gaming Mouse Certified ...	Electronics
1503	Telephone Accessories	Electronics
1504	Trackballs	Electronics
1505	See more Alpine KTP-445U Car Amp	Electronics
1506	Mini Amps	Electronics
1507	Laptops cfzzzzqqfrrrdrtssr	Electronics
1508	See more TiVo Mini Receiver	Electronics
1509	DVR & DVD Recorders	Electronics
1510	Digital Video Recorders	Electronics
1511	#15691 in	Electronics
1512	#917 in	Electronics
1513	#1548 in	Electronics
1514	Mobile Workstations	Electronics
1515	Battery Grips	Electronics
1516	Household Supplies & Cleaning	Electronics
1517	Other Home Cleaning Supplies	Electronics
1518	electronics	Electronics
1519	Drives Storage wcxaeeveystbtzftbafuee	Electronics
1520	Internal Drives dabsvsrxcutf	Electronics
1521	Used:Recorders Players	Electronics
1522	All iPod & MP3 Players	Electronics
1523	A/V Switchers	Electronics
1524	Decor	Electronics
1525	Other Portable Audio	Electronics
1526	Furniture & Decor	Electronics
1527	Nest Compatible Devices	Electronics
1528	Clocks	Electronics
1529	Fitted Camera Bags & Cases	Electronics
1530	 Photo & Video	Electronics
1531	Camcorder Cases	Electronics
1532	Dashcams vayzdratvqxvvrrbey	Electronics
1533	Dash Cams	Electronics
1534	Modems zcbcwebyrcwxwrff	Electronics
1535	Used:Camcorders Cameras	Electronics
1536	Consumer Camcorders	Electronics
1537	All Action Camcorders	Electronics
1538	Used:Consumer Camcorders	Electronics
1539	See more Sharp XLHF102B Hi Fi Component Microsystem Wit...	Electronics
1540	See more Wacom Wireless Accessory Kit for Bamboo and In...	Electronics
1541	Tablet Cases & Sleeves	Electronics
1542	Other Keyboards & Mice	Electronics
1543	Tablets Handwriting Accessories	Electronics
1544	Graphic Tablets	Electronics
1545	Desktop Computer Cases auzcweqzzceaebdx	Electronics
1546	Desktop Computer Cases fcqcczbsvuayatfcdcrewxbwerrfa	Electronics
1547	Desktop Computer Cases xwycbdtrcwywtcuyvacazbryeftcxscza	Electronics
1548	Computer Cases xrawfrudeyyvfavzra	Electronics
1549	Ergonomic Mice	Electronics
1550	Electric Screens (Wide Formats) uwbtftfwubccwsxattfswxaz	Electronics
1551	Projection Screens baesfadqwexxbctqsw	Electronics
1552	3D Glasses & Accessories	Electronics
1553	3D TV Glasses & Accessories	Electronics
1554	See more Xpand 3D Glasses Rechargeable Active Bluetooth...	Electronics
1555	3D Glasses	Electronics
1556	Wall Chargers & Power Adapters	Electronics
1557	Wall Chargers	Electronics
1558	Cell/Smart Phones Accessories	Electronics
1559	Cell/Smart Phone Accessories	Electronics
1560	Wall Chargers uaedvcevatubu	Electronics
1561	Cell/Smart Phone Chargers	Electronics
1562	Wall Chargers fcxxdxcqvyfwsq	Electronics
1563	Cables & Adapters	Electronics
1564	Chargers	Electronics
1565	Power Cables & Connectors	Electronics
1566	Mobile Power zxqyvbwuwyydcq	Electronics
1567	Wireless Multi-Room Speakers uydqdrbtfsxwzyzstyrbybcquvddxuzz	Electronics
1568	Signal Components	Electronics
1569	Semiconductor Products	Electronics
1570	Digital-to-Analog Converters	Electronics
1571	Headphone Accessories	Electronics
1572	Audio Interfaces Systems	Electronics
1573	Signal Converters	Electronics
1574	Computer Audio	Electronics
1575	Industrial & Scientific	Electronics
1576	Computer Audio Hardware	Electronics
1577	Computer Audio Hardware vsweqvez	Electronics
1578	Other Home Stereo Components	Electronics
1579	Industrial Electrical	Electronics
1580	Hi-Res Digital Audio Converters (DACs)	Electronics
1581	Travel Accessories	Electronics
1582	Luggage	Electronics
1583	Travel Adapters Transformers	Electronics
1584	Best Buy	Electronics
1585	Game Capture Devices	Electronics
1586	Baby Monitors	Electronics
1587	See more Samsung SmartCam HD Pro 1080p Full HD WiFi Cam...	Electronics
1588	Baby	Electronics
1589	Security Camera Systems	Electronics
1590	Baby Safety & Health	Electronics
1591	Surveillance Cameras	Electronics
1592	Point Shoot Cameras suybxafwtcyzbfsf	Electronics
1593	Body Only	Electronics
1594	Waterproof Cameras	Electronics
1595	DSLR	Electronics
1596	Receivers edzdabetxucuvafzavxqrcubdwftewac	Electronics
1597	Computer Speakers ezsdxyabe	Electronics
1598	Bose Companion 20	Electronics
1599	Computer Speakers rwxsssxfyzcydcffxxvzrxt	Electronics
1600	Computer Speakers yuqzcyeerrs	Electronics
1601	 Camera	Electronics
1602	 Electronics	Electronics
1603	 Surveillance	Electronics
1604	Memory Storage	Electronics
1605	Studio Monitoring	Electronics
1606	Studio Monitors	Electronics
1607	Studio Monitoring dcxbxvbewxedvwzwqbfwysebtxtya	Electronics
1608	beauty	Electronics
1609	Blank Video Media	Electronics
1610	Hi-8	Electronics
1611	See more Sony 120 Video Hi8 HMP 60 Digital 8 Tape	Electronics
1612	Wireless Multi-Room Components rxrddsauzswueesqzyxzuxawezzxsu	Electronics
1613	Audio/Video Transmitters	Electronics
1614	Wireless Multi-Room Components	Electronics
1615	Action Camcorder Mounts	Electronics
1616	Exterior Accessories	Electronics
1617	Video Camera Components	Electronics
1618	Jeep Accessories	Electronics
1619	Action Cam Mounts	Electronics
1620	Action Camcorder Accessories	Electronics
1621	Handlebar / Pole Mounts	Electronics
1622	Car Mounts	Electronics
1623	Mounting Kits	Electronics
1624	Data Storage & Media	Electronics
1625	Sports Action Cameras	Electronics
1626	Accessory Bundles	Electronics
1627	See more Joby GorillaPod SLR-Zoom Tripod	Electronics
1628	Tripods xeeasdybvsfvcywdzy	Electronics
1629	Tripod Legs	Electronics
1630	See more Bose SoundLink Color Portable Bluetooth Speake...	Electronics
1631	Headphones urvqcddttbdswqbzzfvrxfzqdqawavawss	Electronics
1632	Ethernet Hubs & Switches	Electronics
1633	 Bridges Hubs zdztuauwxcwwrb	Electronics
1634	 Bridges Hubs vdrzccaxxyuewu	Electronics
1635	See more TP-LINK TP-Link (TL-SG108) External Switch	Electronics
1636	 Bridges Hubs cudfuabrrauaxwfcfaxwsdcbcubvrfyu	Electronics
1637	 Bridges Hubs adqydrvaeqbzrzdfxqdbcebazwdbyuvffx	Electronics
1638	Over-the-Ear Headphones	Electronics
1639	8\\\\ Subwoofer	Electronics
1640	8\\\\ Car Subwoofer	Electronics
1641	Dual-channel Amplifiers	Electronics
1642	Specialty Boutique	Electronics
1643	Notebook Power Batteries	Electronics
1644	Laptop Power Adapters/Chargers	Electronics
1645	Notebook Power	Electronics
1646	Used:Power Back Up Surge Protection	Electronics
1647	Bluetooth	Electronics
1648	 Handsfree Car Kits	Electronics
1649	Automotive Tools & Equipment	Electronics
1650	Automotive Electrical	Electronics
1651	Adaptors	Electronics
1652	See more iSimple ISFM2351 Tranzit Blu HF Audio Interfac...	Electronics
1653	Car Audio & Video Installation	Electronics
1654	Interconnect Cables	Electronics
1655	PC Games Accessories	Electronics
1656	Gaming Systems	Electronics
1657	PC Headsets & Glasses	Electronics
1658	Fixed Frame Screens edzdabetxucuvafzavxqrcubdwftewac	Electronics,Furniture
1659	Fixed Frame Screens rcrbftadsasbvtdtaddybarcyxyr	Electronics,Furniture
1660	DJ & Live Sound	Electronics
1661	Recorders Duplicators yqddtadfytvzuxarzyzcff	Electronics
1662	Portable Digital Recorders brzruydyvbwxtuebtrsbqctbwuyrxaabty	Electronics
1663	musical	Electronics
1664	TCL Smart TVs	Electronics
1665	4K TCL TVs	Electronics
1666	4\\\\ x 6\\\\ Car Speakers	Electronics
1667	Refurbished Headphones	Electronics
1668	Wired Analog HD Cameras	Electronics
1669	TV Stands & Entertainment Centers	Electronics
1670	Audio & Media Towers	Electronics
1671	Living Room Furniture	Electronics
1672	TV & Media Furniture	Electronics
1673	Speaker Mounts & Stands	Electronics
1674	sports	Electronics
1675	Camera Mounts & Clamps	Electronics
1676	Camping & Hiking	Electronics
1677	Camera Chest Supports	Electronics
1678	Utility Belts Harnesses	Electronics
1679	NAS Servers cudfuabrrauaxwfcfaxwsdcbcubvrfyu	Electronics
1680	Network Attached Storage Drives yqsuetbftutbfwwawqut	Electronics
1681	iPods & MP3 Players	Electronics
1682	MP3 Players	Electronics
1683	iPods Media Players bzbrzvvebsvabffextaewd	Electronics
1684	All MP3 Players	Electronics
1685	See more Panasonic LUMIX 25mm f/1.4 D ED Lens	Electronics
1686	DSLRs Lenses	Electronics
1687	Bluetooth Devices	Electronics
1688	Bluetooth Car Kits	Electronics
1689	Analog-to-Digital (DTV) Converters	Electronics
1690	Indoor Security Cameras	Electronics
1691	Computer Monitors dcbzsfbefybdfavaxwrwxqys	Electronics
1692	See more Bose SoundTrue II Charcoal Black	Electronics
1693	Live Sound Speakers	Electronics
1694	Speaker Monitors	Electronics
1695	electrical	Electronics
1696	Power Supplies txszcaxfarsxcydtbwvrwbswuzceduxa	Electronics
1697	Power Supplies svcbszvvcdxz	Electronics
1698	Power Supplies ztebqeqttusfyvyzdw	Electronics
1699	No-Contract Phones	Electronics
1700	All No-Contract Phones	Electronics
1701	Optical Drives Burners	Electronics
1702	Optical Media Drives Accessories wxbxabwayzuudwuxrdrayzvfqyyww	Electronics
1703	Drives Storage dxdctycdwvydaqrvdswsxafdyysevb	Electronics
1704	Optical Drives Burners tctwqddwzeuxadazqsvr	Electronics
1705	Optical Media Drives Accessories	Electronics
1706	Optical Drives Burners yyzecszdtttczusr	Electronics
1707	12\\\\ Car Subwoofer	Electronics
1708	Marine Subwoofers	Electronics
1709	Cover Shell Cases	Electronics
1710	Tablet PCs	Electronics
1711	Google Chromebook	 Intel Celeron
1712	See more Acer 15.6\\\\ Cb5-571-c4g4 Chromebook Intel Celer...	 Intel Celeron
1713	Storage	 Intel Celeron
1714	Drives & Storage	Electronics
1715	Computers & Office	Electronics
1716	Computer & Office Accessories	Electronics
1717	See more NETGEAR Powerline 1000 Mbps WiFi 802.11ac 1 Gi...	Electronics
1718	Powerline Adapters	Electronics
1719	Keyboard & Mouse Bundles	Electronics
1720	See more Genuine Logitech MX Anywhere 2s Wireless Mobil...	Electronics
1721	See more SONY BDV-E3100 5.1Ch Home Theater System	Electronics
1722	See more Sony BDV-E3100 5.1 Channel Home Theater System	Electronics
1723	Sony BDV-E3100	Electronics
1724	Mono Amplifiers	Electronics
1725	Mono Subwoofer Amps	Electronics
1726	Mobile Bluetooth Speakers sduvbayvsaybwywwxet	Electronics
1727	See more Pioneer Sc-lx501 Elite 7.2 Channel D3 Network ...	Electronics
1728	UNNAV	Electronics
1729	Connectors & Adapters	Electronics
1730	Cooling Pads & Lights	Electronics
1731	Case Parts & Accessories	Electronics
1732	Computer Lighting	Electronics
1733	Lighting & Light Fixtures	Electronics
1734	Novelty Lighting	Electronics
1735	Desktop Components fxuusxqfaabucfbsfufaatqxqwzfbcuzt	Electronics
1736	Digital Camera Batteries	Electronics
1737	Digital Cameras Accessories	Electronics
1738	Kamera-Akkus	Electronics
1739	Camera Batteries Chargers rqzxubecdbedruwxfcesrdrvaazvc	Electronics
1740	Smart Electronics	Electronics
1741	Bluetooth Speakers	Electronics
1742	On Camera Flashes fvuzesyzercyaefsc	Electronics
1743	Flash Accessories	Electronics
1744	In-Ear Monitoring	Electronics
1745	 DVD & Blu-ray Duplicators	Electronics
1746	CD/DVD Duplicators	Electronics
1747	Amplifiers & Equalizers	Electronics
1748	Used:Laptops	Electronics
1749	Mac Desktops	Electronics
1750	All Desktop Computers	Electronics
1751	Apple Desktops & All-In-Ones	Electronics
1752	Wired Networking uaausubbcbsxutvdfsewwefcqcv	Electronics
1753	See more Lowepro SF Slim Lens Pouch 75 AW #LP36258	Electronics
1754	Lens Accessories	Electronics
1755	Lens Cases	Electronics
1756	Protective Gear	Electronics
1757	In-Ear Monitoring ccxyasaywzvysadzucsecrs	Electronics
1758	#55529 in	Electronics
1759	#14498 in	Electronics
1760	Blank Discs and Labels	Electronics
1761	#28043 in	Electronics
1762	Light Bulbs & Tubes	Electronics
1763	Lighting & Studio	Electronics
1764	Continuous Lighting	Electronics
1765	Desktop Computer Cases safqadwuaub	Electronics
1766	Amplifiers twxaesfvrbydttxbsrefbeewxvustuvrzxd	Electronics
1767	Install Outdoor Speakers rxxbwxxcscxuvutetd	Electronics
1768	Range Extenders	Electronics
1769	See more Linksys Ac1900 WiFi Cable Modem Router CG7500	Electronics
1770	5\\\\ x 7\\\\ Car Speakers	Electronics
1771	See more TP-Link TL-WDN4800 (6935364050603) Pre-802.11n...	Electronics
1772	Wireless Adapters Cards zfxzyvdvsfyqfwub	Electronics
1773	Wireless Adapters Cards rrcsvtuqdaurzwax	Electronics
1774	Wireless Adapters Cards dyxuquefvtyxxeewyrs	Electronics
1775	Network Cards	Electronics
1776	Stereo Receivers and Amplifiers	Electronics
1777	See more Sony STRDN1070 7.2 Channel Hi-res Wi-Fi Networ...	Electronics
1778	Sony STRDN1070	Electronics
1779	Used:SLR Interchangeable Lenses	Electronics
1780	Used:Lenses Lens Accessories	Electronics
1781	Audio Docks	Electronics
1782	Other iPod & Audio Player Accs	Electronics
1783	Automotive Basics	Electronics
1784	SiriusXM Accessories	Electronics
1785	Speaker Docks	Electronics
1786	Car Satellite Radio	Electronics
1787	Bose	Electronics
1788	See more Bose 7417760070 SoundSport in Ear Headphone Ch...	Electronics
1789	Work Headphones	Electronics
1790	Holiday Shop	Electronics
1791	See more Bose SoundSport In-Ear Headphones for Samsung ...	Electronics
1792	Household Batteries	Electronics
1793	AA Batteries	Electronics
1794	Electronic Components	Electronics
1795	Batteries - Rechargeable	Electronics
1796	Household Supplies	Electronics
1797	4k Tv	Electronics
1798	Bluetooth Headphones avecuevdaxstvbrwvwxesrse	Electronics
1799	Tweeters	Electronics
1800	JBL Headphones	Electronics
1801	Wallet Cases	Electronics
1802	See more Seagate Game Drive for Xbox One 4tb Green STEA...	Electronics
1803	More Xbox One Accessories	Electronics
1804	External Drives udrwcdyccddvvyvwefzwctrb	Electronics
1805	See more Seagate Game Hard Drive for Xbox One 4tb Green...	Electronics
1806	Hard Drives - External	Electronics
1807	Used:Mirrorless System Lenses	Electronics
1808	FM Transmitters	Electronics
1809	Bluetooth & FM Transmitters	Electronics
1810	Computers and Monitors	Electronics
1811	Car Safety & Security	Electronics
1812	Rear View Monitors/Cams & Kits	Electronics
1813	See more Garmin BC 30 Wireless Backup Camera System Grm...	Electronics
1814	See more Garmin BC 30 Wireless Backup Camera	Electronics
1815	GPS Accessories & Tracking	Electronics
1816	GPS Devices Accessories	Electronics
1817	Other GPS Accs & Tracking	Electronics
1818	Simulated Cameras	Electronics
1819	Back-Up Cameras ywwwdubutyzyfqwzextu	Electronics
1820	Used:Digital Camera Accessories	Electronics
1821	camera & photo	Electronics
1822	Used:Batteries Power Supplies	Electronics
1823	Virtual Reality	Electronics
1824	VR Headsets	Electronics
1825	Virtual Reality Headsets	Electronics
1826	Virtual Reality for Smartphone	Electronics
1827	Virtual Reality Headsets for Smartphone	Electronics
1828	Smartphone VR Headsets	Electronics
1829	Gadgets & Other Electronics	Electronics
1830	Video Glasses	Electronics
1831	PC & Console VR Headsets	Electronics
1832	Used:Cables Adapters	Electronics
1833	USB Display Adapters uuuxvuqdvtfx	Electronics
1834	Memory Card & USB Adapters	Electronics
1835	USB Display Adapters	Electronics
1836	USB Display Adapters wcdbrdveavaytews	Electronics
1837	Optical Drives Burners zxsqvcbvvywsrwuaasvczufystyyy	Electronics
1838	Optical Drives Burners dxdctycdwvydaqrvdswsxafdyysevb	Electronics
1839	External Blu-ray Drives	Electronics
1840	Used:External Drives	Electronics
1841	Blu-ray Drives	Electronics
1842	Mirrorless System Cameras tuytyeuqxwecucybabxevruuueyuw	Electronics
1843	Point	Electronics
1844	Shoot Cameras	Electronics
1845	Used:Point Shoot Digital Cameras	Electronics
1846	All Video Game Accessories	Electronics
1847	See more Turtle Beach Ear Force Stealth 450 Wireless 7....	Electronics
1848	Ways To Shop Video Games	Electronics
1849	See more Turtle Beach Ear Force Stealth 450 Wireless He...	Electronics
1850	Lens Filters	Electronics
1851	Neutral Density Filters	Electronics
1852	Neutral Density (Solid) zcfuszwabwdcsfrqcxefxcaadffrcfvq	Electronics
1853	Neutral Density (Solid)	Electronics
1854	Headphone Cables Adapters	Electronics
1855	Headphone Splitters	Electronics
1856	Mini Plug-in Microphones	Electronics
1857	Flat Screen TVs	Electronics
1858	See more Optoma Wireless HD142X Full 3D 1080p HDMI 3000...	Electronics
1859	Wireless Audio Receivers & Adapters	Electronics
1860	Wireless Stereo Adapters & Streaming Audio Players	Electronics
1861	Holiday Gifts	Electronics
1862	Internet & Media Streamers	Electronics
1863	Featured Stores	Electronics
1864	College Living	Electronics
1865	Modem & Router Combos	Electronics
1866	College Dorm Living	Electronics
1867	See more Motorola 8x4 343 Mbps DOCSIS 3.0 N300 Cable Mo...	Electronics
1868	See more SanDisk 8GB Clip Jam MP3 Player Black	Electronics
1869	Kenwood Car Stereos	 Apple CarPlay
1870	Video In-Dash Units w/o GPS	 Apple CarPlay
1871	See more Kenwood DDX9703S Double 2 DIN Android iPhone H...	 Apple CarPlay
1872	Car Video Units W/out GPS/Nav	 Apple CarPlay
1873	Fixed Frame Screens dusrsqqdtddevtxfaxsqbcdbucserurxzcfzu	Electronics
1874	Fixed Frame Screens uzsrcwweyedefsbvsdcvuvcreaeufq	Electronics
1875	Fixed Frame Screens dxfeyyzyeyayx	Electronics
1876	Projection Screens (by Type) ccvzfsucersyazsqzattyrywfuwaruxxsy	Electronics
1877	Projection Screens fxyybzbtrcbsrztvff	Electronics
1878	See more Fusion Electronics Ms-bx3020 4\\\\ Inch 2-way Mar...	Electronics
1879	Boating	Electronics
1880	Water Sports	Electronics
1881	Free Shipping	Electronics
1882	Smart Energy and Lighting	Electronics
1883	Smart Lighting	Electronics
1884	Light Bulbs	Electronics
1885	Energy and Lighting	Electronics
1886	Smart Light Bulbs	Electronics
1887	Televisions & Video	Electronics
1888	Amplifiers wdaebvzucdyaaftsaqwqecu	Electronics
1889	Portable Battery Packs dzacqzexyxfwtybubrbtxubq	Electronics
1890	Portable Battery Packs dfcdxxzwfqfqubfvwaac	Electronics
1891	Bluetooth Headphones ufqbfwta	Electronics
1892	Cover Shell Cases sfdrevbuyb	Electronics
1893	Bags and Sleeves	Electronics
1894	Cover Shell Cases xbwaxuvdxzexcbcvwxrbfusstdssbesuvc	Electronics
1895	Tablet Computer Cases uaedvcevatubu	Electronics
1896	Tablet Stands & Mounts	Electronics
1897	Stands & Mounts	Electronics
1898	GPUs / Video Graphics Cards	Electronics
1899	Graphic Cards	Electronics
1900	Home Audio and Video	Electronics
1901	Samsung	Electronics
1902	See more Sony XBR55X700D 55-Inch Black Ultra HD 4K LED ...	Electronics
1903	CD Players & Recorders	Electronics
1904	Boom Boxes & Cd Players	Electronics
1905	See more Sharp 240w 5 Disc Mini Shelf System With Casse...	Electronics
1906	Pioneer SP-SB23W	Electronics
1907	See more Logitech G933 Limited Edition Black Headband H...	Electronics
1908	Wireless Routers cacfwzcvuryefwstesyzywrcyusbayfr	Electronics
1909	Wireless Access Points	Electronics
1910	Home Audio Components abureufb	Electronics
1911	See more Yamaha CD-C600 CD Changer	Electronics
1912	Speaker Separates twxaesfvrbydttxbsrefbeewxvustuvrzxd	Electronics
1913	Epson PowerLite Home Cinema 2045	Electronics
1914	See more Microsoft Wireless Comfort Desktop 5050 Curved...	Electronics
1915	Keyboard & Mouse Combos	Electronics
1916	Mice Keyboard Kits	Electronics
1917	LCD Televisions	Electronics
1918	Bluetooth Headphones zetewdsexwtextcucrctewuwfy	Electronics
1919	Magnolia Audio	Electronics
1920	Magnolia Premium Audio	Electronics
1921	Magnolia Home Theater	Electronics
1922	Record Players/Home Turntables	Electronics
1923	Tech Accessories	Electronics
1924	Cases & Protectors	Electronics
1925	Women's Accessories	Electronics
1926	 Covers & Skins	Electronics
1927	All Tablets	Electronics
1928	iPad Air 2	Electronics
1929	Apple iPad	Electronics
1930	360 Cameras	Electronics
1931	Shop Cameras by Type	Electronics
1932	TV Sound Systems zuxbbweveteztffywrybecztecqtezfbc	Electronics
1933	PCI Express Graphics Cards	Electronics
1934	See more Nvidia GeForce GTX 1080 Founders Edition 8GB G...	Electronics
1935	Antennas & Dishes	Electronics
1936	Antennas	Electronics
1937	Keyboards syuduvzbtawzxvrbeexy	Electronics
1938	Keyboards zsqstqcsbaqbsvexuadecqqyxarfv	Electronics
1939	Keyboards urtvtefvdsrswwrcswbxfzvaauxzvcfafre	Electronics
1940	Keyboards uyfytxvdzbxuterwcsstdayxtwubrfzscursyt	Electronics
1941	Wireless Keyboards	Electronics
1942	Computer Keyboards & Mice	Electronics
1943	See more Kicker KB6000 Main / Stereo Speakers	Electronics
1944	See more Alpine SPE-5000 2-Way 5.25\\\\ Car Speakers Syste...	Electronics
1945	Projector Mounts bzwaasvbzdyqzbuyxsywsc	Electronics
1946	Laptops adrdxyuxbezbcuqedez	Electronics
1947	Laptops turcrqsqbwbevb	Electronics
1948	Receivers Amplifiers cxfascewabraxzueus	Electronics
1949	See more Sherwood RX-4208 200W AM/ FM Stereo Receiver	Electronics
1950	See more Sherwood RX4208 200W AM/FM Stereo Receiver - B...	Electronics
1951	Compact Flash	Electronics
1952	CompactFlash Cards	Electronics
1953	Memory Cards zqbcrtzrdtxxzcff	Electronics
1954	Waterproof Cases	Electronics
1955	Cell Phone Cases & Clips	Electronics
1956	All DVD Players and Screens	Electronics
1957	Modems sqedxbbdyxyzwwxfbtcvyascftbzyxtbwvtcuq	Electronics
1958	Netgear CM700	Electronics
1959	Networking sdxexcebrx	Electronics
1960	ROG - Republic Of Gamers	Electronics
1961	Monitors & Projectors	Electronics
1962	Fixed TV Mounts	Electronics
1963	Accessoires Image et Son	Electronics
1964	Hearing Assistance	Electronics
1965	Consommables et Accessoires	Electronics
1966	Casques et Ã©couteurs	Electronics
1967	High-Tech	Electronics
1968	Computer Display Cables Adapters zfeytsbdcteyyedtvbuw	Electronics
1969	Used:Wearable Tech	Electronics
1970	Digital Clocks & Clock Radios	Electronics
1971	home	Electronics
1972	Mobile Power wyzqeeudcufqyeywbrvbuazecycyfbbecbyc	Electronics
1973	Premium Headphones	Electronics
1974	Magnolia Headphones	Electronics
1975	Magnolia Accessories	Electronics
1976	Headphone Amplifiers	Electronics
1977	Amps	Electronics
1978	Headphone Amps	Electronics
1979	iPads Tablets	Electronics
1980	Tablets Tablet PCs	Electronics
1981	iPad	Electronics
1982	Media Furniture	Electronics
1983	All Speakers	Electronics
1984	Entertainment Centers	Electronics
1985	Small Space Furniture	Electronics
1986	Media Storage Furniture	Electronics
1987	Storage Furniture	Electronics
1988	Keyboards dqdezdwrcbztucaatawcyyexff	Electronics
1989	Samsung Galaxy Tablets	Electronics
1990	Keyboards rewdwwrwzvbzffvvsxdrdbq	Electronics
1991	Galaxy Tablet Accessories	Electronics
1992	See more Samsung Book Cover Keyboard Galaxy Tab S3	Electronics
1993	Keyboards dtcfasvwuxuwccuercftezcrdurveuvcs	Electronics
1994	Camera Camcorder Chargers	Electronics
1995	Photographic Accessories	Electronics
1996	Photography vdacuyvvyfarcxrrzwyvxs	Electronics
1997	Power Protection	Electronics
1998	 Distribution	Electronics
1999	Power Adapters	Electronics
2000	Other Power Protection	Electronics
2001	AC/DC External Power Adapters	Electronics
2002	Power Supplies wdbtebuqwtfr	Electronics
2003	Doorbells & Intercoms	Electronics
2004	Door Bells	Electronics
2005	Doorbell Buttons	Electronics
2006	See more SkyBell SH02300BZ HD WiFi Video Doorbell Bronz...	Electronics
2007	Connectors	Electronics
2008	magnolia home theater	Electronics
2009	Video Cables	Electronics
2010	Power & Chargers	Electronics
2011	HDMI Cables	Electronics
2012	See more Logitech G230 Black/Red Headband Headsets for ...	Electronics
2013	Sling Bags	Electronics
2014	dgbgf	dgbgf
2015	lugk	lugk
2016	vfdv	vfdv
2017	32342423	32342423
2018	apple	apple
2019	minecraft	minecraft
2020	hi	hi
2021	gaming	gaming
2022	microsoft	microsoft
2023	Upple	Upple
\.


--
-- Data for Name: Client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Client" (id, name, birthday_date, email) FROM stdin;
1	emagyhbuhb	2005-10-25	srfstfnd@hbefy.com
2	plcsfeuyng	2007-12-21	peywnnjp@gvpjc.com
3	ktwcpgfjvo	2005-05-08	ywmwkafm@hkgyx.com
4	aldhthfdww	2016-05-04	dooygxvp@cfslq.com
5	qlworarswr	2016-04-19	yeadodih@dudsf.com
6	tfnobcmpxs	2013-03-26	xoitjuas@lljvw.com
7	efsuxkhnpi	2005-06-24	lcgyusmd@fcqip.com
8	ftedtohpmw	2008-09-05	gibwdpaq@vykmu.com
9	kdbfviqypo	2012-03-30	gmtfghkp@ttqlx.com
10	vetyrhtels	2017-01-15	yhdlxblb@vmsec.com
11	sblxdftnja	2019-08-16	nsimvdsb@ramhr.com
12	hispiupreo	2014-07-14	csxiglhs@uqxsh.com
13	wpabilbjxg	2008-07-15	fhmlirry@dawhb.com
14	frsacyuyuk	2014-06-23	lyknjuxl@uqebd.com
15	ofysnnnbdc	2018-06-23	clhblhox@mvomv.com
16	ywpopgbtsi	2012-10-21	ulqcejgp@gymty.com
17	mvjjbfpits	2001-04-17	wasbmqrp@nlqcv.com
18	ibxslmvppr	2002-08-14	qxssoypu@dsifj.com
19	uoxeurihpi	2015-12-21	bfwydxep@qiehl.com
20	sldlbogpuu	2009-09-15	dewuxaio@xdolx.com
21	uevqbyvdow	2015-07-10	ylnwrxvs@lnleq.com
22	rpkknhhaio	2001-06-03	jidujhcb@uscjb.com
23	npvjqbhyvq	2015-06-03	rbtjebos@jndpv.com
24	ulrbbekxrk	2009-04-21	rvqhddxx@huhkx.com
25	housxtjybx	2010-02-21	bwsoptqt@vheec.com
26	toxtiehskt	2013-04-20	ourqlsny@sluln.com
27	hrvemholip	2017-10-16	qorjbxiu@blqng.com
28	calpekwoni	2001-07-15	plwjikte@maooo.com
29	mnvbkknunf	2007-11-08	irevoqre@mybgu.com
30	twcmrkummd	2015-12-08	jbqedlml@cxvaw.com
31	kmefiryagu	2018-07-17	jjimstcl@oxnhh.com
32	qkyyodivpt	2020-03-09	precgpwu@inqub.com
33	xfagnvswdv	2019-05-03	jpohuuhw@eobxs.com
34	qacnovirrf	2019-10-25	kgcdyinf@wogay.com
35	wuwjtabunj	2003-07-31	cykonvwa@pdhfp.com
36	yrvoimbjcl	2008-05-12	jufhihpb@olbkn.com
37	hjfqenngga	2003-04-30	scgfwrdi@cqkxr.com
38	qkivdyacsv	2011-12-25	aoheujgt@vqqxx.com
39	enqtxlqewd	2017-10-17	ptfgrfeo@nckew.com
40	robbvyqgak	2005-11-23	okdnrynb@dycrf.com
41	mtvfqxgolx	2020-01-10	coeuwdoy@tytuv.com
42	agkqlahoky	2006-07-11	adsrxpag@mpkvr.com
43	wcnfyhwstu	2001-09-21	hhyehxbj@vwslw.com
44	ieqwbnsuma	2018-04-12	ewortkju@fgtqa.com
45	xycphyifcf	2000-05-02	ragqsepi@lqmsd.com
46	mtdkctehax	2002-04-11	kgnluwpc@uiedm.com
47	dvdywojmhf	2015-10-11	asffddhe@pcauy.com
48	hibtweggko	2018-07-06	ldvlkvrc@yximu.com
49	tuellweqlj	2002-06-24	xwyluexd@wwjqt.com
50	atfffaxmno	2005-03-23	hiprpeix@yqchd.com
51	vhixnjxbwd	2001-07-31	gsawewum@fijoq.com
52	yqlqllugkr	2008-06-21	ugqqkcko@ohyji.com
53	fkaqavtawq	2000-06-13	pvabgwnb@npray.com
54	tukuwwgyks	2000-03-09	emiyhjog@qfbya.com
55	oynqoeuthj	2014-12-01	ggjphrpt@gucuu.com
56	feiajnjnvm	2003-03-23	bnwwpnmg@ahibu.com
57	qtqfexcyhl	2012-10-23	crjrildf@gfqub.com
58	biokhmeeuc	2008-02-25	fkamyhpy@cjijk.com
59	pbyeptaywl	2016-10-05	dxkaglgb@pmexm.com
60	ounhcefakn	2011-10-23	ymehmdma@liinb.com
61	nogtjyrsqq	2015-05-01	augnlykf@ljbyf.com
62	ywpmuddymy	2008-11-20	ttojiwje@kuhxf.com
63	gcqtnqgaqm	2009-11-28	gltkquex@qfmat.com
64	gcsxfddhyr	2004-01-13	jyebeiri@xqjth.com
65	gbgxetmqoq	2004-12-27	llvlhbdm@oeney.com
66	ddoupvxufg	2012-04-06	fmhglglp@fkkbu.com
67	lbbytfjngr	2006-09-16	ngkdxqau@yrmuy.com
68	rbonmsykqq	2020-09-05	tfybgwpk@amhko.com
69	evygqetoom	2015-10-24	xyrgnaus@eevcs.com
70	lqaoeqaymc	2015-10-06	sgtvvkmg@kbimv.com
71	bohcxxspvb	2006-05-23	unkucdwr@plngf.com
72	umvflnjddd	2017-09-26	dqcdpkcf@qdmqw.com
73	twnqdjawro	2013-01-24	haswubkk@kpwwd.com
74	javiiyfxjy	2005-10-10	pirptqbu@nbprp.com
75	pssbempaet	2013-06-29	ghmbjjdv@hnotw.com
76	bwsthoromg	2001-01-28	lukmdkic@ukrtv.com
77	mlechcllgc	2012-04-17	mtcbgcsf@ttlkt.com
78	tdtjkwfrfp	2013-01-18	lqdxqrsd@dkxln.com
79	jsrwfljfaq	2002-11-17	bwrqouim@jwcdx.com
80	yaqkjipdbe	2000-02-13	ljetvned@nidbx.com
81	fvogqjeivt	2013-09-11	wgvfblnv@mmgko.com
82	vjqtsiksmy	2001-12-04	pqlyyiho@xwmar.com
83	wgvjvaouhg	2009-11-14	xryfytfb@weubs.com
84	llqofhhxvx	2016-12-11	apgfogsd@uahpl.com
85	gtbnfuqxhb	2014-05-11	xkaqsikr@ilhmm.com
86	ytlwxoghqf	2002-09-29	catxlvvn@ploes.com
87	hvhmepbnji	2019-12-14	rrtmuyxj@fqpdt.com
88	sfenuqomcy	2003-06-04	vhamwhip@rsyeg.com
89	repgwjlicw	2003-11-07	tlsatetp@vjgdr.com
90	nrwojfeqdt	2015-01-03	fyelyfmm@rdjad.com
91	rqdvhesmuu	2004-08-07	hdobmftv@ptqdj.com
92	fqdnvfuwff	2002-10-06	pnivvyja@djywu.com
93	rgruwbyeue	2016-08-18	swytiraw@tfdlp.com
94	kcxsqlyvjo	2006-10-02	vdgdntxo@ymblc.com
95	dlncxmkmst	2008-09-06	dikqhcne@xvnxn.com
96	nosdtknewg	2004-01-29	pxcmbovf@nbegy.com
97	turprwjdsc	2020-11-02	rtxoqpgb@novyy.com
98	txpsngybsx	2020-08-23	oincwrdo@ysalk.com
99	haugggobkk	2005-12-27	kskwypne@shmag.com
100	rfndbttjse	2003-05-23	toxqimxb@pybxr.com
101	ietihrsmqr	2010-11-28	xxfauqye@jkueq.com
102	mhfdboemrv	2019-04-18	hbgtndmf@csjhd.com
103	isfyowvuib	2016-04-25	tkbpoyxf@mcsyx.com
104	vwdihhhsvb	2008-08-22	fnhrving@uhtsu.com
105	bmvftfdfxs	2020-07-17	lyqpnvfv@qidee.com
106	rnlcugmhyh	2005-04-24	rjyadavh@rgqff.com
107	djkqslonuo	2011-09-15	klysjnrs@voydi.com
108	ldbfiolgho	2020-02-22	bwdatdoo@swqkc.com
109	kwxvmecvni	2003-07-13	ancewudl@xrwvd.com
110	ahviqjelrg	2006-07-22	euowelrv@tetfx.com
111	ojossfclui	2000-03-18	byxoumae@hwtje.com
112	kslgmicsex	2018-01-09	aqjaggju@lmgsf.com
113	euyxfsceoh	2012-11-29	mjmfyvkl@ecemx.com
114	bmrsfcvypb	2000-02-15	yxydnbub@umdgi.com
115	pjusmebqlp	2003-11-03	fyrrxcnl@yjlbu.com
116	uhtioerind	2009-02-21	yxlngjuq@auqjd.com
117	fhufbngsod	2016-12-29	nlexayot@vutrd.com
118	mymhiwahns	2016-07-29	ghlltnoj@akbpi.com
119	bqjepgrupe	2004-01-07	fwvjkesf@ltnaj.com
120	giosaoycej	2017-12-17	kyqwpfmy@ahnwi.com
121	wdsphiaskn	2013-09-17	dbnbdjxh@qkfrg.com
122	ipkuafflmi	2014-11-06	omkylidm@sqjpy.com
123	eolrlpqcjp	2012-03-17	qsnkhrdf@dfuat.com
124	xjbuawrggx	2010-11-28	btaxsmta@hqnsk.com
125	anyxekfgxw	2012-10-30	kynnccki@thyec.com
126	wpkgfyovhg	2000-06-03	nuaypwvi@kffmf.com
127	dnmwcpdrlp	2003-02-07	mjqrhktg@hgcvm.com
128	hkncnbmsoh	2016-09-15	yhjaonoh@kfbgn.com
129	ldxxjibtjx	2001-07-06	ojwtuhfl@osfgm.com
130	yitjlxvqup	2019-03-12	mdcsqgur@ttdsc.com
131	iuaepopqlh	2014-11-29	tcxwpipx@xsiad.com
132	qehklukcsh	2012-03-07	hdhroujc@outsk.com
133	awlnmmlqar	2008-09-17	jecxvfay@kqsdv.com
134	pptduccwqv	2016-07-28	qfagpvtj@dmhld.com
135	dfgohsrrfd	2007-04-02	sengvnco@ehtlo.com
136	burnqahqhb	2004-01-08	yaqmorys@mpgoy.com
137	hbslhdhdei	2005-12-09	ssyqsgit@krkxp.com
138	birrggxapb	2013-04-27	forqdmru@igxcf.com
139	cqcmcnruvf	2012-02-20	pbvhuthp@mbcbb.com
140	etxyvfumdq	2002-01-12	qwbortcn@bpkcl.com
141	pcdqwbdpko	2011-11-04	qfhagnhl@hjugy.com
142	mntsbeaihn	2020-07-29	tbtellhy@uoiqy.com
143	iavideeexb	2000-07-29	bldosmxw@pvrxw.com
144	qrihyjidko	2020-05-11	dnjaehwm@ktdwm.com
145	axthuwobju	2012-03-02	skpqjlmv@rlhkk.com
146	wvssocivqi	2019-08-21	rswpawuv@xrjvg.com
147	anjfjvhpmk	2000-03-26	vwgljjmy@utgjd.com
148	jmqqvcodta	2012-03-06	csqnlqpr@byrtl.com
149	brysrykmqs	2020-07-21	rwghhyjn@eclbi.com
150	kieicuusyu	2016-12-12	ehqysbqk@voxph.com
151	mgxjiviube	2012-09-21	skeulnbe@nxecq.com
152	bonmnmcams	2000-05-10	qfqkchxj@uwfcu.com
153	hesqhrhidx	2017-09-01	fxxmjtrm@jotgm.com
154	gviudhtsii	2016-10-23	bgpyfiux@myiaw.com
155	qsrwylonhv	2013-12-28	ajtdcawe@yscnj.com
156	wmsxybedif	2015-08-06	rddykheq@xgdqn.com
157	yqpqwrbdvr	2010-03-14	movotymt@qsusu.com
158	wrbownjsnw	2006-04-30	uoewmrsw@ahsml.com
159	hmpvquuadm	2006-04-14	ovcxlidc@wmtox.com
160	nggyhaeprx	2020-07-14	lgflxgqg@laqdw.com
161	nlvtwltmxc	2010-03-14	lmvcacxk@lupwu.com
162	qsaqthdkys	2005-01-20	fiuptbwf@hsbvv.com
163	fvxyfobads	2006-03-24	sumylbir@xlsae.com
164	cftmpjwyry	2019-05-04	vmkbshsi@ilxad.com
165	ppgdaqgjsy	2008-04-05	yeddqhcb@qdmpk.com
166	axxmkqmdnc	2000-11-17	nydqvdfa@ecdig.com
167	gfovhhmimo	2000-06-28	fbixmckv@nagpq.com
168	mboicdfpwa	2006-04-05	rhnuxevv@bnrcn.com
169	kskepuojah	2014-01-20	wqojiuhe@vgehg.com
170	vggmuvhtkc	2013-08-21	kxhkadtx@ovtfs.com
171	ujnfjvivjk	2005-07-28	kuhjsuiq@oklsl.com
172	pqsqsjimho	2015-08-24	brpifbpu@pqhke.com
173	yssqryrprq	2006-09-18	oqdylfhv@quhko.com
174	qxvxtxmwkg	2002-12-08	tminexqo@iboet.com
175	skmboqoyko	2011-02-24	ccgqwhuq@byeuc.com
176	hohqpctekl	2010-12-17	lrjlajlu@kjgtk.com
177	rogcxniqfw	2015-07-22	yincuwmh@qyhgr.com
178	qkcrifpasr	2008-09-08	vetpidyw@xieow.com
179	fpoavohykd	2006-07-19	bxduvjii@sgjid.com
180	tdcslwdjvl	2001-04-04	uovtknma@pqivu.com
181	mhbheexsos	2005-08-30	imwjaelj@uhjir.com
182	viyfwylsdq	2009-11-27	pfaqdsxk@yptjo.com
183	iruexymyie	2016-10-22	cbympewd@iyghi.com
184	sgwuvwtofp	2017-08-08	voqccqgw@tewma.com
185	nrydntscex	2019-10-20	fdgybotr@goiuy.com
186	abnjbcoieo	2016-03-09	yvhyvgjt@ojrxt.com
187	rrghwidqup	2011-11-07	ltreegas@qcvwy.com
188	nygyagwock	2002-01-09	qgfufbgp@nwccu.com
189	omqlkmabfe	2020-03-13	tqmrihcg@naiwy.com
190	mxlsfkelma	2003-06-07	ulffiaxq@ldiks.com
191	lmotcsrdie	2014-03-19	cvyrydoo@amjah.com
192	hmlorhxsno	2018-05-20	eroaotkl@jxywf.com
193	sxahiboosl	2007-08-28	joajbdrk@gdyuq.com
194	giujxlooro	2019-04-11	omvmslbf@athee.com
195	mgfmfqdqha	2016-12-06	hfftrpvu@uovbm.com
196	paimcjggvr	2018-09-28	ovruifpf@kotiy.com
197	vfqytagxmm	2008-07-10	ooonxmab@ggcfi.com
198	iqghutyefx	2006-10-10	lkonwvkd@yypts.com
199	epmqksxneq	2015-12-20	dceofmon@irtfs.com
200	bbbttuthkv	2015-09-15	mysbfduh@isxlu.com
\.


--
-- Data for Name: Link_Product-Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Link_Product-Category" (product_id, category_id) FROM stdin;
1	1
1	2
1	3
1	4
1	5
1	6
1	7
2	8
2	9
2	10
2	11
2	12
2	13
2	4
2	14
2	15
2	16
2	17
2	18
2	19
2	20
2	21
2	22
2	23
2	24
2	25
3	26
3	27
3	28
3	29
3	30
3	31
3	32
3	4
3	33
3	34
3	35
4	9
4	36
4	13
4	4
4	37
4	23
5	38
5	39
5	40
5	41
5	4
5	42
5	43
5	15
5	16
5	44
5	45
5	46
5	20
5	47
5	48
5	22
5	49
5	50
5	23
6	1
6	51
6	4
6	52
6	53
6	6
6	54
6	55
7	38
7	10
7	11
7	40
7	4
7	42
7	43
7	15
7	18
7	20
7	48
7	56
7	22
7	23
8	57
8	58
8	59
8	29
8	4
8	32
8	60
8	61
9	26
9	62
9	59
9	63
9	64
9	65
9	4
9	32
9	66
10	36
10	13
10	4
10	67
10	68
10	23
11	4
11	69
11	70
11	71
11	72
11	73
11	74
11	75
11	59
11	29
11	1
11	76
11	77
11	78
11	79
11	80
11	81
11	82
11	26
11	83
11	84
11	85
11	86
11	87
12	88
12	89
12	90
12	18
12	91
12	92
12	4
12	23
12	93
13	26
13	94
13	95
13	96
13	97
13	59
13	98
13	99
13	29
13	100
13	4
13	60
13	101
13	102
13	63
13	32
13	61
14	103
14	18
14	104
14	105
14	106
14	107
14	108
14	54
14	50
14	109
14	55
14	109
14	110
15	111
15	112
15	113
15	4
15	114
15	15
15	115
15	116
15	18
15	117
15	118
15	119
15	120
15	121
15	122
15	123
15	124
15	125
15	126
16	26
16	127
16	95
16	58
16	59
16	29
16	4
16	60
16	101
16	128
16	57
16	32
16	129
16	61
17	130
17	131
17	132
17	133
17	134
17	135
17	136
17	137
17	138
17	139
17	140
17	141
18	88
18	89
18	142
18	130
18	143
18	4
18	133
18	23
18	93
19	144
19	145
19	22
19	15
19	23
20	27
20	146
20	147
20	148
20	149
20	150
20	151
20	152
20	4
20	54
20	35
20	153
20	154
20	5
20	155
20	156
20	157
20	158
21	159
21	113
21	4
21	114
21	15
21	160
21	116
21	161
21	162
21	18
21	117
21	118
21	119
21	121
21	122
21	124
21	163
21	164
21	165
21	166
21	125
21	126
22	29
22	4
22	54
22	109
22	109
22	110
22	18
22	167
22	104
22	32
22	108
22	6
22	50
22	55
22	168
22	34
22	169
23	4
23	26
23	28
23	170
23	171
23	170
23	172
23	59
23	29
23	170
23	173
23	32
23	174
23	175
23	176
23	177
23	178
23	179
23	180
23	176
23	181
23	182
23	183
23	184
23	185
23	186
23	41
23	187
23	180
24	9
24	36
24	13
24	4
24	37
24	23
24	188
25	1
25	189
25	122
25	190
25	191
25	192
25	193
25	4
25	6
25	23
25	194
25	195
26	144
26	4
26	145
26	22
26	15
26	196
26	23
27	59
27	63
27	65
27	4
27	32
27	66
28	26
28	28
28	29
28	30
28	31
28	32
28	4
29	197
29	198
29	199
29	200
29	201
29	4
29	202
29	69
29	203
29	204
29	205
29	206
29	207
29	208
30	209
30	199
30	201
30	210
30	211
30	212
30	4
30	179
30	213
30	214
30	215
30	69
30	203
30	207
30	216
30	217
30	206
30	218
30	207
30	208
30	219
30	220
31	221
31	222
31	4
31	223
31	224
31	43
31	54
31	225
31	226
31	227
31	228
31	229
31	230
31	231
31	232
32	9
32	8
32	26
32	36
32	28
32	12
32	13
32	4
32	233
32	234
32	15
32	16
32	235
32	37
32	236
32	23
32	237
33	41
33	4
33	15
33	238
33	116
33	18
33	239
33	122
33	47
33	124
33	240
33	22
33	23
34	102
34	59
34	187
34	241
34	4
34	32
34	242
34	243
34	244
34	245
34	246
35	26
35	62
35	59
35	63
35	65
35	64
35	4
35	32
35	66
35	247
36	1
36	2
36	153
36	248
36	3
36	147
36	148
36	149
36	4
36	249
36	54
36	6
36	7
37	144
37	250
37	40
37	47
37	41
37	4
37	43
37	15
37	251
37	22
37	23
37	252
38	18
38	10
38	11
38	253
38	254
38	255
38	4
38	256
38	231
38	43
38	22
38	23
38	257
39	26
39	258
39	28
39	29
39	31
39	259
39	4
39	260
39	33
39	261
39	34
39	162
39	30
39	34
39	262
39	32
40	26
40	28
40	29
40	30
40	31
40	32
40	4
41	27
41	263
41	146
41	147
41	148
41	149
41	151
41	264
41	54
41	265
41	266
41	267
41	268
41	35
41	269
41	270
41	155
42	9
42	36
42	271
42	13
42	4
42	37
42	23
42	93
42	272
42	188
43	8
43	273
43	12
43	235
43	4
43	233
43	234
43	22
43	15
43	16
43	23
43	236
44	239
44	274
44	240
44	43
44	15
44	22
44	23
45	126
45	116
45	112
45	275
46	228
46	229
46	276
46	230
46	4
46	277
46	231
46	224
46	54
46	226
47	26
47	94
47	95
47	59
47	29
47	278
47	41
47	60
47	4
47	101
47	279
47	280
47	281
47	282
47	283
47	284
47	32
47	61
48	88
48	18
48	91
48	41
48	4
48	285
48	23
49	18
49	286
49	91
49	287
49	13
49	4
49	288
49	289
49	233
49	290
49	23
49	291
49	292
50	18
50	8
50	10
50	11
50	255
50	254
50	56
50	4
50	256
50	22
50	23
51	4
51	233
51	117
51	122
51	293
51	294
51	121
51	114
51	295
51	296
51	116
51	297
51	298
51	162
52	117
52	122
52	299
52	300
52	18
52	91
52	301
52	302
52	303
52	125
52	304
52	305
52	115
52	111
52	114
52	306
52	51
52	126
52	307
52	308
52	4
52	41
53	1
53	2
53	147
53	148
53	149
53	4
53	54
53	309
53	7
53	310
53	311
53	312
53	153
53	248
53	3
53	5
53	249
53	6
53	313
54	1
54	2
54	314
54	315
54	316
54	147
54	4
54	317
54	318
54	319
54	7
54	195
54	189
54	230
54	320
54	153
54	321
54	322
54	3
54	6
54	23
54	323
54	324
54	325
55	326
55	327
55	328
55	329
55	130
55	330
55	26
55	4
55	28
55	331
55	332
56	1
56	189
56	333
56	4
56	6
56	334
56	23
56	335
56	336
56	195
57	59
57	29
57	104
57	4
57	337
57	54
57	50
57	109
57	55
58	57
58	59
58	29
58	4
58	32
58	60
58	61
59	1
59	59
59	29
59	32
59	4
59	237
60	4
60	22
60	338
60	50
60	44
60	233
60	43
60	339
60	340
60	341
60	23
60	36
60	342
60	15
60	343
60	41
61	344
61	345
61	121
61	346
61	41
61	4
61	114
61	23
61	347
61	116
61	126
62	348
62	102
62	62
62	349
62	59
62	63
62	350
62	65
62	4
62	32
62	66
63	4
63	121
63	114
63	116
63	15
63	119
63	126
63	112
63	275
64	351
64	10
64	11
64	222
64	4
64	223
64	43
64	224
64	54
64	225
64	226
64	227
64	228
64	18
64	229
64	352
64	230
64	231
64	353
65	88
65	89
65	90
65	4
65	23
65	93
66	354
66	163
66	160
66	165
66	159
66	4
66	121
66	114
66	116
66	15
66	126
66	164
66	112
66	113
66	181
66	355
66	161
67	239
67	356
67	274
67	240
67	43
67	15
67	22
67	23
68	26
68	357
68	4
68	15
68	358
68	359
68	177
68	22
68	15
68	23
68	237
69	23
69	22
69	25
69	43
69	360
69	361
70	1
70	59
70	29
70	4
70	43
70	15
70	362
70	273
70	251
70	22
70	23
70	237
70	363
71	364
71	22
71	15
71	23
72	230
72	365
72	366
72	41
72	4
72	367
72	231
72	43
72	54
72	368
72	369
72	370
73	4
73	26
73	28
73	371
73	6
73	372
73	200
73	198
73	373
73	69
73	374
73	375
73	18
73	10
73	11
73	10
73	376
73	377
73	378
73	379
73	130
73	380
74	8
74	273
74	12
74	4
74	22
74	15
74	16
74	23
74	17
75	9
75	381
75	382
75	36
75	91
75	383
75	13
75	41
75	4
75	384
75	385
75	16
75	386
75	17
75	93
75	301
75	302
75	18
75	271
75	47
75	22
75	37
75	23
75	272
76	387
76	388
76	1
76	59
76	29
76	389
76	390
76	4
76	391
76	392
76	76
76	393
76	394
76	395
76	192
76	396
76	71
76	72
77	26
77	82
77	59
77	4
77	397
77	398
77	399
77	400
77	32
77	401
77	50
77	402
77	403
77	83
77	404
77	405
77	406
77	407
77	44
77	408
77	409
77	18
77	410
77	102
77	411
77	412
77	413
77	394
77	414
77	192
77	156
77	415
77	416
78	117
78	122
78	116
78	417
78	418
78	293
78	419
78	126
78	295
78	420
78	421
78	422
78	4
78	423
78	424
79	9
79	381
79	36
79	91
79	13
79	4
79	43
79	15
79	16
79	386
79	17
79	301
79	302
79	18
79	339
79	425
79	235
79	22
79	37
79	23
79	426
79	340
80	27
80	146
80	147
80	148
80	149
80	151
80	264
80	54
80	44
80	265
80	427
80	35
80	270
80	155
80	50
81	26
81	58
81	428
81	59
81	429
81	29
81	32
81	60
81	4
81	430
81	101
81	61
82	117
82	122
82	124
82	431
82	238
82	432
82	126
82	116
82	433
82	434
82	18
82	125
82	115
82	111
82	114
82	435
82	239
82	4
82	121
83	26
83	82
83	404
83	4
83	436
83	134
83	136
83	437
83	438
83	439
83	440
83	102
83	441
83	442
83	133
83	24
84	93
84	88
84	4
84	443
84	27
84	35
84	444
84	445
84	4
84	446
84	447
84	448
84	23
84	449
85	26
85	450
85	59
85	451
85	452
85	453
85	4
85	454
85	102
85	30
85	452
85	32
85	455
85	456
86	239
86	274
86	4
86	240
86	43
86	15
86	22
86	23
87	26
87	457
87	59
87	429
87	29
87	4
87	32
87	60
87	430
87	101
87	61
88	9
88	381
88	36
88	91
88	13
88	4
88	233
88	15
88	16
88	386
88	93
88	301
88	302
88	18
88	286
88	271
88	235
88	37
88	23
88	272
88	292
89	4
89	43
89	15
89	16
89	239
89	117
89	118
89	122
89	274
89	124
89	240
89	22
89	458
89	23
90	117
90	122
90	417
90	418
90	293
90	294
90	4
90	121
90	114
90	116
90	297
90	126
90	298
91	26
91	459
91	96
91	97
91	98
91	99
91	59
91	29
91	460
91	60
91	4
91	102
91	461
91	63
91	32
91	462
92	26
92	463
92	59
92	29
92	464
92	30
92	465
92	466
92	32
92	4
92	174
93	4
93	26
93	28
93	371
93	467
93	468
93	59
93	469
93	470
93	471
94	26
94	59
94	452
94	453
94	4
94	454
94	102
94	472
94	30
94	452
94	32
94	455
94	456
94	473
95	273
95	13
95	474
95	4
95	22
95	15
95	16
95	23
95	17
96	26
96	475
96	476
96	28
96	4
96	477
96	175
96	176
96	478
96	44
96	479
96	480
96	481
96	482
96	483
96	484
96	485
96	32
96	175
96	486
96	50
96	174
96	487
96	180
96	176
96	180
97	1
97	488
97	489
97	490
97	333
97	4
97	54
97	336
97	491
97	6
97	334
97	55
97	71
97	492
98	493
98	26
98	494
98	59
98	495
98	32
98	4
98	496
98	497
98	498
98	499
98	500
99	26
99	501
99	499
99	502
99	32
99	498
99	496
99	4
99	59
99	497
99	493
99	102
99	503
99	504
100	26
100	8
100	12
100	505
100	29
100	506
100	41
100	4
100	474
100	15
100	16
100	17
100	507
100	15
100	358
100	359
100	32
100	177
100	22
100	23
100	237
100	508
101	509
101	510
101	511
101	512
101	4
101	43
101	513
101	514
101	515
101	516
101	517
101	231
101	49
101	518
101	519
101	382
101	10
101	11
101	520
101	521
101	522
101	41
101	523
101	524
101	54
101	16
101	525
101	18
101	526
101	230
101	527
101	528
102	10
102	11
102	13
102	4
102	43
102	529
102	18
102	530
102	531
102	361
102	532
102	22
102	360
102	23
102	25
103	26
103	533
103	59
103	452
103	453
103	4
103	454
103	102
103	30
103	452
103	32
103	456
103	455
103	534
104	4
104	535
104	114
104	536
104	537
104	538
104	160
104	116
104	162
104	121
104	297
104	539
104	163
104	165
104	126
105	203
105	540
105	541
105	200
105	542
105	543
105	544
105	4
105	213
105	545
105	69
106	9
106	8
106	13
106	4
106	22
106	16
106	546
106	37
106	23
106	25
107	540
107	541
107	542
107	69
108	547
108	548
108	333
108	4
108	54
108	55
108	492
108	549
109	88
109	4
109	550
109	23
109	551
110	26
110	82
110	59
110	552
110	404
110	405
110	4
110	553
110	554
110	555
110	398
110	102
110	556
110	32
110	557
110	156
110	158
111	198
111	558
111	559
111	199
111	200
111	180
111	560
111	201
111	210
111	41
111	4
111	215
111	69
111	203
111	207
111	561
111	206
111	562
111	207
111	208
111	219
112	563
112	564
112	565
112	566
112	327
112	39
112	567
112	568
112	41
112	569
112	570
112	43
112	507
112	571
112	130
112	572
112	329
112	573
112	574
112	575
112	576
112	577
112	578
112	326
113	227
113	18
113	229
113	228
113	230
113	10
113	11
113	4
113	231
113	43
113	224
113	54
113	226
114	579
114	201
114	580
114	4
114	581
114	582
114	583
114	69
114	584
114	203
114	585
114	586
114	130
114	587
114	588
114	589
114	590
114	591
115	26
115	59
115	82
115	404
115	4
115	592
115	593
115	398
115	102
115	594
115	400
115	32
115	156
115	157
115	158
116	27
116	595
116	200
116	596
116	146
116	147
116	148
116	149
116	4
116	151
116	264
116	54
116	16
116	265
116	597
116	35
116	270
116	598
116	6
116	155
116	49
116	599
116	600
116	601
117	130
117	602
117	201
117	603
117	4
117	213
117	33
117	604
117	605
117	69
118	26
118	1
118	606
118	28
118	59
118	29
118	607
118	608
118	4
118	609
118	610
118	611
118	329
118	573
118	32
118	612
118	613
119	93
119	88
119	89
119	4
119	23
119	551
119	550
119	614
119	615
119	41
120	547
120	616
120	253
120	254
120	4
120	43
120	16
120	546
120	256
120	231
120	22
120	23
120	257
121	88
121	90
121	615
121	617
121	618
121	4
121	550
121	23
121	93
121	614
121	619
122	273
122	39
122	4
122	43
122	15
122	251
122	22
122	16
122	23
122	17
123	4
123	16
123	49
123	20
123	18
123	91
123	301
123	302
123	381
123	43
123	360
123	361
123	23
123	22
123	25
123	41
123	620
123	538
123	233
124	27
124	596
124	621
124	147
124	148
124	149
124	4
124	151
124	264
124	54
124	16
124	44
124	265
124	35
124	622
124	623
124	624
124	625
124	270
124	155
124	6
124	49
124	50
124	600
125	20
125	13
125	4
125	67
125	22
125	16
125	546
125	23
125	25
126	274
126	626
126	4
126	43
126	15
126	22
126	627
126	23
126	628
127	4
127	16
127	22
127	17
127	12
127	23
127	36
127	188
127	8
127	15
128	10
128	11
128	253
128	254
128	41
128	4
128	629
128	43
128	18
128	255
128	231
128	256
128	22
128	23
128	257
129	8
129	10
129	11
129	12
129	343
129	4
129	43
129	15
129	16
129	17
129	630
129	18
129	631
129	274
129	22
129	632
129	633
129	23
130	9
130	8
130	10
130	11
130	12
130	13
130	4
130	233
130	15
130	16
130	44
130	386
130	17
130	18
130	273
130	22
130	632
130	50
130	37
130	23
131	200
131	634
131	201
131	4
131	213
131	635
131	69
131	203
131	636
131	637
131	638
131	639
131	558
131	640
131	641
131	642
132	88
132	90
132	443
132	4
132	23
132	93
133	643
133	351
133	4
133	224
133	43
133	54
133	226
133	228
133	227
133	229
133	230
133	644
133	231
133	645
134	26
134	59
134	28
134	63
134	41
134	646
134	32
134	4
134	109
134	66
134	647
134	281
135	26
135	127
135	95
135	58
135	59
135	29
135	4
135	60
135	101
135	128
135	57
135	32
135	129
135	61
136	4
136	474
136	22
136	15
136	23
137	26
137	648
137	649
137	650
137	28
137	59
137	29
137	170
137	171
137	4
137	651
137	652
137	653
137	170
137	173
137	654
137	102
137	170
137	655
137	656
137	657
137	32
137	177
137	651
137	658
137	659
138	59
138	29
138	30
138	32
138	4
138	34
138	660
138	661
139	1
139	191
139	190
139	4
139	15
139	44
139	195
139	189
139	193
139	22
139	6
139	50
139	23
140	27
140	35
140	444
140	445
140	662
140	663
140	664
140	71
140	72
140	665
140	666
140	667
140	668
140	39
140	669
140	670
140	671
140	672
140	673
141	88
141	89
141	90
141	443
141	4
141	674
141	23
141	93
142	10
142	11
142	254
142	4
142	43
142	529
142	18
142	530
142	531
142	56
142	256
142	675
142	22
142	676
142	23
142	677
142	25
143	4
143	16
143	22
143	546
143	256
143	23
143	8
143	20
143	254
143	41
144	26
144	82
144	59
144	83
144	29
144	4
144	32
144	678
144	156
144	408
145	679
145	10
145	11
145	41
145	4
145	224
145	43
145	54
145	226
145	228
145	227
145	229
145	18
145	230
145	277
145	231
145	680
146	187
146	59
146	241
146	32
146	4
147	26
147	681
147	132
147	59
147	28
147	29
147	682
147	41
147	4
147	135
147	134
147	136
147	137
147	34
147	109
147	109
147	110
147	507
147	18
147	683
147	684
147	108
147	685
147	686
147	140
147	687
148	253
148	254
148	41
148	4
148	231
148	256
148	43
148	22
148	23
148	257
148	688
149	274
149	626
149	43
149	15
149	22
149	23
149	627
150	26
150	59
150	689
150	690
150	4
150	32
150	455
150	691
150	692
151	693
151	59
151	63
151	41
151	4
151	694
151	32
151	496
151	497
151	498
151	507
151	500
152	22
152	15
152	23
152	627
153	88
153	90
153	4
153	285
153	23
154	126
154	695
154	696
155	9
155	36
155	12
155	13
155	4
155	68
155	233
155	15
155	44
155	16
155	17
155	301
155	302
155	18
155	21
155	22
155	50
155	37
155	23
155	24
155	292
156	117
156	122
156	124
156	697
156	118
156	126
156	116
156	112
156	4
156	121
156	114
156	15
156	119
156	18
156	71
157	144
157	4
157	145
157	43
157	15
157	16
157	17
157	698
157	22
157	251
157	699
157	23
157	700
158	9
158	36
158	13
158	4
158	37
158	23
158	188
159	701
159	121
159	295
159	297
159	4
159	114
159	126
159	116
159	296
160	26
160	648
160	59
160	28
160	29
160	170
160	171
160	702
160	4
160	170
160	173
160	703
160	704
160	657
160	32
160	651
160	659
161	26
161	28
161	104
161	4
161	705
161	107
161	54
161	50
161	109
161	55
162	4
162	706
162	707
162	708
162	39
162	709
162	130
162	126
162	710
162	711
163	4
163	230
163	227
163	231
163	18
163	10
163	11
163	229
163	54
163	679
163	224
163	41
163	645
163	712
164	26
164	1
164	713
164	714
164	715
164	190
164	716
164	4
164	66
164	230
164	320
164	193
164	32
164	177
164	6
164	717
164	718
164	719
165	147
165	452
165	453
165	4
165	720
165	721
165	54
165	722
165	18
165	723
165	724
165	102
165	725
165	155
166	4
166	367
166	231
166	54
166	370
167	726
167	4
167	43
167	17
167	339
167	425
167	632
167	37
167	426
167	9
167	382
167	383
167	39
167	10
167	11
167	727
167	13
167	728
167	385
167	16
167	18
167	729
167	730
167	21
167	22
167	23
167	340
167	731
168	4
168	26
168	28
168	170
168	171
168	170
168	172
168	32
168	174
168	175
168	176
168	732
168	59
168	733
168	734
168	735
168	180
168	180
168	176
168	736
169	26
169	187
169	59
169	28
169	29
169	4
169	170
169	173
169	733
169	737
169	170
169	32
169	174
169	738
170	26
170	28
170	201
170	4
170	739
170	69
170	203
170	130
170	740
170	741
170	742
170	743
170	744
170	745
170	746
170	129
170	747
170	748
171	26
171	59
171	82
171	749
171	750
171	4
171	751
171	752
171	753
171	398
171	102
171	32
171	754
171	156
171	755
171	754
171	756
172	757
172	758
172	13
172	4
172	134
172	136
172	93
172	759
172	760
172	761
172	67
172	762
172	707
172	706
173	354
173	163
173	160
173	165
173	763
173	4
173	121
173	114
173	116
173	297
173	161
173	126
173	159
173	164
173	764
173	256
173	194
173	8
173	117
173	23
173	122
174	26
174	94
174	59
174	63
174	29
174	4
174	32
174	60
174	765
174	61
175	26
175	59
175	82
175	552
175	405
175	4
175	66
175	555
175	766
175	32
175	156
175	717
175	158
176	1
176	273
176	59
176	29
176	4
176	43
176	15
176	251
176	22
176	23
176	237
177	88
177	89
177	90
177	443
177	4
177	550
177	23
177	551
177	93
178	26
178	767
178	59
178	768
178	4
178	691
178	769
178	770
178	771
178	102
178	772
178	773
178	774
178	689
178	32
178	455
179	26
179	127
179	96
179	97
179	58
179	95
179	98
179	99
179	59
179	29
179	100
179	41
179	4
179	60
179	101
179	128
179	281
179	102
179	57
179	63
179	775
179	32
179	129
179	776
179	61
179	777
180	4
180	26
180	455
180	770
180	769
180	771
180	32
180	691
180	692
180	59
180	689
181	4
181	22
181	43
181	360
181	23
181	25
181	778
182	102
182	779
182	76
182	71
182	72
182	394
182	391
182	389
182	4
182	213
182	780
182	781
182	782
182	783
182	50
182	784
183	785
183	91
183	786
183	4
183	787
183	136
183	93
183	88
183	89
183	18
183	90
183	328
183	788
183	550
183	133
183	789
183	23
183	790
184	4
184	22
184	43
184	360
184	23
184	25
184	778
184	677
185	26
185	57
185	95
185	58
185	59
185	29
185	4
185	32
185	60
185	101
185	61
186	791
186	742
186	743
186	199
186	201
186	59
186	29
186	4
186	792
186	743
186	793
186	69
186	739
186	203
186	740
186	794
187	142
187	795
187	4
187	93
187	88
187	89
187	90
187	130
187	796
187	133
187	23
187	797
187	614
187	798
188	228
188	227
188	229
188	352
188	230
188	4
188	223
188	231
188	224
188	43
188	54
188	226
189	88
189	89
189	799
189	617
189	618
189	4
189	23
189	93
189	619
190	26
190	1
190	606
190	331
190	59
190	4
190	507
190	330
190	611
190	329
190	800
190	15
190	358
190	359
190	801
190	32
190	615
190	327
190	28
190	29
190	607
190	41
190	88
190	102
190	779
190	328
190	802
190	177
190	332
190	613
190	612
190	23
190	614
190	326
191	203
191	803
191	540
191	200
191	804
191	805
191	806
191	4
191	807
191	213
191	69
192	4
192	121
192	114
192	116
192	15
192	119
192	117
192	122
192	124
192	118
192	126
192	112
192	113
193	117
193	122
193	124
193	808
193	112
193	809
193	18
193	125
193	116
193	123
193	810
193	126
193	113
193	422
193	4
193	15
193	119
194	811
194	199
194	200
194	201
194	812
194	813
194	4
194	213
194	814
194	69
194	203
194	637
194	639
194	640
194	642
195	4
195	16
195	22
195	17
195	239
195	43
195	15
195	274
195	23
195	240
196	4
196	16
196	22
196	17
196	626
196	43
196	15
196	274
196	23
196	627
197	117
197	122
197	116
197	417
197	815
197	293
197	816
197	4
197	121
197	114
197	295
197	296
197	126
197	297
197	817
198	4
198	59
198	63
198	818
198	32
198	66
198	819
198	102
198	349
198	820
199	59
199	4
199	54
199	43
199	821
199	156
199	55
199	822
199	823
200	26
200	57
200	95
200	59
200	29
200	63
200	32
200	60
200	4
200	101
200	61
201	824
201	274
201	343
201	626
201	4
201	43
201	15
201	22
201	23
201	627
202	26
202	493
202	59
202	4
202	496
202	825
202	497
202	826
202	498
202	827
202	828
202	32
202	499
203	26
203	767
203	829
203	59
203	689
203	830
203	4
203	32
203	455
203	831
203	691
203	692
204	8
204	20
204	4
204	256
204	22
204	16
204	546
204	832
204	23
205	26
205	459
205	96
205	97
205	98
205	99
205	59
205	29
205	60
205	4
205	101
205	102
205	461
205	429
205	32
205	61
206	26
206	833
206	59
206	29
206	834
206	4
206	835
206	170
206	173
206	733
206	170
206	32
206	177
206	174
206	178
206	836
206	738
207	9
207	36
207	13
207	4
207	233
207	50
207	44
207	37
207	23
207	188
208	144
208	250
208	22
208	15
208	43
208	251
208	23
209	102
209	59
209	772
209	773
209	689
209	32
209	4
209	455
209	691
209	692
210	837
210	838
210	839
210	840
210	841
210	684
210	842
210	134
210	136
210	137
210	93
210	843
211	4
211	474
211	48
211	22
211	15
211	43
211	23
211	844
212	200
212	845
212	39
212	846
212	847
212	4
212	848
212	213
212	93
212	69
212	849
212	638
212	70
212	850
212	851
212	852
212	853
212	854
213	855
213	4
213	285
213	10
213	856
213	857
213	93
213	858
213	88
213	90
213	859
213	92
213	860
213	861
213	862
213	23
214	203
214	636
214	199
214	634
214	201
214	863
214	4
214	639
214	213
214	640
214	69
214	642
215	88
215	89
215	90
215	4
215	23
215	93
216	9
216	8
216	36
216	12
216	13
216	4
216	233
216	15
216	44
216	16
216	386
216	17
216	301
216	302
216	18
216	235
216	21
216	22
216	37
216	50
216	23
216	24
217	4
217	16
217	22
217	546
217	256
217	539
217	39
217	536
217	162
217	116
217	297
217	114
217	122
217	293
217	294
217	864
218	26
218	59
218	30
218	4
218	452
218	32
218	455
218	456
218	534
219	634
219	201
219	812
219	4
219	213
219	69
219	203
219	865
219	866
219	867
219	640
219	642
219	868
220	26
220	82
220	59
220	83
220	404
220	4
220	869
220	870
220	398
220	102
220	871
220	872
220	873
220	32
220	874
220	231
220	875
220	156
220	876
221	26
221	59
221	877
221	32
221	4
221	496
221	878
221	501
221	497
221	498
222	26
222	734
222	735
222	59
222	170
222	32
222	175
222	176
222	4
222	177
222	879
222	174
222	178
222	733
223	344
223	417
223	4
223	114
223	233
223	304
223	290
223	121
223	346
223	293
223	125
223	159
223	880
223	345
223	91
223	881
223	882
223	815
223	41
223	294
223	116
223	18
223	117
223	122
223	816
223	126
224	883
224	884
224	885
224	13
224	4
224	886
224	43
224	233
224	887
224	23
224	888
225	889
225	883
225	884
225	13
225	885
225	4
225	886
225	890
225	43
225	233
225	887
225	23
226	1
226	51
226	10
226	11
226	4
226	52
226	10
226	376
226	54
226	18
226	891
226	394
226	414
226	399
226	192
226	53
226	6
226	55
227	4
227	26
227	28
227	331
227	892
227	329
227	130
227	328
227	23
227	88
227	332
227	32
227	29
227	611
227	613
227	612
227	327
228	88
228	90
228	615
228	893
228	4
228	550
228	105
228	23
228	614
228	93
228	894
229	895
229	896
229	201
229	897
229	4
229	179
229	898
229	867
229	899
229	900
229	901
229	69
230	117
230	122
230	902
230	903
230	116
230	124
230	904
230	118
230	4
230	121
230	114
230	239
230	905
230	126
230	433
230	906
231	9
231	91
231	907
231	908
231	36
231	909
231	910
231	13
231	4
231	478
231	233
231	15
231	479
231	18
231	37
231	23
231	292
232	911
232	26
232	59
232	28
232	29
232	31
232	259
232	4
232	261
232	162
232	30
232	34
232	262
232	32
233	201
233	912
233	210
233	4
233	213
233	913
233	69
233	203
233	207
233	130
233	914
233	206
233	562
233	207
233	208
234	4
234	16
234	22
234	546
234	256
234	231
234	18
234	10
234	11
234	255
234	23
234	254
234	41
235	361
235	22
235	43
235	360
235	23
235	25
236	228
236	229
236	915
236	916
236	4
236	231
236	224
236	43
236	54
236	226
237	8
237	253
237	254
237	4
237	917
237	43
237	16
237	546
237	256
237	231
237	918
237	22
237	23
237	257
238	88
238	89
238	90
238	855
238	4
238	861
238	550
238	23
238	551
238	93
239	361
239	22
239	43
239	360
239	23
239	25
240	26
240	398
240	102
240	82
240	59
240	404
240	4
240	32
240	874
240	156
241	339
241	36
241	13
241	4
241	22
241	532
241	43
241	16
241	386
241	23
241	17
241	188
242	102
242	772
242	59
242	773
242	689
242	32
242	4
242	455
242	691
242	692
243	88
243	90
243	92
243	4
243	285
243	23
243	614
243	798
244	8
244	189
244	12
244	4
244	919
244	23
244	195
245	88
245	89
245	90
245	92
245	4
245	23
245	93
246	4
246	26
246	455
246	767
246	920
246	32
246	691
246	692
246	59
246	921
246	102
246	773
246	772
246	779
246	922
246	923
246	689
246	547
246	924
247	26
247	348
247	102
247	62
247	59
247	349
247	63
247	65
247	64
247	4
247	32
247	66
248	911
248	59
248	28
248	29
248	31
248	259
248	4
248	261
248	162
248	30
248	34
248	262
248	32
248	661
249	26
249	648
249	28
249	59
249	29
249	170
249	171
249	925
249	4
249	926
249	170
249	173
249	927
249	657
249	32
250	26
250	648
250	649
250	28
250	59
250	29
250	170
250	171
250	4
250	170
250	173
250	657
250	32
250	651
250	928
250	659
251	1
251	548
251	130
251	333
251	4
251	56
251	6
251	54
251	55
251	492
251	336
251	549
252	88
252	89
252	929
252	18
252	91
252	92
252	4
252	233
252	930
252	23
252	93
253	88
253	89
253	90
253	92
253	4
253	23
253	93
253	614
253	798
254	10
254	11
254	253
254	254
254	41
254	4
254	43
254	16
254	546
254	18
254	255
254	256
254	231
254	22
254	23
254	257
255	8
255	273
255	12
255	4
255	22
255	15
255	23
256	26
256	488
256	931
256	932
256	933
256	28
256	4
256	934
256	935
256	936
256	937
256	371
256	938
256	939
257	1
257	153
257	940
257	941
257	248
257	3
257	147
257	4
257	249
257	6
257	54
257	7
257	55
258	144
258	47
258	942
258	41
258	145
258	4
258	43
258	15
258	251
258	22
258	23
259	8
259	20
259	4
259	256
259	22
259	16
259	546
259	832
259	23
260	26
260	454
260	456
260	4
260	455
260	30
260	452
260	943
260	32
260	534
260	871
260	944
260	945
260	102
260	452
260	453
260	59
261	4
261	59
261	29
261	1
261	76
261	394
261	946
261	947
261	389
261	390
261	71
261	72
261	391
261	192
261	399
261	948
261	949
261	71
262	26
262	950
262	82
262	29
262	951
262	952
262	278
262	41
262	4
262	60
262	953
262	954
262	281
262	955
262	956
262	957
262	32
262	958
262	129
262	959
262	61
263	203
263	130
263	201
263	960
263	543
263	961
263	962
263	963
263	4
263	964
263	69
264	26
264	482
264	965
264	966
264	30
264	41
264	967
264	455
264	968
265	643
265	4
265	787
265	224
265	43
265	54
265	226
265	969
265	970
265	971
265	227
265	228
265	972
265	230
265	644
265	231
266	973
266	974
266	975
266	4
266	964
266	976
266	69
266	130
266	899
266	977
266	978
266	638
266	181
266	979
266	980
266	981
266	374
267	8
267	547
267	10
267	11
267	616
267	253
267	254
267	4
267	917
267	43
267	16
267	546
267	18
267	530
267	531
267	255
267	256
267	231
267	918
267	22
267	23
267	257
267	982
268	811
268	200
268	199
268	634
268	201
268	812
268	813
268	4
268	983
268	814
268	69
268	984
268	203
268	637
268	638
268	639
268	558
268	640
268	641
268	985
268	642
269	1
269	2
269	320
269	3
269	148
269	149
269	148
269	4
269	54
269	6
269	319
269	7
269	71
270	4
270	26
270	63
270	64
270	32
270	66
270	59
270	65
271	13
271	4
271	538
271	289
271	288
271	289
271	532
271	233
271	23
272	253
272	254
272	4
272	917
272	43
272	16
272	546
272	256
272	231
272	918
272	22
272	23
272	257
273	88
273	90
273	4
273	23
273	93
274	364
274	343
274	274
274	986
274	4
274	22
274	15
274	43
274	23
274	987
275	59
275	63
275	4
275	54
275	988
275	55
275	989
276	273
276	4
276	22
276	15
276	23
277	88
277	89
277	799
277	617
277	618
277	4
277	23
277	93
277	619
278	88
278	89
278	799
278	4
278	990
278	23
278	93
279	9
279	273
279	36
279	13
279	4
279	22
279	15
279	16
279	37
279	23
279	17
280	18
280	36
280	23
280	301
280	302
281	228
281	229
281	915
281	4
281	231
281	224
281	43
281	54
281	226
282	339
282	357
282	13
282	4
282	43
282	532
282	22
282	15
282	386
282	23
283	4
283	16
283	22
283	546
283	256
283	43
283	253
283	254
283	231
283	257
283	23
283	382
283	991
283	992
283	41
284	26
284	993
284	994
284	995
284	59
284	996
284	29
284	997
284	41
284	4
284	481
284	482
284	130
284	998
284	999
284	1000
284	30
284	32
284	1001
284	1002
285	8
285	10
285	11
285	39
285	40
285	4
285	43
285	15
285	1003
285	18
285	530
285	531
285	1004
285	20
285	48
285	256
285	22
285	1005
285	23
286	547
286	616
286	253
286	254
286	4
286	1006
286	917
286	43
286	918
286	256
286	22
286	1007
286	23
287	18
287	125
287	304
287	1008
287	1009
287	117
287	122
287	293
287	294
287	126
287	116
287	297
287	298
287	4
287	114
287	41
287	1010
287	194
288	4
288	121
288	114
288	295
288	1011
288	126
288	116
288	297
288	817
288	1012
288	39
288	1013
288	18
288	1014
289	104
289	4
289	705
289	54
289	55
289	109
290	9
290	8
290	39
290	12
290	13
290	1015
290	41
290	4
290	626
290	43
290	15
290	16
290	17
290	18
290	274
290	47
290	67
290	22
290	37
290	23
290	627
290	700
291	679
291	643
291	351
291	10
291	11
291	4
291	223
291	224
291	43
291	54
291	228
291	227
291	18
291	229
291	352
291	230
291	644
291	231
291	232
292	26
292	1016
292	59
292	1017
292	1018
292	4
292	1019
292	1020
292	66
292	1021
292	1022
292	1023
292	1024
292	63
292	1025
292	32
292	1026
293	26
293	95
293	59
293	98
293	99
293	4
293	60
293	101
293	1027
293	32
293	875
293	61
293	1028
293	547
293	127
293	1029
293	1030
293	96
293	97
293	58
293	29
293	128
293	57
293	102
293	871
293	63
293	129
293	924
293	1031
294	144
294	145
294	22
294	15
294	23
295	23
295	22
295	256
295	832
295	1032
296	88
296	89
296	90
296	92
296	4
296	23
296	93
297	26
297	59
297	63
297	1033
297	4
297	32
297	1034
297	66
298	26
298	398
298	59
298	82
298	83
298	400
298	41
298	4
298	32
298	874
298	156
298	869
299	26
299	348
299	62
299	59
299	63
299	65
299	64
299	41
299	4
299	32
299	66
299	281
300	1035
300	4
300	114
300	1036
300	238
300	116
300	239
300	117
300	118
300	121
300	122
300	124
300	126
300	433
301	4
301	367
301	231
301	54
301	370
302	351
302	10
302	11
302	222
302	4
302	224
302	43
302	54
302	225
302	226
302	228
302	227
302	18
302	229
302	230
302	231
303	791
303	742
303	743
303	198
303	200
303	199
303	59
303	201
303	29
303	4
303	136
303	793
303	739
303	69
303	1037
303	1038
303	746
303	133
303	129
303	1039
303	748
303	1040
304	4
304	26
304	455
304	767
304	768
304	59
304	32
304	689
304	102
304	773
304	772
305	1041
305	26
305	1042
305	59
305	1043
305	1044
305	4
305	136
305	130
305	1045
305	491
305	32
305	174
305	1046
305	28
305	29
305	41
305	134
305	1047
305	1048
305	1049
305	93
305	549
305	1050
305	1051
305	1052
305	998
305	102
305	1000
305	1053
306	88
306	90
306	4
306	550
306	23
306	551
307	1054
307	10
307	11
307	39
307	253
307	254
307	41
307	4
307	43
307	44
307	1055
307	18
307	530
307	531
307	20
307	217
307	256
307	22
307	50
307	49
307	23
307	982
308	117
308	122
308	1056
308	1057
308	4
308	121
308	114
308	295
308	1058
308	126
308	162
309	18
309	10
309	11
309	255
309	1059
309	4
309	22
309	49
309	179
309	20
309	257
309	23
309	254
309	41
309	1060
309	1061
309	8
310	1062
310	1063
310	295
310	1064
310	4
310	1065
310	114
310	1066
310	421
310	69
310	117
310	395
310	121
310	122
310	70
310	1067
310	695
310	604
310	126
310	1068
310	1069
311	1
311	488
311	1070
311	10
311	11
311	39
311	1071
311	893
311	1072
311	4
311	1073
311	1074
311	1075
311	1076
311	1077
311	1078
311	18
311	1079
311	1080
311	530
311	531
311	6
311	22
311	23
311	1081
311	1082
312	1083
312	1084
312	1085
312	1086
312	133
312	134
312	1087
312	1088
312	1089
312	1090
313	547
313	679
313	10
313	11
313	4
313	1091
313	43
313	224
313	54
313	226
313	1092
313	227
313	18
313	229
313	230
313	644
313	277
313	231
313	1093
313	645
314	180
314	1094
314	1095
314	1096
314	133
314	1097
314	136
314	93
314	1098
315	348
315	62
315	59
315	63
315	65
315	4
315	32
315	66
316	1
316	26
316	1099
316	331
316	59
316	28
316	357
316	29
316	506
316	41
316	4
316	15
316	507
316	47
316	1100
316	15
316	358
316	359
316	177
316	1101
316	22
316	23
316	237
317	102
317	772
317	773
317	689
317	32
317	4
317	455
317	691
317	692
318	327
318	1102
318	1103
318	1104
318	1105
318	29
318	130
318	102
318	611
318	779
318	328
318	329
318	32
318	613
318	326
318	1106
319	26
319	59
319	29
319	910
319	4
319	478
319	479
319	1107
319	1108
319	703
319	733
319	1109
319	1050
319	102
319	1110
319	1111
319	1112
319	32
319	177
319	174
319	658
320	203
320	636
320	634
320	201
320	638
320	558
320	640
320	641
320	642
320	69
321	1
321	51
321	10
321	11
321	41
321	4
321	52
321	1113
321	54
321	10
321	376
321	18
321	230
321	53
321	6
321	55
322	1114
322	1
322	51
322	111
322	59
322	702
322	4
322	663
322	114
322	1115
322	1116
322	115
322	130
322	1117
322	121
322	1118
322	1119
322	125
322	1120
322	1121
322	1122
322	1123
322	1124
322	18
322	117
322	1125
322	1126
322	1127
322	1128
322	1129
322	1130
322	126
323	27
323	1131
323	1132
323	146
323	147
323	148
323	149
323	152
323	150
323	151
323	4
323	54
323	44
323	1133
323	35
323	153
323	1125
323	725
323	155
323	6
323	50
324	8
324	1134
324	59
324	702
324	4
324	299
324	16
324	1135
324	1136
324	1137
324	117
324	425
324	20
324	122
324	256
324	22
324	23
324	1138
324	1139
324	1140
325	4
325	69
325	199
325	1141
325	133
325	136
325	1142
325	1143
325	32
325	29
325	60
325	1144
325	59
325	1145
325	130
325	1052
325	134
326	130
326	102
326	170
326	655
326	657
326	29
326	329
326	1146
326	1147
326	1148
326	32
326	1149
327	634
327	199
327	200
327	201
327	812
327	4
327	213
327	69
327	203
327	636
327	637
327	639
327	640
327	642
328	1
328	51
328	4
328	53
328	54
328	6
328	1113
328	55
329	994
329	996
329	29
329	30
329	32
329	4
330	26
330	767
330	59
330	4
330	691
330	692
330	102
330	772
330	773
330	689
330	32
330	455
330	1150
331	88
331	90
331	615
331	4
331	550
331	23
331	614
331	93
332	26
332	348
332	102
332	62
332	59
332	349
332	63
332	65
332	4
332	32
332	1151
332	66
333	345
333	111
333	1152
333	417
333	815
333	4
333	114
333	1153
333	294
333	115
333	116
333	18
333	117
333	121
333	122
333	346
333	297
333	539
333	1154
333	293
333	125
333	126
334	26
334	1155
334	59
334	689
334	1156
334	830
334	32
334	4
334	455
334	691
335	10
335	11
335	1157
335	4
335	223
335	54
335	224
335	225
335	226
335	227
335	18
335	229
335	228
335	230
335	231
335	232
336	26
336	459
336	96
336	97
336	98
336	99
336	59
336	29
336	4
336	60
336	101
336	102
336	461
336	63
336	429
336	32
336	1158
336	61
337	1159
337	59
337	4
337	66
337	1160
337	819
337	820
337	102
337	349
337	1161
337	63
337	818
337	329
337	573
337	32
338	10
338	11
338	253
338	254
338	41
338	4
338	43
338	18
338	255
338	231
338	256
338	22
338	23
338	257
339	1
339	2
339	3
339	148
339	149
339	4
339	6
339	54
339	7
340	59
340	4
340	32
340	1162
340	1163
340	156
340	158
340	66
341	27
341	35
341	146
341	54
341	155
341	723
341	41
341	507
342	50
342	44
342	233
342	4
342	13
342	37
342	9
342	234
342	23
342	36
342	188
342	292
342	15
343	4
343	43
343	15
343	16
343	239
343	117
343	118
343	122
343	274
343	124
343	240
343	22
343	23
344	348
344	26
344	62
344	59
344	63
344	65
344	64
344	4
344	32
344	66
345	8
345	273
345	39
345	12
345	4
345	22
345	15
345	16
345	23
345	17
346	1164
346	20
346	48
346	474
346	4
346	43
346	15
346	22
346	23
346	844
347	102
347	772
347	773
347	32
347	4
347	455
347	921
348	88
348	90
348	92
348	4
348	21
348	285
348	233
348	23
348	93
348	858
349	398
349	102
349	59
349	404
349	4
349	32
349	874
349	156
350	701
350	121
350	295
350	297
350	4
350	114
350	126
350	116
350	296
351	4
351	233
351	292
351	286
351	117
351	122
351	116
351	124
351	238
351	432
351	126
351	433
351	1165
351	118
351	23
351	8
351	12
351	15
351	114
351	239
352	8
352	273
352	12
352	4
352	22
352	15
352	16
352	23
352	17
353	1166
353	1167
353	39
353	253
353	41
353	4
353	114
353	43
353	832
353	256
353	22
353	49
353	23
354	26
354	469
354	1168
354	39
354	1169
354	59
354	1170
354	1171
354	4
354	1172
354	43
354	54
354	1173
354	370
354	230
354	320
354	102
354	1174
354	349
354	63
354	367
354	50
354	1175
355	12
355	4
355	43
355	15
355	16
355	17
355	239
355	274
355	56
355	240
355	22
355	1176
355	23
356	1083
356	1084
356	664
356	1085
356	133
356	134
356	1177
356	1089
356	1090
357	643
357	222
357	4
357	224
357	43
357	54
357	225
357	226
357	228
357	227
357	229
357	230
357	644
357	231
358	547
358	679
358	221
358	10
358	11
358	4
358	223
358	43
358	224
358	54
358	226
358	228
358	227
358	18
358	229
358	352
358	230
358	277
358	231
358	680
358	645
359	488
359	1178
359	1179
359	1180
359	1181
359	4
359	1182
359	233
359	934
359	1183
359	935
359	1184
359	1185
359	937
359	1186
359	1187
359	49
359	23
359	1188
359	1189
359	1190
360	142
360	27
360	1191
360	662
360	134
360	663
360	136
360	93
360	130
360	664
360	328
360	133
360	1192
360	1193
361	1194
361	4
361	1195
361	43
361	54
361	1196
361	970
361	370
361	130
361	329
361	367
361	1197
361	1198
362	26
362	1199
362	459
362	96
362	97
362	59
362	98
362	99
362	29
362	100
362	41
362	4
362	60
362	101
362	281
362	102
362	282
362	461
362	63
362	429
362	32
362	61
363	1200
363	39
363	1201
363	148
363	149
363	4
363	43
363	15
363	54
363	16
363	319
363	17
363	1202
363	189
363	46
363	1203
363	22
363	324
364	26
364	1204
364	59
364	4
364	691
364	692
364	770
364	1205
364	102
364	772
364	773
364	689
364	32
364	455
365	26
365	1206
365	1207
365	1208
365	1209
365	1210
365	1211
366	8
366	18
366	239
366	12
366	274
366	4
366	240
366	43
366	15
366	22
366	23
366	1212
367	18
367	91
367	287
367	13
367	288
367	289
367	4
367	290
367	23
367	291
368	9
368	13
368	4
368	22
368	37
368	23
368	25
369	187
369	59
369	241
369	32
369	4
370	4
370	16
370	22
370	17
370	12
370	43
370	15
370	48
370	844
370	23
370	8
370	474
371	26
371	1213
371	615
371	331
371	111
371	28
371	4
371	551
371	93
371	88
371	18
371	90
371	1214
371	550
371	332
371	23
371	614
371	1215
372	540
372	1216
372	805
372	543
372	4
372	806
372	213
372	1217
372	69
372	203
372	1218
372	1219
372	1220
372	807
373	18
373	91
373	88
373	1221
373	4
373	23
373	861
373	855
373	550
373	614
373	615
373	1222
373	551
373	292
373	41
373	233
373	93
374	23
374	22
374	256
374	254
374	43
374	253
374	1054
374	39
374	4
374	20
374	41
374	18
375	26
375	348
375	62
375	59
375	63
375	1223
375	64
375	65
375	4
375	32
375	1151
375	66
376	1224
376	1225
376	4
376	391
376	946
376	1226
376	1227
376	393
376	337
376	1228
376	1229
376	71
376	72
376	387
376	1230
376	1231
376	389
376	1232
376	1233
376	1234
376	1235
376	18
376	1236
376	394
376	1237
376	192
377	88
377	18
377	91
377	615
377	1238
377	4
377	861
377	23
377	614
377	93
378	26
378	94
378	459
378	95
378	96
378	97
378	59
378	98
378	99
378	29
378	1239
378	100
378	4
378	60
378	101
378	871
378	102
378	63
378	32
378	61
378	1240
379	117
379	122
379	1241
379	4
379	121
379	1242
379	18
379	125
379	1243
379	126
379	695
379	354
379	1244
379	1245
379	1246
380	26
380	59
380	451
380	452
380	453
380	4
380	454
380	1247
380	102
380	30
380	452
380	32
380	455
380	456
380	473
381	547
381	1084
381	664
381	1085
381	41
381	133
381	134
381	1087
381	1090
382	18
382	10
382	11
382	1248
382	1249
382	1250
382	4
382	231
382	367
382	41
383	488
383	1251
383	1252
383	39
383	1253
383	4
383	976
383	1254
383	69
383	1255
383	130
383	217
383	374
384	757
384	200
384	4
384	1256
384	69
384	1257
384	311
384	541
384	1258
384	638
384	1259
384	133
384	1260
384	1261
384	1262
384	707
384	1263
384	706
384	1264
385	88
385	90
385	4
385	550
385	23
385	551
386	239
386	274
386	240
386	43
386	15
386	22
386	23
387	54
387	55
387	823
388	8
388	381
388	12
388	4
388	136
388	17
388	970
388	1265
388	67
388	1266
388	37
388	237
388	1267
388	9
388	91
388	36
388	39
388	13
388	15
388	16
388	1268
388	301
388	302
388	18
388	1269
388	102
388	1270
388	1271
388	779
388	133
388	22
388	1272
388	23
389	1273
389	130
389	131
389	134
389	133
389	1097
389	136
389	137
389	34
389	138
389	93
390	9
390	547
390	36
390	200
390	638
390	13
390	4
390	21
390	37
390	1274
390	23
391	27
391	146
391	147
391	148
391	149
391	523
391	4
391	151
391	264
391	54
391	265
391	266
391	1275
391	1276
391	268
391	35
391	1277
391	269
391	270
391	1278
391	1279
391	231
391	1280
391	600
392	9
392	381
392	382
392	36
392	91
392	383
392	13
392	4
392	385
392	233
392	93
392	301
392	302
392	18
392	286
392	271
392	37
392	23
392	272
392	292
393	26
393	127
393	96
393	97
393	58
393	95
393	98
393	99
393	59
393	29
393	4
393	60
393	101
393	128
393	102
393	57
393	1281
393	63
393	32
393	129
393	61
394	26
394	463
394	28
394	82
394	59
394	29
394	464
394	1282
394	4
394	1283
394	554
394	336
394	102
394	32
394	174
395	1284
395	1285
395	1286
395	1084
395	4
395	134
395	133
396	4
396	26
396	455
396	767
396	920
396	32
396	102
396	773
396	772
396	921
396	59
397	1083
397	1084
397	664
397	1085
397	134
397	1287
397	133
397	1177
397	24
397	1288
397	1090
398	1289
398	522
398	516
398	517
398	528
398	13
398	4
398	54
398	16
398	49
399	228
399	229
399	915
399	4
399	231
399	224
399	43
399	54
400	388
400	488
400	1290
400	1291
400	1292
400	4
400	663
400	934
400	1255
400	88
400	1080
400	1293
400	1294
400	1295
400	1296
400	1297
400	23
400	1298
400	1188
401	88
401	89
401	90
401	4
401	23
401	1299
401	614
401	93
402	88
402	615
402	4
402	285
402	23
402	614
403	88
403	89
403	90
403	92
403	4
403	285
403	23
403	93
404	203
404	1300
404	1301
404	1302
404	201
404	1303
404	4
404	1304
404	1305
404	899
404	900
404	69
405	1306
405	8
405	1307
405	1070
405	4
405	1308
405	16
405	546
405	44
405	1074
405	1309
405	56
405	22
405	1310
405	50
405	23
405	700
405	25
405	1215
406	26
406	388
406	547
406	1311
406	82
406	59
406	83
406	404
406	29
406	405
406	41
406	4
406	1312
406	408
406	44
406	1313
406	102
406	1314
406	32
406	1315
406	156
406	924
406	1316
407	4
407	16
407	49
407	596
407	723
407	147
407	720
407	1317
407	722
407	54
407	155
407	18
407	10
407	11
407	377
407	11
407	27
407	35
407	146
407	41
407	230
407	1318
407	50
407	44
408	1319
408	26
408	1320
408	134
408	135
408	136
408	137
408	138
408	130
408	131
408	683
408	684
408	133
409	1321
409	851
409	1322
409	133
409	134
409	93
409	1323
410	382
410	991
410	39
410	1324
410	992
410	41
410	4
410	474
410	43
410	15
410	224
410	16
410	386
410	17
410	844
410	20
410	47
410	48
410	22
410	23
410	627
411	88
411	90
411	799
411	4
411	23
412	26
412	648
412	649
412	27
412	650
412	28
412	59
412	29
412	146
412	170
412	171
412	4
412	704
412	35
412	336
412	1325
412	871
412	657
412	32
412	177
412	651
412	658
412	659
412	1326
413	199
413	201
413	210
413	4
413	212
413	213
413	215
413	69
413	203
413	207
413	206
413	218
413	207
413	208
413	219
414	10
414	11
414	253
414	254
414	4
414	917
414	43
414	1327
414	18
414	181
414	255
414	231
414	918
414	22
414	23
414	1328
414	257
415	1
415	39
415	1329
415	333
415	4
415	54
415	336
415	1330
415	6
415	334
415	55
415	492
415	71
416	1331
416	361
416	4
416	22
416	43
416	360
416	23
416	25
417	229
417	228
417	915
417	4
417	231
417	43
417	224
417	54
418	26
418	63
418	1033
418	1034
418	1332
418	4
418	59
418	1333
418	32
418	66
418	102
418	349
418	1334
418	1335
419	144
419	250
419	22
419	15
419	43
419	251
419	23
419	71
420	8
420	39
420	12
420	4
420	626
420	114
420	15
420	16
420	17
420	116
420	119
420	22
420	23
420	627
421	239
421	274
421	240
421	43
421	15
421	22
421	23
422	26
422	57
422	95
422	58
422	59
422	29
422	4
422	32
422	60
422	101
422	61
423	253
423	254
423	4
423	256
423	231
423	22
423	43
423	16
423	546
423	23
423	257
424	26
424	1
424	1336
424	28
424	29
424	147
424	4
424	7
424	1337
424	153
424	3
424	32
424	249
424	1338
424	6
424	1339
424	1340
425	26
425	28
425	59
425	201
425	29
425	1341
425	4
425	1342
425	1343
425	739
425	69
425	203
425	130
425	740
425	741
425	742
425	743
425	1038
425	745
425	1344
426	1166
426	39
426	253
426	41
426	256
426	43
426	22
426	832
426	23
427	26
427	1155
427	767
427	59
427	1345
427	1156
427	41
427	4
427	691
427	1346
427	102
427	1000
427	1347
427	773
427	1348
427	689
427	830
427	32
427	455
427	1349
428	88
428	89
428	9
428	90
428	13
428	4
428	550
428	37
428	23
428	551
428	93
429	26
429	1023
429	1024
429	59
429	63
429	1025
429	4
429	32
429	1019
429	66
430	88
430	90
430	1350
430	4
430	550
430	23
430	551
430	93
431	198
431	200
431	199
431	1351
431	201
431	4
431	179
431	1352
431	213
431	34
431	605
431	1353
431	69
431	203
431	204
431	130
431	1354
431	1355
431	603
432	388
432	948
432	1356
432	4
432	1357
432	947
432	391
432	213
432	946
432	780
432	393
432	399
432	781
432	50
432	1229
432	71
432	72
432	949
432	387
432	1358
432	389
432	390
432	18
432	394
432	1359
432	192
433	200
433	199
433	634
433	201
433	812
433	4
433	213
433	69
433	203
433	636
433	637
433	640
433	642
434	253
434	254
434	4
434	1006
434	256
434	918
434	917
434	22
434	43
434	16
434	546
434	23
435	1
435	2
435	230
435	320
435	3
435	4
435	6
435	7
436	26
436	734
436	735
436	28
436	59
436	175
436	176
436	4
436	879
436	1360
436	733
436	1361
436	180
436	1362
436	1363
436	170
436	32
436	177
436	174
436	178
436	180
436	176
436	1364
436	1365
436	738
437	540
437	200
437	542
437	543
437	847
437	41
437	4
437	69
437	203
437	1366
437	541
437	1367
437	1368
437	544
437	558
437	1369
438	10
438	11
438	39
438	727
438	4
438	179
438	43
438	338
438	18
438	1370
438	339
438	425
438	377
438	11
438	22
438	23
438	340
438	731
439	1371
439	344
439	345
439	41
439	4
439	114
439	233
439	290
439	116
439	121
439	346
439	1372
439	23
439	126
440	26
440	1373
440	1374
440	1333
440	1375
440	59
440	63
440	1033
440	4
440	32
440	1034
440	66
441	26
441	57
441	95
441	59
441	63
441	29
441	4
441	60
441	32
441	101
441	61
442	8
442	488
442	1376
442	10
442	11
442	4
442	1377
442	114
442	934
442	16
442	546
442	832
442	116
442	1077
442	18
442	530
442	531
442	121
442	1378
442	1379
442	1294
442	256
442	22
442	23
442	1380
443	26
443	1333
443	102
443	59
443	349
443	63
443	4
443	1033
443	32
443	1334
443	1034
443	66
444	203
444	201
444	4
444	213
444	1381
444	205
444	206
444	207
444	208
444	219
444	202
444	69
444	1382
444	1383
445	1319
445	26
445	258
445	132
445	28
445	4
445	134
445	260
445	136
445	137
445	138
445	130
445	131
445	133
445	141
446	50
446	107
446	1384
446	130
446	133
446	549
446	134
446	136
446	1385
446	1386
446	41
446	1000
446	1387
447	883
447	13
447	4
447	886
447	43
447	233
447	1388
447	889
447	884
447	885
447	890
447	887
447	1389
447	23
448	547
448	679
448	221
448	10
448	11
448	351
448	41
448	4
448	223
448	224
448	43
448	54
448	1390
448	1391
448	227
448	18
448	229
448	352
448	230
448	277
448	231
448	232
448	645
449	26
449	382
449	1392
449	679
449	10
449	11
449	4
449	224
449	43
449	54
449	1393
449	18
449	229
449	228
449	30
449	452
449	231
449	455
449	456
449	1394
449	645
450	88
450	92
450	4
450	285
450	233
450	23
450	93
450	858
450	614
450	798
450	292
451	26
451	96
451	97
451	82
451	98
451	99
451	59
451	29
451	278
451	60
451	4
451	954
451	1395
451	102
451	63
451	957
451	32
451	958
451	1396
451	61
452	1397
452	39
452	986
452	1015
452	41
452	4
452	43
452	15
452	16
452	17
452	18
452	364
452	274
452	47
452	22
452	23
453	4
453	16
453	22
453	546
453	256
453	121
453	114
453	116
453	297
453	126
453	117
453	122
453	293
453	294
454	88
454	89
454	90
454	4
454	23
454	93
455	547
455	679
455	221
455	351
455	10
455	11
455	4
455	223
455	224
455	43
455	54
455	226
455	228
455	1391
455	227
455	18
455	229
455	352
455	230
455	1398
455	277
455	231
455	232
455	645
456	239
456	274
456	4
456	240
456	22
456	15
456	43
456	23
457	26
457	58
457	95
457	96
457	97
457	59
457	98
457	99
457	29
457	4
457	60
457	101
457	57
457	102
457	63
457	32
457	61
458	26
458	59
458	1399
458	495
458	4
458	496
458	878
458	497
458	498
458	1400
458	32
458	499
458	500
459	102
459	57
459	96
459	97
459	58
459	98
459	99
459	59
459	100
459	29
459	4
459	32
459	60
459	61
460	1401
460	27
460	596
460	146
460	4
460	150
460	35
460	153
460	1402
460	1403
460	6
460	49
460	1404
460	1132
460	10
460	11
460	147
460	152
460	54
460	1405
460	10
460	376
460	16
460	18
460	723
460	1406
460	1125
460	155
461	8
461	1167
461	111
461	59
461	4
461	114
461	1407
461	1408
461	1409
461	115
461	116
461	18
461	117
461	122
461	63
461	1410
461	1411
461	256
461	1412
461	125
461	1413
461	23
461	126
461	1414
462	679
462	10
462	11
462	4
462	223
462	43
462	224
462	54
462	228
462	227
462	18
462	229
462	230
462	644
462	231
462	1093
462	232
463	1070
463	4
463	1308
463	22
463	1310
463	50
463	44
463	23
463	1074
463	25
464	130
464	611
464	29
464	834
464	329
464	328
464	32
464	1415
464	613
464	836
465	62
465	59
465	63
465	65
465	41
465	32
465	4
465	66
465	281
466	26
466	59
466	29
466	4
466	32
466	177
466	1416
466	1417
466	658
466	703
466	1418
467	4
467	16
467	22
467	546
467	256
467	23
467	254
467	18
467	255
468	253
468	254
468	4
468	917
468	43
468	16
468	546
468	256
468	231
468	918
468	22
468	23
468	257
469	26
469	1
469	327
469	59
469	29
469	4
469	1419
469	130
469	330
469	611
469	328
469	329
469	15
469	358
469	359
469	32
469	177
469	613
469	326
470	26
470	94
470	1420
470	95
470	96
470	97
470	59
470	82
470	98
470	99
470	29
470	100
470	4
470	60
470	101
470	102
470	63
470	957
470	32
470	958
470	61
471	27
471	26
471	615
471	29
471	4
471	445
471	35
471	88
471	130
471	330
471	102
471	444
471	611
471	779
471	329
471	328
471	15
471	358
471	359
471	32
471	177
471	613
471	23
471	1421
471	614
472	1422
472	1423
472	1424
472	4
472	133
472	93
472	759
472	1425
473	9
473	8
473	36
473	12
473	13
473	4
473	43
473	16
473	386
473	17
473	339
473	21
473	22
473	37
473	23
473	272
474	26
474	59
474	1017
474	4
474	179
474	1426
474	66
474	1019
474	1021
474	1023
474	1024
474	102
474	349
474	1427
474	63
474	1428
474	1429
474	32
474	1023
474	1430
474	1431
474	1432
474	1433
474	1026
475	1
475	2
475	1434
475	147
475	148
475	149
475	4
475	224
475	54
475	7
475	230
475	320
475	312
475	153
475	248
475	3
475	249
475	1435
475	6
475	313
476	27
476	147
476	148
476	149
476	4
476	151
476	264
476	54
476	265
476	35
476	270
476	231
476	155
476	599
477	93
477	272
477	271
477	23
477	36
477	188
477	41
477	47
478	26
478	59
478	28
478	201
478	29
478	4
478	1343
478	739
478	69
478	203
478	740
478	741
478	742
478	743
478	1038
478	745
479	240
479	22
479	15
479	23
480	102
480	62
480	349
480	59
480	63
480	65
480	32
480	4
480	66
481	8
481	547
481	616
481	253
481	254
481	4
481	917
481	43
481	231
481	918
481	256
481	22
481	23
481	257
482	203
482	740
482	739
482	1436
482	69
482	791
482	742
482	743
482	793
483	144
483	250
483	22
483	15
483	23
484	273
484	4
484	22
484	15
484	196
484	23
485	26
485	1437
485	59
485	29
485	1438
485	4
485	54
485	1439
485	55
485	823
485	336
486	26
486	648
486	649
486	59
486	1440
486	4
486	651
486	652
486	1441
486	1442
486	170
486	655
486	1443
486	329
486	1444
486	800
486	1445
486	32
486	650
486	28
486	29
486	170
486	171
486	607
486	354
486	170
486	173
486	102
486	657
486	1446
486	177
486	651
486	658
487	1447
487	1448
487	1449
487	39
487	1450
487	1451
487	711
487	4
487	1452
487	1453
487	710
487	18
487	1454
487	125
487	1455
487	126
487	707
487	706
487	708
488	111
488	1456
488	4
488	114
488	1457
488	115
488	275
488	120
488	118
488	121
488	1458
488	124
488	165
488	166
488	125
488	112
488	1459
488	116
488	18
488	117
488	119
488	123
488	122
488	1460
488	126
489	615
489	39
489	4
489	934
489	935
489	551
489	93
489	858
489	88
489	90
489	550
489	1461
489	23
489	614
490	4
490	16
490	22
490	17
490	12
490	50
490	44
490	15
490	23
490	364
490	8
490	1462
490	1463
490	1464
490	935
490	1465
491	26
491	101
491	95
491	4
491	59
491	61
491	57
491	63
491	32
491	29
491	60
491	58
492	4
492	16
492	22
492	17
492	12
492	117
492	122
492	124
492	118
492	121
492	114
492	116
492	15
492	119
492	126
492	112
492	1466
492	181
492	355
493	112
493	4
493	113
493	114
493	15
493	116
493	18
493	117
493	119
493	118
493	121
493	122
493	124
493	126
494	29
494	30
494	31
494	32
494	4
495	10
495	11
495	596
495	147
495	4
495	720
495	54
495	16
495	722
495	227
495	18
495	723
495	230
495	1467
495	155
495	49
495	1468
496	1469
496	1470
496	200
496	199
496	201
496	963
496	961
496	4
496	964
496	213
496	1471
496	69
496	203
496	130
496	1472
497	26
497	482
497	481
497	997
497	1473
497	1474
497	1475
497	32
497	29
497	30
497	994
497	871
497	1476
497	1477
497	4
497	28
497	1478
497	733
497	996
498	26
498	39
498	82
498	59
498	1479
498	404
498	29
498	83
498	41
498	4
498	408
498	398
498	102
498	1480
498	872
498	349
498	1481
498	32
498	874
498	156
498	1482
499	26
499	28
499	29
499	30
499	34
499	262
499	31
499	259
499	32
499	4
499	261
499	162
500	274
500	626
500	22
500	15
500	43
500	23
500	627
501	679
501	10
501	11
501	4
501	224
501	43
501	54
501	225
501	226
501	228
501	227
501	18
501	229
501	230
501	231
501	1483
502	4
502	121
502	114
502	295
502	1484
502	126
502	695
502	1065
502	1485
502	1486
502	116
502	39
502	423
503	88
503	615
503	4
503	550
503	23
503	614
503	93
504	26
504	1487
504	59
504	82
504	749
504	1488
504	4
504	1489
504	398
504	399
504	400
504	32
504	337
504	1490
504	50
504	1491
504	405
504	1492
504	678
504	593
504	412
504	413
504	395
504	394
504	192
504	156
504	1493
505	26
505	127
505	94
505	95
505	96
505	97
505	59
505	98
505	99
505	29
505	278
505	60
505	4
505	101
505	1494
505	102
505	63
505	32
505	129
505	61
506	9
506	8
506	12
506	13
506	41
506	4
506	22
506	16
506	37
506	23
506	17
507	729
507	365
507	1495
507	4
507	288
507	289
507	728
507	22
507	233
507	1496
507	290
507	23
507	677
508	26
508	1213
508	469
508	96
508	97
508	59
508	28
508	4
508	66
508	467
508	102
508	1497
508	1498
508	1499
508	32
508	371
508	470
509	851
509	1322
509	133
509	134
509	1287
509	93
509	1288
510	88
510	89
510	142
510	90
510	1500
510	130
510	4
510	133
510	23
510	93
511	4
511	16
511	22
511	17
511	474
511	43
511	15
511	48
511	844
511	23
511	8
511	12
511	20
511	41
511	1501
512	26
512	648
512	28
512	29
512	170
512	171
512	4
512	1502
512	651
512	652
512	927
512	130
512	102
512	170
512	655
512	657
512	329
512	1445
512	32
512	651
512	659
513	1503
513	9
513	8
513	36
513	664
513	12
513	13
513	4
513	50
513	44
513	37
513	23
514	117
514	122
514	417
514	418
514	4
514	121
514	114
514	295
514	296
514	293
514	294
514	116
514	297
514	817
514	41
514	1010
515	547
515	616
515	253
515	254
515	4
515	256
515	231
515	43
515	22
515	23
515	257
516	26
516	650
516	59
516	29
516	834
516	4
516	703
516	657
516	32
516	177
516	651
516	659
516	836
516	658
516	1504
517	1167
517	1505
517	4
517	1377
517	114
517	832
517	116
517	18
517	117
517	121
517	122
517	1506
517	1412
517	164
517	165
517	125
517	126
517	1414
518	26
518	830
518	455
518	1155
518	1507
518	4
518	767
518	1349
518	32
518	691
518	1156
518	1348
518	102
518	773
518	59
518	689
518	41
518	1000
518	1347
519	18
519	10
519	11
519	1248
519	1249
519	1508
519	4
519	16
519	49
519	522
519	1509
519	231
519	367
519	54
519	1510
519	39
520	1511
520	1
520	2
520	1512
520	147
520	148
520	149
520	4
520	54
520	7
520	320
520	153
520	248
520	3
520	1513
520	249
520	6
521	26
521	59
521	689
521	690
521	1514
521	4
521	830
521	32
521	455
521	691
521	692
522	4
522	69
522	199
522	204
522	201
522	605
522	1515
522	179
522	217
522	130
523	259
523	162
523	34
523	262
523	261
523	387
523	1516
523	1517
523	1518
523	134
523	136
523	137
523	132
524	26
524	101
524	95
524	4
524	59
524	61
524	94
524	63
524	60
524	280
524	1519
524	1520
524	32
524	29
524	102
524	96
524	97
524	98
524	99
524	100
525	4
525	13
525	883
525	43
525	233
525	885
525	618
525	1521
525	519
525	23
525	884
525	1522
526	4
526	59
526	32
526	187
526	18
526	125
526	1447
526	126
526	710
526	711
527	12
527	274
527	4
527	626
527	22
527	43
527	15
527	16
527	23
527	627
527	17
528	1
528	190
528	4
528	15
528	54
528	44
528	117
528	20
528	122
528	193
528	124
528	22
528	6
528	50
528	55
528	904
528	492
528	1523
529	91
529	13
529	1524
529	4
529	233
529	43
529	1525
529	290
529	1526
529	18
529	1527
529	399
529	192
529	360
529	71
529	72
529	1528
529	778
530	4
530	69
530	199
530	210
530	200
530	198
530	180
530	560
530	638
530	977
530	980
530	180
530	201
530	207
530	208
530	1529
530	604
530	1530
530	1531
530	219
531	111
531	1152
531	41
531	4
531	535
531	1153
531	114
531	536
531	294
531	115
531	1010
531	116
531	162
531	18
531	117
531	121
531	122
531	297
531	539
531	125
531	293
531	126
532	10
532	11
532	4
532	1091
532	223
532	224
532	43
532	54
532	226
532	228
532	227
532	18
532	229
532	230
532	277
532	644
532	231
532	232
532	1093
533	4
533	26
533	63
533	64
533	59
533	65
533	32
533	66
533	62
533	348
533	1223
534	4
534	59
534	156
534	749
534	26
534	82
534	439
534	440
534	750
534	754
534	756
534	32
534	398
534	751
535	395
535	1067
535	1069
535	1064
535	1532
535	117
535	122
535	293
535	419
535	4
535	121
535	114
535	295
535	1063
535	126
535	695
535	1065
535	1533
536	26
536	82
536	1534
536	59
536	404
536	41
536	4
536	869
536	398
536	102
536	872
536	400
536	1481
536	32
536	874
536	156
537	1
537	1535
537	200
537	59
537	29
537	1536
537	4
537	69
537	311
537	102
537	76
537	779
537	638
537	70
537	1537
537	1538
537	1261
538	1
538	51
538	230
538	320
538	1194
538	4
538	367
538	52
538	6
538	1113
538	54
539	9
539	8
539	10
539	11
539	13
539	4
539	16
539	546
539	529
539	18
539	530
539	531
539	1539
539	67
539	22
539	37
539	23
539	25
540	1540
540	26
540	1541
540	28
540	59
540	29
540	834
540	1542
540	4
540	1416
540	733
540	1543
540	703
540	102
540	170
540	655
540	177
540	1544
540	836
540	658
541	26
541	1333
541	1545
541	59
541	4
541	1033
541	1546
541	66
541	1547
541	63
541	32
541	1548
541	1034
542	27
542	547
542	10
542	11
542	39
542	59
542	146
542	147
542	720
542	4
542	54
542	224
542	722
542	35
542	18
542	723
542	320
542	231
542	155
543	26
543	648
543	649
543	59
543	28
543	29
543	170
543	171
543	4
543	170
543	173
543	703
543	704
543	1549
543	657
543	32
543	651
544	27
544	146
544	147
544	148
544	149
544	4
544	151
544	264
544	54
544	265
544	44
544	266
544	267
544	35
544	270
544	1550
544	1551
544	231
544	155
544	6
544	50
545	4
545	230
545	320
545	1552
545	18
545	10
545	11
545	10
545	376
545	1553
545	1554
545	6
545	1
545	1555
545	54
545	55
545	39
546	26
546	1556
546	973
546	1557
546	1558
546	4
546	136
546	1559
546	130
546	1560
546	683
546	1561
546	108
546	1562
546	374
546	50
546	1563
546	141
546	1564
546	41
546	134
546	44
546	1385
546	1386
546	88
546	18
546	1565
546	684
546	133
546	1566
547	50
547	44
547	233
547	43
547	339
547	340
547	1567
547	23
547	22
547	15
547	343
547	41
548	488
548	1568
548	10
548	11
548	1569
548	1570
548	1571
548	1572
548	1573
548	18
548	88
548	1574
548	530
548	531
548	1575
548	1576
548	1577
548	1578
548	1579
548	918
548	22
548	23
548	1580
549	602
549	1581
549	201
549	1564
549	134
549	1582
549	136
549	605
549	93
549	1583
549	69
549	130
549	684
549	1584
549	71
550	4
550	16
550	22
550	17
550	12
550	23
550	36
550	8
550	13
550	37
550	9
551	1585
551	327
551	1168
551	59
551	63
551	329
551	41
551	4
551	988
551	507
552	88
552	89
552	90
552	855
552	4
552	861
552	23
552	93
553	88
553	89
553	90
553	4
553	23
553	93
554	4
554	59
554	61
554	57
554	26
554	101
554	95
554	32
554	29
554	60
555	643
555	222
555	4
555	43
555	224
555	54
555	225
555	226
555	228
555	229
555	230
555	644
555	231
556	4
556	224
556	43
556	54
556	225
556	226
556	228
556	229
556	230
556	644
556	231
556	1093
556	1483
557	948
557	4
557	947
557	391
557	213
557	1586
557	946
557	780
557	69
557	399
557	1229
557	71
557	72
557	949
557	1587
557	389
557	390
557	1588
557	1589
557	1590
557	1234
557	18
557	1591
557	394
557	192
557	70
557	396
558	540
558	200
558	542
558	4
558	1592
558	213
558	545
558	69
558	203
558	541
558	1593
558	1594
558	1595
558	544
558	558
559	253
559	254
559	4
559	917
559	43
559	16
559	546
559	1596
559	256
559	231
559	918
559	22
559	23
559	257
560	10
560	11
560	253
560	41
560	4
560	1377
560	114
560	43
560	832
560	116
560	18
560	530
560	531
560	121
560	256
560	22
560	23
560	982
560	71
561	1
561	26
561	1597
561	59
561	29
561	1598
561	1599
561	41
561	4
561	15
561	507
561	18
561	102
561	779
561	1600
561	15
561	358
561	359
561	32
561	177
561	237
561	71
562	851
562	1322
562	133
562	134
562	93
563	320
563	59
563	29
563	104
563	4
563	705
563	224
563	54
563	109
563	55
564	1
564	38
564	781
564	1601
564	1530
564	1602
564	1603
564	59
564	29
564	4
564	42
564	43
564	15
564	18
564	20
564	48
564	22
564	23
564	237
565	43
565	253
565	254
565	23
565	22
565	256
565	41
565	20
565	4
566	4
566	59
566	29
566	739
566	1038
566	69
566	201
566	741
566	742
566	743
566	747
566	1604
567	488
567	1187
567	1605
567	1606
567	4
567	26
567	28
567	331
567	237
567	1607
568	198
568	200
568	39
568	1608
568	4
568	213
568	54
568	1609
568	1610
568	130
568	373
568	217
568	1611
568	55
569	117
569	122
569	293
569	294
569	4
569	121
569	114
569	116
569	297
569	18
569	125
569	1153
569	126
569	538
569	115
569	111
569	1152
569	41
569	1010
569	535
570	26
570	348
570	59
570	65
570	4
570	66
570	102
570	62
570	349
570	63
570	64
570	32
570	1151
571	18
571	339
571	425
571	1612
571	10
571	11
571	1613
571	22
571	43
571	10
571	376
571	23
571	1614
572	18
572	229
572	227
572	228
572	679
572	230
572	10
572	11
572	4
572	231
572	224
572	712
572	54
573	199
573	1615
573	201
573	960
573	1616
573	4
573	1617
573	69
573	204
573	130
573	1618
573	977
573	638
573	1619
573	374
573	1620
573	1621
574	126
574	295
574	420
574	134
574	130
574	1622
574	4
574	733
574	1202
574	21
574	1623
575	127
575	26
575	459
575	96
575	97
575	59
575	98
575	99
575	29
575	60
575	4
575	102
575	461
575	1624
575	63
575	32
575	836
575	61
576	203
576	206
576	207
576	562
576	4
576	215
576	200
576	198
576	180
576	560
576	201
577	200
577	39
577	846
577	4
577	1625
577	213
577	69
577	311
577	977
577	217
577	850
577	638
577	70
577	1537
577	1262
577	1261
577	853
577	1263
578	547
578	679
578	221
578	643
578	351
578	10
578	11
578	4
578	223
578	224
578	43
578	54
578	226
578	1391
578	228
578	227
578	18
578	229
578	352
578	230
578	277
578	644
578	231
578	232
579	117
579	122
579	299
579	1486
579	126
579	116
579	433
579	906
579	4
579	59
579	63
579	65
579	114
579	905
579	239
580	199
580	200
580	39
580	201
580	961
580	4
580	963
580	964
580	1626
580	213
580	1471
580	1627
580	69
580	203
580	1628
580	1629
580	1472
581	9
581	381
581	91
581	36
581	13
581	4
581	233
581	136
581	290
581	1268
581	301
581	302
581	18
581	1630
581	133
581	37
581	23
582	88
582	90
582	1518
582	92
582	1631
582	285
582	23
582	93
582	858
582	700
583	229
583	228
583	227
583	352
583	230
583	4
583	223
583	231
583	54
583	224
583	43
583	226
584	4
584	26
584	455
584	770
584	494
584	32
584	102
584	773
584	772
584	59
584	689
585	26
585	1632
585	82
585	59
585	754
585	1633
585	749
585	4
585	751
585	754
585	1634
585	398
585	1635
585	400
585	32
585	754
585	50
585	750
585	754
585	1636
585	44
585	752
585	753
585	102
585	439
585	440
585	156
585	755
585	754
585	756
585	754
585	1637
586	88
586	89
586	18
586	91
586	1238
586	4
586	861
586	1638
586	49
586	23
586	93
587	4
587	121
587	114
587	116
587	832
587	117
587	122
587	124
587	1639
587	238
587	1640
587	233
587	292
587	286
587	126
587	433
587	434
587	15
587	1641
587	39
588	26
588	59
588	4
588	765
588	454
588	871
588	63
588	30
588	452
588	32
588	945
588	456
588	455
588	473
588	944
589	26
589	29
589	1385
589	31
589	4
589	179
589	1476
589	213
589	130
589	102
589	871
589	1642
589	779
589	1643
589	30
589	603
589	684
589	1644
589	32
589	1645
589	1646
590	18
590	125
590	304
590	1647
590	1648
590	117
590	1649
590	1650
590	4
590	121
590	1242
590	1
590	116
590	306
590	134
590	130
590	142
590	126
590	307
590	308
590	115
590	111
590	114
590	1651
590	1652
590	1653
590	1654
590	133
590	328
591	26
591	1
591	1655
591	59
591	29
591	4
591	330
591	1656
591	611
591	1657
591	15
591	358
591	359
591	32
591	177
591	613
591	836
592	27
592	146
592	147
592	148
592	149
592	4
592	151
592	1658
592	264
592	54
592	265
592	35
592	270
592	6
592	155
592	599
592	1659
592	600
593	934
593	893
593	1660
593	488
593	1187
593	1181
593	1186
593	1661
593	1662
593	105
593	106
593	1190
593	618
593	1521
593	519
593	1180
593	937
593	1183
593	935
593	1663
594	1664
594	10
594	11
594	4
594	787
594	223
594	224
594	54
594	226
594	970
594	972
594	228
594	18
594	352
594	230
594	472
594	644
594	277
594	231
594	1665
594	232
595	117
595	122
595	124
595	119
595	116
595	112
595	809
595	118
595	126
595	1666
595	4
595	114
595	15
596	8
596	364
596	12
596	1015
596	4
596	22
596	15
596	233
596	50
596	44
596	23
596	292
597	4
597	23
597	88
597	614
597	1667
597	90
597	143
597	133
597	130
597	142
597	41
597	134
597	136
597	26
597	28
598	389
598	391
598	4
598	392
598	780
598	1668
598	1591
598	395
598	394
598	396
598	604
598	71
598	72
598	71
599	144
599	4
599	145
599	22
599	15
599	196
599	23
600	319
600	1669
600	1670
600	43
600	15
600	189
600	1202
600	321
600	1671
600	1672
600	1203
600	54
600	148
600	149
600	1201
600	18
600	10
600	11
600	10
600	376
600	1673
601	39
601	201
601	1674
601	1675
601	4
601	1676
601	202
601	69
601	1677
601	203
601	130
601	205
601	1678
601	206
601	207
601	208
602	26
602	950
602	82
602	59
602	98
602	99
602	4
602	60
602	955
602	956
602	32
602	959
602	61
602	96
602	97
602	29
602	952
602	278
602	41
602	1679
602	1680
602	281
602	102
602	63
602	957
602	958
602	129
603	1681
603	91
603	883
603	13
603	4
603	886
603	43
603	233
603	1682
603	18
603	1683
603	884
603	885
603	1684
603	23
604	9
604	381
604	91
604	36
604	10
604	11
604	13
604	41
604	4
604	306
604	136
604	1268
604	301
604	302
604	116
604	18
604	133
604	632
604	37
604	125
604	23
605	88
605	89
605	90
605	617
605	92
605	618
605	4
605	23
605	93
605	619
606	883
606	365
606	13
606	4
606	886
606	43
606	233
606	93
606	1682
606	884
606	885
606	1684
606	23
607	200
607	199
607	634
607	201
607	812
607	4
607	213
607	215
607	69
607	203
607	636
607	637
607	1685
607	639
607	558
607	640
607	1686
607	642
608	4
608	16
608	22
608	546
608	256
608	43
608	253
608	254
608	231
608	257
608	23
608	41
609	126
609	307
609	308
609	18
609	125
609	304
609	1647
609	1648
609	816
609	293
609	41
609	122
609	1687
609	24
609	1688
609	1242
609	4
610	4
610	23
610	88
610	133
610	130
610	142
610	134
611	4
611	22
611	43
611	360
611	23
611	25
611	778
612	62
612	59
612	63
612	65
612	32
612	4
612	66
612	247
613	1689
613	4
613	231
613	54
613	55
613	989
614	59
614	394
614	389
614	4
614	391
614	947
614	396
614	1690
614	156
614	71
614	72
614	1234
615	88
615	92
615	4
615	285
615	23
615	93
615	858
616	643
616	351
616	4
616	224
616	43
616	54
616	226
616	228
616	227
616	1391
616	229
616	230
616	277
616	644
616	231
617	26
617	59
617	451
617	452
617	453
617	4
617	454
617	1691
617	102
617	30
617	452
617	32
617	455
617	456
618	88
618	18
618	91
618	615
618	1692
618	4
618	550
618	23
618	614
619	488
619	1187
619	1605
619	1606
619	934
619	1294
619	1693
619	1694
619	452
620	8
620	39
620	12
620	4
620	626
620	22
620	15
620	16
620	23
620	627
620	17
621	144
621	12
621	4
621	145
621	22
621	15
621	16
621	23
621	17
622	26
622	1437
622	1438
622	54
622	1439
622	55
622	823
623	228
623	229
623	915
623	4
623	231
623	224
623	43
623	54
624	88
624	89
624	90
624	4
624	285
624	23
624	614
624	798
624	93
625	339
625	36
625	39
625	1695
625	43
625	23
625	340
625	731
626	26
626	1696
626	1697
626	1698
626	59
626	63
626	32
626	4
626	647
626	66
626	1026
627	1083
627	1699
627	1084
627	1700
627	134
627	133
627	1287
627	1089
627	1288
628	228
628	229
628	230
628	4
628	277
628	231
628	224
628	43
628	54
628	680
628	226
629	88
629	89
629	90
629	617
629	92
629	618
629	4
629	23
629	93
629	619
630	88
630	89
630	90
630	615
630	4
630	550
630	23
630	551
630	93
630	614
631	26
631	1701
631	469
631	1702
631	1703
631	59
631	28
631	4
631	1704
631	101
631	66
631	1705
631	467
631	1706
631	1499
631	32
631	371
631	470
632	434
632	111
632	39
632	435
632	112
632	4
632	114
632	1707
632	1036
632	238
632	115
632	116
632	18
632	432
632	117
632	239
632	118
632	121
632	122
632	124
632	125
632	126
632	1708
632	433
633	26
633	482
633	481
633	1709
633	4
633	28
633	1360
633	32
633	174
633	180
633	176
633	479
633	1710
633	1478
633	733
634	228
634	229
634	915
634	39
634	4
634	231
634	224
634	43
634	54
634	226
635	26
635	767
635	1711
635	94
635	59
635	4
635	691
635	1712
635	102
635	1713
635	772
635	773
635	774
635	689
635	32
635	455
635	924
636	26
636	94
636	1714
636	95
636	59
636	29
636	4
636	60
636	1715
636	101
636	63
636	32
636	1716
636	776
636	61
637	26
637	82
637	59
637	404
637	4
637	1717
637	398
637	102
637	594
637	32
637	1718
637	156
637	157
637	158
638	26
638	650
638	59
638	29
638	4
638	651
638	652
638	170
638	173
638	102
638	170
638	655
638	657
638	1719
638	1720
638	32
638	177
638	651
638	658
639	221
639	222
639	4
639	223
639	224
639	43
639	225
639	227
639	352
639	277
639	644
639	231
639	232
639	547
639	679
639	643
639	10
639	11
639	54
639	226
639	1390
639	1391
639	18
639	229
639	228
639	230
640	4
640	16
640	49
640	20
640	43
640	15
640	48
640	1004
640	18
640	10
640	11
640	1721
640	231
640	1722
640	23
640	22
640	41
640	1723
640	320
641	9
641	8
641	381
641	36
641	91
641	12
641	13
641	4
641	1525
641	16
641	93
641	17
641	301
641	302
641	18
641	271
641	22
641	37
641	23
641	272
641	188
642	8
642	1167
642	111
642	1724
642	41
642	4
642	114
642	832
642	16
642	546
642	115
642	116
642	18
642	1725
642	117
642	121
642	122
642	256
642	1412
642	22
642	125
642	23
642	126
643	9
643	36
643	1726
643	13
643	4
643	68
643	233
643	93
643	271
643	21
643	37
643	23
643	272
644	1167
644	10
644	11
644	253
644	254
644	4
644	43
644	1727
644	116
644	18
644	117
644	530
644	531
644	122
644	255
644	1728
644	231
644	256
644	1412
644	22
644	23
644	257
644	982
645	26
645	1
645	59
645	28
645	29
645	1524
645	4
645	1334
645	1729
645	1730
645	1162
645	1163
645	1731
645	66
645	1732
645	102
645	349
645	1733
645	63
645	32
645	1734
645	6
645	717
645	1735
645	1026
646	27
646	198
646	1736
646	1351
646	200
646	4
646	34
646	605
646	69
646	35
646	1354
646	67
646	1737
646	199
646	201
646	1738
646	13
646	41
646	543
646	1342
646	1353
646	203
646	204
646	1355
646	1739
647	394
647	1740
647	1741
647	4
647	16
647	22
647	17
647	12
647	23
647	36
647	8
648	203
648	1304
648	1300
648	1742
648	1305
648	4
648	69
648	199
648	201
648	899
648	900
648	1303
648	1743
648	899
649	4
649	16
649	22
649	546
649	1307
649	23
649	1074
649	1070
649	1310
649	8
650	27
650	723
650	146
650	1467
650	147
650	4
650	54
650	155
650	722
650	35
651	41
651	4
651	361
651	22
651	43
651	16
651	546
651	360
651	23
651	620
651	25
652	88
652	488
652	4
652	285
652	233
652	1296
652	23
652	858
652	1744
652	292
653	26
653	94
653	95
653	96
653	97
653	98
653	99
653	59
653	29
653	100
653	4
653	60
653	101
653	102
653	63
653	32
653	61
654	26
654	1497
654	1745
654	96
654	97
654	28
654	4
654	44
654	66
654	467
654	102
654	400
654	1746
654	32
654	50
654	371
654	470
655	1032
655	20
655	253
655	41
655	4
655	256
655	43
655	22
655	832
655	23
655	1747
656	144
656	10
656	11
656	41
656	145
656	4
656	114
656	43
656	15
656	139
656	116
656	18
656	119
656	250
656	47
656	251
656	22
656	632
656	23
657	117
657	122
657	1241
657	4
657	121
657	1242
657	18
657	125
657	1243
657	126
657	695
658	26
658	767
658	59
658	1156
658	41
658	4
658	691
658	1748
658	1346
658	871
658	1000
658	1347
658	689
658	32
658	455
658	1349
659	26
659	59
659	41
659	4
659	878
659	496
659	497
659	498
659	503
659	1749
659	1750
659	102
659	1000
659	1751
659	877
659	32
659	501
659	499
660	4
660	16
660	22
660	17
660	273
660	23
660	36
660	15
660	8
660	12
660	21
660	9
661	9
661	8
661	36
661	12
661	13
661	4
661	37
661	23
662	88
662	142
662	39
662	92
662	4
662	1461
662	23
662	93
662	858
662	614
662	798
663	88
663	92
663	4
663	285
663	23
663	614
663	798
663	93
663	858
664	26
664	1752
664	82
664	59
664	750
664	749
664	4
664	751
664	398
664	400
664	32
664	156
664	754
664	756
665	203
665	1753
665	1754
665	201
665	1755
665	1756
665	4
665	213
665	219
665	215
665	69
666	488
666	1296
666	1744
666	858
666	1757
666	23
666	88
666	285
666	4
666	614
666	798
666	292
666	233
667	26
667	994
667	965
667	1758
667	28
667	29
667	912
667	4
667	1759
667	1760
667	1360
667	482
667	1761
667	30
667	32
667	218
668	558
668	559
668	200
668	201
668	895
668	41
668	1762
668	4
668	1763
668	898
668	899
668	900
668	901
668	69
668	1764
668	897
668	867
669	26
669	1333
669	59
669	63
669	1033
669	4
669	32
669	1034
669	66
669	1765
670	1166
670	1766
670	39
670	253
670	41
670	4
670	1377
670	105
670	114
670	43
670	832
670	116
670	256
670	106
670	22
670	23
671	4
671	16
671	22
671	17
671	12
671	93
671	272
671	271
671	13
671	37
671	9
671	18
671	91
671	301
671	302
671	381
671	23
671	8
671	36
671	41
671	26
671	237
671	28
671	15
672	144
672	40
672	942
672	41
672	4
672	145
672	1767
672	15
672	43
672	47
672	22
672	251
672	23
673	26
673	1768
673	82
673	59
673	83
673	404
673	405
673	1488
673	4
673	678
673	408
673	593
673	870
673	398
673	439
673	440
673	102
673	1481
673	1769
673	32
673	874
673	156
674	117
674	122
674	124
674	119
674	118
674	126
674	116
674	112
674	1770
674	71
674	114
674	15
674	4
674	47
675	26
675	59
675	82
675	404
675	552
675	1771
675	405
675	4
675	1772
675	1773
675	553
675	554
675	398
675	102
675	63
675	1774
675	32
675	156
675	158
675	1775
676	4
676	16
676	1776
676	18
676	10
676	11
676	255
676	1777
676	23
676	22
676	256
676	254
676	231
676	257
676	8
676	20
676	547
676	616
676	41
676	1778
677	1779
677	811
677	200
677	199
677	1216
677	201
677	812
677	4
677	813
677	213
677	814
677	1780
677	69
677	203
677	637
677	639
677	640
677	642
678	339
678	36
678	425
678	39
678	43
678	22
678	386
678	23
679	102
679	349
679	62
679	4
679	59
679	63
679	65
679	32
679	66
679	348
679	26
679	64
680	4
680	114
680	233
680	162
680	1781
680	1782
680	1783
680	37
680	345
680	91
680	1784
680	464
680	13
680	41
680	234
680	15
680	16
680	116
680	301
680	302
680	18
680	864
680	1125
680	235
680	1785
680	1786
680	236
680	23
680	126
680	292
681	26
681	57
681	95
681	58
681	59
681	63
681	29
681	4
681	60
681	32
681	101
681	61
682	1787
682	91
682	4
682	285
682	1788
682	93
682	858
682	88
682	1265
682	18
682	90
682	1789
682	92
682	23
682	1790
682	1791
683	9
683	381
683	36
683	91
683	13
683	4
683	233
683	234
683	15
683	16
683	386
683	93
683	301
683	302
683	18
683	271
683	235
683	1728
683	37
683	23
683	272
684	50
684	1792
684	1793
684	18
684	108
684	685
684	41
684	1794
684	1795
684	34
684	1518
684	1796
685	144
685	250
685	47
685	41
685	22
685	15
685	23
686	4
686	223
686	43
686	224
686	970
686	972
686	227
686	1265
686	352
686	277
686	231
686	645
686	547
686	679
686	10
686	11
686	39
686	1797
686	787
686	54
686	226
686	1092
686	18
686	230
686	680
686	353
687	1798
687	855
687	91
687	4
687	551
687	93
687	88
687	89
687	18
687	90
687	861
687	550
687	23
688	112
688	4
688	285
688	93
688	88
688	89
688	90
688	117
688	1799
688	122
688	124
688	861
688	23
688	1800
689	93
689	136
689	1097
689	1096
689	133
689	180
689	1094
689	1801
690	9
690	13
690	41
690	48
690	4
690	474
690	43
690	15
690	22
690	37
690	23
690	844
691	144
691	12
691	4
691	145
691	22
691	15
691	16
691	23
691	17
692	490
692	333
692	4
692	334
692	54
692	55
692	492
693	4
693	54
693	1439
693	55
693	823
694	239
694	274
694	240
694	43
694	15
694	22
694	23
695	228
695	229
695	4
695	231
695	224
695	43
695	54
695	226
696	26
696	459
696	98
696	99
696	59
696	568
696	4
696	60
696	1802
696	101
696	329
696	32
696	1803
696	61
696	96
696	97
696	1804
696	29
696	41
696	569
696	281
696	102
696	461
696	63
696	429
696	1805
696	1806
697	382
697	991
697	10
697	11
697	253
697	254
697	992
697	41
697	4
697	43
697	16
697	546
697	18
697	255
697	256
697	231
697	22
697	23
697	257
698	634
698	199
698	1216
698	200
698	201
698	812
698	1807
698	4
698	213
698	1780
698	69
698	203
698	636
698	637
698	638
698	558
698	640
698	641
698	642
699	643
699	351
699	222
699	4
699	224
699	43
699	54
699	225
699	226
699	228
699	227
699	229
699	230
699	644
699	231
700	295
700	417
700	815
700	13
700	4
700	114
700	294
700	116
700	117
700	121
700	122
700	297
700	419
700	67
700	293
700	1808
700	126
700	298
700	296
700	1809
701	662
701	663
701	1810
701	26
701	4
701	455
701	767
701	1349
701	32
701	691
701	1156
701	1348
701	871
701	1748
701	59
701	689
701	41
701	1000
701	1347
702	1447
702	1485
702	4
702	1065
702	114
702	423
702	1533
702	121
702	1811
702	1119
702	1812
702	1067
702	125
702	1813
702	709
702	1814
702	295
702	41
702	1815
702	424
702	1816
702	1817
702	18
702	117
702	1591
702	395
702	122
702	1818
702	558
702	1819
702	695
702	126
703	602
703	1351
703	1216
703	201
703	1820
703	4
703	34
703	605
703	1821
703	69
703	203
703	130
703	1354
703	1355
703	603
703	604
703	1530
703	1822
704	273
704	117
704	118
704	122
704	4
704	124
704	22
704	15
704	23
705	329
705	1823
705	1824
705	133
705	130
705	1825
705	27
705	35
705	444
705	445
705	134
705	136
705	1826
705	1827
705	18
705	1828
705	1829
705	1830
705	1831
706	26
706	1041
706	1207
706	59
706	29
706	1832
706	4
706	1206
706	1476
706	1049
706	1833
706	1834
706	1051
706	1050
706	102
706	871
706	1835
706	1836
707	26
707	1701
707	59
707	4
707	1837
707	1509
707	101
707	66
707	1705
707	1706
707	1497
707	1498
707	32
707	49
707	1838
707	1839
707	1240
707	469
707	96
707	97
707	522
707	1840
707	1704
707	16
707	102
707	871
707	1841
707	470
708	93
708	272
708	271
708	23
708	36
708	41
708	47
709	540
709	1842
709	1216
709	805
709	543
709	4
709	806
709	213
709	1217
709	69
709	203
709	1219
709	807
710	558
710	559
710	540
710	200
710	1216
710	542
710	847
710	41
710	4
710	213
710	1843
710	1844
710	1845
710	545
710	69
710	203
710	541
710	1367
710	638
710	544
710	558
711	394
711	13
711	4
711	391
711	1589
712	26
712	1213
712	606
712	327
712	331
712	28
712	892
712	29
712	1846
712	4
712	88
712	130
712	1847
712	1848
712	611
712	328
712	329
712	801
712	32
712	332
712	612
712	613
712	326
712	1849
713	4
713	16
713	22
713	17
713	273
713	23
713	36
713	15
713	41
713	47
714	8
714	36
714	12
714	4
714	134
714	15
714	233
714	16
714	44
714	17
714	22
714	49
714	50
714	23
714	1741
714	188
715	39
715	201
715	4
715	179
715	1850
715	1851
715	1852
715	1821
715	69
715	203
715	130
715	587
715	217
715	1853
716	547
716	10
716	11
716	616
716	253
716	254
716	4
716	43
716	16
716	546
716	18
716	530
716	531
716	256
716	231
716	22
716	23
716	257
716	982
717	26
717	8
717	606
717	333
717	1292
717	893
717	4
717	1571
717	609
717	894
717	89
717	90
717	929
717	1080
717	1854
717	617
717	256
717	1638
717	49
717	24
717	91
717	615
717	28
717	1291
717	105
717	1855
717	93
717	858
717	301
717	302
717	1856
717	88
717	18
717	859
717	618
717	612
717	23
717	614
717	798
717	619
718	1857
718	679
718	10
718	11
718	4
718	224
718	54
718	44
718	226
718	228
718	227
718	229
718	18
718	230
718	231
718	50
718	645
719	27
719	10
719	11
719	146
719	147
719	452
719	453
719	4
719	720
719	54
719	722
719	35
719	18
719	723
719	102
719	155
719	1858
720	8
720	1859
720	39
720	10
720	11
720	4
720	43
720	338
720	15
720	16
720	546
720	1860
720	18
720	339
720	425
720	530
720	531
720	1861
720	1862
720	1863
720	256
720	22
720	23
720	1614
721	26
721	82
721	59
721	404
721	83
721	4
721	1864
721	1256
721	1865
721	398
721	102
721	872
721	400
721	32
721	874
721	156
721	1866
721	1867
722	1681
722	91
722	883
722	13
722	4
722	233
722	43
722	18
722	1682
722	884
722	1684
722	885
722	23
722	1868
723	117
723	122
723	417
723	1869
723	4
723	121
723	114
723	116
723	297
723	18
723	125
723	295
723	1870
723	1871
723	1014
723	293
723	294
723	126
723	538
723	1153
723	816
723	115
723	111
723	1872
723	1152
723	535
723	41
723	1010
724	4
724	69
724	199
724	739
724	26
724	28
724	745
724	59
724	29
724	1038
724	203
724	129
724	746
724	748
725	27
725	1873
725	596
725	146
725	147
725	4
725	264
725	54
725	265
725	16
725	1874
725	35
725	1875
725	270
725	1876
725	1877
725	6
725	155
725	49
725	599
725	600
726	354
726	163
726	160
726	165
726	159
726	126
726	164
726	166
726	1674
726	18
726	125
726	1878
726	1879
726	1880
726	4
726	121
726	114
726	116
726	15
726	119
727	9
727	39
727	1881
727	1882
727	13
727	41
727	4
727	1740
727	1883
727	338
727	1884
727	1885
727	395
727	399
727	394
727	192
727	37
727	50
727	1741
727	71
727	72
727	23
727	1886
728	4
728	23
728	88
728	550
728	551
729	1032
729	1887
729	253
729	1888
729	4
729	256
729	43
729	22
729	832
729	23
730	239
730	274
730	4
730	240
730	22
730	43
730	15
730	16
730	23
730	17
731	1319
731	26
731	681
731	132
731	1889
731	134
731	135
731	136
731	137
731	138
731	130
731	131
731	683
731	1890
731	684
731	133
732	1
732	615
732	59
732	29
732	4
732	551
732	93
732	88
732	89
732	90
732	550
732	613
732	23
732	614
733	88
733	89
733	90
733	18
733	91
733	1891
733	4
733	23
733	1299
733	93
733	614
734	26
734	767
734	59
734	4
734	691
734	692
734	770
734	1205
734	102
734	772
734	773
734	689
734	32
734	455
734	1150
735	26
735	1892
735	59
735	183
735	4
735	185
735	481
735	733
735	1361
735	482
735	180
735	1362
735	1363
735	181
735	186
735	32
735	1478
735	182
735	174
735	180
735	176
735	1893
735	28
735	175
735	176
735	1360
735	1709
735	184
735	1894
735	1895
735	180
736	26
736	1204
736	59
736	4
736	691
736	692
736	770
736	102
736	772
736	773
736	32
736	455
736	921
737	488
737	1296
737	1744
737	858
737	23
737	88
737	285
737	4
738	1
738	1896
738	147
738	4
738	7
738	153
738	3
738	32
738	5
738	249
738	1338
738	6
738	174
738	1897
739	1032
739	253
739	4
739	256
739	43
739	22
739	832
739	23
740	1518
740	461
740	29
740	32
740	60
741	1166
741	1032
741	253
741	4
741	256
741	22
741	43
741	934
741	832
741	23
742	18
742	530
742	531
742	10
742	11
742	4
742	22
742	43
742	360
742	23
742	529
742	25
742	778
742	677
743	26
743	820
743	102
743	59
743	349
743	63
743	818
743	1898
743	4
743	32
743	1899
743	66
744	273
744	4
744	22
744	15
744	23
745	4
745	474
745	48
745	22
745	43
745	15
745	16
745	23
745	17
745	844
746	4
746	223
746	224
746	43
746	970
746	972
746	227
746	1265
746	352
746	1900
746	231
746	50
746	645
746	679
746	351
746	10
746	11
746	1797
746	787
746	54
746	93
746	226
746	228
746	18
746	230
746	1901
747	228
747	18
747	229
747	227
747	230
747	679
747	10
747	11
747	4
747	231
747	224
747	54
747	1902
748	9
748	36
748	271
748	13
748	4
748	37
748	23
748	93
748	272
748	188
749	679
749	10
749	11
749	4
749	43
749	224
749	54
749	226
749	228
749	227
749	18
749	229
749	230
749	644
749	231
749	1093
750	9
750	8
750	10
750	11
750	13
750	4
750	16
750	546
750	1903
750	1074
750	1309
750	18
750	530
750	531
750	1904
750	1905
750	22
750	37
750	23
750	620
750	25
751	8
751	12
751	4
751	474
751	43
751	15
751	16
751	17
751	844
751	1906
751	48
751	22
751	23
752	26
752	1
752	59
752	29
752	1907
752	834
752	4
752	1415
752	102
752	330
752	611
752	779
752	328
752	15
752	358
752	359
752	32
752	177
752	613
752	836
753	26
753	1311
753	1908
753	82
753	59
753	1909
753	83
753	29
753	405
753	4
753	408
753	1313
753	32
753	156
753	1316
754	10
754	11
754	39
754	1910
754	41
754	4
754	43
754	233
754	538
754	1903
754	1074
754	18
754	530
754	531
754	675
754	22
754	1911
754	676
754	23
755	348
755	102
755	62
755	349
755	59
755	63
755	65
755	4
755	32
755	66
756	239
756	274
756	1912
756	4
756	240
756	22
756	43
756	15
756	16
756	458
756	23
756	17
757	27
757	35
757	146
757	147
757	723
757	720
757	4
757	722
757	16
757	49
757	20
757	18
757	10
757	11
757	54
757	155
757	230
757	227
757	223
757	221
757	41
757	1913
757	1403
758	8
758	273
758	12
758	4
758	22
758	15
758	16
758	23
758	17
759	1914
759	26
759	28
759	59
759	29
759	170
759	171
759	834
759	1915
759	4
759	1916
759	170
759	173
759	102
759	170
759	655
759	657
759	170
759	1719
759	172
759	32
759	177
759	651
759	836
759	658
760	4
760	121
760	114
760	116
760	15
760	119
760	126
760	112
760	1466
760	181
760	355
760	41
761	130
761	330
761	327
761	329
761	328
762	18
762	10
762	11
762	1248
762	1249
762	4
762	367
762	231
762	54
763	10
763	11
763	4
763	224
763	43
763	54
763	10
763	856
763	857
763	226
763	228
763	227
763	18
763	229
763	230
763	1917
763	644
763	231
763	1093
764	117
764	122
764	421
764	4
764	121
764	114
764	1811
764	423
764	126
764	695
764	1065
764	1485
764	1119
764	424
765	88
765	615
765	4
765	550
765	23
765	551
765	614
765	93
766	4
766	26
766	499
766	495
766	771
766	32
766	498
766	496
766	828
766	59
766	497
766	493
767	88
767	89
767	90
767	142
767	1918
767	130
767	92
767	4
767	133
767	23
767	93
768	18
768	88
768	91
768	443
768	4
768	23
769	8
769	1307
769	1070
769	10
769	11
769	41
769	1308
769	4
769	43
769	1919
769	16
769	546
769	1920
769	18
769	530
769	531
769	1921
769	675
769	22
769	1922
769	23
770	1923
770	1096
770	1924
770	4
770	134
770	136
770	93
770	1265
770	130
770	1925
770	180
770	1926
770	1801
770	133
770	1097
770	1901
771	228
771	229
771	352
771	230
771	351
771	4
771	223
771	231
771	224
771	43
771	54
771	226
772	10
772	11
772	596
772	147
772	41
772	4
772	720
772	721
772	54
772	722
772	16
772	18
772	723
772	155
772	49
773	187
773	59
773	1927
773	1928
773	32
773	1929
773	4
773	478
774	679
774	10
774	11
774	4
774	223
774	43
774	224
774	54
774	226
774	228
774	227
774	18
774	229
774	230
774	644
774	231
774	1093
774	232
774	645
775	200
775	1930
775	1258
775	638
775	850
775	4
775	213
775	1260
775	1261
775	1931
775	853
775	69
776	43
776	15
776	1932
776	844
776	48
776	23
776	22
776	474
776	41
776	4
776	20
777	4
777	121
777	114
777	116
777	832
777	1724
777	126
777	1167
777	1725
777	71
778	1933
778	1159
778	59
778	4
778	66
778	1160
778	820
778	819
778	102
778	349
778	1161
778	63
778	818
778	329
778	573
778	32
778	1934
779	26
779	95
779	58
779	96
779	97
779	59
779	98
779	99
779	29
779	4
779	60
779	101
779	57
779	102
779	63
779	32
779	776
779	61
780	4
780	230
780	320
780	1175
780	18
780	10
780	11
780	10
780	376
780	1935
780	41
780	121
780	1242
780	1
780	1936
780	6
780	314
781	26
781	28
781	59
781	29
781	1146
781	170
781	171
781	1937
781	1938
781	4
781	1939
781	1940
781	170
781	173
781	1941
781	657
781	170
781	172
781	32
781	177
781	178
781	1942
782	159
782	36
782	1518
782	10
782	11
782	41
782	114
782	15
782	160
782	354
782	116
782	18
782	119
782	121
782	47
782	163
782	165
782	632
782	1943
782	23
783	111
783	1456
783	112
783	4
783	114
783	15
783	115
783	116
783	18
783	117
783	118
783	119
783	120
783	121
783	122
783	123
783	124
783	1944
783	125
783	126
783	71
784	27
784	1132
784	596
784	146
784	147
784	1945
784	148
784	149
784	4
784	152
784	150
784	151
784	54
784	16
784	44
784	35
784	153
784	155
784	6
784	49
784	50
785	26
785	1155
785	767
785	59
785	1156
785	4
785	1946
785	691
785	1348
785	689
785	830
785	32
785	455
785	1349
785	1947
786	88
786	1
786	339
786	1194
786	367
786	4
786	54
786	6
786	1571
786	43
786	23
786	1614
787	10
787	11
787	522
787	13
787	4
787	54
787	16
787	513
787	18
787	1289
787	230
787	516
787	528
787	517
787	49
788	547
788	10
788	11
788	616
788	253
788	254
788	4
788	43
788	16
788	1948
788	18
788	1776
788	20
788	255
788	256
788	22
788	49
788	23
789	4
789	16
789	22
789	17
789	12
789	13
789	37
789	9
789	23
789	36
789	8
789	50
789	44
789	233
790	8
790	10
790	11
790	254
790	4
790	15
790	16
790	546
790	1949
790	245
790	18
790	530
790	531
790	1950
790	255
790	256
790	22
790	23
790	982
791	198
791	199
791	200
791	1951
791	59
791	201
791	29
791	4
791	1952
791	69
791	739
791	203
791	740
791	1604
791	1953
792	1503
792	664
792	1954
792	134
792	1955
792	50
792	44
792	136
793	723
793	147
793	720
793	4
793	54
793	155
793	722
794	26
794	767
794	1711
794	662
794	1810
794	4
794	32
794	663
794	455
794	691
795	203
795	207
795	201
795	210
795	561
795	4
795	206
795	218
795	207
795	208
795	215
795	69
796	57
796	58
796	59
796	29
796	4
796	32
796	60
796	61
797	26
797	734
797	735
797	59
797	175
797	176
797	4
797	733
797	1050
797	180
797	1362
797	1363
797	102
797	170
797	32
797	177
797	174
797	178
797	180
797	176
797	180
798	50
798	1358
798	389
798	1533
798	117
798	122
798	1056
798	1956
798	4
798	121
798	114
798	295
798	1058
798	126
798	695
798	1065
798	1069
799	26
799	388
799	1957
799	59
799	82
799	404
799	41
799	4
799	1312
799	44
799	1958
799	102
799	1480
799	874
799	1959
799	156
800	26
800	533
800	452
800	453
800	41
800	4
800	507
800	454
800	102
800	1960
800	30
800	452
800	32
800	456
800	455
800	473
800	1961
801	8
801	382
801	381
801	383
801	91
801	36
801	12
801	41
801	4
801	385
801	15
801	136
801	1268
801	93
801	301
801	302
801	18
801	271
801	47
801	133
801	23
801	1741
801	272
802	1
802	2
802	230
802	320
802	3
802	148
802	149
802	4
802	1962
802	54
802	6
802	7
803	679
803	10
803	11
803	1797
803	4
803	787
803	223
803	43
803	224
803	54
803	226
803	970
803	1092
803	227
803	972
803	1265
803	18
803	352
803	230
803	277
803	231
803	680
804	1963
804	1964
804	4
804	551
804	1965
804	93
804	88
804	90
804	1350
804	1966
804	1967
804	550
804	23
805	93
805	272
805	271
805	4
805	13
805	23
805	36
806	117
806	122
806	116
806	1167
806	1412
806	126
806	1725
806	4
806	121
806	114
806	832
806	1724
807	26
807	1207
807	59
807	29
807	31
807	4
807	1206
807	30
807	32
807	156
807	1208
807	158
807	1968
808	88
808	89
808	90
808	4
808	23
808	93
809	228
809	229
809	230
809	643
809	4
809	644
809	231
809	43
809	224
809	54
809	226
810	540
810	200
810	1216
810	805
810	543
810	4
810	806
810	213
810	1217
810	69
810	203
810	1219
810	807
811	758
811	1969
811	1321
811	13
811	4
811	134
811	136
811	93
811	759
811	760
811	761
811	67
811	762
812	4
812	233
812	290
812	71
812	72
812	1526
812	1528
812	18
812	1829
812	1970
812	1200
812	1971
812	23
813	9
813	8
813	12
813	13
813	4
813	22
813	16
813	37
813	23
813	17
814	26
814	684
814	683
814	135
814	1972
814	133
814	130
814	138
814	131
814	134
814	1319
814	136
814	1385
814	1386
814	41
815	4
815	16
815	22
815	17
815	12
815	126
815	116
815	433
815	434
815	23
815	8
815	121
815	114
815	239
815	238
816	26
816	471
816	469
816	28
816	59
816	1746
816	4
816	32
816	371
816	66
816	470
816	467
817	88
817	90
817	1973
817	615
817	1921
817	4
817	23
817	1920
817	614
817	93
817	1974
817	1975
818	26
818	62
818	59
818	63
818	64
818	65
818	4
818	32
818	66
819	1
819	488
819	39
819	4
819	1571
819	1976
819	1977
819	88
819	1978
819	1605
819	6
819	1187
819	23
820	615
820	893
820	4
820	105
820	934
820	935
820	551
820	858
820	894
820	88
820	90
820	1461
820	550
820	23
820	614
821	26
821	127
821	94
821	59
821	29
821	4
821	60
821	101
821	461
821	429
821	32
821	129
821	61
822	203
822	207
822	130
822	201
822	4
822	213
822	206
822	562
822	207
822	208
822	69
823	26
823	102
823	1979
823	59
823	187
823	1980
823	1927
823	4
823	32
823	1981
823	246
824	8
824	39
824	12
824	1015
824	4
824	1671
824	15
824	319
824	1982
824	1983
824	364
824	1984
824	22
824	1985
824	23
824	1986
824	71
824	1987
825	203
825	540
825	1219
825	1216
825	217
825	805
825	4
825	806
825	807
825	213
825	1217
825	69
826	26
826	1988
826	1989
826	59
826	28
826	1990
826	4
826	175
826	176
826	1991
826	733
826	1360
826	1050
826	180
826	1362
826	1363
826	102
826	1992
826	170
826	181
826	1993
826	32
826	177
826	174
826	1901
826	178
826	180
826	176
827	111
827	417
827	4
827	114
827	115
827	817
827	121
827	297
827	539
827	125
827	293
827	1870
827	295
827	815
827	41
827	1153
827	1010
827	116
827	18
827	117
827	122
827	1872
827	1013
827	816
827	126
827	296
828	198
828	1351
828	200
828	1216
828	1820
828	1994
828	4
828	179
828	213
828	605
828	1995
828	69
828	130
828	217
828	603
828	604
828	141
828	602
828	201
828	41
828	33
828	203
828	1355
828	1796
828	1996
828	1822
829	26
829	1696
829	1997
829	1998
829	1697
829	39
829	28
829	4
829	179
829	109
829	647
829	66
829	1999
829	1698
829	2000
829	63
829	32
829	2001
829	1026
829	2002
829	140
829	687
830	26
830	102
830	59
830	30
830	452
830	453
830	4
830	452
830	32
830	455
830	456
830	473
830	454
831	1224
831	59
831	2003
831	1225
831	4
831	947
831	391
831	213
831	946
831	780
831	1227
831	1690
831	50
831	71
831	72
831	2004
831	387
831	389
831	1232
831	2005
831	1233
831	1234
831	1235
831	1591
831	394
831	2006
831	192
831	396
831	156
832	547
832	2007
832	2008
832	39
832	1329
832	2009
832	2010
832	4
832	54
832	55
832	492
832	2011
833	88
833	89
833	90
833	18
833	1213
833	91
833	615
833	4
833	550
833	23
833	93
833	614
834	26
834	327
834	29
834	834
834	1846
834	4
834	1415
834	88
834	130
834	102
834	330
834	2012
834	1848
834	611
834	779
834	329
834	328
834	15
834	358
834	359
834	32
834	177
834	613
834	326
834	836
835	198
835	558
835	559
835	200
835	199
835	201
835	180
835	560
835	210
835	41
835	4
835	212
835	69
835	203
835	207
835	206
835	2013
835	218
835	207
835	208
835	219
836	2014
837	2014
838	2014
839	2014
840	2014
841	2014
842	2014
843	2014
844	2014
845	2014
846	2014
847	2014
848	2014
849	2015
850	2015
851	2015
852	2015
853	2015
854	2015
855	2015
856	2015
857	2015
858	2015
859	2015
860	2015
861	2015
862	2015
863	2015
864	2015
865	2015
866	2015
867	2015
868	2015
869	2015
870	2015
871	2016
872	2016
873	2016
874	2016
875	2016
876	2016
877	2016
878	2016
879	2016
880	2016
881	2016
882	2016
883	2016
884	2016
885	2016
886	2016
887	2016
888	2016
889	2016
890	2016
891	2016
892	2017
893	2017
894	2017
895	2017
896	2017
897	2017
898	2018
899	2018
900	2018
901	2018
902	2018
903	2018
904	2018
905	2018
906	2018
907	2018
908	2018
909	2018
910	2018
911	2018
912	2018
913	2018
914	2018
915	2018
916	2018
917	2018
918	2018
919	2018
920	2018
921	2018
922	2018
923	2018
924	2018
925	2018
926	2018
927	2018
928	2018
929	2018
930	2018
931	2018
932	2018
933	2018
934	2018
935	2018
936	2018
937	2018
938	2018
939	2018
940	2018
941	2018
942	2018
943	2018
944	2018
945	2018
946	2019
947	2019
948	2019
949	2019
950	2019
951	2019
952	2019
953	2019
954	2019
955	2019
956	2019
957	2019
958	2019
959	2019
960	2019
961	2019
962	2019
963	2019
964	2019
965	2019
966	2019
967	2019
968	2019
969	2019
970	2019
971	2019
972	2019
973	2019
974	2019
975	2019
976	2019
977	2019
978	2019
979	2019
980	2019
981	2019
982	2019
983	2019
984	2019
985	2019
986	2019
987	2019
988	2019
989	2019
990	2019
991	2019
992	2019
993	2019
994	2019
995	2019
996	2019
997	2020
998	2020
999	2020
1000	2020
1001	2020
1002	2020
1003	2020
1004	2020
1005	2020
1006	2020
1007	2020
1008	2020
1009	2020
1010	2020
1011	2020
1012	2020
1013	2020
1014	2020
1015	2018
1016	2018
1017	2018
1018	2018
1019	2018
1020	2018
1021	2018
1022	2018
1023	2018
1024	2018
1025	2018
1026	2018
1027	2018
1028	2018
1029	2018
1030	2018
1031	2018
1032	2018
1033	2018
1034	2018
1035	2018
1036	2018
1037	2018
1038	2018
1039	2018
1040	2018
1041	2018
1042	2018
1043	2018
1044	2018
1045	2018
1046	2018
1047	2018
1048	2018
1049	2018
1050	2018
1051	2018
1052	2018
1053	2018
1054	2018
1055	2018
1056	2018
1057	2018
1058	2018
1059	2018
1060	2018
1061	2018
1062	2018
1063	2021
1064	2021
1065	2021
1066	2021
1067	2021
1068	2021
1069	2021
1070	2021
1071	2021
1072	2021
1073	2021
1074	2021
1075	2021
1076	2021
1077	2021
1078	2021
1079	2021
1080	2021
1081	2021
1082	2021
1083	2021
1084	2021
1085	2022
1086	2022
1087	2022
1088	2022
1089	2022
1090	2022
1091	2022
1092	2022
1093	2022
1094	2022
1095	2022
1096	2022
1097	2022
1098	2022
1099	2022
1100	2022
1101	2022
1102	2022
1103	2022
1104	2022
1105	2022
1106	2022
1107	2022
1108	2022
1109	2022
1110	2022
1111	2022
1112	2022
1113	2022
1114	2022
1115	2022
1116	2022
1117	2022
1118	2022
1119	2022
1120	2022
1121	2022
1122	2022
1123	2022
1124	2022
1125	2022
1126	2022
1127	2022
1128	2022
1129	2022
1130	2022
1131	2022
1132	2022
1133	2023
1134	2023
1135	2023
1136	2023
1137	2023
1138	2023
1139	2023
1140	2023
1141	2023
1142	2023
1143	2023
1144	2023
1145	2023
1146	2023
1147	2023
1148	2023
\.


--
-- Data for Name: Link_Product-Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Link_Product-Order" (product_id, order_id) FROM stdin;
7	91
834	17
120	754
226	189
542	460
513	477
648	658
587	713
231	757
125	907
619	970
443	141
632	437
154	290
717	188
471	995
676	875
507	193
715	977
815	82
526	927
703	125
498	244
180	408
19	664
83	574
543	816
639	16
325	807
605	801
130	876
646	241
389	475
744	524
786	440
325	58
336	684
453	371
406	226
423	736
750	612
340	351
651	832
155	510
600	553
184	566
661	620
147	314
17	51
783	134
175	966
636	810
120	138
775	904
154	186
497	447
151	965
134	978
347	714
387	382
750	127
431	121
535	399
258	654
475	878
829	266
615	197
81	998
183	561
561	751
126	635
174	67
788	761
311	611
475	159
96	429
566	201
480	237
423	897
410	591
239	48
375	507
779	20
604	270
233	521
779	453
618	947
313	533
488	12
533	658
365	310
242	46
2	46
497	865
415	830
210	698
667	764
363	622
367	804
672	174
671	119
333	270
194	39
146	55
183	97
63	409
796	238
208	606
592	678
518	880
676	60
769	255
720	411
10	742
555	268
508	327
685	272
818	696
745	229
664	183
518	775
262	139
589	38
745	773
12	993
128	142
18	424
7	429
334	89
807	964
652	7
167	923
587	905
564	958
678	906
383	899
223	450
210	617
537	45
374	474
393	969
627	555
681	53
129	746
604	908
148	473
347	651
321	971
749	135
567	881
377	268
746	808
90	91
632	790
594	409
240	573
422	942
641	640
642	78
327	489
567	4
812	150
743	193
815	775
167	821
74	265
38	376
365	176
830	23
168	863
584	629
763	624
389	682
774	826
785	361
71	552
12	15
825	907
8	502
264	73
40	820
246	39
100	921
286	338
7	332
755	632
799	522
348	627
575	405
103	949
277	277
583	394
93	182
497	933
105	617
484	410
438	615
30	160
529	332
25	63
255	587
256	38
273	971
762	364
201	842
576	641
655	445
644	128
607	507
216	151
215	478
439	672
674	704
800	358
557	488
564	363
33	206
317	596
259	96
542	907
786	423
465	876
443	99
366	861
678	258
91	931
728	206
681	181
492	974
652	371
38	914
126	739
602	129
608	854
449	257
735	948
700	599
559	209
801	262
597	594
129	558
237	894
366	828
52	776
101	754
601	482
327	759
653	225
243	966
649	807
88	82
117	310
590	250
802	217
619	645
791	531
375	513
121	18
18	467
80	303
632	935
520	328
780	791
124	934
799	616
656	974
370	218
75	302
490	93
102	129
833	943
83	81
603	428
27	647
357	630
134	187
155	632
441	346
347	721
733	537
358	214
730	813
630	715
337	353
596	249
110	630
778	505
194	353
68	900
632	841
587	428
412	310
360	360
263	851
286	161
527	132
28	178
682	724
607	179
759	744
137	799
125	825
557	180
463	189
544	526
423	610
294	816
125	223
393	808
258	19
62	674
237	551
421	575
653	134
778	32
196	272
637	338
6	492
683	977
551	546
371	722
130	564
25	484
772	925
650	67
433	286
439	642
276	49
807	882
682	966
358	888
373	759
479	890
238	654
228	918
296	724
286	92
454	580
353	288
606	845
740	475
649	856
575	843
534	370
238	385
338	370
148	474
144	70
797	456
322	245
254	654
835	10
41	635
641	235
103	162
543	492
104	223
188	104
591	741
687	154
602	274
821	44
36	976
393	610
34	199
282	730
392	942
81	181
692	396
319	305
774	369
540	541
806	22
741	259
95	989
758	829
601	349
118	800
793	99
587	932
745	940
267	527
339	296
293	112
371	475
19	774
173	9
106	819
248	861
84	177
342	503
393	706
170	214
398	903
166	418
338	184
733	836
59	658
237	191
746	279
755	151
479	671
53	218
717	902
205	945
298	642
129	218
785	802
773	325
274	1
438	144
297	990
434	558
337	751
500	266
652	285
76	796
58	773
36	39
751	742
554	891
687	694
63	36
477	757
401	168
295	361
619	340
521	287
558	737
39	943
317	954
486	615
456	854
82	762
545	132
1	325
823	641
786	367
261	511
123	817
231	529
430	487
258	291
312	856
692	74
691	503
567	610
147	612
274	192
260	335
16	140
226	717
271	73
466	249
645	372
46	126
777	777
628	770
229	357
595	353
519	685
482	114
290	857
492	888
652	816
282	934
815	69
261	155
173	476
737	774
416	894
334	745
430	991
321	393
404	615
289	681
130	924
539	213
533	466
800	339
367	464
404	83
174	788
243	988
725	101
717	453
46	215
409	104
546	328
549	925
721	282
181	140
797	716
337	233
439	716
623	96
339	882
264	27
246	205
825	835
533	579
573	681
130	969
362	509
389	265
445	361
391	604
505	84
163	238
150	473
312	143
143	952
741	820
406	157
401	232
751	406
69	351
387	737
161	386
674	170
50	349
304	758
774	609
183	849
257	73
137	205
767	300
763	364
63	655
254	97
132	165
525	289
574	166
127	476
20	157
710	138
306	949
827	880
64	93
459	473
763	605
100	989
217	23
239	118
590	225
115	405
44	854
436	512
390	483
121	734
171	838
759	534
710	767
610	637
785	542
607	12
350	827
443	263
35	20
46	597
408	445
749	646
60	10
321	759
171	833
376	788
350	939
613	862
261	542
601	75
471	578
748	954
354	89
497	552
58	922
220	109
508	438
55	543
244	396
125	46
658	775
466	890
592	371
9	265
755	152
679	774
752	689
652	548
232	134
256	143
711	798
797	704
758	475
319	833
803	367
94	798
552	446
443	393
190	483
742	902
289	375
336	735
445	976
598	696
205	953
771	534
818	402
78	222
595	212
339	828
431	121
484	677
525	158
555	204
54	53
669	790
174	607
223	154
350	331
129	655
220	707
446	839
820	62
669	718
788	355
20	347
445	332
353	250
483	49
544	965
215	571
243	547
738	245
61	23
245	926
360	134
273	241
136	666
457	157
189	784
241	624
521	441
761	265
318	958
581	36
385	748
297	447
742	122
138	554
511	440
308	263
72	116
314	897
494	480
793	447
483	1
22	864
177	955
617	429
439	164
41	119
168	595
772	569
550	47
301	980
88	724
428	383
552	38
579	273
247	571
388	569
519	14
27	798
652	354
103	988
348	437
333	969
51	689
10	364
233	68
10	350
745	172
220	387
426	214
9	947
364	938
747	61
563	45
19	286
765	688
771	842
43	532
301	606
719	172
354	188
224	141
425	448
543	993
557	154
476	445
321	838
545	651
98	677
462	496
155	466
205	148
562	548
570	586
613	391
549	690
835	663
52	864
185	212
534	902
213	918
77	380
592	529
657	445
496	574
456	211
478	10
455	712
545	781
463	937
379	107
119	199
736	559
820	758
591	357
502	726
693	553
760	563
477	57
144	328
278	244
827	242
62	563
434	880
156	15
539	62
617	193
516	209
580	555
117	92
629	440
781	613
24	446
179	596
67	433
493	658
393	485
462	21
520	362
405	346
250	330
684	832
433	492
436	517
529	740
79	128
370	96
765	104
567	902
782	443
97	711
664	105
761	736
205	61
76	239
620	987
270	626
181	693
238	397
771	312
765	511
204	365
375	325
680	358
803	569
298	741
749	479
140	384
552	74
653	61
823	409
237	315
822	989
803	362
184	270
495	995
763	166
684	981
158	878
353	695
607	352
634	824
726	224
237	859
814	285
101	758
413	883
357	746
804	423
706	405
176	280
483	728
773	379
731	73
244	538
137	994
163	653
546	512
351	784
322	475
334	144
618	229
258	931
806	724
30	336
661	922
576	423
395	516
824	970
692	430
590	863
659	286
612	630
456	847
335	444
357	173
387	869
334	342
337	866
295	989
274	818
714	68
319	825
240	251
443	453
426	936
109	348
659	137
591	368
414	818
162	637
123	338
534	57
80	830
732	931
601	906
756	102
273	474
165	490
668	833
343	874
301	319
246	453
272	577
237	94
288	233
54	203
38	458
123	731
196	915
308	207
38	59
149	308
780	373
183	876
133	679
453	428
570	444
628	938
551	949
122	51
711	936
217	485
716	329
344	6
153	520
825	907
641	50
238	209
69	700
152	711
82	26
304	902
666	510
738	453
592	877
745	795
641	621
330	7
414	696
808	38
728	246
625	295
297	147
558	636
668	365
628	726
133	562
320	530
169	372
255	272
316	975
420	900
682	457
658	863
493	192
170	87
300	462
210	640
220	237
629	309
712	111
486	223
671	190
16	223
56	799
537	263
207	382
446	916
445	202
758	506
219	923
259	949
51	993
499	446
278	551
612	832
98	997
120	80
488	312
276	731
630	554
697	349
620	326
226	618
615	485
19	910
229	585
569	90
705	661
27	784
665	747
800	843
416	293
40	272
191	432
733	562
799	121
800	377
707	75
711	344
274	415
499	554
683	911
779	158
278	89
559	662
402	141
703	908
220	831
218	854
533	907
674	183
336	925
503	172
557	670
93	517
353	470
819	577
230	664
807	721
563	720
328	176
630	556
122	970
10	747
293	199
470	345
378	566
708	75
500	411
50	645
720	269
463	260
308	406
185	583
72	586
682	121
164	292
429	783
628	990
254	166
19	594
303	944
29	957
788	706
494	404
263	690
137	765
789	695
52	978
542	271
461	349
122	853
141	948
757	382
235	691
553	159
272	546
85	972
723	453
394	354
313	727
158	71
386	296
215	536
194	298
350	352
712	624
182	290
234	696
355	944
281	737
776	516
439	355
347	724
518	352
291	133
286	311
194	692
253	544
282	275
64	352
663	68
68	664
248	671
835	564
780	202
821	684
94	530
323	316
686	752
68	88
624	934
232	106
262	227
283	553
733	385
673	9
462	696
301	513
821	974
775	128
154	182
138	340
694	607
258	410
707	720
469	115
306	720
215	164
568	899
458	75
726	306
407	497
212	238
411	283
158	586
421	152
459	339
667	691
728	970
120	725
146	165
403	278
487	214
689	980
84	28
798	183
91	537
766	248
613	861
216	891
90	502
682	337
92	582
376	784
831	519
293	196
159	429
108	254
362	920
43	368
604	804
191	996
740	308
554	908
762	51
592	890
418	569
699	567
523	676
461	959
826	652
140	674
176	149
619	803
121	990
432	921
665	635
517	777
810	947
431	52
402	118
568	973
515	665
356	963
209	478
805	461
804	170
416	868
141	314
523	213
154	188
95	698
742	674
728	846
795	168
173	263
307	587
89	207
227	711
470	67
804	291
11	26
695	131
459	580
202	900
521	961
263	475
783	375
597	478
28	227
247	37
355	666
198	331
361	992
245	384
308	172
105	589
136	563
462	17
133	128
503	917
612	511
350	751
259	697
631	449
504	527
387	677
796	319
73	882
206	717
502	246
289	508
537	131
200	765
462	28
692	419
177	284
244	329
467	697
519	493
803	241
762	669
8	664
319	476
227	69
320	614
749	776
279	337
691	306
188	475
149	82
284	203
161	326
777	913
434	281
473	207
614	542
392	182
812	440
214	203
95	164
398	334
457	171
346	953
485	510
665	841
408	777
371	633
809	916
816	331
387	69
315	662
817	402
313	181
446	100
293	658
310	224
697	763
172	605
713	14
469	349
558	959
694	477
287	600
157	481
303	432
737	226
545	788
713	463
193	126
34	536
833	690
502	739
206	491
310	308
498	846
550	160
72	437
203	367
155	548
82	894
372	73
253	653
166	626
453	691
752	800
251	387
241	741
672	609
537	253
670	290
467	744
449	707
401	813
531	936
385	262
251	194
734	934
399	497
597	847
25	813
470	939
506	318
577	346
247	871
559	389
802	206
528	997
593	928
268	602
815	678
279	326
806	168
702	859
525	267
693	608
431	133
474	230
91	768
733	457
799	854
97	625
162	901
154	131
255	343
615	966
100	919
271	528
121	149
535	649
608	48
42	894
194	610
390	709
354	101
351	697
452	744
200	116
359	695
519	251
88	469
144	400
40	41
174	745
754	188
33	328
144	63
690	495
697	649
485	493
479	109
789	769
584	901
598	467
192	503
216	255
235	187
209	345
717	18
537	523
292	966
277	565
91	197
273	190
483	339
320	938
25	705
792	782
96	234
510	736
570	641
378	226
165	226
781	520
349	442
503	591
642	405
279	749
641	586
278	936
266	53
437	226
156	974
435	89
591	219
492	624
483	536
502	985
312	587
627	759
662	655
639	52
10	745
177	226
758	313
606	365
569	251
804	343
365	687
89	573
142	378
613	165
699	762
404	351
267	988
627	565
780	741
256	63
573	237
39	4
562	605
304	279
129	473
295	466
42	657
412	99
741	15
232	863
108	440
67	251
730	870
287	694
706	701
561	8
48	223
562	53
449	673
51	304
586	691
181	650
188	538
25	290
45	983
112	49
131	348
686	931
574	917
172	524
120	225
381	634
433	203
689	414
284	743
297	39
252	954
8	174
197	227
209	287
40	529
705	685
75	211
651	975
761	943
275	624
619	286
216	791
643	157
156	856
256	152
819	379
676	248
74	622
474	469
669	676
494	415
646	534
370	682
296	799
178	738
206	640
82	604
750	723
591	766
751	851
551	851
684	908
628	490
522	904
429	661
4	492
167	387
694	327
414	64
126	832
797	770
716	855
160	621
330	35
409	749
591	566
629	999
515	921
458	94
429	705
40	159
250	81
54	22
580	44
733	25
345	635
81	388
191	855
194	930
389	381
717	499
495	489
788	270
648	398
246	943
510	825
204	917
420	345
171	928
799	408
193	802
533	356
312	816
825	842
664	305
576	715
785	14
303	742
348	982
92	416
398	478
274	485
780	200
156	599
70	49
594	330
783	825
394	434
263	693
518	262
56	96
524	811
420	509
8	469
526	794
549	997
830	357
728	583
763	70
771	642
565	576
702	168
792	131
708	671
387	790
27	608
5	493
805	978
370	340
229	39
39	236
99	578
81	994
133	441
662	935
83	779
827	704
499	302
135	616
502	370
406	915
237	876
5	651
597	334
158	599
62	320
122	109
58	835
7	139
818	291
696	856
391	629
606	901
434	298
453	784
98	639
635	614
469	820
402	608
798	772
51	366
659	230
592	894
393	670
632	659
42	478
383	295
827	491
580	256
533	368
285	464
423	733
588	524
437	333
721	829
686	153
829	515
267	109
427	782
687	230
448	240
823	107
638	849
821	512
263	299
1	135
130	628
87	568
791	557
376	988
759	696
760	824
413	680
829	976
573	21
774	433
667	420
34	91
155	781
280	33
640	982
27	657
760	959
174	16
474	882
101	837
336	767
568	674
223	339
311	588
817	911
531	63
388	467
412	27
813	680
772	809
713	691
520	961
173	658
401	518
389	826
351	71
708	584
744	945
221	984
814	360
666	849
255	432
43	563
508	256
835	28
765	429
5	709
731	385
429	862
23	8
710	681
68	750
410	187
308	376
796	212
237	421
342	46
177	267
456	90
390	968
452	681
468	936
330	876
487	339
103	138
450	339
226	307
706	534
89	835
647	752
827	921
344	765
156	49
77	509
578	430
633	223
363	538
628	402
622	702
246	588
172	866
114	164
547	211
832	43
458	751
423	164
183	151
588	780
471	923
668	303
429	426
475	597
823	240
298	465
684	126
154	114
647	768
19	92
203	76
662	459
574	598
562	543
156	59
326	959
760	616
81	779
221	595
180	594
453	609
378	105
577	4
667	610
444	461
268	539
426	2
468	433
761	567
801	532
192	253
799	252
595	144
630	866
650	219
97	608
362	565
612	962
624	189
697	701
296	171
471	201
807	490
118	73
812	581
328	689
64	13
575	877
478	629
442	411
578	800
408	67
335	829
162	863
61	747
71	372
201	703
242	246
66	938
704	649
589	293
768	276
134	266
196	986
93	453
201	394
198	289
695	281
383	765
344	101
34	552
499	860
543	498
685	14
529	659
731	60
85	852
302	115
333	652
383	508
137	862
670	616
495	853
402	455
336	362
600	45
459	643
221	527
282	81
335	278
746	735
818	363
258	886
497	50
548	434
331	911
215	335
782	345
269	71
357	101
269	649
734	848
255	424
17	931
725	912
72	45
253	619
663	454
797	91
60	681
627	281
645	201
239	154
356	943
346	328
235	704
177	795
401	537
403	42
461	29
88	126
445	182
734	980
657	17
175	218
236	955
796	681
227	344
250	788
112	366
785	387
444	76
325	42
106	755
721	428
441	745
711	498
199	967
644	967
122	802
48	987
410	250
241	697
698	227
361	8
733	314
155	257
218	296
206	696
186	225
709	47
170	697
180	182
672	310
765	656
291	398
80	483
730	742
134	35
615	995
429	162
268	730
716	594
393	451
44	699
804	763
141	592
638	794
712	74
315	465
209	642
787	80
735	833
810	810
272	642
44	606
101	253
752	941
833	167
818	729
609	486
534	739
551	966
419	180
475	354
723	235
723	311
295	69
112	961
765	121
615	27
788	869
503	703
470	844
486	489
479	395
648	837
162	165
618	487
234	808
615	210
539	294
270	588
507	383
797	697
582	119
825	85
562	814
340	563
679	251
632	105
722	305
663	553
473	426
474	109
256	535
144	570
684	531
161	69
713	175
407	133
236	980
37	458
275	205
808	920
128	617
565	260
503	787
88	575
412	757
404	806
823	371
370	646
550	106
456	873
569	55
597	126
519	725
731	139
179	481
306	879
191	984
125	859
255	770
587	475
462	436
771	534
779	412
555	135
235	467
421	603
429	959
220	456
610	885
568	611
564	829
709	451
800	176
16	790
720	720
621	134
246	800
24	24
357	307
437	787
115	398
369	592
188	460
102	956
697	149
512	336
483	36
452	911
82	946
253	596
588	329
366	815
175	384
664	539
645	572
517	664
638	724
211	629
265	150
750	986
436	153
138	509
363	683
46	56
495	369
273	754
495	871
434	147
704	17
375	11
637	445
742	25
584	330
330	68
374	475
590	869
28	814
494	125
494	164
609	647
140	563
716	575
535	15
693	265
602	433
739	971
143	103
724	476
697	643
544	870
374	47
676	69
627	53
199	866
317	541
499	637
639	660
307	811
347	583
607	75
581	232
778	675
226	211
136	152
674	987
222	673
488	287
579	592
158	120
728	17
797	97
187	329
702	952
84	431
704	698
617	40
466	717
172	850
825	212
184	44
399	176
607	494
618	115
599	635
611	281
325	628
535	585
749	465
501	733
668	161
791	671
223	310
560	255
14	896
633	613
500	447
677	443
4	752
126	504
714	979
746	991
20	999
340	144
482	407
131	881
630	530
688	210
568	744
528	636
458	343
123	397
125	984
468	406
725	233
748	552
403	315
299	864
162	217
132	774
21	8
649	581
261	92
136	555
756	916
266	614
78	391
376	321
788	815
697	141
591	782
335	203
628	402
734	373
378	214
367	329
654	511
462	654
185	436
403	241
288	607
300	783
198	981
220	92
347	481
696	741
343	903
231	790
756	886
312	136
684	989
286	504
596	266
204	604
308	868
90	152
713	798
109	821
615	193
767	927
60	404
650	829
555	831
113	399
659	393
647	21
215	255
662	396
208	943
602	618
317	482
739	94
730	815
407	318
585	980
708	310
54	48
795	196
264	965
63	841
322	28
798	454
239	418
820	778
421	428
230	109
725	485
587	260
602	459
208	615
397	961
501	240
460	493
284	788
596	895
191	354
393	556
259	56
9	446
65	342
91	517
56	457
469	512
258	557
565	11
573	133
303	941
507	825
617	532
695	807
223	908
418	391
143	214
448	338
88	521
639	503
31	71
741	840
369	772
34	262
508	799
358	873
720	619
309	605
138	84
335	254
504	107
15	52
797	215
323	367
161	813
635	12
264	711
419	305
60	110
389	353
414	965
507	203
703	745
585	903
693	311
95	878
491	717
539	285
195	640
347	432
404	204
418	653
120	213
677	437
326	743
497	990
44	660
394	577
830	56
425	421
788	789
62	741
833	440
396	989
549	460
251	789
744	792
627	33
525	247
536	670
317	897
48	571
548	600
480	795
561	830
805	90
253	74
246	736
254	72
15	874
76	839
752	182
630	782
601	316
204	68
432	713
756	141
816	760
188	438
699	285
182	847
777	322
761	365
105	436
747	906
562	533
682	82
601	449
300	402
675	701
155	729
826	401
306	745
309	151
57	805
552	735
403	693
159	630
797	508
103	151
310	941
834	536
737	961
509	93
23	336
557	134
269	320
308	717
163	601
531	906
554	357
383	732
320	426
818	401
1	5
594	476
175	614
459	44
515	652
608	985
250	139
240	859
689	546
450	983
765	56
129	651
688	356
370	441
188	400
368	945
566	149
406	794
778	909
534	868
202	846
362	196
489	542
89	776
632	169
304	940
13	502
585	539
266	148
246	930
545	477
62	221
375	287
606	403
106	47
431	50
296	189
825	266
282	494
398	200
621	303
296	162
406	141
201	829
807	756
71	213
431	729
1	18
626	190
629	566
65	827
558	851
734	345
753	154
321	819
177	962
95	900
404	971
631	750
726	834
601	14
462	623
794	990
735	941
359	618
575	664
282	713
362	334
96	872
758	917
704	332
645	588
147	810
468	207
711	295
568	101
150	208
156	631
167	192
54	68
692	61
442	929
81	902
419	408
718	305
95	278
121	434
503	248
692	787
135	360
465	101
407	570
95	518
127	789
251	438
84	74
20	689
358	359
562	476
251	517
617	324
619	825
427	726
389	278
97	337
345	866
526	503
428	733
18	336
657	603
590	280
407	676
472	605
80	486
558	166
513	844
375	122
753	712
274	939
313	181
573	637
315	182
151	150
493	388
731	723
728	851
774	149
611	494
357	836
176	128
510	675
791	635
115	257
608	390
598	801
514	162
137	663
55	549
270	751
186	964
512	173
162	917
438	810
659	453
802	676
697	399
111	325
424	917
365	354
713	229
675	724
467	633
581	305
386	947
754	132
612	189
512	177
658	484
466	835
216	331
35	296
737	771
394	595
751	990
799	705
376	125
21	829
239	845
670	730
206	168
102	993
301	350
482	445
465	773
488	525
451	82
698	266
645	142
266	542
493	953
384	835
377	185
667	523
789	935
817	90
137	475
125	542
226	276
819	371
335	203
472	443
261	778
24	679
471	546
605	150
38	829
538	193
827	512
655	884
666	660
357	965
669	318
511	944
233	684
379	20
815	679
635	430
320	451
824	634
77	469
85	788
425	621
706	100
340	694
73	684
479	434
440	404
46	494
164	64
469	461
638	245
502	150
64	262
416	911
432	513
526	675
26	169
585	834
274	929
136	157
421	12
213	719
66	425
210	585
280	146
659	372
731	350
449	539
75	881
828	543
435	56
691	732
296	98
431	855
308	561
251	205
593	380
757	763
41	740
608	96
168	186
9	979
503	343
468	218
302	127
603	628
472	909
443	460
63	702
288	152
487	86
798	172
408	961
192	16
452	780
172	442
674	395
502	38
129	520
505	327
394	306
201	122
554	465
283	436
718	664
313	94
784	437
99	841
102	99
486	370
826	304
399	527
714	832
562	677
790	946
733	448
99	344
499	283
240	387
776	461
27	93
60	645
686	297
228	453
527	804
688	763
375	644
27	656
495	324
316	533
304	618
143	383
678	247
223	470
785	63
18	963
624	277
99	100
487	194
199	818
380	463
28	651
545	565
131	723
106	863
215	306
164	581
665	353
456	119
831	101
833	145
626	873
215	948
340	125
439	633
51	629
388	30
493	69
650	64
342	421
375	653
522	887
198	57
748	421
564	836
269	47
358	575
280	810
747	805
385	246
401	37
691	306
285	760
630	984
36	65
407	665
265	985
391	73
511	252
537	930
546	131
81	799
642	617
755	967
201	255
97	549
384	415
238	149
449	365
617	947
305	841
28	433
233	590
431	184
558	743
352	943
174	976
240	798
641	158
696	569
294	312
654	959
3	333
637	402
166	439
822	192
647	89
624	114
431	633
403	487
489	235
601	707
14	531
57	831
333	811
408	156
658	364
362	908
198	323
199	855
76	19
26	416
231	915
626	784
284	65
21	122
699	324
493	567
501	819
550	475
552	576
220	583
219	741
101	950
528	658
76	600
509	111
94	263
15	476
347	693
337	665
346	675
44	60
617	392
185	782
793	39
425	318
342	540
745	196
389	88
177	703
386	438
597	650
821	274
366	384
768	778
405	984
596	191
218	790
468	306
477	127
559	788
219	206
146	595
722	370
619	328
79	176
702	810
449	846
571	653
692	409
124	583
37	424
772	875
216	695
622	531
387	721
371	45
84	343
263	357
179	77
767	40
226	270
101	246
161	128
518	143
222	998
84	208
600	594
311	297
713	516
234	900
762	606
143	133
394	400
28	138
520	860
805	545
535	751
323	625
580	832
286	786
272	388
114	503
402	394
526	649
447	143
470	199
142	258
115	281
5	93
268	310
158	968
782	578
13	480
364	348
389	886
29	443
546	120
130	136
171	916
45	627
584	774
279	663
315	598
274	381
814	122
359	607
289	574
416	839
327	314
746	672
615	851
785	544
364	793
563	229
506	904
232	639
387	795
57	306
562	335
229	623
538	327
381	807
77	458
773	310
274	530
747	864
654	595
366	707
375	655
227	50
832	744
52	8
242	256
350	544
315	88
302	702
585	73
514	590
469	740
359	702
761	457
538	78
214	607
513	882
603	551
670	608
358	553
656	16
141	167
178	762
249	443
223	747
328	841
526	99
264	950
695	94
257	969
607	202
278	61
339	198
486	21
375	426
407	704
801	765
471	698
88	861
118	198
833	385
85	908
732	966
92	166
339	458
102	154
558	678
16	662
833	493
230	66
33	551
118	236
533	227
492	553
332	795
493	495
139	761
597	590
529	61
27	623
499	84
426	747
204	942
32	603
285	589
435	942
369	720
345	972
38	465
220	935
445	654
449	360
152	254
601	156
661	618
787	664
147	69
262	610
510	476
221	398
70	610
673	629
89	386
809	354
230	744
556	926
730	245
597	172
197	62
193	358
727	193
641	992
434	894
542	971
221	719
767	510
157	37
444	194
818	613
589	853
28	404
755	599
363	889
482	145
607	157
144	101
385	917
784	179
75	958
329	746
609	19
810	111
487	559
381	175
558	834
275	55
429	220
392	192
439	541
603	565
630	628
91	601
209	169
147	482
685	759
693	734
489	470
50	623
573	503
640	269
302	204
334	326
411	178
71	113
591	329
640	926
710	506
254	550
282	604
764	533
166	918
349	581
805	679
483	307
118	595
124	486
373	649
834	4
708	560
816	864
424	495
215	979
690	704
399	761
792	614
382	998
444	808
57	448
542	127
511	205
312	384
42	498
607	404
400	50
75	137
510	487
429	82
598	242
387	240
560	380
805	998
396	518
588	512
494	859
515	445
581	383
440	449
560	164
252	960
79	968
138	984
456	635
259	783
270	271
343	589
795	386
317	873
570	457
2	835
380	322
86	839
36	591
382	934
140	580
646	851
542	862
491	44
641	66
363	340
231	663
786	565
358	564
652	481
51	488
87	663
818	926
635	691
681	756
483	176
609	935
706	392
715	443
235	350
765	654
111	11
732	671
513	45
431	495
146	531
521	389
827	875
277	717
265	84
333	63
114	474
829	717
581	590
802	113
174	840
173	485
755	995
624	266
113	559
406	54
691	143
586	371
216	46
85	796
698	492
639	321
9	331
306	696
435	741
751	387
36	785
278	438
777	223
157	445
652	238
716	952
685	503
454	549
415	682
805	818
475	432
147	279
790	356
413	286
17	882
771	335
22	309
252	541
99	298
205	632
702	46
265	582
648	606
246	967
563	733
590	346
340	694
742	270
77	564
824	189
230	40
10	170
365	387
588	876
192	5
265	58
381	937
269	675
156	480
387	641
102	804
387	433
484	214
533	149
601	626
2	859
225	111
514	282
826	816
606	894
312	733
252	641
804	260
296	371
68	331
672	715
346	539
692	57
614	700
299	990
311	371
275	628
15	695
461	693
814	717
526	163
1	700
595	311
696	909
547	623
387	122
301	71
212	277
367	653
116	751
622	113
196	575
493	149
609	910
599	461
752	672
86	990
643	57
143	974
389	217
103	73
681	419
162	173
434	277
695	764
682	73
374	63
791	334
794	428
472	191
656	238
451	688
403	981
733	840
71	833
540	24
16	109
123	134
487	864
765	397
198	970
791	959
826	429
127	519
252	837
264	662
431	711
300	158
102	682
690	417
102	204
588	362
144	421
32	72
369	301
552	937
70	520
215	739
823	749
261	887
285	537
827	256
650	434
822	296
425	566
477	725
231	410
791	195
666	935
466	336
835	870
725	949
596	68
327	84
169	831
727	423
728	152
226	893
610	325
221	869
519	336
597	672
433	556
143	608
51	75
160	704
100	845
191	884
553	755
417	652
37	239
448	38
161	89
482	826
601	444
780	455
408	616
567	146
571	759
793	197
213	614
715	681
332	271
645	908
462	948
332	152
426	118
592	245
264	723
753	235
251	742
146	323
502	649
173	462
221	228
498	813
251	502
328	784
389	160
197	75
80	571
175	462
375	470
170	221
161	811
108	763
237	613
218	666
230	46
805	282
679	906
503	633
586	166
575	209
677	65
824	899
690	483
442	921
92	545
341	508
440	732
577	200
336	554
808	78
104	196
510	793
805	348
82	236
389	236
240	462
173	31
72	572
301	127
148	318
461	814
140	700
610	198
313	553
728	413
106	526
832	303
221	228
110	202
426	184
742	66
343	515
609	690
641	905
324	630
460	262
489	964
660	468
277	285
781	45
821	892
34	42
233	771
703	28
261	943
212	597
36	9
435	556
327	848
79	51
104	102
383	479
535	110
11	677
240	334
626	936
638	10
448	214
104	634
405	300
192	164
218	462
15	7
231	314
252	568
72	715
81	971
389	156
352	400
80	529
174	535
782	513
303	402
669	39
76	457
384	416
113	101
612	717
783	14
562	139
433	88
800	147
114	839
448	56
121	626
106	426
202	503
757	136
468	43
742	394
305	20
541	550
803	520
232	835
176	972
561	914
95	684
356	659
58	339
791	768
340	937
778	944
492	933
778	945
45	108
787	894
531	602
120	228
341	490
582	563
327	758
81	673
114	452
111	926
316	566
258	676
785	138
226	205
726	535
759	983
56	380
796	460
109	653
497	544
22	768
490	826
710	292
232	28
123	756
800	557
578	995
494	624
419	401
140	243
625	83
771	791
550	120
835	601
447	243
355	802
447	510
328	30
147	509
68	240
522	219
779	301
350	485
723	1
526	270
244	971
95	363
71	636
177	326
577	330
798	526
122	430
278	23
743	82
70	2
633	944
406	138
77	286
794	958
101	122
121	762
72	310
687	863
473	740
777	695
34	676
567	802
524	894
260	744
672	653
107	234
246	19
519	531
805	327
19	719
581	136
178	579
773	279
383	675
488	852
136	941
82	511
651	982
389	662
629	785
716	527
430	1000
511	210
252	628
104	599
441	422
193	676
833	570
338	54
391	807
757	592
362	984
557	969
261	433
542	195
543	789
253	801
568	609
735	313
564	53
193	527
246	834
736	48
156	681
373	100
101	217
268	931
536	296
24	182
657	197
230	823
298	420
804	192
271	724
672	494
187	980
267	677
173	233
231	407
785	494
284	526
174	488
91	660
574	56
689	123
773	677
391	504
215	373
643	675
324	507
709	494
179	381
592	547
162	370
583	349
666	602
710	493
677	819
666	831
297	675
720	837
270	980
51	562
545	646
317	795
339	68
421	915
315	200
304	175
535	267
646	565
90	292
406	785
302	546
765	921
516	290
65	351
96	634
368	588
570	153
343	426
600	755
675	289
62	903
720	421
693	444
360	1000
742	413
170	289
709	28
436	871
753	465
559	91
759	689
467	763
243	418
371	68
83	425
363	137
705	498
571	800
63	109
58	254
649	940
421	472
49	737
495	139
555	43
817	770
595	125
167	425
379	107
5	102
627	820
91	849
632	879
513	456
63	940
107	980
198	278
465	407
695	203
128	921
312	721
830	496
134	422
141	847
276	572
148	893
172	121
718	657
165	93
631	671
396	722
552	4
648	983
146	748
100	669
217	365
415	245
20	947
298	538
61	658
429	170
494	97
229	207
9	620
82	639
45	426
620	95
421	857
183	459
359	192
109	890
311	373
677	244
696	732
10	329
439	247
565	887
540	45
348	337
608	711
529	478
319	308
495	98
129	207
605	578
116	43
97	954
54	435
295	394
785	22
304	288
470	365
539	151
181	343
236	713
62	115
62	549
133	575
667	211
360	512
737	456
85	594
414	290
705	44
154	434
820	584
40	786
505	784
3	316
734	686
458	902
456	977
420	558
74	566
754	593
541	994
450	100
738	283
653	696
482	375
254	321
21	21
65	369
443	971
450	219
628	103
559	585
8	645
544	2
546	756
384	726
748	157
309	71
656	471
154	282
149	552
135	145
368	605
416	166
31	842
205	757
585	889
483	138
506	642
555	703
826	309
117	278
163	53
7	742
641	248
229	139
605	891
472	832
576	188
722	498
308	183
481	482
266	782
674	522
492	241
780	262
171	440
369	987
540	263
636	483
316	1
236	694
538	192
317	744
572	246
654	855
733	568
112	235
438	424
471	588
600	767
171	157
271	63
140	633
198	350
389	371
37	101
451	739
781	283
330	662
67	918
645	282
787	31
791	664
712	416
651	305
637	976
348	149
216	871
16	634
744	157
282	326
291	158
513	884
7	763
225	694
781	329
43	220
554	237
43	493
24	135
672	505
707	222
567	157
366	319
73	812
283	589
256	440
810	850
600	478
379	742
592	890
339	430
365	515
664	578
833	207
412	650
654	614
788	820
684	590
359	368
786	270
335	29
758	121
254	837
21	198
327	234
441	892
368	102
176	902
268	1000
708	990
740	768
723	302
215	352
512	817
208	192
151	325
782	193
582	215
212	272
182	891
301	806
521	721
736	746
691	950
125	133
77	744
832	483
462	757
303	932
631	424
583	10
608	619
59	207
2	150
56	350
364	133
437	44
501	579
270	676
565	78
592	938
723	607
57	922
471	924
646	47
46	895
688	804
25	738
86	115
534	546
696	871
666	600
169	777
157	585
369	926
717	860
811	285
78	486
657	268
795	992
751	169
421	568
462	472
16	391
323	843
762	735
666	949
105	718
217	816
140	263
666	631
59	869
596	767
641	90
692	2
38	527
66	792
731	817
145	912
264	380
340	770
833	539
545	610
143	342
404	713
476	647
394	991
340	790
817	677
819	150
545	104
507	619
819	561
185	696
747	201
726	841
197	797
630	768
465	631
148	220
426	591
811	724
451	450
323	314
379	841
114	875
776	650
222	70
622	370
124	620
161	415
413	171
697	613
687	679
794	857
288	133
503	53
707	81
510	398
593	500
335	147
158	165
104	179
617	480
389	977
276	188
772	818
67	230
486	410
567	125
729	570
195	117
734	130
20	830
310	385
731	928
429	695
209	49
385	22
280	299
590	958
187	56
574	421
791	5
116	383
294	671
827	936
411	61
51	952
597	578
682	469
393	486
558	988
692	753
500	379
96	863
127	743
567	840
678	944
137	785
152	956
220	10
539	48
156	896
66	518
159	12
289	569
833	12
754	708
457	414
152	780
208	646
266	832
216	878
172	862
754	217
556	731
625	79
61	791
454	356
256	608
583	175
695	553
408	775
111	860
44	139
26	162
299	338
636	631
448	714
239	928
388	886
835	923
505	680
608	328
618	237
712	818
238	704
291	64
577	230
245	656
99	448
349	319
432	666
230	884
809	380
130	902
90	718
568	803
254	849
368	252
412	433
653	63
735	86
451	330
382	147
224	587
118	572
177	760
613	745
441	618
51	367
625	689
698	920
71	742
436	455
360	992
486	408
132	604
550	694
699	139
399	39
28	965
208	296
817	710
27	293
23	349
244	651
477	138
59	975
257	966
401	466
244	470
227	669
435	24
430	508
463	998
62	915
82	997
714	340
734	673
821	201
461	103
765	170
544	393
747	587
390	870
761	890
196	59
757	904
422	828
606	393
763	834
130	267
338	152
264	575
665	530
297	549
486	800
357	750
55	430
175	8
604	736
244	736
47	823
317	428
554	253
292	368
585	796
389	719
734	55
29	113
236	714
278	559
132	360
256	477
834	605
637	487
827	505
414	197
25	221
719	994
44	507
76	342
707	314
446	980
538	93
476	272
351	849
108	801
162	138
464	724
202	395
722	30
185	961
665	565
418	669
208	262
601	233
521	953
343	746
829	482
682	44
175	571
825	314
439	106
345	848
770	250
211	472
646	261
102	938
25	450
666	817
27	38
714	865
419	578
684	861
743	603
510	562
185	560
524	747
757	390
440	879
567	330
811	470
178	276
374	2
568	430
355	996
717	713
482	80
579	187
4	357
143	221
302	248
138	869
370	587
69	374
804	699
233	311
643	862
472	874
372	105
338	14
377	349
131	994
193	949
329	742
482	339
475	723
439	171
610	563
170	607
470	366
11	969
508	824
160	836
393	580
535	734
371	519
94	809
203	220
276	534
686	30
811	250
631	500
338	639
41	215
509	876
85	107
117	372
517	109
157	966
737	153
746	511
474	510
582	993
304	280
567	836
473	536
206	714
436	382
208	46
277	67
803	943
500	757
830	832
323	343
335	728
336	501
605	393
656	193
731	86
53	671
828	640
658	811
482	684
461	929
145	467
566	775
343	366
795	34
739	244
500	416
638	305
633	676
209	853
695	134
499	75
240	19
29	13
577	885
230	637
494	548
133	456
495	826
501	278
101	476
398	464
320	701
384	433
361	878
192	958
821	673
417	483
14	289
740	477
6	157
73	146
642	707
212	931
390	232
27	54
7	411
95	585
59	816
686	699
802	189
603	452
784	728
499	764
717	16
761	866
707	823
718	767
209	665
620	873
697	825
75	401
134	812
257	668
97	194
68	878
737	14
596	926
731	965
714	685
248	701
481	610
16	867
130	695
38	314
696	617
222	9
141	567
10	960
706	962
79	858
776	433
138	778
18	771
750	624
613	950
530	225
719	178
648	490
684	587
795	113
423	651
513	84
49	514
777	570
213	391
491	652
640	111
393	972
115	194
212	200
589	930
118	368
484	674
107	504
718	241
711	632
420	684
396	996
401	495
732	152
446	309
684	589
334	759
279	174
11	839
532	102
447	191
34	299
224	666
796	799
320	60
167	384
668	204
616	900
672	495
111	950
269	20
626	938
642	153
550	26
458	949
73	326
792	112
733	329
765	475
310	998
65	399
302	352
155	335
755	173
168	817
64	83
426	802
435	931
348	612
256	188
149	796
429	831
706	503
825	181
611	491
400	36
416	894
370	904
273	684
202	90
324	190
789	866
128	636
413	820
86	169
372	868
98	171
127	701
772	853
33	353
584	410
670	660
805	856
375	449
251	866
239	163
214	657
325	484
187	23
639	230
748	974
342	614
657	39
278	831
652	517
744	334
526	545
486	778
270	17
338	344
475	86
73	636
622	718
155	394
185	254
726	57
408	128
217	916
604	217
197	205
450	280
679	653
360	634
186	978
611	553
164	157
772	356
582	851
256	253
792	234
590	774
481	147
335	886
784	651
397	648
453	435
24	280
402	437
632	143
769	567
428	24
10	392
656	243
221	510
526	815
234	493
88	817
86	407
486	432
552	416
753	261
477	132
374	130
487	384
675	893
230	25
128	278
783	821
10	114
635	964
24	868
373	705
594	168
463	962
565	369
58	429
81	745
13	86
92	152
381	555
136	378
351	97
474	134
720	998
61	92
301	874
311	228
505	258
473	539
148	466
1	231
70	641
42	461
227	900
782	202
797	310
595	624
293	611
512	780
759	106
460	827
422	180
816	396
374	300
593	566
484	7
547	284
257	991
82	100
303	694
361	301
499	246
504	841
523	318
820	572
403	438
739	798
473	195
374	583
63	452
353	616
669	942
679	39
474	479
595	234
762	279
448	220
204	907
260	183
80	584
463	818
605	945
603	94
103	54
342	230
532	510
68	318
30	392
233	938
466	557
575	567
365	798
388	662
317	445
445	132
217	166
707	756
91	557
37	992
590	802
394	841
465	839
48	750
589	983
393	839
725	941
296	832
708	852
538	122
434	532
176	601
722	54
342	62
503	265
487	535
501	694
276	424
200	832
309	25
519	492
166	341
584	244
668	971
583	898
608	869
416	587
785	355
676	613
788	979
434	6
178	832
552	203
561	65
56	106
502	498
605	283
576	389
617	812
627	622
86	910
503	314
461	520
369	577
657	713
327	502
595	286
430	847
52	853
140	979
43	988
588	634
453	597
99	307
288	367
135	681
653	749
570	129
712	879
344	553
690	309
483	475
206	495
613	490
325	59
791	100
521	626
694	804
576	330
423	253
819	416
259	131
605	276
29	215
474	56
139	234
803	756
512	788
483	77
432	289
583	359
140	217
415	925
257	111
486	796
599	55
666	272
766	710
39	562
379	509
179	307
640	818
196	279
263	129
594	258
793	986
477	171
358	178
249	173
157	975
302	665
317	240
282	664
663	980
167	619
160	943
692	410
541	766
243	795
245	368
291	655
761	981
38	755
616	47
398	817
353	698
521	987
473	505
53	599
660	578
465	718
662	988
814	659
290	267
630	202
717	272
307	854
679	88
47	246
675	110
682	921
144	25
508	253
635	892
507	760
679	280
96	711
548	598
345	540
198	218
544	193
142	151
306	169
745	561
107	526
73	821
712	674
61	184
223	395
522	293
539	334
59	518
750	339
481	467
573	737
413	701
463	364
738	407
705	15
401	19
302	74
18	88
623	252
304	614
44	471
32	494
444	490
478	689
520	534
708	954
247	907
645	318
730	618
220	547
279	463
374	120
457	255
92	764
541	755
203	839
537	455
147	347
165	807
736	475
41	525
704	483
197	186
187	632
619	438
259	229
314	584
514	726
500	603
235	229
130	759
636	355
461	978
673	265
284	773
41	495
667	11
195	934
535	953
356	473
278	819
627	369
659	627
768	962
167	326
70	291
444	597
100	96
623	876
149	113
775	529
477	452
246	404
338	958
596	140
610	369
226	283
480	478
137	142
438	366
105	223
704	32
831	887
549	554
788	326
715	82
178	121
531	976
591	834
705	881
431	477
235	797
621	609
414	33
19	52
677	843
65	816
191	194
603	85
368	595
595	299
683	725
254	760
331	55
30	402
756	964
452	852
772	220
414	857
382	38
616	461
454	308
54	382
709	909
437	38
157	279
513	832
77	970
324	187
44	321
450	305
324	884
391	162
370	282
449	455
768	57
77	657
516	405
678	995
234	501
195	258
431	606
188	119
311	982
322	157
667	5
513	630
238	180
352	501
788	974
154	763
352	780
354	2
109	96
203	973
398	143
797	271
71	938
438	751
1	542
251	986
726	741
781	984
608	282
320	715
800	891
341	270
262	889
690	679
226	238
422	435
591	488
158	501
651	834
656	692
616	532
802	594
651	455
72	101
561	257
133	78
673	888
225	860
725	643
647	418
789	841
776	532
89	136
598	10
50	185
16	433
509	629
527	325
265	372
510	274
433	965
301	845
725	353
139	674
282	12
483	967
615	126
725	871
117	177
509	1000
547	348
380	65
395	94
406	468
538	766
308	795
227	490
777	786
475	699
334	98
310	270
140	821
310	186
647	562
460	854
127	965
296	635
449	352
107	291
185	700
493	147
316	79
803	490
468	640
708	353
496	936
123	865
696	959
726	995
138	293
774	202
781	482
727	568
732	129
170	765
605	34
790	191
345	910
92	53
23	742
152	221
767	588
269	721
737	887
828	688
281	524
470	43
656	826
164	513
100	695
42	795
49	773
600	838
343	736
223	259
750	11
132	677
63	553
220	235
35	137
628	994
573	540
768	608
174	267
288	623
99	956
661	953
723	498
353	24
165	251
770	247
760	839
225	283
690	224
624	732
788	500
624	473
278	857
54	378
763	710
350	992
591	180
166	768
432	671
666	254
560	214
271	601
24	993
459	407
399	573
484	733
446	892
100	225
820	669
543	81
38	909
685	996
533	920
785	885
17	204
333	85
605	963
217	916
200	329
20	258
824	802
793	87
587	707
786	995
223	408
474	534
194	353
690	194
91	328
693	614
709	308
137	80
542	511
745	788
81	689
6	15
20	951
252	897
547	771
30	762
43	483
114	237
269	382
484	778
154	799
536	493
31	81
550	629
174	330
657	34
63	210
269	114
185	815
184	405
443	74
778	344
49	955
118	231
722	448
256	564
328	190
506	868
214	193
147	697
647	697
603	131
395	931
327	193
798	287
529	905
44	202
611	883
96	767
159	900
691	183
495	19
450	306
480	645
799	92
259	643
733	364
423	616
470	378
407	775
2	804
759	340
425	600
591	204
105	339
323	403
679	358
579	414
124	960
292	280
780	803
440	342
160	26
72	545
243	468
723	881
395	718
495	6
801	571
476	197
635	350
4	238
207	885
648	659
594	318
194	434
648	45
680	291
16	197
270	947
462	933
118	293
447	888
606	606
15	102
411	348
233	878
413	105
292	718
743	201
353	290
173	187
261	267
79	658
174	438
634	771
264	178
123	290
596	27
584	804
595	347
727	941
585	452
815	169
299	955
263	1
269	371
331	567
575	536
22	972
276	36
72	763
385	917
617	920
86	917
274	67
507	984
34	986
181	39
304	954
532	139
327	495
780	900
137	80
139	760
301	3
492	560
395	111
769	640
429	823
220	464
19	143
794	565
420	360
582	553
807	671
270	455
351	505
582	967
390	997
384	23
653	489
742	613
343	543
43	504
552	914
26	577
735	254
232	761
696	336
147	449
20	905
327	178
349	12
376	359
476	784
713	906
360	645
747	14
18	266
484	644
73	425
365	567
528	59
111	479
790	380
189	230
58	828
313	779
628	513
703	592
116	546
742	1
663	260
341	161
70	579
597	506
581	913
696	123
826	253
687	276
154	684
534	495
201	314
535	416
78	276
261	710
241	361
228	310
440	401
119	887
135	306
593	476
784	744
36	15
404	846
743	515
781	954
695	319
245	216
219	883
9	289
728	361
178	262
568	391
506	533
111	840
721	536
35	987
578	884
377	667
63	319
102	771
307	751
25	343
143	221
182	802
318	535
830	202
119	77
362	434
624	71
696	348
252	523
57	885
690	564
240	475
537	334
399	178
319	796
644	570
566	839
254	380
145	341
150	501
109	687
243	235
296	790
392	627
554	972
32	710
209	755
728	184
51	10
779	111
530	760
277	858
802	513
720	817
151	353
259	204
166	653
230	302
810	642
676	876
556	380
680	667
236	386
721	356
484	981
29	78
398	132
270	474
754	840
781	50
678	416
332	164
683	394
570	499
257	172
621	576
311	623
83	720
614	244
251	646
548	865
456	383
467	771
550	39
45	164
418	134
147	960
212	710
517	962
60	346
375	223
710	343
521	910
161	7
392	87
574	526
118	149
360	606
662	768
639	976
752	912
124	593
195	701
546	879
173	868
404	710
95	123
794	9
361	618
590	340
98	919
538	373
597	201
501	379
272	442
478	972
554	321
188	779
478	217
784	118
642	737
374	557
86	136
39	535
505	745
597	57
620	160
181	641
675	739
525	527
366	420
802	718
540	581
782	275
681	54
810	237
799	314
546	11
26	372
101	93
42	775
206	164
724	792
356	362
669	900
360	914
386	901
145	524
311	699
346	48
598	622
239	247
156	146
735	553
528	726
616	321
51	873
137	534
151	460
530	145
756	979
305	456
289	522
652	882
338	718
91	936
803	137
636	976
280	989
71	135
631	545
686	517
590	954
202	620
143	781
745	684
715	460
560	260
595	973
367	281
564	464
593	897
145	334
804	908
566	842
585	707
657	349
458	985
690	643
110	936
110	677
244	554
751	970
448	580
79	91
426	945
107	865
409	67
596	291
274	387
533	409
238	113
606	453
158	196
740	756
456	639
592	434
804	367
149	176
631	471
322	839
41	443
695	327
548	99
153	371
79	618
166	238
654	511
319	321
774	151
168	69
68	402
157	415
225	656
817	555
486	80
812	405
670	825
426	20
740	628
812	255
774	818
413	496
109	804
463	937
776	625
521	981
619	951
696	118
499	135
762	151
460	292
228	794
798	466
98	30
508	874
38	834
752	403
236	299
511	129
195	987
420	290
57	332
20	206
237	485
388	18
308	967
606	781
388	324
70	417
323	169
583	729
518	739
713	617
736	110
580	31
513	115
665	853
309	452
783	373
570	837
124	63
377	910
165	582
466	925
747	6
208	229
315	618
707	344
155	668
458	74
95	458
424	69
645	236
669	163
535	494
337	579
442	124
481	595
319	757
200	8
68	240
262	798
185	22
620	779
459	518
828	279
626	867
448	771
241	795
46	112
801	808
494	399
806	909
52	656
148	731
489	173
709	520
194	519
510	881
75	263
139	335
309	352
357	932
304	484
428	742
3	61
29	251
704	894
359	256
147	982
526	856
70	996
619	719
435	911
291	80
815	934
62	820
45	439
543	308
701	297
469	903
266	22
342	516
482	792
521	282
342	606
462	305
698	772
465	793
379	76
697	30
522	885
334	452
91	854
93	155
413	949
123	492
609	941
112	13
658	157
228	990
461	809
188	637
71	273
350	495
610	114
136	79
822	60
164	572
262	159
835	667
308	443
502	933
80	88
425	936
623	33
292	198
509	495
758	470
356	346
593	392
46	690
156	247
216	580
173	382
155	840
233	196
575	916
285	368
476	33
434	223
99	86
817	503
242	41
631	2
307	441
464	363
463	877
508	785
419	883
796	774
93	543
677	172
149	811
817	901
348	683
644	948
731	786
602	908
572	454
370	441
792	83
184	425
728	559
600	736
507	608
649	951
503	286
633	244
442	873
220	561
421	7
825	598
176	553
774	141
726	452
252	817
197	854
58	93
820	565
759	814
649	678
666	196
431	826
467	111
332	488
227	830
551	717
694	740
33	318
394	435
478	253
270	397
715	707
790	204
50	266
303	560
527	946
362	920
287	474
789	937
669	827
633	774
29	80
33	844
464	481
253	42
2	121
94	508
80	94
571	667
21	945
519	215
503	858
257	170
441	16
22	664
193	801
414	276
401	50
609	711
744	669
819	49
182	545
749	853
27	517
633	736
281	198
316	32
507	442
608	464
98	299
502	547
475	827
329	903
719	818
27	461
300	336
799	259
329	806
293	466
437	773
134	865
748	210
726	452
342	153
302	620
294	607
35	909
259	622
155	732
88	579
243	651
120	523
85	480
20	500
212	567
535	516
423	603
249	234
510	469
374	258
141	433
142	677
424	382
299	846
713	608
704	540
464	106
708	114
247	927
451	312
298	673
104	840
388	386
484	468
445	713
562	58
676	530
461	226
756	947
582	603
48	635
544	651
557	84
591	880
549	675
125	561
128	543
428	710
172	432
835	544
150	619
615	261
2	608
622	706
81	603
214	984
6	786
418	933
1	263
695	82
742	281
811	919
714	920
765	207
682	252
510	362
218	106
832	260
426	329
602	813
598	3
261	625
187	451
596	250
727	77
465	357
248	844
60	113
785	745
22	69
388	105
559	956
455	371
783	266
10	994
54	875
718	39
760	811
274	516
60	905
657	390
598	169
274	362
19	490
108	395
44	469
506	249
660	126
719	847
442	424
737	502
370	420
681	374
221	227
451	518
835	784
443	936
632	922
628	254
374	711
27	845
632	294
389	234
25	265
794	680
772	78
641	633
820	69
480	78
149	895
33	212
756	659
697	263
446	420
312	668
654	68
282	500
464	471
166	794
798	614
294	400
41	50
143	88
178	235
171	266
197	549
95	974
410	644
719	358
764	166
698	889
765	543
758	902
66	894
658	651
221	903
578	280
661	556
644	815
725	75
764	165
386	198
331	721
802	261
267	35
216	55
623	65
278	136
383	194
650	261
339	266
629	52
562	335
437	681
122	711
444	844
588	7
384	118
762	69
773	187
329	184
793	556
354	170
304	701
377	237
207	273
293	623
576	335
8	469
4	899
292	287
389	619
186	370
360	474
724	923
128	763
756	93
721	959
717	332
142	509
365	743
188	807
54	642
745	625
420	751
582	63
467	766
601	482
399	134
257	854
360	168
494	943
590	305
169	654
192	778
518	272
684	208
145	133
181	8
643	200
483	524
419	881
262	452
316	765
404	689
604	496
721	841
371	852
217	900
161	122
519	619
678	807
95	786
469	414
252	593
699	257
561	87
70	384
200	187
422	157
613	499
341	446
660	952
668	461
687	404
89	296
526	970
453	982
354	434
390	204
39	362
724	741
53	963
435	756
570	91
127	720
575	791
741	868
408	72
818	224
537	257
64	15
271	874
756	880
736	865
453	925
664	681
699	558
769	833
42	724
56	426
669	354
273	401
528	348
286	666
112	977
385	24
611	76
327	798
754	989
663	751
778	337
266	819
33	129
626	627
40	843
203	509
458	457
252	768
822	684
518	822
303	94
17	328
441	771
410	655
44	755
789	575
199	683
419	204
233	750
433	590
731	979
227	527
642	680
35	90
568	268
116	647
707	468
665	569
765	382
825	98
622	901
512	697
457	310
689	627
439	699
417	923
50	937
132	899
210	440
28	248
133	619
194	528
237	785
275	262
35	820
76	287
511	127
700	412
565	423
718	890
626	543
40	858
698	247
355	892
828	669
713	532
91	47
403	686
241	59
629	49
526	663
144	729
181	960
817	215
600	809
430	336
589	374
241	500
608	821
392	230
39	469
155	290
227	738
374	433
666	801
798	452
634	293
504	555
176	295
72	375
380	15
792	182
484	945
289	22
313	836
222	268
235	135
290	778
654	567
452	789
376	325
681	983
384	926
168	71
817	969
830	192
268	379
336	383
105	990
90	956
283	481
238	993
398	366
304	982
92	468
770	409
524	184
490	842
424	72
298	584
410	674
753	32
682	103
586	451
659	136
716	45
567	407
753	598
609	697
604	279
788	866
181	97
5	181
630	442
506	844
785	62
787	739
482	207
200	807
190	616
554	875
606	617
77	377
110	599
514	150
805	258
321	443
527	902
478	290
366	912
75	870
40	910
765	643
502	359
5	334
632	993
200	252
342	697
365	842
278	77
409	577
702	222
177	286
88	450
772	232
38	814
808	965
620	150
237	562
561	966
698	984
372	770
292	324
344	315
554	471
358	400
588	301
389	749
556	925
251	227
231	612
502	16
60	497
698	683
55	242
790	510
466	316
499	539
639	106
110	83
231	983
294	720
46	383
743	305
588	809
792	816
139	779
756	581
833	151
163	619
51	320
621	326
227	528
368	844
12	592
58	763
795	674
825	158
281	52
246	48
355	257
332	974
293	363
243	517
446	309
463	536
782	279
769	958
157	89
263	669
419	250
641	580
752	533
308	865
532	275
409	410
586	109
774	797
138	561
21	308
499	994
361	939
212	33
615	172
156	132
228	57
189	398
682	503
701	883
503	719
179	893
52	145
170	216
733	707
397	880
527	997
483	722
68	676
176	443
210	638
218	113
66	253
465	967
695	349
10	237
515	623
130	219
418	147
442	897
573	618
54	918
509	559
785	646
33	998
750	566
680	295
811	661
144	229
464	3
413	775
763	273
155	88
463	953
573	376
577	888
543	786
816	460
658	175
320	861
638	886
414	647
789	469
821	723
458	543
407	888
629	946
560	290
328	169
493	909
712	908
372	560
539	969
503	925
402	413
161	827
254	725
457	425
64	443
100	870
754	536
801	867
422	496
538	925
491	41
746	299
474	214
427	907
691	326
419	580
307	300
639	685
127	19
313	548
704	389
81	967
374	46
178	149
476	886
368	344
536	165
729	97
104	735
514	344
231	202
123	906
549	284
508	353
307	376
339	732
156	261
88	927
660	178
653	652
782	339
469	407
746	85
663	902
341	739
572	734
827	317
729	961
574	686
595	703
656	479
513	605
22	398
664	411
399	728
752	946
485	238
797	521
324	263
476	592
51	894
719	904
185	866
519	178
738	960
379	438
833	538
484	124
155	34
420	443
420	578
21	483
321	150
551	571
280	258
57	258
514	147
67	128
726	810
421	437
563	850
39	630
264	830
446	246
321	943
295	737
110	848
134	977
712	660
732	150
97	145
537	942
390	5
661	951
771	163
113	234
439	250
266	755
386	696
110	338
495	643
460	506
84	202
610	671
440	586
499	461
236	551
94	675
116	540
384	412
686	585
26	580
411	89
339	564
283	592
727	113
57	434
311	256
40	160
302	491
195	442
548	816
150	105
149	876
389	796
620	701
491	948
85	285
124	909
507	813
89	461
361	508
720	772
300	708
38	991
87	307
661	344
369	665
652	617
1	232
156	910
330	751
56	81
798	602
257	787
350	951
696	521
576	960
230	272
303	575
396	799
476	476
516	425
801	586
432	342
637	149
118	276
114	444
106	559
575	264
549	119
378	949
522	788
615	984
309	148
674	586
549	719
120	323
698	337
39	867
807	143
107	300
111	476
263	725
306	373
676	453
695	454
594	749
160	498
54	618
778	164
125	785
664	21
706	476
467	723
731	481
779	654
814	15
333	299
565	690
7	837
294	535
595	797
769	574
320	978
102	421
683	135
141	540
82	868
817	237
135	415
488	562
654	522
233	518
109	909
261	734
492	200
86	897
724	686
741	221
621	110
16	115
283	761
399	160
742	313
357	322
201	188
352	714
313	86
26	332
189	380
313	301
221	578
146	702
470	849
93	604
357	562
81	28
176	96
531	122
314	476
624	792
701	984
236	628
58	229
307	897
81	364
716	337
136	547
365	520
728	326
199	511
350	924
346	200
58	324
386	106
766	175
32	49
308	447
523	737
191	257
642	181
238	597
426	335
251	938
400	391
626	482
665	259
759	706
68	886
217	239
286	161
628	193
330	17
744	938
669	273
212	282
758	309
448	204
461	224
422	320
790	117
762	940
124	704
129	728
827	355
381	775
795	263
605	896
105	858
465	618
68	92
291	5
490	60
152	296
8	411
1	105
809	313
11	911
487	913
401	599
820	352
605	403
602	241
38	284
566	820
714	707
117	907
35	347
500	231
172	576
493	33
163	671
263	33
509	96
659	790
211	815
419	657
669	721
787	210
512	480
705	258
131	346
643	334
219	225
65	535
703	472
823	926
160	835
291	847
809	621
195	408
140	240
413	996
412	183
561	717
40	859
128	232
541	793
256	992
34	79
32	265
95	794
580	231
599	693
388	63
115	571
374	49
55	527
144	869
287	599
353	278
298	62
422	89
515	296
231	3
651	867
312	179
62	192
469	759
745	576
577	827
554	133
276	526
68	610
299	670
337	587
437	394
212	676
415	621
162	482
715	275
18	146
192	502
376	558
30	662
112	153
720	955
205	907
773	72
401	492
626	929
97	608
289	968
819	198
734	697
761	11
412	278
262	592
355	304
725	805
427	835
226	644
399	597
667	142
409	303
155	18
427	715
30	930
610	995
681	232
739	133
79	342
605	481
583	116
18	10
321	818
671	432
135	389
353	865
541	423
583	866
643	917
364	573
108	37
686	74
795	684
540	497
520	229
473	602
282	746
832	21
350	903
495	448
127	806
106	198
779	406
826	568
546	846
426	892
552	248
418	731
16	412
352	442
69	217
520	487
713	332
229	346
39	786
205	117
273	257
330	942
21	227
407	315
485	297
664	345
641	925
689	877
200	60
720	684
550	568
218	713
431	13
303	312
572	657
49	869
490	279
445	84
241	763
313	947
534	255
95	639
323	544
531	152
399	333
788	539
406	544
445	327
601	744
673	717
682	212
718	914
90	772
343	726
778	949
545	579
475	528
305	312
308	804
579	643
720	939
101	251
623	555
594	425
373	606
429	167
482	950
265	293
655	934
20	396
402	809
361	966
333	768
425	964
447	485
190	734
70	716
735	859
667	231
179	375
273	717
345	390
470	371
795	575
302	1000
660	317
699	544
585	521
40	725
268	856
339	209
771	641
728	894
322	673
538	57
107	942
231	284
584	343
318	59
704	480
34	884
130	435
386	607
757	966
620	910
83	879
428	424
668	399
823	170
363	863
79	564
38	732
598	151
789	896
188	68
500	12
373	633
569	36
527	275
374	380
809	320
422	441
507	891
617	961
785	813
108	634
442	440
17	767
434	753
543	219
327	984
807	796
686	419
834	500
492	179
599	400
191	379
202	916
117	56
421	192
107	561
364	359
479	460
520	531
169	799
690	669
488	222
121	497
402	639
510	580
815	914
630	282
418	562
344	408
175	338
78	299
116	485
668	184
49	925
199	11
493	831
696	822
253	308
828	792
244	303
140	245
405	977
664	728
104	854
273	889
607	85
456	983
164	830
771	795
416	774
165	429
618	500
341	406
516	404
556	956
224	996
703	683
170	200
320	748
132	569
606	685
228	319
769	897
468	816
469	757
560	842
444	808
355	416
668	745
166	90
705	103
23	25
627	612
147	406
16	466
50	517
283	144
300	529
27	10
205	972
292	337
753	739
809	114
390	758
792	574
11	44
692	523
833	356
261	133
674	960
321	304
700	105
749	608
451	174
729	550
711	285
610	788
822	875
476	178
401	669
165	655
59	465
27	161
283	534
764	860
294	84
8	170
811	467
143	996
378	10
49	796
60	550
394	22
258	492
74	773
820	631
523	188
83	952
271	946
2	9
180	188
89	323
201	481
204	331
23	367
630	836
768	319
96	370
771	771
198	820
18	926
712	377
511	515
365	300
570	120
599	969
94	87
548	274
670	334
237	810
549	910
9	120
657	759
756	367
211	15
156	659
441	282
469	574
371	286
564	130
608	45
810	567
533	74
384	550
803	454
201	501
196	527
520	41
111	715
495	438
484	769
777	482
587	267
429	732
643	536
569	265
167	381
100	636
112	528
581	184
555	937
431	919
212	522
59	355
117	337
257	529
487	39
764	492
642	230
107	106
541	217
340	723
373	125
543	756
129	330
71	794
380	483
177	371
5	888
654	647
783	310
451	902
661	267
194	475
446	416
348	117
337	692
398	532
159	871
502	80
513	429
628	701
808	742
591	962
826	854
410	342
737	634
313	883
668	953
127	632
351	929
397	603
759	28
60	730
712	269
213	917
615	408
16	180
56	899
264	260
590	781
606	409
243	108
642	46
268	355
546	639
597	915
140	45
189	580
774	403
509	466
115	224
724	959
507	249
268	103
37	344
685	923
141	768
411	834
36	645
725	967
692	590
7	187
548	305
338	532
164	328
745	781
319	970
443	540
630	734
778	538
282	179
221	417
283	728
825	83
746	575
294	140
599	20
2	637
244	108
402	108
347	706
777	887
414	115
377	161
605	947
299	711
638	677
528	328
540	406
160	984
523	168
273	272
641	526
537	669
802	467
48	601
627	801
694	778
115	540
661	750
188	601
416	541
670	297
540	586
52	675
294	947
792	741
399	346
776	262
97	349
30	583
688	81
648	490
156	993
242	491
522	188
370	510
538	865
349	345
782	886
541	11
514	159
105	492
679	426
193	193
423	528
517	142
397	641
150	956
774	245
422	842
194	383
458	811
338	947
73	361
389	818
441	508
80	321
323	522
82	41
48	978
817	171
767	73
242	144
167	539
230	797
278	404
629	379
297	315
748	568
788	895
98	330
522	791
811	530
790	487
224	467
778	983
655	147
256	762
715	91
152	774
434	168
488	473
118	736
680	743
311	102
676	231
317	791
346	884
834	376
88	510
515	763
248	638
427	688
273	883
646	629
189	878
421	595
610	369
135	257
739	704
795	888
724	730
30	88
223	359
65	512
59	282
354	695
810	71
368	409
170	204
296	712
517	858
249	468
791	451
131	441
219	8
800	34
90	14
524	830
560	149
707	947
21	305
169	658
13	57
204	504
665	821
278	710
275	718
272	792
819	3
294	933
325	101
265	740
308	944
536	178
103	922
124	290
731	878
712	886
694	364
270	782
133	952
451	497
41	824
486	256
82	75
741	402
721	400
379	681
688	145
739	783
478	890
178	136
163	157
518	589
659	458
564	869
488	752
340	417
51	316
224	229
232	392
715	827
387	599
682	159
81	775
120	656
425	970
505	485
382	980
468	843
150	177
741	383
131	196
276	866
420	853
503	952
692	285
432	604
28	177
647	728
559	132
89	949
60	794
662	422
753	157
605	313
499	79
821	827
828	682
753	575
158	40
491	499
100	303
476	437
630	549
557	295
250	149
610	664
567	471
670	726
486	261
614	308
825	184
100	933
594	753
325	189
592	510
119	621
145	25
200	88
609	645
31	195
214	88
195	130
410	858
549	170
156	654
612	471
500	384
240	764
605	240
456	636
698	116
408	699
811	846
382	348
340	236
128	427
160	34
374	845
121	764
126	601
68	576
582	154
298	361
47	753
560	776
25	389
774	125
322	935
465	187
343	417
686	656
311	314
655	987
444	338
119	687
451	500
223	670
825	351
752	955
474	168
751	424
561	22
388	996
534	857
163	69
816	646
635	96
406	242
348	240
605	978
475	313
336	704
44	316
667	505
38	496
138	832
586	967
811	547
200	903
728	871
311	348
488	857
571	703
406	800
341	315
653	656
411	747
127	775
800	476
289	247
567	923
671	689
439	337
350	788
164	898
504	398
304	552
413	85
570	810
310	969
47	973
96	519
695	198
36	818
776	331
31	290
92	804
52	489
247	970
578	84
670	187
725	220
43	646
454	679
577	628
637	990
40	207
135	152
14	348
152	994
2	318
142	526
652	765
245	324
360	78
381	423
64	773
620	957
468	450
422	215
371	831
402	261
1	738
354	741
222	819
356	653
550	410
526	770
83	190
650	241
734	153
390	18
345	364
624	450
142	265
701	754
602	721
772	696
807	436
323	864
555	512
262	313
754	902
487	398
658	584
496	846
611	717
75	652
546	802
95	18
754	308
188	705
10	335
534	873
320	14
440	326
178	791
9	127
800	149
394	189
784	775
778	874
201	974
498	295
806	501
141	976
208	301
811	433
66	415
207	962
633	647
455	511
742	687
88	440
224	784
112	464
310	544
536	228
601	70
563	449
429	3
743	148
733	991
174	190
657	142
334	501
739	936
733	347
666	414
677	661
48	831
26	809
689	592
140	997
670	979
374	476
414	368
63	488
687	541
512	156
78	79
683	124
582	127
709	309
535	507
64	347
451	487
368	720
739	734
165	523
619	298
113	552
352	502
500	371
53	73
214	727
179	932
407	159
37	848
97	552
295	51
317	276
139	281
583	287
598	737
760	770
409	596
561	668
627	351
624	765
195	51
748	914
660	241
644	786
37	218
642	91
72	669
43	606
712	698
817	529
51	804
812	544
291	469
223	241
74	902
253	395
688	737
577	532
386	450
568	427
100	983
249	154
61	705
47	297
235	69
377	7
829	817
364	245
182	204
435	57
205	525
565	390
580	758
687	209
667	313
429	418
164	669
255	127
66	455
126	642
262	8
380	650
376	211
797	530
605	274
224	941
334	693
165	24
170	728
736	573
242	722
396	30
132	156
54	809
486	641
68	130
329	613
442	708
97	230
89	945
442	878
324	754
829	245
766	592
123	148
685	692
660	91
648	303
341	202
131	493
332	363
752	669
640	607
685	896
61	724
526	963
612	606
305	46
255	996
560	75
374	654
219	803
361	897
597	818
439	441
554	940
242	488
243	225
70	437
307	810
523	943
687	886
549	118
820	643
300	785
434	354
312	994
356	572
480	475
336	989
652	368
111	936
411	289
453	623
480	588
262	379
732	907
48	457
153	975
404	825
649	37
140	590
398	720
107	885
457	240
147	27
594	554
98	761
437	647
591	935
398	243
204	244
685	257
194	453
416	826
480	148
44	703
798	363
814	226
143	927
683	773
372	918
317	860
410	130
181	361
297	65
258	423
487	503
829	192
181	424
808	986
790	885
511	857
263	449
437	300
324	563
12	731
352	414
534	254
118	667
278	995
622	748
274	483
197	52
294	776
23	571
358	503
377	355
529	535
634	760
584	935
51	311
46	419
389	442
254	130
290	424
401	741
807	480
679	164
47	131
262	85
150	51
204	873
355	709
520	81
103	685
789	611
203	91
804	686
376	954
562	549
471	207
191	116
347	672
138	33
404	328
257	579
720	963
800	101
793	155
487	905
107	841
381	385
265	340
616	954
634	860
126	727
429	413
629	903
409	198
440	586
74	613
790	344
782	230
262	974
557	207
223	404
19	256
753	645
223	180
101	549
812	830
3	148
96	667
461	286
193	650
625	80
106	970
64	227
55	37
317	96
433	17
773	792
209	690
400	71
754	411
691	98
444	829
471	422
737	952
507	355
661	129
615	58
484	669
790	15
98	601
506	670
495	722
678	10
596	963
177	293
414	940
811	764
372	597
118	805
232	100
91	632
202	847
494	676
207	376
390	57
723	149
527	754
730	125
161	722
425	438
761	364
427	260
31	200
622	157
211	537
154	959
481	916
592	191
657	726
52	635
10	240
398	891
372	767
811	715
130	368
785	626
735	182
517	247
376	938
91	482
524	775
436	688
132	452
562	228
425	650
57	96
89	945
355	983
475	588
442	288
674	689
476	548
795	542
491	674
149	125
50	362
145	114
424	489
687	387
19	775
548	119
196	398
591	759
361	114
508	983
283	676
687	388
165	222
635	858
689	934
155	850
67	223
75	585
35	231
273	895
515	130
309	206
402	838
598	662
640	507
436	643
662	374
450	930
304	462
579	322
676	945
356	88
186	568
783	577
372	637
148	503
55	769
635	513
595	91
237	463
280	364
193	907
823	422
338	819
292	6
493	839
740	627
126	410
393	738
317	643
786	114
66	430
233	76
255	549
410	17
452	846
160	641
213	241
202	361
500	839
783	530
461	185
771	542
410	974
808	82
238	754
676	789
438	462
612	993
290	334
539	664
525	125
819	515
227	345
817	36
631	148
197	934
178	252
326	806
290	170
495	639
620	345
453	465
610	974
798	181
266	182
187	87
417	471
699	761
106	673
153	146
595	986
575	108
16	362
292	693
378	668
828	419
310	735
363	289
314	325
194	834
199	475
631	307
310	467
756	9
184	477
397	53
219	181
325	731
693	234
616	700
461	601
631	232
823	308
496	671
50	475
614	135
244	519
361	843
808	190
138	534
506	848
663	909
325	533
19	539
471	833
346	151
541	184
193	288
174	920
134	157
241	985
304	755
127	595
81	116
537	602
267	384
322	74
257	196
242	992
434	77
359	91
632	990
777	2
411	170
453	685
721	929
543	97
66	29
68	243
741	537
525	778
411	659
110	96
299	887
452	751
404	807
667	440
569	231
763	411
254	48
511	342
829	72
89	997
605	676
53	600
180	995
311	537
494	864
660	373
808	427
241	978
739	532
400	248
525	536
267	199
656	677
47	304
246	190
228	599
491	893
410	400
371	36
659	927
693	926
280	324
302	985
265	828
664	930
66	298
170	602
446	640
706	793
97	733
269	202
808	579
440	786
765	17
274	99
637	651
515	120
192	692
359	679
620	285
70	660
37	187
477	506
93	144
759	51
255	514
345	255
42	138
439	239
643	348
623	574
3	287
713	593
825	239
774	610
640	230
830	746
216	888
3	101
586	647
709	163
125	973
566	744
410	997
376	51
109	561
375	908
753	567
421	744
378	514
44	997
393	850
800	103
310	571
802	790
432	615
4	373
679	53
399	410
358	932
720	405
248	391
247	667
324	704
788	347
550	583
306	861
824	73
573	392
633	572
783	40
251	948
624	568
823	99
830	788
754	12
406	204
1	572
339	904
752	106
128	904
129	945
633	339
114	639
188	843
45	850
389	785
632	174
585	562
449	76
470	101
464	594
129	985
611	928
524	285
601	922
430	303
680	876
128	698
146	692
307	993
385	706
728	618
620	446
124	194
509	160
355	175
583	69
636	308
678	674
613	303
410	92
224	377
501	703
400	932
194	630
404	614
54	810
539	676
119	106
584	586
792	426
284	979
76	400
76	94
165	938
316	867
118	134
461	983
761	51
349	344
396	799
238	402
431	996
172	787
508	358
700	781
245	577
747	197
63	147
818	601
535	114
370	44
427	808
255	100
6	922
130	314
110	947
71	683
722	67
636	465
708	255
149	759
823	221
67	212
59	371
775	429
636	337
553	619
108	645
698	770
676	170
520	183
586	525
665	10
537	734
483	619
152	492
784	875
505	100
443	3
590	911
288	862
374	409
340	776
317	974
826	748
93	549
815	820
81	889
161	409
34	52
696	70
87	937
750	631
40	519
590	233
82	710
752	810
40	814
310	691
247	891
102	291
814	355
564	323
84	845
195	82
33	41
210	26
426	845
620	629
734	417
703	656
101	960
595	412
638	427
164	78
276	954
552	354
130	680
492	397
832	622
318	864
413	644
833	526
178	889
184	251
653	967
609	517
124	962
260	562
559	87
562	323
222	545
508	269
530	152
133	312
202	260
119	543
519	419
627	533
70	233
297	981
19	630
736	104
657	977
289	491
401	194
212	818
408	785
446	910
756	38
490	525
328	871
153	439
355	720
675	668
476	575
263	406
335	158
636	360
224	525
698	260
214	840
182	843
171	85
671	828
332	735
114	552
284	36
58	155
150	666
256	521
367	681
299	479
784	23
122	210
588	877
791	113
689	760
14	704
392	672
258	768
781	377
70	912
202	106
479	843
223	965
31	549
539	319
335	862
158	385
647	369
449	193
644	368
434	893
475	749
786	121
72	944
376	774
311	256
217	939
92	482
764	762
62	386
61	62
104	928
87	606
746	598
529	964
403	255
304	207
316	370
390	504
769	605
290	533
16	734
5	741
797	120
485	952
432	328
496	583
176	85
52	516
35	908
587	711
638	468
213	923
493	759
113	873
132	10
504	180
268	801
2	510
192	621
413	982
557	238
818	230
752	253
638	181
191	974
354	104
323	346
671	968
559	529
768	661
717	705
15	656
778	557
645	329
132	643
395	333
682	603
237	741
547	262
757	161
279	563
779	259
716	512
692	582
608	282
416	509
757	94
123	611
256	551
756	623
511	554
227	67
608	131
718	238
434	120
513	862
250	569
474	394
160	359
371	132
120	405
776	871
456	935
264	596
664	840
347	650
213	450
741	701
160	473
435	510
31	276
174	663
674	879
738	970
91	354
656	709
14	242
303	896
762	749
625	436
463	650
553	411
237	601
337	246
580	319
568	899
662	633
355	961
228	495
403	330
271	193
814	212
718	142
264	725
189	693
173	496
299	44
19	335
426	552
791	302
52	552
495	161
40	134
279	269
757	810
188	37
136	291
558	427
347	197
362	282
293	390
687	425
195	550
571	97
220	107
203	332
164	17
540	327
324	265
282	725
622	415
255	398
278	503
521	609
24	527
180	517
723	144
217	792
596	423
357	794
175	508
57	177
222	620
228	143
230	686
680	594
398	576
454	921
765	420
678	880
682	874
662	248
469	92
274	869
829	425
430	757
377	993
15	332
383	397
383	575
108	605
115	514
750	161
468	987
204	268
20	518
681	573
773	104
190	569
634	53
331	259
20	13
201	77
753	312
509	522
579	731
721	563
326	721
39	515
528	624
56	49
425	425
389	816
101	268
376	849
25	559
574	627
792	603
651	561
461	756
552	635
649	352
581	856
421	543
16	423
118	948
215	957
578	771
672	257
491	511
265	91
755	140
377	164
562	443
531	148
420	394
34	377
155	583
460	111
335	693
715	813
341	852
748	651
543	110
170	54
360	346
124	445
424	315
646	925
601	459
119	513
218	792
388	421
253	389
241	70
770	866
482	433
222	816
678	192
681	97
748	327
372	248
348	559
680	452
636	330
691	265
740	906
196	673
732	556
235	969
591	483
290	2
599	755
796	968
281	640
539	757
171	377
153	882
325	632
39	122
153	685
278	350
352	485
537	337
495	249
626	551
345	701
737	510
213	422
372	956
577	80
494	346
231	499
683	814
713	176
87	786
374	278
686	889
591	401
573	448
157	31
163	906
685	132
246	559
569	526
660	887
478	20
70	264
412	814
195	434
735	425
272	240
455	20
340	430
666	221
554	683
506	797
710	866
513	442
597	99
174	456
185	925
157	907
32	855
833	626
122	784
220	337
429	302
182	454
411	290
580	39
624	540
521	578
692	750
22	409
397	920
74	830
530	335
48	9
638	546
597	928
423	363
123	343
416	520
230	415
811	298
646	615
170	7
206	61
630	473
54	686
201	948
566	688
318	545
280	771
30	480
826	286
194	888
134	1
570	601
479	249
167	507
244	931
9	125
499	370
519	854
433	707
778	266
97	267
146	234
171	229
266	707
669	408
618	353
112	468
14	917
413	359
372	217
536	767
570	954
463	760
242	575
273	817
100	23
827	707
94	371
346	906
466	870
766	849
696	36
166	190
704	972
549	662
603	499
496	531
314	226
145	749
120	20
566	222
38	285
198	648
781	784
270	477
631	473
764	72
443	830
72	896
249	576
675	304
274	935
335	483
715	690
565	240
720	962
794	716
377	230
587	763
294	74
68	205
61	768
799	505
564	553
36	823
346	357
332	614
519	389
475	25
706	36
362	466
765	102
636	555
518	279
678	372
373	947
407	887
174	469
592	910
48	784
230	22
131	924
439	622
830	606
202	906
138	175
552	768
675	364
12	890
567	697
468	419
426	598
663	49
808	947
436	416
612	574
16	282
166	349
540	396
328	405
814	595
86	11
177	14
533	659
31	882
368	598
418	405
511	710
250	447
620	892
130	548
437	134
478	508
711	65
801	164
103	39
81	847
679	643
4	726
450	843
552	49
89	75
100	629
131	438
46	523
655	103
228	742
829	572
27	131
33	637
281	956
661	122
530	112
571	734
517	614
387	418
453	50
611	616
639	612
61	495
480	208
447	408
517	698
356	971
663	984
486	210
116	504
26	517
418	20
246	805
190	487
212	752
524	20
71	23
333	653
3	228
256	213
42	658
326	403
694	843
179	994
439	400
124	179
793	849
304	177
325	313
717	324
76	896
489	860
659	996
683	555
834	893
642	598
500	612
293	968
320	438
567	758
807	3
455	316
199	587
630	284
575	744
359	208
643	313
641	452
345	916
748	815
779	654
814	377
491	751
403	950
595	834
773	6
772	126
29	97
713	324
50	141
834	16
746	350
647	845
407	885
254	339
784	801
476	82
299	75
159	139
159	371
316	901
280	3
569	369
615	605
280	819
371	565
176	953
680	840
45	924
286	441
107	259
222	68
92	583
658	47
699	646
289	732
624	887
126	456
38	342
497	869
264	307
234	193
403	270
653	353
37	254
457	42
86	824
448	738
561	528
44	468
504	721
150	740
219	879
117	408
152	424
624	629
76	595
560	410
316	757
15	63
150	904
422	412
558	855
810	834
764	853
648	162
721	354
776	496
81	561
142	145
816	380
291	96
570	808
401	719
490	335
441	218
469	7
6	84
707	681
655	653
434	808
136	372
816	137
423	129
690	523
155	241
127	646
159	628
552	125
252	984
20	704
580	164
314	599
31	420
117	309
716	160
456	312
278	780
675	682
689	880
745	33
3	881
171	399
71	911
135	932
304	877
584	652
344	237
511	650
377	418
606	616
441	864
487	632
620	307
778	938
461	895
482	631
59	104
170	478
591	542
642	175
297	491
408	125
16	961
263	394
267	283
539	689
29	42
790	304
500	890
337	480
447	900
423	538
237	526
702	991
12	861
375	164
650	651
370	190
832	50
693	502
526	294
104	603
257	513
352	522
27	58
786	539
739	910
722	806
143	22
745	306
485	544
571	732
462	9
586	322
800	699
657	110
209	180
660	477
75	943
724	847
700	316
544	905
358	861
736	154
343	145
234	905
673	237
732	577
7	753
802	411
725	30
358	884
442	111
833	261
603	297
800	338
202	341
746	326
672	244
775	455
210	727
177	396
201	25
649	122
652	69
143	726
698	125
257	173
762	801
118	369
169	449
59	304
85	616
708	551
731	516
68	557
27	192
281	783
653	51
693	974
618	491
260	264
287	523
329	599
521	604
29	718
331	417
776	123
754	500
252	577
128	3
642	545
407	747
598	565
407	501
84	207
210	570
406	44
593	978
55	444
794	843
316	500
824	520
774	605
778	573
318	828
820	865
579	169
39	551
325	393
698	285
450	663
577	170
397	112
139	798
229	554
631	468
630	717
402	459
35	79
638	483
409	904
279	815
707	215
2	223
4	301
730	52
691	682
832	351
570	569
63	706
468	403
476	503
289	877
333	886
170	366
690	637
100	766
408	691
348	395
202	643
515	338
549	277
751	386
404	321
590	436
710	587
545	957
500	117
664	553
795	391
766	968
177	485
294	891
174	414
292	565
227	986
422	442
107	387
816	701
215	578
393	925
204	442
338	792
18	952
714	454
106	465
205	335
301	129
604	230
171	333
103	274
415	134
121	342
791	836
450	458
351	86
41	758
98	346
418	505
412	102
725	954
599	316
335	50
463	324
165	976
611	234
438	951
834	58
727	717
76	97
812	22
116	987
639	200
160	829
41	212
205	859
31	744
168	117
352	166
385	141
788	737
374	910
588	677
118	851
458	103
272	265
135	372
505	142
459	608
83	528
201	194
377	824
439	904
384	44
717	56
49	832
375	601
453	285
335	254
49	628
335	143
197	752
386	60
225	915
129	453
747	593
69	547
287	61
684	897
234	514
237	714
81	631
289	942
570	260
618	191
511	526
306	837
308	354
413	889
474	26
663	564
494	205
384	728
632	128
306	566
589	294
1	689
374	132
140	386
295	525
562	105
746	784
239	741
135	923
336	295
231	778
626	586
812	651
816	638
651	999
558	345
696	625
782	806
755	41
235	693
511	678
195	726
137	25
762	205
718	239
747	856
649	846
283	294
720	783
381	826
627	548
545	420
96	702
524	700
277	811
661	720
528	337
97	617
350	503
74	272
805	304
519	429
410	49
289	648
238	488
267	192
768	813
569	380
81	430
62	851
294	481
43	777
824	503
416	329
336	455
110	297
181	70
476	335
478	536
201	792
252	629
600	749
453	562
65	110
196	280
722	154
228	672
641	297
652	935
46	460
693	654
751	770
767	420
512	374
830	786
249	638
242	702
239	125
77	768
50	426
228	88
187	365
465	679
414	135
359	827
830	717
517	262
480	98
178	749
703	238
127	160
512	584
469	371
497	665
179	145
399	48
784	907
418	660
499	613
715	683
2	28
294	433
337	354
803	266
517	46
676	397
345	534
240	70
431	50
301	494
93	432
147	234
286	395
577	503
113	199
254	894
803	770
212	188
628	8
271	924
51	925
469	148
799	312
693	854
1	31
520	315
324	381
76	130
11	42
306	27
205	864
319	925
18	552
723	387
362	955
802	269
235	942
90	745
694	954
534	714
127	506
372	280
255	181
454	601
626	729
219	165
592	254
70	730
154	334
439	947
535	350
804	79
754	670
816	218
793	246
414	454
281	544
237	725
649	202
126	719
568	849
536	349
652	599
597	379
362	785
736	637
657	843
245	232
714	698
202	224
754	994
738	279
379	387
391	796
543	607
630	837
727	100
525	395
212	311
711	703
472	355
217	232
98	289
446	58
236	450
742	662
163	98
780	712
653	550
679	122
403	47
821	637
119	128
327	792
805	445
794	332
731	704
459	800
644	183
378	405
422	123
705	514
504	583
497	394
538	719
276	156
94	695
651	618
689	471
792	48
463	981
257	248
730	972
789	251
429	711
734	977
240	864
614	125
355	633
647	906
730	802
115	774
61	155
318	212
388	277
485	579
302	120
99	434
585	831
433	779
51	475
717	1000
736	167
536	298
50	841
745	413
378	503
691	967
808	601
478	444
402	864
356	786
432	964
466	861
578	422
229	915
79	523
88	99
66	762
319	841
286	922
230	36
797	995
540	571
730	437
315	570
3	631
508	147
581	432
371	231
288	701
587	642
252	596
719	951
697	290
688	130
173	789
279	131
702	60
490	77
91	240
315	912
387	400
605	828
708	760
489	772
238	230
769	967
312	533
174	199
91	897
191	659
753	218
573	73
317	249
410	597
38	421
328	628
650	306
419	983
509	177
763	403
489	441
754	228
617	585
508	627
534	686
718	626
22	99
142	412
655	386
230	736
175	470
136	188
107	305
359	298
511	301
538	808
21	929
85	890
35	807
479	494
63	298
798	231
632	446
278	802
324	691
440	516
777	59
443	845
562	195
165	104
75	927
771	414
10	903
389	256
770	477
43	248
202	636
288	245
323	72
427	252
209	948
393	800
531	270
775	620
487	278
804	799
296	591
448	693
277	894
755	408
56	879
516	866
728	734
598	42
496	426
350	790
347	294
502	327
424	165
416	347
715	832
79	844
175	487
242	90
460	765
114	384
160	607
591	606
126	148
515	134
712	272
463	181
682	487
471	317
113	852
534	245
473	414
771	323
543	929
113	351
485	672
704	1000
64	908
723	614
117	647
497	210
654	739
501	776
97	471
801	186
467	988
328	84
717	414
123	812
195	61
405	531
744	369
355	108
170	15
242	630
552	138
589	665
797	674
516	740
380	639
278	825
592	64
158	171
607	384
620	162
396	477
641	891
515	778
534	818
714	628
748	691
494	909
167	887
313	380
277	990
321	585
59	89
733	252
385	211
590	211
493	507
352	301
125	399
369	126
517	521
97	2
592	556
264	899
714	474
391	316
175	363
472	950
413	737
185	557
215	777
750	580
49	260
58	277
273	608
481	512
175	445
643	41
370	418
726	924
512	684
406	691
562	363
199	709
664	538
178	113
476	570
499	162
359	744
341	336
144	336
694	853
764	888
222	18
663	674
311	61
615	657
235	338
723	512
461	433
93	570
750	284
242	636
807	230
205	461
386	302
226	932
29	441
721	749
818	749
651	551
604	924
80	392
366	540
727	108
475	869
214	489
657	96
189	509
76	43
528	137
20	862
677	198
537	217
730	528
472	532
181	309
222	180
790	281
761	536
417	861
259	60
345	775
754	737
403	799
620	951
539	605
235	798
31	486
761	350
399	943
317	121
635	275
652	985
356	389
304	700
615	211
471	395
76	418
205	128
573	301
287	625
494	767
167	447
663	444
477	656
829	953
554	309
495	773
229	581
795	155
71	747
93	292
66	676
612	925
444	942
692	923
420	916
678	240
801	740
251	756
389	742
468	927
789	733
543	856
501	768
239	272
359	424
104	835
247	269
190	259
68	39
640	184
329	952
206	546
47	663
740	402
208	782
295	551
458	905
357	506
553	615
714	770
177	233
95	673
273	904
749	514
376	301
329	786
371	513
816	919
201	15
561	571
710	565
111	432
160	98
300	681
689	221
70	949
260	199
194	71
477	383
261	240
224	577
187	682
823	736
193	534
280	988
422	360
516	598
342	136
497	643
396	819
58	936
161	757
591	10
259	872
183	468
36	607
722	819
206	626
346	519
484	490
678	908
82	901
28	716
158	820
496	554
554	669
433	178
659	575
77	5
776	543
235	703
514	222
517	314
756	685
105	827
75	968
54	557
580	493
281	172
288	786
246	978
431	17
180	503
402	87
833	225
134	438
670	658
174	888
676	623
510	413
76	406
813	845
738	98
765	926
87	377
187	85
171	685
809	376
188	121
786	980
558	722
197	910
537	37
585	510
641	757
270	201
786	871
721	297
118	794
53	351
441	21
103	527
734	659
163	929
335	462
624	736
584	148
714	289
730	904
112	801
311	455
755	888
530	205
799	109
509	867
313	486
597	737
470	268
452	871
592	304
401	815
431	721
355	791
221	472
486	591
339	165
422	313
492	814
87	102
417	785
388	803
309	220
748	770
657	650
831	505
522	10
307	875
96	182
787	405
514	239
383	77
828	522
52	783
363	712
609	351
691	816
745	16
783	648
357	414
818	980
798	247
490	839
319	645
409	611
661	182
780	629
648	412
472	377
263	124
517	787
567	924
602	215
263	565
730	591
660	805
116	658
18	219
180	834
53	123
483	662
369	418
546	660
543	395
525	720
266	593
280	270
743	265
547	476
215	582
801	839
336	286
348	168
321	975
715	272
210	932
588	480
237	606
67	986
380	52
216	604
630	191
730	546
232	775
832	380
125	954
350	732
615	284
125	387
179	13
157	90
315	743
100	600
489	704
387	383
446	440
230	751
43	768
516	480
526	342
144	606
378	833
464	314
444	100
383	464
481	596
626	81
810	891
669	592
232	490
582	241
576	702
542	547
295	633
268	267
698	418
473	340
296	323
669	646
718	248
802	204
758	277
750	814
689	62
799	124
93	653
385	530
810	561
671	684
414	782
80	429
693	717
99	364
710	625
2	19
684	270
475	896
17	730
811	946
401	72
173	870
451	985
834	259
578	421
330	499
340	761
751	769
91	165
495	526
248	677
499	981
196	276
526	650
85	396
759	542
95	519
491	28
508	971
468	797
394	575
824	334
240	953
636	253
245	819
725	547
671	96
21	879
266	639
255	951
351	660
241	569
149	846
3	102
249	748
106	516
108	239
610	111
131	339
62	600
717	610
617	397
526	422
363	856
747	550
134	408
12	704
342	616
556	278
414	862
432	411
223	256
451	914
789	16
516	10
402	409
98	299
227	171
331	661
26	758
555	746
783	991
297	983
102	88
469	494
141	752
270	415
573	247
722	463
512	966
766	992
537	531
221	598
537	41
398	404
742	118
463	945
471	250
245	627
398	806
793	705
757	899
274	67
34	949
410	775
103	626
452	443
476	104
500	174
786	322
745	662
491	633
149	215
680	471
669	383
780	97
823	272
79	45
676	501
480	640
763	694
686	873
727	205
113	983
748	114
170	311
742	530
435	790
757	722
388	175
158	381
473	779
446	514
126	780
649	55
384	445
157	318
74	191
548	644
35	123
550	292
295	690
701	258
174	60
340	755
747	596
389	45
233	210
831	110
626	278
327	378
579	345
320	263
22	925
73	88
464	281
314	298
296	894
416	74
519	2
246	914
600	220
266	257
28	91
195	602
790	1000
327	900
744	401
150	269
516	792
807	344
391	99
581	464
20	644
704	302
390	317
459	621
694	151
395	102
304	78
90	88
240	923
531	987
805	346
654	922
332	506
774	224
412	30
783	220
726	110
689	734
370	705
723	737
663	867
462	231
706	81
720	668
104	452
750	544
747	883
803	106
99	925
158	123
245	137
659	30
493	488
228	855
735	388
118	39
332	507
430	900
354	344
505	514
156	607
775	330
414	402
739	339
830	815
110	287
738	29
771	697
102	512
75	195
365	355
760	14
754	194
238	254
541	231
337	356
123	667
222	283
569	606
561	921
401	403
204	456
378	94
665	793
674	818
115	715
472	630
488	280
703	863
\.


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Order" (id, transaction_date, taxes_sum, client_id) FROM stdin;
1	2002-06-30	236	129
2	2016-12-02	459	47
3	2010-01-19	224	180
4	2020-03-16	7	25
5	2003-09-02	152	10
6	2001-04-07	452	171
7	2013-11-17	131	146
8	2016-11-04	40	121
9	2020-01-28	373	80
10	2002-08-23	404	143
11	2020-10-19	136	176
12	2002-06-09	392	44
13	2019-04-17	226	34
14	2013-10-29	331	112
15	2016-11-04	90	93
16	2009-01-16	454	151
17	2019-11-21	213	98
18	2010-05-13	216	197
19	2004-12-05	60	178
20	2013-07-06	324	50
21	2006-10-06	411	82
22	2013-10-10	334	179
23	2011-10-11	367	86
24	2015-12-14	367	54
25	2017-07-22	408	18
26	2018-08-31	124	73
27	2008-02-06	372	110
28	2000-12-17	496	70
29	2012-12-10	481	194
30	2002-04-26	379	58
31	2005-10-14	205	46
32	2014-01-20	275	82
33	2006-07-12	423	125
34	2009-04-25	356	139
35	2016-08-15	448	21
36	2001-07-16	473	36
37	2006-02-24	297	71
38	2017-08-26	222	175
39	2015-07-25	449	140
40	2003-09-12	297	167
41	2009-05-25	142	142
42	2018-03-04	321	45
43	2014-06-22	264	185
44	2020-06-10	347	119
45	2019-03-28	62	80
46	2018-11-11	371	70
47	2008-09-21	468	98
48	2005-10-19	237	110
49	2018-10-28	387	191
50	2018-04-29	42	102
51	2001-01-23	369	18
52	2002-06-04	397	137
53	2004-08-05	58	109
54	2014-01-11	264	32
55	2001-09-07	481	68
56	2017-02-22	253	75
57	2020-01-20	156	13
58	2009-04-30	265	117
59	2005-07-16	432	132
60	2017-12-05	366	5
61	2015-10-04	495	68
62	2011-01-24	461	175
63	2016-06-13	291	64
64	2007-12-19	37	96
65	2019-04-29	9	96
66	2019-07-11	326	39
67	2012-10-13	209	133
68	2015-08-19	63	81
69	2012-07-06	188	147
70	2004-11-20	219	158
71	2003-02-10	81	164
72	2008-11-03	52	19
73	2007-09-24	139	126
74	2006-11-05	442	17
75	2015-05-21	361	39
76	2010-01-06	140	78
77	2019-09-11	445	101
78	2009-12-23	462	13
79	2007-12-31	38	77
80	2003-03-02	471	180
81	2005-04-13	313	128
82	2005-08-14	262	82
83	2012-04-05	222	149
84	2002-11-11	17	76
85	2010-01-15	136	52
86	2005-05-20	269	152
87	2011-09-09	189	72
88	2018-09-13	111	63
89	2020-03-26	471	22
90	2011-03-13	103	76
91	2010-09-17	217	126
92	2013-10-09	53	70
93	2020-10-14	55	80
94	2000-09-29	132	28
95	2000-05-24	478	52
96	2018-12-02	261	156
97	2015-12-06	420	181
98	2002-06-26	447	84
99	2010-01-10	255	154
100	2012-02-16	166	131
101	2010-12-04	327	46
102	2016-11-30	353	195
103	2020-05-23	221	124
104	2019-03-19	450	84
105	2003-10-02	163	171
106	2003-09-08	379	5
107	2013-01-02	60	152
108	2010-01-27	279	167
109	2000-04-06	202	89
110	2011-03-16	105	79
111	2012-07-06	202	142
112	2018-02-26	297	48
113	2007-11-25	30	19
114	2007-10-27	279	168
115	2011-12-26	12	59
116	2014-06-16	31	94
117	2007-09-13	235	166
118	2013-05-20	250	95
119	2005-11-27	314	157
120	2011-05-15	239	71
121	2010-01-26	430	35
122	2009-11-03	225	196
123	2006-03-05	210	32
124	2002-10-22	372	25
125	2004-05-21	454	13
126	2008-12-05	200	135
127	2016-07-11	249	111
128	2003-09-23	42	150
129	2008-05-03	131	65
130	2003-05-28	146	164
131	2007-07-01	82	7
132	2009-10-02	244	19
133	2018-09-02	266	129
134	2014-02-28	175	80
135	2009-02-05	395	99
136	2003-11-23	125	86
137	2014-09-15	121	55
138	2010-08-20	433	168
139	2018-03-02	5	179
140	2016-07-03	214	26
141	2009-12-31	443	136
142	2016-04-02	365	183
143	2013-07-03	195	180
144	2011-06-20	357	171
145	2010-03-14	223	86
146	2009-05-31	320	112
147	2010-09-11	500	196
148	2013-04-15	7	192
149	2016-03-08	196	111
150	2002-04-11	136	30
151	2008-11-01	358	115
152	2012-03-24	113	18
153	2007-06-17	273	21
154	2006-01-16	464	172
155	2009-02-07	224	77
156	2000-11-01	61	43
157	2012-08-31	427	69
158	2012-09-24	8	173
159	2012-08-01	462	157
160	2002-03-27	491	69
161	2019-03-09	266	92
162	2002-05-03	300	96
163	2018-07-08	78	66
164	2017-05-06	291	162
165	2019-09-25	414	138
166	2013-04-13	304	62
167	2019-09-02	59	152
168	2003-10-15	230	7
169	2008-11-28	37	90
170	2010-06-10	358	53
171	2017-05-18	393	44
172	2009-07-07	449	141
173	2011-10-28	280	120
174	2013-07-26	460	191
175	2008-04-21	80	122
176	2020-06-30	484	154
177	2010-11-29	138	39
178	2000-12-21	348	156
179	2001-01-04	265	137
180	2001-07-08	8	52
181	2007-04-27	227	144
182	2006-05-13	131	182
183	2003-11-26	410	48
184	2009-12-27	233	167
185	2002-04-28	218	159
186	2011-04-22	465	185
187	2007-04-01	257	96
188	2013-02-06	201	123
189	2008-07-07	169	82
190	2019-06-27	328	48
191	2008-07-03	168	40
192	2020-12-09	242	188
193	2018-09-08	326	39
194	2015-12-31	472	92
195	2018-05-06	284	37
196	2002-02-15	414	62
197	2012-08-25	465	135
198	2011-02-16	493	161
199	2007-06-21	314	69
200	2016-07-18	104	91
201	2001-06-30	187	43
202	2006-10-16	246	96
203	2016-06-02	145	46
204	2007-03-13	284	83
205	2005-03-01	156	66
206	2016-08-04	476	115
207	2018-05-11	377	150
208	2003-07-28	19	24
209	2005-07-13	120	100
210	2020-08-17	111	40
211	2013-02-01	286	139
212	2020-04-19	486	86
213	2019-08-14	147	200
214	2014-08-10	81	96
215	2005-04-04	174	46
216	2020-07-19	95	66
217	2013-01-02	411	180
218	2006-08-08	394	108
219	2005-02-13	483	95
220	2006-07-07	275	188
221	2017-11-21	487	161
222	2015-08-25	395	155
223	2012-01-12	45	2
224	2005-11-14	79	160
225	2013-10-26	43	127
226	2015-11-05	263	44
227	2002-03-14	291	179
228	2010-03-19	38	108
229	2000-08-06	453	74
230	2018-12-24	309	7
231	2012-03-15	255	175
232	2012-10-08	53	144
233	2008-06-02	353	118
234	2006-09-15	39	99
235	2005-02-27	211	173
236	2019-05-20	175	6
237	2006-11-20	311	112
238	2015-05-04	208	200
239	2007-06-06	314	21
240	2004-06-10	255	24
241	2015-02-17	280	76
242	2011-09-27	309	13
243	2007-04-10	144	36
244	2020-12-04	300	166
245	2004-01-05	250	82
246	2007-06-23	477	92
247	2008-10-29	125	152
248	2000-10-20	294	181
249	2000-11-22	494	112
250	2011-05-24	257	47
251	2012-06-19	353	13
252	2013-02-05	335	50
253	2008-05-06	77	72
254	2004-12-20	57	156
255	2002-07-31	463	124
256	2009-09-09	193	43
257	2016-10-07	353	112
258	2019-05-22	294	142
259	2006-07-09	253	2
260	2019-06-02	243	166
261	2007-09-29	431	18
262	2018-01-06	445	48
263	2006-08-03	437	63
264	2020-06-01	264	143
265	2005-09-18	213	30
266	2008-02-25	170	75
267	2011-08-22	483	21
268	2006-09-20	225	67
269	2016-06-06	369	166
270	2017-02-23	126	168
271	2015-02-08	200	139
272	2007-01-10	499	125
273	2015-06-07	282	83
274	2000-11-09	388	108
275	2002-12-24	351	52
276	2014-03-23	365	80
277	2010-10-21	303	71
278	2020-01-17	71	127
279	2011-08-11	296	107
280	2019-09-13	242	30
281	2000-04-13	303	101
282	2010-11-19	351	185
283	2016-12-17	340	45
284	2007-09-18	313	113
285	2003-10-24	417	102
286	2009-11-27	51	7
287	2004-05-05	170	98
288	2007-01-28	59	193
289	2018-08-12	1	100
290	2018-10-06	313	56
291	2009-06-26	29	50
292	2007-04-02	221	11
293	2016-11-02	283	187
294	2004-01-22	150	50
295	2002-04-15	471	175
296	2004-06-28	336	11
297	2019-12-26	341	58
298	2013-12-11	319	153
299	2014-05-30	350	57
300	2013-01-08	296	136
301	2007-03-26	45	95
302	2008-10-05	463	143
303	2001-07-12	427	4
304	2005-05-31	270	95
305	2018-02-09	260	98
306	2007-12-02	455	166
307	2002-11-05	302	37
308	2015-03-18	419	38
309	2003-11-26	158	141
310	2000-05-13	125	187
311	2015-03-23	182	44
312	2014-07-16	18	170
313	2001-07-09	187	72
314	2014-07-13	339	51
315	2004-03-01	291	10
316	2001-01-05	438	69
317	2015-08-22	294	194
318	2015-04-16	413	50
319	2017-08-25	109	67
320	2009-04-30	441	75
321	2010-04-07	270	59
322	2019-07-25	425	100
323	2004-10-14	446	198
324	2003-03-17	355	138
325	2017-01-22	143	143
326	2016-07-11	294	62
327	2014-01-26	241	46
328	2003-12-24	447	114
329	2014-02-25	347	194
330	2008-11-15	306	56
331	2007-02-05	365	114
332	2008-11-01	251	100
333	2007-05-15	485	188
334	2007-08-01	435	11
335	2012-05-15	94	178
336	2016-02-03	110	72
337	2010-05-09	354	51
338	2003-09-07	325	180
339	2006-02-11	359	142
340	2013-12-25	418	191
341	2016-04-12	500	118
342	2009-01-15	285	152
343	2013-09-12	269	116
344	2014-07-14	342	184
345	2007-05-15	456	17
346	2014-10-20	449	174
347	2003-09-25	415	140
348	2011-08-29	294	52
349	2020-11-12	454	10
350	2001-03-27	496	24
351	2018-08-02	351	52
352	2016-04-01	23	105
353	2008-08-27	327	162
354	2000-11-24	449	148
355	2017-08-18	197	188
356	2020-04-12	430	143
357	2015-02-11	462	171
358	2004-09-07	45	174
359	2008-04-01	253	64
360	2001-01-08	134	29
361	2009-06-23	132	87
362	2005-02-03	101	53
363	2005-03-27	45	158
364	2013-04-20	315	13
365	2017-06-22	227	23
366	2013-03-26	75	108
367	2013-01-31	262	130
368	2011-06-12	32	191
369	2004-09-11	379	199
370	2019-06-12	191	133
371	2006-04-11	46	121
372	2014-11-18	58	87
373	2016-09-13	212	180
374	2004-02-09	73	103
375	2007-07-16	195	156
376	2012-08-11	171	36
377	2010-08-19	448	80
378	2014-03-10	300	12
379	2014-11-07	392	76
380	2001-10-11	496	67
381	2008-10-03	373	96
382	2002-04-27	131	103
383	2005-11-03	160	105
384	2015-04-01	161	111
385	2004-03-05	204	21
386	2006-09-22	397	178
387	2000-01-08	350	16
388	2012-10-02	463	164
389	2009-07-25	178	56
390	2014-02-08	183	165
391	2003-05-04	96	155
392	2005-05-08	206	118
393	2002-10-13	272	118
394	2008-09-26	458	106
395	2016-05-08	294	89
396	2011-03-19	63	142
397	2017-11-22	287	190
398	2006-05-03	204	184
399	2001-05-20	323	64
400	2005-07-04	82	60
401	2010-01-23	113	128
402	2009-12-17	412	157
403	2014-12-20	386	5
404	2017-11-17	418	91
405	2012-09-09	368	89
406	2009-02-11	10	30
407	2002-01-02	29	142
408	2010-06-23	427	6
409	2019-01-15	228	24
410	2015-06-15	352	10
411	2020-12-18	111	25
412	2006-09-04	485	75
413	2011-08-04	159	76
414	2003-12-24	401	163
415	2010-10-29	184	129
416	2006-09-21	264	143
417	2018-05-13	401	18
418	2011-05-29	81	126
419	2004-04-03	494	157
420	2007-03-15	163	16
421	2012-06-11	28	121
422	2000-05-28	34	111
423	2007-12-26	46	49
424	2017-12-19	281	89
425	2014-12-25	27	13
426	2012-10-29	185	96
427	2015-04-16	448	100
428	2001-05-20	38	136
429	2002-02-02	370	140
430	2015-07-25	18	90
431	2019-12-20	5	82
432	2018-12-10	32	155
433	2008-02-01	208	140
434	2015-08-30	436	116
435	2007-02-11	349	145
436	2005-03-26	232	146
437	2011-09-30	348	199
438	2013-06-28	364	21
439	2010-09-01	179	56
440	2005-11-27	337	69
441	2001-05-15	411	7
442	2017-02-25	477	27
443	2009-09-18	24	159
444	2017-10-23	462	65
445	2014-09-07	74	98
446	2012-03-09	44	133
447	2008-01-14	262	53
448	2013-08-31	297	40
449	2019-11-05	112	9
450	2000-07-19	344	85
451	2004-09-21	500	11
452	2007-10-14	12	28
453	2013-02-01	475	159
454	2005-03-24	27	121
455	2006-02-18	277	140
456	2000-01-27	443	111
457	2018-10-22	474	166
458	2016-05-25	22	89
459	2008-10-17	449	128
460	2008-03-16	484	20
461	2015-04-22	207	180
462	2000-11-30	303	49
463	2006-07-10	495	40
464	2007-04-16	198	116
465	2018-09-06	234	12
466	2015-02-02	341	153
467	2018-04-19	433	145
468	2017-05-19	282	49
469	2008-10-25	87	47
470	2004-02-21	21	175
471	2001-03-19	425	42
472	2006-04-28	415	144
473	2006-10-25	99	141
474	2014-05-23	165	48
475	2019-02-24	137	80
476	2017-12-25	434	159
477	2018-09-03	182	165
478	2002-05-12	481	74
479	2019-08-26	368	2
480	2012-07-17	413	78
481	2013-07-09	73	54
482	2015-01-22	418	28
483	2018-11-20	418	178
484	2011-10-07	473	52
485	2010-03-29	266	34
486	2001-06-13	378	135
487	2010-06-19	210	188
488	2015-03-31	32	5
489	2018-10-30	264	16
490	2006-11-13	160	62
491	2000-05-01	141	169
492	2014-07-06	217	6
493	2009-06-18	15	76
494	2015-04-10	281	121
495	2005-12-11	193	9
496	2004-06-20	382	87
497	2002-11-03	343	181
498	2013-08-08	5	125
499	2016-06-08	369	67
500	2003-02-06	419	172
501	2000-01-08	437	87
502	2002-04-17	482	135
503	2014-06-24	71	20
504	2005-07-30	54	105
505	2016-08-16	463	110
506	2004-10-27	342	88
507	2000-03-06	116	195
508	2000-10-25	393	50
509	2002-01-21	127	81
510	2020-07-15	471	93
511	2015-05-30	169	181
512	2016-05-27	204	165
513	2008-12-30	48	60
514	2011-06-22	401	122
515	2002-07-29	491	88
516	2009-04-12	322	18
517	2007-05-20	107	160
518	2016-09-05	402	76
519	2016-01-20	482	27
520	2019-11-19	50	161
521	2010-09-08	7	70
522	2010-09-11	376	88
523	2002-03-05	196	192
524	2004-08-23	105	94
525	2018-04-28	87	107
526	2014-03-05	65	127
527	2009-10-31	83	165
528	2019-07-03	438	15
529	2001-09-19	56	35
530	2011-04-24	399	9
531	2009-08-24	445	32
532	2010-11-24	208	102
533	2001-08-10	162	26
534	2000-08-13	482	65
535	2015-10-03	233	185
536	2008-01-09	251	43
537	2010-12-21	431	50
538	2020-11-29	324	146
539	2020-04-10	21	193
540	2016-06-16	115	129
541	2014-12-19	27	152
542	2016-10-09	385	156
543	2006-09-14	218	51
544	2016-04-02	83	75
545	2015-04-17	420	112
546	2000-07-13	365	184
547	2002-06-25	293	9
548	2009-05-14	105	139
549	2013-05-05	473	62
550	2009-12-24	443	19
551	2001-04-19	38	141
552	2015-11-14	202	186
553	2008-08-12	280	66
554	2002-03-29	293	154
555	2010-09-25	156	117
556	2012-10-17	190	55
557	2001-11-25	499	37
558	2006-11-14	260	78
559	2011-03-23	235	1
560	2001-07-14	464	38
561	2007-12-03	181	42
562	2018-04-12	5	57
563	2012-05-25	464	4
564	2007-08-31	199	151
565	2011-03-12	55	196
566	2010-07-25	241	79
567	2003-05-04	240	21
568	2015-10-24	456	2
569	2020-01-27	10	103
570	2020-06-18	392	33
571	2010-06-04	170	129
572	2012-07-18	90	42
573	2005-03-16	2	137
574	2019-10-28	112	164
575	2019-12-15	260	38
576	2011-09-02	288	195
577	2019-10-04	429	148
578	2001-12-26	88	144
579	2019-12-12	499	86
580	2008-03-29	222	72
581	2006-02-18	37	142
582	2005-11-04	438	15
583	2018-02-01	350	106
584	2019-07-07	52	56
585	2015-03-02	259	145
586	2006-12-01	273	69
587	2008-02-17	109	78
588	2008-08-08	420	176
589	2011-02-08	450	142
590	2002-08-07	171	42
591	2001-07-28	434	111
592	2020-01-16	119	165
593	2010-02-05	349	74
594	2011-12-22	359	183
595	2016-11-23	320	159
596	2017-07-26	319	122
597	2016-03-18	183	60
598	2009-12-19	331	96
599	2017-04-28	171	174
600	2000-06-14	44	3
601	2012-07-29	235	63
602	2013-05-05	488	17
603	2000-05-05	121	82
604	2016-06-04	69	49
605	2006-07-12	318	20
606	2002-01-19	84	18
607	2012-03-19	179	66
608	2004-09-03	10	6
609	2014-04-11	15	27
610	2004-09-07	407	58
611	2005-12-17	275	117
612	2004-10-25	135	105
613	2007-01-18	224	194
614	2002-06-01	95	78
615	2014-03-28	266	55
616	2014-09-22	311	119
617	2017-03-28	479	146
618	2020-07-26	421	102
619	2011-01-12	485	54
620	2018-12-24	19	117
621	2000-09-02	220	79
622	2004-02-19	148	130
623	2014-12-26	426	165
624	2009-05-14	64	15
625	2000-09-21	180	26
626	2004-12-14	222	139
627	2011-09-28	205	90
628	2014-03-17	395	12
629	2007-08-26	249	106
630	2000-11-26	176	29
631	2006-08-28	8	103
632	2005-08-13	414	58
633	2020-03-09	238	82
634	2004-07-09	43	97
635	2001-12-01	284	191
636	2007-08-07	243	50
637	2017-03-05	168	62
638	2001-08-04	434	81
639	2002-01-10	54	193
640	2019-11-04	148	120
641	2005-09-12	302	33
642	2015-11-21	204	130
643	2008-06-10	293	123
644	2000-06-25	198	188
645	2013-01-02	393	101
646	2010-12-22	207	18
647	2018-02-22	473	8
648	2016-06-13	246	149
649	2008-04-23	216	156
650	2018-02-03	231	118
651	2019-09-21	481	86
652	2003-03-14	470	60
653	2004-04-17	261	35
654	2006-07-30	48	73
655	2009-09-21	294	155
656	2001-06-02	32	20
657	2010-03-11	74	180
658	2012-10-28	370	169
659	2005-10-17	433	134
660	2007-01-09	299	58
661	2020-01-04	92	100
662	2009-10-18	172	66
663	2016-06-04	417	20
664	2003-03-13	212	113
665	2015-07-14	441	7
666	2005-04-23	425	148
667	2002-12-01	150	54
668	2005-06-11	43	154
669	2009-08-26	63	124
670	2018-10-07	267	85
671	2016-07-14	348	156
672	2003-09-07	190	171
673	2010-07-11	193	7
674	2010-11-05	5	200
675	2009-09-28	374	109
676	2004-02-17	117	183
677	2018-02-22	139	106
678	2016-09-01	85	180
679	2013-09-21	94	78
680	2013-05-08	217	97
681	2015-12-09	498	17
682	2009-05-06	341	196
683	2014-06-11	102	195
684	2006-03-28	134	178
685	2000-01-17	404	33
686	2001-05-23	325	24
687	2006-11-29	462	112
688	2006-09-13	17	134
689	2020-02-08	124	18
690	2006-06-05	14	58
691	2015-05-05	396	84
692	2006-12-03	217	93
693	2008-07-10	299	87
694	2008-10-02	433	31
695	2002-05-31	159	112
696	2006-08-08	177	137
697	2005-04-19	383	126
698	2007-11-18	16	173
699	2007-12-11	161	136
700	2015-03-07	67	99
701	2008-10-07	364	8
702	2001-10-02	68	105
703	2001-11-07	224	105
704	2002-03-31	214	21
705	2012-11-09	106	20
706	2013-08-09	217	147
707	2000-06-04	252	175
708	2000-05-31	29	69
709	2019-09-01	227	181
710	2007-06-26	116	167
711	2009-07-29	411	42
712	2020-09-24	338	57
713	2008-07-12	232	10
714	2016-04-05	423	12
715	2019-12-18	342	138
716	2002-05-11	484	135
717	2012-01-12	197	80
718	2006-09-10	251	153
719	2003-07-19	315	88
720	2005-07-14	89	186
721	2007-11-07	156	121
722	2016-04-14	345	26
723	2014-06-23	143	17
724	2018-03-13	41	164
725	2004-08-21	450	100
726	2010-03-11	164	57
727	2007-11-23	120	156
728	2000-04-30	119	51
729	2002-08-06	159	168
730	2007-01-09	408	40
731	2000-08-22	184	45
732	2000-01-27	130	38
733	2006-11-25	423	3
734	2005-07-01	226	120
735	2011-08-30	480	136
736	2007-12-31	22	195
737	2011-07-30	317	154
738	2015-02-02	481	146
739	2016-04-08	466	80
740	2007-04-19	216	21
741	2007-12-09	145	84
742	2008-06-18	448	20
743	2008-05-31	201	112
744	2012-09-23	262	152
745	2017-04-25	470	163
746	2013-03-26	198	63
747	2007-05-29	473	183
748	2016-12-10	473	43
749	2007-04-20	367	35
750	2018-10-17	250	85
751	2016-09-18	456	47
752	2007-07-23	344	140
753	2017-05-31	394	139
754	2011-04-24	200	82
755	2016-09-25	85	49
756	2014-09-01	396	54
757	2003-09-21	485	173
758	2019-09-01	159	153
759	2009-09-05	464	149
760	2000-10-04	12	191
761	2004-08-07	495	154
762	2006-02-26	232	186
763	2016-02-22	128	31
764	2005-11-26	443	90
765	2010-07-22	363	110
766	2019-11-16	191	16
767	2002-01-30	115	73
768	2000-12-07	390	144
769	2009-10-12	442	170
770	2001-06-06	155	43
771	2012-07-20	379	121
772	2012-10-24	429	51
773	2003-10-27	284	102
774	2016-03-17	297	15
775	2002-09-22	212	2
776	2006-09-24	91	37
777	2011-08-16	287	99
778	2019-10-05	68	20
779	2011-05-07	474	35
780	2001-08-06	18	15
781	2008-01-01	407	197
782	2010-12-30	364	29
783	2007-02-03	75	74
784	2011-06-20	459	114
785	2004-06-08	246	97
786	2013-09-26	358	23
787	2015-01-01	318	145
788	2005-01-30	278	46
789	2005-01-14	200	89
790	2014-12-30	416	106
791	2000-06-04	420	170
792	2017-03-17	219	162
793	2017-05-30	443	92
794	2007-07-28	104	178
795	2008-10-11	178	103
796	2017-09-02	411	196
797	2008-02-16	474	159
798	2013-02-11	249	149
799	2009-10-09	13	107
800	2015-12-16	449	162
801	2009-06-26	40	20
802	2008-07-08	415	62
803	2016-07-18	312	146
804	2001-01-31	354	55
805	2017-04-13	245	50
806	2001-08-04	384	126
807	2017-09-16	255	123
808	2006-01-22	413	196
809	2010-05-14	293	184
810	2009-04-28	381	9
811	2000-02-10	75	15
812	2008-06-18	119	66
813	2019-10-14	285	12
814	2000-08-13	348	137
815	2017-09-02	454	25
816	2012-01-08	396	184
817	2001-07-13	226	154
818	2009-04-28	454	25
819	2010-08-23	84	144
820	2019-10-07	331	196
821	2014-12-19	357	116
822	2014-08-05	393	119
823	2013-02-28	186	187
824	2018-03-31	342	54
825	2002-03-13	203	79
826	2007-12-20	201	102
827	2019-01-13	152	90
828	2010-07-26	63	119
829	2005-12-08	237	115
830	2001-06-15	425	103
831	2020-04-22	260	119
832	2005-06-24	192	78
833	2011-07-18	335	19
834	2013-11-02	494	132
835	2012-04-21	318	89
836	2004-08-12	188	121
837	2011-03-26	267	123
838	2001-09-21	494	14
839	2012-06-10	424	126
840	2010-11-30	461	191
841	2009-10-18	261	106
842	2012-07-06	320	25
843	2003-05-21	428	155
844	2012-10-26	94	53
845	2007-06-19	283	1
846	2016-04-16	380	22
847	2002-09-30	91	9
848	2012-04-04	209	2
849	2015-11-07	485	113
850	2009-10-19	27	77
851	2005-11-23	342	18
852	2018-07-10	233	100
853	2013-06-19	434	106
854	2004-02-03	373	131
855	2004-02-11	462	19
856	2008-03-27	193	122
857	2015-07-19	65	178
858	2020-03-08	462	190
859	2009-09-28	487	52
860	2006-03-03	98	73
861	2006-07-08	475	93
862	2019-01-24	11	59
863	2009-10-06	78	113
864	2001-04-20	98	38
865	2020-11-08	75	133
866	2001-07-16	31	192
867	2019-08-30	69	35
868	2014-10-17	350	150
869	2017-08-13	283	148
870	2007-03-16	157	105
871	2017-04-19	439	21
872	2013-07-14	400	65
873	2000-07-07	393	137
874	2015-06-05	410	191
875	2014-01-08	409	165
876	2013-12-03	446	27
877	2001-12-04	457	23
878	2007-07-08	406	74
879	2019-02-25	451	130
880	2020-01-08	493	176
881	2015-11-22	483	44
882	2015-07-25	189	131
883	2001-07-06	480	176
884	2013-10-12	226	170
885	2009-10-23	492	11
886	2015-03-02	461	152
887	2013-09-22	104	49
888	2004-02-28	393	141
889	2019-02-14	483	37
890	2016-03-24	411	15
891	2001-07-20	352	148
892	2007-12-03	66	108
893	2013-02-22	124	41
894	2009-03-15	221	129
895	2012-08-09	392	132
896	2008-09-25	392	21
897	2014-10-15	2	171
898	2011-10-01	54	32
899	2010-07-07	372	94
900	2002-09-08	312	16
901	2006-10-08	100	70
902	2001-08-01	460	169
903	2003-08-17	114	152
904	2019-08-26	237	75
905	2010-09-14	194	53
906	2010-04-18	161	126
907	2000-02-19	36	184
908	2015-01-30	347	196
909	2002-04-11	224	2
910	2011-06-04	100	183
911	2002-10-01	339	182
912	2007-09-04	447	175
913	2007-07-27	273	89
914	2004-08-13	412	163
915	2020-08-28	136	35
916	2009-12-29	253	148
917	2019-07-16	162	183
918	2020-09-02	208	142
919	2017-12-24	411	19
920	2017-08-27	93	33
921	2009-07-07	271	142
922	2001-07-11	107	51
923	2003-08-14	377	69
924	2004-11-03	167	192
925	2018-08-13	134	72
926	2014-08-22	465	84
927	2005-10-09	15	91
928	2010-12-16	421	87
929	2000-11-15	460	69
930	2006-02-26	89	41
931	2019-04-30	310	6
932	2008-01-20	57	15
933	2013-12-30	207	15
934	2006-02-04	480	69
935	2010-09-01	455	176
936	2012-02-20	357	1
937	2007-08-25	490	146
938	2009-05-11	326	130
939	2006-06-02	19	155
940	2009-01-01	257	180
941	2009-04-07	72	96
942	2009-11-01	459	191
943	2012-02-27	405	31
944	2003-02-13	65	182
945	2010-07-08	419	97
946	2010-10-12	455	46
947	2012-01-16	156	135
948	2011-04-18	233	21
949	2004-09-07	268	175
950	2002-12-21	358	196
951	2015-12-07	25	2
952	2000-05-01	328	31
953	2006-05-20	421	186
954	2010-06-04	220	165
955	2012-07-27	19	147
956	2001-06-21	180	13
957	2020-04-15	491	14
958	2016-04-28	256	188
959	2008-01-21	462	21
960	2020-08-22	158	150
961	2016-09-30	116	183
962	2011-10-26	384	177
963	2006-11-27	11	163
964	2002-08-13	163	11
965	2019-06-06	200	140
966	2003-08-19	343	55
967	2004-09-28	377	16
968	2003-12-24	183	108
969	2014-06-21	54	95
970	2001-01-09	291	158
971	2008-09-24	431	166
972	2010-05-18	158	109
973	2000-12-05	399	179
974	2001-07-18	17	43
975	2015-09-28	265	123
976	2018-01-05	458	4
977	2018-09-01	33	147
978	2018-02-14	400	150
979	2010-04-26	171	88
980	2013-05-20	453	49
981	2008-04-02	69	91
982	2006-07-18	215	46
983	2017-07-05	469	31
984	2004-04-28	482	53
985	2003-10-27	52	134
986	2001-12-19	230	139
987	2016-09-15	42	30
988	2011-02-08	8	119
989	2019-05-11	369	111
990	2008-04-12	232	73
991	2016-09-13	391	112
992	2010-10-24	333	91
993	2009-05-03	319	15
994	2018-03-30	275	88
995	2002-05-29	37	102
996	2010-08-07	7	182
997	2001-02-12	340	121
998	2014-12-22	409	120
999	2016-08-27	48	170
1000	2012-05-30	464	50
\.


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Product" (id, name, brand, manufacturer, manufacture_date, cost) FROM stdin;
1	Sanus VLF410B1 10-Inch Super Slim Full-Motion Mount for 37 - 84 Inches TV's	Sanus		2015-04-13	104
2	Boytone - 2500W 2.1-Ch. Home Theater System - Black Diamond	Boytone	Boytone	2015-05-18	64
3	DENAQ - AC Adapter for TOSHIBA SATELLITE 1700 1710 1715 1730 1735 1750 1755 1955 3000 3005 A100 M30X M35X - Black	DENAQ	Dantona	2015-03-18	23
4	DreamWave - Tremor Portable Bluetooth Speaker - Green,Black	DreamWave		2015-10-17	290
5	NS-SP1800BL 5.1-Channel Home Theater System (Black)	Yamaha	YAMAHA	2015-07-03	244
6	Universal Remote Control - 48-Device Universal Remote - Black	Universal Remote Control		2015-09-11	254
7	Acoustimass 6 Series V Home Theater Speaker System (Black)	Bose	Bose	2015-05-11	499
8	Samsung - 850 PRO 512GB Internal SATA III Solid State Drive for Laptops	Samsung		2018-05-28	224
9	Corsair Vengeance LPX 16GB (2x8GB) DDR4 DRAM 3000MHz C15 Desktop Memory Kit - Black (CMK16GX4M2B3000C15)	Corsair		2017-07-31	139
10	Outdoor Tech Buckshot Pro Bluetooth Speaker	Outdoor Tech		2015-11-16	55
11	Motorola Wi-Fi Pet Video Camera	Motorola	Motorola	2015-05-11	99
12	Details About Samsung Gear Iconx 2018 Edition Cordfree Fitness Earbuds Black (us Version)	Samsung		2017-11-28	199
13	2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD	WD		2015-08-16	89
14	Details About Panamax Mr4000 8outlets Surge Protector Home Theater Power Line Management	Panamax		2015-03-18	199
15	Details About Alpine 480w 6.5 2way Typee Coaxial Car Speakers W/ Silk Tweeters | Spe6000"	Alpine		2015-11-09	51
16	Transcend - JetDrive 420 480GB Internal Serial ATA III Solid State Drive for Select AppleÂ® Computers	Transcend	TRANSCEND Storage	2014-09-29	249
17	Samsung Universal 3100mAh Portable External Battery Charger - White	Samsung	SAMSUNG	2015-02-26	22
18	Air-Fi Runaway AF32 Stereo Bluetooth Wireless Headphones with Hidden Microphone (Black and Red)	MEE audio		2015-07-13	49
19	SpeakerCraft - 6-1/2 In-Ceiling Speakers (5-Pack) - White"	SpeakerCraft		2015-07-13	449
20	Peerless - Round Ceiling Plate for Most Peerless-AV Projector Mounts - Black	Peerless	Peerless	2015-07-13	21
21	Kenwood KFC-1653MRW 6.5 2-way Marine Speakers Pair (White)"	Kenwood	Kenwood	2015-07-06	46
22	Panamax - 11-Outlet Surge Protector - Black	Panamax		2015-05-18	139
23	Microsoft Surface Pro 4 Type Cover with Fingerprint ID	Microsoft	Microsoft	2015-11-13	159
24	Ultimate Ears MEGABLAST Portable Wi-Fi/Bluetooth Speaker with hands-free Amazon Alexa voice control (waterproof) - Graphite Black	Ultimate Ears		2018-03-14	299
25	Niles - SS-4 4-Pair Speaker Selector - Black	Niles		2015-07-13	179
26	SpeakerCraft - Profile CRS6 Two 6-1/2 In-Ceiling Speaker (Each) - Black"	SpeakerCraft		2015-07-13	229
27	CORSAIR VENGEANCE RGB 16GB (2x8GB) DDR4 3200MHz C16 Desktop Memory - Black	Corsair		2017-07-02	219
28	DENAQ - AC Power Adapter and Charger for Select HP Omnibook, Pavilion and Presario Laptops - Black	DENAQ	Denaq	2015-01-17	25
29	SlideLITE Camera Strap SLL-1 (Black)	Peak Design	Peak Design	2015-12-03	49
30	Flipside 300 Backpack (Black)	Lowepro	Lowepro	2015-08-18	79
31	Samsung - 50 Class (49.5" Diag.) - LED - 1080p - Smart - HDTV"	Samsung		2017-07-25	450
32	iHome Rechargeable Splash Proof Stereo Bluetooth Speaker - Black (IBT33BC)	Sdi Technologies, Inc.	iHome	2016-11-07	37
33	Polk Audio - 50 W Woofer - Black	Polk Audio	Polk Audio	2015-10-30	99
34	Apple - Pre-Owned iPad 3 - 64GB - Black	Apple		2015-11-09	229
35	Corsair CMSA8GX3M2A1066C7 Apple 8 GB Dual Channel Kit DDR3 1066 (PC3 8500) 204-Pin DDR3 Laptop SO-DIMM Memory 1.5V	Corsair		2017-07-18	74
36	ST640P Universal Tilt Wall Mount for 32 to 50 Displays	Peerless-AV		2017-07-31	61
37	Virtually Invisible 891 In-Wall Speakers (Pair)	Bose	BOSE	2015-11-06	599
38	AVR-X1400H 7.2-Channel Network A/V Receiver	Denon		2017-06-22	399
39	DENAQ - AC Power Adapter and Charger for Select Toshiba Satellite and Satellite Pro Laptops - Black	DENAQ	Denaq	2014-08-24	21
40	Lenovo - AC Adapter for Select Lenovo Yoga Laptops - Black	Lenovo	Lenovo Idea	2015-10-16	39
41	Elite Screens - Spectrum Series 110 Motorized Projector Screen - Black"	Elite Screens	ELITE SCREENS DIRECTSHIP	2015-09-04	255
42	Sony - SRS-XB21 Portable Bluetooth Speaker - Black	Sony		2018-04-20	98
43	Russound - Acclaim 5 Series 6-1/2 Indoor/Outdoor Speaker (Each) - White"	Russound	Russound	2015-04-27	128
44	SB-2000 12 500W Subwoofer (Piano Gloss Black)	SVS		2015-07-13	799
45	Kenwood - Road Series 6 x 8" 2-Way Car Speakers with Paper Woofer Cones (Pair) - Black"	Kenwood		2015-09-20	59
46	Hisense - 55 Class - LED - H9 Series - 2160p - Smart - 4K UHD TV with HDR"	Hisense		2018-03-16	799
47	4TB Red 5400 rpm SATA III 3.5 Internal NAS HDD Retail Kit	WD	Western Digital	2014-11-24	119
48	House of Marley Smile Jamaica In-Ear Earbuds	House of Marley	House Of Marley	2014-10-28	17
49	Details About Midland Wr120c Noaa Weather Alert Radio	Midland	Midland	2015-09-20	36
50	Marantz - 1400W 7.2-Ch. 4K Ultra HD and 3D Pass-Through A/V Home Theater Receiver - Black	Marantz	Marantz	2015-11-02	853
51	JVC KD-X320BTS Apple iPod and Android Digital Media Receiver with Bluetooth	JVC		2015-07-06	76
52	iSimple ISBC01 BluClik Bluetooth Remote Control with Steering Wheel and Dash Mounts	iSimple	ISIMPLE	2015-10-30	27
53	Chief PDRUB Wall Mount for Flat Panel Display 42-71	Chief	Chief Manufacturing	2015-08-18	681
54	PS200 A/V Component Shelf	Peerless-AV	Peerless Industries	2015-05-18	42
55	Turtle Beach Ear Force Recon 320 7.1 Surround Sound Gaming Headset Pc Refurb	Turtle Beach		2015-09-13	24
56	AudioQuest - Golden Gate 9.8' RCA-to-RCA Audio Cable - Black/Red	AudioQuest		2015-07-13	89
57	Panamax - 2-Outlet Surge Protector - White	Panamax		2015-11-06	149
58	Toshiba - 3TB Internal Serial ATA III Hard Drive for Desktops	Toshiba		2017-07-25	139
59	Logitech - G560 LIGHTSYNC 2.1 Bluetooth Gaming Speakers with Game Driven RGB Lighting (3-Piece) - Black	Logitech		2018-05-02	199
60	Yamaha WX-030BL MusicCast Wireless Speaker with Wi-Fi and Bluetooth (Black)	Yamaha	YAMAHA	2015-12-02	249
61	SiriusXM SXEZR1V1 XM Onyx EZR Satellite Radio Receiver with Vehicle Kit	Siriusxm	Siriusxm	2017-06-22	79
62	Details About *brand New* Pny Anarchy 16gb Kit (2x8gb) Ddr4 2400mhz Pc419200 Desktop Memory	Pny		2016-03-11	153
63	JBL - 6 x 8" 2-Way Coaxial Car Speakers with Polypropylene Cones (Pair) - Black"	JBL		2015-09-20	95
64	Details About Samsung 24 Class Hd (720p) Smart Led Tv (un24m4500)"	Samsung		2017-08-21	138
65	WI-SP500 Wireless In-Ear Sports Headphones (Black)	Sony		2018-04-05	78
66	KICKER - KM 6.5 2-Way Coaxial Marine Speaker with Injection-Molded Polypropylene Cone (Pair) - Charcoal"	Kicker		2015-09-20	143
67	SVS - 12 500W Powered Subwoofer - Gloss piano black"	SVS		2015-09-10	849
68	YU2 Powered Desktop Speakers (Glossy Black)	Kanto Living		2015-09-20	199
69	Yamaha - Micro Component System - White	Yamaha		2015-12-09	279
70	251 Outdoor Environmental Speakers (White)	Bose		2017-07-18	399
71	MTX - Dual 4 50W RMS Loudspeaker (Each) - Black"	MTX		2015-05-27	89
72	Slingbox M2	Sling Media	Slingbox	2015-09-30	99
73	Sony Mini Digital Video Cassettes - DVC - 1 Hour	Sony	Sony	2015-11-16	19
74	Russound - Acclaim 5 Series 5-1/4 2-Way Indoor/Outdoor Speakers (Pair) - White"	Russound	Russound	2015-07-13	87
75	Sony SRSHG1/BLK Hi-Res Wireless Speaker- Charcoal black	Sony	Sony	2016-07-07	128
76	Circle 2 2MP Wire-Free Network Camera with Night Vision	Logitech		2017-07-12	253
77	Samsung-3-Pack-Connect-Home-Smart-Wi-Fi-System-AC1300	Samsung		2017-07-01	379
78	Power Acoustik LP-3CSC License Plate with 2 Backup Sensors and CCD Camera, Chrome	Power Acoustik	Power Acoustik	2015-01-17	110
79	SRS-ZR7 Wireless Speaker	Sony		2016-06-11	248
80	T92UWH Portable Tripod Screen (45x80)	Elite Screens	Elitescreens	2015-06-29	136
81	SanDisk Extreme 500 Portable SSD 500GB SDSSDEXT-500G-G25	Sandisk		2017-05-21	149
82	Power Acoustik - Gothic Series 10 Dual-Voice-Coil 2-Ohm Subwoofer - Black"	Power Acoustik		2015-12-02	85
83	Details About New Nib Novatel 6620l Verizon 4g Lte Global Ready Jetpack Mifi Hotspot	Novatel	Novatel	2015-10-20	79
84	Grind Headphones with Single-Button TapTech and Mic (Black)	Skullcandy		2015-09-11	58
85	VE278Q 27 Widescreen LCD Computer Display	ASUS		2015-09-11	202
86	MartinLogan - Dynamo 1000 12 1000-Watt Powered Subwoofer - Black"	MartinLogan		2015-09-11	999
87	1TB T5 Portable Solid-State Drive (Black)	Samsung		2017-08-21	399
88	SRS-XB40 Bluetooth Speaker (Black)	Sony		2017-03-27	248
89	sub6 100W 6 Active Subwoofer (Matte Gray)	Kanto Living		2015-09-10	239
90	Pioneer Avh-x3800bhs 6.2 Double-DIN In-Dash DVD Receiver with Bluetooth	Pioneer		2016-03-02	299
91	WD - My Passport X 3TB External USB 3.0 Portable Hard Drive - Black	WD		2017-07-18	115
92	Belkin F4U095tt Thunderbolt 3 Express Dock HD with 3.3-Foot Thunderbolt 3 Cable	Belkin		2017-07-31	299
93	ECON-S3T-DVD-BK 1-DVDROM TO 3-DVD+/-RW DL 24X TOWER STANDALONE	VINPOWER DIGITAL DIRECTSHIP		2014-09-04	225
94	Dell - P2418HT 24 IPS LED FHD Touch-Screen Monitor - Black"	Dell		2018-01-30	320
95	Toshiba - 2.0-Channel Soundbar with 16-Watt Digital Amplifier - Black	Toshiba		2017-09-01	59
96	PELICAN - ProGear Case for Most Tablets - Black	PELICAN	Pelican	2015-09-13	56
97	AudioQuest - GOLDG01R Golden Gate 1m (3.28 ft.) RCA Audio Cable - Red	AudioQuest	Audioquest	2014-02-21	69
98	Lenovo - 300-20ISH 20 All-In-One - Intel Pentium - 4GB Memory - 500GB Hard Drive - Black"	Lenovo	Lenovo	2016-03-16	449
99	XPS 8920 Tower Desktop Computer	Dell		2017-05-22	799
100	Leviathan Elite Gaming Soundbar	Razer	Razer	2015-11-13	217
101	UBD-M9500 HDR UHD Upscaling Blu-ray Disc Player	Samsung	Samsung	2017-05-20	328
102	Sony - Shake Audio System - Black	Sony		2017-07-01	499
103	Details About Openbox Excellent: Alienware Aw2518h 25 Led Fhd Gsync Monitor Black"	Alienware		2017-07-18	571
104	Sony MEXM100BT 160W RMS Marine CD Receiver with Bluetooth (Black) and SiriusXM Ready	Sony	Sony	2016-05-31	269
105	PowerShot G5 X Digital Camera Free Accessory Kit	Canon	Canon	2015-10-31	933
106	Sharp - 350W 5-Disc Mini Component System - Black	Sharp		2017-03-28	249
107	Olympus - Refurbished 14.0-Megapixel Digital Camera - Titanium	Olympus		2015-08-22	219
108	AudioQuest - Black Lab 26.2' In-Wall Subwoofer Cable - Black/White	AudioQuest		2015-10-16	64
109	House of Marley EM-DH003-PS TTR Noise-Cancelling Over-Ear Headphones (Black)	House Of Marley		2015-09-11	299
110	Details About Netgear Nighthawk A7000 (ac1900) Dualband Wifi Usb Adapter	Netgear		2017-07-25	69
111	Adventura SH 140 II Shoulder Bag (Black)	Lowepro	Lowepro	2015-10-31	19
112	Details About Logitech G920 Xbox Driving Force Racing Wheel For Xbox One And Pc (941000121)	Logitech	Logitech	2015-12-02	188
113	Hisense 50H4D Roku 50-inch HD Smart DLED TV	Hisense		2017-07-25	329
114	Hoya - EVO 77mm Antistatic UV Super Multicoated Lens Filter - Gray	Hoya		2015-12-02	89
115	TP-Link AV500 2-port Powerline Starter Kit	TP-Link	TP-Link	2015-11-09	37
116	Aeon 58.3 x 104.1 16:9 Fixed Frame Projection Screen with CineWhite Projection Surface	Elite Screens	Elite Screens	2015-10-30	462
117	Digipower - Dual Battery Charger - Gray	Digipower		2015-12-02	59
118	CORSAIR - VOID Surround Hybrid Wired Stereo Gaming Headset for PC, PS4, Xbox One, Nintendo Switch, Mobile devices - Carbon	CORSAIR		2017-05-20	70
119	Everest Elite 700 Around-Ear Wireless Headphones (White)	JBL	JBL	2016-05-30	299
120	Onkyo TX-8270 2 Channel Network Stereo Receiver with 4k HDMI	Onkyo		2017-06-22	499
121	Sony MDR-1A Headphone - Black (International Version U.S. warranty may not apply)	Sony		2017-07-18	248
122	AW6500 All-Weather Outdoor Speaker (White, Single)	Definitive Technology	5 Years	2015-07-06	249
123	Sony LBT-GPX555 Mini-System with Bluetooth and NFC	Sony	Sony	2015-10-23	488
124	M80UWH Manual Series Projection Screen (39.6 x 69.6)	Elite Screens	Elitescreens	2015-09-03	82
125	Toshiba Micro Component Speaker System: Wireless Bluetooth Speaker Sound System with FM	Toshiba		2017-07-31	129
126	Prime Three-Way Center Channel Speaker (Premium Black Ash)	SVS		2015-07-13	349
127	Kicker 41IK5BT2V2 Amphitheater High-Performance Audio System with Bluetooth, Black	Kicker		2015-09-11	199
128	Yamaha - AVENTAGE 7.2-Ch. 4K Ultra HD A/V Home Theater Receiver - Black	Yamaha	Yamaha	2017-06-30	649
129	NS-6490 Bookshelf Speaker (Pair)	Yamaha		2015-08-18	149
130	Details About Innovative Technology Itsbo358p Bluetooth Outdoor Rock Speaker Pair	Innovative Technology		2017-01-06	94
131	Leica DG Vario-Elmar 100-400mm f/4-6.3 ASPH. POWER O.I.S. Lens	Panasonic		2016-02-17	1797
132	MH30 Foldable On-Ear Headphones (Brown/Silver)	Master Dynamic		2015-09-11	299
133	Samsung - 49 Class - LED - Q6F Series - 2160p - Smart - 4K UHD TV with HDR"	Samsung		2017-11-18	1297
134	CORSAIR - AX760 760-Watt ATX Power Supply - Black	CORSAIR	Corsair	2015-10-30	159
135	Samsung - 960 Pro 1TB Internal PCI Express 3.0 x4 (NVMe 1.1) Solid State Drive	Samsung	Samsung	2016-12-12	600
136	Klipsch - Reference Soundbar with 10 Wireless Subwoofer - Black"	Klipsch		2015-09-11	799
137	Details About Microsoft Arc Mouse Bluetooth 4.0 Souris Wireless For Surface Windows 10	Microsoft		2017-08-25	69
138	DENAQ - 8-Cell Lithium-Ion Battery for Select HP Pavilion Laptops	DENAQ	Denaq	2014-02-21	82
139	SIMA SSW-6 1 x 6 Speaker Selector with Impedance Protection	Sima		2015-12-02	42
140	Clarity - Super-Loud Phone Ringer - White	CLARITY-TELECOM	Allround Software	2015-12-02	39
141	The Rebel BT On-Ear Wireless Bluetooth Headphones (Black)	House of Marley	House of Marley	2016-08-02	59
142	CRX-322 CD Receiver	Yamaha	Yamaha	2015-08-22	249
143	Yamaha RX-V379BL 5.1-Channel AV Receiver (Black)	Yamaha	YAMAHA	2015-08-18	289
144	NETGEAR AC1000 Dual Band Smart WiFi Router	Netgear		2017-07-18	59
145	LG - 75 Class - LED - UJ6470 Series - 2160p - Smart - 4K UHD TV with HDR"	LG		2017-06-23	2496
146	Apple - Pre-Owned iPad 3 - 32GB - White	Apple		2017-03-03	549
147	Belkin Travel RockStar Surge Protector with 2 AC Outlets	Belkin Inc.	Belkin	2015-11-16	31
148	Yamaha - MusicCast 5.1-Ch. 4K Ultra HD A/V Home Theater Receiver - Black	Yamaha	Yamaha	2016-03-11	599
149	SVS - Prime Dual 5-1/4 Passive 3-Way Center-Channel Speaker - Gloss piano black"	SVS		2015-07-13	449
150	MSI - WS Series 15.6 Laptop - Intel Core i7 - 16GB Memory - 256GB Solid State Drive + 2TB Hard Drive - Aluminum Black"	MSI		2017-04-03	2299
151	Lenovo - 510-23ISH 23 Touch-Screen All-In-One - Intel Core i5 - 8GB Memory - 2TB Hard Drive - Black"	Lenovo	Lenovo	2017-03-02	799
152	KEF - Dual 4-1/2 2-1/2-Way Center-Channel Speaker - Black"	KEF		2015-08-15	399
153	AfterShokz - Sportz Titanium with Mic Behind-the-Neck Headphones - Onyx Black	AfterShokz		2017-05-20	59
154	Zubie - In-Car Wi-Fi and Vehicle Monitoring Device - Black	Zubie		2015-12-03	99
155	ECOXGEAR ECOXBT Waterproof Bluetooth Speaker	ECOXGEAR	Grace Digital	2015-09-11	69
156	Alpine - 6 x 9" 2-Way Coaxial Car Speakers with Polypropylene Cones (Pair) - Black"	Alpine	Alpine	2015-10-31	56
157	NS-IW480CWH In-Ceiling 8 Natural Sound Three-Way Speaker System (Pair)	Yamaha	Yamaha	2014-10-29	149
158	Ultimate Ears - BLAST Smart Portable Wi-Fi and Bluetooth Speaker with Amazon Alexa Voice Assistant - Blizzard	Ultimate Ears		2018-03-16	179
159	Alpine Electronics i207-WRA 7 Mech-Less Restyle Dash System with Apple Car Play and Android Auto for Jeep Wrangler (2007-2017)"	Alpine		2017-11-18	999
160	Logitech Ultrathin Touch Mouse T630 for Windows 8 Touch Gestures	Logitech	Logitech	2015-04-23	68
161	Panamax - 8-Outlet Power Conditioner/Surge Protector - Gray	PANAMX		2015-05-18	93
162	Rand McNally 0528011715 IntelliRoute 7 TND 730 GPS Unit"	Rand McNally	Parts	2015-03-18	368
163	Samsung 55 Class 4K (2160P) Smart LED TV (UN55KU7000)"	Samsung	SAMSUNG	2016-05-18	1197
164	Startech VGA Video Extender Over Cat5, Point to Point	StarTech	StarTech	2015-04-07	126
165	ZTE - Spro 2 Wireless Smart DLP Projector - Silver	ZTE		2015-12-02	437
166	TiVo - BOLT VOX 1TB DVR and Streaming Player - Black	TiVo		2018-03-14	299
167	Samsung Radiant360 R1 Wi-Fi/Bluetooth Speaker WAM1500/ZA - Black (Certified Refurbished)	Samsung	Samsung	2016-02-08	121
168	Logitech Focus Case with Integrated Keyboard for iPad Mini 4, Dark Blue	Logitech		2016-02-29	54
169	Logitech Keys-To-Go Ultra-Portable Bluetooth Keyboard for Android and Windows	Logitech	Logitech	2015-10-23	59
170	32GB High Speed UHS-I SDHC U3 Memory Card (Class 10)	Sony	Sony	2015-12-02	29
171	ProSafe 16-Port Gigabit Desktop Switch	Netgear		2018-01-30	54
172	QuickFit 26 Stainless Steel Watch Band (Slate Gray)	Garmin		2017-06-29	149
173	kenwood pkg-mr362bt marine cd receiver with bluetooth and 6.5 2 way speakers package	Kenwood		2015-09-18	199
174	WD - Se 2TB Internal Serial ATA Hard Drive for Desktops (OEM/Bare Drive)	WD		2017-07-25	127
175	TP-Link Archer T9E AC1900 Wireless WiFi PCIe network Adapter Card for PC	Tp-Link		2018-03-14	67
176	151 SE Outdoor Environmental Speakers (White)	Bose		2017-07-18	279
177	JBL Everest 710 Silver Over-Ear Wireless Bluetooth Headphones (Silver)	Jbl		2017-07-12	249
178	Acer - 2-in-1 15.6 Refurbished Touch-Screen Laptop - Intel Core i7 - 12GB Memory - NVIDIA GeForce 940MX - 1TB Hard Drive - Steel gray"	Acer	Acer	2017-03-03	859
179	Samsung - 960 EVO 500GB Internal PCI Express 3.0 x4 (NVMe) Solid State Drive for Laptops	Samsung	Samsung IT	2016-12-12	234
180	Acer Aspire E5-574-53QS 15.6 LED Notebook - Intel Core i5 (6th Gen) i5-6200U Dual-core (2 Core) 2.30 GHz - 4 GB DDR3L SDRAM RAM - 1 TB HDD - DVD-Writer - Intel HD Graphics 550 DDR3L SDRAM - Wind"	Acer	Acer	2016-10-30	616
181	Yamaha - 30W Desktop Audio System - Brick	Yamaha		2016-04-09	399
182	Logitech Circle Black Portable Wifi Video Monitoring Camera Webcam	Logitech		2015-12-14	99
183	Details About Sony Wh1000xm2 Wireless Noisecanceling Headphones (black Or Gold)	Sony		2017-10-04	289
184	Yamaha - Micro Component System - Black	Yamaha		2016-03-10	182
185	Samsung - 850 PRO 1TB Internal SATA III Solid State Drive for Laptops	Samsung		2018-05-19	449
186	SanDisk - High Endurance 64GB microSDXC Memory Card	SanDisk		2017-08-31	37
187	Flyer Wireless Fitness Headphones (Nightfall Blue)	Fitbit		2017-10-22	129
188	Samsung - 40 Class (39.5" Diag.) - LED - 1080p - Smart - HDTV"	Samsung		2017-08-21	399
189	Amps Air Bluetooth Wireless Earbuds (Rose Gold)	SOL REPUBLIC		2017-03-06	89
190	Details About Razer Kraken Pro V2 Analog Gaming Headset For Pc/xbox One/ps4 Black (p05)	Razer	RAZER	2017-03-03	69
191	Alpha a6500 Mirrorless Digital Camera (Body Only)	Sony		2018-04-10	1181
192	Alpine SPR-60 6-1/2 Coaxial 2-Way Type-R Speaker Set"	Alpine		2014-11-14	148
193	Alpine - 6-1/2 2-Way Component Car Speakers with Poly-Mica Cones (Pair) - Black"	Alpine	Alpine	2014-11-17	79
194	Canon EF 100mm f/2.8L IS USM Macro Lens for Canon Digital SLR Cameras	Canon		2018-05-24	810
195	Kanto Living 8 Powered Subwoofer -Gloss White"	Kanto		2015-09-10	279
196	MartinLogan Motion 6 Center Channel Speaker (Piano Black, each)	MartinLogan		2015-09-13	219
197	Planet Audio - 6.2 - Bluetooth - In-Dash DVD Receiver - Black"	Planet Audio	Planet Audio	2017-01-17	89
198	XFX AMD Radeon RX 580 8GB GDDR5 PCI Express 3.0 Graphics Card	XFX		2017-06-22	359
199	IOGEAR Wireless Screen Sharing and MiraCast Kit (GWSSKIT)	IOGEAR		2017-06-22	79
200	SanDisk - Ultra 500GB Internal SATA Solid State Drive for Laptops	SanDisk		2017-08-06	149
201	Cerwin Vega - SL Series 2-Way Center-Channel Speaker - Black	Cerwin Vega		2015-05-18	129
202	CybertronPC - Rhodium Desktop - AMD FX-Series - 16GB Memory - NVIDIA GeForce GTX 1050 - 2TB Hard Drive - Green	CybertronPC	Cybertronpc	2016-06-05	869
203	MSI - 15.6 Laptop - Intel Core i7 - 16GB Memory - NVIDIA GeForce GTX 1060 - 1TB Hard Drive + 256GB Solid State Drive - Black"	MSI		2017-05-08	1499
204	Grace Digital - 50W 2.0-Ch. Amplifier - Black	Grace Digital		2016-07-09	76
205	G-Technology G-DRIVE USB 3.0 6TB External Hard Drive (0G03674)	G-Technology		2017-07-19	249
206	Ultimate Keyboard Case for iPad 2nd, 3rd, 4th Gen	Belkin		2015-05-22	69
207	EcoJam Waterproof Bluetooth Speaker, Black	ECOXGEAR		2017-03-06	107
208	Definitive Technology - Disappearing Dual 6-1/2 In-Wall Speaker (Each) - Black"	Definitive Technology		2015-12-01	549
209	Razer - Blade Pro 17.3 4K Ultra HD Touch-Screen Laptop - Intel Core i7 - 32GB Memory - NVIDIA GeForce GTX 1080 - 1TB SSD - Black"	Razer		2017-05-22	3149
210	Goal Zero Nomad 7 Plus Solar Panel	Goal Zero		2017-06-21	99
211	Yamaha - 2.1-Channel Soundbar System with 6-1/2 Wireless Subwoofer and 200-Watt Digital Amplifier - Black"	Yamaha		2017-08-21	279
212	Gear 360 Spherical VR Camera	Samsung	Samsung Electronics	2016-09-25	62
213	Sennheiser - Earbud Headphones - Black	Sennheiser	Sennheiser	2014-08-25	799
214	M.Zuiko Digital ED 40-150mm f/4-5.6 R Lens (Silver)	Olympus		2017-07-20	124
215	Sony - WH-CH700N Wireless Noise Canceling Over-the-Ear Headphones - Black	Sony		2018-04-23	198
216	ECOXGEAR ECOXBT Rugged and Waterproof Wireless Bluetooth Speaker (Orange)	ECOXGEAR	Grace Digital Audio	2015-09-11	72
217	Kenwood KMM-BT315U Digital Media Receiver with Built-In Bluetooth (Black)	Kenwood	KENWOOD	2016-03-22	74
218	AOC - 18.5 LED Monitor - Black"	AOC		2017-07-20	64
219	Sony SELP18105G E PZ 18-105mm F4 G OSS	Sony		2018-05-24	599
220	Actiontec 300 Mbps Wireless-N ADSL Modem Router (GT784WN)	Actiontec	Actiontec	2015-09-13	75
221	27 iMac with Retina 5K Display (Mid 2017)	Apple		2017-07-12	1839
222	Logitech iPad Pro 12.9 inch Keyboard Case SLIM COMBO with Detachable	Logitech		2017-07-31	149
223	SiriusXM Commander Touch Full-Color	Siriusxm	SiriusXM	2015-12-02	82
224	128GB iPod touch (Space Gray) (6th Generation)	Apple		2017-03-03	299
225	Apple iPod Touch 128GB Blue	Apple		2017-03-03	299
226	Logitech - Harmony Home Hub - Black	Logitech		2017-07-18	99
227	Razer BlackShark Over Ear Noise Isolating PC Gaming Headset - Metal Construction and Compatible with PS4	Razer	Razer USA	2015-10-23	140
228	V-MODA - Crossfade LP2 Vocal Limited Edition Over-the-Ear Headphones - Matte Black	V-MODA	Jvc Real Sound System Z Series Ha-Sz2000 Stream Woofer Db Headphones (black, Japan Import) V-Moda	2015-09-11	129
229	Lumimuse 6 On-Camera LED Light (Black)	Manfrotto	Manfrotto	2015-12-01	79
230	Atrend-Bbox E12DSV B Box Series 12 Dual Vented Enclosure with Shared Chamber"	Atrend		2015-01-17	86
231	Details About Aiwa Exos9 Portable Bluetooth Speaker	Aiwa		2016-08-06	353
232	DENAQ - AC Power Adapter and Charger for Select Dell Inspiron and Latitude Laptops - Black	DENAQ	Denaq	2015-10-31	20
233	DNA 15 Slim Messenger Bag (Graphite)	Tenba		2017-03-03	159
234	7.2CH AVR WITH WIFI _ BLUETOOTH 2 HDMI OUTPUTS 90 WATTS/CH.	DENON - HEOS	Denon	2016-07-26	448
235	MCR-B043 30W Bluetooth Wireless Music System (Red)	Yamaha		2015-12-01	249
236	Pro-Series 49-Class Full HD Outdoor LED TV (Silver)	SunBriteTV		2016-09-03	4295
237	AVR-X3400H 7.2-Channel Network A/V Receiver	Denon		2017-08-21	875
238	HD 4.40 BT Wireless Bluetooth Headphones	Sennheiser		2017-06-24	149
239	Yamaha - Micro Component System - Blue	Yamaha		2015-12-01	279
240	Details About Netgear 16 X 4 Docsis 3.0 Cable Modem Black	Netgear		2017-11-29	125
241	Sony - High Power XB60 Portable Bluetooth Speaker - Black	Sony		2017-10-12	248
242	Details About Alienware 13 R3 Aw13r3/13.3 Fhd/i77700hq/nvidia Gtx 1060/16gb/512gb Ssd"	Alienware		2017-03-06	1849
243	Monster - iSport Achieve In-Ear Wireless Headphones - Green	Monster		2017-03-06	59
244	Niles - 6-Pair Speaker Selector with Volume Control - Black	Niles	Niles	2015-07-13	619
245	Under Armour Sport Wireless Flex Neckband In-Ear Headphones	JBL		2018-05-01	129
246	Lenovo Flex 4 1470 80SA0000US 2-in-1 - 14 HD Touch - Pentium 4405U 2.1Ghz - 4GB - 500GB"	Lenovo		2015-12-01	321
247	PNY Performance 8GB Kit (2x4GB) DDR3 1600MHz (PC3-12800) CL11 Desktop Memory - MD8GK2D31600NHS-Z	Pny		2015-11-16	57
248	DENAQ - AC Power Adapter and Charger for Select Toshiba Satellite Laptops - Black	DENAQ	Denaq	2015-01-17	21
249	CORSAIR - MM800 Polaris RGB Gaming Mouse Pad - Black	CORSAIR		2017-09-18	59
250	Lenovo Yoga Mouse	Lenovo		2017-03-06	57
251	AudioQuest - Black Lab 16.4' In-Wall Subwoofer Cable - Black/White	AudioQuest	Audioquest	2015-05-19	49
252	JBL Under Armour Sport Wireless Heart Rate In-Ear Headphones Black	JBL		2017-03-03	149
253	JBL - Free True Wireless In-Ear Headphones - Black	JBL		2017-11-28	149
254	Pioneer - Elite 7.2-Ch. Hi-Res 4K Ultra HD HDR Compatible A/V Home Theater Receiver - Black	Pioneer	Pioneer	2017-06-30	699
255	MTX Audio - MTX 8 225W 2-way Speaker (Each) - Black"	MTX Audio	MTX	2015-10-23	172
256	Audio Video Shelf	SKB	SKB Cases	2015-08-18	45
257	SunBriteTV - Outdoor Tilting TV Wall Mount for Most 37 - 80" TVs - Powder coated black"	SunBriteTV		2017-12-16	149
258	BoseÂ® - Virtually InvisibleÂ® 591 In-Ceiling Speakers (Pair) - White	BoseÂ®	BOSE	2015-12-02	449
259	Grace Digital - 100W 2.0-Ch. Amplifier - Black	Grace Digital	Grace Digital	2016-02-03	169
260	22 Widescreen Full HD 1080p LED Monitor	ViewSonic		2017-07-19	129
523	Mini Solar Cell Phone Charger	Secur		2015-12-02	8
261	Motorola FOCUS85-B Wi-Fi HD Home Monitoring Camera with Remote Pan	Motorola Home		2015-10-17	110
262	My Cloud Expert Series EX4100 24TB 4-Bay NAS Server (4 x 6TB)	WD	Western Digital	2015-12-02	1199
263	65 Ultra-Light Carbon Fiber Tripod with Ball Head (Black)	Polaroid	Polaroid	2015-12-02	139
264	14 Checkpoint Friendly Laptop Case	Case Logic	Case Logic	2014-10-31	44
265	Samsung - 49 Class - LED - MU6290 Series - 2160p - Smart - 4K Ultra HD TV with HDR"	Samsung		2017-09-18	597
266	Skeleton Housing for HERO3 / HERO3+ / HERO4	GoPro	GoPro	2015-11-06	49
267	AVR-S530BT 5.2-Channel A/V Receiver	Denon		2017-07-19	229
268	Sigma - 35mm f/1.4 DG HSM Art Standard Lens for Canon - Black	Sigma	Sigma	2015-04-27	789
269	Sonax PM-2200 Wall Mount Stand for 28-Inch to 50-Inch TV	Sonax	Sonax	2015-12-02	35
270	CORSAIR - VENGEANCE RGB Series 32GB (4PK 8GB) 3.466GHz DDR4 Desktop Memory with RGB Lighting - Black	Corsair		2017-07-02	632
271	Memorex CD/Cassette Recorder Boombox MP3 AM/FM FlexBeats MP3262 with Aux line in jack - Black	Memorex		2017-03-03	49
272	Marantz - SR 9.2-Ch. Hi-Res With HEOS 4K Ultra HD A/V Home Theater Receiver - Black	Marantz		2017-09-26	2199
273	Sennheiser - HD 660 S Over-the-Ear Headphones - Matte Black and Anthracite	Sennheiser		2017-12-04	499
274	SL-15 Floorstanding Speaker	Cerwin-Vega		2015-05-18	449
275	Hauppauge - WinTV-dualHD Cordcutter - Black	Hauppauge		2018-03-14	69
276	Yamaha - Natural Sound 5 2-Way All-Weather Outdoor Speakers (Pair) - White"	Yamaha		2015-11-01	99
277	Amps Air Bluetooth Wireless Earbuds (Rich Teal)	SOL REPUBLIC		2017-03-06	105
278	Amps Air Bluetooth Wireless Earbuds (Deep Blue)	SOL REPUBLIC		2017-03-06	149
279	Kicker Bullfrog Jump - Green/Black (43BF400) Outdoor Waterproof Bluetooth Speaker W/ FM Tuner and 20 Hour Battery life	Kicker		2017-03-06	399
280	Boytone - Portable Bluetooth Speaker - Blue	Boytone		2015-09-11	26
281	SunBriteTV - Signature Series - 43 Class - LED - Outdoor - Partial Sun - 2160p - 4K UHD TV with HDR"	SunBriteTV		2017-03-03	2799
282	GTK-XB90 Bluetooth Speaker	Sony		2017-11-28	448
283	Onkyo TXNR757 7.2 Channel Wireless A/V Receiver w/ HDCP2.2/HDR DTS _ Bluetooth	Onkyo	Onkyo	2016-10-18	398
284	Vectros Bumper for 13 MacBook Pro Retina (Black)	Thule	Thule	2015-08-18	59
285	Onkyo - 5.1-Ch. Home Theater System - Black	Onkyo	ONKYO	2016-08-01	305
286	RX-V583 7.2-Channel Network A/V Receiver	Yamaha		2017-06-22	499
287	Kenwood CD Single DIN In-Dash Bluetooth Car Stereo Receiver KDC-BT365U	Kenwood	KENWOOD	2016-03-24	89
288	Alpine - 9 - Built-In GPS - CD/DVD - Built-In Bluetooth - Built-In HD Radio - In-Dash Deck - Black"	Alpine	Alpine Electronics USA	2015-12-02	2499
289	Panamax - 8-Outlet Power Conditioner/Surge Protector - Black	Panamax		2015-09-20	169
290	SP-C22 Andrew Jones Designed Center Channel Speaker	Pioneer	Pioneer	2015-08-18	99
291	MU8000-Series 65-Class HDR UHD Smart LED TV	Samsung		2017-04-04	1725
292	CORSAIR - HD Series 120mm Case Cooling Fan Kit with RGB lighting	CORSAIR		2017-05-21	85
293	Samsung - 960 PRO 512GB Internal PCI Express 3.0 x4 (NVMe) Solid State Drive for Laptops	Samsung	Samsung	2016-12-12	286
294	MartinLogan - Helos 22 6-1/2 In-Ceiling Speaker (Each) - Paintable White"	MartinLogan		2015-09-20	449
295	Definitive Technology - 300W 2.0-Ch. Wireless Amplifier - Black	Definitive Technology		2015-09-11	499
296	JBL Inspire 700 In-Ear Wireless Sport Headphones with Charging Case (Black)	Jbl		2018-04-18	63
297	One System Cabinet	Antec		2017-07-18	54
298	NETGEAR Nighthawk AC1900 VDSL/ADSL Modem Router Certified with CenturyLink - Non-bonded	NETGEAR	NETGEAR	2015-12-02	240
299	CORSAIR - VENGEANCE LED Series 16GB (2PK 8GB) 3.0GHz DDR4 Desktop Memory with LED Lighting - Black	CORSAIR	Corsair	2017-02-28	129
300	Alpine Electronics PWE-S8-WRA Powered Subwoofer for 2011-Up Jeep Wrangler	Alpine		2017-05-20	449
301	TiVo - BOLT VOX 3TB DVR and Streaming Player - Black	TiVo		2017-11-16	499
302	Samsung - 32 Class (31.5" Diag.) - LED - 720p - Smart - HDTV"	Samsung		2017-08-21	249
303	Samsung EVO+ 256GB UHS-I microSDXC U3 Memory Card with Adapter (MB-MC256DA/AM)	Samsung	Samsung	2016-11-11	56
304	HP 15-AY103DX 15.6 Touchscreen Touch Screen HD Laptop Notebook PC Computer 7th Gen i5-7200U Kaby Lake 8GB Memory 1TB HDD Hard Drive Windows 10"	HP		2017-03-03	438
305	Apple MD825AM/A Lightning to VGA Adapter for iPhones	Apple	Apple	2015-07-10	24
306	Bowers and Wilkins - P7 Over-the-Ear Headphones - Black	Bowers & Wilkins		2015-09-11	356
307	R-S202 Stereo Receiver with Bluetooth (Black)	Yamaha	Yamaha Electronics	2016-07-26	141
308	Power Acoustik Pmd-102x 10.1 Ceiling-Mount Swivel Monitor With DVD"	Power Acoustik		2015-07-06	155
309	Sony STR DN860 7.2 Channel 165 Watt Receiver	Sony	Sony	2015-11-06	394
310	E100 1080p Dash Camera	GEKO		2015-12-01	69
311	PP999 Phono Preamplifier	Pyle Pro	Manufacturers Limited Warranty:1 Year	2015-07-13	33
312	Virgin Mobile - LG Styloâ¢ 3 4G LTE with 16GB Memory Prepaid Cell Phone - Gray	Virgin Mobile		2017-05-08	124
313	Sony - 55 Class - OLED - A1E Series - 2160p - Smart - 4K UHD TV with HDR"	Sony		2017-04-04	3050
314	S-View Flip Cover for Galaxy Note 8 (Orchid Gray)	Samsung		2017-11-20	29
315	CORSAIR - Vengeance Pro Series 16GB (2PK x 8GB) 1.6 GHz DDR3 DIMM Desktop Memory Kit - Multi	CORSAIR		2017-07-18	129
316	YU2 Powered Desktop Speakers (Matte Black)	Kanto Living	Kanto	2015-10-31	199
317	Details About Alienware 15 R3 Aw15r3/15.6 Fhd/i77700hq/nvidia Gtx1070/16gb/1tb Hdd+128gb Ssd"	Alienware		2017-03-03	1656
318	Details About [genuine National] Sealed Gaming Headset Steelseries Arctis 7 Black 61463	Steelseries		2017-03-03	102
319	Wacom CS610PK Bamboo Sketch	Wacom		2017-07-13	50
320	Sony - G Master FE 85 mm F1.4 GM Full-Frame E-Mount Mid-range Telephoto Lens - Black	Sony		2017-01-22	1797
321	Logitech - Harmony 950 Universal Remote - Black	Logitech	Logitech	2017-03-06	189
322	Viper 7153V 1-Way 5-Button SuperCode Replacement Remote for 5701	Viper	Viper by GLD Products	2014-10-31	31
323	Sanus - VisionMount Universal Projector Ceiling Mount - Black	Sanus	Sanus	2015-11-05	109
324	Grace Digital - 3Play Bluetooth Audio Adapter - Black	Grace Digital	Grace Digital	2014-10-21	28
325	Leef Liacmwk000e1 iAccess iOS microSD Card Reader	Leef	eTape16	2016-11-04	18
326	Details About Razer Cynosa Chroma Rgb Gaming Keyboard Spillresistant Durable Design	Razer		2018-05-28	48
327	Sony SEL85F18 85mm F/1.8-22 Medium-Telephoto Fixed Prime Camera Lens	Sony		2017-03-03	599
328	Logitech - Harmony 665 10-Device Universal Remote - Black	Logitech		2017-07-31	69
329	kate spade new york - Glitter Sleeve for 13 AppleÂ® MacBookÂ® - Rose Gold"	kate spade new york		2015-11-16	69
330	Details About Razer Blade Laptop 14 Full Hd (i77700hq"	Razer		2017-03-03	1679
331	V-MODA - CROSSFADE M-100 Over-the-Ear Headphones - Shadow	V-MODA		2015-09-11	249
332	CORSAIR - Vengeance 16 GB (2PK x 8GB) 1.6 GHz DDR3 DIMM Desktop Memory Kit - Multi	CORSAIR		2015-12-02	45
333	Alpine CDESXM145BT Advanced Bluetooth CD / SiriusXM Receiver	Alpine		2017-07-18	166
334	12 MacBook (Mid 2017, Gold)	Apple		2017-07-25	1409
335	LG - 28 Class (27.5" Diag.) - LED - 720p - HDTV"	LG		2017-07-12	149
336	Seagate Backup Plus Ultra Slim 2TB Portable External Hard Drive	Seagate		2017-07-18	148
337	XFX - AMD Radeon RX 580 GTR XXX Edition 8GB GDDR5 PCI Express 3.0 Graphics Card - Black/White	XFX		2017-06-22	329
338	Yamaha - AVENTAGE 7.2-Ch. 4K Ultra HD A/V Home Theater Receiver - Black	Yamaha	Yamaha	2017-06-30	549
339	Insignia 47 - 80" Full Motion TV Wall Mount"	Insignia		2018-04-15	99
340	StarTech - 2 Port PCI IDE Controller Adapter Card - Green	StarTech		2018-05-28	51
341	Epson EX5250 Pro Wireless Business Projector	Epson	Epson	2015-12-03	599
342	ECOXGEAR - SolJam Portable Bluetooth Speaker - Black	ECOXGEAR		2017-01-06	128
343	Kanto - sub6 6 80W Powered Subwoofer - Gloss Black"	Kanto		2015-09-10	189
344	CORSAIR - Vengeance LPX 32GB (2PK x 16GB) 2.6 GHz DDR4 DRAM Desktop Memory Kit - Black	CORSAIR		2017-07-18	294
345	Niles - OS5.3 2-Way Indoor/Outdoor Speakers (Pair) - Black/White	Niles	niles	2015-11-01	217
346	Reference R-10B 250W 2.1-Channel Soundbar Speaker System (Black)	Klipsch		2015-11-09	599
347	Dell - XPS 2-in-1 13.3 Touch-Screen Laptop - Intel Core i7 - 16GB Memory - 256GB Solid State Drive - Silver"	Dell		2017-01-24	909
348	Klipsch AW-4i In-Ear Headphones	Klipsch	KLIPSCH	2015-12-02	59
349	Next-Generation ARRIS SURFboard SB8200 DOCSIS 3.1 Cable Modem - Retail Packaging- White	Arris		2018-03-14	174
350	Sony - 6.4 - Android Auto/Apple CarPlayâ¢ with SiriusXM Tuner - Built-in Bluetooth - In-Dash DVD/DM Receiver - Black"	Sony		2017-11-20	499
351	Dual - 10 Single-Voice-Coil 4-Ohm Subwoofer with Enclosure - Black/Silver"	Dual	Dual	2015-12-02	64
352	Russound - Acclaim 5 Series 6-1/2 2-Way Indoor/Outdoor Speakers (Pair) - White"	Russound	Russound	2015-09-10	168
353	A-S501 Integrated Amplifier (Black)	Yamaha	Yamaha Electronics	2015-08-18	549
354	Silicondust HDHomeRun-HD-Television-Tuner	Silicondust	SiliconDust USA, Inc	2017-07-02	81
355	Yamaha - 6-1/2 130-Watt Powered Subwoofer - Black"	Yamaha	Yamaha	2015-11-06	249
356	Samsung J1 (Verizon LTE Prepaid)	Samsung	Cooks International LLC (Former Coshell Holdings LLC)	2015-10-16	39
357	J5202-Series 43-Class Full HD Smart LED TV	Samsung		2017-11-27	429
358	LG - 65 Class - LED - SJ8500 Series - 2160p - Smart - 4K UHD TV with HDR"	LG		2017-07-19	1296
359	H6 Handy Recorder Kit with Resident Audio R100 Headphones	Zoom	Zoom	2014-11-17	424
360	VXi - BlueParrott B450-XT Bluetooth Headset - Black	VXi		2017-05-08	149
361	NVIDIA - SHIELD Wireless Controller - Black	NVIDIA	NVIDIA	2017-06-28	59
362	Seagate - Backup Plus 5TB External USB 3.0 Portable Hard Drive - silver	Seagate	Seagate Technology	2017-03-06	134
363	Sanus - Speaker Stands (Pair) - Black	Sanus	Sanus	2015-05-26	50
364	ASUS VivoBook Max X541SA 15.6Inch Laptop Intel Pentium 4GB Memory 500GB HD Matte IMR X541SA-PD0703X	ASUS		2017-07-26	329
365	j5create - VGA to HDMI Video adapter - White	j5create		2015-12-09	34
366	SKW-204 10 230W Powered Subwoofer	Onkyo	Onkyo	2015-05-18	203
367	Insignia NS-HDRAD2 Tabletop HD Radio	Insignia		2017-03-03	36
368	Sharp - 5-Disc Micro System - Black	Sharp		2017-07-15	179
369	Apple - Pre-Owned iPad mini 4 - 16GB - Space gray	Apple		2017-05-22	309
370	JBL Cinema SB350 Soundbar System	JBL		2015-05-18	279
371	V-MODA - CROSSFADE M-100 Over-the-Ear Headphones - Black	V-MODA		2015-09-11	249
372	Lumix DMC-G7 Mirrorless Micro Four Thirds Digital Camera with 14-42mm Lens and Accessory Kit (Black)	Panasonic		2017-07-18	649
373	SENNHEISER HD 558 Over Ear Headphones HD558 - AUTHORIZED DEALER	Sennheiser	Sennheiser	2015-04-23	149
374	Yamaha - 725W 5.1-Ch. Network-Ready 4K Ultra HD and 3D Pass-Through A/V Home Theater Receiver - Black	Yamaha	YAMAHA	2016-04-09	319
375	Corsair CMY32GX3M4A1600C9 Vengeance Pro 32GB (4x8GB) DDR3 1600 MHz (PC3 12800) Desktop 1.5V	Corsair	Corsair	2015-12-02	285
376	Details About Zmodo Greet Wifi Video Doorbell W/ Zmodo Beam Smart Home Hub And Wifi Extender	Zmodo	Zmodo	2017-07-06	79
377	XB550AP EXTRA BASS Headphones (Black)	Sony		2017-05-20	38
378	1TB WD Black Mobile OEM Hard Drive (WD10JPLX)	WD		2017-07-18	83
379	Escort Passport X70 Long Range Smartphone Live App Enabled Laser Radar Detector	Escort		2017-05-17	299
380	e1659Fwu 16 Widescreen USB 3.1 Gen 1 Powered LED Backlit LCD Monitor	AOC		2015-11-06	96
381	Samsung J3 - Verizon Prepaid	Samsung	Samsung	2017-03-03	109
382	TiVo BOLT 1TB Unified Entertainment System 4K DVR Media Player - White TCD849000	Tivo	TIVO	2016-04-16	219
383	RODE - NTG1 Condenser Shotgun Microphone	RODE	RODE	2015-08-18	306
384	VIRB 360 Action Camera	Garmin		2017-07-12	699
385	AudioQuest NightOwl Carbon Closed-Back Around-the-Ear Headphones	Audioquest		2017-03-06	699
386	SVS - 12 800W Powered Subwoofer - Black oak veneer"	SVS		2015-09-10	1399
387	AudioQuest - RJE Vodka 2.5' Ethernet Cable - Black/Blue	AudioQuest		2015-10-16	249
388	Details About Logitech Ue Roll 2 Wireless Portable Bluetooth Waterproof Speaker	Logitech	Logitech, Inc	2017-04-12	69
389	Details About Incipio Mods Offgrid Power Pack Battery For Motorola Moto Z Force Z2 Black New	Incipio		2017-03-06	89
390	JBL Flip 3 Splashproof Portable Bluetooth Speaker (Teal)	JBL		2016-03-11	79
391	ELECTRIC125H Spectrum Motorized Projection Screen (61 x 109, 110V, 60Hz)	Elite Screens		2015-09-04	259
392	SRS-XB40 Bluetooth Speaker (Blue)	Sony		2017-03-27	248
393	Samsung - 960 EVO 250GB Internal PCI Express 3.0 x4 (NVMe) Solid State Drive for Laptops	Samsung	Samsung IT	2016-12-12	129
394	StarTech.com - DVI Dual-Monitor USB 3.0 Docking Station - Black / Silver	StarTech.com	StarTech.com	2015-08-15	133
395	Apple iPhone SE Gold 16GB for Sprint ( MLY92LL/A )	Apple		2017-03-03	8
396	Lenovo - Yoga 710 2-in-1 11.6 Touch-Screen Laptop - Intel Core i5 - 8GB Memory - 128GB Solid State Drive - Silver Tablet PC Notebook 80V6000PUS"	Lenovo		2016-12-14	724
397	Verizon LG Transpyre 4G LTE Prepaid Smartphone	LG		2015-12-01	66
398	Sylvania SDVD7078 7 Portable DVD Player with Swivel Screen (Certified Refurbished)"	Sylvania		2017-06-25	51
399	Veranda Series 55-Class UHD Outdoor LED TV	SunBriteTV		2017-03-03	1999
400	PDWM1904 Single-Channel Wireless System with Headset Lavalier Microphones	Pyle Pro	PYLE	2015-09-30	82
401	JBL Everest 310 On-Ear Wireless Bluetooth Headphones (Gun Metal)	Jbl		2017-07-12	199
402	AfterShokz Sportz Titanium Open Ear Wired Bone Conduction Headphones	Aftershokz		2017-05-20	80
403	MEE audio X7 Stereo Bluetooth Wireless Sports In-Ear Headphones Blue (EP-X7-BLBK-MEE)	Mee Audio		2017-07-12	42
404	EF-610 DG ST Flash for Sony/Minolta Cameras	Sigma		2015-09-20	165
405	Jensen174 Portable 3-Speed Stereo Turntable With Built-In Speakers - Black (jta-410 )	Jensen	Jensen	2014-12-02	64
406	NETGEAR Nighthawk X10 AD7200 802.11ac/ad Quad-Stream WiFi Router	Netgear	NETGEAR	2017-03-06	449
407	Epson PowerLite 740HD LCD Projector - 720p - HDTV - 16:10 V11H764020	Epson	Epson	2016-04-23	479
408	mophie powerstation Plus Mini External Battery with Built in Cables for Smartphones and Tablets (4	mophie		2017-03-06	47
409	Samsung - Galaxy J7 4G LTE with 16GB Memory Cell Phone (Unlocked) - Black	Samsung		2017-08-21	219
410	HT-XT2 170W 2.1-Channel TV Speaker Base (Black)	Sony	Sony	2016-07-26	104
411	Sol Republic - Amps Air True Wireless In-Ear Headphones - Black	Sol Republic		2017-03-06	179
412	Lenovo - YOGA Wireless Optical Mouse - Black	Lenovo	Lenovo Corporate	2016-05-21	46
413	Photo Hatchback Series BP 150 AW II Backpack (Black/Gray)	Lowepro		2016-03-20	68
414	AVENTAGE RX-A1070 7.2-Channel Network A/V Receiver	Yamaha		2017-07-06	1079
415	AudioQuest - Golden Gate 6.6' Analog RCA Cable - Red	AudioQuest	AUDIOQUEST	2014-02-21	79
416	MCR-B043 30W Bluetooth Wireless Music System (Black)	Yamaha	Yamaha	2016-01-20	249
417	Signature Series 43-Class UHD Outdoor LED TV (Black)	SunBriteTV		2017-03-03	2799
418	Phantom 410 Mid-Tower Case (Gunmetal)	NZXT		2017-07-31	89
419	Disappearing Series DI 5.5S 2-Way Speaker (Single, 5.25 Driver)	Definitive Technology	Definitive Technology	2014-02-21	249
420	MTX - Monitor Series Dual 6-1/2 200W 2-way Center-Channel Speaker (Each) - Black"	MTX	MTX	2015-05-18	75
421	SVS - 12 800W Powered Subwoofer - Gloss piano black"	SVS		2015-09-10	1399
422	SanDisk - 120GB Internal SATA Solid State Drive for Laptops	SanDisk		2017-11-29	49
423	Marantz - NR 250W 5.2-Ch. Hi-Res With HEOS 4K Ultra HD A/V Home Theater Receiver - Black	Marantz		2017-05-20	549
424	Visidec - Focus Double Swing Arm Mount - Polished Silver	Visidec		2017-07-25	130
425	64GB High Speed UHS-I SDXC U3 Memory Card (Class 10)	Sony	Sony	2016-07-06	49
426	A-S801 Integrated Amplifier (Silver)	Yamaha	Yamaha Electronics	2015-08-18	899
427	15.4 MacBook Pro with Touch Bar (Late 2016, Space Gray)	Apple	Apple	2016-12-12	1999
428	Master and Dynamic - MW60 Over-the-Ear Wireless Headphones - Silver Metal/Brown Leather	Master & Dynamic		2017-02-04	549
429	CORSAIR - ML Series 140mm Case Cooling Fan - White	CORSAIR		2017-05-21	30
430	RS 195 Digital Wireless Headphone System	Sennheiser		2017-07-18	383
431	LP-E6N Lithium-Ion Battery Pack (7.2V, 1865mAh)	Canon	Canon Cameras US	2015-03-18	66
432	Details About Zmodo Hd Wifi Home Security Camera Twoway Audio Motion Detection Cloud Service	Zmodo		2017-07-18	36
433	24-70mm f/2.8 GM Lens and 82mm Circular Polarizer Filter Kit	Sony		2017-07-18	2198
434	Yamaha RX-V383BL 5.1-Channel 4K Ultra HD AV Receiver with Bluetooth	Yamaha		2017-07-09	279
435	Sanus Tilt TV Wall Mount for 46 - 90" - Bracket fits most LED"	Sanus		2015-12-02	53
436	Rugged Book Keyboard and Case for iPad Air 2	ZAGG	Zagg	2015-11-06	129
437	Cyber-shot DSC-WX220 Digital Camera (Black)	Sony	Sony	2014-12-02	237
438	HEOS 1 Series 2 Wireless Speaker Pair and Go Pack Kit (Black)	Denon	Denon	2015-12-02	499
439	SiriusXM SXEZR1H1 XM Onyx EZR Satellite Radio with Free 3 Months Satellite and Streaming Service	Siriusxm	SiriusXM	2017-05-20	73
440	Silencio 352 microATX Case (Black)	Cooler Master	Coolermaster	2015-11-08	69
441	SanDisk Ultra II 500GB SATA III SSD - 2.5-Inch 7mm Height Solid State Drive - SDSSDHII-500G-G25	Sandisk		2017-07-13	149
442	PYLE - Amplifier - Black	PYLE		2017-07-25	155
443	Crystal 460X RGB Mid-Tower Case	Corsair		2017-05-21	119
444	Peak Design Slide Strap 2.0 Camera Strap	Peak Design		2018-01-10	64
445	Details About Anker Powercore 20000 Qc 3.0 Black A1272h11	Anker		2017-06-29	44
446	Lightning Charge and Sync Cable, Black	Retrak	Emerge	2016-11-08	13
447	128GB iPod touch (Gold) (6th Generation)	Apple	Apple	2016-12-12	299
448	Refurbished Samsung Curved 65 4K (2160P) Smart QLED TV (2017 Model) + 1 Year Extended Warranty (QN65Q7CAMFXZA)"	Samsung	Samsung	2017-03-03	3497
449	P-Series 55-Class UHD SmartCast LED Home Theater Display	VIZIO	Vizio	2017-01-08	1099
450	AS-5i Pro Sport Earphones (Blue)	Klipsch	KLIPSCH	2015-12-02	79
451	WD 4TB My Cloud Home Personal Cloud Storage - WDBVXC0040HWT-NESN	Western Digital		2017-10-18	250
452	SP-FS52 Andrew Jones Designed Floorstanding Loudspeaker	Pioneer	Pioneer	2015-05-18	129
453	Kenwood KDC-HD262U CD Receiver with Built-in HD Radio	Kenwood		2017-07-25	79
454	Sony - WF 1000X True Wireless In-Ear Noise Canceling Headphones - Black	Sony		2017-12-04	198
455	MU9000-Series 65-Class HDR UHD Smart LED TV	Samsung		2017-06-23	1599
456	MartinLogan - Dynamo 500 10 360-Watt Powered Subwoofer - Black"	MartinLogan		2015-09-10	495
457	Details About Kingston A400 Ssd 120gb Sata Iii 2.5â Internal Solid State Drive Sa400s37/120g	Kingston		2017-03-03	49
458	HP ENVY 34-b010 34-inch Curved All-in-One Computer (Intel Core i7-7700T	Intel		2017-04-03	1829
459	Samsung 860 EVO 500GB 2.5 Inch SATA III Internal SSD (MZ-76E500B/AM)	Samsung		2018-03-06	134
460	Universal Projector Mount with 3 Extension Column	Epson	EPSON AMERICA, INC.	2016-12-12	104
461	KICKER - FrontRow 6-Channel Digital Signal Processor - Black	KICKER		2015-09-21	204
462	XBR-X850E-Series 75-Class HDR UHD Smart LED TV	Sony		2017-03-06	2589
463	Victrola - Bluetooth Stereo Turntable - Map	Victrola		2018-02-27	59
464	SteelSeries Siberia 800 Lag-Free Wireless Gaming Headset with OLED Transmitter and Dolby 7.1 Surround Sound	Steelseries		2018-02-03	299
465	CORSAIR - VENGEANCE Series 16GB (2PK 8GB) 2.4GHz DDR4 Laptop Memory - Black	CORSAIR	Corsair	2016-03-14	189
466	Intuos Creative Pen Tablet (Small, Black)	Wacom		2018-04-13	79
467	Yamaha RX-V479BL 5.1-Channel AV Receiver (Black)	Yamaha	Yamaha	2015-08-18	399
468	Pioneer - Elite 7.2-Ch. Hi-Res 4K Ultra HD HDR Compatible A/V Home Theater Receiver - Black	Pioneer		2017-07-31	499
469	Razer ManO'War Wireless 7.1 Surround Sound Gaming Headset (Black) Man O War READ	Razer		2018-04-13	42
470	4TB Network OEM HDD Retail Kit (8-Pack, WD40EFRX, Red Drives)	WD		2017-07-18	875
471	CORSAIR - VOID PRO RGB Wireless Dolby 7.1-Channel Surround Sound Gaming Heads...	Corsair		2017-09-17	99
472	Details About Samsung Gear Fit2 Pro Fitness Smartwatch Red	Samsung		2017-11-18	149
473	Get Up Stand Bluetooth Home Audio System	House of Marley	House of Marley	2015-11-13	372
474	CORSAIR HYDRO SERIES H100i v2 AIO Liquid CPU Cooler	Corsair	Corsair	2015-12-02	109
475	Peerless - SmartMount Tilt TV Wall Mount for 42 - 71" Flat-Panel TVs - Black"	Peerless	Peerless	2015-10-30	83
476	R120WH2 ezFrame 2 58.7 x 104.7 Fixed Frame Projection Screen	Elite Screens	Elitescreens	2015-05-27	744
477	h.ear go Wireless Speaker (Viridian Blue)	Sony	Sony	2016-07-14	198
478	Sony - SF-UY2 Series 64GB SDXC UHS-I Memory Card	Sony		2017-07-31	37
479	Definitive Technology - SuperCube 4000 8 1200-Watt Powered Subwoofer - Black"	Definitive Technology		2015-09-11	799
480	CORSAIR - VENGEANCE LED Series 16GB (2PK 8GB) 2.4GHz DDR4 Desktop Memory with LED Lighting - Black	CORSAIR		2017-06-24	129
481	Denon - 1295W 7.2-Ch. Hi-Res With HEOS 4K Ultra HD A/V Home Theater Receiver - Black	Denon		2017-07-19	579
482	64GB High Speed microSDXC UHS-I Memory Card (Class 10, U3)	Sony		2015-10-17	59
483	MartinLogan - Axis 5-1/4 2-1/2-Way In-Wall Speaker (Each) - Paintable White"	MartinLogan		2015-07-13	1149
484	Russound - Acclaim 5 Series 100W 2-Way Indoor/Outdoor Speakers (Pair) - Black	Russound		2015-11-16	146
485	AudioQuest - RJE Cinnamon 2.5' Ethernet Cable - Black/Red	AudioQuest	AudioQuest	2015-05-11	74
486	Razer Naga Chroma MMO Gaming Mouse 12 Programmable Thumb Buttons 16000 DPI Wired	Razer	Manufacturers Limited Warranty:2 Year	2015-12-01	29
487	Details About Garmin Dezl 770lmthd 7 Gps With Lifetime Maps & Hd Traffic Updates"	Garmin	Garmin	2017-07-18	379
488	Details About Fits Chevy Silverado Pickup 19992006 Speaker Upgrade Pioneer Tsg1345r Tsg4620s	Pioneer		2017-07-19	20
489	Sennheiser - HD 800 Over-the-Ear Headphones - Silver/Black	Sennheiser	2 Years	2015-08-18	1399
490	Bic America Rtr1530 15 Rtr Series 3-way Tower Speaker"	BIC America	BIC America	2015-04-27	200
491	480GB Extreme Pro Solid State Drive	SanDisk		2015-06-11	219
492	Kicker DSC44 4 D-Series 2-Way Car Speakers with 1/2" Tweeters"	Kicker		2015-12-03	29
493	JBL - 6-1/2 2-Way Coaxial Car Speakers with Polypropylene Cones (Pair) - Black"	JBL		2015-10-30	49
494	Insigniaâ¢ - Battery Charger for Acer, HP and Samsung Chromebooks - Black	Insigniaâ¢		2016-03-11	50
495	Optoma - UHD60 4K DLP Projector with High Dynamic Range - White	Optoma		2017-08-06	1999
496	JOBY GorillaPod 3K Kit. Compact Tripod 3K Stand and Ballhead 3K for Compact Mirrorless Cameras or devices up to 3K (6.6lbs). Black/Charcoal.	Joby		2017-10-18	49
497	SeeThru Hard Shell Case for 13 MacBook Pro (Clear)	Speck	Speck	2015-04-23	36
498	Details About Arris Surfboard Svg2482ac Docsis 3.0 Cable Modem Wifi Router Xfinity Voice Voip	Arris	ARRIS Solutions, Inc.	2017-05-20	239
499	DENAQ - AC Adapter for SONY PCG Series; PCG-XR1 PCG-XR7 PCG-XR9 PCG-Z505GAM PCG-Z505JEK PCG-Z505NR PCG-381L - Black	DENAQ	Denaq	2015-02-12	42
500	Definitive Technology - Mythos 2-way 175 W Speaker - Pack of 1 - Black	Definitive Technology		2015-07-13	399
501	Details About Sony Kd43x720e 43inch 4k Ultra Hd Smart Led Tv (2017 Model) Kd43x720e	Sony		2017-06-30	535
502	Alpine - Rear View Camera - Black	Alpine	Alpine	2015-10-31	149
503	Sennheiser Momentum 2.0 for Samsung Galaxy - Black	Sennheiser		2015-07-13	244
504	RE270K AC750 Wi-Fi Range Extender with Smart Plug	TP-Link		2017-07-04	56
505	Details About Wd Red Pro 8tb Nas Desktop Hard Drive Intellipower 6 Gbs 128 Mb Cache Wd8001ffwx	Western Digital	Western Digital	2016-12-12	447
506	BRAVEN BRV-HD Wireless Bluetooth Speaker [28 Hour Playtime][Water Resistant] Built-In 8800 mAh Power Bank Charger - Black	Braven	Incipio	2015-09-11	129
507	Aluratek AIRMM03F Wi-Fi Internet Radio Streaming Pandora	Aluratek	Aluratek	2016-01-17	98
508	Dell DW316 External USB Slim DVD R/W Optical Drive 429-AAUX	Dell	Dell	2016-03-07	35
509	Galaxy Note 8 SM-N950U 64GB Smartphone (Unlocked, Midnight Black)	Samsung		2017-09-12	929
510	Air-Fi Runaway AF32 Stereo Bluetooth Wireless Headphones with Hidden Microphone (Black)	MEE audio		2017-07-18	35
511	Sony HTST9 Soundbar with Wireless Subwoofer Bluetooth and Google Cast	Sony	Sony	2015-12-02	1498
512	Details About Logitech G403 Prodigy Wireless Gaming Mouse	Logitech		2017-03-06	74
513	Ecoxgear Ecocarbon Bluetooth Waterproof Speaker (black)	ECOXGEAR		2016-04-09	79
514	JVC KW-V220BT DVD/CD/USB Receiver with Bluetooth and 6.2 Touchscreen"	JVC	JVC	2016-03-11	199
515	Marantz - NR 350W 7.2-Ch. Hi-Res With HEOS 4K Ultra HD A/V Home Theater Receiver - Black	Marantz		2017-05-20	749
516	Expert Mouse Wireless Trackball	Kensington		2017-08-04	115
517	Alpine KTP-445U Universal Power Pack Amplifier for Use w/ Aftermarket Head Units	Alpine		2015-09-20	118
518	15.4 MacBook Pro with Touch Bar (Late 2016, Space Gray)	Apple	Apple	2017-03-03	1799
519	TiVo Mini Receiver	Tivo	TiVo	2017-07-18	169
520	OC100T Tilt Mount for 23 to 42 TVs (Black)	OmniMount	OmniMount	2015-12-01	45
521	17.3 WE72 7RJ Mobile Workstation	MSI		2017-04-03	1799
522	Energizer Nikon D5100/3100 Battery Grip	Bower	Bower Camera	2015-11-09	50
524	Toshiba - 2TB Internal SATA Hard Drive for Desktops	Toshiba		2017-07-25	74
525	Pioneer - XDP-300R 32GB* Video MP3 Player - Black	Pioneer		2017-05-20	699
526	Rand McNally 7 Connected Car Tablet Overdryve 7c	Rand McNally		2017-07-01	72
527	Cerwin Vega - SL Series 2-Way Center-Channel Loudspeaker - Black	Cerwin Vega		2015-05-18	198
528	Sima - Multi-Zone Speaker Selectors with Volume Controls - Black	Sima	Sima	2016-02-19	171
529	iHome iBN43BC Bluetooth Stereo Dual Alarm FM Clock Radio and Speakerphone with USB Charging	Sound Design	iHome	2015-12-01	59
530	Lowepro Dashpoint AVC 1, Blue	Lowepro	LowePro	2015-08-22	8
531	Sony XAV-AX100 6.4 Car Play/Android Auto Media Receiver with Bluetooth"	Sony	Sony Mobile Communications, (USA) Inc	2017-03-03	342
532	Details About Sony Kd70x690e 70inch 4k Ultra Hd Smart Led Tv (2017 Model)	Sony		2017-07-25	1363
533	VisionTek Black Label 8GB DDR3 SDRAM Memory Module	VisionTek	Visiontek	2016-03-24	73
534	NETGEAR GS116E-200NAS / NETGEAR ProSafe Plus GS116Ev2 - Switch - unmanaged - 16 x 10/100/1000 - desktop	NETGEAR		2017-07-25	169
535	GoSafe S30 1080p Dash Cam	Papago	Papago	2016-05-15	99
536	Details About Netgear Modem Vdsl/adsl Broadband High Speed Dsl Dm200 Verizon At&t Used!	Netgear	NETGEAR	2017-01-17	59
537	Mevo Live Event Camera Kit with Mevo Boost, Stand Case (Black)	Mevo		2017-03-03	299
538	Sideclick - Universal Remote Attachment for RokuÂ® Streaming Players - Black	Sideclick		2017-03-03	42
539	Sharp - 50W Executive Hi-Fi Component System - Black	Sharp		2015-08-18	149
540	Wacom Wireless Accessory Kit for Bamboo and Intuos Tablets (ACK40401)	Wacom		2018-02-03	36
541	Cooler Master - HAF X Ultimate Full-Tower Chassis - Black	Cooler Master		2017-07-25	187
542	VPL-HW45ES Full HD Home Theater Projector (Black)	Sony	Sony	2016-09-25	1798
543	HP - Bluetooth Laser Mouse - Black	PNY	HP Inc	2015-07-06	29
544	ELECTRIC100H Spectrum Motorized Projection Screen (49 x 87, 110V, 60Hz)	Elite Screens	Elitescreens	2015-12-02	189
545	X6D X105-RF-X1-BBY Rechargeable Active RF/Bluetooth 3D Glasses Full HD	X6D	x6d inc	2015-12-02	67
546	Samsung - Adaptive Fast Charging Wall Charger - White	Samsung	Samsung	2015-12-02	9
547	MusicCast Wireless Speaker, White	Yamaha	YAMAHA	2015-12-02	249
548	AudioQuest - DragonFly Black USB DAC and Headphone Amp v1.5 - Black	AudioQuest	Audioquest	2016-05-09	94
549	Sunpak - Universal Travel Power Adapter for Select Electronic Devices - White	Sunpak	Sunpak	2015-10-17	12
550	Monster SuperStar BackFloat High-Definition Bluetooth Speaker, Neon Green	Monster		2017-06-29	90
551	Diamond GC1500 HD Video Capture/Game Box Recorder for Windows	Diamond Multimedia	Diamond Multimedia	2016-07-26	94
552	Sennheiser CX 7.00BT Wireless In-Ear Headphone	Sennheiser		2017-12-11	149
553	JBL Reflect Contour 2 Wireless Sport In-Ear Headphones with Three-Button Remote and Microphone (Blue)	JBL		2018-04-18	99
554	SanDisk Ultra II 1TB SATA III SSD - 2.5-Inch 7mm Height Solid State Drive - SDSSDHII-1T00-G25	SanDisk		2017-07-02	299
555	Samsung - 55 Class - LED - Q8F Series - 2160p - Smart - 4K UHD TV with HDR"	Samsung		2018-04-18	2199
556	X900F-Series 55-Class HDR UHD Smart LED TV	Sony		2018-03-14	1498
557	Samsung SNH-P6410BN SmartCam HD Pro 1080p WiFi IP Camera	Samsung		2017-07-18	159
558	Olympus TG-5 Waterproof Camera with 3-Inch LCD	Olympus		2017-05-20	449
559	Yamaha - AVENTAGE 7.2-Ch. 4K Ultra HD A/V Home Theater Receiver - Black	Yamaha		2017-07-09	1064
560	Onkyo M-5010 2-Channel Amplifier (Black)	Onkyo	ONKYO	2015-05-18	229
561	BoseÂ® - CompanionÂ® 20 Multimedia Speaker System (2-Piece) - White	BoseÂ®	Bose	2015-11-08	249
562	Samsung - Galaxy J3 4G LTE with 16GB Memory Cell Phone (Unlocked) - Black	Samsung		2017-08-21	149
563	Panamax - 8-Outlet Power Conditioner/Surge Protector - Gray	Panamax		2015-09-10	66
564	NS-PA40 5.1-Channel Speaker System (Black)	Yamaha	Yamaha	2015-08-14	349
565	R-S300 Natural Sound Stereo Receiver	Yamaha	Yamaha	2015-06-22	279
566	SanDisk - Extreme PRO 64GB SDXC UHS-II Memory Card	SanDisk	Manufacturers Limited Warranty:Lifetime	2017-07-18	115
567	XD3 - 3 Active Desktop Monitor System (Pair)	Cerwin-Vega	Cerwin Vega	2015-04-20	99
568	Sony Hi8 Camcorder 8mm Cassettes 120 Minute (4-Pack) (Discontinued by Manufacturer)	Sony	Sony	2014-08-29	29
569	JVC - In-Dash CD/DM Receiver - Built-in Bluetooth with Detachable Faceplate - Black	Jvcm	JVC	2017-01-08	77
570	CORSAIR - Vengeance LPX 16GB (2PK x 8GB) 3.2 GHz DDR4 DRAM Desktop Memory Kit - Black	CORSAIR		2017-07-31	219
571	Definitive Technology - Wireless Audio Adapter - Black/Silver	Definitive Technology		2015-09-11	399
572	Sharp Aquos N7000 65 Class 4K Ultra WiFi Smart LED HDTV"	Sharp	Sharp	2016-12-12	854
573	Roll Bar Mount	GoPro	Go-Pro	2015-05-11	29
574	iSimple - StrongHold Headrest Mount for Most 7 - 10.2" Tablets - Black"	iSimple	iSimple	2015-05-30	30
575	WD - My Book 6TB External USB 3.0 Hard Drive - Black	Western Digital		2018-01-31	169
576	Stile Collection Bella IV Shoulder Bag (Black)	Manfrotto	Manfrotto	2015-07-13	14
577	HDR-AS200V Full HD Action Cam	Sony	120	2017-07-20	149
578	SAMSUNG 65 Class 4K (2160P) Ultra HD Smart QLED HDR TV QN65Q6FNAFXZA (2018 Model)"	Samsung		2017-03-13	1089
579	Atrend-Bbox 10 Dual Front-Fire Enclosure for Dodge Ram 19962002"	Atrend	Atrend	2014-11-07	78
580	JOBY GorillaPod SLR Zoom. Flexible Tripod with Ballhead Bundle for DSLR and Mirrorless Cameras Up To 3kg. (6.6lbs).	Joby	Joby	2017-07-21	46
581	Bose SoundLink Color Bluetooth Speaker (Black)	Bose	Bose	2015-11-09	116
582	Sennheiser - CX 3.00 Earbud Headphones - Red	Sennheiser		2015-02-05	34
583	Samsung - 49 Class (48.5" Diag.) - LED - 1080p - Smart - HDTV"	Samsung		2017-08-26	479
584	Lenovo - 100S-14IBR 14 Laptop - Intel Celeron - 2GB Memory - 32GB eMMC Flash Memory - Navy blue"	Lenovo		2017-03-13	229
585	TL-SG108 8-Port 10/100/1000 Mbps Unmanaged Desktop Switch	TP-Link		2017-07-18	24
586	Sony MDR-1000X/C Wireless Bluetooth Noise Cancelling Hi-Fi Headphones (Certified Refurbished)	Sony		2017-03-06	348
587	PYLE - 8 Single-Voice-Coil 4-Ohm Subwoofer with Integrated Amplifier - Black"	Pyle	Sound Around	2015-10-17	136
588	VG939SM 19 Ergonomic LED LCD Multimedia Display	ViewSonic		2016-01-05	89
589	Apple MNF72LL/A 61W USB-C Power Adapter	Apple	Apple Computer (Direct)	2017-03-06	69
590	iSimple - TranzIt Bluetooth Factory Radio Module - Black	Isimple	iSimple	2015-11-09	72
591	Logitech G433 7.1 Wired Gaming Headset with DTS Headphone: X 7.1 Surround for PC	Logitech		2018-02-03	99
592	ER120WH2 SableFrame 2 58.8 x 104.6 Fixed Frame Projection Screen	Elite Screens	Elitescreens	2015-10-30	404
593	Zoom - H1 Handy Recorder - Black	Zoom	Zoom	2014-11-07	79
594	Refurbished TCL 49 Class 4K (2160P) Roku Smart LED TV (49S405)"	TCL		2018-01-30	319
595	Pioneer 200W 4x6 Inch 3 Way 4 Ohms Coaxial Car Audio Speakers Pair | TS-A4676R	Pioneer	Pioneer	2015-11-01	43
596	BIC America - 6-1/2 Floor Speaker (Each) - Black"	BIC America	BIC America	2015-07-13	149
597	Refurbished Jaybird F5-S-B Freedom F5 In-Ear Wireless Headphones - Carbon	Jaybird	JAYBIRD	2016-11-07	88
598	1080p Day/Night PTZ Speed Dome Camera with 5 to 61mm Auto Focus Lens	Lorex	Lorex	2015-10-17	478
599	Niles - Directed Soundfield 7 2-Way Stereo Input In-Ceiling Speaker (Each) - Silver"	Niles		2015-07-13	259
600	Sanus WSS2-W1 White Sonos Speaker Stands	SANUS		2017-07-31	99
601	CapturePRO Camera Clip with PROplate	Peak Design	Limited Lifetime Warranty	2015-04-20	149
602	WD 8TB My Cloud EX2 Ultra Network Attached Storage - NAS - WDBVBZ0080JCH-NESN	Western Digital	Western Digital	2016-04-15	473
603	4GB NW-WS413 Sports Walkman Digital Music Player (Black)	Sony	Sony	2017-01-07	78
604	JBL Trip Visor Mount Portable Bluetooth Hands-Free Kit (Black)	JBL	JBL	2016-03-14	99
605	Relays Sports Wireless In-Ear Headphones (Gray)	SOL REPUBLIC		2017-03-03	49
606	SanDisk 8GB Clip Jam MP3 Player (Pink)	Sandisk	SanDisk	2015-08-18	34
607	Lumix G 25mm f/1.7 ASPH. Lens	Panasonic	Panasonic	2015-10-16	149
608	Onkyo TX-NR555 7.2-Channel Network A/V Receiver	Onkyo	Onkyo	2016-10-18	389
609	iSimple - BluStream Bluetooth Factory Radio Module - Black	Isimple	Pac	2015-10-30	39
610	Jabra Sport Coach Special Edition Sport Headset	Jabra		2017-03-06	119
611	Yamaha - 30W Desktop Audio System - White	Yamaha		2015-12-14	349
612	CORSAIR - ValueSelect 16GB (2PK x 8GB) 1.3 GHz DDR3 SDRAM Laptop Memory - Multi	Corsair		2017-07-31	132
613	Pro-Ject - Box E Digital-to-Analog Converter - Black	Pro-Ject		2017-10-05	79
614	D-Link - DCS Indoor 720p Wi-Fi Network Surveillance Cameras (2-Pack) - White	D-Link		2017-09-04	119
615	R6i In-Ear Headphones (Black)	Klipsch		2017-07-18	79
616	Samsung - 55 Class - LED - Curved - MU6490 Series - 2160p - Smart - 4K Ultra HD TV with HDR"	Samsung		2017-08-21	797
617	PA248Q 24 LED Backlit IPS Widescreen Monitor	ASUS		2016-03-18	322
618	Bose SoundTrue around-ear headphones II - Apple devices	Bose	BOSE	2015-12-02	119
619	PreSonus - Eris E8 2-Way Active Studio Monitor (Each) - Black	PreSonus	PreSonus	2015-11-16	187
620	Polk Audio - Dual 6.5 Center-Channel Speaker - Cherry"	Polk Audio	Polk Audio	2015-09-22	1199
621	Definitive Technology - DT Series 6.5 2-Way In-Ceiling Speaker (Each) - Black"	Definitive Technology		2015-07-13	249
622	AudioQuest - RJE Cinnamon 4.9' Ethernet Cable - Black/Red	AudioQuest	AudioQuest	2015-05-11	89
623	SunBriteTV - Signature Series - 43 Class - LED - Outdoor - Partial Sun - 2160p - 4K UHD TV with HDR"	SunBriteTV		2017-03-03	2799
624	i.am+ BUTTONS	I.am+		2017-05-21	199
625	HEOS 5 Wireless Speaker System (Series 2, White)	Denon	Denon	2015-04-27	299
626	AX860i Digital ATX 860W Power Supply	Corsair		2015-12-02	198
627	ZTE Warp Elite No Contract Phone - Retail Packaging - Boost	ZTE	ZTE	2015-12-02	59
628	LG - 55 Class - LED - UJ7700 Series - 2160p - Smart - 4K UHD TV with HDR"	LG		2018-01-30	796
629	Level Active Wireless In-Ear Headphones (Black)	Samsung		2017-03-03	32
630	JBL Everest 750 Over-Ear Wireless Bluetooth Headphones (Gun Metal)	Jbl		2017-07-12	299
631	GP60NB50 8x Super-Multi Portable DVD Rewriter with M-DISC	LG	LG ODD	2017-07-19	28
632	Details About Kenwood 12 Inch 2000 Watt 4 Ohm Single Voice Coil Audio Subwoofer | Kfcw3016ps	Kenwood	Parts	2015-09-20	56
633	ND Case for iPad mini 1/2/3 (Black)	LifeProof	OtterBox	2015-12-04	119
634	SunBriteTV - Veranda Series - 43 Class - LED - Outdoor - Full Shade - 2160p - 4K UHD TV with HDR"	SunBriteTV	1-Year	2017-03-06	1499
635	Acer 15.6 Chromebook CB5-571-C4G4	Acer	Acer	2016-03-12	223
636	WD Blue 1TB SATA 6 Gb/s 7200 RPM 64MB Cache 3.5 Inch Desktop Hard Drive (WD10EZEX)	Western Digital		2017-05-20	49
637	Details About Netgear Powerline 1000 Mbps Wifi 802.11ac 1 Gigabit Port Plw1000100nas	Netgear		2018-01-30	119
638	MX Anywhere 2S Wireless Mouse	Logitech		2018-04-10	79
639	Samsung - 55 Class - LED - Curved - Q7C Series - 2160p - Smart - 4K UHD TV with HDR"	Samsung		2017-07-18	2395
640	Sony - 5.1-Ch. 3D / Smart Blu-ray Home Theater System - Black	Sony	Sony	2015-05-11	198
641	Sony SRSXB3/BLK Portable Wireless Speaker with Bluetooth (Black)	Sony		2016-06-12	49
642	Pioneer GM-D8601 Class D Mono Amplifier with Wired Bass Boost Remote	Pioneer	Pioneer	2015-11-09	118
643	Tough Portable Bluetooth Speaker (Black and Silver)	FUGOO	Fugoo	2015-01-09	229
644	Elite SC-LX501 7.2-Channel Network A/V Receiver	Pioneer		2017-03-03	899
645	CORSAIR CL-9011109-WW Lighting Node PRO	Corsair		2017-07-02	51
646	NB-13L Lithium-Ion Battery Pack (3.6V, 1250mAh)	Canon	Canon Cameras US	2015-12-02	50
647	Portable Bluetooth Wireless Speaker, Red	iLive	Ilive Blue	2015-10-17	12
648	inactive	Bower		2015-09-11	29
649	Crosley CR49-TA Traveler Turntable with Stereo Speakers and Adjustable Tone Control, Tan	Crosley	Crosley Radio	2015-09-11	204
650	PyleHome - LCD Projector - Silver/White	PyleHome		2017-07-24	167
651	Yamaha - Mini Hi-Fi System - 40 W RMS - iPod Supported - Piano Black	Yamaha	YAMAHA	2015-08-18	349
652	UM Pro10 Single-Driver Universal In-Ear Monitors (Blue, First Generation)	Westone	Westone Laboratories, Inc.	2015-09-11	149
653	Seagate - SkyHawk Surveillance HDD 6TB Internal SATA Hard Drive for Desktops	Seagate		2017-03-03	197
654	Spartan - 1-Target 24x DVD/CD Duplicator - Black	Spartan	Spartan	2015-10-29	183
655	Elite A-20 2-Channel Integrated Amplifier	Pioneer	Pioneer	2015-05-18	299
656	Yamaha - 6-1/2 2-Way In-Ceiling Speakers (Pair) - White"	Yamaha	Yamaha	2014-10-28	129
657	Cobra - Radar and Laser Detector	Cobra Electronics		2017-07-18	106
658	Apple MacBook - 12 - Core m5 - 8 GB RAM - 512 GB flash storage - English"	Apple	Apple	2016-05-25	1547
659	21.5 iMac with Retina 4K Display (Mid 2017)	Apple	Apple	2017-06-29	1461
660	Sabrent Sp-byta Speaker System - 2 W Rms - Wireless Speaker[s] - Usb - Ipod Supported (sp-byta)	Sabrent	Sabrent	2015-11-16	29
661	House of Marley	House of Marley		2017-03-06	132
662	Pinnacle P1 High Fidelity Audiophile In-Ear Headphones	MEE audio	MEE audio	2017-03-06	179
663	Klipsch X20i In-Ear Headphones	Klipsch Xr8i In-Ear Headphones	Klipsch X12 Bluetooth Neckband Headphones (black Leather)	2017-03-06	549
664	BS-GS2024P 24 Gigabit PoE Smart Switch	Buffalo		2015-10-18	399
665	SF Slim Lens Pouch 75 AW	Lowepro	Lowepro	2015-10-24	34
666	UM Pro 30 Triple-Driver with 3-Way Crossover In-Ear Monitors (Smoke)	Westone	Westone Laboratories, Inc.	2015-09-11	269
667	ECO STYLE - Sports Voyage Backpack - Black/Platinum	ECO STYLE	ECO STYLE	2015-11-30	79
668	120 Bulb LED Video Light (Daylight)	Bower	Bower	2015-09-11	89
669	Phantom 410 Mid-Tower Case (White)	NZXT	NZXT	2015-04-23	82
670	A-S801 Integrated Amplifier (Black)	Yamaha	Yamaha Electronics	2015-08-18	899
671	Sony Ultra-Portable Bluetooth Speaker	Sony	Sony	2015-11-06	69
672	BoseÂ® - Virtually InvisibleÂ® 791 In-Ceiling Speakers II (Pair) - White	BoseÂ®	Bose	2015-12-02	599
673	Linksys AC1900 Gigabit Range Extender/WiFi Booster/Repeater MU-MIMO (Max Stream RE7000)	Linksys		2018-01-30	140
674	Alpine - 5 x 7" 2-Way Coaxial Car Speakers with Poly-Mica Cones (Pair) - Black"	Alpine	Alpine	2014-02-20	59
675	450 Mbps 2.4/5GHz Wireless N Dual Band PCI Express Adapter	TP-Link		2015-10-31	39
676	Sony STRDN1070 7.2-channel AV Receiver w/ Bluetooth	Sony	Sony	2016-07-19	687
677	AF-S NIKKOR 85mm f/1.8G Lens	Nikon		2017-07-18	419
678	Definitive Technology - W9 Dual 5-1/4 180W 2-Way Wireless Speaker (Each) for Streaming Music - Black"	Definitive Technology	1 Year	2015-09-11	699
679	PNY - 16 GB (2PK x 8GB) 1.8 GHz DDR3 DIMM Desktop Memory Kit - Black	Pny		2017-07-18	104
680	SiriusXM SXSD2 Portable Speaker Dock Audio System for Dock and Play Radios (Black)	SiriusXM	Audiovox	2015-05-18	103
681	SanDisk - Ultra II 960GB Internal SATA Solid State Drive for Laptops	SanDisk		2017-07-20	279
682	BoseÂ® - SoundSportÂ® In-Ear Headphones (Android) - Charcoal	BoseÂ®		2015-11-13	46
683	Sony - XB20 Portable Bluetooth Speaker - Blue	Sony		2017-03-27	78
684	Energizer - Recharge Rechargeable AA Batteries (8-Pack)	Energizer	Energizer	2015-04-02	26
685	Yamaha - Natural Sound 6-1/2 3-Way In-Wall Speakers (Pair) - White"	Yamaha	Yamaha	2015-12-01	125
686	LG Electronics OLED65C7P 65-Inch 4K Ultra HD Smart OLED TV - Refurbished	LG		2017-06-29	2996
687	Details About *new~sennheiser Hd 4.50 Btnc Wireless Noise Cancelling Headphones~touch Controls	Sennheiser		2017-06-24	199
688	JBL Everest Elite 100 NXTGen Noise-Cancelling Bluetooth In-Ear Headphones Black	JBL	Jbl Everest 110 In-Ear Wireless Bluetooth Headphones (silver)	2017-03-03	199
689	Samsung - LED Wallet Cover for Samsung Galaxy S8 - Black	Samsung		2017-10-04	49
690	Klipsch - Reference Series 2.1-Channel Soundbar System with 6-1/2 Wireless Subwoofer and Digital Amplifier - Black"	Klipsch	Klipsch	2017-03-06	299
691	Polk Audio - Vanishing Series RT 7 3-Way In-Ceiling Speaker (Each) - White"	Polk Audio		2015-12-01	166
692	AudioQuest - Sydney 4.9' RCA-to-RCA Interconnect Cable - Dark Gray/Black	AudioQuest		2015-05-11	179
693	AudioQuest - RJE Vodka 4.9' Ethernet Cable - Black/Blue	AudioQuest	AudioQuest	2015-05-11	339
694	SVS - 12 800W Powered Subwoofer - Black"	SVS		2015-09-10	1199
695	X900F-Series 75-Class HDR UHD Smart LED TV	Sony		2018-03-14	3499
696	Details About Seagate 4 Terabyte (4tb) Superspeed Usb 3.0 Game Drive For Xbox One Stea4000402	Seagate	Seagate Technology	2016-12-28	129
697	Onkyo - TX 7.2-Ch. Network-Ready A/V Home Theater Receiver - Black	Onkyo	Onkyo	2017-05-20	339
698	Lumix G 42.5mm f/1.7 ASPH. POWER O.I.S. Lens	Panasonic		2015-11-02	282
699	Samsung - 65 Class - LED - MU6290 Series - 2160p - Smart - 4K Ultra HD TV with HDR"	Samsung		2017-11-17	798
700	Single DIN Head Unit Receiver - In-Dash Car Stereo with 7â Multi-Color Touchscreen Display - Audio Video System with Bluetooth for Wireless Music Streaming & Hands-free Calling - Pyle PLTS78DUB	Pyle	Pyle	2015-10-16	223
701	Apple MacBook Pro with Touch Bar - 13.3 - Core i5 - 8 GB RAM - 512 GB SSD - English"	Apple	Apple	2017-03-03	1749
702	BC 30 Wireless Backup Camera with Car Adapter Power Cable	Garmin	Garmin	2015-12-15	149
703	BC-TRW W Series Battery Charger (Black)	Sony	Sony	2014-05-30	39
704	Yamaha - Natural Sound 6-1/2 2-Way All-Weather Outdoor Speakers (Pair) - White"	Yamaha		2015-12-02	99
705	Google Daydream View - VR Headset (Slate)	Google		2017-06-29	89
706	Apple USB-C VGA Multiport Adapter	Apple		2017-07-18	24
707	Pioneer - 8x External USB 3.0 Quad-Layer Blu-ray Disc DL DVDÂ±RW/CD-RW Drive - Silver	Pioneer	Pioneer	2017-07-18	74
708	h.ear go Wireless Speaker (Cinnabar Red)	Sony	Sony	2016-07-14	198
709	Alpha a7 Mirrorless Digital Camera with 28-70mm Lens and Battery Kit	Sony		2017-07-18	949
710	Cyber-shot DSC-RX100 V Digital Camera	Sony	Sony	2016-11-04	998
711	Toshiba TH-GW10 Symbio 6-in-1 Smart Home Solution and Security Camera with an Amazon Alexa Speaker built-in	Toshiba		2018-03-16	249
712	Turtle Beach - EAR FORCE Stealth 450 Over-the-Ear Wireless Gaming Headset for PC - Black/Red	Turtle Beach		2016-07-26	79
713	KICKER - 6.5 2-Way Full-Range Speakers (Pair) - White"	Kicker	KICKER	2015-11-06	99
714	ECOXGEAR - ECOSTONE Bluetooth Waterproof Speaker - Blue	ECOXGEAR	Grace Digital Audio	2015-09-13	110
715	Tiffen - 72mm Neutral-Density 0.9 Lens Filter	Tiffen	Tiffen	2014-10-21	33
716	Pioneer - 5.1-Ch. 4K Ultra HD HDR Compatible A/V Home Theater Receiver - Black	Pioneer		2017-07-09	299
717	V-MODA Crossfade Wireless Over-Ear Headphones - Phantom Chrome	V-Moda	V-Moda	2015-09-11	279
718	Hisense - 55 Class - LED - H8 Series - 2160p - Smart - 4K UHD TV with HDR"	Hisense	Spacepole Ince	2017-01-06	549
719	Details About Optoma Hd142x Full Hd 10980p 3d Dlp Home Theater Projector	Optoma		2017-07-18	527
720	Sonos - CONNECT Wireless Streaming Music Stereo Component - White	Sonos	Sonos	2015-05-20	349
721	MG7310-10 8x4 343 Mbps DOCSIS 3.0 Cable Modem N300 Wi-Fi Router	Motorola	MTRLC LLC	2016-03-16	69
722	8GB Clip Jam MP3 Player (Black)	SanDisk		2017-01-07	37
723	Kenwood DDX9703S 6.95 Double-DIN In-Dash DVD Receiver with Bluetooth	Kenwood	KENWOOD	2016-08-29	439
724	SanDisk  Extreme Pro 32 GB SDHC	SanDisk	SanDisk	2015-08-18	64
725	Aeon 71.5 x 130.9 16:9 Fixed Frame Projection Screen with CineWhite Projection Surface	Elite Screens	Elitescreens	2015-10-30	699
726	Fusion - 4 2-Way Marine Speakers with Polypropylene Cones (Pair) - White"	Fusion Marine	Fusion	2014-10-28	69
727	Pulse LED Light Bulb with Wireless Speaker (Pair, Pewter)	Sengled	1 year warranty	2015-08-22	149
728	House of Marley - TTR Over-the-Ear Headphones - Silver/Black	ONLINE		2015-09-11	120
729	Marantz - 280W 2.0-Ch. Stereo Power Amplifier - Black	Marantz	Marantz	2015-05-18	799
730	Yamaha - 10 250W Powered Subwoofer - High-Gloss Piano Black"	Yamaha		2015-08-18	499
731	Powerstation XXL Three-USB 20,000mAh Battery Pack (Rose Gold)	mophie		2017-06-14	99
732	V-MODA Crossfade 2 Wireless Over-Ear Headphone - Matte Black	V-Moda		2017-05-20	249
733	Details About Bose Quietcomfort 35 Noise Cancelling Wireless Headphones Series Ii Qc35 Black	Bose		2017-09-26	349
734	Details About Openbox Excellent: Asus Rog Gl502vm 15.6 Laptop Intel Core I7 12gb Me..."	Asus		2017-03-06	1124
735	Case for Microsoft Surface Pro and Pro 4 (Black)	Urban Armor Gear	Urban Armor Gear	2015-12-02	61
736	Asus - 2-in-1 15.6 4K Ultra HD Touch-Screen Laptop Intel Core i7 16GB Memory NVIDIA GeForce GTX 950M - 2TB HDD + 512GB SSD - Sandblasted matte black aluminum"	Asus		2017-06-22	1099
737	UM Pro10 Single-Driver Universal In-Ear Monitors (Clear)	Westone	Westone Laboratories, Inc.	2015-11-16	99
738	2PJ4280 - Peerless-AV Wall Mount for Tablet PC	Peerless-AV		2015-08-18	39
739	MM8077 7-Channel Power Amplifier	Marantz	Marantz	2015-08-15	2399
740	Buffalo Technology - DriveStation Axis Velocity 3TB External USB 3.0/2.0 Hard Drive - Black	Buffalo Technology	Buffalo Technology	2015-04-27	125
741	Yamaha - A-S2100 320W 2-Ch. Integrated Amplifier - Black	Yamaha		2015-07-10	3499
742	Yamaha - 30W Desktop Audio System - Black	Yamaha		2015-10-31	331
743	Details About Evga Nvidia Geforce Gtx 1080 Sc Gaming 8gb Gddr5x Pci Express 3.0 Graphics ...	Evga		2018-03-12	959
744	Russound - 150W Indoor/Outdoor Speaker (Each) - Black	Russound		2015-09-11	181
745	Sony - 2.1-Channel Soundbar System with 6.3 Wireless Subwoofer and Digital Amplifier - Black"	Sony		2017-05-20	398
746	Samsung - 65 Class - LED - MU7000 Series - 2160p - Smart - 4K UHD TV with HDR"	Samsung		2017-05-20	1129
747	Sony XBR55X700D 55-Inch 4K Ultra HD Smart LED TV (2016 Model)	Sony		2017-07-18	798
748	Sony SRS-XB41 Portable Wireless Bluetooth Speaker - Black - SRSXB41/B (Certified Refurbished)	Sony		2018-04-21	248
749	Sony 43 Class 4K UHD (2160P) Smart LED TV (XBR43X800E)"	Sony		2017-03-06	648
750	Sharp CD-BH950 240W 5-Disc Mini Shelf Speaker System with Cassette and Bluetooth	Sharp		2017-03-03	129
751	Pioneer - Andrew Jones Soundbar System with 6-1/2 Wireless Subwoofer - Black"	Pioneer	Pioneer	2015-08-18	319
752	Logitech G933 Artemis Spectrum â Wireless RGB 7.1 Dolby and DST Headphone Surround Sound Gaming Headset â PC	Logitech		2018-02-01	77
753	R8000P Nighthawk X6S AC4000 Wireless Tri-Band Gigabit Router	Netgear		2017-07-25	279
754	CD-C600 5-Disc CD Changer	Yamaha	Yamaha	2015-05-18	329
755	PNY - 8GB 1.6 GHz DDR3 DIMM Desktop Memory - Green	PNY		2015-12-01	89
756	Kanto - sub8 8 120W Powered Subwoofer - Gloss Black"	Kanto		2015-09-10	279
757	Epson - Home Cinema 2045 LCD Projector - White	Epson	Epson	2016-03-14	717
758	Russound - 2-Way Outdoor Rock Loudspeaker (Each) - Gray Granite	Russound	Russound	2015-09-11	299
759	Microsoft - Wireless Comfort Desktop 5050 Curved Keyboard and Mouse - Black	Microsoft		2015-12-01	49
760	KICKER - CS Series 4 2-Way Car Speakers with Polypropylene Cones (Pair) - Black"	Kicker	Kicker	2017-03-03	40
761	HyperX - Cloud Flight Wireless Stereo Gaming Headset for PC, PS4, Xbox One, Nintendo Wii U, Mobile Devices - Black	HyperX		2018-05-07	159
762	TiVo - Roamio OTA VOX 1TB Digital Video Recorder - Black	TiVo		2018-03-14	399
763	W650D-Series 48-Class Full HD Smart LED TV	Sony		2016-05-09	448
764	BOYO - Concealed Mount License Plate Camera with Night Vision - Black	BOYO	Boyo	2015-10-31	37
765	Master and Dynamic MH40S2 Award Winning Over-ear	Master Dynamic		2015-09-11	324
766	Acer Predator G1-710 Desktop Computer - Intel Core i7-6700 3.4 GHz - 16 GB DDR4 SDRAM - 2 TB HDD + 512 GB SSD	Acer		2017-03-06	1599
767	House of Marley	House Of Marley		2017-03-03	59
768	Beats Solo 2 Wireless On-Ear Headphone - White-(Certified Refurbished)	Beats	Beats	2015-09-07	119
769	DP-300F Fully Automatic Turntable	Denon	Denon	2015-08-18	199
770	LED Wallet Cover for Galaxy S8+ (Black)	Samsung		2017-04-12	49
771	Samsung - 65 Class - LED - Curved - MU7500 Series - 2160p - Smart - 4K UHD TV with HDR"	Samsung		2018-05-28	1897
772	LG - MiniBeam PH550 720p DLP Projector - White	LG		2016-04-12	546
773	Apple - iPad Air 2 Wi-Fi + Cellular 128GB - Gold	Apple		2015-05-30	829
774	Sony - 55 Class - LED - X800E Series - 2160p - Smart - 4K UHD TV with HDR"	Sony		2017-03-06	1896
775	4K Video Camera	360fly		2017-07-18	319
776	YSP-4300 Digital Sound Projector Wireless Active Subwoofer (Black)	Yamaha	Yamaha	2014-08-28	1799
777	Alpine PDXM12 1200W Mono RMS Digital Amplifier	Alpine	Alpine	2014-02-21	849
778	NVIDIA - GeForce GTX 1070 Founders Edition 8GB GDDR5 PCI Express 3.0 Graphics Card - Black	NVIDIA		2017-07-02	429
779	Samsung - 850 EVO 500GB Internal SATA Solid State Drive for Laptops and PC	Samsung		2017-07-18	177
780	RCA Indoor Digital TV Antenna, Amplified, 40-Mile Range	RCA	RCA	2015-04-23	30
781	Universal Foldable Bluetooth Keyboard for Mobile Devices	Microsoft		2017-07-18	68
782	Kicker KB6000 6.5 Full Range Indoor/Outdoor/Marine Speakers - Black 11KB6000B"	Kicker	KICKER	2014-10-21	99
783	Details About Alpine 400w 5.25 Typee Coaxial 2way Car Speakers | Spe5000"	Alpine	Alpine	2014-02-21	69
784	P101 Ceiling Projector Mount (White)	Kanto Living	Kanto	2015-09-13	39
785	Apple - MacBook ProÂ® - 13 Display - Intel Core i5 - 8 GB Memory - 512GB Flash Storage (Latest Model) - Silver"	Apple		2017-07-16	1999
786	Connect Dual-Headphone Bluetooth Audio Transmitter	MEE audio		2017-07-31	59
787	Details About Sylvania Dual Portable Dvd Player W/ 9inch Widescreen Led Display Refurbished	Sylvania	Sylvania	2016-05-06	115
788	Sony - 1155W 7.2-Ch. Hi-Res Network-Ready 4K Ultra HD and 3D Pass-Through HDR Compatible A/V Home Theater Receiver - Black	Sony		2017-05-20	450
789	EcoXGear Ecostone Bluetooth Speaker	Grace Digital	Ecoxgear	2015-11-01	169
790	Sherwood - 200W 2.0-Ch. A/V Home Theater Receiver - Black	Sherwood	Sherwood	2015-05-18	130
791	Sandisk Extreme CompactFlash Memory Card - 64 GB (SDCFXS-064G-A46)	Sandisk	Manufacturers Limited Warranty:Lifetime	2015-09-13	49
792	Ghostek - Atomic Protective Waterproof Case for Samsung Galaxy Note 5 - Black	Ghostek		2017-04-12	64
793	BenQ - CineHome HT2050A 1080p DLP Projector - White	BenQ		2018-01-15	749
794	Lenovo - 2-in-1 11.6 Touch-Screen Chromebook - MT8173c - 4GB Memory - 32GB eMMC Flash Memory - Dark gray"	Lenovo		2017-12-14	298
795	Pro Runner BP 450 AW II Backpack (Black)	Lowepro		2015-12-02	249
796	Samsung 850 EVO 2TB 2.5-Inch SATA III Internal SSD (MZ-75E2T0B/AM)	Samsung		2018-05-28	749
797	Logitech iPad Slim Folio: Case with Wireless Keyboard with Bluetooth (Black) - iPad 5th generation	Logitech		2017-06-24	69
798	Cobra - CDR895D Front and Rear Camera Dash Cam - Black	Cobra		2017-07-25	168
799	Details About Netgear Cm700 Docsis 3.0 32x8 High Speed Cable Modem	Netgear	Netgear Inc	2017-03-02	97
800	MG278Q 27 Widescreen LED Backlit TN Gaming Monitor	ASUS	Asus	2015-10-30	495
801	SRS-XB2 Portable Bluetooth Wireless Speaker (Red)	Sony	Sony	2016-07-07	49
802	Insignia - Fixed TV Wall Mount For Most 40-70" TVs - Black NS-HTVMF0C"	Insignia		2017-03-03	56
803	LG - 65 Class - OLED - B7A Series - 2160p - Smart - 4K UHD TV with HDR"	LG		2017-07-26	3093
804	Sennheiser - RS 175 Over-the-Ear Wireless Headphone System - Black	Sennheiser	Sennheiser	2015-08-23	217
805	Boombox+ Bluetooth Wireless Speaker	SHARKK		2017-07-18	49
806	Power Acoustik EG1-4500D Edge Series Monoblock Class D Amp, 4,500 Watts Max	Power Acoustik	Power Acoustik	2016-09-04	144
807	IOGEAR - USB-C 4-in-1 4K UHD Multiport Laptop Adapter	IOGEAR		2017-11-11	42
808	JBL - Reflect Contour 2 Wireless In-Ear Headphones - Black	JBL		2018-04-18	99
809	Samsung - 65 Class - LED - Q7F Series - 2160p - Smart - 4K UHD TV with HDR"	Samsung		2018-04-20	2599
810	Alpha a5100 Mirrorless Digital Camera with 16-50mm Lens (White)	Sony		2017-07-18	548
811	QuickFit 22 Stainless Steel Watch Band (Slate Gray)	Garmin		2017-06-29	149
812	Sonic Alert Sb300ss Sonic Boom Alarm Clock White	Sonic Alert	Sonic Alert	2015-05-11	44
813	Braven BRV-BLADE Wireless Portable Bluetooth Speaker [22 Hour Playtime][Waterproof] 4000 mAh Power Bank Charger - Black	Braven		2017-03-06	139
814	Powerstation Plus Mini 4000mAh Battery Pack (Gold)	mophie	Mophie	2017-03-16	39
815	Power Acoustik - MOFO 15.50 1700 W Woofer - Royal Blue"	Power Acoustik		2015-12-02	140
816	Spartan - 3-Target 24x DVD/CD Duplicator - Black	Spartan		2015-12-02	464
817	Sennheiser - HD 599 Over-the-Ear Headphones HD 5 - Brown/ivory/matte metallic	Sennheiser		2017-03-06	199
818	CORSAIR - VENGEANCE LPX Series 32GB (2PK 16GB) 2.133GHz DDR4 Desktop Memory - Black	CORSAIR		2016-04-01	253
819	Sennheiser - Digital Headphone Amplifier - Silver	Sennheiser	Sennheiser	2015-08-18	2199
820	M-Audio - Over-the-Ear Headphones - Black	M-Audio		2017-07-25	118
821	10TB G-DRIVE with Thunderbolt	G-Technology	G-TECH	2016-12-12	699
822	DNA 15 Slim Messenger Bag (Cobalt)	Tenba		2017-03-03	159
823	Apple - iPad mini 4 Wi-Fi + Cellular 128GB - Sprint - Silver	Apple	Apple Computer	2015-12-02	509
824	Onkyo - Dual 6-1/4 2-Way Floor Speakers (Pair) - Black"	Onkyo	ONKYO	2015-10-16	299
825	Panasonic - Lumix G85 Mirrorless Camera with 12-60mm Lens - Black	Panasonic	Panasonic	2017-03-03	999
826	Samsung Galaxy Tab S3 Keyboard Cover	Samsung		2017-03-20	130
827	Details About Kenwood Ddx375bt Car Double Din 6.2 Touchscreen Usb Dvd Cd Bluetooth Stereo"	Kenwood	KENWOOD	2017-03-03	214
828	Sony - BC-TRX Battery Charger - Black	Sony	Sony	2015-09-29	22
829	Thermaltake - SMART Series 650W Bronze Power Supply - Black	Thermaltake	Manufacturers Limited Warranty:3 Year	2015-04-07	56
830	VS278Q-P 27 16:9 LCD Monitor	ASUS		2017-07-18	189
831	Details About Skybell Hd Wifi 1080p Video Doorbell Bronze (sh02300bz)	Skybell		2016-12-28	197
832	AudioQuest - Chocolate 16.5' 4K Ultra HD In-Wall HDMI Cable - Brown	AudioQuest	Audioquest	2015-05-19	289
833	V-MODA - Crossfade Wireless Headphones - Gunmetal Black	V-MODA		2017-02-04	299
834	Details About New Logitech G230 981000541 Headset	Logitech		2018-01-30	59
835	Lowepro - Slingshot Edge 250 AW Camera Backpack - Black	Lowepro	Lowepro	2016-06-10	62
836	Cuisinart DGB-400 Automatic Grind & Brew 12-Cup Coffeemaker, Black/Silver			2020-12-17	361
837	Cuisinart DGB-550BKP1 Grind & Brew Automatic Coffeemaker, 12 Cup, Black			2020-12-17	99
838	Single Serve Coffee Maker, Sboly Grind and Brew Automatic Coffee Machine, Single Cup Coffee Maker with Coffee Grinder Built-in a 12oz Glass Coffee Pot			2020-12-17	84
839	Cuisinart DGB-1FR Single Cup Grind and Brew Ground Coffee Maker (Renewed)			2020-12-17	59
840	(6) Water Filters for Cuisinart DGB-650BC Grind & Brew Coffeemaker NEW"			2020-12-17	11
841	Cuisinart (DGB-700BC) 12 Cup Grind & Brew Coffeemaker			2020-12-17	399
842	Parts 4R Сuisinаrt Coffee Maker Clear Replacement Grinder Assembly Lid DGB-500GLID			2020-12-17	22
843	Coffee Maker,500ML Apacity Removable Grinding and Filter Holder Grinding Coffee Maker (Silver)			2020-12-17	95
844	Reusable Basket-style 10-12 Cup Coffee Filter with Screen Bottom To Fit Cuisinart DGB-500 DGB-600BC DGB-650 DGB-700 DGB-900 (1)			2020-12-17	2669
845	Cuisinart DGB-500GLID Grinder Assembly Lid, Clear			2020-12-17	3828
846	Cuisinart DGB-500GLID Grinder Assembly Lid, Clear			2020-12-17	832
847	Cuisinart 12-Cup coffee maker gold tone filter GTFB (japan import)			2020-12-17	324
848	Cuisinart Grind & Brew DGB-550BK Coffee Maker			2020-12-17	2286
849	Conscious Luck: Eight Secrets to Intentionally Change Your Fortune			2020-12-17	18
850	Any Luck at All (Asheville Brewing Book 1)			2020-12-17	0
851	Just My Luck			2020-12-17	1283
852	Conscious Luck: Eight Secrets to Intentionally Change Your Fortune			2020-12-17	0
853	Liquid Luck: The Good Fortune Handbook			2020-12-17	0
854	Luck			2020-12-17	3833
855	Uncut Gems			2020-12-17	2499
856	Luck-Key			2020-12-17	700
857	Pure Luck			2020-12-17	3563
858	Luck: Season 1			2020-12-17	1585
859	Banfeng Lucky Wind Chimes Feng Shui Bell for Good Luck Home Garden Patio Hanging Decoration Gift (6 Bells)			2020-12-17	10
860	Art of the Root, Ltd. Spellbound Oil for Glamour Magic, Enchantment, Charisma, Attraction & Persuasion (Wiccan, Pagan, Conjure, Hoodoo, Magick)			2020-12-17	7
861	Good Night, and Good Luck			2020-12-17	764
862	Success and Luck: Good Fortune and the Myth of Meritocracy			2020-12-17	17
863	Educated Luck (Twisted Luck Book 3)			2020-12-17	0
864	The Luck Factor: The Scientific Study of the Lucky Mind			2020-12-17	0
865	Lucky Dog			2020-12-17	590
866	Dumb Luck and the Kindness of Strangers (John Gierach's Fly-fishing Library)			2020-12-17	18
867	The Joy Luck Club: A Novel			2020-12-17	12
868	The Biggest Bluff: How I Learned to Pay Attention, Master Myself, and Win			2020-12-17	19
869	Dalai Lama - Quote : Sometimes, not getting what you want is a superb stroke of luck - Inspirational Wall Art Vintage Art Print - Home or Office Decor - No Frame			2020-12-17	9
870	Zorbitz Inc. - Lucky Karma Bracelet with Tiger's Eye for Protection & Balance			2020-12-17	7
871	VFDB Women's Bowtie Mule Slippers Summer Pointy Toe Loafers Slip On Flat Shoes			2020-12-17	22
872	VFDB Women Ballet Flats Bowtie Pointy Toe Flats Shoes Wedding Shoes Lightweight Comfortable Ladies Casual Flat Shoes			2020-12-17	15
873	VFDB Women's Faux Suede Slip On Ballets Loafers,Metal Buckle Square Toe Comfort Light Walking Moccasin Loafers			2020-12-17	12
874	VFDB Women‘s Pointy Toe Metal Buckle Formal Dress Flats for OL Ladies Slip On Width Work Shoes			2020-12-17	19
875	VFDB Women's Faux Suede Slip-on Loafer Flat Shoes,Summer Pointy Toe Shallow Casual Work Shoes Walking Ballerina Shoes			2020-12-17	12
876	VFDB Women Bowite Round Toe Cute Single Shoes Soft PU Leather Slip On Dress Shoes			2020-12-17	12
877	VFDB Women Metal Ring Slip On Comfortable Ballest Loafers,Square Toe Simple Design Classic Flats Shoes for Dress,Wedding Shoes			2020-12-17	12
878	VFDB Women's Fashion Faux Suede Floral Ballets Flats,Slip On Pointy Toe Comfort Driving Loafers Big Size 10,Black			2020-12-17	14
879	VFDB Women's Plaid Flats Shoes Pointy Toe Grid Bowknot Working Shoes			2020-12-17	12
880	VFDB Women's Pom Pom Flats Square Toe Ballet Flats Comfortable Slip On Loafer，Soft Faux Suede Moccasins Office Work Shoes			2020-12-17	12
881	VFDB Women/Men Open Toe Striped Anti-Slip Summer House Slippers for Couples Soft Slip On Unisex Indoor Sliders			2020-12-17	11
882	VFDB Women Slingback Thong Sandals Open Toe Summer Platform T-Strap Flip Flops Shoes			2020-12-17	14
883	VFDB Women's PU Leather Pointy Toe Flats Driving Shoes,Slip On Lightweight Walking Shoes for Work,Casual Loafers,Black			2020-12-17	12
884	VFDB Women's Peep Toe Mid Block Heel Summer Slide Sandals,Slip On Casual Transparent Sandals Slippers PVC Sandals			2020-12-17	14
885	VFDB Women's Faux Suede Lace Up Pointy Toe Flats Loafers,Strappy British Style Single Shoes Driving Moccasins Shoes			2020-12-17	12
886	VFDB Women Slingback Thong Sandals Open Toe Summer Platform T-Strap Flip Flops Shoes Y-Beige US 5.5			2020-12-17	14
887	VFDB Women's Faux Suede Slip-on Ballets Flat Shoes with Metal Ring Decor, Square Toe Style Casual Work Shoes,Driving Shoes,Black			2020-12-17	12
888	VFDB Women Mid Calf Boot Suede Faux Fur Tassel Outdoor Winter Snow Suede Flat Shoes			2020-12-17	23
889	VFDB Women Comfort Square Toe Ballets Flats, Slip On Classical Walking Shoes for Wedding/Driving/Dating			2020-12-17	14
890	VFDB Women's Floral Pointy Toe Slip On Ballets Flats,Comfort Walking Flat Loafer Dress Shoes			2020-12-17	14
891	Vacmaster 4 Gallon Dust Bag, 3 Pack, VFDB			2020-12-17	8
892	Husqvarna 545157901 Grade Muffler Genuine Original Equipment Manufacturer (OEM) Part			2020-12-17	4485
893	Echo & SHINDAIWA Genuine 13001606434 Gasket New OEM Replaces 13001606430, 13001606431, 13001606433 Factory Package			2020-12-17	5
894	Genuine GM 15208496 Radiator Air Baffle, Right			2020-12-17	56
895	Dorman 904-7701 Exhaust Gas Temperature (EGT) Sensor for Select Mack/Volvo Models (OE FIX)			2020-12-17	72
896	Genuine GM Retainer Part# 25744385			2020-12-17	2571
897	Crankshaft Position Sensor for Saab 9-3, 900, 9000 | OEM# 1238358/6238313 / 90213515 | Heavy Duty			2020-12-17	39
898	Apple AirPods Pro			2020-12-17	1363
899	New Apple Watch SE (GPS, 44mm) - Silver Aluminum Case with White Sport Band			2020-12-17	2417
900	Apple Watch Series 3 (GPS, 38mm) - Space Gray Aluminium Case with Black Sport Band			2020-12-17	303
901	New Apple Watch Series 6 (GPS, 40mm) - Gold Aluminum Case with Pink Sand Sport Band			2020-12-17	4665
902	Apple 20W USB-C Power Adapter			2020-12-17	3055
903	Apple TV (32GB, 4th generation)			2020-12-17	624
904	Lightning Charger Cable iPhone Charger Cable 5 Pack 6FT USB Fast Charging Syncing Cord Cables Compatible iPhone XS/Max/XR/X/8/8Plus/7/7P/6S/iPad/IOS White sharllen			2020-12-17	14
905	Apple AirPods with Wireless Charging Case			2020-12-17	4194
906	3 in 1 Aluminum Charging Station for Apple Watch Charger Stand Dock for iWatch Series 4/3/2/1,iPad,AirPods and iPhone Xs/X Max/XR/X/8/8Plus/7/7 Plus /6S /6S Plus（Black）			2020-12-17	21
907	Apple MacBook Air MD760LL/A 13.3-Inch Laptop (Intel Core i5 Dual-Core 1.3GHz up to 2.6GHz, 4GB RAM, 128GB SSD, Wi-Fi, Bluetooth 4.0) (Renewed)			2020-12-17	499
908	3Pack Original [Apple MFi Certified] Charger Lightning to USB Cable Compatible iPhone 11 Pro/11/XS MAX/XR/8/7/6s/6/plus,iPad Pro/Air/Mini,iPod Touch(White 1M/3.3FT)			2020-12-17	19
909	Willful Smart Watch for Android Phones and iOS Phones Compatible iPhone Samsung, IP68 Swimming Waterproof Smartwatch Fitness Tracker Fitness Watch Heart Rate Monitor Watches for Men Women (Green-Gold)			2020-12-17	35
910	Powerbeats Pro Wireless Earphones - Apple H1 Headphone Chip, Class 1 Bluetooth, 9 Hours Of Listening Time, Sweat Resistant Earbuds - Black			2020-12-17	1097
911	Apple Smart Keyboard Folio for iPad Pro 12.9-inch (4th Generation) - US English			2020-12-17	4917
912	Tissyee Watch Charger, Charging Cable Magnetic Wireless Portable Charger Compatible for Apple Watch Series Se 6, 5, 4, 3			2020-12-17	11
913	Apple Watch Series 5 (GPS + Cellular, 44mm) - Gold Stainless Steel Case with Stone Sport Band			2020-12-17	3622
914	Apple Watch Magnetic Charging Cable (1m)			2020-12-17	2236
915	Lightning Cable MFi Certified - iPhone Charger 3Pack 6ft Durable Lightning to USB A Charging Cable Cord Compatible with iPhone 12 SE 2020 11 Xs Max XR X 8 7 6S 6 Plus 5S iPad Pro iPod Airpods - White			2020-12-17	14
916	OriBear Compatible with Apple Watch Band 40mm 38mm Elegant Floral Bands for Women Soft Silicone Solid Pattern Printed Replacement Strap Band for Iwatch Series 4/3/2/1 M/L Sexy Leopard			2020-12-17	9
917	Apple Watch Series 5 (GPS + Cellular, 40MM) - Space Gray Aluminum Case with Black Sport Band (Renewed)			2020-12-17	324
918	MEFEO Adjustable Elastic Bands Compatible with Apple Watch Bands 38mm 40mm 42mm 44mm, Soft Stretch Bracelet Replacement for iWatch Series 6/5/4/3/2/1 & SE Women Girls (Rainbow, 42mm/44mm)			2020-12-17	9
919	POWER PRIMACY Bands Compatible with Apple Watch Band 38mm 40mm 42mm 44mm, Top Grain Leather Smart Watch Strap Compatible for Men Women iWatch Series 6 5 4 3 2 1,SE (Black/Rosegold, 38mm/40mm)			2020-12-17	16
920	Seagate One Touch 4TB External Hard Drive HDD – Silver USB 3.0 for PC Laptop and Mac, 1 Year MylioCreate, 4 Months Adobe Creative Cloud Photography Plan (STKC4000401)			2020-12-17	99
921	LK 6 Pack Screen Protector Compatible with Apple Watch Series 6 5 4 SE 44mm Flexible TPU HD Clear Film Bubble-Free (UF-010)			2020-12-17	14
922	Apple Magic Keyboard for iPad Pro 12.9-inch (4th Generation) - US English			2020-12-17	2089
923	Apple Watch Series 5 (GPS, 40MM) - Space Gray Aluminum Case with Black Sport Band (Renewed)			2020-12-17	3916
924	Apple Pencil (2nd Generation)			2020-12-17	619
925	Apple AirPods with Charging Case (Wired)			2020-12-17	2383
926	Apple Gift Card - App Store, iTunes, iPhone, iPad, Airpods, Macbook, accessories and more (Email Delivery)			2020-12-17	25
927	Apple TV 4K (32GB, Latest Model)			2020-12-17	3431
928	LK [6 Pack] Screen Protector for Apple Watch 40mm SE/Series 4/5/6 and Apple Watch 38mm Series 3/2/1- Bubble-Free Scratch-resistant iWatch 38mm/40mm Flexible TPU Clear Film (UF-001)			2020-12-17	13
929	Julk Series 3 38mm Case Compatible with Apple Watch Screen Protector, Overall Protective Case TPU HD Clear Ultra-Thin Cover (2-Pack)			2020-12-17	7
930	Apple Pencil			2020-12-17	272
931	iPhone Charger Cord 4Pack iPhone Charger Cable MFi Certified Lightning Cable Fast iPhone Charging Cord Nylon Braided iPhone Charging Cable Compatible with Phone 11 Pro max/XR max/8/7/6/6s/SE 2020,iPad			2020-12-17	12
932	iiteeology Compatible with Apple Watch Band 42mm 44mm, Upgraded Version Solid Stainless Steel Band Business Replacement iWatch Strap for Apple Watch Series 6/5/4/3/2/1/SE - Space Gray			2020-12-17	19
933	Apple Smart Keyboard for iPad (7th and 8th Generation) and iPad Air (3rd Generation) - US English			2020-12-17	2930
934	VKP Brands VKP1010 Johnny Apple Peeler, Stainless Steel Blades, Red			2020-12-17	25
935	2Pack Apple Original Charger [Apple MFi Certified] Lightning to USB Cable Compatible iPhone Xs Max/Xr/Xs/X/8/7/6s/6plus/5s,iPad Pro/Air/Mini,iPod Touch(White 1M/3.3FT) Original Certified			2020-12-17	14
936	Apple			2020-12-17	2163
937	[8 Items] Ferilinso 6Pcs for Apple Watch Bands 44mm [Soft Silicone Sport Strap] + 2Pcs Apple Watch Series 6/Series 5/Series 4/SE 44mm Hard PC Case with Tempered Glass Screen Protector for iWatch 44mm			2020-12-17	20
938	Apple Magic Keyboard for iPad Air (4th Generation) and iPad Pro 11-inch - US English			2020-12-17	3129
939	ZALAVER Bands Compatible with Apple Watch Band 38mm 40mm 42mm 44mm, Soft Silicone Sport Replacement Band Compatible with iWatch Series 6 5 4 3 2 1 Women Men Pine Green 38mm/40mm S/M			2020-12-17	5
940	Tourist [3 Pack] Compatible for Apple Watch Tempered Glass Screen Protecto 38mm Series 3 / 2 / 1, 9H Hardness, Anti-scratch, Anti-fingerprint, Anti-bubble Easy Installation with Lifetime Replacements			2020-12-17	6
941	Apples to Apples Party Box [Packaging May Vary]			2020-12-17	14
942	Apple Pencil Tips (4 pack)			2020-12-17	28
943	AmazonBasics Nylon Braided Lightning to USB Cable - MFi Certified Apple iPhone Charger, Rose Gold, 3-Foot (2-Pack) (Durability Rated 4,000 Bends)			2020-12-17	18
944	RUOQINI 4 Pack Compatible with Apple Watch Band 38mm 40mm,Sport Silicone Soft Replacement Band Compatible for Apple Watch Series 5/4/3/2/1 [S/M Size - Rosered/MidnightBlue/Black/White]			2020-12-17	14
945	[2-Pack] Julk Case for Apple Watch Series 6 / SE/Series 5 / Series 4 Screen Protector 40mm, Overall Protective Case TPU HD Clear Ultra-Thin Cover (2 Transparent)			2020-12-17	7
946	Minecraft: Java Edition for PC/Mac [Online Game Code]			2020-12-17	26
947	Mattel Games UNO Minecraft Card Game, Now UNO fun includes the world of Minecraft, Multicolor, Basic Pack			2020-12-17	5
948	LEGO Minecraft The Pillager Outpost 21159 Awesome Action Figure Brick Building Playset for Kids Minecraft Gift, New 2020 (303 Pieces)			2020-12-17	836
949	Minecraft: Epic Bases			2020-12-17	11
950	Minecraft Survival Pack			2020-12-17	17
951	Minecraft Light-Up Adventure Sword			2020-12-17	31
952	Minecraft Dungeons Hero Edition - Nintendo Switch			2020-12-17	28
953	Minecraft Comic Maker Multipack Attack Set with Evoker and Vexes, Based on Video Game, Toys for Girls and Boys Age 6 and Up			2020-12-17	14
954	Minecraft			2020-12-17	6
955	Minecraft Carry Along Potion Plus Exclusive Mini Figure, Carrying Case for Mini Figures, Based on Video Game, Toys for Kids Age 6 and Up			2020-12-17	10
956	Minecraft Starter Collection - PlayStation 4			2020-12-17	29
957	Minecraft Mini Battle in a Box - Dungeons			2020-12-17	13
958	The Official Minecraft Guide Collection 8 Books Box Set By Mojang (Ocean Survival, Farming, PVP Minigames, Enchantments & Potions, The Nether & The End, Redstone, Survival, Creative)			2020-12-17	4612
959	Ravensburger Minecraft: Builders & Biomes - Farmer's Market Expansion Strategy Board Game Ages 10 & Up - Amazon Exclusive			2020-12-17	19
960	Wrangler Authentics Men’s Classic Relaxed Fit Flex Jean			2020-12-17	25
961	Minecraft 3.25 Scale Mega Redstone Monstrosity			2020-12-17	24
962	Minecraft (Nintendo Switch)			2020-12-17	37
963	Songs Of War (Minecraft Animation)			2020-12-17	1437
964	Minecraft Earth Boost Mini Figures 2-Pack NFC-Chip Toys, Earth Augmented Reality Mobile Game, Based on Video Game, Great for Playing, Trading, and Collecting, Adventure Toy for Boys and Girl			2020-12-17	9
965	Diary of a Minecraft Zombie Book 1: A Scare of A Dare			2020-12-17	5
966	Mojang Minecraft Blue Plush Blanket 40" x 50" Fleece Throw Soft & Cozy			2020-12-17	2403
967	Minecraft - Nintendo Switch			2020-12-17	4849
968	JINX Minecraft Slime Plush Stuffed Toy, Green, 9.5" Square			2020-12-17	24
969	Minecraft: The Island: An Official Minecraft Novel			2020-12-17	899
970	CIRO Robot Building Kits for Kids, STEM Remote Controlled Building Toys Kits Educational Learning Science STEM Projects for Kids Ages 8-12			2020-12-17	50
971	PlayMonster Snap Ships Sawfly K.L.A.W. Minelayer			2020-12-17	9
972	TUPARKA 18 Pcs Video Game Wristbands Rubber Bracelet Game Party Wristbands Supplies for Birthday Party Baby Shower Party Favors, 6 Styles			2020-12-17	7
973	Houses Guide for Minecraft			2020-12-17	735
974	Skechers Kids' Mega-Craft-Cubotrons Sneaker			2020-12-17	49
975	The Ultimate Unofficial Encyclopedia for Minecrafters: An A - Z Book of Tips and Tricks the Official Guides Don't Teach You			2020-12-17	657
976	Exclusive Set Lego Minecraft: The Bee Farm, The Abandoned Mine, The Trading Post and The Skeleton Defense Bundle			2020-12-17	4318
977	Minecraft Dungeons Hero Edition - PlayStation 4			2020-12-17	23
978	Minecraft T-Shirt Sprites Characters Gamer Gifts Boys Black Short Sleeve Top			2020-12-17	19
979	Minecraft Dungeons: DLC Season Pass - Xbox Series X [Digital Code]			2020-12-17	19
980	LEGO Minecraft 853610 Mini Figure Pack			2020-12-17	38
981	LEGO Minecraft The Polar Igloo 21142 Building Kit (278 Pieces) (Discontinued by Manufacturer)			2020-12-17	79
982	Minecraft Dungeons (Nintendo Switch)			2020-12-17	42
983	Minecraft Core Zombie Figure Pack			2020-12-17	14
984	Diary of a Farting Creeper: Book 1: Why Does the Creeper Fart When He Should Explode? (Volume 1)			2020-12-17	5
985	JINX Minecraft Wolf Plush Stuffed Toy, Gray, 15" Long			2020-12-17	49
986	Jada Toys Minecraft 20-Pack Wave 1 Nano METALFIGS 1.65" Die - Cast Figures, Multicolor (30125)			2020-12-17	39
987	Minecraft Starter Collection - Xbox One			2020-12-17	4025
988	LEGO Minecraft The Iron Golem 21123			2020-12-17	89
989	Clip: Mitch - Minecraft Hello Neighbor			2020-12-17	1036
990	Portal Gun Mod for Minecraft PE			2020-12-17	2599
991	JINX Minecraft MineFaire Baby Sheep Plush Stuffed Toy, Orange, 7" Tall			2020-12-17	14
992	Mattel Minecraft Dungeons 3.25-in Figures 2-Pk Battle Figures, Adriene and Skeleton with Battle Accessories Age 6 and Older			2020-12-17	19
993	LEGO Minecraft The Crafting Box 3.0 21161 Minecraft Brick Construction Toy and Minifigures, Castle and Farm Building Set, Great Gift for Minecraft Players Aged 8 and up, New 2020 (564 Pieces)			2020-12-17	4145
994	LEGO Minecraft The End Battle 21151 Ender Dragon Building Kit includes Dragon Slayer and Enderman Toy Figures for Dragon Fighting Adventures (222 Pieces)			2020-12-17	1828
995	Minecraft Windows 10 Starter Collection - Windows 10 [Digital Code]			2020-12-17	29
996	Minecraft Story Mode Season 2 - Nintendo Switch			2020-12-17	39
997	FUDYNMALC Women's Casual Walking Shoes Lightweight Breathable Mesh Athletic Running Shoes Fashion Slip-on Sock Sneakers Comfort Work			2020-12-17	21
998	Hidden Figures			2020-12-17	3971
999	High School Musical			2020-12-17	899
1000	The Man in the High Castle - Season 4			2020-12-17	2791
1001	High School Musical 2			2020-12-17	4577
1002	Hi, My Name is Dicky			2020-12-17	3876
1003	High School Musical 3: Senior Year			2020-12-17	1940
1004	The Man in the High Castle - Season 1			2020-12-17	1171
1005	Maia Hi Maia Ho - MagMus Purple			2020-12-17	796
1006	BOTANIC HEARTH Argan Oil Shampoo and Conditioner Set - with Keratin, Restorative & Moisturizing, Sulfate Free - All Hair Types & Color Treated Hair, Men and Women - (Packaging May Vary) -16 fl oz each			2020-12-17	24
1007	Hi LA			2020-12-17	4692
1008	The Man in the High Castle - Season 2			2020-12-17	4760
1009	Hi-Rail Layouts, Part One			2020-12-17	1630
1010	Broken Ceiling			2020-12-17	732
1011	Hi Five (An IQ Novel, 4)			2020-12-17	15
1012	The Hi Jackers			2020-12-17	1
1013	Hi-Jinks_Season 1			2020-12-17	1
1014	Hi-5			2020-12-17	297
1015	Apple AirPods Pro			2020-12-17	1291
1016	New Apple Watch SE (GPS, 44mm) - Silver Aluminum Case with White Sport Band			2020-12-17	2134
1017	Apple Watch Series 3 (GPS, 38mm) - Space Gray Aluminium Case with Black Sport Band			2020-12-17	4466
1018	New Apple Watch Series 6 (GPS, 40mm) - Gold Aluminum Case with Pink Sand Sport Band			2020-12-17	4033
1019	Apple 20W USB-C Power Adapter			2020-12-17	3063
1020	Apple TV (32GB, 4th generation)			2020-12-17	3256
1021	Lightning Charger Cable iPhone Charger Cable 5 Pack 6FT USB Fast Charging Syncing Cord Cables Compatible iPhone XS/Max/XR/X/8/8Plus/7/7P/6S/iPad/IOS White sharllen			2020-12-17	14
1022	Apple AirPods with Wireless Charging Case			2020-12-17	1617
1023	3 in 1 Aluminum Charging Station for Apple Watch Charger Stand Dock for iWatch Series 4/3/2/1,iPad,AirPods and iPhone Xs/X Max/XR/X/8/8Plus/7/7 Plus /6S /6S Plus（Black）			2020-12-17	21
1024	Apple MacBook Air MD760LL/A 13.3-Inch Laptop (Intel Core i5 Dual-Core 1.3GHz up to 2.6GHz, 4GB RAM, 128GB SSD, Wi-Fi, Bluetooth 4.0) (Renewed)			2020-12-17	499
1025	3Pack Original [Apple MFi Certified] Charger Lightning to USB Cable Compatible iPhone 11 Pro/11/XS MAX/XR/8/7/6s/6/plus,iPad Pro/Air/Mini,iPod Touch(White 1M/3.3FT)			2020-12-17	19
1026	Willful Smart Watch for Android Phones and iOS Phones Compatible iPhone Samsung, IP68 Swimming Waterproof Smartwatch Fitness Tracker Fitness Watch Heart Rate Monitor Watches for Men Women (Green-Gold)			2020-12-17	35
1027	Powerbeats Pro Wireless Earphones - Apple H1 Headphone Chip, Class 1 Bluetooth, 9 Hours Of Listening Time, Sweat Resistant Earbuds - Black			2020-12-17	3105
1028	Apple Smart Keyboard Folio for iPad Pro 12.9-inch (4th Generation) - US English			2020-12-17	4877
1029	Tissyee Watch Charger, Charging Cable Magnetic Wireless Portable Charger Compatible for Apple Watch Series Se 6, 5, 4, 3			2020-12-17	11
1030	Apple Watch Series 5 (GPS + Cellular, 44mm) - Gold Stainless Steel Case with Stone Sport Band			2020-12-17	3939
1031	Apple Watch Magnetic Charging Cable (1m)			2020-12-17	466
1137	BSN N.O.-XPLODE Pre Workout Supplement with Creatine, Beta-Alanine, and Energy, Flavor: Fruit Punch, 60 Servings			2020-12-17	4436
1032	Lightning Cable MFi Certified - iPhone Charger 3Pack 6ft Durable Lightning to USB A Charging Cable Cord Compatible with iPhone 12 SE 2020 11 Xs Max XR X 8 7 6S 6 Plus 5S iPad Pro iPod Airpods - White			2020-12-17	14
1033	OriBear Compatible with Apple Watch Band 40mm 38mm Elegant Floral Bands for Women Soft Silicone Solid Pattern Printed Replacement Strap Band for Iwatch Series 4/3/2/1 M/L Sexy Leopard			2020-12-17	9
1034	Apple Watch Series 5 (GPS + Cellular, 40MM) - Space Gray Aluminum Case with Black Sport Band (Renewed)			2020-12-17	324
1035	MEFEO Adjustable Elastic Bands Compatible with Apple Watch Bands 38mm 40mm 42mm 44mm, Soft Stretch Bracelet Replacement for iWatch Series 6/5/4/3/2/1 & SE Women Girls (Rainbow, 42mm/44mm)			2020-12-17	9
1036	POWER PRIMACY Bands Compatible with Apple Watch Band 38mm 40mm 42mm 44mm, Top Grain Leather Smart Watch Strap Compatible for Men Women iWatch Series 6 5 4 3 2 1,SE (Black/Rosegold, 38mm/40mm)			2020-12-17	16
1037	Seagate One Touch 4TB External Hard Drive HDD – Silver USB 3.0 for PC Laptop and Mac, 1 Year MylioCreate, 4 Months Adobe Creative Cloud Photography Plan (STKC4000401)			2020-12-17	99
1038	LK 6 Pack Screen Protector Compatible with Apple Watch Series 6 5 4 SE 44mm Flexible TPU HD Clear Film Bubble-Free (UF-010)			2020-12-17	14
1039	Apple Magic Keyboard for iPad Pro 12.9-inch (4th Generation) - US English			2020-12-17	2053
1040	Apple Watch Series 5 (GPS, 40MM) - Space Gray Aluminum Case with Black Sport Band (Renewed)			2020-12-17	3570
1041	Apple Pencil (2nd Generation)			2020-12-17	4485
1042	Apple AirPods with Charging Case (Wired)			2020-12-17	3227
1043	Apple Gift Card - App Store, iTunes, iPhone, iPad, Airpods, Macbook, accessories and more (Email Delivery)			2020-12-17	25
1044	Apple TV 4K (32GB, Latest Model)			2020-12-17	728
1045	LK [6 Pack] Screen Protector for Apple Watch 40mm SE/Series 4/5/6 and Apple Watch 38mm Series 3/2/1- Bubble-Free Scratch-resistant iWatch 38mm/40mm Flexible TPU Clear Film (UF-001)			2020-12-17	13
1046	Julk Series 3 38mm Case Compatible with Apple Watch Screen Protector, Overall Protective Case TPU HD Clear Ultra-Thin Cover (2-Pack)			2020-12-17	7
1047	Apple Pencil			2020-12-17	1054
1048	iPhone Charger Cord 4Pack iPhone Charger Cable MFi Certified Lightning Cable Fast iPhone Charging Cord Nylon Braided iPhone Charging Cable Compatible with Phone 11 Pro max/XR max/8/7/6/6s/SE 2020,iPad			2020-12-17	12
1049	iiteeology Compatible with Apple Watch Band 42mm 44mm, Upgraded Version Solid Stainless Steel Band Business Replacement iWatch Strap for Apple Watch Series 6/5/4/3/2/1/SE - Space Gray			2020-12-17	19
1050	Apple Smart Keyboard for iPad (7th and 8th Generation) and iPad Air (3rd Generation) - US English			2020-12-17	398
1051	VKP Brands VKP1010 Johnny Apple Peeler, Stainless Steel Blades, Red			2020-12-17	25
1052	2Pack Apple Original Charger [Apple MFi Certified] Lightning to USB Cable Compatible iPhone Xs Max/Xr/Xs/X/8/7/6s/6plus/5s,iPad Pro/Air/Mini,iPod Touch(White 1M/3.3FT) Original Certified			2020-12-17	14
1053	Apple			2020-12-17	1284
1054	[8 Items] Ferilinso 6Pcs for Apple Watch Bands 44mm [Soft Silicone Sport Strap] + 2Pcs Apple Watch Series 6/Series 5/Series 4/SE 44mm Hard PC Case with Tempered Glass Screen Protector for iWatch 44mm			2020-12-17	20
1055	Apple Magic Keyboard for iPad Air (4th Generation) and iPad Pro 11-inch - US English			2020-12-17	2934
1056	ZALAVER Bands Compatible with Apple Watch Band 38mm 40mm 42mm 44mm, Soft Silicone Sport Replacement Band Compatible with iWatch Series 6 5 4 3 2 1 Women Men Pine Green 38mm/40mm S/M			2020-12-17	5
1057	Tourist [3 Pack] Compatible for Apple Watch Tempered Glass Screen Protecto 38mm Series 3 / 2 / 1, 9H Hardness, Anti-scratch, Anti-fingerprint, Anti-bubble Easy Installation with Lifetime Replacements			2020-12-17	6
1058	Apples to Apples Party Box [Packaging May Vary]			2020-12-17	14
1059	Apple Pencil Tips (4 pack)			2020-12-17	28
1060	AmazonBasics Nylon Braided Lightning to USB Cable - MFi Certified Apple iPhone Charger, Rose Gold, 3-Foot (2-Pack) (Durability Rated 4,000 Bends)			2020-12-17	18
1061	RUOQINI 4 Pack Compatible with Apple Watch Band 38mm 40mm,Sport Silicone Soft Replacement Band Compatible for Apple Watch Series 5/4/3/2/1 [S/M Size - Rosered/MidnightBlue/Black/White]			2020-12-17	14
1062	[2-Pack] Julk Case for Apple Watch Series 6 / SE/Series 5 / Series 4 Screen Protector 40mm, Overall Protective Case TPU HD Clear Ultra-Thin Cover (2 Transparent)			2020-12-17	7
1063	iBUYPOWER Gaming PC Computer Desktop Trace 4 9310 (AMD Ryzen 5 3600 3.6GHz, AMD Radeon RX 5500 XT 4GB, 8GB DDR4 RAM, 240GB SSD, WiFi Ready, Windows 10 Home)			2020-12-17	699
1064	Razer DeathAdder Essential Gaming Mouse: 6400 DPI Optical Sensor - 5 Programmable Buttons - Mechanical Switches - Rubber Side Grips - White			2020-12-17	29
1065	ASUS - TUF Gaming 15.6" Full HD Laptop - Intel Core i5-10300H- 8GB Memory - 256GB SSD -NVIDIA GeForce GTX 1650 Ti – Black			2020-12-17	724
1066	Turtle Beach Stealth 600 Gen 2 Wireless Gaming Headset for Xbox One and Xbox Series X|S			2020-12-17	99
1067	Gaming Glasses | Blue Light Blocking Glasses | Enigma/Smoke by Gunnar | 65% Blue Light Protection, 100% UV Light, Anti-Reflective, Protect & Reduce Eye Strain & Dryness			2020-12-17	49
1068	ASUS TUF Gaming A15 Gaming Laptop, 15.6” 144Hz Full HD IPS-Type Display, AMD Ryzen 5 4600H, GeForce GTX 1650, 8GB DDR4, 512GB PCIe SSD, RGB Keyboard, Windows 10 Home, Bonfire Black, FA506IH-AS53			2020-12-17	749
1069	Razer Kraken Gaming Headset: Lightweight Aluminum Frame, Retractable Noise Isolating Microphone, For PC, PS4, PS5, Switch, Xbox One, Xbox Series X & S, Mobile, 3.5 mm Audio Jack, Black			2020-12-17	64
1070	Logitech G502 SE Hero High Performance RGB Gaming Mouse with 11 Programmable Buttons			2020-12-17	49
1071	Razer Sphex V2 Gaming Mouse Pad: Ultra-Thin Form Factor - Optimized Gaming Surface - Polycarbonate Finish			2020-12-17	14
1072	HyperX Pulsefire Dart - Wireless RGB Gaming Mouse, Software-Controlled Customization, 6 Programmable Buttons, Qi-Charging Battery up to 50 Hours - PC, PS4, Xbox One Compatible			2020-12-17	79
1073	Razer Kraken X Ultralight Gaming Headset: 7.1 Surround Sound - Lightweight Aluminum Frame - Bendable Cardioid Microphone - PC, PS4, PS5, Switch, Xbox One, Xbox Series X & S, Mobile - Black			2020-12-17	44
1074	AOPEN 27HC5R Pbiipx 27" 1500R Curved Full HD (1920 x 1080) VA Gaming Monitor with AMD Radeon FREESYNC Premium Technology, 165Hz (Display Port & 2 x HDMI Ports), Black			2020-12-17	189
1075	Razer Kraken Tournament Edition THX 7.1 Surround Sound Gaming Headset: Retractable Noise Cancelling Mic - USB DAC -  For PC, PS4, PS5, Nintendo Switch, Xbox One, Xbox Series X & S, Mobile – Black			2020-12-17	64
1076	Gaming Keyboard and Mouse and Mouse pad and Gaming Headset, Wired LED RGB Backlight Bundle for PC Gamers and Xbox and PS4 Users - 4 in 1 Edition Hornet RX-250			2020-12-17	49
1077	HyperX Cloud Flight - Wireless Gaming Headset, with Long Lasting Battery Upto 30 hours of Use, Detachable Noise Cancelling Microphone, Red LED Light, Bass, Comfortable Memory Foam, PS4, PC, PS4 Pro			2020-12-17	99
1078	Logitech G432 DTS:X 7.1 Surround Sound Wired PC Gaming Headset (Leatherette)			2020-12-17	1064
1079	2020 Asus TUF 15.6" FHD Premium Gaming Laptop, 10th Gen Intel Quad-Core i5-10300H, 16GB RAM, 1TB SSD, NVIDIA GeForce GTX 1650Ti 4GB GDDR6, RGB Backlit Keyboard, Windows 10 Home			2020-12-17	869
1080	Razer Blade 15 Base Gaming Laptop 2020: Intel Core i7-10750H 6 Core, NVIDIA GeForce RTX 2070 Max-Q, 15.6" FHD 1080p 144Hz, 16GB RAM, 512GB SSD, CNC Aluminum, Chroma RGB Lighting, Thunderbolt 3, Black			2020-12-17	599
1081	SteelSeries Apex 3 RGB Gaming Keyboard – 10-Zone RGB Illumination – IP32 Water Resistant – Premium Magnetic Wrist Rest (Whisper Quiet Gaming Switch)			2020-12-17	49
1082	Corsair VOID RGB Elite Wireless Premium Gaming Headset with 7.1 Surround Sound - Discord Certified - Works with PC, PS5 and PS4 - White			2020-12-17	99
1083	Cougar Revenger Wired USB Optical Gaming Mouse with 12,000 DPI, Black (CGR-WOMI-REV)			2020-12-17	49
1084	HyperX Cloud Stinger - Gaming Headset – Comfortable HyperX Signature Memory Foam, Swivel to Mute Noise-Cancellation Microphone, Compatible with PC, Xbox One, PS4, Nintendo Switch, and Mobile Devices			2020-12-17	39
1085	NEW Microsoft Surface Go 2 - 10.5" Touch-Screen - Intel Pentium - 4GB Memory - 64GB - Wifi - Platinum (Latest Model)			2020-12-17	4434
1086	$25 Xbox Gift Card [Digital Code]			2020-12-17	25
1087	NEW Microsoft Surface Dock 2			2020-12-17	173
1088	Microsoft Surface Laptop 3 – 13.5" Touch-Screen – Intel Core i5 - 8GB Memory - 128GB Solid State Drive (Latest Model) – Platinum with Alcantara			2020-12-17	4254
1089	Microsoft Surface Pro 7 – 12.3" Touch-Screen - 10th Gen Intel Core i5 - 8GB Memory - 128GB SSD (Latest Model) – Platinum (VDV-00001)			2020-12-17	3695
1090	NEW Microsoft Surface Headphones 2 - Matte Black			2020-12-17	249
1091	$100 Xbox Gift Card [Digital Code]			2020-12-17	100
1092	Microsoft Surface Pro 7 – 12.3" Touch-Screen - 10th Gen Intel Core i5 - 8GB Memory - 128GB SSD (Latest Model) – Platinum with Black Type Cover			2020-12-17	2858
1093	Microsoft Windows 10 Pro | USB Flash Drive + Microsoft Office 365 Home with Auto-Renew			2020-12-17	291
1094	Microsoft Surface Laptop Go - 12.4" Touchscreen - Intel Core i5 - 8GB Memory - 128GB SSD - Sandstone			2020-12-17	699
1095	NEW Microsoft Ergonomic Desktop			2020-12-17	796
1096	NEW Microsoft Surface Duo 128GB (Unlocked) - Glacier			2020-12-17	855
1097	NEW Microsoft Surface Go Signature Type Cover - Ice Blue			2020-12-17	96
1098	Microsoft Surface Dock (Pd9-00003),Black			2020-12-17	2276
1099	Microsoft  Surface Pro 6 (Intel Core i5, 8GB RAM, 128GB)			2020-12-17	753
1100	Microsoft Surface Pen Platinum Model 1776 (EYU-00009)			2020-12-17	72
1101	Microsoft Xbox One Wireless Adapter for Windows (Bulk Packaging)			2020-12-17	2042
1102	Microsoft Surface Keyboard, WS2-00025, Silver			2020-12-17	79
1103	Microsoft Surface Dock Compatible with Surface Book, Surface Pro 4, and Surface Pro 3 (Renewed)			2020-12-17	158
1104	Microsoft Surface Pen, Charcoal Black, Model: 1776 (EYU-00001)			2020-12-17	64
1105	$50 Xbox Gift Card [Digital Code]			2020-12-17	50
1106	Microsoft Outlook 365 Mail, Calendar, People, Tasks, Notes Quick Reference - Windows Version (Cheat Sheet of Instructions, Tips & Shortcuts - Laminated Guide)			2020-12-17	7
1107	Microsoft Surface Laptop 3 – 13.5" Touch-Screen – Intel Core i5 - 8GB Memory - 128GB Solid State Drive (Latest Model) – Platinum with Alcantara (Renewed)			2020-12-17	740
1108	Microsoft Surface Pro Signature Type Cover – Ice Blue			2020-12-17	113
1109	Microsoft Project  Standard 2010			2020-12-17	3295
1110	Elite Series 2 Controller - Black			2020-12-17	715
1111	Microsoft P3Q-00001 Wireless Display Adapter			2020-12-17	2804
1112	New Microsoft Surface Pro X Signature Keyboard with Slim Pen			2020-12-17	192
1113	Microsoft Xbox One Wireless Gaming Controller Arctic Camo Special Edition			2020-12-17	59
1114	Microsoft Arc Mouse (ELG-00001) Black			2020-12-17	3729
1115	Microsoft Surface Dial			2020-12-17	84
1116	Microsoft Surface Book 2 15" (Intel Core i7, 16GB RAM, 512 GB), Silver			2020-12-17	1932
1117	Microsoft FMM-00001 Type Cover for Surface Pro - Black			2020-12-17	2301
1118	Microsoft Surface Pro 6 12.3" (2736 x 1824) Touch Screen - Intel 8th Gen Core i5 (up to 3.40 GHz) - 8GB Memory - 256GB SSD - with Keyboard and Surface Pen - Black			2020-12-17	999
1119	Xbox One Chat Headset			2020-12-17	389
1120	Microsoft Surface Pro X – 13" Touch-Screen – SQ1 - 8GB Memory - 128GB Solid State Drive – Wifi, 4G Lte – Matte Black			2020-12-17	2979
1121	Microsoft LifeCam Studio for Business			2020-12-17	3249
1122	Microsoft Surface Laptop 1769 (KSR-00001) Intel Core i5, 8GB RAM, 128GB SSD, 13.5-in Touchscreen, Win10 S			2020-12-17	788
1123	Office Professional 2013 Key Card 1PC/1User			2020-12-17	249
1124	Microsoft Surface Pro 3 Docking Station (Renewed)			2020-12-17	74
1125	Xbox Wireless Controller - Shock Blue			2020-12-17	64
1126	Microsoft Xbox Wireless Controller + Wireless Adapter for Windows 10			2020-12-17	1394
1127	NEW Microsoft USB-C Travel Hub			2020-12-17	2597
1128	Microsoft Xbox Wireless Controller + USB-C Cable - Xbox			2020-12-17	59
1129	Microsoft Surface Pro 7 128GB i5 8GB RAM with Windows 10 Pro (Wi-Fi, Quad-Core i5-1035G4, Newest Version) Platinum PVQ-00001			2020-12-17	744
1130	NEW Microsoft Mobile Mouse - Peach			2020-12-17	613
1131	$10 Xbox Gift Card [Digital Code]			2020-12-17	10
1132	Microsoft Surface Pro 7 MS7 12.3” (2736x1824) 10-Point Touch Display Tablet PC W/Surface Type Cover & Surface Pen, Intel 10th Gen Core i3, 4GB RAM, 128GB SSD, Windows 10, Platinum (Latest Model)			2020-12-17	761
1133	Double Upple			2020-12-17	1174
1134	Think and Grow Rich			2020-12-17	0
1135	BACtrack S80 Breathalyzer | Professional-Grade Accuracy | DOT & NHTSA Approved | FDA 510(k) Cleared | Portable Breath Alcohol Tester for Personal & Professional Use			2020-12-17	129
1136	NOW Supplements, DHA-500 with 250 EPA, Molecularly Distilled, Supports Brain Health*, 180 Softgels			2020-12-17	1468
1138	Dermoplast Pain & Itch Spray, 2.75 Ounce Can (Packaging May Vary)			2020-12-17	4246
1139	Nutricost Quercetin 880mg, 240 Veggie Capsules with Bromelain (165mg) - 120 Servings (440mg Quercetin Per Cap) - Gluten Free, Non-GMO			2020-12-17	577
1140	NOW Sports Nutrition, L-Citrulline, Extra Strength 1200 mg, Amino Acid, 120 Tablets			2020-12-17	503
1141	Dermoplast First Aid Spray, 2.75 Ounce Can, Antiseptic & Anesthetic (Packaging May Vary)			2020-12-17	3868
1142	Genuine New for Lenovo Yoga 900S 900S-12ISK US Keyboard Bezel Upple Case Palmrest			2020-12-17	56
1143	NOW Supplements, 5-HTP (5-hydroxytryptophan) 100 mg, Neurotransmitter Support, 120 Veg Capsules			2020-12-17	4821
1144	NOW Supplements, D-Mannose 500 mg, Non-GMO Project Verified, Healthy Urinary Tract*, 240 Veg Capsules			2020-12-17	625
1145	MHP Anadrox Pump & Burn, Nitric Oxide Fat Burning Inferno, 112 capsules			2020-12-17	1198
1146	Anti Hair Loss Shampoo - Wick & Strom (Caffeine, Biotin, Saw Palmetto, Aloe Leaf, Keto.+ No Minoxidil Formula) Stimulates Hair Growth For Men and Women/12oz.			2020-12-17	15
1147	Regress			2020-12-17	4563
1148	Solaray Yeast-Cleanse | with Caprylic Acid, PAU Darco, Grapefruit Seed Extract & Tea Tree Oil | Healthy Cleansing Support | 30 Servings | 180 VegCaps			2020-12-17	4635
\.


--
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Category_id_seq"', 2023, true);


--
-- Name: Client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Client_id_seq"', 200, true);


--
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_id_seq"', 1000, true);


--
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Product_id_seq"', 1148, true);


--
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- Name: Client Client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY (id);


--
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- Name: Link_Product-Category Link_Product-Category_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Link_Product-Category"
    ADD CONSTRAINT "Link_Product-Category_category_id_fkey" FOREIGN KEY (category_id) REFERENCES public."Category"(id) ON DELETE CASCADE;


--
-- Name: Link_Product-Category Link_Product-Category_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Link_Product-Category"
    ADD CONSTRAINT "Link_Product-Category_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public."Product"(id) ON DELETE CASCADE;


--
-- Name: Link_Product-Order Link_Product-Order_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Link_Product-Order"
    ADD CONSTRAINT "Link_Product-Order_order_id_fkey" FOREIGN KEY (order_id) REFERENCES public."Order"(id) ON DELETE CASCADE;


--
-- Name: Link_Product-Order Link_Product-Order_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Link_Product-Order"
    ADD CONSTRAINT "Link_Product-Order_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public."Product"(id) ON DELETE CASCADE;


--
-- Name: Order Order_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_client_id_fkey" FOREIGN KEY (client_id) REFERENCES public."Client"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5 (Ubuntu 12.5-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.5 (Ubuntu 12.5-0ubuntu0.20.04.1)

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
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

