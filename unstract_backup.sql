--
-- PostgreSQL database dump
--

\restrict GxduvG7mMorzP83Kfd17Lef9o0B9bluh7LlYonzCZSM8uFqHXLugNE1b3rrZoxW

-- Dumped from database version 15.14 (Debian 15.14-1.pgdg12+1)
-- Dumped by pg_dump version 15.14 (Debian 15.14-1.pgdg12+1)

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
-- Name: unstract; Type: SCHEMA; Schema: -; Owner: unstract_dev
--

CREATE SCHEMA unstract;


ALTER SCHEMA unstract OWNER TO unstract_dev;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: authentications; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.authentications (
    id character varying(255) NOT NULL,
    hashed_client_token character varying(255) NOT NULL,
    method integer DEFAULT 0 NOT NULL,
    metadata text,
    expires_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.authentications OWNER TO unstract_dev;

--
-- Name: celery_taskmeta; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.celery_taskmeta (
    id integer NOT NULL,
    task_id character varying(155),
    status character varying(50),
    result bytea,
    date_done timestamp without time zone,
    traceback text,
    name character varying(155),
    args bytea,
    kwargs bytea,
    worker character varying(155),
    retries integer,
    queue character varying(155)
);


ALTER TABLE public.celery_taskmeta OWNER TO unstract_dev;

--
-- Name: celery_tasksetmeta; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.celery_tasksetmeta (
    id integer NOT NULL,
    taskset_id character varying(155),
    result bytea,
    date_done timestamp without time zone
);


ALTER TABLE public.celery_tasksetmeta OWNER TO unstract_dev;

--
-- Name: constraints; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.constraints (
    id character varying(255) NOT NULL,
    segment_key character varying(255) NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    property character varying(255) NOT NULL,
    operator character varying(255) NOT NULL,
    value text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    namespace_key character varying(255) DEFAULT 'default'::character varying NOT NULL,
    description text
);


ALTER TABLE public.constraints OWNER TO unstract_dev;

--
-- Name: distributions; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.distributions (
    id character varying(255) NOT NULL,
    rule_id character varying(255) NOT NULL,
    variant_id character varying(255) NOT NULL,
    rollout double precision DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.distributions OWNER TO unstract_dev;

--
-- Name: flags; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.flags (
    key character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    namespace_key character varying(255) DEFAULT 'default'::character varying NOT NULL,
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.flags OWNER TO unstract_dev;

--
-- Name: namespaces; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.namespaces (
    key character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    protected boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.namespaces OWNER TO unstract_dev;

--
-- Name: operation_lock; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.operation_lock (
    operation character varying(255) NOT NULL,
    version integer DEFAULT 0 NOT NULL,
    last_acquired_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    acquired_until timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.operation_lock OWNER TO unstract_dev;

--
-- Name: rollout_segment_references; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.rollout_segment_references (
    rollout_segment_id character varying(255) NOT NULL,
    namespace_key character varying(255) NOT NULL,
    segment_key character varying(255) NOT NULL
);


ALTER TABLE public.rollout_segment_references OWNER TO unstract_dev;

--
-- Name: rollout_segments; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.rollout_segments (
    id character varying(255) NOT NULL,
    rollout_id character varying(255) NOT NULL,
    value boolean DEFAULT false NOT NULL,
    segment_operator integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.rollout_segments OWNER TO unstract_dev;

--
-- Name: rollout_thresholds; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.rollout_thresholds (
    id character varying(255) NOT NULL,
    namespace_key character varying(255) NOT NULL,
    rollout_id character varying(255) NOT NULL,
    percentage double precision DEFAULT 0 NOT NULL,
    value boolean DEFAULT false NOT NULL
);


ALTER TABLE public.rollout_thresholds OWNER TO unstract_dev;

--
-- Name: rollouts; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.rollouts (
    id character varying(255) NOT NULL,
    namespace_key character varying(255) NOT NULL,
    flag_key character varying(255) NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    description text NOT NULL,
    rank integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.rollouts OWNER TO unstract_dev;

--
-- Name: rule_segments; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.rule_segments (
    rule_id character varying(255) NOT NULL,
    namespace_key character varying(255) NOT NULL,
    segment_key character varying(255) NOT NULL
);


ALTER TABLE public.rule_segments OWNER TO unstract_dev;

--
-- Name: rules; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.rules (
    id character varying(255) NOT NULL,
    flag_key character varying(255) NOT NULL,
    rank integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    namespace_key character varying(255) DEFAULT 'default'::character varying NOT NULL,
    segment_operator integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.rules OWNER TO unstract_dev;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    dirty boolean NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO unstract_dev;

--
-- Name: segments; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.segments (
    key character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    match_type integer DEFAULT 0 NOT NULL,
    namespace_key character varying(255) DEFAULT 'default'::character varying NOT NULL
);


ALTER TABLE public.segments OWNER TO unstract_dev;

--
-- Name: task_id_sequence; Type: SEQUENCE; Schema: public; Owner: unstract_dev
--

CREATE SEQUENCE public.task_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_id_sequence OWNER TO unstract_dev;

--
-- Name: taskset_id_sequence; Type: SEQUENCE; Schema: public; Owner: unstract_dev
--

CREATE SEQUENCE public.taskset_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taskset_id_sequence OWNER TO unstract_dev;

--
-- Name: variants; Type: TABLE; Schema: public; Owner: unstract_dev
--

CREATE TABLE public.variants (
    id character varying(255) NOT NULL,
    flag_key character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    attachment jsonb,
    namespace_key character varying(255) DEFAULT 'default'::character varying NOT NULL
);


ALTER TABLE public.variants OWNER TO unstract_dev;

--
-- Name: adapter_instance; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.adapter_instance (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    adapter_name text NOT NULL,
    adapter_id character varying(128) NOT NULL,
    adapter_metadata jsonb NOT NULL,
    adapter_metadata_b bytea,
    adapter_type character varying NOT NULL,
    is_active boolean NOT NULL,
    shared_to_org boolean NOT NULL,
    is_friction_less boolean NOT NULL,
    is_usable boolean NOT NULL,
    description text,
    created_by_id bigint,
    modified_by_id bigint,
    organization_id bigint
);


ALTER TABLE unstract.adapter_instance OWNER TO unstract_dev;

--
-- Name: COLUMN adapter_instance.id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.adapter_instance.id IS 'Unique identifier for the Adapter Instance';


--
-- Name: COLUMN adapter_instance.adapter_name; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.adapter_instance.adapter_name IS 'Name of the Adapter Instance';


--
-- Name: COLUMN adapter_instance.adapter_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.adapter_instance.adapter_id IS 'Unique identifier of the Adapter';


--
-- Name: COLUMN adapter_instance.adapter_metadata; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.adapter_instance.adapter_metadata IS 'JSON adapter metadata submitted by the user';


--
-- Name: COLUMN adapter_instance.adapter_type; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.adapter_instance.adapter_type IS 'Type of adapter LLM/EMBEDDING/VECTOR_DB';


--
-- Name: COLUMN adapter_instance.is_active; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.adapter_instance.is_active IS 'Is the adapter instance currently being used';


--
-- Name: COLUMN adapter_instance.shared_to_org; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.adapter_instance.shared_to_org IS 'Is the adapter shared to entire org';


--
-- Name: COLUMN adapter_instance.is_friction_less; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.adapter_instance.is_friction_less IS 'Was the adapter created through frictionless onboarding';


--
-- Name: COLUMN adapter_instance.is_usable; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.adapter_instance.is_usable IS 'Is the Adpater Usable';


--
-- Name: COLUMN adapter_instance.organization_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.adapter_instance.organization_id IS 'Foreign key reference to the Organization model.';


--
-- Name: adapter_instance_shared_users; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.adapter_instance_shared_users (
    id bigint NOT NULL,
    adapterinstance_id uuid NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE unstract.adapter_instance_shared_users OWNER TO unstract_dev;

--
-- Name: adapter_instance_shared_users_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.adapter_instance_shared_users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.adapter_instance_shared_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_deployment; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.api_deployment (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    display_name character varying(30) NOT NULL,
    description character varying(255) NOT NULL,
    is_active boolean NOT NULL,
    api_endpoint character varying(255) NOT NULL,
    api_name character varying(30) NOT NULL,
    created_by_id bigint,
    modified_by_id bigint,
    organization_id bigint,
    workflow_id uuid NOT NULL,
    shared_to_org boolean NOT NULL
);


ALTER TABLE unstract.api_deployment OWNER TO unstract_dev;

--
-- Name: COLUMN api_deployment.display_name; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.api_deployment.display_name IS 'User-given display name for the API.';


--
-- Name: COLUMN api_deployment.description; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.api_deployment.description IS 'User-given description for the API.';


--
-- Name: COLUMN api_deployment.is_active; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.api_deployment.is_active IS 'Flag indicating whether the API is active or not.';


--
-- Name: COLUMN api_deployment.api_endpoint; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.api_deployment.api_endpoint IS 'URL endpoint for the API deployment.';


--
-- Name: COLUMN api_deployment.api_name; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.api_deployment.api_name IS 'Short name for the API deployment.';


--
-- Name: COLUMN api_deployment.organization_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.api_deployment.organization_id IS 'Foreign key reference to the Organization model.';


--
-- Name: COLUMN api_deployment.workflow_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.api_deployment.workflow_id IS 'Foreign key reference to the Workflow model.';


--
-- Name: COLUMN api_deployment.shared_to_org; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.api_deployment.shared_to_org IS 'Whether this API deployment is shared with the entire organization';


--
-- Name: api_deployment_key; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.api_deployment_key (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    api_key uuid NOT NULL,
    description character varying(255),
    is_active boolean NOT NULL,
    api_id uuid,
    created_by_id bigint,
    modified_by_id bigint,
    pipeline_id uuid
);


ALTER TABLE unstract.api_deployment_key OWNER TO unstract_dev;

--
-- Name: COLUMN api_deployment_key.id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.api_deployment_key.id IS 'Unique identifier for the API key.';


--
-- Name: COLUMN api_deployment_key.api_key; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.api_deployment_key.api_key IS 'Actual key UUID.';


--
-- Name: COLUMN api_deployment_key.description; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.api_deployment_key.description IS 'Description of the API key.';


--
-- Name: COLUMN api_deployment_key.is_active; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.api_deployment_key.is_active IS 'Flag indicating whether the API key is active or not.';


--
-- Name: COLUMN api_deployment_key.api_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.api_deployment_key.api_id IS 'Foreign key reference to the APIDeployment model.';


--
-- Name: COLUMN api_deployment_key.pipeline_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.api_deployment_key.pipeline_id IS 'Foreign key reference to the Pipeline model.';


--
-- Name: api_deployment_shared_users; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.api_deployment_shared_users (
    id bigint NOT NULL,
    apideployment_id uuid NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE unstract.api_deployment_shared_users OWNER TO unstract_dev;

--
-- Name: api_deployment_shared_users_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.api_deployment_shared_users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.api_deployment_shared_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE unstract.auth_group OWNER TO unstract_dev;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE unstract.auth_group_permissions OWNER TO unstract_dev;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE unstract.auth_permission OWNER TO unstract_dev;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: configuration; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.configuration (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    key character varying(100) NOT NULL,
    value text NOT NULL,
    enabled boolean NOT NULL,
    organization_id bigint NOT NULL
);


ALTER TABLE unstract.configuration OWNER TO unstract_dev;

--
-- Name: connector_auth; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.connector_auth (
    provider character varying(32) NOT NULL,
    uid character varying(255) NOT NULL,
    extra_data jsonb NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    user_id bigint
);


ALTER TABLE unstract.connector_auth OWNER TO unstract_dev;

--
-- Name: connector_instance; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.connector_instance (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    connector_name text NOT NULL,
    connector_id character varying(128) NOT NULL,
    connector_metadata bytea,
    connector_version character varying(64) NOT NULL,
    connector_mode character varying,
    connector_auth_id uuid,
    created_by_id bigint,
    modified_by_id bigint,
    organization_id bigint,
    shared_to_org boolean NOT NULL
);


ALTER TABLE unstract.connector_instance OWNER TO unstract_dev;

--
-- Name: COLUMN connector_instance.connector_mode; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.connector_instance.connector_mode IS '0: UNKNOWN, 1: FILE_SYSTEM, 2: DATABASE';


--
-- Name: COLUMN connector_instance.organization_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.connector_instance.organization_id IS 'Foreign key reference to the Organization model.';


--
-- Name: COLUMN connector_instance.shared_to_org; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.connector_instance.shared_to_org IS 'Is the connector shared to entire org';


--
-- Name: connector_instance_shared_users; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.connector_instance_shared_users (
    id bigint NOT NULL,
    connectorinstance_id uuid NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE unstract.connector_instance_shared_users OWNER TO unstract_dev;

--
-- Name: connector_instance_shared_users_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.connector_instance_shared_users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.connector_instance_shared_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: custom_tool; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.custom_tool (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    tool_id uuid NOT NULL,
    tool_name text NOT NULL,
    description text NOT NULL,
    author text NOT NULL,
    icon text NOT NULL,
    output text NOT NULL,
    log_id uuid NOT NULL,
    summarize_context boolean NOT NULL,
    summarize_as_source boolean NOT NULL,
    summarize_prompt text NOT NULL,
    preamble text NOT NULL,
    postamble text NOT NULL,
    prompt_grammer jsonb,
    exclude_failed boolean NOT NULL,
    single_pass_extraction_mode boolean NOT NULL,
    enable_challenge boolean NOT NULL,
    enable_highlight boolean NOT NULL,
    challenge_llm_id uuid,
    created_by_id bigint,
    modified_by_id bigint,
    monitor_llm_id uuid,
    organization_id bigint,
    summarize_llm_adapter_id uuid,
    shared_to_org boolean NOT NULL
);


ALTER TABLE unstract.custom_tool OWNER TO unstract_dev;

--
-- Name: COLUMN custom_tool.author; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.author IS 'Specific to the user who created the tool.';


--
-- Name: COLUMN custom_tool.icon; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.icon IS 'Field to store             icon url for the custom tool.';


--
-- Name: COLUMN custom_tool.output; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.output IS 'Field to store the output format type.';


--
-- Name: COLUMN custom_tool.log_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.log_id IS 'Field to store unique log_id for polling';


--
-- Name: COLUMN custom_tool.summarize_context; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.summarize_context IS 'Flag to summarize content';


--
-- Name: COLUMN custom_tool.summarize_as_source; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.summarize_as_source IS 'Flag to use summarized content as source';


--
-- Name: COLUMN custom_tool.summarize_prompt; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.summarize_prompt IS 'Field to store the summarize prompt';


--
-- Name: COLUMN custom_tool.preamble; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.preamble IS 'Preamble to the prompts';


--
-- Name: COLUMN custom_tool.postamble; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.postamble IS 'Appended as postable to prompts.';


--
-- Name: COLUMN custom_tool.prompt_grammer; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.prompt_grammer IS 'Synonymous words used in prompt';


--
-- Name: COLUMN custom_tool.exclude_failed; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.exclude_failed IS 'Flag to make the answer null if it is incorrect';


--
-- Name: COLUMN custom_tool.single_pass_extraction_mode; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.single_pass_extraction_mode IS 'Flag to enable or disable single pass extraction mode';


--
-- Name: COLUMN custom_tool.enable_challenge; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.enable_challenge IS 'Flag to enable or disable challenge';


--
-- Name: COLUMN custom_tool.enable_highlight; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.enable_highlight IS 'Flag to enable or disable document highlighting';


--
-- Name: COLUMN custom_tool.challenge_llm_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.challenge_llm_id IS 'Field to store challenge llm';


--
-- Name: COLUMN custom_tool.monitor_llm_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.monitor_llm_id IS 'Field to store monitor llm';


--
-- Name: COLUMN custom_tool.organization_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.organization_id IS 'Foreign key reference to the Organization model.';


--
-- Name: COLUMN custom_tool.summarize_llm_adapter_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.summarize_llm_adapter_id IS 'Field to store the LLM adapter for summarization';


--
-- Name: COLUMN custom_tool.shared_to_org; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.custom_tool.shared_to_org IS 'Flag to share this custom tool with all users in the organization';


--
-- Name: custom_tool_shared_users; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.custom_tool_shared_users (
    id bigint NOT NULL,
    customtool_id uuid NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE unstract.custom_tool_shared_users OWNER TO unstract_dev;

--
-- Name: custom_tool_shared_users_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.custom_tool_shared_users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.custom_tool_shared_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: default_organization_user_adapter; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.default_organization_user_adapter (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    default_embedding_adapter_id uuid,
    default_llm_adapter_id uuid,
    default_vector_db_adapter_id uuid,
    default_x2text_adapter_id uuid,
    organization_member_id bigint
);


ALTER TABLE unstract.default_organization_user_adapter OWNER TO unstract_dev;

--
-- Name: COLUMN default_organization_user_adapter.organization_member_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.default_organization_user_adapter.organization_member_id IS 'Foreign key reference to the OrganizationMember model.';


--
-- Name: default_organization_user_adapter_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.default_organization_user_adapter ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.default_organization_user_adapter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE unstract.django_admin_log OWNER TO unstract_dev;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_celery_beat_clockedschedule; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.django_celery_beat_clockedschedule (
    id integer NOT NULL,
    clocked_time timestamp with time zone NOT NULL
);


ALTER TABLE unstract.django_celery_beat_clockedschedule OWNER TO unstract_dev;

--
-- Name: django_celery_beat_clockedschedule_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.django_celery_beat_clockedschedule ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.django_celery_beat_clockedschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_celery_beat_crontabschedule; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.django_celery_beat_crontabschedule (
    id integer NOT NULL,
    minute character varying(240) NOT NULL,
    hour character varying(96) NOT NULL,
    day_of_week character varying(64) NOT NULL,
    day_of_month character varying(124) NOT NULL,
    month_of_year character varying(64) NOT NULL,
    timezone character varying(63) NOT NULL
);


ALTER TABLE unstract.django_celery_beat_crontabschedule OWNER TO unstract_dev;

--
-- Name: django_celery_beat_crontabschedule_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.django_celery_beat_crontabschedule ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.django_celery_beat_crontabschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_celery_beat_intervalschedule; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.django_celery_beat_intervalschedule (
    id integer NOT NULL,
    every integer NOT NULL,
    period character varying(24) NOT NULL
);


ALTER TABLE unstract.django_celery_beat_intervalschedule OWNER TO unstract_dev;

--
-- Name: django_celery_beat_intervalschedule_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.django_celery_beat_intervalschedule ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.django_celery_beat_intervalschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_celery_beat_periodictask; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.django_celery_beat_periodictask (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    task character varying(200) NOT NULL,
    args text NOT NULL,
    kwargs text NOT NULL,
    queue character varying(200),
    exchange character varying(200),
    routing_key character varying(200),
    expires timestamp with time zone,
    enabled boolean NOT NULL,
    last_run_at timestamp with time zone,
    total_run_count integer NOT NULL,
    date_changed timestamp with time zone NOT NULL,
    description text NOT NULL,
    crontab_id integer,
    interval_id integer,
    solar_id integer,
    one_off boolean NOT NULL,
    start_time timestamp with time zone,
    priority integer,
    headers text NOT NULL,
    clocked_id integer,
    expire_seconds integer,
    CONSTRAINT django_celery_beat_periodictask_expire_seconds_check CHECK ((expire_seconds >= 0)),
    CONSTRAINT django_celery_beat_periodictask_priority_check CHECK ((priority >= 0)),
    CONSTRAINT django_celery_beat_periodictask_total_run_count_check CHECK ((total_run_count >= 0))
);


ALTER TABLE unstract.django_celery_beat_periodictask OWNER TO unstract_dev;

--
-- Name: django_celery_beat_periodictask_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.django_celery_beat_periodictask ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.django_celery_beat_periodictask_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_celery_beat_periodictasks; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.django_celery_beat_periodictasks (
    ident smallint NOT NULL,
    last_update timestamp with time zone NOT NULL
);


ALTER TABLE unstract.django_celery_beat_periodictasks OWNER TO unstract_dev;

--
-- Name: django_celery_beat_solarschedule; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.django_celery_beat_solarschedule (
    id integer NOT NULL,
    event character varying(24) NOT NULL,
    latitude numeric(9,6) NOT NULL,
    longitude numeric(9,6) NOT NULL
);


ALTER TABLE unstract.django_celery_beat_solarschedule OWNER TO unstract_dev;

--
-- Name: django_celery_beat_solarschedule_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.django_celery_beat_solarschedule ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.django_celery_beat_solarschedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE unstract.django_content_type OWNER TO unstract_dev;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE unstract.django_migrations OWNER TO unstract_dev;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE unstract.django_session OWNER TO unstract_dev;

--
-- Name: document_manager; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.document_manager (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    document_id uuid NOT NULL,
    document_name character varying NOT NULL,
    created_by_id bigint,
    modified_by_id bigint,
    tool_id uuid NOT NULL
);


ALTER TABLE unstract.document_manager OWNER TO unstract_dev;

--
-- Name: COLUMN document_manager.document_name; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.document_manager.document_name IS 'Field to store the document name';


--
-- Name: execution_log; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.execution_log (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    execution_id uuid,
    data jsonb NOT NULL,
    event_time timestamp with time zone NOT NULL,
    file_execution_id uuid,
    wf_execution_id uuid
);


ALTER TABLE unstract.execution_log OWNER TO unstract_dev;

--
-- Name: COLUMN execution_log.execution_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.execution_log.execution_id IS 'Execution ID (deprecated, refer wf_execution instead)';


--
-- Name: COLUMN execution_log.data; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.execution_log.data IS 'Execution log data';


--
-- Name: COLUMN execution_log.event_time; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.execution_log.event_time IS 'Execution log event time';


--
-- Name: COLUMN execution_log.file_execution_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.execution_log.file_execution_id IS 'Foreign key from WorkflowFileExecution model';


--
-- Name: COLUMN execution_log.wf_execution_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.execution_log.wf_execution_id IS 'Foreign key from WorkflowExecution model';


--
-- Name: file_history; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.file_history (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    cache_key character varying(64) NOT NULL,
    status text NOT NULL,
    error text NOT NULL,
    result text NOT NULL,
    metadata text NOT NULL,
    workflow_id uuid NOT NULL,
    provider_file_uuid character varying(64),
    file_path character varying(1000)
);


ALTER TABLE unstract.file_history OWNER TO unstract_dev;

--
-- Name: COLUMN file_history.cache_key; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.file_history.cache_key IS 'Hash value of file contents, WF and tool modified times';


--
-- Name: COLUMN file_history.status; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.file_history.status IS 'Latest status of execution';


--
-- Name: COLUMN file_history.error; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.file_history.error IS 'Error message';


--
-- Name: COLUMN file_history.result; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.file_history.result IS 'Result from execution';


--
-- Name: COLUMN file_history.metadata; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.file_history.metadata IS 'MetaData from execution';


--
-- Name: COLUMN file_history.provider_file_uuid; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.file_history.provider_file_uuid IS 'Unique identifier assigned by the file storage provider';


--
-- Name: COLUMN file_history.file_path; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.file_history.file_path IS 'Full Path of the file';


--
-- Name: index_manager; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.index_manager (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    index_manager_id uuid NOT NULL,
    raw_index_id character varying,
    summarize_index_id character varying,
    index_ids_history jsonb NOT NULL,
    created_by_id bigint,
    document_manager_id uuid NOT NULL,
    modified_by_id bigint,
    profile_manager_id uuid,
    extraction_status jsonb NOT NULL
);


ALTER TABLE unstract.index_manager OWNER TO unstract_dev;

--
-- Name: COLUMN index_manager.raw_index_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.index_manager.raw_index_id IS 'Field to store the raw index id';


--
-- Name: COLUMN index_manager.summarize_index_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.index_manager.summarize_index_id IS 'Field to store the summarize index id';


--
-- Name: COLUMN index_manager.index_ids_history; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.index_manager.index_ids_history IS 'List of index ids';


--
-- Name: COLUMN index_manager.extraction_status; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.index_manager.extraction_status IS 'Extraction status for documents';


--
-- Name: notification; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.notification (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    url character varying(200),
    authorization_key character varying(255),
    authorization_header character varying(255),
    authorization_type character varying(50) NOT NULL,
    max_retries integer NOT NULL,
    platform character varying(50),
    notification_type character varying(50) NOT NULL,
    is_active boolean NOT NULL,
    api_id uuid,
    pipeline_id uuid
);


ALTER TABLE unstract.notification OWNER TO unstract_dev;

--
-- Name: COLUMN notification.name; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.notification.name IS 'Name of the notification.';


--
-- Name: COLUMN notification.is_active; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.notification.is_active IS 'Flag indicating whether the notification is active or not.';


--
-- Name: organization; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.organization (
    id bigint NOT NULL,
    name character varying(64) NOT NULL,
    display_name character varying(64) NOT NULL,
    organization_id character varying(64) NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone NOT NULL,
    allowed_token_limit integer NOT NULL,
    created_by_id bigint,
    modified_by_id bigint
);


ALTER TABLE unstract.organization OWNER TO unstract_dev;

--
-- Name: COLUMN organization.allowed_token_limit; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.organization.allowed_token_limit IS 'token limit set in case of frition less onbaoarded org';


--
-- Name: organization_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.organization ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: organization_member; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.organization_member (
    member_id bigint NOT NULL,
    role character varying NOT NULL,
    is_login_onboarding_msg boolean NOT NULL,
    is_prompt_studio_onboarding_msg boolean NOT NULL,
    organization_id bigint,
    user_id bigint NOT NULL
);


ALTER TABLE unstract.organization_member OWNER TO unstract_dev;

--
-- Name: COLUMN organization_member.is_login_onboarding_msg; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.organization_member.is_login_onboarding_msg IS 'Flag to indicate whether the onboarding messages are shown';


--
-- Name: COLUMN organization_member.is_prompt_studio_onboarding_msg; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.organization_member.is_prompt_studio_onboarding_msg IS 'Flag to indicate whether the prompt studio messages are shown';


--
-- Name: COLUMN organization_member.organization_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.organization_member.organization_id IS 'Foreign key reference to the Organization model.';


--
-- Name: organization_member_member_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.organization_member ALTER COLUMN member_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.organization_member_member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: page_usage; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.page_usage (
    id uuid NOT NULL,
    organization_id character varying NOT NULL,
    file_name character varying(255) NOT NULL,
    file_type character varying(128) NOT NULL,
    run_id character varying(255) NOT NULL,
    pages_processed integer NOT NULL,
    file_size bigint NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE unstract.page_usage OWNER TO unstract_dev;

--
-- Name: COLUMN page_usage.id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.page_usage.id IS 'Primary key for the usage entry, automatically generated UUID';


--
-- Name: COLUMN page_usage.file_name; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.page_usage.file_name IS 'Name of the file';


--
-- Name: COLUMN page_usage.file_type; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.page_usage.file_type IS 'Mime type of file';


--
-- Name: COLUMN page_usage.run_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.page_usage.run_id IS 'Identifier for the run';


--
-- Name: COLUMN page_usage.pages_processed; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.page_usage.pages_processed IS 'Number of pages which got processed';


--
-- Name: COLUMN page_usage.file_size; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.page_usage.file_size IS 'Size of the the file';


--
-- Name: pipeline; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.pipeline (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    pipeline_name character varying(32) NOT NULL,
    app_id text,
    active boolean NOT NULL,
    scheduled boolean NOT NULL,
    cron_string text,
    pipeline_type character varying NOT NULL,
    run_count integer NOT NULL,
    last_run_time timestamp with time zone,
    last_run_status character varying NOT NULL,
    app_icon character varying(200),
    app_url character varying(200),
    access_control_bundle_id text,
    created_by_id bigint,
    modified_by_id bigint,
    organization_id bigint,
    workflow_id uuid NOT NULL,
    shared_to_org boolean NOT NULL
);


ALTER TABLE unstract.pipeline OWNER TO unstract_dev;

--
-- Name: COLUMN pipeline.active; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.pipeline.active IS 'Indicates whether the pipeline is active';


--
-- Name: COLUMN pipeline.scheduled; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.pipeline.scheduled IS 'Indicates whether the pipeline is scheduled';


--
-- Name: COLUMN pipeline.cron_string; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.pipeline.cron_string IS 'UNIX cron string';


--
-- Name: COLUMN pipeline.app_icon; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.pipeline.app_icon IS 'Field to store icon url for Apps';


--
-- Name: COLUMN pipeline.app_url; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.pipeline.app_url IS 'Stores deployed URL for App';


--
-- Name: COLUMN pipeline.organization_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.pipeline.organization_id IS 'Foreign key reference to the Organization model.';


--
-- Name: COLUMN pipeline.shared_to_org; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.pipeline.shared_to_org IS 'Whether this pipeline is shared with the entire organization';


--
-- Name: pipeline_shared_users; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.pipeline_shared_users (
    id bigint NOT NULL,
    pipeline_id uuid NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE unstract.pipeline_shared_users OWNER TO unstract_dev;

--
-- Name: pipeline_shared_users_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.pipeline_shared_users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.pipeline_shared_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: platform_key; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.platform_key (
    id uuid NOT NULL,
    key uuid NOT NULL,
    key_name character varying(64) NOT NULL,
    is_active boolean NOT NULL,
    created_by_id bigint,
    modified_by_id bigint,
    organization_id bigint
);


ALTER TABLE unstract.platform_key OWNER TO unstract_dev;

--
-- Name: profile_manager; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.profile_manager (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    profile_id uuid NOT NULL,
    profile_name text NOT NULL,
    chunk_size integer,
    chunk_overlap integer,
    reindex boolean NOT NULL,
    retrieval_strategy text NOT NULL,
    similarity_top_k integer,
    section text,
    is_default boolean NOT NULL,
    is_summarize_llm boolean NOT NULL,
    created_by_id bigint,
    embedding_model_id uuid NOT NULL,
    llm_id uuid NOT NULL,
    modified_by_id bigint,
    prompt_studio_tool_id uuid,
    vector_store_id uuid NOT NULL,
    x2text_id uuid NOT NULL
);


ALTER TABLE unstract.profile_manager OWNER TO unstract_dev;

--
-- Name: COLUMN profile_manager.retrieval_strategy; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.profile_manager.retrieval_strategy IS 'Field to store the retrieval strategy for prompts';


--
-- Name: COLUMN profile_manager.similarity_top_k; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.profile_manager.similarity_top_k IS 'Field to store number of top embeddings to take into context';


--
-- Name: COLUMN profile_manager.section; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.profile_manager.section IS 'Field to store limit to section';


--
-- Name: COLUMN profile_manager.is_default; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.profile_manager.is_default IS 'Default LLM Profile used in prompt';


--
-- Name: COLUMN profile_manager.is_summarize_llm; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.profile_manager.is_summarize_llm IS 'DEPRECATED: Default LLM Profile used for summarizing. Use CustomTool.summarize_llm_adapter instead.';


--
-- Name: COLUMN profile_manager.llm_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.profile_manager.llm_id IS 'Field to store the LLM chosen by the user';


--
-- Name: COLUMN profile_manager.vector_store_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.profile_manager.vector_store_id IS 'Field to store the chosen vector store.';


--
-- Name: COLUMN profile_manager.x2text_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.profile_manager.x2text_id IS 'Field to store the X2Text Adapter chosen by the user';


--
-- Name: prompt_studio_output_manager; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.prompt_studio_output_manager (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    prompt_output_id uuid NOT NULL,
    output character varying,
    context text,
    challenge_data jsonb,
    eval_metrics jsonb NOT NULL,
    is_single_pass_extract boolean NOT NULL,
    run_id uuid NOT NULL,
    created_by_id bigint,
    document_manager_id uuid NOT NULL,
    modified_by_id bigint,
    profile_manager_id uuid NOT NULL,
    prompt_id_id uuid NOT NULL,
    tool_id_id uuid NOT NULL,
    highlight_data jsonb,
    confidence_data jsonb
);


ALTER TABLE unstract.prompt_studio_output_manager OWNER TO unstract_dev;

--
-- Name: COLUMN prompt_studio_output_manager.output; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.prompt_studio_output_manager.output IS 'Field to store output';


--
-- Name: COLUMN prompt_studio_output_manager.context; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.prompt_studio_output_manager.context IS 'Field to store chunks used';


--
-- Name: COLUMN prompt_studio_output_manager.challenge_data; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.prompt_studio_output_manager.challenge_data IS 'Field to store challenge data';


--
-- Name: COLUMN prompt_studio_output_manager.eval_metrics; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.prompt_studio_output_manager.eval_metrics IS 'Field to store the evaluation metrics';


--
-- Name: COLUMN prompt_studio_output_manager.is_single_pass_extract; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.prompt_studio_output_manager.is_single_pass_extract IS 'Is the single pass extraction mode active';


--
-- Name: COLUMN prompt_studio_output_manager.highlight_data; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.prompt_studio_output_manager.highlight_data IS 'Field to store highlight data';


--
-- Name: COLUMN prompt_studio_output_manager.confidence_data; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.prompt_studio_output_manager.confidence_data IS 'Field to store confidence data';


--
-- Name: prompt_studio_registry; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.prompt_studio_registry (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    prompt_registry_id uuid NOT NULL,
    name character varying NOT NULL,
    description character varying NOT NULL,
    tool_property jsonb NOT NULL,
    tool_spec jsonb NOT NULL,
    tool_metadata jsonb NOT NULL,
    icon character varying NOT NULL,
    url character varying NOT NULL,
    shared_to_org boolean NOT NULL,
    created_by_id bigint,
    custom_tool_id uuid,
    modified_by_id bigint,
    organization_id bigint
);


ALTER TABLE unstract.prompt_studio_registry OWNER TO unstract_dev;

--
-- Name: COLUMN prompt_studio_registry.tool_property; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.prompt_studio_registry.tool_property IS 'PROPERTIES of the tool';


--
-- Name: COLUMN prompt_studio_registry.tool_spec; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.prompt_studio_registry.tool_spec IS 'SPEC of the tool';


--
-- Name: COLUMN prompt_studio_registry.tool_metadata; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.prompt_studio_registry.tool_metadata IS 'Metadata from Prompt Studio';


--
-- Name: COLUMN prompt_studio_registry.icon; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.prompt_studio_registry.icon IS 'Tool icon in svg format';


--
-- Name: COLUMN prompt_studio_registry.shared_to_org; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.prompt_studio_registry.shared_to_org IS 'Is the exported tool shared with entire org';


--
-- Name: COLUMN prompt_studio_registry.organization_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.prompt_studio_registry.organization_id IS 'Foreign key reference to the Organization model.';


--
-- Name: prompt_studio_registry_shared_users; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.prompt_studio_registry_shared_users (
    id bigint NOT NULL,
    promptstudioregistry_id uuid NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE unstract.prompt_studio_registry_shared_users OWNER TO unstract_dev;

--
-- Name: prompt_studio_registry_shared_users_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.prompt_studio_registry_shared_users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.prompt_studio_registry_shared_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: social_auth_association; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.social_auth_association (
    id bigint NOT NULL,
    server_url character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    issued integer NOT NULL,
    lifetime integer NOT NULL,
    assoc_type character varying(64) NOT NULL
);


ALTER TABLE unstract.social_auth_association OWNER TO unstract_dev;

--
-- Name: social_auth_association_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.social_auth_association ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.social_auth_association_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: social_auth_code; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.social_auth_code (
    id bigint NOT NULL,
    email character varying(254) NOT NULL,
    code character varying(32) NOT NULL,
    verified boolean NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE unstract.social_auth_code OWNER TO unstract_dev;

--
-- Name: social_auth_code_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.social_auth_code ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.social_auth_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: social_auth_nonce; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.social_auth_nonce (
    id bigint NOT NULL,
    server_url character varying(255) NOT NULL,
    "timestamp" integer NOT NULL,
    salt character varying(65) NOT NULL
);


ALTER TABLE unstract.social_auth_nonce OWNER TO unstract_dev;

--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.social_auth_nonce ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.social_auth_nonce_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: social_auth_partial; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.social_auth_partial (
    id bigint NOT NULL,
    token character varying(32) NOT NULL,
    next_step smallint NOT NULL,
    backend character varying(32) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    data jsonb NOT NULL,
    CONSTRAINT social_auth_partial_next_step_check CHECK ((next_step >= 0))
);


ALTER TABLE unstract.social_auth_partial OWNER TO unstract_dev;

--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.social_auth_partial ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.social_auth_partial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: social_auth_usersocialauth; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.social_auth_usersocialauth (
    id bigint NOT NULL,
    provider character varying(32) NOT NULL,
    uid character varying(255) NOT NULL,
    user_id bigint NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    extra_data jsonb NOT NULL
);


ALTER TABLE unstract.social_auth_usersocialauth OWNER TO unstract_dev;

--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.social_auth_usersocialauth ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.social_auth_usersocialauth_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tag; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.tag (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    organization_id bigint
);


ALTER TABLE unstract.tag OWNER TO unstract_dev;

--
-- Name: COLUMN tag.name; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tag.name IS 'Unique name of the tag';


--
-- Name: COLUMN tag.description; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tag.description IS 'Description of the tag';


--
-- Name: COLUMN tag.organization_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tag.organization_id IS 'Foreign key reference to the Organization model.';


--
-- Name: tool_instance; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.tool_instance (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    tool_id character varying(64) NOT NULL,
    input jsonb,
    output jsonb,
    version character varying(16) NOT NULL,
    metadata jsonb NOT NULL,
    step integer NOT NULL,
    status character varying(32) NOT NULL,
    created_by_id bigint,
    modified_by_id bigint,
    workflow_id uuid NOT NULL
);


ALTER TABLE unstract.tool_instance OWNER TO unstract_dev;

--
-- Name: COLUMN tool_instance.tool_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tool_instance.tool_id IS 'Function name of the tool being used';


--
-- Name: COLUMN tool_instance.input; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tool_instance.input IS 'Provisional WF input to a tool';


--
-- Name: COLUMN tool_instance.output; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tool_instance.output IS 'Provisional WF output to a tool';


--
-- Name: COLUMN tool_instance.metadata; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tool_instance.metadata IS 'Stores config for a tool';


--
-- Name: tool_studio_prompt; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.tool_studio_prompt (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    prompt_id uuid NOT NULL,
    prompt_key text NOT NULL,
    enforce_type text NOT NULL,
    prompt text NOT NULL,
    sequence_number integer,
    prompt_type text NOT NULL,
    output text NOT NULL,
    assert_prompt text,
    assertion_failure_prompt text,
    is_assert boolean NOT NULL,
    active boolean NOT NULL,
    output_metadata jsonb NOT NULL,
    evaluate boolean NOT NULL,
    eval_quality_faithfulness boolean NOT NULL,
    eval_quality_correctness boolean NOT NULL,
    eval_quality_relevance boolean NOT NULL,
    eval_security_pii boolean NOT NULL,
    eval_guidance_toxicity boolean NOT NULL,
    eval_guidance_completeness boolean NOT NULL,
    created_by_id bigint,
    modified_by_id bigint,
    profile_manager_id uuid,
    tool_id_id uuid,
    required character varying,
    has_line_item_history boolean NOT NULL,
    enable_postprocessing_webhook boolean NOT NULL,
    postprocessing_webhook_url text
);


ALTER TABLE unstract.tool_studio_prompt OWNER TO unstract_dev;

--
-- Name: COLUMN tool_studio_prompt.prompt_key; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tool_studio_prompt.prompt_key IS 'Field to store the prompt key';


--
-- Name: COLUMN tool_studio_prompt.enforce_type; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tool_studio_prompt.enforce_type IS 'Field to store the type in             which the response to be returned.';


--
-- Name: COLUMN tool_studio_prompt.prompt; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tool_studio_prompt.prompt IS 'Field to store the prompt';


--
-- Name: COLUMN tool_studio_prompt.prompt_type; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tool_studio_prompt.prompt_type IS 'Field to store the type of the input prompt';


--
-- Name: COLUMN tool_studio_prompt.assert_prompt; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tool_studio_prompt.assert_prompt IS 'Field to store the asserted prompt';


--
-- Name: COLUMN tool_studio_prompt.assertion_failure_prompt; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tool_studio_prompt.assertion_failure_prompt IS 'Field to store the prompt key';


--
-- Name: COLUMN tool_studio_prompt.output_metadata; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tool_studio_prompt.output_metadata IS 'JSON adapter metadata for the FE to load the pagination';


--
-- Name: COLUMN tool_studio_prompt.required; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tool_studio_prompt.required IS 'Field to store weather the values all values or any         values required. This is used for HQR, based on the value approve or finish         review';


--
-- Name: COLUMN tool_studio_prompt.enable_postprocessing_webhook; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tool_studio_prompt.enable_postprocessing_webhook IS 'Enable postprocessing webhook for JSON responses';


--
-- Name: COLUMN tool_studio_prompt.postprocessing_webhook_url; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.tool_studio_prompt.postprocessing_webhook_url IS 'URL endpoint for postprocessing webhook';


--
-- Name: usage; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.usage (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    workflow_id character varying(255),
    execution_id character varying(255),
    adapter_instance_id character varying(255) NOT NULL,
    run_id uuid,
    usage_type character varying(255) NOT NULL,
    llm_usage_reason character varying(255),
    model_name character varying(255) NOT NULL,
    embedding_tokens integer NOT NULL,
    prompt_tokens integer NOT NULL,
    completion_tokens integer NOT NULL,
    total_tokens integer NOT NULL,
    cost_in_dollars double precision NOT NULL,
    organization_id bigint
);


ALTER TABLE unstract.usage OWNER TO unstract_dev;

--
-- Name: COLUMN usage.id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.usage.id IS 'Primary key for the usage entry, automatically generated UUID';


--
-- Name: COLUMN usage.workflow_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.usage.workflow_id IS 'Identifier for the workflow';


--
-- Name: COLUMN usage.execution_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.usage.execution_id IS 'Identifier for the execution instance';


--
-- Name: COLUMN usage.adapter_instance_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.usage.adapter_instance_id IS 'Identifier for the adapter instance';


--
-- Name: COLUMN usage.run_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.usage.run_id IS 'Identifier for the run';


--
-- Name: COLUMN usage.usage_type; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.usage.usage_type IS 'Type of usage, either ''llm'' or ''embedding''';


--
-- Name: COLUMN usage.llm_usage_reason; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.usage.llm_usage_reason IS 'Reason for LLM usage. Empty if usage_type is ''embedding''. ';


--
-- Name: COLUMN usage.model_name; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.usage.model_name IS 'Name of the model used';


--
-- Name: COLUMN usage.embedding_tokens; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.usage.embedding_tokens IS 'Number of tokens used for embedding';


--
-- Name: COLUMN usage.prompt_tokens; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.usage.prompt_tokens IS 'Number of tokens used for the prompt';


--
-- Name: COLUMN usage.completion_tokens; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.usage.completion_tokens IS 'Number of tokens used for the completion';


--
-- Name: COLUMN usage.total_tokens; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.usage.total_tokens IS 'Total number of tokens used';


--
-- Name: COLUMN usage.cost_in_dollars; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.usage.cost_in_dollars IS 'Total number of tokens used';


--
-- Name: COLUMN usage.organization_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.usage.organization_id IS 'Foreign key reference to the Organization model.';


--
-- Name: user; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract."user" (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    user_id character varying NOT NULL,
    project_storage_created boolean NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone NOT NULL,
    created_by_id bigint,
    modified_by_id bigint,
    auth_provider character varying(64) NOT NULL
);


ALTER TABLE unstract."user" OWNER TO unstract_dev;

--
-- Name: user_groups; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE unstract.user_groups OWNER TO unstract_dev;

--
-- Name: user_groups_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract."user" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_user_permissions; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE unstract.user_user_permissions OWNER TO unstract_dev;

--
-- Name: user_user_permissions_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: workflow; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.workflow (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    description text NOT NULL,
    workflow_name character varying(128) NOT NULL,
    is_active boolean NOT NULL,
    status character varying(16) NOT NULL,
    deployment_type character varying NOT NULL,
    source_settings jsonb,
    destination_settings jsonb,
    created_by_id bigint,
    modified_by_id bigint,
    organization_id bigint,
    workflow_owner_id bigint,
    shared_to_org boolean NOT NULL
);


ALTER TABLE unstract.workflow OWNER TO unstract_dev;

--
-- Name: COLUMN workflow.deployment_type; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow.deployment_type IS 'Type of workflow deployment';


--
-- Name: COLUMN workflow.source_settings; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow.source_settings IS 'Settings for the Source module';


--
-- Name: COLUMN workflow.destination_settings; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow.destination_settings IS 'Settings for the Destination module';


--
-- Name: COLUMN workflow.organization_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow.organization_id IS 'Foreign key reference to the Organization model.';


--
-- Name: COLUMN workflow.shared_to_org; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow.shared_to_org IS 'Whether this workflow is shared with the entire organization';


--
-- Name: workflow_endpoints; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.workflow_endpoints (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    endpoint_type character varying NOT NULL,
    connection_type character varying NOT NULL,
    configuration jsonb,
    connector_instance_id uuid,
    workflow_id uuid NOT NULL
);


ALTER TABLE unstract.workflow_endpoints OWNER TO unstract_dev;

--
-- Name: COLUMN workflow_endpoints.endpoint_type; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_endpoints.endpoint_type IS 'Endpoint type (source or destination)';


--
-- Name: COLUMN workflow_endpoints.connection_type; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_endpoints.connection_type IS 'Connection type (Filesystem, Database, API or Manualreview)';


--
-- Name: COLUMN workflow_endpoints.configuration; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_endpoints.configuration IS 'Configuration in JSON format';


--
-- Name: COLUMN workflow_endpoints.connector_instance_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_endpoints.connector_instance_id IS 'Foreign key from ConnectorInstance model';


--
-- Name: COLUMN workflow_endpoints.workflow_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_endpoints.workflow_id IS 'Foreign key from Workflow model';


--
-- Name: workflow_execution; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.workflow_execution (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    pipeline_id uuid,
    task_id uuid,
    workflow_id uuid,
    execution_mode character varying NOT NULL,
    execution_method character varying NOT NULL,
    execution_type character varying NOT NULL,
    execution_log_id character varying NOT NULL,
    status character varying NOT NULL,
    error_message character varying(256) NOT NULL,
    attempts integer NOT NULL,
    execution_time double precision NOT NULL,
    result_acknowledged boolean NOT NULL,
    total_files integer NOT NULL,
    CONSTRAINT workflow_execution_total_files_check CHECK ((total_files >= 0))
);


ALTER TABLE unstract.workflow_execution OWNER TO unstract_dev;

--
-- Name: COLUMN workflow_execution.pipeline_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_execution.pipeline_id IS 'ID of the associated pipeline, if applicable';


--
-- Name: COLUMN workflow_execution.task_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_execution.task_id IS 'task id of asynchronous execution';


--
-- Name: COLUMN workflow_execution.workflow_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_execution.workflow_id IS 'Workflow to be executed';


--
-- Name: COLUMN workflow_execution.execution_mode; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_execution.execution_mode IS 'Mode of execution';


--
-- Name: COLUMN workflow_execution.execution_method; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_execution.execution_method IS 'Method of execution';


--
-- Name: COLUMN workflow_execution.execution_type; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_execution.execution_type IS 'Type of execution';


--
-- Name: COLUMN workflow_execution.execution_log_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_execution.execution_log_id IS 'Execution log events Id';


--
-- Name: COLUMN workflow_execution.status; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_execution.status IS 'Current status of the execution';


--
-- Name: COLUMN workflow_execution.error_message; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_execution.error_message IS 'Details of encountered errors';


--
-- Name: COLUMN workflow_execution.attempts; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_execution.attempts IS 'number of attempts taken';


--
-- Name: COLUMN workflow_execution.execution_time; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_execution.execution_time IS 'execution time in seconds';


--
-- Name: COLUMN workflow_execution.result_acknowledged; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_execution.result_acknowledged IS 'To track if result is acknowledged by user - used mainly by API deployments';


--
-- Name: COLUMN workflow_execution.total_files; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_execution.total_files IS 'Number of files to process';


--
-- Name: workflow_execution_tags; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.workflow_execution_tags (
    id bigint NOT NULL,
    workflowexecution_id uuid NOT NULL,
    tag_id uuid NOT NULL
);


ALTER TABLE unstract.workflow_execution_tags OWNER TO unstract_dev;

--
-- Name: workflow_execution_tags_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.workflow_execution_tags ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.workflow_execution_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: workflow_file_execution; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.workflow_file_execution (
    created_at timestamp with time zone NOT NULL,
    modified_at timestamp with time zone NOT NULL,
    id uuid NOT NULL,
    file_name character varying(255) NOT NULL,
    file_path character varying(255),
    file_size bigint,
    file_hash character varying(64),
    mime_type character varying(128),
    status text NOT NULL,
    execution_time double precision,
    execution_error text,
    workflow_execution_id uuid NOT NULL,
    fs_metadata jsonb,
    provider_file_uuid character varying(64)
);


ALTER TABLE unstract.workflow_file_execution OWNER TO unstract_dev;

--
-- Name: COLUMN workflow_file_execution.file_name; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_file_execution.file_name IS 'Name of the file';


--
-- Name: COLUMN workflow_file_execution.file_path; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_file_execution.file_path IS 'Full Path of the file';


--
-- Name: COLUMN workflow_file_execution.file_size; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_file_execution.file_size IS 'Size of the file in bytes';


--
-- Name: COLUMN workflow_file_execution.file_hash; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_file_execution.file_hash IS 'Hash of the file content';


--
-- Name: COLUMN workflow_file_execution.mime_type; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_file_execution.mime_type IS 'MIME type of the file';


--
-- Name: COLUMN workflow_file_execution.status; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_file_execution.status IS 'Current status of the execution';


--
-- Name: COLUMN workflow_file_execution.execution_time; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_file_execution.execution_time IS 'Execution time in seconds';


--
-- Name: COLUMN workflow_file_execution.execution_error; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_file_execution.execution_error IS 'Error message if execution failed';


--
-- Name: COLUMN workflow_file_execution.workflow_execution_id; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_file_execution.workflow_execution_id IS 'Foreign key from WorkflowExecution model';


--
-- Name: COLUMN workflow_file_execution.fs_metadata; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_file_execution.fs_metadata IS 'Complete metadata of the file retrieved from the file system.';


--
-- Name: COLUMN workflow_file_execution.provider_file_uuid; Type: COMMENT; Schema: unstract; Owner: unstract_dev
--

COMMENT ON COLUMN unstract.workflow_file_execution.provider_file_uuid IS 'Unique identifier assigned by the file storage provider';


--
-- Name: workflow_shared_users; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.workflow_shared_users (
    id bigint NOT NULL,
    workflow_id uuid NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE unstract.workflow_shared_users OWNER TO unstract_dev;

--
-- Name: workflow_shared_users_id_seq; Type: SEQUENCE; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE unstract.workflow_shared_users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME unstract.workflow_shared_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: x2text_audit; Type: TABLE; Schema: unstract; Owner: unstract_dev
--

CREATE TABLE unstract.x2text_audit (
    id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    org_id character varying(255) NOT NULL,
    file_name character varying(255) NOT NULL,
    file_type character varying(255) NOT NULL,
    file_size_in_kb real NOT NULL,
    status character varying(255) NOT NULL
);


ALTER TABLE unstract.x2text_audit OWNER TO unstract_dev;

--
-- Data for Name: authentications; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.authentications (id, hashed_client_token, method, metadata, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: celery_taskmeta; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.celery_taskmeta (id, task_id, status, result, date_done, traceback, name, args, kwargs, worker, retries, queue) FROM stdin;
1	91130f8c-bd00-40d6-bb87-c51f26c848a8	SUCCESS	\N	2025-11-02 22:10:45.960917	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
2	5d55ef9e-d636-492c-8fb5-9a98087715da	SUCCESS	\N	2025-11-02 22:11:15.735031	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
3	f793e64c-27e7-4c55-ac2c-bf85062ae835	SUCCESS	\N	2025-11-02 22:11:45.766303	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
4	74478573-400a-4878-9a5a-999f7050177d	SUCCESS	\N	2025-11-02 22:12:15.777309	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
5	2fe90769-9ab5-4f6b-9d45-027d366dc8e5	SUCCESS	\N	2025-11-02 22:12:45.798533	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
6	077b73c0-b7b2-47e2-a751-8bd1167735a5	SUCCESS	\N	2025-11-02 22:13:15.803784	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
7	66e1df34-0bb7-485e-816f-72a119a61323	SUCCESS	\N	2025-11-02 22:13:45.831624	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
8	bd7324d2-af7f-4961-a2e6-1db01fc38c77	SUCCESS	\N	2025-11-02 22:14:15.825801	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
9	a0d47036-f6cb-477a-8390-42bb875d70bd	SUCCESS	\N	2025-11-02 22:14:45.80955	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
10	66cacfef-67df-48bf-bf6f-4c3db315e904	SUCCESS	\N	2025-11-02 22:15:15.829757	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
11	232224d4-2a7d-4261-9781-af0f5c5c32b2	SUCCESS	\N	2025-11-02 22:15:45.858628	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
12	f19f827d-7688-4bf1-afa5-6c2b87f0451c	SUCCESS	\N	2025-11-02 22:16:15.874956	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
13	8ba2b00a-195a-48b6-876f-59ceed67573d	SUCCESS	\N	2025-11-02 22:16:45.906799	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
14	a775a4e5-e0ab-471b-976e-731297080790	SUCCESS	\N	2025-11-02 22:17:15.87622	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
15	e439de3f-50de-45cb-a2dd-5e53b6e564d5	SUCCESS	\N	2025-11-02 22:17:46.082657	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
16	b053c52c-8df2-4754-acac-22b6d25523f2	SUCCESS	\N	2025-11-02 22:18:41.092664	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
17	fba67142-0371-4f8c-b1e1-05a84d130408	SUCCESS	\N	2025-11-02 22:19:22.673593	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
18	2ec5e0b8-5786-46ba-8a27-cf8282d9034c	SUCCESS	\N	2025-11-02 22:20:17.994942	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
20	d8e83c6c-723f-4e80-bdde-06c16bd1df62	FAILURE	\\x8005958e000000000000007d94288c086578635f74797065948c0f576f726b65724c6f73744572726f72948c0b6578635f6d657373616765948c36576f726b657220657869746564207072656d61747572656c793a207369676e616c203920285349474b494c4c29204a6f623a2031382e9485948c0a6578635f6d6f64756c65948c1362696c6c696172642e657863657074696f6e7394752e	2025-11-02 22:21:36.752943	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
21	9cfc9484-b365-4412-999c-94fa95c50a76	SUCCESS	\N	2025-11-02 22:45:18.965022	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
22	82c30f3d-d2c0-48f6-966c-d1d1b8cca3d9	SUCCESS	\N	2025-11-02 22:45:28.893118	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
23	dc40d6d6-8741-47a9-9a33-c97d4f9a7cd4	SUCCESS	\N	2025-11-02 22:45:36.498417	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
24	bf986b1b-7102-48e2-9c79-3fa6841737f2	SUCCESS	\N	2025-11-02 22:45:38.531546	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
25	ff0c06f8-1929-4d90-92d7-04b3238a7268	SUCCESS	\N	2025-11-02 22:45:38.531566	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
26	8ee23761-b71a-4e1e-b561-59161be0f3b6	SUCCESS	\N	2025-11-02 22:45:44.120413	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
27	f33e504a-307f-4967-800a-a1a0aa61db05	SUCCESS	\N	2025-11-02 22:45:52.90465	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
29	58fb782b-d1a6-4b6b-9a44-4101ab07f882	SUCCESS	\N	2025-11-02 22:45:52.904301	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
28	33b754af-bb0c-48c2-8edf-6baca2b758e8	SUCCESS	\N	2025-11-02 22:45:52.904077	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
30	ce56c914-276f-4b75-abf6-4a4862e35d89	SUCCESS	\N	2025-11-02 22:46:10.139084	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
34	2ed08b47-2c9a-496e-bd9f-d3b2e289147e	SUCCESS	\N	2025-11-02 22:46:18.871525	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
36	1d1ba143-bb1c-4c5f-8fcf-f47c92aff773	SUCCESS	\N	2025-11-02 22:46:36.410699	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
41	8dd29a56-37c1-4e96-9a8e-fb5e3118a5d7	SUCCESS	\N	2025-11-02 22:46:45.841778	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
31	78f85825-533a-4b9f-b3f1-17332083daca	SUCCESS	\N	2025-11-02 22:46:10.138271	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
35	7bb496a5-8abe-40db-881c-d40db48fa9e7	SUCCESS	\N	2025-11-02 22:46:18.871276	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
38	e04b6784-abcb-4629-98a9-384213f12589	SUCCESS	\N	2025-11-02 22:46:36.808666	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
39	97876ef5-dbe8-444d-b494-c94fb133845b	SUCCESS	\N	2025-11-02 22:46:45.818915	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
32	781367b4-4544-410d-bc41-70e77ff30c0e	SUCCESS	\N	2025-11-02 22:46:10.641409	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
33	028299de-87f2-46d1-9c9a-88cfb024d2c6	SUCCESS	\N	2025-11-02 22:46:18.880243	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
37	22f3c46e-f7f9-40d7-ba5f-1a7c8dd5de3f	SUCCESS	\N	2025-11-02 22:46:36.554567	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
40	f65665a9-9a93-48ed-9d32-86867c44776a	SUCCESS	\N	2025-11-02 22:46:45.819144	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
44	b656e823-606d-485a-af1f-db28137c6a0a	SUCCESS	\N	2025-11-02 22:46:52.896069	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
42	a44aa4b8-9558-4ef8-a16c-310630007b3a	SUCCESS	\N	2025-11-02 22:46:52.896096	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
43	d7e5841d-ffb3-4b84-a67f-3e73fc5f0695	SUCCESS	\N	2025-11-02 22:46:52.896101	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
45	dc38813c-e972-40cb-af5b-12e3535640f4	SUCCESS	\N	2025-11-02 22:46:59.774195	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
46	97736a92-6a79-4749-8ac5-e824bec6b0ab	SUCCESS	\N	2025-11-02 22:46:59.774126	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
47	cf0dad21-ffb2-481a-86d2-ba3ef9d2fc7d	SUCCESS	\N	2025-11-02 22:46:59.988744	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
49	e90cd49e-c753-4d2e-8a8b-eea9bc941b2f	SUCCESS	\N	2025-11-02 22:47:03.51729	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
50	abf95d5f-743e-494e-9cc6-30be55a8f571	SUCCESS	\N	2025-11-02 22:47:03.518678	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
48	9766d8ba-3fa5-4f35-9bdd-e82ea695eb41	SUCCESS	\N	2025-11-02 22:47:03.520475	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
52	9e0c4cb4-f3b3-4568-a53e-248a36861acc	SUCCESS	\N	2025-11-02 22:47:08.612125	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
53	f9adb6ef-c146-4a25-a6f4-dc2638f5e06f	SUCCESS	\N	2025-11-02 22:47:08.61113	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
51	5845835a-b0ac-48cb-a1fe-f5fde8e615be	SUCCESS	\N	2025-11-02 22:47:08.61165	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
55	99512f52-ef66-4b30-86ce-d8cfa4f9fa11	SUCCESS	\N	2025-11-02 22:47:10.284135	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
54	76948815-fdb8-4d98-a7fb-f683aea6b1c6	SUCCESS	\N	2025-11-02 22:47:10.28389	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
56	30da38b8-97b0-40cf-ad2a-b791d6c78ad2	SUCCESS	\N	2025-11-02 22:47:10.284123	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
59	a9c6814c-b0a2-4bfd-9908-b4a3c9fd3adc	SUCCESS	\N	2025-11-02 22:47:11.022375	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
58	4d3ec52f-477d-40c9-92bd-cd32ab77b682	SUCCESS	\N	2025-11-02 22:47:11.024782	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
57	6ad499c9-3a4f-4186-8e24-47356259e30f	SUCCESS	\N	2025-11-02 22:47:11.025081	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
62	c5fa7b84-fa43-4313-8ba3-734856909e82	SUCCESS	\N	2025-11-02 22:47:14.826096	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
61	03c04258-cd2d-458e-9f9b-9dc5053578ea	SUCCESS	\N	2025-11-02 22:47:14.842197	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
60	3fe44e11-852b-4f62-a743-47b135307a07	SUCCESS	\N	2025-11-02 22:47:14.839544	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
63	6d938dae-d3c2-4be1-975d-c0c77662e0fe	SUCCESS	\N	2025-11-02 22:47:25.784143	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
64	9644ee3f-93cc-4513-b44f-c78ed034a756	SUCCESS	\N	2025-11-02 22:47:33.841609	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
65	03099e2d-3a6e-4857-8303-6671f95e9185	SUCCESS	\N	2025-11-02 22:47:33.959673	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
66	ba067f61-5c05-47bb-8a0d-f0f1d75ca975	SUCCESS	\N	2025-11-02 22:48:02.465349	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
67	e9dcae87-95d6-46fd-928c-d4714afeb9dd	SUCCESS	\N	2025-11-02 22:48:32.478124	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
68	50fb492a-d79b-424e-b00c-2bbb43e9e7c1	SUCCESS	\N	2025-11-02 22:49:02.470402	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
69	22454dfc-4291-4157-9dda-982fbdbf9158	SUCCESS	\N	2025-11-02 22:49:32.473867	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
70	8e34fa63-ef74-43bc-bc53-e968f986f625	SUCCESS	\N	2025-11-02 22:50:02.485679	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
71	d6820cf5-50cd-4f37-8fad-0b20b65fe73f	SUCCESS	\N	2025-11-02 22:50:32.478401	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
72	33ba0695-6102-4533-a1b2-9e95448496e0	SUCCESS	\N	2025-11-02 22:51:02.495641	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
73	eb3667de-8c1f-4ec6-a4f0-1bfb73e3e97b	SUCCESS	\N	2025-11-02 22:51:32.486177	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
74	ed911515-c12f-4a12-b61a-54ef3705bc40	SUCCESS	\N	2025-11-02 22:52:02.49458	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
75	86a9d873-64ec-403a-b4d3-d4fa37a7e60d	SUCCESS	\N	2025-11-02 22:52:32.48109	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
76	ffb8fa77-829f-457e-91bc-c1014431394c	SUCCESS	\N	2025-11-02 22:53:02.494312	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
77	3aba7d61-9727-4029-944c-0066e202019a	SUCCESS	\N	2025-11-02 22:53:32.494299	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
78	ea4354f0-04c9-4a97-bc66-3548a89a6aaf	SUCCESS	\N	2025-11-02 22:54:02.498803	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
79	6b3ebaab-8815-4db4-a4b5-cb093490abbc	SUCCESS	\N	2025-11-02 22:54:32.510922	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
80	e26fde81-9695-4354-8bd5-dcf8242eae42	SUCCESS	\N	2025-11-02 22:55:02.50719	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
81	b39a123b-5ffe-4218-8892-ed571a3052c6	SUCCESS	\N	2025-11-02 22:55:32.507647	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
82	cd6097a5-3846-4274-9344-0b75eea9001a	SUCCESS	\N	2025-11-02 22:56:02.514872	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
83	cd81ee77-f2a1-4f6b-8153-e4e38a614830	SUCCESS	\N	2025-11-02 22:56:32.517249	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
84	47ec8cb6-ce0d-4a96-848b-98ba56101532	SUCCESS	\N	2025-11-02 22:57:02.510986	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
85	3e0bf441-d052-45fa-b5f9-2e42ed8bb06d	SUCCESS	\N	2025-11-02 22:57:32.515143	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
86	a9dd11ff-1430-438e-b22e-ed9d0b73f0e7	SUCCESS	\N	2025-11-02 22:58:02.522098	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
87	5f8fecc7-a45e-4a18-bd1c-ece72c52eec8	SUCCESS	\N	2025-11-02 22:58:32.524901	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
88	cb9aed40-f336-470d-a134-48c3289f6e71	SUCCESS	\N	2025-11-02 22:59:02.537138	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
89	80d5f877-de15-41da-85f9-599429c291e4	SUCCESS	\N	2025-11-02 22:59:32.524438	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
90	d648891c-adfc-4322-8fc0-f1cd7fa73b3e	SUCCESS	\N	2025-11-02 23:00:02.572471	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
91	83436d87-6ec7-49b3-802a-63a41b214a9b	SUCCESS	\N	2025-11-02 23:00:32.553676	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
92	ff4fa3d9-d58a-4733-aeb1-886f7aa7cb22	SUCCESS	\N	2025-11-02 23:01:02.549759	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
93	1db59f07-0d85-403b-9359-58008a3b830e	SUCCESS	\N	2025-11-02 23:01:32.544153	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
94	5837d480-4b44-4914-a91a-0bcd5c747e8b	SUCCESS	\N	2025-11-02 23:02:02.562468	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
95	fac556c8-4328-4c7b-bf9a-9fc53ad1dc29	SUCCESS	\N	2025-11-02 23:02:32.559722	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
96	7d912ba6-53a1-424c-843f-4da3f07db697	SUCCESS	\N	2025-11-02 23:03:02.567095	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
97	b3a930d3-db06-4b76-ad6c-f4405472ed54	SUCCESS	\N	2025-11-02 23:03:32.576546	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
98	496cc54d-66a1-4d28-b86f-54f4a86c3925	SUCCESS	\N	2025-11-02 23:04:02.569535	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
99	248af473-de81-4362-86d5-ee9e7079e296	SUCCESS	\N	2025-11-02 23:04:32.566841	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
100	db5553ec-e067-4ee8-8219-92a8ad21e9ad	SUCCESS	\N	2025-11-02 23:05:02.581266	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
101	0376fdd4-d2a6-487b-b31a-0eaef50ec999	SUCCESS	\N	2025-11-02 23:05:32.579734	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
102	820c7655-5c57-4bca-bdbd-7d2115dbc5ac	SUCCESS	\N	2025-11-02 23:06:02.583596	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
103	705b2133-cd64-4769-ae2b-5bf01cf18ef4	SUCCESS	\N	2025-11-02 23:06:32.575224	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
104	abb17756-60ff-4442-aefa-cf63582ae177	SUCCESS	\N	2025-11-02 23:07:02.579913	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
105	90913535-80a3-4adb-85c3-ef2fc67fc70d	SUCCESS	\N	2025-11-02 23:07:32.596641	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
106	e31ba1a4-457c-499a-89ce-f0e28f7b337d	SUCCESS	\N	2025-11-02 23:08:02.600034	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
107	c564db21-8299-451e-a70a-5d33f290e5d9	SUCCESS	\N	2025-11-02 23:08:32.602625	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
108	ed3ddaad-a027-46bc-b504-2f422572df13	SUCCESS	\N	2025-11-02 23:09:02.606525	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
109	59a335a1-f0fe-4554-8090-09e3252adcbf	SUCCESS	\N	2025-11-02 23:09:32.627516	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
110	4cfe9099-3083-47c6-b84a-980fe437ee76	SUCCESS	\N	2025-11-02 23:10:02.609994	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
111	147d6e07-f8d2-484a-89f1-6e763b2e2b72	SUCCESS	\N	2025-11-02 23:10:32.618894	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
112	228c16d9-c40a-44a4-b68b-5943fc0c702c	SUCCESS	\N	2025-11-02 23:11:02.618172	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
113	363e2a53-1f85-4897-adb6-0a7c63b4bda7	SUCCESS	\N	2025-11-02 23:11:32.609729	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
114	6dc354b3-db43-4a2e-9e06-d52784477a96	SUCCESS	\N	2025-11-02 23:12:02.620823	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
115	83badbc7-e94e-4df5-a5f2-10af4f7c2e68	SUCCESS	\N	2025-11-02 23:12:32.619257	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
116	3e200901-a019-45aa-9e31-c7c2280af8da	SUCCESS	\N	2025-11-02 23:13:02.625617	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
117	a43c6326-6219-4d8c-867d-f07d091231bd	SUCCESS	\N	2025-11-02 23:13:32.638237	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
118	6227b617-3c62-47b6-aa60-0bb6bf3826da	SUCCESS	\N	2025-11-02 23:14:02.631784	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
119	68355af4-1f04-4be5-a3a9-497dffa3da61	SUCCESS	\N	2025-11-02 23:14:32.644215	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
120	ab70fa58-7eef-43ea-9737-b346440d9916	SUCCESS	\N	2025-11-02 23:15:02.651037	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
121	55852b64-fb28-4d5d-93e6-9c12570901f6	SUCCESS	\N	2025-11-02 23:15:32.650358	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
122	54537aa3-1734-4d22-a429-ec0417aa8426	SUCCESS	\N	2025-11-02 23:16:02.645827	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
123	72d34bfc-6319-4b81-b674-57504fd198e7	SUCCESS	\N	2025-11-02 23:16:32.649001	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
124	553cbe15-bc8f-47df-9855-b01b45f0dd58	SUCCESS	\N	2025-11-02 23:17:02.677494	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
125	de3f0e66-ad43-464b-9860-ff8e48700f7d	SUCCESS	\N	2025-11-02 23:17:32.683649	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
126	96c0bd1e-1e7b-40a6-b887-b680acf6d065	SUCCESS	\N	2025-11-02 23:18:02.683116	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
127	d40cdb4c-df47-494b-9602-3e088c783d16	SUCCESS	\N	2025-11-02 23:18:32.676386	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
128	a44e0259-93e5-467a-bb43-ea381a72262f	SUCCESS	\N	2025-11-02 23:19:02.677227	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
129	570665b7-bd8e-401f-95ed-9f4f99d1ca95	SUCCESS	\N	2025-11-02 23:19:32.6924	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
130	5438293a-809b-4ec7-930e-ac76a5256d2e	SUCCESS	\N	2025-11-02 23:20:02.697729	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
131	5e32ce6b-2c8d-41b1-ae4b-171bf2bf17a1	SUCCESS	\N	2025-11-02 23:20:32.704613	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
132	abc25ba3-c648-491f-84a7-917c603d6120	SUCCESS	\N	2025-11-02 23:21:02.708022	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
133	cef7bb70-6d07-4b76-bb25-aed6f50062dc	SUCCESS	\N	2025-11-02 23:21:32.714036	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
134	16333dfc-9fcb-434a-bc32-7eb4057080fb	SUCCESS	\N	2025-11-02 23:22:02.711758	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
135	e5fab19d-46cc-44c4-ab65-977ed4ea5270	SUCCESS	\N	2025-11-02 23:22:32.72063	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
136	8d09ae9b-9343-443d-9d3d-8c69d5a6e0f7	SUCCESS	\N	2025-11-02 23:23:02.71166	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
137	10be26d9-d3e6-48c5-8d63-f88765769033	SUCCESS	\N	2025-11-02 23:23:32.718385	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
138	1f04960a-0f25-4aeb-b44c-e7257f422b5e	SUCCESS	\N	2025-11-02 23:24:02.723189	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
139	354de4fb-74c2-4708-a232-5ad6b6eeb2d4	SUCCESS	\N	2025-11-02 23:24:32.720873	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
140	916f68a3-20ae-417c-b10f-66722ab1c92f	SUCCESS	\N	2025-11-02 23:25:02.728789	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
141	ec5bdf9f-8e77-4f44-8ab6-0bfc4696efdc	SUCCESS	\N	2025-11-02 23:25:32.731069	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
142	d476dc86-8159-4213-adfe-023d93e9befe	SUCCESS	\N	2025-11-02 23:26:02.746333	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
143	8685bd07-2046-4b67-a55f-9488a0e4b847	SUCCESS	\N	2025-11-02 23:26:32.754662	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
144	2d04d334-c51b-436e-a3e4-46c78cd3c944	SUCCESS	\N	2025-11-02 23:27:02.754776	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
145	197095b9-bdc1-4275-9480-8e4fd6c3ee15	SUCCESS	\N	2025-11-02 23:27:32.757506	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
146	e9de6a80-a22b-449d-866b-1cf9cb2706d4	SUCCESS	\N	2025-11-02 23:28:02.759372	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
147	8bd0d8a8-cf8a-4498-a54b-812b7df9e740	SUCCESS	\N	2025-11-02 23:28:32.760685	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
148	bbb1e01a-7908-4ad4-9e05-d2739c98da25	SUCCESS	\N	2025-11-02 23:29:02.771411	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
149	99cbe857-a690-49aa-9533-176bcb7d39b6	SUCCESS	\N	2025-11-02 23:29:32.762795	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
150	0b596e0f-8f95-4d12-bb65-4a7ee14ae953	SUCCESS	\N	2025-11-02 23:30:02.764999	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
151	2a1966f4-be00-4b3c-b91f-64368b170f63	SUCCESS	\N	2025-11-02 23:30:32.766783	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
152	f215bbf2-4751-462a-9e27-537a5bdfbc9f	SUCCESS	\N	2025-11-02 23:31:02.762679	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
153	e84c6a92-d0fc-463f-a803-4801d201160b	SUCCESS	\N	2025-11-02 23:31:32.780704	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
154	5831520e-dd50-4e60-a602-498066655629	SUCCESS	\N	2025-11-02 23:32:02.783902	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
155	ea966a51-6c58-48f5-99d6-3ac09fe18869	SUCCESS	\N	2025-11-02 23:32:32.787143	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
156	4e65a264-58d9-424f-96a1-b70446040bd3	SUCCESS	\N	2025-11-02 23:33:02.786372	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
157	b6564e3c-8f71-44e3-935b-a77615b3d5c7	SUCCESS	\N	2025-11-02 23:33:32.780495	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
158	9f505bde-f4ff-44f7-9a49-1dd4de3a0ccf	SUCCESS	\N	2025-11-02 23:34:02.793314	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
159	7dd9f434-2edf-4f1a-b374-475ff9da18ac	SUCCESS	\N	2025-11-02 23:34:32.796972	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
160	346fc700-4d6f-4350-9ebf-64b195256dfe	SUCCESS	\N	2025-11-02 23:35:02.8081	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
161	13c97afa-6ba0-476e-a347-db727f63bda3	SUCCESS	\N	2025-11-02 23:35:32.796344	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
162	f5bb33ba-1e3f-4e89-9cb4-40126c664bae	SUCCESS	\N	2025-11-02 23:36:02.797303	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
163	54d59e99-1895-4601-a662-01eddd461662	SUCCESS	\N	2025-11-02 23:36:32.814065	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
164	78646913-3171-419d-aa96-0d890a374630	SUCCESS	\N	2025-11-02 23:37:02.819471	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
165	42faeb2b-75b2-42c1-86d9-433b2de930a1	SUCCESS	\N	2025-11-02 23:37:32.814843	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
166	ab503cc5-589d-47eb-ba05-20f11a2336f0	SUCCESS	\N	2025-11-02 23:38:02.797366	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
167	6c4c3044-11d8-442b-9d1c-85a8882150d7	SUCCESS	\N	2025-11-02 23:38:32.804335	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
168	5af4b759-c7b4-4082-895c-a2e4253a0e26	SUCCESS	\N	2025-11-02 23:39:02.819264	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
169	d34c0114-590d-4348-8fb6-8a8a2a1d9258	SUCCESS	\N	2025-11-02 23:39:32.823211	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
170	61069f39-9de9-44ba-ae62-60bc781a80cf	SUCCESS	\N	2025-11-02 23:40:02.82096	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
171	89604a10-2808-42e3-a737-60a6512fe56a	SUCCESS	\N	2025-11-02 23:40:32.831164	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
172	852570fb-d764-45e4-84e2-2702aea614f4	SUCCESS	\N	2025-11-02 23:41:02.824497	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
173	7ba794c4-f021-475a-b187-cd7a5bb494d3	SUCCESS	\N	2025-11-02 23:41:32.826402	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
174	bd40e930-2aa0-4c1b-968f-0e9b1364f695	SUCCESS	\N	2025-11-02 23:42:02.834218	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
175	41eb1605-0495-408f-badb-9fcf19d5e0d4	SUCCESS	\N	2025-11-02 23:42:32.837763	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
176	ec0d9e22-dfb3-4c76-a2af-fcbb94665819	SUCCESS	\N	2025-11-02 23:43:02.843994	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
177	5abb27a7-840f-4620-8210-d67e6e9e82f1	SUCCESS	\N	2025-11-02 23:43:33.455451	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
178	d15de091-7797-4c3e-8763-51d5d8c32f9d	SUCCESS	\N	2025-11-02 23:44:11.754159	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
179	22d7e384-caed-45e6-a5af-b8c0ee51f4ad	SUCCESS	\N	2025-11-02 23:44:38.032372	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
180	8362270b-a7d3-444d-a6cb-18efd85c8de4	SUCCESS	\N	2025-11-02 23:45:35.339413	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
181	df509d95-a43d-4289-ac4b-40c755da753b	SUCCESS	\N	2025-11-02 23:46:15.151052	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
182	e90d7e43-b843-480b-922f-9f5da22b8b6e	SUCCESS	\N	2025-11-02 23:46:51.731664	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
183	40af98f3-5343-4aeb-83cd-e530a9547376	SUCCESS	\N	2025-11-02 23:47:48.912173	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
184	9a1630c4-c7a7-485b-a20d-1186bdab5cba	SUCCESS	\N	2025-11-02 23:48:55.609503	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
185	bffd7abe-ea38-4d63-a6e9-c2bc9d6fe7d3	SUCCESS	\N	2025-11-02 23:48:57.781866	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
186	f936d63d-4298-4a6b-b9fc-a62b82caa601	SUCCESS	\N	2025-11-02 23:49:30.606627	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
187	184260a1-d04a-41b6-8154-992a5fd8f4ac	SUCCESS	\N	2025-11-02 23:50:43.26946	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
188	c83f1dc4-0fbb-4231-a53b-a356b6b4a9e4	SUCCESS	\N	2025-11-02 23:51:27.308496	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
189	52828c71-2b17-42a0-8ae1-6a940f4629b4	SUCCESS	\N	2025-11-02 23:51:59.028975	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
190	009a30df-b071-474b-9f68-9df13d6e6303	SUCCESS	\N	2025-11-02 23:52:28.375658	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
191	d9a5f47c-9692-4b99-b9eb-2c3e91d71af9	SUCCESS	\N	2025-11-02 23:53:30.695108	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
192	785cdb6d-11a8-4110-a992-9b718781f1dc	SUCCESS	\N	2025-11-02 23:53:59.271012	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
193	fb253290-69d6-4566-9275-d23fd22705dd	SUCCESS	\N	2025-11-02 23:54:42.222953	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
194	388fdbaa-3e4c-451f-b77e-7b6d0e23d568	SUCCESS	\N	2025-11-02 23:55:32.978462	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
195	c15bd445-677c-47f6-97e8-eac695065080	SUCCESS	\N	2025-11-02 23:56:13.37756	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
196	d3d907f8-88e4-4d48-99e0-7b5f28aa3eae	SUCCESS	\N	2025-11-02 23:56:40.443547	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
197	08b3b8cc-5dd5-4bce-9d60-70d7df839144	SUCCESS	\N	2025-11-02 23:57:15.128898	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
198	6bd921eb-0619-4f9b-b9ff-0ebe824d6768	SUCCESS	\N	2025-11-02 23:57:45.24805	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
199	d25eeacd-0255-4c85-bc46-5347603f029e	SUCCESS	\N	2025-11-02 23:58:35.462422	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
200	682371c8-4e57-4660-a753-a1f51e476066	SUCCESS	\N	2025-11-02 23:59:32.592	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
201	67f9f560-9631-4e9a-af53-a217eac41aac	SUCCESS	\N	2025-11-02 23:59:55.27255	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
202	b688a98f-c6f7-44a1-be31-881fdb9525b0	SUCCESS	\N	2025-11-03 00:00:20.668946	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
203	ea63f1d0-0d71-473c-950e-d1c35f3c4216	SUCCESS	\N	2025-11-03 00:01:09.372785	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
204	9b706045-116c-4641-be69-cb9f3a46aadf	SUCCESS	\N	2025-11-03 00:01:48.13142	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
205	114685c0-120b-43c1-ad51-db8c75b8f79d	SUCCESS	\N	2025-11-03 00:02:31.458724	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
206	8af56f6f-354d-42de-94ba-19adaba6e198	SUCCESS	\N	2025-11-03 00:03:22.581348	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
207	e7ea6a95-e555-4f4a-a965-4d02d0ff0384	SUCCESS	\N	2025-11-03 00:03:50.090291	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
208	f1491a15-01f7-4d30-b08c-9aa609431b4f	SUCCESS	\N	2025-11-03 00:04:24.037005	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
209	dd2c6e51-ca9e-4785-b25f-bc6dfa43f077	SUCCESS	\N	2025-11-03 00:05:07.966272	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
210	ac272f67-648f-4739-b986-529ed4a80da7	SUCCESS	\N	2025-11-03 00:05:31.335919	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
211	85268a26-e516-442d-997c-9d8cb9496191	SUCCESS	\N	2025-11-03 00:06:19.614502	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
212	2f0d6898-3128-4329-b83a-0e14cc6152b0	SUCCESS	\N	2025-11-03 00:07:05.666307	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
213	70925c70-ec81-4d79-ae65-ce05a68917f2	FAILURE	\\x8005958f000000000000007d94288c086578635f74797065948c0f576f726b65724c6f73744572726f72948c0b6578635f6d657373616765948c37576f726b657220657869746564207072656d61747572656c793a207369676e616c203920285349474b494c4c29204a6f623a203139322e9485948c0a6578635f6d6f64756c65948c1362696c6c696172642e657863657074696f6e7394752e	2025-11-03 00:08:34.982018	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
214	0c4da20f-3c26-4171-adc7-62653042827d	SUCCESS	\N	2025-11-03 00:24:07.494093	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
215	90253cac-e45e-4230-80e4-e2edd86756ab	SUCCESS	\N	2025-11-03 00:24:07.512688	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
216	e50f5f69-dfeb-4e48-ad79-d233a8741550	SUCCESS	\N	2025-11-03 00:24:10.512926	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
217	ae13486b-aad8-4f2f-b6ad-e0ecefe68757	SUCCESS	\N	2025-11-03 00:24:10.543107	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
218	7d8baacf-45a8-46f9-86f8-d29c3db320f3	SUCCESS	\N	2025-11-03 00:24:10.547907	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
219	44185813-5868-4677-a6be-0cab3f85bf16	SUCCESS	\N	2025-11-03 00:24:10.557932	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
220	fb4f10ff-3a70-48fb-a4fa-e242f3c3237e	SUCCESS	\N	2025-11-03 00:24:10.579032	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
221	d75fbe37-d6c1-4127-8599-0577a3d07256	SUCCESS	\N	2025-11-03 00:24:10.584015	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
222	f33d4517-fafb-427e-aa81-ca83a5fc8bbe	SUCCESS	\N	2025-11-03 00:24:10.600382	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
223	21b4a430-1710-407f-8b04-3ee2e2a19630	SUCCESS	\N	2025-11-03 00:24:10.610386	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
224	b472b67c-ddb3-42b2-9e6e-d20f72da6325	SUCCESS	\N	2025-11-03 00:24:10.627045	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
225	171025ef-3a0a-4ec3-bd08-f946726074b7	SUCCESS	\N	2025-11-03 00:24:10.640608	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
226	e33e7d14-0cac-4813-a8b8-7cbb39b1c6dd	SUCCESS	\N	2025-11-03 00:24:10.654759	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
227	e83a6321-17b6-47fb-8418-61ae8b96b0a2	SUCCESS	\N	2025-11-03 00:24:10.66111	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
228	fa022cba-841b-4b35-bb92-5d457772f734	SUCCESS	\N	2025-11-03 00:24:10.669216	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
229	8701cc7c-3245-4010-99fd-52ff96e52e9b	SUCCESS	\N	2025-11-03 00:24:10.684731	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
230	d0911f22-04f4-4fab-a343-6ab81cfc6d95	SUCCESS	\N	2025-11-03 00:24:10.698248	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
231	c80e56c8-6dee-4062-93b8-b62b41b32120	SUCCESS	\N	2025-11-03 00:24:10.701378	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
232	52139631-9112-4be7-8fda-4be882d83ccd	SUCCESS	\N	2025-11-03 00:24:10.714881	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
234	e5da0789-9302-4592-b852-a55066aeac4c	SUCCESS	\N	2025-11-03 00:24:10.729103	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
233	8ee00c7f-68e4-4446-af9b-8ac81530823d	SUCCESS	\N	2025-11-03 00:24:10.727866	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
235	ce23c45b-476f-40fc-8201-67f3c928b2a1	SUCCESS	\N	2025-11-03 00:24:10.754957	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
236	32054a8c-6118-43ce-bb49-77ce3bcbfbe6	SUCCESS	\N	2025-11-03 00:24:10.761925	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
237	0ddc76ac-8cdb-420b-bbf1-10b58b231caf	SUCCESS	\N	2025-11-03 00:24:10.769167	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
238	e7e2f8cc-0728-4857-bab5-5c220782f518	SUCCESS	\N	2025-11-03 00:24:15.010321	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
239	daf634e1-7fe8-48c9-9e2f-e8cc1e4962ef	SUCCESS	\N	2025-11-03 00:33:31.049184	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
240	3352a76b-131f-4c53-81f0-f417936f291a	SUCCESS	\N	2025-11-03 00:48:52.206454	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
241	dd56b41f-b7b2-4558-91b8-ecfc7f40e56f	SUCCESS	\N	2025-11-03 01:11:58.122371	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
242	45076baf-ea54-4c5e-9c8f-65c1a99848b5	SUCCESS	\N	2025-11-03 01:14:58.241891	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
243	173dcc82-3945-4a4d-b9fb-475ea595ffe8	SUCCESS	\N	2025-11-03 01:15:53.538773	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
244	ef655474-de1d-4003-bd93-9a051ef264e4	SUCCESS	\N	2025-11-03 01:16:23.581229	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
245	78785610-b049-46b0-9de2-84cfa91a0a60	SUCCESS	\N	2025-11-03 01:16:53.62919	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
246	3a6624ba-fc60-46c7-9cea-dd6f76a61ef7	SUCCESS	\N	2025-11-03 01:17:27.592511	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
247	683a89ad-7514-4705-9c63-aec8911d55d5	SUCCESS	\N	2025-11-03 01:17:58.110167	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
248	10e30683-86f3-4947-a227-696ce296fea5	SUCCESS	\N	2025-11-03 01:18:45.773507	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
249	246b71e6-6e29-45c7-89fb-4ba7ddcacbe4	SUCCESS	\N	2025-11-03 01:19:30.197711	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
250	5afe38e4-3e79-4af2-a496-f503a1a64849	SUCCESS	\N	2025-11-03 01:20:09.724443	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
251	7c06eefc-5808-4165-8bb4-d3fb90493123	SUCCESS	\N	2025-11-03 01:20:56.649154	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
252	85c089de-0bdb-4aed-953e-7160aabe3cc7	SUCCESS	\N	2025-11-03 01:21:30.311528	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
253	74d9761f-073d-4eb6-ab8c-8f189eb90626	SUCCESS	\N	2025-11-03 01:22:15.571184	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
254	544bcf0c-7cb7-4c44-b2eb-7bc598f956bf	SUCCESS	\N	2025-11-03 01:22:53.537295	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
255	190838bf-785d-4706-9c4c-53b087bc7da2	SUCCESS	\N	2025-11-03 01:23:42.777865	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
256	6f597077-6438-4383-a15a-af69f1001dd2	SUCCESS	\N	2025-11-03 01:24:13.436122	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
257	d3d3cd42-989a-4c45-b735-0785e55ad6c6	SUCCESS	\N	2025-11-03 01:24:59.887244	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
258	bbfead69-e1ee-4784-94ad-696e640fcf7a	SUCCESS	\N	2025-11-03 01:25:30.948569	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
260	f400bb81-630f-460c-b862-3d50923b8fc2	SUCCESS	\N	2025-11-03 01:41:29.662382	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
259	7f4a673a-2e17-4f14-8a4b-7c4a6edf849e	SUCCESS	\N	2025-11-03 01:41:29.666849	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
262	1061b4e9-0b5c-4a81-a625-d9a2240f909a	SUCCESS	\N	2025-11-03 01:41:29.749002	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
263	c1ee8932-e5d6-47af-9362-2f3633a5d037	SUCCESS	\N	2025-11-03 01:41:29.75042	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
261	a03ab6b3-9547-4b3a-b397-ce1bca5ad6d7	SUCCESS	\N	2025-11-03 01:41:29.74692	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
265	07c94833-eebc-41a9-a437-b203218ba6e7	SUCCESS	\N	2025-11-03 01:41:29.7779	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
266	fb021547-effd-41b0-9c45-7c6ad5c8a0e2	SUCCESS	\N	2025-11-03 01:41:29.778192	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
264	ebe4e7f7-8006-4d72-8a18-5b77a9b76bfd	SUCCESS	\N	2025-11-03 01:41:29.778094	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
268	01d5f9b4-0e42-4b47-b828-70bad00587b0	SUCCESS	\N	2025-11-03 01:41:29.786439	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
270	e06c36fe-5f92-4a9e-baa2-b46ffb959dae	SUCCESS	\N	2025-11-03 01:41:29.787257	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
269	37e53692-0511-4817-94ca-b00fccef80a2	SUCCESS	\N	2025-11-03 01:41:29.787452	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
267	46b35c31-8983-4903-bc79-4cbb283b4d24	SUCCESS	\N	2025-11-03 01:41:29.787359	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
272	141dabe3-327e-47a2-86e0-bde4994c9feb	SUCCESS	\N	2025-11-03 01:41:29.791891	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
271	a1d683b1-89b3-4c0b-addb-a9d3089eadda	SUCCESS	\N	2025-11-03 01:41:29.791598	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
273	df14ba99-a618-4cc5-b378-cdaf373d6c71	SUCCESS	\N	2025-11-03 01:41:29.794694	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
274	238c3d65-2cbb-4765-8a07-bc70ea4b02eb	SUCCESS	\N	2025-11-03 01:41:29.795136	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
275	bed14306-3005-4475-a353-34b04486eb0f	SUCCESS	\N	2025-11-03 01:41:29.795398	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
276	0c1a4dfc-6fb2-45a3-a732-48ff6fffb0e7	SUCCESS	\N	2025-11-03 01:41:29.796077	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
277	0da23289-b8d6-4a70-b738-0fc31d89d7a5	SUCCESS	\N	2025-11-03 01:41:29.798661	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
278	4535e7d3-66ef-44fd-b4ef-4b37c712964c	SUCCESS	\N	2025-11-03 01:41:29.798806	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
279	50262c41-3254-4e8b-a0fe-dc7634d92c22	SUCCESS	\N	2025-11-03 01:41:49.846623	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
280	9b38b168-9c0c-4c4f-a49f-eceac9999133	SUCCESS	\N	2025-11-03 01:42:19.797278	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
281	b50030c8-8724-41b2-a445-21c4164d2b83	SUCCESS	\N	2025-11-03 01:42:49.710321	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
282	2aec4fd9-8fb2-4434-bdba-a0b2b3e61f17	SUCCESS	\N	2025-11-03 01:43:19.708027	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
283	aa0ff9a2-6ed6-4370-af6a-20e09aa87002	SUCCESS	\N	2025-11-03 01:43:49.736028	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
284	a75f3f84-2bd7-4512-929e-468213f13e3e	SUCCESS	\N	2025-11-03 01:44:19.789391	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
285	24207945-95fc-46cd-91c4-907a2ba31468	SUCCESS	\N	2025-11-03 01:44:49.799143	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
286	95f02617-4fea-4c8a-a9d8-0d86117093fd	SUCCESS	\N	2025-11-03 01:45:19.99498	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
287	6c2072e3-d946-4c93-af9f-f6c142e274cc	SUCCESS	\N	2025-11-03 01:46:04.990017	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
288	92ba3a1b-1750-4460-80f9-9d15c4380b8e	SUCCESS	\N	2025-11-03 01:46:34.518049	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
289	350b38bc-b267-4430-ac95-ffbe7fb0466d	SUCCESS	\N	2025-11-03 01:47:04.911761	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
290	826a6c5d-9e3a-4302-9931-8d8a7ba0b22b	SUCCESS	\N	2025-11-03 01:47:35.938722	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
291	d2a1a82f-b2e4-4e36-b228-fe11266eb5fa	SUCCESS	\N	2025-11-03 01:48:05.479353	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
292	848d576a-ecc0-433b-a0c1-4ce2489e6924	SUCCESS	\N	2025-11-03 01:48:38.291584	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
293	50a414f3-2bc8-4969-8745-0bb629138670	SUCCESS	\N	2025-11-03 01:49:16.110858	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
294	48461028-6dc3-482f-b165-e95334f9a97e	SUCCESS	\N	2025-11-03 01:49:51.224765	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
295	96b16ee0-eca0-4d54-84f3-c850903d5811	SUCCESS	\N	2025-11-03 01:50:19.328421	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
296	674e94bb-4a96-46f7-8fe4-28e3b7f458f3	SUCCESS	\N	2025-11-03 01:50:49.486879	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
297	57a99014-175f-4b0d-9448-2f2c995e6519	SUCCESS	\N	2025-11-03 01:51:52.958866	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
298	6f6099f3-45c1-4476-b8c3-9e523a6405c7	SUCCESS	\N	2025-11-03 01:52:18.641044	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
299	97546057-c096-494d-8f0b-efc6d0968aca	SUCCESS	\N	2025-11-03 01:52:48.527235	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
300	8430b244-6ad7-4737-bd77-b30f9a1f2736	SUCCESS	\N	2025-11-03 01:53:33.38483	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
301	1e2e427f-d0f1-4405-b665-149b1558b0f6	SUCCESS	\N	2025-11-03 01:54:02.877534	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
302	b84fd722-2da6-4f4a-9a5b-e77a26b9a8a0	SUCCESS	\N	2025-11-03 01:54:47.31979	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
303	5bf4fdd7-e000-4e39-91a7-efff60d2bd96	SUCCESS	\N	2025-11-03 01:55:10.550613	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
304	72f937fa-fd6b-4395-9986-321759b4c921	SUCCESS	\N	2025-11-03 01:55:43.631883	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
305	e4eb350d-63ca-49bb-9075-20a2a49e0233	SUCCESS	\N	2025-11-03 01:56:17.158656	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
306	a46a964a-e4b5-4542-ad7e-859e278120a3	SUCCESS	\N	2025-11-03 01:56:58.263531	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
307	7ef24f0f-b7f4-4183-948d-b59d418af14f	SUCCESS	\N	2025-11-03 01:57:36.855349	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
308	555ad5c9-068a-4e80-9dfe-96af333ddcbf	SUCCESS	\N	2025-11-03 01:58:04.555059	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
309	cf8b9f05-e5cd-47e2-a732-2914b541823f	SUCCESS	\N	2025-11-03 01:58:34.544087	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
310	ec05697e-1e80-45dc-a23e-5c0b3dbf25ed	SUCCESS	\N	2025-11-03 01:59:04.650914	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
311	23788066-9bb0-4ddd-9fff-130485fb1c40	SUCCESS	\N	2025-11-03 01:59:34.567945	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
312	9ab01430-caa5-46c7-91c5-69ab53c0ff84	SUCCESS	\N	2025-11-03 02:00:04.575972	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
313	62ca3b4d-f28e-4ca2-87df-5ab2739aa940	SUCCESS	\N	2025-11-03 02:00:34.576486	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
314	c1f82f80-5d36-4164-8ba8-ffa02c7b4d17	SUCCESS	\N	2025-11-03 02:01:04.587495	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
315	bac67fc4-05e6-4513-8395-16788c9171c9	SUCCESS	\N	2025-11-03 02:01:34.595398	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
325	820b0387-ec44-4e7c-9258-16634fef995c	SUCCESS	\N	2025-11-03 02:06:04.794099	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
318	bd2ceb71-eb48-4865-a16a-0e559e2fe42c	SUCCESS	\N	2025-11-03 02:02:34.648003	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
317	d1a7902e-5592-4c6e-98ec-8675695bff15	SUCCESS	\N	2025-11-03 02:02:04.586007	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
319	13a0fcf4-fb42-40c6-b3d7-4b7f89d9014c	SUCCESS	\N	2025-11-03 02:03:04.784079	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
320	35734054-f0bb-4efa-ae6a-31b1bb650496	SUCCESS	\N	2025-11-03 02:03:34.718833	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
321	d8adf0b6-a861-4932-b3af-640a84837495	SUCCESS	\N	2025-11-03 02:04:04.704529	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
322	2b5fdc1c-a42b-4e3c-8ad4-f10acf774987	SUCCESS	\N	2025-11-03 02:04:34.71883	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
323	c4f8c76f-3bdf-4bcf-ba4b-c7c516c4e75f	SUCCESS	\N	2025-11-03 02:05:04.742386	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
324	22b78209-f8a8-40e3-b241-7e37e9f89bbc	SUCCESS	\N	2025-11-03 02:05:34.757257	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
326	98c2ab12-de39-47b2-b4b8-5bb4f0a0af1c	SUCCESS	\N	2025-11-03 02:06:38.425846	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
327	86ef39ad-d43a-45a2-8207-009ceef7ca1a	SUCCESS	\N	2025-11-03 02:07:08.837963	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
328	283cb31f-7142-47dd-a65c-f9565b33e436	SUCCESS	\N	2025-11-03 02:07:39.356127	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
329	5db49fba-623b-48c9-bd27-f4d917551293	SUCCESS	\N	2025-11-03 02:08:12.478737	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
330	ee85c56d-93bb-4a3d-825c-d423f8819e7b	SUCCESS	\N	2025-11-03 02:08:43.664349	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
331	c3ab5ecb-a0dc-4e72-8425-3a0b4b6b2625	SUCCESS	\N	2025-11-03 02:09:13.836676	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
332	39c3b03f-bc6c-49ab-b5c3-3499268c9f07	SUCCESS	\N	2025-11-03 02:09:48.818175	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
333	420c6981-7332-44ac-b7f0-48128f6eeda6	SUCCESS	\N	2025-11-03 02:10:23.600392	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
334	5b94903c-f49b-4d44-a60f-c19cb513a2dd	SUCCESS	\N	2025-11-03 02:11:11.007577	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
335	47e113f1-c980-41f1-8357-d6dacbb98324	SUCCESS	\N	2025-11-03 02:12:00.570136	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
336	0badc0d6-19cf-4117-9805-9b08190456f3	SUCCESS	\N	2025-11-03 02:12:30.04861	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
337	fbc2886b-0678-4633-8845-e51641c40ec9	SUCCESS	\N	2025-11-03 02:13:04.367754	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
338	1190ef15-22e9-4d89-b44c-7e1a467aed28	SUCCESS	\N	2025-11-03 02:13:48.085159	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
339	7e51a7b9-dbef-4f4b-b066-4a77a535cf4a	SUCCESS	\N	2025-11-03 02:14:23.1658	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
340	72fb6ce8-a4fc-4c87-ad2d-346e503abf30	SUCCESS	\N	2025-11-03 02:14:50.066655	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
341	6762d91c-7232-4f57-b7fe-33c6609d9cab	SUCCESS	\N	2025-11-03 02:15:18.905571	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
342	f764f168-425d-4271-b9ef-c5a17a28f36a	SUCCESS	\N	2025-11-03 02:15:55.023133	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
343	fc0b0bc9-af34-4aee-a015-7b2bce5f3de1	SUCCESS	\N	2025-11-03 02:16:33.01192	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
344	401f44eb-e4fa-4699-948a-b972d7375c79	SUCCESS	\N	2025-11-03 02:16:59.485815	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
345	b07665b0-2cb8-4428-ab50-f4af673a3008	SUCCESS	\N	2025-11-03 02:17:31.227911	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
346	b83ed1fb-65ea-4e16-bbf4-ac69b6736a07	SUCCESS	\N	2025-11-03 02:18:01.376766	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
347	72a2c6bf-4dc0-4aad-b9cc-449aa1038e27	SUCCESS	\N	2025-11-03 02:18:32.404395	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
348	45f91da9-377d-4bef-adcf-7a375930320e	SUCCESS	\N	2025-11-03 02:19:06.232929	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
349	2bedb909-d731-4b5a-a2e7-437c8557223e	SUCCESS	\N	2025-11-03 02:19:40.479641	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
350	dfd31e7d-6cac-4415-ba00-3123f8fed48c	SUCCESS	\N	2025-11-03 02:20:10.579245	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
351	7d45da3e-06f7-4ea2-81dc-cd4a1f8e34ec	SUCCESS	\N	2025-11-03 02:20:38.446044	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
352	67cbb48c-0591-4535-955f-3627db864fe1	SUCCESS	\N	2025-11-03 02:21:11.094426	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
353	52eb111a-ab72-4a9d-81be-017714b00e32	SUCCESS	\N	2025-11-03 02:21:53.405666	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
354	d2de4c4c-0d02-4c89-a74f-ab612fb01ec9	SUCCESS	\N	2025-11-03 02:22:20.878816	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
355	3521f69f-233c-4fa4-ae7c-b2aac3595dad	SUCCESS	\N	2025-11-03 02:22:52.135737	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
356	c170621a-8f08-4b58-bc61-9ae05d67b840	SUCCESS	\N	2025-11-03 02:23:30.899109	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
357	184fe67c-2335-44cc-b317-6f9ef51c3d4d	SUCCESS	\N	2025-11-03 02:23:59.052669	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
358	7bd48dbe-7641-4a3b-9e82-09cdf14801c7	SUCCESS	\N	2025-11-03 02:25:18.787343	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
359	43456cf7-ad60-4f66-b4f1-21e24615e945	SUCCESS	\N	2025-11-03 02:25:56.372233	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
360	76a12f63-1bfe-4469-86d7-fdc1ec05c9c2	SUCCESS	\N	2025-11-03 02:26:29.163081	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
361	026297e9-f1b3-4001-96ac-03e3a619f002	SUCCESS	\N	2025-11-03 02:27:08.603245	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
362	324db327-63cc-494d-8401-896ea0389ac5	SUCCESS	\N	2025-11-03 02:43:02.925874	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
363	07fca0ac-96de-4f25-8ee0-48e1c1629db9	SUCCESS	\N	2025-11-03 02:43:02.926438	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
365	196fbc80-ea4d-48d9-9447-5e36ac23f2d7	SUCCESS	\N	2025-11-03 02:43:03.07319	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
366	988674f7-834a-46d7-ace6-fd29ccc8e720	SUCCESS	\N	2025-11-03 02:43:03.074161	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
364	87da0ab0-ed8e-4a32-9fa4-adb5083d7d62	SUCCESS	\N	2025-11-03 02:43:03.062524	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
367	3b06570b-3ebf-4954-8584-13e344e506fb	SUCCESS	\N	2025-11-03 02:43:03.088878	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
368	13ec3fa2-845c-4e89-b65e-0e5aa798e3d6	SUCCESS	\N	2025-11-03 02:43:03.089823	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
369	3ce9a714-ac04-4e6e-a721-aad3fcff5939	SUCCESS	\N	2025-11-03 02:43:03.096371	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
370	31be332e-ced0-4717-aa0b-95344b3c7a50	SUCCESS	\N	2025-11-03 02:43:03.096805	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
371	5f0196f0-e8ef-4044-be9c-405c13972294	SUCCESS	\N	2025-11-03 02:43:03.102514	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
372	01b1e4d2-1c35-4ab9-b7b4-0dacc5b92873	SUCCESS	\N	2025-11-03 02:43:03.102942	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
373	192d2a39-51d0-400f-8f26-6e4a65f2a74d	SUCCESS	\N	2025-11-03 02:43:03.103681	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
374	0392fbba-cb93-4f3c-ba6b-97930799c357	SUCCESS	\N	2025-11-03 02:43:03.107659	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
376	202751d8-656a-439f-b1d5-054f5ce698a9	SUCCESS	\N	2025-11-03 02:43:03.108612	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
375	dfeb2e13-319e-4254-943a-6b8047fc6c7f	SUCCESS	\N	2025-11-03 02:43:03.108559	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
377	9e00f329-4bf8-4e30-a433-81bc1ea2b33c	SUCCESS	\N	2025-11-03 02:43:03.113423	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
378	01fbce67-c31f-4293-8cb7-773e604ba91a	SUCCESS	\N	2025-11-03 02:43:03.115741	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
380	2fa842e5-5a31-44ff-b7de-ee6dbdc7f972	SUCCESS	\N	2025-11-03 02:43:03.118416	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
379	99d4c36e-4ba9-413b-b0be-1582d7d9c065	SUCCESS	\N	2025-11-03 02:43:03.11574	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
381	64b6b140-dadb-4630-bef3-a37a2959854b	SUCCESS	\N	2025-11-03 02:43:03.119615	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
383	b64eb2b4-c463-4a65-b026-358daa054288	SUCCESS	\N	2025-11-03 02:43:03.122549	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
386	93675c67-cbe4-4d8f-8733-34fc80448692	SUCCESS	\N	2025-11-03 02:43:03.127454	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
387	53e9334b-71d0-4f45-84d9-6d12109a8898	SUCCESS	\N	2025-11-03 02:43:03.1283	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
389	b9037e9e-eaab-4f9c-aeae-7558335c4126	SUCCESS	\N	2025-11-03 02:43:21.098217	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
390	5bda09c7-892a-47c0-89f6-766753df86a5	SUCCESS	\N	2025-11-03 02:43:50.992896	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
391	f3487bdc-836a-49cf-b1fe-5259fb886aab	SUCCESS	\N	2025-11-03 02:44:21.04801	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
392	05277519-7b99-4e59-b5e6-ff04a39eb7aa	SUCCESS	\N	2025-11-03 02:44:51.320365	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
393	0ab90905-47ce-413a-bc51-132e8663fb6f	SUCCESS	\N	2025-11-03 02:45:28.189375	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
394	5cee0e7a-2d34-4656-94a6-8a7d28271c5d	SUCCESS	\N	2025-11-03 02:46:09.588926	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
395	2c4be97a-d961-40ce-b9ea-e7e95c3b8ac8	SUCCESS	\N	2025-11-03 02:46:57.8871	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
396	743dc021-ede7-4540-8b61-fc08896fd7f7	SUCCESS	\N	2025-11-03 02:47:30.775661	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
397	34757a9c-3a91-4cbf-a175-4380b56e9913	SUCCESS	\N	2025-11-03 02:48:02.342556	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
398	3448f7ab-6ef5-4087-9db3-b977f4140c7c	SUCCESS	\N	2025-11-03 02:48:50.382866	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
382	490b27b4-aa97-438a-996f-6054c3cbe334	SUCCESS	\N	2025-11-03 02:43:03.121108	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
385	c5315645-3db9-4b7a-b88a-e915d4b2256e	SUCCESS	\N	2025-11-03 02:43:03.126977	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
384	269de291-b680-4453-8e1d-db41434b484b	SUCCESS	\N	2025-11-03 02:43:03.124192	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
388	c9590ddf-8f8b-47f7-b7e3-15a23a4c26e3	SUCCESS	\N	2025-11-03 02:43:03.129661	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
400	1b32a532-d437-4468-91ba-3bb93ef21cdf	SUCCESS	\N	2025-11-03 02:59:38.247863	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
399	cb426f45-2bbf-410e-979b-6ff8eacef051	SUCCESS	\N	2025-11-03 02:59:38.247937	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
401	961039f5-2cd5-4900-ba9b-b478fc0e8b19	SUCCESS	\N	2025-11-03 02:59:38.255976	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
402	dc56bfb1-14cb-48e6-bda9-bffd305e42e6	SUCCESS	\N	2025-11-03 02:59:38.274281	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
403	524c0087-332d-4766-a14a-06ee4f970de7	SUCCESS	\N	2025-11-03 02:59:38.276808	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
404	af2efb0a-da94-4835-83e4-bab3770e067f	SUCCESS	\N	2025-11-03 02:59:38.279437	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
405	0574bc45-c891-474f-96cb-fd37f7e2ff59	SUCCESS	\N	2025-11-03 02:59:38.281855	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
406	8341b82e-aa43-4452-9e7f-89d5e2a15c20	SUCCESS	\N	2025-11-03 02:59:38.283268	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
407	6455def8-06af-4b5b-9a6e-6c72750842c8	SUCCESS	\N	2025-11-03 02:59:38.28379	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
408	e3d4e0bf-3ef0-4ad9-ba76-6fbbec92448a	SUCCESS	\N	2025-11-03 02:59:38.289602	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
409	67ce2043-1f6b-4099-835c-6482b71039f9	SUCCESS	\N	2025-11-03 02:59:38.2904	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
410	a8580ae2-3bcc-4003-89d6-5c0783aef1a2	SUCCESS	\N	2025-11-03 02:59:38.291392	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
411	8246f74a-2480-40ea-8137-b26c85c0b4ee	SUCCESS	\N	2025-11-03 02:59:38.29849	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
412	0c9dd9e1-0c53-4b52-9381-0c005cc81221	SUCCESS	\N	2025-11-03 02:59:38.300065	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
413	ebe69afe-b82b-4528-b543-4486fa3926ae	SUCCESS	\N	2025-11-03 02:59:38.301623	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
415	ce1c678c-0927-4957-a4d2-6373bef3eb83	SUCCESS	\N	2025-11-03 02:59:38.306696	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
414	86a1fbc8-b2ee-4f9f-a652-c4bf22d558b1	SUCCESS	\N	2025-11-03 02:59:38.307017	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
416	373bf862-3162-4089-a572-94d2beb7cdfc	SUCCESS	\N	2025-11-03 02:59:38.31823	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
417	12aa4433-c605-43ce-8087-ba8832781a5f	SUCCESS	\N	2025-11-03 03:00:03.03759	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
418	be0c0236-a601-4cfe-acb2-124e975da1c3	SUCCESS	\N	2025-11-03 03:00:33.114617	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
419	8ce91882-4ed5-480e-a22f-54a4008bf7ef	SUCCESS	\N	2025-11-03 03:01:03.02251	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
420	5448c22c-15da-403b-86be-f05780426308	SUCCESS	\N	2025-11-03 03:01:33.017676	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
421	9b7f964d-09f5-435e-b54b-3f1ff48fe646	SUCCESS	\N	2025-11-03 03:02:03.009772	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
422	04e6cbba-30fa-4e87-bdbc-29d3bb697654	SUCCESS	\N	2025-11-03 03:02:33.022583	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
423	948c07c1-4694-495d-a6cc-b88a8ed3d15f	SUCCESS	\N	2025-11-03 03:03:03.024674	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
424	5804f268-315d-49b3-b9e1-ec1ce097f8e8	SUCCESS	\N	2025-11-03 03:03:33.013516	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
425	d3bef695-fc4c-4171-97e1-693d25e472d3	SUCCESS	\N	2025-11-03 03:04:03.024745	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
426	efa39fc5-af7b-4787-a87a-49330ffa412b	SUCCESS	\N	2025-11-03 03:04:33.030677	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
427	c91511a2-be43-422c-9a10-2afa1f286290	SUCCESS	\N	2025-11-03 03:05:03.036212	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
428	abc8db55-dfae-4fc9-93ee-9b433fdb0004	SUCCESS	\N	2025-11-03 03:05:33.030764	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
429	2e86167a-0983-45a5-a9e8-af4e6a0369a5	SUCCESS	\N	2025-11-03 03:06:03.016974	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
430	a4fe9a37-4001-4c9f-87d9-d901462715ab	SUCCESS	\N	2025-11-03 03:06:33.021301	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
431	eb814629-7f3b-498a-8677-ee67e0b31c25	SUCCESS	\N	2025-11-03 03:07:03.014891	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
432	2088b1d3-f3eb-4f30-b214-33bf44f50159	SUCCESS	\N	2025-11-03 03:07:33.032847	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
433	b24aae45-ea22-4b7b-808a-efea1f65d640	SUCCESS	\N	2025-11-03 03:08:03.017419	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
434	fb402c3b-0cc4-42f4-9cf8-12033a725072	SUCCESS	\N	2025-11-03 03:08:33.030848	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
435	c20f7a42-35d6-45ef-bcaa-bb00a8dc371d	SUCCESS	\N	2025-11-03 03:09:03.050507	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
436	d26db43e-9e2b-416e-b3c0-f61cf3358e7f	SUCCESS	\N	2025-11-03 03:09:33.046791	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
437	b288f0c1-36e3-4b2e-add7-b50484a4cb9a	SUCCESS	\N	2025-11-03 03:10:03.041582	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
438	51bddd38-848c-4f11-b533-49ff339e5d38	SUCCESS	\N	2025-11-03 03:10:33.062604	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
439	75bcc3d5-9adb-4627-b641-6aa67bc3da92	SUCCESS	\N	2025-11-03 03:11:03.057401	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
440	256c12a6-3969-4a9b-a0df-86593106e014	SUCCESS	\N	2025-11-03 03:11:33.099261	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
441	2647584a-4fd8-4704-83dc-44463841843e	SUCCESS	\N	2025-11-03 03:12:03.093423	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
442	7561d2e7-fe7b-4a54-b963-8e69006f47b8	SUCCESS	\N	2025-11-03 03:12:33.106162	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
443	c5898542-ab16-45d0-b0f5-4a520e3820ad	SUCCESS	\N	2025-11-03 03:13:03.100836	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
444	1af1bda8-8e87-4689-ba70-25aee3047bdd	SUCCESS	\N	2025-11-03 03:13:33.111064	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
445	c1563351-4316-4739-86e3-d63a49c6d990	SUCCESS	\N	2025-11-03 03:14:03.106519	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
446	4ba3c1b3-00e3-4207-aa36-ee30eb8e23fa	SUCCESS	\N	2025-11-03 03:14:33.102591	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
447	ec328150-da01-4146-ae45-943262cedace	SUCCESS	\N	2025-11-03 03:15:03.128905	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
448	c9a5c2ab-a14b-49ea-9465-8448cc8e7c64	SUCCESS	\N	2025-11-03 03:15:33.127249	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
449	dfce6da5-7a0f-4281-b056-6076eed450ce	SUCCESS	\N	2025-11-03 03:16:03.17343	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
495	33fcc065-2260-4afd-a7f2-07a60595ce6d	SUCCESS	\N	2025-11-03 03:51:43.560032	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
450	e8fa61e3-d52c-4c52-9861-893daebebddd	SUCCESS	\N	2025-11-03 03:16:33.173282	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
496	06ac67e5-a2eb-43d6-948e-4813600b276f	SUCCESS	\N	2025-11-03 03:51:43.572544	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
497	9f8f4d17-e67b-404a-8e5b-5b22736a106b	SUCCESS	\N	2025-11-03 03:51:43.57988	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
451	cebc5d1a-75e8-4d6e-8215-c354d09023c7	SUCCESS	\N	2025-11-03 03:17:03.276414	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
452	80ca03a1-9557-49a4-ab61-694c0eb9c3a4	SUCCESS	\N	2025-11-03 03:17:33.17683	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
453	de18a8be-1970-4a07-8aa7-dd28590b4e6e	SUCCESS	\N	2025-11-03 03:18:03.17819	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
454	84176d99-b4c5-4548-8166-3afebe766f5e	SUCCESS	\N	2025-11-03 03:18:33.191184	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
455	fa38f830-97e4-4ad7-9a8c-ff10ea9d08ee	SUCCESS	\N	2025-11-03 03:19:03.228666	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
498	086340c0-2358-4c55-9401-a6e4f5855026	SUCCESS	\N	2025-11-03 03:51:43.5907	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
510	63e1c71b-acf5-4717-86b9-0305114dee63	SUCCESS	\N	2025-11-03 03:54:46.725793	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
499	f47a34e4-1444-4b7e-8510-fa20b40b77bf	SUCCESS	\N	2025-11-03 03:51:43.595781	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
500	20853028-4033-41a3-9a7b-9d3e419d952c	SUCCESS	\N	2025-11-03 03:51:43.603918	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
501	329d3c41-3b46-4a94-a553-ee488ddc9c6d	SUCCESS	\N	2025-11-03 03:51:43.608867	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
502	48c24e89-fbe6-447b-b380-d9b0595c73d0	SUCCESS	\N	2025-11-03 03:51:43.614439	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
503	e18fed63-42b9-4460-9c03-4d9be6cd3a02	SUCCESS	\N	2025-11-03 03:51:47.517922	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
504	fde58198-1fb0-4bd6-9fb7-fce3171cb1a5	SUCCESS	\N	2025-11-03 03:51:47.5148	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
505	5c16d616-dfc4-4d42-806a-d45ca0a34c2e	SUCCESS	\N	2025-11-03 03:52:16.570464	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
506	6a1659ca-a093-41fe-a30c-93f1d4927ba8	SUCCESS	\N	2025-11-03 03:52:46.711019	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
507	bc78af18-74ac-4f9e-87ad-c743b1dba271	SUCCESS	\N	2025-11-03 03:53:16.722769	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
508	ef766cd5-8dc8-4fba-8cc6-c77adaf8208c	SUCCESS	\N	2025-11-03 03:53:46.726369	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
509	f63e39f6-ed01-4a7f-a4bb-75467cdc7c4d	SUCCESS	\N	2025-11-03 03:54:16.724851	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
511	5caa1516-ff3f-4718-865b-700f77a8444c	SUCCESS	\N	2025-11-03 03:55:16.771248	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
512	8e00e3e5-9418-4ea1-8883-8e6518dc2a18	SUCCESS	\N	2025-11-03 03:55:46.750038	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
513	d35e94a3-edcb-4ee9-8d2a-9c85a55ff3f2	SUCCESS	\N	2025-11-03 03:56:16.751262	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
514	d7c653d7-1dcf-4318-84e3-e49c9bd3cdaf	SUCCESS	\N	2025-11-03 03:56:46.745789	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
515	041bfd67-91aa-4e75-8daf-135470cd5b09	SUCCESS	\N	2025-11-03 03:57:16.751322	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
516	4f97e718-0e0a-4d3e-acad-09d1d85b3e93	SUCCESS	\N	2025-11-03 03:57:46.74822	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
517	d8483b09-045f-4560-875d-5fc9867662a0	SUCCESS	\N	2025-11-03 03:58:16.736025	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
518	97ac7ab8-31d7-4fe3-b944-febf47ad073e	SUCCESS	\N	2025-11-03 03:58:46.76058	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
519	340e4343-afe2-436f-99e9-3d9476735ec7	SUCCESS	\N	2025-11-03 03:59:16.768102	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
520	d9ce0e3e-b49e-470a-91c2-3bf363e89c51	SUCCESS	\N	2025-11-03 03:59:46.762474	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
522	1f0404a9-bb1b-4967-88ea-b81bf0dd81a1	SUCCESS	\N	2025-11-03 04:00:16.779912	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
460	6910c715-7cf2-4d6f-a72e-13bb9a6afdb7	SUCCESS	\N	2025-11-03 03:21:37.713669	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
461	c2b28b8f-bc9b-484d-aedc-19d37961a5fe	SUCCESS	\N	2025-11-03 03:22:05.003549	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
462	06508649-a6fc-4ac2-a93c-7c60621a556e	SUCCESS	\N	2025-11-03 03:22:36.176291	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
463	347575da-ab9c-43df-be1c-f9f887468e03	SUCCESS	\N	2025-11-03 03:23:06.136814	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
464	d03c0d37-563a-45c6-919a-9d6884b1f01f	SUCCESS	\N	2025-11-03 03:23:37.703768	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
456	12fce311-0b0f-4118-8572-d37b9b8e0d32	SUCCESS	\N	2025-11-03 03:19:33.239409	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
457	11c7880e-1c43-4124-8b05-e9c3019fddda	SUCCESS	\N	2025-11-03 03:20:03.249326	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
458	e8abf0a2-6bbb-4fda-a0ba-488ac1798516	SUCCESS	\N	2025-11-03 03:20:33.271124	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
459	20bca28d-139d-4fa6-8cf5-954ac60643ed	SUCCESS	\N	2025-11-03 03:21:03.288837	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
465	b58f183e-f18c-4640-a2a4-bec64f5146fe	SUCCESS	\N	2025-11-03 03:24:07.507855	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
466	c7ba644e-7feb-4497-b773-4a77b3478754	SUCCESS	\N	2025-11-03 03:24:40.353798	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
467	c1233a37-f592-4a21-be87-0e2955bf9f7d	SUCCESS	\N	2025-11-03 03:25:15.819714	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
468	60ea82fc-d906-44d7-821c-1dedfc6b5eff	SUCCESS	\N	2025-11-03 03:25:46.395002	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
469	00bde626-7d6b-43c2-b8ac-6626b848b558	SUCCESS	\N	2025-11-03 03:26:33.545659	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
470	b6bcb23b-716f-4c4a-aa1b-4bdfb357baf4	SUCCESS	\N	2025-11-03 03:27:10.634469	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
471	cacc67d6-29e6-48d8-9ebe-54d8b15659d7	SUCCESS	\N	2025-11-03 03:28:45.650235	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
472	5dff3d75-3f41-43b1-b4db-a4d160eef6cb	SUCCESS	\N	2025-11-03 03:29:24.68543	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
473	c10880f2-d7c1-4ef4-b7d4-43acc335cf09	SUCCESS	\N	2025-11-03 03:30:11.420454	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
474	56021b73-0ab8-4da7-b342-2515db33f8cc	SUCCESS	\N	2025-11-03 03:30:44.173855	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
475	d0db8883-6037-4b52-8a7c-bcdaa693e1db	SUCCESS	\N	2025-11-03 03:31:20.379672	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
477	90d686fd-eec0-42dc-952a-ae91dd6f1b14	FAILURE	\\x8005958f000000000000007d94288c086578635f74797065948c0f576f726b65724c6f73744572726f72948c0b6578635f6d657373616765948c37576f726b657220657869746564207072656d61747572656c793a207369676e616c203920285349474b494c4c29204a6f623a203130372e9485948c0a6578635f6d6f64756c65948c1362696c6c696172642e657863657074696f6e7394752e	2025-11-03 03:31:56.252046	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
478	d170ab85-5bf2-4ab8-9ccb-6f951a5b18a3	FAILURE	\\x8005958d000000000000007d94288c086578635f74797065948c0f576f726b65724c6f73744572726f72948c0b6578635f6d657373616765948c35576f726b657220657869746564207072656d61747572656c793a207369676e616c203920285349474b494c4c29204a6f623a20302e9485948c0a6578635f6d6f64756c65948c1362696c6c696172642e657863657074696f6e7394752e	2025-11-03 03:51:20.410881	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
479	04372ed3-b550-4ab0-819a-9f748b8c6782	SUCCESS	\N	2025-11-03 03:51:20.410689	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
480	a0fde4c6-38d7-4f54-8834-fe46660b55b7	SUCCESS	\N	2025-11-03 03:51:20.412463	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
482	acc52a50-f306-4218-81d8-50c151c9b847	SUCCESS	\N	2025-11-03 03:51:23.64451	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
481	b4003d48-fea3-40fc-ae1d-f2cb5080fd6e	SUCCESS	\N	2025-11-03 03:51:23.641459	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
483	87ab3dea-6d70-43f3-9b96-4a964e4fef04	SUCCESS	\N	2025-11-03 03:51:33.517228	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
484	c3d56bbf-7586-44a3-91cf-537cd1eaaaa5	SUCCESS	\N	2025-11-03 03:51:33.515677	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
485	38a2b724-c4bd-464c-b18d-18955066cca4	SUCCESS	\N	2025-11-03 03:51:38.629658	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
486	512c5098-b396-4a55-a784-f622191b0590	SUCCESS	\N	2025-11-03 03:51:43.403672	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
487	edcdc3e0-5f91-435f-bc15-2f8eebcb201d	SUCCESS	\N	2025-11-03 03:51:43.445015	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
488	25374a95-82cf-4f30-b3e4-65c8041dd1db	SUCCESS	\N	2025-11-03 03:51:43.467514	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
489	7a0382fb-f82d-407a-ba2b-7e7f3425989c	SUCCESS	\N	2025-11-03 03:51:43.47843	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
490	640843a4-51e6-4be2-ae89-b5a195b29f0d	SUCCESS	\N	2025-11-03 03:51:43.493086	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
491	71d8534e-4f5d-4465-8554-19cd35f77ee4	SUCCESS	\N	2025-11-03 03:51:43.493719	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
493	16a98bbc-c5df-480e-9718-dad5c97dd5e6	SUCCESS	\N	2025-11-03 03:51:43.535667	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
492	c950e6ef-e98e-4e49-b294-81a3f7178341	SUCCESS	\N	2025-11-03 03:51:43.524214	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
494	81cd5505-af7c-463b-b04c-eed93c6e5928	SUCCESS	\N	2025-11-03 03:51:43.555733	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
521	fcbb56ff-efe5-4882-b02f-105245f4dd23	SUCCESS	\N	2025-11-03 04:00:00.139965	\N	celery.backend_cleanup	\\x5b5d	\\x7b7d	celery@75063ac58df2	0	celery
523	957a9db6-2054-4fb4-8bb6-8302f867d15a	SUCCESS	\N	2025-11-03 04:00:46.777988	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
524	57c0f077-6071-485c-9d43-6ee1fc9466c2	SUCCESS	\N	2025-11-03 04:01:16.764307	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
525	f8b8dc4f-6c52-4099-aa49-160bc5d4ae68	SUCCESS	\N	2025-11-03 04:01:46.792333	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
526	c60487b3-97ed-4575-b46e-966d0327b848	SUCCESS	\N	2025-11-03 04:02:16.822481	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
527	a2a83412-7edb-4c97-8e40-43a061af61d8	SUCCESS	\N	2025-11-03 04:02:46.82498	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
528	71d9f676-f4ff-420f-b8da-f00f094f32a1	SUCCESS	\N	2025-11-03 04:03:16.827576	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
529	2c14c358-5537-4f6e-a369-da81c0e266ea	SUCCESS	\N	2025-11-03 04:03:46.833649	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
530	defd5b02-bb8b-4dd6-bab5-c1441147e3fb	SUCCESS	\N	2025-11-03 04:04:16.846565	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
531	d17dcc6b-8e69-4a63-9701-c23f9b7a07d5	SUCCESS	\N	2025-11-03 04:04:46.847195	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
532	1a9f9265-2585-4cf7-896c-72bbf354e0b7	SUCCESS	\N	2025-11-03 04:05:16.856103	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
533	90e76b85-cfbd-4cb7-90f7-f5ab503a6ca1	SUCCESS	\N	2025-11-03 04:05:46.859336	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
534	a722504d-0353-453d-95b2-d41963b0abcc	SUCCESS	\N	2025-11-03 04:06:16.843281	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
535	b84474fd-94b1-4c88-8bcf-930fc9dfbccb	SUCCESS	\N	2025-11-03 04:06:46.842058	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
536	217657a9-f63a-4db4-9c98-ac8f88a6e8c2	SUCCESS	\N	2025-11-03 04:07:16.863113	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
537	b4824d27-c5d0-4b9e-984b-94f233fe6afd	SUCCESS	\N	2025-11-03 04:07:46.875797	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
538	4de11e00-a99a-4c55-b524-e95ff110946c	SUCCESS	\N	2025-11-03 04:08:16.885267	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
539	86b1ae05-7dd1-4f03-9130-6c3cc2f4c750	SUCCESS	\N	2025-11-03 04:08:46.876911	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
540	41f27bdf-1524-4f65-9212-0c692d459537	SUCCESS	\N	2025-11-03 04:09:16.862797	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
541	36f9e4b9-d120-43c1-b00d-ef08bdc70e1d	SUCCESS	\N	2025-11-03 04:09:46.880637	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
542	0b7fde7d-958a-4a10-bf07-ac1c3fa5dbbd	SUCCESS	\N	2025-11-03 04:10:16.895316	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
543	370c0d82-3ee5-49b0-8949-f4d8b5eab738	SUCCESS	\N	2025-11-03 04:10:46.881436	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
544	6ef7f12b-079d-4271-8663-fd8c2d7b3b3e	SUCCESS	\N	2025-11-03 04:11:16.897354	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
545	3bbb4058-f01f-4e45-9aec-2bbd8d1de8fb	SUCCESS	\N	2025-11-03 04:11:46.900751	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
546	4b802ddc-8de5-4170-b8f5-8623a29d8eed	SUCCESS	\N	2025-11-03 04:12:16.8914	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
547	bbeaea6b-e784-4d2c-b12c-dd200ee95284	SUCCESS	\N	2025-11-03 04:12:46.891094	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
548	24e66b81-5eff-4662-b5ed-65a8f72fcd86	SUCCESS	\N	2025-11-03 04:13:16.894546	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
549	68c3de9d-54bd-41f0-b6d5-4b7c78d3d1b0	SUCCESS	\N	2025-11-03 04:13:46.89983	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
550	aab86a48-b8e1-4b4d-a873-5312b2c6f958	SUCCESS	\N	2025-11-03 04:14:16.918217	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
551	02e257b8-4243-40a9-b0b7-0335bd055df4	SUCCESS	\N	2025-11-03 04:14:46.916136	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
552	1c99ecf5-1d37-48ec-ac7a-69815104edf3	SUCCESS	\N	2025-11-03 04:15:16.903729	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
553	e9af3c1d-c6f4-4bec-8f04-ca4a1cdc208e	SUCCESS	\N	2025-11-03 04:15:46.917318	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
554	ffda0d3d-2b57-4be9-b2de-9417f03ffdfb	SUCCESS	\N	2025-11-03 04:16:16.907729	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
555	7ff977a2-2f3a-43d0-8772-8f48a9be0b45	SUCCESS	\N	2025-11-03 04:16:46.930797	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
556	630685cc-2e07-4703-826c-2504f25ce0ab	SUCCESS	\N	2025-11-03 04:17:16.939708	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
557	7ee1eeb0-5003-4042-97d6-3c22878029a0	SUCCESS	\N	2025-11-03 04:17:46.956435	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
558	52e97dc5-37dd-4c71-bebd-65f937a6852f	SUCCESS	\N	2025-11-03 04:18:16.940143	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
559	9680f83f-1be6-4b5d-aae6-9e6407503457	SUCCESS	\N	2025-11-03 04:18:46.93498	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
560	8fe5d61e-085d-4b0b-9abb-9d103a219d71	SUCCESS	\N	2025-11-03 04:19:16.937672	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
561	5e77d9cb-8df0-418a-937c-742c4beabe72	SUCCESS	\N	2025-11-03 04:19:46.932801	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
562	f8915529-26e5-44ae-a06e-327b0dc6e689	SUCCESS	\N	2025-11-03 04:20:16.928433	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
563	dd7f2307-484c-4c2c-95d0-9c2dd7b1aab6	SUCCESS	\N	2025-11-03 04:20:46.957542	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
564	5a519aed-67a3-49c7-acf0-466b278a3c43	SUCCESS	\N	2025-11-03 04:21:16.931978	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
565	f6b9cfe7-d38c-4d66-8930-aadc8d4b7dea	SUCCESS	\N	2025-11-03 04:21:46.959792	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
566	c2f40fc3-d888-41f9-9872-83f5c766eb5f	SUCCESS	\N	2025-11-03 04:22:16.940794	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
567	ff1894c1-3688-4f26-bbc1-3c3dd494a3d7	SUCCESS	\N	2025-11-03 04:22:46.981741	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
568	08a64b79-f974-4ea0-842a-50f8b8f075ed	SUCCESS	\N	2025-11-03 04:23:16.978929	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
569	b75a4b97-3aec-43f7-b6f2-5c6335cd96fb	SUCCESS	\N	2025-11-03 04:23:46.973386	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
570	06e834ba-bec6-4acf-a578-2be7fe6e90ef	SUCCESS	\N	2025-11-03 04:24:16.982867	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
571	e254aada-e85a-464b-9b9e-41b816b9a46d	SUCCESS	\N	2025-11-03 04:24:46.986472	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
572	0170fb89-2e8b-4b20-b17e-fe691873d3cc	SUCCESS	\N	2025-11-03 04:25:16.990351	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
573	aeea5116-25b8-4e2f-9cf3-59d1c38785df	SUCCESS	\N	2025-11-03 04:25:47.008788	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
574	2bce2705-01dc-4615-9f75-948eda2c7eeb	SUCCESS	\N	2025-11-03 04:26:17.001195	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
575	d249e2ef-35c3-47a7-9996-bf47e4f628ad	SUCCESS	\N	2025-11-03 04:26:47.019215	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
576	ab11a8b4-39b5-4e55-943f-ab59ad30c663	SUCCESS	\N	2025-11-03 04:27:17.013141	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
577	d36930cf-1983-41d7-b6b3-b817a2425f81	SUCCESS	\N	2025-11-03 04:27:47.023937	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
578	dfd63dda-9a3e-4510-83a4-07844aab75eb	SUCCESS	\N	2025-11-03 04:28:17.049325	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
579	ad88910e-7e2a-4371-b25b-61819a8ac49e	SUCCESS	\N	2025-11-03 04:28:47.080245	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
580	7544e2c9-8ef0-4dbd-9f85-5ffb9d99e0e0	SUCCESS	\N	2025-11-03 04:29:17.083961	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
581	8802332b-5ae2-48c9-aa8c-7e7945970a88	SUCCESS	\N	2025-11-03 04:29:47.074742	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
582	656b74da-1682-412d-9719-7e4c25e28529	SUCCESS	\N	2025-11-03 04:30:17.077609	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
583	ecfebc6f-6d60-49ba-8e18-d27631e4df7e	SUCCESS	\N	2025-11-03 04:30:47.081824	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
584	6b5d71f1-4500-4919-9aec-3c3eba4ba506	SUCCESS	\N	2025-11-03 04:31:17.074767	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
585	bd8d7781-4971-46a2-a0d5-c1ad212a369e	SUCCESS	\N	2025-11-03 04:31:47.086028	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
586	ceba3922-01a2-4ec2-97d9-076b6afcd454	SUCCESS	\N	2025-11-03 04:32:17.084442	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
587	e7c4046d-fd37-4424-911e-377e257aff11	SUCCESS	\N	2025-11-03 04:32:47.087868	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
588	8f5a75dd-0be0-4b21-ac72-fb04f363ebb7	SUCCESS	\N	2025-11-03 04:33:17.092501	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
589	b5fbdc3a-4365-4d2d-b14b-5b6527d81e42	SUCCESS	\N	2025-11-03 04:33:47.101251	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
590	2187fcab-067c-435f-81a6-d33a2c543465	SUCCESS	\N	2025-11-03 04:34:17.128979	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
591	5d60f4fa-2ff5-4a49-ae51-01083f1fa559	SUCCESS	\N	2025-11-03 04:34:47.208241	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
592	6ea4ab8d-1ccb-48bf-9d2f-cdc0ecd3eb37	SUCCESS	\N	2025-11-03 04:35:17.190791	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
593	0d713ac0-5c88-4f61-9da3-39140f4087b1	SUCCESS	\N	2025-11-03 04:35:47.187317	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
594	efce1268-0430-4da6-8b8a-b1584b9cbe4d	SUCCESS	\N	2025-11-03 04:36:17.193671	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
595	f22536ac-c60b-4dbc-bfe8-7d98b473c632	SUCCESS	\N	2025-11-03 04:36:47.194281	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
596	1b58e67f-89b5-4e43-a5d7-b9e19dd723cf	SUCCESS	\N	2025-11-03 04:37:17.190958	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
597	4c7f9ca3-fb8c-44a5-ade6-f25e96b2f58c	SUCCESS	\N	2025-11-03 04:37:47.198156	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
598	9b78fc9d-e692-4051-bcd6-39305c4dd2c2	SUCCESS	\N	2025-11-03 04:38:17.248128	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
599	ef1795aa-3b7c-4a15-a0f5-06be7f55dd3d	SUCCESS	\N	2025-11-03 04:38:47.280729	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
600	b873056e-0309-45a3-8a2e-6f9ccd02326f	SUCCESS	\N	2025-11-03 04:39:17.299666	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
601	f2a7975a-5ca1-4e94-b4f0-5caead393e9a	SUCCESS	\N	2025-11-03 04:39:47.303819	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
602	82397338-28a6-47c3-9b17-792fea11c1da	SUCCESS	\N	2025-11-03 04:40:17.365457	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
603	d949e241-f0bd-4877-a4e2-a0bb6ba1bc9b	SUCCESS	\N	2025-11-03 04:40:47.397019	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
604	74c72d97-eddc-48af-b6f9-c83cf5e83fc9	SUCCESS	\N	2025-11-03 04:41:17.38674	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
605	ded2e50c-8415-486d-9c2b-7f43bab1e721	SUCCESS	\N	2025-11-03 04:41:47.395292	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
606	64deb469-1eec-47db-b2c4-985bd9a8e14a	SUCCESS	\N	2025-11-03 04:42:17.390451	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
607	a625f6be-f7ea-4b57-b1f8-2b92eeffd2b4	SUCCESS	\N	2025-11-03 04:42:47.402973	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
608	b80a6a11-f8f1-4bdf-aa43-40d77e82c251	SUCCESS	\N	2025-11-03 04:43:17.40881	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
609	97c7486c-5264-43cf-afbf-734a2880c345	SUCCESS	\N	2025-11-03 04:43:47.460531	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
610	1dbbfd42-95b3-43fb-98c3-03df9a41e967	SUCCESS	\N	2025-11-03 04:44:17.46533	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
611	bf5cce13-1e50-4d5d-88db-15de16b79b1b	SUCCESS	\N	2025-11-03 04:44:47.478307	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
612	bdfef782-a3d5-4580-b454-30d937a6e63b	SUCCESS	\N	2025-11-03 04:45:17.483251	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
613	ff17dd73-963c-48fd-8b22-b33fb80edbbb	SUCCESS	\N	2025-11-03 04:45:47.507711	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
614	d64e575f-64bb-42fd-a77c-6cee4a2b56bf	SUCCESS	\N	2025-11-03 04:46:17.514421	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
615	13a3339d-df35-46fe-9b9c-0c1d3198df28	SUCCESS	\N	2025-11-03 04:46:47.599362	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
616	11dc2dd0-35c9-4424-9fc9-96e00aff47b6	SUCCESS	\N	2025-11-03 04:47:17.537357	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
617	5ef517e6-6fc1-48fc-a9e8-009ebc63fa0a	SUCCESS	\N	2025-11-03 04:47:47.566061	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
618	bd50f290-fc31-42df-9e7d-797ef81759ef	SUCCESS	\N	2025-11-03 04:48:17.563854	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
619	e6b491b0-1b29-4949-8bc9-ef2fe797d197	SUCCESS	\N	2025-11-03 04:48:47.576996	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
620	650a39fb-64f0-4ce8-b0a0-43ad91ffb252	SUCCESS	\N	2025-11-03 04:49:17.583146	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
621	1bbdbdd7-21fa-48ee-a574-cc3fd2f56b71	SUCCESS	\N	2025-11-03 04:49:47.59478	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
622	72021875-d232-476e-b3b8-5fd0e2176913	SUCCESS	\N	2025-11-03 04:50:17.616258	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
623	7ad9a089-83a1-4e4c-882a-3a7a1f7865c2	SUCCESS	\N	2025-11-03 04:50:47.640131	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
624	746f940a-4484-4bf5-bb32-6f03d4079433	SUCCESS	\N	2025-11-03 04:51:17.642419	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
625	23efd1a2-74f6-4811-9805-9295d5253c39	SUCCESS	\N	2025-11-03 04:51:47.647703	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
626	69072d39-c518-4eb8-b3c4-e3a4a62ffef0	SUCCESS	\N	2025-11-03 04:52:17.645301	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
627	014a1c0c-6643-446d-ae2d-3c923fbcbad7	SUCCESS	\N	2025-11-03 04:52:47.657954	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
628	c9d6b97b-7aaf-440c-937e-f1a4ef4bb9f9	SUCCESS	\N	2025-11-03 04:53:17.666483	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
629	ac057e38-9409-4706-bdff-435a505c821a	SUCCESS	\N	2025-11-03 04:53:47.689994	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
630	9ef79d5c-19bf-4ece-9f0a-8611a8b0f37a	SUCCESS	\N	2025-11-03 04:54:17.686298	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
631	3f5ec406-0435-4f99-b2de-b5cc332b991c	SUCCESS	\N	2025-11-03 04:54:47.707747	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
632	fd65be2b-bebd-488a-ab40-d5cfe37fa32c	SUCCESS	\N	2025-11-03 04:55:17.714377	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
633	6f961690-4af8-47ff-bc35-91b85e7b44ee	SUCCESS	\N	2025-11-03 04:55:47.741712	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
634	085103c4-6579-4528-9886-fb9af03d56d3	SUCCESS	\N	2025-11-03 04:56:17.729895	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
635	9aefa585-fd63-49cf-ab9f-d410ce1641a0	SUCCESS	\N	2025-11-03 04:56:47.743244	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
636	c69e7385-eda8-48dc-b612-d16cfbc2b0bf	SUCCESS	\N	2025-11-03 04:57:17.777206	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
637	6f473cc3-b8c8-4f02-b414-ae415a1748df	SUCCESS	\N	2025-11-03 04:57:47.779353	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
638	ac33d9ea-98c6-4654-9fe9-28005aacb657	SUCCESS	\N	2025-11-03 04:58:17.765809	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
639	6141ff79-704d-42d9-ab4d-a963b5371962	SUCCESS	\N	2025-11-03 04:58:47.803746	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
640	f30427a8-eb77-4b87-8af5-26d544e63073	SUCCESS	\N	2025-11-03 04:59:17.796723	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
641	6d405b84-df74-49ec-a974-d2d8dd7db82b	SUCCESS	\N	2025-11-03 04:59:47.807387	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
642	bd4ac085-4680-4f74-851b-614d075befc5	SUCCESS	\N	2025-11-03 05:00:17.86978	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
643	02923240-cc82-45d0-ad76-734aa650a5af	SUCCESS	\N	2025-11-03 05:00:47.88545	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
644	b418bf6f-28fa-4f04-b4a9-375ccb744a27	SUCCESS	\N	2025-11-03 05:01:17.871955	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
645	e7a39bab-3cd4-40cf-9be1-5c43ae040fc5	SUCCESS	\N	2025-11-03 05:01:47.879925	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
646	71f46d43-5a30-4251-be5c-2ed13c0258b3	SUCCESS	\N	2025-11-03 05:02:17.910814	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
647	b11f1fb8-d0bd-426d-b264-d74c53c55aa4	SUCCESS	\N	2025-11-03 05:02:47.981062	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
648	3ebc5aa6-a9db-4115-89ca-ea38eaafb4bb	SUCCESS	\N	2025-11-03 05:03:17.954692	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
649	12890db9-5795-4739-acd6-b24994c70fe1	SUCCESS	\N	2025-11-03 05:03:47.962286	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
650	8abdf21c-9d06-47dd-9ea6-cabbab320f0f	SUCCESS	\N	2025-11-03 05:04:17.970589	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
651	46558ca9-5611-40b5-bedd-3fd5c6465095	SUCCESS	\N	2025-11-03 05:04:47.990166	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
652	3a0ff038-3658-499b-8922-2965f82a15a4	SUCCESS	\N	2025-11-03 05:05:17.994282	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
653	8c37ec95-6375-43d0-9dd7-3973fda644ba	SUCCESS	\N	2025-11-03 05:05:48.002672	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
654	4492cecc-72b8-4b69-9eb3-4ac7bf0442ef	SUCCESS	\N	2025-11-03 05:06:18.005753	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
655	3c9243e0-67b4-46a7-be2a-44b01d01643d	SUCCESS	\N	2025-11-03 05:06:48.006595	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
656	b4a578e8-0320-45d2-bb93-a4e631e8ad6f	SUCCESS	\N	2025-11-03 05:07:18.008227	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
657	30db2ca7-7bc0-4b70-afcc-2e5be399943c	SUCCESS	\N	2025-11-03 05:07:48.048843	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
658	6758b73a-75de-45c9-a17a-3da9e2ad9ae2	SUCCESS	\N	2025-11-03 05:08:18.079942	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
659	b4bc5897-83b8-4f91-bfea-ac0f76b68f9a	SUCCESS	\N	2025-11-03 05:08:48.258053	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
660	b7171ac6-9ce6-4dcd-bc33-09fecd357ede	SUCCESS	\N	2025-11-03 05:09:18.233067	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
661	0a13ab34-e0cb-4d91-bba3-db8417565da8	SUCCESS	\N	2025-11-03 05:09:48.21347	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
662	ba558449-9f7c-419d-b2c8-1c6255f5d92c	SUCCESS	\N	2025-11-03 05:10:18.261232	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
663	0ad732c9-cd18-4678-a27c-985e7d84c154	SUCCESS	\N	2025-11-03 05:10:48.24733	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
664	a91d8d73-771b-481c-9934-32cac1186c05	SUCCESS	\N	2025-11-03 05:11:18.254583	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
665	d6c69c26-b6f1-44bb-aa4f-f5dbfad2f00d	SUCCESS	\N	2025-11-03 05:11:48.25992	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
666	8e20bfb1-7da7-4f9c-8771-d25ed010775b	SUCCESS	\N	2025-11-03 05:12:18.265865	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
667	96898fb0-293d-44c1-9a18-2d23883919f6	SUCCESS	\N	2025-11-03 05:12:48.2915	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
668	aa98e3e2-edbf-470b-a2fb-ed758efe251e	SUCCESS	\N	2025-11-03 05:13:18.272427	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
669	933968c7-ede2-42e0-b16f-4928c223b078	SUCCESS	\N	2025-11-03 05:13:48.288491	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
670	85de7582-756e-4b04-a0af-1458d9252812	SUCCESS	\N	2025-11-03 05:14:18.33907	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
671	17f58852-ac6e-462a-bb53-c10ed5c4bc0d	SUCCESS	\N	2025-11-03 05:14:48.340688	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
672	94d76f34-a4b7-4517-bc58-a5c9dd4ff0ae	SUCCESS	\N	2025-11-03 05:15:18.355262	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
673	378fdf35-055d-40c9-8c87-82cd112f1d10	SUCCESS	\N	2025-11-03 05:15:48.4119	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
674	65b5df6c-8944-4e68-9b8d-02f61f0fa25e	SUCCESS	\N	2025-11-03 05:16:18.426013	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
675	23aff84f-578e-42da-a458-717c758710e2	SUCCESS	\N	2025-11-03 05:16:48.416989	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
676	750e1448-91e0-4142-bde0-049da25c5e6d	SUCCESS	\N	2025-11-03 05:17:18.419554	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
677	7dbc0a0a-d8b1-4b0e-97db-1576e878bbf1	SUCCESS	\N	2025-11-03 05:17:48.468556	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
678	f1324f13-31f3-4396-9ded-dc373c240e1b	SUCCESS	\N	2025-11-03 05:18:18.449245	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
679	c64636ce-2629-48f0-ad2d-ab11c52d6ea4	SUCCESS	\N	2025-11-03 05:18:48.452031	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
680	148c2746-b354-412a-bc73-4d65ed4eb71e	SUCCESS	\N	2025-11-03 05:19:18.42615	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
681	027fb5d5-b40a-43fd-b99c-69e2351b73c5	SUCCESS	\N	2025-11-03 05:19:48.458077	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
682	06aa2ce9-2040-4a28-b4a6-528574622976	SUCCESS	\N	2025-11-03 05:20:18.486078	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
683	7bf5d755-64b8-477f-9089-1dcfc12d3072	SUCCESS	\N	2025-11-03 05:20:48.521939	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
684	473ad071-1e0d-4ca9-a714-9818cd97fc2b	SUCCESS	\N	2025-11-03 05:21:18.529327	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
685	a8d1551b-5fa6-42f9-af1d-c7980576e7c5	SUCCESS	\N	2025-11-03 05:21:48.536764	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
686	21911bdf-dba0-44d5-9176-061091b6c7aa	SUCCESS	\N	2025-11-03 05:22:18.570953	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
687	90cac47b-9109-48fb-af46-02d8e34f38d4	SUCCESS	\N	2025-11-03 05:22:48.591678	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
688	512dc4dd-68b2-44b2-9948-fa69dbed0b7e	SUCCESS	\N	2025-11-03 05:23:18.629784	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
689	9e0bcb83-bba5-4ff5-90cb-ee83ba6b0013	SUCCESS	\N	2025-11-03 05:23:48.629881	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
690	abed2663-47c1-49d5-b39f-89d7e395f3ea	SUCCESS	\N	2025-11-03 05:24:18.663822	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
691	605512d3-16ea-4aeb-b0de-9efc2842e3e8	SUCCESS	\N	2025-11-03 05:24:48.649638	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
692	82eaac7b-f703-4050-8ab7-b666987c5000	SUCCESS	\N	2025-11-03 05:25:18.658665	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
693	05780b2d-1a94-4ea9-b866-d845fa3374fd	SUCCESS	\N	2025-11-03 05:25:48.716173	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
694	e14b2649-8e3b-4f1b-b41c-f588c2268d0b	SUCCESS	\N	2025-11-03 05:26:18.721818	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
695	82ae5016-b3ab-4175-bac9-e0923ac4b287	SUCCESS	\N	2025-11-03 05:26:48.808089	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
696	b244f5cf-1454-4002-a10a-e1d97c155be1	SUCCESS	\N	2025-11-03 05:27:18.782846	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
697	b3cd8d4d-cdd8-4b6c-9873-ad24ef8f32b6	SUCCESS	\N	2025-11-03 05:27:48.837314	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
698	d6207168-a1e1-43dd-b7d5-6b2d93e09d81	SUCCESS	\N	2025-11-03 05:28:18.841285	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
699	2002fbbc-092c-46f1-81c8-94062045f9f4	SUCCESS	\N	2025-11-03 05:28:48.973982	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
700	1ff4e615-8fa4-4aad-90b0-19c924d54329	SUCCESS	\N	2025-11-03 05:29:18.903481	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
701	071e3816-8cdc-43c7-8850-6645a9346f4a	SUCCESS	\N	2025-11-03 05:29:48.904466	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
702	ebba9661-9aa4-4583-aeb1-6ab392f44a6d	SUCCESS	\N	2025-11-03 05:30:18.909347	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
703	345456b5-f0da-4676-857a-33fe3f6247da	SUCCESS	\N	2025-11-03 05:30:48.924304	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
704	4314b834-2219-4584-8c0b-8313416e615a	SUCCESS	\N	2025-11-03 05:31:18.930276	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
705	84373655-0bf4-4fda-b794-620704594f24	SUCCESS	\N	2025-11-03 05:31:49.00224	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
706	11e6e66b-5f5e-42a4-b680-f6b0ed3300d0	SUCCESS	\N	2025-11-03 05:32:18.994587	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
707	5084fcee-9074-46ce-bd31-00759fc1a4c7	SUCCESS	\N	2025-11-03 05:32:49.007314	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
708	a2c116c3-0b33-4e89-8d86-694050b810d5	SUCCESS	\N	2025-11-03 05:33:18.996607	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
709	e903c8bc-445b-4add-98f6-bd2ed3dcfc34	SUCCESS	\N	2025-11-03 05:33:49.015021	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
710	d340ecd0-3d72-4b3d-963c-dd2b6b22efb5	SUCCESS	\N	2025-11-03 05:34:19.0136	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
711	a94c4b97-ce89-4b6a-ae09-11438a921adb	SUCCESS	\N	2025-11-03 05:34:49.030872	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
712	f4c70255-299e-40cd-b302-a0e6dc100d2e	SUCCESS	\N	2025-11-03 05:35:19.047642	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
713	7422c2cb-e716-4506-b2f3-6aff450fb4d5	SUCCESS	\N	2025-11-03 05:35:49.050627	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
714	cc21eb6b-903d-423f-b43f-d177fb8b2973	SUCCESS	\N	2025-11-03 05:36:19.047713	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
715	b1818710-8b88-433b-8248-92fa013f629c	SUCCESS	\N	2025-11-03 05:36:49.057823	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
716	5bfdbc94-83c8-488c-bf17-3e10b394b1db	SUCCESS	\N	2025-11-03 05:37:19.04731	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
717	b372bc3f-8ed4-4e70-9f13-a3d5cc989364	SUCCESS	\N	2025-11-03 05:37:49.061241	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
718	f018e03e-7adb-443d-84e7-19db680caa7c	SUCCESS	\N	2025-11-03 05:38:19.064832	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
719	b366120b-90cd-4055-8cdf-e75ea4fb345d	SUCCESS	\N	2025-11-03 05:38:49.072484	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
720	6f6dd54f-03ad-4a9a-a989-354f24cd37b6	SUCCESS	\N	2025-11-03 05:39:19.078082	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
721	556db51b-c385-41e2-9a32-825338bf4bad	SUCCESS	\N	2025-11-03 05:39:49.08352	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
722	98926df4-9591-42b5-8ea1-7874d5c7d881	SUCCESS	\N	2025-11-03 05:40:19.389546	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
723	26095117-d1de-4747-ba4e-f98392bfd37c	SUCCESS	\N	2025-11-03 05:40:49.333402	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
724	aa24086c-a44e-4b88-a901-61fbf2ba9996	SUCCESS	\N	2025-11-03 05:41:19.333317	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
725	91833fc8-d699-463c-b7ed-a8b3fcb3921c	SUCCESS	\N	2025-11-03 05:41:49.332875	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
726	7c2632c4-376e-4385-aaaa-acbc71f6d28d	SUCCESS	\N	2025-11-03 05:42:19.338713	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
727	6b52f2b7-9c22-4b91-8c19-fb1736926e3a	SUCCESS	\N	2025-11-03 05:42:49.386904	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
728	608a4357-e95d-4cca-bbc4-cdfeff2a3404	SUCCESS	\N	2025-11-03 05:43:19.378938	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
729	d477760f-77ec-456b-821d-abc92965fa60	SUCCESS	\N	2025-11-03 05:43:49.447378	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
730	cb776b86-4326-4d19-bdbc-fcee3c7c1dd7	SUCCESS	\N	2025-11-03 05:44:19.432158	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
731	b08ec72b-039f-4ff8-857b-d1323c6f5d26	SUCCESS	\N	2025-11-03 05:44:49.417697	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
732	fef15c74-ab88-4ef6-b230-fd12b103194b	SUCCESS	\N	2025-11-03 05:45:19.437101	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
733	4e3dc285-c1f2-47d2-8399-9acb54e0b483	SUCCESS	\N	2025-11-03 05:45:49.440531	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
734	2f1de0fd-6d68-4e98-93e7-d8957cf5468c	SUCCESS	\N	2025-11-03 05:46:19.455431	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
735	7912b526-ec54-4dc3-b8f9-faf0721be15b	SUCCESS	\N	2025-11-03 05:46:49.445102	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
736	f9a0c323-c953-4326-ae63-465fd07282c0	SUCCESS	\N	2025-11-03 05:47:19.467219	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
737	735b5cd3-ca23-4245-9be0-17fae60dbb83	SUCCESS	\N	2025-11-03 05:47:49.48218	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
738	16135f87-a491-4257-9acc-703571ea6d6d	SUCCESS	\N	2025-11-03 05:48:19.505392	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
739	e7b73da2-5cc0-47fc-a8bb-fc31ebdd39fa	SUCCESS	\N	2025-11-03 05:48:49.541243	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
740	c9e282bc-1292-44cd-a2a3-111f32468af4	SUCCESS	\N	2025-11-03 05:49:19.535055	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
741	c4b4344c-cb72-490f-8ac0-c3895837d464	SUCCESS	\N	2025-11-03 05:49:49.553752	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
742	5723290c-bbba-4b4f-8b66-3bd631890ece	SUCCESS	\N	2025-11-03 05:50:19.555463	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
743	d11610b3-bd02-4202-bb8d-5bf36f66a5c5	SUCCESS	\N	2025-11-03 05:50:49.55019	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
744	fcb82541-6e5d-4764-aade-aeb6a74a2468	SUCCESS	\N	2025-11-03 05:51:19.56672	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
745	f57ca204-0ad5-4dd7-8085-e401568fe105	SUCCESS	\N	2025-11-03 05:51:49.564438	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
746	dc7bbfe3-2ee0-4a98-8e5c-d63d9c9fc8e9	SUCCESS	\N	2025-11-03 05:52:19.566314	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
747	bc3fcdab-e84f-441e-9edb-120d01a1e624	SUCCESS	\N	2025-11-03 05:52:49.574868	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
748	ed34718f-fcc6-4957-9d9b-de3a304a4b32	SUCCESS	\N	2025-11-03 05:53:19.580734	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
749	d78ffb46-939e-40da-ad2d-9f5bee9dbd94	SUCCESS	\N	2025-11-03 05:53:49.593088	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
750	5a1f4e50-af8e-47db-bc81-33f6c0158b6c	SUCCESS	\N	2025-11-03 05:54:19.590769	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
751	62828847-cef7-4504-8217-f7364e0d58b4	SUCCESS	\N	2025-11-03 05:54:49.601912	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
752	81fb7a8e-2294-4fc5-bd1b-38df618d9e64	SUCCESS	\N	2025-11-03 05:55:19.622059	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
753	5c6ae73a-530e-4210-a976-23f6541ea1a1	SUCCESS	\N	2025-11-03 05:55:49.661103	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
754	a910dd70-3429-4de3-bfab-aa6c9372218c	SUCCESS	\N	2025-11-03 05:56:19.661234	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
755	a20c5602-3620-4b48-ae2f-399a42aeb248	SUCCESS	\N	2025-11-03 05:56:49.648314	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
756	455db413-f042-489e-b52d-b9cf5470fe8c	SUCCESS	\N	2025-11-03 05:57:19.636171	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
757	60cc97f4-b9a3-44c6-8007-83660160aa01	SUCCESS	\N	2025-11-03 05:57:49.623237	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
758	cde25093-924a-4303-9f47-3c97b5b9bb3e	SUCCESS	\N	2025-11-03 05:58:19.629768	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
759	9d6552d9-647f-45ee-ae31-de6fc9292fa3	SUCCESS	\N	2025-11-03 05:58:49.629647	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
760	fe6df9a4-93f9-4e87-8f5d-f3872b96660c	SUCCESS	\N	2025-11-03 05:59:19.639532	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
761	6f5e5a36-9a5c-44fb-a923-6f33faef801a	SUCCESS	\N	2025-11-03 05:59:49.629864	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
762	541eb64e-f678-477a-888c-b05eaae4177c	SUCCESS	\N	2025-11-03 06:00:19.654865	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
763	b7e64da3-0ac9-4f2f-a2d6-bb0393beef49	SUCCESS	\N	2025-11-03 06:00:49.632529	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
764	2f337a3d-b384-41d4-9b03-531936a94aef	SUCCESS	\N	2025-11-03 06:01:19.65067	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
765	c8886559-0c6a-4f75-8154-2193118a98c8	SUCCESS	\N	2025-11-03 06:01:49.636067	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
766	1ef2d379-9389-48cb-8e31-3bbf3780550c	SUCCESS	\N	2025-11-03 06:02:19.649602	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
767	d453d61c-a459-4201-8a77-b1447beceb98	SUCCESS	\N	2025-11-03 06:02:49.644253	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
768	1ed3ca75-d710-4093-8c6d-377e21ba4ecb	SUCCESS	\N	2025-11-03 06:03:19.643313	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
769	d3a258c3-e84d-4840-be99-a4b69449ff74	SUCCESS	\N	2025-11-03 06:03:49.650181	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
770	ed0f30da-67db-4dc7-9923-f18083953958	SUCCESS	\N	2025-11-03 06:04:19.651762	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
771	2e228135-8ca2-4738-9d02-5682a2f11296	SUCCESS	\N	2025-11-03 06:04:49.660232	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
772	2ca98821-4053-46db-9a0a-4dfbdbee6730	SUCCESS	\N	2025-11-03 06:05:19.650336	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
773	ee56361f-b9e5-4bee-af64-6ca220c92a4f	SUCCESS	\N	2025-11-03 06:05:49.657945	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
774	96acfb1e-d27d-4961-b472-6826fcaa4e9a	SUCCESS	\N	2025-11-03 06:06:19.655403	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
775	30943482-01db-4969-8f30-cbde89a9d61f	SUCCESS	\N	2025-11-03 06:06:49.670388	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
776	50dc4bb0-8905-4f73-96d7-3b4eb84849f8	SUCCESS	\N	2025-11-03 06:07:19.660753	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
777	c20fc3be-86f1-45a3-bd22-038b2fc5b7a9	SUCCESS	\N	2025-11-03 06:07:49.688207	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
778	558df72a-3980-48f0-b7d6-dfa4e34b9816	SUCCESS	\N	2025-11-03 06:08:19.674482	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
779	2184ebcc-36b2-4e01-a316-f4bbde7bdad0	SUCCESS	\N	2025-11-03 06:08:49.695717	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
780	38c0f8b5-fe9a-4ecc-b213-8ae35da0ebdc	SUCCESS	\N	2025-11-03 06:09:19.681627	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
781	3a05e80b-53ec-4d9d-b6ec-122d1d1e717a	SUCCESS	\N	2025-11-03 06:09:49.695793	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
782	07831756-48b5-4ff2-9015-83f58afc4b50	SUCCESS	\N	2025-11-03 06:10:19.697945	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
783	87bc33b1-ffd8-4d69-9ec5-31d8722691bb	SUCCESS	\N	2025-11-03 06:10:49.711228	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
784	00b4af27-75cd-4e31-9eee-94d4cba9ba0f	SUCCESS	\N	2025-11-03 06:11:19.707756	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
785	1616dcd2-d422-45d8-9dbf-bb6971f7a349	SUCCESS	\N	2025-11-03 06:11:49.724323	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
786	67e0863c-13d8-4ef5-a307-6063dfab26ff	SUCCESS	\N	2025-11-03 06:12:19.714288	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
787	159167cc-3a03-4ff1-8110-4f2ef5aeca5b	SUCCESS	\N	2025-11-03 06:12:49.724579	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
788	17fd42b0-e352-4ce1-b550-e8dbc380b023	SUCCESS	\N	2025-11-03 06:13:19.716176	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
789	df5b7249-05a2-408d-9386-21144a7f2ae1	SUCCESS	\N	2025-11-03 06:13:49.72087	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
790	cd0f6df6-816d-49a5-aef0-8aa7879649f6	SUCCESS	\N	2025-11-03 06:14:19.724275	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
791	037dd575-1673-40dd-8a68-3514bfc325af	SUCCESS	\N	2025-11-03 06:14:49.739472	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
792	1fd17c39-854f-4ca1-bc4f-762e706b0d33	SUCCESS	\N	2025-11-03 06:15:19.728918	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
793	d647d1a6-0875-4131-8d57-439c34e03f56	SUCCESS	\N	2025-11-03 06:15:49.745384	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
794	b2b87d99-890b-4b39-9340-e9b12c01d61e	SUCCESS	\N	2025-11-03 06:16:19.733997	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
795	0b304477-141d-4dc2-8edc-06d94a38776a	SUCCESS	\N	2025-11-03 06:16:49.767509	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
796	b700e350-1b0c-42e3-b11b-7ebaa9c6c339	SUCCESS	\N	2025-11-03 06:17:27.935935	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
797	1fb9db77-cda5-4061-a810-e2d39e984bc2	SUCCESS	\N	2025-11-03 06:17:59.214545	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
798	435574e1-c78a-472f-8a3f-f50cd4f98a70	SUCCESS	\N	2025-11-03 06:18:25.788628	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
799	0c27a700-58dd-4236-ae41-b3e1638178ad	SUCCESS	\N	2025-11-03 06:18:55.691819	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
809	6b452efe-05a5-4690-88f4-797d52ebba78	SUCCESS	\N	2025-11-03 06:23:55.754752	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
800	6422dcbd-6584-4b20-86f0-d212a39a893d	SUCCESS	\N	2025-11-03 06:19:25.690922	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
801	622ca0af-24bd-480a-b354-88383f86228b	SUCCESS	\N	2025-11-03 06:19:55.719472	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
802	47352c2f-1bf3-4715-8f78-d3c9a50b5fde	SUCCESS	\N	2025-11-03 06:20:25.710459	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
803	20912676-f156-480f-a5cd-6115130477ae	SUCCESS	\N	2025-11-03 06:20:55.721763	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
804	ad435cfa-b0e9-4393-9748-b7f0b86fb768	SUCCESS	\N	2025-11-03 06:21:25.714017	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
805	383b1d07-c036-49f5-9580-91ec109b4807	SUCCESS	\N	2025-11-03 06:21:55.723166	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
806	9f5d9b07-b4c7-4e2f-8001-400948b867d7	SUCCESS	\N	2025-11-03 06:22:25.72572	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
807	c95e17a7-9695-45fb-8a7c-912d968b706c	SUCCESS	\N	2025-11-03 06:22:55.747897	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
808	305c8778-e0ac-4119-98c9-069bfc0316de	SUCCESS	\N	2025-11-03 06:23:25.740645	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
810	83c17adf-98f9-480a-b85b-94eb064b06fd	SUCCESS	\N	2025-11-03 06:24:25.751566	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
811	0a462c67-b67c-4881-8c0d-709ab640ac38	SUCCESS	\N	2025-11-03 06:24:55.759808	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
812	4121bc29-e5d9-4c34-889d-c5f83debebfd	SUCCESS	\N	2025-11-03 06:25:25.772172	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
813	74f78bd2-f1be-4e0b-bc77-9d054ddfb5db	SUCCESS	\N	2025-11-03 06:25:55.782195	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
814	1a94a259-423e-46aa-91ea-67b1f4e85a12	SUCCESS	\N	2025-11-03 06:26:25.779741	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
815	5c04b53a-5565-4b65-99b6-424b2704d408	SUCCESS	\N	2025-11-03 06:26:55.794374	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
816	3b46674e-4a7f-42a4-b785-f45e88bff3d9	SUCCESS	\N	2025-11-03 06:27:25.783345	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
817	8e7db477-11fe-443e-b7d0-fd427733f633	SUCCESS	\N	2025-11-03 06:27:55.812866	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
818	30ce891c-6561-439d-9f64-1c74bc40de83	SUCCESS	\N	2025-11-03 06:28:25.851008	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
819	161dddc0-c382-4642-8e39-04a4865784af	SUCCESS	\N	2025-11-03 06:29:04.92979	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
820	b93f40bc-b88c-4f0d-987e-da9ebb9bfb72	SUCCESS	\N	2025-11-03 06:29:38.218429	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
821	69edd05f-ddf0-4090-b76a-dd25532d9717	SUCCESS	\N	2025-11-03 06:30:11.85537	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
822	582de393-0eaa-4ab6-884d-63371b6d31ee	SUCCESS	\N	2025-11-03 06:30:40.575203	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
823	041ed050-dcaa-446f-946f-57a9127eede5	SUCCESS	\N	2025-11-03 06:31:16.726225	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
824	3fb6759a-01d7-42eb-8888-b02020b52fab	SUCCESS	\N	2025-11-03 06:31:46.75088	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
825	f4395dab-a48f-4152-9ea8-194295eae4e4	SUCCESS	\N	2025-11-03 06:32:19.75338	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
826	2cf53464-4f91-4e93-ab75-af296f168265	SUCCESS	\N	2025-11-03 06:32:51.815589	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
827	d0e4e59f-cfc2-422f-b9be-196809430068	SUCCESS	\N	2025-11-03 06:33:22.712554	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
828	7177b8d3-848b-43c1-8964-636da8ac277a	SUCCESS	\N	2025-11-03 06:34:09.714019	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
829	30939066-31ee-4395-b833-b7c9584a1ad3	SUCCESS	\N	2025-11-03 06:34:32.275754	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
830	5885b8d9-bc9c-4dfa-8eb0-9acdecefef64	SUCCESS	\N	2025-11-03 06:35:04.179615	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
831	58154731-9134-4a1e-8005-aad8e1550f57	SUCCESS	\N	2025-11-03 06:35:46.464103	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
832	abdceed5-be71-44ee-bd96-8b32f702513c	SUCCESS	\N	2025-11-03 06:36:16.476718	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
833	bb8d61e9-6532-4b0b-b68b-29c07929161d	SUCCESS	\N	2025-11-03 06:36:58.153573	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
834	dcb5c6c5-7b37-4167-80ed-f20101bab7ec	SUCCESS	\N	2025-11-03 06:38:25.607992	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
835	d439b73c-a411-4898-ab5d-f223815613ba	SUCCESS	\N	2025-11-03 06:38:47.30025	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
836	279106c5-1258-4628-9149-1c194f6e0111	SUCCESS	\N	2025-11-03 06:39:02.723623	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
837	8bf657c7-2b54-476c-916a-def6d4339e64	SUCCESS	\N	2025-11-03 06:39:27.64945	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
838	bf0057f5-a4e9-41ba-a30d-01075f5cab41	SUCCESS	\N	2025-11-03 06:40:05.379009	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
839	62547f39-6ecf-4362-90ea-0ed6708a6d4b	SUCCESS	\N	2025-11-03 06:40:45.347645	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
840	5272602c-582d-4fb0-b0b9-43b96ebd4249	SUCCESS	\N	2025-11-03 06:41:17.605939	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
841	33fb2bdc-9a09-4c5b-99e5-938e9480b945	SUCCESS	\N	2025-11-03 06:41:50.067755	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
842	78d603b9-7c79-4ddd-8824-5c313586a7ba	SUCCESS	\N	2025-11-03 06:43:00.618822	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
843	3affae5b-a45b-496e-b70f-1d6a88ba8bde	SUCCESS	\N	2025-11-03 06:43:09.80762	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
844	816d00d6-ea7a-4dd7-8df8-df9b3fc93daa	SUCCESS	\N	2025-11-03 06:43:57.209599	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
845	6cb9eeb4-3f57-4994-ba75-4286edcba8ea	SUCCESS	\N	2025-11-03 06:44:39.123139	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
846	1631c0c4-bf7c-42b1-8690-b27c77a91d4b	SUCCESS	\N	2025-11-03 06:45:09.576362	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
847	8bc211d7-f33b-4f6d-9b4e-bbf5dbdf12c6	SUCCESS	\N	2025-11-03 06:45:35.940933	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
848	5ea3bd8d-ac68-4eeb-8926-664e9937eec0	SUCCESS	\N	2025-11-03 06:46:16.463688	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
849	04cc25b1-949f-4a13-a020-4dea95957b80	SUCCESS	\N	2025-11-03 06:46:41.255669	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
850	e69923cf-0d9e-4bc1-aa0a-696815c6942d	SUCCESS	\N	2025-11-03 06:47:25.769487	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
851	b2b230a9-cc15-4a56-a32b-a6997bab5b3e	SUCCESS	\N	2025-11-03 06:47:54.494736	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
852	7f5fa86c-e47c-4f6f-bc1b-4ba99095d422	SUCCESS	\N	2025-11-03 06:48:40.925298	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
853	aba3e221-3336-49ee-8283-7d590f4797be	SUCCESS	\N	2025-11-03 06:49:17.494251	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
854	91045c45-8df2-44a8-b2ca-345bbd74f327	SUCCESS	\N	2025-11-03 06:49:47.448066	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
855	7f2eb900-526b-4d45-9b79-fbaeed6d2136	SUCCESS	\N	2025-11-03 06:51:01.248869	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
856	233000ad-2bb5-4075-945e-1dea50c14f28	SUCCESS	\N	2025-11-03 06:51:11.635232	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
857	d1703a5f-353c-44d9-bf69-6ad2768c4299	SUCCESS	\N	2025-11-03 06:51:41.208506	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
858	ef369be2-c645-434a-ac89-e2a57d95bbcc	SUCCESS	\N	2025-11-03 06:52:51.485052	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
859	3ed7c5a1-1a33-44e3-a955-3dae66a1e255	SUCCESS	\N	2025-11-03 06:53:22.851859	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
860	35081f2b-6689-426e-bf43-312923913213	SUCCESS	\N	2025-11-03 06:53:51.459637	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
861	ea574a74-d139-494c-9cc5-81e4cc5b02d6	SUCCESS	\N	2025-11-03 06:54:32.790815	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
862	2d896672-61af-4d61-a0c5-c6a839389dfc	SUCCESS	\N	2025-11-03 07:12:19.808463	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
863	44185ddc-8f06-44ae-a795-252f16c1c196	SUCCESS	\N	2025-11-03 07:12:30.709437	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
864	3edf2193-de79-4fb3-b098-1c12a72c2ffe	SUCCESS	\N	2025-11-03 07:13:06.532384	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
865	21425842-ea47-4850-ab60-d2ba3bda7888	SUCCESS	\N	2025-11-03 07:13:47.847455	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
866	af6cd476-ab2e-4246-8d1c-f8a83b33e26e	SUCCESS	\N	2025-11-03 07:14:09.66846	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
867	25e52815-eb12-4ce5-84da-30a56e5a962f	SUCCESS	\N	2025-11-03 07:14:41.489518	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
868	9042a18c-5505-490e-82ad-3baf1533013f	SUCCESS	\N	2025-11-03 07:15:22.672237	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
869	c6e661a4-bac1-4f1b-8eb6-bd1baa49bcb5	SUCCESS	\N	2025-11-03 07:31:39.121051	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
870	0ad325d3-d6e3-403e-8bc9-72dda3a13667	SUCCESS	\N	2025-11-03 07:31:39.16031	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
871	09da982e-6d10-4d44-a564-f9828838b1fc	SUCCESS	\N	2025-11-03 07:31:41.358444	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
872	0dbd98b1-be2d-411b-bb93-6e1c4669195f	SUCCESS	\N	2025-11-03 07:31:41.358317	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
873	3cc4068b-03a3-4d73-a4ac-43c7468d454c	SUCCESS	\N	2025-11-03 07:31:41.393878	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
874	59465caf-2bc2-4630-821d-353beb44c15b	SUCCESS	\N	2025-11-03 07:31:41.397045	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
875	ec99aeeb-c7a6-449d-958e-3cecc477d5cb	SUCCESS	\N	2025-11-03 07:31:41.408573	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
876	16db2ce0-9d5a-4717-b5bb-1154d50d3d09	SUCCESS	\N	2025-11-03 07:31:41.412089	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
877	6419e2e4-f2d6-4541-8850-72e22a6a2f7c	SUCCESS	\N	2025-11-03 07:31:41.415917	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
878	7db043f7-bf7a-4df2-9f42-0b8a99e21c6e	SUCCESS	\N	2025-11-03 07:31:41.421843	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
879	81da888d-6f6a-4cb4-b26c-1d0a6ced1cf1	SUCCESS	\N	2025-11-03 07:31:41.422295	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
881	63b6a640-8c15-4c31-97ac-82cc46e87923	SUCCESS	\N	2025-11-03 07:31:41.429935	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
880	8b2a71aa-6a94-4a3a-abe6-ca0d7346bdda	SUCCESS	\N	2025-11-03 07:31:41.429877	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
882	76793f82-2a58-4c48-b440-65d7c41342d9	SUCCESS	\N	2025-11-03 07:31:41.4385	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
883	24a4e9eb-5e65-41a3-bfe1-052ab38fe890	SUCCESS	\N	2025-11-03 07:31:41.440048	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
885	2a1656e9-8141-4445-8bfc-014947002702	SUCCESS	\N	2025-11-03 07:31:41.4581	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
884	32232214-bfee-4ce8-95f6-fd0c4d0e2283	SUCCESS	\N	2025-11-03 07:31:41.456718	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
886	bb9a73dc-9204-4f72-ba91-65905ce68ba8	SUCCESS	\N	2025-11-03 07:31:41.492759	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
892	ad6fea14-2703-4dcd-8775-cae8604d9603	SUCCESS	\N	2025-11-03 07:31:41.539942	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
897	4b7d02f1-3180-47c3-baff-88f43727a934	SUCCESS	\N	2025-11-03 07:31:41.548942	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
887	71efe936-d6b9-4e8c-ba8d-12f698068be9	SUCCESS	\N	2025-11-03 07:31:41.527777	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
893	048e32be-8de3-41e1-992f-406db23b1338	SUCCESS	\N	2025-11-03 07:31:41.541094	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
888	be72b21b-ecda-44c1-ac55-809bee133840	SUCCESS	\N	2025-11-03 07:31:41.532463	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
889	aa1a3606-9c33-4069-b63a-abbce26e0f10	SUCCESS	\N	2025-11-03 07:31:41.53482	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
890	1625522a-4dfe-49f8-b454-a7c42ea63fc1	SUCCESS	\N	2025-11-03 07:31:41.535887	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
891	e7f04a80-90cf-40a0-af79-86c145c6a2e5	SUCCESS	\N	2025-11-03 07:31:41.538815	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
894	f313b36b-eadd-45a3-aa55-fc2cb246b916	SUCCESS	\N	2025-11-03 07:31:41.543446	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
895	2a458268-f4cf-4723-8d0c-32cc0f90f351	SUCCESS	\N	2025-11-03 07:31:41.544468	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
896	fb107c9e-3cd0-4f6e-a99a-24bdf0485a48	SUCCESS	\N	2025-11-03 07:31:41.547226	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
941	5deeb570-4403-4f4f-9f16-c17b0ee83b6a	SUCCESS	\N	2025-11-03 15:17:08.833344	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
898	c307c028-3efe-4d0f-9cef-db7e8a44f7f6	SUCCESS	\N	2025-11-03 07:31:41.55291	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
899	12ec1958-6b00-47e6-8b29-14d046ab9278	SUCCESS	\N	2025-11-03 07:31:41.553059	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
900	9d8190fe-58b3-47cf-9445-f11681205689	SUCCESS	\N	2025-11-03 07:31:44.116483	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
901	c02783d4-bbd2-4759-a5f5-3c674f5a20dc	SUCCESS	\N	2025-11-03 07:32:28.311655	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
940	c5409b35-895b-455c-881e-479d407c495f	SUCCESS	\N	2025-11-03 15:17:08.833198	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
942	b65d5e78-98f3-4273-b23d-03c64e18a039	SUCCESS	\N	2025-11-03 15:17:08.836408	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
943	48c80c2e-7d41-43a0-8035-05b4644dd07d	SUCCESS	\N	2025-11-03 15:17:08.842894	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
944	b0106094-a676-457f-a88a-07cab367d958	SUCCESS	\N	2025-11-03 15:17:08.848272	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
910	b7a989ba-53de-411f-a543-399ccbc7de34	SUCCESS	\N	2025-11-03 07:36:57.991382	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
911	55b8ba41-f95b-444f-9727-8c3f4486b32a	SUCCESS	\N	2025-11-03 07:37:28.066197	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
912	01cfccf4-1a8b-4188-b3e5-0e5e4d1113c7	SUCCESS	\N	2025-11-03 07:37:58.103182	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
913	10d1bc2f-0215-487a-a01a-21e53edbecf3	SUCCESS	\N	2025-11-03 07:38:28.831853	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
902	caf373c5-aea7-42f9-8107-fdd476459e0d	SUCCESS	\N	2025-11-03 07:34:00.982375	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
903	e663f8c3-79c9-4161-9ac4-2e7a29855ae5	SUCCESS	\N	2025-11-03 07:34:04.65263	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
904	91e8664b-912e-4f21-a7df-9a43047c9807	SUCCESS	\N	2025-11-03 07:34:06.344019	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
905	5379b91d-d79d-4245-9911-5ea0b6cd7f2c	SUCCESS	\N	2025-11-03 07:34:27.981728	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
906	88545a70-7242-46b3-a122-2fa8c0c69c19	SUCCESS	\N	2025-11-03 07:34:57.971305	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
907	b5965523-39f2-496a-aa32-5afa74b9c2ce	SUCCESS	\N	2025-11-03 07:35:27.965814	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
908	2d800e19-118e-4082-82cc-09795ff8c49b	SUCCESS	\N	2025-11-03 07:35:57.975572	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
909	e8ab8a6a-9331-4ffc-b089-321e609268dd	SUCCESS	\N	2025-11-03 07:36:27.988457	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
914	2ea72ab2-69e0-4436-95ee-cfcc3843364b	SUCCESS	\N	2025-11-03 07:39:00.855553	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
915	1cd816e9-65c1-486a-97a7-56f2e4712f8d	SUCCESS	\N	2025-11-03 07:39:30.831008	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
916	c1c265bd-b7b9-4556-86c0-5c743bc13149	SUCCESS	\N	2025-11-03 07:40:01.941191	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
917	b4545cb1-fce7-4605-b977-540e862dcc71	SUCCESS	\N	2025-11-03 07:40:32.192636	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
918	cea9b191-b1af-4f32-a749-ac030f4bf138	SUCCESS	\N	2025-11-03 07:41:02.660565	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
919	fc22deeb-e60b-4355-9f00-cd90afbc7359	SUCCESS	\N	2025-11-03 07:41:42.295085	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
920	4007effa-adf2-4e1e-9444-94286167c333	SUCCESS	\N	2025-11-03 07:42:11.762824	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
921	3bddc5d2-eca5-4fec-b608-02ae34aa7632	SUCCESS	\N	2025-11-03 07:42:52.761432	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
922	a61cd9f6-3487-4deb-b786-1ab6016d61d9	SUCCESS	\N	2025-11-03 07:43:22.559782	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
923	13b8e920-21a4-4ac6-b5bc-98ccfb355c9f	SUCCESS	\N	2025-11-03 07:44:01.329676	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
924	38bda04f-332f-4f22-bd72-cbd4d87adec8	SUCCESS	\N	2025-11-03 07:44:44.374121	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
925	81e8f68f-8ac5-45d3-a401-836717b3f554	SUCCESS	\N	2025-11-03 07:45:14.092403	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
926	0b10d517-6a27-4c58-aa98-2ad41ec86b56	SUCCESS	\N	2025-11-03 07:45:54.745493	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
927	2cb27569-6f39-4d44-8281-c036342d9575	SUCCESS	\N	2025-11-03 07:46:40.483253	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
928	f617d784-9133-481d-b97d-a0fb9ef4dd58	SUCCESS	\N	2025-11-03 07:47:13.702094	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
929	bb0a79fc-bc68-4c84-ad3a-2ea8fe42cf79	SUCCESS	\N	2025-11-03 07:47:47.670925	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
930	58d7c73a-afd8-4c84-8514-38e07975ee1a	SUCCESS	\N	2025-11-03 07:48:13.711412	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
931	63b70c0e-219d-4f73-9700-0f83cbdc58ad	SUCCESS	\N	2025-11-03 07:49:05.224602	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
934	d268392d-8d5b-4067-af78-403f4fd598cf	SUCCESS	\N	2025-11-03 07:50:45.829234	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
932	3a502b59-5647-4caa-ab4b-72af10062207	FAILURE	\\x8005958e000000000000007d94288c086578635f74797065948c0f576f726b65724c6f73744572726f72948c0b6578635f6d657373616765948c36576f726b657220657869746564207072656d61747572656c793a207369676e616c203920285349474b494c4c29204a6f623a2038332e9485948c0a6578635f6d6f64756c65948c1362696c6c696172642e657863657074696f6e7394752e	2025-11-03 07:50:13.489026	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
933	618e680f-93cf-4416-a09f-a48962478e8f	SUCCESS	\N	2025-11-03 07:50:37.064449	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
935	116abbcb-ff84-4830-8455-047a6d2d6573	SUCCESS	\N	2025-11-03 07:51:47.331945	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
936	66232a8d-b9fa-4cc0-a175-4231d96cdbbd	SUCCESS	\N	2025-11-03 07:52:44.219156	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
937	8f7581ee-783e-4d70-9aa9-3de03336b5bd	SUCCESS	\N	2025-11-03 07:53:07.412894	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
938	2a4abfd7-5c11-4dd9-acc7-7b45b51b3c02	SUCCESS	\N	2025-11-03 07:53:39.572464	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
939	f10d49d7-c7ac-4f13-a686-d5b0a5a493aa	SUCCESS	\N	2025-11-03 07:54:14.71598	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
945	7c661a6a-bc5d-4810-98ca-60f96c59392b	SUCCESS	\N	2025-11-03 15:17:08.848504	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
948	87238e2e-4d39-4ec5-8222-a6e8c9594a4a	SUCCESS	\N	2025-11-03 15:17:08.856996	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
951	eb10e96c-7a98-42cc-a16b-4f4e65343a90	SUCCESS	\N	2025-11-03 15:17:08.862285	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
955	8e1264bd-98d8-4e35-b713-c13f0eeda18e	SUCCESS	\N	2025-11-03 15:17:08.868404	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
957	dd0cb4fa-d3ec-4aa5-ac01-d7ae58abc406	SUCCESS	\N	2025-11-03 15:17:08.872556	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
962	df35c801-6e1c-483a-9873-e9ab11880e8a	SUCCESS	\N	2025-11-03 15:17:08.904403	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
967	2c99f744-6c86-4fd3-bafa-e7bba9861e96	SUCCESS	\N	2025-11-03 15:17:08.919155	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
969	e647b0e8-30ab-4f33-b025-dea7ea9fc4ad	SUCCESS	\N	2025-11-03 15:17:08.923322	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
974	a111fa15-f4a9-4233-aa6f-e1e7ec7cff0a	SUCCESS	\N	2025-11-03 15:17:08.932667	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
976	12685bf6-31b8-4b62-b2f7-f55420f248d0	SUCCESS	\N	2025-11-03 15:17:08.936827	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
980	d80a0328-9807-4ff4-920f-7b1256267ae0	SUCCESS	\N	2025-11-03 15:17:08.945324	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
983	4605da83-ca4d-4a25-a9b4-850bd2419c5a	SUCCESS	\N	2025-11-03 15:17:08.951106	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
988	176b34f5-3747-48d0-8ebd-0a45d4e6c4b2	SUCCESS	\N	2025-11-03 15:17:08.957103	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
991	61e875ef-dee2-4771-8bd0-b114053db067	SUCCESS	\N	2025-11-03 15:17:08.979549	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
993	1477c601-3883-469d-a9e5-39bbb9b2c9d9	SUCCESS	\N	2025-11-03 15:17:45.938234	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
994	689fdb9b-c8c9-4536-9c0e-f3b61e2d5ca4	SUCCESS	\N	2025-11-03 15:18:13.520775	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
995	0edf4bc0-3bd3-4097-ab7e-507c45e30fcb	SUCCESS	\N	2025-11-03 15:18:43.548685	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
996	1c861861-00cf-4964-8e06-524ee83d5149	SUCCESS	\N	2025-11-03 15:19:13.540285	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
997	f5f96e04-2245-4c30-94e1-e40402c51ef6	SUCCESS	\N	2025-11-03 15:19:43.519544	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
998	023ea31d-c399-48f6-8f60-2e0493c73d0d	SUCCESS	\N	2025-11-03 15:20:13.541317	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
999	673d0c57-9e6f-4b5b-be93-0ada361cb113	SUCCESS	\N	2025-11-03 15:20:55.125646	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1000	bcbb044f-5103-4dab-be8c-eb6b3cd93bca	SUCCESS	\N	2025-11-03 15:21:42.030926	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
946	669d9dd5-fa57-4b8c-9e14-06d6c04144af	SUCCESS	\N	2025-11-03 15:17:08.850653	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
949	7dc9368a-35b8-446d-a6a2-a71774f2149f	SUCCESS	\N	2025-11-03 15:17:08.857225	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
952	418ca37c-a138-401f-a92b-dd4df5a514da	SUCCESS	\N	2025-11-03 15:17:08.862317	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
954	d9ba2157-7e80-42e0-a010-9e01a189f775	SUCCESS	\N	2025-11-03 15:17:08.867187	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
956	8781ec28-2e0c-478a-9b42-ac1f9e4f31b5	SUCCESS	\N	2025-11-03 15:17:08.872115	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
958	20de888a-72c4-40c0-bdc1-a1c4422eab0f	SUCCESS	\N	2025-11-03 15:17:08.877801	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
961	2daaef9c-b460-44be-bca0-05fa519b5333	SUCCESS	\N	2025-11-03 15:17:08.900692	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
963	ebd562ae-c6f1-4717-bbb8-3358c14bfc79	SUCCESS	\N	2025-11-03 15:17:08.909854	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
966	5f9b4260-050f-4e26-aa65-20d8861e9ac9	SUCCESS	\N	2025-11-03 15:17:08.918633	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
970	9465f9ec-b956-4f38-8671-737a9be155f9	SUCCESS	\N	2025-11-03 15:17:08.924944	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
972	ef4c85f4-efff-4d6b-98c0-3006b18abbe8	SUCCESS	\N	2025-11-03 15:17:08.930375	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
977	fedd24c8-9a3b-4663-929d-0b45889a96b1	SUCCESS	\N	2025-11-03 15:17:08.937469	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
979	91d57abe-1d69-4c7a-8376-9c657558c0c7	SUCCESS	\N	2025-11-03 15:17:08.943375	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
982	e5a8bc3c-288f-49c0-90bc-86822f6dce24	SUCCESS	\N	2025-11-03 15:17:08.947185	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
985	488e9e79-1c29-43c3-8cb1-8633ce85494d	SUCCESS	\N	2025-11-03 15:17:08.952407	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
986	c6c63a81-72f9-4a07-b405-cd9627fc19c7	SUCCESS	\N	2025-11-03 15:17:08.95595	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
989	13e4fb64-d640-4f0a-9e40-273731998596	SUCCESS	\N	2025-11-03 15:17:08.960831	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
947	0caf5ed8-b73f-436a-9924-87bc7266e9c4	SUCCESS	\N	2025-11-03 15:17:08.856629	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
950	b3a81051-1e94-4ff2-9320-fd6c7a529cad	SUCCESS	\N	2025-11-03 15:17:08.861993	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
953	96f47259-de4d-41ac-a3c4-4984d7fdc776	SUCCESS	\N	2025-11-03 15:17:08.866744	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
971	8551ae1f-6381-45fb-b7fa-cd0614967137	SUCCESS	\N	2025-11-03 15:17:08.92863	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
959	2b102fb6-ea65-4610-81a2-76f32f55e163	SUCCESS	\N	2025-11-03 15:17:08.883777	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
960	0d637126-4807-493b-ba56-e5766a56ad8b	SUCCESS	\N	2025-11-03 15:17:08.894265	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
973	e24e388e-140d-49ba-8fda-067309701fc2	SUCCESS	\N	2025-11-03 15:17:08.93137	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
975	64afb0a9-8cac-4691-b21c-4f2bb659d2c2	SUCCESS	\N	2025-11-03 15:17:08.93465	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
964	627dc68d-f6eb-49ca-9fa0-788f23a3f89c	SUCCESS	\N	2025-11-03 15:17:08.915096	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
965	df16df53-73a6-48ce-995c-fb17b8decbbe	SUCCESS	\N	2025-11-03 15:17:08.918291	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1009	6f331b5e-d7c4-42fd-b4e5-2f2f49b12e36	SUCCESS	\N	2025-11-03 15:29:03.554497	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
968	a9e7927e-1249-45a9-84b8-18176e5aadbe	SUCCESS	\N	2025-11-03 15:17:08.922572	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
978	6a54627d-bc0d-4610-98f7-d1b41dbd3bb7	SUCCESS	\N	2025-11-03 15:17:08.941697	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
981	7bfe95f4-1d4a-4de5-ae29-82ed2468f4f5	SUCCESS	\N	2025-11-03 15:17:08.946698	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
984	ba709c38-8b75-46c7-80e0-051cf3349872	SUCCESS	\N	2025-11-03 15:17:08.951069	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
987	e09fb260-41e8-4813-9495-a3c6d77b5d57	SUCCESS	\N	2025-11-03 15:17:08.956223	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
990	0e2bc314-eacf-4fb4-90df-1908269ae52f	SUCCESS	\N	2025-11-03 15:17:08.978686	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
992	0fa5fd7a-530c-4b5a-a3c3-5cc8b52dd92b	SUCCESS	\N	2025-11-03 15:17:09.73559	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1001	138fc77b-2406-4770-afdf-deda40dfbddb	SUCCESS	\N	2025-11-03 15:22:11.627331	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1002	6341853a-6b20-430a-80b1-e72123ea22d3	SUCCESS	\N	2025-11-03 15:23:29.5499	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1003	bde55840-c964-4396-ab1e-66ef5188507d	SUCCESS	\N	2025-11-03 15:24:27.923442	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1004	020959f6-612f-4e98-8d72-3bdbbaa51202	SUCCESS	\N	2025-11-03 15:25:01.081033	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1005	15bab7fd-d676-4aae-be24-ee0ca78e79e2	SUCCESS	\N	2025-11-03 15:25:36.14574	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1006	29f06dd1-92cb-48c4-a24a-7fcdb70f642a	SUCCESS	\N	2025-11-03 15:26:39.350408	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1007	6743dbe9-dcb4-400b-962e-7f2040d141bb	SUCCESS	\N	2025-11-03 15:27:11.182064	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1008	57e752c1-cba2-4547-a78e-ec622aaf3a30	SUCCESS	\N	2025-11-03 15:28:40.428382	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1010	787de3b4-af7b-4240-824b-0585710f3361	SUCCESS	\N	2025-11-03 15:29:34.722033	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1011	387fe257-724b-4158-b70f-abebd49b6ec5	SUCCESS	\N	2025-11-03 15:30:10.298851	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1012	bf08a443-7b13-4753-9afb-6637f5a77f5c	SUCCESS	\N	2025-11-03 15:30:42.049639	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1013	b1708746-2af7-4221-8957-e1d4143e3621	SUCCESS	\N	2025-11-03 15:31:12.942212	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1014	cd8ee0d0-3f8d-40f3-9efc-9f81ef6a5460	SUCCESS	\N	2025-11-03 15:31:49.358864	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1015	e84ec5ef-5b48-46b0-a17f-668317e1a2bb	SUCCESS	\N	2025-11-03 15:32:20.018834	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1016	01d632d3-ba70-468a-8877-af032fce3781	SUCCESS	\N	2025-11-03 15:32:51.674725	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1017	a8e9f106-4594-447d-b4ae-e201fbf65d5a	SUCCESS	\N	2025-11-03 15:33:25.825672	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1018	75c0e193-20dd-4a63-807e-b3f064eaa480	SUCCESS	\N	2025-11-03 15:34:08.099271	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1019	5c7d137e-c531-4083-958d-5d1afde78806	SUCCESS	\N	2025-11-03 15:34:58.446973	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1020	cc359394-9ea0-4e15-b6bb-affbaef89e5d	SUCCESS	\N	2025-11-03 15:35:28.10047	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1021	93d9889d-ac6c-4ce8-bf89-b1b2ff2cc3ca	SUCCESS	\N	2025-11-03 15:36:03.938064	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1022	28a523bb-31be-4c43-a535-b0037a8dccd4	SUCCESS	\N	2025-11-03 15:36:58.915497	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1023	75f46baa-0e21-4c38-a532-e07ec7b7201f	SUCCESS	\N	2025-11-03 15:38:07.152173	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1024	62e0f16e-fa17-4143-aa0b-0083686a6d59	SUCCESS	\N	2025-11-03 15:39:23.859658	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1025	efc2ec5f-cb1d-4276-be34-24590fd01497	SUCCESS	\N	2025-11-03 15:40:27.56662	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1026	b54aea16-1b6f-4782-a75e-4c0282761257	SUCCESS	\N	2025-11-03 15:41:02.918952	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1027	76e8ed84-2b01-4f57-8df8-aabd94b89666	SUCCESS	\N	2025-11-03 15:41:53.081692	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1028	70081313-0a90-41ff-b1d7-477d87921d93	SUCCESS	\N	2025-11-03 15:42:33.360008	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1029	6d0ffc55-8694-428a-b351-305bdffed52f	SUCCESS	\N	2025-11-03 15:42:59.045383	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1030	d38615fb-016b-42d1-99ad-5ac3af64fc7d	SUCCESS	\N	2025-11-03 15:44:16.558134	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1031	445c0368-15da-4e23-83f3-69c8da7fcb69	SUCCESS	\N	2025-11-03 15:44:50.091793	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1032	ff8454b6-acca-4d74-8009-ab2b1ad1d81f	SUCCESS	\N	2025-11-03 15:45:46.22413	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1033	73f35e3b-8824-4d13-adb4-885f91ef8d67	FAILURE	\\x8005958f000000000000007d94288c086578635f74797065948c0f576f726b65724c6f73744572726f72948c0b6578635f6d657373616765948c37576f726b657220657869746564207072656d61747572656c793a207369676e616c203920285349474b494c4c29204a6f623a203130332e9485948c0a6578635f6d6f64756c65948c1362696c6c696172642e657863657074696f6e7394752e	2025-11-03 15:47:02.977601	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1035	2ffe1fe1-4698-4c51-bec3-3409c9a76238	SUCCESS	\N	2025-11-03 15:50:17.168975	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1034	e8175517-3467-4388-b884-4490f1f43334	SUCCESS	\N	2025-11-03 15:50:17.16527	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1036	10e930a4-0bf4-4996-9561-b1db2b1e1249	SUCCESS	\N	2025-11-03 15:50:17.165144	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1037	40f4881e-9d2b-46bb-8cfc-649562586041	SUCCESS	\N	2025-11-03 15:50:17.717375	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1038	45ce6081-76d8-4b5d-8995-970517e9db0e	SUCCESS	\N	2025-11-03 15:50:17.717292	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1039	a3f43603-569b-49dd-9d32-df11c79085a0	SUCCESS	\N	2025-11-03 15:50:18.483375	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1040	938670f8-9e44-4733-ba5c-d9b9698d6111	SUCCESS	\N	2025-11-03 15:50:20.803612	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1041	5a9e317e-904b-4c93-b9a3-287d60a16d8b	SUCCESS	\N	2025-11-03 15:50:50.61607	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1042	4ecd7170-330a-4830-bbf7-f662ff7b188b	SUCCESS	\N	2025-11-03 15:51:20.573186	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1043	01c721e9-7602-4f3b-b5a5-dcb70f3b0de9	SUCCESS	\N	2025-11-03 15:51:50.579902	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1044	79ed897f-9540-434e-840d-d7744b0888a6	SUCCESS	\N	2025-11-03 15:52:20.575358	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1045	f89efe06-261f-4bd7-a358-dafd267ca1bf	SUCCESS	\N	2025-11-03 15:52:50.586329	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1046	2608aaa0-0d6b-4f2c-84ed-4f36fe329fd4	SUCCESS	\N	2025-11-03 15:53:20.573348	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1047	abbb513c-8f49-452f-9491-1b8e6a15e011	SUCCESS	\N	2025-11-03 15:53:50.587622	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1048	849418e1-d27f-4ddd-85bc-2788671f89c5	SUCCESS	\N	2025-11-03 15:54:20.578491	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1049	300a168f-83d7-4abe-bfee-f91c5e47da9c	SUCCESS	\N	2025-11-03 15:54:50.58882	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1050	6a489239-d5a3-4e92-8d77-e4888a4cad7e	SUCCESS	\N	2025-11-03 15:55:20.601414	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1051	1710011c-e760-498b-8772-56abbbe3d747	SUCCESS	\N	2025-11-03 15:55:50.590721	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1052	fa3d9187-d387-4571-8f34-35fedc707612	SUCCESS	\N	2025-11-03 15:56:20.603567	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1056	36e0d56a-fe0d-447c-a8b7-03c2ea6e2d0f	SUCCESS	\N	2025-11-03 15:58:20.63349	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1053	f6448248-8120-4c75-a267-d00d608f70db	SUCCESS	\N	2025-11-03 15:56:50.614937	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1054	b38d4c0b-c26e-4faa-add5-c257f7035ea0	SUCCESS	\N	2025-11-03 15:57:20.625562	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1055	14638c79-d72f-4e8d-9bef-614fb67f9269	SUCCESS	\N	2025-11-03 15:57:50.631788	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1057	c0fb256e-c2f8-44a0-9c7d-cb60b7763ced	SUCCESS	\N	2025-11-03 15:58:50.655638	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1058	032b51e9-c8a8-402f-8efd-756a790ccddb	SUCCESS	\N	2025-11-03 15:59:20.658315	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1059	c2baf843-df71-49aa-87a8-ff143692c146	SUCCESS	\N	2025-11-03 15:59:50.649428	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1060	f582e69f-f313-42e9-9e1f-0f52910adc85	SUCCESS	\N	2025-11-03 16:00:20.68878	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1061	a52509b8-0ee7-4713-b61d-a15ed58466c2	SUCCESS	\N	2025-11-03 16:00:50.715342	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1062	09ccabc8-1f09-4ef8-bd72-9b605a903765	SUCCESS	\N	2025-11-03 16:01:21.171475	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1063	b5d5882b-190f-4fd9-83e4-f4c3601f4a8e	SUCCESS	\N	2025-11-03 16:01:58.61772	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1064	dbecf0e3-af73-4807-a5e7-b215fa9c218c	SUCCESS	\N	2025-11-03 16:02:29.22702	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1065	bb5aaeb9-fa64-4cc6-aa94-f2ed1e840b67	SUCCESS	\N	2025-11-03 16:02:56.583532	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1066	c131adf8-9d17-4c85-9807-3caefae319e2	SUCCESS	\N	2025-11-03 16:03:30.870072	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1067	b457dc03-c02e-464a-a6b3-8725aca1430f	SUCCESS	\N	2025-11-03 16:04:35.476533	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1068	1058fd46-af82-4be8-ab96-284295176200	SUCCESS	\N	2025-11-03 16:05:26.009906	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1069	ccdfbcb4-3b88-40b1-b118-8acb334c17f8	SUCCESS	\N	2025-11-03 16:06:06.932436	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1070	61fd5d7f-a7e7-4416-b73a-3c3be6376cce	SUCCESS	\N	2025-11-03 16:06:37.453302	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1071	3f95aedc-b030-4c53-bf33-678de54dbb8b	SUCCESS	\N	2025-11-03 16:07:23.996322	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1090	c0bfaf13-2eb9-4ec0-8558-693e5eb90228	SUCCESS	\N	2025-11-03 16:22:23.801056	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1073	dd6a902a-ff24-4361-be9f-55bdf8c0fb58	FAILURE	\\x8005958f000000000000007d94288c086578635f74797065948c0f576f726b65724c6f73744572726f72948c0b6578635f6d657373616765948c37576f726b657220657869746564207072656d61747572656c793a207369676e616c203920285349474b494c4c29204a6f623a203135322e9485948c0a6578635f6d6f64756c65948c1362696c6c696172642e657863657074696f6e7394752e	2025-11-03 16:09:36.454084	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1074	42bfaba0-9ce2-446d-83cb-9b7e607ec29d	SUCCESS	\N	2025-11-03 16:09:51.351738	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1075	159a49d7-bc8c-4124-9d59-8cb198128f5a	SUCCESS	\N	2025-11-03 16:10:16.253437	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1076	2094958e-5b96-475d-a5f4-8e784ea21d35	SUCCESS	\N	2025-11-03 16:10:57.590372	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1077	9f23a5da-6f37-4b77-b6ce-d3e29cf4676c	SUCCESS	\N	2025-11-03 16:11:32.830486	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1078	5f1e78a0-5932-491d-8fa9-07d9234b9b1d	SUCCESS	\N	2025-11-03 16:12:11.008101	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1079	e153b4b8-b6ce-404e-8ecd-1909a9989ee3	SUCCESS	\N	2025-11-03 16:12:40.902022	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1080	5d6c99f1-f122-46bf-85bb-2cc902cc16e3	SUCCESS	\N	2025-11-03 16:13:12.091497	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1081	500c12e8-6b1d-4495-aafb-3974f7ab10b8	SUCCESS	\N	2025-11-03 16:13:48.058707	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1082	85f359c5-91ab-4769-97a4-f633b9dc8b86	SUCCESS	\N	2025-11-03 16:14:56.005443	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1083	0af35ce7-084e-4ca8-9c29-25adfdc39bb1	SUCCESS	\N	2025-11-03 16:15:17.795894	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1084	1bbcde46-8b1c-4b46-8d31-5022a1ea4a05	SUCCESS	\N	2025-11-03 16:16:45.024043	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1085	0068407b-ba15-4853-994c-57480eac9ad5	SUCCESS	\N	2025-11-03 16:18:12.210423	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1086	e6c09ede-3544-4107-b7d8-4bae26cc3724	SUCCESS	\N	2025-11-03 16:18:57.205056	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1087	e475ea4b-56b8-4b90-8fdb-b76946d88220	SUCCESS	\N	2025-11-03 16:20:24.943194	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1088	991d30e0-1762-45d9-9000-e6318372a36e	SUCCESS	\N	2025-11-03 16:20:27.51703	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1089	7e60bbd5-33ab-40b6-bf58-577372eb256b	SUCCESS	\N	2025-11-03 16:21:01.375167	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1091	bcee56e2-83e6-4eaf-be60-de53843898ec	SUCCESS	\N	2025-11-03 16:23:44.840297	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1092	83b9af1b-b59a-44ff-bb81-5caa9ce1dddd	SUCCESS	\N	2025-11-03 16:24:14.790854	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1093	86dca553-423f-4d45-ab1f-3b17c1015c24	SUCCESS	\N	2025-11-03 16:24:44.476414	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1094	5eb2eec2-dbe0-4817-9921-bc1dfdbff586	SUCCESS	\N	2025-11-03 16:25:24.844735	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1095	f265f46c-3d43-4507-b363-aab35cf02cd0	SUCCESS	\N	2025-11-03 16:27:31.829305	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1096	2fb5a267-1f93-4fc6-91a0-48a961443e63	SUCCESS	\N	2025-11-03 16:27:57.399005	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1097	d11760b6-64d4-4adf-b8c0-c5d7c53ca910	SUCCESS	\N	2025-11-03 16:28:37.471854	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1098	1032b423-0e50-402e-8c88-acc5d0be91f6	SUCCESS	\N	2025-11-03 16:29:19.639157	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1099	727881dd-2b3b-4e9a-8c9d-78c6f3b45830	SUCCESS	\N	2025-11-03 16:29:50.279712	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1100	28e5f353-5cfa-4268-a180-f4cff0d3d470	SUCCESS	\N	2025-11-03 16:30:25.554703	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1101	042b28a2-69a4-47a8-824b-b1d3ee2ed555	SUCCESS	\N	2025-11-03 16:31:16.940947	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1102	2e882b21-cf8e-416b-8632-d9b1be3cbbc7	SUCCESS	\N	2025-11-03 16:32:24.47917	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1103	d9626114-aa28-45c8-9224-28125402bfe3	SUCCESS	\N	2025-11-03 16:33:19.066997	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1104	412fef09-4e4c-4755-a9a6-64f39a3a6586	SUCCESS	\N	2025-11-03 16:33:51.65159	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1105	ed8b98a6-7398-4764-995e-e7c2789e33b9	SUCCESS	\N	2025-11-03 16:34:40.44411	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1106	1f9921cd-f3b4-4b98-8afd-4b573d257dca	SUCCESS	\N	2025-11-03 16:36:08.475948	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1107	81b90403-ed5a-4296-825b-f4d4b3cd3ffd	SUCCESS	\N	2025-11-03 16:36:38.814816	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1108	f8b26d88-fe6f-4787-8e4e-0a95e8e0c882	SUCCESS	\N	2025-11-03 16:37:00.393829	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1109	db49bb59-42d5-4133-b607-5f2e9d71ce97	SUCCESS	\N	2025-11-03 16:37:33.29085	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1110	78841f31-5c99-43cd-a516-5f5e9b71a1e7	SUCCESS	\N	2025-11-03 16:38:26.256017	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1111	f9066aca-61ef-4947-ad84-e350141a380f	SUCCESS	\N	2025-11-03 16:38:56.506609	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1112	0c529bcc-8ba2-480d-926a-400166f0ad8b	SUCCESS	\N	2025-11-03 16:40:43.567407	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1113	948b803c-c2fc-4dc8-bd9a-037bebb1d839	SUCCESS	\N	2025-11-03 16:41:13.233602	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1114	766d1b44-8ec0-4932-b4ff-38794074e487	SUCCESS	\N	2025-11-03 16:41:48.828698	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1115	6579d745-841e-4212-89e3-7a00a5bbb7e8	SUCCESS	\N	2025-11-03 17:34:23.364921	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1116	2097f65d-d5c9-44b0-b76c-1ceea0cc2d70	SUCCESS	\N	2025-11-03 17:34:54.101696	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1117	d1596a70-a667-4751-bdde-acf333242e65	SUCCESS	\N	2025-11-03 17:35:03.619578	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1118	4c7df085-b9cb-4088-9cca-0f097a724b99	SUCCESS	\N	2025-11-03 17:35:21.445729	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1119	8fd44b6f-368f-4565-bef4-8581d0e24966	SUCCESS	\N	2025-11-03 17:35:30.534283	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1120	a95eade5-9419-4dee-863f-738c1840f168	SUCCESS	\N	2025-11-03 17:35:33.490752	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1121	80c00994-70f2-4c4c-a429-e557c4a8a0b2	SUCCESS	\N	2025-11-03 17:35:37.219925	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1122	a0d4b5ca-a890-4fee-9509-625d89cb89d6	SUCCESS	\N	2025-11-03 17:35:43.012813	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1123	c2aac039-bf13-430c-9fe5-859af2361c72	SUCCESS	\N	2025-11-03 17:35:46.505289	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1124	2ce42647-618a-44aa-832b-aed5decface1	SUCCESS	\N	2025-11-03 17:35:53.818818	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1125	444387af-c65e-4eed-b488-66690aefac55	SUCCESS	\N	2025-11-03 17:36:01.337668	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1126	030887e1-3e88-4841-a563-3c2b7ec57aff	SUCCESS	\N	2025-11-03 17:36:05.369402	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1127	67bcf5f2-969b-4832-b01a-703366a6c0c4	SUCCESS	\N	2025-11-03 17:36:09.251488	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1128	a0772107-fa1a-4acc-8e28-cff96dd8e01a	SUCCESS	\N	2025-11-03 17:36:25.000964	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1129	01f315bc-7a76-44d3-b8c7-2aecee5e235b	SUCCESS	\N	2025-11-03 17:36:51.460966	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1130	c3d89d18-6a41-4c9c-8cf9-c2e74c7f731d	SUCCESS	\N	2025-11-03 17:36:59.756087	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1131	82576e5a-3e75-4ba1-81f6-fe40e106e412	SUCCESS	\N	2025-11-03 17:37:05.877547	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1132	c40bc4c4-1a22-4638-b2ba-4d2ae388b86e	SUCCESS	\N	2025-11-03 17:37:12.555698	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1133	fa01c271-4066-4c04-a0bb-dc8da1e95ece	FAILURE	\\x8005958e000000000000007d94288c086578635f74797065948c0f576f726b65724c6f73744572726f72948c0b6578635f6d657373616765948c36576f726b657220657869746564207072656d61747572656c793a207369676e616c203920285349474b494c4c29204a6f623a2031382e9485948c0a6578635f6d6f64756c65948c1362696c6c696172642e657863657074696f6e7394752e	2025-11-03 17:37:15.313005	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1134	039bfa25-7429-44c6-bf69-fd25fcdf5c90	SUCCESS	\N	2025-11-03 17:37:33.942278	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1135	d690b1bb-7bba-41b6-8f7e-0b65deab3a5e	SUCCESS	\N	2025-11-03 17:37:40.349022	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1139	d9caace0-6735-4d08-99fe-1268d0210e84	SUCCESS	\N	2025-11-03 17:38:37.454103	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1136	546829c5-daff-4a76-b883-df0464834056	SUCCESS	\N	2025-11-03 17:37:44.497079	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1142	10c2b69c-4123-4669-99bc-c8a31ae9401b	SUCCESS	\N	2025-11-03 17:38:38.707083	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1137	2b042eae-891b-4038-be7e-83519e50a80d	SUCCESS	\N	2025-11-03 17:38:14.829577	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1138	22e89449-5b45-41be-be4a-96e8d3a0b1e7	SUCCESS	\N	2025-11-03 17:38:31.887164	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1140	575dceae-d2ba-46fc-af5c-e1105d1c57a2	SUCCESS	\N	2025-11-03 17:38:38.697288	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
316	\N	SUCCESS	\N	2025-11-03 17:38:38.699686	\N	logs_consumer	\\x5b5d	\\x7b226576656e74223a20226c6f67733a736a77793038696d73363937726b77696d336b78693970663733636f6f333261222c20226d657373616765223a207b2274696d657374616d70223a20313736323139303932322e3738323639392c202274797065223a20224c4f47222c202273657276696365223a202270726f6d7074222c2022636f6d706f6e656e74223a207b22746f6f6c5f6964223a202262623633643139642d613764342d343065652d616362662d306463346631353561646361222c2022646f635f6e616d65223a2022446961676e6f73697320616e642054726561746d656e742028526566657272616c2066726f6d205448537465707320436865636b7570292e706466227d2c20226c6576656c223a2022494e464f222c20227374617465223a202252554e222c20226d657373616765223a2022457865637574696f6e20636f6d706c657465227d2c2022757365725f73657373696f6e5f6964223a2022736a77793038696d73363937726b77696d336b78693970663733636f6f333261227d	celery@d25293699634	0	celery_log_task_queue
1141	e30397fd-a496-4ad9-962e-c528ae9e5f7d	SUCCESS	\N	2025-11-03 17:38:38.698958	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1143	94ceefa3-f8c6-48d1-a044-1e460dc7217f	SUCCESS	\N	2025-11-03 17:38:38.708717	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1144	838a32ed-6230-4cc4-9d66-063bdc251446	SUCCESS	\N	2025-11-03 17:38:38.712505	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1145	0bb88a4e-827b-4e03-88d0-e5bd7d15ff06	SUCCESS	\N	2025-11-03 17:38:38.713049	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1146	42f17ba3-be39-4def-89d0-a0f7d19bbe5c	SUCCESS	\N	2025-11-03 17:38:38.714274	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1147	38dd4d05-10fc-4ea7-90b6-74986912101b	SUCCESS	\N	2025-11-03 17:38:38.720087	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1150	d8175268-06b4-4bba-8069-ec947c0eb0d8	SUCCESS	\N	2025-11-03 17:38:38.725677	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1154	aaf90d9f-1d0d-4228-b63b-a7678f6c437d	SUCCESS	\N	2025-11-03 17:38:38.733251	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1157	2272c107-4023-4ce9-95a5-b818d551e5f0	SUCCESS	\N	2025-11-03 17:38:38.745633	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1159	df51a26f-4a1f-4cdd-9ba8-a50969324882	SUCCESS	\N	2025-11-03 17:38:38.750038	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1162	739e4374-3ff2-4afa-83c2-def143d6cf49	SUCCESS	\N	2025-11-03 17:38:38.759271	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1165	52070cec-e5fa-4138-bd99-c7e093a630d2	SUCCESS	\N	2025-11-03 17:38:38.764488	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1168	e00a787d-2f49-4ae2-ad9b-adcff6b716a1	SUCCESS	\N	2025-11-03 17:38:38.769167	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1170	0ce156e9-170f-4845-9b98-46e4e53f955e	SUCCESS	\N	2025-11-03 17:38:38.773276	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1173	29d9c056-93ff-478c-8399-2e8f2e1d9d51	SUCCESS	\N	2025-11-03 17:38:38.777695	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1176	2c8b5777-f8fd-49b7-9f99-25d5c0c33e7c	SUCCESS	\N	2025-11-03 17:38:38.786053	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1179	f13b39c3-7fc8-40f8-822a-d117cee5b1c5	SUCCESS	\N	2025-11-03 17:38:38.790392	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1183	667c70c4-478a-4440-9c4a-1e717f9139c5	SUCCESS	\N	2025-11-03 17:38:38.795056	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1185	d5fc8803-5f83-4c5c-a40a-752a6807be2a	SUCCESS	\N	2025-11-03 17:38:38.800962	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1187	e61a6b56-1d74-416c-86c0-e1b9a1bc8df6	SUCCESS	\N	2025-11-03 17:38:38.808847	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1190	57394404-6b5d-48b6-9ebb-2ce1e3f1a028	SUCCESS	\N	2025-11-03 17:38:38.813714	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1194	51c97178-5c38-4002-8c06-f01851ac038c	SUCCESS	\N	2025-11-03 17:38:38.818111	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1197	df248a6c-e2ba-4a42-b357-37c21c71eb72	SUCCESS	\N	2025-11-03 17:38:38.822423	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1200	0b3dc283-19bf-41f3-952e-44e345c6eb27	SUCCESS	\N	2025-11-03 17:38:38.827335	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1202	51f30d54-744b-4276-a3cd-ea22d0697c44	SUCCESS	\N	2025-11-03 17:38:38.832841	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1149	5f806bf5-976c-4b22-b80c-936017db76f6	SUCCESS	\N	2025-11-03 17:38:38.721431	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1151	b9221d84-75f3-4110-97b9-29d0c3ac64a9	SUCCESS	\N	2025-11-03 17:38:38.726949	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1152	fc0d9a4f-1e56-446d-8677-6f58e2f3a15d	SUCCESS	\N	2025-11-03 17:38:38.73262	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1156	2cf43984-c10a-4947-9308-8932b0f807fe	SUCCESS	\N	2025-11-03 17:38:38.745457	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1160	673dd300-2e10-4eb7-bca7-4ecdfa8a8363	SUCCESS	\N	2025-11-03 17:38:38.753154	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1163	4fe50a91-3bcf-4079-921c-089f8c5bf43a	SUCCESS	\N	2025-11-03 17:38:38.761386	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1166	14f020e2-56ff-4715-810b-c8b6f2e4bd3f	SUCCESS	\N	2025-11-03 17:38:38.765861	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1169	cf5eb253-dd9c-4753-ab1d-d847d3265ad3	SUCCESS	\N	2025-11-03 17:38:38.77121	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1172	50172945-0be8-4492-a57b-a0739ea6b941	SUCCESS	\N	2025-11-03 17:38:38.776606	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1175	d00088f3-8114-45d0-9ba9-5b1e182b888e	SUCCESS	\N	2025-11-03 17:38:38.784778	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1180	4d591fd2-bea9-4dbd-a9a4-86fa59fb3b53	SUCCESS	\N	2025-11-03 17:38:38.790617	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1182	5c170a25-3928-48f1-8763-14b89323c39f	SUCCESS	\N	2025-11-03 17:38:38.794981	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1184	21c2a15e-567d-47ae-a397-c7ef155efcb1	SUCCESS	\N	2025-11-03 17:38:38.801337	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1189	02dc2ec2-188a-407e-8930-4556c1bb0938	SUCCESS	\N	2025-11-03 17:38:38.809224	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1192	c9e11fac-805a-47d7-a39e-d543c00e00da	SUCCESS	\N	2025-11-03 17:38:38.813723	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1193	dc78885e-eb42-4d37-b2f5-4af2594b020b	SUCCESS	\N	2025-11-03 17:38:38.817588	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1196	b8cee67b-7bc2-40b3-8584-a39c174c4081	SUCCESS	\N	2025-11-03 17:38:38.82177	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1199	39cfa6ed-4142-413c-8abe-971ddebb7c9d	SUCCESS	\N	2025-11-03 17:38:38.827611	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1203	1dad07cf-e0c6-4e07-80f3-4ce6618c3c34	SUCCESS	\N	2025-11-03 17:38:38.832743	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1204	2c954ecd-8da5-4aae-abf9-06fd87fcfa0c	SUCCESS	\N	2025-11-03 17:39:08.653863	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1205	7bbd207a-77d2-4108-80e6-d36d5de7da48	SUCCESS	\N	2025-11-03 17:39:52.622556	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1206	71d7d6cd-c739-44b0-a5cb-a263703c636d	SUCCESS	\N	2025-11-03 17:41:06.920078	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1207	819f8ef1-d986-48ce-a0f4-03466d79bbc2	SUCCESS	\N	2025-11-03 17:41:35.634624	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1208	8e819ba1-3d3f-41e1-aacf-2405e63b5951	SUCCESS	\N	2025-11-03 17:42:34.368164	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1209	6e2320ef-13a9-410e-8a70-218897c5cb6d	SUCCESS	\N	2025-11-03 17:43:51.006179	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1210	4e7afa6d-abbb-4e9c-afaf-86c790eda1dd	SUCCESS	\N	2025-11-03 17:43:51.722394	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1211	df49e355-7293-44b6-a036-d3b05d318dce	SUCCESS	\N	2025-11-03 17:43:51.967985	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1212	1afb14c8-a62f-4da4-a4c4-37218cdc19db	SUCCESS	\N	2025-11-03 17:44:51.280244	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1213	68b57b0d-8753-48cc-914c-a102e472f18c	SUCCESS	\N	2025-11-03 17:45:27.666028	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1214	32ce5c50-526c-483a-87d9-9f4109948f66	SUCCESS	\N	2025-11-03 17:46:12.704128	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1215	052a9a08-ca94-410b-9c20-281263e633cb	SUCCESS	\N	2025-11-03 17:46:38.025328	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1216	d4183179-e1c2-434e-8a46-db3c08ce6891	SUCCESS	\N	2025-11-03 17:47:43.814786	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1217	a09af3b8-d18b-4a08-9e95-0b7fdbd46902	SUCCESS	\N	2025-11-03 17:47:54.049485	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1218	c5db26b7-8290-46e5-b2ca-dacde3af7662	FAILURE	\\x8005958f000000000000007d94288c086578635f74797065948c0f576f726b65724c6f73744572726f72948c0b6578635f6d657373616765948c37576f726b657220657869746564207072656d61747572656c793a207369676e616c203920285349474b494c4c29204a6f623a203131332e9485948c0a6578635f6d6f64756c65948c1362696c6c696172642e657863657074696f6e7394752e	2025-11-03 17:48:34.396158	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1219	c40e9256-1740-4d02-8ba0-a60a97fcedf7	SUCCESS	\N	2025-11-03 17:51:05.095325	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1220	6d07fe0b-2300-45f4-920a-923a2a0c9e1e	SUCCESS	\N	2025-11-03 17:51:28.074658	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1221	a3c80be8-faf5-4de5-b60d-c9d65fb3ea50	SUCCESS	\N	2025-11-03 17:51:28.103684	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1222	4984844f-29e0-4dab-8130-c0216527413f	SUCCESS	\N	2025-11-03 17:51:28.127649	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1223	89bf2289-90a8-4ecd-89e8-2bfbaaaec63d	SUCCESS	\N	2025-11-03 17:51:28.129487	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1224	02692dbe-11c2-407c-9e48-6d3ffcd6cfac	SUCCESS	\N	2025-11-03 17:51:41.152337	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1225	fdae8e7c-f096-4a7c-8998-823e604f8318	SUCCESS	\N	2025-11-03 17:52:11.052089	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1226	69572806-64e1-470c-8e36-18790e09fd75	SUCCESS	\N	2025-11-03 17:52:41.036904	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1227	6eeecad9-1f6a-468f-a4a2-3d84e9113663	SUCCESS	\N	2025-11-03 17:53:11.056514	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1228	bd74efd8-3b33-4a05-b5f2-dfbd12670bfa	SUCCESS	\N	2025-11-03 17:53:41.055503	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1229	8dbdbdd1-086f-4810-81c0-d7152b683da1	SUCCESS	\N	2025-11-03 17:54:11.054491	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1230	614de825-c0c7-4b26-882b-d43cae6428ec	SUCCESS	\N	2025-11-03 17:54:41.042789	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1231	1390fbc2-c6c8-4d52-8646-49452646b1b9	SUCCESS	\N	2025-11-03 17:55:11.058332	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1232	8551e45e-d682-4dfb-b206-874fe94db03d	SUCCESS	\N	2025-11-03 17:55:41.059713	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1233	eeae8874-4e46-42c5-ae91-aad300e838ca	SUCCESS	\N	2025-11-03 17:56:11.101584	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1234	a0acc2df-780e-44cc-a8c7-49ffc17ea8c6	SUCCESS	\N	2025-11-03 17:56:42.41029	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1235	f4f0a7f8-86c9-4081-9de2-0178e4aa4b83	SUCCESS	\N	2025-11-03 17:57:18.441334	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1236	82992c95-3c22-4dba-9e88-1755aaeb20f3	SUCCESS	\N	2025-11-03 17:57:47.425888	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1237	58fc988c-773b-4f34-a409-4ad2dea97d7f	SUCCESS	\N	2025-11-03 17:58:21.412277	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1238	fdba7f8a-80e5-4df0-bec8-446ec681ea9c	SUCCESS	\N	2025-11-03 17:59:12.1181	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1239	00cc867d-c0b7-4df3-b674-fdee350c0028	SUCCESS	\N	2025-11-03 18:00:10.900518	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1240	75eeac77-0e1d-4b4f-8ef9-4ffd29a677b5	SUCCESS	\N	2025-11-03 18:00:26.847182	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1241	f610b5fe-3a92-4340-b154-2de2f45228a1	SUCCESS	\N	2025-11-03 18:01:03.278437	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1242	a3927d1e-b1bf-4f58-b3e0-e36c9bc2a06c	SUCCESS	\N	2025-11-03 18:01:50.274261	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1243	4e1c5629-a81c-4cd9-b75e-6cc22d130a3d	SUCCESS	\N	2025-11-03 18:02:20.258859	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1244	ccb0c7df-10ce-4b1d-b001-e70e74248589	SUCCESS	\N	2025-11-03 18:03:30.086247	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1245	6f9758a0-62cb-42d1-b9cd-4d87f47d9cce	SUCCESS	\N	2025-11-03 18:04:06.483374	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1246	ebec99c1-0fe8-46b8-bb12-c71ffaaaf236	SUCCESS	\N	2025-11-03 18:04:36.323505	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1247	d7fd4916-3cb0-41b1-ac55-4f081769591a	SUCCESS	\N	2025-11-03 18:05:08.466336	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1248	5807123a-818c-4a02-a923-79d7cdd4aa8d	SUCCESS	\N	2025-11-03 18:05:42.457782	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1249	472a1b7b-2ba4-4975-b287-0a434ba231e3	SUCCESS	\N	2025-11-03 18:06:26.656678	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1250	6ef62acd-f107-4186-9dab-7d06ecd87873	SUCCESS	\N	2025-11-03 18:07:32.305472	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1148	3f6d503d-3994-4a1d-b1aa-a82e68793afc	SUCCESS	\N	2025-11-03 17:38:38.720232	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1153	24b39eec-0cfb-4798-afb8-cdf8d8d43c65	SUCCESS	\N	2025-11-03 17:38:38.733174	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1155	16ff1bd0-8326-46a0-bfd5-50e2b5218a35	SUCCESS	\N	2025-11-03 17:38:38.745061	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1158	ffb850d0-92d3-4b77-b0d5-8457ff75cbf4	SUCCESS	\N	2025-11-03 17:38:38.749968	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1161	f1040819-f510-4be6-bfcb-7deef27113f8	SUCCESS	\N	2025-11-03 17:38:38.759013	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1164	c7b7c3ab-687d-4002-bece-7cbaad6526b0	SUCCESS	\N	2025-11-03 17:38:38.76435	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1167	c20a5bc5-6ca8-406a-9c7c-d361f3edbb91	SUCCESS	\N	2025-11-03 17:38:38.769144	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1171	4e27d883-5b5d-494e-ad17-93fefd72c44b	SUCCESS	\N	2025-11-03 17:38:38.773469	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1174	baf2bf1b-6a5e-427d-90c4-99a66121914c	SUCCESS	\N	2025-11-03 17:38:38.777828	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1177	63a46fdf-be7a-402f-8376-4de77eeb846c	SUCCESS	\N	2025-11-03 17:38:38.785712	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1178	0b5d2f34-6e27-47c0-9aca-0a25834e8246	SUCCESS	\N	2025-11-03 17:38:38.790472	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1181	999488f2-0d4e-4cd4-a02c-b908a3f059e8	SUCCESS	\N	2025-11-03 17:38:38.79464	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1186	cb45fcca-f5cf-4e11-b36f-79e93b12c7f4	SUCCESS	\N	2025-11-03 17:38:38.80096	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1188	e829da9c-6961-4247-83a8-fd20f8038717	SUCCESS	\N	2025-11-03 17:38:38.809065	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1191	d65792d3-4854-4261-9023-b5d7bc8e5abf	SUCCESS	\N	2025-11-03 17:38:38.813771	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1195	d352e961-c5b1-4f99-a48b-c129984e15c4	SUCCESS	\N	2025-11-03 17:38:38.81831	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1198	1f0b8218-db10-496b-a279-b6fac8f7aea7	SUCCESS	\N	2025-11-03 17:38:38.8231	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
1201	58fb3f30-d96d-4add-8717-821d62949744	SUCCESS	\N	2025-11-03 17:38:38.829497	\N	consume_log_history	\\x5b5d	\\x7b7d	celery@d25293699634	0	celery_periodic_logs
\.


--
-- Data for Name: celery_tasksetmeta; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.celery_tasksetmeta (id, taskset_id, result, date_done) FROM stdin;
\.


--
-- Data for Name: constraints; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.constraints (id, segment_key, type, property, operator, value, created_at, updated_at, namespace_key, description) FROM stdin;
\.


--
-- Data for Name: distributions; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.distributions (id, rule_id, variant_id, rollout, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: flags; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.flags (key, name, description, enabled, created_at, updated_at, namespace_key, type) FROM stdin;
\.


--
-- Data for Name: namespaces; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.namespaces (key, name, description, protected, created_at, updated_at) FROM stdin;
default	Default	Default namespace	t	2025-11-02 22:09:12.240208	2025-11-02 22:09:12.240208
\.


--
-- Data for Name: operation_lock; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.operation_lock (operation, version, last_acquired_at, acquired_until) FROM stdin;
\.


--
-- Data for Name: rollout_segment_references; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.rollout_segment_references (rollout_segment_id, namespace_key, segment_key) FROM stdin;
\.


--
-- Data for Name: rollout_segments; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.rollout_segments (id, rollout_id, value, segment_operator) FROM stdin;
\.


--
-- Data for Name: rollout_thresholds; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.rollout_thresholds (id, namespace_key, rollout_id, percentage, value) FROM stdin;
\.


--
-- Data for Name: rollouts; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.rollouts (id, namespace_key, flag_key, type, description, rank, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: rule_segments; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.rule_segments (rule_id, namespace_key, segment_key) FROM stdin;
\.


--
-- Data for Name: rules; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.rules (id, flag_key, rank, created_at, updated_at, namespace_key, segment_operator) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.schema_migrations (version, dirty) FROM stdin;
12	f
\.


--
-- Data for Name: segments; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.segments (key, name, description, created_at, updated_at, match_type, namespace_key) FROM stdin;
\.


--
-- Data for Name: variants; Type: TABLE DATA; Schema: public; Owner: unstract_dev
--

COPY public.variants (id, flag_key, key, name, description, created_at, updated_at, attachment, namespace_key) FROM stdin;
\.


--
-- Data for Name: adapter_instance; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.adapter_instance (created_at, modified_at, id, adapter_name, adapter_id, adapter_metadata, adapter_metadata_b, adapter_type, is_active, shared_to_org, is_friction_less, is_usable, description, created_by_id, modified_by_id, organization_id) FROM stdin;
2025-11-03 01:59:55.653807+00	2025-11-03 01:59:55.653846+00	85c5aa71-ed97-4146-a83b-c2c13c200a38	claude	bedrock|8d18571f-5e96-4505-bd28-ad0379c64064	{}	\\x6741414141414270434179622d74386c68635555756f4c68336b49462d7048416e5742566d767430597a764b5951534a72474a64384e4c49564b39444b7743344e7142654458575f325031716951524f796b41767069346e33637672325a6a336a344e704958454d334a333775767a795551763134426e414973417531414662585f76337372544862446c6a3743536c35524b456769536c756b66384e4d463769627175653733307175676b6743484b6252544c5a334c7872685353724d755f7132744f4661316e645a4f4372576e725563364f7975357269492d427762586a386f2d67727a5849304849304a624e5f734146503568585139465347523465394a726a594e65553868474f77336e764e4a567375794f31646b667134526a5842596e6754665a525f41327554762d4e65566e2d4449635a36364d736355496a6e4f44564d73686f6449594769796144552d564552566d517473554b6e4f33396d4d434a59414333514357346f6b39667955585f7378723549495837367348695a58365156513751665f614c4864444471623957544832453749614e704434395f4442456a774b4d4732583250475638705359636b50485272574c316f4f777355475a6d57686a395a3957374878577438497052756b4b6c734e355f58434e427236673d3d	LLM	f	f	f	t	\N	1	1	1
2025-11-03 02:00:15.075236+00	2025-11-03 02:00:15.075265+00	ae657576-a4ac-48d9-9df9-977f8c901eea	vector	postgres|70ab6cc2-e86a-4e5a-896f-498a95022d34	{}	\\x6741414141414270434179763534435639574e36726d3138744832545a59374e366e4370685949443854474149465442584164393170737368462d55446b3766305045784a6b4d4e64714c616a624e624932763263333257664355726d72446c71324232477968346b626565647773625347335048574868394353387957564f58574a63564179503879545673534747526d61357a5f6973586e5f2d48575341784c6432674a5a69466f77736d2d77353242686d5133584a4a6d5534685050314c39364f38797a4f344d4e2d3966667335774f725973625a5f4a6d7536517566644f72494250556b5244636237644b375757547a6f767a4f6b572d356758524c6772537278344250766e4944	VECTOR_DB	f	f	f	t	\N	1	1	1
2025-11-03 02:00:36.643947+00	2025-11-03 02:00:36.643985+00	ead5cf5e-845c-4c93-b5e1-b2cffc0b6a1b	titan	bedrock|88199741-8d7e-4e8c-9d92-d76b0dc20c91	{}	\\x674141414141427043417a4537705f4c644d41647a385565536f78523569535f38534d704a49766b3059466a5a4b377230727076646c66616a38503063435270385934596d73372d594631464e7a6f3967657374566f4864736668364278454b4a52784f4778335a4f4173356a76557842335f667655524d517a524b71554f2d77715a4e70344c4c6c6d4a75565774746c4e72316a5a382d5455755a727366374d4b52456f426a49667762643444654e3868715a784f347a36335542577031587672546b307a526c5f4b307170466a71387571655a626562664638474a39372d5434564647764c736c437a4357704f6d67627142425949785a68395a77525a706a57794658597562503157636278796367596269636b457552376172436b385a6e5831755046483262704c436f6241687834394e7a395236693362427243425a7353506f55542d506171512d556734566a6e6d524b696f47314f73796a482d73626c3243597837516c6849626e74765a6b515450797a4232765f756d4b4c396369705346712d6f676e614a3357764d6b51657877463579625f5f6b46454c6c4a65673d3d	EMBEDDING	f	f	f	t	\N	1	1	1
2025-11-03 02:00:42.677267+00	2025-11-03 02:00:42.677281+00	83ba2d43-797c-4cbc-95f2-4ceaa7f15482	llm-whisperer-v2	llmwhisperer|a5e6b8af-3e1f-4a80-b006-d017e8e67f93	{}	\\x674141414141427043417a4b6f76656f49656a496e4c6148314879596e5a3772707632335f64664e324a50454a414c44314665575266506555654c626b6f62764a4744464e57446b657541486c426470547233736c724667567253357642497244614272303839775f6c48666b3448323178687445516d4567446f566d6164396b5763774239476874734c6a4b44724159586135644f38475f443647627a5772726e4d543741397a353071323357504339315544633752763854636647506f72575041637a626a414d53594f72656575574c4c44366171392d4259334c335f754d72577035666650537a5377745f38723072627430732d674a4e6b6c66526437306f555859314547645475333074356243724f627549755f37574366566372776f6c706a59706b5a41614e45355670684d6131314c64767661436874716b667949785961703967715a356c6273785335726e6a5f65663034436b41663041793145336d6737784f46634d6666774f4e4c78573966384c4d32524858764157735a723168396d5970546e48367a635963565777366d4a2d44582d305351504759343353576d303873475054314f497444484d5f6c6d6e4f4b687630755f493876576858554c6e594f317a625051333037747a59684e6d786f5f4f4d436a4e49456657586830324f78325972572d697569785a6c3569655632504a354b7a76453374716d4f75453475464173476457726d3749724859757172536a7a532d3179776c37587866793632386b36353959577831633333356f45434648364e3254483172477073674f4e7864494b4c4d50772d4675594f485767435f78727a71514878563943416d793059653243373379554236443545366e5a3975416744506c78716f4a7364335f4a637073325052386f6c66436f69536a327469744274665f637248655451466876634b47666a3447516776654571426835624e774c64327a6130357753544f626f6f4c5843704b786a4b575a31736f45425535494a5a4952724e4e746b6161502d724e5153475734724476757931644a5f553d	X2TEXT	f	f	f	t	\N	1	1	1
\.


--
-- Data for Name: adapter_instance_shared_users; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.adapter_instance_shared_users (id, adapterinstance_id, user_id) FROM stdin;
\.


--
-- Data for Name: api_deployment; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.api_deployment (created_at, modified_at, id, display_name, description, is_active, api_endpoint, api_name, created_by_id, modified_by_id, organization_id, workflow_id, shared_to_org) FROM stdin;
\.


--
-- Data for Name: api_deployment_key; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.api_deployment_key (created_at, modified_at, id, api_key, description, is_active, api_id, created_by_id, modified_by_id, pipeline_id) FROM stdin;
\.


--
-- Data for Name: api_deployment_shared_users; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.api_deployment_shared_users (id, apideployment_id, user_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add User	1	add_user
2	Can change User	1	change_user
3	Can delete User	1	delete_user
4	Can view User	1	view_user
5	Can add Organization	2	add_organization
6	Can change Organization	2	change_organization
7	Can delete Organization	2	delete_organization
8	Can view Organization	2	view_organization
9	Can add Platform Key	3	add_platformkey
10	Can change Platform Key	3	change_platformkey
11	Can delete Platform Key	3	delete_platformkey
12	Can view Platform Key	3	view_platformkey
13	Can add page usage	4	add_pageusage
14	Can change page usage	4	change_pageusage
15	Can delete page usage	4	delete_pageusage
16	Can view page usage	4	view_pageusage
17	Can add log entry	5	add_logentry
18	Can change log entry	5	change_logentry
19	Can delete log entry	5	delete_logentry
20	Can view log entry	5	view_logentry
21	Can add permission	6	add_permission
22	Can change permission	6	change_permission
23	Can delete permission	6	delete_permission
24	Can view permission	6	view_permission
25	Can add group	7	add_group
26	Can change group	7	change_group
27	Can delete group	7	delete_group
28	Can view group	7	view_group
29	Can add content type	8	add_contenttype
30	Can change content type	8	change_contenttype
31	Can delete content type	8	delete_contenttype
32	Can view content type	8	view_contenttype
33	Can add session	9	add_session
34	Can change session	9	change_session
35	Can delete session	9	delete_session
36	Can view session	9	view_session
37	Can add association	10	add_association
38	Can change association	10	change_association
39	Can delete association	10	delete_association
40	Can view association	10	view_association
41	Can add code	11	add_code
42	Can change code	11	change_code
43	Can delete code	11	delete_code
44	Can view code	11	view_code
45	Can add nonce	12	add_nonce
46	Can change nonce	12	change_nonce
47	Can delete nonce	12	delete_nonce
48	Can view nonce	12	view_nonce
49	Can add user social auth	13	add_usersocialauth
50	Can change user social auth	13	change_usersocialauth
51	Can delete user social auth	13	delete_usersocialauth
52	Can view user social auth	13	view_usersocialauth
53	Can add partial	14	add_partial
54	Can change partial	14	change_partial
55	Can delete partial	14	delete_partial
56	Can view partial	14	view_partial
57	Can add crontab	15	add_crontabschedule
58	Can change crontab	15	change_crontabschedule
59	Can delete crontab	15	delete_crontabschedule
60	Can view crontab	15	view_crontabschedule
61	Can add interval	16	add_intervalschedule
62	Can change interval	16	change_intervalschedule
63	Can delete interval	16	delete_intervalschedule
64	Can view interval	16	view_intervalschedule
65	Can add periodic task	17	add_periodictask
66	Can change periodic task	17	change_periodictask
67	Can delete periodic task	17	delete_periodictask
68	Can view periodic task	17	view_periodictask
69	Can add periodic tasks	18	add_periodictasks
70	Can change periodic tasks	18	change_periodictasks
71	Can delete periodic tasks	18	delete_periodictasks
72	Can view periodic tasks	18	view_periodictasks
73	Can add solar event	19	add_solarschedule
74	Can change solar event	19	change_solarschedule
75	Can delete solar event	19	delete_solarschedule
76	Can view solar event	19	view_solarschedule
77	Can add clocked	20	add_clockedschedule
78	Can change clocked	20	change_clockedschedule
79	Can delete clocked	20	delete_clockedschedule
80	Can view clocked	20	view_clockedschedule
81	Can add Connector Auth	21	add_connectorauth
82	Can change Connector Auth	21	change_connectorauth
83	Can delete Connector Auth	21	delete_connectorauth
84	Can view Connector Auth	21	view_connectorauth
85	Can add Organization Member	22	add_organizationmember
86	Can change Organization Member	22	change_organizationmember
87	Can delete Organization Member	22	delete_organizationmember
88	Can view Organization Member	22	view_organizationmember
89	Can add Connector Instance	23	add_connectorinstance
90	Can change Connector Instance	23	change_connectorinstance
91	Can delete Connector Instance	23	delete_connectorinstance
92	Can view Connector Instance	23	view_connectorinstance
93	Can add adapter instance	24	add_adapterinstance
94	Can change adapter instance	24	change_adapterinstance
95	Can delete adapter instance	24	delete_adapterinstance
96	Can view adapter instance	24	view_adapterinstance
97	Can add Default Adapter for Organization User	25	add_userdefaultadapter
98	Can change Default Adapter for Organization User	25	change_userdefaultadapter
99	Can delete Default Adapter for Organization User	25	delete_userdefaultadapter
100	Can view Default Adapter for Organization User	25	view_userdefaultadapter
101	Can add Workflow File Execution	26	add_workflowfileexecution
102	Can change Workflow File Execution	26	change_workflowfileexecution
103	Can delete Workflow File Execution	26	delete_workflowfileexecution
104	Can view Workflow File Execution	26	view_workflowfileexecution
105	Can add Workflow Endpoint	27	add_workflowendpoint
106	Can change Workflow Endpoint	27	change_workflowendpoint
107	Can delete Workflow Endpoint	27	delete_workflowendpoint
108	Can view Workflow Endpoint	27	view_workflowendpoint
109	Can add Execution Log	28	add_executionlog
110	Can change Execution Log	28	change_executionlog
111	Can delete Execution Log	28	delete_executionlog
112	Can view Execution Log	28	view_executionlog
113	Can add Workflow Execution	29	add_workflowexecution
114	Can change Workflow Execution	29	change_workflowexecution
115	Can delete Workflow Execution	29	delete_workflowexecution
116	Can view Workflow Execution	29	view_workflowexecution
117	Can add Workflow	30	add_workflow
118	Can change Workflow	30	change_workflow
119	Can delete Workflow	30	delete_workflow
120	Can view Workflow	30	view_workflow
121	Can add File History	31	add_filehistory
122	Can change File History	31	change_filehistory
123	Can delete File History	31	delete_filehistory
124	Can view File History	31	view_filehistory
125	Can add Tool Instance	32	add_toolinstance
126	Can change Tool Instance	32	change_toolinstance
127	Can delete Tool Instance	32	delete_toolinstance
128	Can view Tool Instance	32	view_toolinstance
129	Can add Pipeline	33	add_pipeline
130	Can change Pipeline	33	change_pipeline
131	Can delete Pipeline	33	delete_pipeline
132	Can view Pipeline	33	view_pipeline
133	Can add Api Deployment	34	add_apideployment
134	Can change Api Deployment	34	change_apideployment
135	Can delete Api Deployment	34	delete_apideployment
136	Can view Api Deployment	34	view_apideployment
137	Can add Api Deployment key	35	add_apikey
138	Can change Api Deployment key	35	change_apikey
139	Can delete Api Deployment key	35	delete_apikey
140	Can view Api Deployment key	35	view_apikey
141	Can add usage	36	add_usage
142	Can change usage	36	change_usage
143	Can delete usage	36	delete_usage
144	Can view usage	36	view_usage
145	Can add Notification	37	add_notification
146	Can change Notification	37	change_notification
147	Can delete Notification	37	delete_notification
148	Can view Notification	37	view_notification
149	Can add Profile Manager	38	add_profilemanager
150	Can change Profile Manager	38	change_profilemanager
151	Can delete Profile Manager	38	delete_profilemanager
152	Can view Profile Manager	38	view_profilemanager
153	Can add Tool Studio Prompt	39	add_toolstudioprompt
154	Can change Tool Studio Prompt	39	change_toolstudioprompt
155	Can delete Tool Studio Prompt	39	delete_toolstudioprompt
156	Can view Tool Studio Prompt	39	view_toolstudioprompt
157	Can add Custom Tool	40	add_customtool
158	Can change Custom Tool	40	change_customtool
159	Can delete Custom Tool	40	delete_customtool
160	Can view Custom Tool	40	view_customtool
161	Can add Prompt Studio Registry	41	add_promptstudioregistry
162	Can change Prompt Studio Registry	41	change_promptstudioregistry
163	Can delete Prompt Studio Registry	41	delete_promptstudioregistry
164	Can view Prompt Studio Registry	41	view_promptstudioregistry
165	Can add Prompt Studio Output Manager	42	add_promptstudiooutputmanager
166	Can change Prompt Studio Output Manager	42	change_promptstudiooutputmanager
167	Can delete Prompt Studio Output Manager	42	delete_promptstudiooutputmanager
168	Can view Prompt Studio Output Manager	42	view_promptstudiooutputmanager
169	Can add Document Manager	43	add_documentmanager
170	Can change Document Manager	43	change_documentmanager
171	Can delete Document Manager	43	delete_documentmanager
172	Can view Document Manager	43	view_documentmanager
173	Can add Index Manager	44	add_indexmanager
174	Can change Index Manager	44	change_indexmanager
175	Can delete Index Manager	44	delete_indexmanager
176	Can view Index Manager	44	view_indexmanager
177	Can add Tag	45	add_tag
178	Can change Tag	45	change_tag
179	Can delete Tag	45	delete_tag
180	Can view Tag	45	view_tag
181	Can add Configuration	46	add_configuration
182	Can change Configuration	46	change_configuration
183	Can delete Configuration	46	delete_configuration
184	Can view Configuration	46	view_configuration
\.


--
-- Data for Name: configuration; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.configuration (created_at, modified_at, id, key, value, enabled, organization_id) FROM stdin;
\.


--
-- Data for Name: connector_auth; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.connector_auth (provider, uid, extra_data, created, modified, id, user_id) FROM stdin;
\.


--
-- Data for Name: connector_instance; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.connector_instance (created_at, modified_at, id, connector_name, connector_id, connector_metadata, connector_version, connector_mode, connector_auth_id, created_by_id, modified_by_id, organization_id, shared_to_org) FROM stdin;
\.


--
-- Data for Name: connector_instance_shared_users; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.connector_instance_shared_users (id, connectorinstance_id, user_id) FROM stdin;
\.


--
-- Data for Name: custom_tool; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.custom_tool (created_at, modified_at, tool_id, tool_name, description, author, icon, output, log_id, summarize_context, summarize_as_source, summarize_prompt, preamble, postamble, prompt_grammer, exclude_failed, single_pass_extraction_mode, enable_challenge, enable_highlight, challenge_llm_id, created_by_id, modified_by_id, monitor_llm_id, organization_id, summarize_llm_adapter_id, shared_to_org) FROM stdin;
2025-11-03 07:26:54.526876+00	2025-11-03 07:27:57.855746+00	bb63d19d-a7d4-40ee-acbf-0dc4f155adca	Medical claims	Eob processing	datadestintion		b4d87a97-3373-4160-8237-4a62905dab5b	8daf914d-485d-4d22-9bd8-5c539f105e40	f	f		Your ability to extract and summarize this context accurately is essential for effective analysis. Pay close attention to the context's language, structure, and any cross-references to ensure a comprehensive and precise extraction of information. Do not use prior knowledge or information from outside the context to answer the questions. Only use the information provided in the context to answer the questions.	Do not include any explanation in the reply. Only include the extracted information in the reply.	\N	t	f	f	f	\N	1	1	\N	1	\N	f
\.


--
-- Data for Name: custom_tool_shared_users; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.custom_tool_shared_users (id, customtool_id, user_id) FROM stdin;
\.


--
-- Data for Name: default_organization_user_adapter; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.default_organization_user_adapter (id, created_at, modified_at, default_embedding_adapter_id, default_llm_adapter_id, default_vector_db_adapter_id, default_x2text_adapter_id, organization_member_id) FROM stdin;
1	2025-11-03 01:59:55.670768+00	2025-11-03 02:00:42.684031+00	ead5cf5e-845c-4c93-b5e1-b2cffc0b6a1b	85c5aa71-ed97-4146-a83b-c2c13c200a38	ae657576-a4ac-48d9-9df9-977f8c901eea	83ba2d43-797c-4cbc-95f2-4ceaa7f15482	1
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_clockedschedule; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.django_celery_beat_clockedschedule (id, clocked_time) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_crontabschedule; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.django_celery_beat_crontabschedule (id, minute, hour, day_of_week, day_of_month, month_of_year, timezone) FROM stdin;
1	0	4	*	*	*	UTC
\.


--
-- Data for Name: django_celery_beat_intervalschedule; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.django_celery_beat_intervalschedule (id, every, period) FROM stdin;
1	30	seconds
\.


--
-- Data for Name: django_celery_beat_periodictask; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.django_celery_beat_periodictask (id, name, task, args, kwargs, queue, exchange, routing_key, expires, enabled, last_run_at, total_run_count, date_changed, description, crontab_id, interval_id, solar_id, one_off, start_time, priority, headers, clocked_id, expire_seconds) FROM stdin;
4	celery.backend_cleanup	celery.backend_cleanup	[]	{}	\N	\N	\N	\N	t	2025-11-03 04:00:00.001304+00	1	2025-11-03 15:17:01.759946+00		1	\N	\N	f	\N	\N	{}	\N	43200
1	workflow_log_history_v2	consume_log_history	[]	{}	celery_periodic_logs	\N	\N	\N	t	2025-11-03 18:14:26.200782+00	1232	2025-11-03 18:14:52.391816+00		\N	1	\N	f	\N	\N	{}	\N	\N
\.


--
-- Data for Name: django_celery_beat_periodictasks; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.django_celery_beat_periodictasks (ident, last_update) FROM stdin;
1	2025-11-03 17:55:15.140161+00
\.


--
-- Data for Name: django_celery_beat_solarschedule; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.django_celery_beat_solarschedule (id, event, latitude, longitude) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.django_content_type (id, app_label, model) FROM stdin;
1	account_v2	user
2	account_v2	organization
3	account_v2	platformkey
4	account_usage	pageusage
5	admin	logentry
6	auth	permission
7	auth	group
8	contenttypes	contenttype
9	sessions	session
10	social_django	association
11	social_django	code
12	social_django	nonce
13	social_django	usersocialauth
14	social_django	partial
15	django_celery_beat	crontabschedule
16	django_celery_beat	intervalschedule
17	django_celery_beat	periodictask
18	django_celery_beat	periodictasks
19	django_celery_beat	solarschedule
20	django_celery_beat	clockedschedule
21	connector_auth_v2	connectorauth
22	tenant_account_v2	organizationmember
23	connector_v2	connectorinstance
24	adapter_processor_v2	adapterinstance
25	adapter_processor_v2	userdefaultadapter
26	file_execution	workflowfileexecution
27	endpoint_v2	workflowendpoint
28	workflow_v2	executionlog
29	workflow_v2	workflowexecution
30	workflow_v2	workflow
31	workflow_v2	filehistory
32	tool_instance_v2	toolinstance
33	pipeline_v2	pipeline
34	api_v2	apideployment
35	api_v2	apikey
36	usage_v2	usage
37	notification_v2	notification
38	prompt_profile_manager_v2	profilemanager
39	prompt_studio_v2	toolstudioprompt
40	prompt_studio_core_v2	customtool
41	prompt_studio_registry_v2	promptstudioregistry
42	prompt_studio_output_manager_v2	promptstudiooutputmanager
43	prompt_studio_document_manager_v2	documentmanager
44	prompt_studio_index_manager_v2	indexmanager
45	tags	tag
46	configuration	configuration
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.django_migrations (id, app, name, applied) FROM stdin;
1	account_usage	0001_initial	2025-11-02 22:09:49.060785+00
2	account_usage	0002_alter_pageusage_pages_processed	2025-11-02 22:09:49.064286+00
3	contenttypes	0001_initial	2025-11-02 22:09:49.073458+00
4	contenttypes	0002_remove_content_type_name	2025-11-02 22:09:49.078928+00
5	auth	0001_initial	2025-11-02 22:09:49.124369+00
6	auth	0002_alter_permission_name_max_length	2025-11-02 22:09:49.128119+00
7	auth	0003_alter_user_email_max_length	2025-11-02 22:09:49.132093+00
8	auth	0004_alter_user_username_opts	2025-11-02 22:09:49.136929+00
9	auth	0005_alter_user_last_login_null	2025-11-02 22:09:49.141078+00
10	auth	0006_require_contenttypes_0002	2025-11-02 22:09:49.142169+00
11	auth	0007_alter_validators_add_error_messages	2025-11-02 22:09:49.145026+00
12	auth	0008_alter_user_username_max_length	2025-11-02 22:09:49.147887+00
13	auth	0009_alter_user_last_name_max_length	2025-11-02 22:09:49.150813+00
14	auth	0010_alter_group_name_max_length	2025-11-02 22:09:49.154822+00
15	auth	0011_update_proxy_permissions	2025-11-02 22:09:49.158217+00
16	auth	0012_alter_user_first_name_max_length	2025-11-02 22:09:49.16081+00
17	account_v2	0001_initial	2025-11-02 22:09:49.233451+00
18	account_v2	0002_user_auth_provider	2025-11-02 22:09:49.238635+00
19	tenant_account_v2	0001_initial	2025-11-02 22:09:49.272812+00
20	adapter_processor_v2	0001_initial	2025-11-02 22:09:49.402629+00
21	admin	0001_initial	2025-11-02 22:09:49.435577+00
22	admin	0002_logentry_remove_auto_add	2025-11-02 22:09:49.467629+00
23	admin	0003_logentry_add_action_flag_choices	2025-11-02 22:09:49.486011+00
24	workflow_v2	0001_initial	2025-11-02 22:09:49.594583+00
25	pipeline_v2	0001_initial	2025-11-02 22:09:49.662771+00
26	api_v2	0001_initial	2025-11-02 22:09:49.831474+00
27	api_v2	0002_apideployment_shared_to_org_and_more	2025-11-02 22:09:49.942637+00
28	configuration	0001_initial	2025-11-02 22:09:50.081565+00
29	connector_auth_v2	0001_initial	2025-11-02 22:09:50.144291+00
30	connector_v2	0001_initial	2025-11-02 22:09:50.294349+00
31	endpoint_v2	0001_initial	2025-11-02 22:09:50.354479+00
32	workflow_v2	0002_remove_workflow_llm_response_and_more	2025-11-02 22:09:50.459175+00
33	workflow_v2	0003_workflowexecution_result_acknowledged	2025-11-02 22:09:50.472087+00
34	file_execution	0001_initial	2025-11-02 22:09:50.541171+00
35	workflow_v2	0004_executionlog_file_execution	2025-11-02 22:09:50.555795+00
36	tags	0001_initial	2025-11-02 22:09:50.651318+00
37	workflow_v2	0005_workflowexecution_tags	2025-11-02 22:09:50.713071+00
38	workflow_v2	0006_workflowexecution_workflow_ex_workflo_5942c9_idx_and_more	2025-11-02 22:09:50.752234+00
39	workflow_v2	0007_update_execution_time	2025-11-02 22:09:50.81507+00
40	workflow_v2	0008_workflowexecution_total_files_and_more	2025-11-02 22:09:50.871025+00
41	workflow_v2	0009_update_total_files	2025-11-02 22:09:52.660114+00
42	workflow_v2	0010_executionlog_wf_execution_and_more	2025-11-02 22:09:52.833015+00
43	workflow_v2	0011_remove_filehistory_unique_workflow_cachekey_and_more	2025-11-02 22:09:52.972907+00
44	workflow_v2	0012_remove_wf_exec_with_invalid_wf_references	2025-11-02 22:09:53.056496+00
45	workflow_v2	0013_remove_workflowexecution_workflow_id_and_more	2025-11-02 22:09:53.163419+00
46	workflow_v2	0014_remove_filehistory_unique_workflow_cachekey_and_more	2025-11-02 22:09:53.473481+00
47	workflow_v2	0015_executionlog_idx_wf_execution_event_time_and_more	2025-11-02 22:09:53.541565+00
48	connector_v2	0002_alter_connectorinstance_connector_metadata_and_more	2025-11-02 22:09:53.838554+00
49	connector_v2	0003_migrate_to_centralized_connectors	2025-11-02 22:09:53.955074+00
50	connector_v2	0004_remove_connectorinstance_unique_workflow_connector_and_more	2025-11-02 22:09:54.295737+00
51	connector_v2	0005_fix_unintended_connector_sharing	2025-11-02 22:09:54.340292+00
52	django_celery_beat	0001_initial	2025-11-02 22:09:54.424607+00
53	django_celery_beat	0002_auto_20161118_0346	2025-11-02 22:09:54.453366+00
54	django_celery_beat	0003_auto_20161209_0049	2025-11-02 22:09:54.484566+00
55	django_celery_beat	0004_auto_20170221_0000	2025-11-02 22:09:54.491341+00
56	django_celery_beat	0005_add_solarschedule_events_choices	2025-11-02 22:09:54.503917+00
57	django_celery_beat	0006_auto_20180322_0932	2025-11-02 22:09:54.586354+00
58	django_celery_beat	0007_auto_20180521_0826	2025-11-02 22:09:54.619562+00
59	django_celery_beat	0008_auto_20180914_1922	2025-11-02 22:09:54.677685+00
60	django_celery_beat	0006_auto_20180210_1226	2025-11-02 22:09:54.702802+00
61	django_celery_beat	0006_periodictask_priority	2025-11-02 22:09:54.718692+00
62	django_celery_beat	0009_periodictask_headers	2025-11-02 22:09:54.744582+00
63	django_celery_beat	0010_auto_20190429_0326	2025-11-02 22:09:54.977549+00
64	django_celery_beat	0011_auto_20190508_0153	2025-11-02 22:09:54.996299+00
65	django_celery_beat	0012_periodictask_expire_seconds	2025-11-02 22:09:55.00693+00
66	django_celery_beat	0013_auto_20200609_0727	2025-11-02 22:09:55.014752+00
67	django_celery_beat	0014_remove_clockedschedule_enabled	2025-11-02 22:09:55.022701+00
68	django_celery_beat	0015_edit_solarschedule_events_choices	2025-11-02 22:09:55.027621+00
69	django_celery_beat	0016_alter_crontabschedule_timezone	2025-11-02 22:09:55.036022+00
70	django_celery_beat	0017_alter_crontabschedule_month_of_year	2025-11-02 22:09:55.041257+00
71	django_celery_beat	0018_improve_crontab_helptext	2025-11-02 22:09:55.046046+00
72	endpoint_v2	0002_alter_workflowendpoint_connector_instance	2025-11-02 22:09:55.065134+00
73	file_execution	0002_rename_status_and_update_exec_time	2025-11-02 22:09:55.088355+00
74	file_execution	0003_alter_workflowfileexecution_status_and_more	2025-11-02 22:09:55.117727+00
75	file_execution	0004_alter_workflowfileexecution_status	2025-11-02 22:09:55.1237+00
76	file_execution	0005_workflowfileexecution_fs_metadata_and_more	2025-11-02 22:09:55.148252+00
77	file_execution	0006_workflowfileexecution_wf_file_hash_path_status_idx_and_more	2025-11-02 22:09:55.157972+00
78	notification_v2	0001_initial	2025-11-02 22:09:55.195809+00
79	pipeline_v2	0002_remove_pipeline_unique_pipeline_and_more	2025-11-02 22:09:55.350961+00
80	pipeline_v2	0003_add_sharing_fields_to_pipeline	2025-11-02 22:09:55.421318+00
81	prompt_studio_core_v2	0001_initial	2025-11-02 22:09:55.519244+00
82	prompt_profile_manager_v2	0001_initial	2025-11-02 22:09:55.601137+00
83	prompt_profile_manager_v2	0002_alter_profilemanager_retrieval_strategy	2025-11-02 22:09:55.618101+00
84	prompt_profile_manager_v2	0003_alter_profilemanager_retrieval_strategy	2025-11-02 22:09:55.633507+00
85	prompt_profile_manager_v2	0002_alter_profilemanager_is_summarize_llm	2025-11-02 22:09:55.656275+00
86	prompt_profile_manager_v2	0004_merge_20250805_1025	2025-11-02 22:09:55.660486+00
87	prompt_studio_core_v2	0002_add_summarize_llm_adapter	2025-11-02 22:09:55.69809+00
88	prompt_studio_core_v2	0003_alter_customtool_summarize_llm_adapter	2025-11-02 22:09:55.720849+00
89	prompt_studio_core_v2	0004_add_shared_to_org_to_custom_tool	2025-11-02 22:09:55.747212+00
90	prompt_studio_document_manager_v2	0001_initial	2025-11-02 22:09:55.823084+00
91	prompt_studio_index_manager_v2	0001_initial	2025-11-02 22:09:55.873019+00
92	prompt_studio_index_manager_v2	0002_indexmanager_extraction_status	2025-11-02 22:09:55.887152+00
93	prompt_studio_v2	0001_initial	2025-11-02 22:09:55.954652+00
94	prompt_studio_output_manager_v2	0001_initial	2025-11-02 22:09:56.016989+00
95	prompt_studio_output_manager_v2	0002_promptstudiooutputmanager_highlight_data	2025-11-02 22:09:56.040589+00
96	prompt_studio_output_manager_v2	0003_promptstudiooutputmanager_confidence_data	2025-11-02 22:09:56.057041+00
97	prompt_studio_registry_v2	0001_initial	2025-11-02 22:09:56.118909+00
98	prompt_studio_v2	0002_alter_toolstudioprompt_enforce_type	2025-11-02 22:09:56.140048+00
99	prompt_studio_v2	0003_toolstudioprompt_required	2025-11-02 22:09:56.158246+00
100	prompt_studio_v2	0004_alter_toolstudioprompt_required	2025-11-02 22:09:56.182829+00
101	prompt_studio_v2	0005_alter_toolstudioprompt_required	2025-11-02 22:09:56.204494+00
102	prompt_studio_v2	0006_alter_toolstudioprompt_enforce_type	2025-11-02 22:09:56.219608+00
103	prompt_studio_v2	0007_merge_table_record_cell_types	2025-11-02 22:09:56.268337+00
104	prompt_studio_v2	0008_alter_toolstudioprompt_enforce_type	2025-11-02 22:09:56.279943+00
105	prompt_studio_v2	0009_alter_toolstudioprompt_enforce_type	2025-11-02 22:09:56.294922+00
106	prompt_studio_v2	0010_update_enforce_type_text	2025-11-02 22:09:56.336566+00
107	prompt_studio_v2	0011_revert_cell_type_merge	2025-11-02 22:09:56.365922+00
108	prompt_studio_v2	0012_alter_toolstudioprompt_enforce_type	2025-11-02 22:09:56.378903+00
109	prompt_studio_v2	0013_toolstudioprompt_enable_postprocessing_webhook_and_more	2025-11-02 22:09:56.412161+00
110	sessions	0001_initial	2025-11-02 22:09:56.443294+00
111	default	0001_initial	2025-11-02 22:09:56.515332+00
112	social_auth	0001_initial	2025-11-02 22:09:56.517059+00
113	default	0002_add_related_name	2025-11-02 22:09:56.536961+00
114	social_auth	0002_add_related_name	2025-11-02 22:09:56.538013+00
115	default	0003_alter_email_max_length	2025-11-02 22:09:56.541648+00
116	social_auth	0003_alter_email_max_length	2025-11-02 22:09:56.542391+00
117	default	0004_auto_20160423_0400	2025-11-02 22:09:56.558498+00
118	social_auth	0004_auto_20160423_0400	2025-11-02 22:09:56.559704+00
119	social_auth	0005_auto_20160727_2333	2025-11-02 22:09:56.564271+00
120	social_django	0006_partial	2025-11-02 22:09:56.579943+00
121	social_django	0007_code_timestamp	2025-11-02 22:09:56.584371+00
122	social_django	0008_partial_timestamp	2025-11-02 22:09:56.589631+00
123	social_django	0009_auto_20191118_0520	2025-11-02 22:09:56.61975+00
124	social_django	0010_uid_db_index	2025-11-02 22:09:56.635458+00
125	social_django	0011_alter_id_fields	2025-11-02 22:09:56.683385+00
126	social_django	0012_usersocialauth_extra_data_new	2025-11-02 22:09:56.699593+00
127	social_django	0013_migrate_extra_data	2025-11-02 22:09:56.719064+00
128	social_django	0014_remove_usersocialauth_extra_data	2025-11-02 22:09:56.729239+00
129	social_django	0015_rename_extra_data_new_usersocialauth_extra_data	2025-11-02 22:09:56.746872+00
130	tool_instance_v2	0001_initial	2025-11-02 22:09:56.78648+00
131	tool_instance_v2	0002_remove_toolinstance_input_db_connector_and_more	2025-11-02 22:09:57.119949+00
132	usage_v2	0001_initial	2025-11-02 22:09:57.175438+00
133	usage_v2	0002_alter_usage_run_id	2025-11-02 22:09:57.340671+00
134	usage_v2	0003_usage_usage_executi_4deb35_idx	2025-11-02 22:09:57.367282+00
135	workflow_v2	0016_add_filehistory_deletion_index	2025-11-02 22:09:57.383505+00
136	workflow_v2	0017_workflow_shared_to_org_workflow_shared_users	2025-11-02 22:09:57.489192+00
137	social_django	0001_initial	2025-11-02 22:09:57.496454+00
138	social_django	0004_auto_20160423_0400	2025-11-02 22:09:57.498958+00
139	social_django	0003_alter_email_max_length	2025-11-02 22:09:57.502441+00
140	social_django	0005_auto_20160727_2333	2025-11-02 22:09:57.505763+00
141	social_django	0002_add_related_name	2025-11-02 22:09:57.50978+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.django_session (session_key, session_data, expire_date) FROM stdin;
q8aclhknwwhka8lxl6kiqo1q8tj99hx2	.eJxVjMEOgyAQBf-Fc0NAFKXH3vsNZGEXpVpIUC9t-u_FxEN7nXlv3szCvk12X6nYiOzKJLv8Mgd-pnQIfEAaM_c5bSU6fkz4aVd-z0jL7dz-BSZYp_oO2BoZhJKDNiTQBC-oC40G0qZxkpTrhVQ0dEq1iFIG7FEH1WqhADyKGs1lhBRfsMWcavGZ_Wwrq6bkhSoBfMbEPl8CK0X1:1vFgHH:TvtdIVlkBhZkZVrtEC9VBuwQGT-RYxxUn5xZjOOmOkY	2025-11-03 22:10:23.071303+00
sjwy08ims697rkwim3kxi9pf73coo32a	.eJxVjMEOgyAQBf-Fc0NAFKXH3vsNZGEXpVpIUC9t-u_FxEN7nXlv3szCvk12X6nYiOzKJLv8Mgd-pnQIfEAaM_c5bSU6fkz4aVd-z0jL7dz-BSZYp_oO2BoZhJKDNiTQBC-oC40G0qZxkpTrhVQ0dEq1iFIG7FEH1WqhADyKGs1lhBRfsMWcavGZ_Wwrq6bkhSoBfMbEPl8CK0X1:1vFyLw:IhL_IS-omWoh4ezmyLMNQxYs3rw6UQGyTPCO6q-lyO0	2025-11-04 17:28:24.481096+00
\.


--
-- Data for Name: document_manager; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.document_manager (created_at, modified_at, document_id, document_name, created_by_id, modified_by_id, tool_id) FROM stdin;
2025-11-03 07:27:57.754334+00	2025-11-03 07:27:57.75439+00	b4d87a97-3373-4160-8237-4a62905dab5b	Diagnosis and Treatment (Referral from THSteps Checkup).pdf	\N	\N	bb63d19d-a7d4-40ee-acbf-0dc4f155adca
\.


--
-- Data for Name: execution_log; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.execution_log (created_at, modified_at, id, execution_id, data, event_time, file_execution_id, wf_execution_id) FROM stdin;
\.


--
-- Data for Name: file_history; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.file_history (created_at, modified_at, id, cache_key, status, error, result, metadata, workflow_id, provider_file_uuid, file_path) FROM stdin;
\.


--
-- Data for Name: index_manager; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.index_manager (created_at, modified_at, index_manager_id, raw_index_id, summarize_index_id, index_ids_history, created_by_id, document_manager_id, modified_by_id, profile_manager_id, extraction_status) FROM stdin;
2025-11-03 07:28:34.65417+00	2025-11-03 07:28:34.654265+00	6cbdaf57-9c30-4f6c-852c-e4eb311237f7	b91765d30ac9f51dab49fea2224f0f6102c6d224183261b09ce206fd76c342b6	\N	"[\\"b91765d30ac9f51dab49fea2224f0f6102c6d224183261b09ce206fd76c342b6\\"]"	\N	b4d87a97-3373-4160-8237-4a62905dab5b	\N	36e887d3-66b6-4764-a293-a660afc1e36c	{"b91765d30ac9f51dab49fea2224f0f6102c6d224183261b09ce206fd76c342b6": true}
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.notification (created_at, modified_at, id, name, url, authorization_key, authorization_header, authorization_type, max_retries, platform, notification_type, is_active, api_id, pipeline_id) FROM stdin;
\.


--
-- Data for Name: organization; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.organization (id, name, display_name, organization_id, modified_at, created_at, allowed_token_limit, created_by_id, modified_by_id) FROM stdin;
1	mock_org	mock_org	mock_org	2025-11-02 22:10:23.064792+00	2025-11-02 22:10:23.064798+00	-1	\N	\N
\.


--
-- Data for Name: organization_member; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.organization_member (member_id, role, is_login_onboarding_msg, is_prompt_studio_onboarding_msg, organization_id, user_id) FROM stdin;
1	admin	f	f	1	1
\.


--
-- Data for Name: page_usage; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.page_usage (id, organization_id, file_name, file_type, run_id, pages_processed, file_size, created_at) FROM stdin;
73f9111f-71ba-47bb-b90e-a7c844e0d2c9	mock_org	Diagnosis and Treatment (Referral from THSteps Checkup).pdf	application/pdf	07720348-3268-4f06-be4c-c46b43de45db	1	235733	2025-11-03 02:02:02.684017+00
4aaee9a7-146d-4c3c-b06a-baf1225f3115	mock_org	Diagnosis and Treatment (Referral from THSteps Checkup).pdf	application/pdf	c1c26356-948c-44f2-b097-3a05c4d9db56	1	235733	2025-11-03 07:28:34.532899+00
\.


--
-- Data for Name: pipeline; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.pipeline (created_at, modified_at, id, pipeline_name, app_id, active, scheduled, cron_string, pipeline_type, run_count, last_run_time, last_run_status, app_icon, app_url, access_control_bundle_id, created_by_id, modified_by_id, organization_id, workflow_id, shared_to_org) FROM stdin;
\.


--
-- Data for Name: pipeline_shared_users; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.pipeline_shared_users (id, pipeline_id, user_id) FROM stdin;
\.


--
-- Data for Name: platform_key; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.platform_key (id, key, key_name, is_active, created_by_id, modified_by_id, organization_id) FROM stdin;
a54f97be-88d0-4d61-a51f-70241b0fe494	f3184b9f-0a88-47a9-bc78-6e96aa32699a	Key #1	t	1	1	1
\.


--
-- Data for Name: profile_manager; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.profile_manager (created_at, modified_at, profile_id, profile_name, chunk_size, chunk_overlap, reindex, retrieval_strategy, similarity_top_k, section, is_default, is_summarize_llm, created_by_id, embedding_model_id, llm_id, modified_by_id, prompt_studio_tool_id, vector_store_id, x2text_id) FROM stdin;
2025-11-03 07:27:17.410811+00	2025-11-03 07:27:17.457866+00	36e887d3-66b6-4764-a293-a660afc1e36c	LLM-profile1	0	0	f	simple	3	Default	t	f	1	ead5cf5e-845c-4c93-b5e1-b2cffc0b6a1b	85c5aa71-ed97-4146-a83b-c2c13c200a38	1	bb63d19d-a7d4-40ee-acbf-0dc4f155adca	ae657576-a4ac-48d9-9df9-977f8c901eea	83ba2d43-797c-4cbc-95f2-4ceaa7f15482
\.


--
-- Data for Name: prompt_studio_output_manager; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.prompt_studio_output_manager (created_at, modified_at, prompt_output_id, output, context, challenge_data, eval_metrics, is_single_pass_extract, run_id, created_by_id, document_manager_id, modified_by_id, profile_manager_id, prompt_id_id, tool_id_id, highlight_data, confidence_data) FROM stdin;
2025-11-03 07:28:42.232903+00	2025-11-03 07:28:42.23307+00	dddd4936-1c6d-443e-a65d-260de4f8fddd	{\n  "patient_first_name": "John",\n  "patient_last_name": "Doe",\n  "date_of_birth": "04/09/1994",\n  "phone_number": "123-555-1234",\n  "address_line1": "2608 Best Street",\n  "city": "Dallas",\n  "state": "TX",\n  "zip_code": "75227"\n}	["\\n\\n    HEALTH INSURANCE CLAIM FORM \\n    APPROVED BY NATIONAL UNIFORM CLAIM COMMITTEE (NUCC) 02/12                                                                                                                            CARRIER \\n            PICA                                                                                                                                                            PICA \\n\\n     1. MEDICARE        MEDICAID         TRICARE             CHAMPVA         GROUP             FECA          OTHER 1a. INSURED'S I.D. NUMBER                  (For Program in Item 1) \\n                                                                             HEALTH PLAN       BLK LUNG \\n         (Medicare#)    (Medicaid#)     (ID#/DoD#)           (Member ID#)    (ID#)             (ID#)         (ID#)      123456789 \\n    [ ]             [X]             [ ]                 [ ]             [ ]                [ ]          [ ] \\n     2. PATIENT'S NAME (Last Name, First Name, Middle Initial)        3. PATIENT'S BIRTH DATE         SEX           4. INSURED'S NAME (Last Name, First Name, Middle Initial) \\n                                                                          MM     DD       \\u00ddY \\n        Doe, John                                                        04      09     1994 M [X]         F [ ] \\n     5. PATIENT'S ADDRESS (No., Street)                               6. PATIENT RELATIONSHIP TO INSURED            7. INSURED'S ADDRESS (No., Street) \\n        2608 Best Street                                                 Self     Spouse     Child      Other \\n                                                                             [ ]         [ ]     [ ]         [ ] \\n     CITY                                                     STATE 8. RESERVED FOR NUCC USE                        CITY                                                  STATE \\n         Dallas                                                  TX \\n\\n     ZIP CODE                      TELEPHONE (Include Area Code)                                                    ZIP CODE                      TELEPHONE (Include Area Code) \\n\\n         75227                      ( 123 ) 555-1234 \\n                                                                                                                                                     (        ) \\n     9. OTHER INSURED'S NAME (Last Name, First Name, Middle Initial) 10. IS PATIENT'S CONDITION RELATED TO:         11. INSURED'S POLICY GROUP OR FECA NUMBER                            INFORMATION \\n\\n     a. OTHER INSURED'S POLICY OR GROUP NUMBER                        a. EMPLOYMENT? (Current or Previous)          a. INSURED'S DATE OF BIRTH                      SEX \\n                                                                                                                            MM     DD       YY \\n                                                                                      YES           NO                                                    M                F \\n                                                                                 [ ]           [X]                                                           [ ]             [ ]         INSURED \\n     b. RESERVED FOR NUCC USE                                         b. AUTO ACCIDENT? \\n                                                                                                      PLACE (State) b. OTHER CLAIM ID (Designated by NUCC) \\n                                                                                      YES          NO                                                                                    AND \\n                                                                                  [ ]          [X]                                                                                       PATIENT \\n     c. RESERVED FOR NUCC USE                                         c. OTHER ACCIDENT?                            c. INSURANCE PLAN NAME OR PROGRAM NAME \\n                                                                                      YES           NO \\n                                                                                  [ ]          [X] \\n     d. INSURANCE PLAN NAME OR PROGRAM NAME                           10d. CLAIM CODES (Designated by NUCC)         d. IS THERE ANOTHER HEALTH BENEFIT PLAN? \\n\\n                                                                                                                        [ ] YES     [ ] NO      If yes, complete items 9, 9a, and 9d. \\n                           READ BACK OF FORM BEFORE COMPLETING & SIGNING THIS FORM.                                 13. INSURED'S OR AUTHORIZED PERSON'S SIGNATURE I authorize \\n     12. PATIENT'S OR AUTHORIZED PERSON'S SIGNATURE I authorize the release of any medical or other information necessary payment of medical benefits to the undersigned physician or supplier for \\n        to process this claim. I also request payment of government benefits either to myself or to the party who accepts assignment services described below. \\n        below. \\n\\n        SIGNED                                                                 DATE                                      SIGNED \\n     14. DATE OF CURRENT ILLNESS, INJURY, or PREGNANCY (LMP) 15. OTHER DATE                                         16. DATES PATIENT UNABLE TO WORK IN CURRENT OCCUPATION \\n        MM     DD       YY                                                             MM      DD      YY                     MM      DD       YY             MM      DD       YY \\n                               QUAL                               QUAL.                                                FROM                               TO \\n     17. NAME OF REFERRING PROVIDER OR OTHER SOURCE               17a.                                              18. HOSPITALIZATION DATES RELATED TO CURRENT SERVICES \\n                                                                                                                              MM     DD        YY             MM      DD       YY \\n              John J Smith MD                                     17b. NPI      1234567089                             FROM                               TO \\n     19. ADDITIONAL CLAIM INFORMATION (Designated by NUCC)                                                          20. OUTSIDE LAB?                     $ CHARGES \\n\\n                                                                                                                        [ ] YES     [ ] NO \\n     21. DIAGNOSIS OR NATURE OF ILLNESS OR INJURY Relate A-L to service line below (24E)                            22. RESUBMISSION \\n                                                                                          ICD Ind. 0                   CODE                      ORIGINAL REF. NO. \\n      A. J45909                    B.                            C.                            D. \\n                                                                                                                    23. PRIOR AUTHORIZATION NUMBER \\n      E.                           F.                            G.                            H. \\n      I.                           J.                            K.                           L. \\n     24. A.    DATE(S) OF SERVICE              B.     C.    D. PROCEDURES, SERVICES, OR SUPPLIES             E.              F.            G.     H.     1.               J. \\n            From                 To          PLACE OF           (Explain Unusual Circumstances)         DIAGNOSIS                         DAYS OR EPSDT \\n                                                                                                                                                 Family ID.          RENDERING \\n     MM     DD     YY     MM    DD     YY    SERVICE EMG     CPT/HCPCS               MODIFIER            POINTER        $ CHARGES         UNITS   Plan QUAL.        PROVIDER ID. # \\n\\n  1 \\n      01    01 2016 01           01 2016       1               99213           1                             A                40.00         1          NPI \\n\\n                                                                                                                                                                                         INFORMATION \\n2 \\n      01    01   2016 01         01 2016       1               71010           1                             A                45.00         1          NPI \\n\\n3 \\n      01    01 2016 01           01 2016       1               J0170           1                             A                18.00         1          NPI \\n                                                                                                                                                                                         SUPPLIER \\n  4 \\n                                                                                                                                                       NPI                               OR PHYSICIAN \\n\\n5 \\n                                                                                                                                                       NPI \\n\\n6 \\n                                                                                                                                                       NPI \\n     25. FEDERAL TAX I.D. NUMBER         SSN EIN       26. PATIENT'S ACCOUNT NO.        27. ACCEPT ASSIGNMENT?      28. TOTAL CHARGE          29. AMOUNT PAID      30. Rsvd for NUCC Use \\n                                                                                           (For govt. claims, see back) \\n                                                                                                                     $            103.00       $ \\n                                         [ ] [ ]          1234567890                    [X] YES     [ ] NO \\n     31. SIGNATURE OF PHYSICIAN OR SUPPLIER            32. SERVICE FACILITY LOCATION INFORMATION                    33. BILLING PROVIDER INFO & PH # \\n                                                                                                                                                        (      ) \\n        INCLUDING DEGREES OR CREDENTIALS \\n        (I certify that the statements on the reverse                                                                  Norman Joseph, M.D. \\n        apply to this bill and are made a part thereof.)                                                               105 Medical Parkway \\n                                                                                                                       Anytown, TX 77711 \\n      Signature on File            01 09 2016 \\n                                                       a.                       b.                                  a. 9876543021             b. 1234567-01                              Y \\n     SIGNED                            DATE                      NPI \\n    NUCC Instruction Manual available at: www.nucc.org                       PLEASE PRINT OR TYPE                              APPROVED OMB-0938-1197 FORM 1500 (02-12) \\n<<<\\f"]	\N	[]	f	ab8d3845-a83e-4949-8559-2661ed7a908b	\N	b4d87a97-3373-4160-8237-4a62905dab5b	\N	36e887d3-66b6-4764-a293-a660afc1e36c	7c9b44ba-97f7-4813-b753-7366fb929f8e	bb63d19d-a7d4-40ee-acbf-0dc4f155adca	[]	{"factors": ["completeness: 1.0", "format_validity: 0.7", "consistency: 0.73", "token_efficiency: 0.5"], "metrics": {"consistency": {"score": 0.727, "weight": 0.25}, "completeness": {"score": 1.0, "weight": 0.3}, "format_validity": {"score": 0.7, "weight": 0.25}, "token_efficiency": {"score": 0.5, "weight": 0.2}}, "overall_confidence": 0.757}
\.


--
-- Data for Name: prompt_studio_registry; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.prompt_studio_registry (created_at, modified_at, prompt_registry_id, name, description, tool_property, tool_spec, tool_metadata, icon, url, shared_to_org, created_by_id, custom_tool_id, modified_by_id, organization_id) FROM stdin;
\.


--
-- Data for Name: prompt_studio_registry_shared_users; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.prompt_studio_registry_shared_users (id, promptstudioregistry_id, user_id) FROM stdin;
\.


--
-- Data for Name: social_auth_association; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.social_auth_association (id, server_url, handle, secret, issued, lifetime, assoc_type) FROM stdin;
\.


--
-- Data for Name: social_auth_code; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.social_auth_code (id, email, code, verified, "timestamp") FROM stdin;
\.


--
-- Data for Name: social_auth_nonce; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.social_auth_nonce (id, server_url, "timestamp", salt) FROM stdin;
\.


--
-- Data for Name: social_auth_partial; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.social_auth_partial (id, token, next_step, backend, "timestamp", data) FROM stdin;
\.


--
-- Data for Name: social_auth_usersocialauth; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.social_auth_usersocialauth (id, provider, uid, user_id, created, modified, extra_data) FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.tag (created_at, modified_at, id, name, description, organization_id) FROM stdin;
\.


--
-- Data for Name: tool_instance; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.tool_instance (created_at, modified_at, id, tool_id, input, output, version, metadata, step, status, created_by_id, modified_by_id, workflow_id) FROM stdin;
\.


--
-- Data for Name: tool_studio_prompt; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.tool_studio_prompt (created_at, modified_at, prompt_id, prompt_key, enforce_type, prompt, sequence_number, prompt_type, output, assert_prompt, assertion_failure_prompt, is_assert, active, output_metadata, evaluate, eval_quality_faithfulness, eval_quality_correctness, eval_quality_relevance, eval_security_pii, eval_guidance_toxicity, eval_guidance_completeness, created_by_id, modified_by_id, profile_manager_id, tool_id_id, required, has_line_item_history, enable_postprocessing_webhook, postprocessing_webhook_url) FROM stdin;
2025-11-03 02:01:02.350107+00	2025-11-03 02:01:05.379088+00	12b65805-cbd6-45df-88ab-c32410897eca	Medical claims_1	text	You are an intelligent document extractor.\nFrom the provided "Diagnosis and Treatment (Referral from THSteps Checkup)" form, extract all patient details and output only valid JSON.\nReturn JSON fields:\npatient_first_name\npatient_last_name\ndate_of_birth\nphone_number\naddress_line1\ncity\nstate\nzip_code	1	PROMPT		\N	\N	f	t	{}	t	t	t	t	t	t	t	1	1	\N	\N	\N	f	f	\N
2025-11-03 03:19:08.205376+00	2025-11-03 03:19:13.886142+00	d19cde9c-9783-4775-80a3-5ee1022ac6e3	Medical claims_2	text	You are an intelligent document extractor.\nFrom the same document, extract the rendering or billing provider details and output valid JSON.\nReturn JSON fields:\nprovider_name\nprovider_npi\nprovider_address_line1\nprovider_city\nprovider_state\nprovider_zip_code	2	PROMPT		\N	\N	f	t	{}	t	t	t	t	t	t	t	1	1	\N	\N	\N	f	f	\N
2025-11-03 07:27:45.616814+00	2025-11-03 07:27:48.928513+00	7c9b44ba-97f7-4813-b753-7366fb929f8e	Medical claims_1	text	You are an intelligent document extractor.\nFrom the provided "Diagnosis and Treatment (Referral from THSteps Checkup)" form, extract all patient details and output only valid JSON.\nReturn JSON fields:\npatient_first_name\npatient_last_name\ndate_of_birth\nphone_number\naddress_line1\ncity\nstate\nzip_code	1	PROMPT		\N	\N	f	t	{}	t	t	t	t	t	t	t	1	1	36e887d3-66b6-4764-a293-a660afc1e36c	bb63d19d-a7d4-40ee-acbf-0dc4f155adca	\N	f	f	\N
\.


--
-- Data for Name: usage; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.usage (created_at, modified_at, id, workflow_id, execution_id, adapter_instance_id, run_id, usage_type, llm_usage_reason, model_name, embedding_tokens, prompt_tokens, completion_tokens, total_tokens, cost_in_dollars, organization_id) FROM stdin;
2025-11-03 02:02:08.347846+00	2025-11-03 02:02:08.347846+00	a7474fe1-c1b1-4bf9-88db-e6be2b14eaec			85c5aa71-ed97-4146-a83b-c2c13c200a38	07720348-3268-4f06-be4c-c46b43de45db	llm	extraction	anthropic.claude-3-5-sonnet-20240620-v1:0	0	2283	105	2388	0.008424	1
2025-11-03 03:16:23.632489+00	2025-11-03 03:16:23.632489+00	8a3dc1e0-a0b9-4d14-8adf-8910f783f55f			85c5aa71-ed97-4146-a83b-c2c13c200a38	d3307fa2-82b1-4b4c-b7c9-da257168d949	llm	extraction	anthropic.claude-3-5-sonnet-20240620-v1:0	0	2283	105	2388	0.008424	1
2025-11-03 03:19:19.509732+00	2025-11-03 03:19:19.509732+00	93b01972-8cd7-4aa7-90d3-fb4dcf789a9a			85c5aa71-ed97-4146-a83b-c2c13c200a38	b0b6c87f-d9ed-4fa3-a0c4-0f5e5d22693c	llm	extraction	anthropic.claude-3-5-sonnet-20240620-v1:0	0	2263	88	2351	0.008109	1
2025-11-03 03:19:20.958749+00	2025-11-03 03:19:20.958749+00	44a20864-5a18-4486-8560-c437643bed0b			85c5aa71-ed97-4146-a83b-c2c13c200a38	b0150e02-b6de-4231-af23-c90372f38017	llm	extraction	anthropic.claude-3-5-sonnet-20240620-v1:0	0	2283	105	2388	0.008424	1
2025-11-03 06:17:25.496762+00	2025-11-03 06:17:25.496762+00	32bd2dc5-98cd-4a93-ab77-f50f93079d9f			85c5aa71-ed97-4146-a83b-c2c13c200a38	ff0be457-03e0-48db-9292-201d891fac79	llm	extraction	anthropic.claude-3-5-sonnet-20240620-v1:0	0	2263	88	2351	0.008109	1
2025-11-03 06:17:28.023239+00	2025-11-03 06:17:28.023239+00	0afbe809-e8fb-4213-aef9-b99e7a9a27e5			85c5aa71-ed97-4146-a83b-c2c13c200a38	62d55948-fb97-44c2-a9a5-8007a8f6d210	llm	extraction	anthropic.claude-3-5-sonnet-20240620-v1:0	0	2283	105	2388	0.008424	1
2025-11-03 07:28:41.745054+00	2025-11-03 07:28:41.745054+00	c4b6dde2-9f3f-4e1b-a660-a13446fd48cc			85c5aa71-ed97-4146-a83b-c2c13c200a38	c1c26356-948c-44f2-b097-3a05c4d9db56	llm	extraction	anthropic.claude-3-5-sonnet-20240620-v1:0	0	2283	105	2388	0.008424	1
2025-11-03 07:32:47.301438+00	2025-11-03 07:32:47.301438+00	ae4b8a69-4527-47c9-b0a0-f6721a41d1ff			85c5aa71-ed97-4146-a83b-c2c13c200a38	e364f4f3-b037-40c1-937b-28da7620cd3d	llm	extraction	anthropic.claude-3-5-sonnet-20240620-v1:0	0	2283	105	2388	0.008424	1
2025-11-03 08:23:34.943894+00	2025-11-03 08:23:34.943894+00	07f2a56c-600e-49da-a337-6ecf4fcf10d3			85c5aa71-ed97-4146-a83b-c2c13c200a38	0028b0cb-0300-429b-a822-7a9e2b5d2da5	llm	extraction	anthropic.claude-3-5-sonnet-20240620-v1:0	0	2283	105	2388	0.008424	1
2025-11-03 15:56:32.634647+00	2025-11-03 15:56:32.634647+00	905742ba-0314-44a4-8b0e-acc4aa1b0db6			85c5aa71-ed97-4146-a83b-c2c13c200a38	2b9bccde-b657-4df8-8851-e1774d4afa85	llm	extraction	anthropic.claude-3-5-sonnet-20240620-v1:0	0	2283	105	2388	0.008424	1
2025-11-03 17:28:42.708894+00	2025-11-03 17:28:42.708894+00	feb6c34a-e9b4-4076-9904-30dc41ee484e			85c5aa71-ed97-4146-a83b-c2c13c200a38	ab8d3845-a83e-4949-8559-2661ed7a908b	llm	extraction	anthropic.claude-3-5-sonnet-20240620-v1:0	0	2283	105	2388	0.008424	1
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract."user" (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, user_id, project_storage_created, modified_at, created_at, created_by_id, modified_by_id, auth_provider) FROM stdin;
1	pbkdf2_sha256$600000$YyqUjO0znY6iaGVErOWPVZ$5VKs98ikkt7ifGC5hVIA5xY9S4scibd0qkPQhcSstbg=	2025-11-03 01:29:08.112491+00	f	unstract			email@mock.com	f	t	2025-11-02 22:10:22.645069+00	mock_user_id	f	2025-11-02 22:10:22.817726+00	2025-11-02 22:10:22.645921+00	\N	\N	
\.


--
-- Data for Name: user_groups; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: user_user_permissions; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: workflow; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.workflow (created_at, modified_at, id, description, workflow_name, is_active, status, deployment_type, source_settings, destination_settings, created_by_id, modified_by_id, organization_id, workflow_owner_id, shared_to_org) FROM stdin;
\.


--
-- Data for Name: workflow_endpoints; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.workflow_endpoints (created_at, modified_at, id, endpoint_type, connection_type, configuration, connector_instance_id, workflow_id) FROM stdin;
\.


--
-- Data for Name: workflow_execution; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.workflow_execution (created_at, modified_at, id, pipeline_id, task_id, workflow_id, execution_mode, execution_method, execution_type, execution_log_id, status, error_message, attempts, execution_time, result_acknowledged, total_files) FROM stdin;
\.


--
-- Data for Name: workflow_execution_tags; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.workflow_execution_tags (id, workflowexecution_id, tag_id) FROM stdin;
\.


--
-- Data for Name: workflow_file_execution; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.workflow_file_execution (created_at, modified_at, id, file_name, file_path, file_size, file_hash, mime_type, status, execution_time, execution_error, workflow_execution_id, fs_metadata, provider_file_uuid) FROM stdin;
\.


--
-- Data for Name: workflow_shared_users; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.workflow_shared_users (id, workflow_id, user_id) FROM stdin;
\.


--
-- Data for Name: x2text_audit; Type: TABLE DATA; Schema: unstract; Owner: unstract_dev
--

COPY unstract.x2text_audit (id, created_at, org_id, file_name, file_type, file_size_in_kb, status) FROM stdin;
\.


--
-- Name: task_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: unstract_dev
--

SELECT pg_catalog.setval('public.task_id_sequence', 1250, true);


--
-- Name: taskset_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: unstract_dev
--

SELECT pg_catalog.setval('public.taskset_id_sequence', 1, false);


--
-- Name: adapter_instance_shared_users_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.adapter_instance_shared_users_id_seq', 1, false);


--
-- Name: api_deployment_shared_users_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.api_deployment_shared_users_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.auth_permission_id_seq', 184, true);


--
-- Name: connector_instance_shared_users_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.connector_instance_shared_users_id_seq', 1, false);


--
-- Name: custom_tool_shared_users_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.custom_tool_shared_users_id_seq', 1, false);


--
-- Name: default_organization_user_adapter_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.default_organization_user_adapter_id_seq', 1, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.django_admin_log_id_seq', 1, false);


--
-- Name: django_celery_beat_clockedschedule_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.django_celery_beat_clockedschedule_id_seq', 1, false);


--
-- Name: django_celery_beat_crontabschedule_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.django_celery_beat_crontabschedule_id_seq', 1, true);


--
-- Name: django_celery_beat_intervalschedule_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.django_celery_beat_intervalschedule_id_seq', 1, true);


--
-- Name: django_celery_beat_periodictask_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.django_celery_beat_periodictask_id_seq', 4, true);


--
-- Name: django_celery_beat_solarschedule_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.django_celery_beat_solarschedule_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.django_content_type_id_seq', 46, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.django_migrations_id_seq', 141, true);


--
-- Name: organization_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.organization_id_seq', 1, true);


--
-- Name: organization_member_member_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.organization_member_member_id_seq', 1, true);


--
-- Name: pipeline_shared_users_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.pipeline_shared_users_id_seq', 1, false);


--
-- Name: prompt_studio_registry_shared_users_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.prompt_studio_registry_shared_users_id_seq', 1, false);


--
-- Name: social_auth_association_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.social_auth_association_id_seq', 1, false);


--
-- Name: social_auth_code_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.social_auth_code_id_seq', 1, false);


--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.social_auth_nonce_id_seq', 1, false);


--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.social_auth_partial_id_seq', 1, false);


--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.social_auth_usersocialauth_id_seq', 1, false);


--
-- Name: user_groups_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.user_groups_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.user_id_seq', 1, true);


--
-- Name: user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.user_user_permissions_id_seq', 1, false);


--
-- Name: workflow_execution_tags_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.workflow_execution_tags_id_seq', 1, false);


--
-- Name: workflow_shared_users_id_seq; Type: SEQUENCE SET; Schema: unstract; Owner: unstract_dev
--

SELECT pg_catalog.setval('unstract.workflow_shared_users_id_seq', 1, false);


--
-- Name: authentications authentications_hashed_client_token_key; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.authentications
    ADD CONSTRAINT authentications_hashed_client_token_key UNIQUE (hashed_client_token);


--
-- Name: authentications authentications_pkey; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.authentications
    ADD CONSTRAINT authentications_pkey PRIMARY KEY (id);


--
-- Name: celery_taskmeta celery_taskmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.celery_taskmeta
    ADD CONSTRAINT celery_taskmeta_pkey PRIMARY KEY (id);


--
-- Name: celery_taskmeta celery_taskmeta_task_id_key; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.celery_taskmeta
    ADD CONSTRAINT celery_taskmeta_task_id_key UNIQUE (task_id);


--
-- Name: celery_tasksetmeta celery_tasksetmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.celery_tasksetmeta
    ADD CONSTRAINT celery_tasksetmeta_pkey PRIMARY KEY (id);


--
-- Name: celery_tasksetmeta celery_tasksetmeta_taskset_id_key; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.celery_tasksetmeta
    ADD CONSTRAINT celery_tasksetmeta_taskset_id_key UNIQUE (taskset_id);


--
-- Name: constraints constraints_pkey; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.constraints
    ADD CONSTRAINT constraints_pkey PRIMARY KEY (id);


--
-- Name: distributions distributions_pkey; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.distributions
    ADD CONSTRAINT distributions_pkey PRIMARY KEY (id);


--
-- Name: flags flags_pkey; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.flags
    ADD CONSTRAINT flags_pkey PRIMARY KEY (namespace_key, key);


--
-- Name: namespaces namespaces_pkey; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.namespaces
    ADD CONSTRAINT namespaces_pkey PRIMARY KEY (key);


--
-- Name: operation_lock operation_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.operation_lock
    ADD CONSTRAINT operation_lock_pkey PRIMARY KEY (operation);


--
-- Name: rollout_segment_references rollout_segment_references_rollout_segment_id_namespace_key_key; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rollout_segment_references
    ADD CONSTRAINT rollout_segment_references_rollout_segment_id_namespace_key_key UNIQUE (rollout_segment_id, namespace_key, segment_key);


--
-- Name: rollout_segments rollout_segments_pkey; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rollout_segments
    ADD CONSTRAINT rollout_segments_pkey PRIMARY KEY (id);


--
-- Name: rollout_thresholds rollout_thresholds_pkey; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rollout_thresholds
    ADD CONSTRAINT rollout_thresholds_pkey PRIMARY KEY (id);


--
-- Name: rollout_thresholds rollout_thresholds_rollout_id_key; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rollout_thresholds
    ADD CONSTRAINT rollout_thresholds_rollout_id_key UNIQUE (rollout_id);


--
-- Name: rollouts rollouts_pkey; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rollouts
    ADD CONSTRAINT rollouts_pkey PRIMARY KEY (id);


--
-- Name: rule_segments rule_segments_rule_id_namespace_key_segment_key_key; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rule_segments
    ADD CONSTRAINT rule_segments_rule_id_namespace_key_segment_key_key UNIQUE (rule_id, namespace_key, segment_key);


--
-- Name: rules rules_pkey; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rules
    ADD CONSTRAINT rules_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: segments segments_pkey; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.segments
    ADD CONSTRAINT segments_pkey PRIMARY KEY (namespace_key, key);


--
-- Name: variants variants_namespace_flag_key; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_namespace_flag_key UNIQUE (namespace_key, flag_key, key);


--
-- Name: variants variants_pkey; Type: CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_pkey PRIMARY KEY (id);


--
-- Name: adapter_instance adapter_instance_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.adapter_instance
    ADD CONSTRAINT adapter_instance_pkey PRIMARY KEY (id);


--
-- Name: adapter_instance_shared_users adapter_instance_shared__adapterinstance_id_user__92da058c_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.adapter_instance_shared_users
    ADD CONSTRAINT adapter_instance_shared__adapterinstance_id_user__92da058c_uniq UNIQUE (adapterinstance_id, user_id);


--
-- Name: adapter_instance_shared_users adapter_instance_shared_users_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.adapter_instance_shared_users
    ADD CONSTRAINT adapter_instance_shared_users_pkey PRIMARY KEY (id);


--
-- Name: api_deployment api_deployment_api_endpoint_key; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment
    ADD CONSTRAINT api_deployment_api_endpoint_key UNIQUE (api_endpoint);


--
-- Name: api_deployment_key api_deployment_key_api_key_key; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment_key
    ADD CONSTRAINT api_deployment_key_api_key_key UNIQUE (api_key);


--
-- Name: api_deployment_key api_deployment_key_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment_key
    ADD CONSTRAINT api_deployment_key_pkey PRIMARY KEY (id);


--
-- Name: api_deployment api_deployment_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment
    ADD CONSTRAINT api_deployment_pkey PRIMARY KEY (id);


--
-- Name: api_deployment_shared_users api_deployment_shared_us_apideployment_id_user_id_0be483de_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment_shared_users
    ADD CONSTRAINT api_deployment_shared_us_apideployment_id_user_id_0be483de_uniq UNIQUE (apideployment_id, user_id);


--
-- Name: api_deployment_shared_users api_deployment_shared_users_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment_shared_users
    ADD CONSTRAINT api_deployment_shared_users_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: configuration configuration_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.configuration
    ADD CONSTRAINT configuration_pkey PRIMARY KEY (id);


--
-- Name: connector_auth connector_auth_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.connector_auth
    ADD CONSTRAINT connector_auth_pkey PRIMARY KEY (id);


--
-- Name: connector_instance connector_instance_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.connector_instance
    ADD CONSTRAINT connector_instance_pkey PRIMARY KEY (id);


--
-- Name: connector_instance_shared_users connector_instance_share_connectorinstance_id_use_cdab3cac_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.connector_instance_shared_users
    ADD CONSTRAINT connector_instance_share_connectorinstance_id_use_cdab3cac_uniq UNIQUE (connectorinstance_id, user_id);


--
-- Name: connector_instance_shared_users connector_instance_shared_users_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.connector_instance_shared_users
    ADD CONSTRAINT connector_instance_shared_users_pkey PRIMARY KEY (id);


--
-- Name: custom_tool custom_tool_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.custom_tool
    ADD CONSTRAINT custom_tool_pkey PRIMARY KEY (tool_id);


--
-- Name: custom_tool_shared_users custom_tool_shared_users_customtool_id_user_id_62265a45_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.custom_tool_shared_users
    ADD CONSTRAINT custom_tool_shared_users_customtool_id_user_id_62265a45_uniq UNIQUE (customtool_id, user_id);


--
-- Name: custom_tool_shared_users custom_tool_shared_users_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.custom_tool_shared_users
    ADD CONSTRAINT custom_tool_shared_users_pkey PRIMARY KEY (id);


--
-- Name: default_organization_user_adapter default_organization_user_adapter_organization_member_id_key; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.default_organization_user_adapter
    ADD CONSTRAINT default_organization_user_adapter_organization_member_id_key UNIQUE (organization_member_id);


--
-- Name: default_organization_user_adapter default_organization_user_adapter_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.default_organization_user_adapter
    ADD CONSTRAINT default_organization_user_adapter_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_clockedschedule django_celery_beat_clockedschedule_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_celery_beat_clockedschedule
    ADD CONSTRAINT django_celery_beat_clockedschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_crontabschedule django_celery_beat_crontabschedule_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_celery_beat_crontabschedule
    ADD CONSTRAINT django_celery_beat_crontabschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_intervalschedule django_celery_beat_intervalschedule_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_celery_beat_intervalschedule
    ADD CONSTRAINT django_celery_beat_intervalschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_periodictask django_celery_beat_periodictask_name_key; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_periodictask_name_key UNIQUE (name);


--
-- Name: django_celery_beat_periodictask django_celery_beat_periodictask_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_periodictask_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_periodictasks django_celery_beat_periodictasks_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_celery_beat_periodictasks
    ADD CONSTRAINT django_celery_beat_periodictasks_pkey PRIMARY KEY (ident);


--
-- Name: django_celery_beat_solarschedule django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_celery_beat_solarschedule
    ADD CONSTRAINT django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq UNIQUE (event, latitude, longitude);


--
-- Name: django_celery_beat_solarschedule django_celery_beat_solarschedule_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_celery_beat_solarschedule
    ADD CONSTRAINT django_celery_beat_solarschedule_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: document_manager document_manager_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.document_manager
    ADD CONSTRAINT document_manager_pkey PRIMARY KEY (document_id);


--
-- Name: execution_log execution_log_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.execution_log
    ADD CONSTRAINT execution_log_pkey PRIMARY KEY (id);


--
-- Name: file_history file_history_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.file_history
    ADD CONSTRAINT file_history_pkey PRIMARY KEY (id);


--
-- Name: index_manager index_manager_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.index_manager
    ADD CONSTRAINT index_manager_pkey PRIMARY KEY (index_manager_id);


--
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: organization_member organization_member_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.organization_member
    ADD CONSTRAINT organization_member_pkey PRIMARY KEY (member_id);


--
-- Name: organization organization_organization_id_key; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.organization
    ADD CONSTRAINT organization_organization_id_key UNIQUE (organization_id);


--
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);


--
-- Name: page_usage page_usage_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.page_usage
    ADD CONSTRAINT page_usage_pkey PRIMARY KEY (id);


--
-- Name: pipeline pipeline_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.pipeline
    ADD CONSTRAINT pipeline_pkey PRIMARY KEY (id);


--
-- Name: pipeline_shared_users pipeline_shared_users_pipeline_id_user_id_80ad906b_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.pipeline_shared_users
    ADD CONSTRAINT pipeline_shared_users_pipeline_id_user_id_80ad906b_uniq UNIQUE (pipeline_id, user_id);


--
-- Name: pipeline_shared_users pipeline_shared_users_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.pipeline_shared_users
    ADD CONSTRAINT pipeline_shared_users_pkey PRIMARY KEY (id);


--
-- Name: platform_key platform_key_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.platform_key
    ADD CONSTRAINT platform_key_pkey PRIMARY KEY (id);


--
-- Name: profile_manager profile_manager_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.profile_manager
    ADD CONSTRAINT profile_manager_pkey PRIMARY KEY (profile_id);


--
-- Name: prompt_studio_output_manager prompt_studio_output_manager_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_output_manager
    ADD CONSTRAINT prompt_studio_output_manager_pkey PRIMARY KEY (prompt_output_id);


--
-- Name: prompt_studio_registry prompt_studio_registry_custom_tool_id_key; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_registry
    ADD CONSTRAINT prompt_studio_registry_custom_tool_id_key UNIQUE (custom_tool_id);


--
-- Name: prompt_studio_registry prompt_studio_registry_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_registry
    ADD CONSTRAINT prompt_studio_registry_pkey PRIMARY KEY (prompt_registry_id);


--
-- Name: prompt_studio_registry_shared_users prompt_studio_registry_s_promptstudioregistry_id__bdf116f2_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_registry_shared_users
    ADD CONSTRAINT prompt_studio_registry_s_promptstudioregistry_id__bdf116f2_uniq UNIQUE (promptstudioregistry_id, user_id);


--
-- Name: prompt_studio_registry_shared_users prompt_studio_registry_shared_users_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_registry_shared_users
    ADD CONSTRAINT prompt_studio_registry_shared_users_pkey PRIMARY KEY (id);


--
-- Name: social_auth_association social_auth_association_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.social_auth_association
    ADD CONSTRAINT social_auth_association_pkey PRIMARY KEY (id);


--
-- Name: social_auth_association social_auth_association_server_url_handle_078befa2_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.social_auth_association
    ADD CONSTRAINT social_auth_association_server_url_handle_078befa2_uniq UNIQUE (server_url, handle);


--
-- Name: social_auth_code social_auth_code_email_code_801b2d02_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.social_auth_code
    ADD CONSTRAINT social_auth_code_email_code_801b2d02_uniq UNIQUE (email, code);


--
-- Name: social_auth_code social_auth_code_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.social_auth_code
    ADD CONSTRAINT social_auth_code_pkey PRIMARY KEY (id);


--
-- Name: social_auth_nonce social_auth_nonce_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.social_auth_nonce
    ADD CONSTRAINT social_auth_nonce_pkey PRIMARY KEY (id);


--
-- Name: social_auth_nonce social_auth_nonce_server_url_timestamp_salt_f6284463_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.social_auth_nonce
    ADD CONSTRAINT social_auth_nonce_server_url_timestamp_salt_f6284463_uniq UNIQUE (server_url, "timestamp", salt);


--
-- Name: social_auth_partial social_auth_partial_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.social_auth_partial
    ADD CONSTRAINT social_auth_partial_pkey PRIMARY KEY (id);


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_pkey PRIMARY KEY (id);


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_provider_uid_e6b5e668_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_provider_uid_e6b5e668_uniq UNIQUE (provider, uid);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: tool_instance tool_instance_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.tool_instance
    ADD CONSTRAINT tool_instance_pkey PRIMARY KEY (id);


--
-- Name: tool_studio_prompt tool_studio_prompt_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.tool_studio_prompt
    ADD CONSTRAINT tool_studio_prompt_pkey PRIMARY KEY (prompt_id);


--
-- Name: api_deployment unique_api_name; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment
    ADD CONSTRAINT unique_api_name UNIQUE (api_name, organization_id);


--
-- Name: index_manager unique_document_manager_profile_manager_index; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.index_manager
    ADD CONSTRAINT unique_document_manager_profile_manager_index UNIQUE (document_manager_id, profile_manager_id);


--
-- Name: document_manager unique_document_name_tool_index; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.document_manager
    ADD CONSTRAINT unique_document_name_tool_index UNIQUE (document_name, tool_id);


--
-- Name: platform_key unique_key_name_organization; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.platform_key
    ADD CONSTRAINT unique_key_name_organization UNIQUE (key_name, organization_id);


--
-- Name: notification unique_name_api; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.notification
    ADD CONSTRAINT unique_name_api UNIQUE (name, api_id);


--
-- Name: notification unique_name_pipeline; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.notification
    ADD CONSTRAINT unique_name_pipeline UNIQUE (name, pipeline_id);


--
-- Name: adapter_instance unique_organization_adapter; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.adapter_instance
    ADD CONSTRAINT unique_organization_adapter UNIQUE (adapter_name, adapter_type, organization_id);


--
-- Name: connector_instance unique_organization_connector; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.connector_instance
    ADD CONSTRAINT unique_organization_connector UNIQUE (connector_name, organization_id);


--
-- Name: configuration unique_organization_key; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.configuration
    ADD CONSTRAINT unique_organization_key UNIQUE (organization_id, key);


--
-- Name: organization_member unique_organization_member; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.organization_member
    ADD CONSTRAINT unique_organization_member UNIQUE (organization_id, user_id);


--
-- Name: pipeline unique_pipeline_entity; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.pipeline
    ADD CONSTRAINT unique_pipeline_entity UNIQUE (id, pipeline_type);


--
-- Name: pipeline unique_pipeline_name; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.pipeline
    ADD CONSTRAINT unique_pipeline_name UNIQUE (pipeline_name, organization_id);


--
-- Name: tool_studio_prompt unique_prompt_key_tool_id_index; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.tool_studio_prompt
    ADD CONSTRAINT unique_prompt_key_tool_id_index UNIQUE (prompt_key, tool_id_id);


--
-- Name: prompt_studio_output_manager unique_prompt_output_index; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_output_manager
    ADD CONSTRAINT unique_prompt_output_index UNIQUE (prompt_id_id, document_manager_id, profile_manager_id, tool_id_id, is_single_pass_extract);


--
-- Name: profile_manager unique_prompt_studio_tool_profile_name_index; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.profile_manager
    ADD CONSTRAINT unique_prompt_studio_tool_profile_name_index UNIQUE (prompt_studio_tool_id, profile_name);


--
-- Name: connector_auth unique_provider_uid_index; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.connector_auth
    ADD CONSTRAINT unique_provider_uid_index UNIQUE (provider, uid);


--
-- Name: tag unique_tag_name_organization; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.tag
    ADD CONSTRAINT unique_tag_name_organization UNIQUE (name, organization_id);


--
-- Name: custom_tool unique_tool_name; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.custom_tool
    ADD CONSTRAINT unique_tool_name UNIQUE (tool_name, organization_id);


--
-- Name: workflow_file_execution unique_workflow_file_hash_path; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_file_execution
    ADD CONSTRAINT unique_workflow_file_hash_path UNIQUE (workflow_execution_id, file_hash, file_path);


--
-- Name: workflow unique_workflow_name; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow
    ADD CONSTRAINT unique_workflow_name UNIQUE (workflow_name, organization_id);


--
-- Name: workflow_file_execution unique_workflow_provider_uuid_path; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_file_execution
    ADD CONSTRAINT unique_workflow_provider_uuid_path UNIQUE (workflow_execution_id, provider_file_uuid, file_path);


--
-- Name: usage usage_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.usage
    ADD CONSTRAINT usage_pkey PRIMARY KEY (id);


--
-- Name: user_groups user_groups_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.user_groups
    ADD CONSTRAINT user_groups_pkey PRIMARY KEY (id);


--
-- Name: user_groups user_groups_user_id_group_id_40beef00_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.user_groups
    ADD CONSTRAINT user_groups_user_id_group_id_40beef00_uniq UNIQUE (user_id, group_id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_user_permissions user_user_permissions_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.user_user_permissions
    ADD CONSTRAINT user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: user_user_permissions user_user_permissions_user_id_permission_id_7dc6e2e0_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.user_user_permissions
    ADD CONSTRAINT user_user_permissions_user_id_permission_id_7dc6e2e0_uniq UNIQUE (user_id, permission_id);


--
-- Name: user user_username_key; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: workflow_endpoints workflow_endpoints_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_endpoints
    ADD CONSTRAINT workflow_endpoints_pkey PRIMARY KEY (id);


--
-- Name: workflow_execution workflow_execution_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_execution
    ADD CONSTRAINT workflow_execution_pkey PRIMARY KEY (id);


--
-- Name: workflow_execution_tags workflow_execution_tags_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_execution_tags
    ADD CONSTRAINT workflow_execution_tags_pkey PRIMARY KEY (id);


--
-- Name: workflow_execution_tags workflow_execution_tags_workflowexecution_id_tag_e1578c22_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_execution_tags
    ADD CONSTRAINT workflow_execution_tags_workflowexecution_id_tag_e1578c22_uniq UNIQUE (workflowexecution_id, tag_id);


--
-- Name: workflow_file_execution workflow_file_execution_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_file_execution
    ADD CONSTRAINT workflow_file_execution_pkey PRIMARY KEY (id);


--
-- Name: workflow workflow_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow
    ADD CONSTRAINT workflow_pkey PRIMARY KEY (id);


--
-- Name: workflow_shared_users workflow_shared_users_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_shared_users
    ADD CONSTRAINT workflow_shared_users_pkey PRIMARY KEY (id);


--
-- Name: workflow_shared_users workflow_shared_users_workflow_id_user_id_08c04c8f_uniq; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_shared_users
    ADD CONSTRAINT workflow_shared_users_workflow_id_user_id_08c04c8f_uniq UNIQUE (workflow_id, user_id);


--
-- Name: x2text_audit x2text_audit_pkey; Type: CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.x2text_audit
    ADD CONSTRAINT x2text_audit_pkey PRIMARY KEY (id);


--
-- Name: hashed_client_token_authentications_index; Type: INDEX; Schema: public; Owner: unstract_dev
--

CREATE UNIQUE INDEX hashed_client_token_authentications_index ON public.authentications USING btree (hashed_client_token);


--
-- Name: adapter_instance_created_by_id_2c3c57b2; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX adapter_instance_created_by_id_2c3c57b2 ON unstract.adapter_instance USING btree (created_by_id);


--
-- Name: adapter_instance_modified_by_id_a2461822; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX adapter_instance_modified_by_id_a2461822 ON unstract.adapter_instance USING btree (modified_by_id);


--
-- Name: adapter_instance_organization_id_8d3624e5; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX adapter_instance_organization_id_8d3624e5 ON unstract.adapter_instance USING btree (organization_id);


--
-- Name: adapter_instance_shared_users_adapterinstance_id_6d55c52f; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX adapter_instance_shared_users_adapterinstance_id_6d55c52f ON unstract.adapter_instance_shared_users USING btree (adapterinstance_id);


--
-- Name: adapter_instance_shared_users_user_id_1947bdb8; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX adapter_instance_shared_users_user_id_1947bdb8 ON unstract.adapter_instance_shared_users USING btree (user_id);


--
-- Name: api_deployment_api_endpoint_0edd7e39_like; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX api_deployment_api_endpoint_0edd7e39_like ON unstract.api_deployment USING btree (api_endpoint varchar_pattern_ops);


--
-- Name: api_deployment_created_by_id_aef43578; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX api_deployment_created_by_id_aef43578 ON unstract.api_deployment USING btree (created_by_id);


--
-- Name: api_deployment_key_api_id_0b1c2b29; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX api_deployment_key_api_id_0b1c2b29 ON unstract.api_deployment_key USING btree (api_id);


--
-- Name: api_deployment_key_created_by_id_6812972f; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX api_deployment_key_created_by_id_6812972f ON unstract.api_deployment_key USING btree (created_by_id);


--
-- Name: api_deployment_key_modified_by_id_b8454e11; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX api_deployment_key_modified_by_id_b8454e11 ON unstract.api_deployment_key USING btree (modified_by_id);


--
-- Name: api_deployment_key_pipeline_id_0d4d7988; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX api_deployment_key_pipeline_id_0d4d7988 ON unstract.api_deployment_key USING btree (pipeline_id);


--
-- Name: api_deployment_modified_by_id_47e7e2db; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX api_deployment_modified_by_id_47e7e2db ON unstract.api_deployment USING btree (modified_by_id);


--
-- Name: api_deployment_organization_id_3899d105; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX api_deployment_organization_id_3899d105 ON unstract.api_deployment USING btree (organization_id);


--
-- Name: api_deployment_shared_users_apideployment_id_2462b599; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX api_deployment_shared_users_apideployment_id_2462b599 ON unstract.api_deployment_shared_users USING btree (apideployment_id);


--
-- Name: api_deployment_shared_users_user_id_7f08be94; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX api_deployment_shared_users_user_id_7f08be94 ON unstract.api_deployment_shared_users USING btree (user_id);


--
-- Name: api_deployment_workflow_id_aa6eb848; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX api_deployment_workflow_id_aa6eb848 ON unstract.api_deployment USING btree (workflow_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX auth_group_name_a6ea08ec_like ON unstract.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON unstract.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON unstract.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON unstract.auth_permission USING btree (content_type_id);


--
-- Name: configuration_organization_id_718550ef; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX configuration_organization_id_718550ef ON unstract.configuration USING btree (organization_id);


--
-- Name: connector_auth_uid_47048a70; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX connector_auth_uid_47048a70 ON unstract.connector_auth USING btree (uid);


--
-- Name: connector_auth_uid_47048a70_like; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX connector_auth_uid_47048a70_like ON unstract.connector_auth USING btree (uid varchar_pattern_ops);


--
-- Name: connector_auth_user_id_40cc7eac; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX connector_auth_user_id_40cc7eac ON unstract.connector_auth USING btree (user_id);


--
-- Name: connector_instance_connector_auth_id_69e22e05; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX connector_instance_connector_auth_id_69e22e05 ON unstract.connector_instance USING btree (connector_auth_id);


--
-- Name: connector_instance_created_by_id_c234e416; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX connector_instance_created_by_id_c234e416 ON unstract.connector_instance USING btree (created_by_id);


--
-- Name: connector_instance_modified_by_id_571d566c; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX connector_instance_modified_by_id_571d566c ON unstract.connector_instance USING btree (modified_by_id);


--
-- Name: connector_instance_organization_id_037491b3; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX connector_instance_organization_id_037491b3 ON unstract.connector_instance USING btree (organization_id);


--
-- Name: connector_instance_shared_users_connectorinstance_id_56b0fe6e; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX connector_instance_shared_users_connectorinstance_id_56b0fe6e ON unstract.connector_instance_shared_users USING btree (connectorinstance_id);


--
-- Name: connector_instance_shared_users_user_id_4e77ee46; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX connector_instance_shared_users_user_id_4e77ee46 ON unstract.connector_instance_shared_users USING btree (user_id);


--
-- Name: custom_tool_challenge_llm_id_96ed23cf; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX custom_tool_challenge_llm_id_96ed23cf ON unstract.custom_tool USING btree (challenge_llm_id);


--
-- Name: custom_tool_created_by_id_861ee398; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX custom_tool_created_by_id_861ee398 ON unstract.custom_tool USING btree (created_by_id);


--
-- Name: custom_tool_modified_by_id_a9604ac6; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX custom_tool_modified_by_id_a9604ac6 ON unstract.custom_tool USING btree (modified_by_id);


--
-- Name: custom_tool_monitor_llm_id_5f9ef0ad; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX custom_tool_monitor_llm_id_5f9ef0ad ON unstract.custom_tool USING btree (monitor_llm_id);


--
-- Name: custom_tool_organization_id_201cb278; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX custom_tool_organization_id_201cb278 ON unstract.custom_tool USING btree (organization_id);


--
-- Name: custom_tool_shared_users_customtool_id_3deac6fb; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX custom_tool_shared_users_customtool_id_3deac6fb ON unstract.custom_tool_shared_users USING btree (customtool_id);


--
-- Name: custom_tool_shared_users_user_id_b2bae190; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX custom_tool_shared_users_user_id_b2bae190 ON unstract.custom_tool_shared_users USING btree (user_id);


--
-- Name: custom_tool_summarize_llm_adapter_id_398e3803; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX custom_tool_summarize_llm_adapter_id_398e3803 ON unstract.custom_tool USING btree (summarize_llm_adapter_id);


--
-- Name: default_organization_user__default_embedding_adapter__76db6587; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX default_organization_user__default_embedding_adapter__76db6587 ON unstract.default_organization_user_adapter USING btree (default_embedding_adapter_id);


--
-- Name: default_organization_user__default_llm_adapter_id_23ae692f; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX default_organization_user__default_llm_adapter_id_23ae692f ON unstract.default_organization_user_adapter USING btree (default_llm_adapter_id);


--
-- Name: default_organization_user__default_vector_db_adapter__e7ab0a85; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX default_organization_user__default_vector_db_adapter__e7ab0a85 ON unstract.default_organization_user_adapter USING btree (default_vector_db_adapter_id);


--
-- Name: default_organization_user__default_x2text_adapter_id_0b33c45b; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX default_organization_user__default_x2text_adapter_id_0b33c45b ON unstract.default_organization_user_adapter USING btree (default_x2text_adapter_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON unstract.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON unstract.django_admin_log USING btree (user_id);


--
-- Name: django_celery_beat_periodictask_clocked_id_47a69f82; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX django_celery_beat_periodictask_clocked_id_47a69f82 ON unstract.django_celery_beat_periodictask USING btree (clocked_id);


--
-- Name: django_celery_beat_periodictask_crontab_id_d3cba168; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX django_celery_beat_periodictask_crontab_id_d3cba168 ON unstract.django_celery_beat_periodictask USING btree (crontab_id);


--
-- Name: django_celery_beat_periodictask_interval_id_a8ca27da; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX django_celery_beat_periodictask_interval_id_a8ca27da ON unstract.django_celery_beat_periodictask USING btree (interval_id);


--
-- Name: django_celery_beat_periodictask_name_265a36b7_like; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX django_celery_beat_periodictask_name_265a36b7_like ON unstract.django_celery_beat_periodictask USING btree (name varchar_pattern_ops);


--
-- Name: django_celery_beat_periodictask_solar_id_a87ce72c; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX django_celery_beat_periodictask_solar_id_a87ce72c ON unstract.django_celery_beat_periodictask USING btree (solar_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX django_session_expire_date_a5c62663 ON unstract.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX django_session_session_key_c0390e0f_like ON unstract.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: document_manager_created_by_id_41634cee; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX document_manager_created_by_id_41634cee ON unstract.document_manager USING btree (created_by_id);


--
-- Name: document_manager_modified_by_id_8be3c48e; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX document_manager_modified_by_id_8be3c48e ON unstract.document_manager USING btree (modified_by_id);


--
-- Name: document_manager_tool_id_9c37a4b1; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX document_manager_tool_id_9c37a4b1 ON unstract.document_manager USING btree (tool_id);


--
-- Name: execution_log_file_execution_id_dbf2ab5d; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX execution_log_file_execution_id_dbf2ab5d ON unstract.execution_log USING btree (file_execution_id);


--
-- Name: execution_log_wf_execution_id_1634f425; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX execution_log_wf_execution_id_1634f425 ON unstract.execution_log USING btree (wf_execution_id);


--
-- Name: file_history_workflow_id_6e447719; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX file_history_workflow_id_6e447719 ON unstract.file_history USING btree (workflow_id);


--
-- Name: idx_execution_id_event_time; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX idx_execution_id_event_time ON unstract.execution_log USING btree (execution_id, event_time);


--
-- Name: idx_fh_workflow_created; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX idx_fh_workflow_created ON unstract.file_history USING btree (workflow_id, created_at);


--
-- Name: idx_file_execution_event_time; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX idx_file_execution_event_time ON unstract.execution_log USING btree (file_execution_id, event_time);


--
-- Name: idx_wf_execution_event_time; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX idx_wf_execution_event_time ON unstract.execution_log USING btree (wf_execution_id, event_time);


--
-- Name: index_manager_created_by_id_ef12f53c; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX index_manager_created_by_id_ef12f53c ON unstract.index_manager USING btree (created_by_id);


--
-- Name: index_manager_document_manager_id_f477750c; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX index_manager_document_manager_id_f477750c ON unstract.index_manager USING btree (document_manager_id);


--
-- Name: index_manager_modified_by_id_2d411aee; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX index_manager_modified_by_id_2d411aee ON unstract.index_manager USING btree (modified_by_id);


--
-- Name: index_manager_profile_manager_id_c12a1afc; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX index_manager_profile_manager_id_c12a1afc ON unstract.index_manager USING btree (profile_manager_id);


--
-- Name: notification_api_id_49c69ed5; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX notification_api_id_49c69ed5 ON unstract.notification USING btree (api_id);


--
-- Name: notification_pipeline_id_7f82a296; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX notification_pipeline_id_7f82a296 ON unstract.notification USING btree (pipeline_id);


--
-- Name: organization_created_by_id_35551e36; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX organization_created_by_id_35551e36 ON unstract.organization USING btree (created_by_id);


--
-- Name: organization_member_organization_id_ca7d3ea8; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX organization_member_organization_id_ca7d3ea8 ON unstract.organization_member USING btree (organization_id);


--
-- Name: organization_member_user_id_ee858f64; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX organization_member_user_id_ee858f64 ON unstract.organization_member USING btree (user_id);


--
-- Name: organization_modified_by_id_ccb4de5f; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX organization_modified_by_id_ccb4de5f ON unstract.organization USING btree (modified_by_id);


--
-- Name: organization_organization_id_e42205cb_like; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX organization_organization_id_e42205cb_like ON unstract.organization USING btree (organization_id varchar_pattern_ops);


--
-- Name: page_usage_organiz_b56749_idx; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX page_usage_organiz_b56749_idx ON unstract.page_usage USING btree (organization_id);


--
-- Name: pipeline_created_by_id_af4600ea; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX pipeline_created_by_id_af4600ea ON unstract.pipeline USING btree (created_by_id);


--
-- Name: pipeline_modified_by_id_0daa0c7a; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX pipeline_modified_by_id_0daa0c7a ON unstract.pipeline USING btree (modified_by_id);


--
-- Name: pipeline_organization_id_add99931; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX pipeline_organization_id_add99931 ON unstract.pipeline USING btree (organization_id);


--
-- Name: pipeline_shared_users_pipeline_id_fee2e87c; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX pipeline_shared_users_pipeline_id_fee2e87c ON unstract.pipeline_shared_users USING btree (pipeline_id);


--
-- Name: pipeline_shared_users_user_id_6e7b45b5; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX pipeline_shared_users_user_id_6e7b45b5 ON unstract.pipeline_shared_users USING btree (user_id);


--
-- Name: pipeline_workflow_id_a1ccb4e8; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX pipeline_workflow_id_a1ccb4e8 ON unstract.pipeline USING btree (workflow_id);


--
-- Name: platform_key_created_by_id_3df05402; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX platform_key_created_by_id_3df05402 ON unstract.platform_key USING btree (created_by_id);


--
-- Name: platform_key_modified_by_id_0ab1c6e3; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX platform_key_modified_by_id_0ab1c6e3 ON unstract.platform_key USING btree (modified_by_id);


--
-- Name: platform_key_organization_id_7a444fb6; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX platform_key_organization_id_7a444fb6 ON unstract.platform_key USING btree (organization_id);


--
-- Name: profile_manager_created_by_id_22604ac9; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX profile_manager_created_by_id_22604ac9 ON unstract.profile_manager USING btree (created_by_id);


--
-- Name: profile_manager_embedding_model_id_31b50061; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX profile_manager_embedding_model_id_31b50061 ON unstract.profile_manager USING btree (embedding_model_id);


--
-- Name: profile_manager_llm_id_f1cb74ee; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX profile_manager_llm_id_f1cb74ee ON unstract.profile_manager USING btree (llm_id);


--
-- Name: profile_manager_modified_by_id_aad8e97d; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX profile_manager_modified_by_id_aad8e97d ON unstract.profile_manager USING btree (modified_by_id);


--
-- Name: profile_manager_prompt_studio_tool_id_91d3c920; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX profile_manager_prompt_studio_tool_id_91d3c920 ON unstract.profile_manager USING btree (prompt_studio_tool_id);


--
-- Name: profile_manager_vector_store_id_5f897443; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX profile_manager_vector_store_id_5f897443 ON unstract.profile_manager USING btree (vector_store_id);


--
-- Name: profile_manager_x2text_id_9567268e; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX profile_manager_x2text_id_9567268e ON unstract.profile_manager USING btree (x2text_id);


--
-- Name: prompt_studio_output_manager_created_by_id_eb325217; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX prompt_studio_output_manager_created_by_id_eb325217 ON unstract.prompt_studio_output_manager USING btree (created_by_id);


--
-- Name: prompt_studio_output_manager_document_manager_id_b2858ee5; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX prompt_studio_output_manager_document_manager_id_b2858ee5 ON unstract.prompt_studio_output_manager USING btree (document_manager_id);


--
-- Name: prompt_studio_output_manager_modified_by_id_54d42f2f; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX prompt_studio_output_manager_modified_by_id_54d42f2f ON unstract.prompt_studio_output_manager USING btree (modified_by_id);


--
-- Name: prompt_studio_output_manager_profile_manager_id_9d4296aa; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX prompt_studio_output_manager_profile_manager_id_9d4296aa ON unstract.prompt_studio_output_manager USING btree (profile_manager_id);


--
-- Name: prompt_studio_output_manager_prompt_id_id_646c12f5; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX prompt_studio_output_manager_prompt_id_id_646c12f5 ON unstract.prompt_studio_output_manager USING btree (prompt_id_id);


--
-- Name: prompt_studio_output_manager_tool_id_id_05fcbbe3; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX prompt_studio_output_manager_tool_id_id_05fcbbe3 ON unstract.prompt_studio_output_manager USING btree (tool_id_id);


--
-- Name: prompt_studio_registry_created_by_id_a1bc7ecf; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX prompt_studio_registry_created_by_id_a1bc7ecf ON unstract.prompt_studio_registry USING btree (created_by_id);


--
-- Name: prompt_studio_registry_modified_by_id_8cf53126; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX prompt_studio_registry_modified_by_id_8cf53126 ON unstract.prompt_studio_registry USING btree (modified_by_id);


--
-- Name: prompt_studio_registry_organization_id_f610bb27; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX prompt_studio_registry_organization_id_f610bb27 ON unstract.prompt_studio_registry USING btree (organization_id);


--
-- Name: prompt_studio_registry_sha_promptstudioregistry_id_8b008e8b; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX prompt_studio_registry_sha_promptstudioregistry_id_8b008e8b ON unstract.prompt_studio_registry_shared_users USING btree (promptstudioregistry_id);


--
-- Name: prompt_studio_registry_shared_users_user_id_48bd909b; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX prompt_studio_registry_shared_users_user_id_48bd909b ON unstract.prompt_studio_registry_shared_users USING btree (user_id);


--
-- Name: social_auth_code_code_a2393167; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX social_auth_code_code_a2393167 ON unstract.social_auth_code USING btree (code);


--
-- Name: social_auth_code_code_a2393167_like; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX social_auth_code_code_a2393167_like ON unstract.social_auth_code USING btree (code varchar_pattern_ops);


--
-- Name: social_auth_code_timestamp_176b341f; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX social_auth_code_timestamp_176b341f ON unstract.social_auth_code USING btree ("timestamp");


--
-- Name: social_auth_partial_timestamp_50f2119f; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX social_auth_partial_timestamp_50f2119f ON unstract.social_auth_partial USING btree ("timestamp");


--
-- Name: social_auth_partial_token_3017fea3; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX social_auth_partial_token_3017fea3 ON unstract.social_auth_partial USING btree (token);


--
-- Name: social_auth_partial_token_3017fea3_like; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX social_auth_partial_token_3017fea3_like ON unstract.social_auth_partial USING btree (token varchar_pattern_ops);


--
-- Name: social_auth_usersocialauth_uid_796e51dc; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX social_auth_usersocialauth_uid_796e51dc ON unstract.social_auth_usersocialauth USING btree (uid);


--
-- Name: social_auth_usersocialauth_uid_796e51dc_like; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX social_auth_usersocialauth_uid_796e51dc_like ON unstract.social_auth_usersocialauth USING btree (uid varchar_pattern_ops);


--
-- Name: social_auth_usersocialauth_user_id_17d28448; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX social_auth_usersocialauth_user_id_17d28448 ON unstract.social_auth_usersocialauth USING btree (user_id);


--
-- Name: tag_organization_id_9181f8bb; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX tag_organization_id_9181f8bb ON unstract.tag USING btree (organization_id);


--
-- Name: tool_instance_created_by_id_3b033ad8; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX tool_instance_created_by_id_3b033ad8 ON unstract.tool_instance USING btree (created_by_id);


--
-- Name: tool_instance_modified_by_id_a9b8c906; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX tool_instance_modified_by_id_a9b8c906 ON unstract.tool_instance USING btree (modified_by_id);


--
-- Name: tool_instance_workflow_id_ab81425d; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX tool_instance_workflow_id_ab81425d ON unstract.tool_instance USING btree (workflow_id);


--
-- Name: tool_studio_prompt_created_by_id_1c1817fe; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX tool_studio_prompt_created_by_id_1c1817fe ON unstract.tool_studio_prompt USING btree (created_by_id);


--
-- Name: tool_studio_prompt_modified_by_id_618eb1bb; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX tool_studio_prompt_modified_by_id_618eb1bb ON unstract.tool_studio_prompt USING btree (modified_by_id);


--
-- Name: tool_studio_prompt_profile_manager_id_ae621291; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX tool_studio_prompt_profile_manager_id_ae621291 ON unstract.tool_studio_prompt USING btree (profile_manager_id);


--
-- Name: tool_studio_prompt_tool_id_id_c4fb4829; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX tool_studio_prompt_tool_id_id_c4fb4829 ON unstract.tool_studio_prompt USING btree (tool_id_id);


--
-- Name: unique_workflow_cacheKey; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE UNIQUE INDEX "unique_workflow_cacheKey" ON unstract.file_history USING btree (workflow_id, cache_key) WHERE (((cache_key)::text IS NOT NULL) AND ((file_path)::text IS NULL));


--
-- Name: unique_workflow_cacheKey_with_filePath; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE UNIQUE INDEX "unique_workflow_cacheKey_with_filePath" ON unstract.file_history USING btree (workflow_id, cache_key, file_path) WHERE (((cache_key)::text IS NOT NULL) AND ((file_path)::text IS NOT NULL));


--
-- Name: unique_workflow_providerFileUUID; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE UNIQUE INDEX "unique_workflow_providerFileUUID" ON unstract.file_history USING btree (workflow_id, provider_file_uuid) WHERE (((file_path)::text IS NULL) AND ((provider_file_uuid)::text IS NOT NULL));


--
-- Name: unique_workflow_providerFileUUID_with_filePath; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE UNIQUE INDEX "unique_workflow_providerFileUUID_with_filePath" ON unstract.file_history USING btree (workflow_id, provider_file_uuid, file_path) WHERE (((file_path)::text IS NOT NULL) AND ((provider_file_uuid)::text IS NOT NULL));


--
-- Name: usage_executi_4deb35_idx; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX usage_executi_4deb35_idx ON unstract.usage USING btree (execution_id);


--
-- Name: usage_organization_id_8f526ff4; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX usage_organization_id_8f526ff4 ON unstract.usage USING btree (organization_id);


--
-- Name: usage_run_id_c84096_idx; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX usage_run_id_c84096_idx ON unstract.usage USING btree (run_id);


--
-- Name: user_created_by_id_7fed2b0e; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX user_created_by_id_7fed2b0e ON unstract."user" USING btree (created_by_id);


--
-- Name: user_groups_group_id_b76f8aba; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX user_groups_group_id_b76f8aba ON unstract.user_groups USING btree (group_id);


--
-- Name: user_groups_user_id_abaea130; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX user_groups_user_id_abaea130 ON unstract.user_groups USING btree (user_id);


--
-- Name: user_modified_by_id_6c8b494e; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX user_modified_by_id_6c8b494e ON unstract."user" USING btree (modified_by_id);


--
-- Name: user_user_permissions_permission_id_9deb68a3; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX user_user_permissions_permission_id_9deb68a3 ON unstract.user_user_permissions USING btree (permission_id);


--
-- Name: user_user_permissions_user_id_ed4a47ea; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX user_user_permissions_user_id_ed4a47ea ON unstract.user_user_permissions USING btree (user_id);


--
-- Name: user_username_cf016618_like; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX user_username_cf016618_like ON unstract."user" USING btree (username varchar_pattern_ops);


--
-- Name: wf_file_hash_path_status_idx; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX wf_file_hash_path_status_idx ON unstract.workflow_file_execution USING btree (workflow_execution_id, file_hash, file_path, status);


--
-- Name: wf_provider_uuid_path_stat_idx; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX wf_provider_uuid_path_stat_idx ON unstract.workflow_file_execution USING btree (workflow_execution_id, provider_file_uuid, file_path, status);


--
-- Name: workflow_created_by_id_f4342385; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX workflow_created_by_id_f4342385 ON unstract.workflow USING btree (created_by_id);


--
-- Name: workflow_endpoints_connector_instance_id_59df0598; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX workflow_endpoints_connector_instance_id_59df0598 ON unstract.workflow_endpoints USING btree (connector_instance_id);


--
-- Name: workflow_endpoints_workflow_id_dc62f4a5; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX workflow_endpoints_workflow_id_dc62f4a5 ON unstract.workflow_endpoints USING btree (workflow_id);


--
-- Name: workflow_ex_pipelin_126dbf_idx; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX workflow_ex_pipelin_126dbf_idx ON unstract.workflow_execution USING btree (pipeline_id, created_at DESC);


--
-- Name: workflow_ex_workflo_5942c9_idx; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX workflow_ex_workflo_5942c9_idx ON unstract.workflow_execution USING btree (workflow_id, created_at DESC);


--
-- Name: workflow_exec_p_uuid_idx; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX workflow_exec_p_uuid_idx ON unstract.workflow_file_execution USING btree (workflow_execution_id, provider_file_uuid);


--
-- Name: workflow_execution_tags_tag_id_7717f64c; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX workflow_execution_tags_tag_id_7717f64c ON unstract.workflow_execution_tags USING btree (tag_id);


--
-- Name: workflow_execution_tags_workflowexecution_id_1d4e2d20; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX workflow_execution_tags_workflowexecution_id_1d4e2d20 ON unstract.workflow_execution_tags USING btree (workflowexecution_id);


--
-- Name: workflow_execution_workflow_id_53557214; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX workflow_execution_workflow_id_53557214 ON unstract.workflow_execution USING btree (workflow_id);


--
-- Name: workflow_file_execution_workflow_execution_id_9a8e3880; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX workflow_file_execution_workflow_execution_id_9a8e3880 ON unstract.workflow_file_execution USING btree (workflow_execution_id);


--
-- Name: workflow_file_hash_idx; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX workflow_file_hash_idx ON unstract.workflow_file_execution USING btree (workflow_execution_id, file_hash);


--
-- Name: workflow_modified_by_id_6763e6ef; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX workflow_modified_by_id_6763e6ef ON unstract.workflow USING btree (modified_by_id);


--
-- Name: workflow_organization_id_99e92910; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX workflow_organization_id_99e92910 ON unstract.workflow USING btree (organization_id);


--
-- Name: workflow_shared_users_user_id_28f13cce; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX workflow_shared_users_user_id_28f13cce ON unstract.workflow_shared_users USING btree (user_id);


--
-- Name: workflow_shared_users_workflow_id_d650c47b; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX workflow_shared_users_workflow_id_d650c47b ON unstract.workflow_shared_users USING btree (workflow_id);


--
-- Name: workflow_workflow_owner_id_dcc410b4; Type: INDEX; Schema: unstract; Owner: unstract_dev
--

CREATE INDEX workflow_workflow_owner_id_dcc410b4 ON unstract.workflow USING btree (workflow_owner_id);


--
-- Name: constraints constraints_namespace_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.constraints
    ADD CONSTRAINT constraints_namespace_key_fkey FOREIGN KEY (namespace_key) REFERENCES public.namespaces(key) ON DELETE CASCADE;


--
-- Name: constraints constraints_namespace_key_segment_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.constraints
    ADD CONSTRAINT constraints_namespace_key_segment_key_fkey FOREIGN KEY (namespace_key, segment_key) REFERENCES public.segments(namespace_key, key) ON DELETE CASCADE;


--
-- Name: distributions distributions_rule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.distributions
    ADD CONSTRAINT distributions_rule_id_fkey FOREIGN KEY (rule_id) REFERENCES public.rules(id) ON DELETE CASCADE;


--
-- Name: distributions distributions_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.distributions
    ADD CONSTRAINT distributions_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.variants(id) ON DELETE CASCADE;


--
-- Name: flags flags_namespace_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.flags
    ADD CONSTRAINT flags_namespace_key_fkey FOREIGN KEY (namespace_key) REFERENCES public.namespaces(key) ON DELETE CASCADE;


--
-- Name: rollout_segment_references rollout_segment_references_namespace_key_segment_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rollout_segment_references
    ADD CONSTRAINT rollout_segment_references_namespace_key_segment_key_fkey FOREIGN KEY (namespace_key, segment_key) REFERENCES public.segments(namespace_key, key) ON DELETE CASCADE;


--
-- Name: rollout_segment_references rollout_segment_references_rollout_segment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rollout_segment_references
    ADD CONSTRAINT rollout_segment_references_rollout_segment_id_fkey FOREIGN KEY (rollout_segment_id) REFERENCES public.rollout_segments(id) ON DELETE CASCADE;


--
-- Name: rollout_segments rollout_segments_rollout_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rollout_segments
    ADD CONSTRAINT rollout_segments_rollout_id_fkey FOREIGN KEY (rollout_id) REFERENCES public.rollouts(id) ON DELETE CASCADE;


--
-- Name: rollout_thresholds rollout_thresholds_namespace_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rollout_thresholds
    ADD CONSTRAINT rollout_thresholds_namespace_key_fkey FOREIGN KEY (namespace_key) REFERENCES public.namespaces(key) ON DELETE CASCADE;


--
-- Name: rollout_thresholds rollout_thresholds_rollout_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rollout_thresholds
    ADD CONSTRAINT rollout_thresholds_rollout_id_fkey FOREIGN KEY (rollout_id) REFERENCES public.rollouts(id) ON DELETE CASCADE;


--
-- Name: rollouts rollouts_namespace_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rollouts
    ADD CONSTRAINT rollouts_namespace_key_fkey FOREIGN KEY (namespace_key) REFERENCES public.namespaces(key) ON DELETE CASCADE;


--
-- Name: rollouts rollouts_namespace_key_flag_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rollouts
    ADD CONSTRAINT rollouts_namespace_key_flag_key_fkey FOREIGN KEY (namespace_key, flag_key) REFERENCES public.flags(namespace_key, key) ON DELETE CASCADE;


--
-- Name: rule_segments rule_segments_namespace_key_segment_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rule_segments
    ADD CONSTRAINT rule_segments_namespace_key_segment_key_fkey FOREIGN KEY (namespace_key, segment_key) REFERENCES public.segments(namespace_key, key) ON DELETE CASCADE;


--
-- Name: rule_segments rule_segments_rule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rule_segments
    ADD CONSTRAINT rule_segments_rule_id_fkey FOREIGN KEY (rule_id) REFERENCES public.rules(id) ON DELETE CASCADE;


--
-- Name: rules rules_namespace_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rules
    ADD CONSTRAINT rules_namespace_key_fkey FOREIGN KEY (namespace_key) REFERENCES public.namespaces(key) ON DELETE CASCADE;


--
-- Name: rules rules_namespace_key_flag_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.rules
    ADD CONSTRAINT rules_namespace_key_flag_key_fkey FOREIGN KEY (namespace_key, flag_key) REFERENCES public.flags(namespace_key, key) ON DELETE CASCADE;


--
-- Name: segments segments_namespace_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.segments
    ADD CONSTRAINT segments_namespace_key_fkey FOREIGN KEY (namespace_key) REFERENCES public.namespaces(key) ON DELETE CASCADE;


--
-- Name: variants variants_namespace_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_namespace_key_fkey FOREIGN KEY (namespace_key) REFERENCES public.namespaces(key) ON DELETE CASCADE;


--
-- Name: variants variants_namespace_key_flag_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unstract_dev
--

ALTER TABLE ONLY public.variants
    ADD CONSTRAINT variants_namespace_key_flag_key_fkey FOREIGN KEY (namespace_key, flag_key) REFERENCES public.flags(namespace_key, key) ON DELETE CASCADE;


--
-- Name: adapter_instance adapter_instance_created_by_id_2c3c57b2_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.adapter_instance
    ADD CONSTRAINT adapter_instance_created_by_id_2c3c57b2_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: adapter_instance adapter_instance_modified_by_id_a2461822_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.adapter_instance
    ADD CONSTRAINT adapter_instance_modified_by_id_a2461822_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: adapter_instance adapter_instance_organization_id_8d3624e5_fk_organization_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.adapter_instance
    ADD CONSTRAINT adapter_instance_organization_id_8d3624e5_fk_organization_id FOREIGN KEY (organization_id) REFERENCES unstract.organization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: adapter_instance_shared_users adapter_instance_sha_adapterinstance_id_6d55c52f_fk_adapter_i; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.adapter_instance_shared_users
    ADD CONSTRAINT adapter_instance_sha_adapterinstance_id_6d55c52f_fk_adapter_i FOREIGN KEY (adapterinstance_id) REFERENCES unstract.adapter_instance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: adapter_instance_shared_users adapter_instance_shared_users_user_id_1947bdb8_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.adapter_instance_shared_users
    ADD CONSTRAINT adapter_instance_shared_users_user_id_1947bdb8_fk_user_id FOREIGN KEY (user_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_deployment api_deployment_created_by_id_aef43578_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment
    ADD CONSTRAINT api_deployment_created_by_id_aef43578_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_deployment_key api_deployment_key_api_id_0b1c2b29_fk_api_deployment_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment_key
    ADD CONSTRAINT api_deployment_key_api_id_0b1c2b29_fk_api_deployment_id FOREIGN KEY (api_id) REFERENCES unstract.api_deployment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_deployment_key api_deployment_key_created_by_id_6812972f_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment_key
    ADD CONSTRAINT api_deployment_key_created_by_id_6812972f_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_deployment_key api_deployment_key_modified_by_id_b8454e11_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment_key
    ADD CONSTRAINT api_deployment_key_modified_by_id_b8454e11_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_deployment_key api_deployment_key_pipeline_id_0d4d7988_fk_pipeline_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment_key
    ADD CONSTRAINT api_deployment_key_pipeline_id_0d4d7988_fk_pipeline_id FOREIGN KEY (pipeline_id) REFERENCES unstract.pipeline(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_deployment api_deployment_modified_by_id_47e7e2db_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment
    ADD CONSTRAINT api_deployment_modified_by_id_47e7e2db_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_deployment api_deployment_organization_id_3899d105_fk_organization_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment
    ADD CONSTRAINT api_deployment_organization_id_3899d105_fk_organization_id FOREIGN KEY (organization_id) REFERENCES unstract.organization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_deployment_shared_users api_deployment_share_apideployment_id_2462b599_fk_api_deplo; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment_shared_users
    ADD CONSTRAINT api_deployment_share_apideployment_id_2462b599_fk_api_deplo FOREIGN KEY (apideployment_id) REFERENCES unstract.api_deployment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_deployment_shared_users api_deployment_shared_users_user_id_7f08be94_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment_shared_users
    ADD CONSTRAINT api_deployment_shared_users_user_id_7f08be94_fk_user_id FOREIGN KEY (user_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_deployment api_deployment_workflow_id_aa6eb848_fk_workflow_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.api_deployment
    ADD CONSTRAINT api_deployment_workflow_id_aa6eb848_fk_workflow_id FOREIGN KEY (workflow_id) REFERENCES unstract.workflow(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES unstract.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES unstract.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES unstract.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: configuration configuration_organization_id_718550ef_fk_organization_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.configuration
    ADD CONSTRAINT configuration_organization_id_718550ef_fk_organization_id FOREIGN KEY (organization_id) REFERENCES unstract.organization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: connector_auth connector_auth_user_id_40cc7eac_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.connector_auth
    ADD CONSTRAINT connector_auth_user_id_40cc7eac_fk_user_id FOREIGN KEY (user_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: connector_instance connector_instance_connector_auth_id_69e22e05_fk_connector; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.connector_instance
    ADD CONSTRAINT connector_instance_connector_auth_id_69e22e05_fk_connector FOREIGN KEY (connector_auth_id) REFERENCES unstract.connector_auth(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: connector_instance connector_instance_created_by_id_c234e416_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.connector_instance
    ADD CONSTRAINT connector_instance_created_by_id_c234e416_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: connector_instance connector_instance_modified_by_id_571d566c_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.connector_instance
    ADD CONSTRAINT connector_instance_modified_by_id_571d566c_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: connector_instance connector_instance_organization_id_037491b3_fk_organization_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.connector_instance
    ADD CONSTRAINT connector_instance_organization_id_037491b3_fk_organization_id FOREIGN KEY (organization_id) REFERENCES unstract.organization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: connector_instance_shared_users connector_instance_s_connectorinstance_id_56b0fe6e_fk_connector; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.connector_instance_shared_users
    ADD CONSTRAINT connector_instance_s_connectorinstance_id_56b0fe6e_fk_connector FOREIGN KEY (connectorinstance_id) REFERENCES unstract.connector_instance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: connector_instance_shared_users connector_instance_shared_users_user_id_4e77ee46_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.connector_instance_shared_users
    ADD CONSTRAINT connector_instance_shared_users_user_id_4e77ee46_fk_user_id FOREIGN KEY (user_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: custom_tool custom_tool_challenge_llm_id_96ed23cf_fk_adapter_instance_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.custom_tool
    ADD CONSTRAINT custom_tool_challenge_llm_id_96ed23cf_fk_adapter_instance_id FOREIGN KEY (challenge_llm_id) REFERENCES unstract.adapter_instance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: custom_tool custom_tool_created_by_id_861ee398_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.custom_tool
    ADD CONSTRAINT custom_tool_created_by_id_861ee398_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: custom_tool custom_tool_modified_by_id_a9604ac6_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.custom_tool
    ADD CONSTRAINT custom_tool_modified_by_id_a9604ac6_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: custom_tool custom_tool_monitor_llm_id_5f9ef0ad_fk_adapter_instance_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.custom_tool
    ADD CONSTRAINT custom_tool_monitor_llm_id_5f9ef0ad_fk_adapter_instance_id FOREIGN KEY (monitor_llm_id) REFERENCES unstract.adapter_instance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: custom_tool custom_tool_organization_id_201cb278_fk_organization_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.custom_tool
    ADD CONSTRAINT custom_tool_organization_id_201cb278_fk_organization_id FOREIGN KEY (organization_id) REFERENCES unstract.organization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: custom_tool_shared_users custom_tool_shared_u_customtool_id_3deac6fb_fk_custom_to; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.custom_tool_shared_users
    ADD CONSTRAINT custom_tool_shared_u_customtool_id_3deac6fb_fk_custom_to FOREIGN KEY (customtool_id) REFERENCES unstract.custom_tool(tool_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: custom_tool_shared_users custom_tool_shared_users_user_id_b2bae190_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.custom_tool_shared_users
    ADD CONSTRAINT custom_tool_shared_users_user_id_b2bae190_fk_user_id FOREIGN KEY (user_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: custom_tool custom_tool_summarize_llm_adapte_398e3803_fk_adapter_i; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.custom_tool
    ADD CONSTRAINT custom_tool_summarize_llm_adapte_398e3803_fk_adapter_i FOREIGN KEY (summarize_llm_adapter_id) REFERENCES unstract.adapter_instance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: default_organization_user_adapter default_organization_default_embedding_ad_76db6587_fk_adapter_i; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.default_organization_user_adapter
    ADD CONSTRAINT default_organization_default_embedding_ad_76db6587_fk_adapter_i FOREIGN KEY (default_embedding_adapter_id) REFERENCES unstract.adapter_instance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: default_organization_user_adapter default_organization_default_llm_adapter__23ae692f_fk_adapter_i; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.default_organization_user_adapter
    ADD CONSTRAINT default_organization_default_llm_adapter__23ae692f_fk_adapter_i FOREIGN KEY (default_llm_adapter_id) REFERENCES unstract.adapter_instance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: default_organization_user_adapter default_organization_default_vector_db_ad_e7ab0a85_fk_adapter_i; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.default_organization_user_adapter
    ADD CONSTRAINT default_organization_default_vector_db_ad_e7ab0a85_fk_adapter_i FOREIGN KEY (default_vector_db_adapter_id) REFERENCES unstract.adapter_instance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: default_organization_user_adapter default_organization_default_x2text_adapt_0b33c45b_fk_adapter_i; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.default_organization_user_adapter
    ADD CONSTRAINT default_organization_default_x2text_adapt_0b33c45b_fk_adapter_i FOREIGN KEY (default_x2text_adapter_id) REFERENCES unstract.adapter_instance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: default_organization_user_adapter default_organization_organization_member__ee5cd305_fk_organizat; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.default_organization_user_adapter
    ADD CONSTRAINT default_organization_organization_member__ee5cd305_fk_organizat FOREIGN KEY (organization_member_id) REFERENCES unstract.organization_member(member_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES unstract.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_user_id FOREIGN KEY (user_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_clocked_id_47a69f82_fk_django_ce; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_clocked_id_47a69f82_fk_django_ce FOREIGN KEY (clocked_id) REFERENCES unstract.django_celery_beat_clockedschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_crontab_id_d3cba168_fk_django_ce; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_crontab_id_d3cba168_fk_django_ce FOREIGN KEY (crontab_id) REFERENCES unstract.django_celery_beat_crontabschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_interval_id_a8ca27da_fk_django_ce; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_interval_id_a8ca27da_fk_django_ce FOREIGN KEY (interval_id) REFERENCES unstract.django_celery_beat_intervalschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_solar_id_a87ce72c_fk_django_ce; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_solar_id_a87ce72c_fk_django_ce FOREIGN KEY (solar_id) REFERENCES unstract.django_celery_beat_solarschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: document_manager document_manager_created_by_id_41634cee_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.document_manager
    ADD CONSTRAINT document_manager_created_by_id_41634cee_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: document_manager document_manager_modified_by_id_8be3c48e_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.document_manager
    ADD CONSTRAINT document_manager_modified_by_id_8be3c48e_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: document_manager document_manager_tool_id_9c37a4b1_fk_custom_tool_tool_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.document_manager
    ADD CONSTRAINT document_manager_tool_id_9c37a4b1_fk_custom_tool_tool_id FOREIGN KEY (tool_id) REFERENCES unstract.custom_tool(tool_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: execution_log execution_log_file_execution_id_dbf2ab5d_fk_workflow_; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.execution_log
    ADD CONSTRAINT execution_log_file_execution_id_dbf2ab5d_fk_workflow_ FOREIGN KEY (file_execution_id) REFERENCES unstract.workflow_file_execution(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: execution_log execution_log_wf_execution_id_1634f425_fk_workflow_execution_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.execution_log
    ADD CONSTRAINT execution_log_wf_execution_id_1634f425_fk_workflow_execution_id FOREIGN KEY (wf_execution_id) REFERENCES unstract.workflow_execution(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: file_history file_history_workflow_id_6e447719_fk_workflow_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.file_history
    ADD CONSTRAINT file_history_workflow_id_6e447719_fk_workflow_id FOREIGN KEY (workflow_id) REFERENCES unstract.workflow(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: index_manager index_manager_created_by_id_ef12f53c_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.index_manager
    ADD CONSTRAINT index_manager_created_by_id_ef12f53c_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: index_manager index_manager_document_manager_id_f477750c_fk_document_; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.index_manager
    ADD CONSTRAINT index_manager_document_manager_id_f477750c_fk_document_ FOREIGN KEY (document_manager_id) REFERENCES unstract.document_manager(document_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: index_manager index_manager_modified_by_id_2d411aee_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.index_manager
    ADD CONSTRAINT index_manager_modified_by_id_2d411aee_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: index_manager index_manager_profile_manager_id_c12a1afc_fk_profile_m; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.index_manager
    ADD CONSTRAINT index_manager_profile_manager_id_c12a1afc_fk_profile_m FOREIGN KEY (profile_manager_id) REFERENCES unstract.profile_manager(profile_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notification notification_api_id_49c69ed5_fk_api_deployment_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.notification
    ADD CONSTRAINT notification_api_id_49c69ed5_fk_api_deployment_id FOREIGN KEY (api_id) REFERENCES unstract.api_deployment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notification notification_pipeline_id_7f82a296_fk_pipeline_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.notification
    ADD CONSTRAINT notification_pipeline_id_7f82a296_fk_pipeline_id FOREIGN KEY (pipeline_id) REFERENCES unstract.pipeline(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: organization organization_created_by_id_35551e36_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.organization
    ADD CONSTRAINT organization_created_by_id_35551e36_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: organization_member organization_member_organization_id_ca7d3ea8_fk_organization_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.organization_member
    ADD CONSTRAINT organization_member_organization_id_ca7d3ea8_fk_organization_id FOREIGN KEY (organization_id) REFERENCES unstract.organization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: organization_member organization_member_user_id_ee858f64_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.organization_member
    ADD CONSTRAINT organization_member_user_id_ee858f64_fk_user_id FOREIGN KEY (user_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: organization organization_modified_by_id_ccb4de5f_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.organization
    ADD CONSTRAINT organization_modified_by_id_ccb4de5f_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipeline pipeline_created_by_id_af4600ea_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.pipeline
    ADD CONSTRAINT pipeline_created_by_id_af4600ea_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipeline pipeline_modified_by_id_0daa0c7a_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.pipeline
    ADD CONSTRAINT pipeline_modified_by_id_0daa0c7a_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipeline pipeline_organization_id_add99931_fk_organization_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.pipeline
    ADD CONSTRAINT pipeline_organization_id_add99931_fk_organization_id FOREIGN KEY (organization_id) REFERENCES unstract.organization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipeline_shared_users pipeline_shared_users_pipeline_id_fee2e87c_fk_pipeline_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.pipeline_shared_users
    ADD CONSTRAINT pipeline_shared_users_pipeline_id_fee2e87c_fk_pipeline_id FOREIGN KEY (pipeline_id) REFERENCES unstract.pipeline(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipeline_shared_users pipeline_shared_users_user_id_6e7b45b5_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.pipeline_shared_users
    ADD CONSTRAINT pipeline_shared_users_user_id_6e7b45b5_fk_user_id FOREIGN KEY (user_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pipeline pipeline_workflow_id_a1ccb4e8_fk_workflow_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.pipeline
    ADD CONSTRAINT pipeline_workflow_id_a1ccb4e8_fk_workflow_id FOREIGN KEY (workflow_id) REFERENCES unstract.workflow(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: platform_key platform_key_created_by_id_3df05402_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.platform_key
    ADD CONSTRAINT platform_key_created_by_id_3df05402_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: platform_key platform_key_modified_by_id_0ab1c6e3_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.platform_key
    ADD CONSTRAINT platform_key_modified_by_id_0ab1c6e3_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: platform_key platform_key_organization_id_7a444fb6_fk_organization_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.platform_key
    ADD CONSTRAINT platform_key_organization_id_7a444fb6_fk_organization_id FOREIGN KEY (organization_id) REFERENCES unstract.organization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profile_manager profile_manager_created_by_id_22604ac9_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.profile_manager
    ADD CONSTRAINT profile_manager_created_by_id_22604ac9_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profile_manager profile_manager_embedding_model_id_31b50061_fk_adapter_i; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.profile_manager
    ADD CONSTRAINT profile_manager_embedding_model_id_31b50061_fk_adapter_i FOREIGN KEY (embedding_model_id) REFERENCES unstract.adapter_instance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profile_manager profile_manager_llm_id_f1cb74ee_fk_adapter_instance_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.profile_manager
    ADD CONSTRAINT profile_manager_llm_id_f1cb74ee_fk_adapter_instance_id FOREIGN KEY (llm_id) REFERENCES unstract.adapter_instance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profile_manager profile_manager_modified_by_id_aad8e97d_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.profile_manager
    ADD CONSTRAINT profile_manager_modified_by_id_aad8e97d_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profile_manager profile_manager_prompt_studio_tool_i_91d3c920_fk_custom_to; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.profile_manager
    ADD CONSTRAINT profile_manager_prompt_studio_tool_i_91d3c920_fk_custom_to FOREIGN KEY (prompt_studio_tool_id) REFERENCES unstract.custom_tool(tool_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profile_manager profile_manager_vector_store_id_5f897443_fk_adapter_instance_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.profile_manager
    ADD CONSTRAINT profile_manager_vector_store_id_5f897443_fk_adapter_instance_id FOREIGN KEY (vector_store_id) REFERENCES unstract.adapter_instance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profile_manager profile_manager_x2text_id_9567268e_fk_adapter_instance_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.profile_manager
    ADD CONSTRAINT profile_manager_x2text_id_9567268e_fk_adapter_instance_id FOREIGN KEY (x2text_id) REFERENCES unstract.adapter_instance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prompt_studio_output_manager prompt_studio_output_document_manager_id_b2858ee5_fk_document_; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_output_manager
    ADD CONSTRAINT prompt_studio_output_document_manager_id_b2858ee5_fk_document_ FOREIGN KEY (document_manager_id) REFERENCES unstract.document_manager(document_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prompt_studio_output_manager prompt_studio_output_manager_created_by_id_eb325217_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_output_manager
    ADD CONSTRAINT prompt_studio_output_manager_created_by_id_eb325217_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prompt_studio_output_manager prompt_studio_output_manager_modified_by_id_54d42f2f_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_output_manager
    ADD CONSTRAINT prompt_studio_output_manager_modified_by_id_54d42f2f_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prompt_studio_output_manager prompt_studio_output_profile_manager_id_9d4296aa_fk_profile_m; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_output_manager
    ADD CONSTRAINT prompt_studio_output_profile_manager_id_9d4296aa_fk_profile_m FOREIGN KEY (profile_manager_id) REFERENCES unstract.profile_manager(profile_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prompt_studio_output_manager prompt_studio_output_prompt_id_id_646c12f5_fk_tool_stud; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_output_manager
    ADD CONSTRAINT prompt_studio_output_prompt_id_id_646c12f5_fk_tool_stud FOREIGN KEY (prompt_id_id) REFERENCES unstract.tool_studio_prompt(prompt_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prompt_studio_output_manager prompt_studio_output_tool_id_id_05fcbbe3_fk_custom_to; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_output_manager
    ADD CONSTRAINT prompt_studio_output_tool_id_id_05fcbbe3_fk_custom_to FOREIGN KEY (tool_id_id) REFERENCES unstract.custom_tool(tool_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prompt_studio_registry prompt_studio_regist_custom_tool_id_615bbfd7_fk_custom_to; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_registry
    ADD CONSTRAINT prompt_studio_regist_custom_tool_id_615bbfd7_fk_custom_to FOREIGN KEY (custom_tool_id) REFERENCES unstract.custom_tool(tool_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prompt_studio_registry prompt_studio_regist_organization_id_f610bb27_fk_organizat; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_registry
    ADD CONSTRAINT prompt_studio_regist_organization_id_f610bb27_fk_organizat FOREIGN KEY (organization_id) REFERENCES unstract.organization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prompt_studio_registry_shared_users prompt_studio_regist_promptstudioregistry_8b008e8b_fk_prompt_st; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_registry_shared_users
    ADD CONSTRAINT prompt_studio_regist_promptstudioregistry_8b008e8b_fk_prompt_st FOREIGN KEY (promptstudioregistry_id) REFERENCES unstract.prompt_studio_registry(prompt_registry_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prompt_studio_registry prompt_studio_registry_created_by_id_a1bc7ecf_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_registry
    ADD CONSTRAINT prompt_studio_registry_created_by_id_a1bc7ecf_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prompt_studio_registry prompt_studio_registry_modified_by_id_8cf53126_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_registry
    ADD CONSTRAINT prompt_studio_registry_modified_by_id_8cf53126_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prompt_studio_registry_shared_users prompt_studio_registry_shared_users_user_id_48bd909b_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.prompt_studio_registry_shared_users
    ADD CONSTRAINT prompt_studio_registry_shared_users_user_id_48bd909b_fk_user_id FOREIGN KEY (user_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_user_id_17d28448_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_user_id_17d28448_fk_user_id FOREIGN KEY (user_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tag tag_organization_id_9181f8bb_fk_organization_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.tag
    ADD CONSTRAINT tag_organization_id_9181f8bb_fk_organization_id FOREIGN KEY (organization_id) REFERENCES unstract.organization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tool_instance tool_instance_created_by_id_3b033ad8_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.tool_instance
    ADD CONSTRAINT tool_instance_created_by_id_3b033ad8_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tool_instance tool_instance_modified_by_id_a9b8c906_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.tool_instance
    ADD CONSTRAINT tool_instance_modified_by_id_a9b8c906_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tool_instance tool_instance_workflow_id_ab81425d_fk_workflow_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.tool_instance
    ADD CONSTRAINT tool_instance_workflow_id_ab81425d_fk_workflow_id FOREIGN KEY (workflow_id) REFERENCES unstract.workflow(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tool_studio_prompt tool_studio_prompt_created_by_id_1c1817fe_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.tool_studio_prompt
    ADD CONSTRAINT tool_studio_prompt_created_by_id_1c1817fe_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tool_studio_prompt tool_studio_prompt_modified_by_id_618eb1bb_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.tool_studio_prompt
    ADD CONSTRAINT tool_studio_prompt_modified_by_id_618eb1bb_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tool_studio_prompt tool_studio_prompt_profile_manager_id_ae621291_fk_profile_m; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.tool_studio_prompt
    ADD CONSTRAINT tool_studio_prompt_profile_manager_id_ae621291_fk_profile_m FOREIGN KEY (profile_manager_id) REFERENCES unstract.profile_manager(profile_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tool_studio_prompt tool_studio_prompt_tool_id_id_c4fb4829_fk_custom_tool_tool_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.tool_studio_prompt
    ADD CONSTRAINT tool_studio_prompt_tool_id_id_c4fb4829_fk_custom_tool_tool_id FOREIGN KEY (tool_id_id) REFERENCES unstract.custom_tool(tool_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: usage usage_organization_id_8f526ff4_fk_organization_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.usage
    ADD CONSTRAINT usage_organization_id_8f526ff4_fk_organization_id FOREIGN KEY (organization_id) REFERENCES unstract.organization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user user_created_by_id_7fed2b0e_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract."user"
    ADD CONSTRAINT user_created_by_id_7fed2b0e_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_groups user_groups_group_id_b76f8aba_fk_auth_group_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.user_groups
    ADD CONSTRAINT user_groups_group_id_b76f8aba_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES unstract.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_groups user_groups_user_id_abaea130_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.user_groups
    ADD CONSTRAINT user_groups_user_id_abaea130_fk_user_id FOREIGN KEY (user_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user user_modified_by_id_6c8b494e_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract."user"
    ADD CONSTRAINT user_modified_by_id_6c8b494e_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_user_permissions user_user_permission_permission_id_9deb68a3_fk_auth_perm; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.user_user_permissions
    ADD CONSTRAINT user_user_permission_permission_id_9deb68a3_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES unstract.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_user_permissions user_user_permissions_user_id_ed4a47ea_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.user_user_permissions
    ADD CONSTRAINT user_user_permissions_user_id_ed4a47ea_fk_user_id FOREIGN KEY (user_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: workflow workflow_created_by_id_f4342385_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow
    ADD CONSTRAINT workflow_created_by_id_f4342385_fk_user_id FOREIGN KEY (created_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: workflow_endpoints workflow_endpoints_connector_instance_i_59df0598_fk_connector; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_endpoints
    ADD CONSTRAINT workflow_endpoints_connector_instance_i_59df0598_fk_connector FOREIGN KEY (connector_instance_id) REFERENCES unstract.connector_instance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: workflow_endpoints workflow_endpoints_workflow_id_dc62f4a5_fk_workflow_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_endpoints
    ADD CONSTRAINT workflow_endpoints_workflow_id_dc62f4a5_fk_workflow_id FOREIGN KEY (workflow_id) REFERENCES unstract.workflow(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: workflow_execution_tags workflow_execution_t_workflowexecution_id_1d4e2d20_fk_workflow_; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_execution_tags
    ADD CONSTRAINT workflow_execution_t_workflowexecution_id_1d4e2d20_fk_workflow_ FOREIGN KEY (workflowexecution_id) REFERENCES unstract.workflow_execution(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: workflow_execution_tags workflow_execution_tags_tag_id_7717f64c_fk_tag_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_execution_tags
    ADD CONSTRAINT workflow_execution_tags_tag_id_7717f64c_fk_tag_id FOREIGN KEY (tag_id) REFERENCES unstract.tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: workflow_execution workflow_execution_workflow_id_53557214_fk_workflow_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_execution
    ADD CONSTRAINT workflow_execution_workflow_id_53557214_fk_workflow_id FOREIGN KEY (workflow_id) REFERENCES unstract.workflow(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: workflow_file_execution workflow_file_execut_workflow_execution_i_9a8e3880_fk_workflow_; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_file_execution
    ADD CONSTRAINT workflow_file_execut_workflow_execution_i_9a8e3880_fk_workflow_ FOREIGN KEY (workflow_execution_id) REFERENCES unstract.workflow_execution(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: workflow workflow_modified_by_id_6763e6ef_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow
    ADD CONSTRAINT workflow_modified_by_id_6763e6ef_fk_user_id FOREIGN KEY (modified_by_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: workflow workflow_organization_id_99e92910_fk_organization_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow
    ADD CONSTRAINT workflow_organization_id_99e92910_fk_organization_id FOREIGN KEY (organization_id) REFERENCES unstract.organization(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: workflow_shared_users workflow_shared_users_user_id_28f13cce_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_shared_users
    ADD CONSTRAINT workflow_shared_users_user_id_28f13cce_fk_user_id FOREIGN KEY (user_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: workflow_shared_users workflow_shared_users_workflow_id_d650c47b_fk_workflow_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow_shared_users
    ADD CONSTRAINT workflow_shared_users_workflow_id_d650c47b_fk_workflow_id FOREIGN KEY (workflow_id) REFERENCES unstract.workflow(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: workflow workflow_workflow_owner_id_dcc410b4_fk_user_id; Type: FK CONSTRAINT; Schema: unstract; Owner: unstract_dev
--

ALTER TABLE ONLY unstract.workflow
    ADD CONSTRAINT workflow_workflow_owner_id_dcc410b4_fk_user_id FOREIGN KEY (workflow_owner_id) REFERENCES unstract."user"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\unrestrict GxduvG7mMorzP83Kfd17Lef9o0B9bluh7LlYonzCZSM8uFqHXLugNE1b3rrZoxW

