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
    partner uuid
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
    entrepreneurship uuid,
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
    profile_picture character varying,
    university uuid NOT NULL,
    document character varying,
    document_type character varying,
    status integer NOT NULL,
    registration_date timestamp without time zone,
    email_verification boolean,
    verification uuid,
    user_rating numeric,
    partner_rating numeric
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

INSERT INTO public."Delivery" VALUES ('00000000-0000-0000-0000-000000000016', 'Delivery', 'Calle 123 #45-67', '00000000-0000-0000-0000-000000000012', '00000000-0000-0000-0000-000000000009');


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

INSERT INTO public."Entrepreneurship" VALUES ('00000000-0000-0000-0000-000000000007', 'Emarket', 'Compra y vende en la uni', 'Plataforma de compraventa entre estudiantes', '2025-04-19 12:00:00', '00000000-0000-0000-0000-000000000003', 'info@emarket.com', '1234567890', '00000000-0000-0000-0000-000000000004', 'active', 1, 1, 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa');


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
INSERT INTO public.directus_fields VALUES (9, 'Entrepreneurship', 'user_founder', 'uuid', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (11, 'OrderStatus', 'id', 'uuid', 'input', NULL, NULL, NULL, true, true, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (12, 'OrderStatus', 'name', NULL, NULL, NULL, NULL, NULL, false, false, 2, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);
INSERT INTO public.directus_fields VALUES (14, 'Order', 'status', 'm2o', NULL, NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL, false, NULL, NULL, NULL);


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_flows VALUES ('a631a800-b219-4c44-8829-910153ec9c2b', 'Realizar una Orden', 'bolt', NULL, 'Flow a ejecutar cuando un usuario ordena un producto ', 'active', 'event', 'all', '{"type":"action","scope":["items.update"],"collections":["Order"]}', '21b07fc3-0eb8-493e-a6b8-dd16e9589e6c', '2025-05-13 18:57:01.279+00', 'f49db054-0000-4460-bb03-2f783370e377');


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

INSERT INTO public.directus_operations VALUES ('adc3bb66-0f3d-49e2-ac9c-3b2b721aec9c', 'test 1', 'test_1', 'log', 37, 1, '{"message":"Esta pendientte"}', NULL, NULL, 'a631a800-b219-4c44-8829-910153ec9c2b', '2025-05-14 02:07:31.123+00', 'f49db054-0000-4460-bb03-2f783370e377');
INSERT INTO public.directus_operations VALUES ('a2b6e335-6e07-4243-bdb3-0a5502a92112', 'test 2', 'test_2', 'log', 37, 17, '{"message":"operacion es {{$trigger.payload.status}}"}', NULL, NULL, 'a631a800-b219-4c44-8829-910153ec9c2b', '2025-05-14 02:07:31.389+00', 'f49db054-0000-4460-bb03-2f783370e377');
INSERT INTO public.directus_operations VALUES ('21b07fc3-0eb8-493e-a6b8-dd16e9589e6c', 'Status is Pendiente', 'status_is_pendiente', 'condition', 19, 1, '{"filter":"{{$trigger.payload.status}} = ''pendiente''"}', 'adc3bb66-0f3d-49e2-ac9c-3b2b721aec9c', 'a2b6e335-6e07-4243-bdb3-0a5502a92112', 'a631a800-b219-4c44-8829-910153ec9c2b', '2025-05-14 02:07:31.641+00', 'f49db054-0000-4460-bb03-2f783370e377');


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_permissions VALUES (1, 'directus_users', 'create', '{}', '{}', NULL, '*', 'abf8a154-5b1c-4a46-ac9c-7300570f4f17');
INSERT INTO public.directus_permissions VALUES (2, 'directus_roles', 'read', '{}', '{}', NULL, '*', 'abf8a154-5b1c-4a46-ac9c-7300570f4f17');
INSERT INTO public.directus_permissions VALUES (4, 'Banner', 'read', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (5, 'Notification', 'read', '{"_and":[{"user_profile":{"_eq":"$CURRENT_USER"}}]}', NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (6, 'Notification', 'update', '{"_and":[{"user_profile":{"_eq":"$CURRENT_USER"}}]}', NULL, NULL, 'is_read', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (7, 'Product', 'read', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');
INSERT INTO public.directus_permissions VALUES (8, 'NotificationType', 'read', NULL, NULL, NULL, '*', '4a706832-1a5a-4e16-be61-a1756c9edaa7');


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_policies VALUES ('abf8a154-5b1c-4a46-ac9c-7300570f4f17', '$t:public_label', 'public', '$t:public_description', NULL, false, false, false);
INSERT INTO public.directus_policies VALUES ('4861387b-6d9c-48d1-9570-5af806d0671c', 'Administrator', 'verified', '$t:admin_description', NULL, false, true, true);
INSERT INTO public.directus_policies VALUES ('60429753-5a20-475d-85bc-de9a5f1ac84f', 'Emprendedor', 'badge', 'Usuario verificado de la aplicación', NULL, false, false, false);
INSERT INTO public.directus_policies VALUES ('4a706832-1a5a-4e16-be61-a1756c9edaa7', 'Usuario', 'badge', 'Usuario general de la aplicación', NULL, false, false, false);


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_presets VALUES (1, NULL, 'f49db054-0000-4460-bb03-2f783370e377', NULL, 'directus_users', NULL, 'cards', '{"cards":{"sort":["email"],"page":1}}', '{"cards":{"icon":"account_circle","title":"{{ first_name }} {{ last_name }}","subtitle":"{{ email }}","size":4}}', NULL, NULL, 'bookmark', NULL);


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_relations VALUES (1, 'Order', 'status', 'OrderStatus', NULL, NULL, NULL, NULL, NULL, 'nullify');


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


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_roles VALUES ('8c163976-88d3-4247-a44a-587399ecf43e', 'Administrator', 'verified', '$t:admin_description', NULL);
INSERT INTO public.directus_roles VALUES ('11111111-1111-1111-1111-111111111111', 'Comprador', 'supervised_user_circle', 'Usuario con permisos para comprar productos', NULL);
INSERT INTO public.directus_roles VALUES ('22222222-2222-2222-2222-222222222222', 'Emprendedor', 'supervised_user_circle', 'Usuario con permisos para vender productos', NULL);


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_sessions VALUES ('uJLVvRoIxBQozTuhf6kANQsqRW-bFvZ9UoueL5z0bMeT1Irj4_n7wV6GEPHt5ZyL', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-14 20:55:57.454+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.231.238.114', NULL);
INSERT INTO public.directus_sessions VALUES ('bj8keEHV6wT9KEk5tn9QdiK4UivFeq1q_zYYDmQsjIAKu4fyldV8tQt-Bxhs2CqE', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 01:10:46.567+00', '190.108.76.130', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.231.238.114', NULL);
INSERT INTO public.directus_sessions VALUES ('ecn3kBUkMsE0TKXzlXzgfwDWv5Iz3iO4DxkZ36PIpvyeRsY7LPZHLfI-1ogQKiZ8', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-21 02:10:31.29+00', '54.86.50.139', 'PostmanRuntime/7.43.4', NULL, NULL, NULL);
INSERT INTO public.directus_sessions VALUES ('-Og98ErvEqqo6Ur7Zl1LN8A8tGdHcEAhjNw3-mvgVMPPwJuY_akzCoHoR2ZnYRIg', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-15 02:20:20.044+00', '10.142.0.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.231.238.114', NULL);
INSERT INTO public.directus_sessions VALUES ('zRy8wjsKhlZeXGPwDbnpnvdJUZ78so4JJFchSzgGIk69cm8nKgqbrO1xMP_TsMn9', 'f49db054-0000-4460-bb03-2f783370e377', '2025-05-21 02:25:55.623+00', '186.116.227.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0', NULL, 'http://35.231.238.114', NULL);


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_users VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Carlos Comprador', NULL, 'carlos@tienda.com', '$argon2i$v=19$m=16,t=2,p=1$Qk4zb1RuWDJCcVRpb2JoSw$SzyC3tGEP6swGBt0TvBkiw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '11111111-1111-1111-1111-111111111111', NULL, NULL, NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.directus_users VALUES ('f49db054-0000-4460-bb03-2f783370e377', 'Admin', 'User', 'uniadmin@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$HwpZG943w+ekAUsSyGPIXA$Lmoi5sOtfYr9NVlcLZpn54pBzEFo6fIOfTMTHb/ox3k', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '8c163976-88d3-4247-a44a-587399ecf43e', NULL, '2025-05-14 02:25:56.062+00', '/content/ProductImage', 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: user_profile; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.user_profile VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'foto.jpg', '00000000-0000-0000-0000-000000000001', '12345678', 'C.C', 1, '2025-04-18 08:30:00', true, '00000000-0000-0000-0000-000000000006', 4.8, 4.5);


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

SELECT pg_catalog.setval('public.directus_activity_id_seq', 98, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 14, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 8, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 1, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 1, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 80, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, false);


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

