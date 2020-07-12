

-- Table Definition ----------------------------------------------

CREATE TABLE group (
    id uuid PRIMARY KEY,
    name character(50),
    avatar text,
    type integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);

-- Indices -------------------------------------------------------

CREATE UNIQUE INDEX group_pkey ON group(id uuid_ops);


-- Table Definition ----------------------------------------------

CREATE TABLE group_user (
    id uuid PRIMARY KEY,
    user_id uuid,
    group_id uuid,
    user_remark_name character varying(255),
    last_msg_id uuid,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);

-- Indices -------------------------------------------------------

CREATE UNIQUE INDEX group_user_pkey ON group_user(id uuid_ops);


-- Table Definition ----------------------------------------------

CREATE TABLE message (
    id uuid PRIMARY KEY,
    group_id uuid,
    sender_uid uuid,
    content text,
    type smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);

-- Indices -------------------------------------------------------

CREATE UNIQUE INDEX message_pkey ON message(id uuid_ops);


-- Table Definition ----------------------------------------------

CREATE TABLE message_status (
    id uuid PRIMARY KEY,
    msg_id uuid,
    receiver_uid uuid,
    group_id uuid,
    send_status smallint,
    read_status smallint,
    create_time timestamp without time zone,
    update_time timestamp without time zone
);

-- Indices -------------------------------------------------------

CREATE UNIQUE INDEX message_status_pkey ON message_status(id uuid_ops);

-- Table Definition ----------------------------------------------

CREATE TABLE user (
    id uuid PRIMARY KEY,
    name character(50),
    avatar text,
    online_status smallint,
    conn character(255),
    create_time timestamp without time zone,
    update_time timestamp without time zone
);

-- Indices -------------------------------------------------------

CREATE UNIQUE INDEX user_pkey ON user(id uuid_ops);
