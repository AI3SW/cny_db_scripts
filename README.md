# AI Toolbox Database

## Run PostgreSQL using Docker

```bash
$ # Running db wih volume mounted for staging purposes
$ docker run --rm -p 5432:5432 --name postgres \
    -v /data/kianboon/staging:/var/lib/postgresql/data \
    -e POSTGRES_PASSWORD=password -d postgres
$ docker stop postgres
```

## Create Database and Tables

### 1. Using `psql`

```bash
$ PGPASSWORD=password psql -U postgres -h localhost -f scripts/create_db.sql
$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3 -f scripts/create_tables.sql
```

### 2. Using interactive shell of the container

```bash
$ docker exec -it postgres /bin/bash
root@container:/$ apt-get update && apt-get install git
root@container:/$ https://github.com/kw01sg/ai_toolbox_db.git
root@container:/$ PGPASSWORD=password psql -U postgres -h localhost -f ai_toolbox_db/scripts/create_db.sql
root@container:/$ PGPASSWORD=password psql -U postgres -h localhost -d ai_3 -f ai_toolbox_db/scripts/create_tables.sql
```

## Seed Database

```bash
$ 
```
