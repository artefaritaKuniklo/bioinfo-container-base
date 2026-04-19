FROM rocker/r-ver:4.3

LABEL devcontainer.name="RCAE-Sc"
LABEL devcontainer.version="0.0.1"
LABEL devcontainer.description="R Common Analysis Environment, tuned for single-cell RNA-seq data analysis"

RUN sed -i 's@archive.ubuntu.com@mirrors.ustc.edu.cn@g' /etc/apt/sources.list && \
    sed -i 's@security.ubuntu.com@mirrors.ustc.edu.cn@g' /etc/apt/sources.list

RUN apt update && \
    apt install -y git curl wget
RUN apt install -y libzmq5 libzmq3-dev libssl-dev libcurl4-openssl-dev pkg-config zlib1g-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libwebp-dev build-essential libgit2-dev libfontconfig1-dev libuv1-dev

WORKDIR /workspace