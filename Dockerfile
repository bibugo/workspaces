FROM node:lts-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN set -eu \
    && apk update \
    && apk add --no-cache \
        git \
        doas \
    && echo 'node:node' | chpasswd \
    && echo 'permit persist :node as root' > /etc/doas.d/doas.conf \
    && npm i nodemon -g \
    && mkdir -p ${HOME}/workspaces

USER node

ARG WORKDIR_SUB EXPOSE_PORT
WORKDIR ${HOME}/workspaces/${WORKDIR_SUB:-app}
EXPOSE ${EXPOSE_PORT:-5173}
