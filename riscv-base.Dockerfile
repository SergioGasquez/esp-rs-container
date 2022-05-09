# Installs Rust nightly toolchain and sets it to be used with RiscV ESP targets (esp32c3)

# Base image
ARG VARIANT=bullseye
FROM debian:${VARIANT}
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
# Arguments
ARG CONTAINER_USER=esp
ARG CONTAINER_GROUP=esp
ARG NIGHTLY_TOOLCHAIN_VERSION=nightly
# Install dependencies
RUN apt-get update \
    && apt-get install -y vim nano git curl gcc ninja-build libudev-dev \
    python3 python3-pip libusb-1.0-0 libssl-dev pkg-config libtinfo5 clang \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts \
    && pip3 install websockets==10.2
# Set user
RUN adduser --disabled-password --gecos "" ${CONTAINER_USER}
USER ${CONTAINER_USER}
WORKDIR /home/${CONTAINER_USER}
# Install nightly toolchain
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- \
    --default-toolchain ${NIGHTLY_TOOLCHAIN_VERSION} -y \
    && $HOME/.cargo/bin/rustup component add rust-src --toolchain ${NIGHTLY_TOOLCHAIN_VERSION} \
    && $HOME/.cargo/bin/rustup target add riscv32i-unknown-none-elf