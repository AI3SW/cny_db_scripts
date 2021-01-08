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
