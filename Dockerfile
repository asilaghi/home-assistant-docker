FROM alpine:3.8

RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    apk add --no-cache musl-dev openssl-dev python3-dev libffi-dev gcc linux-headers && \
    python3 -m pip install wheel aiohttp-cors sqlalchemy netifaces && \
    python3 -m pip install homeassistant && \
    rm -r /root/.cache || true

RUN mkdir /config

VOLUME ["/config"]

CMD hass -c /config --open-ui
