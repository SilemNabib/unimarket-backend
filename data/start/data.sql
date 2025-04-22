-- INSERTION OF DATA INTO DIRECTUS

-- Role creation
INSERT INTO directus_roles (id, name, icon, description, parent) VALUES
  ('11111111-1111-1111-1111-111111111111', 'Comprador', 'supervised_user_circle', 'Usuario con permisos para comprar productos', NULL),
  ('22222222-2222-2222-2222-222222222222', 'Emprendedor', 'supervised_user_circle', 'Usuario con permisos para vender productos', NULL);

INSERT INTO directus_permissions (
    collection,
    action,
    fields,
    policy,
    permissions,
    validation
) VALUES (
    'directus_users',
    'create',
    '*',
    (SELECT id FROM directus_policies WHERE name LIKE '%public_label%'),
    '{}',
    '{}'
);

-- Hacemos publico el acceso a listar los roles
INSERT INTO directus_permissions (
    collection,
    action,
    fields,
    policy,
    permissions,
    validation
) VALUES (
    'directus_roles',
    'read',
    '*',
    (SELECT id FROM directus_policies WHERE name LIKE '%public_label%'),
    '{}',
    '{}'
);

-- Creamos los usuarios para que puedan iniciar sesion
INSERT INTO directus_users (id, first_name, email, password, role, status)
VALUES
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Carlos Comprador', 'carlos@tienda.com', '$argon2i$v=19$m=16,t=2,p=1$Qk4zb1RuWDJCcVRpb2JoSw$SzyC3tGEP6swGBt0TvBkiw', 
    '11111111-1111-1111-1111-111111111111', 'active');

-- 1) EntrepreneurhipType
INSERT INTO "EntrepreneurshipType" ("id","name") 
VALUES (1, 'Digital');

-- 2) PartnerRol
INSERT INTO "PartnerRol" ("id","name") 
VALUES (1, 'Co‑founder');

-- 3) UserStatus
INSERT INTO "UserStatus" ("id","name") 
VALUES (1, 'Active');

-- 4) NotificationType
INSERT INTO "NotificationType" ("id","name") 
VALUES (1, 'General');

-- 5) SubscriptionPlans
INSERT INTO "SubscriptionPlans" ("id","name","price","description","benefits") 
VALUES (
  '00000000-0000-0000-0000-000000000005',
  'Plan Básico',
  9.99,
  'Descripción del plan básico',
  'Acceso limitado, Soporte básico'
);

-- 6) University
INSERT INTO "University" ("id","acronym","name") 
VALUES (
  '00000000-0000-0000-0000-000000000001',
  'ICESI',
  'Universidad Icesi'
);

-- 7) Tags
INSERT INTO "Tags" ("id","name") 
VALUES (
  '00000000-0000-0000-0000-000000000002',
  'Tecnología'
);

-- 8) EntrepreneurshipCustomization
INSERT INTO "EntrepreneurshipCustomization" ("id","profile_img","banner_img","color1","color2") 
VALUES (
  '00000000-0000-0000-0000-000000000003',
  'perfil.jpg',
  'banner.jpg',
  '#FFFFFF',
  '#000000'
);

-- 9) EntrepreneurshipSubscription
INSERT INTO "EntrepreneurshipSubscription" ("id","subscription_plan","cutoff_date","last_payment") 
VALUES (
  '00000000-0000-0000-0000-000000000004',
  '00000000-0000-0000-0000-000000000005',
  '2025-12-31 23:59:59',
  '2025-04-20 10:00:00'
);

-- 10) Verification
INSERT INTO "Verification" ("id","university","front_document","back_document","selfie_with_document","status","verification_date") 
VALUES (
  '00000000-0000-0000-0000-000000000006',
  '00000000-0000-0000-0000-000000000001',
  'front.png',
  'back.png',
  'selfie.png',
  'Pending',
  '2025-04-20 09:00:00'
);

-- 11) user_profile
INSERT INTO "user_profile" (
  "id","user_id","profile_picture","university","document","document_type",
  "status","registration_date","email_verification","verification",
  "user_rating","partner_rating"
) VALUES (
  '00000000-0000-0000-0000-000000000008',
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
  'foto.jpg',
  '00000000-0000-0000-0000-000000000001',
  '12345678',
  'C.C',
  1,
  '2025-04-18 08:30:00',
  TRUE,
  '00000000-0000-0000-0000-000000000006',
  4.8,
  4.5
);

-- 12) Entrepreneurship
INSERT INTO "Entrepreneurship" (
  "id","name","slogan","description","creation_date","customization",
  "email","phone","subscription","status","category","social_networks","user_founder"
) VALUES (
  '00000000-0000-0000-0000-000000000007',
  'Emarket',
  'Compra y vende en la uni',
  'Plataforma de compraventa entre estudiantes',
  '2025-04-19 12:00:00',
  '00000000-0000-0000-0000-000000000003',
  'info@emarket.com',
  '1234567890',
  '00000000-0000-0000-0000-000000000004',
  'active',
  1,
  1,
  '00000000-0000-0000-0000-000000000008'
);

-- 13) SocialNetWork
INSERT INTO "SocialNetWork" ("platform","url") 
VALUES ('Instagram','https://instagram.com/emarket');

-- 14) Partner
INSERT INTO "Partner" (
  "id","user_profile","entrepreneurship","partner_rol","rating","comment"
) VALUES (
  '00000000-0000-0000-0000-000000000009',
  '00000000-0000-0000-0000-000000000008',
  '00000000-0000-0000-0000-000000000007',
  1,
  5,
  'Socio fundador'
);

-- 15) Notification
INSERT INTO "Notification" ("id","user_profile","type","title","content") 
VALUES (
  '00000000-0000-0000-0000-00000000000D',
  '00000000-0000-0000-0000-000000000008',
  1,
  'Bienvenida',
  '¡Bienvenido a Emarket!'
);

-- 16) Product
INSERT INTO "Product" (
  "id","entrepreneurship","name","description","price","quantity","stock_alert"
) VALUES (
  '00000000-0000-0000-0000-00000000000E',
  '00000000-0000-0000-0000-000000000007',
  'Camiseta',
  'Camiseta universitaria',
  20000,
  100,
  10
);

-- 17) ProductVariant
INSERT INTO "ProductVariant" ("id","product","nombre","stock") 
VALUES (
  '00000000-0000-0000-0000-00000000000F',
  '00000000-0000-0000-0000-00000000000E',
  'Talla M',
  50
);

-- 18) ProductImage
INSERT INTO "ProductImage" ("id","image_url","product_variant") 
VALUES (
  '00000000-0000-0000-0000-000000000010',
  'camiseta_m.jpg',
  '00000000-0000-0000-0000-00000000000F'
);

-- 19) ProductSpecification
INSERT INTO "ProductSpecification" ("id","product","key","value") 
VALUES (
  '00000000-0000-0000-0000-000000000011',
  '00000000-0000-0000-0000-00000000000E',
  'Material',
  'Algodón'
);

-- 20) "Order"
INSERT INTO "Order" (
  "id","user_profile","entrepreneurship","date","status","subtotal","discount","total"
) VALUES (
  '00000000-0000-0000-0000-000000000012',
  '00000000-0000-0000-0000-000000000008',
  '00000000-0000-0000-0000-000000000007',
  '2025-04-20 15:30:00',
  'Pending',
  40000,
  5000,
  35000
);

-- 21) OrderDetail
INSERT INTO "OrderDetail" ("id","order","product","amount","unit_price") 
VALUES (
  '00000000-0000-0000-0000-000000000013',
  '00000000-0000-0000-0000-000000000012',
  '00000000-0000-0000-0000-00000000000E',
  2,
  20000
);

-- 22) PaymentMethod
INSERT INTO "PaymentMethod" ("id","name") 
VALUES (
  '00000000-0000-0000-0000-00000000000A',
  'Tarjeta'
);

-- 23) Payment
INSERT INTO "Payment" (
  "id","order","payment_method","status","payment_date","created_at"
) VALUES (
  '00000000-0000-0000-0000-000000000014',
  '00000000-0000-0000-0000-000000000012',
  '00000000-0000-0000-0000-00000000000A',
  'Confirmed',
  '2025-04-20 16:00:00',
  '2025-04-20 15:45:00'
);

-- 24) PaymentEvidence
INSERT INTO "PaymentEvidence" ("id","payment","url","description","uploaded_at") 
VALUES (
  '00000000-0000-0000-0000-000000000015',
  '00000000-0000-0000-0000-000000000014',
  'evidence.jpg',
  'Comprobante de pago',
  '2025-04-20 16:05:00'
);

-- 25) DeliveryStatus
INSERT INTO "DeliveryStatus" ("id","name") 
VALUES (
  '00000000-0000-0000-0000-00000000000B',
  'Shipped'
);

-- 26) Delivery
INSERT INTO "Delivery" ("id","type","delivery_address","order","partner") 
VALUES (
  '00000000-0000-0000-0000-000000000016',
  'Delivery',
  'Calle 123 #45-67',
  '00000000-0000-0000-0000-000000000012',
  '00000000-0000-0000-0000-000000000009'
);

-- 27) DeliveryStatusLog
INSERT INTO "DeliveryStatusLog" (
  "id","delivery","delivery_status","updated_by","updated_at"
) VALUES (
  '00000000-0000-0000-0000-000000000017',
  '00000000-0000-0000-0000-000000000016',
  '00000000-0000-0000-0000-00000000000B',
  '00000000-0000-0000-0000-000000000008',
  '2025-04-20 17:00:00'
);

-- 28) Review
INSERT INTO "Review" ("id","user_profile","product","rating","comment","creation_date") 
VALUES (
  '00000000-0000-0000-0000-000000000018',
  '00000000-0000-0000-0000-000000000008',
  '00000000-0000-0000-0000-00000000000E',
  5,
  'Excelente producto',
  '2025-04-21 10:00:00'
);

-- 29) Collaboration
INSERT INTO "Collaboration" ("id","name","description","price") 
VALUES (
  '00000000-0000-0000-0000-000000000019',
  'Promo Primavera',
  'Descuento especial primavera',
  50000
);

-- 30) CollaborationMembers
INSERT INTO "CollaborationMembers" ("id","collaboration","entrepreneurship","joined_at") 
VALUES (
  '00000000-0000-0000-0000-000000000020',
  '00000000-0000-0000-0000-000000000019',
  '00000000-0000-0000-0000-000000000007',
  '2025-04-21 09:00:00'
);

-- 31) CollaborationImage
INSERT INTO "CollaborationImage" ("id","image_url","collaboration") 
VALUES (
  '00000000-0000-0000-0000-000000000021',
  'collab.jpg',
  '00000000-0000-0000-0000-000000000019'
);

-- 32) CollaborationProducts
INSERT INTO "CollaborationProducts" ("id","amount","collaboration","product") 
VALUES (
  '00000000-0000-0000-0000-000000000022',
  10,
  '00000000-0000-0000-0000-000000000019',
  '00000000-0000-0000-0000-00000000000E'
);

-- 33) Banner
INSERT INTO "Banner" ("id","url","created_at") 
VALUES (
  '00000000-0000-0000-0000-00000000000C',
  'banner1.jpg',
  '2025-04-20'
);

-- 34) Entrepreneurship_Tags (tabla intermedia M:N)
INSERT INTO "Entrepreneurship_Tags" ("Entrepreneurship_id","Tags_id") 
VALUES (
  '00000000-0000-0000-0000-000000000007',
  '00000000-0000-0000-0000-000000000002'
);

