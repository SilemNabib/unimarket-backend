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
    social_networks integer NOT NULL,
    user_founder uuid NOT NULL
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
    color2 character varying
);


ALTER TABLE public."EntrepreneurshipCustomization" OWNER TO app_mov;

--
-- Name: EntrepreneurshipSubscription; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."EntrepreneurshipSubscription" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    subscription_plan uuid,
    cutoff_date timestamp without time zone,
    last_payment timestamp without time zone
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
    "Entrepreneurship_id" uuid NOT NULL,
    "Tags_id" uuid NOT NULL
);


ALTER TABLE public."Entrepreneurship_Tags" OWNER TO app_mov;

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
    date timestamp without time zone,
    subtotal numeric,
    discount numeric,
    total numeric,
    status uuid
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
    created_at timestamp without time zone
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
    entrepreneurship uuid NOT NULL,
    name character varying,
    description text,
    price numeric,
    stock_alert integer
);


ALTER TABLE public."Product" OWNER TO app_mov;

--
-- Name: ProductImage; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."ProductImage" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    image_url character varying,
    product_variant uuid NOT NULL
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
    product uuid NOT NULL,
    nombre character varying,
    stock integer
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
-- Name: SocialNetWork; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."SocialNetWork" (
    id integer NOT NULL,
    platform character varying,
    url character varying
);


ALTER TABLE public."SocialNetWork" OWNER TO app_mov;

--
-- Name: SocialNetWork_id_seq; Type: SEQUENCE; Schema: public; Owner: app_mov
--

ALTER TABLE public."SocialNetWork" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."SocialNetWork_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


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
-- Name: Temp_Prueba; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public."Temp_Prueba" (
    id uuid NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone
);


ALTER TABLE public."Temp_Prueba" OWNER TO app_mov;

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
-- Name: temp_many; Type: TABLE; Schema: public; Owner: app_mov
--

CREATE TABLE public.temp_many (
    id uuid NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    "Temp_one" uuid
);


ALTER TABLE public.temp_many OWNER TO app_mov;

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
    email_verification boolean DEFAULT false NOT NULL,
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

INSERT INTO public."Entrepreneurship" VALUES ('00000000-0000-0000-0000-000000000007', 'Emarket', 'Compra y vende en la uni', 'Plataforma de compraventa entre estudiantes', '2025-04-19 12:00:00', '00000000-0000-0000-0000-000000000003', 'info@emarket.com', '1234567890', '00000000-0000-0000-0000-000000000004', 'active', 1, 1, '8360fc8e-a7cb-483f-9bb8-b12b9827d233');


--
-- Data for Name: EntrepreneurshipCustomization; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."EntrepreneurshipCustomization" VALUES ('00000000-0000-0000-0000-000000000003', 'perfil.jpg', 'banner.jpg', '#FFFFFF', '#000000');


--
-- Data for Name: EntrepreneurshipSubscription; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."EntrepreneurshipSubscription" VALUES ('00000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000005', '2025-12-31 23:59:59', '2025-04-20 10:00:00');


--
-- Data for Name: EntrepreneurshipType; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."EntrepreneurshipType" VALUES (1, 'Digital');


--
-- Data for Name: Entrepreneurship_Tags; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Entrepreneurship_Tags" VALUES ('00000000-0000-0000-0000-000000000007', '00000000-0000-0000-0000-000000000002');


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

INSERT INTO public."Payment" VALUES ('00000000-0000-0000-0000-000000000014', '00000000-0000-0000-0000-000000000012', '00000000-0000-0000-0000-00000000000a', 'Confirmed', '2025-04-20 16:00:00', '2025-04-20 15:45:00');


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

INSERT INTO public."Product" VALUES ('00000000-0000-0000-0000-00000000000e', '00000000-0000-0000-0000-000000000007', 'Camiseta', 'Camiseta universitaria', 20000, 10);
INSERT INTO public."Product" VALUES ('cccdc0be-bc78-46da-8710-02d43466da2c', '00000000-0000-0000-0000-000000000007', 'Camiseta Universitaria', 'Camiseta 100% algodón con logo de la universidad', 25000, 10);
INSERT INTO public."Product" VALUES ('119f42ba-df36-4f32-8786-80c20ae3740a', '00000000-0000-0000-0000-000000000007', 'Camiseta Universitaria', 'Camiseta 100% algodón con logo de la universidad', 25000, 10);


--
-- Data for Name: ProductImage; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."ProductImage" VALUES ('00000000-0000-0000-0000-000000000010', 'camiseta_m.jpg', '00000000-0000-0000-0000-00000000000f');


--
-- Data for Name: ProductSpecification; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."ProductSpecification" VALUES ('00000000-0000-0000-0000-000000000011', '00000000-0000-0000-0000-00000000000e', 'Material', 'Algodón');


--
-- Data for Name: ProductVariant; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."ProductVariant" VALUES ('00000000-0000-0000-0000-00000000000f', '00000000-0000-0000-0000-00000000000e', 'Talla M', 50);


--
-- Data for Name: Review; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Review" VALUES ('00000000-0000-0000-0000-000000000018', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000000-0000-0000-0000-00000000000e', 5, 'Excelente producto', '2025-04-21 10:00:00');


--
-- Data for Name: SocialNetWork; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."SocialNetWork" VALUES (1, 'Instagram', 'https://instagram.com/emarket');


--
-- Data for Name: SubscriptionPlans; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."SubscriptionPlans" VALUES ('00000000-0000-0000-0000-000000000005', 'Plan Básico', 9.99, 'Descripción del plan básico', 'Acceso limitado, Soporte básico');


--
-- Data for Name: Tags; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Tags" VALUES ('00000000-0000-0000-0000-000000000002', 'Tecnología');


--
-- Data for Name: Temp_Prueba; Type: TABLE DATA; Schema: public; Owner: app_mov
--



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
INSERT INTO public.directus_collections VALUES ('SocialNetWork', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Review', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('EntrepreneurshipCustomization', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('EntrepreneurshipSubscription', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Partner', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('Entrepreneurship_Tags', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
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
INSERT INTO public.directus_collections VALUES ('Temp_Prueba', NULL, NULL, NULL, false, false, NULL, 'status', true, 'archived', 'draft', NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);
INSERT INTO public.directus_collections VALUES ('temp_many', NULL, NULL, NULL, false, false, NULL, 'status', true, 'archived', 'draft', NULL, 'all', NULL, NULL, NULL, NULL, 'open', NULL, false);


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
INSERT INTO public.directus_fields VALUES (14, 'Order', 'status', 'm2o', NULL, NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (15, 'Delivery', 'partner', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (16, 'Delivery', 'type', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (17, 'Delivery', 'status', 'm2o', NULL, NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (59, 'temp_many', 'id', 'uuid', 'input', NULL, NULL, NULL, true, true, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (60, 'temp_many', 'status', NULL, 'select-dropdown', '{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]}', 'labels', '{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]}', false, false, 2, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (61, 'temp_many', 'user_created', 'user-created', 'select-dropdown-m2o', '{"template":"{{avatar}} {{first_name}} {{last_name}}"}', 'user', NULL, true, true, 3, 'half', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (62, 'temp_many', 'date_created', 'date-created', 'datetime', NULL, 'datetime', '{"relative":true}', true, true, 4, 'half', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (23, 'user_profile', 'id', NULL, NULL, NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (63, 'temp_many', 'user_updated', 'user-updated', 'select-dropdown-m2o', '{"template":"{{avatar}} {{first_name}} {{last_name}}"}', 'user', NULL, true, true, 5, 'half', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (19, 'user_profile', 'profile_picture', NULL, NULL, NULL, NULL, NULL, false, false, 3, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (20, 'user_profile', 'document', NULL, NULL, NULL, NULL, NULL, false, false, 4, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (21, 'user_profile', 'document_type', NULL, NULL, NULL, NULL, NULL, false, false, 5, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (22, 'user_profile', 'status', NULL, NULL, NULL, NULL, NULL, false, false, 6, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (24, 'user_profile', 'registration_date', 'date-created', NULL, NULL, NULL, NULL, false, false, 7, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (25, 'user_profile', 'email_verification', 'cast-boolean', NULL, NULL, NULL, NULL, false, false, 8, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (26, 'user_profile', 'verification', NULL, NULL, NULL, NULL, NULL, false, false, 9, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (27, 'user_profile', 'user_rating', NULL, NULL, NULL, NULL, NULL, false, false, 10, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (28, 'user_profile', 'partner_rating', NULL, NULL, NULL, NULL, NULL, false, false, 11, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (18, 'user_profile', 'university', NULL, NULL, NULL, NULL, NULL, false, false, 2, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (64, 'temp_many', 'date_updated', 'date-updated', 'datetime', NULL, 'datetime', '{"relative":true}', true, true, 6, 'half', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (30, 'Banner', 'id', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (31, 'Banner', 'url', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (32, 'Banner', 'created_at', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (33, 'Entrepreneurship', 'id', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (34, 'Entrepreneurship', 'name', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (35, 'Entrepreneurship', 'social_networks', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
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
INSERT INTO public.directus_fields VALUES (29, 'Product', 'entrepreneurship', NULL, 'select-dropdown-m2o', '{"template":"{{id}}{{name}}"}', 'related-values', '{"template":"{{id}}{{name}}{{slogan}}"}', false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (45, 'Entrepreneurship', 'email', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (9, 'Entrepreneurship', 'user_founder', 'uuid', NULL, NULL, 'related-values', '{"template":"{{id}}{{university}}"}', false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (50, 'University', 'id', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (51, 'University', 'acronym', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (52, 'University', 'name', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (53, 'Temp_Prueba', 'id', 'uuid', 'input', NULL, NULL, NULL, true, true, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (54, 'Temp_Prueba', 'status', NULL, 'select-dropdown', '{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]}', 'labels', '{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]}', false, false, 2, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (55, 'Temp_Prueba', 'user_created', 'user-created', 'select-dropdown-m2o', '{"template":"{{avatar}} {{first_name}} {{last_name}}"}', 'user', NULL, true, true, 3, 'half', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (56, 'Temp_Prueba', 'date_created', 'date-created', 'datetime', NULL, 'datetime', '{"relative":true}', true, true, 4, 'half', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (57, 'Temp_Prueba', 'user_updated', 'user-updated', 'select-dropdown-m2o', '{"template":"{{avatar}} {{first_name}} {{last_name}}"}', 'user', NULL, true, true, 5, 'half', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (58, 'Temp_Prueba', 'date_updated', 'date-updated', 'datetime', NULL, 'datetime', '{"relative":true}', true, true, 6, 'half', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (66, 'temp_many', 'Temp_one', 'm2o', NULL, NULL, NULL, NULL, false, false, 7, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_flows VALUES ('66904cac-25ff-48ab-9ee6-a4eac72485b2', 'Get User', 'task', '#E35169', NULL, 'active', 'operation', 'all', '{"return":"$last"}', '336d194c-cf1f-410c-af63-ce913f219fb4', '2025-05-15 01:44:35.845+00', 'f49db054-0000-4460-bb03-2f783370e377');
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
INSERT INTO public.directus_permissions VALUES (16, 'Entrepreneurship', 'read', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (17, 'Entrepreneurship_Tags', 'read', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (1, 'directus_users', 'create', NULL, NULL, NULL, '*', 'abf8a154-5b1c-4a46-ac9c-7300570f4f17');
INSERT INTO public.directus_permissions VALUES (7, 'Product', 'read', NULL, NULL, NULL, 'id,entrepreneurship,name,description,price', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (18, 'Product', 'read', '{"entrepreneurship":{"user_founder":{"id":"$CURRENT_USER"}}}', NULL, NULL, '*', '60429753-5a20-475d-85bc-de9a5f1ac84f');


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


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_relations VALUES (1, 'Order', 'status', 'OrderStatus', NULL, NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (2, 'Delivery', 'status', 'DeliveryStatus', NULL, NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (3, 'Temp_Prueba', 'user_updated', 'directus_users', NULL, NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (4, 'Temp_Prueba', 'user_created', 'directus_users', NULL, NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (5, 'temp_many', 'user_created', 'directus_users', NULL, NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (6, 'temp_many', 'user_updated', 'directus_users', NULL, NULL, NULL, NULL, NULL, 'nullify');
INSERT INTO public.directus_relations VALUES (8, 'temp_many', 'Temp_one', 'Temp_Prueba', NULL, NULL, NULL, NULL, NULL, 'nullify');


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


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_roles VALUES ('8c163976-88d3-4247-a44a-587399ecf43e', 'Administrator', 'verified', '$t:admin_description', NULL);
INSERT INTO public.directus_roles VALUES ('22222222-2222-2222-2222-222222222222', 'Emprendedor', 'supervised_user_circle', 'Usuario con permisos para vender productos', NULL);
INSERT INTO public.directus_roles VALUES ('1eb1310f-321f-4733-8aaf-7a935b5886f6', 'TestRole', 'supervised_user_circle', NULL, NULL);
INSERT INTO public.directus_roles VALUES ('11111111-1111-1111-1111-111111111111', 'Comprador', 'supervised_user_circle', 'Usuario con permisos para comprar productos', NULL);


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_sessions VALUES ('8OWgWN7kjFyIbMxqApti9iLbvTlk8PKAh926Lw6A7K_mzkZY5wPFuXD8YKNye8tP', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-22 02:38:53.014+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('8-dMuonM93s8VaB2PmNw_IAPGm-BqBgGW8RmvrDH_EuJ-7dy_FTtLcAdbgAK66pk', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 15:03:55.044+00', '190.108.76.130', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.231.238.114', NULL);
INSERT INTO public.directus_sessions VALUES ('047lZB3faW8_lYG8-YxXVcBlwFxL0Gg_nbrZQS_mOmdHvwhs8xVx9pgQtXKI-VMb', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-22 02:48:54.905+00', '10.142.0.3', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('ecn3kBUkMsE0TKXzlXzgfwDWv5Iz3iO4DxkZ36PIpvyeRsY7LPZHLfI-1ogQKiZ8', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-21 02:10:31.29+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('zRy8wjsKhlZeXGPwDbnpnvdJUZ78so4JJFchSzgGIk69cm8nKgqbrO1xMP_TsMn9', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-21 02:25:55.623+00', '186.116.227.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.231.238.114', NULL);
INSERT INTO public.directus_sessions VALUES ('FcktwSwM6TXiZnf5JovxKL7v9BxrjpR3jwH0lxkLlYzcwLjtWJcEw9itzFvLgESX', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-21 23:01:06.846+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('WkhLPXbgIRVm92GaXiwqaCW3jxJXVUCk-pji1P62ZjVH_FNXFLci0joVpGnYZF1s', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-21 23:11:36.836+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('zARCukL-5X3GkKafqH6e7BnDanOqK-EV2_tXZPmYbDUAPEOQICv6aLoi6oGDqNe3', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-21 23:11:41.386+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('KOUIuIZOtvJXrCONZ-oAqXjiKFW-4aNN7uEZGyVL9ssplR1vE2D14_chNC2QqR0r', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-21 23:12:21.528+00', '10.142.0.3', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('TGXWDwlLfyXTfBy4dA3n4hCKKexAHUYkvflJW-IM4LG8MG9MiVb15UFU1pXu0nBe', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-22 04:34:19.164+00', '186.169.19.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('T2s2SqudHSlHoHWKftwVm7sZbCMwqmcuhVDxk_lSt1tiDnug43RBLFqIgXKpjb9f', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-22 02:00:34.093+00', '10.142.0.3', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('InOIEBDGSWG4m0EeE194WddsQ0x6XsdOrC95Xy1-jFD-o9mIsSS9BqA-aupAyxS9', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-22 04:34:23.039+00', '186.169.19.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('4bSmvFzq1TIDenkolBtr4GURwmpg4byujPX5juf4HDMdUehCpr62Ync8CscpqAiS', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 05:06:48.393+00', '190.108.76.130', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.231.238.114', 'oE2l72Bhzbjy46zreC2wuFsXjvd1xZuWv9qhKfSxMAdGcr6UXACpCyBk68Gu9893');
INSERT INTO public.directus_sessions VALUES ('WjjyboGUe1Cq5HcUvfXHdzwnA6R9RFBmd-1sQGO6Im-HFUHkFDkMBR-apFZ1Wo6G', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 04:35:32.133+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.231.238.114', NULL);
INSERT INTO public.directus_sessions VALUES ('Z75-oHd5du8cwHHL0HWy6qxAulRmpmiLnz03kiuXkqW_VCx6_VT9U8fmJ9NLPcc2', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-22 03:23:08.754+00', '10.142.0.3', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('lYv0bMs0Nl6C3oE62jFfJsiJqA_L6yvhTIPraXKZXQ39o0LcIQ628_JpiLU5-efu', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-22 03:23:27.996+00', '186.169.19.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('85nWbZEuabeZG5B0vEpam7cBZYIovkVFDRZFrZwuLP2HsDjwi3LDVPV3SrbWCTF4', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-22 03:26:02.268+00', '10.142.0.3', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('A_cC3otVplzmWAvX17IPukExWdO-PES6q2rk8tjlSz_aWYO_pochp2-o-49A4T6I', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-22 03:26:13.124+00', '186.169.19.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('oLG_mkNpZwGzv339DPCmE58M47h2_RsTMPYEHSNZ7xyrq7-OmTLOvpnpHJktU6dM', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-22 03:27:00.467+00', '186.169.19.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('1qhnE8DKefqmzhAXnKszt7dxAhw5GZCKprsYBvpTpeX1Xb1ZEi9uFqOjmLhbEWLy', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-22 03:37:25.544+00', '10.142.0.3', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('rfaw4fcROACv76rgK3toI6FsYdCSm1Nidtgjh9MmI0oacZdlyYN9o65ou6_SSP-b', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2025-05-22 03:40:54.056+00', '186.169.19.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('vOeTL8wc2im5NVAgiPyNmCfg4cvvH0SzS5tA_aUFHAXL2kr7npLGPDPWiczYs-pr', '8360fc8e-a7cb-483f-9bb8-b12b9827d233', '2025-05-22 03:41:03.99+00', '186.169.19.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('oE2l72Bhzbjy46zreC2wuFsXjvd1xZuWv9qhKfSxMAdGcr6UXACpCyBk68Gu9893', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-16 05:06:38.393+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.231.238.114', NULL);
INSERT INTO public.directus_sessions VALUES ('3VIPycR2-EYYR-jqbGGujsK7ImdsgzqlILTEprvlvSQkOQRZdjC61mfURRUvKm10', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-22 04:38:15.251+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_settings VALUES (1, 'Directus', 'http://35.231.238.114', '#6644FF', NULL, NULL, NULL, NULL, 25, NULL, 'all', NULL, NULL, NULL, NULL, NULL, '[{"type":"module","id":"content","enabled":true},{"type":"module","id":"visual","enabled":true},{"type":"module","id":"users","enabled":true},{"type":"module","id":"files","enabled":true},{"type":"module","id":"insights","enabled":true},{"type":"link","id":"docs","name":"Documentation","url":"https://docs.directus.io","icon":"help","enabled":true},{"type":"module","id":"settings","enabled":true,"locked":true}]', NULL, 'en-US', NULL, NULL, 'auto', NULL, NULL, NULL, NULL, NULL, NULL, NULL, true, false, '1eb1310f-321f-4733-8aaf-7a935b5886f6', NULL, NULL);


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_users VALUES ('f49db054-0000-4460-bb03-2f783370e377', 'Admin', 'User', 'uniadmin@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$HwpZG943w+ekAUsSyGPIXA$Lmoi5sOtfYr9NVlcLZpn54pBzEFo6fIOfTMTHb/ox3k', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '8c163976-88d3-4247-a44a-587399ecf43e', NULL, '2025-05-15 05:06:38.566+00', '/settings/flows', 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.directus_users VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Carlos Comprador', NULL, 'carlos@tienda.com', '$argon2id$v=19$m=65536,t=3,p=4$bjAsRR7iRUQEUQsfnp/18w$bbFzNoSUhllzcb9Xzap94owNuzlXHyNXcMFwu+RD2ZM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '11111111-1111-1111-1111-111111111111', NULL, '2025-05-15 04:34:19.607+00', NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.directus_users VALUES ('8360fc8e-a7cb-483f-9bb8-b12b9827d233', 'Juan', 'Vendedor', 'juanvendedor@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$Lfl8YI9ZO1sKjEMgySaLpw$3p1b5VmW1t5RDo7PQkJqwmtGLi0QfczZxk5QfGzQpoM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '22222222-2222-2222-2222-222222222222', NULL, '2025-05-15 04:34:23.458+00', NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: temp_many; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: user_profile; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.user_profile VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'foto.jpg', '00000000-0000-0000-0000-000000000001', '12345678', 'C.C', 1, '2025-04-18 08:30:00', true, '00000000-0000-0000-0000-000000000006', 4.80000, 4.50000);
INSERT INTO public.user_profile VALUES ('8360fc8e-a7cb-483f-9bb8-b12b9827d233', 'https://directus-unimarket.s3.us-east-1.amazonaws.com/usuarios/default-profile', '00000000-0000-0000-0000-000000000001', '1231231231', 'C.C', 1, '2025-05-15 04:38:21.763', false, 'd76eb01a-7b8b-45d9-9e15-ddf24157cc23', 4.00000, 5.00000);


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

SELECT pg_catalog.setval('public.directus_activity_id_seq', 382, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 66, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 21, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 1, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 8, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 296, true);


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
    ADD CONSTRAINT "Entrepreneurship_Tags_pkey" PRIMARY KEY ("Entrepreneurship_id", "Tags_id");


--
-- Name: Entrepreneurship Entrepreneurship_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Entrepreneurship"
    ADD CONSTRAINT "Entrepreneurship_pkey" PRIMARY KEY (id);


--
-- Name: Entrepreneurship Entrepreneurship_social_networks_key; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Entrepreneurship"
    ADD CONSTRAINT "Entrepreneurship_social_networks_key" UNIQUE (social_networks);


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
-- Name: SocialNetWork SocialNetWork_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."SocialNetWork"
    ADD CONSTRAINT "SocialNetWork_pkey" PRIMARY KEY (id);


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
-- Name: Temp_Prueba Temp_Prueba_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Temp_Prueba"
    ADD CONSTRAINT "Temp_Prueba_pkey" PRIMARY KEY (id);


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
-- Name: OrderStatus orderstatus_name_unique; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."OrderStatus"
    ADD CONSTRAINT orderstatus_name_unique UNIQUE (name);


--
-- Name: temp_many temp_many_pkey; Type: CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.temp_many
    ADD CONSTRAINT temp_many_pkey PRIMARY KEY (id);


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
-- Name: CollaborationImage CollaborationImage_collaboration_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."CollaborationImage"
    ADD CONSTRAINT "CollaborationImage_collaboration_fkey" FOREIGN KEY (collaboration) REFERENCES public."Collaboration"(id);


--
-- Name: CollaborationMembers CollaborationMembers_collaboration_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."CollaborationMembers"
    ADD CONSTRAINT "CollaborationMembers_collaboration_fkey" FOREIGN KEY (collaboration) REFERENCES public."Collaboration"(id);


--
-- Name: CollaborationMembers CollaborationMembers_entrepreneurship_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."CollaborationMembers"
    ADD CONSTRAINT "CollaborationMembers_entrepreneurship_fkey" FOREIGN KEY (entrepreneurship) REFERENCES public."Entrepreneurship"(id);


--
-- Name: CollaborationProducts CollaborationProducts_collaboration_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."CollaborationProducts"
    ADD CONSTRAINT "CollaborationProducts_collaboration_fkey" FOREIGN KEY (collaboration) REFERENCES public."Collaboration"(id);


--
-- Name: CollaborationProducts CollaborationProducts_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."CollaborationProducts"
    ADD CONSTRAINT "CollaborationProducts_product_fkey" FOREIGN KEY (product) REFERENCES public."Product"(id);


--
-- Name: DeliveryStatusLog DeliveryStatusLog_delivery_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."DeliveryStatusLog"
    ADD CONSTRAINT "DeliveryStatusLog_delivery_fkey" FOREIGN KEY (delivery) REFERENCES public."Delivery"(id);


--
-- Name: DeliveryStatusLog DeliveryStatusLog_delivery_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."DeliveryStatusLog"
    ADD CONSTRAINT "DeliveryStatusLog_delivery_status_fkey" FOREIGN KEY (delivery_status) REFERENCES public."DeliveryStatus"(id);


--
-- Name: DeliveryStatusLog DeliveryStatusLog_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."DeliveryStatusLog"
    ADD CONSTRAINT "DeliveryStatusLog_updated_by_fkey" FOREIGN KEY (updated_by) REFERENCES public.user_profile(id);


--
-- Name: Delivery Delivery_order_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Delivery"
    ADD CONSTRAINT "Delivery_order_fkey" FOREIGN KEY ("order") REFERENCES public."Order"(id);


--
-- Name: Delivery Delivery_partner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Delivery"
    ADD CONSTRAINT "Delivery_partner_fkey" FOREIGN KEY (partner) REFERENCES public."Partner"(id);


--
-- Name: EntrepreneurshipSubscription EntrepreneurshipSubscription_subscription_plan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."EntrepreneurshipSubscription"
    ADD CONSTRAINT "EntrepreneurshipSubscription_subscription_plan_fkey" FOREIGN KEY (subscription_plan) REFERENCES public."SubscriptionPlans"(id);


--
-- Name: Entrepreneurship_Tags Entrepreneurship_Tags_Entrepreneurship_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Entrepreneurship_Tags"
    ADD CONSTRAINT "Entrepreneurship_Tags_Entrepreneurship_id_fkey" FOREIGN KEY ("Entrepreneurship_id") REFERENCES public."Entrepreneurship"(id);


--
-- Name: Entrepreneurship_Tags Entrepreneurship_Tags_Tags_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Entrepreneurship_Tags"
    ADD CONSTRAINT "Entrepreneurship_Tags_Tags_id_fkey" FOREIGN KEY ("Tags_id") REFERENCES public."Tags"(id);


--
-- Name: Entrepreneurship Entrepreneurship_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Entrepreneurship"
    ADD CONSTRAINT "Entrepreneurship_category_fkey" FOREIGN KEY (category) REFERENCES public."EntrepreneurshipType"(id);


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
    ADD CONSTRAINT "Entrepreneurship_user_founder_fkey" FOREIGN KEY (user_founder) REFERENCES public.user_profile(id);


--
-- Name: Notification Notification_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_type_fkey" FOREIGN KEY (type) REFERENCES public."NotificationType"(id);


--
-- Name: Notification Notification_user_profile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_user_profile_fkey" FOREIGN KEY (user_profile) REFERENCES public.user_profile(id);


--
-- Name: OrderDetail OrderDetail_order_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."OrderDetail"
    ADD CONSTRAINT "OrderDetail_order_fkey" FOREIGN KEY ("order") REFERENCES public."Order"(id);


--
-- Name: OrderDetail OrderDetail_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."OrderDetail"
    ADD CONSTRAINT "OrderDetail_product_fkey" FOREIGN KEY (product) REFERENCES public."Product"(id);


--
-- Name: Order Order_entrepreneurship_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_entrepreneurship_fkey" FOREIGN KEY (entrepreneurship) REFERENCES public."Entrepreneurship"(id);


--
-- Name: Order Order_user_profile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_user_profile_fkey" FOREIGN KEY (user_profile) REFERENCES public.user_profile(id);


--
-- Name: Partner Partner_entrepreneurship_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Partner"
    ADD CONSTRAINT "Partner_entrepreneurship_fkey" FOREIGN KEY (entrepreneurship) REFERENCES public."Entrepreneurship"(id);


--
-- Name: Partner Partner_partner_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Partner"
    ADD CONSTRAINT "Partner_partner_rol_fkey" FOREIGN KEY (partner_rol) REFERENCES public."PartnerRol"(id);


--
-- Name: Partner Partner_user_profile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Partner"
    ADD CONSTRAINT "Partner_user_profile_fkey" FOREIGN KEY (user_profile) REFERENCES public.user_profile(id);


--
-- Name: PaymentEvidence PaymentEvidence_payment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."PaymentEvidence"
    ADD CONSTRAINT "PaymentEvidence_payment_fkey" FOREIGN KEY (payment) REFERENCES public."Payment"(id);


--
-- Name: Payment Payment_order_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_order_fkey" FOREIGN KEY ("order") REFERENCES public."Order"(id);


--
-- Name: Payment Payment_payment_method_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_payment_method_fkey" FOREIGN KEY (payment_method) REFERENCES public."PaymentMethod"(id);


--
-- Name: ProductImage ProductImage_product_variant_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."ProductImage"
    ADD CONSTRAINT "ProductImage_product_variant_fkey" FOREIGN KEY (product_variant) REFERENCES public."ProductVariant"(id);


--
-- Name: ProductSpecification ProductSpecification_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."ProductSpecification"
    ADD CONSTRAINT "ProductSpecification_product_fkey" FOREIGN KEY (product) REFERENCES public."Product"(id);


--
-- Name: ProductVariant ProductVariant_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."ProductVariant"
    ADD CONSTRAINT "ProductVariant_product_fkey" FOREIGN KEY (product) REFERENCES public."Product"(id);


--
-- Name: Product Product_entrepreneurship_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_entrepreneurship_fkey" FOREIGN KEY (entrepreneurship) REFERENCES public."Entrepreneurship"(id);


--
-- Name: Review Review_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_product_fkey" FOREIGN KEY (product) REFERENCES public."Product"(id);


--
-- Name: Review Review_user_profile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_user_profile_fkey" FOREIGN KEY (user_profile) REFERENCES public.user_profile(id);


--
-- Name: SocialNetWork SocialNetWork_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."SocialNetWork"
    ADD CONSTRAINT "SocialNetWork_id_fkey" FOREIGN KEY (id) REFERENCES public."Entrepreneurship"(social_networks);


--
-- Name: Verification Verification_university_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Verification"
    ADD CONSTRAINT "Verification_university_fkey" FOREIGN KEY (university) REFERENCES public."University"(id);


--
-- Name: Delivery delivery_status_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Delivery"
    ADD CONSTRAINT delivery_status_foreign FOREIGN KEY (status) REFERENCES public."DeliveryStatus"(id);


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
-- Name: Order order_status_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT order_status_foreign FOREIGN KEY (status) REFERENCES public."OrderStatus"(id);


--
-- Name: temp_many temp_many_temp_one_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.temp_many
    ADD CONSTRAINT temp_many_temp_one_foreign FOREIGN KEY ("Temp_one") REFERENCES public."Temp_Prueba"(id) ON DELETE SET NULL;


--
-- Name: temp_many temp_many_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.temp_many
    ADD CONSTRAINT temp_many_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id);


--
-- Name: temp_many temp_many_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.temp_many
    ADD CONSTRAINT temp_many_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: Temp_Prueba temp_prueba_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Temp_Prueba"
    ADD CONSTRAINT temp_prueba_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id);


--
-- Name: Temp_Prueba temp_prueba_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public."Temp_Prueba"
    ADD CONSTRAINT temp_prueba_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: user_profile user_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_id_fkey FOREIGN KEY (id) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: user_profile user_profile_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_status_fkey FOREIGN KEY (status) REFERENCES public."UserStatus"(id);


--
-- Name: user_profile user_profile_university_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_university_fkey FOREIGN KEY (university) REFERENCES public."University"(id);


--
-- Name: user_profile user_profile_verification_fkey; Type: FK CONSTRAINT; Schema: public; Owner: app_mov
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_verification_fkey FOREIGN KEY (verification) REFERENCES public."Verification"(id);


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

