# AI Toolbox Database

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
root@container:/$ git clone https://github.com/kw01sg/ai_toolbox_db.git
root@container:/$ PGPASSWORD=password psql -U postgres -h localhost -f ai_toolbox_db/scripts/create_db.sql
root@container:/$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3_staging -f ai_toolbox_db/scripts/create_tables.sql
root@container:/$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3 -f ai_toolbox_db/scripts/create_tables.sql
root@container:/$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3_staging -f ai_toolbox_db/scripts/create_procedures.sql
root@container:/$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3 -f ai_toolbox_db/scripts/scripts/create_procedures.sql
```

## Seed Staging Database

```bash
$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3_staging -f scripts/seed_mock_data.sql
```
