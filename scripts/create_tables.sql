-- drop tables 
DROP TABLE IF EXISTS public."asr_audio_stream_prediction";

DROP TABLE IF EXISTS public."asr_audio_stream_info";

DROP TABLE IF EXISTS public."session";

DROP TABLE IF EXISTS public."device";

DROP TABLE IF EXISTS public."app";

DROP TABLE IF EXISTS public."user";

-- public."user" definition
CREATE TABLE public."user" (
	user_id SERIAL NOT NULL,
	PRIMARY KEY (user_id)
);

-- public.app definition
CREATE TABLE public."app" (
	app_id SERIAL NOT NULL,
	app_name VARCHAR NOT NULL,
	app_desc VARCHAR,
	PRIMARY KEY (app_id)
);

-- public.device definition
CREATE TABLE public."device" (
	device_id VARCHAR(64) NOT NULL,
	start_time TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
	last_play_time TIMESTAMP WITH TIME ZONE,
	PRIMARY KEY (device_id)
);

CREATE INDEX ix_device_last_play_time ON public.device USING btree (last_play_time);

CREATE INDEX ix_device_start_time ON public.device USING btree (start_time);

-- public."session" definition
CREATE TABLE public."session" (
	session_id VARCHAR(100) NOT NULL,
	device_id VARCHAR(64),
	session_start TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
	session_end TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
	PRIMARY KEY (session_id),
	FOREIGN KEY(device_id) REFERENCES device (device_id) ON UPDATE CASCADE
);

CREATE INDEX ix_session_device_id ON public.session USING btree (device_id);

CREATE INDEX ix_session_session_end ON public.session USING btree (session_end);

CREATE INDEX ix_session_session_start ON public.session USING btree (session_start);

-- public.asr_audio_stream_info definition
CREATE TABLE public."asr_audio_stream_info" (
	user_id INTEGER NOT NULL,
	device_id VARCHAR(64),
	session_id VARCHAR,
	seq_id INTEGER,
	app_id INTEGER NOT NULL,
	proc_start_time TIMESTAMP WITH TIME ZONE NOT NULL,
	proc_end_time TIMESTAMP WITH TIME ZONE NOT NULL,
	stream_duration BIGINT NOT NULL,
	PRIMARY KEY (session_id, seq_id),
	FOREIGN KEY(user_id) REFERENCES "user" (user_id) ON UPDATE CASCADE,
	FOREIGN KEY(device_id) REFERENCES device (device_id) ON UPDATE CASCADE,
	FOREIGN KEY(session_id) REFERENCES session (session_id) ON UPDATE CASCADE,
	FOREIGN KEY(app_id) REFERENCES app (app_id) ON UPDATE CASCADE
);

CREATE INDEX ix_asr_audio_stream_info_user_id ON public.asr_audio_stream_info USING btree (user_id);

CREATE INDEX ix_asr_audio_stream_info_app_id ON public.asr_audio_stream_info USING btree (app_id);

CREATE INDEX ix_asr_audio_stream_info_proc_start_time ON public.asr_audio_stream_info USING btree (proc_start_time);

CREATE INDEX ix_asr_audio_stream_info_proc_end_time ON public.asr_audio_stream_info USING btree (proc_end_time);

-- public.asr_audio_stream_prediction definition
CREATE TABLE public."asr_audio_stream_prediction" (
	user_id INTEGER NOT NULL,
	device_id VARCHAR(64),
	session_id VARCHAR,
	seq_id INTEGER,
	app_id INTEGER NOT NULL,
	pred_timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
	input_word VARCHAR NOT NULL,
	return_text VARCHAR NOT NULL,
	PRIMARY KEY (session_id, seq_id),
	FOREIGN KEY(user_id) REFERENCES "user" (user_id) ON UPDATE CASCADE,
	FOREIGN KEY(device_id) REFERENCES device (device_id) ON UPDATE CASCADE,
	FOREIGN KEY(session_id) REFERENCES session (session_id) ON UPDATE CASCADE,
	FOREIGN KEY(app_id) REFERENCES app (app_id) ON UPDATE CASCADE
);

CREATE INDEX ix_asr_audio_stream_prediction_user_id ON public.asr_audio_stream_prediction USING btree (user_id);

CREATE INDEX ix_asr_audio_stream_prediction_app_id ON public.asr_audio_stream_prediction USING btree (app_id);

CREATE INDEX ix_asr_audio_stream_prediction_pred_timestamp ON public.asr_audio_stream_prediction USING btree (pred_timestamp);