FROM debian:buster

RUN apt-get update && apt-get install -y python3 python3-pip notmuch python3-notmuch \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --trusted-host pypi.python.org gunicorn netviel

WORKDIR /app
COPY notmuch-config /app/

ENV NOTMUCH_CONFIG /app/notmuch-config
ENV PORT 8000

CMD gunicorn -b 0.0.0.0:$PORT netviel.wsgi:app
