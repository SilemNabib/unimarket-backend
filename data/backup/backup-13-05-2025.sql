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
    content character varying
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
    status character varying,
    subtotal numeric,
    discount numeric,
    total numeric
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
    quantity integer,
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

INSERT INTO public."Notification" VALUES ('00000000-0000-0000-0000-00000000000d', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 1, 'Bienvenida', '¡Bienvenido a Emarket!');


--
-- Data for Name: NotificationType; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."NotificationType" VALUES (1, 'General');


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."Order" VALUES ('00000000-0000-0000-0000-000000000012', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '00000000-0000-0000-0000-000000000007', '2025-04-20 15:30:00', 'Pending', 40000, 5000, 35000);


--
-- Data for Name: OrderDetail; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public."OrderDetail" VALUES ('00000000-0000-0000-0000-000000000013', '00000000-0000-0000-0000-000000000012', '00000000-0000-0000-0000-00000000000e', 2, 20000);


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

INSERT INTO public."Product" VALUES ('00000000-0000-0000-0000-00000000000e', '00000000-0000-0000-0000-000000000007', 'Camiseta', 'Camiseta universitaria', 20000, 10, 5);


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

INSERT INTO public.directus_access VALUES ('961dcce6-b567-4e7b-b095-dd7407c4a80f', NULL, NULL, 'abf8a154-5b1c-4a46-ac9c-7300570f4f17', 1);
INSERT INTO public.directus_access VALUES ('c0a5f8ba-edee-4905-b487-800b68b92260', '5115c454-fe0e-4805-9ef9-ef6c5d9767f1', NULL, 'd76e247c-64e6-47d2-9269-ff2329e4a393', NULL);


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: app_mov
--



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
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_migrations VALUES ('20201028A', 'Remove Collection Foreign Keys', '2025-05-13 13:22:57.712135+00');
INSERT INTO public.directus_migrations VALUES ('20201029A', 'Remove System Relations', '2025-05-13 13:22:57.902467+00');
INSERT INTO public.directus_migrations VALUES ('20201029B', 'Remove System Collections', '2025-05-13 13:22:58.074415+00');
INSERT INTO public.directus_migrations VALUES ('20201029C', 'Remove System Fields', '2025-05-13 13:22:58.251784+00');
INSERT INTO public.directus_migrations VALUES ('20201105A', 'Add Cascade System Relations', '2025-05-13 13:23:00.86119+00');
INSERT INTO public.directus_migrations VALUES ('20201105B', 'Change Webhook URL Type', '2025-05-13 13:23:01.203467+00');
INSERT INTO public.directus_migrations VALUES ('20210225A', 'Add Relations Sort Field', '2025-05-13 13:23:01.465311+00');
INSERT INTO public.directus_migrations VALUES ('20210304A', 'Remove Locked Fields', '2025-05-13 13:23:01.63709+00');
INSERT INTO public.directus_migrations VALUES ('20210312A', 'Webhooks Collections Text', '2025-05-13 13:23:01.979258+00');
INSERT INTO public.directus_migrations VALUES ('20210331A', 'Add Refresh Interval', '2025-05-13 13:23:02.146792+00');
INSERT INTO public.directus_migrations VALUES ('20210415A', 'Make Filesize Nullable', '2025-05-13 13:23:02.566425+00');
INSERT INTO public.directus_migrations VALUES ('20210416A', 'Add Collections Accountability', '2025-05-13 13:23:02.822125+00');
INSERT INTO public.directus_migrations VALUES ('20210422A', 'Remove Files Interface', '2025-05-13 13:23:02.986857+00');
INSERT INTO public.directus_migrations VALUES ('20210506A', 'Rename Interfaces', '2025-05-13 13:23:06.35022+00');
INSERT INTO public.directus_migrations VALUES ('20210510A', 'Restructure Relations', '2025-05-13 13:23:07.340925+00');
INSERT INTO public.directus_migrations VALUES ('20210518A', 'Add Foreign Key Constraints', '2025-05-13 13:23:07.613134+00');
INSERT INTO public.directus_migrations VALUES ('20210519A', 'Add System Fk Triggers', '2025-05-13 13:23:09.162543+00');
INSERT INTO public.directus_migrations VALUES ('20210521A', 'Add Collections Icon Color', '2025-05-13 13:23:09.339771+00');
INSERT INTO public.directus_migrations VALUES ('20210525A', 'Add Insights', '2025-05-13 13:23:09.943144+00');
INSERT INTO public.directus_migrations VALUES ('20210608A', 'Add Deep Clone Config', '2025-05-13 13:23:10.12088+00');
INSERT INTO public.directus_migrations VALUES ('20210626A', 'Change Filesize Bigint', '2025-05-13 13:23:10.556555+00');
INSERT INTO public.directus_migrations VALUES ('20210716A', 'Add Conditions to Fields', '2025-05-13 13:23:10.723571+00');
INSERT INTO public.directus_migrations VALUES ('20210721A', 'Add Default Folder', '2025-05-13 13:23:10.986481+00');
INSERT INTO public.directus_migrations VALUES ('20210802A', 'Replace Groups', '2025-05-13 13:23:11.244309+00');
INSERT INTO public.directus_migrations VALUES ('20210803A', 'Add Required to Fields', '2025-05-13 13:23:11.411142+00');
INSERT INTO public.directus_migrations VALUES ('20210805A', 'Update Groups', '2025-05-13 13:23:11.583048+00');
INSERT INTO public.directus_migrations VALUES ('20210805B', 'Change Image Metadata Structure', '2025-05-13 13:23:11.754867+00');
INSERT INTO public.directus_migrations VALUES ('20210811A', 'Add Geometry Config', '2025-05-13 13:23:11.922596+00');
INSERT INTO public.directus_migrations VALUES ('20210831A', 'Remove Limit Column', '2025-05-13 13:23:12.09111+00');
INSERT INTO public.directus_migrations VALUES ('20210903A', 'Add Auth Provider', '2025-05-13 13:23:12.85334+00');
INSERT INTO public.directus_migrations VALUES ('20210907A', 'Webhooks Collections Not Null', '2025-05-13 13:23:13.275041+00');
INSERT INTO public.directus_migrations VALUES ('20210910A', 'Move Module Setup', '2025-05-13 13:23:13.524527+00');
INSERT INTO public.directus_migrations VALUES ('20210920A', 'Webhooks URL Not Null', '2025-05-13 13:23:13.949092+00');
INSERT INTO public.directus_migrations VALUES ('20210924A', 'Add Collection Organization', '2025-05-13 13:23:14.210948+00');
INSERT INTO public.directus_migrations VALUES ('20210927A', 'Replace Fields Group', '2025-05-13 13:23:14.713425+00');
INSERT INTO public.directus_migrations VALUES ('20210927B', 'Replace M2M Interface', '2025-05-13 13:23:14.891355+00');
INSERT INTO public.directus_migrations VALUES ('20210929A', 'Rename Login Action', '2025-05-13 13:23:15.057563+00');
INSERT INTO public.directus_migrations VALUES ('20211007A', 'Update Presets', '2025-05-13 13:23:15.399366+00');
INSERT INTO public.directus_migrations VALUES ('20211009A', 'Add Auth Data', '2025-05-13 13:23:15.571445+00');
INSERT INTO public.directus_migrations VALUES ('20211016A', 'Add Webhook Headers', '2025-05-13 13:23:15.765179+00');
INSERT INTO public.directus_migrations VALUES ('20211103A', 'Set Unique to User Token', '2025-05-13 13:23:15.93547+00');
INSERT INTO public.directus_migrations VALUES ('20211103B', 'Update Special Geometry', '2025-05-13 13:23:16.103875+00');
INSERT INTO public.directus_migrations VALUES ('20211104A', 'Remove Collections Listing', '2025-05-13 13:23:16.278133+00');
INSERT INTO public.directus_migrations VALUES ('20211118A', 'Add Notifications', '2025-05-13 13:23:16.794994+00');
INSERT INTO public.directus_migrations VALUES ('20211211A', 'Add Shares', '2025-05-13 13:23:17.614141+00');
INSERT INTO public.directus_migrations VALUES ('20211230A', 'Add Project Descriptor', '2025-05-13 13:23:17.812334+00');
INSERT INTO public.directus_migrations VALUES ('20220303A', 'Remove Default Project Color', '2025-05-13 13:23:18.230715+00');
INSERT INTO public.directus_migrations VALUES ('20220308A', 'Add Bookmark Icon and Color', '2025-05-13 13:23:18.399805+00');
INSERT INTO public.directus_migrations VALUES ('20220314A', 'Add Translation Strings', '2025-05-13 13:23:18.567333+00');
INSERT INTO public.directus_migrations VALUES ('20220322A', 'Rename Field Typecast Flags', '2025-05-13 13:23:18.737522+00');
INSERT INTO public.directus_migrations VALUES ('20220323A', 'Add Field Validation', '2025-05-13 13:23:18.912481+00');
INSERT INTO public.directus_migrations VALUES ('20220325A', 'Fix Typecast Flags', '2025-05-13 13:23:19.083804+00');
INSERT INTO public.directus_migrations VALUES ('20220325B', 'Add Default Language', '2025-05-13 13:23:19.58925+00');
INSERT INTO public.directus_migrations VALUES ('20220402A', 'Remove Default Value Panel Icon', '2025-05-13 13:23:20.011272+00');
INSERT INTO public.directus_migrations VALUES ('20220429A', 'Add Flows', '2025-05-13 13:23:21.055987+00');
INSERT INTO public.directus_migrations VALUES ('20220429B', 'Add Color to Insights Icon', '2025-05-13 13:23:21.227681+00');
INSERT INTO public.directus_migrations VALUES ('20220429C', 'Drop Non Null From IP of Activity', '2025-05-13 13:23:21.393667+00');
INSERT INTO public.directus_migrations VALUES ('20220429D', 'Drop Non Null From Sender of Notifications', '2025-05-13 13:23:21.55896+00');
INSERT INTO public.directus_migrations VALUES ('20220614A', 'Rename Hook Trigger to Event', '2025-05-13 13:23:21.7229+00');
INSERT INTO public.directus_migrations VALUES ('20220801A', 'Update Notifications Timestamp Column', '2025-05-13 13:23:22.140625+00');
INSERT INTO public.directus_migrations VALUES ('20220802A', 'Add Custom Aspect Ratios', '2025-05-13 13:23:22.307561+00');
INSERT INTO public.directus_migrations VALUES ('20220826A', 'Add Origin to Accountability', '2025-05-13 13:23:22.567627+00');
INSERT INTO public.directus_migrations VALUES ('20230401A', 'Update Material Icons', '2025-05-13 13:23:23.076533+00');
INSERT INTO public.directus_migrations VALUES ('20230525A', 'Add Preview Settings', '2025-05-13 13:23:23.244113+00');
INSERT INTO public.directus_migrations VALUES ('20230526A', 'Migrate Translation Strings', '2025-05-13 13:23:23.592715+00');
INSERT INTO public.directus_migrations VALUES ('20230721A', 'Require Shares Fields', '2025-05-13 13:23:23.85333+00');
INSERT INTO public.directus_migrations VALUES ('20230823A', 'Add Content Versioning', '2025-05-13 13:23:24.607654+00');
INSERT INTO public.directus_migrations VALUES ('20230927A', 'Themes', '2025-05-13 13:23:25.876757+00');
INSERT INTO public.directus_migrations VALUES ('20231009A', 'Update CSV Fields to Text', '2025-05-13 13:23:26.058475+00');
INSERT INTO public.directus_migrations VALUES ('20231009B', 'Update Panel Options', '2025-05-13 13:23:26.228048+00');
INSERT INTO public.directus_migrations VALUES ('20231010A', 'Add Extensions', '2025-05-13 13:23:26.419288+00');
INSERT INTO public.directus_migrations VALUES ('20231215A', 'Add Focalpoints', '2025-05-13 13:23:26.683292+00');
INSERT INTO public.directus_migrations VALUES ('20240122A', 'Add Report URL Fields', '2025-05-13 13:23:26.91234+00');
INSERT INTO public.directus_migrations VALUES ('20240204A', 'Marketplace', '2025-05-13 13:23:29.235889+00');
INSERT INTO public.directus_migrations VALUES ('20240305A', 'Change Useragent Type', '2025-05-13 13:23:29.885985+00');
INSERT INTO public.directus_migrations VALUES ('20240311A', 'Deprecate Webhooks', '2025-05-13 13:23:30.648476+00');
INSERT INTO public.directus_migrations VALUES ('20240422A', 'Public Registration', '2025-05-13 13:23:30.975164+00');
INSERT INTO public.directus_migrations VALUES ('20240515A', 'Add Session Window', '2025-05-13 13:23:31.155684+00');
INSERT INTO public.directus_migrations VALUES ('20240701A', 'Add Tus Data', '2025-05-13 13:23:31.340913+00');
INSERT INTO public.directus_migrations VALUES ('20240716A', 'Update Files Date Fields', '2025-05-13 13:23:31.680692+00');
INSERT INTO public.directus_migrations VALUES ('20240806A', 'Permissions Policies', '2025-05-13 13:23:33.809505+00');
INSERT INTO public.directus_migrations VALUES ('20240817A', 'Update Icon Fields Length', '2025-05-13 13:23:35.882276+00');
INSERT INTO public.directus_migrations VALUES ('20240909A', 'Separate Comments', '2025-05-13 13:23:36.227492+00');
INSERT INTO public.directus_migrations VALUES ('20240909B', 'Consolidate Content Versioning', '2025-05-13 13:23:36.413132+00');
INSERT INTO public.directus_migrations VALUES ('20240924A', 'Migrate Legacy Comments', '2025-05-13 13:23:36.755151+00');
INSERT INTO public.directus_migrations VALUES ('20240924B', 'Populate Versioning Deltas', '2025-05-13 13:23:36.931329+00');
INSERT INTO public.directus_migrations VALUES ('20250224A', 'Visual Editor', '2025-05-13 13:23:37.190922+00');


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
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_policies VALUES ('abf8a154-5b1c-4a46-ac9c-7300570f4f17', '$t:public_label', 'public', '$t:public_description', NULL, false, false, false);
INSERT INTO public.directus_policies VALUES ('d76e247c-64e6-47d2-9269-ff2329e4a393', 'Administrator', 'verified', '$t:admin_description', NULL, false, true, true);


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: app_mov
--



--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: app_mov
--

INSERT INTO public.directus_roles VALUES ('5115c454-fe0e-4805-9ef9-ef6c5d9767f1', 'Administrator', 'verified', '$t:admin_description', NULL);
INSERT INTO public.directus_roles VALUES ('11111111-1111-1111-1111-111111111111', 'Comprador', 'supervised_user_circle', 'Usuario con permisos para comprar productos', NULL);
INSERT INTO public.directus_roles VALUES ('22222222-2222-2222-2222-222222222222', 'Emprendedor', 'supervised_user_circle', 'Usuario con permisos para vender productos', NULL);


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: app_mov
--



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

INSERT INTO public.directus_users VALUES ('65073795-0bd3-48b9-a092-58ffa8de9ce0', 'Admin', 'User', 'uniadmin@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$A05Jjl87wjxBAdhxmX+pZA$HbBVy14c7JF6O1aQgtWx1aO+32yhHNqNFk5tyMm1E5Y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '5115c454-fe0e-4805-9ef9-ef6c5d9767f1', NULL, NULL, NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.directus_users VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Carlos Comprador', NULL, 'carlos@tienda.com', '$argon2i$v=19$m=16,t=2,p=1$Qk4zb1RuWDJCcVRpb2JoSw$SzyC3tGEP6swGBt0TvBkiw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '11111111-1111-1111-1111-111111111111', NULL, NULL, NULL, 'default', NULL, NULL, true, NULL, NULL, NULL, NULL, NULL);


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

SELECT pg_catalog.setval('public.directus_activity_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.directus_presets_id_seq', 1, false);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 1, false);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app_mov
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 1, false);


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

