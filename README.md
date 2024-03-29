# CNY DB Scripts

Scripts to create and setup database for CNY project.

## Run PostgreSQL using Docker

```bash
$ # Running db wih volume mounted for staging purposes
$ docker run --rm -p 5432:5432 --name postgres \
    -v /data/kianboon/staging:/var/lib/postgresql/data \
    --network ai_3 -e POSTGRES_PASSWORD=password -d postgres
$ docker stop postgres
```

## Create Database, Tables and Stored Procedures

### 1. Using `psql`

```bash
$ PGPASSWORD=password psql -U postgres -h localhost -f scripts/create_db.sql
$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3_staging -f scripts/create_tables.sql
$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3 -f scripts/create_tables.sql
$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3_staging -f scripts/create_procedures.sql
$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3 -f scripts/create_procedures.sql
```

### 2. Using interactive shell into the container

```bash
$ docker exec -it postgres /bin/bash
root@container:/$ apt-get update && apt-get install git
root@container:/$ git clone git@github.com:AI3SW/cny_db_scripts.git
root@container:/$ PGPASSWORD=password psql -U postgres -h localhost -f cny_db_scripts/scripts/create_db.sql
root@container:/$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3_staging -f cny_db_scripts/scripts/create_tables.sql
root@container:/$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3 -f cny_db_scripts/scripts/create_tables.sql
root@container:/$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3_staging -f cny_db_scripts/scripts/create_procedures.sql
root@container:/$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3 -f cny_db_scripts/scripts/create_procedures.sql
```

## Seed Staging Database

```bash
$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3_staging -f scripts/seed_mock_data.sql
```

## Seed Playback Table for Testing purposes

```bash
$ # Simple Test
$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3_staging -f scripts/seed_simple_playback.sql

$ # Mock Game Session
$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3_staging -f scripts/seed_mock_session_playback.sql
```

## TODO

* only upsert_device device or session in `insert_audio_stream_prediction` or `insert_audio_stream_info`, not both

```sql
CALL public.upsert_device(device_id);
CALL public.upsert_session(session_id, device_id);
```
