insert into
    public.app (app_name, app_desc)
values
    ('app_1', 'app_1'),
    ('app_2', 'app_2'),
    ('app_3', 'app_3'),
    ('app_4', 'app_4');

insert into
    public."user"
values
    (1),
    (2),
    (3);

insert into
    public.device (device_id)
values
    ('device_id_1'),
    ('device_id_2'),
    ('device_id_3');

insert into
    public."session" (session_id, device_id)
values
    ('session_id_0', 'device_id_1'),
    ('session_id_1', 'device_id_1'),
    ('session_id_2', 'device_id_1'),
    ('session_id_3', 'device_id_1'),
    ('session_id_4', 'device_id_2'),
    ('session_id_5', 'device_id_2'),
    ('session_id_6', 'device_id_3');

INSERT INTO
    public.asr_audio_stream_info (
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
        1,
        'device_id_1',
        'session_id_0',
        1,
        1,
        '2020-12-25 10:00:00.000',
        '2020-12-25 11:00:00.000',
        500
    ),
    (
        1,
        'device_id_1',
        'session_id_0',
        2,
        1,
        '2020-12-26 10:00:00.000',
        '2020-12-26 11:00:00.000',
        1000
    ),
    (
        1,
        'device_id_1',
        'session_id_0',
        3,
        1,
        '2020-12-27 10:00:00.000',
        '2020-12-27 11:00:00.000',
        500
    ),
    (
        1,
        'device_id_1',
        'session_id_0',
        4,
        1,
        '2020-12-28 10:00:00.000',
        '2020-12-28 11:00:00.000',
        1000
    ),
    (
        1,
        'device_id_1',
        'session_id_0',
        5,
        1,
        '2020-12-29 10:00:00.000',
        '2020-12-29 11:00:00.000',
        500
    ),
    (
        1,
        'device_id_1',
        'session_id_0',
        6,
        1,
        '2020-12-30 10:00:00.000',
        '2020-12-30 11:00:00.000',
        1000
    ),
    (
        1,
        'device_id_1',
        'session_id_1',
        1,
        1,
        '2021-01-01 10:00:00.000',
        '2021-01-01 11:00:00.000',
        500
    ),
    (
        1,
        'device_id_1',
        'session_id_1',
        2,
        1,
        '2021-01-01 11:00:00.000',
        '2021-01-01 12:00:00.000',
        1000
    ),
    (
        1,
        'device_id_1',
        'session_id_1',
        3,
        1,
        '2021-01-01 12:00:00.000',
        '2021-01-01 13:00:00.000',
        1500
    ),
    (
        1,
        'device_id_1',
        'session_id_1',
        4,
        1,
        '2021-01-01 13:00:00.000',
        '2021-01-01 14:00:00.000',
        2000
    ),
    (
        1,
        'device_id_1',
        'session_id_2',
        1,
        2,
        '2021-01-04 13:00:00.000',
        '2021-01-04 14:00:00.000',
        10
    ),
    (
        1,
        'device_id_1',
        'session_id_3',
        1,
        2,
        '2021-01-05 00:00:00.000',
        '2021-01-05 01:00:00.000',
        10000
    ),
    (
        2,
        'device_id_2',
        'session_id_4',
        1,
        1,
        '2021-01-01 00:00:00.000',
        '2021-01-01 01:00:00.000',
        100
    ),
    (
        2,
        'device_id_2',
        'session_id_4',
        2,
        1,
        '2021-01-04 02:00:00.000',
        '2021-01-04 20:00:00.000',
        20000
    ),
    (
        2,
        'device_id_2',
        'session_id_5',
        1,
        1,
        '2021-01-04 22:00:00.000',
        '2021-01-05 00:00:00.000',
        1000
    ),
    (
        3,
        'device_id_3',
        'session_id_6',
        1,
        1,
        '2021-01-05 00:00:00.000',
        '2021-01-05 00:30:00.000',
        1000
    );