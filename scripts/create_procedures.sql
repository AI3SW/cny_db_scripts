CREATE OR REPLACE PROCEDURE upsert_device(
    device_id VARCHAR
)
LANGUAGE SQL
AS $$
    INSERT INTO public."device" (device_id)
    VALUES (device_id)
    ON CONFLICT (device_id)
    DO UPDATE SET last_play_time = NOW();
$$;

CREATE OR REPLACE PROCEDURE upsert_session(
    session_id VARCHAR,
    device_id VARCHAR
)
LANGUAGE SQL
AS $$
    INSERT INTO public."session" (session_id, device_id)
    VALUES (session_id, device_id)
    ON CONFLICT (session_id)
    DO UPDATE SET session_end = NOW();
$$;

CREATE OR REPLACE PROCEDURE insert_audio_stream_prediction(
    user_id INTEGER,
    device_id VARCHAR(64),
    session_id VARCHAR,
    seq_id INTEGER,
    app_id INTEGER,
    pred_timestamp TIMESTAMP WITH TIME ZONE,
    input_audio BYTEA,
    input_word VARCHAR,
    return_text VARCHAR
)
LANGUAGE SQL 
AS $$
    CALL public.upsert_device(device_id);
    CALL public.upsert_session(session_id, device_id);
    INSERT INTO
        public."asr_audio_stream_prediction" (
            user_id,
            device_id,
            session_id,
            seq_id,
            app_id,
            pred_timestamp,
            input_audio,
            input_word,
            return_text
        )
    VALUES
        (
            user_id,
            device_id,
            session_id,
            seq_id,
            app_id,
            pred_timestamp,
            input_audio,
            input_word,
            return_text
        );
$$;


CREATE OR REPLACE PROCEDURE insert_audio_stream_info(
    user_id INTEGER,
    device_id VARCHAR(64),
    session_id VARCHAR,
    seq_id INTEGER,
    app_id INTEGER,
    proc_start_time TIMESTAMP WITH TIME ZONE,
    proc_end_time TIMESTAMP WITH TIME ZONE,
    stream_duration BIGINT
)
LANGUAGE SQL
AS $$
    CALL public.upsert_device(device_id);
    CALL public.upsert_session(session_id, device_id);
    INSERT INTO
        public."asr_audio_stream_info" (
            user_id,
            device_id,
            session_id,
            seq_id,
            app_id,
            proc_start_time,
            proc_end_time,
            stream_duration
        )
    VALUES
        (
            user_id,
            device_id,
            session_id,
            seq_id,
            app_id,
            proc_start_time,
            proc_end_time,
            stream_duration
        );
$$;


CREATE OR REPLACE PROCEDURE update_audio_stream_prediction(
    session_id VARCHAR,
    seq_id INTEGER,
    user_id INTEGER DEFAULT NULL,
    device_id VARCHAR(64) DEFAULT NULL,
    app_id INTEGER DEFAULT NULL,
    pred_timestamp TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    input_audio BYTEA DEFAULT NULL,
    input_word VARCHAR DEFAULT NULL,
    return_text VARCHAR DEFAULT NULL
)
LANGUAGE SQL
AS $$
    UPDATE public."asr_audio_stream_prediction"
    SET user_id = COALESCE(update_audio_stream_prediction.user_id, public."asr_audio_stream_prediction".user_id),
        device_id = COALESCE(update_audio_stream_prediction.device_id, public."asr_audio_stream_prediction".device_id),
        app_id = COALESCE(update_audio_stream_prediction.app_id, public."asr_audio_stream_prediction".app_id),
        pred_timestamp = COALESCE(update_audio_stream_prediction.pred_timestamp, public."asr_audio_stream_prediction".pred_timestamp),
        input_audio = COALESCE(update_audio_stream_prediction.input_audio, public."asr_audio_stream_prediction".input_audio),
        input_word = COALESCE(update_audio_stream_prediction.input_word, public."asr_audio_stream_prediction".input_word),
        return_text = COALESCE(update_audio_stream_prediction.return_text, public."asr_audio_stream_prediction".return_text)
WHERE public."asr_audio_stream_prediction".session_id = update_audio_stream_prediction.session_id
    AND public."asr_audio_stream_prediction".seq_id = update_audio_stream_prediction.seq_id;
$$;


CREATE OR REPLACE PROCEDURE update_audio_stream_info(
    user_id INTEGER,
    device_id VARCHAR(64),
    session_id VARCHAR,
    seq_id INTEGER,
    app_id INTEGER,
    proc_start_time TIMESTAMP WITH TIME ZONE,
    proc_end_time TIMESTAMP WITH TIME ZONE,
    stream_duration BIGINT
)
LANGUAGE SQL
AS $$
    UPDATE public."asr_audio_stream_info"
    SET user_id = COALESCE(update_audio_stream_info.user_id, public."asr_audio_stream_info".user_id),
        device_id = COALESCE(update_audio_stream_info.device_id, public."asr_audio_stream_info".device_id),
        app_id = COALESCE(update_audio_stream_info.app_id, public."asr_audio_stream_info".app_id),
        proc_start_time = COALESCE(update_audio_stream_info.proc_start_time, public."asr_audio_stream_info".proc_start_time),
        proc_end_time = COALESCE(update_audio_stream_info.proc_end_time, public."asr_audio_stream_info".proc_end_time),
        stream_duration = COALESCE(update_audio_stream_info.stream_duration, public."asr_audio_stream_info".stream_duration)
WHERE public."asr_audio_stream_info".session_id = update_audio_stream_info.session_id
    AND public."asr_audio_stream_info".seq_id = update_audio_stream_info.seq_id;
$$;
