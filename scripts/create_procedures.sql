SET search_path TO public;

CREATE OR REPLACE PROCEDURE upsert_device (device_id varchar)
LANGUAGE SQL
AS $$
    INSERT INTO "device" (device_id)
        VALUES (device_id)
    ON CONFLICT (device_id)
        DO UPDATE SET
            last_play_time = NOW();
$$;

CREATE OR REPLACE PROCEDURE upsert_session (session_id varchar, device_id varchar)
LANGUAGE SQL
AS $$
    INSERT INTO "session" (session_id, device_id)
        VALUES (session_id, device_id)
    ON CONFLICT (session_id)
        DO UPDATE SET
            session_end = NOW();
$$;

CREATE OR REPLACE PROCEDURE insert_audio_stream_prediction (user_id integer, device_id varchar(64), session_id varchar, seq_id integer, app_id integer, pred_timestamp timestamp with time zone, input_word varchar, return_text varchar)
LANGUAGE SQL
AS $$
    CALL upsert_device (device_id);
        CALL upsert_session (session_id, device_id);
    INSERT INTO "asr_audio_stream_prediction" (user_id, device_id, session_id, seq_id, app_id, pred_timestamp, input_word, return_text)
        VALUES (user_id, device_id, session_id, seq_id, app_id, pred_timestamp, input_word, return_text);
$$;

CREATE OR REPLACE PROCEDURE insert_audio_stream_info (user_id integer, device_id varchar(64), session_id varchar, seq_id integer, app_id integer, proc_start_time timestamp with time zone, proc_end_time timestamp with time zone, stream_duration bigint)
LANGUAGE SQL
AS $$
    CALL upsert_device (device_id);
        CALL upsert_session (session_id, device_id);
    INSERT INTO "asr_audio_stream_info" (user_id, device_id, session_id, seq_id, app_id, proc_start_time, proc_end_time, stream_duration)
        VALUES (user_id, device_id, session_id, seq_id, app_id, proc_start_time, proc_end_time, stream_duration);
$$;

CREATE OR REPLACE PROCEDURE update_audio_stream_prediction (session_id varchar, seq_id integer, user_id integer DEFAULT NULL, device_id varchar(64) DEFAULT NULL, app_id integer DEFAULT NULL, pred_timestamp timestamp with time zone DEFAULT NULL, input_word varchar DEFAULT NULL, return_text varchar DEFAULT NULL)
LANGUAGE SQL
AS $$
    UPDATE
        "asr_audio_stream_prediction"
    SET
        user_id = COALESCE(update_audio_stream_prediction.user_id, "asr_audio_stream_prediction".user_id),
        device_id = COALESCE(update_audio_stream_prediction.device_id, "asr_audio_stream_prediction".device_id),
        app_id = COALESCE(update_audio_stream_prediction.app_id, "asr_audio_stream_prediction".app_id),
        pred_timestamp = COALESCE(update_audio_stream_prediction.pred_timestamp, "asr_audio_stream_prediction".pred_timestamp),
        input_word = COALESCE(update_audio_stream_prediction.input_word, "asr_audio_stream_prediction".input_word),
        return_text = COALESCE(update_audio_stream_prediction.return_text, "asr_audio_stream_prediction".return_text)
    WHERE
        "asr_audio_stream_prediction".session_id = update_audio_stream_prediction.session_id
        AND "asr_audio_stream_prediction".seq_id = update_audio_stream_prediction.seq_id;
$$;

CREATE OR REPLACE PROCEDURE update_audio_stream_info (session_id varchar, seq_id integer, user_id integer DEFAULT NULL, device_id varchar(64) DEFAULT NULL, app_id integer DEFAULT NULL, proc_start_time timestamp with time zone DEFAULT NULL, proc_end_time timestamp with time zone DEFAULT NULL, stream_duration bigint DEFAULT NULL)
LANGUAGE SQL
AS $$
    UPDATE
        "asr_audio_stream_info"
    SET
        user_id = COALESCE(update_audio_stream_info.user_id, "asr_audio_stream_info".user_id),
        device_id = COALESCE(update_audio_stream_info.device_id, "asr_audio_stream_info".device_id),
        app_id = COALESCE(update_audio_stream_info.app_id, "asr_audio_stream_info".app_id),
        proc_start_time = COALESCE(update_audio_stream_info.proc_start_time, "asr_audio_stream_info".proc_start_time),
        proc_end_time = COALESCE(update_audio_stream_info.proc_end_time, "asr_audio_stream_info".proc_end_time),
        stream_duration = COALESCE(update_audio_stream_info.stream_duration, "asr_audio_stream_info".stream_duration)
    WHERE
        "asr_audio_stream_info".session_id = update_audio_stream_info.session_id
        AND "asr_audio_stream_info".seq_id = update_audio_stream_info.seq_id;
$$;

CREATE OR REPLACE FUNCTION is_user (username varchar, "password" varchar)
    RETURNS boolean
    LANGUAGE SQL
    AS $$
    SELECT
        EXISTS (
            SELECT
                user_id
            FROM
                "user"
            WHERE
                "user".username = is_user.username
                AND "user"."password" = crypt(is_user.password, "user"."password"));
$$;

