# [Choice] Go version (use -bullseye variants on local arm64/Apple Silicon): 1, 1.16, 1.17, 1-bullseye, 1.16-bullseye, 1.17-bullseye, 1-buster, 1.16-buster, 1.17-buster
ARG VARIANT="1.18"
FROM golang:${VARIANT}
LABEL maintainer="williamyao <williamyao@boyaa.com>"

ARG CHANGE_SOURCE=false
RUN if [ ${CHANGE_SOURCE} = true ]; then \
    cp /etc/apt/sources.list /etc/apt/sources.list.back \
    && sed -i "s@http://\(deb\|security\).debian.org@https://mirrors.163.com@g" /etc/apt/sources.list \
;fi

ENV TZ="Asia/Shanghai" \
    LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"

# init
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    vim \
    curl \
    wget \
    zip \
    git \
    unzip \
    less \
    lsof \
    telnet \
    net-tools \
    zsh \
    locales \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen

# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && chsh -s `which zsh`

# install protobuf
ARG PROTOBUFF_VERSION=3.17.3
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUFF_VERSION}/protoc-${PROTOBUFF_VERSION}-linux-x86_64.zip -O protoc.zip \
    && unzip protoc.zip -d /usr/local/protoc \
    && rm -r protoc.zip

# install protoc-gen-go
ARG PROTO_GEN_GO_VERSION=1.28.0
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v${PROTO_GEN_GO_VERSION}
