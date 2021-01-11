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
