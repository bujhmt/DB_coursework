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
2014	stone products	Electronics
2015	brick manufacturing	Electronics
2016	landmark stone	Electronics
2017	brick manufacturing process	Electronics
2018	natural stone	Electronics
2019	brick designs	Electronics
2020	brick	Electronics
2021	thin brick	Electronics
2022	brick sizes	Electronics
2023	glen gery	Electronics
2024	manufactured stone	Electronics
2025	Apple CarPlay Receivers	Electronics
2026	brick colors	Electronics
2027	See more Logitech Harmony Ultimate One IR Remote With C...	Electronics
2028	Microft	Microft
2029	Minecraft	Minecraft
\.


--
-- Data for Name: Client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Client" (id, name, birthday_date, email) FROM stdin;
1	pyurbdktep	2009-10-04	glywoaob@uvsxw.com
2	ekpsmtncof	2020-02-28	vqyehojq@umtcc.com
3	jknmtaiqpx	2003-04-14	jvfwymyh@gcjve.com
4	haiuceatlv	2001-03-06	tasjcwwf@mcrky.com
5	mbcdqghxsc	2017-01-06	hquruhho@bvrdb.com
6	xjgkkasike	2004-09-05	avkwgpbx@xrdqt.com
7	axdspktyrc	2018-03-20	waicfymo@qmqow.com
8	dwuslstpun	2004-04-28	bgjmmgaj@uiakx.com
9	oqnjdqqqxf	2009-10-10	gyacuvbj@mcmgc.com
10	vybcrvywog	2020-11-17	hiwxknhn@tkvyx.com
11	tucmimfhux	2007-10-04	lhaxpars@ajwdb.com
12	mxhfdjbqwi	2014-04-19	wlguvdfo@paubq.com
13	rklmlkekhs	2003-05-26	gpeqtndf@kfesk.com
14	jipxaoqdgs	2013-12-18	apnoqngt@muuvq.com
15	npbepnkjyx	2008-11-24	bnrfmdur@gfcot.com
16	aatlmwckdg	2001-03-02	bttkxrag@pjxyc.com
17	mkncsemhnb	2018-08-05	jeyknvdh@wiykq.com
18	bomxombllu	2007-12-16	xlivsyyo@xmslp.com
19	ffrdbyyxhp	2016-05-16	dvnastfj@pogri.com
20	jjlrplqbwd	2019-11-15	tvudblbd@uwqot.com
21	gnfqwokphi	2018-05-21	jfwlcuco@rwwkl.com
22	jnticnvklv	2010-03-25	fycmdduk@yelyy.com
23	exfwlkwakb	2019-06-03	simpexwy@wcvta.com
24	veqvrxbbuh	2018-12-24	pqlvyeay@euooo.com
25	difclclslp	2010-07-14	npihkrbp@islav.com
26	aryvsicnmh	2005-04-25	fioguyah@fbdje.com
27	avaymevulb	2009-09-29	vxabfmfd@lkfdp.com
28	ejajsidjxw	2006-06-28	tlggdomj@fmoro.com
29	sjphyswwws	2010-12-06	ydybrivf@iqabb.com
30	djjqbdqyur	2006-08-08	aotgvasw@rmaun.com
31	dbfnjelxpk	2013-03-15	asivfqyg@icfsr.com
32	xnqvxvqyhn	2016-03-30	jxoumhum@ixtfd.com
33	gpvgrltntr	2004-06-06	fbnfgxua@tsqlp.com
34	yfvahtapbq	2008-04-26	jbkhgjyc@olehx.com
35	redosnebpl	2008-09-03	kldlotgr@eijui.com
36	nmnhncqshv	2011-05-25	aibfsddq@brsty.com
37	nvlkrfdqeo	2018-09-01	prrybnqm@pcfhg.com
38	pxsisvksai	2016-05-21	bgvhleta@rgfwv.com
39	kilurbeiwu	2017-09-01	agbuhmaf@crxaf.com
40	lhxpctjpju	2008-06-26	mauwcnvr@xolkk.com
41	urfwnvxoht	2006-04-16	gcooodud@treyd.com
42	fhswvxumrl	2000-07-29	hvuvjoua@sbnqx.com
43	olxgaeycjq	2018-02-08	iysvgnsw@mnful.com
44	hxxblmtgrc	2012-08-01	uboflini@jlwjs.com
45	usumeljueh	2008-03-09	gtnbdgkw@tdnuo.com
46	xkduduutvl	2009-07-02	mprsllsa@rvrxu.com
47	greoodtadx	2007-11-01	fegtyicu@qsatm.com
48	rhkthfabby	2005-01-04	wwbkfnif@cnbiq.com
49	wpbwiqfhsr	2020-02-28	xiyvfgwy@fduaf.com
50	sitgraivsh	2017-12-19	fywphaao@dsidh.com
51	lgvvrstwpe	2018-05-01	xgijbjay@rxpli.com
52	mwplwngjoa	2015-03-01	jiaqklag@omoqu.com
53	xqrjhncqln	2014-07-18	ccxxtehp@rmqvu.com
54	vuywtyumei	2000-02-16	sxkrxnfq@vdida.com
55	gtyjcoiwtd	2005-02-15	wxbmktkv@svrjq.com
56	uxjuvanfyb	2013-11-21	kmkmpfpi@grdsq.com
57	fvgydfvaik	2001-04-17	gfqvdffm@strdk.com
58	vkbeyvivdb	2007-12-19	ankngaru@cfeme.com
59	nrsukrrcpi	2003-06-08	gyfxshuj@vpigv.com
60	sedndebkki	2016-12-20	wgipscwi@koecw.com
61	xifahhfsok	2013-01-08	geufdric@wshcb.com
62	rvjufawwos	2013-08-23	ahpsltfk@kywga.com
63	erdfnsswye	2013-06-20	yfcxxndn@csocn.com
64	ordtmehxvs	2010-03-08	pjiuenwq@alkov.com
65	vatdpqdqme	2003-07-06	jwpepuql@didov.com
66	esivpsnjnw	2009-02-25	qtadcbmv@aaell.com
67	wmhqlmnlhu	2004-01-02	kuexaowm@eibnw.com
68	ncvarruqhe	2000-06-03	shxnnaow@grsmd.com
69	kavtuomicj	2006-02-25	cgsgjuld@klymu.com
70	jfeywaiosr	2016-10-20	rusmcotd@skvma.com
71	prumvysaae	2002-08-08	syxwnxtv@laofw.com
72	uirahhnofb	2014-06-08	oqdhsifi@wyvky.com
73	ecdsgsuraw	2016-11-13	knffnvnn@ddbqu.com
74	tmxyyjkklf	2000-01-18	vqesdcrl@iqrvh.com
75	rnknlvnouf	2010-01-28	erqctbwc@kojab.com
76	greoqwfhxg	2013-08-14	ygsatbig@mxmij.com
77	moytetbvug	2010-12-23	ovxewkre@jqwun.com
78	uwuqxxvluv	2000-02-20	jhgucvrs@ppnxr.com
79	jhvjrjvtef	2001-08-29	dxmbpssq@ndbpv.com
80	jvdnssxtil	2008-05-27	xcqbnfrd@icblo.com
81	wwgemwdfev	2020-07-10	oogcemfq@kfndd.com
82	sxaxcgrjcy	2005-02-12	yjcfcfwu@bqvdm.com
83	dkbckxawky	2004-05-08	weomnjnm@rljxi.com
84	awlsjqxunp	2004-09-19	aolcxgwu@hdcdk.com
85	gfqssnfsxl	2009-07-23	xyaagwpp@nigyj.com
86	lytiqqnacm	2002-08-22	mfmuhxsc@ummbl.com
87	nunacshrnm	2009-01-02	jbyccdxg@trmyb.com
88	gjyedsqjpu	2003-01-15	ksfvldul@eiama.com
89	tpemnsjmil	2019-11-20	hryaxuls@tprvh.com
90	uqyudfmewd	2017-02-10	hocolqrw@iksyi.com
91	kpbpqhlbpr	2000-08-14	njcdbxcm@taacq.com
92	chuxmyrsmn	2018-07-12	sxhphoqh@lhvik.com
93	durqqwrkxk	2009-10-03	klmbaoer@cpnxd.com
94	ckbsuduuys	2015-09-07	dpimfjan@siymp.com
95	jrpqbbxdgn	2012-04-20	mnukwecf@qubat.com
96	ckqmwxntxd	2006-09-23	ihwowudo@ccapo.com
97	avivcqkjsj	2005-01-04	tmnxpvmk@pappd.com
98	ldfctcoesn	2008-07-27	gjakatot@kvjhm.com
99	womkktubjl	2003-06-28	wxymjmxy@bejnx.com
100	hawtawonrj	2020-05-16	pvtvbiyb@tqgeb.com
101	seyhnurcvm	2019-06-11	ojvdbsyk@ermis.com
102	rvujeqvkdh	2020-10-21	pelkrplx@moqra.com
103	tqvfmravqx	2004-03-15	fxutoyle@wjjib.com
104	bnpyntqrhl	2008-11-20	miewycwi@gvtfl.com
105	gkvteasrbk	2014-11-13	mdxqycdf@dsiin.com
106	gpodfosypp	2005-12-14	rbdccagn@wafmb.com
107	usrlyqukwj	2006-05-23	irnhdbdj@eepui.com
108	atpkkqmtre	2006-01-26	fsqbychd@chjav.com
109	vsjmcglvdd	2020-01-05	qdqpxbvb@vkqah.com
110	owlbvojhnr	2009-11-20	jtbhfygo@tkgwt.com
111	kanoponbdc	2002-10-28	fnbojnxg@tlfkv.com
112	gawulebmgl	2018-11-02	ocrvuump@odppq.com
113	bjfjajkype	2008-08-30	lscwdxev@wtqqw.com
114	eukqvvkycf	2018-09-09	nstgelby@ivdei.com
115	yodunywxdy	2008-03-10	bdwfxdxf@gwvam.com
116	vmthewfmgj	2001-11-17	lpamiyac@alkrl.com
117	dlopqhtbwm	2011-03-04	gevcvwib@ycpml.com
118	yvrlaqdvhe	2020-05-19	cutcdrmo@giwdx.com
119	cfmhbwfmfq	2012-05-24	mkuvhatu@junww.com
120	awebaolxje	2014-01-18	doavivgb@qhcmv.com
121	rcxdqrdlop	2012-10-07	rqmxjxvy@rowet.com
122	wjnqthyjsx	2004-08-26	iyhhqxpo@wwymu.com
123	kebnlrkeaf	2015-05-28	rcignguk@gybdc.com
124	bniclhlxww	2012-02-02	cnakbbpk@ittko.com
125	ciqhytfdil	2006-11-15	qlibixoj@rgadg.com
126	wdgejtuyrb	2020-06-12	mgtntmkc@pqecy.com
127	fqpummddls	2001-11-06	riuwbbtr@ppqwv.com
128	yoekdpiger	2011-12-11	beklhjoh@dstfm.com
129	lwwdqhpvco	2003-11-04	kcpptvtq@jelsi.com
130	vfspwypnnx	2007-11-17	tgywdjun@fwikv.com
131	jbvxtwhyye	2012-10-18	adjhoboc@uaweu.com
132	hdtwwmyfdq	2019-02-22	dcyvmina@jhanx.com
133	bxydxvsdvy	2005-08-31	xiwjavob@mfrej.com
134	fcjwekjekq	2002-12-15	vwdbehho@gitlx.com
135	dtusdjxevu	2010-04-10	ndyfadxl@ynpck.com
136	iqkobykgck	2011-10-10	gpexvliq@djvad.com
137	xmodykpovm	2020-02-16	gjvviroy@jvunb.com
138	fcgdhrqvni	2011-09-02	vofsvjcs@melmb.com
139	joaoqyhcyo	2006-12-07	yvkywgul@twhuf.com
140	hahmmxjmge	2007-07-13	tdbprcsv@wpjot.com
141	cbvcrrclgi	2019-12-10	mekwrgfv@mhnal.com
142	yexoeipjru	2004-11-23	lxlrlvwn@nllfp.com
143	pclwioigmx	2009-07-01	byvpehxk@pxiao.com
144	jumixiibru	2015-05-06	abpfiija@lonll.com
145	obrtkjpqiv	2004-04-24	oogwgyyd@nmusa.com
146	hqfdmlfisr	2002-08-21	vwkqpxyn@hcpft.com
147	hwcehlqifx	2017-05-13	rfuwbial@avyvj.com
148	ssfdfpmkic	2008-02-13	hrqemdsy@dbrom.com
149	kudhiyrocc	2005-06-22	iplxqnum@arqsw.com
150	aruawqffev	2006-01-28	vxnhokwm@lkpfl.com
151	yrlwujghoj	2002-12-03	xdtmciyk@uwysd.com
152	srecosugtw	2011-01-01	blvjattv@qascw.com
153	rdeudctlih	2008-09-06	lvslemtg@oprba.com
154	jqwvqvgomk	2018-12-31	mgodxiux@nijyy.com
155	broqxjjnkq	2010-02-06	mlkxbyag@kbvcf.com
156	rhpmayssry	2000-10-14	xuvllgjn@omwxa.com
157	wwmuiauygu	2006-02-27	jrupbhtj@jixuy.com
158	tvlugrslxt	2001-01-05	atyxdseh@ftsyb.com
159	yudttmtaoj	2003-08-04	jslljcqo@suapm.com
160	aeikpwnxvj	2004-11-10	jgbyslol@xaaeb.com
161	plfrplgbqm	2006-07-03	mvilcahe@jadqj.com
162	orojnatqvp	2015-02-15	jaloufvx@gypsc.com
163	coamllghxp	2004-04-20	eabweioh@hvkax.com
164	bewyathbnm	2011-04-07	dgmgkvjm@gcljt.com
165	vcpvvdvrcq	2010-01-16	hpsouoqu@fxpjs.com
166	jwrhcsapio	2013-02-15	dcrrrnho@iciut.com
167	hmsbrpplqf	2017-07-06	bcpsbykf@febkt.com
168	dwtxsbviyr	2015-04-20	cluatbrs@sdqxd.com
169	gbvhpkqjgq	2002-09-01	lmyrupvp@vmngr.com
170	cyllxlkouc	2004-05-01	qhnnkdjj@wkgkj.com
171	uksiagplnp	2016-03-25	svpkfqll@wxdhp.com
172	hcxfwrvdus	2003-04-04	ejydubtd@cqdfn.com
173	cbsjsbxmfo	2020-08-02	clyuoxga@rplev.com
174	xjuxjlwyty	2009-02-22	ywysytpq@yfayq.com
175	dxcculuypo	2011-04-04	exknnsbg@ajbuy.com
176	jbfnjyhpst	2009-09-07	loyuhfhw@brewl.com
177	ktneqeofmc	2002-08-01	esdyotqk@ubpqy.com
178	rgthhoctvs	2017-12-07	xqxmbbgm@jutdh.com
179	dekyulyjen	2008-06-16	aufaxmjk@dircb.com
180	owfxqtbhgu	2006-10-14	qrsttwrb@uqdvy.com
181	jjmlbpvcgg	2007-03-06	qfhyvcfq@eioly.com
182	gdybmbxvgf	2007-10-14	pikhtsgk@lrwmj.com
183	aogilnpyoy	2010-10-03	bbfdrnjv@hcyqp.com
184	mgvribqslh	2014-05-08	ienipwun@lbbmp.com
185	itaoqhwrof	2007-04-22	aablvgwi@iyfjy.com
186	jhjvracxrt	2006-07-13	mevjokqi@hofdl.com
187	ttdjmvctyj	2012-04-23	aqoovnmj@srtue.com
188	vpnwplbtwq	2020-10-23	thudbpom@sghmd.com
189	svwmwyxrha	2007-11-23	rghvrnqr@baglc.com
190	nypjmeqxhk	2004-09-01	wyokpsmp@vmdtw.com
191	cwugcrrtiu	2016-05-28	ufriahka@ernel.com
192	gwyhcwavqf	2019-11-05	rkstbweb@aqlao.com
193	coqhnssxkm	2013-12-09	knecsucs@fpkls.com
194	jhjgtojckw	2019-07-23	sptdvbdc@cdonm.com
195	hlpxkcjoss	2003-07-29	ysovyhfx@mctfd.com
196	svqdlniymd	2005-02-01	imqimpjn@yvtgg.com
197	lytgfpsuvd	2006-07-08	wtiwkndh@wqnoj.com
198	pylkfnyvcs	2007-07-01	vxfjdnkm@gwuru.com
199	heggbsmsud	2007-05-19	jibjlhls@uadvo.com
200	urufbajtxl	2017-05-28	ofskxwgb@vrnqb.com
201	lwtcxsmqks	2006-06-11	xlmfxoad@qyrxh.com
202	dskeqeoufy	2014-08-11	dswbaxqk@wvetl.com
203	cxeyodycsr	2020-08-01	cuatrrgl@pdver.com
204	uxgqhsrqxo	2007-03-17	hipeltna@gjlpp.com
205	gopjbkfbtx	2005-12-09	mljimqkw@juysc.com
206	cftumjruuu	2000-06-04	smyrbxar@sylxo.com
207	penrkujclp	2002-12-02	mwocpmgg@dhjwi.com
208	vhwismdvoh	2006-10-29	myroefka@aashg.com
209	jxjbfyomra	2005-06-24	sealusig@pltvi.com
210	adyxtsqdvo	2010-07-03	qoocrcvg@msqkr.com
211	hheajjxivc	2010-11-04	shcdwqdu@mqjon.com
212	bgsfwfrslv	2001-10-03	yrgbdbky@kblcx.com
213	tcrccwnbmx	2014-09-22	kgayydpu@ansvr.com
214	nkrfulipdn	2019-05-18	oabkgbyb@uyfyi.com
215	rcjldewich	2004-02-16	qewwkunb@ewutp.com
216	hbxajmqiyv	2003-04-18	wkrkjxuf@denmh.com
217	jsbtljddhv	2005-01-20	cjidtwjf@enfpv.com
218	ehcryviyoa	2000-07-07	kbxpkpeh@rwark.com
219	jbmahnpbmb	2016-10-04	esovqdna@nfnhf.com
220	nvakgkchfw	2012-08-10	ttanfgpj@pyirt.com
221	aqdmubjdyi	2005-04-22	enungsia@fewlg.com
222	dkgyrqpvqk	2017-02-27	wdatqlij@wobre.com
223	xtutipkimw	2008-08-09	nblqlvpy@tniuh.com
224	pdhyoucbxi	2007-12-09	usogqiky@ayvkm.com
225	iuvyijmgyp	2011-03-22	asrbeege@beyti.com
226	allpehengw	2008-09-29	feofgjcv@pvutc.com
227	yiiqxygvlo	2008-07-12	bcdlcjbj@jijtn.com
228	jhyetcwfqi	2000-02-14	rowscusp@xmjjm.com
229	vxclralflp	2013-02-10	uvfgydfy@shhla.com
230	glxqncikcb	2018-06-02	vahlwdmy@mlaea.com
231	aksxrexnxb	2013-06-12	ntwtvyce@egipo.com
232	bpdybpbbfy	2019-12-11	skppftab@cvbrh.com
233	dtgkkjvwrr	2005-03-21	cufcfbmj@oxsqh.com
234	vjfdssvpyn	2011-02-09	ttptiihm@ymhuh.com
235	xicwkornjc	2010-11-18	krsnrdps@netke.com
236	ogtkyqgxlj	2005-11-04	jrojajqk@obktt.com
237	cgpbxxbfub	2008-04-11	fwxjyxuf@hcwhc.com
238	xkdoomhcjc	2006-09-17	lskvfsyc@udvac.com
239	rdxcpkjidi	2009-06-05	alifnjnj@lfbtg.com
240	owltmwodop	2001-06-06	gwpqlnmm@ieows.com
241	evkdlmsogb	2010-10-22	ntueldcg@gpvuk.com
242	hupvwguaun	2013-10-29	nfgbqirr@bqnua.com
243	iivwlxqdew	2003-09-19	tqbyrwxr@fbwxk.com
244	dfythubooq	2001-05-01	pqtuunom@mfgod.com
245	xaleflnwgg	2007-08-02	ljoeojho@ffibr.com
246	wawomksrtf	2005-08-09	ckcqamwt@eopke.com
247	prpqkwxjdi	2010-04-17	swkmwjpb@xfvlu.com
248	ebykhetseu	2001-11-21	egnepcsi@hhwpn.com
249	qbxnodltuf	2019-11-04	heycvwdr@kgrbo.com
250	jkkyintlxy	2011-02-26	uukumeqn@rqwik.com
251	pbwbrgtwyo	2016-12-28	wdqnodlx@iuvsm.com
252	rokqlinrap	2015-03-05	ksnavjoq@fwfvf.com
253	tompqwashb	2002-09-01	twcuajrq@gvtyk.com
254	lylpvwckta	2018-01-16	jjshsovt@tfvvp.com
255	wpfbxwanwu	2003-04-02	royxivle@udyol.com
256	msqvyjqfgh	2014-11-02	eabseftm@axcjc.com
257	urouwghjbx	2007-02-07	qgkunsrn@gides.com
258	nodjxyugqi	2011-05-17	ecrcqxgx@qrqyu.com
259	bougjuhyxf	2020-11-14	ifsoeait@orkjt.com
260	abyhrhmamc	2013-04-18	awjyogjp@cbnuq.com
261	dywvwephmv	2019-06-19	qjabdpgh@pefee.com
262	wvmyiijmpr	2012-12-12	yrrbwlyt@qutsd.com
263	kjmogjiuve	2009-10-04	rwnxpxrq@abkyv.com
264	mufvpehfco	2007-09-30	ndkdatyf@nyjbt.com
265	uslyesjnfx	2013-05-13	ubddlesk@tigwk.com
266	erqjvemyyi	2005-01-05	alpumpex@gqyet.com
267	jaolcslutd	2010-02-06	prtiqfxb@bhdsj.com
268	dddihvjnpw	2015-07-05	nctisbgq@oocsc.com
269	vijrnplmev	2014-12-06	blhmeaes@fvqqr.com
270	twdispbbvf	2001-01-30	aemcnnes@ufyjm.com
271	sbsnplepvm	2004-07-09	tbnvpdao@ffjbm.com
272	utwupdcidw	2020-03-17	gpqgibym@wkxhs.com
273	dtjmcriyqf	2002-09-27	xjxfqpix@niksy.com
274	dtgsxugrkg	2001-05-05	mgbkqvmf@cbwlp.com
275	ssxnyouhxp	2009-08-30	hkwxvchh@byoya.com
276	nvymtnuvcb	2007-04-19	kpdekpnf@acjbj.com
277	tglswgklsw	2009-12-19	bhavfimo@hywkd.com
278	aaulnhyhho	2011-02-25	jdmxrjss@tpajs.com
279	ewjuopemgb	2007-10-05	nmjtjlsg@mrgje.com
280	vdpnsqqhmh	2015-05-16	iuvxghgu@pnapr.com
281	hcmtfpuboy	2019-03-25	hhppgckq@xconq.com
282	tdqqdlgsae	2007-02-07	msvxihyy@ijcuc.com
283	asggbvfrvh	2001-08-25	voyhcaab@vjbcd.com
284	ocinrhlpix	2003-11-16	pymcxitq@jotbd.com
285	hongrfxooj	2017-08-23	tnrtngcl@hajyc.com
286	qipvlmatxm	2008-03-05	pxoblpfx@grpai.com
287	eoulstaqka	2014-09-26	qgdujabu@nvyyq.com
288	nyghhtjtog	2009-08-02	hnweknjh@bhiab.com
289	rbbnwejoxm	2012-07-31	tuasneia@pgrcj.com
290	aglfnucume	2010-06-26	foxlvoky@smfgi.com
291	ykfotblfmc	2004-06-03	aqoowxik@fckmj.com
292	cminjeuogx	2014-06-22	ltarfcqo@nrxfl.com
293	mgpkpkwmhj	2018-08-23	hrtjemjk@skggs.com
294	iruupmedme	2006-01-30	whmwtpjp@erxxw.com
295	qjkngdmfhr	2014-07-01	xexpyquw@wjhjq.com
296	cdievfufbv	2018-05-08	abiqvmnt@edqvk.com
297	oprrsutnsu	2005-05-04	noxcdmcv@cwnti.com
298	siqbhjghsq	2012-05-14	opjkiejb@npysb.com
299	ghcjyosryk	2009-12-24	eyirfknc@pwaxu.com
300	rlydedskhc	2011-11-22	iykxfjca@qwulx.com
301	Andruxa	2002-08-28	andrew@hmail.com
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
836	4
836	26
836	28
836	170
836	171
836	170
836	172
836	59
836	29
836	170
836	173
836	32
836	174
836	175
836	176
836	177
836	178
836	179
836	180
836	176
836	181
836	182
836	183
836	184
836	185
836	186
836	41
836	187
836	180
837	4
837	13
837	16
837	22
837	17
837	12
837	18
837	10
837	11
837	20
837	14
837	23
837	8
837	15
837	24
837	21
837	9
837	19
838	1
838	2
838	3
838	4
838	5
838	6
838	7
839	9
839	36
839	13
839	4
839	37
839	23
839	188
840	203
840	206
840	207
840	218
840	209
840	69
840	201
840	207
840	208
840	212
840	4
840	199
840	210
840	179
840	211
840	217
840	213
840	219
840	215
840	220
840	214
840	216
841	26
841	62
841	59
841	63
841	65
841	64
841	4
841	32
841	66
841	247
842	9
842	8
842	26
842	36
842	28
842	12
842	13
842	4
842	233
842	234
842	15
842	16
842	235
842	37
842	236
842	23
842	237
843	26
843	82
843	404
843	4
843	436
843	134
843	136
843	437
843	438
843	439
843	440
843	102
843	441
843	442
843	133
843	24
844	4
844	233
844	117
844	122
844	293
844	294
844	121
844	114
844	295
844	296
844	116
844	297
844	298
844	162
845	4
845	121
845	114
845	116
845	15
845	119
845	126
845	112
845	275
846	32
846	29
846	30
846	31
846	26
846	4
846	28
847	344
847	345
847	121
847	346
847	41
847	4
847	114
847	23
847	347
847	116
847	126
848	348
848	102
848	62
848	349
848	59
848	63
848	350
848	65
848	4
848	32
848	66
849	230
849	365
849	366
849	41
849	4
849	367
849	231
849	43
849	54
849	368
849	369
849	370
850	9
850	381
850	382
850	36
850	91
850	383
850	13
850	41
850	4
850	384
850	385
850	16
850	386
850	17
850	93
850	301
850	302
850	18
850	271
850	47
850	22
850	37
850	23
850	272
851	4
851	233
851	292
851	286
851	23
851	288
851	289
851	290
851	13
851	291
852	4
852	26
852	28
852	371
852	6
852	372
852	200
852	198
852	373
852	69
852	374
852	375
852	18
852	10
852	11
852	10
852	376
852	377
852	378
852	379
852	130
852	380
853	9
853	381
853	36
853	91
853	13
853	4
853	43
853	15
853	16
853	386
853	17
853	301
853	302
853	18
853	339
853	425
853	235
853	22
853	37
853	23
853	426
853	340
854	57
854	59
854	29
854	4
854	32
854	60
854	61
855	117
855	122
855	124
855	431
855	238
855	432
855	126
855	116
855	433
855	434
855	18
855	125
855	115
855	111
855	114
855	435
855	239
855	4
855	121
856	88
856	89
856	443
856	4
856	674
856	23
856	93
857	10
857	11
857	254
857	4
857	43
857	529
857	18
857	530
857	531
857	56
857	256
857	675
857	22
857	676
857	23
857	677
857	25
858	9
858	36
858	13
858	4
858	37
858	23
859	2014
859	1518
859	111
859	2015
859	2016
859	114
859	2017
859	115
859	2018
859	2019
859	539
859	297
859	125
859	2020
859	39
859	1870
859	295
859	2021
859	1153
859	116
859	18
859	2022
859	2023
859	2024
859	1872
859	2025
859	1013
859	2026
859	126
860	26
860	501
860	499
860	502
860	32
860	498
860	496
860	4
860	59
860	497
860	493
860	102
860	503
860	504
861	88
861	89
861	90
861	4
861	23
861	93
862	228
862	227
862	352
862	230
862	4
862	223
862	231
862	224
862	43
863	38
863	39
863	40
863	41
863	4
863	42
863	43
863	15
863	16
863	44
863	45
863	46
863	20
863	47
863	48
863	22
863	49
863	50
863	23
864	38
864	10
864	11
864	40
864	4
864	42
864	43
864	15
864	18
864	20
864	48
864	56
864	22
864	23
865	26
865	648
865	28
865	29
865	170
865	171
865	4
865	927
865	130
865	657
865	329
865	1445
865	32
865	651
865	659
866	4
866	535
866	114
866	536
866	537
866	538
866	160
866	116
866	162
866	121
866	297
866	539
866	163
866	165
866	126
867	9
867	381
867	36
867	91
867	13
867	4
867	233
867	234
867	15
867	16
867	386
867	93
867	301
867	302
867	18
867	271
867	235
867	1728
867	37
867	23
867	272
867	188
868	4
868	16
868	49
868	20
868	18
868	91
868	301
868	302
868	381
868	43
868	360
868	361
868	23
868	22
868	25
868	41
868	620
868	538
868	233
869	144
869	4
869	145
869	43
869	15
869	16
869	17
869	698
869	22
869	251
869	699
869	23
869	700
870	4
870	69
870	70
870	71
870	72
870	73
870	74
870	75
870	59
870	29
870	1
870	76
870	77
870	78
870	79
870	80
870	81
870	82
870	26
870	83
870	84
870	85
870	86
870	87
871	273
871	39
871	4
871	43
871	15
871	251
871	22
871	16
871	23
871	17
872	117
872	122
872	124
872	113
872	118
872	126
872	116
872	112
872	4
872	121
872	114
872	15
872	119
873	26
873	681
873	132
873	59
873	28
873	29
873	682
873	41
873	4
873	135
873	134
873	136
873	137
873	34
873	109
873	109
873	110
873	507
873	18
873	683
873	684
873	108
873	685
873	686
873	140
873	687
874	88
874	4
874	550
874	23
874	551
875	93
875	88
875	89
875	4
875	23
875	551
875	550
875	614
875	615
875	41
876	27
876	35
876	444
876	445
876	662
876	663
876	664
876	71
876	72
876	665
876	666
876	667
876	668
876	39
876	669
876	670
876	671
876	672
876	673
877	88
877	4
877	550
877	23
877	551
878	20
878	13
878	4
878	67
878	22
878	16
878	546
878	23
878	25
879	4
879	16
879	22
879	17
879	12
879	23
879	36
879	188
879	8
879	15
880	274
880	626
880	4
880	43
880	15
880	22
880	627
880	23
880	628
881	26
881	94
881	95
881	96
881	97
881	59
881	98
881	99
881	29
881	100
881	4
881	60
881	101
881	102
881	63
881	32
881	61
882	26
882	556
882	82
882	59
882	552
882	405
882	4
882	156
882	158
882	554
882	555
883	130
883	131
883	132
883	133
883	134
883	135
883	136
883	137
883	138
883	139
883	140
883	141
884	4
884	6
884	1
884	1113
884	230
884	320
884	51
884	43
884	822
884	130
884	18
884	10
884	11
884	10
884	376
884	2027
884	52
884	54
884	55
884	53
884	1329
884	39
885	27
885	146
885	147
885	148
885	149
885	150
885	151
885	152
885	4
885	54
885	35
885	153
885	154
885	5
885	156
885	157
885	158
886	2028
887	2028
888	2028
889	2028
890	2028
891	2028
892	2028
893	2028
894	2028
895	2028
896	2028
897	2028
898	2028
899	2028
900	2028
901	2028
902	2028
903	2028
904	2028
905	2028
906	2028
907	2028
908	2028
909	2028
910	2028
911	2028
912	2028
913	2028
914	2028
915	2028
916	2028
917	2028
918	2028
919	2028
920	2028
921	2028
922	2028
923	2028
924	2028
925	2028
926	2028
927	2028
928	2028
929	2028
930	2028
931	2028
932	2028
933	2028
934	2029
935	2029
936	2029
937	2029
938	2029
939	2029
940	2029
941	2029
942	2029
943	2029
944	2029
945	2029
946	2029
947	2029
948	2029
949	2029
950	2029
951	2029
952	2029
953	2029
954	2029
955	2029
956	2029
957	2029
958	2029
959	2029
960	2029
961	2029
962	2029
963	2029
964	2029
965	2029
966	2029
967	2029
968	2029
969	2029
970	2029
971	2029
972	2029
973	2029
974	2029
975	2029
976	2029
977	2029
978	2029
979	2029
980	2029
981	2029
982	2029
983	2029
984	2029
985	2029
986	2029
987	2029
988	2029
\.


--
-- Data for Name: Link_Product-Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Link_Product-Order" (product_id, order_id) FROM stdin;
586	399
296	78
407	299
641	405
65	45
163	311
691	10
817	412
837	108
46	172
410	105
102	275
569	191
189	156
135	56
808	124
261	109
345	302
710	181
397	371
171	135
466	488
70	95
547	260
773	270
267	180
426	160
113	393
101	62
95	60
725	312
294	232
474	390
826	5
458	397
871	37
729	28
89	201
851	117
430	370
665	393
568	241
20	483
79	267
101	132
844	346
609	488
24	173
393	254
98	401
756	95
848	5
529	71
807	438
726	428
199	10
496	247
360	348
131	127
812	473
604	143
112	258
569	224
687	233
676	101
751	211
43	191
802	343
662	256
240	202
840	312
355	459
184	83
644	474
477	363
619	463
197	335
210	143
594	143
221	209
156	250
401	432
655	158
353	420
43	112
496	422
560	73
114	182
174	331
832	31
869	283
157	62
72	72
370	44
249	345
312	178
735	65
724	470
561	387
777	464
826	300
452	373
241	475
771	460
206	352
196	200
443	397
353	347
497	335
187	323
380	290
251	204
250	38
125	455
533	200
686	40
126	92
67	137
643	195
77	402
785	311
858	297
41	210
125	175
778	147
59	8
200	448
104	129
54	499
345	341
540	87
309	276
694	80
553	67
58	18
392	111
538	387
504	477
835	445
719	7
685	214
295	390
86	443
699	227
508	195
177	450
664	193
512	353
151	91
181	345
501	124
303	202
445	117
51	121
766	324
745	393
64	373
80	463
676	79
520	415
226	326
161	473
485	284
249	99
383	235
171	171
312	231
407	355
483	99
205	57
12	252
190	343
61	478
106	400
292	464
786	431
534	171
298	323
479	216
190	38
514	245
136	274
198	73
356	198
740	457
321	253
570	238
821	447
444	346
576	154
719	478
435	482
727	68
476	103
569	489
813	234
674	77
358	478
291	39
864	145
188	258
647	197
154	177
143	18
443	23
325	263
258	327
365	45
279	8
604	450
421	189
619	434
60	122
843	202
173	480
11	145
355	333
134	125
244	263
485	138
377	324
700	496
733	54
407	332
57	456
83	316
144	315
541	423
432	245
360	309
741	45
594	381
281	251
480	116
220	24
227	336
26	376
658	58
437	284
343	222
518	251
208	435
411	226
720	229
34	123
668	341
796	75
12	307
211	324
72	332
622	298
858	294
52	19
61	123
347	93
543	262
702	88
493	489
382	280
459	313
357	33
731	469
693	437
682	482
284	94
423	302
847	272
101	486
317	216
378	164
785	463
611	276
300	124
724	399
285	159
393	74
714	493
110	162
592	464
315	6
120	414
50	256
21	363
587	63
788	259
712	154
567	443
149	182
570	437
328	30
213	126
206	284
239	354
520	424
469	189
852	293
441	214
317	14
359	54
132	230
475	376
783	141
415	386
284	235
478	207
454	19
528	75
751	427
474	164
609	377
53	278
281	53
802	383
302	414
89	250
471	124
749	280
562	256
642	227
882	193
43	302
663	399
543	164
288	437
807	230
853	457
808	351
295	476
606	157
117	231
249	235
8	60
634	491
540	29
163	466
214	228
513	124
51	187
68	366
654	240
525	30
362	52
413	478
668	76
136	293
89	310
246	108
597	429
776	431
747	305
819	18
377	435
742	435
309	23
151	262
871	328
755	55
348	274
280	412
883	159
285	236
516	141
374	486
470	344
587	65
796	138
730	273
431	81
587	246
421	136
403	20
265	70
384	241
382	373
702	114
81	123
337	124
170	323
138	237
421	274
255	255
536	39
377	397
81	201
73	202
476	50
555	159
830	379
185	37
713	204
60	176
708	446
285	21
171	145
23	79
395	88
661	34
444	277
308	237
634	148
596	499
440	64
531	189
882	116
772	412
56	336
21	337
277	286
673	461
743	16
352	419
587	244
275	494
404	155
633	79
481	165
110	42
292	385
36	161
27	497
256	436
234	238
835	350
239	31
476	42
409	480
110	139
502	77
846	394
304	415
726	65
816	285
883	105
297	232
18	329
875	54
853	134
779	419
786	322
169	297
544	466
616	140
609	456
154	34
514	149
614	372
348	483
259	195
680	172
630	431
148	29
354	444
29	102
516	162
851	44
340	393
309	85
20	217
337	54
485	125
272	86
804	96
736	339
99	245
841	197
201	343
454	151
436	496
481	144
807	457
833	213
509	339
44	460
735	434
610	48
759	92
800	330
876	278
373	90
677	400
360	480
691	58
136	67
316	252
5	381
273	154
798	359
47	79
730	476
642	168
371	368
273	51
801	44
640	299
774	115
858	7
687	180
821	84
477	417
519	486
103	322
358	100
692	452
785	26
189	371
871	88
348	471
167	243
444	436
213	217
512	200
670	20
28	339
698	314
652	465
501	225
416	306
103	476
313	416
289	199
256	51
225	87
493	120
869	266
503	24
727	328
842	48
871	241
226	389
354	116
103	225
429	424
598	53
743	126
121	345
469	164
845	313
331	405
482	84
34	251
451	83
353	363
566	380
134	439
225	33
372	486
769	150
344	481
24	353
350	417
608	490
195	84
142	476
830	8
206	101
641	112
446	124
850	350
143	100
456	369
628	330
808	248
282	299
142	225
465	423
118	428
410	264
342	191
265	201
287	484
453	78
448	441
588	327
112	487
824	50
370	18
598	121
107	39
99	197
240	136
393	356
748	355
275	392
854	330
829	36
52	74
321	345
601	497
231	21
658	5
90	125
813	221
328	332
687	233
442	407
273	385
878	56
72	168
133	409
674	27
771	240
214	193
459	411
635	341
26	36
507	375
131	238
59	294
171	193
454	82
277	361
367	20
643	197
635	255
559	263
551	28
587	252
508	305
14	384
476	245
443	333
284	149
731	122
210	321
787	480
591	277
611	357
484	479
476	201
826	379
319	243
509	246
316	19
661	215
715	217
525	263
451	62
609	272
627	247
33	247
176	316
82	462
817	411
476	21
700	470
178	9
212	259
138	334
505	179
440	476
346	103
372	322
197	386
385	11
86	454
485	377
812	248
218	327
870	453
531	137
561	263
835	173
655	45
714	281
590	359
752	226
554	405
407	411
783	270
863	491
480	21
398	34
249	32
339	201
757	257
641	319
208	67
864	79
713	477
643	116
205	152
203	398
776	284
524	305
652	412
286	117
47	359
824	499
591	290
698	176
260	489
338	322
232	132
692	363
446	340
115	295
537	55
700	44
760	155
429	216
655	331
324	46
197	100
344	132
874	250
789	164
345	273
391	205
221	87
175	251
53	102
745	428
82	13
147	405
273	29
556	416
517	387
753	243
365	330
423	141
551	128
617	346
444	1
232	359
282	474
437	399
632	146
51	310
781	237
548	48
797	486
432	244
717	131
182	467
580	170
622	20
313	151
761	462
89	106
671	342
702	271
883	375
693	393
499	179
867	312
24	267
449	247
615	485
748	309
650	284
765	101
863	21
434	447
4	382
400	60
391	444
266	288
100	255
858	29
490	494
420	390
759	238
142	84
614	449
384	92
288	399
171	395
598	103
438	14
578	474
203	245
389	232
617	213
204	188
776	421
816	456
119	465
750	204
674	70
519	119
655	105
188	88
50	42
797	404
82	148
386	338
235	302
613	202
508	333
443	208
349	324
387	500
758	463
757	26
714	167
692	226
415	268
767	285
825	476
783	408
411	228
245	416
102	155
25	240
141	490
810	193
722	222
355	245
789	241
626	48
805	301
879	415
36	257
133	336
487	230
756	203
418	68
834	207
468	152
492	114
672	278
615	280
339	185
543	330
120	196
539	84
665	117
387	248
388	407
829	188
554	28
823	165
724	493
530	489
443	359
805	281
784	106
670	289
303	218
48	121
668	427
624	346
626	475
641	335
571	301
690	297
119	382
550	105
530	320
317	305
28	335
472	492
94	316
881	173
699	388
294	495
38	471
540	73
603	375
49	376
716	236
605	170
675	264
464	491
815	22
411	363
617	25
503	298
133	173
665	122
95	467
494	396
718	451
791	373
139	60
332	60
848	167
538	63
592	27
707	186
202	185
59	399
39	286
240	479
189	425
820	103
85	90
861	277
871	237
703	188
536	480
210	333
834	351
670	402
710	409
128	252
529	173
842	132
463	481
748	283
662	73
576	442
102	50
788	406
761	282
343	199
259	417
831	322
181	38
187	413
689	445
209	387
118	458
804	91
445	267
222	297
415	7
827	256
262	395
401	422
546	185
465	409
855	468
488	418
725	11
664	106
177	135
281	381
714	248
304	465
678	73
866	247
302	59
434	354
720	490
80	198
688	221
877	294
843	271
113	370
273	200
58	254
163	229
97	275
481	74
358	84
816	196
224	315
700	335
22	435
621	291
730	2
854	326
822	101
721	253
531	201
422	321
558	391
605	422
632	113
469	211
27	484
401	202
464	373
486	154
405	387
788	123
870	165
347	79
661	427
808	456
112	247
629	472
365	24
205	178
597	310
152	408
95	472
793	64
435	362
293	487
266	345
58	204
317	146
688	437
117	105
421	490
429	357
354	500
495	225
469	343
725	32
14	474
222	126
853	29
284	159
584	318
365	333
477	226
249	462
61	130
353	48
231	196
289	366
737	450
431	424
460	86
60	290
533	231
407	398
845	299
32	473
112	271
45	137
492	338
29	90
799	459
792	88
402	293
330	154
861	339
536	58
682	236
585	395
398	346
214	106
122	21
577	3
607	366
62	291
168	310
140	303
425	407
759	323
461	383
650	208
334	114
300	224
260	214
460	211
878	476
8	25
748	40
476	31
90	90
283	113
446	348
614	439
128	351
205	269
552	355
836	211
125	2
336	253
220	61
462	159
493	394
189	225
479	306
711	229
191	115
400	129
133	375
659	90
868	403
188	420
183	90
93	379
525	427
165	231
239	111
718	450
75	263
434	230
279	289
686	161
152	268
617	210
782	215
165	477
849	379
833	320
198	107
734	199
161	358
879	484
879	29
115	162
40	473
841	92
387	414
149	483
652	192
392	377
273	408
746	442
264	269
593	439
473	450
435	350
111	230
614	115
9	362
431	293
45	201
469	452
884	46
467	27
473	161
43	403
184	492
478	34
484	162
705	488
809	90
225	428
275	2
225	444
873	446
129	276
429	467
447	214
214	447
811	26
100	327
117	323
30	72
534	416
406	406
796	337
263	405
510	23
455	262
785	297
81	490
625	153
391	376
429	160
94	67
339	21
120	237
313	196
727	349
549	43
341	32
462	19
550	108
122	236
491	184
810	58
253	308
622	266
682	387
257	26
14	488
318	54
798	143
100	121
268	54
216	370
34	83
97	413
590	222
837	235
752	400
220	214
723	316
381	409
601	307
45	171
557	132
600	346
372	197
342	373
153	414
362	422
135	172
441	66
47	450
530	473
194	47
726	295
602	36
802	301
390	332
848	367
258	411
239	192
142	84
209	127
418	479
243	28
351	89
208	286
251	351
753	94
211	68
508	46
259	369
783	402
642	313
416	494
521	413
601	246
840	494
748	210
80	354
844	491
615	443
522	78
777	460
363	244
504	416
863	94
26	169
400	171
639	19
395	186
817	28
234	179
217	343
539	209
314	22
596	323
206	478
397	222
822	83
58	228
634	414
405	374
820	53
345	228
840	28
304	201
123	281
41	67
755	498
281	304
53	127
701	377
31	486
748	468
127	23
836	46
618	339
432	341
475	14
809	210
293	494
601	131
153	24
418	362
305	70
266	396
349	316
639	366
301	131
737	121
233	180
482	125
127	371
288	43
674	424
722	234
27	363
820	317
609	498
570	10
231	168
618	26
25	450
820	206
387	79
282	37
652	450
434	112
4	190
117	281
765	167
407	302
607	2
284	479
236	165
831	71
270	447
191	185
64	308
334	424
439	413
737	229
848	117
187	206
659	145
780	252
467	490
143	488
471	341
233	340
587	273
249	439
266	368
357	136
740	395
753	164
496	70
150	432
144	170
782	30
18	392
541	433
307	144
723	45
128	178
566	439
24	230
89	464
159	42
38	461
763	40
841	1
395	351
482	322
584	367
580	398
631	246
468	327
613	384
838	237
269	112
128	364
436	435
453	357
240	238
194	166
91	285
790	150
592	221
440	457
753	246
839	66
724	421
183	346
160	393
677	276
433	4
383	327
827	143
558	270
115	44
432	269
7	165
791	442
625	285
299	333
552	98
21	187
421	98
816	65
873	366
243	198
623	370
53	200
337	297
543	125
617	262
40	428
256	172
558	94
50	129
756	108
379	228
884	457
188	11
65	443
277	112
71	420
539	248
265	322
679	475
551	366
503	67
739	24
518	12
778	48
587	388
348	253
392	379
229	131
527	286
777	222
493	406
242	324
595	335
523	2
715	197
136	417
12	352
9	357
455	209
434	164
255	148
870	477
156	185
48	390
553	195
552	258
79	132
82	63
544	459
302	382
485	70
353	78
117	276
689	498
638	420
635	313
537	122
24	86
54	334
486	402
355	195
64	131
755	347
635	255
717	396
741	283
885	75
245	346
50	436
96	170
194	469
95	166
91	38
707	443
136	145
253	348
282	127
327	31
45	192
285	62
371	421
567	106
835	24
434	3
171	80
818	288
176	495
371	150
210	261
69	170
864	195
850	147
752	263
679	221
676	148
40	115
70	282
797	320
447	98
405	464
491	356
534	401
630	74
646	298
525	273
629	445
603	202
861	347
390	35
151	44
815	122
683	141
303	353
433	168
495	7
738	15
85	129
632	382
706	358
134	443
492	434
409	341
760	406
398	431
551	466
541	340
479	292
790	148
178	112
547	190
743	1
131	402
103	297
790	481
69	484
683	418
225	335
820	455
611	342
98	1
60	166
667	400
627	32
155	50
260	341
138	2
19	63
854	129
12	425
233	118
134	155
717	401
419	126
147	178
266	64
611	130
748	116
222	195
221	378
453	303
535	40
678	427
703	50
725	202
534	7
619	378
296	487
182	138
706	274
101	57
467	168
144	109
254	352
170	262
683	272
639	495
491	373
580	12
136	294
511	51
591	482
30	67
564	239
187	6
217	362
799	9
183	403
106	395
231	58
877	21
317	280
611	306
311	80
58	171
17	147
83	254
708	114
119	188
182	178
388	494
823	161
312	311
139	359
509	191
471	284
658	425
550	363
628	313
104	408
330	458
576	336
57	322
284	76
399	55
756	133
292	381
287	472
576	460
638	279
104	261
565	84
5	187
268	117
867	340
261	70
447	468
80	144
517	390
739	478
174	416
72	182
601	27
347	414
692	403
40	500
663	35
351	459
650	78
715	496
596	356
734	396
463	84
160	29
825	473
130	381
551	384
661	398
860	257
316	165
335	179
147	98
249	238
70	43
598	46
114	380
138	202
478	223
831	324
164	109
755	104
272	399
485	198
151	468
685	431
419	12
531	106
597	485
584	134
457	361
671	327
285	345
633	24
795	458
215	159
680	139
693	459
584	278
39	247
561	42
750	106
776	183
302	338
879	439
747	41
851	84
148	378
592	179
9	380
699	459
116	292
857	476
58	405
74	284
194	62
843	94
820	326
445	220
764	160
270	382
89	117
409	417
877	136
330	34
491	428
9	188
758	24
244	477
860	444
11	428
881	220
350	472
820	221
663	390
786	41
64	28
451	312
414	365
863	417
512	407
522	404
561	408
659	54
872	358
366	263
433	272
494	9
637	280
748	428
6	351
477	155
840	232
60	15
399	66
620	60
441	171
747	45
647	212
33	309
187	223
323	299
229	67
795	9
357	425
217	7
759	424
329	339
444	282
327	39
17	362
216	213
201	15
718	173
805	334
828	329
171	242
816	310
162	377
325	68
540	494
804	499
373	186
299	86
7	120
239	366
668	234
86	281
869	198
426	133
181	434
343	358
659	217
462	154
39	284
447	498
473	21
59	430
360	212
102	175
278	393
865	183
579	126
731	334
378	492
102	271
238	429
858	64
658	305
210	93
305	195
644	298
204	332
56	380
572	299
41	416
310	293
594	461
313	167
633	436
466	44
626	32
298	288
53	279
491	256
619	264
402	291
541	490
21	208
790	16
400	274
100	310
68	472
38	454
810	203
31	163
536	481
265	56
396	17
149	249
653	231
353	234
185	333
310	214
836	38
450	159
861	466
525	195
146	61
276	193
538	259
652	204
112	329
412	259
646	295
61	98
753	256
248	154
488	34
646	95
258	475
844	287
649	80
881	461
284	424
507	454
343	251
693	293
567	18
41	258
710	312
296	108
551	367
505	112
179	121
771	81
173	452
88	337
736	491
821	374
147	200
507	499
27	390
644	101
603	317
863	390
193	63
251	493
416	337
690	81
224	299
380	194
628	292
812	342
435	261
434	196
737	184
80	424
606	185
223	485
233	105
460	153
833	486
872	147
802	140
98	195
405	404
769	316
344	78
241	344
713	319
197	59
185	204
421	339
221	382
566	239
823	46
277	315
42	354
184	72
376	163
36	34
737	298
421	299
652	366
488	298
242	244
11	111
495	264
354	43
627	369
167	146
38	346
659	455
251	3
142	59
181	79
35	298
575	330
877	112
20	479
582	453
847	225
30	175
500	406
143	238
371	223
443	48
791	136
401	180
476	496
258	463
74	444
60	386
108	81
37	354
378	218
270	1
745	220
143	208
426	429
218	419
725	279
278	437
164	300
443	482
442	49
103	307
188	60
259	3
65	233
192	103
630	343
473	140
715	47
167	269
590	402
483	7
52	216
266	292
813	380
562	333
125	169
564	370
54	175
282	103
218	139
861	282
560	133
565	316
187	157
12	248
329	66
746	201
175	134
99	9
462	428
658	200
692	116
713	35
157	157
430	223
146	260
11	470
799	413
841	447
159	162
476	62
342	270
166	149
872	200
874	74
286	278
580	397
795	434
842	284
168	120
89	153
729	47
876	261
321	312
649	367
171	388
495	292
862	152
179	3
99	320
638	218
147	182
331	454
493	274
821	16
47	328
368	265
717	274
858	55
463	120
819	290
587	270
145	144
786	169
673	93
10	279
562	317
529	450
352	473
13	392
259	287
288	261
595	145
113	203
620	178
640	159
390	88
517	348
710	406
729	211
358	92
295	32
348	5
287	467
661	481
603	168
606	152
539	68
506	342
491	412
6	19
157	301
530	186
473	394
740	227
126	145
94	227
679	362
603	275
545	177
399	57
754	88
400	101
782	277
295	268
266	298
471	362
760	337
171	490
271	239
880	254
788	264
109	316
106	409
17	492
532	480
113	118
7	7
641	341
416	17
559	491
312	373
237	472
268	367
189	51
527	129
732	414
519	9
444	412
810	6
628	32
151	397
55	87
254	23
593	218
459	284
251	116
830	98
662	463
552	83
54	480
821	125
775	404
491	400
647	266
430	158
329	89
159	102
19	294
576	465
188	171
833	388
385	25
149	402
798	407
736	50
880	158
674	82
137	354
745	75
60	199
318	167
300	213
366	282
167	61
268	378
246	198
16	459
875	152
846	413
61	71
93	28
479	279
331	119
437	33
197	487
20	462
321	417
778	160
411	90
802	82
683	435
311	400
754	244
213	179
19	185
404	349
646	441
847	416
811	64
179	116
219	278
224	332
456	183
479	89
449	70
84	164
395	374
79	492
241	425
656	56
570	389
596	382
777	325
141	425
845	274
113	366
694	493
529	444
380	140
376	479
868	382
559	344
315	129
176	137
251	47
192	342
279	166
578	279
668	218
634	253
302	127
61	131
196	223
90	142
83	405
562	69
850	300
85	176
531	396
363	151
589	310
120	240
229	332
409	34
485	435
498	175
502	69
831	453
845	162
190	404
10	416
256	324
132	172
840	286
81	401
714	299
545	427
248	248
33	160
785	309
155	52
319	110
339	285
42	48
392	442
865	117
291	323
679	240
213	365
836	104
106	60
676	448
684	127
729	104
847	475
83	226
610	219
880	369
48	355
132	32
721	147
839	483
33	108
97	75
868	55
247	34
303	8
148	235
35	430
680	492
433	241
308	326
256	255
367	299
878	115
623	192
620	331
127	63
270	92
854	438
26	75
559	442
309	33
621	94
685	169
678	287
414	200
92	405
528	273
617	386
455	177
151	244
337	33
623	297
640	41
24	207
168	326
851	137
316	489
722	386
537	383
530	473
747	52
139	338
272	45
689	394
387	118
483	56
461	317
203	351
342	14
277	433
522	132
529	302
391	158
293	286
114	262
596	65
819	64
372	46
635	251
317	278
371	25
20	19
338	17
101	168
754	34
616	363
436	318
202	392
451	445
387	69
703	179
227	427
153	437
104	267
817	356
443	250
344	270
97	368
631	300
799	332
456	301
862	99
450	236
121	237
130	450
574	104
872	434
760	189
115	139
176	149
35	136
735	301
104	91
245	96
96	446
850	488
305	309
78	276
111	416
632	72
630	337
697	419
5	147
181	42
152	460
361	24
681	28
436	11
440	304
434	48
665	321
107	97
141	345
773	331
563	342
875	38
66	42
368	3
510	202
42	20
438	240
80	433
690	275
581	160
573	161
663	266
100	374
799	98
87	398
265	436
779	228
262	33
143	108
560	22
738	491
107	184
531	24
776	322
366	500
731	289
717	311
355	31
30	33
734	90
740	430
295	58
62	134
720	171
835	26
325	170
796	229
87	86
386	104
216	31
169	407
276	56
773	317
361	413
163	19
52	100
458	274
2	350
745	472
671	87
14	85
591	456
71	189
342	18
95	487
855	54
498	364
781	446
150	180
87	329
658	467
90	81
604	250
417	101
298	286
482	329
787	412
129	181
816	348
195	318
677	437
41	187
414	230
760	426
812	93
695	357
740	470
187	419
301	407
656	200
53	36
321	27
241	146
417	291
475	59
456	296
179	339
793	33
604	265
110	188
164	229
825	316
345	243
142	172
671	49
467	467
561	380
438	463
536	16
379	236
92	491
439	20
641	142
756	18
81	328
299	456
551	127
326	125
11	208
733	436
31	317
495	500
273	304
787	234
675	416
728	267
676	406
531	192
231	116
321	302
561	56
695	399
204	75
543	472
550	420
520	121
544	422
693	343
523	244
700	236
679	337
452	113
257	150
113	389
578	290
640	152
780	323
304	94
741	252
475	342
254	309
414	493
433	229
429	4
503	258
258	350
198	492
353	292
340	105
95	67
786	119
736	321
491	327
676	180
380	51
175	207
241	405
731	73
852	488
289	120
636	334
551	499
12	86
366	244
72	371
243	370
304	472
396	71
30	480
865	57
317	310
719	213
41	43
566	291
710	142
310	11
56	13
342	303
452	442
831	285
140	470
80	465
620	462
245	173
230	89
462	346
167	397
242	375
21	481
244	304
646	10
385	9
517	250
72	66
556	265
759	81
750	45
647	156
204	175
771	83
824	152
146	258
702	488
187	492
645	270
273	327
11	321
669	361
579	205
210	401
2	446
630	100
676	257
633	3
372	306
200	139
35	126
152	1
41	145
574	89
76	294
663	34
359	330
742	2
436	185
43	141
568	226
502	13
569	141
818	118
867	343
205	350
418	21
577	366
862	14
344	302
649	13
760	234
656	392
841	383
648	124
691	7
766	92
863	253
556	12
885	168
727	36
42	356
545	210
741	101
479	472
219	184
617	51
350	216
303	313
88	42
394	442
453	325
824	327
339	446
578	330
790	453
301	457
95	334
691	234
299	351
57	252
631	155
592	45
773	279
130	410
768	188
55	273
687	25
765	463
174	437
662	58
529	311
829	320
742	278
726	114
798	341
504	157
530	149
347	56
128	435
286	318
201	274
687	98
509	244
732	281
188	239
544	378
813	251
542	123
579	28
830	468
693	190
761	449
776	492
276	122
121	383
136	343
538	30
567	415
549	455
623	293
285	295
748	389
461	154
484	123
110	192
530	206
686	92
712	64
213	110
797	267
6	116
226	214
657	173
306	327
125	300
631	9
883	251
154	284
313	300
460	333
679	145
180	219
317	458
39	287
703	495
392	184
848	195
384	25
37	429
594	488
611	367
287	135
170	176
347	208
704	285
236	283
494	132
427	40
393	257
741	249
256	411
689	415
828	359
349	230
390	474
549	336
343	271
125	25
292	193
610	133
838	315
602	426
722	126
847	497
284	45
45	252
865	218
690	359
463	448
443	78
633	25
407	227
785	48
368	53
121	226
485	42
646	19
129	494
774	473
494	442
227	60
731	274
308	195
90	175
613	415
646	208
182	424
746	459
282	493
15	337
398	428
373	50
160	187
605	297
67	434
763	367
714	27
180	208
328	377
807	134
758	164
311	121
651	70
42	383
835	213
695	138
491	462
171	185
389	32
270	432
551	151
261	448
111	20
644	393
165	250
554	371
342	394
333	147
746	99
291	32
660	487
107	288
683	258
155	211
419	76
565	189
864	253
209	287
605	125
340	340
873	373
757	83
232	484
306	311
727	448
212	414
684	177
1	124
860	475
863	78
875	191
201	383
13	487
142	76
525	392
239	341
590	379
507	305
321	2
569	286
721	413
731	36
34	478
229	469
184	75
9	38
104	303
833	497
51	82
855	271
270	288
37	67
576	32
575	27
451	362
847	65
725	340
492	182
153	432
28	156
715	324
584	480
225	283
177	494
366	372
149	492
218	494
755	89
856	367
528	114
743	427
602	70
372	180
459	500
863	215
331	274
235	222
40	406
579	491
561	214
727	494
294	428
299	405
538	71
831	96
835	245
345	314
500	43
388	41
587	92
3	449
447	478
208	94
742	114
465	120
468	37
708	82
138	275
369	215
353	4
267	92
217	342
592	306
715	41
49	455
846	175
17	270
300	369
87	163
461	336
342	226
467	399
325	369
42	247
283	191
823	228
609	337
551	310
274	413
145	92
638	353
744	67
689	87
443	339
337	155
836	311
65	294
709	435
32	117
512	164
827	155
819	154
652	469
300	303
791	122
882	370
40	225
261	21
610	95
837	430
403	462
856	27
692	94
739	332
204	479
722	61
445	145
868	101
344	275
881	272
486	460
774	369
151	67
361	297
418	413
212	270
771	409
736	452
645	448
445	205
744	159
391	362
577	252
768	91
552	60
466	483
851	383
676	281
736	265
105	247
132	352
323	124
536	313
360	229
115	101
816	157
124	495
349	232
393	305
66	246
637	478
694	268
547	429
387	480
316	484
589	396
663	349
53	220
491	161
79	323
104	1
138	419
674	202
456	334
169	30
245	346
98	121
778	450
708	209
94	9
577	130
745	231
46	422
857	366
8	260
412	453
783	471
544	373
554	132
318	241
19	383
90	162
481	50
316	249
747	207
266	161
179	255
451	252
623	216
465	258
862	448
379	145
102	493
412	286
459	270
111	83
584	57
662	107
746	355
47	322
697	495
346	247
448	428
876	436
801	255
398	336
840	484
313	233
816	480
232	100
603	192
809	391
156	238
643	353
338	250
754	457
11	488
215	297
209	223
696	372
780	48
489	90
573	358
646	271
457	212
270	300
355	489
160	414
252	55
699	145
94	473
700	267
654	465
637	47
387	172
672	333
598	117
568	188
482	165
402	106
71	147
574	426
110	242
246	350
146	312
274	278
284	493
368	182
495	388
519	85
765	103
752	98
686	54
198	20
147	450
548	138
689	263
751	433
408	152
275	352
622	106
617	461
857	353
568	163
22	214
201	495
250	93
34	146
492	225
378	168
458	327
32	121
258	104
82	225
863	335
854	367
544	275
196	381
677	133
415	301
135	23
794	203
633	243
758	447
614	438
82	377
619	426
91	301
472	453
697	263
387	500
504	50
625	202
539	58
255	64
775	284
739	384
19	62
558	147
159	208
112	457
863	64
578	19
799	388
261	286
277	292
291	33
282	457
826	301
721	331
24	128
751	195
459	326
710	205
648	109
654	491
338	255
567	308
389	465
379	200
272	382
608	186
50	486
237	319
803	423
448	402
725	262
380	85
650	19
756	191
111	170
91	237
527	228
162	225
19	472
621	95
646	158
481	76
182	13
738	19
308	500
319	85
582	498
576	500
790	456
544	26
591	35
503	183
564	265
531	330
477	400
881	328
265	234
566	267
349	248
183	66
109	476
522	234
166	477
848	379
66	135
234	266
717	371
241	48
408	374
766	194
95	255
145	253
850	349
605	92
388	431
57	327
668	82
192	213
686	48
873	31
825	484
563	360
388	126
637	203
578	483
584	130
128	394
614	452
173	198
373	460
831	466
570	202
349	471
797	472
610	221
463	46
325	75
823	132
1	493
330	484
124	284
866	482
840	166
245	400
448	441
650	150
823	31
854	460
147	204
577	53
599	142
696	202
508	246
151	305
756	24
270	73
96	271
725	87
532	152
524	215
679	329
515	330
767	320
702	122
443	467
743	260
168	122
373	158
849	475
761	75
433	75
491	3
377	491
457	408
692	326
793	144
71	407
483	489
346	373
88	114
555	470
689	386
235	365
458	416
223	414
248	300
447	334
270	498
862	67
303	428
808	329
275	445
249	120
165	325
818	414
126	422
838	20
99	148
234	101
589	396
296	369
496	355
329	334
770	148
308	30
120	367
506	471
679	341
346	446
70	500
851	253
797	59
511	387
237	154
502	488
412	480
779	47
188	85
13	184
635	313
318	458
694	1
415	232
244	79
622	189
659	296
338	80
564	122
589	369
184	243
836	116
799	369
710	148
526	223
101	63
619	411
396	210
314	275
22	235
230	130
765	146
577	358
793	65
400	479
389	232
653	207
404	249
164	429
625	203
451	117
137	38
320	460
265	453
792	301
629	182
316	278
301	353
876	277
79	431
759	286
501	124
704	243
169	17
228	295
437	40
455	459
608	494
19	182
824	121
488	7
695	312
552	471
369	18
216	407
445	313
194	150
243	454
800	177
751	284
47	158
540	323
541	354
145	226
31	262
554	136
309	214
20	191
92	229
385	375
122	131
91	443
173	483
201	161
364	245
694	127
324	448
27	71
478	289
261	325
126	356
268	135
514	410
164	416
862	186
629	404
765	409
839	272
413	136
373	382
48	148
327	456
372	127
831	151
770	268
647	498
248	277
488	421
621	144
550	338
606	76
575	161
162	287
439	467
271	425
791	256
554	346
485	400
28	385
742	365
802	170
432	106
546	379
676	119
857	120
286	157
588	281
491	120
8	14
123	468
293	252
277	407
234	327
114	384
156	3
837	201
226	274
770	23
818	437
104	301
869	147
754	114
333	253
682	134
313	89
155	196
715	313
873	331
848	277
827	107
80	162
154	124
756	434
348	455
621	76
527	352
685	397
813	376
863	354
760	178
885	474
287	434
139	208
858	45
615	245
867	100
378	415
568	349
150	88
494	30
124	221
295	320
617	145
10	366
457	47
162	145
542	119
82	402
480	433
653	481
41	400
377	259
701	313
388	57
686	364
159	173
186	264
17	437
61	251
74	387
200	437
445	332
461	316
69	170
354	171
598	41
653	2
243	355
429	384
639	427
368	113
340	432
816	100
140	86
326	347
582	296
425	183
730	429
508	65
686	66
105	295
310	300
817	474
171	35
412	223
435	432
699	345
255	161
92	354
179	100
736	394
710	365
665	136
333	144
343	158
867	482
209	489
579	342
102	142
548	372
454	351
253	173
165	415
822	31
256	460
269	98
426	443
365	108
238	256
431	206
490	97
875	451
590	299
451	361
314	241
739	118
709	29
612	404
397	115
50	18
756	132
794	348
50	248
507	303
155	166
423	23
466	468
654	150
666	295
215	372
392	325
760	68
571	164
73	321
473	302
59	438
178	396
419	271
236	479
326	276
18	150
573	6
4	261
429	307
82	389
789	361
217	23
333	40
538	144
190	270
129	336
266	461
844	300
792	187
370	112
48	129
273	313
584	47
824	441
120	52
475	452
297	37
786	320
763	116
279	466
713	339
845	395
340	256
140	134
387	2
823	16
460	24
503	347
584	188
784	497
442	21
539	470
356	70
628	500
543	207
808	367
305	228
387	220
756	30
603	296
612	114
166	73
363	91
591	289
567	47
405	71
487	288
164	203
41	465
802	11
799	240
52	307
431	55
78	56
217	490
794	370
27	131
447	282
363	258
688	458
437	472
613	279
660	31
242	425
282	303
302	414
402	387
771	25
485	49
236	302
155	242
856	202
262	344
157	493
539	493
142	91
588	446
254	115
725	193
552	473
459	404
364	482
468	468
2	157
343	240
866	59
285	39
388	220
826	177
150	254
327	390
612	395
56	457
382	404
176	56
248	17
573	187
769	345
541	428
378	321
834	91
737	440
492	10
876	152
314	493
184	56
21	107
782	454
805	83
466	354
427	70
336	152
774	421
704	470
680	480
884	104
12	476
607	307
528	5
686	129
805	87
361	169
256	480
752	351
353	84
431	48
626	294
145	177
837	40
806	127
855	455
563	1
155	349
406	294
245	159
538	77
757	122
39	474
394	76
793	149
556	161
172	167
284	219
658	417
283	246
553	390
61	337
563	465
427	54
813	331
807	321
825	275
587	351
857	394
644	288
293	339
684	234
481	356
867	481
177	361
307	411
140	59
256	37
667	220
811	283
503	348
297	480
250	499
46	297
146	300
209	259
414	154
179	338
432	389
175	490
222	160
310	254
330	185
283	258
586	361
654	378
718	484
191	184
227	284
151	46
433	267
3	404
484	485
308	31
92	48
750	94
103	96
400	50
594	275
103	211
328	199
37	323
122	270
4	412
542	144
463	276
240	160
413	283
335	351
212	469
593	117
52	295
782	273
239	356
431	339
736	82
830	147
459	141
779	78
380	133
554	339
660	94
536	75
219	282
546	41
395	200
878	215
596	395
708	192
418	139
770	64
249	393
413	63
646	321
431	321
867	247
794	354
741	395
366	90
451	426
521	451
508	475
221	242
497	35
553	414
167	173
873	275
308	186
763	427
399	483
650	232
559	309
727	316
451	261
614	372
716	348
561	367
568	414
578	24
82	284
267	491
580	381
335	448
87	70
321	191
752	284
582	441
78	221
233	478
702	20
770	437
598	30
276	6
523	348
809	186
830	213
487	470
89	40
714	180
71	487
665	331
300	263
212	102
814	134
507	422
280	66
385	124
258	276
662	16
278	481
369	8
530	242
134	111
390	21
816	420
684	202
513	245
436	400
223	294
703	329
151	403
135	31
440	27
366	331
109	120
434	171
697	375
872	293
355	260
866	167
409	309
432	232
368	317
702	283
617	68
685	184
559	7
420	313
169	402
73	336
59	200
802	163
838	193
202	104
623	457
709	3
11	194
417	91
484	167
410	395
728	138
742	438
229	284
111	9
273	149
351	187
7	218
646	92
109	178
355	254
798	105
545	63
302	103
122	145
521	327
547	475
333	404
257	153
735	145
771	439
487	253
62	223
555	353
259	408
745	227
728	118
478	398
810	222
524	115
205	47
323	409
622	285
440	42
337	5
292	304
277	4
845	104
585	377
209	49
431	498
475	24
293	39
146	479
874	90
39	22
465	190
208	179
220	77
229	472
681	403
392	378
728	355
782	35
811	214
55	242
772	121
655	492
545	360
216	197
175	452
831	455
660	429
10	360
342	440
11	452
770	499
262	259
527	259
260	328
311	413
566	412
522	348
668	316
359	461
847	142
462	33
388	8
709	133
576	361
43	414
124	287
645	120
849	408
602	408
731	314
570	191
617	373
564	431
113	452
634	438
93	487
715	435
648	21
547	325
150	190
278	278
284	480
777	434
346	249
824	415
169	265
57	104
574	290
468	320
714	467
480	420
403	307
80	53
143	489
658	343
161	61
260	168
149	454
695	150
594	126
760	182
855	83
642	487
407	403
206	12
539	73
751	57
710	212
582	468
478	453
327	297
182	53
200	470
802	224
875	240
680	179
690	14
563	242
644	271
884	246
260	92
677	485
637	393
346	229
111	186
410	120
878	384
198	73
105	152
799	326
136	433
569	146
498	84
401	417
291	393
339	67
779	84
232	2
276	55
337	63
42	62
868	428
228	406
516	118
320	345
280	428
161	25
191	436
627	333
487	384
615	109
296	4
310	338
276	122
544	21
797	201
318	391
518	212
277	317
292	296
310	287
38	84
328	380
825	343
115	380
238	287
838	127
455	9
445	323
660	11
95	137
229	347
755	128
763	482
204	46
361	455
101	331
549	307
549	113
447	7
38	250
632	495
171	484
169	373
217	86
875	417
745	244
36	357
827	248
48	128
589	328
434	236
187	363
737	216
397	101
125	414
145	53
519	296
361	311
329	133
872	70
745	342
686	36
188	323
564	48
26	408
673	46
322	82
486	266
473	177
131	81
767	76
84	145
564	343
653	324
710	178
460	73
319	156
635	349
291	242
205	410
709	287
252	341
765	172
289	104
469	370
112	74
166	403
378	87
115	76
802	167
71	129
47	443
477	451
770	488
399	381
874	317
868	490
380	479
249	396
234	484
616	217
11	128
212	378
538	208
372	484
610	19
813	211
409	446
819	35
858	429
509	456
560	251
293	329
286	336
95	129
138	219
183	41
486	174
655	257
199	288
770	5
703	323
95	381
267	163
76	263
791	83
624	88
646	312
103	461
388	430
50	298
161	230
542	58
663	23
175	321
674	72
415	243
815	386
433	96
347	426
571	465
145	433
358	474
699	121
767	290
361	404
288	486
422	335
856	117
809	372
217	434
715	363
32	453
861	312
479	130
698	225
590	146
279	426
700	497
125	167
368	113
706	207
337	235
267	470
504	4
200	158
594	166
686	12
186	277
327	403
63	9
724	112
438	282
861	328
818	3
220	59
294	433
865	394
773	50
834	391
490	111
768	336
591	434
767	239
818	279
752	182
472	357
788	180
800	65
757	222
563	4
162	332
262	294
67	291
766	249
852	494
15	196
485	459
214	330
482	435
177	345
68	400
756	225
94	299
133	420
702	318
627	201
617	345
565	80
792	93
686	226
263	63
463	183
42	366
425	38
879	347
301	193
129	433
518	46
825	71
761	402
160	160
865	109
705	239
354	98
684	81
852	465
843	417
840	371
566	133
575	71
841	305
223	53
433	263
765	343
113	9
866	142
873	309
198	296
176	500
520	460
748	229
698	482
260	338
304	272
268	124
657	7
860	70
341	478
504	55
385	219
688	61
361	475
11	257
272	265
641	497
220	103
499	416
559	166
136	20
137	7
757	244
47	254
760	43
655	416
357	259
53	414
513	257
553	64
813	318
847	150
867	304
203	470
147	191
366	72
688	27
231	58
534	317
214	238
544	7
361	398
73	366
205	369
846	57
808	20
420	78
783	134
460	244
712	54
323	65
374	500
364	489
287	195
717	278
710	236
760	430
516	113
109	249
765	102
574	209
175	195
142	126
438	6
723	277
94	204
137	139
127	249
74	473
508	161
809	349
204	69
77	474
186	82
662	80
716	26
849	44
505	163
149	245
719	385
582	454
289	309
51	74
430	169
595	196
631	445
797	383
120	471
367	352
491	476
884	121
419	159
379	270
419	118
183	471
2	454
351	173
711	463
854	198
743	432
501	345
530	35
375	484
362	405
262	322
351	332
719	202
218	321
176	326
549	45
353	438
790	215
770	323
736	449
666	387
72	156
8	38
617	402
215	363
626	53
875	234
381	450
629	47
64	147
322	85
260	218
627	341
44	299
705	490
719	312
741	54
632	8
540	331
851	369
729	419
710	230
674	453
596	325
672	493
396	131
590	67
694	434
84	103
845	116
305	30
608	321
804	50
278	333
267	3
364	441
131	279
140	415
7	103
854	140
713	73
722	271
145	368
447	346
722	29
875	278
817	267
152	481
390	143
282	396
630	359
141	422
773	261
582	43
137	106
578	301
154	374
719	267
823	256
808	408
263	297
701	283
114	405
600	330
490	195
878	280
570	177
489	176
879	417
50	235
295	380
600	310
50	338
688	351
373	106
745	489
164	86
103	401
675	500
393	471
641	20
372	71
476	225
884	194
820	456
648	448
796	14
278	99
373	482
665	280
233	426
233	67
598	398
831	306
853	142
269	453
531	149
541	477
664	59
518	244
669	152
366	166
496	370
71	255
25	449
282	467
315	270
237	339
417	217
560	156
373	358
771	75
103	202
400	394
805	393
240	240
303	64
712	439
554	467
623	88
848	125
458	472
75	476
515	334
203	436
342	416
125	334
617	311
782	37
732	6
127	109
13	101
361	100
768	393
159	483
725	387
650	440
450	485
67	18
721	30
532	70
405	58
632	227
512	477
374	272
699	314
136	321
367	118
225	234
829	377
855	404
188	432
777	429
824	220
703	159
346	493
686	91
845	213
343	249
401	400
308	450
780	488
32	379
324	125
407	224
882	41
110	265
858	32
175	412
620	97
280	90
146	112
742	31
176	349
731	412
416	469
691	388
730	263
227	370
31	411
18	308
531	334
799	80
610	406
552	444
598	360
736	326
40	495
31	142
30	427
809	185
703	106
286	410
439	321
440	320
180	450
562	333
267	60
565	99
381	285
814	2
605	383
472	497
95	381
454	459
199	164
57	42
781	155
86	205
396	484
7	500
539	212
502	251
833	498
851	262
35	217
687	248
261	12
209	316
602	298
360	25
302	405
399	348
110	474
17	479
94	469
196	113
759	474
497	33
885	258
566	428
409	112
836	362
115	331
72	45
203	147
742	443
116	76
99	296
10	72
804	29
700	40
593	87
554	425
558	7
857	386
582	274
527	203
311	167
96	441
508	71
505	348
856	143
877	261
455	238
710	419
638	252
147	294
838	466
281	230
819	176
151	434
181	133
424	94
198	152
415	373
740	401
77	347
826	465
478	116
769	263
299	266
247	426
841	9
703	326
281	250
46	420
754	45
882	308
194	11
176	464
478	63
364	321
492	458
544	422
283	465
465	175
68	443
673	341
244	305
285	322
789	116
440	360
384	204
492	20
531	38
719	130
684	425
99	30
311	59
597	418
516	229
868	136
683	331
235	111
75	498
53	361
118	265
226	63
475	256
151	205
211	333
358	170
582	76
171	440
723	60
462	480
839	474
373	440
362	284
218	171
540	333
864	157
114	382
599	153
810	22
194	387
237	138
416	308
772	348
559	385
711	461
187	17
80	310
702	17
466	490
241	276
342	457
795	206
702	434
63	448
327	50
166	397
260	297
849	217
748	230
518	87
277	159
11	407
677	112
459	20
159	95
589	285
293	101
398	349
722	107
634	260
473	217
825	355
633	296
57	79
339	114
65	284
289	151
551	457
217	429
285	193
829	158
688	310
498	386
554	289
50	129
322	222
373	175
661	242
734	178
760	494
615	464
772	79
377	193
475	302
56	396
306	207
162	491
257	275
566	378
330	448
73	56
746	409
660	420
844	234
430	330
475	297
629	220
819	152
671	400
311	373
767	263
261	441
186	438
755	115
400	316
666	371
387	160
197	242
578	307
775	449
317	399
472	99
493	424
42	246
853	178
759	416
775	343
332	258
277	16
625	39
865	228
683	126
449	175
378	314
166	86
542	401
412	470
206	97
453	425
823	166
617	108
105	89
659	317
191	404
280	463
853	6
287	83
63	119
520	146
219	15
380	214
250	264
294	408
224	49
80	113
747	457
284	101
400	17
381	48
459	301
188	205
523	464
631	310
201	21
503	111
174	481
749	386
611	452
358	294
387	266
616	188
654	74
438	275
161	37
438	3
619	54
548	294
707	85
631	486
165	471
463	320
206	280
410	97
862	65
116	358
591	66
84	322
634	180
450	275
592	71
259	116
580	499
492	217
465	224
538	311
447	58
863	448
129	98
334	448
460	184
165	367
456	491
404	137
168	404
215	418
487	350
639	46
438	78
300	453
815	301
16	342
852	428
650	287
39	356
318	244
500	76
830	202
201	100
883	371
318	141
508	496
672	8
420	112
118	107
623	132
758	486
94	493
492	426
149	192
722	6
51	211
518	473
552	211
696	230
746	41
359	208
147	432
643	66
787	248
768	256
885	74
578	36
354	422
291	81
672	69
426	469
767	345
706	417
616	258
78	352
615	434
280	446
183	156
367	377
301	412
146	294
558	242
118	113
629	257
542	443
752	71
826	149
794	51
42	414
51	25
757	134
733	459
213	175
182	83
185	241
131	439
514	303
597	398
536	21
72	304
156	458
532	237
28	345
18	137
434	494
814	400
522	412
750	229
439	318
488	395
171	383
83	356
54	429
522	113
51	389
518	486
747	282
98	95
862	458
639	322
714	262
341	362
877	78
39	78
299	356
439	457
541	275
512	399
670	388
148	17
685	154
731	185
817	304
187	167
730	443
276	108
873	89
563	66
707	166
735	315
382	137
622	26
334	100
369	374
298	218
407	379
673	6
182	34
748	117
371	379
277	76
496	253
441	294
108	156
805	464
98	415
597	96
611	360
466	61
334	427
56	191
535	136
43	180
312	342
238	143
370	406
338	369
526	175
231	212
151	316
318	102
409	420
655	50
777	165
559	355
31	352
424	216
860	498
240	473
468	130
554	393
802	185
806	389
391	12
316	40
139	223
512	473
566	410
563	328
133	382
201	125
792	71
645	151
663	393
277	101
25	470
273	387
135	178
792	72
451	436
641	145
257	41
696	207
284	3
76	21
434	384
580	58
368	332
338	496
479	157
715	383
477	83
119	363
340	215
800	152
324	325
409	141
477	45
475	299
722	55
193	399
212	30
18	286
476	494
513	492
\.


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Order" (id, transaction_date, taxes_sum, client_id) FROM stdin;
1	2013-11-06	450	67
2	2011-07-25	4	30
3	2004-08-29	164	4
4	2011-08-26	319	84
5	2017-06-10	404	29
6	2006-02-05	71	88
7	2001-03-02	126	19
8	2004-07-12	497	5
9	2013-07-08	184	11
10	2000-01-14	5	98
11	2006-05-31	127	85
12	2013-05-10	12	19
13	2016-10-31	399	77
14	2000-04-20	165	25
15	2003-08-01	360	48
16	2001-10-19	377	36
17	2012-03-15	181	87
18	2009-01-25	360	54
19	2009-05-07	121	1
20	2016-03-07	38	29
21	2000-12-28	45	64
22	2006-10-08	218	55
23	2010-06-14	180	7
24	2019-10-19	388	4
25	2010-06-01	252	64
26	2019-09-11	457	58
27	2007-10-16	34	67
28	2003-05-10	359	73
29	2011-08-21	56	23
30	2007-07-04	345	31
31	2019-10-14	29	87
32	2008-05-10	4	87
33	2002-12-24	406	56
34	2008-01-05	15	78
35	2020-08-06	22	65
36	2008-05-01	238	26
37	2015-10-22	2	40
38	2013-08-15	45	73
39	2016-09-11	410	74
40	2010-02-02	199	38
41	2004-07-28	149	24
42	2016-12-31	233	35
43	2020-07-09	367	2
44	2004-05-18	69	30
45	2006-07-08	48	22
46	2003-09-16	309	12
47	2011-11-04	130	52
48	2010-12-14	81	7
49	2004-02-22	10	84
50	2011-12-24	439	15
51	2014-04-01	38	74
52	2012-04-29	399	73
53	2018-02-23	144	43
54	2002-02-27	299	29
55	2009-08-28	367	40
56	2006-04-20	47	70
57	2004-12-30	272	26
58	2007-11-19	176	32
59	2016-06-14	219	10
60	2007-11-02	107	82
61	2016-06-12	193	5
62	2000-09-26	101	8
63	2019-11-03	384	41
64	2002-11-29	4	47
65	2018-07-09	5	59
66	2016-09-26	275	95
67	2002-06-04	191	45
68	2012-07-18	323	29
69	2006-04-22	378	9
70	2019-11-30	170	39
71	2020-10-27	324	5
72	2018-06-29	290	42
73	2010-10-27	125	99
74	2020-01-21	99	36
75	2013-01-26	57	63
76	2002-11-23	294	52
77	2012-08-31	420	87
78	2002-10-09	190	42
79	2020-02-14	152	3
80	2019-07-23	70	97
81	2016-10-31	332	27
82	2008-01-10	248	9
83	2003-06-08	459	99
84	2010-08-09	35	53
85	2015-03-20	186	61
86	2016-07-13	232	2
87	2004-10-18	456	92
88	2016-10-16	99	30
89	2011-07-31	398	42
90	2006-09-07	164	25
91	2017-12-20	29	71
92	2017-01-03	215	51
93	2006-10-03	179	98
94	2002-12-24	196	97
95	2000-06-27	399	92
96	2017-04-01	387	30
97	2015-08-26	403	53
98	2019-06-27	184	86
99	2000-03-24	462	62
100	2004-10-02	377	34
101	2014-05-11	86	16
102	2004-05-03	148	42
103	2000-08-30	287	28
104	2020-12-19	395	58
105	2014-03-04	154	71
106	2003-12-12	219	99
107	2019-09-14	216	69
108	2010-07-25	184	79
109	2011-09-28	147	57
110	2011-05-25	286	34
111	2016-02-07	311	33
112	2002-11-24	42	36
113	2008-09-20	121	89
114	2009-03-27	364	88
115	2002-12-22	470	64
116	2007-02-01	39	66
117	2013-06-12	281	21
118	2013-11-26	427	11
119	2016-10-14	154	39
120	2015-03-16	425	30
121	2001-12-29	378	64
122	2017-12-20	360	27
123	2014-06-11	91	100
124	2014-01-11	28	91
125	2016-09-29	489	84
126	2019-07-26	464	20
127	2005-08-08	295	73
128	2004-05-13	263	28
129	2014-03-28	143	93
130	2006-07-13	476	62
131	2016-03-22	1	3
132	2004-01-23	280	15
133	2008-05-25	211	1
134	2002-02-19	453	31
135	2006-08-23	434	74
136	2013-07-26	212	12
137	2004-09-07	139	76
138	2008-08-22	465	99
139	2016-01-12	436	66
140	2014-03-24	437	94
141	2006-08-26	409	74
142	2017-06-09	29	26
143	2007-12-18	125	93
144	2018-05-16	339	20
145	2017-07-07	130	28
146	2014-02-05	419	91
147	2005-02-28	242	66
148	2017-11-06	90	18
149	2009-02-03	297	90
150	2017-05-08	49	69
151	2009-01-27	295	90
152	2013-08-30	124	78
153	2016-02-06	111	71
154	2001-10-21	443	80
155	2017-10-30	458	81
156	2020-02-19	120	25
157	2016-04-25	258	91
158	2010-01-05	436	37
159	2013-07-22	482	3
160	2009-04-15	40	76
161	2008-07-23	231	26
162	2012-07-28	193	79
163	2018-06-30	57	50
164	2005-12-29	38	40
165	2012-05-31	98	67
166	2001-11-12	330	86
167	2001-07-15	215	79
168	2016-12-23	332	13
169	2001-11-15	207	46
170	2004-04-26	465	57
171	2000-12-18	372	67
172	2003-10-09	34	66
173	2019-10-29	438	6
174	2002-03-27	320	71
175	2005-12-15	132	74
176	2011-05-26	289	60
177	2020-01-24	48	13
178	2014-07-30	142	65
179	2016-05-20	316	42
180	2008-11-20	63	85
181	2015-01-25	146	14
182	2019-08-01	79	74
183	2001-10-29	7	22
184	2000-06-09	387	77
185	2007-03-18	75	77
186	2005-07-12	404	60
187	2020-05-20	171	93
188	2020-08-20	428	96
189	2001-04-11	351	13
190	2004-08-26	426	87
191	2015-12-14	6	46
192	2009-02-07	336	6
193	2008-04-23	349	46
194	2010-12-01	289	61
195	2002-01-07	310	29
196	2009-07-25	454	88
197	2013-09-16	201	77
198	2016-02-03	414	23
199	2008-10-05	131	18
200	2017-08-12	175	83
201	2018-04-09	203	26
202	2012-07-29	249	62
203	2001-04-12	371	42
204	2016-03-27	443	100
205	2007-07-30	152	89
206	2007-05-01	191	74
207	2009-04-13	406	54
208	2004-07-20	182	89
209	2007-06-23	259	86
210	2008-05-31	21	18
211	2005-04-07	500	68
212	2020-04-20	266	98
213	2002-10-30	190	22
214	2003-10-04	488	8
215	2002-05-07	3	47
216	2020-03-01	1	70
217	2007-10-11	384	85
218	2004-02-12	245	23
219	2012-05-09	443	35
220	2001-02-23	31	74
221	2004-10-26	50	22
222	2016-07-02	246	19
223	2017-08-09	125	43
224	2010-03-21	8	57
225	2000-11-07	188	83
226	2001-11-13	363	60
227	2012-12-02	334	93
228	2007-07-24	429	36
229	2001-12-10	56	69
230	2010-04-30	468	68
231	2013-12-01	90	62
232	2018-12-09	52	80
233	2007-03-26	299	55
234	2001-11-26	497	80
235	2018-06-10	216	68
236	2017-03-07	445	75
237	2010-08-29	406	35
238	2017-06-29	67	85
239	2019-03-08	191	8
240	2018-12-12	357	86
241	2002-06-24	249	76
242	2016-08-24	100	51
243	2003-01-22	406	18
244	2001-09-17	297	45
245	2017-07-19	288	48
246	2011-07-17	50	12
247	2003-09-25	7	57
248	2007-04-15	476	53
249	2006-04-28	456	73
250	2018-10-04	299	88
251	2004-12-10	472	38
252	2010-01-30	32	68
253	2009-03-27	379	70
254	2000-05-24	40	28
255	2020-10-11	12	51
256	2003-11-20	311	38
257	2002-09-10	406	21
258	2001-05-25	3	97
259	2009-12-25	189	3
260	2003-02-07	383	29
261	2013-05-23	379	48
262	2005-03-24	256	54
263	2018-07-30	391	11
264	2014-01-20	356	27
265	2004-12-26	240	11
266	2019-05-31	431	38
267	2001-09-04	2	71
268	2018-04-21	95	52
269	2016-02-18	376	9
270	2016-12-21	177	10
271	2015-04-21	166	36
272	2000-11-27	430	78
273	2019-01-20	119	97
274	2001-05-25	386	94
275	2020-04-08	98	17
276	2009-12-07	37	83
277	2004-07-01	449	76
278	2006-06-07	268	41
279	2009-10-18	292	28
280	2002-10-09	294	93
281	2018-08-15	326	80
282	2009-09-23	179	19
283	2016-06-28	370	99
284	2016-05-17	78	73
285	2009-11-15	44	90
286	2006-05-12	250	72
287	2014-08-26	76	100
288	2010-12-16	182	47
289	2011-03-30	211	20
290	2014-01-15	273	33
291	2004-05-30	137	79
292	2010-06-11	307	7
293	2012-06-29	295	27
294	2016-01-08	37	75
295	2015-05-02	327	91
296	2005-07-12	379	29
297	2004-12-19	203	20
298	2012-10-21	321	7
299	2015-04-21	128	11
300	2011-04-16	297	45
301	2013-06-10	63	12
302	2008-12-26	72	61
303	2000-04-15	335	22
304	2005-11-02	134	8
305	2006-04-18	235	58
306	2019-12-01	397	43
307	2010-07-21	371	91
308	2012-11-29	252	73
309	2018-09-19	120	74
310	2015-04-24	434	77
311	2002-03-25	355	19
312	2019-01-20	286	18
313	2017-02-20	62	64
314	2005-06-17	344	52
315	2000-12-06	232	40
316	2003-06-29	5	33
317	2000-05-08	496	47
318	2002-04-04	199	9
319	2012-01-19	418	6
320	2005-12-05	143	3
321	2003-10-24	69	91
322	2011-01-27	309	73
323	2015-11-02	484	96
324	2019-01-02	431	61
325	2009-08-11	179	58
326	2018-03-15	180	64
327	2010-02-01	419	99
328	2009-06-21	245	13
329	2005-05-03	290	53
330	2014-08-03	120	57
331	2012-04-20	424	1
332	2011-12-04	8	44
333	2013-09-30	423	28
334	2019-06-30	277	62
335	2007-08-26	39	76
336	2009-05-16	293	70
337	2007-07-15	499	11
338	2005-11-08	322	30
339	2007-11-03	158	69
340	2013-11-21	338	14
341	2019-11-25	102	92
342	2002-04-13	308	94
343	2018-01-10	205	25
344	2015-04-05	137	51
345	2012-09-13	329	2
346	2005-11-26	305	12
347	2012-06-28	311	68
348	2005-08-23	103	7
349	2005-01-11	134	50
350	2016-08-20	308	89
351	2007-06-09	402	81
352	2014-03-06	341	7
353	2004-11-07	40	91
354	2018-11-28	54	6
355	2012-08-04	46	38
356	2004-09-13	28	43
357	2016-01-21	139	57
358	2002-06-26	412	1
359	2007-08-05	272	46
360	2001-11-18	476	79
361	2019-10-28	143	28
362	2016-07-22	221	23
363	2012-02-17	399	61
364	2004-06-23	73	60
365	2011-07-14	121	39
366	2001-03-06	66	87
367	2009-11-08	92	57
368	2017-10-09	413	80
369	2009-09-17	242	89
370	2017-10-19	317	20
371	2016-09-23	57	92
372	2012-10-28	175	71
373	2008-07-20	83	20
374	2020-09-15	425	88
375	2001-02-24	291	60
376	2003-08-23	7	23
377	2015-06-10	55	81
378	2017-02-15	438	6
379	2018-08-19	336	98
380	2002-04-16	6	86
381	2011-09-21	114	81
382	2013-11-17	430	50
383	2003-02-18	359	30
384	2004-07-04	200	70
385	2011-06-12	234	48
386	2002-10-05	103	15
387	2004-03-15	240	87
388	2009-06-21	331	8
389	2004-05-19	110	36
390	2013-12-21	184	86
391	2002-03-31	62	56
392	2017-03-15	185	1
393	2009-10-05	182	89
394	2017-07-03	347	78
395	2010-10-20	109	57
396	2017-04-14	172	62
397	2014-06-06	416	15
398	2015-09-18	363	39
399	2020-09-10	48	89
400	2015-07-28	406	30
401	2007-12-30	249	54
402	2010-01-25	413	14
403	2013-02-13	483	5
404	2015-02-01	114	77
405	2020-05-23	299	74
406	2013-07-20	25	12
407	2016-06-10	39	95
408	2014-04-23	286	87
409	2000-12-21	243	38
410	2007-02-22	436	81
411	2012-04-04	443	81
412	2006-11-16	213	54
413	2014-08-24	294	91
414	2005-07-31	314	32
415	2019-10-17	413	58
416	2017-11-24	205	99
417	2008-01-22	395	42
418	2007-07-21	187	89
419	2013-02-28	302	96
420	2016-01-29	89	20
421	2020-11-20	76	86
422	2007-08-15	165	38
423	2016-02-16	133	28
424	2000-03-08	385	80
425	2010-05-27	471	20
426	2013-03-14	54	31
427	2001-03-22	160	80
428	2014-08-19	406	17
429	2015-04-23	160	23
430	2001-04-07	264	74
431	2013-11-15	85	22
432	2002-06-17	435	89
433	2012-08-23	402	68
434	2007-09-24	67	48
435	2013-02-07	451	39
436	2003-05-09	90	43
437	2000-01-04	325	61
438	2017-12-02	112	6
439	2006-10-18	23	4
440	2002-02-27	470	79
441	2007-10-30	391	39
442	2014-01-13	379	82
443	2003-02-26	237	69
444	2013-10-19	228	67
445	2020-08-28	306	68
446	2020-02-29	193	68
447	2007-02-22	426	47
448	2007-07-17	311	58
449	2007-07-14	111	75
450	2010-01-27	274	64
451	2009-12-08	124	19
452	2017-03-02	233	71
453	2009-06-01	427	59
454	2002-11-27	362	39
455	2016-04-18	239	18
456	2019-12-08	428	14
457	2010-06-23	206	77
458	2012-08-13	369	76
459	2019-09-26	326	92
460	2003-11-11	498	69
461	2011-08-14	435	54
462	2007-03-28	191	20
463	2014-11-18	24	8
464	2014-06-07	380	65
465	2019-02-22	452	71
466	2013-11-24	316	30
467	2000-02-02	476	2
468	2019-10-22	359	38
469	2015-10-01	479	43
470	2017-11-25	131	99
471	2017-07-26	262	5
472	2011-02-05	162	13
473	2009-02-20	48	100
474	2007-04-13	429	31
475	2014-09-10	474	39
476	2013-09-06	326	15
477	2018-09-14	244	86
478	2014-10-05	494	89
479	2011-12-17	83	80
480	2020-02-02	476	58
481	2013-05-01	147	4
482	2007-05-24	298	45
483	2000-03-25	227	77
484	2005-07-25	179	61
485	2018-05-13	424	52
486	2012-10-11	362	12
487	2005-04-30	394	60
488	2006-04-09	75	47
489	2004-12-31	333	7
490	2017-05-22	48	15
491	2008-12-21	300	44
492	2000-09-22	125	77
493	2008-12-23	303	16
494	2014-04-13	162	31
495	2009-02-02	460	14
496	2003-03-11	438	31
497	2004-07-24	415	24
498	2006-04-06	76	85
499	2004-03-12	103	16
500	2001-07-21	352	4
501	2003-02-02	447	135
502	2017-01-24	468	151
503	2010-06-16	174	59
504	2005-04-26	66	127
505	2009-07-18	162	154
506	2006-12-21	234	96
507	2014-09-19	210	111
508	2018-02-20	128	107
509	2000-01-28	11	31
510	2001-06-06	191	113
511	2003-05-24	438	182
512	2002-01-26	345	92
513	2004-03-15	243	48
514	2001-04-23	386	183
515	2005-10-24	479	144
516	2018-06-16	140	173
517	2005-01-03	448	72
518	2005-12-01	246	149
519	2020-02-03	52	122
520	2002-11-25	67	199
521	2015-12-15	187	57
522	2013-10-22	84	60
523	2014-05-19	282	21
524	2011-10-29	59	121
525	2004-06-28	66	64
526	2016-11-23	240	164
527	2007-06-17	443	72
528	2005-08-21	383	151
529	2016-01-12	317	78
530	2007-07-13	455	89
531	2006-04-09	45	146
532	2009-01-06	24	115
533	2008-07-26	281	66
534	2006-06-30	305	160
535	2016-01-24	324	61
536	2010-04-06	8	32
537	2002-10-14	246	196
538	2014-05-08	40	47
539	2016-02-15	268	40
540	2003-06-05	60	79
541	2005-12-16	306	78
542	2009-02-16	69	17
543	2012-12-15	324	190
544	2002-07-07	12	117
545	2001-05-07	377	182
546	2009-02-21	21	162
547	2013-12-03	455	155
548	2018-04-29	364	129
549	2000-01-07	147	172
550	2000-08-05	341	188
551	2015-12-08	108	10
552	2003-04-07	85	8
553	2010-04-02	91	13
554	2014-10-08	234	111
555	2014-12-13	86	11
556	2016-02-05	417	8
557	2000-11-03	228	116
558	2001-09-30	461	172
559	2011-03-14	131	145
560	2013-09-10	244	54
561	2014-06-09	68	141
562	2012-01-19	490	120
563	2013-03-18	337	67
564	2016-09-20	441	74
565	2001-03-04	152	49
566	2015-02-05	366	7
567	2003-08-16	271	46
568	2006-09-11	76	145
569	2000-07-02	254	71
570	2011-02-06	305	13
571	2016-09-01	354	193
572	2000-12-23	344	63
573	2010-12-16	177	43
574	2016-10-29	49	42
575	2008-02-08	242	101
576	2015-01-27	215	39
577	2020-02-19	161	113
578	2015-09-28	295	82
579	2005-11-16	48	91
580	2019-02-12	452	122
581	2020-10-01	161	18
582	2001-01-31	227	169
583	2005-09-05	284	88
584	2015-06-06	414	166
585	2017-01-26	285	106
586	2016-12-04	93	77
587	2020-10-20	471	188
588	2006-12-25	395	121
589	2000-04-29	301	168
590	2015-07-23	137	20
591	2019-05-09	271	150
592	2004-10-30	143	124
593	2020-01-10	50	69
594	2009-04-24	294	76
595	2018-12-30	472	138
596	2013-10-31	207	52
597	2002-02-26	171	150
598	2006-09-02	34	11
599	2007-11-25	497	79
600	2000-08-20	336	121
601	2007-06-08	330	92
602	2009-06-09	44	11
603	2014-05-14	454	109
604	2018-04-24	261	84
605	2003-08-20	147	122
606	2011-11-28	49	81
607	2016-01-14	20	142
608	2014-02-03	470	75
609	2014-12-21	210	175
610	2017-03-03	9	145
611	2003-03-06	186	119
612	2005-05-20	331	18
613	2009-03-27	450	193
614	2003-02-13	243	26
615	2016-09-11	83	37
616	2011-07-24	337	89
617	2012-02-25	278	41
618	2014-05-10	102	28
619	2008-02-06	239	48
620	2016-02-16	185	73
621	2014-12-03	162	120
622	2012-10-19	259	112
623	2020-05-19	234	122
624	2008-06-17	450	116
625	2003-07-04	359	148
626	2015-10-31	462	164
627	2009-05-25	233	138
628	2013-09-13	212	26
629	2009-07-14	196	200
630	2004-09-13	151	161
631	2002-10-02	416	176
632	2005-05-16	195	51
633	2017-02-13	244	64
634	2004-04-02	300	31
635	2020-07-28	238	26
636	2001-12-08	262	92
637	2003-12-30	319	23
638	2005-04-11	58	26
639	2004-12-23	405	192
640	2005-10-21	420	54
641	2005-07-25	69	81
642	2005-05-16	357	59
643	2004-01-19	257	186
644	2019-04-15	455	193
645	2000-07-01	459	183
646	2009-10-20	43	82
647	2010-06-22	113	132
648	2003-08-01	309	140
649	2004-06-04	136	167
650	2019-09-29	344	154
651	2020-09-27	372	96
652	2014-03-01	363	137
653	2008-01-27	150	5
654	2001-03-08	6	154
655	2005-01-22	377	123
656	2000-11-28	11	70
657	2017-01-23	95	169
658	2014-12-26	359	195
659	2004-08-02	252	200
660	2011-10-30	93	9
661	2006-02-27	88	192
662	2004-10-16	257	175
663	2002-09-16	10	60
664	2018-07-07	95	153
665	2002-04-05	38	56
666	2020-01-19	400	73
667	2007-05-14	339	18
668	2001-05-31	429	76
669	2015-02-12	414	190
670	2002-11-05	408	33
671	2013-04-26	490	119
672	2001-06-07	56	118
673	2010-11-01	143	119
674	2011-03-08	216	167
675	2000-05-19	168	11
676	2005-09-25	287	56
677	2017-10-11	437	30
678	2020-02-23	398	13
679	2018-04-13	297	159
680	2012-05-12	209	116
681	2018-06-28	192	150
682	2019-06-17	365	39
683	2004-11-15	378	178
684	2003-12-04	407	71
685	2006-06-12	162	196
686	2005-04-01	86	113
687	2003-09-29	35	50
688	2017-08-26	428	68
689	2015-05-24	356	30
690	2013-02-16	479	126
691	2005-03-14	134	54
692	2012-02-16	292	188
693	2015-01-01	95	158
694	2018-04-25	464	83
695	2001-10-14	96	96
696	2004-04-19	323	200
697	2015-04-11	295	155
698	2016-02-22	347	47
699	2007-02-18	257	174
700	2002-09-17	49	46
701	2001-01-03	437	70
702	2003-03-30	174	59
703	2011-01-02	252	158
704	2016-07-28	69	113
705	2009-01-24	247	181
706	2005-08-01	65	118
707	2020-11-15	34	106
708	2019-10-10	413	49
709	2014-12-08	381	200
710	2001-11-09	132	109
711	2009-02-28	193	144
712	2000-02-23	219	137
713	2019-04-26	382	2
714	2017-11-15	124	88
715	2005-08-08	257	5
716	2013-11-26	343	53
717	2006-12-05	379	176
718	2014-03-20	200	164
719	2002-11-16	124	193
720	2018-10-20	467	92
721	2017-12-18	346	68
722	2016-12-28	420	137
723	2006-08-13	205	106
724	2016-06-13	224	20
725	2012-09-27	356	129
726	2016-04-26	448	104
727	2001-07-30	211	121
728	2007-02-18	453	70
729	2000-03-05	40	182
730	2007-02-05	322	176
731	2007-06-11	387	89
732	2018-10-11	324	14
733	2016-09-28	460	89
734	2000-10-19	203	150
735	2018-03-03	228	69
736	2012-10-16	313	29
737	2008-04-21	289	71
738	2016-03-15	23	8
739	2011-06-24	487	100
740	2019-04-03	279	41
741	2013-02-27	104	4
742	2016-05-15	179	138
743	2015-02-02	446	31
744	2018-03-17	324	186
745	2010-03-22	200	6
746	2002-11-29	62	25
747	2011-12-25	90	178
748	2012-12-17	8	24
749	2014-11-16	119	33
750	2019-01-29	129	96
751	2013-10-01	375	2
752	2011-11-08	97	30
753	2003-07-26	124	35
754	2016-04-18	490	190
755	2018-07-06	388	174
756	2019-05-11	81	100
757	2016-07-20	32	85
758	2004-09-11	70	133
759	2002-07-27	131	141
760	2018-05-30	413	71
761	2008-08-21	260	178
762	2020-05-29	327	175
763	2019-02-21	178	65
764	2017-05-15	201	95
765	2007-10-31	38	109
766	2014-10-09	264	109
767	2019-01-10	308	72
768	2012-07-03	406	76
769	2017-01-05	68	44
770	2018-01-27	20	152
771	2015-01-17	112	96
772	2019-09-14	52	103
773	2011-11-18	431	160
774	2013-02-20	262	75
775	2009-06-13	371	173
776	2002-10-24	440	138
777	2010-01-28	286	77
778	2000-11-21	303	187
779	2017-03-29	262	46
780	2019-04-13	444	164
781	2003-08-09	309	190
782	2012-12-18	447	67
783	2020-07-12	192	198
784	2011-08-29	142	192
785	2020-01-25	465	187
786	2013-08-21	437	148
787	2005-08-25	197	75
788	2008-02-19	253	121
789	2008-03-05	64	91
790	2020-08-05	118	139
791	2000-09-19	6	118
792	2016-07-16	173	130
793	2001-05-09	50	25
794	2017-06-22	440	50
795	2002-09-20	410	62
796	2001-02-23	324	188
797	2013-10-29	244	105
798	2018-10-20	320	21
799	2006-12-31	156	39
800	2009-01-29	451	105
801	2019-12-27	206	162
802	2018-08-21	82	132
803	2020-04-04	12	121
804	2002-06-25	107	194
805	2009-12-22	15	129
806	2007-03-03	204	94
807	2000-09-23	145	169
808	2017-05-10	168	44
809	2014-10-14	136	84
810	2010-07-28	478	154
811	2000-04-10	299	144
812	2004-07-29	420	52
813	2005-02-18	83	120
814	2017-09-20	359	194
815	2017-07-04	134	44
816	2005-09-11	69	161
817	2005-06-17	350	155
818	2017-08-13	297	116
819	2001-12-05	367	41
820	2010-01-24	377	138
821	2010-03-25	55	89
822	2008-01-27	181	138
823	2010-04-11	126	112
824	2012-04-12	59	51
825	2011-08-09	389	88
826	2008-10-02	203	124
827	2009-11-26	99	200
828	2008-12-31	120	104
829	2020-03-23	334	1
830	2001-08-27	437	59
831	2014-02-13	253	85
832	2008-03-15	380	176
833	2001-06-27	200	131
834	2001-01-01	255	7
835	2004-10-18	487	58
836	2017-03-06	139	74
837	2011-03-11	283	117
838	2009-10-19	357	40
839	2005-06-18	144	52
840	2016-10-27	172	145
841	2005-12-24	433	60
842	2005-06-25	166	13
843	2017-05-12	341	24
844	2013-07-21	72	184
845	2017-03-14	14	1
846	2010-10-09	169	38
847	2009-08-10	24	119
848	2008-07-08	395	190
849	2013-02-18	86	165
850	2020-03-22	383	135
851	2019-09-01	94	5
852	2018-12-16	15	95
853	2020-10-04	274	6
854	2014-01-06	140	96
855	2007-11-11	311	55
856	2015-04-03	195	49
857	2020-02-16	31	91
858	2006-03-27	129	156
859	2015-07-11	28	55
860	2017-08-16	1	86
861	2004-07-24	32	26
862	2012-03-09	300	189
863	2019-08-30	74	8
864	2011-07-02	429	50
865	2015-08-27	101	39
866	2019-06-12	141	185
867	2004-10-05	351	73
868	2016-04-03	401	66
869	2013-10-28	4	97
870	2006-10-01	161	84
871	2005-06-10	385	69
872	2016-06-10	176	80
873	2007-01-05	10	142
874	2004-06-27	475	199
875	2005-02-27	227	169
876	2015-08-13	170	54
877	2020-06-27	458	109
878	2004-03-18	361	186
879	2018-03-03	184	152
880	2016-07-13	220	45
881	2001-05-27	43	23
882	2000-06-16	381	38
883	2006-02-25	418	160
884	2010-11-26	451	11
885	2016-01-20	287	83
886	2011-04-18	290	144
887	2007-10-17	423	122
888	2005-10-11	67	60
889	2003-03-08	32	138
890	2002-02-10	344	102
891	2006-08-14	399	96
892	2016-05-15	196	89
893	2008-10-17	445	56
894	2020-07-28	372	21
895	2011-01-08	375	133
896	2005-05-23	230	81
897	2010-03-01	314	47
898	2006-03-01	67	171
899	2000-05-01	366	197
900	2009-12-11	63	18
901	2005-09-01	482	199
902	2004-05-26	326	34
903	2015-02-24	110	199
904	2013-08-18	100	39
905	2018-02-23	433	123
906	2000-08-09	235	8
907	2008-12-04	217	1
908	2013-10-27	14	153
909	2001-02-19	32	105
910	2003-03-01	318	169
911	2007-12-10	288	134
912	2009-12-16	389	158
913	2006-04-10	21	130
914	2017-03-21	80	49
915	2015-06-11	212	45
916	2007-04-21	114	5
917	2000-09-12	217	93
918	2000-03-07	82	110
919	2016-08-30	8	133
920	2016-11-26	213	13
921	2006-11-28	396	188
922	2015-09-27	338	63
923	2013-10-15	117	141
924	2003-04-24	204	114
925	2006-12-05	99	83
926	2015-10-11	166	13
927	2007-11-12	119	43
928	2018-03-19	33	18
929	2012-02-16	32	194
930	2003-04-15	375	170
931	2016-09-10	302	152
932	2016-05-21	201	46
933	2006-03-12	378	117
934	2018-04-28	138	168
935	2007-06-28	484	108
936	2020-02-24	304	195
937	2020-01-16	208	104
938	2000-01-25	322	33
939	2017-01-02	337	111
940	2012-02-07	450	84
941	2020-06-24	212	76
942	2011-05-12	159	47
943	2008-05-07	347	31
944	2002-02-01	273	136
945	2004-06-30	241	100
946	2013-06-06	229	155
947	2007-05-26	314	177
948	2017-02-21	130	142
949	2020-11-27	122	161
950	2010-01-01	496	5
951	2014-02-24	56	63
952	2011-09-23	37	136
953	2016-11-27	343	139
954	2019-10-23	357	157
955	2000-10-21	192	95
956	2007-08-03	378	58
957	2008-11-15	104	123
958	2003-04-08	147	115
959	2007-07-07	19	106
960	2014-07-31	57	113
961	2004-03-29	283	152
962	2001-02-15	341	14
963	2020-03-16	123	88
964	2017-01-15	409	196
965	2008-12-21	150	64
966	2004-01-30	394	178
967	2012-09-11	421	140
968	2015-07-21	471	63
969	2003-06-14	123	177
970	2003-08-22	103	66
971	2010-07-24	338	111
972	2008-09-11	15	92
973	2017-01-17	61	2
974	2000-01-04	201	97
975	2009-01-06	321	120
976	2009-10-03	176	3
977	2012-10-28	460	33
978	2003-06-01	16	153
979	2008-12-23	271	8
980	2005-07-05	494	99
981	2015-01-16	3	24
982	2001-01-20	32	197
983	2002-02-11	395	167
984	2017-12-01	251	118
985	2001-02-01	213	195
986	2018-10-23	413	87
987	2011-06-19	268	43
988	2011-12-24	131	35
989	2001-08-04	438	61
990	2008-01-05	256	187
991	2019-07-30	211	43
992	2004-12-29	453	102
993	2016-03-15	113	57
994	2012-09-05	213	118
995	2008-10-27	303	24
996	2001-04-23	34	187
997	2013-05-20	124	28
998	2003-04-01	453	116
999	2012-07-28	40	104
1000	2010-11-06	109	73
1001	2004-03-16	197	119
1002	2014-03-15	16	39
1003	2018-07-21	296	135
1004	2015-11-20	203	21
1005	2012-10-22	76	44
1006	2007-11-19	47	124
1007	2007-07-08	344	193
1008	2008-02-07	374	78
1009	2003-07-21	212	64
1010	2013-07-16	169	55
1011	2007-10-17	213	71
1012	2014-05-09	371	96
1013	2005-06-19	435	161
1014	2002-10-07	332	128
1015	2016-11-27	202	199
1016	2015-07-21	438	106
1017	2020-10-02	480	120
1018	2006-09-17	415	185
1019	2006-09-11	280	3
1020	2006-09-30	261	189
1021	2000-06-11	361	6
1022	2019-09-06	64	165
1023	2000-11-06	46	125
1024	2013-09-19	407	115
1025	2011-05-07	387	31
1026	2006-05-23	381	171
1027	2002-10-03	254	33
1028	2016-06-14	39	132
1029	2019-07-10	186	162
1030	2000-09-14	426	39
1031	2007-12-03	236	12
1032	2012-06-06	174	63
1033	2017-06-03	274	45
1034	2007-07-19	259	183
1035	2009-12-19	326	166
1036	2000-12-07	358	82
1037	2009-09-05	167	135
1038	2015-09-04	304	123
1039	2020-05-23	89	177
1040	2016-07-17	267	191
1041	2014-04-13	174	195
1042	2007-01-28	185	132
1043	2018-11-21	352	125
1044	2015-07-11	19	87
1045	2001-07-26	321	11
1046	2005-02-09	426	89
1047	2020-12-13	142	53
1048	2019-02-22	244	158
1049	2010-12-11	407	15
1050	2013-11-24	433	126
1051	2000-12-02	233	68
1052	2006-09-19	413	85
1053	2000-10-29	454	119
1054	2006-02-17	46	92
1055	2005-06-07	13	17
1056	2009-11-18	359	143
1057	2009-07-22	215	141
1058	2012-02-27	167	89
1059	2019-05-24	392	37
1060	2012-09-22	491	162
1061	2007-05-28	105	86
1062	2018-03-07	477	159
1063	2007-03-29	386	158
1064	2012-04-04	329	53
1065	2000-12-18	226	104
1066	2013-06-17	119	98
1067	2001-04-22	423	95
1068	2000-04-21	193	140
1069	2017-04-04	251	180
1070	2014-08-01	415	45
1071	2015-05-31	247	151
1072	2001-01-05	170	121
1073	2010-12-21	157	31
1074	2003-05-07	188	68
1075	2009-10-18	105	14
1076	2000-01-14	341	109
1077	2013-02-02	278	124
1078	2002-04-04	97	86
1079	2009-07-26	135	178
1080	2017-12-13	191	111
1081	2007-01-11	312	52
1082	2012-05-18	81	21
1083	2014-08-27	106	63
1084	2010-08-07	156	165
1085	2019-01-15	282	5
1086	2016-02-15	480	141
1087	2004-02-23	282	179
1088	2011-11-08	348	43
1089	2005-06-02	13	2
1090	2001-07-25	239	44
1091	2011-06-25	323	53
1092	2008-10-10	170	20
1093	2005-05-24	471	151
1094	2003-01-09	258	95
1095	2020-09-09	174	200
1096	2004-04-12	315	110
1097	2010-02-28	291	173
1098	2013-01-11	416	48
1099	2001-04-24	433	159
1100	2008-02-11	435	88
1101	2001-10-27	485	150
1102	2017-03-06	128	195
1103	2017-02-03	137	67
1104	2012-06-17	216	106
1105	2008-03-10	221	96
1106	2013-02-05	404	75
1107	2019-10-27	344	179
1108	2009-07-29	55	140
1109	2005-09-10	140	23
1110	2020-07-01	379	80
1111	2018-01-18	242	83
1112	2005-07-13	116	178
1113	2019-07-18	465	117
1114	2015-03-21	30	71
1115	2011-05-13	383	189
1116	2007-08-05	190	120
1117	2012-05-29	177	177
1118	2014-04-22	479	112
1119	2003-02-22	379	121
1120	2007-11-04	484	12
1121	2017-08-18	170	6
1122	2004-06-03	158	83
1123	2020-07-10	154	91
1124	2010-04-13	308	136
1125	2016-11-19	268	20
1126	2016-04-02	466	44
1127	2017-04-12	42	182
1128	2006-02-10	459	31
1129	2001-10-13	30	6
1130	2009-03-21	80	164
1131	2002-12-16	142	191
1132	2016-11-01	90	196
1133	2008-08-01	108	37
1134	2010-06-28	79	25
1135	2007-06-14	437	142
1136	2015-08-01	391	128
1137	2005-08-30	416	118
1138	2000-02-17	269	128
1139	2011-08-05	268	134
1140	2005-04-18	496	85
1141	2008-09-27	89	133
1142	2004-05-25	176	173
1143	2007-12-27	180	20
1144	2014-07-15	241	38
1145	2019-04-15	117	35
1146	2013-03-26	141	122
1147	2007-07-28	207	170
1148	2010-03-13	174	143
1149	2014-08-27	157	103
1150	2015-06-06	134	38
1151	2020-10-21	474	22
1152	2007-10-12	45	179
1153	2017-08-22	363	46
1154	2020-06-29	40	181
1155	2020-06-21	425	18
1156	2017-11-11	451	29
1157	2015-03-29	69	162
1158	2005-10-29	24	154
1159	2013-04-28	269	94
1160	2001-12-16	297	186
1161	2000-03-27	416	6
1162	2018-09-07	342	118
1163	2001-08-29	494	108
1164	2000-04-10	336	125
1165	2016-03-09	423	66
1166	2019-05-09	11	198
1167	2000-01-09	44	41
1168	2016-10-24	195	97
1169	2014-01-18	147	19
1170	2016-03-03	152	168
1171	2000-11-07	401	89
1172	2014-10-23	41	77
1173	2018-05-21	416	199
1174	2002-03-16	9	172
1175	2010-11-04	464	108
1176	2009-10-09	356	169
1177	2011-08-27	137	62
1178	2000-12-05	224	51
1179	2020-03-21	161	47
1180	2008-04-23	186	89
1181	2003-07-09	457	38
1182	2013-10-25	296	59
1183	2006-11-21	309	163
1184	2016-06-02	198	112
1185	2010-07-26	474	144
1186	2020-07-05	348	68
1187	2018-08-16	177	96
1188	2019-03-18	442	83
1189	2006-12-23	349	162
1190	2005-03-16	390	181
1191	2019-02-20	169	161
1192	2016-10-18	329	74
1193	2017-01-20	37	166
1194	2005-10-31	65	27
1195	2018-10-12	436	6
1196	2006-10-03	43	81
1197	2006-06-11	391	12
1198	2007-01-06	108	165
1199	2014-02-15	53	139
1200	2008-07-28	422	187
1201	2001-12-15	166	111
1202	2005-01-07	215	13
1203	2002-07-03	220	51
1204	2011-06-28	157	140
1205	2010-11-13	394	175
1206	2020-07-08	379	141
1207	2003-10-11	166	89
1208	2017-07-01	141	20
1209	2011-03-26	291	166
1210	2007-09-15	428	109
1211	2019-04-11	169	57
1212	2012-07-20	299	63
1213	2004-08-22	199	156
1214	2002-02-06	474	149
1215	2018-11-25	239	140
1216	2011-09-17	343	139
1217	2016-05-01	154	32
1218	2015-06-07	311	19
1219	2014-10-22	131	38
1220	2007-06-29	40	78
1221	2016-03-11	435	138
1222	2001-02-07	485	181
1223	2011-12-30	421	124
1224	2006-10-21	396	32
1225	2017-08-06	434	71
1226	2011-02-25	184	19
1227	2004-05-08	380	144
1228	2005-08-03	416	82
1229	2018-05-03	363	180
1230	2011-12-27	460	94
1231	2012-05-13	371	104
1232	2002-09-28	72	162
1233	2016-03-26	187	20
1234	2010-12-02	388	146
1235	2002-11-25	397	111
1236	2008-12-16	74	139
1237	2003-01-26	293	1
1238	2010-03-12	268	99
1239	2000-09-20	309	124
1240	2007-12-21	98	82
1241	2000-08-23	137	93
1242	2008-04-11	247	93
1243	2011-07-29	32	114
1244	2018-11-09	292	123
1245	2011-09-01	172	15
1246	2016-03-10	361	132
1247	2004-09-27	404	162
1248	2012-05-26	87	103
1249	2014-02-02	491	132
1250	2004-12-09	463	16
1251	2007-10-16	5	102
1252	2004-12-27	149	134
1253	2011-04-07	70	198
1254	2016-07-22	256	171
1255	2019-04-28	19	144
1256	2007-01-10	183	157
1257	2019-01-05	63	122
1258	2011-10-10	286	99
1259	2018-01-17	301	183
1260	2011-10-15	262	36
1261	2018-04-10	422	21
1262	2017-02-16	152	76
1263	2011-05-31	446	108
1264	2006-05-27	385	63
1265	2013-06-29	128	25
1266	2014-03-09	477	157
1267	2000-05-24	175	155
1268	2013-11-20	89	185
1269	2013-05-03	6	122
1270	2004-07-05	258	25
1271	2001-09-15	378	149
1272	2014-04-05	125	9
1273	2020-08-18	48	110
1274	2006-05-23	156	36
1275	2003-12-10	77	42
1276	2020-04-18	473	191
1277	2016-08-18	250	72
1278	2017-06-26	488	25
1279	2010-08-05	22	152
1280	2003-11-30	340	85
1281	2017-11-09	321	90
1282	2015-03-14	310	83
1283	2006-12-15	445	190
1284	2008-01-03	186	70
1285	2004-10-06	111	7
1286	2010-03-10	353	164
1287	2018-02-23	350	167
1288	2011-04-24	345	119
1289	2004-06-21	373	10
1290	2018-04-14	301	131
1291	2016-06-05	451	180
1292	2006-01-03	383	40
1293	2006-07-29	367	113
1294	2013-01-03	476	26
1295	2008-12-31	123	8
1296	2002-11-04	493	124
1297	2011-11-21	474	50
1298	2003-01-31	387	134
1299	2009-02-16	372	145
1300	2004-12-29	484	46
1301	2006-07-12	308	157
1302	2010-07-29	272	120
1303	2010-06-09	460	148
1304	2004-04-14	198	146
1305	2013-05-25	354	63
1306	2018-09-30	373	86
1307	2013-07-16	440	173
1308	2003-03-04	141	121
1309	2003-07-30	428	161
1310	2011-05-15	493	83
1311	2016-01-23	314	147
1312	2016-06-15	33	31
1313	2010-06-07	154	67
1314	2015-11-12	124	26
1315	2007-03-21	91	114
1316	2000-01-01	63	8
1317	2011-09-01	346	176
1318	2011-10-05	442	71
1319	2007-10-21	392	107
1320	2004-06-25	259	157
1321	2010-08-13	22	64
1322	2008-10-22	328	184
1323	2002-06-02	199	45
1324	2006-10-10	94	171
1325	2003-03-23	304	68
1326	2003-06-30	271	188
1327	2000-03-10	133	33
1328	2000-10-14	215	152
1329	2017-02-22	271	9
1330	2008-12-18	482	13
1331	2005-01-30	493	109
1332	2001-04-29	80	155
1333	2012-04-29	234	105
1334	2010-12-27	445	160
1335	2015-02-12	10	98
1336	2010-02-18	190	102
1337	2007-03-18	123	115
1338	2001-03-19	241	196
1339	2020-06-27	469	4
1340	2011-05-04	165	195
1341	2010-06-05	484	173
1342	2002-11-30	30	29
1343	2005-07-20	46	9
1344	2019-05-20	470	183
1345	2008-07-14	223	113
1346	2010-04-30	356	80
1347	2011-03-11	257	172
1348	2011-12-28	303	148
1349	2012-10-04	437	104
1350	2010-12-08	128	21
1351	2003-11-19	48	2
1352	2020-10-08	405	30
1353	2010-04-14	207	105
1354	2015-04-20	85	118
1355	2012-01-13	6	86
1356	2000-12-02	368	31
1357	2017-11-10	379	147
1358	2016-08-10	384	148
1359	2019-11-23	194	17
1360	2004-11-14	455	143
1361	2016-10-31	237	68
1362	2020-08-24	62	62
1363	2003-05-11	492	194
1364	2009-10-11	409	184
1365	2017-10-22	91	137
1366	2012-10-02	121	184
1367	2016-07-09	236	118
1368	2010-08-06	311	89
1369	2012-03-19	47	63
1370	2011-03-28	243	64
1371	2009-09-12	257	53
1372	2005-10-17	188	63
1373	2007-02-08	266	27
1374	2020-11-12	288	110
1375	2002-11-29	198	44
1376	2009-10-24	292	17
1377	2007-03-23	169	194
1378	2005-03-28	178	180
1379	2014-08-10	248	24
1380	2020-03-10	274	111
1381	2007-05-08	489	97
1382	2019-05-08	21	125
1383	2016-06-06	88	58
1384	2018-06-25	363	23
1385	2010-06-22	127	71
1386	2005-02-20	478	60
1387	2001-05-15	10	10
1388	2005-04-26	101	175
1389	2004-01-15	122	174
1390	2015-08-18	261	129
1391	2001-08-17	250	81
1392	2012-05-29	242	19
1393	2000-11-28	10	177
1394	2009-01-14	465	156
1395	2014-09-26	134	48
1396	2019-11-11	17	189
1397	2012-03-26	82	129
1398	2017-06-10	472	97
1399	2019-04-30	119	65
1400	2007-12-25	172	21
1401	2005-07-25	475	149
1402	2018-07-28	133	84
1403	2017-12-31	292	1
1404	2002-07-06	459	138
1405	2009-11-30	107	60
1406	2020-11-11	148	136
1407	2006-04-30	265	156
1408	2001-06-29	78	19
1409	2013-07-16	341	116
1410	2006-03-27	152	81
1411	2017-12-28	293	73
1412	2016-11-28	51	88
1413	2008-03-06	246	175
1414	2011-11-10	415	200
1415	2012-05-23	235	122
1416	2011-12-09	446	122
1417	2008-07-21	64	62
1418	2019-12-06	298	14
1419	2011-10-28	244	153
1420	2007-10-24	9	46
1421	2007-09-17	428	175
1422	2004-06-03	160	8
1423	2019-07-10	324	166
1424	2015-05-12	387	44
1425	2008-06-24	6	92
1426	2020-01-07	298	114
1427	2007-06-18	500	197
1428	2003-09-23	381	149
1429	2016-02-18	70	108
1430	2017-08-05	239	1
1431	2007-09-06	46	162
1432	2005-02-26	475	149
1433	2005-09-19	51	181
1434	2015-03-13	198	153
1435	2018-06-26	240	196
1436	2005-07-09	287	98
1437	2012-02-24	360	136
1438	2003-11-30	453	21
1439	2012-06-13	171	103
1440	2018-11-27	67	147
1441	2001-05-31	222	195
1442	2018-12-20	19	135
1443	2001-07-28	107	101
1444	2002-09-16	405	196
1445	2020-08-16	408	30
1446	2020-02-09	93	73
1447	2009-04-29	358	3
1448	2019-08-19	449	6
1449	2016-09-28	93	162
1450	2004-07-28	50	96
1451	2004-07-31	484	109
1452	2018-06-12	140	30
1453	2005-12-25	149	67
1454	2012-01-25	486	130
1455	2010-08-07	5	166
1456	2007-07-30	265	132
1457	2011-10-31	414	36
1458	2020-07-27	291	1
1459	2000-04-15	110	187
1460	2005-06-07	467	199
1461	2010-08-01	454	163
1462	2019-05-24	105	8
1463	2010-01-12	79	88
1464	2008-11-09	326	129
1465	2005-01-25	492	118
1466	2004-07-05	145	133
1467	2020-02-12	350	101
1468	2008-03-28	123	52
1469	2003-12-22	63	123
1470	2014-02-11	414	83
1471	2003-10-16	320	198
1472	2012-08-23	500	92
1473	2018-10-25	487	179
1474	2013-05-09	117	80
1475	2010-06-14	74	36
1476	2004-10-10	413	135
1477	2006-02-14	75	171
1478	2000-04-18	262	117
1479	2006-05-05	308	190
1480	2017-09-05	27	38
1481	2007-10-22	421	36
1482	2019-08-02	394	116
1483	2015-05-10	209	97
1484	2020-11-29	25	181
1485	2003-02-09	329	109
1486	2019-09-04	260	29
1487	2006-04-08	51	147
1488	2018-04-17	227	179
1489	2015-09-21	313	55
1490	2002-03-02	276	167
1491	2013-10-11	169	34
1492	2004-06-19	397	189
1493	2018-10-20	176	70
1494	2007-07-28	191	40
1495	2001-03-15	342	27
1496	2017-03-29	180	196
1497	2012-10-03	482	136
1498	2016-10-14	105	95
1499	2004-08-05	483	70
1500	2000-01-23	268	96
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
836	Microsoft Surface Pro 4 Type Cover with Fingerprint ID	Microsoft	Microsoft	2015-11-13	957
837	Boytone - 2500W 2.1-Ch. Home Theater System - Black Diamond	Boytone	Boytone	2015-05-18	2760
838	Sanus VLF410B1 10-Inch Super Slim Full-Motion Mount for 37 - 84 Inches TV's	Sanus		2015-04-13	760
839	Ultimate Ears MEGABLAST Portable Wi-Fi/Bluetooth Speaker with hands-free Amazon Alexa voice control (waterproof) - Graphite Black	Ultimate Ears		2018-03-14	2820
840	Flipside 300 Backpack (Black)	Lowepro	Lowepro	2015-08-18	3667
841	Corsair CMSA8GX3M2A1066C7 Apple 8 GB Dual Channel Kit DDR3 1066 (PC3 8500) 204-Pin DDR3 Laptop SO-DIMM Memory 1.5V	Corsair		2017-07-18	1712
842	iHome Rechargeable Splash Proof Stereo Bluetooth Speaker - Black (IBT33BC)	Sdi Technologies, Inc.	iHome	2016-11-07	4103
843	Verizon MiFi 6620L Jetpack 4G LTE Mobile Hotspot (Verizon Wireless)	Verizon Wireless	Novatel	2015-10-20	4525
844	JVC KD-X320BTS Apple iPod and Android Digital Media Receiver with Bluetooth	JVC		2015-07-06	227
845	JBL - 6" x 8" 2-Way Coaxial Car Speakers with Polypropylene Cones (Pair) - Black	JBL		2015-09-20	4603
846	Lenovo - AC Adapter for Select Lenovo Yoga Laptops - Black	Lenovo	Lenovo Idea	2015-10-16	3804
847	SiriusXM SXEZR1V1 XM Onyx EZR Satellite Radio Receiver with Vehicle Kit	Siriusxm	Siriusxm	2017-06-22	1467
848	PNY Anarchy 16GB Kit (2x8GB) DDR4 2400MHz (PC4-19200) CL15 Desktop Memory (BLUE) - MD16GK2D4240015AB	Pny		2016-03-11	1475
849	Slingbox M2	Sling Media	Slingbox	2015-09-30	722
850	Sony SRSHG1/BLK Hi-Res Wireless Speaker- Charcoal black	Sony	Sony	2016-07-07	744
851	Midland Weather Alert Radio, 1.0 CT	Midland	Midland	2015-09-20	924
852	Sony Mini Digital Video Cassettes - DVC - 1 Hour	Sony	Sony	2015-11-16	4425
853	SRS-ZR7 Wireless Speaker	Sony		2016-06-11	3984
854	Toshiba - 3TB Internal Serial ATA III Hard Drive for Desktops	Toshiba		2017-07-25	1539
855	Power Acoustik - Gothic Series 10" Dual-Voice-Coil 2-Ohm Subwoofer - Black	Power Acoustik		2015-12-02	2360
856	The Rebel BT On-Ear Wireless Bluetooth Headphones (Black)	House of Marley	House of Marley	2016-08-02	2627
857	CRX-322 CD Receiver	Yamaha	Yamaha	2015-08-22	4806
858	DreamWave - Tremor Portable Bluetooth Speaker - Green,Black	DreamWave		2015-10-17	2898
859	Alpine	Glengery	Glengery	2014-11-20	1761
860	XPS 8920 Tower Desktop Computer	Dell		2017-05-22	1964
861	Air-Fi Runaway AF32 Stereo Bluetooth Wireless Headphones with Hidden Microphone (White)	MEE audio		2015-08-18	1943
862	SAMSUNG 40'' Class FHD (1080P) Smart LED TV (UN40M5300)	Samsung		2017-08-21	3832
863	NS-SP1800BL 5.1-Channel Home Theater System (Black)	Yamaha	YAMAHA	2015-07-03	2782
864	Acoustimass 6 Series V Home Theater Speaker System (Black)	Bose	Bose	2015-05-11	1422
865	Logitech G403 Wireless Gaming Mouse with High Performance Gaming Sensor	Logitech		2017-03-06	2884
866	Sony MEXM100BT 160W RMS Marine CD Receiver with Bluetooth (Black) and SiriusXM Ready	Sony	Sony	2016-05-31	2650
867	Sony SRSXB30/BLK XB30 Portable Wireless Speaker with Bluetooth	Sony		2017-03-27	807
868	Sony LBT-GPX555 Mini-System with Bluetooth and NFC	Sony	Sony	2015-10-23	2212
869	NS-IW480CWH In-Ceiling 8 Natural Sound Three-Way Speaker System (Pair)	Yamaha	Yamaha	2014-10-29	4581
870	Motorola Wi-Fi Pet Video Camera	Motorola	Motorola	2015-05-11	2771
871	AW6500 All-Weather Outdoor Speaker (White, Single)	Definitive Technology	5 Years	2015-07-06	3254
872	Alpine - 6-1/2" 2-Way Coaxial Car Speakers with Polypropylene Cones (Pair) - Black	Alpine		2015-11-09	620
873	Travel RockStar 3-in-1 2A USB and Dual-Outlet Wall Charger with Internal 3000mAh Battery Pack	Belkin	Belkin	2015-11-16	3686
874	Bowers & Wilkins P7 Wired Over Ear Headphones	Bowers & Wilkins		2015-09-11	3653
875	Everest Elite 700 Around-Ear Wireless Headphones (White)	JBL	JBL	2016-05-30	4823
876	Clarity - Super-Loud Phone Ringer - White	CLARITY-TELECOM	Allround Software	2015-12-02	3850
877	House of Marley EM-DH003-PS TTR Noise-Cancelling Over-Ear Headphones (Black)	House of Marley		2015-09-11	2460
878	Toshiba Micro Component Speaker System: Wireless Bluetooth Speaker Sound System with FM	Toshiba		2017-07-31	3055
879	Kicker 41IK5BT2V2 Amphitheater High-Performance Audio System with Bluetooth, Black	Kicker		2015-09-11	2939
880	Prime Three-Way Center Channel Speaker (Premium Black Ash)	SVS		2015-07-13	1124
881	2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD	WD		2015-08-16	3697
882	Nighthawk AC1900 Dual-Band Wi-Fi USB Adapter	Netgear		2017-07-25	619
883	Samsung Universal 3100mAh Portable External Battery Charger - White	Samsung	SAMSUNG	2015-02-26	3600
884	Logitech 915-000224  Harmony Ultimate One 15-Device Universal Infrared Remote with Customizable Touch Screen Control - Black	Logitech	Logitech	2015-05-18	4221
885	Round LCD/Projector Ceiling Plate - Black	Peerless-AV	Peerless	2015-07-13	1218
886	A Taste for Honey (The Mycroft Holmes Mysteries Book 1)			2020-12-13	7
887	Kareem: Minority of One			2020-12-13	619
888	Mycroft Holmes			2020-12-13	0
889	Microsoft Surface Pro 3 (128 GB, Intel Core i5) (Renewed)			2020-12-13	1118
890	Writings on the Wall: Searching for a New Equality Beyond Black and White			2020-12-13	39
891	Mycroft and Sherlock: The Empty Birdcage			2020-12-13	0
892	Mycroft and Sherlock			2020-12-13	0
893	Mycroft Holmes and The Apocalypse Handbook			2020-12-13	2831
894	Sherlock Holmes and the Seven Deadly Sins Murders			2020-12-13	7
895	Black Profiles in Courage: A Legacy of African-American Achievement			2020-12-13	40
896	An Android Dog's Tale: A Sci-Fi Counter-Fantasy Novel			2020-12-13	0
897	Coach Wooden and Me: Our 50-Year Friendship On and Off the Court			2020-12-13	17
898	The Hundred Year Wait (Mycroft Holmes Adventures Book 1)			2020-12-13	0
899	On the Shoulders of Giants: My Journey Through the Harlem Renaissance			2020-12-13	16
900	$25 Xbox Gift Card [Digital Code]			2020-12-13	25
901	Dell USB 3.0 Ultra HD/4K Triple Display Docking Station (D3100), Black			2020-12-13	2138
902	Microsoft Office Home and Business 2019 Download 1 Person Compatible on Windows 10 and Apple MacOS			2020-12-13	4470
903	Shoeboy's Polish Application Brush/Premium Horsehair/Made in Germany/Gray			2020-12-13	19
904	Microsoft Surface Pro 7 – 12.3" Touch-Screen - 10th Gen Intel Core i5 - 8GB Memory - 128GB SSD (Latest Model) – Platinum with Black Type Cover			2020-12-13	2692
905	Microsoft 365 Personal | 12-Month Subscription, 1 person | Premium Office apps | 1TB OneDrive cloud storage | PC/Mac Download			2020-12-13	2802
906	Microsoft Sculpt Ergonomic Keyboard for Business (5KV-00001 )			2020-12-13	1597
907	Office Mac Home & Business 2011 Key Card (1PC/1User)			2020-12-13	916
908	Microsoft Surface Pro 7 – 12.3" Touch-Screen - Intel Core i7 - 16GB Memory - 256GB SSD (Latest Model) – Matte Black (VNX-00016)			2020-12-13	1124
909	Office 2019 Home and Business Boxed 1 PC or 1MAC Word Excel PowerPoint OneNote Outlook - USA Version			2020-12-13	3486
910	Microsoft Surface Dock (Pd9-00003),Black			2020-12-13	3799
911	Office Mac Home & Student 2011 - 1MAC/1User (Disc Version)			2020-12-13	4140
912	Microsoft Surface Arc Mouse – Ice Blue			2020-12-13	66
913	Microsoft Sculpt Ergonomic Desktop USB Port Keyboard and Mouse Combo (L5V-00002)			2020-12-13	1770
914	OLD VERSION Microsoft Office Home and Student 2010 Family Pack, 3PC (Disc Version)			2020-12-13	249
915	Office Suite 2019 USB Alternative to Office Home Student and Business Compatible with Word, Excel, PowerPoint for Windows 10 8 7 Vista XP by Apache OpenOffice ms Word ms Office (USB-Drive)			2020-12-13	4766
916	Perixx Periboard-612 Wireless Ergonomic Split Keyboard with Dual Mode 2.4G and Bluetooth Feature, Compatible with Windows 10 and Mac OS X System, Black, US English Layout			2020-12-13	79
917	Microsoft Office Home and Student 2016 for Mac Key Card w/ Norton Security Deluxe - 5 Devices [Key Card]			2020-12-13	789
918	Microsoft Ergonomic Keyboard (LXM-00001)			2020-12-13	2265
919	Logitech M557 Bluetooth Mouse – Wireless Mouse with 1 Year Battery Life, Side-to-Side Scrolling, and Right or Left Hand Use with Apple Mac or Microsoft Windows Computers and Laptops, Gray			2020-12-13	2211
920	Microsoft Modern Mobile Mouse (KTF-00013), Black			2020-12-13	4734
921	New Microsoft Surface Pro 7 Bundle: 10th Gen Intel Core i5-1035G4, 8GB RAM, 256GB SSD (Latest Model) – Platinum with Black Type Cover and Surface Pen, 12.3" Touch-Screen Pixelsense Display			2020-12-13	90
922	Microsoft Surface Precision Mouse, Light Grey			2020-12-13	79
923	Microsoft FHD-00001 Surface Arc Mouse Light Grey, Gray			2020-12-13	75
924	Microsoft RVF-00052 Arc Touch Mouse,Black			2020-12-13	41
925	10" Windows 10 Fusion5 Ultra Slim Windows Tablet PC- (4GB RAM, 128GB Storage, USB 3.0, Intel, 5MP and 2MP Cameras, Windows 10 S Tablet PC) (128GB)			2020-12-13	239
926	Microsoft WS3-00001 Surface Mouse			2020-12-13	42
927	Microsoft Surface Mobile Mouse (Silver) - KGY-00001			2020-12-13	3068
928	Microsoft  Surface Pro 6 (Intel Core i5, 8GB RAM, 128GB)			2020-12-13	739
929	Microsoft Surface Dock Compatible with Surface Book, Surface Pro 4, and Surface Pro 3 (Renewed)			2020-12-13	145
930	Perixx PERIDUO-606 Wireless Mini Ergonomic Keyboard with Portable Vertical Mouse, Adjustable Palm Rest Stand and Membrane Low Profile Keys, US English Layout			2020-12-13	59
931	Kensington Pro Fit Ergonomic Wireless Keyboard - Black (K75401US)			2020-12-13	49
932	Microsoft Sculpt Ergonomic Wireless Desktop Keyboard and Mouse - L5V-00001,Black			2020-12-13	2544
933	Surface Pro Dock for Surface Pro 4/Pro 5/Pro 6 USB Hub Docking Station with Gigabit Ethernet, 4K HDMI VGA DP Display, 3xUSB 3.0, Audio Out, USB C, SD/TF Card Slot Combo Dock Only for Surface Pro 4/5/6			2020-12-13	85
934	Minecraft Dungeons 3.25" Skeleton Necromancer and Wraith			2020-12-13	18
935	Minecraft: Java Edition for PC/Mac [Online Game Code]			2020-12-13	26
936	LEGO Minecraft The Pillager Outpost 21159 Awesome Action Figure Brick Building Playset for Kids Minecraft Gift, New 2020 (303 Pieces)			2020-12-13	689
937	Mattel Games UNO Minecraft Card Game, Now UNO fun includes the world of Minecraft, Multicolor, Basic Pack			2020-12-13	4
938	Minecraft: Epic Bases			2020-12-13	11
939	Minecraft Survival Pack			2020-12-13	14
940	Minecraft Starter Collection - PlayStation 4			2020-12-13	29
941	Minecraft Hot Wheels Character Vehicle 5-Pk Collector Set, 1:64 Scale Collectible Cars and Trucks for Play and Display, Gift for Kids Age 3 and Older			2020-12-13	23
943	Minecraft Toys Redstone Torch 12.6 Inch LED Lamp | USB Rechargeable for Nightlight, Costume Cosplay, Roleplay			2020-12-13	4471
944	Diary of a Minecraft Zombie Book 1: A Scare of A Dare			2020-12-13	5
945	Minecraft Carry Along Potion Plus Exclusive Mini Figure, Carrying Case for Mini Figures, Based on Video Game, Toys for Kids Age 6 and Up			2020-12-13	4
946	Minecraft Dungeons Hero Edition - Nintendo Switch			2020-12-13	1777
947	PACKGOUT STEM Toys Gifts for Boy Teen Remote Control Building Kits for Boy Girl Teen Gift 5/6/7 Year Old Boy Gifts Build Own Gift			2020-12-13	30
948	LEGO Star Wars Darth Vader's Castle 75251 Building Kit includes TIE Fighter, Darth Vader Minifigures, Bacta Tank and more (1,060 Pieces) - (Amazon Exclusive)			2020-12-13	116
949	Smack it Card Game for Kids			2020-12-13	8
950	Wrangler Authentics Men’s Classic Relaxed Fit Flex Jean			2020-12-13	25
951	Robe Factory LLC Minecraft Mini Mob 4-Piece Figure Mood Light Set | Battery Operated LED Lights			2020-12-13	1140
952	Minecraft Dungeons Hero Edition - PlayStation 4			2020-12-13	20
953	JINX Minecraft Pig Plush Stuffed Toy, Pink, 12" Long			2020-12-13	46
954	Jada Toys Nano METALFIGS Minecraft 20-Pack Wave 3, 1.65" Die-Cast Collectible Figures 31431			2020-12-13	40
955	The Official Minecraft Guide Collection 8 Books Box Set By Mojang (Ocean Survival, Farming, PVP Minigames, Enchantments & Potions, The Nether & The End, Redstone, Survival, Creative)			2020-12-13	4161
956	Mattel Minecraft Dungeons 3.25-in Figures 2-Pk Battle Figures, Adriene and Skeleton with Battle Accessories Age 6 and Older			2020-12-13	19
957	Minecraft (Nintendo Switch)			2020-12-13	42
958	ThinkGeek Minecraft Light-Up Wall Torch - Mounts To Your Wall - Officially Licensed Minecraft Collectible			2020-12-13	3892
959	Minecraft: The Island: An Official Minecraft Novel			2020-12-13	4437
960	Minecraft Comic Maker Multipack Attack Set with Evoker and Vexes, Based on Video Game, Toys for Girls and Boys Age 6 and Up			2020-12-13	7
961	Minecraft - Nintendo Switch			2020-12-13	2524
962	Minecraft Redstone Series 11 Build-A-Mini Figure Blind Box (Pack of 4)			2020-12-13	29
963	Red Light, Green Light, 1-2-3 - Card Game for Ages 5 and Up			2020-12-13	7
964	Box Buddies Monyamo - Pack of 12 Monster Paper Toy Cards			2020-12-13	8
965	Jada Toys Minecraft 20-Pack Wave 1 Nano METALFIGS 1.65" Die - Cast Figures, Multicolor (30125)			2020-12-13	39
966	Minecraft Boxer Briefs (3 Pack) Creeper Crew Underwear for Boys			2020-12-13	20
967	Minecraft: Guide Collection 4-Book Boxed Set: Exploration; Creative; Redstone; The Nether & the End			2020-12-13	4337
968	Minecraft Dungeons (Nintendo Switch)			2020-12-13	42
969	Minecraft Dungeons: DLC Season Pass - Xbox Series X [Digital Code]			2020-12-13	19
970	Portal Gun Mod for Minecraft PE			2020-12-13	2933
971	Ravensburger Minecraft: Builders & Biomes - Farmer's Market Expansion Strategy Board Game Ages 10 & Up - Amazon Exclusive			2020-12-13	19
972	Minecraft Grass Block Storage Cube Organizer | Minecraft Storage Cube | Grass Block From Minecraft Cubbies Storage Cubes | Organization Cubes | 15-Inch Square Bin With Lid			2020-12-13	3214
973	Songs Of War (Minecraft Animation)			2020-12-13	2215
974	Minecraft 3.25 Scale Mega Redstone Monstrosity			2020-12-13	24
975	Minecraft Dungeons Hero Edition - Xbox One			2020-12-13	1672
976	LEGO Minecraft The Polar Igloo 21142 Building Kit (278 Pieces) (Discontinued by Manufacturer)			2020-12-13	89
977	The Ultimate Unofficial Encyclopedia for Minecrafters: An A - Z Book of Tips and Tricks the Official Guides Don't Teach You			2020-12-13	4122
942	Minecraft		Anrew	2020-12-13	6
978	Minecraft Earth Boost Mini Figures 2-Pack NFC-Chip Toys, Earth Augmented Reality Mobile Game, Based on Video Game, Great for Playing, Trading, and Collecting, Adventure Toy for Boys and Girl			2020-12-13	4
979	Minecraft Boys' Creeper Button Down Shirt			2020-12-13	23
980	Minecraft Creeper Glitter Motion Light | 12-Inch LED Mood Light Battery Lamp			2020-12-13	4220
981	Minecraft Starter Collection - Xbox One			2020-12-13	2056
982	JINX Minecraft Steve Plush Stuffed Toy, Multi-Colored, 12" Tall			2020-12-13	44
983	Minecraft Transforming Sword/Pickaxe			2020-12-13	234
984	LEGO Minecraft The End Battle 21151 Ender Dragon Building Kit includes Dragon Slayer and Enderman Toy Figures for Dragon Fighting Adventures (222 Pieces)			2020-12-13	3897
985	LEGO Minecraft The Crafting Box 3.0 21161 Minecraft Brick Construction Toy and Minifigures, Castle and Farm Building Set, Great Gift for Minecraft Players Aged 8 and up, New 2020 (564 Pieces)			2020-12-13	3443
986	Minecraft Hardcore Gameplay - Dallas Gamer			2020-12-13	4851
987	Minecraft: The Shipwreck: An Official Minecraft Novel			2020-12-13	12
988	Houses Guide for Minecraft			2020-12-13	2377
\.


--
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Category_id_seq"', 2029, true);


--
-- Name: Client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Client_id_seq"', 301, true);


--
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_id_seq"', 1500, true);


--
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Product_id_seq"', 988, true);


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

