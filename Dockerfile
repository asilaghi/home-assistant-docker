FROM alpine:3.8

RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

RUN apk add --no-cache musl-dev openssl-dev python3-dev libffi-dev gcc

RUN python3 -m pip install wheel && \
    python3 -m pip install homeassistant

RUN apk del musl-dev openssl-dev python3-dev libffi-dev gcc 

ENTRYPOINT ["hass --open-ui"]
