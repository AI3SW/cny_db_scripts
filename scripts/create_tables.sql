-- set search path
SET search_path TO public;

-- drop tables
DROP TABLE IF EXISTS "asr_audio_stream_prediction";

DROP TABLE IF EXISTS "asr_audio_stream_info";

DROP TABLE IF EXISTS "session";

DROP TABLE IF EXISTS "device";

DROP TABLE IF EXISTS "app";

DROP TABLE IF EXISTS "user";

-- public."user" definition
CREATE TABLE "user" (
    user_id serial NOT NULL,
    username varchar NOT NULL,
    password varchar NOT NULL,
    PRIMARY KEY (user_id)
);

-- public.app definition
CREATE TABLE "app" (
    app_id serial NOT NULL,
    app_name varchar NOT NULL,
    app_desc varchar,
    PRIMARY KEY (app_id)
);

-- public.device definition
CREATE TABLE "device" (
    device_id varchar(64) NOT NULL,
    start_time timestamp with time zone DEFAULT NOW(),
    last_play_time timestamp with time zone,
    PRIMARY KEY (device_id)
);

CREATE INDEX ix_device_last_play_time ON device USING btree (last_play_time);

CREATE INDEX ix_device_start_time ON device USING btree (start_time);

-- public."session" definition
CREATE TABLE "session" (
    session_id varchar(100) NOT NULL,
    device_id varchar(64),
    session_start timestamp with time zone DEFAULT NOW(),
    session_end timestamp with time zone DEFAULT NOW(),
    PRIMARY KEY (session_id),
    FOREIGN KEY (device_id) REFERENCES device (device_id) ON UPDATE CASCADE
);

CREATE INDEX ix_session_device_id ON session USING btree (device_id);

CREATE INDEX ix_session_session_end ON session USING btree (session_end);

CREATE INDEX ix_session_session_start ON session USING btree (session_start);

-- public.asr_audio_stream_info definition
CREATE TABLE "asr_audio_stream_info" (
    user_id integer NOT NULL,
    device_id varchar(64),
    session_id varchar,
    seq_id integer,
    app_id integer NOT NULL,
    proc_start_time timestamp with time zone NOT NULL,
    proc_end_time timestamp with time zone NOT NULL,
    stream_duration bigint NOT NULL,
    PRIMARY KEY (session_id, seq_id),
    FOREIGN KEY (user_id) REFERENCES "user" (user_id) ON UPDATE CASCADE,
    FOREIGN KEY (device_id) REFERENCES device (device_id) ON UPDATE CASCADE,
    FOREIGN KEY (session_id) REFERENCES session (session_id) ON UPDATE CASCADE,
    FOREIGN KEY (app_id) REFERENCES app (app_id) ON UPDATE CASCADE
);

CREATE INDEX ix_asr_audio_stream_info_user_id ON asr_audio_stream_info USING btree (user_id);

CREATE INDEX ix_asr_audio_stream_info_app_id ON asr_audio_stream_info USING btree (app_id);

CREATE INDEX ix_asr_audio_stream_info_proc_start_time ON asr_audio_stream_info USING btree (proc_start_time);

CREATE INDEX ix_asr_audio_stream_info_proc_end_time ON asr_audio_stream_info USING btree (proc_end_time);

-- public.asr_audio_stream_prediction definition
CREATE TABLE "asr_audio_stream_prediction" (
    user_id integer NOT NULL,
    device_id varchar(64),
    session_id varchar,
    seq_id integer,
    app_id integer NOT NULL,
    pred_timestamp timestamp with time zone NOT NULL,
    input_word varchar NOT NULL,
    return_text varchar NOT NULL,
    PRIMARY KEY (session_id, seq_id),
    FOREIGN KEY (user_id) REFERENCES "user" (user_id) ON UPDATE CASCADE,
    FOREIGN KEY (device_id) REFERENCES device (device_id) ON UPDATE CASCADE,
    FOREIGN KEY (session_id) REFERENCES session (session_id) ON UPDATE CASCADE,
    FOREIGN KEY (app_id) REFERENCES app (app_id) ON UPDATE CASCADE
);

CREATE INDEX ix_asr_audio_stream_prediction_user_id ON asr_audio_stream_prediction USING btree (user_id);

CREATE INDEX ix_asr_audio_stream_prediction_app_id ON asr_audio_stream_prediction USING btree (app_id);

CREATE INDEX ix_asr_audio_stream_prediction_pred_timestamp ON asr_audio_stream_prediction USING btree (pred_timestamp);

-- create extension
CREATE EXTENSION IF NOT EXISTS pgcrypto;

