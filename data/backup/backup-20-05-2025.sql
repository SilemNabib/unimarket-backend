--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Debian 16.8-1.pgdg120+1)
-- Dumped by pg_dump version 16.9 (Ubuntu 16.9-1.pgdg24.04+1)

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: app_mov
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO app_mov;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: app_mov
--

COMMENT ON SCHEMA public IS '';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Banner; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."Banner" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    url character varying,
    created_at character varying
);


ALTER TABLE public."Banner" OWNER TO app_mov;

--
-- Name: Collaboration; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."Collaboration" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying,
    description text,
    price numeric
);


ALTER TABLE public."Collaboration" OWNER TO app_mov;

--
-- Name: CollaborationImage; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."CollaborationImage" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    image_url character varying,
    collaboration uuid NOT NULL
);


ALTER TABLE public."CollaborationImage" OWNER TO app_mov;

--
-- Name: CollaborationMembers; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."CollaborationMembers" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    collaboration uuid NOT NULL,
    entrepreneurship uuid NOT NULL,
    joined_at timestamp without time zone
);


ALTER TABLE public."CollaborationMembers" OWNER TO app_mov;

--
-- Name: CollaborationProducts; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."CollaborationProducts" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    amount integer,
    collaboration uuid NOT NULL,
    product uuid NOT NULL
);


ALTER TABLE public."CollaborationProducts" OWNER TO app_mov;

--
-- Name: Delivery; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."Delivery" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    type character varying,
    delivery_address text,
    "order" uuid NOT NULL,
    partner uuid,
    status uuid
);


ALTER TABLE public."Delivery" OWNER TO app_mov;

--
-- Name: COLUMN "Delivery".type; Type: COMMENT; Schema: public; Owner: app_mov
--

COMMENT ON COLUMN public."Delivery".type IS 'Delivery, Pick_Up';


--
-- Name: DeliveryStatus; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."DeliveryStatus" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying
);


ALTER TABLE public."DeliveryStatus" OWNER TO app_mov;

--
-- Name: DeliveryStatusLog; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."DeliveryStatusLog" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    delivery uuid NOT NULL,
    delivery_status uuid NOT NULL,
    updated_by uuid NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public."DeliveryStatusLog" OWNER TO app_mov;

--
-- Name: Entrepreneurship; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."Entrepreneurship" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying,
    slogan text,
    description text,
    creation_date timestamp without time zone,
    customization uuid,
    email character varying,
    phone character varying,
    subscription uuid,
    status character varying,
    category integer NOT NULL,
    user_founder uuid NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public."Entrepreneurship" OWNER TO app_mov;

--
-- Name: COLUMN "Entrepreneurship".status; Type: COMMENT; Schema: public; Owner: app_mov
--

COMMENT ON COLUMN public."Entrepreneurship".status IS 'Enum: active, inactive';


--
-- Name: EntrepreneurshipCustomization; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."EntrepreneurshipCustomization" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    profile_img character varying,
    banner_img character varying,
    color1 character varying,
    color2 character varying,
    entrepreneurship uuid NOT NULL
);


ALTER TABLE public."EntrepreneurshipCustomization" OWNER TO app_mov;

--
-- Name: EntrepreneurshipSubscription; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."EntrepreneurshipSubscription" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    subscription_plan uuid,
    cutoff_date timestamp without time zone,
    last_payment timestamp without time zone,
    entrepreneurship uuid NOT NULL
);


ALTER TABLE public."EntrepreneurshipSubscription" OWNER TO app_mov;

--
-- Name: EntrepreneurshipType; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."EntrepreneurshipType" (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public."EntrepreneurshipType" OWNER TO app_mov;

--
-- Name: EntrepreneurshipType_id_seq; Type: SEQUENCE; Schema: public; Owner: app_mov
--

ALTER TABLE public."EntrepreneurshipType" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."EntrepreneurshipType_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Entrepreneurship_Tags; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."Entrepreneurship_Tags" (
    id integer NOT NULL,
    "Entrepreneurship_id" uuid,
    "Tags_id" uuid
);


ALTER TABLE public."Entrepreneurship_Tags" OWNER TO app_mov;

--
-- Name: Entrepreneurship_Tags_id_seq; Type: SEQUENCE; Schema: public; Owner: app_mov
--

CREATE SEQUENCE public."Entrepreneurship_Tags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Entrepreneurship_Tags_id_seq" OWNER TO app_mov;

--
-- Name: Entrepreneurship_Tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_mov
--

ALTER SEQUENCE public."Entrepreneurship_Tags_id_seq" OWNED BY public."Entrepreneurship_Tags".id;


--
-- Name: Notification; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."Notification" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_profile uuid,
    type integer,
    title character varying,
    content character varying,
    is_read boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Notification" OWNER TO app_mov;

--
-- Name: NotificationType; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."NotificationType" (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public."NotificationType" OWNER TO app_mov;

--
-- Name: Order; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."Order" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_profile uuid,
    entrepreneurship uuid,
    date timestamp without time zone NOT NULL,
    subtotal numeric,
    discount numeric,
    total numeric,
    status uuid DEFAULT 'c1909f66-0fbb-4c62-b5e4-32975d95a700'::uuid
);


ALTER TABLE public."Order" OWNER TO app_mov;

--
-- Name: OrderDetail; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."OrderDetail" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "order" uuid NOT NULL,
    product uuid NOT NULL,
    amount integer,
    unit_price numeric
);


ALTER TABLE public."OrderDetail" OWNER TO app_mov;

--
-- Name: OrderStatus; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."OrderStatus" (
    id uuid NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public."OrderStatus" OWNER TO app_mov;

--
-- Name: Partner; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."Partner" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_profile uuid NOT NULL,
    entrepreneurship uuid NOT NULL,
    partner_rol integer NOT NULL,
    rating integer,
    comment text
);


ALTER TABLE public."Partner" OWNER TO app_mov;

--
-- Name: PartnerRol; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."PartnerRol" (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public."PartnerRol" OWNER TO app_mov;

--
-- Name: PartnerRol_id_seq; Type: SEQUENCE; Schema: public; Owner: app_mov
--

ALTER TABLE public."PartnerRol" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."PartnerRol_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Payment; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."Payment" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "order" uuid,
    payment_method uuid,
    status character varying,
    payment_date timestamp without time zone,
    created_at timestamp without time zone,
    total_paid numeric(10,5) DEFAULT '0'::numeric NOT NULL
);


ALTER TABLE public."Payment" OWNER TO app_mov;

--
-- Name: COLUMN "Payment".status; Type: COMMENT; Schema: public; Owner: app_mov
--

COMMENT ON COLUMN public."Payment".status IS 'Pending, Confirmed, Rejected';


--
-- Name: PaymentEvidence; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."PaymentEvidence" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    payment uuid NOT NULL,
    url character varying,
    description text,
    uploaded_at timestamp without time zone
);


ALTER TABLE public."PaymentEvidence" OWNER TO app_mov;

--
-- Name: PaymentMethod; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."PaymentMethod" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying
);


ALTER TABLE public."PaymentMethod" OWNER TO app_mov;

--
-- Name: Product; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."Product" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    entrepreneurship uuid,
    name character varying(255) DEFAULT NULL::character varying NOT NULL,
    description text,
    price numeric(10,5) DEFAULT NULL::numeric NOT NULL,
    stock_alert integer,
    published boolean DEFAULT true NOT NULL,
    category character varying(255) DEFAULT NULL::character varying NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public."Product" OWNER TO app_mov;

--
-- Name: ProductCategory; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."ProductCategory" (
    name character varying(255) NOT NULL,
    description character varying(255) DEFAULT 'Sin descripción.'::character varying NOT NULL
);


ALTER TABLE public."ProductCategory" OWNER TO app_mov;

--
-- Name: ProductImage; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."ProductImage" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    image_url character varying,
    product_variant uuid
);


ALTER TABLE public."ProductImage" OWNER TO app_mov;

--
-- Name: ProductSpecification; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."ProductSpecification" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    product uuid,
    key character varying,
    value character varying
);


ALTER TABLE public."ProductSpecification" OWNER TO app_mov;

--
-- Name: ProductVariant; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."ProductVariant" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    product uuid,
    stock integer,
    name character varying(255) DEFAULT NULL::character varying NOT NULL
);


ALTER TABLE public."ProductVariant" OWNER TO app_mov;

--
-- Name: Review; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."Review" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_profile uuid NOT NULL,
    product uuid NOT NULL,
    rating integer,
    comment text,
    creation_date timestamp without time zone
);


ALTER TABLE public."Review" OWNER TO app_mov;

--
-- Name: SocialNetwork; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."SocialNetwork" (
    id uuid NOT NULL,
    platform character varying(50) NOT NULL,
    url character varying(255) NOT NULL,
    entrepreneurship uuid
);


ALTER TABLE public."SocialNetwork" OWNER TO app_mov;

--
-- Name: SubscriptionPlans; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."SubscriptionPlans" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying,
    price numeric,
    description text,
    benefits text
);


ALTER TABLE public."SubscriptionPlans" OWNER TO app_mov;

--
-- Name: Tags; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."Tags" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying
);


ALTER TABLE public."Tags" OWNER TO app_mov;

--
-- Name: University; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."University" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    acronym character varying,
    name character varying
);


ALTER TABLE public."University" OWNER TO app_mov;

--
-- Name: UserStatus; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."UserStatus" (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE public."UserStatus" OWNER TO app_mov;

--
-- Name: UserStatus_id_seq; Type: SEQUENCE; Schema: public; Owner: app_mov
--

ALTER TABLE public."UserStatus" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."UserStatus_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: Verification; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."Verification" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    university uuid NOT NULL,
    front_document character varying,
    back_document character varying,
    selfie_with_document character varying,
    status character varying,
    verification_date timestamp without time zone
);


ALTER TABLE public."Verification" OWNER TO app_mov;

--
-- Name: COLUMN "Verification".status; Type: COMMENT; Schema: public; Owner: app_mov
--

COMMENT ON COLUMN public."Verification".status IS 'Pending, Approved, Rejected';


--
-- Name: directus_access; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_access (
    id uuid NOT NULL,
    role uuid,
    "user" uuid,
    policy uuid NOT NULL,
    sort integer
);


ALTER TABLE public.directus_access OWNER TO app_mov;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent text,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO app_mov;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: app_mov
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_activity_id_seq OWNER TO app_mov;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_mov
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(64),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255),
    versioning boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO app_mov;

--
-- Name: directus_comments; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_comments (
    id uuid NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid
);


ALTER TABLE public.directus_comments OWNER TO app_mov;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO app_mov;

--
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_extensions (
    enabled boolean DEFAULT true NOT NULL,
    id uuid NOT NULL,
    folder character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    bundle uuid
);


ALTER TABLE public.directus_extensions OWNER TO app_mov;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text
);


ALTER TABLE public.directus_fields OWNER TO app_mov;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: app_mov
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_fields_id_seq OWNER TO app_mov;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_mov
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json,
    focal_point_x integer,
    focal_point_y integer,
    tus_id character varying(64),
    tus_data json,
    uploaded_on timestamp with time zone
);


ALTER TABLE public.directus_files OWNER TO app_mov;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO app_mov;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO app_mov;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO app_mov;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO app_mov;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: app_mov
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_notifications_id_seq OWNER TO app_mov;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_mov
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO app_mov;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(64) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO app_mov;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    policy uuid NOT NULL
);


ALTER TABLE public.directus_permissions OWNER TO app_mov;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: app_mov
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_permissions_id_seq OWNER TO app_mov;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_mov
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_policies; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_policies (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'badge'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_policies OWNER TO app_mov;

--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(64) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO app_mov;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: app_mov
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_presets_id_seq OWNER TO app_mov;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_mov
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO app_mov;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: app_mov
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_relations_id_seq OWNER TO app_mov;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_mov
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer,
    version uuid
);


ALTER TABLE public.directus_revisions OWNER TO app_mov;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: app_mov
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_revisions_id_seq OWNER TO app_mov;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_mov
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    parent uuid
);


ALTER TABLE public.directus_roles OWNER TO app_mov;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent text,
    share uuid,
    origin character varying(255),
    next_token character varying(64)
);


ALTER TABLE public.directus_sessions OWNER TO app_mov;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json,
    public_favicon uuid,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255),
    theme_light_overrides json,
    default_theme_dark character varying(255),
    theme_dark_overrides json,
    report_error_url character varying(255),
    report_bug_url character varying(255),
    report_feature_url character varying(255),
    public_registration boolean DEFAULT false NOT NULL,
    public_registration_verify_email boolean DEFAULT true NOT NULL,
    public_registration_role uuid,
    public_registration_email_filter json,
    visual_editor_urls json
);


ALTER TABLE public.directus_settings OWNER TO app_mov;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: app_mov
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_settings_id_seq OWNER TO app_mov;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_mov
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO app_mov;

--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO app_mov;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true,
    appearance character varying(255),
    theme_dark character varying(255),
    theme_light character varying(255),
    theme_light_overrides json,
    theme_dark_overrides json
);


ALTER TABLE public.directus_users OWNER TO app_mov;

--
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_versions (
    id uuid NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    hash character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid,
    delta json
);


ALTER TABLE public.directus_versions OWNER TO app_mov;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json,
    was_active_before_deprecation boolean DEFAULT false NOT NULL,
    migrated_flow uuid
);


ALTER TABLE public.directus_webhooks OWNER TO app_mov;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: app_mov
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_webhooks_id_seq OWNER TO app_mov;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app_mov
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: user_profile; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.user_profile (
    id uuid NOT NULL,
    profile_picture character varying(255) DEFAULT 'https://directus-unimarket.s3.us-east-1.amazonaws.com/usuarios/default-profile'::character varying NOT NULL,
    university uuid,
    document character varying,
    document_type character varying,
    status integer DEFAULT 1 NOT NULL,
    registration_date timestamp without time zone NOT NULL,
    verification uuid,
    user_rating numeric(10,5) DEFAULT '0'::numeric NOT NULL,
    partner_rating numeric(10,5) DEFAULT '0'::numeric NOT NULL
);


ALTER TABLE public.user_profile OWNER TO app_mov;

--
-- Name: COLUMN user_profile.document_type; Type: COMMENT; Schema: public; Owner: app_mov
--

COMMENT ON COLUMN public.user_profile.document_type IS 'C.C, Etc.';


--
-- Name: Entrepreneurship_Tags id; Type: DEFAULT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Entrepreneurship_Tags" ALTER COLUMN id SET DEFAULT nextval('public."Entrepreneurship_Tags_id_seq"'::regclass);


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


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
-- Data for Name: CollaborationMembers; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."CollaborationMembers" VALUES ('00000000-0000-0000-0000-000000000020', '00000000-0000-0000-0000-000000000019', '00000000-0000-0000-0000-000000000007', '2025-04-21 09:00:00');


--
-- Data for Name: CollaborationProducts; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."CollaborationProducts" VALUES ('00000000-0000-0000-0000-000000000022', 10, '00000000-0000-0000-0000-000000000019', '00000000-0000-0000-0000-00000000000e');


--
-- Data for Name: Delivery; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Delivery" VALUES ('00000000-0000-0000-0000-000000000016', 'Delivery', 'Calle 123 #45-67', '00000000-0000-0000-0000-000000000012', '00000000-0000-0000-0000-000000000009', NULL);


--
-- Data for Name: DeliveryStatus; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."DeliveryStatus" VALUES ('00000000-0000-0000-0000-00000000000b', 'Shipped');


--
-- Data for Name: DeliveryStatusLog; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."DeliveryStatusLog" VALUES ('00000000-0000-0000-0000-000000000017', '00000000-0000-0000-0000-000000000016', '00000000-0000-0000-0000-00000000000b', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-04-20 17:00:00');


--
-- Data for Name: Entrepreneurship; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Entrepreneurship" VALUES ('00000000-0000-0000-0000-000000000007', 'Starbucks', 'Mas que café, pasión por mejorar el mundo.', 'Somos un ícono global de calidad y comodidad. Ya sea que busques un espresso cargado de energía, un refrescante frappuccino o un snack para acompañar tu día, aquí encontrarás todo lo que necesitas para disfrutar esos momentos especiales.', '2025-04-19 12:00:00', '00000000-0000-0000-0000-000000000003', 'info@emarket.com', '1234567890', '00000000-0000-0000-0000-000000000004', 'active', 1, '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);


--
-- Data for Name: EntrepreneurshipCustomization; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."EntrepreneurshipCustomization" VALUES ('00000000-0000-0000-0000-000000000003', 'https://th.bing.com/th/id/R.ee726b5983009289c7ba33363114a351?rik=gJZod0%2fBYMLTPw&riu=http%3a%2f%2f1000logos.net%2fwp-content%2fuploads%2f2016%2f12%2foriginal-starbucks-logo.jpg&ehk=mBFyzvZn%2bC%2bFnr%2bNhuaqHk5xlRc8Xup8rwuhgtb53x4%3d&risl=&pid=ImgRaw&r=0', 'https://i.ytimg.com/vi/pGj4yFaeJpw/maxresdefault.jpg', '#FFFFFF', '#000000', '00000000-0000-0000-0000-000000000007');


--
-- Data for Name: EntrepreneurshipSubscription; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."EntrepreneurshipSubscription" VALUES ('00000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000005', '2025-12-31 23:59:59', '2025-04-20 10:00:00', '00000000-0000-0000-0000-000000000007');


--
-- Data for Name: EntrepreneurshipType; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."EntrepreneurshipType" VALUES (1, 'Digital');


--
-- Data for Name: Entrepreneurship_Tags; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Entrepreneurship_Tags" VALUES (1, '00000000-0000-0000-0000-000000000007', '83c2533e-8014-4b49-bb30-87a1617dd9ec');
INSERT INTO public."Entrepreneurship_Tags" VALUES (2, '00000000-0000-0000-0000-000000000007', 'b57415c5-23af-4519-9f03-36366174c23d');
INSERT INTO public."Entrepreneurship_Tags" VALUES (3, '00000000-0000-0000-0000-000000000007', 'c73936d7-2913-4b40-af31-0a86a0e8b894');
INSERT INTO public."Entrepreneurship_Tags" VALUES (4, '00000000-0000-0000-0000-000000000007', 'e4dda122-35d9-4d15-8678-64797339acbe');
INSERT INTO public."Entrepreneurship_Tags" VALUES (5, '00000000-0000-0000-0000-000000000007', 'f1d479f9-8332-46ac-a3e5-cd9cf551b936');


--
-- Data for Name: Notification; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Notification" VALUES ('00000000-0000-0000-0000-00000000000d', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 1, 'Bienvenida', '¡Bienvenido a Emarket!', false);


--
-- Data for Name: NotificationType; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."NotificationType" VALUES (1, 'General');


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Order" VALUES ('00000000-0000-0000-0000-000000000012', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000000-0000-0000-0000-000000000007', '2025-04-20 15:30:00', 40000, 5000, 35000, NULL);


--
-- Data for Name: OrderDetail; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."OrderDetail" VALUES ('00000000-0000-0000-0000-000000000013', '00000000-0000-0000-0000-000000000012', '00000000-0000-0000-0000-00000000000e', 2, 20000);


--
-- Data for Name: OrderStatus; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."OrderStatus" VALUES ('c1909f66-0fbb-4c62-b5e4-32975d95a700', 'pendiente');
INSERT INTO public."OrderStatus" VALUES ('e0f5b827-f8ca-4dcb-8ac0-7c2ccb4663f0', 'confirmado');
INSERT INTO public."OrderStatus" VALUES ('1e1ded25-3529-47f6-a632-4de38d0f6c92', 'en proceso');
INSERT INTO public."OrderStatus" VALUES ('ef71736e-3791-440e-b97e-f3a646baba04', 'cancelado');
INSERT INTO public."OrderStatus" VALUES ('5b989409-5b3c-49c0-8285-52687912916b', 'fallido');
INSERT INTO public."OrderStatus" VALUES ('2bef1dec-02be-4614-88f0-5de146201c40', 'listo');
INSERT INTO public."OrderStatus" VALUES ('f6ae0a15-c86b-4181-ab1a-0d434c41d257', 'completado');


--
-- Data for Name: Partner; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Partner" VALUES ('00000000-0000-0000-0000-000000000009', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000000-0000-0000-0000-000000000007', 1, 5, 'Socio fundador');


--
-- Data for Name: PartnerRol; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."PartnerRol" VALUES (1, 'Co‑founder');


--
-- Data for Name: Payment; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Payment" VALUES ('00000000-0000-0000-0000-000000000014', '00000000-0000-0000-0000-000000000012', '00000000-0000-0000-0000-00000000000a', 'Confirmed', '2025-04-20 16:00:00', '2025-04-20 15:45:00', 0.00000);


--
-- Data for Name: PaymentEvidence; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."PaymentEvidence" VALUES ('00000000-0000-0000-0000-000000000015', '00000000-0000-0000-0000-000000000014', 'evidence.jpg', 'Comprobante de pago', '2025-04-20 16:05:00');


--
-- Data for Name: PaymentMethod; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."PaymentMethod" VALUES ('00000000-0000-0000-0000-00000000000a', 'Tarjeta');


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Product" VALUES ('fafbbda3-3958-47aa-a4d4-3c02200dedee', '00000000-0000-0000-0000-000000000007', 'Camiseta Universitaria', 'Camiseta 100% algodón con logo de la universidad', 25000.00000, 10, true, 'Moda', NULL);
INSERT INTO public."Product" VALUES ('00000000-0000-0000-0000-00000000000e', '00000000-0000-0000-0000-000000000007', 'Camiseta', 'Camiseta universitaria', 20000.00000, 10, true, 'Moda', NULL);


--
-- Data for Name: ProductCategory; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."ProductCategory" VALUES ('Moda', 'Viste con estilo.');


--
-- Data for Name: ProductImage; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."ProductImage" VALUES ('00000000-0000-0000-0000-000000000010', 'https://www.lazo.com.co/cdn/shop/files/CAMISETAMODIFICADA1_2.png?v=1739452423', '00000000-0000-0000-0000-00000000000f');
INSERT INTO public."ProductImage" VALUES ('d80f8c93-e79a-401a-8a37-2b3c0d0227de', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOjeK14w5tVQ_cSW5qBfbtN5wZR1Eh-Fbuyg&s', '36d475f6-bf51-4113-b565-29e376899839');
INSERT INTO public."ProductImage" VALUES ('e4ca3c82-e983-48c5-86ec-e5664800be02', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3R4Os2OPTRBjMlPQUeLu5BUE6h6bvQi7TTg&s', '5e52293a-60eb-45fc-8e7b-fb626b046b59');


--
-- Data for Name: ProductSpecification; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."ProductSpecification" VALUES ('a548c783-2e75-444b-aba0-cca4c756e6ac', NULL, 'aSDFADSFAS', 'adsfasfd');
INSERT INTO public."ProductSpecification" VALUES ('76b6bd5f-b898-4d84-a365-bae0186e140c', NULL, 'aSDFADSFAS', 'adsfasfd');
INSERT INTO public."ProductSpecification" VALUES ('fcf1e8aa-b45d-4258-bec8-4a7a55622ad3', 'fafbbda3-3958-47aa-a4d4-3c02200dedee', 'aSDFADSFAS', 'adsfasfd');
INSERT INTO public."ProductSpecification" VALUES ('00000000-0000-0000-0000-000000000011', '00000000-0000-0000-0000-00000000000e', 'Material', 'Algodón');


--
-- Data for Name: ProductVariant; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."ProductVariant" VALUES ('36d475f6-bf51-4113-b565-29e376899839', NULL, 10, 'ASDFASDFADS');
INSERT INTO public."ProductVariant" VALUES ('5e52293a-60eb-45fc-8e7b-fb626b046b59', 'fafbbda3-3958-47aa-a4d4-3c02200dedee', 10, 'ASDFASDFADS');
INSERT INTO public."ProductVariant" VALUES ('00000000-0000-0000-0000-00000000000f', '00000000-0000-0000-0000-00000000000e', 50, 'Talla M');


--
-- Data for Name: Review; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Review" VALUES ('00000000-0000-0000-0000-000000000018', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000000-0000-0000-0000-00000000000e', 5, 'Excelente producto', '2025-04-21 10:00:00');


--
-- Data for Name: SocialNetwork; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: SubscriptionPlans; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."SubscriptionPlans" VALUES ('00000000-0000-0000-0000-000000000005', 'Plan Básico', 9.99, 'Descripción del plan básico', 'Acceso limitado, Soporte básico');


--
-- Data for Name: Tags; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Tags" VALUES ('00000000-0000-0000-0000-000000000002', 'Tecnología');
INSERT INTO public."Tags" VALUES ('b57415c5-23af-4519-9f03-36366174c23d', 'snacks');
INSERT INTO public."Tags" VALUES ('2f84e0cc-1bfb-421d-ade7-1fa5b4f9d13b', 'dulces');
INSERT INTO public."Tags" VALUES ('c73936d7-2913-4b40-af31-0a86a0e8b894', 'bebidas');
INSERT INTO public."Tags" VALUES ('9b8ff68b-ffed-42d6-bab4-651b455d7ab0', 'postres');
INSERT INTO public."Tags" VALUES ('83c2533e-8014-4b49-bb30-87a1617dd9ec', 'comida saludable');
INSERT INTO public."Tags" VALUES ('f1d479f9-8332-46ac-a3e5-cd9cf551b936', 'comida');
INSERT INTO public."Tags" VALUES ('e4dda122-35d9-4d15-8678-64797339acbe', 'vegana');
INSERT INTO public."Tags" VALUES ('0c062ab0-921c-4fab-a30d-6eeb9ffe6bd1', 'orgánica');


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
INSERT INTO public."Verification" VALUES ('d76eb01a-7b8b-45d9-9e15-ddf24157cc23', '00000000-0000-0000-0000-000000000001', 'a.jpg', 'a.jpg', 'a.jpg', 'Pending', '2025-05-14 12:00:00');


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_access VALUES ('0c352f2c-362b-4cf8-b0dd-ae03099d41cc', NULL, NULL, 'abf8a154-5b1c-4a46-ac9c-7300570f4f17', 1);
INSERT INTO public.directus_access VALUES ('14d949cf-af7a-4dd4-894d-1552cb882e23', '8c163976-88d3-4247-a44a-587399ecf43e', NULL, '4861387b-6d9c-48d1-9570-5af806d0671c', NULL);
INSERT INTO public.directus_access VALUES ('bc8471d8-e9e9-437e-94e8-16c22e03708b', '11111111-1111-1111-1111-111111111111', NULL, '4a706832-1a5a-4e16-be61-a1756c9edaa7', 1);
INSERT INTO public.directus_access VALUES ('a78a4f48-4f30-413b-b6fa-5b9458ec8ace', '22222222-2222-2222-2222-222222222222', NULL, '4a706832-1a5a-4e16-be61-a1756c9edaa7', 1);
INSERT INTO public.directus_access VALUES ('cdb115a0-3d0e-422e-854a-f27fbf7078de', '22222222-2222-2222-2222-222222222222', NULL, '60429753-5a20-475d-85bc-de9a5f1ac84f', 2);


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_activity VALUES (1, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 13:51:07.496+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (2, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 14:40:41.235+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (3, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 14:44:09.825+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'user_profile', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (4, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 14:44:42.053+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'SubscriptionPlans', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (5, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 16:59:07.726+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (6, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 16:59:56.382+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Banner', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (7, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:06:06.358+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '3', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (8, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:06:06.652+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', 'abf8a154-5b1c-4a46-ac9c-7300570f4f17', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (9, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:08:32.917+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (10, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:09:10.228+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (11, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:09:47.518+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_access', 'bc8471d8-e9e9-437e-94e8-16c22e03708b', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (12, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:09:47.808+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_roles', '11111111-1111-1111-1111-111111111111', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (13, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:10:11.443+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_access', 'a78a4f48-4f30-413b-b6fa-5b9458ec8ace', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (14, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:10:11.809+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_access', 'cdb115a0-3d0e-422e-854a-f27fbf7078de', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (15, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:10:12.07+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_roles', '22222222-2222-2222-2222-222222222222', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (16, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:49:17.469+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (17, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:49:45.069+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '3', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (18, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:49:45.158+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', 'abf8a154-5b1c-4a46-ac9c-7300570f4f17', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (19, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:50:00.063+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '4', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (20, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:50:00.324+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (21, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:51:32.615+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Collaboration', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (22, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:51:34.758+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (23, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:52:00.877+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'DeliveryStatus', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (24, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:52:19.885+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'CollaborationImage', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (25, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:52:24.737+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'CollaborationMembers', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (26, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:52:37.649+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'CollaborationProducts', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (27, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:52:44.595+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Delivery', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (28, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:52:55.87+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'DeliveryStatusLog', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (119, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 23:01:07.098+00', '54.86.50.139', 'PostmanRuntime/7.43.4', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (29, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:53:04.4+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'UserStatus', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (30, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:53:51.612+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Verification', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (31, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:54:03.124+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Entrepreneurship', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (32, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:54:16.396+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'University', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (33, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:54:26.559+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Tags', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (34, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:54:35.52+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'SocialNetWork', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (35, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:55:00.015+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Review', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (36, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:55:08.022+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'EntrepreneurshipCustomization', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (37, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:55:16.456+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'EntrepreneurshipSubscription', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (38, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:56:40.488+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Partner', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (39, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:56:50.386+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Entrepreneurship_Tags', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (40, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:56:58.618+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'EntrepreneurshipType', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (41, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:57:05.96+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Product', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (42, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:57:12.502+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'NotificationType', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (43, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:57:19.712+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'ProductVariant', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (44, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:57:30.873+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'ProductSpecification', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (45, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:57:37.844+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'ProductImage', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (46, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:57:55.749+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Notification', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (47, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:58:01.883+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Order', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (48, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:58:08.352+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'OrderDetail', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (49, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:58:20.99+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'PartnerRol', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (50, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:58:27.243+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Payment', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (51, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:58:36.538+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'PaymentMethod', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (52, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 17:58:41.645+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'PaymentEvidence', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (53, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:13:05.009+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '5', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (54, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:13:05.271+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (55, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:27:19.104+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '5', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (56, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:27:19.445+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (57, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:31:43.929+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '2', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (229, 'login', '8172a6a5-cb0c-4daf-bf77-5293486b6640', '2025-05-15 02:58:05.111+00', '169.254.42.1', 'axios/1.8.4', 'directus_users', '8172a6a5-cb0c-4daf-bf77-5293486b6640', NULL);
INSERT INTO public.directus_activity VALUES (58, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:31:52.07+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '3', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (59, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:31:52.617+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '4', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (60, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:31:53.128+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '5', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (61, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:31:53.672+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '6', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (62, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:31:54.237+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (63, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:31:54.785+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '2', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (64, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:38:24.123+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '6', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (65, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:38:24.442+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (66, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:38:47.86+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (67, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:38:48.113+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (68, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:39:15.648+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '8', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (69, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:39:15.901+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (70, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:42:31.187+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (71, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 18:57:01.367+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'a631a800-b219-4c44-8829-910153ec9c2b', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (72, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 19:33:30.61+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'a631a800-b219-4c44-8829-910153ec9c2b', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (73, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 19:33:49.81+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '8', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (74, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 19:56:40.7+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '9', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (75, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 19:57:17.858+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '10', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (76, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 20:10:31.031+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '11', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (77, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 20:10:31.301+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'OrderStatus', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (78, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 20:11:00.194+00', '200.3.193.228', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '12', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (79, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 20:47:26.613+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (80, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 20:50:08.966+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '10', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (81, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 20:54:01.853+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '13', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (82, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 20:55:15.451+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '13', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (83, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 21:26:24.084+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '14', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (84, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 21:40:43.388+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'OrderStatus', 'c1909f66-0fbb-4c62-b5e4-32975d95a700', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (85, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 21:40:58.48+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'OrderStatus', 'e0f5b827-f8ca-4dcb-8ac0-7c2ccb4663f0', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (86, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 21:41:30.741+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'OrderStatus', '1e1ded25-3529-47f6-a632-4de38d0f6c92', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (230, 'run', NULL, '2025-05-15 02:58:05.461+00', NULL, NULL, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', NULL);
INSERT INTO public.directus_activity VALUES (231, 'run', NULL, '2025-05-15 02:58:05.973+00', NULL, NULL, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', NULL);
INSERT INTO public.directus_activity VALUES (87, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 21:42:36.676+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'OrderStatus', 'ef71736e-3791-440e-b97e-f3a646baba04', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (89, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 21:45:06.862+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'OrderStatus', '2bef1dec-02be-4614-88f0-5de146201c40', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (91, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 21:57:05.528+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'a631a800-b219-4c44-8829-910153ec9c2b', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (88, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 21:42:51.634+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'OrderStatus', '5b989409-5b3c-49c0-8285-52687912916b', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (90, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 21:45:49.399+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'OrderStatus', 'f6ae0a15-c86b-4181-ab1a-0d434c41d257', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (92, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-13 21:57:22.509+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'a631a800-b219-4c44-8829-910153ec9c2b', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (93, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 02:07:31.212+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', 'adc3bb66-0f3d-49e2-ac9c-3b2b721aec9c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (94, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 02:07:31.472+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', 'a2b6e335-6e07-4243-bdb3-0a5502a92112', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (95, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 02:07:31.725+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '21b07fc3-0eb8-493e-a6b8-dd16e9589e6c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (96, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 02:07:32.148+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'a631a800-b219-4c44-8829-910153ec9c2b', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (97, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 02:10:31.543+00', '54.86.50.139', 'PostmanRuntime/7.43.4', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (98, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 02:25:55.877+00', '186.116.227.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (99, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 18:42:06.341+00', '190.108.76.130', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (100, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 18:42:45.542+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (101, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 18:50:53.485+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (102, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 18:51:40.347+00', '190.108.76.130', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4861387b-6d9c-48d1-9570-5af806d0671c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (103, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 20:56:00.61+00', '200.3.192.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '15', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (104, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 21:02:01.776+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '16', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (105, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 21:15:09.495+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '17', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (106, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 21:18:01.478+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '9', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (107, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 21:18:01.755+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '10', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (108, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 21:18:02.01+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '11', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (109, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 21:18:02.26+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '12', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (110, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 21:18:02.512+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '13', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (111, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 21:18:02.773+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '14', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (112, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 21:18:03.027+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '15', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (113, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 21:18:03.274+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (114, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 21:18:51.252+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '16', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (115, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 21:18:51.513+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (116, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 21:20:37.193+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '17', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (117, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 21:20:37.454+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (118, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 22:58:58.667+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (120, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 23:06:47.807+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (121, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 23:11:37.095+00', '54.86.50.139', 'PostmanRuntime/7.43.4', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (122, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-14 23:11:41.642+00', '54.86.50.139', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (123, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 23:12:18.015+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (124, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-14 23:12:21.787+00', '10.142.0.3', 'PostmanRuntime/7.43.4', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (125, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 23:32:24.466+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (126, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 23:33:46.021+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '42a51146-3462-43a0-8601-1c969fa0a959', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (127, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 23:33:46.373+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (130, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 23:38:05.934+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (131, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 23:38:06.282+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', 'abf8a154-5b1c-4a46-ac9c-7300570f4f17', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (132, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 23:46:53.643+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_settings', '1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (133, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 23:49:43.439+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_settings', '1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (139, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 00:19:42.827+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (140, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 00:19:43.163+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', 'abf8a154-5b1c-4a46-ac9c-7300570f4f17', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (143, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 00:29:33.772+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (144, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 00:29:34.116+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', 'abf8a154-5b1c-4a46-ac9c-7300570f4f17', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (161, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 01:05:10.409+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_settings', '1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (164, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 01:10:04.533+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_roles', '1eb1310f-321f-4733-8aaf-7a935b5886f6', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (166, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 01:11:31.691+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_settings', '1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (168, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 01:19:52.723+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (169, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 01:25:07.595+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (170, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 01:25:54.556+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (171, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 01:26:04.397+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', '12af7a25-fb23-4b4b-835a-c8c8da93b250', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (172, 'run', NULL, '2025-05-15 01:26:11.424+00', NULL, NULL, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', NULL);
INSERT INTO public.directus_activity VALUES (173, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 01:44:35.932+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (174, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:00:34.39+00', '10.142.0.3', 'PostmanRuntime/7.43.4', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (175, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:10:32.684+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '336d194c-cf1f-410c-af63-ce913f219fb4', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (176, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:10:33.048+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (177, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:14:52.077+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', 'ae241e41-a3b0-4dd5-8f90-0e86f96c34a8', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (178, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:14:52.343+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '0a325417-f595-4af0-b2b4-b8824397d519', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (179, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:14:52.886+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '42a51146-3462-43a0-8601-1c969fa0a959', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (180, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:14:52.98+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (181, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:18:51.521+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '9b8eca22-d0f7-44bc-a71c-4444f01d85b1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (182, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:18:51.789+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '336d194c-cf1f-410c-af63-ce913f219fb4', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (183, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:18:52.318+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (184, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:19:19.181+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', 'ae241e41-a3b0-4dd5-8f90-0e86f96c34a8', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (185, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:19:19.529+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '0a325417-f595-4af0-b2b4-b8824397d519', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (186, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:19:20.06+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (187, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:19:33.531+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', '57d2af88-6b67-4b43-84c1-4259d943972f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (188, 'run', NULL, '2025-05-15 02:19:50.59+00', NULL, NULL, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', NULL);
INSERT INTO public.directus_activity VALUES (189, 'run', NULL, '2025-05-15 02:19:51.123+00', NULL, NULL, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', NULL);
INSERT INTO public.directus_activity VALUES (190, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:22:47.759+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '9b8eca22-d0f7-44bc-a71c-4444f01d85b1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (191, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:22:48.111+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '336d194c-cf1f-410c-af63-ce913f219fb4', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (192, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:22:48.621+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (193, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:23:47.357+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'a5b7379d-1ccc-489f-b60b-a7819f4a219f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (194, 'login', '6cdc8591-4fa7-4d56-9323-39309c878e00', '2025-05-15 02:23:51.981+00', '169.254.42.1', 'axios/1.8.4', 'directus_users', '6cdc8591-4fa7-4d56-9323-39309c878e00', NULL);
INSERT INTO public.directus_activity VALUES (195, 'run', NULL, '2025-05-15 02:23:52.339+00', NULL, NULL, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', NULL);
INSERT INTO public.directus_activity VALUES (196, 'run', NULL, '2025-05-15 02:23:52.852+00', NULL, NULL, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', NULL);
INSERT INTO public.directus_activity VALUES (197, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:24:37.754+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '9b8eca22-d0f7-44bc-a71c-4444f01d85b1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (198, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:24:38.124+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '336d194c-cf1f-410c-af63-ce913f219fb4', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (199, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:24:38.653+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (200, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:36:49.591+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (201, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:38:53.271+00', '54.86.50.139', 'PostmanRuntime/7.43.4', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (202, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:41:02.73+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '19', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (203, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:41:29.657+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '20', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (204, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:41:36.8+00', '200.3.192.203', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '21', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (205, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:42:10.978+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '22', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (206, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:42:39.483+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '23', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (207, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:42:41.2+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '24', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (208, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:43:01.412+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '24', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (209, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:43:08.407+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '25', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (210, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:43:27.945+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '26', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (211, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:43:53.588+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '26', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (212, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:43:59.264+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '27', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (213, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:45:03.026+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '28', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (214, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:46:37.933+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '23', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (215, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:48:13.847+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '23', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (216, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:48:38.781+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '2937e439-104a-46d0-89ec-d5e42b65baf0', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (217, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:48:39.052+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '0a325417-f595-4af0-b2b4-b8824397d519', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (218, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:48:39.694+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', 'ae241e41-a3b0-4dd5-8f90-0e86f96c34a8', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (219, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:48:39.827+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (220, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:48:48.53+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', '6cdc8591-4fa7-4d56-9323-39309c878e00', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (221, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:48:55.159+00', '10.142.0.3', 'PostmanRuntime/7.43.4', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (222, 'login', 'dc0a415a-ab2d-4563-9374-dd0ffeda8d3e', '2025-05-15 02:49:01.806+00', '169.254.42.1', 'axios/1.8.4', 'directus_users', 'dc0a415a-ab2d-4563-9374-dd0ffeda8d3e', NULL);
INSERT INTO public.directus_activity VALUES (223, 'run', NULL, '2025-05-15 02:49:02.158+00', NULL, NULL, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', NULL);
INSERT INTO public.directus_activity VALUES (224, 'run', NULL, '2025-05-15 02:49:02.676+00', NULL, NULL, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', NULL);
INSERT INTO public.directus_activity VALUES (225, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:56:48.232+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '2937e439-104a-46d0-89ec-d5e42b65baf0', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (226, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:56:48.602+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '0a325417-f595-4af0-b2b4-b8824397d519', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (227, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:56:49.121+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (228, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:58:00.068+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'dc0a415a-ab2d-4563-9374-dd0ffeda8d3e', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (232, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:02:56.587+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', '8172a6a5-cb0c-4daf-bf77-5293486b6640', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (236, 'login', 'eaf0c17a-1b80-4452-b0ec-2a9875d71292', '2025-05-15 03:03:07.466+00', '169.254.42.1', 'axios/1.8.4', 'directus_users', 'eaf0c17a-1b80-4452-b0ec-2a9875d71292', NULL);
INSERT INTO public.directus_activity VALUES (237, 'run', NULL, '2025-05-15 03:03:07.957+00', NULL, NULL, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', NULL);
INSERT INTO public.directus_activity VALUES (238, 'run', NULL, '2025-05-15 03:03:08.678+00', NULL, NULL, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', NULL);
INSERT INTO public.directus_activity VALUES (233, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:02:59.84+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '2937e439-104a-46d0-89ec-d5e42b65baf0', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (234, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:03:00.184+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '0a325417-f595-4af0-b2b4-b8824397d519', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (235, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:03:00.701+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (239, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:04:07.373+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '2937e439-104a-46d0-89ec-d5e42b65baf0', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (240, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:04:07.75+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '0a325417-f595-4af0-b2b4-b8824397d519', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (241, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:04:08.264+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (242, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:04:58.887+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '2937e439-104a-46d0-89ec-d5e42b65baf0', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (243, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:04:59.227+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '0a325417-f595-4af0-b2b4-b8824397d519', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (244, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:04:59.75+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (245, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:05:12.397+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'eaf0c17a-1b80-4452-b0ec-2a9875d71292', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (246, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:07:51.02+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '2937e439-104a-46d0-89ec-d5e42b65baf0', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (247, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:07:51.366+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '0a325417-f595-4af0-b2b4-b8824397d519', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (248, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:07:51.876+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (249, 'login', '02999d68-e9bf-48e6-a094-b5b33d096581', '2025-05-15 03:08:01.364+00', '169.254.42.1', 'axios/1.8.4', 'directus_users', '02999d68-e9bf-48e6-a094-b5b33d096581', NULL);
INSERT INTO public.directus_activity VALUES (250, 'run', NULL, '2025-05-15 03:08:01.786+00', NULL, NULL, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', NULL);
INSERT INTO public.directus_activity VALUES (251, 'run', NULL, '2025-05-15 03:08:02.633+00', NULL, NULL, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', NULL);
INSERT INTO public.directus_activity VALUES (252, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:09:02.437+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '23', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (253, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:09:03.316+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (254, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:09:03.997+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '19', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (255, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:09:04.642+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '20', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (256, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:09:05.324+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '21', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (257, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:09:06.002+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '22', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (258, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:09:06.595+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '24', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (259, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:09:07.235+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '25', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (260, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:09:07.853+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '26', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (261, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:09:08.433+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '27', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (262, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:09:09.14+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '28', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (263, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:10:30.125+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (264, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:10:59.465+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', '02999d68-e9bf-48e6-a094-b5b33d096581', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (265, 'login', '4bb91682-adb1-455c-b045-4c31c5f976c9', '2025-05-15 03:11:05.19+00', '169.254.42.1', 'axios/1.8.4', 'directus_users', '4bb91682-adb1-455c-b045-4c31c5f976c9', NULL);
INSERT INTO public.directus_activity VALUES (266, 'run', NULL, '2025-05-15 03:11:05.53+00', NULL, NULL, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', NULL);
INSERT INTO public.directus_activity VALUES (267, 'create', NULL, '2025-05-15 03:11:06.117+00', NULL, NULL, 'user_profile', '4bb91682-adb1-455c-b045-4c31c5f976c9', NULL);
INSERT INTO public.directus_activity VALUES (268, 'run', NULL, '2025-05-15 03:11:06.456+00', NULL, NULL, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', NULL);
INSERT INTO public.directus_activity VALUES (269, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:12:03.064+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (270, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:12:33.539+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', '4bb91682-adb1-455c-b045-4c31c5f976c9', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (271, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:19:40.966+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (272, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 03:23:09.005+00', '10.142.0.3', 'PostmanRuntime/7.43.4', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (273, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-15 03:23:28.293+00', '186.169.19.139', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (274, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:23:37.537+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (275, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:23:37.941+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (276, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:24:54.421+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_roles', '11111111-1111-1111-1111-111111111111', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (277, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:25:24.805+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_roles', '11111111-1111-1111-1111-111111111111', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (278, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:25:38.116+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_roles', '11111111-1111-1111-1111-111111111111', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (279, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 03:26:02.528+00', '10.142.0.3', 'PostmanRuntime/7.43.4', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (280, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:26:13.378+00', '186.169.19.139', 'PostmanRuntime/7.43.4', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (281, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:27:00.718+00', '186.169.19.139', 'PostmanRuntime/7.43.4', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (282, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:37:03.914+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_access', '52dd11d7-e6fd-47ae-b715-7ac7f141a1ed', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (283, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:37:04.174+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4861387b-6d9c-48d1-9570-5af806d0671c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (284, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:37:25.819+00', '10.142.0.3', 'PostmanRuntime/7.43.4', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (285, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:38:48.408+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_access', '52dd11d7-e6fd-47ae-b715-7ac7f141a1ed', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (286, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:38:48.746+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4861387b-6d9c-48d1-9570-5af806d0671c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (287, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 03:40:54.338+00', '186.169.19.139', 'PostmanRuntime/7.43.4', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (288, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-15 03:41:04.244+00', '186.169.19.139', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (289, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:44:56.01+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (290, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:44:56.262+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (291, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:47:06.503+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '2f88803e-8fff-44c9-a2f5-04eb8bcbe78d', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (292, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:47:42.566+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '2f88803e-8fff-44c9-a2f5-04eb8bcbe78d', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (293, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:48:50.271+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '2f88803e-8fff-44c9-a2f5-04eb8bcbe78d', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (294, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:50:39.001+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '2f88803e-8fff-44c9-a2f5-04eb8bcbe78d', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (295, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:56:21.458+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '29', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (296, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 03:57:54.627+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '29', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (297, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:05:16.426+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '30', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (298, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:05:21.276+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '31', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (299, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:05:26.77+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '32', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (300, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:05:44.736+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '33', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (301, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:05:49.553+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '34', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (302, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:06:14.716+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '35', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (304, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:06:29.089+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '37', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (305, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:06:32.946+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '38', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (306, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:06:37.66+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '39', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (307, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:06:41.148+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '40', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (308, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:09:15.763+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_settings', '1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (309, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:09:37.23+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '41', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (314, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:09:45.793+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '46', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (317, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:09:50.253+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '49', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (303, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:06:25.169+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '36', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (310, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:09:38.816+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '42', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (311, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:09:43.134+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '43', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (312, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:09:44.452+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '44', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (313, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:09:44.456+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '45', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (315, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:09:48.599+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '47', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (316, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:09:49.86+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '48', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (318, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:11:20.986+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '45', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (319, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:11:25.67+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '45', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (320, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:12:53.022+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '29', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (321, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:23:33.378+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (322, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:23:41.643+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (323, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:24:25.807+00', '190.108.76.130', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'a631a800-b219-4c44-8829-910153ec9c2b', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (324, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:24:36.406+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '9', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (325, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:26:43.545+00', '190.108.76.130', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '19', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (326, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:26:43.803+00', '190.108.76.130', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '20', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (327, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:26:44.063+00', '190.108.76.130', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '21', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (328, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:26:44.407+00', '190.108.76.130', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (329, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:26:44.749+00', '190.108.76.130', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (330, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:27:19.749+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (331, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:27:20.101+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (332, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:29:09.706+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (333, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:29:10.133+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '19', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (334, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:29:10.223+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '20', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (335, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:29:10.333+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '21', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (336, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:29:10.448+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (337, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:30:09.257+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '5c9a819a-e910-4711-bdbb-7fcadd494268', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (338, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:31:10.557+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '5c9a819a-e910-4711-bdbb-7fcadd494268', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (339, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:31:31.206+00', '190.108.76.130', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (340, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:32:07.891+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (341, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:32:07.937+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (342, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:32:08.295+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (343, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 04:34:19.428+00', '186.169.19.139', 'PostmanRuntime/7.43.4', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (344, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-15 04:34:23.292+00', '186.169.19.139', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (345, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:36:09.794+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '50', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (346, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:36:11.368+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '51', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (347, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:36:14.685+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '52', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (348, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:37:41.698+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', 'da7fb5e9-27af-41a7-8ab6-4c399a2efe42', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (349, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:37:42.045+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '5c9a819a-e910-4711-bdbb-7fcadd494268', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (350, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:37:49.87+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Verification', 'd76eb01a-7b8b-45d9-9e15-ddf24157cc23', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (351, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:38:02.807+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Verification', 'd76eb01a-7b8b-45d9-9e15-ddf24157cc23', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (352, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:38:15.504+00', '54.86.50.139', 'PostmanRuntime/7.43.4', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (353, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:38:21.847+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'user_profile', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (354, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:39:09.132+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Entrepreneurship', '00000000-0000-0000-0000-000000000007', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (355, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:40:15.185+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '53', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (356, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:40:15.516+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '54', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (357, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:40:15.915+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '55', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (358, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:40:16.225+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '56', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (359, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:40:16.552+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '57', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (360, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:40:16.897+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '58', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (361, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:40:17.301+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Temp_Prueba', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (362, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:40:50.036+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '59', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (363, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:40:50.353+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '60', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (364, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:40:50.69+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '61', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (365, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:40:51.032+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '62', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (366, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:40:51.322+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '63', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (367, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:40:51.615+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '64', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (368, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:40:51.958+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'temp_many', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (371, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:42:02.145+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '29', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (373, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:42:17.192+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '65', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (375, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:42:35.482+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '65', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (376, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:43:10.551+00', '186.169.19.139', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '66', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (377, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:43:42.737+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '5c9a819a-e910-4711-bdbb-7fcadd494268', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (378, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:43:50.647+00', '10.142.0.3', 'PostmanRuntime/7.43.4', 'Product', 'cccdc0be-bc78-46da-8710-02d43466da2c', NULL);
INSERT INTO public.directus_activity VALUES (379, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:47:34.25+00', '190.108.76.130', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '5c9a819a-e910-4711-bdbb-7fcadd494268', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (380, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:47:50.557+00', '54.86.50.139', 'PostmanRuntime/7.43.4', 'Product', '119f42ba-df36-4f32-8786-80c20ae3740a', NULL);
INSERT INTO public.directus_activity VALUES (381, 'run', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 04:47:50.975+00', '54.86.50.139', 'PostmanRuntime/7.43.4', 'directus_flows', '5c9a819a-e910-4711-bdbb-7fcadd494268', NULL);
INSERT INTO public.directus_activity VALUES (382, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 05:06:30.485+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '5c9a819a-e910-4711-bdbb-7fcadd494268', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (383, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 12:30:49.273+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (384, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 12:40:09.029+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '22', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (385, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 12:40:09.366+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (386, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 12:43:17.761+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '23', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (387, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 12:43:18.035+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '24', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (388, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 12:43:18.285+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (389, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 12:48:47.964+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '22', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (390, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 12:48:48.308+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (391, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 12:49:34.874+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (392, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 12:49:35.213+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (393, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:44:08.607+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '67', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (394, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:48:24.868+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '66', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (395, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:48:27.375+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Temp_Prueba', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (396, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:48:27.629+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '53', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (397, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:48:27.758+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '54', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (398, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:48:27.86+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '55', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (399, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:48:27.954+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '56', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (400, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:48:28.038+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '57', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (401, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:48:28.121+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '58', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (402, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:48:38.119+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'temp_many', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (403, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:48:38.398+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '59', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (590, 'create', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 18:36:18.842+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'Product', '6f41a854-d702-43c6-a3af-e91c5bae8128', NULL);
INSERT INTO public.directus_activity VALUES (404, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:48:38.481+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '60', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (405, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:48:38.564+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '61', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (406, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:48:38.664+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '62', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (407, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:48:38.747+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '63', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (408, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:48:38.831+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '64', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (409, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 13:51:56.268+00', '191.95.50.156', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (410, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:26:25.761+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '68', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (411, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:26:26.02+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '69', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (412, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:26:26.281+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '70', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (413, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:26:26.534+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '71', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (414, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:26:26.788+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '72', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (415, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:26:27.047+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Temp', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (416, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:26:59.066+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '73', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (417, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:26:59.339+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '74', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (418, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:26:59.599+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '75', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (419, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:26:59.856+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '76', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (420, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:27:00.131+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '77', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (421, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:27:00.395+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'TempMany', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (422, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:28:10.025+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '78', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (423, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-15 14:47:21.288+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (424, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:48:35.166+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (425, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:48:35.53+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (426, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:59:40.919+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (427, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 14:59:41.257+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (428, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:07:24.596+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (429, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:07:24.953+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (430, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:15:55.9+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '79', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (431, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:16:18.167+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '79', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (432, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:16:49.368+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '80', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (433, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:27:43.482+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '82', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (434, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:30:30.846+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (435, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:30:31.205+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (436, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:31:19.833+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (437, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 15:32:03.671+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (438, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:34:55.557+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Partner', '6022e80e-3c5e-4b6c-b294-1880430c4373', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (439, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-15 15:35:04.542+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (440, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 15:35:11.807+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (441, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:37:00.607+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (442, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:37:00.971+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (443, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:37:29.421+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Partner', '6022e80e-3c5e-4b6c-b294-1880430c4373', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (444, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-15 15:37:47.671+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (445, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 15:37:54.132+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (446, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:38:34.282+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '80', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (447, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:38:34.845+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '78', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (448, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:38:37.483+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Temp', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (449, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:38:37.738+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '68', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (450, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:38:37.858+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '69', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (451, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:38:37.94+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '70', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (452, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:38:38.023+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '71', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (453, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:38:38.109+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '72', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (454, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:38:45.378+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'TempMany', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (455, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:38:45.63+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '73', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (456, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:38:45.715+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '74', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (457, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:38:45.801+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '75', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (458, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:38:45.884+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '76', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (459, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:38:45.967+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '77', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (460, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:40:01.418+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '83', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (461, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:41:17.159+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '25', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (462, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:41:17.421+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (463, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:45:36.294+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '84', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (464, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:48:22.186+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '85', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (465, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:48:24.577+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '86', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (466, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:48:24.846+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Collaboration_Entrepreneurship', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (467, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:48:26.846+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '87', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (468, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:48:29.169+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '88', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (470, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:48:56.865+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Collaboration', '00000000-0000-0000-0000-000000000019', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (471, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:52:54.622+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '26', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (472, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:52:54.879+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (473, 'create', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 15:53:38.889+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'Collaboration', '792ec089-942c-446b-b1c7-18fd3f6532ea', NULL);
INSERT INTO public.directus_activity VALUES (474, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:55:07.525+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Collaboration_Entrepreneurship', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (475, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:56:20.915+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '26', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (476, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:56:21.245+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (477, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-15 15:56:31.711+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (478, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-15 15:56:39.229+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'Collaboration', '6b6df512-bccd-4052-9445-482dfa13a80a', NULL);
INSERT INTO public.directus_activity VALUES (479, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 16:32:30.25+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (480, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:33:36.137+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '24', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (481, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:33:36.223+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '26', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (482, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:33:36.31+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (483, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:34:46.136+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '85', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (484, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:36:32.467+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '27', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (485, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:36:32.721+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (486, 'create', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 16:36:39.872+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'Collaboration', '169f5ef7-fc33-4f28-aa3f-25930743b45d', NULL);
INSERT INTO public.directus_activity VALUES (487, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:40:58.636+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Collaboration', '169f5ef7-fc33-4f28-aa3f-25930743b45d', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (488, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:40:58.722+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Collaboration', '6b6df512-bccd-4052-9445-482dfa13a80a', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (489, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:40:58.829+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Collaboration', '792ec089-942c-446b-b1c7-18fd3f6532ea', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (490, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:44:21.634+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '89', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (491, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:45:18.75+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '90', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (492, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:49:12.143+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '25', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (493, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:50:38.126+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '91', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (494, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:51:55.122+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '92', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (495, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:52:40.044+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '93', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (496, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:53:52.464+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '94', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (497, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:56:02.387+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '95', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (591, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 18:36:24.864+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (592, 'create', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 18:36:28.835+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'Product', 'e6813b20-857a-4a84-878e-6857867a5cea', NULL);
INSERT INTO public.directus_activity VALUES (498, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:59:28.573+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '95', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (499, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 16:59:56.212+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '96', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (500, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:00:52.92+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '97', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (501, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:02:38.081+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '98', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (502, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:04:01.761+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '99', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (503, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:04:52.029+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '100', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (504, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:06:40.335+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '101', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (505, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:08:01.215+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '102', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (506, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:08:29.342+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '103', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (507, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:09:11.602+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '104', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (508, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:09:50.566+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '105', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (509, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:10:45.213+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '106', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (510, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:11:47.14+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '107', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (511, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:12:26.438+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '108', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (512, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:13:33.067+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '109', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (513, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:17:59.816+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '110', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (514, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:18:59.388+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '111', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (515, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:22:22.416+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Collaboration_Entrepreneurship', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (516, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:22:22.672+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '86', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (517, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:22:22.757+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '87', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (518, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:22:22.843+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '88', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (519, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:22:24.118+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '85', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (520, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:23:43.67+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '27', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (521, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:23:43.753+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (522, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:24:49.876+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '112', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (523, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:28:57.758+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '113', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (524, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:30:08.033+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '114', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (525, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:30:51.53+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '115', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (526, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:32:39.85+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '116', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (527, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:34:44.141+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '117', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (593, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 03:53:12.597+00', '181.32.95.252', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '129', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (528, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:35:29.886+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'EntrepreneurshipSubscription', '00000000-0000-0000-0000-000000000004', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (529, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:38:50.684+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '118', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (530, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:39:34.954+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '119', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (531, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:40:34.405+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '120', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (532, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:42:38.686+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '121', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (533, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:43:09.271+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'SocialNetWork', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (534, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:43:09.522+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '121', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (535, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:43:41.664+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '122', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (536, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:43:41.932+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'SocialNetwork', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (537, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:44:30.809+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '123', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (538, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:45:00.08+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '124', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (539, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:45:57.011+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '125', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (540, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:46:15.475+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '35', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (541, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:46:36.37+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '126', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (542, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:47:45.748+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '127', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (543, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:48:40.634+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'EntrepreneurshipCustomization', '00000000-0000-0000-0000-000000000003', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (544, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:50:05.772+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '128', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (545, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:55:41.793+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (546, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 17:55:42.118+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (547, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:02:32.183+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '28', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (548, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:02:32.52+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '22', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (549, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:02:32.896+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (550, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-15 18:02:47.264+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (551, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 18:02:50.623+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (552, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-15 18:03:22.4+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (553, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:05:34.893+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '22', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (554, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:05:35.227+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (555, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:06:02.882+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '22', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (556, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:06:03.222+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (557, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-15 18:06:56.799+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (558, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:09:01.38+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '22', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (559, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:09:01.717+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (560, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:11:24.884+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '29', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (561, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:13:36.176+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '29', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (562, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:13:36.434+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (563, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:14:03.042+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '28', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (564, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:14:03.123+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '29', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (565, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:14:03.203+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (566, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:15:14.645+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '30', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (567, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:15:14.898+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (568, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:16:11.946+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '22', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (569, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:16:12.384+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (570, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-15 18:16:23.665+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'Product', '8eb18a4b-bf30-42d0-9f65-79d62d73d0a9', NULL);
INSERT INTO public.directus_activity VALUES (571, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:18:21.669+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '22', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (572, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:18:22.019+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (573, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:26:04.669+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '22', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (574, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:26:05.028+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (575, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:29:20.901+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '22', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (576, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:29:21.253+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (577, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-15 18:29:37.093+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'Product', 'f7bff1e4-fc7b-45e1-b021-b72efbc20bab', NULL);
INSERT INTO public.directus_activity VALUES (578, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-15 18:30:03.128+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'Product', '6aa5195e-1fab-46ff-bed3-0259c45d4e41', NULL);
INSERT INTO public.directus_activity VALUES (579, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 18:30:34.668+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (580, 'create', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 18:30:38.964+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'Product', 'f6e9d8cb-2eba-4536-84d4-9db480da3b26', NULL);
INSERT INTO public.directus_activity VALUES (581, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:32:39.004+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', '119f42ba-df36-4f32-8786-80c20ae3740a', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (582, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:32:39.09+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', 'f7bff1e4-fc7b-45e1-b021-b72efbc20bab', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (583, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:32:39.174+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', 'f6e9d8cb-2eba-4536-84d4-9db480da3b26', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (584, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:32:39.259+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', 'cccdc0be-bc78-46da-8710-02d43466da2c', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (585, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:32:39.343+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', '8eb18a4b-bf30-42d0-9f65-79d62d73d0a9', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (586, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:32:39.43+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', '6aa5195e-1fab-46ff-bed3-0259c45d4e41', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (587, 'create', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-15 18:34:19.105+00', '200.3.193.227', 'PostmanRuntime/7.43.4', 'Product', '8893bbf2-2267-4a26-89bb-815087c5c859', NULL);
INSERT INTO public.directus_activity VALUES (588, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:36:05.354+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '22', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (589, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 18:36:05.692+00', '200.3.193.227', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (594, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 03:53:41.556+00', '181.32.95.252', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '130', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (595, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 03:54:05.604+00', '181.32.95.252', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'ProductVariant', '00000000-0000-0000-0000-00000000000f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (596, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 03:54:15.488+00', '181.32.95.252', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '129', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (597, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 03:54:35.076+00', '181.32.95.252', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '130', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (598, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 03:55:16.493+00', '186.113.155.117', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '131', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (599, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 04:05:25.526+00', '186.113.155.117', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '132', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (600, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 12:47:04.647+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '133', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (601, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 12:50:08.316+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '134', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (602, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 12:50:35.698+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '135', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (603, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 12:56:28.945+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '136', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (604, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 15:32:08.731+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (605, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 15:40:05.631+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '3b20c117-7bf0-46ee-8c14-234e7714a17f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (606, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 15:41:49.998+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '96889676-413d-4e8e-a61d-836ad7799ef8', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (607, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 15:41:50.347+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '3b20c117-7bf0-46ee-8c14-234e7714a17f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (608, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 15:52:43.548+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '0a6bb686-45db-4ec9-93b2-941396e09bfa', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (609, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 15:52:43.813+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '909ade44-4d93-48ed-b6a2-b4514e7aebd5', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (610, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 15:52:44.064+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '96889676-413d-4e8e-a61d-836ad7799ef8', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (611, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 15:52:44.566+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '3b20c117-7bf0-46ee-8c14-234e7714a17f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (612, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 15:55:31.709+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '31', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (613, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 15:55:31.954+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '32', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (614, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 15:55:32.198+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (615, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 15:57:23.391+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '14', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (616, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 16:00:44.139+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '137', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (617, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 16:00:46.211+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '138', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (618, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 16:01:11.455+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '138', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (619, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 16:12:53.006+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '0a6bb686-45db-4ec9-93b2-941396e09bfa', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (620, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 16:12:53.445+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '909ade44-4d93-48ed-b6a2-b4514e7aebd5', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (621, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 16:12:53.808+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', '96889676-413d-4e8e-a61d-836ad7799ef8', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (622, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 16:12:54.302+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '3b20c117-7bf0-46ee-8c14-234e7714a17f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (623, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 16:13:39.555+00', '54.86.50.139', 'PostmanRuntime/7.43.4', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (624, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 16:13:50.244+00', '54.86.50.139', 'PostmanRuntime/7.43.4', 'Order', '00000000-0000-0000-0000-000000000013', NULL);
INSERT INTO public.directus_activity VALUES (625, 'run', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 16:13:50.661+00', '54.86.50.139', 'PostmanRuntime/7.43.4', 'directus_flows', '3b20c117-7bf0-46ee-8c14-234e7714a17f', NULL);
INSERT INTO public.directus_activity VALUES (626, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 16:17:01.97+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '05d702bd-3f09-4a0b-9b4c-ca574255c4e7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (627, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 16:17:56.929+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '05d702bd-3f09-4a0b-9b4c-ca574255c4e7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (628, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 16:18:30.305+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '05d702bd-3f09-4a0b-9b4c-ca574255c4e7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (629, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 16:18:46.969+00', '200.3.193.226', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (630, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 23:13:06.5+00', '191.95.55.94', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '139', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (631, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 14:45:18.379+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '140', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (632, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 14:51:22.587+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '141', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (633, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 15:53:11.151+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '142', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (634, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 15:53:23.982+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '143', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (635, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 15:53:28.754+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '144', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (636, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 15:54:30.591+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '145', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (637, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 21:39:11.93+00', '54.86.50.139', 'PostmanRuntime/7.43.4', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (638, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 21:42:01.566+00', '190.108.76.176', 'okhttp/4.12.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (639, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-17 22:20:31.089+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (640, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-17 22:20:56.813+00', '181.32.88.187', 'okhttp/4.12.0', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (641, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:31:25.698+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (642, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:35:31.242+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '146', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (643, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:35:31.492+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'ProductCategory', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (644, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:35:46.682+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'ProductCategory', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (645, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:35:46.93+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '146', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (646, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:36:04.762+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '147', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (647, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:36:05.02+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'ProductCategory', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (648, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:37:10.452+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '148', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (649, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:38:55.783+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '149', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (650, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:39:28.657+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '150', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (651, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:40:35.167+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', '8893bbf2-2267-4a26-89bb-815087c5c859', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (652, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:40:35.931+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', 'e6813b20-857a-4a84-878e-6857867a5cea', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (653, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:40:36.657+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', '6f41a854-d702-43c6-a3af-e91c5bae8128', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (654, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:40:37.338+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', '00000000-0000-0000-0000-00000000000e', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (655, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:40:37.932+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'ProductCategory', 'Moda', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (656, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:41:37.724+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'ProductCategory', 'Moda', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (657, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:42:03.641+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '148', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (658, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:43:20.221+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', 'e6813b20-857a-4a84-878e-6857867a5cea', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (659, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:43:20.902+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', '8893bbf2-2267-4a26-89bb-815087c5c859', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (660, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:43:21.589+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', '6f41a854-d702-43c6-a3af-e91c5bae8128', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (661, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:43:22.265+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', '00000000-0000-0000-0000-00000000000e', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (662, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 22:43:22.858+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'ProductCategory', 'Moda', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (663, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 23:19:22.572+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '33', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (664, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 23:19:22.822+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (665, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 23:20:17.807+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '150', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (666, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 23:20:40.361+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '150', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (667, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 23:21:09.866+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '33', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (668, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 23:21:10.195+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (669, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-17 23:21:18.849+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (670, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 23:22:57.863+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '16', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (671, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 23:22:58.3+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (672, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-17 23:23:22.75+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (673, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-17 23:23:38.608+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (674, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 23:25:00.398+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (675, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 23:28:18.956+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '30', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (676, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-17 23:28:19.29+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (677, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-17 23:46:38.913+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (678, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-17 23:46:55.599+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'Product', '62f6a448-ad01-4528-82f0-29f84d8e7e9d', NULL);
INSERT INTO public.directus_activity VALUES (679, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-17 23:47:42.404+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'Product', '6eff820a-322b-426a-aae6-fff032719f34', NULL);
INSERT INTO public.directus_activity VALUES (680, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 00:48:45.77+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (681, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 00:54:43.454+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '34', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (682, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 00:54:43.787+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (683, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 00:54:44.134+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (684, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 00:55:31.193+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '35', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (685, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 00:55:31.473+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (686, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 00:57:34.563+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '36', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (687, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 00:57:34.812+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (688, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 00:58:11.373+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '36', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (689, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 00:58:11.701+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (690, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 00:58:37.939+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '36', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (691, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 00:58:38.274+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (692, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 02:19:50.646+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (693, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 03:22:20.784+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '22', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (694, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 03:22:21.119+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (695, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:22:39.783+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (696, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:22:45.051+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'Product', '52dae876-5b45-4966-a80d-da879b514931', NULL);
INSERT INTO public.directus_activity VALUES (697, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 03:24:59.034+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '37', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (698, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 03:24:59.296+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '38', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (699, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 03:24:59.547+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (700, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 03:25:39.493+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '37', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (701, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 03:25:39.925+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '38', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (702, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 03:25:40.272+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (703, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:25:44.284+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'ProductSpecification', '9ab6d3ef-2a07-4520-9ea7-8341990493d3', NULL);
INSERT INTO public.directus_activity VALUES (704, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:25:44.536+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'Product', 'f51f4492-f4ba-426d-8889-f1b54de5010a', NULL);
INSERT INTO public.directus_activity VALUES (705, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:26:21.29+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'ProductVariant', 'd64d917c-3db2-4e12-8d48-f3dd93fbad2c', NULL);
INSERT INTO public.directus_activity VALUES (706, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:26:21.624+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'ProductSpecification', 'b72e9f3c-ab4c-405b-9a97-f6c37f35a3cd', NULL);
INSERT INTO public.directus_activity VALUES (707, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:26:21.872+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'Product', 'fac48e36-bfd9-47e8-a47d-234e7ca98465', NULL);
INSERT INTO public.directus_activity VALUES (708, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 03:27:08.45+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '39', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (709, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 03:27:08.752+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (710, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:28:03.74+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'ProductImage', 'bd4560e9-c957-425f-a63e-5dd102b72730', NULL);
INSERT INTO public.directus_activity VALUES (711, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:28:04.025+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'ProductVariant', 'a60aba3d-9ab3-4645-a2a4-660dd2f093ad', NULL);
INSERT INTO public.directus_activity VALUES (712, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:28:04.534+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'ProductSpecification', 'af3e18b6-4989-4e3e-9069-636a1d6b7994', NULL);
INSERT INTO public.directus_activity VALUES (713, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:28:04.795+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'Product', 'd33dd371-e9e3-4083-850c-640a81dd7921', NULL);
INSERT INTO public.directus_activity VALUES (716, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:58:33.439+00', '181.32.88.187', 'okhttp/4.12.0', 'ProductVariant', 'fe811dba-6665-4baa-a3d3-0fc042158dd4', NULL);
INSERT INTO public.directus_activity VALUES (717, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:58:33.764+00', '181.32.88.187', 'okhttp/4.12.0', 'ProductSpecification', '9ea44edf-8e3d-49c6-948a-c0d7580eb488', NULL);
INSERT INTO public.directus_activity VALUES (718, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:58:34.014+00', '181.32.88.187', 'okhttp/4.12.0', 'Product', 'b1b64781-763c-4b14-8017-00380cff05d0', NULL);
INSERT INTO public.directus_activity VALUES (719, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:59:15.704+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'ProductImage', '6d62415f-aecd-4552-8ef1-7ea8adc07fe6', NULL);
INSERT INTO public.directus_activity VALUES (720, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:59:16.051+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'ProductVariant', '0d136607-35ae-4f93-9acb-0f3e29dfedf6', NULL);
INSERT INTO public.directus_activity VALUES (721, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:59:16.459+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'ProductSpecification', 'a18a944e-c8c4-46ab-9beb-494bfa68cd5f', NULL);
INSERT INTO public.directus_activity VALUES (722, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 03:59:16.701+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'Product', '422cf1dd-efde-42c9-a258-9165dc37fc58', NULL);
INSERT INTO public.directus_activity VALUES (723, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 04:01:23.237+00', '181.32.88.187', 'okhttp/4.12.0', 'ProductVariant', '2b678685-68ab-4428-9372-e50198f2ce16', NULL);
INSERT INTO public.directus_activity VALUES (724, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 04:01:23.555+00', '181.32.88.187', 'okhttp/4.12.0', 'ProductSpecification', 'd274a16e-ef01-4496-ba1f-5f92eee5b9d8', NULL);
INSERT INTO public.directus_activity VALUES (725, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 04:01:23.795+00', '181.32.88.187', 'okhttp/4.12.0', 'Product', 'aa8131c1-b1eb-4f10-a85a-e6bf64b18bf6', NULL);
INSERT INTO public.directus_activity VALUES (726, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:12:45.305+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (727, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:18:42.851+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '151', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (728, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:19:14.106+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '152', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (729, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:34:40.684+00', '191.95.54.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (730, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 16:39:23.111+00', '191.95.54.40', 'okhttp/4.12.0', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (731, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:40:18.497+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '40', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (732, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:40:18.846+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '30', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (733, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:40:19.304+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (734, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:40:19.812+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '23', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (735, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:40:20.286+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (736, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:40:50.653+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (737, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:40:50.984+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (738, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:41:05.068+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '30', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (739, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:41:05.389+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (740, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:42:49.38+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (741, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:42:49.794+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '36', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (742, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:42:50.204+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '35', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (743, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:42:50.614+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '34', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (744, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:42:50.943+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (745, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:49:07.128+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '41', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (746, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:49:07.373+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '42', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (747, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:49:07.615+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '43', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (748, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:49:07.856+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '44', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (749, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:49:08.095+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '45', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (750, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:49:08.334+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (751, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 16:51:54.775+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (752, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 16:53:10.537+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductImage', '6196af9e-d0d4-4b07-978c-a40a9e28f16c', NULL);
INSERT INTO public.directus_activity VALUES (753, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 16:53:10.783+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductVariant', '531d0ad5-e394-49fa-b064-5ef299c944f9', NULL);
INSERT INTO public.directus_activity VALUES (754, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 16:53:11.295+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductSpecification', '9a8ba045-db02-487c-9fb2-150c2a44da2c', NULL);
INSERT INTO public.directus_activity VALUES (755, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 16:53:11.54+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'Product', '62f6a448-ad01-4528-82f0-29f84d8e7e9d', NULL);
INSERT INTO public.directus_activity VALUES (758, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:54:50.677+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '43', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (759, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:54:51.106+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '41', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (835, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:10:51.189+00', '186.168.154.36', 'okhttp/4.12.0', 'ProductSpecification', '00000000-0000-0000-0000-000000000011', NULL);
INSERT INTO public.directus_activity VALUES (760, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:54:51.454+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (761, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:57:04.844+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '153', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (762, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:58:00.211+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', '422cf1dd-efde-42c9-a258-9165dc37fc58', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (763, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:58:00.3+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', '52dae876-5b45-4966-a80d-da879b514931', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (764, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:58:00.398+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', '62f6a448-ad01-4528-82f0-29f84d8e7e9d', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (765, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:58:00.485+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', '6eff820a-322b-426a-aae6-fff032719f34', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (766, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:58:00.572+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', '6f41a854-d702-43c6-a3af-e91c5bae8128', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (767, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:58:00.658+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', '8893bbf2-2267-4a26-89bb-815087c5c859', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (768, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:58:00.747+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', 'aa8131c1-b1eb-4f10-a85a-e6bf64b18bf6', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (769, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:58:00.839+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', 'b1b64781-763c-4b14-8017-00380cff05d0', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (770, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:58:00.924+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', 'd33dd371-e9e3-4083-850c-640a81dd7921', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (771, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:58:01.016+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', 'e6813b20-857a-4a84-878e-6857867a5cea', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (772, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:58:01.11+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', 'f51f4492-f4ba-426d-8889-f1b54de5010a', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (773, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 16:58:01.195+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', 'fac48e36-bfd9-47e8-a47d-234e7ca98465', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (774, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 16:59:38.005+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductImage', 'd80f8c93-e79a-401a-8a37-2b3c0d0227de', NULL);
INSERT INTO public.directus_activity VALUES (775, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 16:59:38.258+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductVariant', '36d475f6-bf51-4113-b565-29e376899839', NULL);
INSERT INTO public.directus_activity VALUES (776, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 16:59:38.769+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductSpecification', 'a548c783-2e75-444b-aba0-cca4c756e6ac', NULL);
INSERT INTO public.directus_activity VALUES (777, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 16:59:39.02+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'Product', 'fafbbda3-3958-47aa-a4d4-3c02200dedee', NULL);
INSERT INTO public.directus_activity VALUES (780, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:00:47.243+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (781, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:10:11.456+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '43', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (782, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:10:11.806+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (787, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:11:16.882+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '43', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (788, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:11:17.221+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (793, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:11:50.81+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '43', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (794, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:11:51.146+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (795, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:19:38.93+00', '181.62.251.242', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (796, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:20:10.151+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '28efc141-52c8-4cf7-854f-6ef43f3a0568', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (797, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:25:26.429+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', '28efc141-52c8-4cf7-854f-6ef43f3a0568', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (798, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:29:36.514+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'b02c0861-b56e-48a7-abba-5c31ae2075d5', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (799, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:30:59.763+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'b02c0861-b56e-48a7-abba-5c31ae2075d5', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (800, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:36:13.26+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', 'abac974e-6984-4a11-b7db-e59ce19c82c3', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (801, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:36:13.518+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_operations', 'e52a3ed0-a122-4a1f-a436-6d47af1a59a7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (802, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:36:13.944+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'b02c0861-b56e-48a7-abba-5c31ae2075d5', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (803, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 17:37:32.607+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductSpecification', '76b6bd5f-b898-4d84-a365-bae0186e140c', NULL);
INSERT INTO public.directus_activity VALUES (804, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 17:37:33.243+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductSpecification', 'a548c783-2e75-444b-aba0-cca4c756e6ac', NULL);
INSERT INTO public.directus_activity VALUES (805, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 17:37:33.861+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductImage', '1851227e-4bcd-4e88-a5e6-b05371354fd8', NULL);
INSERT INTO public.directus_activity VALUES (806, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 17:37:34.127+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductVariant', '5e52293a-60eb-45fc-8e7b-fb626b046b59', NULL);
INSERT INTO public.directus_activity VALUES (807, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 17:37:34.841+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductVariant', '36d475f6-bf51-4113-b565-29e376899839', NULL);
INSERT INTO public.directus_activity VALUES (808, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 17:37:35.182+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'Product', 'fafbbda3-3958-47aa-a4d4-3c02200dedee', NULL);
INSERT INTO public.directus_activity VALUES (809, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:39:05.189+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_flows', 'b02c0861-b56e-48a7-abba-5c31ae2075d5', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (810, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 17:54:23.909+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (814, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:56:47.921+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '46', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (815, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 17:56:48.171+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (819, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 17:57:22.428+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductSpecification', 'fcf1e8aa-b45d-4258-bec8-4a7a55622ad3', NULL);
INSERT INTO public.directus_activity VALUES (820, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 17:57:23.06+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductSpecification', '76b6bd5f-b898-4d84-a365-bae0186e140c', NULL);
INSERT INTO public.directus_activity VALUES (821, 'create', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 17:57:23.979+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductImage', 'e4ca3c82-e983-48c5-86ec-e5664800be02', NULL);
INSERT INTO public.directus_activity VALUES (822, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 17:57:24.559+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductImage', '1851227e-4bcd-4e88-a5e6-b05371354fd8', NULL);
INSERT INTO public.directus_activity VALUES (823, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 17:57:24.805+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductVariant', '5e52293a-60eb-45fc-8e7b-fb626b046b59', NULL);
INSERT INTO public.directus_activity VALUES (824, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 17:57:25.292+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'Product', 'fafbbda3-3958-47aa-a4d4-3c02200dedee', NULL);
INSERT INTO public.directus_activity VALUES (825, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 18:55:50.072+00', '186.168.154.36', 'okhttp/4.12.0', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (826, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 18:59:16.136+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (827, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:07:59.111+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductSpecification', 'fcf1e8aa-b45d-4258-bec8-4a7a55622ad3', NULL);
INSERT INTO public.directus_activity VALUES (828, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:08:00.16+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductImage', 'e4ca3c82-e983-48c5-86ec-e5664800be02', NULL);
INSERT INTO public.directus_activity VALUES (829, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:08:00.517+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'ProductVariant', '5e52293a-60eb-45fc-8e7b-fb626b046b59', NULL);
INSERT INTO public.directus_activity VALUES (830, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:08:01.041+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'Product', 'fafbbda3-3958-47aa-a4d4-3c02200dedee', NULL);
INSERT INTO public.directus_activity VALUES (831, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:09:42.166+00', '186.168.154.36', 'okhttp/4.12.0', 'ProductSpecification', '00000000-0000-0000-0000-000000000011', NULL);
INSERT INTO public.directus_activity VALUES (832, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:09:43.204+00', '186.168.154.36', 'okhttp/4.12.0', 'ProductImage', '00000000-0000-0000-0000-000000000010', NULL);
INSERT INTO public.directus_activity VALUES (833, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:09:43.533+00', '186.168.154.36', 'okhttp/4.12.0', 'ProductVariant', '00000000-0000-0000-0000-00000000000f', NULL);
INSERT INTO public.directus_activity VALUES (834, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:09:44.034+00', '186.168.154.36', 'okhttp/4.12.0', 'Product', '00000000-0000-0000-0000-00000000000e', NULL);
INSERT INTO public.directus_activity VALUES (836, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:10:52.199+00', '186.168.154.36', 'okhttp/4.12.0', 'ProductImage', '00000000-0000-0000-0000-000000000010', NULL);
INSERT INTO public.directus_activity VALUES (837, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:10:52.535+00', '186.168.154.36', 'okhttp/4.12.0', 'ProductVariant', '00000000-0000-0000-0000-00000000000f', NULL);
INSERT INTO public.directus_activity VALUES (838, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:10:53.058+00', '186.168.154.36', 'okhttp/4.12.0', 'Product', '00000000-0000-0000-0000-00000000000e', NULL);
INSERT INTO public.directus_activity VALUES (839, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:21:27.922+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '151', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (840, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:22:06.944+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '154', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (841, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:22:22.701+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '152', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (842, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:22:40.497+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '155', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (843, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:26:30+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '18', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (844, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:26:30.428+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '30', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (845, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:26:30.852+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '23', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (846, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:26:31.289+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '41', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (847, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:26:31.732+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '40', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (848, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:26:32.157+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '42', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (849, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:26:32.581+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '43', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (850, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:26:33.01+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '44', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (851, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:26:33.357+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (852, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:28:45.297+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '23', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (853, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:28:45.636+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (854, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:32:32.516+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (855, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:32:32.845+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (856, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:34:23.166+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (857, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:34:23.496+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (858, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:34:43.27+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (859, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:35:08.336+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (860, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:35:08.696+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (861, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:35:16.052+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (862, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-18 19:35:55.312+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (863, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:36:04.831+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (864, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:38:07.822+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '34', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (865, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:38:08.249+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '35', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (866, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:38:08.671+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '36', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (867, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:38:09.009+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (868, 'login', '424fbc11-d0b9-438a-8685-69d0fc7674d1', '2025-05-18 19:38:15.633+00', '169.254.42.1', 'axios/1.8.4', 'directus_users', '424fbc11-d0b9-438a-8685-69d0fc7674d1', NULL);
INSERT INTO public.directus_activity VALUES (869, 'run', NULL, '2025-05-18 19:38:15.977+00', NULL, NULL, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', NULL);
INSERT INTO public.directus_activity VALUES (870, 'create', NULL, '2025-05-18 19:38:16.575+00', NULL, NULL, 'user_profile', '424fbc11-d0b9-438a-8685-69d0fc7674d1', NULL);
INSERT INTO public.directus_activity VALUES (871, 'run', NULL, '2025-05-18 19:38:16.919+00', NULL, NULL, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', NULL);
INSERT INTO public.directus_activity VALUES (872, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:38:36.274+00', '186.168.154.36', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (873, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:40:04.14+00', '186.168.154.36', 'okhttp/4.12.0', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (874, 'update', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-18 19:45:55.967+00', '186.168.154.36', 'okhttp/4.12.0', 'Product', '00000000-0000-0000-0000-00000000000e', NULL);
INSERT INTO public.directus_activity VALUES (875, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:51:52.602+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (876, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:51:52.951+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (877, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:52:46.988+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Product', '00000000-0000-0000-0000-00000000000e', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (878, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:53:18.999+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'ProductImage', '1851227e-4bcd-4e88-a5e6-b05371354fd8', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (879, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:54:27.359+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'ProductImage', '00000000-0000-0000-0000-000000000010', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (880, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:54:47.311+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'ProductImage', 'd80f8c93-e79a-401a-8a37-2b3c0d0227de', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (881, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 19:55:08.717+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'ProductImage', 'e4ca3c82-e983-48c5-86ec-e5664800be02', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (882, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 21:39:50.97+00', '54.86.50.139', 'PostmanRuntime/7.43.4', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (883, 'login', 'af52ffb9-09a6-4997-9169-0f168ac8dde4', '2025-05-18 23:41:33.996+00', '169.254.42.1', 'axios/1.8.4', 'directus_users', 'af52ffb9-09a6-4997-9169-0f168ac8dde4', NULL);
INSERT INTO public.directus_activity VALUES (884, 'run', NULL, '2025-05-18 23:41:34.348+00', NULL, NULL, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', NULL);
INSERT INTO public.directus_activity VALUES (885, 'create', NULL, '2025-05-18 23:41:35.001+00', NULL, NULL, 'user_profile', 'af52ffb9-09a6-4997-9169-0f168ac8dde4', NULL);
INSERT INTO public.directus_activity VALUES (886, 'run', NULL, '2025-05-18 23:41:35.349+00', NULL, NULL, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', NULL);
INSERT INTO public.directus_activity VALUES (887, 'login', 'af52ffb9-09a6-4997-9169-0f168ac8dde4', '2025-05-18 23:41:49.309+00', '186.168.154.36', 'okhttp/4.12.0', 'directus_users', 'af52ffb9-09a6-4997-9169-0f168ac8dde4', NULL);
INSERT INTO public.directus_activity VALUES (888, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 23:50:53.93+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (889, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 23:50:54.273+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (890, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 23:51:47.761+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'af52ffb9-09a6-4997-9169-0f168ac8dde4', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (891, 'login', 'af52ffb9-09a6-4997-9169-0f168ac8dde4', '2025-05-18 23:52:39.762+00', '186.168.154.36', 'okhttp/4.12.0', 'directus_users', 'af52ffb9-09a6-4997-9169-0f168ac8dde4', NULL);
INSERT INTO public.directus_activity VALUES (892, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 23:52:58.402+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (893, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 23:52:58.761+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (894, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 23:53:14.792+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_settings', '1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (895, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 23:53:33.122+00', '54.86.50.139', 'PostmanRuntime/7.43.4', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (896, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-18 23:54:02.131+00', '190.108.76.176', 'okhttp/4.12.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (897, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 00:27:27.906+00', '54.86.50.139', 'PostmanRuntime/7.43.4', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (898, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 00:49:04.121+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'EntrepreneurshipCustomization', '00000000-0000-0000-0000-000000000003', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (899, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 01:38:14.409+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '156', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (900, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 01:38:16.645+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '157', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (901, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 01:38:16.898+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Entrepreneurship_Tags_1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (902, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 01:38:18.806+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '158', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (903, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 01:38:21.047+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '159', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (904, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-19 02:12:14.568+00', '186.168.154.36', 'okhttp/4.12.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (905, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-19 02:15:16.598+00', '186.168.154.36', 'okhttp/4.12.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (906, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-19 02:20:13.042+00', '186.168.154.36', 'okhttp/4.12.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (907, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-19 02:30:12.211+00', '186.168.154.36', 'okhttp/4.12.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (908, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-19 02:33:48.638+00', '186.168.154.36', 'okhttp/4.12.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (909, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-19 02:36:10.814+00', '186.168.154.36', 'okhttp/4.12.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (910, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-19 02:38:35.09+00', '181.32.88.187', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (911, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-19 02:40:24.438+00', '186.168.154.36', 'okhttp/4.12.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (912, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-19 02:42:46.044+00', '186.168.154.36', 'okhttp/4.12.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (913, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-19 02:50:43.214+00', '186.168.154.36', 'okhttp/4.12.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (914, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-19 02:51:53.645+00', '186.168.154.36', 'okhttp/4.12.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (915, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-19 02:54:37.932+00', '186.168.154.36', 'okhttp/4.12.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (916, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-19 02:57:25.042+00', '186.168.154.36', 'okhttp/4.12.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (917, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-19 03:34:27.739+00', '181.32.88.187', 'PostmanRuntime/7.44.0', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (918, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 04:11:12.19+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_roles', '22222222-2222-2222-2222-222222222222', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (919, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 04:11:33.393+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_roles', '11111111-1111-1111-1111-111111111111', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (920, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-19 05:09:49.318+00', '181.32.88.187', 'PostmanRuntime/7.44.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (921, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 05:12:19.293+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '47', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (922, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 05:12:19.551+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (923, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-19 05:28:12.128+00', '181.32.88.187', 'okhttp/4.12.0', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (924, 'login', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-19 05:30:45.728+00', '181.32.88.187', 'okhttp/4.12.0', 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', NULL);
INSERT INTO public.directus_activity VALUES (925, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:31:56.09+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Tags', 'b57415c5-23af-4519-9f03-36366174c23d', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (926, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:32:12.121+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Tags', '2f84e0cc-1bfb-421d-ade7-1fa5b4f9d13b', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (927, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:32:25.693+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Tags', 'c73936d7-2913-4b40-af31-0a86a0e8b894', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (928, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:32:31.548+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Tags', '7df5fb03-526c-40fd-a46b-c3c4cd3400a1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (929, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:32:47.329+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Tags', '603107c1-2519-4e3d-b9b7-23cd8ec82c6e', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (930, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:33:00.806+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Tags', '9b8ff68b-ffed-42d6-bab4-651b455d7ab0', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (931, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:33:14.567+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Tags', '603107c1-2519-4e3d-b9b7-23cd8ec82c6e', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (932, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:33:39.303+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Tags', '83c2533e-8014-4b49-bb30-87a1617dd9ec', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (933, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:33:45.954+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Tags', 'f1d479f9-8332-46ac-a3e5-cd9cf551b936', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (934, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:33:53.165+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Tags', 'e4dda122-35d9-4d15-8678-64797339acbe', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (935, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:34:00.516+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Tags', '0c062ab0-921c-4fab-a30d-6eeb9ffe6bd1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (936, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:37:43.083+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Tags', '7df5fb03-526c-40fd-a46b-c3c4cd3400a1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (942, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:37:51.432+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Entrepreneurship', '00000000-0000-0000-0000-000000000007', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (943, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:41:36.804+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'EntrepreneurshipCustomization', '00000000-0000-0000-0000-000000000003', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (944, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:45:24.219+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Entrepreneurship', '00000000-0000-0000-0000-000000000007', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (945, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:57:17.13+00', '54.86.50.139', 'PostmanRuntime/7.44.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (946, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 06:57:19.474+00', '54.86.50.139', 'PostmanRuntime/7.44.0', 'Entrepreneurship', '00000000-0000-0000-0000-000000000007', NULL);
INSERT INTO public.directus_activity VALUES (947, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 07:14:08.667+00', '54.86.50.139', 'PostmanRuntime/7.44.0', 'Entrepreneurship', '00000000-0000-0000-0000-000000000007', NULL);
INSERT INTO public.directus_activity VALUES (948, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 13:15:18.253+00', '54.86.50.139', 'PostmanRuntime/7.44.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (949, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 13:52:02.916+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Entrepreneurship_Tags', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (950, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 13:52:08.788+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Entrepreneurship_Tags_1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (951, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 14:00:46.136+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Entrepreneurship_Tags_1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (952, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 14:00:46.382+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '157', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (953, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 14:00:46.477+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '158', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (954, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 14:00:46.561+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '159', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (955, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 14:00:47.819+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '156', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (956, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 14:02:07.672+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '160', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (957, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 14:02:09.821+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '161', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (958, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 14:02:10.073+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Entrepreneurship_Tags', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (959, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 14:02:11.89+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '162', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (960, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 14:02:14.07+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '163', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (961, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 14:02:53.71+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Entrepreneurship_Tags', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (967, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 14:04:55.459+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Entrepreneurship', '00000000-0000-0000-0000-000000000007', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (968, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 14:33:13.406+00', '54.86.50.139', 'PostmanRuntime/7.44.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (969, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-19 15:44:23.249+00', '200.3.193.225', 'okhttp/4.12.0', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (970, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 17:08:18.116+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (971, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-19 17:21:09.906+00', '200.3.193.227', 'okhttp/4.12.0', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (972, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-19 17:30:57.32+00', '200.3.193.227', 'okhttp/4.12.0', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (973, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-19 20:53:59.883+00', '200.3.193.229', 'PostmanRuntime/7.43.4', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (974, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 20:56:27.932+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '30', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (975, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 20:56:28.278+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (976, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 20:57:03.504+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '30', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (977, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 20:57:03.862+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (978, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 20:58:32.068+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '30', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (979, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 20:58:32.407+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (980, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 20:59:00.568+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '16', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (981, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 20:59:00.899+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (982, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:03:26.936+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '160', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (983, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:04:15.964+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '164', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (984, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:04:51.091+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '164', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (985, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:05:13.589+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Entrepreneurship_Tags', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (986, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:05:13.997+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '161', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (987, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:05:14.097+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '162', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (988, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:05:14.217+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '163', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (989, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:05:52.257+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '165', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (990, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:05:52.517+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'EntrepreneurshipTags', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (991, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:06:32.885+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '166', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (992, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:06:58.352+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '167', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (993, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:07:45.207+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '168', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (994, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:08:20.018+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '169', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (998, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:10:36.605+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '170', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (999, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:10:38.953+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '171', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1000, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:10:39.205+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Entrepreneurship_Tags', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1001, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:10:41.433+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '172', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1002, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:10:43.916+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '173', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1003, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:11:21.632+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '48', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1004, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:11:21.892+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '49', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1005, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:11:22.145+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1015, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:11:49.087+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Entrepreneurship', '00000000-0000-0000-0000-000000000007', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1016, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:12:27.329+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '16', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1017, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:12:27.711+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1018, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:13:59.383+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'EntrepreneurshipTags', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1019, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:13:59.632+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '165', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1020, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:13:59.713+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '166', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1021, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:13:59.797+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '167', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1022, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:14:01.107+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '168', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1023, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:14:01.712+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '169', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1024, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:14:11.088+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '170', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1025, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:14:18.079+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Entrepreneurship_Tags', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1026, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:14:18.325+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '171', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1027, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:14:18.407+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '172', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1028, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:14:18.488+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '173', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1029, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:14:41.851+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '174', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1030, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:14:44.067+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '175', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1031, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:14:44.31+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Entrepreneurship_Tags', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1032, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:14:46.627+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '176', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1033, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:14:48.86+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '177', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1034, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:17:02.623+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '50', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1035, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:17:02.997+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '16', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1036, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:17:03.358+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1037, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:17:29.739+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Entrepreneurship_Tags', '1', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1038, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:17:30.07+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Entrepreneurship_Tags', '2', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1039, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:17:30.433+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Entrepreneurship_Tags', '3', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1040, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:17:30.786+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Entrepreneurship_Tags', '4', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1041, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:17:31.122+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Entrepreneurship_Tags', '5', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1042, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:17:31.389+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'Entrepreneurship', '00000000-0000-0000-0000-000000000007', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1043, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:21:31.83+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '178', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1044, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:21:34.026+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '179', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1045, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:21:34.269+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Tags_Entrepreneurship', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1046, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:21:36.318+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '180', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1047, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:21:38.718+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '181', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1048, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:22:18.939+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_collections', 'Tags_Entrepreneurship', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1049, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:22:19.182+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '179', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1050, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:22:19.262+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '180', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1051, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:22:19.344+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '181', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1052, 'delete', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:22:20.506+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '178', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1053, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:22:49.098+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_fields', '182', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1054, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:23:40.375+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '49', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1055, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:23:40.71+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1056, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:24:08.493+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '49', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1057, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-19 21:24:08.839+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1058, 'login', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-20 00:20:21.132+00', '54.86.50.139', 'PostmanRuntime/7.44.0', 'directus_users', 'f49db054-0000-4460-bb03-2f783370e377', NULL);
INSERT INTO public.directus_activity VALUES (1059, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-20 00:23:31.668+00', '190.108.76.176', 'okhttp/4.12.0', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (1060, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-20 01:11:14.724+00', '54.86.50.139', 'PostmanRuntime/7.44.0', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (1061, 'login', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-20 03:33:05.752+00', '181.32.88.187', 'PostmanRuntime/7.44.0', 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', NULL);
INSERT INTO public.directus_activity VALUES (1062, 'create', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-20 03:39:15.85+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_permissions', '51', 'http://35.231.238.114');
INSERT INTO public.directus_activity VALUES (1063, 'update', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-20 03:39:16.114+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', 'http://35.231.238.114');


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_collections VALUES ('user_profile', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('SubscriptionPlans', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Banner', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Collaboration', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('DeliveryStatus', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('CollaborationImage', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('CollaborationMembers', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('CollaborationProducts', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Delivery', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('DeliveryStatusLog', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('UserStatus', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Verification', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Entrepreneurship', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('University', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Tags', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Review', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('EntrepreneurshipCustomization', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('EntrepreneurshipSubscription', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Partner', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('EntrepreneurshipType', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Product', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('NotificationType', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('ProductVariant', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('ProductSpecification', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('ProductImage', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Notification', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Order', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('OrderDetail', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('PartnerRol', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Payment', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('PaymentMethod', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('PaymentEvidence', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('OrderStatus', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('SocialNetwork', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('ProductCategory', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Entrepreneurship_Tags', 'import_export', NULL, NULL, true, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);


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

INSERT INTO public.directus_fields VALUES (1, 'Collaboration', 'description', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (3, 'Notification', 'id', NULL, NULL, NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (4, 'Notification', 'user_profile', NULL, NULL, NULL, NULL, NULL, false, false, 2, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (5, 'Notification', 'type', NULL, NULL, NULL, NULL, NULL, false, false, 3, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (6, 'Notification', 'title', NULL, NULL, NULL, NULL, NULL, false, false, 4, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (7, 'Notification', 'content', NULL, NULL, NULL, NULL, NULL, false, false, 5, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (2, 'Notification', 'is_read', 'cast-boolean', NULL, NULL, NULL, NULL, false, false, 6, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (8, 'Order', 'entrepreneurship', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (11, 'OrderStatus', 'id', 'uuid', 'input', NULL, NULL, NULL, true, true, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (12, 'OrderStatus', 'name', NULL, NULL, NULL, NULL, NULL, false, false, 2, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (15, 'Delivery', 'partner', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (16, 'Delivery', 'type', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (17, 'Delivery', 'status', 'm2o', NULL, NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (23, 'user_profile', 'id', NULL, NULL, NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (19, 'user_profile', 'profile_picture', NULL, NULL, NULL, NULL, NULL, false, false, 3, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (20, 'user_profile', 'document', NULL, NULL, NULL, NULL, NULL, false, false, 4, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (21, 'user_profile', 'document_type', NULL, NULL, NULL, NULL, NULL, false, false, 5, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (22, 'user_profile', 'status', NULL, NULL, NULL, NULL, NULL, false, false, 6, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (24, 'user_profile', 'registration_date', 'date-created', NULL, NULL, NULL, NULL, false, false, 7, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (26, 'user_profile', 'verification', NULL, NULL, NULL, NULL, NULL, false, false, 9, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (27, 'user_profile', 'user_rating', NULL, NULL, NULL, NULL, NULL, false, false, 10, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (28, 'user_profile', 'partner_rating', NULL, NULL, NULL, NULL, NULL, false, false, 11, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (18, 'user_profile', 'university', NULL, NULL, NULL, NULL, NULL, false, false, 2, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (30, 'Banner', 'id', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (31, 'Banner', 'url', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (32, 'Banner', 'created_at', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (33, 'Entrepreneurship', 'id', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (34, 'Entrepreneurship', 'name', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (36, 'Product', 'id', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (37, 'Product', 'name', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (38, 'Product', 'description', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (39, 'Product', 'price', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (40, 'Product', 'stock_alert', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (41, 'Entrepreneurship', 'slogan', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (42, 'Entrepreneurship', 'description', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (43, 'Entrepreneurship', 'creation_date', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (44, 'Entrepreneurship', 'customization', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (46, 'Entrepreneurship', 'phone', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (47, 'Entrepreneurship', 'subscription', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (48, 'Entrepreneurship', 'status', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (49, 'Entrepreneurship', 'category', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (45, 'Entrepreneurship', 'email', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (9, 'Entrepreneurship', 'user_founder', 'uuid', NULL, NULL, 'related-values', '{"template":"{{id}}{{university}}"}', false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (50, 'University', 'id', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (51, 'University', 'acronym', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (52, 'University', 'name', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (67, 'Product', 'published', 'cast-boolean', NULL, NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (29, 'Product', 'entrepreneurship', NULL, NULL, '{"template":null}', 'related-values', '{"template":"{{id}}{{name}}{{slogan}}"}', false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (14, 'Order', 'status', 'm2o', NULL, NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (82, 'Entrepreneurship', 'partners', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (83, 'user_profile', 'orders', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 12, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (84, 'Collaboration', 'images', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (89, 'user_profile', 'entrepreneurships', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 13, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (90, 'University', 'users', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (91, 'user_profile', 'notifications', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 14, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (92, 'user_profile', 'partner_entrepreneurships', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 15, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (93, 'user_profile', 'reviews', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 16, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (94, 'user_profile', 'delivery_logs', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 17, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (96, 'UserStatus', 'users', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (97, 'Verification', 'user', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (98, 'NotificationType', 'notifications', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (99, 'PartnerRol', 'user_partners', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (100, 'Partner', 'deliveries', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (101, 'DeliveryStatus', 'deliveries', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (102, 'Delivery', 'deliverylogs', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 2, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (103, 'DeliveryStatus', 'deliverylogs', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 2, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (104, 'PaymentMethod', 'payments', 'o2m', 'list-o2m', '{"sort":null}', NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (105, 'Payment', 'payment_evidences', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (106, 'OrderStatus', 'orders', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 3, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (107, 'Order', 'payments', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 2, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (108, 'Order', 'order_details', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 3, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (109, 'Payment', 'total_paid', NULL, NULL, NULL, NULL, NULL, false, false, 2, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (110, 'Collaboration', 'members', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 3, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (111, 'Collaboration', 'products', 'o2m', 'list-o2m', '{"sort":null}', NULL, NULL, false, false, 4, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (112, 'Product', 'reviews', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 2, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (113, 'Product', 'variants', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 3, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (114, 'ProductVariant', 'variant_images', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (115, 'Product', 'specifications', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 4, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (116, 'SubscriptionPlans', 'subscriptions', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (117, 'EntrepreneurshipSubscription', 'entrepreneurship', 'm2o', 'select-dropdown-m2o', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, true, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (118, 'Entrepreneurship', 'products', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 2, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (119, 'Entrepreneurship', 'collaborations', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 3, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (120, 'Entrepreneurship', 'orders', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 4, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (122, 'SocialNetwork', 'id', 'uuid', 'input', NULL, NULL, NULL, true, true, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (123, 'SocialNetwork', 'platform', NULL, NULL, NULL, NULL, NULL, false, false, 2, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (124, 'SocialNetwork', 'url', NULL, NULL, NULL, NULL, NULL, false, false, 3, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (125, 'SocialNetwork', 'entrepreneurship', 'm2o', 'select-dropdown-m2o', NULL, NULL, NULL, false, false, 4, 'full', NULL, NULL, NULL, true, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (126, 'Entrepreneurship', 'social_networks', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 5, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (127, 'EntrepreneurshipCustomization', 'entrepreneurship', 'm2o', 'select-dropdown-m2o', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, true, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (128, 'EntrepreneurshipType', 'entrepreneurships', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (130, 'ProductVariant', 'name', NULL, NULL, NULL, NULL, NULL, false, false, 2, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (131, 'ProductVariant', 'product', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (132, 'ProductVariant', 'id', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (133, 'ProductSpecification', 'key', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (134, 'ProductSpecification', 'value', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (135, 'ProductSpecification', 'product', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (136, 'ProductSpecification', 'id', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (137, 'Order', 'user_profile', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (138, 'Order', 'date', 'date-created', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (139, 'ProductImage', 'id', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (140, 'Review', 'product', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (141, 'ProductVariant', 'stock', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (142, 'Review', 'user_profile', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (143, 'Review', 'comment', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (144, 'Review', 'creation_date', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (145, 'Review', 'rating', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (147, 'ProductCategory', 'name', NULL, 'input', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (149, 'Product', 'category', 'm2o', 'select-dropdown-m2o', NULL, NULL, NULL, false, false, 5, 'full', NULL, NULL, NULL, true, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (148, 'ProductCategory', 'description', NULL, NULL, NULL, NULL, NULL, false, false, 2, 'full', NULL, NULL, NULL, true, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (150, 'ProductCategory', 'products', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 3, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (153, 'ProductImage', 'product_variant', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (154, 'Product', 'deleted_at', NULL, 'datetime', NULL, NULL, NULL, false, false, 6, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (155, 'Entrepreneurship', 'deleted_at', NULL, 'datetime', NULL, NULL, NULL, false, false, 6, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (174, 'Entrepreneurship', 'tags', 'm2m', 'list-m2m', NULL, NULL, NULL, false, false, 7, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (175, 'Entrepreneurship_Tags', 'id', NULL, NULL, NULL, NULL, NULL, false, true, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (176, 'Entrepreneurship_Tags', 'Entrepreneurship_id', NULL, NULL, NULL, NULL, NULL, false, true, 2, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (177, 'Entrepreneurship_Tags', 'Tags_id', NULL, NULL, NULL, NULL, NULL, false, true, 3, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (182, 'Tags', 'entrepreneurships', 'o2m', 'list-o2m', NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_flows VALUES ('3b20c117-7bf0-46ee-8c14-234e7714a17f', 'Maker Order', 'bolt', NULL, NULL, 'active', 'event', 'all', '{"type":"action","scope":["items.update"],"collections":["Order"]}', '96889676-413d-4e8e-a61d-836ad7799ef8', '2025-05-16 15:40:05.547+00', 'f49db054-0000-4460-bb03-2f783370e377');
INSERT INTO public.directus_flows VALUES ('05d702bd-3f09-4a0b-9b4c-ca574255c4e7', 'Get Product', 'content_paste_search', '#E35169', NULL, 'active', 'operation', 'all', '{"return":"$last"}', NULL, '2025-05-16 16:17:01.885+00', 'f49db054-0000-4460-bb03-2f783370e377');
INSERT INTO public.directus_flows VALUES ('66904cac-25ff-48ab-9ee6-a4eac72485b2', 'Get User', 'content_paste_search', '#E35169', NULL, 'active', 'operation', 'all', '{"return":"$last"}', '336d194c-cf1f-410c-af63-ce913f219fb4', '2025-05-15 01:44:35.845+00', 'f49db054-0000-4460-bb03-2f783370e377');
INSERT INTO public.directus_flows VALUES ('aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', 'Register User', 'bolt', NULL, NULL, 'active', 'event', 'all', '{"type":"action","scope":["items.create"],"collections":["directus_users"]}', '0a325417-f595-4af0-b2b4-b8824397d519', '2025-05-14 23:32:24.375+00', 'f49db054-0000-4460-bb03-2f783370e377');


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_migrations VALUES ('20201028A', 'Remove Collection Foreign Keys', '2025-05-13 13:35:44.303437+00');
INSERT INTO public.directus_migrations VALUES ('20201029A', 'Remove System Relations', '2025-05-13 13:35:44.478296+00');
INSERT INTO public.directus_migrations VALUES ('20201029B', 'Remove System Collections', '2025-05-13 13:35:44.662169+00');
INSERT INTO public.directus_migrations VALUES ('20201029C', 'Remove System Fields', '2025-05-13 13:35:44.841797+00');
INSERT INTO public.directus_migrations VALUES ('20201105A', 'Add Cascade System Relations', '2025-05-13 13:35:47.520769+00');
INSERT INTO public.directus_migrations VALUES ('20201105B', 'Change Webhook URL Type', '2025-05-13 13:35:47.892792+00');
INSERT INTO public.directus_migrations VALUES ('20210225A', 'Add Relations Sort Field', '2025-05-13 13:35:48.147449+00');
INSERT INTO public.directus_migrations VALUES ('20210304A', 'Remove Locked Fields', '2025-05-13 13:35:48.315712+00');
INSERT INTO public.directus_migrations VALUES ('20210312A', 'Webhooks Collections Text', '2025-05-13 13:35:48.658901+00');
INSERT INTO public.directus_migrations VALUES ('20210331A', 'Add Refresh Interval', '2025-05-13 13:35:48.827874+00');
INSERT INTO public.directus_migrations VALUES ('20210415A', 'Make Filesize Nullable', '2025-05-13 13:35:49.252674+00');
INSERT INTO public.directus_migrations VALUES ('20210416A', 'Add Collections Accountability', '2025-05-13 13:35:49.50758+00');
INSERT INTO public.directus_migrations VALUES ('20210422A', 'Remove Files Interface', '2025-05-13 13:35:49.682805+00');
INSERT INTO public.directus_migrations VALUES ('20210506A', 'Rename Interfaces', '2025-05-13 13:35:53.183668+00');
INSERT INTO public.directus_migrations VALUES ('20210510A', 'Restructure Relations', '2025-05-13 13:35:54.191384+00');
INSERT INTO public.directus_migrations VALUES ('20210518A', 'Add Foreign Key Constraints', '2025-05-13 13:35:54.454442+00');
INSERT INTO public.directus_migrations VALUES ('20210519A', 'Add System Fk Triggers', '2025-05-13 13:35:55.81519+00');
INSERT INTO public.directus_migrations VALUES ('20210521A', 'Add Collections Icon Color', '2025-05-13 13:35:55.995084+00');
INSERT INTO public.directus_migrations VALUES ('20210525A', 'Add Insights', '2025-05-13 13:35:56.533095+00');
INSERT INTO public.directus_migrations VALUES ('20210608A', 'Add Deep Clone Config', '2025-05-13 13:35:56.714027+00');
INSERT INTO public.directus_migrations VALUES ('20210626A', 'Change Filesize Bigint', '2025-05-13 13:35:57.154608+00');
INSERT INTO public.directus_migrations VALUES ('20210716A', 'Add Conditions to Fields', '2025-05-13 13:35:57.327479+00');
INSERT INTO public.directus_migrations VALUES ('20210721A', 'Add Default Folder', '2025-05-13 13:35:57.614128+00');
INSERT INTO public.directus_migrations VALUES ('20210802A', 'Replace Groups', '2025-05-13 13:35:57.897385+00');
INSERT INTO public.directus_migrations VALUES ('20210803A', 'Add Required to Fields', '2025-05-13 13:35:58.071749+00');
INSERT INTO public.directus_migrations VALUES ('20210805A', 'Update Groups', '2025-05-13 13:35:58.246381+00');
INSERT INTO public.directus_migrations VALUES ('20210805B', 'Change Image Metadata Structure', '2025-05-13 13:35:58.423585+00');
INSERT INTO public.directus_migrations VALUES ('20210811A', 'Add Geometry Config', '2025-05-13 13:35:58.608172+00');
INSERT INTO public.directus_migrations VALUES ('20210831A', 'Remove Limit Column', '2025-05-13 13:35:58.813905+00');
INSERT INTO public.directus_migrations VALUES ('20210903A', 'Add Auth Provider', '2025-05-13 13:35:59.595219+00');
INSERT INTO public.directus_migrations VALUES ('20210907A', 'Webhooks Collections Not Null', '2025-05-13 13:36:00.032594+00');
INSERT INTO public.directus_migrations VALUES ('20210910A', 'Move Module Setup', '2025-05-13 13:36:00.287185+00');
INSERT INTO public.directus_migrations VALUES ('20210920A', 'Webhooks URL Not Null', '2025-05-13 13:36:00.708192+00');
INSERT INTO public.directus_migrations VALUES ('20210924A', 'Add Collection Organization', '2025-05-13 13:36:00.968817+00');
INSERT INTO public.directus_migrations VALUES ('20210927A', 'Replace Fields Group', '2025-05-13 13:36:01.484805+00');
INSERT INTO public.directus_migrations VALUES ('20210927B', 'Replace M2M Interface', '2025-05-13 13:36:01.653906+00');
INSERT INTO public.directus_migrations VALUES ('20210929A', 'Rename Login Action', '2025-05-13 13:36:01.821183+00');
INSERT INTO public.directus_migrations VALUES ('20211007A', 'Update Presets', '2025-05-13 13:36:02.163926+00');
INSERT INTO public.directus_migrations VALUES ('20211009A', 'Add Auth Data', '2025-05-13 13:36:02.339125+00');
INSERT INTO public.directus_migrations VALUES ('20211016A', 'Add Webhook Headers', '2025-05-13 13:36:02.51051+00');
INSERT INTO public.directus_migrations VALUES ('20211103A', 'Set Unique to User Token', '2025-05-13 13:36:02.682602+00');
INSERT INTO public.directus_migrations VALUES ('20211103B', 'Update Special Geometry', '2025-05-13 13:36:02.853654+00');
INSERT INTO public.directus_migrations VALUES ('20211104A', 'Remove Collections Listing', '2025-05-13 13:36:03.024214+00');
INSERT INTO public.directus_migrations VALUES ('20211118A', 'Add Notifications', '2025-05-13 13:36:03.570834+00');
INSERT INTO public.directus_migrations VALUES ('20211211A', 'Add Shares', '2025-05-13 13:36:04.3625+00');
INSERT INTO public.directus_migrations VALUES ('20211230A', 'Add Project Descriptor', '2025-05-13 13:36:04.536128+00');
INSERT INTO public.directus_migrations VALUES ('20220303A', 'Remove Default Project Color', '2025-05-13 13:36:04.963532+00');
INSERT INTO public.directus_migrations VALUES ('20220308A', 'Add Bookmark Icon and Color', '2025-05-13 13:36:05.136339+00');
INSERT INTO public.directus_migrations VALUES ('20220314A', 'Add Translation Strings', '2025-05-13 13:36:05.308338+00');
INSERT INTO public.directus_migrations VALUES ('20220322A', 'Rename Field Typecast Flags', '2025-05-13 13:36:05.487844+00');
INSERT INTO public.directus_migrations VALUES ('20220323A', 'Add Field Validation', '2025-05-13 13:36:05.659621+00');
INSERT INTO public.directus_migrations VALUES ('20220325A', 'Fix Typecast Flags', '2025-05-13 13:36:05.835969+00');
INSERT INTO public.directus_migrations VALUES ('20220325B', 'Add Default Language', '2025-05-13 13:36:06.344164+00');
INSERT INTO public.directus_migrations VALUES ('20220402A', 'Remove Default Value Panel Icon', '2025-05-13 13:36:06.7705+00');
INSERT INTO public.directus_migrations VALUES ('20220429A', 'Add Flows', '2025-05-13 13:36:07.895672+00');
INSERT INTO public.directus_migrations VALUES ('20220429B', 'Add Color to Insights Icon', '2025-05-13 13:36:08.07124+00');
INSERT INTO public.directus_migrations VALUES ('20220429C', 'Drop Non Null From IP of Activity', '2025-05-13 13:36:08.244866+00');
INSERT INTO public.directus_migrations VALUES ('20220429D', 'Drop Non Null From Sender of Notifications', '2025-05-13 13:36:08.414581+00');
INSERT INTO public.directus_migrations VALUES ('20220614A', 'Rename Hook Trigger to Event', '2025-05-13 13:36:08.581982+00');
INSERT INTO public.directus_migrations VALUES ('20220801A', 'Update Notifications Timestamp Column', '2025-05-13 13:36:09.011181+00');
INSERT INTO public.directus_migrations VALUES ('20220802A', 'Add Custom Aspect Ratios', '2025-05-13 13:36:09.180012+00');
INSERT INTO public.directus_migrations VALUES ('20220826A', 'Add Origin to Accountability', '2025-05-13 13:36:09.431726+00');
INSERT INTO public.directus_migrations VALUES ('20230401A', 'Update Material Icons', '2025-05-13 13:36:09.952895+00');
INSERT INTO public.directus_migrations VALUES ('20230525A', 'Add Preview Settings', '2025-05-13 13:36:10.129127+00');
INSERT INTO public.directus_migrations VALUES ('20230526A', 'Migrate Translation Strings', '2025-05-13 13:36:10.490724+00');
INSERT INTO public.directus_migrations VALUES ('20230721A', 'Require Shares Fields', '2025-05-13 13:36:10.757702+00');
INSERT INTO public.directus_migrations VALUES ('20230823A', 'Add Content Versioning', '2025-05-13 13:36:11.458223+00');
INSERT INTO public.directus_migrations VALUES ('20230927A', 'Themes', '2025-05-13 13:36:12.657672+00');
INSERT INTO public.directus_migrations VALUES ('20231009A', 'Update CSV Fields to Text', '2025-05-13 13:36:12.830055+00');
INSERT INTO public.directus_migrations VALUES ('20231009B', 'Update Panel Options', '2025-05-13 13:36:12.998236+00');
INSERT INTO public.directus_migrations VALUES ('20231010A', 'Add Extensions', '2025-05-13 13:36:13.171295+00');
INSERT INTO public.directus_migrations VALUES ('20231215A', 'Add Focalpoints', '2025-05-13 13:36:13.33991+00');
INSERT INTO public.directus_migrations VALUES ('20240122A', 'Add Report URL Fields', '2025-05-13 13:36:13.509187+00');
INSERT INTO public.directus_migrations VALUES ('20240204A', 'Marketplace', '2025-05-13 13:36:15.184336+00');
INSERT INTO public.directus_migrations VALUES ('20240305A', 'Change Useragent Type', '2025-05-13 13:36:15.773836+00');
INSERT INTO public.directus_migrations VALUES ('20240311A', 'Deprecate Webhooks', '2025-05-13 13:36:16.366057+00');
INSERT INTO public.directus_migrations VALUES ('20240422A', 'Public Registration', '2025-05-13 13:36:16.618143+00');
INSERT INTO public.directus_migrations VALUES ('20240515A', 'Add Session Window', '2025-05-13 13:36:16.79733+00');
INSERT INTO public.directus_migrations VALUES ('20240701A', 'Add Tus Data', '2025-05-13 13:36:16.994238+00');
INSERT INTO public.directus_migrations VALUES ('20240716A', 'Update Files Date Fields', '2025-05-13 13:36:17.360414+00');
INSERT INTO public.directus_migrations VALUES ('20240806A', 'Permissions Policies', '2025-05-13 13:36:19.553266+00');
INSERT INTO public.directus_migrations VALUES ('20240817A', 'Update Icon Fields Length', '2025-05-13 13:36:21.700448+00');
INSERT INTO public.directus_migrations VALUES ('20240909A', 'Separate Comments', '2025-05-13 13:36:22.049951+00');
INSERT INTO public.directus_migrations VALUES ('20240909B', 'Consolidate Content Versioning', '2025-05-13 13:36:22.217371+00');
INSERT INTO public.directus_migrations VALUES ('20240924A', 'Migrate Legacy Comments', '2025-05-13 13:36:22.554599+00');
INSERT INTO public.directus_migrations VALUES ('20240924B', 'Populate Versioning Deltas', '2025-05-13 13:36:22.730355+00');
INSERT INTO public.directus_migrations VALUES ('20250224A', 'Visual Editor', '2025-05-13 13:36:22.985495+00');


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_operations VALUES ('9b8eca22-d0f7-44bc-a71c-4444f01d85b1', 'Decode Token', 'decode_token', 'json-web-token', 37, 1, '{"operation":"decode","token":"{{$last.data.data.access_token}}"}', NULL, NULL, '66904cac-25ff-48ab-9ee6-a4eac72485b2', '2025-05-15 02:18:51.432+00', 'f49db054-0000-4460-bb03-2f783370e377');
INSERT INTO public.directus_operations VALUES ('336d194c-cf1f-410c-af63-ce913f219fb4', 'Login', 'login', 'request', 19, 1, '{"method":"POST","url":"http://35.231.238.114/auth/login","body":"{\n  \"email\": \"{{$trigger.email}}\",\n  \"password\" : \"{{$trigger.password}}\"\n}"}', '9b8eca22-d0f7-44bc-a71c-4444f01d85b1', NULL, '66904cac-25ff-48ab-9ee6-a4eac72485b2', '2025-05-15 02:10:32.597+00', 'f49db054-0000-4460-bb03-2f783370e377');
INSERT INTO public.directus_operations VALUES ('0a6bb686-45db-4ec9-93b2-941396e09bfa', 'Log to Console', 'log_k8e4x', 'log', 37, 1, '{"message":"sisas"}', NULL, NULL, '3b20c117-7bf0-46ee-8c14-234e7714a17f', '2025-05-16 15:52:43.446+00', 'f49db054-0000-4460-bb03-2f783370e377');
INSERT INTO public.directus_operations VALUES ('909ade44-4d93-48ed-b6a2-b4514e7aebd5', 'Log to Console', 'log_skgcp', 'log', 37, 19, '{"message":"nonas"}', NULL, NULL, '3b20c117-7bf0-46ee-8c14-234e7714a17f', '2025-05-16 15:52:43.732+00', 'f49db054-0000-4460-bb03-2f783370e377');
INSERT INTO public.directus_operations VALUES ('96889676-413d-4e8e-a61d-836ad7799ef8', 'Condition', 'condition_h5wag', 'condition', 19, 1, '{"filter":{"$trigger":{"payload":{"status":{"_eq":"e0f5b827-f8ca-4dcb-8ac0-7c2ccb4663f0"}}}}}', '0a6bb686-45db-4ec9-93b2-941396e09bfa', '909ade44-4d93-48ed-b6a2-b4514e7aebd5', '3b20c117-7bf0-46ee-8c14-234e7714a17f', '2025-05-16 15:41:49.914+00', 'f49db054-0000-4460-bb03-2f783370e377');
INSERT INTO public.directus_operations VALUES ('2937e439-104a-46d0-89ec-d5e42b65baf0', 'Create User Profile', 'item_create_laiji', 'item-create', 37, 1, '{"permissions":"$full","emitEvents":false,"collection":"user_profile","payload":{"id":"{{$last.id}}"}}', NULL, NULL, 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '2025-05-15 02:48:38.697+00', 'f49db054-0000-4460-bb03-2f783370e377');
INSERT INTO public.directus_operations VALUES ('0a325417-f595-4af0-b2b4-b8824397d519', 'Get User Data', 'get_user_data', 'trigger', 19, 1, '{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"{{$trigger.payload.email}}","password":"{{$trigger.payload.password}}"}}', '2937e439-104a-46d0-89ec-d5e42b65baf0', NULL, 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '2025-05-15 02:14:52.254+00', 'f49db054-0000-4460-bb03-2f783370e377');


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_permissions VALUES (2, 'directus_roles', 'read', '{}', '{}', NULL, '*', 'abf8a154-5b1c-4a46-ac9c-7300570f4f17');
INSERT INTO public.directus_permissions VALUES (4, 'Banner', 'read', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (5, 'Notification', 'read', '{"_and":[{"user_profile":{"_eq":"$CURRENT_USER"}}]}', NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (6, 'Notification', 'update', '{"_and":[{"user_profile":{"_eq":"$CURRENT_USER"}}]}', NULL, NULL, 'is_read', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (8, 'NotificationType', 'read', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (9, 'Collaboration', 'read', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (10, 'CollaborationImage', 'read', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (11, 'CollaborationMembers', 'read', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (12, 'CollaborationProducts', 'read', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (13, 'Delivery', 'read', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (14, 'Delivery', 'update', '{"_and":[{"id":{"_eq":"$CURRENT_USER"}}]}', NULL, NULL, 'status', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (15, 'DeliveryStatus', 'read', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (23, 'Product', 'update', '{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deleted_at":{"_null":true}}]}', NULL, NULL, 'specifications,variants,published,category,name,description,price,stock_alert,deletedAt,deleted_at', '60429753-5a20-475d-85bc-de9a5f1ac84f');
INSERT INTO public.directus_permissions VALUES (1, 'directus_users', 'create', NULL, NULL, NULL, '*', 'abf8a154-5b1c-4a46-ac9c-7300570f4f17');
INSERT INTO public.directus_permissions VALUES (7, 'Product', 'read', '{"_and":[{"published":{"_eq":true}},{"deleted_at":{"_null":true}}]}', NULL, NULL, 'id,entrepreneurship,name,description,price,reviews,specifications,variants,category', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (31, 'Product', 'create', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (32, 'Order', 'create', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (33, 'ProductCategory', 'read', NULL, NULL, NULL, 'name,description', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (18, 'Product', 'read', '{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deleted_at":{"_null":true}}]}', NULL, NULL, '*', '60429753-5a20-475d-85bc-de9a5f1ac84f');
INSERT INTO public.directus_permissions VALUES (16, 'Entrepreneurship', 'read', NULL, NULL, NULL, 'social_networks,id,name,slogan,description,creation_date,customization,email,phone,category,tags,tags_temp', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (25, 'Order', 'read', '{"_and":[{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}]}', NULL, NULL, NULL, '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (30, 'Entrepreneurship', 'read', '{"_and":[{"_or":[{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}},{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deleted_at":{"_null":true}}]}', NULL, NULL, 'social_networks,id,name,slogan,description,creation_date,customization,phone,subscription,email,category,status,user_founder,tags', '60429753-5a20-475d-85bc-de9a5f1ac84f');
INSERT INTO public.directus_permissions VALUES (40, 'ProductImage', 'delete', '{"_and":[{"_or":[{"product_variant":{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}}},{"product_variant":{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}}]},{"product_variant":{"product":{"deleted_at":{"_null":true}}}},{"product_variant":{"product":{"entrepreneurship":{"deleted_at":{"_null":true}}}}}]}', NULL, NULL, NULL, '60429753-5a20-475d-85bc-de9a5f1ac84f');
INSERT INTO public.directus_permissions VALUES (22, 'Product', 'create', NULL, '{"_and":[{"price":{"_gte":"0"}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]}', NULL, 'published,variants,specifications,name,description,price,stock_alert', '60429753-5a20-475d-85bc-de9a5f1ac84f');
INSERT INTO public.directus_permissions VALUES (37, 'ProductSpecification', 'create', NULL, NULL, NULL, 'key,value,product', '60429753-5a20-475d-85bc-de9a5f1ac84f');
INSERT INTO public.directus_permissions VALUES (38, 'ProductVariant', 'create', NULL, NULL, NULL, 'name,variant_images,stock,product', '60429753-5a20-475d-85bc-de9a5f1ac84f');
INSERT INTO public.directus_permissions VALUES (39, 'ProductImage', 'create', NULL, NULL, NULL, 'image_url,product_variant', '60429753-5a20-475d-85bc-de9a5f1ac84f');
INSERT INTO public.directus_permissions VALUES (34, 'ProductVariant', 'read', '{"_and":[{"product":{"published":{"_eq":true}}},{"product":{"deleted_at":{"_null":true}}}]}', NULL, NULL, 'variant_images,name,id,stock', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (41, 'ProductSpecification', 'update', '{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deleted_at":{"_null":true}}}]}', NULL, NULL, 'key,value,product', '60429753-5a20-475d-85bc-de9a5f1ac84f');
INSERT INTO public.directus_permissions VALUES (42, 'ProductSpecification', 'delete', '{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deleted_at":{"_null":true}}}]}', NULL, NULL, NULL, '60429753-5a20-475d-85bc-de9a5f1ac84f');
INSERT INTO public.directus_permissions VALUES (35, 'ProductSpecification', 'read', '{"_and":[{"product":{"published":{"_eq":true}}},{"product":{"deleted_at":{"_null":true}}}]}', NULL, NULL, 'key,value,id', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (36, 'ProductImage', 'read', '{"_and":[{"product_variant":{"product":{"published":{"_eq":true}}}},{"product_variant":{"product":{"deleted_at":{"_null":true}}}}]}', NULL, NULL, 'image_url,id', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (45, 'Entrepreneurship', 'create', NULL, NULL, NULL, '*', '60429753-5a20-475d-85bc-de9a5f1ac84f');
INSERT INTO public.directus_permissions VALUES (46, 'ProductImage', 'update', '{"_and":[{"_or":[{"product_variant":{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product_variant":{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}}}]}]}', NULL, NULL, 'product_variant,image_url', '60429753-5a20-475d-85bc-de9a5f1ac84f');
INSERT INTO public.directus_permissions VALUES (43, 'ProductVariant', 'update', '{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deleted_at":{"_null":true}}}]}', NULL, NULL, 'variant_images,stock,name,product', '60429753-5a20-475d-85bc-de9a5f1ac84f');
INSERT INTO public.directus_permissions VALUES (44, 'ProductVariant', 'delete', '{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deleted_at":{"_null":true}}}]}', NULL, NULL, NULL, '60429753-5a20-475d-85bc-de9a5f1ac84f');
INSERT INTO public.directus_permissions VALUES (47, 'directus_roles', 'read', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (50, 'Entrepreneurship_Tags', 'read', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (49, 'Tags', 'read', NULL, NULL, NULL, 'id,name,entrepreneurships', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (51, 'EntrepreneurshipType', 'read', NULL, NULL, NULL, 'id,name', '4a706832-1a5a-4e16-be61-a1756c9edaa7');


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_policies VALUES ('abf8a154-5b1c-4a46-ac9c-7300570f4f17', '$t:public_label', 'public', '$t:public_description', NULL, false, false, false);
INSERT INTO public.directus_policies VALUES ('4a706832-1a5a-4e16-be61-a1756c9edaa7', 'Usuario', 'badge', 'Usuario general de la aplicación', NULL, false, false, false);
INSERT INTO public.directus_policies VALUES ('60429753-5a20-475d-85bc-de9a5f1ac84f', 'Usuario Verificado', 'badge', 'Usuario verificado de la aplicación', NULL, false, false, false);
INSERT INTO public.directus_policies VALUES ('4861387b-6d9c-48d1-9570-5af806d0671c', 'Administrator', 'accessibility_new', '$t:admin_description', NULL, false, true, true);


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_presets VALUES (1, NULL, 'f49db054-0000-4460-bb03-2f783370e377', NULL, 'directus_users', NULL, 'cards', '{"cards":{"sort":["email"],"page":1}}', '{"cards":{"icon":"account_circle","title":"{{ first_name }} {{ last_name }}","subtitle":"{{ email }}","size":4}}', NULL, NULL, 'bookmark', NULL);
INSERT INTO public.directus_presets VALUES (4, NULL, 'f49db054-0000-4460-bb03-2f783370e377', NULL, 'Product', NULL, NULL, '{"tabular":{"fields":["published","reviews","specifications","variants","name"]}}', NULL, NULL, NULL, 'bookmark', NULL);
INSERT INTO public.directus_presets VALUES (2, NULL, 'f49db054-0000-4460-bb03-2f783370e377', NULL, 'ProductCategory', NULL, NULL, '{"tabular":{"page":1}}', NULL, NULL, NULL, 'bookmark', NULL);
INSERT INTO public.directus_presets VALUES (5, NULL, 'f49db054-0000-4460-bb03-2f783370e377', NULL, 'ProductImage', NULL, NULL, '{"tabular":{"page":1}}', NULL, NULL, NULL, 'bookmark', NULL);
INSERT INTO public.directus_presets VALUES (7, NULL, 'f49db054-0000-4460-bb03-2f783370e377', NULL, 'Tags', NULL, NULL, '{"tabular":{"page":1}}', NULL, NULL, NULL, 'bookmark', NULL);
INSERT INTO public.directus_presets VALUES (3, NULL, 'f49db054-0000-4460-bb03-2f783370e377', NULL, 'Entrepreneurship', NULL, NULL, '{"tabular":{"page":1}}', NULL, NULL, NULL, 'bookmark', NULL);


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_relations VALUES (14, 'Partner', 'entrepreneurship', 'Entrepreneurship', 'partners', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (15, 'Order', 'user_profile', 'user_profile', 'orders', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (16, 'CollaborationImage', 'collaboration', 'Collaboration', 'images', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (13, 'Entrepreneurship', 'user_founder', 'user_profile', 'entrepreneurships', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (19, 'user_profile', 'university', 'University', 'users', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (20, 'Notification', 'user_profile', 'user_profile', 'notifications', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (21, 'Partner', 'user_profile', 'user_profile', 'partner_entrepreneurships', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (22, 'Review', 'user_profile', 'user_profile', 'reviews', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (23, 'DeliveryStatusLog', 'updated_by', 'user_profile', 'delivery_logs', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (25, 'user_profile', 'status', 'UserStatus', 'users', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (26, 'user_profile', 'verification', 'Verification', 'user', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (27, 'Notification', 'type', 'NotificationType', 'notifications', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (28, 'Partner', 'partner_rol', 'PartnerRol', 'user_partners', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (29, 'Delivery', 'partner', 'Partner', 'deliveries', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (2, 'Delivery', 'status', 'DeliveryStatus', 'deliveries', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (30, 'DeliveryStatusLog', 'delivery', 'Delivery', 'deliverylogs', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (31, 'DeliveryStatusLog', 'delivery_status', 'DeliveryStatus', 'deliverylogs', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (32, 'Payment', 'payment_method', 'PaymentMethod', 'payments', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (33, 'PaymentEvidence', 'payment', 'Payment', 'payment_evidences', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (1, 'Order', 'status', 'OrderStatus', 'orders', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (34, 'Payment', 'order', 'Order', 'payments', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (35, 'OrderDetail', 'order', 'Order', 'order_details', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (36, 'CollaborationMembers', 'collaboration', 'Collaboration', 'members', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (37, 'CollaborationProducts', 'collaboration', 'Collaboration', 'products', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (38, 'Review', 'product', 'Product', 'reviews', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (42, 'EntrepreneurshipSubscription', 'subscription_plan', 'SubscriptionPlans', 'subscriptions', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (43, 'EntrepreneurshipSubscription', 'entrepreneurship', 'Entrepreneurship', NULL, NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (12, 'Product', 'entrepreneurship', 'Entrepreneurship', 'products', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (44, 'CollaborationMembers', 'entrepreneurship', 'Entrepreneurship', 'collaborations', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (45, 'Order', 'entrepreneurship', 'Entrepreneurship', 'orders', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (46, 'SocialNetwork', 'entrepreneurship', 'Entrepreneurship', 'social_networks', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (47, 'EntrepreneurshipCustomization', 'entrepreneurship', 'Entrepreneurship', NULL, NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (48, 'Entrepreneurship', 'category', 'EntrepreneurshipType', 'entrepreneurships', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (49, 'Product', 'category', 'ProductCategory', 'products', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (39, 'ProductVariant', 'product', 'Product', 'variants', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (40, 'ProductImage', 'product_variant', 'ProductVariant', 'variant_images', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (41, 'ProductSpecification', 'product', 'Product', 'specifications', NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (59, 'Entrepreneurship_Tags', 'Entrepreneurship_id', 'Entrepreneurship', 'tags', NULL, NULL, 'Tags_id', NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (58, 'Entrepreneurship_Tags', 'Tags_id', 'Tags', 'entrepreneurships', NULL, NULL, 'Entrepreneurship_id', NULL, 'nullify');


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_revisions VALUES (1, 3, 'directus_collections', 'user_profile', '{"collection":"user_profile"}', '{"collection":"user_profile"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (2, 4, 'directus_collections', 'SubscriptionPlans', '{"collection":"SubscriptionPlans"}', '{"collection":"SubscriptionPlans"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (3, 5, 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', '{"name":"Comprador","admin_access":false,"app_access":false}', '{"name":"Comprador","admin_access":false,"app_access":false}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (4, 6, 'directus_collections', 'Banner', '{"collection":"Banner"}', '{"collection":"Banner"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (5, 7, 'directus_permissions', '3', '{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Banner","action":"read"}', '{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Banner","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (6, 9, 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', '{"id":"4a706832-1a5a-4e16-be61-a1756c9edaa7","name":"Comprador","icon":"badge","description":"Usuario general de la aplicación","ip_access":null,"enforce_tfa":false,"admin_access":false,"app_access":false,"permissions":[],"users":[],"roles":[]}', '{"description":"Usuario general de la aplicación"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (7, 10, 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', '{"name":"Emprendedor","admin_access":false,"app_access":false}', '{"name":"Emprendedor","admin_access":false,"app_access":false}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (8, 11, 'directus_access', 'bc8471d8-e9e9-437e-94e8-16c22e03708b', '{"role":"11111111-1111-1111-1111-111111111111","policy":{"id":"4a706832-1a5a-4e16-be61-a1756c9edaa7"},"sort":1}', '{"role":"11111111-1111-1111-1111-111111111111","policy":{"id":"4a706832-1a5a-4e16-be61-a1756c9edaa7"},"sort":1}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (9, 13, 'directus_access', 'a78a4f48-4f30-413b-b6fa-5b9458ec8ace', '{"role":"22222222-2222-2222-2222-222222222222","policy":{"id":"4a706832-1a5a-4e16-be61-a1756c9edaa7"},"sort":1}', '{"role":"22222222-2222-2222-2222-222222222222","policy":{"id":"4a706832-1a5a-4e16-be61-a1756c9edaa7"},"sort":1}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (10, 14, 'directus_access', 'cdb115a0-3d0e-422e-854a-f27fbf7078de', '{"role":"22222222-2222-2222-2222-222222222222","policy":{"id":"60429753-5a20-475d-85bc-de9a5f1ac84f"},"sort":2}', '{"role":"22222222-2222-2222-2222-222222222222","policy":{"id":"60429753-5a20-475d-85bc-de9a5f1ac84f"},"sort":2}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (11, 16, 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', '{"id":"60429753-5a20-475d-85bc-de9a5f1ac84f","name":"Emprendedor","icon":"badge","description":"Usuario verificado de la aplicación","ip_access":null,"enforce_tfa":false,"admin_access":false,"app_access":false,"permissions":[],"users":["cdb115a0-3d0e-422e-854a-f27fbf7078de"],"roles":["cdb115a0-3d0e-422e-854a-f27fbf7078de"]}', '{"description":"Usuario verificado de la aplicación"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (12, 19, 'directus_permissions', '4', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Banner","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Banner","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (13, 21, 'directus_collections', 'Collaboration', '{"collection":"Collaboration"}', '{"collection":"Collaboration"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (14, 22, 'directus_fields', '1', '{"special":null,"collection":"Collaboration","field":"description"}', '{"special":null,"collection":"Collaboration","field":"description"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (15, 23, 'directus_collections', 'DeliveryStatus', '{"collection":"DeliveryStatus"}', '{"collection":"DeliveryStatus"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (16, 24, 'directus_collections', 'CollaborationImage', '{"collection":"CollaborationImage"}', '{"collection":"CollaborationImage"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (17, 25, 'directus_collections', 'CollaborationMembers', '{"collection":"CollaborationMembers"}', '{"collection":"CollaborationMembers"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (18, 26, 'directus_collections', 'CollaborationProducts', '{"collection":"CollaborationProducts"}', '{"collection":"CollaborationProducts"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (19, 27, 'directus_collections', 'Delivery', '{"collection":"Delivery"}', '{"collection":"Delivery"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (20, 28, 'directus_collections', 'DeliveryStatusLog', '{"collection":"DeliveryStatusLog"}', '{"collection":"DeliveryStatusLog"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (21, 29, 'directus_collections', 'UserStatus', '{"collection":"UserStatus"}', '{"collection":"UserStatus"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (22, 30, 'directus_collections', 'Verification', '{"collection":"Verification"}', '{"collection":"Verification"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (23, 31, 'directus_collections', 'Entrepreneurship', '{"collection":"Entrepreneurship"}', '{"collection":"Entrepreneurship"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (24, 32, 'directus_collections', 'University', '{"collection":"University"}', '{"collection":"University"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (25, 33, 'directus_collections', 'Tags', '{"collection":"Tags"}', '{"collection":"Tags"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (26, 34, 'directus_collections', 'SocialNetWork', '{"collection":"SocialNetWork"}', '{"collection":"SocialNetWork"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (27, 35, 'directus_collections', 'Review', '{"collection":"Review"}', '{"collection":"Review"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (28, 36, 'directus_collections', 'EntrepreneurshipCustomization', '{"collection":"EntrepreneurshipCustomization"}', '{"collection":"EntrepreneurshipCustomization"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (29, 37, 'directus_collections', 'EntrepreneurshipSubscription', '{"collection":"EntrepreneurshipSubscription"}', '{"collection":"EntrepreneurshipSubscription"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (30, 38, 'directus_collections', 'Partner', '{"collection":"Partner"}', '{"collection":"Partner"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (31, 39, 'directus_collections', 'Entrepreneurship_Tags', '{"collection":"Entrepreneurship_Tags"}', '{"collection":"Entrepreneurship_Tags"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (32, 40, 'directus_collections', 'EntrepreneurshipType', '{"collection":"EntrepreneurshipType"}', '{"collection":"EntrepreneurshipType"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (33, 41, 'directus_collections', 'Product', '{"collection":"Product"}', '{"collection":"Product"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (34, 42, 'directus_collections', 'NotificationType', '{"collection":"NotificationType"}', '{"collection":"NotificationType"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (35, 43, 'directus_collections', 'ProductVariant', '{"collection":"ProductVariant"}', '{"collection":"ProductVariant"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (36, 44, 'directus_collections', 'ProductSpecification', '{"collection":"ProductSpecification"}', '{"collection":"ProductSpecification"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (37, 45, 'directus_collections', 'ProductImage', '{"collection":"ProductImage"}', '{"collection":"ProductImage"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (38, 46, 'directus_collections', 'Notification', '{"collection":"Notification"}', '{"collection":"Notification"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (39, 47, 'directus_collections', 'Order', '{"collection":"Order"}', '{"collection":"Order"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (40, 48, 'directus_collections', 'OrderDetail', '{"collection":"OrderDetail"}', '{"collection":"OrderDetail"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (41, 49, 'directus_collections', 'PartnerRol', '{"collection":"PartnerRol"}', '{"collection":"PartnerRol"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (42, 50, 'directus_collections', 'Payment', '{"collection":"Payment"}', '{"collection":"Payment"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (43, 51, 'directus_collections', 'PaymentMethod', '{"collection":"PaymentMethod"}', '{"collection":"PaymentMethod"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (44, 52, 'directus_collections', 'PaymentEvidence', '{"collection":"PaymentEvidence"}', '{"collection":"PaymentEvidence"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (73, 89, 'OrderStatus', '2bef1dec-02be-4614-88f0-5de146201c40', '{"name":"listo"}', '{"name":"listo"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (45, 53, 'directus_permissions', '5', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Notification","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Notification","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (46, 55, 'directus_permissions', '5', '{"id":5,"collection":"Notification","action":"read","permissions":{"_and":[{"user_profile":{"_eq":"$CURRENT_USER"}}]},"validation":null,"presets":null,"fields":["*"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Notification","action":"read","permissions":{"_and":[{"user_profile":{"_eq":"$CURRENT_USER"}}]},"validation":null,"presets":null,"fields":["*"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (47, 57, 'directus_fields', '2', '{"sort":1,"special":["cast-boolean"],"collection":"Notification","field":"is_read"}', '{"sort":1,"special":["cast-boolean"],"collection":"Notification","field":"is_read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (48, 58, 'directus_fields', '3', '{"sort":1,"group":null,"collection":"Notification","field":"id"}', '{"sort":1,"group":null,"collection":"Notification","field":"id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (49, 59, 'directus_fields', '4', '{"sort":2,"group":null,"collection":"Notification","field":"user_profile"}', '{"sort":2,"group":null,"collection":"Notification","field":"user_profile"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (50, 60, 'directus_fields', '5', '{"sort":3,"group":null,"collection":"Notification","field":"type"}', '{"sort":3,"group":null,"collection":"Notification","field":"type"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (51, 61, 'directus_fields', '6', '{"sort":4,"group":null,"collection":"Notification","field":"title"}', '{"sort":4,"group":null,"collection":"Notification","field":"title"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (52, 62, 'directus_fields', '7', '{"sort":5,"group":null,"collection":"Notification","field":"content"}', '{"sort":5,"group":null,"collection":"Notification","field":"content"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (53, 63, 'directus_fields', '2', '{"id":2,"collection":"Notification","field":"is_read","special":["cast-boolean"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"Notification","field":"is_read","sort":6,"group":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (54, 64, 'directus_permissions', '6', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":{"_and":[{"user_profile":{"_eq":"$CURRENT_USER"}}]},"validation":null,"fields":["is_read"],"presets":null,"collection":"Notification","action":"update"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":{"_and":[{"user_profile":{"_eq":"$CURRENT_USER"}}]},"validation":null,"fields":["is_read"],"presets":null,"collection":"Notification","action":"update"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (55, 66, 'directus_permissions', '7', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Product","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Product","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (56, 68, 'directus_permissions', '8', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"NotificationType","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"NotificationType","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (57, 70, 'directus_policies', '4a706832-1a5a-4e16-be61-a1756c9edaa7', '{"id":"4a706832-1a5a-4e16-be61-a1756c9edaa7","name":"Usuario","icon":"badge","description":"Usuario general de la aplicación","ip_access":null,"enforce_tfa":false,"admin_access":false,"app_access":false,"permissions":[4,5,6,7,8],"users":["bc8471d8-e9e9-437e-94e8-16c22e03708b","a78a4f48-4f30-413b-b6fa-5b9458ec8ace"],"roles":["bc8471d8-e9e9-437e-94e8-16c22e03708b","a78a4f48-4f30-413b-b6fa-5b9458ec8ace"]}', '{"name":"Usuario"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (58, 71, 'directus_flows', 'a631a800-b219-4c44-8829-910153ec9c2b', '{"name":"Ordenar un Producto","icon":"bolt","color":null,"description":"Flow a ejecutar cuando un usuario ordena un producto ","status":"active","accountability":"all","trigger":"event","options":{"type":"action","scope":["items.create"],"collections":["Product"]}}', '{"name":"Ordenar un Producto","icon":"bolt","color":null,"description":"Flow a ejecutar cuando un usuario ordena un producto ","status":"active","accountability":"all","trigger":"event","options":{"type":"action","scope":["items.create"],"collections":["Product"]}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (59, 72, 'directus_flows', 'a631a800-b219-4c44-8829-910153ec9c2b', '{"id":"a631a800-b219-4c44-8829-910153ec9c2b","name":"Ordenar un Producto","icon":"bolt","color":null,"description":"Flow a ejecutar cuando un usuario ordena un producto ","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["Order"]},"operation":null,"date_created":"2025-05-13T18:57:01.279Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":[]}', '{"name":"Ordenar un Producto","icon":"bolt","color":null,"description":"Flow a ejecutar cuando un usuario ordena un producto ","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["Order"]}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (60, 73, 'directus_fields', '8', '{"special":["uuid"],"collection":"Order","field":"entrepreneurship"}', '{"special":["uuid"],"collection":"Order","field":"entrepreneurship"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (61, 74, 'directus_fields', '9', '{"special":["uuid"],"collection":"Entrepreneurship","field":"user_founder"}', '{"special":["uuid"],"collection":"Entrepreneurship","field":"user_founder"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (62, 75, 'directus_fields', '10', '{"special":null,"collection":"Order","field":"status"}', '{"special":null,"collection":"Order","field":"status"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (63, 76, 'directus_fields', '11', '{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"OrderStatus"}', '{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"OrderStatus"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (64, 77, 'directus_collections', 'OrderStatus', '{"singleton":false,"collection":"OrderStatus"}', '{"singleton":false,"collection":"OrderStatus"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (65, 78, 'directus_fields', '12', '{"sort":2,"special":null,"collection":"OrderStatus","field":"name"}', '{"sort":2,"special":null,"collection":"OrderStatus","field":"name"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (66, 81, 'directus_fields', '13', '{"sort":1,"special":["o2m"],"collection":"Order","field":"status"}', '{"sort":1,"special":["o2m"],"collection":"Order","field":"status"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (67, 83, 'directus_fields', '14', '{"sort":1,"special":["m2o"],"collection":"Order","field":"status"}', '{"sort":1,"special":["m2o"],"collection":"Order","field":"status"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (68, 84, 'OrderStatus', 'c1909f66-0fbb-4c62-b5e4-32975d95a700', '{"name":"pendiente"}', '{"name":"pendiente"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (69, 85, 'OrderStatus', 'e0f5b827-f8ca-4dcb-8ac0-7c2ccb4663f0', '{"name":"confirmado"}', '{"name":"confirmado"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (70, 86, 'OrderStatus', '1e1ded25-3529-47f6-a632-4de38d0f6c92', '{"name":"en proceso"}', '{"name":"en proceso"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (71, 87, 'OrderStatus', 'ef71736e-3791-440e-b97e-f3a646baba04', '{"name":"cancelado"}', '{"name":"cancelado"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (72, 88, 'OrderStatus', '5b989409-5b3c-49c0-8285-52687912916b', '{"name":"fallido"}', '{"name":"fallido"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (74, 90, 'OrderStatus', 'f6ae0a15-c86b-4181-ab1a-0d434c41d257', '{"name":"completado"}', '{"name":"completado"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (75, 91, 'directus_flows', 'a631a800-b219-4c44-8829-910153ec9c2b', '{"id":"a631a800-b219-4c44-8829-910153ec9c2b","name":"Realizar una Orden","icon":"bolt","color":null,"description":"Flow a ejecutar cuando un usuario ordena un producto ","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["Order"]},"operation":null,"date_created":"2025-05-13T18:57:01.279Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":[]}', '{"name":"Realizar una Orden","icon":"bolt","color":null,"description":"Flow a ejecutar cuando un usuario ordena un producto ","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["Order"]}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (76, 92, 'directus_flows', 'a631a800-b219-4c44-8829-910153ec9c2b', '{"id":"a631a800-b219-4c44-8829-910153ec9c2b","name":"Realizar una Orden","icon":"bolt","color":null,"description":"Flow a ejecutar cuando un usuario ordena un producto ","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["Order"]},"operation":null,"date_created":"2025-05-13T18:57:01.279Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":[]}', '{"name":"Realizar una Orden","icon":"bolt","color":null,"description":"Flow a ejecutar cuando un usuario ordena un producto ","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["Order"]}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (77, 93, 'directus_operations', 'adc3bb66-0f3d-49e2-ac9c-3b2b721aec9c', '{"flow":"a631a800-b219-4c44-8829-910153ec9c2b","position_x":37,"position_y":1,"name":"test 1","key":"test_1","type":"log","options":{"message":"Esta pendientte"}}', '{"flow":"a631a800-b219-4c44-8829-910153ec9c2b","position_x":37,"position_y":1,"name":"test 1","key":"test_1","type":"log","options":{"message":"Esta pendientte"}}', 79, NULL);
INSERT INTO public.directus_revisions VALUES (78, 94, 'directus_operations', 'a2b6e335-6e07-4243-bdb3-0a5502a92112', '{"flow":"a631a800-b219-4c44-8829-910153ec9c2b","position_x":37,"position_y":17,"name":"test 2","key":"test_2","type":"log","options":{"message":"operacion es {{$trigger.payload.status}}"}}', '{"flow":"a631a800-b219-4c44-8829-910153ec9c2b","position_x":37,"position_y":17,"name":"test 2","key":"test_2","type":"log","options":{"message":"operacion es {{$trigger.payload.status}}"}}', 79, NULL);
INSERT INTO public.directus_revisions VALUES (80, 96, 'directus_flows', 'a631a800-b219-4c44-8829-910153ec9c2b', '{"id":"a631a800-b219-4c44-8829-910153ec9c2b","name":"Realizar una Orden","icon":"bolt","color":null,"description":"Flow a ejecutar cuando un usuario ordena un producto ","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["Order"]},"operation":"21b07fc3-0eb8-493e-a6b8-dd16e9589e6c","date_created":"2025-05-13T18:57:01.279Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["21b07fc3-0eb8-493e-a6b8-dd16e9589e6c","a2b6e335-6e07-4243-bdb3-0a5502a92112","adc3bb66-0f3d-49e2-ac9c-3b2b721aec9c"]}', '{"name":"Realizar una Orden","icon":"bolt","color":null,"description":"Flow a ejecutar cuando un usuario ordena un producto ","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["Order"]},"operation":"21b07fc3-0eb8-493e-a6b8-dd16e9589e6c","date_created":"2025-05-13T18:57:01.279Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (79, 95, 'directus_operations', '21b07fc3-0eb8-493e-a6b8-dd16e9589e6c', '{"flow":"a631a800-b219-4c44-8829-910153ec9c2b","position_x":19,"position_y":1,"name":"Status is Pendiente","key":"status_is_pendiente","type":"condition","options":{"filter":"{{$trigger.payload.status}} = ''pendiente''"},"resolve":{"flow":"a631a800-b219-4c44-8829-910153ec9c2b","position_x":37,"position_y":1,"name":"test 1","key":"test_1","type":"log","options":{"message":"Esta pendientte"}},"reject":{"flow":"a631a800-b219-4c44-8829-910153ec9c2b","position_x":37,"position_y":17,"name":"test 2","key":"test_2","type":"log","options":{"message":"operacion es {{$trigger.payload.status}}"}}}', '{"flow":"a631a800-b219-4c44-8829-910153ec9c2b","position_x":19,"position_y":1,"name":"Status is Pendiente","key":"status_is_pendiente","type":"condition","options":{"filter":"{{$trigger.payload.status}} = ''pendiente''"},"resolve":{"flow":"a631a800-b219-4c44-8829-910153ec9c2b","position_x":37,"position_y":1,"name":"test 1","key":"test_1","type":"log","options":{"message":"Esta pendientte"}},"reject":{"flow":"a631a800-b219-4c44-8829-910153ec9c2b","position_x":37,"position_y":17,"name":"test 2","key":"test_2","type":"log","options":{"message":"operacion es {{$trigger.payload.status}}"}}}', 80, NULL);
INSERT INTO public.directus_revisions VALUES (81, 100, 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', '{"id":"60429753-5a20-475d-85bc-de9a5f1ac84f","name":"Verified User","icon":"badge","description":"Usuario verificado de la aplicación","ip_access":null,"enforce_tfa":false,"admin_access":false,"app_access":false,"permissions":[],"users":["cdb115a0-3d0e-422e-854a-f27fbf7078de"],"roles":["cdb115a0-3d0e-422e-854a-f27fbf7078de"]}', '{"name":"Verified User"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (82, 101, 'directus_policies', '60429753-5a20-475d-85bc-de9a5f1ac84f', '{"id":"60429753-5a20-475d-85bc-de9a5f1ac84f","name":"Usuario Verificado","icon":"badge","description":"Usuario verificado de la aplicación","ip_access":null,"enforce_tfa":false,"admin_access":false,"app_access":false,"permissions":[],"users":["cdb115a0-3d0e-422e-854a-f27fbf7078de"],"roles":["cdb115a0-3d0e-422e-854a-f27fbf7078de"]}', '{"name":"Usuario Verificado"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (83, 102, 'directus_policies', '4861387b-6d9c-48d1-9570-5af806d0671c', '{"id":"4861387b-6d9c-48d1-9570-5af806d0671c","name":"Administrator","icon":"accessibility_new","description":"$t:admin_description","ip_access":null,"enforce_tfa":false,"admin_access":true,"app_access":true,"permissions":[],"users":["14d949cf-af7a-4dd4-894d-1552cb882e23"],"roles":["14d949cf-af7a-4dd4-894d-1552cb882e23"]}', '{"icon":"accessibility_new"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (84, 103, 'directus_fields', '15', '{"special":["uuid"],"collection":"Delivery","field":"partner"}', '{"special":["uuid"],"collection":"Delivery","field":"partner"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (85, 104, 'directus_fields', '16', '{"special":null,"collection":"Delivery","field":"type"}', '{"special":null,"collection":"Delivery","field":"type"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (86, 105, 'directus_fields', '17', '{"sort":1,"special":["m2o"],"collection":"Delivery","field":"status"}', '{"sort":1,"special":["m2o"],"collection":"Delivery","field":"status"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (87, 106, 'directus_permissions', '9', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Collaboration","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Collaboration","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (88, 107, 'directus_permissions', '10', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"CollaborationImage","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"CollaborationImage","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (89, 108, 'directus_permissions', '11', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"CollaborationMembers","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"CollaborationMembers","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (90, 109, 'directus_permissions', '12', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"CollaborationProducts","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"CollaborationProducts","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (91, 110, 'directus_permissions', '13', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Delivery","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Delivery","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (92, 111, 'directus_permissions', '14', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":{"_and":[{"id":{"_eq":"$CURRENT_USER"}}]},"validation":null,"fields":["status"],"presets":null,"collection":"Delivery","action":"update"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":{"_and":[{"id":{"_eq":"$CURRENT_USER"}}]},"validation":null,"fields":["status"],"presets":null,"collection":"Delivery","action":"update"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (93, 112, 'directus_permissions', '15', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"DeliveryStatus","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"DeliveryStatus","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (94, 114, 'directus_permissions', '16', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Entrepreneurship","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Entrepreneurship","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (95, 116, 'directus_permissions', '17', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Entrepreneurship_Tags","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Entrepreneurship_Tags","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (96, 118, 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '{"first_name":"Juan","last_name":"Vendedor","email":"juanvendedor@gmail.com","password":"**********","role":"22222222-2222-2222-2222-222222222222"}', '{"first_name":"Juan","last_name":"Vendedor","email":"juanvendedor@gmail.com","password":"**********","role":"22222222-2222-2222-2222-222222222222"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (97, 120, 'directus_users', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '{"id":"8360fc8e-a7cb-483f-9bb8-b12b9827d233","first_name":"Juan","last_name":"Vendedor","email":"juanvendedor@gmail.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"22222222-2222-2222-2222-222222222222","token":null,"last_access":null,"last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"policies":[]}', '{"password":"**********"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (98, 123, 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '{"id":"aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa","first_name":"Carlos Comprador","last_name":null,"email":"carlos@tienda.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"11111111-1111-1111-1111-111111111111","token":null,"last_access":null,"last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"policies":[]}', '{"password":"**********"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (99, 125, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"filter","scope":["items.create"],"collections":["directus_users"],"return":"$last"}}', '{"name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"filter","scope":["items.create"],"collections":["directus_users"],"return":"$last"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (101, 127, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"id":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"filter","scope":["items.create"],"collections":["directus_users"],"return":"$last"},"operation":"42a51146-3462-43a0-8601-1c969fa0a959","date_created":"2025-05-14T23:32:24.375Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["42a51146-3462-43a0-8601-1c969fa0a959"]}', '{"name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"filter","scope":["items.create"],"collections":["directus_users"],"return":"$last"},"operation":"42a51146-3462-43a0-8601-1c969fa0a959","date_created":"2025-05-14T23:32:24.375Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (100, 126, 'directus_operations', '42a51146-3462-43a0-8601-1c969fa0a959', '{"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","position_x":19,"position_y":1,"name":"Log to Console","key":"log_4tkmg","type":"log","options":{"message":"{{$trigger.payload}}"}}', '{"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","position_x":19,"position_y":1,"name":"Log to Console","key":"log_4tkmg","type":"log","options":{"message":"{{$trigger.payload}}"}}', 101, NULL);
INSERT INTO public.directus_revisions VALUES (103, 130, 'directus_permissions', '1', '{"id":1,"collection":"directus_users","action":"create","permissions":{},"validation":{},"presets":null,"fields":["first_name","last_name","email","password","avatar","location","title","description","tags","preferences_divider","language","tfa_secret","email_notifications","theming_divider","appearance","theme_light","theme_light_overrides","theme_dark","theme_dark_overrides","admin_divider","status","policies","token","id","last_page","last_access","provider","external_identifier","auth_data"],"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}', '{"collection":"directus_users","action":"create","permissions":{},"validation":{},"presets":null,"fields":["first_name","last_name","email","password","avatar","location","title","description","tags","preferences_divider","language","tfa_secret","email_notifications","theming_divider","appearance","theme_light","theme_light_overrides","theme_dark","theme_dark_overrides","admin_divider","status","policies","token","id","last_page","last_access","provider","external_identifier","auth_data"],"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (104, 132, 'directus_settings', '1', '{"public_registration_role":"11111111-1111-1111-1111-111111111111","public_registration_verify_email":false}', '{"public_registration_role":"11111111-1111-1111-1111-111111111111","public_registration_verify_email":false}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (226, 299, 'directus_fields', '32', '{"special":null,"collection":"Banner","field":"created_at"}', '{"special":null,"collection":"Banner","field":"created_at"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (227, 300, 'directus_fields', '33', '{"special":["uuid"],"collection":"Entrepreneurship","field":"id"}', '{"special":["uuid"],"collection":"Entrepreneurship","field":"id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (105, 133, 'directus_settings', '1', '{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":true,"public_registration_verify_email":false,"public_registration_role":"11111111-1111-1111-1111-111111111111","public_registration_email_filter":null,"visual_editor_urls":null}', '{"public_registration":true,"public_registration_role":"11111111-1111-1111-1111-111111111111"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (111, 139, 'directus_permissions', '1', '{"id":1,"collection":"directus_users","action":"create","permissions":null,"validation":null,"presets":null,"fields":["*"],"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}', '{"collection":"directus_users","action":"create","permissions":null,"validation":null,"presets":null,"fields":["*"],"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (113, 143, 'directus_permissions', '1', '{"id":1,"collection":"directus_users","action":"create","permissions":null,"validation":null,"presets":null,"fields":["*"],"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}', '{"collection":"directus_users","action":"create","permissions":null,"validation":null,"presets":null,"fields":["*"],"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (123, 161, 'directus_settings', '1', '{"id":1,"project_name":"Directus","project_url":"http://35.231.238.114","project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":true,"public_registration_verify_email":false,"public_registration_role":"11111111-1111-1111-1111-111111111111","public_registration_email_filter":null,"visual_editor_urls":null}', '{"project_url":"http://35.231.238.114"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (126, 164, 'directus_roles', '1eb1310f-321f-4733-8aaf-7a935b5886f6', '{"name":"TestRole"}', '{"name":"TestRole"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (228, 301, 'directus_fields', '34', '{"special":null,"collection":"Entrepreneurship","field":"name"}', '{"special":null,"collection":"Entrepreneurship","field":"name"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (229, 302, 'directus_fields', '35', '{"special":null,"collection":"Entrepreneurship","field":"social_networks"}', '{"special":null,"collection":"Entrepreneurship","field":"social_networks"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (128, 166, 'directus_settings', '1', '{"id":1,"project_name":"Directus","project_url":"http://35.231.238.114","project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":true,"public_registration_verify_email":false,"public_registration_role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","public_registration_email_filter":null,"visual_editor_urls":null}', '{"public_registration_role":"1eb1310f-321f-4733-8aaf-7a935b5886f6"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (130, 168, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"id":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"inactive","trigger":"event","accountability":"all","options":{"type":"filter","scope":["items.create"],"collections":["directus_users"],"return":"$last"},"operation":"42a51146-3462-43a0-8601-1c969fa0a959","date_created":"2025-05-14T23:32:24.375Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["42a51146-3462-43a0-8601-1c969fa0a959"]}', '{"status":"inactive"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (131, 169, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"id":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"inactive","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["directus_users"]},"operation":"42a51146-3462-43a0-8601-1c969fa0a959","date_created":"2025-05-14T23:32:24.375Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["42a51146-3462-43a0-8601-1c969fa0a959"]}', '{"name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"inactive","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["directus_users"]}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (132, 170, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"id":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["directus_users"]},"operation":"42a51146-3462-43a0-8601-1c969fa0a959","date_created":"2025-05-14T23:32:24.375Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["42a51146-3462-43a0-8601-1c969fa0a959"]}', '{"status":"active"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (133, 172, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"steps":[{"operation":"42a51146-3462-43a0-8601-1c969fa0a959","key":"log_4tkmg","status":"resolve","options":{"message":{"email":"usertesting@gmail.com","password":"Securepassword@1","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","status":"active","first_name":"User","last_name":"Testing"}}}],"data":{"$trigger":{"event":"users.create","payload":{"email":"usertesting@gmail.com","password":"--redacted--","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","status":"active","first_name":"User","last_name":"Testing"},"key":"57d2af88-6b67-4b43-84c1-4259d943972f","collection":"directus_users"},"$last":null,"$accountability":null,"$env":{},"log_4tkmg":null}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (134, 173, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"name":"Buscar Usuario","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"operation","options":{"return":"$last"}}', '{"name":"Buscar Usuario","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"operation","options":{"return":"$last"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (136, 176, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"id":"66904cac-25ff-48ab-9ee6-a4eac72485b2","name":"Buscar Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"},"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","date_created":"2025-05-15T01:44:35.845Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["336d194c-cf1f-410c-af63-ce913f219fb4"]}', '{"name":"Buscar Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"},"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","date_created":"2025-05-15T01:44:35.845Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (135, 175, 'directus_operations', '336d194c-cf1f-410c-af63-ce913f219fb4', '{"flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","position_x":19,"position_y":1,"name":"Login","key":"login","type":"request","options":{"method":"POST","url":"http://35.231.238.114/auth/login","body":"{\n  \"email\": \"{{$trigger.payload.email}}\",\n  \"password\" : \"{{$trigger.payload.password}}\"\n}"}}', '{"flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","position_x":19,"position_y":1,"name":"Login","key":"login","type":"request","options":{"method":"POST","url":"http://35.231.238.114/auth/login","body":"{\n  \"email\": \"{{$trigger.payload.email}}\",\n  \"password\" : \"{{$trigger.payload.password}}\"\n}"}}', 136, NULL);
INSERT INTO public.directus_revisions VALUES (137, 177, 'directus_operations', 'ae241e41-a3b0-4dd5-8f90-0e86f96c34a8', '{"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","position_x":43,"position_y":1,"name":"Log","key":"log","type":"log","options":{"message":"{{$last.payload}}"}}', '{"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","position_x":43,"position_y":1,"name":"Log","key":"log","type":"log","options":{"message":"{{$last.payload}}"}}', 138, NULL);
INSERT INTO public.directus_revisions VALUES (230, 303, 'directus_fields', '36', '{"special":["uuid"],"collection":"Product","field":"id"}', '{"special":["uuid"],"collection":"Product","field":"id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (298, 386, 'directus_permissions', '23', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"fields":null,"presets":null,"collection":"Product","action":"update"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"fields":null,"presets":null,"collection":"Product","action":"update"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (299, 387, 'directus_permissions', '24', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"validation":null,"fields":null,"presets":null,"collection":"Product","action":"delete"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"validation":null,"fields":null,"presets":null,"collection":"Product","action":"delete"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (301, 391, 'directus_permissions', '18', '{"id":18,"collection":"Product","action":"read","permissions":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"read","permissions":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (369, 525, 'directus_fields', '115', '{"sort":4,"interface":"list-o2m","special":["o2m"],"collection":"Product","field":"specifications"}', '{"sort":4,"interface":"list-o2m","special":["o2m"],"collection":"Product","field":"specifications"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (139, 180, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"id":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["directus_users"]},"operation":"0a325417-f595-4af0-b2b4-b8824397d519","date_created":"2025-05-14T23:32:24.375Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["0a325417-f595-4af0-b2b4-b8824397d519","ae241e41-a3b0-4dd5-8f90-0e86f96c34a8"]}', '{"name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["directus_users"]},"operation":"0a325417-f595-4af0-b2b4-b8824397d519","date_created":"2025-05-14T23:32:24.375Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (138, 178, 'directus_operations', '0a325417-f595-4af0-b2b4-b8824397d519', '{"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","position_x":25,"position_y":1,"name":"Get Id","key":"get_id","type":"trigger","options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"{{$trigger.payload.email}}","password":"{{$trigger.payload.password}}"}},"resolve":{"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","position_x":43,"position_y":1,"name":"Log","key":"log","type":"log","options":{"message":"{{$last.payload}}"}}}', '{"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","position_x":25,"position_y":1,"name":"Get Id","key":"get_id","type":"trigger","options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"{{$trigger.payload.email}}","password":"{{$trigger.payload.password}}"}},"resolve":{"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","position_x":43,"position_y":1,"name":"Log","key":"log","type":"log","options":{"message":"{{$last.payload}}"}}}', 139, NULL);
INSERT INTO public.directus_revisions VALUES (140, 181, 'directus_operations', '9b8eca22-d0f7-44bc-a71c-4444f01d85b1', '{"flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","position_x":37,"position_y":1,"name":"Decode Token","key":"decode_token","type":"json-web-token","options":{"operation":"decode","token":"{{$last.data.access_token}}"},"resolve":null}', '{"flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","position_x":37,"position_y":1,"name":"Decode Token","key":"decode_token","type":"json-web-token","options":{"operation":"decode","token":"{{$last.data.access_token}}"},"resolve":null}', 141, NULL);
INSERT INTO public.directus_revisions VALUES (142, 183, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"id":"66904cac-25ff-48ab-9ee6-a4eac72485b2","name":"Buscar Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"},"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","date_created":"2025-05-15T01:44:35.845Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["336d194c-cf1f-410c-af63-ce913f219fb4","9b8eca22-d0f7-44bc-a71c-4444f01d85b1"]}', '{"operation":"336d194c-cf1f-410c-af63-ce913f219fb4"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (141, 182, 'directus_operations', '336d194c-cf1f-410c-af63-ce913f219fb4', '{"id":"336d194c-cf1f-410c-af63-ce913f219fb4","name":"Login","key":"login","type":"request","position_x":19,"position_y":1,"options":{"method":"POST","url":"http://35.231.238.114/auth/login","body":"{\n  \"email\": \"{{$trigger.payload.email}}\",\n  \"password\" : \"{{$trigger.payload.password}}\"\n}"},"resolve":"9b8eca22-d0f7-44bc-a71c-4444f01d85b1","reject":null,"flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","date_created":"2025-05-15T02:10:32.597Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"resolve":"9b8eca22-d0f7-44bc-a71c-4444f01d85b1","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2"}', 142, NULL);
INSERT INTO public.directus_revisions VALUES (143, 184, 'directus_operations', 'ae241e41-a3b0-4dd5-8f90-0e86f96c34a8', '{"id":"ae241e41-a3b0-4dd5-8f90-0e86f96c34a8","name":"Log","key":"log","type":"log","position_x":43,"position_y":1,"options":{"message":"{{$last}}"},"resolve":null,"reject":null,"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","date_created":"2025-05-15T02:14:51.991Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"name":"Log","key":"log","type":"log","options":{"message":"{{$last}}"},"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c"}', 144, NULL);
INSERT INTO public.directus_revisions VALUES (145, 186, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"id":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["directus_users"]},"operation":"0a325417-f595-4af0-b2b4-b8824397d519","date_created":"2025-05-14T23:32:24.375Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["0a325417-f595-4af0-b2b4-b8824397d519","ae241e41-a3b0-4dd5-8f90-0e86f96c34a8"]}', '{"operation":"0a325417-f595-4af0-b2b4-b8824397d519"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (144, 185, 'directus_operations', '0a325417-f595-4af0-b2b4-b8824397d519', '{"id":"0a325417-f595-4af0-b2b4-b8824397d519","name":"Get Id","key":"get_id","type":"trigger","position_x":25,"position_y":1,"options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"{{$trigger.payload.email}}","password":"{{$trigger.payload.password}}"}},"resolve":"ae241e41-a3b0-4dd5-8f90-0e86f96c34a8","reject":null,"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","date_created":"2025-05-15T02:14:52.254Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"resolve":"ae241e41-a3b0-4dd5-8f90-0e86f96c34a8","flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c"}', 145, NULL);
INSERT INTO public.directus_revisions VALUES (146, 188, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"steps":[{"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","key":"login","status":"reject","options":{"method":"POST","url":"http://35.231.238.114/auth/login","body":"{\n  \"email\": \"undefined\",\n  \"password\" : \"undefined\"\n}"}}],"data":{"$trigger":{"email":"usertesting@gmail.com","password":"Securepassword@1"},"$last":{"status":400,"statusText":"Bad Request","headers":{"content-security-policy":"script-src ''self'' ''unsafe-eval'';worker-src ''self'' blob:;child-src ''self'' blob:;img-src ''self'' data: blob: https://raw.githubusercontent.com https://avatars.githubusercontent.com;media-src ''self'';connect-src ''self'' https://* wss://*;default-src ''self'';base-uri ''self'';font-src ''self'' https: data:;form-action ''self'';frame-ancestors ''self'';object-src ''none'';script-src-attr ''none'';style-src ''self'' https: ''unsafe-inline''","x-powered-by":"Directus","content-type":"application/json; charset=utf-8","content-length":"159","etag":"W/\"9f-fKzJntWbdNipv4+5/KmWViL/9r4\"","date":"Thu, 15 May 2025 02:19:50 GMT","connection":"close"},"data":{"errors":[{"message":"Invalid payload. \"email\" must be a valid email.","extensions":{"reason":"\"email\" must be a valid email","code":"INVALID_PAYLOAD"}}]}},"$accountability":null,"$env":{},"login":{"status":400,"statusText":"Bad Request","headers":{"content-security-policy":"script-src ''self'' ''unsafe-eval'';worker-src ''self'' blob:;child-src ''self'' blob:;img-src ''self'' data: blob: https://raw.githubusercontent.com https://avatars.githubusercontent.com;media-src ''self'';connect-src ''self'' https://* wss://*;default-src ''self'';base-uri ''self'';font-src ''self'' https: data:;form-action ''self'';frame-ancestors ''self'';object-src ''none'';script-src-attr ''none'';style-src ''self'' https: ''unsafe-inline''","x-powered-by":"Directus","content-type":"application/json; charset=utf-8","content-length":"159","etag":"W/\"9f-fKzJntWbdNipv4+5/KmWViL/9r4\"","date":"Thu, 15 May 2025 02:19:50 GMT","connection":"close"},"data":{"errors":[{"message":"Invalid payload. \"email\" must be a valid email.","extensions":{"reason":"\"email\" must be a valid email","code":"INVALID_PAYLOAD"}}]}}}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (147, 189, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"steps":[{"operation":"0a325417-f595-4af0-b2b4-b8824397d519","key":"get_id","status":"resolve","options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"usertesting@gmail.com","password":"Securepassword@1"}}},{"operation":"ae241e41-a3b0-4dd5-8f90-0e86f96c34a8","key":"log","status":"resolve","options":{"message":{"status":400,"statusText":"Bad Request","headers":{"content-security-policy":"script-src ''self'' ''unsafe-eval'';worker-src ''self'' blob:;child-src ''self'' blob:;img-src ''self'' data: blob: https://raw.githubusercontent.com https://avatars.githubusercontent.com;media-src ''self'';connect-src ''self'' https://* wss://*;default-src ''self'';base-uri ''self'';font-src ''self'' https: data:;form-action ''self'';frame-ancestors ''self'';object-src ''none'';script-src-attr ''none'';style-src ''self'' https: ''unsafe-inline''","x-powered-by":"Directus","content-type":"application/json; charset=utf-8","content-length":"159","etag":"W/\"9f-fKzJntWbdNipv4+5/KmWViL/9r4\"","date":"Thu, 15 May 2025 02:19:50 GMT","connection":"close"},"data":{"errors":[{"message":"Invalid payload. \"email\" must be a valid email.","extensions":{"reason":"\"email\" must be a valid email","code":"INVALID_PAYLOAD"}}]}}}}],"data":{"$trigger":{"event":"users.create","payload":{"email":"usertesting@gmail.com","password":"--redacted--","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","status":"active","first_name":"User","last_name":"Testing"},"key":"a5b7379d-1ccc-489f-b60b-a7819f4a219f","collection":"directus_users"},"$last":null,"$accountability":null,"$env":{},"get_id":{"status":400,"statusText":"Bad Request","headers":{"content-security-policy":"script-src ''self'' ''unsafe-eval'';worker-src ''self'' blob:;child-src ''self'' blob:;img-src ''self'' data: blob: https://raw.githubusercontent.com https://avatars.githubusercontent.com;media-src ''self'';connect-src ''self'' https://* wss://*;default-src ''self'';base-uri ''self'';font-src ''self'' https: data:;form-action ''self'';frame-ancestors ''self'';object-src ''none'';script-src-attr ''none'';style-src ''self'' https: ''unsafe-inline''","x-powered-by":"Directus","content-type":"application/json; charset=utf-8","content-length":"159","etag":"W/\"9f-fKzJntWbdNipv4+5/KmWViL/9r4\"","date":"Thu, 15 May 2025 02:19:50 GMT","connection":"close"},"data":{"errors":[{"message":"Invalid payload. \"email\" must be a valid email.","extensions":{"reason":"\"email\" must be a valid email","code":"INVALID_PAYLOAD"}}]}},"log":null}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (148, 190, 'directus_operations', '9b8eca22-d0f7-44bc-a71c-4444f01d85b1', '{"id":"9b8eca22-d0f7-44bc-a71c-4444f01d85b1","name":"Decode Token","key":"decode_token","type":"json-web-token","position_x":37,"position_y":1,"options":{"operation":"decode","token":"{{$last.data.access_token}}"},"resolve":null,"reject":null,"flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","date_created":"2025-05-15T02:18:51.432Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2"}', 149, NULL);
INSERT INTO public.directus_revisions VALUES (150, 192, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"id":"66904cac-25ff-48ab-9ee6-a4eac72485b2","name":"Buscar Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"},"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","date_created":"2025-05-15T01:44:35.845Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["336d194c-cf1f-410c-af63-ce913f219fb4","9b8eca22-d0f7-44bc-a71c-4444f01d85b1"]}', '{"name":"Buscar Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"},"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","date_created":"2025-05-15T01:44:35.845Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (149, 191, 'directus_operations', '336d194c-cf1f-410c-af63-ce913f219fb4', '{"id":"336d194c-cf1f-410c-af63-ce913f219fb4","name":"Login","key":"login","type":"request","position_x":19,"position_y":1,"options":{"method":"POST","url":"http://35.231.238.114/auth/login","body":"{\n  \"email\": \"{{$trigger.email}}\",\n  \"password\" : \"{{$trigger.password}}\"\n}"},"resolve":"9b8eca22-d0f7-44bc-a71c-4444f01d85b1","reject":null,"flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","date_created":"2025-05-15T02:10:32.597Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"name":"Login","key":"login","type":"request","options":{"method":"POST","url":"http://35.231.238.114/auth/login","body":"{\n  \"email\": \"{{$trigger.email}}\",\n  \"password\" : \"{{$trigger.password}}\"\n}"},"resolve":"9b8eca22-d0f7-44bc-a71c-4444f01d85b1","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2"}', 150, NULL);
INSERT INTO public.directus_revisions VALUES (151, 195, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"steps":[{"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","key":"login","status":"resolve","options":{"method":"POST","url":"http://35.231.238.114/auth/login","body":"{\n  \"email\": \"usertesting@gmail.com\",\n  \"password\" : \"Securepassword@1\"\n}"}},{"operation":"9b8eca22-d0f7-44bc-a71c-4444f01d85b1","key":"decode_token","status":"resolve","options":{"operation":"decode","token":"undefined"}}],"data":{"$trigger":{"email":"usertesting@gmail.com","password":"Securepassword@1"},"$last":null,"$accountability":null,"$env":{},"login":{"status":200,"statusText":"OK","headers":{"content-security-policy":"script-src ''self'' ''unsafe-eval'';worker-src ''self'' blob:;child-src ''self'' blob:;img-src ''self'' data: blob: https://raw.githubusercontent.com https://avatars.githubusercontent.com;media-src ''self'';connect-src ''self'' https://* wss://*;default-src ''self'';base-uri ''self'';font-src ''self'' https: data:;form-action ''self'';frame-ancestors ''self'';object-src ''none'';script-src-attr ''none'';style-src ''self'' https: ''unsafe-inline''","x-powered-by":"Directus","cache-control":"no-cache","vary":"Origin, Cache-Control","content-type":"application/json; charset=utf-8","content-length":"450","etag":"W/\"1c2-in35FDVwLEckoe0lgw++wtI2ASE\"","date":"Thu, 15 May 2025 02:23:52 GMT","connection":"close"},"data":{"data":{"expires":3600,"refresh_token":"Rr5eGCu4Av0BIhnZgvSwJDACc5VImRHNRU86Sspdm9-8q-VzxtfZtTscqg0zUQhP","access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZjZGM4NTkxLTRmYTctNGQ1Ni05MzIzLTM5MzA5Yzg3OGUwMCIsInJvbGUiOiIxZWIxMzEwZi0zMjFmLTQ3MzMtOGFhZi03YTkzNWI1ODg2ZjYiLCJhcHBfYWNjZXNzIjpmYWxzZSwiYWRtaW5fYWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQ3Mjc1ODMxLCJleHAiOjE3NDcyNzk0MzEsImlzcyI6ImRpcmVjdHVzIn0.FM7VrgBNwP3MYf4Ux4mnexaXV46TB1JorPaoITryHZQ"}}},"decode_token":null}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (152, 196, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"steps":[{"operation":"0a325417-f595-4af0-b2b4-b8824397d519","key":"get_id","status":"resolve","options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"usertesting@gmail.com","password":"Securepassword@1"}}},{"operation":"ae241e41-a3b0-4dd5-8f90-0e86f96c34a8","key":"log","status":"resolve","options":{"message":null}}],"data":{"$trigger":{"event":"users.create","payload":{"email":"usertesting@gmail.com","password":"--redacted--","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","status":"active","first_name":"User","last_name":"Testing"},"key":"6cdc8591-4fa7-4d56-9323-39309c878e00","collection":"directus_users"},"$last":null,"$accountability":null,"$env":{},"get_id":null,"log":null}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (231, 304, 'directus_fields', '37', '{"special":null,"collection":"Product","field":"name"}', '{"special":null,"collection":"Product","field":"name"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (232, 305, 'directus_fields', '38', '{"special":null,"collection":"Product","field":"description"}', '{"special":null,"collection":"Product","field":"description"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (233, 306, 'directus_fields', '39', '{"special":null,"collection":"Product","field":"price"}', '{"special":null,"collection":"Product","field":"price"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (234, 307, 'directus_fields', '40', '{"special":null,"collection":"Product","field":"stock_alert"}', '{"special":null,"collection":"Product","field":"stock_alert"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (302, 393, 'directus_fields', '67', '{"sort":1,"special":["cast-boolean"],"collection":"Product","field":"published"}', '{"sort":1,"special":["cast-boolean"],"collection":"Product","field":"published"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (370, 526, 'directus_fields', '116', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"SubscriptionPlans","field":"subscriptions"}', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"SubscriptionPlans","field":"subscriptions"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (372, 528, 'EntrepreneurshipSubscription', '00000000-0000-0000-0000-000000000004', '{"id":"00000000-0000-0000-0000-000000000004","subscription_plan":"00000000-0000-0000-0000-000000000005","cutoff_date":"2025-12-31T23:59:59","last_payment":"2025-04-20T10:00:00","entrepreneurship":"00000000-0000-0000-0000-000000000007"}', '{"entrepreneurship":"00000000-0000-0000-0000-000000000007"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (453, 650, 'directus_fields', '150', '{"sort":3,"interface":"list-o2m","special":["o2m"],"collection":"ProductCategory","field":"products"}', '{"sort":3,"interface":"list-o2m","special":["o2m"],"collection":"ProductCategory","field":"products"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (153, 197, 'directus_operations', '9b8eca22-d0f7-44bc-a71c-4444f01d85b1', '{"id":"9b8eca22-d0f7-44bc-a71c-4444f01d85b1","name":"Decode Token","key":"decode_token","type":"json-web-token","position_x":37,"position_y":1,"options":{"operation":"decode","token":"{{$last.data.data.access_token}}"},"resolve":null,"reject":null,"flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","date_created":"2025-05-15T02:18:51.432Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"name":"Decode Token","key":"decode_token","type":"json-web-token","position_x":37,"position_y":1,"options":{"operation":"decode","token":"{{$last.data.data.access_token}}"},"flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2"}', 154, NULL);
INSERT INTO public.directus_revisions VALUES (155, 199, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"id":"66904cac-25ff-48ab-9ee6-a4eac72485b2","name":"Buscar Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"},"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","date_created":"2025-05-15T01:44:35.845Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["336d194c-cf1f-410c-af63-ce913f219fb4","9b8eca22-d0f7-44bc-a71c-4444f01d85b1"]}', '{"operation":"336d194c-cf1f-410c-af63-ce913f219fb4"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (154, 198, 'directus_operations', '336d194c-cf1f-410c-af63-ce913f219fb4', '{"id":"336d194c-cf1f-410c-af63-ce913f219fb4","name":"Login","key":"login","type":"request","position_x":19,"position_y":1,"options":{"method":"POST","url":"http://35.231.238.114/auth/login","body":"{\n  \"email\": \"{{$trigger.email}}\",\n  \"password\" : \"{{$trigger.password}}\"\n}"},"resolve":"9b8eca22-d0f7-44bc-a71c-4444f01d85b1","reject":null,"flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","date_created":"2025-05-15T02:10:32.597Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"resolve":"9b8eca22-d0f7-44bc-a71c-4444f01d85b1","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2"}', 155, NULL);
INSERT INTO public.directus_revisions VALUES (156, 200, 'directus_fields', '18', '{"special":["uuid"],"collection":"user_profile","field":"university"}', '{"special":["uuid"],"collection":"user_profile","field":"university"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (157, 202, 'directus_fields', '19', '{"special":null,"collection":"user_profile","field":"profile_picture"}', '{"special":null,"collection":"user_profile","field":"profile_picture"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (158, 203, 'directus_fields', '20', '{"special":null,"collection":"user_profile","field":"document"}', '{"special":null,"collection":"user_profile","field":"document"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (159, 204, 'directus_fields', '21', '{"special":null,"collection":"user_profile","field":"document_type"}', '{"special":null,"collection":"user_profile","field":"document_type"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (160, 205, 'directus_fields', '22', '{"special":null,"collection":"user_profile","field":"status"}', '{"special":null,"collection":"user_profile","field":"status"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (161, 206, 'directus_fields', '23', '{"special":["uuid"],"collection":"user_profile","field":"id"}', '{"special":["uuid"],"collection":"user_profile","field":"id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (162, 207, 'directus_fields', '24', '{"special":null,"collection":"user_profile","field":"registration_date"}', '{"special":null,"collection":"user_profile","field":"registration_date"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (163, 208, 'directus_fields', '24', '{"id":24,"collection":"user_profile","field":"registration_date","special":["date-created"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"user_profile","field":"registration_date","special":["date-created"]}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (164, 209, 'directus_fields', '25', '{"special":["cast-boolean"],"collection":"user_profile","field":"email_verification"}', '{"special":["cast-boolean"],"collection":"user_profile","field":"email_verification"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (165, 210, 'directus_fields', '26', '{"special":["uuid"],"collection":"user_profile","field":"verification"}', '{"special":["uuid"],"collection":"user_profile","field":"verification"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (166, 211, 'directus_fields', '26', '{"id":26,"collection":"user_profile","field":"verification","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"user_profile","field":"verification","special":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (167, 212, 'directus_fields', '27', '{"special":null,"collection":"user_profile","field":"user_rating"}', '{"special":null,"collection":"user_profile","field":"user_rating"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (168, 213, 'directus_fields', '28', '{"special":null,"collection":"user_profile","field":"partner_rating"}', '{"special":null,"collection":"user_profile","field":"partner_rating"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (169, 214, 'directus_fields', '23', '{"id":23,"collection":"user_profile","field":"id","special":["user-created"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"user_profile","field":"id","special":["user-created"]}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (170, 215, 'directus_fields', '23', '{"id":23,"collection":"user_profile","field":"id","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"user_profile","field":"id","special":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (253, 327, 'directus_permissions', '21', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Product","action":"delete"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Product","action":"delete"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (254, 328, 'directus_permissions', '18', '{"id":18,"collection":"Product","action":"read","permissions":null,"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"read","permissions":null,"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (303, 410, 'directus_fields', '68', '{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"Temp"}', '{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"Temp"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (317, 426, 'directus_permissions', '18', '{"id":18,"collection":"Product","action":"read","permissions":{"_or":[{"entrepreneurship":{"Partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}}]},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"read","permissions":{"_or":[{"entrepreneurship":{"Partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}}]},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (371, 527, 'directus_fields', '117', '{"sort":1,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"EntrepreneurshipSubscription","field":"entrepreneurship"}', '{"sort":1,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"EntrepreneurshipSubscription","field":"entrepreneurship"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (171, 216, 'directus_operations', '2937e439-104a-46d0-89ec-d5e42b65baf0', '{"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","position_x":37,"position_y":1,"name":"Create User Profile","key":"item_create_laiji","type":"item-create","options":{"permissions":"$full","emitEvents":false,"collection":"user_profile","payload":"{\n   \"id\": {{$last.id}}\n}"}}', '{"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","position_x":37,"position_y":1,"name":"Create User Profile","key":"item_create_laiji","type":"item-create","options":{"permissions":"$full","emitEvents":false,"collection":"user_profile","payload":"{\n   \"id\": {{$last.id}}\n}"}}', 172, NULL);
INSERT INTO public.directus_revisions VALUES (173, 219, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"id":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["directus_users"]},"operation":"0a325417-f595-4af0-b2b4-b8824397d519","date_created":"2025-05-14T23:32:24.375Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["0a325417-f595-4af0-b2b4-b8824397d519","2937e439-104a-46d0-89ec-d5e42b65baf0"]}', '{"operation":"0a325417-f595-4af0-b2b4-b8824397d519"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (172, 217, 'directus_operations', '0a325417-f595-4af0-b2b4-b8824397d519', '{"id":"0a325417-f595-4af0-b2b4-b8824397d519","name":"Get User Data","key":"get_user_data","type":"trigger","position_x":19,"position_y":1,"options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"{{$trigger.payload.email}}","password":"{{$trigger.payload.password}}"}},"resolve":"2937e439-104a-46d0-89ec-d5e42b65baf0","reject":null,"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","date_created":"2025-05-15T02:14:52.254Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"name":"Get User Data","key":"get_user_data","type":"trigger","position_x":19,"position_y":1,"options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"{{$trigger.payload.email}}","password":"{{$trigger.payload.password}}"}},"resolve":"2937e439-104a-46d0-89ec-d5e42b65baf0","flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c"}', 173, NULL);
INSERT INTO public.directus_revisions VALUES (174, 223, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"steps":[{"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","key":"login","status":"resolve","options":{"method":"POST","url":"http://35.231.238.114/auth/login","body":"{\n  \"email\": \"usertesting@gmail.com\",\n  \"password\" : \"Securepassword@1\"\n}"}},{"operation":"9b8eca22-d0f7-44bc-a71c-4444f01d85b1","key":"decode_token","status":"resolve","options":{"operation":"decode","token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImRjMGE0MTVhLWFiMmQtNDU2My05Mzc0LWRkMGZmZWRhOGQzZSIsInJvbGUiOiIxZWIxMzEwZi0zMjFmLTQ3MzMtOGFhZi03YTkzNWI1ODg2ZjYiLCJhcHBfYWNjZXNzIjpmYWxzZSwiYWRtaW5fYWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQ3Mjc3MzQxLCJleHAiOjE3NDcyODA5NDEsImlzcyI6ImRpcmVjdHVzIn0.U3GvF3nXYwc8VgECDZqLKa5mkZpeBfssjFoz9qjtBBU"}}],"data":{"$trigger":{"email":"usertesting@gmail.com","password":"Securepassword@1"},"$last":{"id":"dc0a415a-ab2d-4563-9374-dd0ffeda8d3e","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747277341,"exp":1747280941,"iss":"directus"},"$accountability":null,"$env":{},"login":{"status":200,"statusText":"OK","headers":{"content-security-policy":"script-src ''self'' ''unsafe-eval'';worker-src ''self'' blob:;child-src ''self'' blob:;img-src ''self'' data: blob: https://raw.githubusercontent.com https://avatars.githubusercontent.com;media-src ''self'';connect-src ''self'' https://* wss://*;default-src ''self'';base-uri ''self'';font-src ''self'' https: data:;form-action ''self'';frame-ancestors ''self'';object-src ''none'';script-src-attr ''none'';style-src ''self'' https: ''unsafe-inline''","x-powered-by":"Directus","cache-control":"no-cache","vary":"Origin, Cache-Control","content-type":"application/json; charset=utf-8","content-length":"450","etag":"W/\"1c2-QlIdyvqw6P77iuByE+cAav90+vs\"","date":"Thu, 15 May 2025 02:49:02 GMT","connection":"close"},"data":{"data":{"expires":3600,"refresh_token":"Y3A29XJahSD4brZDH_amlLUP7PlPTCiyk2EIJTfB-7CuJmRyrglySgV5lMNAp3CM","access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImRjMGE0MTVhLWFiMmQtNDU2My05Mzc0LWRkMGZmZWRhOGQzZSIsInJvbGUiOiIxZWIxMzEwZi0zMjFmLTQ3MzMtOGFhZi03YTkzNWI1ODg2ZjYiLCJhcHBfYWNjZXNzIjpmYWxzZSwiYWRtaW5fYWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQ3Mjc3MzQxLCJleHAiOjE3NDcyODA5NDEsImlzcyI6ImRpcmVjdHVzIn0.U3GvF3nXYwc8VgECDZqLKa5mkZpeBfssjFoz9qjtBBU"}}},"decode_token":{"id":"dc0a415a-ab2d-4563-9374-dd0ffeda8d3e","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747277341,"exp":1747280941,"iss":"directus"}}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (175, 224, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"steps":[{"operation":"0a325417-f595-4af0-b2b4-b8824397d519","key":"get_user_data","status":"resolve","options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"usertesting@gmail.com","password":"Securepassword@1"}}},{"operation":"2937e439-104a-46d0-89ec-d5e42b65baf0","key":"item_create_laiji","status":"reject","options":{"permissions":"$full","emitEvents":false,"collection":"user_profile","payload":"{\n   \"id\": dc0a415a-ab2d-4563-9374-dd0ffeda8d3e\n}"}}],"data":{"$trigger":{"event":"users.create","payload":{"email":"usertesting@gmail.com","password":"--redacted--","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","status":"active","first_name":"User","last_name":"Testing"},"key":"dc0a415a-ab2d-4563-9374-dd0ffeda8d3e","collection":"directus_users"},"$last":{"name":"SyntaxError","message":"Unexpected token ''d'', ...\"\n   \"id\": dc0a415a-a\"... is not valid JSON"},"$accountability":null,"$env":{},"get_user_data":{"id":"dc0a415a-ab2d-4563-9374-dd0ffeda8d3e","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747277341,"exp":1747280941,"iss":"directus"},"item_create_laiji":{"name":"SyntaxError","message":"Unexpected token ''d'', ...\"\n   \"id\": dc0a415a-a\"... is not valid JSON"}}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (176, 225, 'directus_operations', '2937e439-104a-46d0-89ec-d5e42b65baf0', '{"id":"2937e439-104a-46d0-89ec-d5e42b65baf0","name":"Create User Profile","key":"item_create_laiji","type":"item-create","position_x":37,"position_y":1,"options":{"permissions":"$full","emitEvents":false,"collection":"user_profile","payload":"{\"id\": {{$last.payload.id}}}"},"resolve":null,"reject":null,"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","date_created":"2025-05-15T02:48:38.697Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"name":"Create User Profile","key":"item_create_laiji","type":"item-create","options":{"permissions":"$full","emitEvents":false,"collection":"user_profile","payload":"{\"id\": {{$last.payload.id}}}"},"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c"}', 177, NULL);
INSERT INTO public.directus_revisions VALUES (178, 227, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"id":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["directus_users"]},"operation":"0a325417-f595-4af0-b2b4-b8824397d519","date_created":"2025-05-14T23:32:24.375Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["0a325417-f595-4af0-b2b4-b8824397d519","2937e439-104a-46d0-89ec-d5e42b65baf0"]}', '{"operation":"0a325417-f595-4af0-b2b4-b8824397d519"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (177, 226, 'directus_operations', '0a325417-f595-4af0-b2b4-b8824397d519', '{"id":"0a325417-f595-4af0-b2b4-b8824397d519","name":"Get User Data","key":"get_user_data","type":"trigger","position_x":19,"position_y":1,"options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"{{$trigger.payload.email}}","password":"{{$trigger.payload.password}}"}},"resolve":"2937e439-104a-46d0-89ec-d5e42b65baf0","reject":null,"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","date_created":"2025-05-15T02:14:52.254Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"resolve":"2937e439-104a-46d0-89ec-d5e42b65baf0","flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c"}', 178, NULL);
INSERT INTO public.directus_revisions VALUES (181, 233, 'directus_operations', '2937e439-104a-46d0-89ec-d5e42b65baf0', '{"id":"2937e439-104a-46d0-89ec-d5e42b65baf0","name":"Create User Profile","key":"item_create_laiji","type":"item-create","position_x":37,"position_y":1,"options":{"permissions":"$full","emitEvents":false,"collection":"user_profile","payload":{"id":"{{$last.payload.id}}"}},"resolve":null,"reject":null,"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","date_created":"2025-05-15T02:48:38.697Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"name":"Create User Profile","key":"item_create_laiji","type":"item-create","options":{"permissions":"$full","emitEvents":false,"collection":"user_profile","payload":{"id":"{{$last.payload.id}}"}},"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c"}', 182, NULL);
INSERT INTO public.directus_revisions VALUES (255, 330, 'directus_permissions', '18', '{"id":18,"collection":"Product","action":"read","permissions":{"entrepreneurship":{"user_profile":{"user":"$CURRENT_USER"}}},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"read","permissions":{"entrepreneurship":{"user_profile":{"user":"$CURRENT_USER"}}},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (257, 337, 'directus_flows', '5c9a819a-e910-4711-bdbb-7fcadd494268', '{"name":"Producto","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"filter","scope":["items.create","items.update","items.delete"],"collections":["Product"],"return":"$last"}}', '{"name":"Producto","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"filter","scope":["items.create","items.update","items.delete"],"collections":["Product"],"return":"$last"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (258, 338, 'directus_flows', '5c9a819a-e910-4711-bdbb-7fcadd494268', '{"id":"5c9a819a-e910-4711-bdbb-7fcadd494268","name":"Product Validator","icon":"library_add_check","color":"#2ECDA7","description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"filter","scope":["items.create","items.update","items.delete"],"collections":["Product"],"return":"$last"},"operation":null,"date_created":"2025-05-15T04:30:09.162Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":[]}', '{"name":"Product Validator","icon":"library_add_check","color":"#2ECDA7","description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"filter","scope":["items.create","items.update","items.delete"],"collections":["Product"],"return":"$last"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (179, 230, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"steps":[{"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","key":"login","status":"resolve","options":{"method":"POST","url":"http://35.231.238.114/auth/login","body":"{\n  \"email\": \"usertesting@gmail.com\",\n  \"password\" : \"Securepassword@1\"\n}"}},{"operation":"9b8eca22-d0f7-44bc-a71c-4444f01d85b1","key":"decode_token","status":"resolve","options":{"operation":"decode","token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjgxNzJhNmE1LWNiMGMtNGRhZi1iZjc3LTUyOTM0ODZiNjY0MCIsInJvbGUiOiIxZWIxMzEwZi0zMjFmLTQ3MzMtOGFhZi03YTkzNWI1ODg2ZjYiLCJhcHBfYWNjZXNzIjpmYWxzZSwiYWRtaW5fYWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQ3Mjc3ODg0LCJleHAiOjE3NDcyODE0ODQsImlzcyI6ImRpcmVjdHVzIn0.n5XapKPm52ySAcxyD_cZeCMI2PTsk-_wVR8-I3iQitg"}}],"data":{"$trigger":{"email":"usertesting@gmail.com","password":"Securepassword@1"},"$last":{"id":"8172a6a5-cb0c-4daf-bf77-5293486b6640","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747277884,"exp":1747281484,"iss":"directus"},"$accountability":null,"$env":{},"login":{"status":200,"statusText":"OK","headers":{"content-security-policy":"script-src ''self'' ''unsafe-eval'';worker-src ''self'' blob:;child-src ''self'' blob:;img-src ''self'' data: blob: https://raw.githubusercontent.com https://avatars.githubusercontent.com;media-src ''self'';connect-src ''self'' https://* wss://*;default-src ''self'';base-uri ''self'';font-src ''self'' https: data:;form-action ''self'';frame-ancestors ''self'';object-src ''none'';script-src-attr ''none'';style-src ''self'' https: ''unsafe-inline''","x-powered-by":"Directus","cache-control":"no-cache","vary":"Origin, Cache-Control","content-type":"application/json; charset=utf-8","content-length":"450","etag":"W/\"1c2-Whz3p/4t1nWXsfzryMx7iXUFqAM\"","date":"Thu, 15 May 2025 02:58:05 GMT","connection":"close"},"data":{"data":{"expires":3600,"refresh_token":"tBLoPaLDLjPGT6K-UMBacBH_kLmDPB_kp43ko2NK9S4e3GBCK8wBsSHOAHcA3ua3","access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjgxNzJhNmE1LWNiMGMtNGRhZi1iZjc3LTUyOTM0ODZiNjY0MCIsInJvbGUiOiIxZWIxMzEwZi0zMjFmLTQ3MzMtOGFhZi03YTkzNWI1ODg2ZjYiLCJhcHBfYWNjZXNzIjpmYWxzZSwiYWRtaW5fYWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQ3Mjc3ODg0LCJleHAiOjE3NDcyODE0ODQsImlzcyI6ImRpcmVjdHVzIn0.n5XapKPm52ySAcxyD_cZeCMI2PTsk-_wVR8-I3iQitg"}}},"decode_token":{"id":"8172a6a5-cb0c-4daf-bf77-5293486b6640","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747277884,"exp":1747281484,"iss":"directus"}}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (180, 231, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"steps":[{"operation":"0a325417-f595-4af0-b2b4-b8824397d519","key":"get_user_data","status":"resolve","options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"usertesting@gmail.com","password":"Securepassword@1"}}},{"operation":"2937e439-104a-46d0-89ec-d5e42b65baf0","key":"item_create_laiji","status":"reject","options":{"permissions":"$full","emitEvents":false,"collection":"user_profile","payload":"{\"id\": undefined}"}}],"data":{"$trigger":{"event":"users.create","payload":{"email":"usertesting@gmail.com","password":"--redacted--","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","status":"active","first_name":"User","last_name":"Testing"},"key":"8172a6a5-cb0c-4daf-bf77-5293486b6640","collection":"directus_users"},"$last":{"name":"SyntaxError","message":"Unexpected token ''u'', \"{\"id\": undefined}\" is not valid JSON"},"$accountability":null,"$env":{},"get_user_data":{"id":"8172a6a5-cb0c-4daf-bf77-5293486b6640","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747277884,"exp":1747281484,"iss":"directus"},"item_create_laiji":{"name":"SyntaxError","message":"Unexpected token ''u'', \"{\"id\": undefined}\" is not valid JSON"}}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (183, 235, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"id":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["directus_users"]},"operation":"0a325417-f595-4af0-b2b4-b8824397d519","date_created":"2025-05-14T23:32:24.375Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["0a325417-f595-4af0-b2b4-b8824397d519","2937e439-104a-46d0-89ec-d5e42b65baf0"]}', '{"operation":"0a325417-f595-4af0-b2b4-b8824397d519"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (182, 234, 'directus_operations', '0a325417-f595-4af0-b2b4-b8824397d519', '{"id":"0a325417-f595-4af0-b2b4-b8824397d519","name":"Get User Data","key":"get_user_data","type":"trigger","position_x":19,"position_y":1,"options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"{{$trigger.payload.email}}","password":"{{$trigger.payload.password}}"}},"resolve":"2937e439-104a-46d0-89ec-d5e42b65baf0","reject":null,"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","date_created":"2025-05-15T02:14:52.254Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"resolve":"2937e439-104a-46d0-89ec-d5e42b65baf0","flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c"}', 183, NULL);
INSERT INTO public.directus_revisions VALUES (184, 237, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"steps":[{"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","key":"login","status":"resolve","options":{"method":"POST","url":"http://35.231.238.114/auth/login","body":"{\n  \"email\": \"usertesting@gmail.com\",\n  \"password\" : \"Securepassword@1\"\n}"}},{"operation":"9b8eca22-d0f7-44bc-a71c-4444f01d85b1","key":"decode_token","status":"resolve","options":{"operation":"decode","token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImVhZjBjMTdhLTFiODAtNDQ1Mi1iMGVjLTJhOTg3NWQ3MTI5MiIsInJvbGUiOiIxZWIxMzEwZi0zMjFmLTQ3MzMtOGFhZi03YTkzNWI1ODg2ZjYiLCJhcHBfYWNjZXNzIjpmYWxzZSwiYWRtaW5fYWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQ3Mjc4MTg3LCJleHAiOjE3NDcyODE3ODcsImlzcyI6ImRpcmVjdHVzIn0.m00VaJPkOttFQRuyt7Ada2PMtb5d59cDjxkN90J5_UM"}}],"data":{"$trigger":{"email":"usertesting@gmail.com","password":"Securepassword@1"},"$last":{"id":"eaf0c17a-1b80-4452-b0ec-2a9875d71292","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747278187,"exp":1747281787,"iss":"directus"},"$accountability":null,"$env":{},"login":{"status":200,"statusText":"OK","headers":{"content-security-policy":"script-src ''self'' ''unsafe-eval'';worker-src ''self'' blob:;child-src ''self'' blob:;img-src ''self'' data: blob: https://raw.githubusercontent.com https://avatars.githubusercontent.com;media-src ''self'';connect-src ''self'' https://* wss://*;default-src ''self'';base-uri ''self'';font-src ''self'' https: data:;form-action ''self'';frame-ancestors ''self'';object-src ''none'';script-src-attr ''none'';style-src ''self'' https: ''unsafe-inline''","x-powered-by":"Directus","cache-control":"no-cache","vary":"Origin, Cache-Control","content-type":"application/json; charset=utf-8","content-length":"450","etag":"W/\"1c2-5MUHuWn3ARgYjc6iIroSiGbkvt8\"","date":"Thu, 15 May 2025 03:03:07 GMT","connection":"close"},"data":{"data":{"expires":3600,"refresh_token":"35zahFk6QQrtsHa5AADo4AOAjTsL8AR_JqInQxETrlLkc9bKYOCPRjhH2KB0iQqr","access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImVhZjBjMTdhLTFiODAtNDQ1Mi1iMGVjLTJhOTg3NWQ3MTI5MiIsInJvbGUiOiIxZWIxMzEwZi0zMjFmLTQ3MzMtOGFhZi03YTkzNWI1ODg2ZjYiLCJhcHBfYWNjZXNzIjpmYWxzZSwiYWRtaW5fYWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQ3Mjc4MTg3LCJleHAiOjE3NDcyODE3ODcsImlzcyI6ImRpcmVjdHVzIn0.m00VaJPkOttFQRuyt7Ada2PMtb5d59cDjxkN90J5_UM"}}},"decode_token":{"id":"eaf0c17a-1b80-4452-b0ec-2a9875d71292","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747278187,"exp":1747281787,"iss":"directus"}}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (185, 238, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"steps":[{"operation":"0a325417-f595-4af0-b2b4-b8824397d519","key":"get_user_data","status":"resolve","options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"usertesting@gmail.com","password":"Securepassword@1"}}},{"operation":"2937e439-104a-46d0-89ec-d5e42b65baf0","key":"item_create_laiji","status":"reject","options":{"permissions":"$full","emitEvents":false,"collection":"user_profile","payload":{"id":"undefined"}}}],"data":{"$trigger":{"event":"users.create","payload":{"email":"usertesting@gmail.com","password":"--redacted--","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","status":"active","first_name":"User","last_name":"Testing"},"key":"eaf0c17a-1b80-4452-b0ec-2a9875d71292","collection":"directus_users"},"$last":{"name":"DirectusError","message":"You don''t have permission to access this."},"$accountability":null,"$env":{},"get_user_data":{"id":"eaf0c17a-1b80-4452-b0ec-2a9875d71292","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747278187,"exp":1747281787,"iss":"directus"},"item_create_laiji":{"name":"DirectusError","message":"You don''t have permission to access this."}}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (186, 239, 'directus_operations', '2937e439-104a-46d0-89ec-d5e42b65baf0', '{"id":"2937e439-104a-46d0-89ec-d5e42b65baf0","name":"Create User Profile","key":"item_create_laiji","type":"item-create","position_x":37,"position_y":1,"options":{"permissions":"$trigger","emitEvents":false,"collection":"user_profile","payload":{"id":"{{$last.payload.id}}"}},"resolve":null,"reject":null,"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","date_created":"2025-05-15T02:48:38.697Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"name":"Create User Profile","key":"item_create_laiji","type":"item-create","position_x":37,"position_y":1,"options":{"permissions":"$trigger","emitEvents":false,"collection":"user_profile","payload":{"id":"{{$last.payload.id}}"}},"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c"}', 187, NULL);
INSERT INTO public.directus_revisions VALUES (188, 241, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"id":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["directus_users"]},"operation":"0a325417-f595-4af0-b2b4-b8824397d519","date_created":"2025-05-14T23:32:24.375Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["0a325417-f595-4af0-b2b4-b8824397d519","2937e439-104a-46d0-89ec-d5e42b65baf0"]}', '{"operation":"0a325417-f595-4af0-b2b4-b8824397d519"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (187, 240, 'directus_operations', '0a325417-f595-4af0-b2b4-b8824397d519', '{"id":"0a325417-f595-4af0-b2b4-b8824397d519","name":"Get User Data","key":"get_user_data","type":"trigger","position_x":19,"position_y":1,"options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"{{$trigger.payload.email}}","password":"{{$trigger.payload.password}}"}},"resolve":"2937e439-104a-46d0-89ec-d5e42b65baf0","reject":null,"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","date_created":"2025-05-15T02:14:52.254Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"resolve":"2937e439-104a-46d0-89ec-d5e42b65baf0","flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c"}', 188, NULL);
INSERT INTO public.directus_revisions VALUES (189, 242, 'directus_operations', '2937e439-104a-46d0-89ec-d5e42b65baf0', '{"id":"2937e439-104a-46d0-89ec-d5e42b65baf0","name":"Create User Profile","key":"item_create_laiji","type":"item-create","position_x":37,"position_y":1,"options":{"permissions":"$trigger","emitEvents":false,"collection":"user_profile","payload":{"id":"{{$last.id}}"}},"resolve":null,"reject":null,"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","date_created":"2025-05-15T02:48:38.697Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"name":"Create User Profile","key":"item_create_laiji","type":"item-create","options":{"permissions":"$trigger","emitEvents":false,"collection":"user_profile","payload":{"id":"{{$last.id}}"}},"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c"}', 190, NULL);
INSERT INTO public.directus_revisions VALUES (191, 244, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"id":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["directus_users"]},"operation":"0a325417-f595-4af0-b2b4-b8824397d519","date_created":"2025-05-14T23:32:24.375Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["0a325417-f595-4af0-b2b4-b8824397d519","2937e439-104a-46d0-89ec-d5e42b65baf0"]}', '{"operation":"0a325417-f595-4af0-b2b4-b8824397d519"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (190, 243, 'directus_operations', '0a325417-f595-4af0-b2b4-b8824397d519', '{"id":"0a325417-f595-4af0-b2b4-b8824397d519","name":"Get User Data","key":"get_user_data","type":"trigger","position_x":19,"position_y":1,"options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"{{$trigger.payload.email}}","password":"{{$trigger.payload.password}}"}},"resolve":"2937e439-104a-46d0-89ec-d5e42b65baf0","reject":null,"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","date_created":"2025-05-15T02:14:52.254Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"resolve":"2937e439-104a-46d0-89ec-d5e42b65baf0","flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c"}', 191, NULL);
INSERT INTO public.directus_revisions VALUES (192, 246, 'directus_operations', '2937e439-104a-46d0-89ec-d5e42b65baf0', '{"id":"2937e439-104a-46d0-89ec-d5e42b65baf0","name":"Create User Profile","key":"item_create_laiji","type":"item-create","position_x":37,"position_y":1,"options":{"permissions":"$full","emitEvents":false,"collection":"user_profile","payload":{"id":"{{$last.id}}"}},"resolve":null,"reject":null,"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","date_created":"2025-05-15T02:48:38.697Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"name":"Create User Profile","key":"item_create_laiji","type":"item-create","options":{"permissions":"$full","emitEvents":false,"collection":"user_profile","payload":{"id":"{{$last.id}}"}},"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c"}', 193, NULL);
INSERT INTO public.directus_revisions VALUES (194, 248, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"id":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","name":"Creación de Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["directus_users"]},"operation":"0a325417-f595-4af0-b2b4-b8824397d519","date_created":"2025-05-14T23:32:24.375Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["0a325417-f595-4af0-b2b4-b8824397d519","2937e439-104a-46d0-89ec-d5e42b65baf0"]}', '{"operation":"0a325417-f595-4af0-b2b4-b8824397d519"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (193, 247, 'directus_operations', '0a325417-f595-4af0-b2b4-b8824397d519', '{"id":"0a325417-f595-4af0-b2b4-b8824397d519","name":"Get User Data","key":"get_user_data","type":"trigger","position_x":19,"position_y":1,"options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"{{$trigger.payload.email}}","password":"{{$trigger.payload.password}}"}},"resolve":"2937e439-104a-46d0-89ec-d5e42b65baf0","reject":null,"flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","date_created":"2025-05-15T02:14:52.254Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"resolve":"2937e439-104a-46d0-89ec-d5e42b65baf0","flow":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c"}', 194, NULL);
INSERT INTO public.directus_revisions VALUES (195, 250, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"steps":[{"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","key":"login","status":"resolve","options":{"method":"POST","url":"http://35.231.238.114/auth/login","body":"{\n  \"email\": \"usertesting@gmail.com\",\n  \"password\" : \"Securepassword@1\"\n}"}},{"operation":"9b8eca22-d0f7-44bc-a71c-4444f01d85b1","key":"decode_token","status":"resolve","options":{"operation":"decode","token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAyOTk5ZDY4LWU5YmYtNDhlNi1hMDk0LWI1YjMzZDA5NjU4MSIsInJvbGUiOiIxZWIxMzEwZi0zMjFmLTQ3MzMtOGFhZi03YTkzNWI1ODg2ZjYiLCJhcHBfYWNjZXNzIjpmYWxzZSwiYWRtaW5fYWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQ3Mjc4NDgxLCJleHAiOjE3NDcyODIwODEsImlzcyI6ImRpcmVjdHVzIn0.NYISmN3hSqbLvpJgBpiEiMzTEryYz7mpCNkIR-kvUEg"}}],"data":{"$trigger":{"email":"usertesting@gmail.com","password":"Securepassword@1"},"$last":{"id":"02999d68-e9bf-48e6-a094-b5b33d096581","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747278481,"exp":1747282081,"iss":"directus"},"$accountability":null,"$env":{},"login":{"status":200,"statusText":"OK","headers":{"content-security-policy":"script-src ''self'' ''unsafe-eval'';worker-src ''self'' blob:;child-src ''self'' blob:;img-src ''self'' data: blob: https://raw.githubusercontent.com https://avatars.githubusercontent.com;media-src ''self'';connect-src ''self'' https://* wss://*;default-src ''self'';base-uri ''self'';font-src ''self'' https: data:;form-action ''self'';frame-ancestors ''self'';object-src ''none'';script-src-attr ''none'';style-src ''self'' https: ''unsafe-inline''","x-powered-by":"Directus","cache-control":"no-cache","vary":"Origin, Cache-Control","content-type":"application/json; charset=utf-8","content-length":"450","etag":"W/\"1c2-QbDNZAX+ZKNyGQdC75ugR4Olppg\"","date":"Thu, 15 May 2025 03:08:01 GMT","connection":"close"},"data":{"data":{"expires":3600,"refresh_token":"aOMErpycTTGm0znRr88eXuLx--IbQxNMBoMrRX4ObNAbi3ZQs4YExzpnPJ9XBt_x","access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAyOTk5ZDY4LWU5YmYtNDhlNi1hMDk0LWI1YjMzZDA5NjU4MSIsInJvbGUiOiIxZWIxMzEwZi0zMjFmLTQ3MzMtOGFhZi03YTkzNWI1ODg2ZjYiLCJhcHBfYWNjZXNzIjpmYWxzZSwiYWRtaW5fYWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQ3Mjc4NDgxLCJleHAiOjE3NDcyODIwODEsImlzcyI6ImRpcmVjdHVzIn0.NYISmN3hSqbLvpJgBpiEiMzTEryYz7mpCNkIR-kvUEg"}}},"decode_token":{"id":"02999d68-e9bf-48e6-a094-b5b33d096581","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747278481,"exp":1747282081,"iss":"directus"}}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (256, 332, 'directus_permissions', '18', '{"id":18,"collection":"Product","action":"read","permissions":{"entrepreneurship":{"user_founder":{"user":"$CURRENT_USER"}}},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"read","permissions":{"entrepreneurship":{"user_founder":{"user":"$CURRENT_USER"}}},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (283, 367, 'directus_fields', '64', '{"sort":6,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"temp_many"}', '{"sort":6,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"temp_many"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (284, 368, 'directus_collections', 'temp_many', '{"archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"temp_many"}', '{"archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"temp_many"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (300, 389, 'directus_permissions', '22', '{"id":22,"collection":"Product","action":"create","permissions":null,"validation":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"presets":null,"fields":null,"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"create","permissions":null,"validation":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"presets":null,"fields":null,"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (365, 514, 'directus_fields', '111', '{"sort":4,"interface":"list-o2m","special":["o2m"],"options":{"sort":null},"collection":"Collaboration","field":"products"}', '{"sort":4,"interface":"list-o2m","special":["o2m"],"options":{"sort":null},"collection":"Collaboration","field":"products"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (196, 251, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"steps":[{"operation":"0a325417-f595-4af0-b2b4-b8824397d519","key":"get_user_data","status":"resolve","options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"usertesting@gmail.com","password":"Securepassword@1"}}},{"operation":"2937e439-104a-46d0-89ec-d5e42b65baf0","key":"item_create_laiji","status":"reject","options":{"permissions":"$full","emitEvents":false,"collection":"user_profile","payload":{"id":"02999d68-e9bf-48e6-a094-b5b33d096581"}}}],"data":{"$trigger":{"event":"users.create","payload":{"email":"usertesting@gmail.com","password":"--redacted--","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","status":"active","first_name":"User","last_name":"Testing"},"key":"02999d68-e9bf-48e6-a094-b5b33d096581","collection":"directus_users"},"$last":{"name":"DirectusError","message":"Invalid foreign key for field \"university\" in collection \"user_profile\"."},"$accountability":null,"$env":{},"get_user_data":{"id":"02999d68-e9bf-48e6-a094-b5b33d096581","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747278481,"exp":1747282081,"iss":"directus"},"item_create_laiji":{"name":"DirectusError","message":"Invalid foreign key for field \"university\" in collection \"user_profile\"."}}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (197, 252, 'directus_fields', '23', '{"id":23,"collection":"user_profile","field":"id","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"user_profile","field":"id","sort":1,"group":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (198, 253, 'directus_fields', '18', '{"id":18,"collection":"user_profile","field":"university","special":["uuid"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"user_profile","field":"university","sort":2,"group":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (199, 254, 'directus_fields', '19', '{"id":19,"collection":"user_profile","field":"profile_picture","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"user_profile","field":"profile_picture","sort":3,"group":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (200, 255, 'directus_fields', '20', '{"id":20,"collection":"user_profile","field":"document","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"user_profile","field":"document","sort":4,"group":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (201, 256, 'directus_fields', '21', '{"id":21,"collection":"user_profile","field":"document_type","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"user_profile","field":"document_type","sort":5,"group":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (202, 257, 'directus_fields', '22', '{"id":22,"collection":"user_profile","field":"status","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"user_profile","field":"status","sort":6,"group":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (203, 258, 'directus_fields', '24', '{"id":24,"collection":"user_profile","field":"registration_date","special":["date-created"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"user_profile","field":"registration_date","sort":7,"group":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (204, 259, 'directus_fields', '25', '{"id":25,"collection":"user_profile","field":"email_verification","special":["cast-boolean"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"user_profile","field":"email_verification","sort":8,"group":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (205, 260, 'directus_fields', '26', '{"id":26,"collection":"user_profile","field":"verification","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"user_profile","field":"verification","sort":9,"group":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (206, 261, 'directus_fields', '27', '{"id":27,"collection":"user_profile","field":"user_rating","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"user_profile","field":"user_rating","sort":10,"group":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (207, 262, 'directus_fields', '28', '{"id":28,"collection":"user_profile","field":"partner_rating","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"user_profile","field":"partner_rating","sort":11,"group":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (208, 263, 'directus_fields', '18', '{"id":18,"collection":"user_profile","field":"university","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"user_profile","field":"university","special":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (212, 269, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"id":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","name":"Registro de Nuevo Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["directus_users"]},"operation":"0a325417-f595-4af0-b2b4-b8824397d519","date_created":"2025-05-14T23:32:24.375Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["0a325417-f595-4af0-b2b4-b8824397d519","2937e439-104a-46d0-89ec-d5e42b65baf0"]}', '{"name":"Registro de Nuevo Usuario","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["directus_users"]}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (366, 522, 'directus_fields', '112', '{"sort":2,"interface":"list-o2m","special":["o2m"],"collection":"Product","field":"reviews"}', '{"sort":2,"interface":"list-o2m","special":["o2m"],"collection":"Product","field":"reviews"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (209, 266, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"steps":[{"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","key":"login","status":"resolve","options":{"method":"POST","url":"http://35.231.238.114/auth/login","body":"{\n  \"email\": \"usertesting@gmail.com\",\n  \"password\" : \"Securepassword@1\"\n}"}},{"operation":"9b8eca22-d0f7-44bc-a71c-4444f01d85b1","key":"decode_token","status":"resolve","options":{"operation":"decode","token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjRiYjkxNjgyLWFkYjEtNDU1Yy1iMDQ1LTRjMzFjNWY5NzZjOSIsInJvbGUiOiIxZWIxMzEwZi0zMjFmLTQ3MzMtOGFhZi03YTkzNWI1ODg2ZjYiLCJhcHBfYWNjZXNzIjpmYWxzZSwiYWRtaW5fYWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQ3Mjc4NjY0LCJleHAiOjE3NDcyODIyNjQsImlzcyI6ImRpcmVjdHVzIn0.mk0m7aCEn9uh6-u0E2X6ypWlRmVjj2MsBJppjGI4J0U"}}],"data":{"$trigger":{"email":"usertesting@gmail.com","password":"Securepassword@1"},"$last":{"id":"4bb91682-adb1-455c-b045-4c31c5f976c9","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747278664,"exp":1747282264,"iss":"directus"},"$accountability":null,"$env":{},"login":{"status":200,"statusText":"OK","headers":{"content-security-policy":"script-src ''self'' ''unsafe-eval'';worker-src ''self'' blob:;child-src ''self'' blob:;img-src ''self'' data: blob: https://raw.githubusercontent.com https://avatars.githubusercontent.com;media-src ''self'';connect-src ''self'' https://* wss://*;default-src ''self'';base-uri ''self'';font-src ''self'' https: data:;form-action ''self'';frame-ancestors ''self'';object-src ''none'';script-src-attr ''none'';style-src ''self'' https: ''unsafe-inline''","x-powered-by":"Directus","cache-control":"no-cache","vary":"Origin, Cache-Control","content-type":"application/json; charset=utf-8","content-length":"450","etag":"W/\"1c2-T5eLfqA9lKbF/2wxs/AjQ8/NSM0\"","date":"Thu, 15 May 2025 03:11:05 GMT","connection":"close"},"data":{"data":{"expires":3600,"refresh_token":"iTouXE7eSmGSAEP9bZJQlFYzuYQxCN5f4fpii3fhZGyWgow0yLjf16-g9CIGJytG","access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjRiYjkxNjgyLWFkYjEtNDU1Yy1iMDQ1LTRjMzFjNWY5NzZjOSIsInJvbGUiOiIxZWIxMzEwZi0zMjFmLTQ3MzMtOGFhZi03YTkzNWI1ODg2ZjYiLCJhcHBfYWNjZXNzIjpmYWxzZSwiYWRtaW5fYWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQ3Mjc4NjY0LCJleHAiOjE3NDcyODIyNjQsImlzcyI6ImRpcmVjdHVzIn0.mk0m7aCEn9uh6-u0E2X6ypWlRmVjj2MsBJppjGI4J0U"}}},"decode_token":{"id":"4bb91682-adb1-455c-b045-4c31c5f976c9","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747278664,"exp":1747282264,"iss":"directus"}}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (210, 267, 'user_profile', '4bb91682-adb1-455c-b045-4c31c5f976c9', '{"id":"4bb91682-adb1-455c-b045-4c31c5f976c9"}', '{"id":"4bb91682-adb1-455c-b045-4c31c5f976c9"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (211, 268, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"steps":[{"operation":"0a325417-f595-4af0-b2b4-b8824397d519","key":"get_user_data","status":"resolve","options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"usertesting@gmail.com","password":"Securepassword@1"}}},{"operation":"2937e439-104a-46d0-89ec-d5e42b65baf0","key":"item_create_laiji","status":"resolve","options":{"permissions":"$full","emitEvents":false,"collection":"user_profile","payload":{"id":"4bb91682-adb1-455c-b045-4c31c5f976c9"}}}],"data":{"$trigger":{"event":"users.create","payload":{"email":"usertesting@gmail.com","password":"--redacted--","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","status":"active","first_name":"User","last_name":"Testing"},"key":"4bb91682-adb1-455c-b045-4c31c5f976c9","collection":"directus_users"},"$last":["4bb91682-adb1-455c-b045-4c31c5f976c9"],"$accountability":null,"$env":{},"get_user_data":{"id":"4bb91682-adb1-455c-b045-4c31c5f976c9","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747278664,"exp":1747282264,"iss":"directus"},"item_create_laiji":["4bb91682-adb1-455c-b045-4c31c5f976c9"]}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (213, 274, 'directus_permissions', '7', '{"id":7,"collection":"Product","action":"read","permissions":null,"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Product","action":"read","permissions":null,"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (214, 276, 'directus_roles', '11111111-1111-1111-1111-111111111111', '{"id":"11111111-1111-1111-1111-111111111111","name":"User","icon":"supervised_user_circle","description":"Usuario con permisos para comprar productos","parent":null,"children":[],"policies":["bc8471d8-e9e9-437e-94e8-16c22e03708b"],"users":["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"]}', '{"name":"User"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (215, 277, 'directus_roles', '11111111-1111-1111-1111-111111111111', '{"id":"11111111-1111-1111-1111-111111111111","name":"Usuario","icon":"supervised_user_circle","description":"Usuario con permisos para comprar productos","parent":null,"children":[],"policies":["bc8471d8-e9e9-437e-94e8-16c22e03708b"],"users":["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"]}', '{"name":"Usuario"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (216, 278, 'directus_roles', '11111111-1111-1111-1111-111111111111', '{"id":"11111111-1111-1111-1111-111111111111","name":"Comprador","icon":"supervised_user_circle","description":"Usuario con permisos para comprar productos","parent":null,"children":[],"policies":["bc8471d8-e9e9-437e-94e8-16c22e03708b"],"users":["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"]}', '{"name":"Comprador"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (217, 282, 'directus_access', '52dd11d7-e6fd-47ae-b715-7ac7f141a1ed', '{"policy":"4861387b-6d9c-48d1-9570-5af806d0671c","user":{"id":"f49db054-0000-4460-bb03-2f783370e377"}}', '{"policy":"4861387b-6d9c-48d1-9570-5af806d0671c","user":{"id":"f49db054-0000-4460-bb03-2f783370e377"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (218, 289, 'directus_permissions', '18', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Product","action":"read"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Product","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (219, 291, 'directus_flows', '2f88803e-8fff-44c9-a2f5-04eb8bcbe78d', '{"name":"Validar Pertenencia","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"manual","options":{"collections":["Product"]}}', '{"name":"Validar Pertenencia","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"manual","options":{"collections":["Product"]}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (220, 292, 'directus_flows', '2f88803e-8fff-44c9-a2f5-04eb8bcbe78d', '{"id":"2f88803e-8fff-44c9-a2f5-04eb8bcbe78d","name":"Validar Pertenencia","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{},"operation":null,"date_created":"2025-05-15T03:47:06.418Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":[]}', '{"name":"Validar Pertenencia","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (221, 293, 'directus_flows', '2f88803e-8fff-44c9-a2f5-04eb8bcbe78d', '{"id":"2f88803e-8fff-44c9-a2f5-04eb8bcbe78d","name":"Validar Pertenencia","icon":"bolt","color":null,"description":null,"status":"active","trigger":"webhook","accountability":"all","options":{},"operation":null,"date_created":"2025-05-15T03:47:06.418Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":[]}', '{"name":"Validar Pertenencia","icon":"bolt","color":null,"description":null,"status":"active","trigger":"webhook","accountability":"all","options":{}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (222, 295, 'directus_fields', '29', '{"special":["uuid"],"collection":"Product","field":"entrepreneurship"}', '{"special":["uuid"],"collection":"Product","field":"entrepreneurship"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (223, 296, 'directus_fields', '29', '{"id":29,"collection":"Product","field":"entrepreneurship","special":["uuid"],"interface":"select-dropdown-m2o","options":{"template":"{{id}}{{name}}"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"Product","field":"entrepreneurship","interface":"select-dropdown-m2o","options":{"template":"{{id}}{{name}}"},"readonly":false}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (224, 297, 'directus_fields', '30', '{"special":["uuid"],"collection":"Banner","field":"id"}', '{"special":["uuid"],"collection":"Banner","field":"id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (225, 298, 'directus_fields', '31', '{"special":null,"collection":"Banner","field":"url"}', '{"special":null,"collection":"Banner","field":"url"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (235, 308, 'directus_settings', '1', '{"id":1,"project_name":"Directus","project_url":"http://35.231.238.114","project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":true},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":true},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":true,"public_registration_verify_email":false,"public_registration_role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","public_registration_email_filter":null,"visual_editor_urls":null}', '{"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":true},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":true},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}]}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (236, 309, 'directus_fields', '41', '{"special":null,"collection":"Entrepreneurship","field":"slogan"}', '{"special":null,"collection":"Entrepreneurship","field":"slogan"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (237, 310, 'directus_fields', '42', '{"special":null,"collection":"Entrepreneurship","field":"description"}', '{"special":null,"collection":"Entrepreneurship","field":"description"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (238, 311, 'directus_fields', '43', '{"special":null,"collection":"Entrepreneurship","field":"creation_date"}', '{"special":null,"collection":"Entrepreneurship","field":"creation_date"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (239, 312, 'directus_fields', '44', '{"special":["uuid"],"collection":"Entrepreneurship","field":"customization"}', '{"special":["uuid"],"collection":"Entrepreneurship","field":"customization"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (240, 313, 'directus_fields', '45', '{"special":null,"collection":"Entrepreneurship","field":"email"}', '{"special":null,"collection":"Entrepreneurship","field":"email"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (241, 314, 'directus_fields', '46', '{"special":null,"collection":"Entrepreneurship","field":"phone"}', '{"special":null,"collection":"Entrepreneurship","field":"phone"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (242, 315, 'directus_fields', '47', '{"special":["uuid"],"collection":"Entrepreneurship","field":"subscription"}', '{"special":["uuid"],"collection":"Entrepreneurship","field":"subscription"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (243, 316, 'directus_fields', '48', '{"special":null,"collection":"Entrepreneurship","field":"status"}', '{"special":null,"collection":"Entrepreneurship","field":"status"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (244, 317, 'directus_fields', '49', '{"special":null,"collection":"Entrepreneurship","field":"category"}', '{"special":null,"collection":"Entrepreneurship","field":"category"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (245, 318, 'directus_fields', '45', '{"id":45,"collection":"Entrepreneurship","field":"email","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"Entrepreneurship","field":"email","width":"half"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (246, 319, 'directus_fields', '45', '{"id":45,"collection":"Entrepreneurship","field":"email","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"Entrepreneurship","field":"email","width":"full"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (247, 320, 'directus_fields', '29', '{"id":29,"collection":"Product","field":"entrepreneurship","special":["uuid"],"interface":"select-dropdown-m2o","options":{"template":"{{id}}{{name}}"},"display":"related-values","display_options":{"template":"{{id}}{{name}}{{slogan}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"Product","field":"entrepreneurship","display":"related-values","display_options":{"template":"{{id}}{{name}}{{slogan}}"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (248, 321, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"id":"66904cac-25ff-48ab-9ee6-a4eac72485b2","name":"Buscar Usuario","icon":"task","color":null,"description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"},"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","date_created":"2025-05-15T01:44:35.845Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["336d194c-cf1f-410c-af63-ce913f219fb4","9b8eca22-d0f7-44bc-a71c-4444f01d85b1"]}', '{"name":"Buscar Usuario","icon":"task","color":null,"description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (249, 322, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"id":"66904cac-25ff-48ab-9ee6-a4eac72485b2","name":"Buscar Usuario","icon":"task","color":"#E35169","description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"},"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","date_created":"2025-05-15T01:44:35.845Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["336d194c-cf1f-410c-af63-ce913f219fb4","9b8eca22-d0f7-44bc-a71c-4444f01d85b1"]}', '{"name":"Buscar Usuario","icon":"task","color":"#E35169","description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (250, 324, 'directus_fields', '9', '{"id":9,"collection":"Entrepreneurship","field":"user_founder","special":["uuid"],"interface":null,"options":null,"display":"related-values","display_options":{"template":"{{id}}{{university}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"Entrepreneurship","field":"user_founder","display":"related-values","display_options":{"template":"{{id}}{{university}}"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (251, 325, 'directus_permissions', '19', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Product","action":"create"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Product","action":"create"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (252, 326, 'directus_permissions', '20', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Product","action":"update"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Product","action":"update"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (259, 339, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"id":"66904cac-25ff-48ab-9ee6-a4eac72485b2","name":"Get User","icon":"task","color":"#E35169","description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"},"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","date_created":"2025-05-15T01:44:35.845Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["336d194c-cf1f-410c-af63-ce913f219fb4","9b8eca22-d0f7-44bc-a71c-4444f01d85b1"]}', '{"name":"Get User","icon":"task","color":"#E35169","description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (260, 341, 'directus_permissions', '18', '{"id":18,"collection":"Product","action":"read","permissions":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"read","permissions":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (261, 340, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"id":"aa2c35a0-e31c-4c4c-9181-4d6da7bea92c","name":"Register User","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["directus_users"]},"operation":"0a325417-f595-4af0-b2b4-b8824397d519","date_created":"2025-05-14T23:32:24.375Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["0a325417-f595-4af0-b2b4-b8824397d519","2937e439-104a-46d0-89ec-d5e42b65baf0"]}', '{"name":"Register User","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["directus_users"]}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (262, 345, 'directus_fields', '50', '{"special":["uuid"],"collection":"University","field":"id"}', '{"special":["uuid"],"collection":"University","field":"id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (263, 346, 'directus_fields', '51', '{"special":null,"collection":"University","field":"acronym"}', '{"special":null,"collection":"University","field":"acronym"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (264, 347, 'directus_fields', '52', '{"special":null,"collection":"University","field":"name"}', '{"special":null,"collection":"University","field":"name"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (266, 349, 'directus_flows', '5c9a819a-e910-4711-bdbb-7fcadd494268', '{"id":"5c9a819a-e910-4711-bdbb-7fcadd494268","name":"Product Validator","icon":"library_add_check","color":"#2ECDA7","description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"filter","scope":["items.create","items.update","items.delete"],"collections":["Product"],"return":"$last"},"operation":"da7fb5e9-27af-41a7-8ab6-4c399a2efe42","date_created":"2025-05-15T04:30:09.162Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["da7fb5e9-27af-41a7-8ab6-4c399a2efe42"]}', '{"name":"Product Validator","icon":"library_add_check","color":"#2ECDA7","description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"filter","scope":["items.create","items.update","items.delete"],"collections":["Product"],"return":"$last"},"operation":"da7fb5e9-27af-41a7-8ab6-4c399a2efe42","date_created":"2025-05-15T04:30:09.162Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (265, 348, 'directus_operations', 'da7fb5e9-27af-41a7-8ab6-4c399a2efe42', '{"flow":"5c9a819a-e910-4711-bdbb-7fcadd494268","position_x":19,"position_y":1,"name":"Log to Console","key":"log_ij4a1","type":"log","options":{"message":"{{$trigger}}"}}', '{"flow":"5c9a819a-e910-4711-bdbb-7fcadd494268","position_x":19,"position_y":1,"name":"Log to Console","key":"log_ij4a1","type":"log","options":{"message":"{{$trigger}}"}}', 266, NULL);
INSERT INTO public.directus_revisions VALUES (267, 350, 'Verification', 'd76eb01a-7b8b-45d9-9e15-ddf24157cc23', '{"university":"00000000-0000-0000-0000-000000000001","front_document":"a.jpg","back_document":"a.jpg","selfie_with_document":"a.jpg","status":"1","verification_date":"2025-05-14T12:00:00"}', '{"university":"00000000-0000-0000-0000-000000000001","front_document":"a.jpg","back_document":"a.jpg","selfie_with_document":"a.jpg","status":"1","verification_date":"2025-05-14T12:00:00"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (268, 351, 'Verification', 'd76eb01a-7b8b-45d9-9e15-ddf24157cc23', '{"id":"d76eb01a-7b8b-45d9-9e15-ddf24157cc23","university":"00000000-0000-0000-0000-000000000001","front_document":"a.jpg","back_document":"a.jpg","selfie_with_document":"a.jpg","status":"Pending","verification_date":"2025-05-14T12:00:00"}', '{"status":"Pending"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (269, 353, 'user_profile', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '{"id":"8360fc8e-a7cb-483f-9bb8-b12b9827d233","university":"00000000-0000-0000-0000-000000000001","document":"1231231231","document_type":"C.C","registration_date":"2025-05-14T12:00:00","user_rating":"4","partner_rating":"5","verification":"d76eb01a-7b8b-45d9-9e15-ddf24157cc23"}', '{"id":"8360fc8e-a7cb-483f-9bb8-b12b9827d233","university":"00000000-0000-0000-0000-000000000001","document":"1231231231","document_type":"C.C","registration_date":"2025-05-14T12:00:00","user_rating":"4","partner_rating":"5","verification":"d76eb01a-7b8b-45d9-9e15-ddf24157cc23"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (270, 354, 'Entrepreneurship', '00000000-0000-0000-0000-000000000007', '{"id":"00000000-0000-0000-0000-000000000007","name":"Emarket","slogan":"Compra y vende en la uni","description":"Plataforma de compraventa entre estudiantes","creation_date":"2025-04-19T12:00:00","customization":"00000000-0000-0000-0000-000000000003","email":"info@emarket.com","phone":"1234567890","subscription":"00000000-0000-0000-0000-000000000004","status":"active","category":1,"social_networks":1,"user_founder":"8360fc8e-a7cb-483f-9bb8-b12b9827d233"}', '{"user_founder":"8360fc8e-a7cb-483f-9bb8-b12b9827d233"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (271, 355, 'directus_fields', '53', '{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"Temp_Prueba"}', '{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"Temp_Prueba"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (272, 356, 'directus_fields', '54', '{"sort":2,"width":"full","options":{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]},"field":"status","collection":"Temp_Prueba"}', '{"sort":2,"width":"full","options":{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]},"field":"status","collection":"Temp_Prueba"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (273, 357, 'directus_fields', '55', '{"sort":3,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"Temp_Prueba"}', '{"sort":3,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"Temp_Prueba"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (274, 358, 'directus_fields', '56', '{"sort":4,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"Temp_Prueba"}', '{"sort":4,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"Temp_Prueba"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (275, 359, 'directus_fields', '57', '{"sort":5,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"Temp_Prueba"}', '{"sort":5,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"Temp_Prueba"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (276, 360, 'directus_fields', '58', '{"sort":6,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"Temp_Prueba"}', '{"sort":6,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"Temp_Prueba"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (277, 361, 'directus_collections', 'Temp_Prueba', '{"archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"Temp_Prueba"}', '{"archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"Temp_Prueba"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (278, 362, 'directus_fields', '59', '{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"temp_many"}', '{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"temp_many"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (279, 363, 'directus_fields', '60', '{"sort":2,"width":"full","options":{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]},"field":"status","collection":"temp_many"}', '{"sort":2,"width":"full","options":{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]},"field":"status","collection":"temp_many"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (280, 364, 'directus_fields', '61', '{"sort":3,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"temp_many"}', '{"sort":3,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"temp_many"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (281, 365, 'directus_fields', '62', '{"sort":4,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"temp_many"}', '{"sort":4,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"temp_many"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (282, 366, 'directus_fields', '63', '{"sort":5,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"temp_many"}', '{"sort":5,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"temp_many"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (287, 371, 'directus_fields', '29', '{"id":29,"collection":"Product","field":"entrepreneurship","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{id}}{{name}}"},"display":"related-values","display_options":{"template":"{{id}}{{name}}{{slogan}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"Product","field":"entrepreneurship","special":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (289, 373, 'directus_fields', '65', '{"sort":7,"special":["m2o"],"collection":"temp_many","field":"Temp_one"}', '{"sort":7,"special":["m2o"],"collection":"temp_many","field":"Temp_one"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (291, 376, 'directus_fields', '66', '{"sort":7,"special":["m2o"],"collection":"temp_many","field":"Temp_one"}', '{"sort":7,"special":["m2o"],"collection":"temp_many","field":"Temp_one"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (292, 377, 'directus_flows', '5c9a819a-e910-4711-bdbb-7fcadd494268', '{"id":"5c9a819a-e910-4711-bdbb-7fcadd494268","name":"Product Validator","icon":"library_add_check","color":"#2ECDA7","description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action"},"operation":"da7fb5e9-27af-41a7-8ab6-4c399a2efe42","date_created":"2025-05-15T04:30:09.162Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["da7fb5e9-27af-41a7-8ab6-4c399a2efe42"]}', '{"name":"Product Validator","icon":"library_add_check","color":"#2ECDA7","description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (293, 378, 'Product', 'cccdc0be-bc78-46da-8710-02d43466da2c', '{"entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', '{"entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (294, 379, 'directus_flows', '5c9a819a-e910-4711-bdbb-7fcadd494268', '{"id":"5c9a819a-e910-4711-bdbb-7fcadd494268","name":"Product Validator","icon":"library_add_check","color":"#2ECDA7","description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create","items.update","items.delete"],"collections":["Product"]},"operation":"da7fb5e9-27af-41a7-8ab6-4c399a2efe42","date_created":"2025-05-15T04:30:09.162Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["da7fb5e9-27af-41a7-8ab6-4c399a2efe42"]}', '{"name":"Product Validator","icon":"library_add_check","color":"#2ECDA7","description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create","items.update","items.delete"],"collections":["Product"]}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (295, 380, 'Product', '119f42ba-df36-4f32-8786-80c20ae3740a', '{"entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', '{"entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (296, 381, 'directus_flows', '5c9a819a-e910-4711-bdbb-7fcadd494268', '{"steps":[{"operation":"da7fb5e9-27af-41a7-8ab6-4c399a2efe42","key":"log_ij4a1","status":"resolve","options":{"message":{"event":"Product.items.create","payload":{"entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10},"key":"119f42ba-df36-4f32-8786-80c20ae3740a","collection":"Product"}}}],"data":{"$trigger":{"event":"Product.items.create","payload":{"entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10},"key":"119f42ba-df36-4f32-8786-80c20ae3740a","collection":"Product"},"$last":null,"$accountability":{"role":"8c163976-88d3-4247-a44a-587399ecf43e","user":"f49db054-0000-4460-bb03-2f783370e377","roles":["8c163976-88d3-4247-a44a-587399ecf43e"],"admin":true,"app":true,"ip":"54.86.50.139","userAgent":"PostmanRuntime/7.43.4"},"$env":{},"log_ij4a1":null}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (297, 384, 'directus_permissions', '22', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"fields":null,"presets":null,"collection":"Product","action":"create"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"fields":null,"presets":null,"collection":"Product","action":"create"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (304, 411, 'directus_fields', '69', '{"sort":2,"width":"full","options":{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]},"field":"status","collection":"Temp"}', '{"sort":2,"width":"full","options":{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]},"field":"status","collection":"Temp"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (305, 412, 'directus_fields', '70', '{"sort":3,"interface":"input","hidden":true,"field":"sort","collection":"Temp"}', '{"sort":3,"interface":"input","hidden":true,"field":"sort","collection":"Temp"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (306, 413, 'directus_fields', '71', '{"sort":4,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"Temp"}', '{"sort":4,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"Temp"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (307, 414, 'directus_fields', '72', '{"sort":5,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"Temp"}', '{"sort":5,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"Temp"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (308, 415, 'directus_collections', 'Temp', '{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"Temp"}', '{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"Temp"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (309, 416, 'directus_fields', '73', '{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"TempMany"}', '{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"TempMany"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (310, 417, 'directus_fields', '74', '{"sort":2,"width":"full","options":{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]},"field":"status","collection":"TempMany"}', '{"sort":2,"width":"full","options":{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]},"field":"status","collection":"TempMany"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (311, 418, 'directus_fields', '75', '{"sort":3,"interface":"input","hidden":true,"field":"sort","collection":"TempMany"}', '{"sort":3,"interface":"input","hidden":true,"field":"sort","collection":"TempMany"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (312, 419, 'directus_fields', '76', '{"sort":4,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"TempMany"}', '{"sort":4,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"TempMany"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (313, 420, 'directus_fields', '77', '{"sort":5,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"TempMany"}', '{"sort":5,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"TempMany"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (314, 421, 'directus_collections', 'TempMany', '{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"TempMany"}', '{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"TempMany"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (315, 422, 'directus_fields', '78', '{"sort":6,"special":["m2o"],"collection":"TempMany","field":"Temp"}', '{"sort":6,"special":["m2o"],"collection":"TempMany","field":"Temp"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (316, 424, 'directus_permissions', '18', '{"id":18,"collection":"Product","action":"read","permissions":{"_or":[{"entrepreneurship":{"Partner":{"user_profile":{"_eq":"$CURRENT_USER"}}}}]},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"read","permissions":{"_or":[{"entrepreneurship":{"Partner":{"user_profile":{"_eq":"$CURRENT_USER"}}}}]},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (318, 428, 'directus_permissions', '18', '{"id":18,"collection":"Product","action":"read","permissions":{"_or":[{"entrepreneurship":{"Partner":{"_some":{"user_profile":{"_eq":"$CURRENT_USER"}}}}}]},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"read","permissions":{"_or":[{"entrepreneurship":{"Partner":{"_some":{"user_profile":{"_eq":"$CURRENT_USER"}}}}}]},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (319, 430, 'directus_fields', '79', '{"sort":6,"special":["o2m"],"collection":"Temp","field":"partner"}', '{"sort":6,"special":["o2m"],"collection":"Temp","field":"partner"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (320, 432, 'directus_fields', '80', '{"sort":6,"special":["o2m"],"collection":"Temp","field":"many"}', '{"sort":6,"special":["o2m"],"collection":"Temp","field":"many"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (321, 433, 'directus_fields', '82', '{"sort":1,"interface":"list-o2m","special":["o2m"],"required":false,"collection":"Entrepreneurship","field":"partners"}', '{"sort":1,"interface":"list-o2m","special":["o2m"],"required":false,"collection":"Entrepreneurship","field":"partners"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (322, 434, 'directus_permissions', '18', '{"id":18,"collection":"Product","action":"read","permissions":{"_and":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}}]},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"read","permissions":{"_and":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}}]},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (323, 436, 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '{"id":"aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa","first_name":"Carlos Comprador","last_name":null,"email":"carlos@tienda.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"22222222-2222-2222-2222-222222222222","token":null,"last_access":"2025-05-15T04:34:19.607Z","last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"policies":[]}', '{"role":"22222222-2222-2222-2222-222222222222"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (324, 438, 'Partner', '6022e80e-3c5e-4b6c-b294-1880430c4373', '{"entrepreneurship":"00000000-0000-0000-0000-000000000007","user_profile":"8360fc8e-a7cb-483f-9bb8-b12b9827d233","partner_rol":1,"rating":4,"comment":"fff"}', '{"entrepreneurship":"00000000-0000-0000-0000-000000000007","user_profile":"8360fc8e-a7cb-483f-9bb8-b12b9827d233","partner_rol":1,"rating":4,"comment":"fff"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (325, 441, 'directus_permissions', '18', '{"id":18,"collection":"Product","action":"read","permissions":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]}]},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"read","permissions":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]}]},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (326, 460, 'directus_fields', '83', '{"sort":12,"interface":"list-o2m","special":["o2m"],"required":false,"collection":"user_profile","field":"orders"}', '{"sort":12,"interface":"list-o2m","special":["o2m"],"required":false,"collection":"user_profile","field":"orders"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (327, 461, 'directus_permissions', '25', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":{"_and":[{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}]},"validation":null,"fields":null,"presets":null,"collection":"Order","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":{"_and":[{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}]},"validation":null,"fields":null,"presets":null,"collection":"Order","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (328, 463, 'directus_fields', '84', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"Collaboration","field":"images"}', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"Collaboration","field":"images"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (329, 464, 'directus_fields', '85', '{"sort":2,"interface":"list-m2m","special":["m2m"],"collection":"Collaboration","field":"entrepreneurships"}', '{"sort":2,"interface":"list-m2m","special":["m2m"],"collection":"Collaboration","field":"entrepreneurships"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (330, 465, 'directus_fields', '86', '{"sort":1,"hidden":true,"field":"id","collection":"Collaboration_Entrepreneurship"}', '{"sort":1,"hidden":true,"field":"id","collection":"Collaboration_Entrepreneurship"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (331, 466, 'directus_collections', 'Collaboration_Entrepreneurship', '{"hidden":true,"icon":"import_export","collection":"Collaboration_Entrepreneurship"}', '{"hidden":true,"icon":"import_export","collection":"Collaboration_Entrepreneurship"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (332, 467, 'directus_fields', '87', '{"sort":2,"hidden":true,"collection":"Collaboration_Entrepreneurship","field":"Collaboration_id"}', '{"sort":2,"hidden":true,"collection":"Collaboration_Entrepreneurship","field":"Collaboration_id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (333, 468, 'directus_fields', '88', '{"sort":3,"hidden":true,"collection":"Collaboration_Entrepreneurship","field":"Entrepreneurship_id"}', '{"sort":3,"hidden":true,"collection":"Collaboration_Entrepreneurship","field":"Entrepreneurship_id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (335, 471, 'directus_permissions', '26', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]}]},"fields":null,"presets":null,"collection":"Collaboration","action":"create"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]}]},"fields":null,"presets":null,"collection":"Collaboration","action":"create"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (336, 473, 'Collaboration', '792ec089-942c-446b-b1c7-18fd3f6532ea', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (337, 474, 'directus_collections', 'Collaboration_Entrepreneurship', '{"collection":"Collaboration_Entrepreneurship","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}', '{"hidden":false}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (367, 523, 'directus_fields', '113', '{"sort":3,"interface":"list-o2m","special":["o2m"],"collection":"Product","field":"variants"}', '{"sort":3,"interface":"list-o2m","special":["o2m"],"collection":"Product","field":"variants"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (368, 524, 'directus_fields', '114', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"ProductVariant","field":"variant_images"}', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"ProductVariant","field":"variant_images"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (373, 529, 'directus_fields', '118', '{"sort":2,"interface":"list-o2m","special":["o2m"],"collection":"Entrepreneurship","field":"products"}', '{"sort":2,"interface":"list-o2m","special":["o2m"],"collection":"Entrepreneurship","field":"products"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (338, 475, 'directus_permissions', '26', '{"id":26,"collection":"Collaboration","action":"create","permissions":null,"validation":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$id"}}}}]}]},"presets":null,"fields":["images","description","id","entrepreneurships","price","name"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Collaboration","action":"create","permissions":null,"validation":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$id"}}}}]}]},"presets":null,"fields":["images","description","id","entrepreneurships","price","name"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (339, 478, 'Collaboration', '6b6df512-bccd-4052-9445-482dfa13a80a', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (340, 483, 'directus_fields', '85', '{"id":85,"collection":"Collaboration","field":"entrepreneurships","special":["m2m"],"interface":"list-m2m","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}', '{"collection":"Collaboration","field":"entrepreneurships","required":true}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (341, 484, 'directus_permissions', '27', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":{"_and":[{"_or":[{"entrepreneurships":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurships":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]}]},"fields":null,"presets":null,"collection":"Collaboration","action":"create"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":{"_and":[{"_or":[{"entrepreneurships":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurships":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]}]},"fields":null,"presets":null,"collection":"Collaboration","action":"create"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (342, 486, 'Collaboration', '169f5ef7-fc33-4f28-aa3f-25930743b45d', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (343, 490, 'directus_fields', '89', '{"sort":13,"interface":"list-o2m","special":["o2m"],"collection":"user_profile","field":"entrepreneurships"}', '{"sort":13,"interface":"list-o2m","special":["o2m"],"collection":"user_profile","field":"entrepreneurships"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (344, 491, 'directus_fields', '90', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"University","field":"users"}', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"University","field":"users"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (345, 493, 'directus_fields', '91', '{"sort":14,"interface":"list-o2m","special":["o2m"],"collection":"user_profile","field":"notifications"}', '{"sort":14,"interface":"list-o2m","special":["o2m"],"collection":"user_profile","field":"notifications"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (346, 494, 'directus_fields', '92', '{"sort":15,"interface":"list-o2m","special":["o2m"],"collection":"user_profile","field":"partner_entrepreneurships"}', '{"sort":15,"interface":"list-o2m","special":["o2m"],"collection":"user_profile","field":"partner_entrepreneurships"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (347, 495, 'directus_fields', '93', '{"sort":16,"interface":"list-o2m","special":["o2m"],"collection":"user_profile","field":"reviews"}', '{"sort":16,"interface":"list-o2m","special":["o2m"],"collection":"user_profile","field":"reviews"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (348, 496, 'directus_fields', '94', '{"sort":17,"interface":"list-o2m","special":["o2m"],"collection":"user_profile","field":"delivery_logs"}', '{"sort":17,"interface":"list-o2m","special":["o2m"],"collection":"user_profile","field":"delivery_logs"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (349, 497, 'directus_fields', '95', '{"sort":1,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"UserStatus","field":"users"}', '{"sort":1,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"UserStatus","field":"users"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (350, 499, 'directus_fields', '96', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"UserStatus","field":"users"}', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"UserStatus","field":"users"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (351, 500, 'directus_fields', '97', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"Verification","field":"user"}', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"Verification","field":"user"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (352, 501, 'directus_fields', '98', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"NotificationType","field":"notifications"}', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"NotificationType","field":"notifications"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (353, 502, 'directus_fields', '99', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"PartnerRol","field":"user_partners"}', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"PartnerRol","field":"user_partners"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (354, 503, 'directus_fields', '100', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"Partner","field":"deliveries"}', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"Partner","field":"deliveries"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (355, 504, 'directus_fields', '101', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"DeliveryStatus","field":"deliveries"}', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"DeliveryStatus","field":"deliveries"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (356, 505, 'directus_fields', '102', '{"sort":2,"interface":"list-o2m","special":["o2m"],"collection":"Delivery","field":"deliverylogs"}', '{"sort":2,"interface":"list-o2m","special":["o2m"],"collection":"Delivery","field":"deliverylogs"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (357, 506, 'directus_fields', '103', '{"sort":2,"interface":"list-o2m","special":["o2m"],"collection":"DeliveryStatus","field":"deliverylogs"}', '{"sort":2,"interface":"list-o2m","special":["o2m"],"collection":"DeliveryStatus","field":"deliverylogs"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (358, 507, 'directus_fields', '104', '{"sort":1,"interface":"list-o2m","special":["o2m"],"options":{"sort":null},"collection":"PaymentMethod","field":"payments"}', '{"sort":1,"interface":"list-o2m","special":["o2m"],"options":{"sort":null},"collection":"PaymentMethod","field":"payments"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (359, 508, 'directus_fields', '105', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"Payment","field":"payment_evidences"}', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"Payment","field":"payment_evidences"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (360, 509, 'directus_fields', '106', '{"sort":3,"interface":"list-o2m","special":["o2m"],"collection":"OrderStatus","field":"orders"}', '{"sort":3,"interface":"list-o2m","special":["o2m"],"collection":"OrderStatus","field":"orders"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (361, 510, 'directus_fields', '107', '{"sort":2,"interface":"list-o2m","special":["o2m"],"collection":"Order","field":"payments"}', '{"sort":2,"interface":"list-o2m","special":["o2m"],"collection":"Order","field":"payments"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (362, 511, 'directus_fields', '108', '{"sort":3,"interface":"list-o2m","special":["o2m"],"collection":"Order","field":"order_details"}', '{"sort":3,"interface":"list-o2m","special":["o2m"],"collection":"Order","field":"order_details"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (363, 512, 'directus_fields', '109', '{"sort":2,"special":null,"collection":"Payment","field":"total_paid"}', '{"sort":2,"special":null,"collection":"Payment","field":"total_paid"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (364, 513, 'directus_fields', '110', '{"sort":3,"interface":"list-o2m","special":["o2m"],"collection":"Collaboration","field":"members"}', '{"sort":3,"interface":"list-o2m","special":["o2m"],"collection":"Collaboration","field":"members"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (412, 599, 'directus_fields', '132', '{"special":["uuid"],"collection":"ProductVariant","field":"id"}', '{"special":["uuid"],"collection":"ProductVariant","field":"id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (374, 530, 'directus_fields', '119', '{"sort":3,"interface":"list-o2m","special":["o2m"],"collection":"Entrepreneurship","field":"collaborations"}', '{"sort":3,"interface":"list-o2m","special":["o2m"],"collection":"Entrepreneurship","field":"collaborations"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (375, 531, 'directus_fields', '120', '{"sort":4,"interface":"list-o2m","special":["o2m"],"collection":"Entrepreneurship","field":"orders"}', '{"sort":4,"interface":"list-o2m","special":["o2m"],"collection":"Entrepreneurship","field":"orders"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (376, 532, 'directus_fields', '121', '{"special":null,"collection":"SocialNetWork","field":"id"}', '{"special":null,"collection":"SocialNetWork","field":"id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (377, 535, 'directus_fields', '122', '{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"SocialNetwork"}', '{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"SocialNetwork"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (378, 536, 'directus_collections', 'SocialNetwork', '{"singleton":false,"collection":"SocialNetwork"}', '{"singleton":false,"collection":"SocialNetwork"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (379, 537, 'directus_fields', '123', '{"sort":2,"special":null,"collection":"SocialNetwork","field":"platform"}', '{"sort":2,"special":null,"collection":"SocialNetwork","field":"platform"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (380, 538, 'directus_fields', '124', '{"sort":3,"special":null,"collection":"SocialNetwork","field":"url"}', '{"sort":3,"special":null,"collection":"SocialNetwork","field":"url"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (381, 539, 'directus_fields', '125', '{"sort":4,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"SocialNetwork","field":"entrepreneurship"}', '{"sort":4,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"SocialNetwork","field":"entrepreneurship"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (382, 541, 'directus_fields', '126', '{"sort":5,"interface":"list-o2m","special":["o2m"],"collection":"Entrepreneurship","field":"social_networks"}', '{"sort":5,"interface":"list-o2m","special":["o2m"],"collection":"Entrepreneurship","field":"social_networks"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (383, 542, 'directus_fields', '127', '{"sort":1,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"EntrepreneurshipCustomization","field":"entrepreneurship"}', '{"sort":1,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"EntrepreneurshipCustomization","field":"entrepreneurship"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (384, 543, 'EntrepreneurshipCustomization', '00000000-0000-0000-0000-000000000003', '{"id":"00000000-0000-0000-0000-000000000003","profile_img":"perfil.jpg","banner_img":"banner.jpg","color1":"#FFFFFF","color2":"#000000","entrepreneurship":"00000000-0000-0000-0000-000000000007"}', '{"entrepreneurship":"00000000-0000-0000-0000-000000000007"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (385, 544, 'directus_fields', '128', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"EntrepreneurshipType","field":"entrepreneurships"}', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"EntrepreneurshipType","field":"entrepreneurships"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (386, 545, 'directus_permissions', '7', '{"id":7,"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (387, 547, 'directus_permissions', '28', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Entrepreneurship","action":"create"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Entrepreneurship","action":"create"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (388, 548, 'directus_permissions', '22', '{"id":22,"collection":"Product","action":"create","permissions":null,"validation":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"presets":null,"fields":["published","variants","specifications","name","entrepreneurship","description","price","stock_alert"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"create","permissions":null,"validation":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"presets":null,"fields":["published","variants","specifications","name","entrepreneurship","description","price","stock_alert"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (389, 553, 'directus_permissions', '22', '{"id":22,"collection":"Product","action":"create","permissions":null,"validation":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"create","permissions":null,"validation":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (390, 555, 'directus_permissions', '22', '{"id":22,"collection":"Product","action":"create","permissions":null,"validation":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert","entrepreneurship"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"create","permissions":null,"validation":{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert","entrepreneurship"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (391, 558, 'directus_permissions', '22', '{"id":22,"collection":"Product","action":"create","permissions":null,"validation":{"_and":[{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},{"price":{"_gte":"0"}}]},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert","entrepreneurship"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"create","permissions":null,"validation":{"_and":[{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}},{"price":{"_gte":"0"}}]},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert","entrepreneurship"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (392, 560, 'directus_fields', '29', '{"id":29,"collection":"Product","field":"entrepreneurship","special":null,"interface":null,"options":{"template":null},"display":"related-values","display_options":{"template":"{{id}}{{name}}{{slogan}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"Product","field":"entrepreneurship","interface":null,"options":{"template":null}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (393, 561, 'directus_permissions', '29', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Entrepreneurship","action":"read"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Entrepreneurship","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (394, 566, 'directus_permissions', '30', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Entrepreneurship","action":"read"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Entrepreneurship","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (395, 568, 'directus_permissions', '22', '{"id":22,"collection":"Product","action":"create","permissions":null,"validation":{"_and":[{"price":{"_gte":"0"}}]},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert","entrepreneurship"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"create","permissions":null,"validation":{"_and":[{"price":{"_gte":"0"}}]},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert","entrepreneurship"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (396, 570, 'Product', '8eb18a4b-bf30-42d0-9f65-79d62d73d0a9', '{"entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', '{"entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (397, 571, 'directus_permissions', '22', '{"id":22,"collection":"Product","action":"create","permissions":null,"validation":{"_and":[{"price":{"_gte":"0"}},{"entrepreneurship":{"user_founder":{"_eq":"$CURRENT_USER"}}}]},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert","entrepreneurship"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"create","permissions":null,"validation":{"_and":[{"price":{"_gte":"0"}},{"entrepreneurship":{"user_founder":{"_eq":"$CURRENT_USER"}}}]},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert","entrepreneurship"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (398, 573, 'directus_permissions', '22', '{"id":22,"collection":"Product","action":"create","permissions":null,"validation":{"_and":[{"price":{"_gte":"0"}},{"entrepreneurship":{"user_founder":{"_eq":"$CURRENT_USER"}}}]},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"create","permissions":null,"validation":{"_and":[{"price":{"_gte":"0"}},{"entrepreneurship":{"user_founder":{"_eq":"$CURRENT_USER"}}}]},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (399, 575, 'directus_permissions', '22', '{"id":22,"collection":"Product","action":"create","permissions":null,"validation":{"_and":[{"price":{"_gte":"0"}},{"entrepreneurship":{"user_founder":{"_eq":"$CURRENT_USER"}}}]},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert","entrepreneurship"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"create","permissions":null,"validation":{"_and":[{"price":{"_gte":"0"}},{"entrepreneurship":{"user_founder":{"_eq":"$CURRENT_USER"}}}]},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert","entrepreneurship"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (400, 577, 'Product', 'f7bff1e4-fc7b-45e1-b021-b72efbc20bab', '{"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', '{"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (401, 578, 'Product', '6aa5195e-1fab-46ff-bed3-0259c45d4e41', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (402, 580, 'Product', 'f6e9d8cb-2eba-4536-84d4-9db480da3b26', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (403, 587, 'Product', '8893bbf2-2267-4a26-89bb-815087c5c859', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (404, 588, 'directus_permissions', '22', '{"id":22,"collection":"Product","action":"create","permissions":null,"validation":{"_and":[{"price":{"_gte":"0"}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert","entrepreneurship"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"create","permissions":null,"validation":{"_and":[{"price":{"_gte":"0"}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert","entrepreneurship"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (405, 590, 'Product', '6f41a854-d702-43c6-a3af-e91c5bae8128', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (406, 592, 'Product', 'e6813b20-857a-4a84-878e-6857867a5cea', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (407, 593, 'directus_fields', '129', '{"special":null,"collection":"ProductVariant","field":"nombre"}', '{"special":null,"collection":"ProductVariant","field":"nombre"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (408, 594, 'directus_fields', '130', '{"sort":2,"special":null,"collection":"ProductVariant","field":"name"}', '{"sort":2,"special":null,"collection":"ProductVariant","field":"name"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (409, 595, 'ProductVariant', '00000000-0000-0000-0000-00000000000f', '{"id":"00000000-0000-0000-0000-00000000000f","product":"00000000-0000-0000-0000-00000000000e","nombre":"Talla M","stock":50,"name":"Talla M","variant_images":["00000000-0000-0000-0000-000000000010"]}', '{"name":"Talla M"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (410, 597, 'directus_fields', '130', '{"id":130,"collection":"ProductVariant","field":"name","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"ProductVariant","field":"name","required":false}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (411, 598, 'directus_fields', '131', '{"special":["uuid"],"collection":"ProductVariant","field":"product"}', '{"special":["uuid"],"collection":"ProductVariant","field":"product"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (413, 600, 'directus_fields', '133', '{"special":null,"collection":"ProductSpecification","field":"key"}', '{"special":null,"collection":"ProductSpecification","field":"key"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (414, 601, 'directus_fields', '134', '{"special":null,"collection":"ProductSpecification","field":"value"}', '{"special":null,"collection":"ProductSpecification","field":"value"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (415, 602, 'directus_fields', '135', '{"special":["uuid"],"collection":"ProductSpecification","field":"product"}', '{"special":["uuid"],"collection":"ProductSpecification","field":"product"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (416, 603, 'directus_fields', '136', '{"special":["uuid"],"collection":"ProductSpecification","field":"id"}', '{"special":["uuid"],"collection":"ProductSpecification","field":"id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (417, 605, 'directus_flows', '3b20c117-7bf0-46ee-8c14-234e7714a17f', '{"name":"Maker Order","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"action","scope":["items.update"],"collections":["Order"]}}', '{"name":"Maker Order","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"action","scope":["items.update"],"collections":["Order"]}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (419, 607, 'directus_flows', '3b20c117-7bf0-46ee-8c14-234e7714a17f', '{"id":"3b20c117-7bf0-46ee-8c14-234e7714a17f","name":"Maker Order","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["Order"]},"operation":"96889676-413d-4e8e-a61d-836ad7799ef8","date_created":"2025-05-16T15:40:05.547Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["96889676-413d-4e8e-a61d-836ad7799ef8"]}', '{"operation":"96889676-413d-4e8e-a61d-836ad7799ef8"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (418, 606, 'directus_operations', '96889676-413d-4e8e-a61d-836ad7799ef8', '{"flow":"3b20c117-7bf0-46ee-8c14-234e7714a17f","position_x":19,"position_y":1,"name":"Condition","key":"condition_h5wag","type":"condition","options":{}}', '{"flow":"3b20c117-7bf0-46ee-8c14-234e7714a17f","position_x":19,"position_y":1,"name":"Condition","key":"condition_h5wag","type":"condition","options":{}}', 419, NULL);
INSERT INTO public.directus_revisions VALUES (420, 608, 'directus_operations', '0a6bb686-45db-4ec9-93b2-941396e09bfa', '{"flow":"3b20c117-7bf0-46ee-8c14-234e7714a17f","position_x":37,"position_y":1,"name":"Log to Console","key":"log_k8e4x","type":"log","options":{"message":"sisas"}}', '{"flow":"3b20c117-7bf0-46ee-8c14-234e7714a17f","position_x":37,"position_y":1,"name":"Log to Console","key":"log_k8e4x","type":"log","options":{"message":"sisas"}}', 422, NULL);
INSERT INTO public.directus_revisions VALUES (421, 609, 'directus_operations', '909ade44-4d93-48ed-b6a2-b4514e7aebd5', '{"flow":"3b20c117-7bf0-46ee-8c14-234e7714a17f","position_x":37,"position_y":19,"name":"Log to Console","key":"log_skgcp","type":"log","options":{"message":"nonas"}}', '{"flow":"3b20c117-7bf0-46ee-8c14-234e7714a17f","position_x":37,"position_y":19,"name":"Log to Console","key":"log_skgcp","type":"log","options":{"message":"nonas"}}', 422, NULL);
INSERT INTO public.directus_revisions VALUES (423, 611, 'directus_flows', '3b20c117-7bf0-46ee-8c14-234e7714a17f', '{"id":"3b20c117-7bf0-46ee-8c14-234e7714a17f","name":"Maker Order","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["Order"]},"operation":"96889676-413d-4e8e-a61d-836ad7799ef8","date_created":"2025-05-16T15:40:05.547Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["0a6bb686-45db-4ec9-93b2-941396e09bfa","909ade44-4d93-48ed-b6a2-b4514e7aebd5","96889676-413d-4e8e-a61d-836ad7799ef8"]}', '{"operation":"96889676-413d-4e8e-a61d-836ad7799ef8"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (422, 610, 'directus_operations', '96889676-413d-4e8e-a61d-836ad7799ef8', '{"id":"96889676-413d-4e8e-a61d-836ad7799ef8","name":"Condition","key":"condition_h5wag","type":"condition","position_x":19,"position_y":1,"options":{"filter":{"$trigger":{"payload":{"status":{"_eq":"e0f5b827-f8ca-4dcb-8ac0-7c2ccb4663f0"}}}}},"resolve":"0a6bb686-45db-4ec9-93b2-941396e09bfa","reject":"909ade44-4d93-48ed-b6a2-b4514e7aebd5","flow":"3b20c117-7bf0-46ee-8c14-234e7714a17f","date_created":"2025-05-16T15:41:49.914Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"name":"Condition","key":"condition_h5wag","type":"condition","options":{"filter":{"$trigger":{"payload":{"status":{"_eq":"e0f5b827-f8ca-4dcb-8ac0-7c2ccb4663f0"}}}}},"resolve":"0a6bb686-45db-4ec9-93b2-941396e09bfa","reject":"909ade44-4d93-48ed-b6a2-b4514e7aebd5","flow":"3b20c117-7bf0-46ee-8c14-234e7714a17f"}', 423, NULL);
INSERT INTO public.directus_revisions VALUES (424, 612, 'directus_permissions', '31', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Product","action":"create"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Product","action":"create"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (425, 613, 'directus_permissions', '32', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Order","action":"create"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Order","action":"create"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (426, 615, 'directus_fields', '14', '{"id":14,"collection":"Order","field":"status","special":["m2o"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"Order","field":"status","special":["m2o"]}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (427, 616, 'directus_fields', '137', '{"special":["uuid"],"collection":"Order","field":"user_profile"}', '{"special":["uuid"],"collection":"Order","field":"user_profile"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (428, 617, 'directus_fields', '138', '{"special":null,"collection":"Order","field":"date"}', '{"special":null,"collection":"Order","field":"date"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (429, 618, 'directus_fields', '138', '{"id":138,"collection":"Order","field":"date","special":["date-created"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"Order","field":"date","special":["date-created"]}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (450, 647, 'directus_collections', 'ProductCategory', '{"singleton":false,"collection":"ProductCategory"}', '{"singleton":false,"collection":"ProductCategory"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (452, 649, 'directus_fields', '149', '{"sort":5,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"Product","field":"category"}', '{"sort":5,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"Product","field":"category"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (430, 619, 'directus_operations', '0a6bb686-45db-4ec9-93b2-941396e09bfa', '{"id":"0a6bb686-45db-4ec9-93b2-941396e09bfa","name":"Log to Console","key":"log_k8e4x","type":"log","position_x":37,"position_y":1,"options":{"message":"sisas"},"resolve":null,"reject":null,"flow":"3b20c117-7bf0-46ee-8c14-234e7714a17f","date_created":"2025-05-16T15:52:43.446Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"flow":"3b20c117-7bf0-46ee-8c14-234e7714a17f"}', 432, NULL);
INSERT INTO public.directus_revisions VALUES (431, 620, 'directus_operations', '909ade44-4d93-48ed-b6a2-b4514e7aebd5', '{"id":"909ade44-4d93-48ed-b6a2-b4514e7aebd5","name":"Log to Console","key":"log_skgcp","type":"log","position_x":37,"position_y":19,"options":{"message":"nonas"},"resolve":null,"reject":null,"flow":"3b20c117-7bf0-46ee-8c14-234e7714a17f","date_created":"2025-05-16T15:52:43.732Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"flow":"3b20c117-7bf0-46ee-8c14-234e7714a17f"}', 432, NULL);
INSERT INTO public.directus_revisions VALUES (433, 622, 'directus_flows', '3b20c117-7bf0-46ee-8c14-234e7714a17f', '{"id":"3b20c117-7bf0-46ee-8c14-234e7714a17f","name":"Maker Order","icon":"bolt","color":null,"description":null,"status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["Order"]},"operation":"96889676-413d-4e8e-a61d-836ad7799ef8","date_created":"2025-05-16T15:40:05.547Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["0a6bb686-45db-4ec9-93b2-941396e09bfa","909ade44-4d93-48ed-b6a2-b4514e7aebd5","96889676-413d-4e8e-a61d-836ad7799ef8"]}', '{"operation":"96889676-413d-4e8e-a61d-836ad7799ef8"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (432, 621, 'directus_operations', '96889676-413d-4e8e-a61d-836ad7799ef8', '{"id":"96889676-413d-4e8e-a61d-836ad7799ef8","name":"Condition","key":"condition_h5wag","type":"condition","position_x":19,"position_y":1,"options":{"filter":{"$trigger":{"payload":{"status":{"_eq":"e0f5b827-f8ca-4dcb-8ac0-7c2ccb4663f0"}}}}},"resolve":"0a6bb686-45db-4ec9-93b2-941396e09bfa","reject":"909ade44-4d93-48ed-b6a2-b4514e7aebd5","flow":"3b20c117-7bf0-46ee-8c14-234e7714a17f","date_created":"2025-05-16T15:41:49.914Z","user_created":"f49db054-0000-4460-bb03-2f783370e377"}', '{"name":"Condition","key":"condition_h5wag","type":"condition","options":{"filter":{"$trigger":{"payload":{"status":{"_eq":"e0f5b827-f8ca-4dcb-8ac0-7c2ccb4663f0"}}}}},"resolve":"0a6bb686-45db-4ec9-93b2-941396e09bfa","reject":"909ade44-4d93-48ed-b6a2-b4514e7aebd5","flow":"3b20c117-7bf0-46ee-8c14-234e7714a17f"}', 433, NULL);
INSERT INTO public.directus_revisions VALUES (434, 624, 'Order', '00000000-0000-0000-0000-000000000013', NULL, '{"status":"e0f5b827-f8ca-4dcb-8ac0-7c2ccb4663f0"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (435, 625, 'directus_flows', '3b20c117-7bf0-46ee-8c14-234e7714a17f', '{"steps":[{"operation":"96889676-413d-4e8e-a61d-836ad7799ef8","key":"condition_h5wag","status":"resolve","options":{"filter":{"$trigger":{"payload":{"status":{"_eq":"e0f5b827-f8ca-4dcb-8ac0-7c2ccb4663f0"}}}}}},{"operation":"0a6bb686-45db-4ec9-93b2-941396e09bfa","key":"log_k8e4x","status":"resolve","options":{"message":"sisas"}}],"data":{"$trigger":{"event":"Order.items.update","payload":{"status":"e0f5b827-f8ca-4dcb-8ac0-7c2ccb4663f0"},"keys":["00000000-0000-0000-0000-000000000013"],"collection":"Order"},"$last":null,"$accountability":{"role":"8c163976-88d3-4247-a44a-587399ecf43e","user":"f49db054-0000-4460-bb03-2f783370e377","roles":["8c163976-88d3-4247-a44a-587399ecf43e"],"admin":true,"app":true,"ip":"54.86.50.139","userAgent":"PostmanRuntime/7.43.4"},"$env":{},"condition_h5wag":null,"log_k8e4x":null}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (436, 626, 'directus_flows', '05d702bd-3f09-4a0b-9b4c-ca574255c4e7', '{"name":"Get Product","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"operation","options":{"return":"$last"}}', '{"name":"Get Product","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"operation","options":{"return":"$last"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (437, 627, 'directus_flows', '05d702bd-3f09-4a0b-9b4c-ca574255c4e7', '{"id":"05d702bd-3f09-4a0b-9b4c-ca574255c4e7","name":"Get Product","icon":null,"color":"#E35169","description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"},"operation":null,"date_created":"2025-05-16T16:17:01.885Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":[]}', '{"name":"Get Product","icon":null,"color":"#E35169","description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (438, 628, 'directus_flows', '05d702bd-3f09-4a0b-9b4c-ca574255c4e7', '{"id":"05d702bd-3f09-4a0b-9b4c-ca574255c4e7","name":"Get Product","icon":"content_paste_search","color":"#E35169","description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"},"operation":null,"date_created":"2025-05-16T16:17:01.885Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":[]}', '{"name":"Get Product","icon":"content_paste_search","color":"#E35169","description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (439, 629, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"id":"66904cac-25ff-48ab-9ee6-a4eac72485b2","name":"Get User","icon":"content_paste_search","color":"#E35169","description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"},"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","date_created":"2025-05-15T01:44:35.845Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["336d194c-cf1f-410c-af63-ce913f219fb4","9b8eca22-d0f7-44bc-a71c-4444f01d85b1"]}', '{"name":"Get User","icon":"content_paste_search","color":"#E35169","description":null,"status":"active","trigger":"operation","accountability":"all","options":{"return":"$last"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (440, 630, 'directus_fields', '139', '{"special":["uuid"],"collection":"ProductImage","field":"id"}', '{"special":["uuid"],"collection":"ProductImage","field":"id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (441, 631, 'directus_fields', '140', '{"special":["uuid"],"collection":"Review","field":"product"}', '{"special":["uuid"],"collection":"Review","field":"product"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (442, 632, 'directus_fields', '141', '{"special":null,"collection":"ProductVariant","field":"stock"}', '{"special":null,"collection":"ProductVariant","field":"stock"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (443, 633, 'directus_fields', '142', '{"special":["uuid"],"collection":"Review","field":"user_profile"}', '{"special":["uuid"],"collection":"Review","field":"user_profile"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (444, 634, 'directus_fields', '143', '{"special":null,"collection":"Review","field":"comment"}', '{"special":null,"collection":"Review","field":"comment"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (445, 635, 'directus_fields', '144', '{"special":null,"collection":"Review","field":"creation_date"}', '{"special":null,"collection":"Review","field":"creation_date"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (446, 636, 'directus_fields', '145', '{"special":null,"collection":"Review","field":"rating"}', '{"special":null,"collection":"Review","field":"rating"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (447, 642, 'directus_fields', '146', '{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"ProductCategory"}', '{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"ProductCategory"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (448, 643, 'directus_collections', 'ProductCategory', '{"singleton":false,"collection":"ProductCategory"}', '{"singleton":false,"collection":"ProductCategory"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (449, 646, 'directus_fields', '147', '{"sort":1,"interface":"input","readonly":false,"hidden":false,"field":"name","collection":"ProductCategory"}', '{"sort":1,"interface":"input","readonly":false,"hidden":false,"field":"name","collection":"ProductCategory"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (451, 648, 'directus_fields', '148', '{"sort":2,"special":null,"readonly":true,"required":true,"collection":"ProductCategory","field":"description"}', '{"sort":2,"special":null,"readonly":true,"required":true,"collection":"ProductCategory","field":"description"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (458, 655, 'ProductCategory', 'Moda', '{"name":"Moda","products":{"create":[],"update":[{"category":"+","id":"8893bbf2-2267-4a26-89bb-815087c5c859"},{"category":"+","id":"e6813b20-857a-4a84-878e-6857867a5cea"},{"category":"+","id":"6f41a854-d702-43c6-a3af-e91c5bae8128"},{"category":"+","id":"00000000-0000-0000-0000-00000000000e"}],"delete":[]}}', '{"name":"Moda","products":{"create":[],"update":[{"category":"+","id":"8893bbf2-2267-4a26-89bb-815087c5c859"},{"category":"+","id":"e6813b20-857a-4a84-878e-6857867a5cea"},{"category":"+","id":"6f41a854-d702-43c6-a3af-e91c5bae8128"},{"category":"+","id":"00000000-0000-0000-0000-00000000000e"}],"delete":[]}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (454, 651, 'Product', '8893bbf2-2267-4a26-89bb-815087c5c859', '{"id":"8893bbf2-2267-4a26-89bb-815087c5c859","entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":"25000.00000","stock_alert":10,"published":true,"category":"Moda","reviews":[],"variants":[],"specifications":[]}', '{"category":"Moda"}', 458, NULL);
INSERT INTO public.directus_revisions VALUES (455, 652, 'Product', 'e6813b20-857a-4a84-878e-6857867a5cea', '{"id":"e6813b20-857a-4a84-878e-6857867a5cea","entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":"25000.00000","stock_alert":10,"published":true,"category":"Moda","reviews":[],"variants":[],"specifications":[]}', '{"category":"Moda"}', 458, NULL);
INSERT INTO public.directus_revisions VALUES (456, 653, 'Product', '6f41a854-d702-43c6-a3af-e91c5bae8128', '{"id":"6f41a854-d702-43c6-a3af-e91c5bae8128","entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":"25000.00000","stock_alert":10,"published":true,"category":"Moda","reviews":[],"variants":[],"specifications":[]}', '{"category":"Moda"}', 458, NULL);
INSERT INTO public.directus_revisions VALUES (457, 654, 'Product', '00000000-0000-0000-0000-00000000000e', '{"id":"00000000-0000-0000-0000-00000000000e","entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta","description":"Camiseta universitaria","price":"20000.00000","stock_alert":10,"published":true,"category":"Moda","reviews":["00000000-0000-0000-0000-000000000018"],"variants":["00000000-0000-0000-0000-00000000000f"],"specifications":["00000000-0000-0000-0000-000000000011"]}', '{"category":"Moda"}', 458, NULL);
INSERT INTO public.directus_revisions VALUES (459, 657, 'directus_fields', '148', '{"id":148,"collection":"ProductCategory","field":"description","special":null,"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}', '{"collection":"ProductCategory","field":"description","readonly":false}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (464, 662, 'ProductCategory', 'Moda', '{"name":"Moda","description":"Viste con estilo.","products":{"create":[],"update":[{"category":"+","id":"e6813b20-857a-4a84-878e-6857867a5cea"},{"category":"+","id":"8893bbf2-2267-4a26-89bb-815087c5c859"},{"category":"+","id":"6f41a854-d702-43c6-a3af-e91c5bae8128"},{"category":"+","id":"00000000-0000-0000-0000-00000000000e"}],"delete":[]}}', '{"name":"Moda","description":"Viste con estilo.","products":{"create":[],"update":[{"category":"+","id":"e6813b20-857a-4a84-878e-6857867a5cea"},{"category":"+","id":"8893bbf2-2267-4a26-89bb-815087c5c859"},{"category":"+","id":"6f41a854-d702-43c6-a3af-e91c5bae8128"},{"category":"+","id":"00000000-0000-0000-0000-00000000000e"}],"delete":[]}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (460, 658, 'Product', 'e6813b20-857a-4a84-878e-6857867a5cea', '{"id":"e6813b20-857a-4a84-878e-6857867a5cea","entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":"25000.00000","stock_alert":10,"published":true,"category":"Moda","reviews":[],"variants":[],"specifications":[]}', '{"category":"Moda"}', 464, NULL);
INSERT INTO public.directus_revisions VALUES (461, 659, 'Product', '8893bbf2-2267-4a26-89bb-815087c5c859', '{"id":"8893bbf2-2267-4a26-89bb-815087c5c859","entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":"25000.00000","stock_alert":10,"published":true,"category":"Moda","reviews":[],"variants":[],"specifications":[]}', '{"category":"Moda"}', 464, NULL);
INSERT INTO public.directus_revisions VALUES (462, 660, 'Product', '6f41a854-d702-43c6-a3af-e91c5bae8128', '{"id":"6f41a854-d702-43c6-a3af-e91c5bae8128","entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":"25000.00000","stock_alert":10,"published":true,"category":"Moda","reviews":[],"variants":[],"specifications":[]}', '{"category":"Moda"}', 464, NULL);
INSERT INTO public.directus_revisions VALUES (463, 661, 'Product', '00000000-0000-0000-0000-00000000000e', '{"id":"00000000-0000-0000-0000-00000000000e","entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta","description":"Camiseta universitaria","price":"20000.00000","stock_alert":10,"published":true,"category":"Moda","reviews":["00000000-0000-0000-0000-000000000018"],"variants":["00000000-0000-0000-0000-00000000000f"],"specifications":["00000000-0000-0000-0000-000000000011"]}', '{"category":"Moda"}', 464, NULL);
INSERT INTO public.directus_revisions VALUES (465, 663, 'directus_permissions', '33', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"ProductCategory","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"ProductCategory","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (466, 665, 'directus_fields', '150', '{"id":150,"collection":"ProductCategory","field":"products","special":["o2m"],"interface":"list-o2m","options":null,"display":null,"display_options":null,"readonly":false,"hidden":true,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"ProductCategory","field":"products","hidden":true}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (467, 666, 'directus_fields', '150', '{"id":150,"collection":"ProductCategory","field":"products","special":["o2m"],"interface":"list-o2m","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}', '{"collection":"ProductCategory","field":"products","hidden":false}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (468, 667, 'directus_permissions', '33', '{"id":33,"collection":"ProductCategory","action":"read","permissions":null,"validation":null,"presets":null,"fields":["name","description"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"ProductCategory","action":"read","permissions":null,"validation":null,"presets":null,"fields":["name","description"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (482, 697, 'directus_permissions', '37', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["key","value"],"presets":null,"collection":"ProductSpecification","action":"create"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["key","value"],"presets":null,"collection":"ProductSpecification","action":"create"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (469, 670, 'directus_permissions', '16', '{"id":16,"collection":"Entrepreneurship","action":"read","permissions":null,"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","email","phone","category"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Entrepreneurship","action":"read","permissions":null,"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","email","phone","category"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (470, 674, 'directus_users', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '{"id":"aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa","first_name":"Carlos Comprador","last_name":null,"email":"carlos@tienda.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"11111111-1111-1111-1111-111111111111","token":null,"last_access":"2025-05-17T23:23:22.921Z","last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"policies":[]}', '{"role":"11111111-1111-1111-1111-111111111111"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (471, 675, 'directus_permissions', '30', '{"id":30,"collection":"Entrepreneurship","action":"read","permissions":{"_and":[{"_or":[{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}},{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}]}]},"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","phone","subscription","email","category","status","user_founder"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Entrepreneurship","action":"read","permissions":{"_and":[{"_or":[{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}},{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}]}]},"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","phone","subscription","email","category","status","user_founder"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (472, 678, 'Product', '62f6a448-ad01-4528-82f0-29f84d8e7e9d', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda"}', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (473, 679, 'Product', '6eff820a-322b-426a-aae6-fff032719f34', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda"}', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (474, 681, 'directus_permissions', '34', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":{"_and":[{"product":{"published":{"_eq":true}}}]},"validation":null,"fields":["variant_images","name","id","stock"],"presets":null,"collection":"ProductVariant","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":{"_and":[{"product":{"published":{"_eq":true}}}]},"validation":null,"fields":["variant_images","name","id","stock"],"presets":null,"collection":"ProductVariant","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (475, 682, 'directus_permissions', '7', '{"id":7,"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants","category"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants","category"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (476, 684, 'directus_permissions', '35', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":{"_and":[{"product":{"published":{"_eq":true}}}]},"validation":null,"fields":["key","value","id"],"presets":null,"collection":"ProductSpecification","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":{"_and":[{"product":{"published":{"_eq":true}}}]},"validation":null,"fields":["key","value","id"],"presets":null,"collection":"ProductSpecification","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (477, 686, 'directus_permissions', '36', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":{"_and":[{"product_variant":{"product":{"published":{"_eq":true}}}}]},"validation":null,"fields":["id","image_url"],"presets":null,"collection":"ProductImage","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":{"_and":[{"product_variant":{"product":{"published":{"_eq":true}}}}]},"validation":null,"fields":["id","image_url"],"presets":null,"collection":"ProductImage","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (478, 688, 'directus_permissions', '36', '{"id":36,"collection":"ProductImage","action":"read","permissions":{"_and":[{"product_variant":{"product":{"published":{"_eq":true}}}}]},"validation":null,"presets":null,"fields":["image_url"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"ProductImage","action":"read","permissions":{"_and":[{"product_variant":{"product":{"published":{"_eq":true}}}}]},"validation":null,"presets":null,"fields":["image_url"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (479, 690, 'directus_permissions', '36', '{"id":36,"collection":"ProductImage","action":"read","permissions":{"_and":[{"product_variant":{"product":{"published":{"_eq":true}}}}]},"validation":null,"presets":null,"fields":["image_url","id"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"ProductImage","action":"read","permissions":{"_and":[{"product_variant":{"product":{"published":{"_eq":true}}}}]},"validation":null,"presets":null,"fields":["image_url","id"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (480, 693, 'directus_permissions', '22', '{"id":22,"collection":"Product","action":"create","permissions":null,"validation":{"_and":[{"price":{"_gte":"0"}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"create","permissions":null,"validation":{"_and":[{"price":{"_gte":"0"}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},"presets":null,"fields":["published","variants","specifications","name","description","price","stock_alert"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (481, 696, 'Product', '52dae876-5b45-4966-a80d-da879b514931', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda"}', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (483, 698, 'directus_permissions', '38', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["name","variant_images","stock"],"presets":null,"collection":"ProductVariant","action":"create"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["name","variant_images","stock"],"presets":null,"collection":"ProductVariant","action":"create"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (484, 700, 'directus_permissions', '37', '{"id":37,"collection":"ProductSpecification","action":"create","permissions":null,"validation":null,"presets":null,"fields":["key","value","product"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"ProductSpecification","action":"create","permissions":null,"validation":null,"presets":null,"fields":["key","value","product"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (485, 701, 'directus_permissions', '38', '{"id":38,"collection":"ProductVariant","action":"create","permissions":null,"validation":null,"presets":null,"fields":["name","variant_images","stock","product"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"ProductVariant","action":"create","permissions":null,"validation":null,"presets":null,"fields":["name","variant_images","stock","product"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (487, 704, 'Product', 'f51f4492-f4ba-426d-8889-f1b54de5010a', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda","specifications":[{"key":"aSDFADSFAS","value":"adsfasfd"}]}', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda","specifications":[{"key":"aSDFADSFAS","value":"adsfasfd"}]}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (486, 703, 'ProductSpecification', '9ab6d3ef-2a07-4520-9ea7-8341990493d3', '{"key":"aSDFADSFAS","value":"adsfasfd","product":"f51f4492-f4ba-426d-8889-f1b54de5010a"}', '{"key":"aSDFADSFAS","value":"adsfasfd","product":"f51f4492-f4ba-426d-8889-f1b54de5010a"}', 487, NULL);
INSERT INTO public.directus_revisions VALUES (490, 707, 'Product', 'fac48e36-bfd9-47e8-a47d-234e7ca98465', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda","specifications":[{"key":"aSDFADSFAS","value":"adsfasfd"}],"variants":[{"name":"ASDFASDFADS","stock":10}]}', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda","specifications":[{"key":"aSDFADSFAS","value":"adsfasfd"}],"variants":[{"name":"ASDFASDFADS","stock":10}]}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (488, 705, 'ProductVariant', 'd64d917c-3db2-4e12-8d48-f3dd93fbad2c', '{"name":"ASDFASDFADS","stock":10,"product":"fac48e36-bfd9-47e8-a47d-234e7ca98465"}', '{"name":"ASDFASDFADS","stock":10,"product":"fac48e36-bfd9-47e8-a47d-234e7ca98465"}', 490, NULL);
INSERT INTO public.directus_revisions VALUES (489, 706, 'ProductSpecification', 'b72e9f3c-ab4c-405b-9a97-f6c37f35a3cd', '{"key":"aSDFADSFAS","value":"adsfasfd","product":"fac48e36-bfd9-47e8-a47d-234e7ca98465"}', '{"key":"aSDFADSFAS","value":"adsfasfd","product":"fac48e36-bfd9-47e8-a47d-234e7ca98465"}', 490, NULL);
INSERT INTO public.directus_revisions VALUES (491, 708, 'directus_permissions', '39', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["image_url","product_variant"],"presets":null,"collection":"ProductImage","action":"create"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["image_url","product_variant"],"presets":null,"collection":"ProductImage","action":"create"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (492, 710, 'ProductImage', 'bd4560e9-c957-425f-a63e-5dd102b72730', '{"image_url":"SDFADSFA","product_variant":"a60aba3d-9ab3-4645-a2a4-660dd2f093ad"}', '{"image_url":"SDFADSFA","product_variant":"a60aba3d-9ab3-4645-a2a4-660dd2f093ad"}', 493, NULL);
INSERT INTO public.directus_revisions VALUES (495, 713, 'Product', 'd33dd371-e9e3-4083-850c-640a81dd7921', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda","specifications":[{"key":"aSDFADSFAS","value":"adsfasfd"}],"variants":[{"name":"ASDFASDFADS","stock":10,"variant_images":[{"image_url":"SDFADSFA"}]}]}', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda","specifications":[{"key":"aSDFADSFAS","value":"adsfasfd"}],"variants":[{"name":"ASDFASDFADS","stock":10,"variant_images":[{"image_url":"SDFADSFA"}]}]}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (493, 711, 'ProductVariant', 'a60aba3d-9ab3-4645-a2a4-660dd2f093ad', '{"name":"ASDFASDFADS","stock":10,"variant_images":[{"image_url":"SDFADSFA"}],"product":"d33dd371-e9e3-4083-850c-640a81dd7921"}', '{"name":"ASDFASDFADS","stock":10,"variant_images":[{"image_url":"SDFADSFA"}],"product":"d33dd371-e9e3-4083-850c-640a81dd7921"}', 495, NULL);
INSERT INTO public.directus_revisions VALUES (494, 712, 'ProductSpecification', 'af3e18b6-4989-4e3e-9069-636a1d6b7994', '{"key":"aSDFADSFAS","value":"adsfasfd","product":"d33dd371-e9e3-4083-850c-640a81dd7921"}', '{"key":"aSDFADSFAS","value":"adsfasfd","product":"d33dd371-e9e3-4083-850c-640a81dd7921"}', 495, NULL);
INSERT INTO public.directus_revisions VALUES (498, 716, 'ProductVariant', 'fe811dba-6665-4baa-a3d3-0fc042158dd4', '{"name":"jfhs","stock":33,"variant_images":[],"product":"b1b64781-763c-4b14-8017-00380cff05d0"}', '{"name":"jfhs","stock":33,"variant_images":[],"product":"b1b64781-763c-4b14-8017-00380cff05d0"}', 500, NULL);
INSERT INTO public.directus_revisions VALUES (500, 718, 'Product', 'b1b64781-763c-4b14-8017-00380cff05d0', '{"category":"Moda","description":"fjjs","entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"jfjs","price":3,"published":false,"specifications":[{"key":"hfjs","value":"bfjd"}],"stock_alert":3,"variants":[{"name":"jfhs","stock":33,"variant_images":[]}]}', '{"category":"Moda","description":"fjjs","entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"jfjs","price":3,"published":false,"specifications":[{"key":"hfjs","value":"bfjd"}],"stock_alert":3,"variants":[{"name":"jfhs","stock":33,"variant_images":[]}]}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (499, 717, 'ProductSpecification', '9ea44edf-8e3d-49c6-948a-c0d7580eb488', '{"key":"hfjs","value":"bfjd","product":"b1b64781-763c-4b14-8017-00380cff05d0"}', '{"key":"hfjs","value":"bfjd","product":"b1b64781-763c-4b14-8017-00380cff05d0"}', 500, NULL);
INSERT INTO public.directus_revisions VALUES (501, 719, 'ProductImage', '6d62415f-aecd-4552-8ef1-7ea8adc07fe6', '{"image_url":"SDFADSFA","product_variant":"0d136607-35ae-4f93-9acb-0f3e29dfedf6"}', '{"image_url":"SDFADSFA","product_variant":"0d136607-35ae-4f93-9acb-0f3e29dfedf6"}', 502, NULL);
INSERT INTO public.directus_revisions VALUES (504, 722, 'Product', '422cf1dd-efde-42c9-a258-9165dc37fc58', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda","specifications":[{"key":"aSDFADSFAS","value":"adsfasfd"}],"variants":[{"name":"ASDFASDFADS","stock":10,"variant_images":[{"image_url":"SDFADSFA"}]}]}', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda","specifications":[{"key":"aSDFADSFAS","value":"adsfasfd"}],"variants":[{"name":"ASDFASDFADS","stock":10,"variant_images":[{"image_url":"SDFADSFA"}]}]}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (502, 720, 'ProductVariant', '0d136607-35ae-4f93-9acb-0f3e29dfedf6', '{"name":"ASDFASDFADS","stock":10,"variant_images":[{"image_url":"SDFADSFA"}],"product":"422cf1dd-efde-42c9-a258-9165dc37fc58"}', '{"name":"ASDFASDFADS","stock":10,"variant_images":[{"image_url":"SDFADSFA"}],"product":"422cf1dd-efde-42c9-a258-9165dc37fc58"}', 504, NULL);
INSERT INTO public.directus_revisions VALUES (503, 721, 'ProductSpecification', 'a18a944e-c8c4-46ab-9beb-494bfa68cd5f', '{"key":"aSDFADSFAS","value":"adsfasfd","product":"422cf1dd-efde-42c9-a258-9165dc37fc58"}', '{"key":"aSDFADSFAS","value":"adsfasfd","product":"422cf1dd-efde-42c9-a258-9165dc37fc58"}', 504, NULL);
INSERT INTO public.directus_revisions VALUES (507, 725, 'Product', 'aa8131c1-b1eb-4f10-a85a-e6bf64b18bf6', '{"category":"Moda","description":"hdhs","entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"bzj","price":33,"published":true,"specifications":[{"key":"bdjs","value":"djjs"}],"stock_alert":3,"variants":[{"name":"dbs","stock":9464,"variant_images":[]}]}', '{"category":"Moda","description":"hdhs","entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"bzj","price":33,"published":true,"specifications":[{"key":"bdjs","value":"djjs"}],"stock_alert":3,"variants":[{"name":"dbs","stock":9464,"variant_images":[]}]}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (505, 723, 'ProductVariant', '2b678685-68ab-4428-9372-e50198f2ce16', '{"name":"dbs","stock":9464,"variant_images":[],"product":"aa8131c1-b1eb-4f10-a85a-e6bf64b18bf6"}', '{"name":"dbs","stock":9464,"variant_images":[],"product":"aa8131c1-b1eb-4f10-a85a-e6bf64b18bf6"}', 507, NULL);
INSERT INTO public.directus_revisions VALUES (506, 724, 'ProductSpecification', 'd274a16e-ef01-4496-ba1f-5f92eee5b9d8', '{"key":"bdjs","value":"djjs","product":"aa8131c1-b1eb-4f10-a85a-e6bf64b18bf6"}', '{"key":"bdjs","value":"djjs","product":"aa8131c1-b1eb-4f10-a85a-e6bf64b18bf6"}', 507, NULL);
INSERT INTO public.directus_revisions VALUES (508, 727, 'directus_fields', '151', '{"sort":6,"interface":"datetime","special":null,"collection":"Product","field":"deletedAt"}', '{"sort":6,"interface":"datetime","special":null,"collection":"Product","field":"deletedAt"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (509, 728, 'directus_fields', '152', '{"sort":6,"interface":"datetime","special":null,"options":{},"collection":"Entrepreneurship","field":"deletedAt"}', '{"sort":6,"interface":"datetime","special":null,"options":{},"collection":"Entrepreneurship","field":"deletedAt"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (510, 731, 'directus_permissions', '40', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":{"_and":[{"_or":[{"product_variant":{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}}},{"product_variant":{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}}]},{"product_variant":{"product":{"deletedAt":{"_null":true}}}},{"product_variant":{"product":{"entrepreneurship":{"deletedAt":{"_null":true}}}}}]},"validation":null,"fields":null,"presets":null,"collection":"ProductImage","action":"delete"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":{"_and":[{"_or":[{"product_variant":{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}}},{"product_variant":{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}}]},{"product_variant":{"product":{"deletedAt":{"_null":true}}}},{"product_variant":{"product":{"entrepreneurship":{"deletedAt":{"_null":true}}}}}]},"validation":null,"fields":null,"presets":null,"collection":"ProductImage","action":"delete"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (511, 732, 'directus_permissions', '30', '{"id":30,"collection":"Entrepreneurship","action":"read","permissions":{"_and":[{"_or":[{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}},{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deletedAt":{"_nnull":true}}]},"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","phone","subscription","email","category","status","user_founder"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Entrepreneurship","action":"read","permissions":{"_and":[{"_or":[{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}},{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deletedAt":{"_nnull":true}}]},"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","phone","subscription","email","category","status","user_founder"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (512, 733, 'directus_permissions', '18', '{"id":18,"collection":"Product","action":"read","permissions":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deletedAt":{"_nnull":true}}]},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"read","permissions":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deletedAt":{"_nnull":true}}]},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (513, 734, 'directus_permissions', '23', '{"id":23,"collection":"Product","action":"update","permissions":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deletedAt":{"_null":true}}]},"validation":null,"presets":null,"fields":["specifications","variants","published","category","name","description","price","stock_alert","deletedAt"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"update","permissions":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deletedAt":{"_null":true}}]},"validation":null,"presets":null,"fields":["specifications","variants","published","category","name","description","price","stock_alert","deletedAt"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (514, 736, 'directus_permissions', '18', '{"id":18,"collection":"Product","action":"read","permissions":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deletedAt":{"_null":true}}]},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"read","permissions":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deletedAt":{"_null":true}}]},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (515, 738, 'directus_permissions', '30', '{"id":30,"collection":"Entrepreneurship","action":"read","permissions":{"_and":[{"_or":[{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}},{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deletedAt":{"_null":true}}]},"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","phone","subscription","email","category","status","user_founder"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Entrepreneurship","action":"read","permissions":{"_and":[{"_or":[{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}},{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deletedAt":{"_null":true}}]},"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","phone","subscription","email","category","status","user_founder"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (516, 740, 'directus_permissions', '7', '{"id":7,"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}},{"deletedAt":{"_null":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants","category"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}},{"deletedAt":{"_null":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants","category"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (517, 741, 'directus_permissions', '36', '{"id":36,"collection":"ProductImage","action":"read","permissions":{"_and":[{"product_variant":{"product":{"published":{"_eq":true}}}},{"product_variant":{"product":{"deletedAt":{"_null":true}}}}]},"validation":null,"presets":null,"fields":["image_url","id"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"ProductImage","action":"read","permissions":{"_and":[{"product_variant":{"product":{"published":{"_eq":true}}}},{"product_variant":{"product":{"deletedAt":{"_null":true}}}}]},"validation":null,"presets":null,"fields":["image_url","id"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (518, 742, 'directus_permissions', '35', '{"id":35,"collection":"ProductSpecification","action":"read","permissions":{"_and":[{"product":{"published":{"_eq":true}}},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"presets":null,"fields":["key","value","id"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"ProductSpecification","action":"read","permissions":{"_and":[{"product":{"published":{"_eq":true}}},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"presets":null,"fields":["key","value","id"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (519, 743, 'directus_permissions', '34', '{"id":34,"collection":"ProductVariant","action":"read","permissions":{"_and":[{"product":{"published":{"_eq":true}}},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"presets":null,"fields":["variant_images","name","id","stock"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"ProductVariant","action":"read","permissions":{"_and":[{"product":{"published":{"_eq":true}}},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"presets":null,"fields":["variant_images","name","id","stock"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (520, 745, 'directus_permissions', '41', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"fields":["key","value"],"presets":null,"collection":"ProductSpecification","action":"update"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"fields":["key","value"],"presets":null,"collection":"ProductSpecification","action":"update"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (521, 746, 'directus_permissions', '42', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"fields":null,"presets":null,"collection":"ProductSpecification","action":"delete"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"fields":null,"presets":null,"collection":"ProductSpecification","action":"delete"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (522, 747, 'directus_permissions', '43', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"fields":["variant_images","stock","name"],"presets":null,"collection":"ProductVariant","action":"update"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"fields":["variant_images","stock","name"],"presets":null,"collection":"ProductVariant","action":"update"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (523, 748, 'directus_permissions', '44', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"fields":null,"presets":null,"collection":"ProductVariant","action":"delete"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"fields":null,"presets":null,"collection":"ProductVariant","action":"delete"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (524, 749, 'directus_permissions', '45', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Entrepreneurship","action":"create"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Entrepreneurship","action":"create"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (525, 752, 'ProductImage', '6196af9e-d0d4-4b07-978c-a40a9e28f16c', '{"image_url":"SDFADSFA","product_variant":"531d0ad5-e394-49fa-b064-5ef299c944f9"}', '{"image_url":"SDFADSFA","product_variant":"531d0ad5-e394-49fa-b064-5ef299c944f9"}', 526, NULL);
INSERT INTO public.directus_revisions VALUES (528, 755, 'Product', '62f6a448-ad01-4528-82f0-29f84d8e7e9d', '{"id":"62f6a448-ad01-4528-82f0-29f84d8e7e9d","entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":"25000.00000","stock_alert":10,"published":true,"category":"Moda","deletedAt":null,"reviews":[],"variants":["531d0ad5-e394-49fa-b064-5ef299c944f9"],"specifications":["9a8ba045-db02-487c-9fb2-150c2a44da2c"]}', '{"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (526, 753, 'ProductVariant', '531d0ad5-e394-49fa-b064-5ef299c944f9', '{"name":"ASDFASDFADS","stock":10,"variant_images":[{"image_url":"SDFADSFA"}],"product":"62f6a448-ad01-4528-82f0-29f84d8e7e9d"}', '{"name":"ASDFASDFADS","stock":10,"variant_images":[{"image_url":"SDFADSFA"}],"product":"62f6a448-ad01-4528-82f0-29f84d8e7e9d"}', 528, NULL);
INSERT INTO public.directus_revisions VALUES (527, 754, 'ProductSpecification', '9a8ba045-db02-487c-9fb2-150c2a44da2c', '{"key":"aSDFADSFAS","value":"adsfasfd","product":"62f6a448-ad01-4528-82f0-29f84d8e7e9d"}', '{"key":"aSDFADSFAS","value":"adsfasfd","product":"62f6a448-ad01-4528-82f0-29f84d8e7e9d"}', 528, NULL);
INSERT INTO public.directus_revisions VALUES (545, 787, 'directus_permissions', '43', '{"id":43,"collection":"ProductVariant","action":"update","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"presets":null,"fields":["variant_images","stock","name","product","id"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"ProductVariant","action":"update","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"presets":null,"fields":["variant_images","stock","name","product","id"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (531, 758, 'directus_permissions', '43', '{"id":43,"collection":"ProductVariant","action":"update","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"presets":null,"fields":["variant_images","stock","name","product"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"ProductVariant","action":"update","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"presets":null,"fields":["variant_images","stock","name","product"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (532, 759, 'directus_permissions', '41', '{"id":41,"collection":"ProductSpecification","action":"update","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"presets":null,"fields":["key","value","product"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"ProductSpecification","action":"update","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"presets":null,"fields":["key","value","product"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (533, 761, 'directus_fields', '153', '{"special":["uuid"],"collection":"ProductImage","field":"product_variant"}', '{"special":["uuid"],"collection":"ProductImage","field":"product_variant"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (534, 774, 'ProductImage', 'd80f8c93-e79a-401a-8a37-2b3c0d0227de', '{"image_url":"SDFADSFA","product_variant":"36d475f6-bf51-4113-b565-29e376899839"}', '{"image_url":"SDFADSFA","product_variant":"36d475f6-bf51-4113-b565-29e376899839"}', 535, NULL);
INSERT INTO public.directus_revisions VALUES (537, 777, 'Product', 'fafbbda3-3958-47aa-a4d4-3c02200dedee', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda","specifications":[{"key":"aSDFADSFAS","value":"adsfasfd"}],"variants":[{"name":"ASDFASDFADS","stock":10,"variant_images":[{"image_url":"SDFADSFA"}]}]}', '{"entrepreneurship":{"id":"00000000-0000-0000-0000-000000000007"},"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda","specifications":[{"key":"aSDFADSFAS","value":"adsfasfd"}],"variants":[{"name":"ASDFASDFADS","stock":10,"variant_images":[{"image_url":"SDFADSFA"}]}]}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (535, 775, 'ProductVariant', '36d475f6-bf51-4113-b565-29e376899839', '{"name":"ASDFASDFADS","stock":10,"variant_images":[{"image_url":"SDFADSFA"}],"product":"fafbbda3-3958-47aa-a4d4-3c02200dedee"}', '{"name":"ASDFASDFADS","stock":10,"variant_images":[{"image_url":"SDFADSFA"}],"product":"fafbbda3-3958-47aa-a4d4-3c02200dedee"}', 537, NULL);
INSERT INTO public.directus_revisions VALUES (536, 776, 'ProductSpecification', 'a548c783-2e75-444b-aba0-cca4c756e6ac', '{"key":"aSDFADSFAS","value":"adsfasfd","product":"fafbbda3-3958-47aa-a4d4-3c02200dedee"}', '{"key":"aSDFADSFAS","value":"adsfasfd","product":"fafbbda3-3958-47aa-a4d4-3c02200dedee"}', 537, NULL);
INSERT INTO public.directus_revisions VALUES (540, 781, 'directus_permissions', '43', '{"id":43,"collection":"ProductVariant","action":"update","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"presets":null,"fields":["variant_images","stock","name","product","id"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"ProductVariant","action":"update","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"presets":null,"fields":["variant_images","stock","name","product","id"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (550, 793, 'directus_permissions', '43', '{"id":43,"collection":"ProductVariant","action":"update","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"presets":null,"fields":["variant_images","stock","name","product"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"ProductVariant","action":"update","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deletedAt":{"_null":true}}}]},"validation":null,"presets":null,"fields":["variant_images","stock","name","product"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (551, 796, 'directus_flows', '28efc141-52c8-4cf7-854f-6ef43f3a0568', '{"name":"update product","icon":"package","color":"#FFBB00","description":null,"status":"active","accountability":"all","trigger":"webhook","options":{"method":"POST"}}', '{"name":"update product","icon":"package","color":"#FFBB00","description":null,"status":"active","accountability":"all","trigger":"webhook","options":{"method":"POST"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (552, 798, 'directus_flows', 'b02c0861-b56e-48a7-abba-5c31ae2075d5', '{"name":"Delete null entities","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"schedule","options":{"cron":"**1***"}}', '{"name":"Delete null entities","icon":"bolt","color":null,"description":null,"status":"active","accountability":"all","trigger":"schedule","options":{"cron":"**1***"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (553, 799, 'directus_flows', 'b02c0861-b56e-48a7-abba-5c31ae2075d5', '{"id":"b02c0861-b56e-48a7-abba-5c31ae2075d5","name":"Delete null entities","icon":"bolt","color":null,"description":null,"status":"active","trigger":"schedule","accountability":"all","options":{"cron":"**1***"},"operation":null,"date_created":"2025-05-18T17:29:36.429Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":[]}', '{"name":"Delete null entities","icon":"bolt","color":null,"description":null,"status":"active","trigger":"schedule","accountability":"all","options":{"cron":"**1***"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (554, 800, 'directus_operations', 'abac974e-6984-4a11-b7db-e59ce19c82c3', '{"flow":"b02c0861-b56e-48a7-abba-5c31ae2075d5","position_x":37,"position_y":1,"name":"Delete null Product Specification","key":"delete_null_product_specification","type":"item-delete","options":{"permissions":"$trigger","emitEvents":false,"collection":"ProductSpecification","query":{"product":{"_null":true}}}}', '{"flow":"b02c0861-b56e-48a7-abba-5c31ae2075d5","position_x":37,"position_y":1,"name":"Delete null Product Specification","key":"delete_null_product_specification","type":"item-delete","options":{"permissions":"$trigger","emitEvents":false,"collection":"ProductSpecification","query":{"product":{"_null":true}}}}', 555, NULL);
INSERT INTO public.directus_revisions VALUES (556, 802, 'directus_flows', 'b02c0861-b56e-48a7-abba-5c31ae2075d5', '{"id":"b02c0861-b56e-48a7-abba-5c31ae2075d5","name":"Delete null entities","icon":"bolt","color":null,"description":null,"status":"active","trigger":"schedule","accountability":"all","options":{"cron":"**1***"},"operation":"e52a3ed0-a122-4a1f-a436-6d47af1a59a7","date_created":"2025-05-18T17:29:36.429Z","user_created":"f49db054-0000-4460-bb03-2f783370e377","operations":["abac974e-6984-4a11-b7db-e59ce19c82c3","e52a3ed0-a122-4a1f-a436-6d47af1a59a7"]}', '{"operation":"e52a3ed0-a122-4a1f-a436-6d47af1a59a7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (555, 801, 'directus_operations', 'e52a3ed0-a122-4a1f-a436-6d47af1a59a7', '{"flow":"b02c0861-b56e-48a7-abba-5c31ae2075d5","position_x":19,"position_y":1,"name":"Delete from Product Variants","key":"delete_from_product_variants","type":"item-delete","options":{"permissions":"$trigger","emitEvents":false,"collection":"ProductVariant","query":{"product":{"_null":true}}},"resolve":{"flow":"b02c0861-b56e-48a7-abba-5c31ae2075d5","position_x":37,"position_y":1,"name":"Delete null Product Specification","key":"delete_null_product_specification","type":"item-delete","options":{"permissions":"$trigger","emitEvents":false,"collection":"ProductSpecification","query":{"product":{"_null":true}}}}}', '{"flow":"b02c0861-b56e-48a7-abba-5c31ae2075d5","position_x":19,"position_y":1,"name":"Delete from Product Variants","key":"delete_from_product_variants","type":"item-delete","options":{"permissions":"$trigger","emitEvents":false,"collection":"ProductVariant","query":{"product":{"_null":true}}},"resolve":{"flow":"b02c0861-b56e-48a7-abba-5c31ae2075d5","position_x":37,"position_y":1,"name":"Delete null Product Specification","key":"delete_null_product_specification","type":"item-delete","options":{"permissions":"$trigger","emitEvents":false,"collection":"ProductSpecification","query":{"product":{"_null":true}}}}}', 556, NULL);
INSERT INTO public.directus_revisions VALUES (559, 805, 'ProductImage', '1851227e-4bcd-4e88-a5e6-b05371354fd8', '{"image_url":"SDFADSFA","product_variant":"5e52293a-60eb-45fc-8e7b-fb626b046b59"}', '{"image_url":"SDFADSFA","product_variant":"5e52293a-60eb-45fc-8e7b-fb626b046b59"}', 560, NULL);
INSERT INTO public.directus_revisions VALUES (557, 803, 'ProductSpecification', '76b6bd5f-b898-4d84-a365-bae0186e140c', '{"key":"aSDFADSFAS","value":"adsfasfd","product":"fafbbda3-3958-47aa-a4d4-3c02200dedee"}', '{"key":"aSDFADSFAS","value":"adsfasfd","product":"fafbbda3-3958-47aa-a4d4-3c02200dedee"}', 562, NULL);
INSERT INTO public.directus_revisions VALUES (558, 804, 'ProductSpecification', 'a548c783-2e75-444b-aba0-cca4c756e6ac', '{"id":"a548c783-2e75-444b-aba0-cca4c756e6ac","product":null,"key":"aSDFADSFAS","value":"adsfasfd"}', '{"product":null}', 562, NULL);
INSERT INTO public.directus_revisions VALUES (560, 806, 'ProductVariant', '5e52293a-60eb-45fc-8e7b-fb626b046b59', '{"name":"ASDFASDFADS","stock":10,"variant_images":[{"image_url":"SDFADSFA"}],"product":"fafbbda3-3958-47aa-a4d4-3c02200dedee"}', '{"name":"ASDFASDFADS","stock":10,"variant_images":[{"image_url":"SDFADSFA"}],"product":"fafbbda3-3958-47aa-a4d4-3c02200dedee"}', 562, NULL);
INSERT INTO public.directus_revisions VALUES (561, 807, 'ProductVariant', '36d475f6-bf51-4113-b565-29e376899839', '{"id":"36d475f6-bf51-4113-b565-29e376899839","product":null,"stock":10,"name":"ASDFASDFADS","variant_images":["d80f8c93-e79a-401a-8a37-2b3c0d0227de"]}', '{"product":null}', 562, NULL);
INSERT INTO public.directus_revisions VALUES (587, 838, 'Product', '00000000-0000-0000-0000-00000000000e', '{"id":"00000000-0000-0000-0000-00000000000e","entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta","description":"Camiseta universitaria","price":"20000.00000","stock_alert":10,"published":true,"category":"Moda","deletedAt":null,"reviews":["00000000-0000-0000-0000-000000000018"],"variants":["00000000-0000-0000-0000-00000000000f"],"specifications":["00000000-0000-0000-0000-000000000011"]}', '{"name":"Camiseta","description":"Camiseta universitaria","price":20000,"stock_alert":10,"published":true,"category":"Moda"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (586, 837, 'ProductVariant', '00000000-0000-0000-0000-00000000000f', '{"id":"00000000-0000-0000-0000-00000000000f","product":"00000000-0000-0000-0000-00000000000e","stock":50,"name":"Talla M","variant_images":["00000000-0000-0000-0000-000000000010"]}', '{"stock":50,"name":"Talla M"}', 587, NULL);
INSERT INTO public.directus_revisions VALUES (588, 840, 'directus_fields', '154', '{"sort":6,"interface":"datetime","special":null,"collection":"Product","field":"deleted_at"}', '{"sort":6,"interface":"datetime","special":null,"collection":"Product","field":"deleted_at"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (589, 842, 'directus_fields', '155', '{"sort":6,"interface":"datetime","special":null,"collection":"Entrepreneurship","field":"deleted_at"}', '{"sort":6,"interface":"datetime","special":null,"collection":"Entrepreneurship","field":"deleted_at"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (562, 808, 'Product', 'fafbbda3-3958-47aa-a4d4-3c02200dedee', '{"id":"fafbbda3-3958-47aa-a4d4-3c02200dedee","entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":"25000.00000","stock_alert":10,"published":true,"category":"Moda","deletedAt":null,"reviews":[],"variants":["5e52293a-60eb-45fc-8e7b-fb626b046b59"],"specifications":["76b6bd5f-b898-4d84-a365-bae0186e140c"]}', '{"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (566, 814, 'directus_permissions', '46', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":{"_and":[{"_or":[{"product_variant":{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product_variant":{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}}}]}]},"validation":null,"fields":["product_variant","image_url"],"presets":null,"collection":"ProductImage","action":"update"}', '{"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f","permissions":{"_and":[{"_or":[{"product_variant":{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product_variant":{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}}}]}]},"validation":null,"fields":["product_variant","image_url"],"presets":null,"collection":"ProductImage","action":"update"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (572, 821, 'ProductImage', 'e4ca3c82-e983-48c5-86ec-e5664800be02', '{"image_url":"SDFADSFA","product_variant":"5e52293a-60eb-45fc-8e7b-fb626b046b59"}', '{"image_url":"SDFADSFA","product_variant":"5e52293a-60eb-45fc-8e7b-fb626b046b59"}', 574, NULL);
INSERT INTO public.directus_revisions VALUES (573, 822, 'ProductImage', '1851227e-4bcd-4e88-a5e6-b05371354fd8', '{"id":"1851227e-4bcd-4e88-a5e6-b05371354fd8","image_url":"SDFADSFA","product_variant":null}', '{"product_variant":null}', 574, NULL);
INSERT INTO public.directus_revisions VALUES (575, 824, 'Product', 'fafbbda3-3958-47aa-a4d4-3c02200dedee', '{"id":"fafbbda3-3958-47aa-a4d4-3c02200dedee","entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":"25000.00000","stock_alert":10,"published":true,"category":"Moda","deletedAt":null,"reviews":[],"variants":["5e52293a-60eb-45fc-8e7b-fb626b046b59"],"specifications":["fcf1e8aa-b45d-4258-bec8-4a7a55622ad3"]}', '{"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":25000,"stock_alert":10,"category":"Moda"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (570, 819, 'ProductSpecification', 'fcf1e8aa-b45d-4258-bec8-4a7a55622ad3', '{"key":"aSDFADSFAS","value":"adsfasfd","product":"fafbbda3-3958-47aa-a4d4-3c02200dedee"}', '{"key":"aSDFADSFAS","value":"adsfasfd","product":"fafbbda3-3958-47aa-a4d4-3c02200dedee"}', 575, NULL);
INSERT INTO public.directus_revisions VALUES (571, 820, 'ProductSpecification', '76b6bd5f-b898-4d84-a365-bae0186e140c', '{"id":"76b6bd5f-b898-4d84-a365-bae0186e140c","product":null,"key":"aSDFADSFAS","value":"adsfasfd"}', '{"product":null}', 575, NULL);
INSERT INTO public.directus_revisions VALUES (574, 823, 'ProductVariant', '5e52293a-60eb-45fc-8e7b-fb626b046b59', '{"id":"5e52293a-60eb-45fc-8e7b-fb626b046b59","product":"fafbbda3-3958-47aa-a4d4-3c02200dedee","stock":10,"name":"ASDFASDFADS","variant_images":["e4ca3c82-e983-48c5-86ec-e5664800be02"]}', '{"stock":10,"name":"ASDFASDFADS"}', 575, NULL);
INSERT INTO public.directus_revisions VALUES (577, 828, 'ProductImage', 'e4ca3c82-e983-48c5-86ec-e5664800be02', '{"id":"e4ca3c82-e983-48c5-86ec-e5664800be02","image_url":"SDFADSFA","product_variant":"5e52293a-60eb-45fc-8e7b-fb626b046b59"}', '{"image_url":"SDFADSFA"}', 578, NULL);
INSERT INTO public.directus_revisions VALUES (579, 830, 'Product', 'fafbbda3-3958-47aa-a4d4-3c02200dedee', '{"id":"fafbbda3-3958-47aa-a4d4-3c02200dedee","entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":"25000.00000","stock_alert":10,"published":true,"category":"Moda","deletedAt":null,"reviews":[],"variants":["5e52293a-60eb-45fc-8e7b-fb626b046b59"],"specifications":["fcf1e8aa-b45d-4258-bec8-4a7a55622ad3"]}', '{"name":"Camiseta Universitaria","description":"Camiseta 100% algodón con logo de la universidad","price":"25000.00000","stock_alert":10,"published":true,"category":"Moda"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (576, 827, 'ProductSpecification', 'fcf1e8aa-b45d-4258-bec8-4a7a55622ad3', '{"id":"fcf1e8aa-b45d-4258-bec8-4a7a55622ad3","product":"fafbbda3-3958-47aa-a4d4-3c02200dedee","key":"aSDFADSFAS","value":"adsfasfd"}', '{"key":"aSDFADSFAS","value":"adsfasfd"}', 579, NULL);
INSERT INTO public.directus_revisions VALUES (578, 829, 'ProductVariant', '5e52293a-60eb-45fc-8e7b-fb626b046b59', '{"id":"5e52293a-60eb-45fc-8e7b-fb626b046b59","product":"fafbbda3-3958-47aa-a4d4-3c02200dedee","stock":10,"name":"ASDFASDFADS","variant_images":["e4ca3c82-e983-48c5-86ec-e5664800be02"]}', '{"stock":10,"name":"ASDFASDFADS"}', 579, NULL);
INSERT INTO public.directus_revisions VALUES (581, 832, 'ProductImage', '00000000-0000-0000-0000-000000000010', '{"id":"00000000-0000-0000-0000-000000000010","image_url":"camiseta_m.jpg","product_variant":"00000000-0000-0000-0000-00000000000f"}', '{"image_url":"camiseta_m.jpg"}', 582, NULL);
INSERT INTO public.directus_revisions VALUES (583, 834, 'Product', '00000000-0000-0000-0000-00000000000e', '{"id":"00000000-0000-0000-0000-00000000000e","entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camisetaaa","description":"Camiseta universitaria","price":"20000.00000","stock_alert":10,"published":true,"category":"Moda","deletedAt":null,"reviews":["00000000-0000-0000-0000-000000000018"],"variants":["00000000-0000-0000-0000-00000000000f"],"specifications":["00000000-0000-0000-0000-000000000011"]}', '{"name":"Camisetaaa","description":"Camiseta universitaria","price":20000,"stock_alert":10,"published":true,"category":"Moda"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (580, 831, 'ProductSpecification', '00000000-0000-0000-0000-000000000011', '{"id":"00000000-0000-0000-0000-000000000011","product":"00000000-0000-0000-0000-00000000000e","key":"Material","value":"Algodón"}', '{"key":"Material","value":"Algodón"}', 583, NULL);
INSERT INTO public.directus_revisions VALUES (582, 833, 'ProductVariant', '00000000-0000-0000-0000-00000000000f', '{"id":"00000000-0000-0000-0000-00000000000f","product":"00000000-0000-0000-0000-00000000000e","stock":50,"name":"Talla M","variant_images":["00000000-0000-0000-0000-000000000010"]}', '{"stock":50,"name":"Talla M"}', 583, NULL);
INSERT INTO public.directus_revisions VALUES (585, 836, 'ProductImage', '00000000-0000-0000-0000-000000000010', '{"id":"00000000-0000-0000-0000-000000000010","image_url":"camiseta_m.jpg","product_variant":"00000000-0000-0000-0000-00000000000f"}', '{"image_url":"camiseta_m.jpg"}', 586, NULL);
INSERT INTO public.directus_revisions VALUES (584, 835, 'ProductSpecification', '00000000-0000-0000-0000-000000000011', '{"id":"00000000-0000-0000-0000-000000000011","product":"00000000-0000-0000-0000-00000000000e","key":"Material","value":"Algodón"}', '{"key":"Material","value":"Algodón"}', 587, NULL);
INSERT INTO public.directus_revisions VALUES (590, 843, 'directus_permissions', '18', '{"id":18,"collection":"Product","action":"read","permissions":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"read","permissions":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["*"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (591, 844, 'directus_permissions', '30', '{"id":30,"collection":"Entrepreneurship","action":"read","permissions":{"_and":[{"_or":[{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}},{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","phone","subscription","email","category","status","user_founder"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Entrepreneurship","action":"read","permissions":{"_and":[{"_or":[{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}},{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","phone","subscription","email","category","status","user_founder"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (592, 845, 'directus_permissions', '23', '{"id":23,"collection":"Product","action":"update","permissions":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["specifications","variants","published","category","name","description","price","stock_alert","deletedAt"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"update","permissions":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["specifications","variants","published","category","name","description","price","stock_alert","deletedAt"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (593, 846, 'directus_permissions', '41', '{"id":41,"collection":"ProductSpecification","action":"update","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deleted_at":{"_null":true}}}]},"validation":null,"presets":null,"fields":["key","value","product"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"ProductSpecification","action":"update","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deleted_at":{"_null":true}}}]},"validation":null,"presets":null,"fields":["key","value","product"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (594, 847, 'directus_permissions', '40', '{"id":40,"collection":"ProductImage","action":"delete","permissions":{"_and":[{"_or":[{"product_variant":{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}}},{"product_variant":{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}}]},{"product_variant":{"product":{"deleted_at":{"_null":true}}}},{"product_variant":{"product":{"entrepreneurship":{"deleted_at":{"_null":true}}}}}]},"validation":null,"presets":null,"fields":null,"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"ProductImage","action":"delete","permissions":{"_and":[{"_or":[{"product_variant":{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}}},{"product_variant":{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}}]},{"product_variant":{"product":{"deleted_at":{"_null":true}}}},{"product_variant":{"product":{"entrepreneurship":{"deleted_at":{"_null":true}}}}}]},"validation":null,"presets":null,"fields":null,"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (595, 848, 'directus_permissions', '42', '{"id":42,"collection":"ProductSpecification","action":"delete","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deleted_at":{"_null":true}}}]},"validation":null,"presets":null,"fields":null,"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"ProductSpecification","action":"delete","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deleted_at":{"_null":true}}}]},"validation":null,"presets":null,"fields":null,"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (596, 849, 'directus_permissions', '43', '{"id":43,"collection":"ProductVariant","action":"update","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deleted_at":{"_null":true}}}]},"validation":null,"presets":null,"fields":["variant_images","stock","name","product"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"ProductVariant","action":"update","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deleted_at":{"_null":true}}}]},"validation":null,"presets":null,"fields":["variant_images","stock","name","product"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (597, 850, 'directus_permissions', '44', '{"id":44,"collection":"ProductVariant","action":"delete","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deleted_at":{"_null":true}}}]},"validation":null,"presets":null,"fields":null,"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"ProductVariant","action":"delete","permissions":{"_and":[{"_or":[{"product":{"entrepreneurship":{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}}},{"product":{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}}]},{"product":{"deleted_at":{"_null":true}}}]},"validation":null,"presets":null,"fields":null,"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (598, 852, 'directus_permissions', '23', '{"id":23,"collection":"Product","action":"update","permissions":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["specifications","variants","published","category","name","description","price","stock_alert","deletedAt","deleted_at"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Product","action":"update","permissions":{"_and":[{"_or":[{"entrepreneurship":{"partners":{"user_profile":{"_eq":"$CURRENT_USER"}}}},{"entrepreneurship":{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["specifications","variants","published","category","name","description","price","stock_alert","deletedAt","deleted_at"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (599, 854, 'directus_permissions', '7', '{"id":7,"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants","category"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants","category"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (600, 856, 'directus_permissions', '7', '{"id":7,"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants","category"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants","category"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (601, 859, 'directus_permissions', '7', '{"id":7,"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants","category"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants","category"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (602, 864, 'directus_permissions', '34', '{"id":34,"collection":"ProductVariant","action":"read","permissions":{"_and":[{"product":{"published":{"_eq":true}}},{"product":{"deleted_at":{"_null":true}}}]},"validation":null,"presets":null,"fields":["variant_images","name","id","stock"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"ProductVariant","action":"read","permissions":{"_and":[{"product":{"published":{"_eq":true}}},{"product":{"deleted_at":{"_null":true}}}]},"validation":null,"presets":null,"fields":["variant_images","name","id","stock"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (603, 865, 'directus_permissions', '35', '{"id":35,"collection":"ProductSpecification","action":"read","permissions":{"_and":[{"product":{"published":{"_eq":true}}},{"product":{"deleted_at":{"_null":true}}}]},"validation":null,"presets":null,"fields":["key","value","id"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"ProductSpecification","action":"read","permissions":{"_and":[{"product":{"published":{"_eq":true}}},{"product":{"deleted_at":{"_null":true}}}]},"validation":null,"presets":null,"fields":["key","value","id"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (604, 866, 'directus_permissions', '36', '{"id":36,"collection":"ProductImage","action":"read","permissions":{"_and":[{"product_variant":{"product":{"published":{"_eq":true}}}},{"product_variant":{"product":{"deleted_at":{"_null":true}}}}]},"validation":null,"presets":null,"fields":["image_url","id"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"ProductImage","action":"read","permissions":{"_and":[{"product_variant":{"product":{"published":{"_eq":true}}}},{"product_variant":{"product":{"deleted_at":{"_null":true}}}}]},"validation":null,"presets":null,"fields":["image_url","id"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (605, 869, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"steps":[{"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","key":"login","status":"resolve","options":{"method":"POST","url":"http://35.231.238.114/auth/login","body":"{\n  \"email\": \"usertesting@gmail.com\",\n  \"password\" : \"Securepassword@1\"\n}"}},{"operation":"9b8eca22-d0f7-44bc-a71c-4444f01d85b1","key":"decode_token","status":"resolve","options":{"operation":"decode","token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQyNGZiYzExLWQwYjktNDM4YS04Njg1LTY5ZDBmYzc2NzRkMSIsInJvbGUiOiIxZWIxMzEwZi0zMjFmLTQ3MzMtOGFhZi03YTkzNWI1ODg2ZjYiLCJhcHBfYWNjZXNzIjpmYWxzZSwiYWRtaW5fYWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQ3NTk3MDk1LCJleHAiOjE3NDc2MDA2OTUsImlzcyI6ImRpcmVjdHVzIn0.fJyJsUxMYUZ4qQ3rqgWTZBBe9f6KcazXM7yc5iE-ufM"}}],"data":{"$trigger":{"email":"usertesting@gmail.com","password":"Securepassword@1"},"$last":{"id":"424fbc11-d0b9-438a-8685-69d0fc7674d1","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747597095,"exp":1747600695,"iss":"directus"},"$accountability":null,"$env":{},"login":{"status":200,"statusText":"OK","headers":{"content-security-policy":"script-src ''self'' ''unsafe-eval'';worker-src ''self'' blob:;child-src ''self'' blob:;img-src ''self'' data: blob: https://raw.githubusercontent.com https://avatars.githubusercontent.com;media-src ''self'';connect-src ''self'' https://* wss://*;default-src ''self'';base-uri ''self'';font-src ''self'' https: data:;form-action ''self'';frame-ancestors ''self'';object-src ''none'';script-src-attr ''none'';style-src ''self'' https: ''unsafe-inline''","x-powered-by":"Directus","cache-control":"no-cache","vary":"Origin, Cache-Control","content-type":"application/json; charset=utf-8","content-length":"450","etag":"W/\"1c2-dH/TP3po1hp3oTmrzTio32XcopA\"","date":"Sun, 18 May 2025 19:38:15 GMT","connection":"close"},"data":{"data":{"expires":3600,"refresh_token":"gjHwZ4UPu-V19IvLCuupfDoaR4tYfd__BHVPjPC6plPVpv0C3GzYfU7Td1RWf-IC","access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQyNGZiYzExLWQwYjktNDM4YS04Njg1LTY5ZDBmYzc2NzRkMSIsInJvbGUiOiIxZWIxMzEwZi0zMjFmLTQ3MzMtOGFhZi03YTkzNWI1ODg2ZjYiLCJhcHBfYWNjZXNzIjpmYWxzZSwiYWRtaW5fYWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQ3NTk3MDk1LCJleHAiOjE3NDc2MDA2OTUsImlzcyI6ImRpcmVjdHVzIn0.fJyJsUxMYUZ4qQ3rqgWTZBBe9f6KcazXM7yc5iE-ufM"}}},"decode_token":{"id":"424fbc11-d0b9-438a-8685-69d0fc7674d1","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747597095,"exp":1747600695,"iss":"directus"}}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (606, 870, 'user_profile', '424fbc11-d0b9-438a-8685-69d0fc7674d1', '{"id":"424fbc11-d0b9-438a-8685-69d0fc7674d1"}', '{"id":"424fbc11-d0b9-438a-8685-69d0fc7674d1"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (607, 871, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"steps":[{"operation":"0a325417-f595-4af0-b2b4-b8824397d519","key":"get_user_data","status":"resolve","options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"usertesting@gmail.com","password":"Securepassword@1"}}},{"operation":"2937e439-104a-46d0-89ec-d5e42b65baf0","key":"item_create_laiji","status":"resolve","options":{"permissions":"$full","emitEvents":false,"collection":"user_profile","payload":{"id":"424fbc11-d0b9-438a-8685-69d0fc7674d1"}}}],"data":{"$trigger":{"event":"users.create","payload":{"email":"usertesting@gmail.com","password":"--redacted--","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","status":"active","first_name":"User","last_name":"Testing"},"key":"424fbc11-d0b9-438a-8685-69d0fc7674d1","collection":"directus_users"},"$last":["424fbc11-d0b9-438a-8685-69d0fc7674d1"],"$accountability":null,"$env":{},"get_user_data":{"id":"424fbc11-d0b9-438a-8685-69d0fc7674d1","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747597095,"exp":1747600695,"iss":"directus"},"item_create_laiji":["424fbc11-d0b9-438a-8685-69d0fc7674d1"]}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (608, 874, 'Product', '00000000-0000-0000-0000-00000000000e', '{"id":"00000000-0000-0000-0000-00000000000e","entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta","description":"Camiseta universitaria","price":"20000.00000","stock_alert":10,"published":true,"category":"Moda","deleted_at":"2025-05-18T19:45:54.023Z","reviews":["00000000-0000-0000-0000-000000000018"],"variants":["00000000-0000-0000-0000-00000000000f"],"specifications":["00000000-0000-0000-0000-000000000011"]}', '{"deleted_at":"2025-05-18T19:45:54.023Z"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (609, 875, 'directus_permissions', '7', '{"id":7,"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants","category"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants","category"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (610, 877, 'Product', '00000000-0000-0000-0000-00000000000e', '{"id":"00000000-0000-0000-0000-00000000000e","entrepreneurship":"00000000-0000-0000-0000-000000000007","name":"Camiseta","description":"Camiseta universitaria","price":"20000.00000","stock_alert":10,"published":true,"category":"Moda","deleted_at":null,"reviews":["00000000-0000-0000-0000-000000000018"],"variants":["00000000-0000-0000-0000-00000000000f"],"specifications":["00000000-0000-0000-0000-000000000011"]}', '{"deleted_at":null}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (611, 879, 'ProductImage', '00000000-0000-0000-0000-000000000010', '{"id":"00000000-0000-0000-0000-000000000010","image_url":"https://www.lazo.com.co/cdn/shop/files/CAMISETAMODIFICADA1_2.png?v=1739452423","product_variant":"00000000-0000-0000-0000-00000000000f"}', '{"image_url":"https://www.lazo.com.co/cdn/shop/files/CAMISETAMODIFICADA1_2.png?v=1739452423"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (612, 880, 'ProductImage', 'd80f8c93-e79a-401a-8a37-2b3c0d0227de', '{"id":"d80f8c93-e79a-401a-8a37-2b3c0d0227de","image_url":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOjeK14w5tVQ_cSW5qBfbtN5wZR1Eh-Fbuyg&s","product_variant":"36d475f6-bf51-4113-b565-29e376899839"}', '{"image_url":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOjeK14w5tVQ_cSW5qBfbtN5wZR1Eh-Fbuyg&s"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (613, 881, 'ProductImage', 'e4ca3c82-e983-48c5-86ec-e5664800be02', '{"id":"e4ca3c82-e983-48c5-86ec-e5664800be02","image_url":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3R4Os2OPTRBjMlPQUeLu5BUE6h6bvQi7TTg&s","product_variant":"5e52293a-60eb-45fc-8e7b-fb626b046b59"}', '{"image_url":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3R4Os2OPTRBjMlPQUeLu5BUE6h6bvQi7TTg&s"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (614, 884, 'directus_flows', '66904cac-25ff-48ab-9ee6-a4eac72485b2', '{"steps":[{"operation":"336d194c-cf1f-410c-af63-ce913f219fb4","key":"login","status":"resolve","options":{"method":"POST","url":"http://35.231.238.114/auth/login","body":"{\n  \"email\": \"example@example.com\",\n  \"password\" : \"example\"\n}"}},{"operation":"9b8eca22-d0f7-44bc-a71c-4444f01d85b1","key":"decode_token","status":"resolve","options":{"operation":"decode","token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImFmNTJmZmI5LTA5YTYtNDk5Ny05MTY5LTBmMTY4YWM4ZGRlNCIsInJvbGUiOiIxZWIxMzEwZi0zMjFmLTQ3MzMtOGFhZi03YTkzNWI1ODg2ZjYiLCJhcHBfYWNjZXNzIjpmYWxzZSwiYWRtaW5fYWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQ3NjExNjkzLCJleHAiOjE3NDc2MTUyOTMsImlzcyI6ImRpcmVjdHVzIn0.Wpx7p8h6aS1DRmcYMWnGue-pj0LHkdGz7iaJuU-tsAs"}}],"data":{"$trigger":{"email":"example@example.com","password":"example"},"$last":{"id":"af52ffb9-09a6-4997-9169-0f168ac8dde4","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747611693,"exp":1747615293,"iss":"directus"},"$accountability":null,"$env":{},"login":{"status":200,"statusText":"OK","headers":{"content-security-policy":"script-src ''self'' ''unsafe-eval'';worker-src ''self'' blob:;child-src ''self'' blob:;img-src ''self'' data: blob: https://raw.githubusercontent.com https://avatars.githubusercontent.com;media-src ''self'';connect-src ''self'' https://* wss://*;default-src ''self'';base-uri ''self'';font-src ''self'' https: data:;form-action ''self'';frame-ancestors ''self'';object-src ''none'';script-src-attr ''none'';style-src ''self'' https: ''unsafe-inline''","x-powered-by":"Directus","cache-control":"no-cache","vary":"Origin, Cache-Control","content-type":"application/json; charset=utf-8","content-length":"450","etag":"W/\"1c2-tGC9s7nChK4tXx/ohPXgBGKBVY8\"","date":"Sun, 18 May 2025 23:41:34 GMT","connection":"close"},"data":{"data":{"expires":3600,"refresh_token":"fu1M57KKSVKXiI71KrxQtB6fY0jyzaLXsGLAfi35yaGENjtubr7opTeZ92aQnM3e","access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImFmNTJmZmI5LTA5YTYtNDk5Ny05MTY5LTBmMTY4YWM4ZGRlNCIsInJvbGUiOiIxZWIxMzEwZi0zMjFmLTQ3MzMtOGFhZi03YTkzNWI1ODg2ZjYiLCJhcHBfYWNjZXNzIjpmYWxzZSwiYWRtaW5fYWNjZXNzIjpmYWxzZSwiaWF0IjoxNzQ3NjExNjkzLCJleHAiOjE3NDc2MTUyOTMsImlzcyI6ImRpcmVjdHVzIn0.Wpx7p8h6aS1DRmcYMWnGue-pj0LHkdGz7iaJuU-tsAs"}}},"decode_token":{"id":"af52ffb9-09a6-4997-9169-0f168ac8dde4","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747611693,"exp":1747615293,"iss":"directus"}}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (615, 885, 'user_profile', 'af52ffb9-09a6-4997-9169-0f168ac8dde4', '{"id":"af52ffb9-09a6-4997-9169-0f168ac8dde4"}', '{"id":"af52ffb9-09a6-4997-9169-0f168ac8dde4"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (616, 886, 'directus_flows', 'aa2c35a0-e31c-4c4c-9181-4d6da7bea92c', '{"steps":[{"operation":"0a325417-f595-4af0-b2b4-b8824397d519","key":"get_user_data","status":"resolve","options":{"iterationMode":"serial","flow":"66904cac-25ff-48ab-9ee6-a4eac72485b2","payload":{"email":"example@example.com","password":"example"}}},{"operation":"2937e439-104a-46d0-89ec-d5e42b65baf0","key":"item_create_laiji","status":"resolve","options":{"permissions":"$full","emitEvents":false,"collection":"user_profile","payload":{"id":"af52ffb9-09a6-4997-9169-0f168ac8dde4"}}}],"data":{"$trigger":{"event":"users.create","payload":{"email":"example@example.com","password":"--redacted--","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","status":"active","first_name":null,"last_name":null},"key":"af52ffb9-09a6-4997-9169-0f168ac8dde4","collection":"directus_users"},"$last":["af52ffb9-09a6-4997-9169-0f168ac8dde4"],"$accountability":null,"$env":{},"get_user_data":{"id":"af52ffb9-09a6-4997-9169-0f168ac8dde4","role":"1eb1310f-321f-4733-8aaf-7a935b5886f6","app_access":false,"admin_access":false,"iat":1747611693,"exp":1747615293,"iss":"directus"},"item_create_laiji":["af52ffb9-09a6-4997-9169-0f168ac8dde4"]}}', NULL, NULL, NULL);
INSERT INTO public.directus_revisions VALUES (617, 888, 'directus_permissions', '7', '{"id":7,"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants","category","stock_alert"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants","category","stock_alert"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (618, 890, 'directus_users', 'af52ffb9-09a6-4997-9169-0f168ac8dde4', '{"id":"af52ffb9-09a6-4997-9169-0f168ac8dde4","first_name":null,"last_name":null,"email":"example@example.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"11111111-1111-1111-1111-111111111111","token":null,"last_access":"2025-05-18T23:41:49.482Z","last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"policies":[]}', '{"role":"11111111-1111-1111-1111-111111111111"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (619, 892, 'directus_permissions', '7', '{"id":7,"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants","category"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Product","action":"read","permissions":{"_and":[{"published":{"_eq":true}},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["id","entrepreneurship","name","description","price","reviews","specifications","variants","category"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (620, 894, 'directus_settings', '1', '{"id":1,"project_name":"Directus","project_url":"http://35.231.238.114","project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":true},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":true},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}],"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":true,"public_registration_verify_email":false,"public_registration_role":"11111111-1111-1111-1111-111111111111","public_registration_email_filter":null,"visual_editor_urls":null}', '{"public_registration_role":"11111111-1111-1111-1111-111111111111"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (621, 898, 'EntrepreneurshipCustomization', '00000000-0000-0000-0000-000000000003', '{"id":"00000000-0000-0000-0000-000000000003","profile_img":"https://picsum.photos/200","banner_img":"https://picsum.photos/800/400","color1":"#FFFFFF","color2":"#000000","entrepreneurship":"00000000-0000-0000-0000-000000000007"}', '{"profile_img":"https://picsum.photos/200","banner_img":"https://picsum.photos/800/400"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (622, 899, 'directus_fields', '156', '{"sort":7,"interface":"list-m2m","special":["m2m"],"collection":"Entrepreneurship","field":"tag"}', '{"sort":7,"interface":"list-m2m","special":["m2m"],"collection":"Entrepreneurship","field":"tag"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (623, 900, 'directus_fields', '157', '{"sort":1,"hidden":true,"field":"id","collection":"Entrepreneurship_Tags_1"}', '{"sort":1,"hidden":true,"field":"id","collection":"Entrepreneurship_Tags_1"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (624, 901, 'directus_collections', 'Entrepreneurship_Tags_1', '{"hidden":true,"icon":"import_export","collection":"Entrepreneurship_Tags_1"}', '{"hidden":true,"icon":"import_export","collection":"Entrepreneurship_Tags_1"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (625, 902, 'directus_fields', '158', '{"sort":2,"hidden":true,"collection":"Entrepreneurship_Tags_1","field":"Entrepreneurship_id"}', '{"sort":2,"hidden":true,"collection":"Entrepreneurship_Tags_1","field":"Entrepreneurship_id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (626, 903, 'directus_fields', '159', '{"sort":3,"hidden":true,"collection":"Entrepreneurship_Tags_1","field":"Tags_id"}', '{"sort":3,"hidden":true,"collection":"Entrepreneurship_Tags_1","field":"Tags_id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (627, 918, 'directus_roles', '22222222-2222-2222-2222-222222222222', '{"id":"22222222-2222-2222-2222-222222222222","name":"Entrepreneur","icon":"supervised_user_circle","description":"Usuario con permisos para vender productos","parent":null,"children":[],"policies":["a78a4f48-4f30-413b-b6fa-5b9458ec8ace","cdb115a0-3d0e-422e-854a-f27fbf7078de"],"users":["8360fc8e-a7cb-483f-9bb8-b12b9827d233"]}', '{"name":"Entrepreneur"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (628, 919, 'directus_roles', '11111111-1111-1111-1111-111111111111', '{"id":"11111111-1111-1111-1111-111111111111","name":"Shopper","icon":"supervised_user_circle","description":"Usuario con permisos para comprar productos","parent":null,"children":[],"policies":["bc8471d8-e9e9-437e-94e8-16c22e03708b"],"users":["aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa","af52ffb9-09a6-4997-9169-0f168ac8dde4"]}', '{"name":"Shopper"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (629, 921, 'directus_permissions', '47', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_roles","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"directus_roles","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (630, 925, 'Tags', 'b57415c5-23af-4519-9f03-36366174c23d', '{"name":"snacks"}', '{"name":"snacks"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (631, 926, 'Tags', '2f84e0cc-1bfb-421d-ade7-1fa5b4f9d13b', '{"name":"dulces"}', '{"name":"dulces"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (632, 927, 'Tags', 'c73936d7-2913-4b40-af31-0a86a0e8b894', '{"name":"bebidas"}', '{"name":"bebidas"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (633, 928, 'Tags', '7df5fb03-526c-40fd-a46b-c3c4cd3400a1', '{"name":"café"}', '{"name":"café"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (634, 929, 'Tags', '603107c1-2519-4e3d-b9b7-23cd8ec82c6e', '{"name":"té"}', '{"name":"té"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (635, 930, 'Tags', '9b8ff68b-ffed-42d6-bab4-651b455d7ab0', '{"name":"postres"}', '{"name":"postres"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (636, 932, 'Tags', '83c2533e-8014-4b49-bb30-87a1617dd9ec', '{"name":"comida saludable"}', '{"name":"comida saludable"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (637, 933, 'Tags', 'f1d479f9-8332-46ac-a3e5-cd9cf551b936', '{"name":"comida"}', '{"name":"comida"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (638, 934, 'Tags', 'e4dda122-35d9-4d15-8678-64797339acbe', '{"name":"vegana"}', '{"name":"vegana"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (639, 935, 'Tags', '0c062ab0-921c-4fab-a30d-6eeb9ffe6bd1', '{"name":"orgánica"}', '{"name":"orgánica"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (645, 943, 'EntrepreneurshipCustomization', '00000000-0000-0000-0000-000000000003', '{"id":"00000000-0000-0000-0000-000000000003","profile_img":"https://th.bing.com/th/id/R.ee726b5983009289c7ba33363114a351?rik=gJZod0%2fBYMLTPw&riu=http%3a%2f%2f1000logos.net%2fwp-content%2fuploads%2f2016%2f12%2foriginal-starbucks-logo.jpg&ehk=mBFyzvZn%2bC%2bFnr%2bNhuaqHk5xlRc8Xup8rwuhgtb53x4%3d&risl=&pid=ImgRaw&r=0","banner_img":"https://i.ytimg.com/vi/pGj4yFaeJpw/maxresdefault.jpg","color1":"#FFFFFF","color2":"#000000","entrepreneurship":"00000000-0000-0000-0000-000000000007"}', '{"profile_img":"https://th.bing.com/th/id/R.ee726b5983009289c7ba33363114a351?rik=gJZod0%2fBYMLTPw&riu=http%3a%2f%2f1000logos.net%2fwp-content%2fuploads%2f2016%2f12%2foriginal-starbucks-logo.jpg&ehk=mBFyzvZn%2bC%2bFnr%2bNhuaqHk5xlRc8Xup8rwuhgtb53x4%3d&risl=&pid=ImgRaw&r=0","banner_img":"https://i.ytimg.com/vi/pGj4yFaeJpw/maxresdefault.jpg"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (646, 944, 'Entrepreneurship', '00000000-0000-0000-0000-000000000007', '{"id":"00000000-0000-0000-0000-000000000007","name":"Starbucks","slogan":"Mas que café, pasión por mejorar el mundo.","description":"Somos un ícono global de calidad y comodidad. Ya sea que busques un espresso cargado de energía, un refrescante frappuccino o un snack para acompañar tu día, aquí encontrarás todo lo que necesitas para disfrutar esos momentos especiales.","creation_date":"2025-04-19T12:00:00","customization":"00000000-0000-0000-0000-000000000003","email":"info@emarket.com","phone":"1234567890","subscription":"00000000-0000-0000-0000-000000000004","status":"active","category":1,"user_founder":"8360fc8e-a7cb-483f-9bb8-b12b9827d233","deleted_at":null,"partners":["00000000-0000-0000-0000-000000000009"],"products":["00000000-0000-0000-0000-00000000000e","fafbbda3-3958-47aa-a4d4-3c02200dedee"],"collaborations":["00000000-0000-0000-0000-000000000020"],"orders":["00000000-0000-0000-0000-000000000012"],"social_networks":[],"tag":[1,2,3,4,5]}', '{"name":"Starbucks","slogan":"Mas que café, pasión por mejorar el mundo.","description":"Somos un ícono global de calidad y comodidad. Ya sea que busques un espresso cargado de energía, un refrescante frappuccino o un snack para acompañar tu día, aquí encontrarás todo lo que necesitas para disfrutar esos momentos especiales."}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (647, 950, 'directus_collections', 'Entrepreneurship_Tags_1', '{"collection":"Entrepreneurship_Tags_1","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}', '{"hidden":false}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (648, 956, 'directus_fields', '160', '{"sort":7,"interface":"list-m2m","special":["m2m"],"required":true,"collection":"Entrepreneurship","field":"tags"}', '{"sort":7,"interface":"list-m2m","special":["m2m"],"required":true,"collection":"Entrepreneurship","field":"tags"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (649, 957, 'directus_fields', '161', '{"sort":1,"hidden":true,"field":"id","collection":"Entrepreneurship_Tags"}', '{"sort":1,"hidden":true,"field":"id","collection":"Entrepreneurship_Tags"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (650, 958, 'directus_collections', 'Entrepreneurship_Tags', '{"hidden":true,"icon":"import_export","collection":"Entrepreneurship_Tags"}', '{"hidden":true,"icon":"import_export","collection":"Entrepreneurship_Tags"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (651, 959, 'directus_fields', '162', '{"sort":2,"hidden":true,"collection":"Entrepreneurship_Tags","field":"Entrepreneurship_id"}', '{"sort":2,"hidden":true,"collection":"Entrepreneurship_Tags","field":"Entrepreneurship_id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (652, 960, 'directus_fields', '163', '{"sort":3,"hidden":true,"collection":"Entrepreneurship_Tags","field":"Tags_id"}', '{"sort":3,"hidden":true,"collection":"Entrepreneurship_Tags","field":"Tags_id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (653, 961, 'directus_collections', 'Entrepreneurship_Tags', '{"collection":"Entrepreneurship_Tags","icon":"import_export","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}', '{"hidden":false}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (659, 974, 'directus_permissions', '30', '{"id":30,"collection":"Entrepreneurship","action":"read","permissions":null,"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","phone","subscription","email","category","status","user_founder"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Entrepreneurship","action":"read","permissions":null,"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","phone","subscription","email","category","status","user_founder"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (660, 976, 'directus_permissions', '30', '{"id":30,"collection":"Entrepreneurship","action":"read","permissions":{"_and":[{"_or":[{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}},{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","phone","subscription","email","category","status","user_founder"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Entrepreneurship","action":"read","permissions":{"_and":[{"_or":[{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}},{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","phone","subscription","email","category","status","user_founder"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (661, 978, 'directus_permissions', '30', '{"id":30,"collection":"Entrepreneurship","action":"read","permissions":{"_and":[{"_or":[{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}},{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","phone","subscription","email","category","status","user_founder","tags"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', '{"collection":"Entrepreneurship","action":"read","permissions":{"_and":[{"_or":[{"user_founder":{"id":{"_eq":"$CURRENT_USER"}}},{"partners":{"user_profile":{"id":{"_eq":"$CURRENT_USER"}}}}]},{"deleted_at":{"_null":true}}]},"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","phone","subscription","email","category","status","user_founder","tags"],"policy":"60429753-5a20-475d-85bc-de9a5f1ac84f"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (662, 980, 'directus_permissions', '16', '{"id":16,"collection":"Entrepreneurship","action":"read","permissions":null,"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","email","phone","category","tags"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Entrepreneurship","action":"read","permissions":null,"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","email","phone","category","tags"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (663, 983, 'directus_fields', '164', '{"sort":7,"interface":"list-o2m","special":["o2m"],"collection":"Entrepreneurship","field":"tags"}', '{"sort":7,"interface":"list-o2m","special":["o2m"],"collection":"Entrepreneurship","field":"tags"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (664, 989, 'directus_fields', '165', '{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"EntrepreneurshipTags"}', '{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"EntrepreneurshipTags"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (665, 990, 'directus_collections', 'EntrepreneurshipTags', '{"singleton":false,"collection":"EntrepreneurshipTags"}', '{"singleton":false,"collection":"EntrepreneurshipTags"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (666, 991, 'directus_fields', '166', '{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"EntrepreneurshipTags","field":"entrepreneurship"}', '{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"EntrepreneurshipTags","field":"entrepreneurship"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (667, 992, 'directus_fields', '167', '{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"EntrepreneurshipTags","field":"tag"}', '{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"EntrepreneurshipTags","field":"tag"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (668, 993, 'directus_fields', '168', '{"sort":7,"interface":"list-o2m","special":["o2m"],"collection":"Entrepreneurship","field":"tags"}', '{"sort":7,"interface":"list-o2m","special":["o2m"],"collection":"Entrepreneurship","field":"tags"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (669, 994, 'directus_fields', '169', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"Tags","field":"entrepreneurships"}', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"Tags","field":"entrepreneurships"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (673, 998, 'directus_fields', '170', '{"sort":8,"interface":"list-m2m","special":["m2m"],"collection":"Entrepreneurship","field":"tags_temp"}', '{"sort":8,"interface":"list-m2m","special":["m2m"],"collection":"Entrepreneurship","field":"tags_temp"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (674, 999, 'directus_fields', '171', '{"sort":1,"hidden":true,"field":"id","collection":"Entrepreneurship_Tags"}', '{"sort":1,"hidden":true,"field":"id","collection":"Entrepreneurship_Tags"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (675, 1000, 'directus_collections', 'Entrepreneurship_Tags', '{"hidden":true,"icon":"import_export","collection":"Entrepreneurship_Tags"}', '{"hidden":true,"icon":"import_export","collection":"Entrepreneurship_Tags"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (676, 1001, 'directus_fields', '172', '{"sort":2,"hidden":true,"collection":"Entrepreneurship_Tags","field":"Entrepreneurship_id"}', '{"sort":2,"hidden":true,"collection":"Entrepreneurship_Tags","field":"Entrepreneurship_id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (677, 1002, 'directus_fields', '173', '{"sort":3,"hidden":true,"collection":"Entrepreneurship_Tags","field":"Tags_id"}', '{"sort":3,"hidden":true,"collection":"Entrepreneurship_Tags","field":"Tags_id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (678, 1003, 'directus_permissions', '48', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Entrepreneurship_Tags","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Entrepreneurship_Tags","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (679, 1004, 'directus_permissions', '49', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Tags","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Tags","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (689, 1016, 'directus_permissions', '16', '{"id":16,"collection":"Entrepreneurship","action":"read","permissions":null,"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","email","phone","category","tags","tags_temp"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Entrepreneurship","action":"read","permissions":null,"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","email","phone","category","tags","tags_temp"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (690, 1029, 'directus_fields', '174', '{"sort":7,"interface":"list-m2m","special":["m2m"],"collection":"Entrepreneurship","field":"tags"}', '{"sort":7,"interface":"list-m2m","special":["m2m"],"collection":"Entrepreneurship","field":"tags"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (691, 1030, 'directus_fields', '175', '{"sort":1,"hidden":true,"field":"id","collection":"Entrepreneurship_Tags"}', '{"sort":1,"hidden":true,"field":"id","collection":"Entrepreneurship_Tags"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (692, 1031, 'directus_collections', 'Entrepreneurship_Tags', '{"hidden":true,"icon":"import_export","collection":"Entrepreneurship_Tags"}', '{"hidden":true,"icon":"import_export","collection":"Entrepreneurship_Tags"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (693, 1032, 'directus_fields', '176', '{"sort":2,"hidden":true,"collection":"Entrepreneurship_Tags","field":"Entrepreneurship_id"}', '{"sort":2,"hidden":true,"collection":"Entrepreneurship_Tags","field":"Entrepreneurship_id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (694, 1033, 'directus_fields', '177', '{"sort":3,"hidden":true,"collection":"Entrepreneurship_Tags","field":"Tags_id"}', '{"sort":3,"hidden":true,"collection":"Entrepreneurship_Tags","field":"Tags_id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (695, 1034, 'directus_permissions', '50', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Entrepreneurship_Tags","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"Entrepreneurship_Tags","action":"read"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (696, 1035, 'directus_permissions', '16', '{"id":16,"collection":"Entrepreneurship","action":"read","permissions":null,"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","email","phone","category","tags","tags_temp"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Entrepreneurship","action":"read","permissions":null,"validation":null,"presets":null,"fields":["social_networks","id","name","slogan","description","creation_date","customization","email","phone","category","tags","tags_temp"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (697, 1037, 'Entrepreneurship_Tags', '1', '{"Entrepreneurship_id":"00000000-0000-0000-0000-000000000007","Tags_id":{"id":"83c2533e-8014-4b49-bb30-87a1617dd9ec"}}', '{"Entrepreneurship_id":"00000000-0000-0000-0000-000000000007","Tags_id":{"id":"83c2533e-8014-4b49-bb30-87a1617dd9ec"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (698, 1038, 'Entrepreneurship_Tags', '2', '{"Entrepreneurship_id":"00000000-0000-0000-0000-000000000007","Tags_id":{"id":"b57415c5-23af-4519-9f03-36366174c23d"}}', '{"Entrepreneurship_id":"00000000-0000-0000-0000-000000000007","Tags_id":{"id":"b57415c5-23af-4519-9f03-36366174c23d"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (699, 1039, 'Entrepreneurship_Tags', '3', '{"Entrepreneurship_id":"00000000-0000-0000-0000-000000000007","Tags_id":{"id":"c73936d7-2913-4b40-af31-0a86a0e8b894"}}', '{"Entrepreneurship_id":"00000000-0000-0000-0000-000000000007","Tags_id":{"id":"c73936d7-2913-4b40-af31-0a86a0e8b894"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (700, 1040, 'Entrepreneurship_Tags', '4', '{"Entrepreneurship_id":"00000000-0000-0000-0000-000000000007","Tags_id":{"id":"e4dda122-35d9-4d15-8678-64797339acbe"}}', '{"Entrepreneurship_id":"00000000-0000-0000-0000-000000000007","Tags_id":{"id":"e4dda122-35d9-4d15-8678-64797339acbe"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (701, 1041, 'Entrepreneurship_Tags', '5', '{"Entrepreneurship_id":"00000000-0000-0000-0000-000000000007","Tags_id":{"id":"f1d479f9-8332-46ac-a3e5-cd9cf551b936"}}', '{"Entrepreneurship_id":"00000000-0000-0000-0000-000000000007","Tags_id":{"id":"f1d479f9-8332-46ac-a3e5-cd9cf551b936"}}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (702, 1043, 'directus_fields', '178', '{"sort":1,"interface":"list-m2m","special":["m2m"],"collection":"Tags","field":"entrepreneurships"}', '{"sort":1,"interface":"list-m2m","special":["m2m"],"collection":"Tags","field":"entrepreneurships"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (703, 1044, 'directus_fields', '179', '{"sort":1,"hidden":true,"field":"id","collection":"Tags_Entrepreneurship"}', '{"sort":1,"hidden":true,"field":"id","collection":"Tags_Entrepreneurship"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (704, 1045, 'directus_collections', 'Tags_Entrepreneurship', '{"hidden":true,"icon":"import_export","collection":"Tags_Entrepreneurship"}', '{"hidden":true,"icon":"import_export","collection":"Tags_Entrepreneurship"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (705, 1046, 'directus_fields', '180', '{"sort":2,"hidden":true,"collection":"Tags_Entrepreneurship","field":"Tags_id"}', '{"sort":2,"hidden":true,"collection":"Tags_Entrepreneurship","field":"Tags_id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (706, 1047, 'directus_fields', '181', '{"sort":3,"hidden":true,"collection":"Tags_Entrepreneurship","field":"Entrepreneurship_id"}', '{"sort":3,"hidden":true,"collection":"Tags_Entrepreneurship","field":"Entrepreneurship_id"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (707, 1053, 'directus_fields', '182', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"Tags","field":"entrepreneurships"}', '{"sort":1,"interface":"list-o2m","special":["o2m"],"collection":"Tags","field":"entrepreneurships"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (708, 1054, 'directus_permissions', '49', '{"id":49,"collection":"Tags","action":"read","permissions":null,"validation":null,"presets":null,"fields":["id","name"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Tags","action":"read","permissions":null,"validation":null,"presets":null,"fields":["id","name"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (709, 1056, 'directus_permissions', '49', '{"id":49,"collection":"Tags","action":"read","permissions":null,"validation":null,"presets":null,"fields":["id","name","entrepreneurships"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', '{"collection":"Tags","action":"read","permissions":null,"validation":null,"presets":null,"fields":["id","name","entrepreneurships"],"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7"}', NULL, NULL);
INSERT INTO public.directus_revisions VALUES (710, 1062, 'directus_permissions', '51', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["id","name"],"presets":null,"collection":"EntrepreneurshipType","action":"read"}', '{"policy":"4a706832-1a5a-4e16-be61-a1756c9edaa7","permissions":null,"validation":null,"fields":["id","name"],"presets":null,"collection":"EntrepreneurshipType","action":"read"}', NULL, NULL);


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_roles VALUES ('8c163976-88d3-4247-a44a-587399ecf43e', 'Administrator', 'verified', '$t:admin_description', NULL);
INSERT INTO public.directus_roles VALUES ('1eb1310f-321f-4733-8aaf-7a935b5886f6', 'TestRole', 'supervised_user_circle', NULL, NULL);
INSERT INTO public.directus_roles VALUES ('22222222-2222-2222-2222-222222222222', 'Entrepreneur', 'supervised_user_circle', 'Usuario con permisos para vender productos', NULL);
INSERT INTO public.directus_roles VALUES ('11111111-1111-1111-1111-111111111111', 'Shopper', 'supervised_user_circle', 'Usuario con permisos para comprar productos', NULL);


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_sessions VALUES ('FcGJBEeC6hQkGZ9qXS91t-DM5vBXMs_0K9OkftheY2bsUa0DHBcUUAT_Zkp8Hp6N', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-22 15:35:04.277+00', '200.3.193.227', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('8OWgWN7kjFyIbMxqApti9iLbvTlk8PKAh926Lw6A7K_mzkZY5wPFuXD8YKNye8tP', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-22 02:38:53.014+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('ZmuJt_jwH96z-jIPjXQTwQfhKESNDM8Jmxo8xwqcoPD9OSPOAehKIHSTHxXW9CUM', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-22 15:35:11.554+00', '200.3.193.227', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('kVboz3bIuBRB3gFYtbhJx0yzn3JzukbF1JF26GKKLp7uoyJDgDsIys_sq3NclgOt', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-22 15:32:03.415+00', '200.3.193.227', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('jIq-rRyiWlpfJi9C7uoqotwwsABrKz-8hVzh-3KBwuhMxIj47Ww-iSnXUNXONSqK', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-22 18:02:47.013+00', '200.3.193.227', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('GgQump066dQ92azM30HD3rm6H8P2WxVykXGTFpUjWrTsKmqFq7o2QNivFUkusdlS', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-22 15:37:47.378+00', '200.3.193.227', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('aw2mnAdBo3Z_6FGIjwktd2IVDw5UeDE2X0WXdPqTvjh9IzBQnjTU7yw72kMaXKNz', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-22 15:37:53.875+00', '200.3.193.227', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('4KaDIlLeEgor-2MKWOTb0DvEinUnUUq8dkGjS2jLMT-GL18sWS7wVXjqI1YSyxp0', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-22 15:56:31.452+00', '200.3.193.227', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('sb_Qjlo-ZawObq01zgtby1ybJdpRJkDSDYPKHl0xmmiVZt_O3S17IIW-FPn268i9', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-22 16:32:29.971+00', '200.3.193.227', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('047lZB3faW8_lYG8-YxXVcBlwFxL0Gg_nbrZQS_mOmdHvwhs8xVx9pgQtXKI-VMb', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-22 02:48:54.905+00', '10.142.0.3', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('9OMoXZ-RorFpD0TXBpax6jq00xp0QfJEOweopT665en1PMZPPwx_6Lv8DEZd7Kz5', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-22 18:30:34.407+00', '200.3.193.227', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('PvVpNTJdh-6ULMjK9qxl0pl1DQQ5q7d9M4PDVjBIHyuz7D3r99H3auUeFa4HvnCl', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-22 18:02:50.376+00', '200.3.193.227', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('DBM21VryiNk0YL-dJpjdrnbjLBXglPz-03Gb-FyZrrIcvNWRv-CvNoYWWUYcubTd', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-22 18:03:22.116+00', '200.3.193.227', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('9vznUWZr9H5KVSR6UFLLT79J5POY1lasMzkbl-YInKnpH8OKz9FIXzhXC0PEv5uQ', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-22 18:06:56.548+00', '200.3.193.227', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('ecn3kBUkMsE0TKXzlXzgfwDWv5Iz3iO4DxkZ36PIpvyeRsY7LPZHLfI-1ogQKiZ8', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-21 02:10:31.29+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('U1NKVo3x6xMhM4kp-wTGrSJbKrrQx18xPjKgTymGYNFRoLkJ2hj0cvYv88FON0JJ', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-22 18:36:24.59+00', '200.3.193.227', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('zRy8wjsKhlZeXGPwDbnpnvdJUZ78so4JJFchSzgGIk69cm8nKgqbrO1xMP_TsMn9', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-21 02:25:55.623+00', '186.116.227.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.231.238.114', NULL);
INSERT INTO public.directus_sessions VALUES ('FcktwSwM6TXiZnf5JovxKL7v9BxrjpR3jwH0lxkLlYzcwLjtWJcEw9itzFvLgESX', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-21 23:01:06.846+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('WkhLPXbgIRVm92GaXiwqaCW3jxJXVUCk-pji1P62ZjVH_FNXFLci0joVpGnYZF1s', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-21 23:11:36.836+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('zARCukL-5X3GkKafqH6e7BnDanOqK-EV2_tXZPmYbDUAPEOQICv6aLoi6oGDqNe3', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-21 23:11:41.386+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('KOUIuIZOtvJXrCONZ-oAqXjiKFW-4aNN7uEZGyVL9ssplR1vE2D14_chNC2QqR0r', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-21 23:12:21.528+00', '10.142.0.3', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('TGXWDwlLfyXTfBy4dA3n4hCKKexAHUYkvflJW-IM4LG8MG9MiVb15UFU1pXu0nBe', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-22 04:34:19.164+00', '186.169.19.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('T2s2SqudHSlHoHWKftwVm7sZbCMwqmcuhVDxk_lSt1tiDnug43RBLFqIgXKpjb9f', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-22 02:00:34.093+00', '10.142.0.3', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('InOIEBDGSWG4m0EeE194WddsQ0x6XsdOrC95Xy1-jFD-o9mIsSS9BqA-aupAyxS9', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-22 04:34:23.039+00', '186.169.19.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('Z75-oHd5du8cwHHL0HWy6qxAulRmpmiLnz03kiuXkqW_VCx6_VT9U8fmJ9NLPcc2', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-22 03:23:08.754+00', '10.142.0.3', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('lYv0bMs0Nl6C3oE62jFfJsiJqA_L6yvhTIPraXKZXQ39o0LcIQ628_JpiLU5-efu', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-22 03:23:27.996+00', '186.169.19.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('85nWbZEuabeZG5B0vEpam7cBZYIovkVFDRZFrZwuLP2HsDjwi3LDVPV3SrbWCTF4', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-22 03:26:02.268+00', '10.142.0.3', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('A_cC3otVplzmWAvX17IPukExWdO-PES6q2rk8tjlSz_aWYO_pochp2-o-49A4T6I', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-22 03:26:13.124+00', '186.169.19.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('oLG_mkNpZwGzv339DPCmE58M47h2_RsTMPYEHSNZ7xyrq7-OmTLOvpnpHJktU6dM', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-22 03:27:00.467+00', '186.169.19.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('1qhnE8DKefqmzhAXnKszt7dxAhw5GZCKprsYBvpTpeX1Xb1ZEi9uFqOjmLhbEWLy', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-22 03:37:25.544+00', '10.142.0.3', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('rfaw4fcROACv76rgK3toI6FsYdCSm1Nidtgjh9MmI0oacZdlyYN9o65ou6_SSP-b', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-22 03:40:54.056+00', '186.169.19.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('vOeTL8wc2im5NVAgiPyNmCfg4cvvH0SzS5tA_aUFHAXL2kr7npLGPDPWiczYs-pr', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-22 03:41:03.99+00', '186.169.19.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('3VIPycR2-EYYR-jqbGGujsK7ImdsgzqlILTEprvlvSQkOQRZdjC61mfURRUvKm10', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-22 04:38:15.251+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('ZO0y3gd4F1FAN484-7yJ4FmfJvXKwaxGd3a9eEcoce17U8j-OwfUekq-HZ0ZdX9B', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-22 14:47:21.034+00', '200.3.193.227', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('n1X4LRYIBm1aIi3gAdowAfv0DKDVcx8qSh5QjFj7kNDvv0GckURUoQuwMln_67Ud', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-24 22:20:30.848+00', '181.32.88.187', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('9S8t6nulGEHVHbpOlyaXzoGPsptmmYpKjd-rXEztZS4SAL6rDSKn2vTFIs9i7Uvr', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-24 22:31:25.458+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.231.238.114', NULL);
INSERT INTO public.directus_sessions VALUES ('MHOGh7vtmHihjYS6n-tre-ekfwWmmIBPFd2htjZzgdZg41QQVcI9oV3vjf9LZOIy', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-23 16:13:39.293+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('1u7QMDvGPgupbJRL-Ql0XnwsfJUK3SHyCBruEPtYtGOn7Tb6JywG3EnUY1cGy-ee', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-24 23:21:18.576+00', '181.32.88.187', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('meiIkIHor7dthsPM-F0Bs-MF1e-pZtIcrLiyYETV5N2v4qydgHALhFdNlmgeSAcZ', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-24 23:23:22.5+00', '181.32.88.187', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('p5oPlYMJAh3lQRcr2HJmnSYyTQan7zHGoqQQz3ItrY7bAIZ39lD04spio5Rd9ftI', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-24 23:23:38.362+00', '181.32.88.187', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('ORe2JOFchVEu2Ez6PRtcRYf4CsUEpnI8gmzXpk5jcpAGzGrK959xwh-mOsf_oRh3', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-24 23:46:38.658+00', '181.32.88.187', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('VZcvgmsCJu2-6eszsbw3XDS9Lw9Q4wdT6R2QRc27uMvxAWvsw5_lSDCRS3VlPFrH', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-25 00:48:45.518+00', '181.32.88.187', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('cZXIzswid5wqNKE2vjf9n62JMX5WSU1KdLCk2qe0gEzTd1Sc_0ma_T4E1s3qTttO', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-24 21:39:11.681+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('kt1M0stT3Fgs7plN85eyxUEV2lqn60RML8I2ciqxpQr2VqdE6xavLrkDo6UFObg5', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-25 02:19:50.391+00', '181.32.88.187', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('NlAIqyUbxgTsBqFLJLC-MKbXyyPyEti6vsUCzYO3RXW_qInUZ7BVIFfXz4ZSJeIb', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-25 03:22:39.53+00', '181.32.88.187', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('mjgWtdpjbP0BniFcU0c8DVMWaoG0SUfsClJ7Q0fJiumG3KxHk72x5TJLVuh-EGPO', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-25 03:51:56.205+00', '181.32.88.187', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('17a6XXDNfw_v0oDW30spe2RrCu9o5-9ycIc0o7jYw3W2RaEJBZ83XBOGf16S4s9W', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-25 16:12:45.049+00', '186.168.154.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.231.238.114', NULL);
INSERT INTO public.directus_sessions VALUES ('fmBzoExBpKn6ahSzxV3Y1aA73vwW-CEuiK93qm-DX0yvE061zSQCCw1DWB3djXXN', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-25 18:59:15.805+00', '186.168.154.36', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('q8tIoNHzqEmg78qrcgZYsNR57RZ3cG4f79U71-h_DwhQVEqACuf5MXMD_dcVz76y', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-25 16:51:54.522+00', '186.168.154.36', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('p2I_P1YFPVcEj8YO-SfzawIrs35axGl7WYSnreVK0FoTZ2tflP8Z8KE5DCqfAhET', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-25 19:19:22.534+00', '191.95.54.40', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('bhk3db69sSVLCt-A-ok86Yfs1LsfYU1ATK0uSWxvEmYir7hk7K7qXLAz0_HIoFI7', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-25 17:54:23.654+00', '186.168.154.36', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('I0duUqgUzvuZcXsxsbyJzxsd84OYAhqAdZ1Iz6yNkMi0neon9XANolmIzRLnRwZy', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-25 18:55:49.814+00', '186.168.154.36', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('l4m375rZq942K8MjQZ6EjOdgQCkahP-3gPPHT-kzoix2tqZExBvLCtbm6_nPVCJ_', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-25 23:36:44.972+00', '186.168.154.36', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('GXYQUBkjGQ9tO6EEqoEGDWdETNlJDXynHQ7Rc757MICmX--RDCYw1HEWSvypgFB1', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-25 19:34:42.997+00', '186.168.154.36', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('V9hTNXTkVm9I-vLqPoBWmTEx9CisvycsypOViARcnrqTyGsG_rHrDAB_YEiu8zrn', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-25 19:35:15.711+00', '186.168.154.36', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('bAIHeZGlxfgPq2KFg1kl3UvLgX8amUQ1cRGCXtrP8cL6HpZNZRWCKxgkauG3d3Qb', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-25 19:35:55.062+00', '186.168.154.36', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('161gnHUJvf0zkFwfyGtBdmYVTqNqmHdZt36uBbZK03Sz6PFBP45OUXsIQykWpAM_', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-25 19:36:04.585+00', '186.168.154.36', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('gjHwZ4UPu-V19IvLCuupfDoaR4tYfd__BHVPjPC6plPVpv0C3GzYfU7Td1RWf-IC', '424fbc11-d0b9-438a-8685-69d0fc7674d1', '2025-05-25 19:38:15.378+00', '169.254.42.1', 'axios/1.8.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('mgYRwWwo2qCZ2NsjIKWbpD8aKBp__8LeaM8sTk4EqiKf_ugYY_vd2ngUfENkDeyU', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-25 19:38:36.012+00', '186.168.154.36', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('fu1M57KKSVKXiI71KrxQtB6fY0jyzaLXsGLAfi35yaGENjtubr7opTeZ92aQnM3e', 'af52ffb9-09a6-4997-9169-0f168ac8dde4', '2025-05-25 23:41:33.704+00', '169.254.42.1', 'axios/1.8.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('2-iART-vLzG0L636_9n80Va5DAuw-xzo4CKl3Ney7wbwQmJ6S_O4ljghzE7aZaSC', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-25 21:39:50.721+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('RvicIpOuoSZQvGSWDutWJB8Go9Z0cXk5xLHjsA1196vzQ46W8XRmXvTmupeoNiEm', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-25 23:36:26.981+00', '190.108.76.176', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('iRm2-AZ29NxrP0ojpM4eCjyLmupCO5r4In_HKct8HM8EcSZRf1W1JQF6dPzCm0Ef', 'af52ffb9-09a6-4997-9169-0f168ac8dde4', '2025-05-25 23:41:49.064+00', '186.168.154.36', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('YhjZrac0WYmGjWK0WJyXT1OFEcwK-bla_2h6CZo_ofXBvo4JPYeVmmMZ6DWp10_i', 'af52ffb9-09a6-4997-9169-0f168ac8dde4', '2025-05-25 23:52:39.488+00', '186.168.154.36', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('L5Z1dP-aJdL13akIEHca-pZXb0QIK93J965ceVFEOPJXPleg5yNMsdjA_pQNDKKK', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-25 23:53:32.838+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('-tGa8rza4O6WAPBFrT75E1_fhFCVfm-TeBh7qC804yoI1_M_UWIcUu4D76txhoAq', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-26 00:27:27.657+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('XwLzJ4PJzwsf9k-To96zzSSRhOWgQvRNczBCV18AqFevQ20V7oP11b9ZSAfIwwuh', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-26 02:12:14.305+00', '186.168.154.36', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('QoOM33sNJEDrNtgKQhnUYd-S46VqB4redL5HXfg_w502ZTDN4vMp9aziokWHYygE', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-26 02:20:12.792+00', '186.168.154.36', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('NcLsiNbhIWhrNdvI6wXVgrpjPaHIlGV0zfnt-_GxWWB7v_N-gQKv-cmriYvJDmLa', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-26 02:15:16.328+00', '186.168.154.36', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('jvO6ueoq0fsfnY9UjecIMo4tN4SJBH9-vvYUO99iUJReBkckRPs7UR77ZMc0iip5', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-26 02:30:11.955+00', '186.168.154.36', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('TS1UzTegbX-c1DjZjxmm1IDre2CDgqgEmXrMDV4kZdbG6TnZAIgUEl6fnQf4UYJz', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-26 02:33:48.389+00', '186.168.154.36', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('hAm7KJoFiIsDWp3NXtrpnyiFabWl2G4wn4NKwzFNVYnRgVSvL--ztqCk5Y8fti14', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-26 15:58:20.549+00', '190.108.76.176', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('c3UwRRrt9SQxmDgPKhtRKNWxF_U424bDpDmlQeflLCsUMd_9tj2_vHyym9w9IrOi', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-26 02:36:10.565+00', '186.168.154.36', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('Ut6PflLRbFyGmTMYSmzIHw9juZhjPVeffBtk8aDUFQhbV9f1xJWzo0C71mdfnjMi', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-26 02:38:34.84+00', '181.32.88.187', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('Jx6Yi8CRx-6yDPGs7FQJttASSE9ugQzco6qaORpF1ggLR0Xe-rZ5pCBZMsXIwcHE', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-26 02:40:24.189+00', '186.168.154.36', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('YkTc28uSGFrbl44tHD_9Uzsklf4l8b1wB4HtprcuFv6Hg3LR_34DZ1cW_BPnToIE', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-26 02:42:45.793+00', '186.168.154.36', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('KSdxCf1VbiF3lD8sy3lm2buz0og_5IeEcra6Xr_Ho_cNbEYs4mqdu9HBzeGLXDRe', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-26 02:50:42.96+00', '186.168.154.36', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('xk3gakolkdUYAepU1d-b2NYEnwxBze5yR1zRQj25kMkYWQ-sxCky5n4DJZ2nsBhb', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-26 02:51:53.397+00', '186.168.154.36', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('6xcT-1AmGG_cpipXTYw86QmIa3ZOp9ygIGLt4_76O6fd-yWMjVgPABExwrKc9mLW', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-26 02:54:37.678+00', '186.168.154.36', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('PuSh7Kl0lAEnKb2UQljY-iBsUk7dGXGXJC-vGUcqQbjsbRucUa9jfQO16X07TJHJ', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-26 02:57:24.763+00', '186.168.154.36', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('dhze_X2ycD8dyDJknIVuSQQ_uKtreIaOSd5FlFbgRNS52XLO1FXk8GNQM-8Zh1du', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-26 03:34:27.486+00', '181.32.88.187', 'PostmanRuntime/7.44.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('abf0wwdCd6ndq0pMMbaBh1wvyUkFq1dKTXyPfr1KFKBAq-607xtjCElB9ZjMc9Oz', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-26 05:09:49.063+00', '181.32.88.187', 'PostmanRuntime/7.44.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('AK09w8-VcFX5zAX5r3o55QLZK2Gz4Q6Ef5UflAZjla19Hn9rzeYF3xd6R29t8SUw', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-26 14:33:13.143+00', '54.86.50.139', 'PostmanRuntime/7.44.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('yO3Z2C4rWoe6o4zD2j0hyR8wPsxllA7TufKJ9jObFIjpIb7tNcGO84_OT03ELavF', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-20 05:10:07.343+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.231.238.114', NULL);
INSERT INTO public.directus_sessions VALUES ('4QQgR9cxMMZelqqLD2V1YwYhJIYOmxrvYYbKF0MRCF8DYxdEI0l-QJuIfrbj3nBl', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-26 05:28:11.875+00', '181.32.88.187', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('DTK1jhhEX6Nf3JZNK0_8Fdz9s_8Fls7Ge9wxGDx6Fm5nzluCoGIYnGvBlvx5QWxi', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-26 05:30:45.453+00', '181.32.88.187', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('-Ue5GlBiXDk9JIkU9VCZQwSc2464fDwoRnY8VF17RVq5DklIfPqShn9IrpfKQuJd', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-26 15:44:22.992+00', '200.3.193.225', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('JyPzjQ0SsSB-xkqWToQu7s1QQ0KYkG6jZy0gscaik52BmwScuv9A8gnvOgJvgBMM', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-26 06:57:16.883+00', '54.86.50.139', 'PostmanRuntime/7.44.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('MN4muycGEPlzNHqjfXfVQoKRPeMD2Qf7P06_a2-QuaIII5pM0sydhhDYvolSFNhX', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-26 13:15:17.997+00', '54.86.50.139', 'PostmanRuntime/7.44.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('yPCxSF7IGr5ki89ORLfilIETgOmcbeFApwuz0-fT89SOPsRhGDwS7baqSwgQrbtP', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-26 17:21:09.656+00', '200.3.193.227', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('_g-mqdBe_SEshk0QVFmD4LJLrTz4IX005H8IK2vcwizOcoRkgWKi1Ntf3L9If5HS', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-26 18:58:34.504+00', '200.3.193.227', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('SW2YfVQwBlBuvaZSKyz9nYCl4PaIojIUQBTCWZZNM-mHUOYxLRVZYOG0fsDclQCk', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-26 20:53:59.627+00', '200.3.193.229', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('DdolPZQW0pqi-pgaubN77yo_O6WQr7OvBQswsjXn5dnnTeKa-cS92JfnxEGcX_vK', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-21 00:15:16.392+00', '190.108.76.176', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.231.238.114', NULL);
INSERT INTO public.directus_sessions VALUES ('NATZVFRe1zHpDmNXcsEyUkoTQAIJKhPo64O11wtVsqFrF2bIeOhd6PtbsDwrQ5bG', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-27 00:20:20.882+00', '54.86.50.139', 'PostmanRuntime/7.44.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('PwBcYl15T--_L0uPkjmiNi_GZfCQ9JDhkgx-RCmorDZsZOGpX9HnO3ndYdWL6IFc', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-27 01:11:14.449+00', '54.86.50.139', 'PostmanRuntime/7.44.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('wcgnQthSBjqLUAx27lJoRUfI1LcUZ_xCb5jO0737viHGlvu95lWPm8tVAkOqjNwj', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-27 01:27:25.428+00', '190.108.76.176', 'okhttp/4.12.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('6Csn_X4-yRasGp3bYmFv3fhL0dcHZ3r_DxUezFM_nQnL1PonlqJoYjq-L_bX5fGb', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-27 03:33:05.5+00', '181.32.88.187', 'PostmanRuntime/7.44.0', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('WL6g5hbcPC8vAmD6iMeZZi8h-cNVIxB3diq_WmTV3BDq4yZwdN--stqDTgJ6XqQm', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-20 03:35:57.594+00', '200.3.193.229', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.231.238.114', 'N5aT8TdSLH2Ad6yJXjUM2v0odeYIW5-x-GSyRblRezAOs0t0lhOzyxRkQPZ6cIar');
INSERT INTO public.directus_sessions VALUES ('N5aT8TdSLH2Ad6yJXjUM2v0odeYIW5-x-GSyRblRezAOs0t0lhOzyxRkQPZ6cIar', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-21 03:35:47.594+00', '181.32.88.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.231.238.114', NULL);


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_settings VALUES (1, 'Directus', 'http://35.231.238.114', '#6644FF', NULL, NULL, NULL, NULL, 25, NULL, 'all', NULL, NULL, NULL, NULL, NULL, '[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":true},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":true},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}]', NULL, 'en-US', NULL, NULL, 'auto', NULL, NULL, NULL, NULL, NULL, NULL, NULL, true, false, '11111111-1111-1111-1111-111111111111', NULL, NULL);


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_users VALUES ('af52ffb9-09a6-4997-9169-0f168ac8dde4', NULL, NULL, 'example@example.com', '$argon2id$v=19$m=65536,t=3,p=4$BI0XgGR4kzbGE0uuQP38iw$WaVSu1py+KBzUmGsgwgfkVnganhBK+7gp6JlN2wL2OU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '11111111-1111-1111-1111-111111111111', NULL, '2025-05-18 23:52:39.931+00', NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.directus_users VALUES ('f49db054-0000-4460-bb03-2f783370e377', 'Admin', 'User', 'uniadmin@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$HwpZG943w+ekAUsSyGPIXA$Lmoi5sOtfYr9NVlcLZpn54pBzEFo6fIOfTMTHb/ox3k', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '8c163976-88d3-4247-a44a-587399ecf43e', NULL, '2025-05-20 03:35:47.769+00', '/content/Entrepreneurship/00000000-0000-0000-0000-000000000007', 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.directus_users VALUES ('8360fc8e-a7cb-483f-9bb8-b12b9827d233', 'Juan', 'Vendedor', 'juanvendedor@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$Lfl8YI9ZO1sKjEMgySaLpw$3p1b5VmW1t5RDo7PQkJqwmtGLi0QfczZxk5QfGzQpoM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '22222222-2222-2222-2222-222222222222', NULL, '2025-05-20 03:33:05.949+00', NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.directus_users VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Carlos Comprador', NULL, 'carlos@tienda.com', '$argon2id$v=19$m=65536,t=3,p=4$bjAsRR7iRUQEUQsfnp/18w$bbFzNoSUhllzcb9Xzap94owNuzlXHyNXcMFwu+RD2ZM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '11111111-1111-1111-1111-111111111111', NULL, '2025-05-19 05:30:45.899+00', NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.directus_users VALUES ('424fbc11-d0b9-438a-8685-69d0fc7674d1', 'User', 'Testing', 'usertesting@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$e5vjdxwCupd951/u2jGFng$ajSzHyxRF9ff8aGZkkJQmGn8nR6GXmxgDHVRQabszWY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '1eb1310f-321f-4733-8aaf-7a935b5886f6', NULL, '2025-05-18 19:38:15.803+00', NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: user_profile; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.user_profile VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'foto.jpg', '00000000-0000-0000-0000-000000000001', '12345678', 'C.C', 1, '2025-04-18 08:30:00', '00000000-0000-0000-0000-000000000006', 4.80000, 4.50000);
INSERT INTO public.user_profile VALUES ('8360fc8e-a7cb-483f-9bb8-b12b9827d233', 'https://directus-unimarket.s3.us-east-1.amazonaws.com/usuarios/default-profile', '00000000-0000-0000-0000-000000000001', '1231231231', 'C.C', 1, '2025-05-15 04:38:21.763', 'd76eb01a-7b8b-45d9-9e15-ddf24157cc23', 4.00000, 5.00000);
INSERT INTO public.user_profile VALUES ('424fbc11-d0b9-438a-8685-69d0fc7674d1', 'https://directus-unimarket.s3.us-east-1.amazonaws.com/usuarios/default-profile', NULL, NULL, NULL, 1, '2025-05-18 19:38:16.49', NULL, 0.00000, 0.00000);
INSERT INTO public.user_profile VALUES ('af52ffb9-09a6-4997-9169-0f168ac8dde4', 'https://directus-unimarket.s3.us-east-1.amazonaws.com/usuarios/default-profile', NULL, NULL, NULL, 1, '2025-05-18 23:41:34.909', NULL, 0.00000, 0.00000);


--
-- Name: EntrepreneurshipType_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public."EntrepreneurshipType_id_seq"', 1, false);


--
-- Name: Entrepreneurship_Tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public."Entrepreneurship_Tags_id_seq"', 5, true);


--
-- Name: PartnerRol_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public."PartnerRol_id_seq"', 1, false);


--
-- Name: UserStatus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public."UserStatus_id_seq"', 1, false);


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 1063, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 182, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 51, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 7, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 61, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 710, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: Banner Banner_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Banner"
    ADD CONSTRAINT "Banner_pkey" PRIMARY KEY (id);


--
-- Name: CollaborationImage CollaborationImage_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."CollaborationImage"
    ADD CONSTRAINT "CollaborationImage_pkey" PRIMARY KEY (id);


--
-- Name: CollaborationMembers CollaborationMembers_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."CollaborationMembers"
    ADD CONSTRAINT "CollaborationMembers_pkey" PRIMARY KEY (id);


--
-- Name: CollaborationProducts CollaborationProducts_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."CollaborationProducts"
    ADD CONSTRAINT "CollaborationProducts_pkey" PRIMARY KEY (id);


--
-- Name: Collaboration Collaboration_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Collaboration"
    ADD CONSTRAINT "Collaboration_pkey" PRIMARY KEY (id);


--
-- Name: DeliveryStatusLog DeliveryStatusLog_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."DeliveryStatusLog"
    ADD CONSTRAINT "DeliveryStatusLog_pkey" PRIMARY KEY (id);


--
-- Name: DeliveryStatus DeliveryStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."DeliveryStatus"
    ADD CONSTRAINT "DeliveryStatus_pkey" PRIMARY KEY (id);


--
-- Name: Delivery Delivery_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Delivery"
    ADD CONSTRAINT "Delivery_pkey" PRIMARY KEY (id);


--
-- Name: EntrepreneurshipCustomization EntrepreneurshipCustomization_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."EntrepreneurshipCustomization"
    ADD CONSTRAINT "EntrepreneurshipCustomization_pkey" PRIMARY KEY (id);


--
-- Name: EntrepreneurshipSubscription EntrepreneurshipSubscription_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."EntrepreneurshipSubscription"
    ADD CONSTRAINT "EntrepreneurshipSubscription_pkey" PRIMARY KEY (id);


--
-- Name: EntrepreneurshipType EntrepreneurshipType_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."EntrepreneurshipType"
    ADD CONSTRAINT "EntrepreneurshipType_pkey" PRIMARY KEY (id);


--
-- Name: Entrepreneurship_Tags Entrepreneurship_Tags_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Entrepreneurship_Tags"
    ADD CONSTRAINT "Entrepreneurship_Tags_pkey" PRIMARY KEY (id);


--
-- Name: Entrepreneurship Entrepreneurship_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Entrepreneurship"
    ADD CONSTRAINT "Entrepreneurship_pkey" PRIMARY KEY (id);


--
-- Name: NotificationType NotificationType_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."NotificationType"
    ADD CONSTRAINT "NotificationType_pkey" PRIMARY KEY (id);


--
-- Name: Notification Notification_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_pkey" PRIMARY KEY (id);


--
-- Name: OrderDetail OrderDetail_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."OrderDetail"
    ADD CONSTRAINT "OrderDetail_pkey" PRIMARY KEY (id);


--
-- Name: OrderStatus OrderStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."OrderStatus"
    ADD CONSTRAINT "OrderStatus_pkey" PRIMARY KEY (id);


--
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- Name: PartnerRol PartnerRol_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."PartnerRol"
    ADD CONSTRAINT "PartnerRol_pkey" PRIMARY KEY (id);


--
-- Name: Partner Partner_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Partner"
    ADD CONSTRAINT "Partner_pkey" PRIMARY KEY (id);


--
-- Name: PaymentEvidence PaymentEvidence_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."PaymentEvidence"
    ADD CONSTRAINT "PaymentEvidence_pkey" PRIMARY KEY (id);


--
-- Name: PaymentMethod PaymentMethod_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."PaymentMethod"
    ADD CONSTRAINT "PaymentMethod_pkey" PRIMARY KEY (id);


--
-- Name: Payment Payment_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_pkey" PRIMARY KEY (id);


--
-- Name: ProductCategory ProductCategory_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."ProductCategory"
    ADD CONSTRAINT "ProductCategory_pkey" PRIMARY KEY (name);


--
-- Name: ProductImage ProductImage_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."ProductImage"
    ADD CONSTRAINT "ProductImage_pkey" PRIMARY KEY (id);


--
-- Name: ProductSpecification ProductSpecification_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."ProductSpecification"
    ADD CONSTRAINT "ProductSpecification_pkey" PRIMARY KEY (id);


--
-- Name: ProductVariant ProductVariant_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."ProductVariant"
    ADD CONSTRAINT "ProductVariant_pkey" PRIMARY KEY (id);


--
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- Name: Review Review_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_pkey" PRIMARY KEY (id);


--
-- Name: SocialNetwork SocialNetwork_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."SocialNetwork"
    ADD CONSTRAINT "SocialNetwork_pkey" PRIMARY KEY (id);


--
-- Name: SubscriptionPlans SubscriptionPlans_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."SubscriptionPlans"
    ADD CONSTRAINT "SubscriptionPlans_pkey" PRIMARY KEY (id);


--
-- Name: Tags Tags_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Tags"
    ADD CONSTRAINT "Tags_pkey" PRIMARY KEY (id);


--
-- Name: University University_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."University"
    ADD CONSTRAINT "University_pkey" PRIMARY KEY (id);


--
-- Name: UserStatus UserStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."UserStatus"
    ADD CONSTRAINT "UserStatus_pkey" PRIMARY KEY (id);


--
-- Name: Verification Verification_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Verification"
    ADD CONSTRAINT "Verification_pkey" PRIMARY KEY (id);


--
-- Name: directus_access directus_access_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_comments directus_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_pkey PRIMARY KEY (id);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_extensions directus_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT directus_extensions_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_policies directus_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_policies
    ADD CONSTRAINT directus_policies_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_versions directus_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: EntrepreneurshipCustomization entrepreneurshipcustomization_entrepreneurship_unique; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."EntrepreneurshipCustomization"
    ADD CONSTRAINT entrepreneurshipcustomization_entrepreneurship_unique UNIQUE (entrepreneurship);


--
-- Name: EntrepreneurshipSubscription entrepreneurshipsubscription_entrepreneurship_unique; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."EntrepreneurshipSubscription"
    ADD CONSTRAINT entrepreneurshipsubscription_entrepreneurship_unique UNIQUE (entrepreneurship);


--
-- Name: OrderStatus orderstatus_name_unique; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."OrderStatus"
    ADD CONSTRAINT orderstatus_name_unique UNIQUE (name);


--
-- Name: user_profile user_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_pkey PRIMARY KEY (id);


--
-- Name: user_profile user_profile_verification_key; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_verification_key UNIQUE (verification);


--
-- Name: entrepreneurshipcustomization_entrepreneurship_index; Type: INDEX; Schema: public; Owner: app_mov
--

CREATE INDEX entrepreneurshipcustomization_entrepreneurship_index ON public."EntrepreneurshipCustomization" USING btree (entrepreneurship);


--
-- Name: entrepreneurshipsubscription_entrepreneurship_index; Type: INDEX; Schema: public; Owner: app_mov
--

CREATE INDEX entrepreneurshipsubscription_entrepreneurship_index ON public."EntrepreneurshipSubscription" USING btree (entrepreneurship);


--
-- Name: productvariant_product_index; Type: INDEX; Schema: public; Owner: app_mov
--

CREATE INDEX productvariant_product_index ON public."ProductVariant" USING btree (product);


--
-- Name: socialnetwork_entrepreneurship_index; Type: INDEX; Schema: public; Owner: app_mov
--

CREATE INDEX socialnetwork_entrepreneurship_index ON public."SocialNetwork" USING btree (entrepreneurship);


--
-- Name: CollaborationImage CollaborationImage_collaboration_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."CollaborationImage"
    ADD CONSTRAINT "CollaborationImage_collaboration_fkey" FOREIGN KEY (collaboration) REFERENCES public."Collaboration"(id) ON DELETE SET NULL;


--
-- Name: CollaborationMembers CollaborationMembers_collaboration_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."CollaborationMembers"
    ADD CONSTRAINT "CollaborationMembers_collaboration_fkey" FOREIGN KEY (collaboration) REFERENCES public."Collaboration"(id) ON DELETE SET NULL;


--
-- Name: CollaborationMembers CollaborationMembers_entrepreneurship_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."CollaborationMembers"
    ADD CONSTRAINT "CollaborationMembers_entrepreneurship_fkey" FOREIGN KEY (entrepreneurship) REFERENCES public."Entrepreneurship"(id) ON DELETE SET NULL;


--
-- Name: CollaborationProducts CollaborationProducts_collaboration_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."CollaborationProducts"
    ADD CONSTRAINT "CollaborationProducts_collaboration_fkey" FOREIGN KEY (collaboration) REFERENCES public."Collaboration"(id) ON DELETE SET NULL;


--
-- Name: CollaborationProducts CollaborationProducts_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."CollaborationProducts"
    ADD CONSTRAINT "CollaborationProducts_product_fkey" FOREIGN KEY (product) REFERENCES public."Product"(id);


--
-- Name: DeliveryStatusLog DeliveryStatusLog_delivery_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."DeliveryStatusLog"
    ADD CONSTRAINT "DeliveryStatusLog_delivery_fkey" FOREIGN KEY (delivery) REFERENCES public."Delivery"(id) ON DELETE SET NULL;


--
-- Name: DeliveryStatusLog DeliveryStatusLog_delivery_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."DeliveryStatusLog"
    ADD CONSTRAINT "DeliveryStatusLog_delivery_status_fkey" FOREIGN KEY (delivery_status) REFERENCES public."DeliveryStatus"(id) ON DELETE SET NULL;


--
-- Name: DeliveryStatusLog DeliveryStatusLog_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."DeliveryStatusLog"
    ADD CONSTRAINT "DeliveryStatusLog_updated_by_fkey" FOREIGN KEY (updated_by) REFERENCES public.user_profile(id) ON DELETE SET NULL;


--
-- Name: Delivery Delivery_order_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Delivery"
    ADD CONSTRAINT "Delivery_order_fkey" FOREIGN KEY ("order") REFERENCES public."Order"(id);


--
-- Name: Delivery Delivery_partner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Delivery"
    ADD CONSTRAINT "Delivery_partner_fkey" FOREIGN KEY (partner) REFERENCES public."Partner"(id) ON DELETE SET NULL;


--
-- Name: EntrepreneurshipSubscription EntrepreneurshipSubscription_subscription_plan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."EntrepreneurshipSubscription"
    ADD CONSTRAINT "EntrepreneurshipSubscription_subscription_plan_fkey" FOREIGN KEY (subscription_plan) REFERENCES public."SubscriptionPlans"(id) ON DELETE SET NULL;


--
-- Name: Entrepreneurship Entrepreneurship_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Entrepreneurship"
    ADD CONSTRAINT "Entrepreneurship_category_fkey" FOREIGN KEY (category) REFERENCES public."EntrepreneurshipType"(id) ON DELETE SET NULL;


--
-- Name: Entrepreneurship Entrepreneurship_customization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Entrepreneurship"
    ADD CONSTRAINT "Entrepreneurship_customization_fkey" FOREIGN KEY (customization) REFERENCES public."EntrepreneurshipCustomization"(id);


--
-- Name: Entrepreneurship Entrepreneurship_subscription_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Entrepreneurship"
    ADD CONSTRAINT "Entrepreneurship_subscription_fkey" FOREIGN KEY (subscription) REFERENCES public."EntrepreneurshipSubscription"(id);


--
-- Name: Entrepreneurship Entrepreneurship_user_founder_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Entrepreneurship"
    ADD CONSTRAINT "Entrepreneurship_user_founder_fkey" FOREIGN KEY (user_founder) REFERENCES public.user_profile(id) ON DELETE SET NULL;


--
-- Name: Notification Notification_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_type_fkey" FOREIGN KEY (type) REFERENCES public."NotificationType"(id) ON DELETE SET NULL;


--
-- Name: Notification Notification_user_profile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_user_profile_fkey" FOREIGN KEY (user_profile) REFERENCES public.user_profile(id) ON DELETE SET NULL;


--
-- Name: OrderDetail OrderDetail_order_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."OrderDetail"
    ADD CONSTRAINT "OrderDetail_order_fkey" FOREIGN KEY ("order") REFERENCES public."Order"(id) ON DELETE SET NULL;


--
-- Name: OrderDetail OrderDetail_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."OrderDetail"
    ADD CONSTRAINT "OrderDetail_product_fkey" FOREIGN KEY (product) REFERENCES public."Product"(id);


--
-- Name: Order Order_entrepreneurship_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_entrepreneurship_fkey" FOREIGN KEY (entrepreneurship) REFERENCES public."Entrepreneurship"(id) ON DELETE SET NULL;


--
-- Name: Order Order_user_profile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_user_profile_fkey" FOREIGN KEY (user_profile) REFERENCES public.user_profile(id) ON DELETE SET NULL;


--
-- Name: Partner Partner_entrepreneurship_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Partner"
    ADD CONSTRAINT "Partner_entrepreneurship_fkey" FOREIGN KEY (entrepreneurship) REFERENCES public."Entrepreneurship"(id) ON DELETE SET NULL;


--
-- Name: Partner Partner_partner_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Partner"
    ADD CONSTRAINT "Partner_partner_rol_fkey" FOREIGN KEY (partner_rol) REFERENCES public."PartnerRol"(id) ON DELETE SET NULL;


--
-- Name: Partner Partner_user_profile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Partner"
    ADD CONSTRAINT "Partner_user_profile_fkey" FOREIGN KEY (user_profile) REFERENCES public.user_profile(id) ON DELETE SET NULL;


--
-- Name: PaymentEvidence PaymentEvidence_payment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."PaymentEvidence"
    ADD CONSTRAINT "PaymentEvidence_payment_fkey" FOREIGN KEY (payment) REFERENCES public."Payment"(id) ON DELETE SET NULL;


--
-- Name: Payment Payment_order_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_order_fkey" FOREIGN KEY ("order") REFERENCES public."Order"(id) ON DELETE SET NULL;


--
-- Name: Payment Payment_payment_method_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_payment_method_fkey" FOREIGN KEY (payment_method) REFERENCES public."PaymentMethod"(id);


--
-- Name: ProductImage ProductImage_product_variant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."ProductImage"
    ADD CONSTRAINT "ProductImage_product_variant_fkey" FOREIGN KEY (product_variant) REFERENCES public."ProductVariant"(id) ON DELETE CASCADE;


--
-- Name: ProductSpecification ProductSpecification_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."ProductSpecification"
    ADD CONSTRAINT "ProductSpecification_product_fkey" FOREIGN KEY (product) REFERENCES public."Product"(id) ON DELETE CASCADE;


--
-- Name: ProductVariant ProductVariant_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."ProductVariant"
    ADD CONSTRAINT "ProductVariant_product_fkey" FOREIGN KEY (product) REFERENCES public."Product"(id) ON DELETE CASCADE;


--
-- Name: Product Product_entrepreneurship_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_entrepreneurship_fkey" FOREIGN KEY (entrepreneurship) REFERENCES public."Entrepreneurship"(id) ON DELETE SET NULL;


--
-- Name: Review Review_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_product_fkey" FOREIGN KEY (product) REFERENCES public."Product"(id) ON DELETE SET NULL;


--
-- Name: Review Review_user_profile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_user_profile_fkey" FOREIGN KEY (user_profile) REFERENCES public.user_profile(id) ON DELETE SET NULL;


--
-- Name: Verification Verification_university_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Verification"
    ADD CONSTRAINT "Verification_university_fkey" FOREIGN KEY (university) REFERENCES public."University"(id);


--
-- Name: Delivery delivery_status_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Delivery"
    ADD CONSTRAINT delivery_status_foreign FOREIGN KEY (status) REFERENCES public."DeliveryStatus"(id) ON DELETE SET NULL;


--
-- Name: directus_access directus_access_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_comments directus_comments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_comments directus_comments_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON DELETE CASCADE;


--
-- Name: directus_roles directus_roles_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_roles(id);


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_registration_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_registration_role_foreign FOREIGN KEY (public_registration_role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_webhooks directus_webhooks_migrated_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_migrated_flow_foreign FOREIGN KEY (migrated_flow) REFERENCES public.directus_flows(id) ON DELETE SET NULL;


--
-- Name: Entrepreneurship_Tags entrepreneurship_tags_entrepreneurship_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Entrepreneurship_Tags"
    ADD CONSTRAINT entrepreneurship_tags_entrepreneurship_id_foreign FOREIGN KEY ("Entrepreneurship_id") REFERENCES public."Entrepreneurship"(id) ON DELETE SET NULL;


--
-- Name: Entrepreneurship_Tags entrepreneurship_tags_tags_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Entrepreneurship_Tags"
    ADD CONSTRAINT entrepreneurship_tags_tags_id_foreign FOREIGN KEY ("Tags_id") REFERENCES public."Tags"(id) ON DELETE SET NULL;


--
-- Name: EntrepreneurshipCustomization entrepreneurshipcustomization_entrepreneurship_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."EntrepreneurshipCustomization"
    ADD CONSTRAINT entrepreneurshipcustomization_entrepreneurship_foreign FOREIGN KEY (entrepreneurship) REFERENCES public."Entrepreneurship"(id);


--
-- Name: EntrepreneurshipSubscription entrepreneurshipsubscription_entrepreneurship_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."EntrepreneurshipSubscription"
    ADD CONSTRAINT entrepreneurshipsubscription_entrepreneurship_foreign FOREIGN KEY (entrepreneurship) REFERENCES public."Entrepreneurship"(id);


--
-- Name: Order order_status_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT order_status_foreign FOREIGN KEY (status) REFERENCES public."OrderStatus"(id) ON DELETE SET NULL;


--
-- Name: Product product_category_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT product_category_foreign FOREIGN KEY (category) REFERENCES public."ProductCategory"(name);


--
-- Name: SocialNetwork socialnetwork_entrepreneurship_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."SocialNetwork"
    ADD CONSTRAINT socialnetwork_entrepreneurship_foreign FOREIGN KEY (entrepreneurship) REFERENCES public."Entrepreneurship"(id) ON DELETE SET NULL;


--
-- Name: user_profile user_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_id_fkey FOREIGN KEY (id) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: user_profile user_profile_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_status_fkey FOREIGN KEY (status) REFERENCES public."UserStatus"(id) ON DELETE SET NULL;


--
-- Name: user_profile user_profile_university_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_university_fkey FOREIGN KEY (university) REFERENCES public."University"(id) ON DELETE SET NULL;


--
-- Name: user_profile user_profile_verification_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_verification_fkey FOREIGN KEY (verification) REFERENCES public."Verification"(id) ON DELETE SET NULL;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: app_mov
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_generate_v1() TO app_mov;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_generate_v1mc() TO app_mov;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_generate_v3(namespace uuid, name text) TO app_mov;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_generate_v4() TO app_mov;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_generate_v5(namespace uuid, name text) TO app_mov;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_nil() TO app_mov;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_ns_dns() TO app_mov;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_ns_oid() TO app_mov;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_ns_url() TO app_mov;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.uuid_ns_x500() TO app_mov;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES TO app_mov;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES TO app_mov;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS TO app_mov;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES TO app_mov;


--
-- PostgreSQL database dump complete
--

