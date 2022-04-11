# Installs Rust nightly toolchain and sets it to be used with RiscV ESP targets (esp32c3)
ARG VARIANT=bullseye
FROM debian:${VARIANT}
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
# Install dependencies
RUN apt-get update \
    && apt-get install -y vim nano git curl gcc ninja-build cmake libudev-dev \
    python3 python3-pip libusb-1.0-0 libssl-dev pkg-config libtinfo5 clang \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts
RUN pip3 install websockets==10.2
# Set vscode user
RUN adduser --disabled-password --gecos "" vscode
USER vscode
WORKDIR /home/vscode
# Install toolchain
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- \
    --default-toolchain nightly-2022-03-30 -y
# Set enviroment variables
ENV PATH=${PATH}:$HOME/.cargo/bin:$HOME/.cargo/bin
# Install components and targets
RUN $HOME/.cargo/bin/rustup component add rust-src --toolchain nightly-2022-03-30
RUN $HOME/.cargo/bin/rustup target add riscv32i-unknown-none-elf
# Install cargo tools
RUN $HOME/.cargo/bin/cargo install cargo-generate cargo-espflash espmonitor bindgen ldproxy