-- drop tables 
DROP TABLE IF EXISTS public."asr_prediction";
DROP TABLE IF EXISTS public."session";
DROP TABLE IF EXISTS public."device";
DROP TABLE IF EXISTS public."app";


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

CREATE INDEX ix_last_play_time ON public.device USING btree (last_smile_time);
CREATE INDEX ix_device_start_time ON public.device USING btree (start_time);


-- public."session" definition

CREATE TABLE public."session" (
	session_id VARCHAR(100) NOT NULL,
	device_id VARCHAR(64),
	session_start TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
	session_end TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
	PRIMARY KEY (session_id),
	FOREIGN KEY(device_id) REFERENCES device (device_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX ix_session_device_id ON public.session USING btree (device_id);
CREATE INDEX ix_session_session_end ON public.session USING btree (session_end);
CREATE INDEX ix_session_session_start ON public.session USING btree (session_start);


-- public.asr_prediction definition

CREATE TABLE public."asr_prediction" (
	asr_prediction_id SERIAL NOT NULL,
	session_id VARCHAR, 
	app_id INTEGER NOT NULL, 
	input_audio BYTEA NOT NULL, 
	receive_time TIMESTAMP WITH TIME ZONE NOT NULL,
	end_time TIMESTAMP WITH TIME ZONE NOT NULL,
	prediction VARCHAR, 
	PRIMARY KEY (asr_prediction_id), 
	FOREIGN KEY(session_id) REFERENCES session (session_id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(app_id) REFERENCES app (app_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX ix_asr_prediction_app_id ON public.asr_prediction USING btree (app_id);
CREATE INDEX ix_asr_prediction_receive_time ON public.asr_prediction USING btree (receive_time);
CREATE INDEX ix_asr_prediction_end_time ON public.asr_prediction USING btree (end_time);
CREATE INDEX ix_asr_prediction_session_id ON public.asr_prediction USING btree (session_id);
