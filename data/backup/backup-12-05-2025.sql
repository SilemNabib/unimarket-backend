--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Debian 16.8-1.pgdg120+1)
-- Dumped by pg_dump version 16.8 (Ubuntu 16.8-1.pgdg24.04+1)

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
-- Data for Name: Banner; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Banner" VALUES ('00000000-0000-0000-0000-00000000000c', 'banner1.jpg', '2025-04-20');


--
-- Data for Name: Collaboration; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Collaboration" VALUES ('00000000-0000-0000-0000-000000000019', 'Promo Primavera', 'Descuento especial primavera', 50000);


--
-- Data for Name: CollaborationImage; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."CollaborationImage" VALUES ('00000000-0000-0000-0000-000000000021', 'collab.jpg', '00000000-0000-0000-0000-000000000019');


--
-- Data for Name: EntrepreneurshipCustomization; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."EntrepreneurshipCustomization" VALUES ('00000000-0000-0000-0000-000000000003', 'perfil.jpg', 'banner.jpg', '#FFFFFF', '#000000');


--
-- Data for Name: SubscriptionPlans; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."SubscriptionPlans" VALUES ('00000000-0000-0000-0000-000000000005', 'Plan Básico', 9.99, 'Descripción del plan básico', 'Acceso limitado, Soporte básico');


--
-- Data for Name: EntrepreneurshipSubscription; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."EntrepreneurshipSubscription" VALUES ('00000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000005', '2025-12-31 23:59:59', '2025-04-20 10:00:00');


--
-- Data for Name: EntrepreneurshipType; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."EntrepreneurshipType" VALUES (1, 'Digital');


--
-- Data for Name: University; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."University" VALUES ('00000000-0000-0000-0000-000000000001', 'ICESI', 'Universidad Icesi');


--
-- Data for Name: UserStatus; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."UserStatus" VALUES (1, 'Active');


--
-- Data for Name: Verification; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Verification" VALUES ('00000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000001', 'front.png', 'back.png', 'selfie.png', 'Pending', '2025-04-20 09:00:00');


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_roles VALUES ('df51ae03-5274-4f33-8245-0a3c3d8c73dd', 'Administrator', 'verified', '$t:admin_description', NULL);
INSERT INTO public.directus_roles VALUES ('11111111-1111-1111-1111-111111111111', 'Comprador', 'supervised_user_circle', 'Usuario con permisos para comprar productos', NULL);
INSERT INTO public.directus_roles VALUES ('22222222-2222-2222-2222-222222222222', 'Emprendedor', 'supervised_user_circle', 'Usuario con permisos para vender productos', NULL);


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_users VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Carlos Comprador', NULL, 'carlos@tienda.com', '$argon2i$v=19$m=16,t=2,p=1$Qk4zb1RuWDJCcVRpb2JoSw$SzyC3tGEP6swGBt0TvBkiw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '11111111-1111-1111-1111-111111111111', NULL, NULL, NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.directus_users VALUES ('b258fe3d-95a5-4722-9bba-a346c8675ff3', 'Andrés', 'Parra', 'andresdavidparra2002@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$6UzU4J8UE1xWBN5an3N0pQ$2hC2yn/d2Znfo260FPt4Ilk0u542QhuWfZlrKuwxTv4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '22222222-2222-2222-2222-222222222222', 'zoUF-wD86nyzwLv8QM8bZSsnt1suqfJ9', '2025-04-29 02:06:00.554+00', NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.directus_users VALUES ('82f7a95b-662f-413e-b7d8-235886483d61', NULL, NULL, 'silemnabib@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$n8jEsgd4DAVqmY/Wm8CCQQ$EOZszC0Bsg+srsm7YT3/cinaLlVId95CqWSNaZ/avm0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '11111111-1111-1111-1111-111111111111', NULL, '2025-04-27 04:18:16.623+00', NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.directus_users VALUES ('01d95619-7251-448a-9c16-10f7ac3eecd8', NULL, NULL, 'alejamantillac@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$DeLFYp8R31kmfJpYys/bgQ$H8Kk7Gmrfn44u6iGDDnB3lRFiPfJQfqr+i7hYte7Tiw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '11111111-1111-1111-1111-111111111111', NULL, '2025-04-29 02:06:29.46+00', NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.directus_users VALUES ('84b9bb4d-e46d-4903-8fba-83137905bbca', NULL, NULL, 'prueba55@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$yb7p+ZI2sJFLPQTtOrOlXg$gi2XGxAC7+63iD1eFjvTYty8xS23CPAPPpT64gScMTY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '11111111-1111-1111-1111-111111111111', NULL, '2025-04-29 02:07:35.157+00', NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.directus_users VALUES ('c21f0bbf-8122-4a4b-9958-f5f847ed5e75', NULL, NULL, 'alejoamu2@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$2QJ3czS4A61T2xPgKpbLOw$H1XhoDiWgOjO0VriORcT5LZf4qRAMeu0CbP/eMaPqrQ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '11111111-1111-1111-1111-111111111111', NULL, '2025-05-01 20:22:06.304+00', NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.directus_users VALUES ('d314f4b1-972f-4d9d-a95b-b058b25863a3', 'Admin', 'User', 'uniadmin@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$9/qtwyJk8zNunbhrobKbgg$pQc+ys1XtfXtsS/+I2hnJEXOGaSXIbaGyTTfaoOgVWM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'df51ae03-5274-4f33-8245-0a3c3d8c73dd', NULL, '2025-05-10 21:18:33.853+00', '/settings/data-model/user_profile', 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: user_profile; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.user_profile VALUES ('00000000-0000-0000-0000-000000000008', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'foto.jpg', '00000000-0000-0000-0000-000000000001', '12345678', 'C.C', 1, '2025-04-18 08:30:00', true, '00000000-0000-0000-0000-000000000006', 4.8, 4.5);


--
-- Data for Name: Entrepreneurship; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Entrepreneurship" VALUES ('00000000-0000-0000-0000-000000000007', 'Emarket', 'Compra y vende en la uni', 'Plataforma de compraventa entre estudiantes', '2025-04-19 12:00:00', '00000000-0000-0000-0000-000000000003', 'info@emarket.com', '1234567890', '00000000-0000-0000-0000-000000000004', 'active', 1, 1, '00000000-0000-0000-0000-000000000008');


--
-- Data for Name: CollaborationMembers; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."CollaborationMembers" VALUES ('00000000-0000-0000-0000-000000000020', '00000000-0000-0000-0000-000000000019', '00000000-0000-0000-0000-000000000007', '2025-04-21 09:00:00');


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Product" VALUES ('00000000-0000-0000-0000-00000000000e', '00000000-0000-0000-0000-000000000007', 'Camiseta', 'Camiseta universitaria', 20000, 100, 10);


--
-- Data for Name: CollaborationProducts; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."CollaborationProducts" VALUES ('00000000-0000-0000-0000-000000000022', 10, '00000000-0000-0000-0000-000000000019', '00000000-0000-0000-0000-00000000000e');


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Order" VALUES ('00000000-0000-0000-0000-000000000012', '00000000-0000-0000-0000-000000000008', '00000000-0000-0000-0000-000000000007', '2025-04-20 15:30:00', 'Pending', 40000, 5000, 35000);


--
-- Data for Name: PartnerRol; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."PartnerRol" VALUES (1, 'Co‑founder');


--
-- Data for Name: Partner; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Partner" VALUES ('00000000-0000-0000-0000-000000000009', '00000000-0000-0000-0000-000000000008', '00000000-0000-0000-0000-000000000007', 1, 5, 'Socio fundador');


--
-- Data for Name: Delivery; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Delivery" VALUES ('00000000-0000-0000-0000-000000000016', 'Delivery', 'Calle 123 #45-67', '00000000-0000-0000-0000-000000000012', '00000000-0000-0000-0000-000000000009');


--
-- Data for Name: DeliveryStatus; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."DeliveryStatus" VALUES ('00000000-0000-0000-0000-00000000000b', 'Shipped');


--
-- Data for Name: DeliveryStatusLog; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."DeliveryStatusLog" VALUES ('00000000-0000-0000-0000-000000000017', '00000000-0000-0000-0000-000000000016', '00000000-0000-0000-0000-00000000000b', '00000000-0000-0000-0000-000000000008', '2025-04-20 17:00:00');


--
-- Data for Name: Tags; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Tags" VALUES ('00000000-0000-0000-0000-000000000002', 'Tecnología');


--
-- Data for Name: Entrepreneurship_Tags; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Entrepreneurship_Tags" VALUES ('00000000-0000-0000-0000-000000000007', '00000000-0000-0000-0000-000000000002');


--
-- Data for Name: NotificationType; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."NotificationType" VALUES (1, 'General');


--
-- Data for Name: Notification; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Notification" VALUES ('00000000-0000-0000-0000-00000000000d', '00000000-0000-0000-0000-000000000008', 1, 'Bienvenida', '¡Bienvenido a Emarket!');


--
-- Data for Name: OrderDetail; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."OrderDetail" VALUES ('00000000-0000-0000-0000-000000000013', '00000000-0000-0000-0000-000000000012', '00000000-0000-0000-0000-00000000000e', 2, 20000);


--
-- Data for Name: PaymentMethod; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."PaymentMethod" VALUES ('00000000-0000-0000-0000-00000000000a', 'Tarjeta');


--
-- Data for Name: Payment; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Payment" VALUES ('00000000-0000-0000-0000-000000000014', '00000000-0000-0000-0000-000000000012', '00000000-0000-0000-0000-00000000000a', 'Confirmed', '2025-04-20 16:00:00', '2025-04-20 15:45:00');


--
-- Data for Name: PaymentEvidence; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."PaymentEvidence" VALUES ('00000000-0000-0000-0000-000000000015', '00000000-0000-0000-0000-000000000014', 'evidence.jpg', 'Comprobante de pago', '2025-04-20 16:05:00');


--
-- Data for Name: ProductVariant; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."ProductVariant" VALUES ('00000000-0000-0000-0000-00000000000f', '00000000-0000-0000-0000-00000000000e', 'Talla M', 50);


--
-- Data for Name: ProductImage; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."ProductImage" VALUES ('00000000-0000-0000-0000-000000000010', 'camiseta_m.jpg', '00000000-0000-0000-0000-00000000000f');


--
-- Data for Name: ProductSpecification; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."ProductSpecification" VALUES ('00000000-0000-0000-0000-000000000011', '00000000-0000-0000-0000-00000000000e', 'Material', 'Algodón');


--
-- Data for Name: Review; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Review" VALUES ('00000000-0000-0000-0000-000000000018', '00000000-0000-0000-0000-000000000008', '00000000-0000-0000-0000-00000000000e', 5, 'Excelente producto', '2025-04-21 10:00:00');


--
-- Data for Name: SocialNetWork; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."SocialNetWork" VALUES (1, 'Instagram', 'https://instagram.com/emarket');


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_policies VALUES ('abf8a154-5b1c-4a46-ac9c-7300570f4f17', '$t:public_label', 'public', '$t:public_description', NULL, false, false, false);
INSERT INTO public.directus_policies VALUES ('f0327c5b-3ef6-45a7-af2f-6c8f58680374', 'Administrator', 'verified', '$t:admin_description', NULL, false, true, true);
INSERT INTO public.directus_policies VALUES ('9cbbd46e-58be-40ca-8fde-e5bb6b15b966', 'shopper', 'badge', NULL, NULL, false, false, false);


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_access VALUES ('e38e0404-07af-4ca1-bf13-4a9fa354094d', NULL, NULL, 'abf8a154-5b1c-4a46-ac9c-7300570f4f17', 1);
INSERT INTO public.directus_access VALUES ('f846457d-05fd-4eb3-a70a-40f33c3c0c4f', 'df51ae03-5274-4f33-8245-0a3c3d8c73dd', NULL, 'f0327c5b-3ef6-45a7-af2f-6c8f58680374', NULL);


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_activity VALUES (1, 'login', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-22 04:10:56.525+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_users', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', 'http://34.138.186.57');
INSERT INTO public.directus_activity VALUES (2, 'login', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-23 15:21:50.192+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_users', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (3, 'login', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-26 02:23:03.269+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_users', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (4, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-26 02:30:34.641+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_settings', '1', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (5, 'delete', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-26 02:44:09.618+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_users', 'ef5f946c-e8c1-46d3-9714-2e215e2a8b4b', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (6, 'delete', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-26 02:54:00.531+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_users', '7ef13226-21c8-4079-8dc7-a6dddf18909f', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (7, 'update', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-26 02:55:59.481+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_settings', '1', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (8, 'delete', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-26 02:56:04.934+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_users', '208019b3-35c5-4c17-bee2-1d3cb04e22bc', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (9, 'login', 'd78c255b-0766-4bc7-8921-f6a1583cefab', '2025-04-26 02:56:25.986+00', '10.142.0.6', 'PostmanRuntime/7.43.3', 'directus_users', 'd78c255b-0766-4bc7-8921-f6a1583cefab', NULL);
INSERT INTO public.directus_activity VALUES (10, 'login', 'd78c255b-0766-4bc7-8921-f6a1583cefab', '2025-04-26 13:29:13.369+00', '10.48.2.1', 'PostmanRuntime/7.43.3', 'directus_users', 'd78c255b-0766-4bc7-8921-f6a1583cefab', NULL);
INSERT INTO public.directus_activity VALUES (11, 'login', 'd78c255b-0766-4bc7-8921-f6a1583cefab', '2025-04-26 15:19:18.412+00', '10.48.2.1', 'PostmanRuntime/7.43.3', 'directus_users', 'd78c255b-0766-4bc7-8921-f6a1583cefab', NULL);
INSERT INTO public.directus_activity VALUES (12, 'delete', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-26 22:06:02.082+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_users', 'd78c255b-0766-4bc7-8921-f6a1583cefab', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (13, 'delete', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-26 22:06:19.822+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_users', '8f209e47-da1f-495f-8a38-25612df49abb', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (14, 'delete', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-26 22:06:45.051+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_users', 'feb52e35-2b32-4586-9613-a5b46bfa739a', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (15, 'update', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-26 22:15:31.925+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_settings', '1', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (16, 'update', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-26 22:16:00.395+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_settings', '1', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (17, 'delete', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-26 22:17:44.935+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_users', 'e1809924-a635-4b67-a91d-05383664c046', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (18, 'delete', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-26 22:20:47.187+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_users', 'a747bb22-9c48-4514-9373-71896aef9650', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (19, 'update', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-26 22:20:56.139+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_settings', '1', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (20, 'delete', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-26 23:05:22.735+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_users', '8ea01773-a824-4027-b4f3-d1d9da70ba93', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (21, 'login', '18dde81b-bc2b-4fdd-8d69-2256c729953f', '2025-04-26 23:05:32.789+00', '10.142.0.6', 'PostmanRuntime/7.43.3', 'directus_users', '18dde81b-bc2b-4fdd-8d69-2256c729953f', NULL);
INSERT INTO public.directus_activity VALUES (22, 'login', '18dde81b-bc2b-4fdd-8d69-2256c729953f', '2025-04-27 00:16:38.098+00', '10.142.0.6', 'PostmanRuntime/7.43.3', 'directus_users', '18dde81b-bc2b-4fdd-8d69-2256c729953f', NULL);
INSERT INTO public.directus_activity VALUES (23, 'login', '18dde81b-bc2b-4fdd-8d69-2256c729953f', '2025-04-27 00:34:30.844+00', '10.48.2.1', 'PostmanRuntime/7.43.3', 'directus_users', '18dde81b-bc2b-4fdd-8d69-2256c729953f', NULL);
INSERT INTO public.directus_activity VALUES (24, 'login', '18dde81b-bc2b-4fdd-8d69-2256c729953f', '2025-04-27 00:57:21.631+00', '10.142.0.5', 'PostmanRuntime/7.43.3', 'directus_users', '18dde81b-bc2b-4fdd-8d69-2256c729953f', NULL);
INSERT INTO public.directus_activity VALUES (25, 'delete', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-27 04:17:35.243+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_users', '18dde81b-bc2b-4fdd-8d69-2256c729953f', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (26, 'login', '82f7a95b-662f-413e-b7d8-235886483d61', '2025-04-27 04:18:16.58+00', '10.48.2.1', 'okhttp/4.12.0', 'directus_users', '82f7a95b-662f-413e-b7d8-235886483d61', NULL);
INSERT INTO public.directus_activity VALUES (27, 'login', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', '2025-04-28 05:33:40.956+00', '10.142.0.5', 'okhttp/4.12.0', 'directus_users', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', NULL);
INSERT INTO public.directus_activity VALUES (28, 'login', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', '2025-04-28 17:55:05.015+00', '10.48.2.1', 'okhttp/4.12.0', 'directus_users', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', NULL);
INSERT INTO public.directus_activity VALUES (29, 'login', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', '2025-04-28 18:58:46.737+00', '10.48.2.1', 'okhttp/4.12.0', 'directus_users', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', NULL);
INSERT INTO public.directus_activity VALUES (30, 'login', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', '2025-04-28 19:32:53.393+00', '10.48.2.1', 'okhttp/4.12.0', 'directus_users', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', NULL);
INSERT INTO public.directus_activity VALUES (31, 'login', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-28 19:39:58.371+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_users', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (32, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-28 19:40:54.107+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_collections', 'UserStatus', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (33, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-28 19:40:58.258+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_collections', 'Banner', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (34, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-28 19:41:00.546+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_collections', 'Collaboration', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (35, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-28 19:41:10.655+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_collections', 'CollaborationImage', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (36, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-28 19:41:13.402+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', 'directus_collections', 'CollaborationMembers', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (37, 'login', '01d95619-7251-448a-9c16-10f7ac3eecd8', '2025-04-28 20:14:53.169+00', '10.48.2.1', 'okhttp/4.12.0', 'directus_users', '01d95619-7251-448a-9c16-10f7ac3eecd8', NULL);
INSERT INTO public.directus_activity VALUES (38, 'login', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', '2025-04-28 21:11:15.206+00', '10.48.2.1', 'okhttp/4.12.0', 'directus_users', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', NULL);
INSERT INTO public.directus_activity VALUES (39, 'login', '01d95619-7251-448a-9c16-10f7ac3eecd8', '2025-04-28 21:11:42.048+00', '10.48.2.1', 'okhttp/4.12.0', 'directus_users', '01d95619-7251-448a-9c16-10f7ac3eecd8', NULL);
INSERT INTO public.directus_activity VALUES (40, 'login', '01d95619-7251-448a-9c16-10f7ac3eecd8', '2025-04-28 21:47:09.156+00', '10.48.2.1', 'okhttp/4.12.0', 'directus_users', '01d95619-7251-448a-9c16-10f7ac3eecd8', NULL);
INSERT INTO public.directus_activity VALUES (41, 'login', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', '2025-04-29 01:22:15.177+00', '10.142.0.5', 'okhttp/4.12.0', 'directus_users', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', NULL);
INSERT INTO public.directus_activity VALUES (42, 'login', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', '2025-04-29 01:24:23.519+00', '10.142.0.5', 'okhttp/4.12.0', 'directus_users', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', NULL);
INSERT INTO public.directus_activity VALUES (43, 'login', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', '2025-04-29 02:06:00.511+00', '10.142.0.5', 'okhttp/4.12.0', 'directus_users', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', NULL);
INSERT INTO public.directus_activity VALUES (44, 'login', '01d95619-7251-448a-9c16-10f7ac3eecd8', '2025-04-29 02:06:29.415+00', '10.142.0.5', 'okhttp/4.12.0', 'directus_users', '01d95619-7251-448a-9c16-10f7ac3eecd8', NULL);
INSERT INTO public.directus_activity VALUES (45, 'login', '84b9bb4d-e46d-4903-8fba-83137905bbca', '2025-04-29 02:07:35.113+00', '10.48.2.1', 'okhttp/4.12.0', 'directus_users', '84b9bb4d-e46d-4903-8fba-83137905bbca', NULL);
INSERT INTO public.directus_activity VALUES (46, 'login', 'c21f0bbf-8122-4a4b-9958-f5f847ed5e75', '2025-05-01 20:22:06.253+00', '10.48.2.1', 'okhttp/4.12.0', 'directus_users', 'c21f0bbf-8122-4a4b-9958-f5f847ed5e75', NULL);
INSERT INTO public.directus_activity VALUES (47, 'login', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 20:55:58.154+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (48, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:04:16.134+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Entrepreneurship', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (49, 'update', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:07:28.04+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (50, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:07.593+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', 'fd2364d7-e864-46f9-8def-48968e4c3e36', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (51, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:07.965+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '3', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (52, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:08.046+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '4', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (53, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:08.111+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '5', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (54, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:08.175+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '6', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (55, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:08.24+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '7', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (56, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:08.305+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '8', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (57, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:08.372+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '9', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (58, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:08.437+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '10', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (59, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:08.506+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '11', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (60, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:08.571+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '12', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (61, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:08.641+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '13', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (62, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:08.706+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '14', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (63, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:08.777+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '15', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (64, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:08.844+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '16', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (65, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:08.911+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '17', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (66, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:08.975+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '18', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (67, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:09.038+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '19', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (68, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:09.103+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '20', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (69, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:09.168+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '21', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (70, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:09.234+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '22', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (71, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:09.301+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '23', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (72, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:09.366+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '24', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (73, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:09.429+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '25', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (74, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:09.495+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '26', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (75, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:09:09.562+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '27', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (76, 'delete', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:10:32.218+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', 'fd2364d7-e864-46f9-8def-48968e4c3e36', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (77, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:10:53.229+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '9cbbd46e-58be-40ca-8fde-e5bb6b15b966', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (78, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:29.58+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', 'dd502345-fabe-419c-8d9a-b5377a7ca07f', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (79, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:30.007+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '28', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (80, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:30.071+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '29', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (81, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:30.136+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '30', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (82, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:30.2+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '31', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (83, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:30.264+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '32', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (84, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:30.331+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '33', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (85, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:30.395+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '34', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (86, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:30.458+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '35', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (87, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:30.522+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '36', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (88, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:30.59+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '37', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (89, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:30.654+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '38', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (90, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:30.72+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '39', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (91, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:30.796+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '40', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (92, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:30.859+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '41', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (93, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:30.923+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '42', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (94, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:30.987+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '43', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (95, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:31.051+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '44', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (96, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:31.117+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '45', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (97, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:31.181+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '46', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (98, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:31.245+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '47', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (99, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:31.309+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '48', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (100, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:31.375+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '49', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (101, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:31.442+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '50', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (102, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:31.511+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '51', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (103, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:31.575+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '52', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (104, 'delete', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:12:51.171+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', 'dd502345-fabe-419c-8d9a-b5377a7ca07f', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (105, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:14:10.744+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '53', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (106, 'update', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:14:10.812+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', 'abf8a154-5b1c-4a46-ac9c-7300570f4f17', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (107, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:14:33.738+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'CollaborationProducts', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (108, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:14:38.551+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Delivery', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (109, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:14:41.639+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'DeliveryStatus', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (110, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:14:46.217+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'DeliveryStatusLog', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (111, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:14:50.126+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'EntrepreneurshipCustomization', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (112, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:14:53.62+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'EntrepreneurshipSubscription', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (113, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:14:57.191+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'user_profile', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (114, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:15:00.826+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Verification', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (115, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:15:04.932+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'University', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (116, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:15:08.143+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Tags', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (117, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:15:11.567+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'SubscriptionPlans', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (118, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:15:17.095+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'SocialNetWork', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (119, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:15:22.891+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Review', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (120, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:15:29.446+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'ProductVariant', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (121, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:15:38.023+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'EntrepreneurshipType', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (122, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:15:45.351+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Entrepreneurship_Tags', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (123, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:15:49.201+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Partner', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (124, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:15:54.672+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Payment', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (125, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:15:58.114+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'PartnerRol', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (126, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:16:01.087+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'OrderDetail', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (127, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:16:03.807+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Order', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (128, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:16:07.039+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'PaymentEvidence', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (129, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:16:10.048+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'NotificationType', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (130, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:16:12.926+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Notification', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (131, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:16:16.607+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'PaymentMethod', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (132, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:16:19.869+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Product', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (133, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:16:23.082+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'ProductImage', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (134, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:16:25.876+00', '10.48.2.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'ProductSpecification', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (135, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:19:02.268+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '1', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (136, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:19:21.766+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '2', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (137, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:19:26.2+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '3', 'http://35.237.238.109');
INSERT INTO public.directus_activity VALUES (138, 'create', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:19:29.314+00', '10.142.0.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '4', 'http://35.237.238.109');


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_collections VALUES ('UserStatus', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Banner', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Collaboration', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('CollaborationImage', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('CollaborationMembers', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Entrepreneurship', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('CollaborationProducts', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Delivery', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('DeliveryStatus', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('DeliveryStatusLog', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('EntrepreneurshipCustomization', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('EntrepreneurshipSubscription', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('user_profile', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Verification', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('University', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Tags', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('SubscriptionPlans', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('SocialNetWork', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Review', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('ProductVariant', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('EntrepreneurshipType', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Entrepreneurship_Tags', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Partner', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Payment', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('PartnerRol', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('OrderDetail', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Order', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('PaymentEvidence', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('NotificationType', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Notification', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('PaymentMethod', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Product', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('ProductImage', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('ProductSpecification', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);


--
-- Data for Name: directus_comments; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_fields VALUES (1, 'user_profile', 'status', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (2, 'user_profile', 'id', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (3, 'user_profile', 'user_id', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (4, 'user_profile', 'profile_picture', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_migrations VALUES ('20201028A', 'Remove Collection Foreign Keys', '2025-04-22 04:06:44.698322+00');
INSERT INTO public.directus_migrations VALUES ('20201029A', 'Remove System Relations', '2025-04-22 04:06:44.761558+00');
INSERT INTO public.directus_migrations VALUES ('20201029B', 'Remove System Collections', '2025-04-22 04:06:44.824451+00');
INSERT INTO public.directus_migrations VALUES ('20201029C', 'Remove System Fields', '2025-04-22 04:06:44.888203+00');
INSERT INTO public.directus_migrations VALUES ('20201105A', 'Add Cascade System Relations', '2025-04-22 04:06:45.680147+00');
INSERT INTO public.directus_migrations VALUES ('20201105B', 'Change Webhook URL Type', '2025-04-22 04:06:45.805559+00');
INSERT INTO public.directus_migrations VALUES ('20210225A', 'Add Relations Sort Field', '2025-04-22 04:06:45.885002+00');
INSERT INTO public.directus_migrations VALUES ('20210304A', 'Remove Locked Fields', '2025-04-22 04:06:45.93233+00');
INSERT INTO public.directus_migrations VALUES ('20210312A', 'Webhooks Collections Text', '2025-04-22 04:06:46.025282+00');
INSERT INTO public.directus_migrations VALUES ('20210331A', 'Add Refresh Interval', '2025-04-22 04:06:46.071702+00');
INSERT INTO public.directus_migrations VALUES ('20210415A', 'Make Filesize Nullable', '2025-04-22 04:06:46.19499+00');
INSERT INTO public.directus_migrations VALUES ('20210416A', 'Add Collections Accountability', '2025-04-22 04:06:46.267185+00');
INSERT INTO public.directus_migrations VALUES ('20210422A', 'Remove Files Interface', '2025-04-22 04:06:46.317452+00');
INSERT INTO public.directus_migrations VALUES ('20210506A', 'Rename Interfaces', '2025-04-22 04:06:47.258897+00');
INSERT INTO public.directus_migrations VALUES ('20210510A', 'Restructure Relations', '2025-04-22 04:06:47.628403+00');
INSERT INTO public.directus_migrations VALUES ('20210518A', 'Add Foreign Key Constraints', '2025-04-22 04:06:47.702832+00');
INSERT INTO public.directus_migrations VALUES ('20210519A', 'Add System Fk Triggers', '2025-04-22 04:06:48.112397+00');
INSERT INTO public.directus_migrations VALUES ('20210521A', 'Add Collections Icon Color', '2025-04-22 04:06:48.161048+00');
INSERT INTO public.directus_migrations VALUES ('20210525A', 'Add Insights', '2025-04-22 04:06:48.34585+00');
INSERT INTO public.directus_migrations VALUES ('20210608A', 'Add Deep Clone Config', '2025-04-22 04:06:48.393706+00');
INSERT INTO public.directus_migrations VALUES ('20210626A', 'Change Filesize Bigint', '2025-04-22 04:06:48.517085+00');
INSERT INTO public.directus_migrations VALUES ('20210716A', 'Add Conditions to Fields', '2025-04-22 04:06:48.567141+00');
INSERT INTO public.directus_migrations VALUES ('20210721A', 'Add Default Folder', '2025-04-22 04:06:48.641967+00');
INSERT INTO public.directus_migrations VALUES ('20210802A', 'Replace Groups', '2025-04-22 04:06:48.712918+00');
INSERT INTO public.directus_migrations VALUES ('20210803A', 'Add Required to Fields', '2025-04-22 04:06:48.765172+00');
INSERT INTO public.directus_migrations VALUES ('20210805A', 'Update Groups', '2025-04-22 04:06:48.814729+00');
INSERT INTO public.directus_migrations VALUES ('20210805B', 'Change Image Metadata Structure', '2025-04-22 04:06:48.865613+00');
INSERT INTO public.directus_migrations VALUES ('20210811A', 'Add Geometry Config', '2025-04-22 04:06:48.912276+00');
INSERT INTO public.directus_migrations VALUES ('20210831A', 'Remove Limit Column', '2025-04-22 04:06:48.965067+00');
INSERT INTO public.directus_migrations VALUES ('20210903A', 'Add Auth Provider', '2025-04-22 04:06:49.18033+00');
INSERT INTO public.directus_migrations VALUES ('20210907A', 'Webhooks Collections Not Null', '2025-04-22 04:06:49.295752+00');
INSERT INTO public.directus_migrations VALUES ('20210910A', 'Move Module Setup', '2025-04-22 04:06:49.365448+00');
INSERT INTO public.directus_migrations VALUES ('20210920A', 'Webhooks URL Not Null', '2025-04-22 04:06:49.480057+00');
INSERT INTO public.directus_migrations VALUES ('20210924A', 'Add Collection Organization', '2025-04-22 04:06:49.548926+00');
INSERT INTO public.directus_migrations VALUES ('20210927A', 'Replace Fields Group', '2025-04-22 04:06:49.685067+00');
INSERT INTO public.directus_migrations VALUES ('20210927B', 'Replace M2M Interface', '2025-04-22 04:06:49.730312+00');
INSERT INTO public.directus_migrations VALUES ('20210929A', 'Rename Login Action', '2025-04-22 04:06:49.776201+00');
INSERT INTO public.directus_migrations VALUES ('20211007A', 'Update Presets', '2025-04-22 04:06:49.871835+00');
INSERT INTO public.directus_migrations VALUES ('20211009A', 'Add Auth Data', '2025-04-22 04:06:49.917352+00');
INSERT INTO public.directus_migrations VALUES ('20211016A', 'Add Webhook Headers', '2025-04-22 04:06:49.963608+00');
INSERT INTO public.directus_migrations VALUES ('20211103A', 'Set Unique to User Token', '2025-04-22 04:06:50.012803+00');
INSERT INTO public.directus_migrations VALUES ('20211103B', 'Update Special Geometry', '2025-04-22 04:06:50.059012+00');
INSERT INTO public.directus_migrations VALUES ('20211104A', 'Remove Collections Listing', '2025-04-22 04:06:50.105867+00');
INSERT INTO public.directus_migrations VALUES ('20211118A', 'Add Notifications', '2025-04-22 04:06:50.249292+00');
INSERT INTO public.directus_migrations VALUES ('20211211A', 'Add Shares', '2025-04-22 04:06:50.45626+00');
INSERT INTO public.directus_migrations VALUES ('20211230A', 'Add Project Descriptor', '2025-04-22 04:06:50.501712+00');
INSERT INTO public.directus_migrations VALUES ('20220303A', 'Remove Default Project Color', '2025-04-22 04:06:50.624815+00');
INSERT INTO public.directus_migrations VALUES ('20220308A', 'Add Bookmark Icon and Color', '2025-04-22 04:06:50.670886+00');
INSERT INTO public.directus_migrations VALUES ('20220314A', 'Add Translation Strings', '2025-04-22 04:06:50.718395+00');
INSERT INTO public.directus_migrations VALUES ('20220322A', 'Rename Field Typecast Flags', '2025-04-22 04:06:50.765654+00');
INSERT INTO public.directus_migrations VALUES ('20220323A', 'Add Field Validation', '2025-04-22 04:06:50.811434+00');
INSERT INTO public.directus_migrations VALUES ('20220325A', 'Fix Typecast Flags', '2025-04-22 04:06:50.860396+00');
INSERT INTO public.directus_migrations VALUES ('20220325B', 'Add Default Language', '2025-04-22 04:06:50.997153+00');
INSERT INTO public.directus_migrations VALUES ('20220402A', 'Remove Default Value Panel Icon', '2025-04-22 04:06:51.109481+00');
INSERT INTO public.directus_migrations VALUES ('20220429A', 'Add Flows', '2025-04-22 04:06:51.414985+00');
INSERT INTO public.directus_migrations VALUES ('20220429B', 'Add Color to Insights Icon', '2025-04-22 04:06:51.462003+00');
INSERT INTO public.directus_migrations VALUES ('20220429C', 'Drop Non Null From IP of Activity', '2025-04-22 04:06:51.50955+00');
INSERT INTO public.directus_migrations VALUES ('20220429D', 'Drop Non Null From Sender of Notifications', '2025-04-22 04:06:51.556411+00');
INSERT INTO public.directus_migrations VALUES ('20220614A', 'Rename Hook Trigger to Event', '2025-04-22 04:06:51.606273+00');
INSERT INTO public.directus_migrations VALUES ('20220801A', 'Update Notifications Timestamp Column', '2025-04-22 04:06:51.723774+00');
INSERT INTO public.directus_migrations VALUES ('20220802A', 'Add Custom Aspect Ratios', '2025-04-22 04:06:51.771779+00');
INSERT INTO public.directus_migrations VALUES ('20220826A', 'Add Origin to Accountability', '2025-04-22 04:06:51.845476+00');
INSERT INTO public.directus_migrations VALUES ('20230401A', 'Update Material Icons', '2025-04-22 04:06:51.987459+00');
INSERT INTO public.directus_migrations VALUES ('20230525A', 'Add Preview Settings', '2025-04-22 04:06:52.035213+00');
INSERT INTO public.directus_migrations VALUES ('20230526A', 'Migrate Translation Strings', '2025-04-22 04:06:52.145791+00');
INSERT INTO public.directus_migrations VALUES ('20230721A', 'Require Shares Fields', '2025-04-22 04:06:52.21847+00');
INSERT INTO public.directus_migrations VALUES ('20230823A', 'Add Content Versioning', '2025-04-22 04:06:52.42209+00');
INSERT INTO public.directus_migrations VALUES ('20230927A', 'Themes', '2025-04-22 04:06:52.7327+00');
INSERT INTO public.directus_migrations VALUES ('20231009A', 'Update CSV Fields to Text', '2025-04-22 04:06:52.781502+00');
INSERT INTO public.directus_migrations VALUES ('20231009B', 'Update Panel Options', '2025-04-22 04:06:52.868724+00');
INSERT INTO public.directus_migrations VALUES ('20231010A', 'Add Extensions', '2025-04-22 04:06:52.994863+00');
INSERT INTO public.directus_migrations VALUES ('20231215A', 'Add Focalpoints', '2025-04-22 04:06:53.040866+00');
INSERT INTO public.directus_migrations VALUES ('20240122A', 'Add Report URL Fields', '2025-04-22 04:06:53.092914+00');
INSERT INTO public.directus_migrations VALUES ('20240204A', 'Marketplace', '2025-04-22 04:06:53.542645+00');
INSERT INTO public.directus_migrations VALUES ('20240305A', 'Change Useragent Type', '2025-04-22 04:06:53.703347+00');
INSERT INTO public.directus_migrations VALUES ('20240311A', 'Deprecate Webhooks', '2025-04-22 04:06:53.861372+00');
INSERT INTO public.directus_migrations VALUES ('20240422A', 'Public Registration', '2025-04-22 04:06:53.93306+00');
INSERT INTO public.directus_migrations VALUES ('20240515A', 'Add Session Window', '2025-04-22 04:06:53.979324+00');
INSERT INTO public.directus_migrations VALUES ('20240701A', 'Add Tus Data', '2025-04-22 04:06:54.026482+00');
INSERT INTO public.directus_migrations VALUES ('20240716A', 'Update Files Date Fields', '2025-04-22 04:06:54.133981+00');
INSERT INTO public.directus_migrations VALUES ('20240806A', 'Permissions Policies', '2025-04-22 04:06:55.012011+00');
INSERT INTO public.directus_migrations VALUES ('20240817A', 'Update Icon Fields Length', '2025-04-22 04:06:55.577886+00');
INSERT INTO public.directus_migrations VALUES ('20240909A', 'Separate Comments', '2025-04-22 04:06:55.683146+00');
INSERT INTO public.directus_migrations VALUES ('20240909B', 'Consolidate Content Versioning', '2025-04-22 04:06:55.733695+00');
INSERT INTO public.directus_migrations VALUES ('20240924A', 'Migrate Legacy Comments', '2025-04-22 04:06:55.877579+00');
INSERT INTO public.directus_migrations VALUES ('20240924B', 'Populate Versioning Deltas', '2025-04-22 04:06:55.934745+00');
INSERT INTO public.directus_migrations VALUES ('20250224A', 'Visual Editor', '2025-04-22 04:06:56.029747+00');


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_permissions VALUES (1, 'directus_users', 'create', '{}', '{}', NULL, '*', 'abf8a154-5b1c-4a46-ac9c-7300570f4f17');
INSERT INTO public.directus_permissions VALUES (2, 'directus_roles', 'read', '{}', '{}', NULL, '*', 'abf8a154-5b1c-4a46-ac9c-7300570f4f17');
INSERT INTO public.directus_permissions VALUES (53, 'Banner', 'read', NULL, NULL, NULL, '*', 'abf8a154-5b1c-4a46-ac9c-7300570f4f17');


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_presets VALUES (2, NULL, 'd314f4b1-972f-4d9d-a95b-b058b25863a3', NULL, 'directus_files', NULL, 'cards', '{"cards":{"sort":["-uploaded_on"],"page":1}}', '{"cards":{"icon":"insert_drive_file","title":"{{ title }}","subtitle":"{{ type }} • {{ filesize }}","size":4,"imageFit":"crop"}}', NULL, NULL, 'bookmark', NULL);
INSERT INTO public.directus_presets VALUES (1, NULL, 'd314f4b1-972f-4d9d-a95b-b058b25863a3', NULL, 'directus_users', NULL, 'cards', '{"cards":{"sort":["email"],"page":1}}', '{"cards":{"icon":"account_circle","title":"{{ first_name }} {{ last_name }}","subtitle":"{{ email }}","size":4}}', NULL, NULL, 'bookmark', NULL);


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_revisions VALUES (1, 4, 'directus_settings', '1', '{"public_registration":true,"public_registration_role":"11111111-1111-1111-1111-111111111111"}', '{"public_registration":true,"public_registration_role":"11111111-1111-1111-1111-111111111111"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (2, 7, 'directus_settings', '1', '{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":true,"public_registration_verify_email":false,"public_registration_role":"11111111-1111-1111-1111-111111111111","public_registration_email_filter":null,"visual_editor_urls":null}', '{"public_registration_verify_email":false}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (3, 15, 'directus_settings', '1', '{"id":1,"project_name":"Directus","project_url":null,"project_color":"#4AACF7","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":true,"public_registration_verify_email":false,"public_registration_role":"11111111-1111-1111-1111-111111111111","public_registration_email_filter":null,"visual_editor_urls":null}', '{"project_color":"#4AACF7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (4, 16, 'directus_settings', '1', '{"id":1,"project_name":"Directus","project_url":null,"project_color":"#4AACF7","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":true,"public_registration_verify_email":true,"public_registration_role":"11111111-1111-1111-1111-111111111111","public_registration_email_filter":null,"visual_editor_urls":null}', '{"public_registration_verify_email":true}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (5, 19, 'directus_settings', '1', '{"id":1,"project_name":"Directus","project_url":null,"project_color":"#4AACF7","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":true,"public_registration_verify_email":false,"public_registration_role":"11111111-1111-1111-1111-111111111111","public_registration_email_filter":null,"visual_editor_urls":null}', '{"public_registration_verify_email":false}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (6, 32, 'directus_collections', 'UserStatus', '{"collection":"UserStatus"}', '{"collection":"UserStatus"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (7, 33, 'directus_collections', 'Banner', '{"collection":"Banner"}', '{"collection":"Banner"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (8, 34, 'directus_collections', 'Collaboration', '{"collection":"Collaboration"}', '{"collection":"Collaboration"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (9, 35, 'directus_collections', 'CollaborationImage', '{"collection":"CollaborationImage"}', '{"collection":"CollaborationImage"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (10, 36, 'directus_collections', 'CollaborationMembers', '{"collection":"CollaborationMembers"}', '{"collection":"CollaborationMembers"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (11, 48, 'directus_collections', 'Entrepreneurship', '{"collection":"Entrepreneurship"}', '{"collection":"Entrepreneurship"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (12, 49, 'directus_users', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', '{"id":"b258fe3d-95a5-4722-9bba-a346c8675ff3","first_name":"Andrés","last_name":"Parra","email":"andresdavidparra2002@gmail.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"22222222-2222-2222-2222-222222222222","token":"**********","last_access":"2025-04-29T02:06:00.554Z","last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"policies":[]}', '{"first_name":"Andrés","last_name":"Parra","role":"22222222-2222-2222-2222-222222222222","token":"**********"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (13, 50, 'directus_policies', 'fd2364d7-e864-46f9-8def-48968e4c3e36', '{"name":"Entrepreneur","admin_access":false,"app_access":true}', '{"name":"Entrepreneur","admin_access":false,"app_access":true}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (14, 51, 'directus_permissions', '3', '{"collection":"directus_comments","action":"read","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_comments","action":"read","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (15, 52, 'directus_permissions', '4', '{"collection":"directus_files","action":"create","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_files","action":"create","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (16, 53, 'directus_permissions', '5', '{"collection":"directus_files","action":"read","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_files","action":"read","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (17, 54, 'directus_permissions', '6', '{"collection":"directus_files","action":"update","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_files","action":"update","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (18, 55, 'directus_permissions', '7', '{"collection":"directus_files","action":"delete","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_files","action":"delete","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (19, 56, 'directus_permissions', '8', '{"collection":"directus_dashboards","action":"create","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_dashboards","action":"create","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (20, 57, 'directus_permissions', '9', '{"collection":"directus_dashboards","action":"read","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_dashboards","action":"read","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (21, 58, 'directus_permissions', '10', '{"collection":"directus_dashboards","action":"update","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_dashboards","action":"update","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (22, 59, 'directus_permissions', '11', '{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (23, 60, 'directus_permissions', '12', '{"collection":"directus_panels","action":"create","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_panels","action":"create","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (24, 61, 'directus_permissions', '13', '{"collection":"directus_panels","action":"read","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_panels","action":"read","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (25, 62, 'directus_permissions', '14', '{"collection":"directus_panels","action":"update","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_panels","action":"update","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (26, 63, 'directus_permissions', '15', '{"collection":"directus_panels","action":"delete","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_panels","action":"delete","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (27, 64, 'directus_permissions', '16', '{"collection":"directus_folders","action":"create","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_folders","action":"create","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (28, 65, 'directus_permissions', '17', '{"collection":"directus_folders","action":"read","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_folders","action":"read","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (29, 66, 'directus_permissions', '18', '{"collection":"directus_folders","action":"update","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_folders","action":"update","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (30, 67, 'directus_permissions', '19', '{"collection":"directus_folders","action":"delete","permissions":{},"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_folders","action":"delete","permissions":{},"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (31, 68, 'directus_permissions', '20', '{"collection":"directus_users","action":"read","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_users","action":"read","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (32, 69, 'directus_permissions', '21', '{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":["first_name","last_name","email","password","location","title","description","avatar","language","appearance","theme_light","theme_dark","theme_light_overrides","theme_dark_overrides","tfa_secret"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":["first_name","last_name","email","password","location","title","description","avatar","language","appearance","theme_light","theme_dark","theme_light_overrides","theme_dark_overrides","tfa_secret"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (33, 70, 'directus_permissions', '22', '{"collection":"directus_roles","action":"read","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_roles","action":"read","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (34, 71, 'directus_permissions', '23', '{"collection":"directus_shares","action":"read","permissions":{"_or":[{"role":{"_eq":"$CURRENT_ROLE"}},{"role":{"_null":true}}]},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_shares","action":"read","permissions":{"_or":[{"role":{"_eq":"$CURRENT_ROLE"}},{"role":{"_null":true}}]},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (35, 72, 'directus_permissions', '24', '{"collection":"directus_shares","action":"create","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_shares","action":"create","permissions":{},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (36, 73, 'directus_permissions', '25', '{"collection":"directus_shares","action":"update","permissions":{"user_created":{"_eq":"$CURRENT_USER"}},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_shares","action":"update","permissions":{"user_created":{"_eq":"$CURRENT_USER"}},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (37, 74, 'directus_permissions', '26', '{"collection":"directus_shares","action":"delete","permissions":{"user_created":{"_eq":"$CURRENT_USER"}},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_shares","action":"delete","permissions":{"user_created":{"_eq":"$CURRENT_USER"}},"fields":["*"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (38, 75, 'directus_permissions', '27', '{"collection":"directus_flows","action":"read","permissions":{"trigger":{"_eq":"manual"}},"fields":["id","status","name","icon","color","options","trigger"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', '{"collection":"directus_flows","action":"read","permissions":{"trigger":{"_eq":"manual"}},"fields":["id","status","name","icon","color","options","trigger"],"policy":"fd2364d7-e864-46f9-8def-48968e4c3e36"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (39, 77, 'directus_policies', '9cbbd46e-58be-40ca-8fde-e5bb6b15b966', '{"name":"shopper","admin_access":false,"app_access":false}', '{"name":"shopper","admin_access":false,"app_access":false}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (40, 78, 'directus_policies', 'dd502345-fabe-419c-8d9a-b5377a7ca07f', '{"name":"user","admin_access":false,"app_access":true}', '{"name":"user","admin_access":false,"app_access":true}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (41, 79, 'directus_permissions', '28', '{"collection":"directus_comments","action":"read","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_comments","action":"read","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (42, 80, 'directus_permissions', '29', '{"collection":"directus_files","action":"create","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_files","action":"create","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (43, 81, 'directus_permissions', '30', '{"collection":"directus_files","action":"read","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_files","action":"read","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (44, 82, 'directus_permissions', '31', '{"collection":"directus_files","action":"update","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_files","action":"update","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (45, 83, 'directus_permissions', '32', '{"collection":"directus_files","action":"delete","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_files","action":"delete","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (46, 84, 'directus_permissions', '33', '{"collection":"directus_dashboards","action":"create","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_dashboards","action":"create","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (47, 85, 'directus_permissions', '34', '{"collection":"directus_dashboards","action":"read","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_dashboards","action":"read","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (48, 86, 'directus_permissions', '35', '{"collection":"directus_dashboards","action":"update","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_dashboards","action":"update","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (49, 87, 'directus_permissions', '36', '{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_dashboards","action":"delete","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (50, 88, 'directus_permissions', '37', '{"collection":"directus_panels","action":"create","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_panels","action":"create","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (51, 89, 'directus_permissions', '38', '{"collection":"directus_panels","action":"read","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_panels","action":"read","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (52, 90, 'directus_permissions', '39', '{"collection":"directus_panels","action":"update","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_panels","action":"update","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (53, 91, 'directus_permissions', '40', '{"collection":"directus_panels","action":"delete","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_panels","action":"delete","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (54, 92, 'directus_permissions', '41', '{"collection":"directus_folders","action":"create","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_folders","action":"create","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (55, 93, 'directus_permissions', '42', '{"collection":"directus_folders","action":"read","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_folders","action":"read","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (56, 94, 'directus_permissions', '43', '{"collection":"directus_folders","action":"update","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_folders","action":"update","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (57, 95, 'directus_permissions', '44', '{"collection":"directus_folders","action":"delete","permissions":{},"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_folders","action":"delete","permissions":{},"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (58, 96, 'directus_permissions', '45', '{"collection":"directus_users","action":"read","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_users","action":"read","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (59, 97, 'directus_permissions', '46', '{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":["first_name","last_name","email","password","location","title","description","avatar","language","appearance","theme_light","theme_dark","theme_light_overrides","theme_dark_overrides","tfa_secret"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_users","action":"update","permissions":{"id":{"_eq":"$CURRENT_USER"}},"fields":["first_name","last_name","email","password","location","title","description","avatar","language","appearance","theme_light","theme_dark","theme_light_overrides","theme_dark_overrides","tfa_secret"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (60, 98, 'directus_permissions', '47', '{"collection":"directus_roles","action":"read","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_roles","action":"read","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (61, 99, 'directus_permissions', '48', '{"collection":"directus_shares","action":"read","permissions":{"_or":[{"role":{"_eq":"$CURRENT_ROLE"}},{"role":{"_null":true}}]},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_shares","action":"read","permissions":{"_or":[{"role":{"_eq":"$CURRENT_ROLE"}},{"role":{"_null":true}}]},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (62, 100, 'directus_permissions', '49', '{"collection":"directus_shares","action":"create","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_shares","action":"create","permissions":{},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (63, 101, 'directus_permissions', '50', '{"collection":"directus_shares","action":"update","permissions":{"user_created":{"_eq":"$CURRENT_USER"}},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_shares","action":"update","permissions":{"user_created":{"_eq":"$CURRENT_USER"}},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (64, 102, 'directus_permissions', '51', '{"collection":"directus_shares","action":"delete","permissions":{"user_created":{"_eq":"$CURRENT_USER"}},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_shares","action":"delete","permissions":{"user_created":{"_eq":"$CURRENT_USER"}},"fields":["*"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (65, 103, 'directus_permissions', '52', '{"collection":"directus_flows","action":"read","permissions":{"trigger":{"_eq":"manual"}},"fields":["id","status","name","icon","color","options","trigger"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', '{"collection":"directus_flows","action":"read","permissions":{"trigger":{"_eq":"manual"}},"fields":["id","status","name","icon","color","options","trigger"],"policy":"dd502345-fabe-419c-8d9a-b5377a7ca07f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (66, 105, 'directus_permissions', '53', '{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Banner","action":"read"}', '{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Banner","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (67, 107, 'directus_collections', 'CollaborationProducts', '{"collection":"CollaborationProducts"}', '{"collection":"CollaborationProducts"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (68, 108, 'directus_collections', 'Delivery', '{"collection":"Delivery"}', '{"collection":"Delivery"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (69, 109, 'directus_collections', 'DeliveryStatus', '{"collection":"DeliveryStatus"}', '{"collection":"DeliveryStatus"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (70, 110, 'directus_collections', 'DeliveryStatusLog', '{"collection":"DeliveryStatusLog"}', '{"collection":"DeliveryStatusLog"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (71, 111, 'directus_collections', 'EntrepreneurshipCustomization', '{"collection":"EntrepreneurshipCustomization"}', '{"collection":"EntrepreneurshipCustomization"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (72, 112, 'directus_collections', 'EntrepreneurshipSubscription', '{"collection":"EntrepreneurshipSubscription"}', '{"collection":"EntrepreneurshipSubscription"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (73, 113, 'directus_collections', 'user_profile', '{"collection":"user_profile"}', '{"collection":"user_profile"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (74, 114, 'directus_collections', 'Verification', '{"collection":"Verification"}', '{"collection":"Verification"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (75, 115, 'directus_collections', 'University', '{"collection":"University"}', '{"collection":"University"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (76, 116, 'directus_collections', 'Tags', '{"collection":"Tags"}', '{"collection":"Tags"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (77, 117, 'directus_collections', 'SubscriptionPlans', '{"collection":"SubscriptionPlans"}', '{"collection":"SubscriptionPlans"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (78, 118, 'directus_collections', 'SocialNetWork', '{"collection":"SocialNetWork"}', '{"collection":"SocialNetWork"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (79, 119, 'directus_collections', 'Review', '{"collection":"Review"}', '{"collection":"Review"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (80, 120, 'directus_collections', 'ProductVariant', '{"collection":"ProductVariant"}', '{"collection":"ProductVariant"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (81, 121, 'directus_collections', 'EntrepreneurshipType', '{"collection":"EntrepreneurshipType"}', '{"collection":"EntrepreneurshipType"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (82, 122, 'directus_collections', 'Entrepreneurship_Tags', '{"collection":"Entrepreneurship_Tags"}', '{"collection":"Entrepreneurship_Tags"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (83, 123, 'directus_collections', 'Partner', '{"collection":"Partner"}', '{"collection":"Partner"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (84, 124, 'directus_collections', 'Payment', '{"collection":"Payment"}', '{"collection":"Payment"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (85, 125, 'directus_collections', 'PartnerRol', '{"collection":"PartnerRol"}', '{"collection":"PartnerRol"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (86, 126, 'directus_collections', 'OrderDetail', '{"collection":"OrderDetail"}', '{"collection":"OrderDetail"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (87, 127, 'directus_collections', 'Order', '{"collection":"Order"}', '{"collection":"Order"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (88, 128, 'directus_collections', 'PaymentEvidence', '{"collection":"PaymentEvidence"}', '{"collection":"PaymentEvidence"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (89, 129, 'directus_collections', 'NotificationType', '{"collection":"NotificationType"}', '{"collection":"NotificationType"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (90, 130, 'directus_collections', 'Notification', '{"collection":"Notification"}', '{"collection":"Notification"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (91, 131, 'directus_collections', 'PaymentMethod', '{"collection":"PaymentMethod"}', '{"collection":"PaymentMethod"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (92, 132, 'directus_collections', 'Product', '{"collection":"Product"}', '{"collection":"Product"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (93, 133, 'directus_collections', 'ProductImage', '{"collection":"ProductImage"}', '{"collection":"ProductImage"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (94, 134, 'directus_collections', 'ProductSpecification', '{"collection":"ProductSpecification"}', '{"collection":"ProductSpecification"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (95, 135, 'directus_fields', '1', '{"special":null,"collection":"user_profile","field":"status"}', '{"special":null,"collection":"user_profile","field":"status"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (96, 136, 'directus_fields', '2', '{"special":["uuid"],"collection":"user_profile","field":"id"}', '{"special":["uuid"],"collection":"user_profile","field":"id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (97, 137, 'directus_fields', '3', '{"special":["uuid"],"collection":"user_profile","field":"user_id"}', '{"special":["uuid"],"collection":"user_profile","field":"user_id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (98, 138, 'directus_fields', '4', '{"special":null,"collection":"user_profile","field":"profile_picture"}', '{"special":null,"collection":"user_profile","field":"profile_picture"}', NULL, NULL);


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_sessions VALUES ('eG3ZdtDHyNxkjKfBoNCtIC_PhWKhHHgktY9EDfGbUWlS0AB160z7qxme4xfvqnY3', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-10 21:18:43.807+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.237.238.109', 'BMVoyiv0uLypuvx1eE79K9jcdrNQHAsSfkh4vS2XP3ltuTWH6j6-MyVMSvblmCZf');
INSERT INTO public.directus_sessions VALUES ('BMVoyiv0uLypuvx1eE79K9jcdrNQHAsSfkh4vS2XP3ltuTWH6j6-MyVMSvblmCZf', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-05-11 21:18:33.806+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.237.238.109', NULL);


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_settings VALUES (1, 'Directus', NULL, '#4AACF7', NULL, NULL, NULL, NULL, 25, NULL, 'all', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'en-US', NULL, NULL, 'auto', NULL, NULL, NULL, NULL, NULL, NULL, NULL, true, false, '11111111-1111-1111-1111-111111111111', NULL, NULL);


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Name: EntrepreneurshipType_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public."EntrepreneurshipType_id_seq"', 1, false);


--
-- Name: PartnerRol_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public."PartnerRol_id_seq"', 1, false);


--
-- Name: SocialNetWork_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public."SocialNetWork_id_seq"', 1, true);


--
-- Name: UserStatus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public."UserStatus_id_seq"', 1, false);


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 138, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 4, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 53, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 2, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 1, false);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 98, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

