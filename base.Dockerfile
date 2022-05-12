# Installs both available toolchains for Rust in ESP boards: nightly and esp

# Base image
ARG VARIANT=bullseye-slim
FROM debian:${VARIANT}
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
# Arguments
ARG CONTAINER_USER=esp
ARG CONTAINER_GROUP=esp
ARG NIGHTLY_TOOLCHAIN_VERSION=nightly
ARG XTENSA_TOOLCHAIN_VERSION=1.59.0.1
# Install dependencies
RUN apt-get update \
    && apt-get install -y git curl gcc clang ninja-build unzip xz-utils libudev-dev \
    python3 python3-pip libusb-1.0-0 libssl-dev pkg-config libtinfo5  libpython2.7 \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts
# Set user
RUN adduser --disabled-password --gecos "" ${CONTAINER_USER}
USER ${CONTAINER_USER}
WORKDIR /home/${CONTAINER_USER}
# Install esp-rs/rust toolchain with extra crates
ENV PATH=${PATH}:/home/${CONTAINER_USER}/.cargo/bin:/home/${CONTAINER_USER}/opt/bin
ADD --chown=${CONTAINER_USER}:${CONTAINER_GROUP} \
    https://github.com/esp-rs/rust-build/releases/download/v${XTENSA_TOOLCHAIN_VERSION}/install-rust-toolchain.sh \
    /home/${CONTAINER_USER}/install-rust-toolchain.sh
RUN chmod a+x install-rust-toolchain.sh \
    && ./install-rust-toolchain.sh \
    --extra-crates "ldproxy cargo-generate cargo-espflash espmonitor" \
    --clear-cache "YES" --export-file /home/${CONTAINER_USER}/export-rust.sh
# Install nightly toolchain version
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- \
    --default-toolchain ${NIGHTLY_TOOLCHAIN_VERSION} -y --profile minimal\
    && $HOME/.cargo/bin/rustup component add rust-src --toolchain ${NIGHTLY_TOOLCHAIN_VERSION} \
    && $HOME/.cargo/bin/rustup target add riscv32i-unknown-none-elf
RUN echo "source /home/${CONTAINER_USER}/export-rust.sh > /dev/null 2>&1" >> ~/.bashrc