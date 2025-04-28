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
INSERT INTO public.directus_users VALUES ('82f7a95b-662f-413e-b7d8-235886483d61', NULL, NULL, 'silemnabib@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$n8jEsgd4DAVqmY/Wm8CCQQ$EOZszC0Bsg+srsm7YT3/cinaLlVId95CqWSNaZ/avm0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '11111111-1111-1111-1111-111111111111', NULL, '2025-04-27 04:18:16.623+00', NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.directus_users VALUES ('d314f4b1-972f-4d9d-a95b-b058b25863a3', 'Admin', 'User', 'uniadmin@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$9/qtwyJk8zNunbhrobKbgg$pQc+ys1XtfXtsS/+I2hnJEXOGaSXIbaGyTTfaoOgVWM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 'df51ae03-5274-4f33-8245-0a3c3d8c73dd', NULL, '2025-04-27 18:10:28.817+00', '/users', 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.directus_users VALUES ('b258fe3d-95a5-4722-9bba-a346c8675ff3', NULL, NULL, 'andresdavidparra2002@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$6UzU4J8UE1xWBN5an3N0pQ$2hC2yn/d2Znfo260FPt4Ilk0u542QhuWfZlrKuwxTv4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '11111111-1111-1111-1111-111111111111', NULL, '2025-04-28 05:33:41+00', NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);


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


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: app_mov
--



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


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_sessions VALUES ('sifCIuO_k5Jl86KEk3vT2I4e8ZbbXgnyebMK_yz5M2nOx-r6AZrAqEkfll-ztlLG', '82f7a95b-662f-413e-b7d8-235886483d61', '2025-05-04 04:18:16.507+00', '10.48.2.1', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('5sgHUXwA7X7EPY8cFzArZG_Gt19mCasfWIAytgh4PlfhtTXNCLYgSPFinx34QwLg', 'd314f4b1-972f-4d9d-a95b-b058b25863a3', '2025-04-28 18:10:28.771+00', '10.142.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0', NULL, 'http://35.237.238.109', NULL);
INSERT INTO public.directus_sessions VALUES ('R9W705Fw2AMZrFIx3dpem_27kPazIPV7kmF0CDmagDkIpr1F8WEd1ca98nBOh9gm', 'b258fe3d-95a5-4722-9bba-a346c8675ff3', '2025-05-05 05:33:40.889+00', '10.142.0.5', 'okhttp/4.12.0', NULL, NULL, NULL);


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

SELECT pg_catalog.setval('public.directus_activity_id_seq', 27, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 1, false);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 2, true);


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

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 5, true);


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

