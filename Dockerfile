FROM pspitzner/beets-flask:latest

WORKDIR /config

# rar support
# @see https://github.com/EDM115/unrar-alpine

RUN apk update && \
    apk add --no-cache curl jq

# ...

RUN curl -LsSf https://api.github.com/repos/EDM115/unrar-alpine/releases/latest \
    | jq -r '.assets[] | select(.name == "unrar") | .id' \
    | xargs -I {} curl -LsSf https://api.github.com/repos/EDM115/unrar-alpine/releases/assets/{} \
    | jq -r '.browser_download_url' \
    | xargs -I {} curl -Lsf {} -o /tmp/unrar && \
    install -v -m755 /tmp/unrar /usr/local/bin

# You MUST install required libraries or else you'll run into linked libraries loading issues
RUN apk add --no-cache libstdc++ libgcc

# 7z support
# @see https://beets-flask.readthedocs.io/latest/faq.html#z-support

RUN apk add gcc musl-dev linux-headers

RUN echo "py7zr" >> /config/requirements.txt

# Keyfinder plugin support
# @see https://github.com/evanpurkhiser/keyfinder-cli

RUN apk update && \
    apk add --no-cache \
        build-base \
        ffmpeg-dev \
        libkeyfinder-dev

# WIP
# RUN git clone --depth=1 https://github.com/evanpurkhiser/keyfinder-cli.git
# RUN cmake -DCMAKE_INSTALL_PREFIX=/where/you/want/to/install/to -S . -B build
