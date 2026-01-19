FROM tensorchord/vchord-scratch:pg17-v1.0.0 AS vchord_scratch

FROM bitnamilegacy/postgresql:17.6.0-debian-12-r4

USER root

# Копіюємо vectorchord розширення
COPY --from=vchord_scratch /usr/lib/postgresql/*/lib/vectors.so /opt/bitnami/postgresql/lib/
COPY --from=vchord_scratch /usr/share/postgresql/*/extension/vectors* /opt/bitnami/postgresql/share/extension/

# Встановлюємо pgvector
RUN apt-get update && \
    apt-get install -y postgresql-contrib && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER 1001
