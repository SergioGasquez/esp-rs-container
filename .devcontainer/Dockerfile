FROM mcr.microsoft.com/vscode/devcontainers/base:focal
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN apt-get update \
    && apt-get install -y vim nano git curl gcc ninja-build cmake libudev-dev python3 python3-pip libusb-1.0-0 libssl-dev \
    pkg-config libtinfo5 clang \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts
ARG USERNAME=vscode
ARG USER_UID=1001
ARG USER_GID=$USER_UID
ENV HOME=/home/$USERNAME
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly
RUN git clone https://github.com/esp-rs/rust-build.git /opt/rust-build
RUN /opt/rust-build/install-rust-toolchain.sh --extra-crates "ldproxy cargo-generate" --clear-cache "YES" --export-file /opt/export-rust.sh
ENV PATH=${PATH}:$HOME/.cargo/bin
RUN mkdir $HOME/esp-rs
RUN chown -R vscode $HOME/.cargo/
RUN chown -R vscode $HOME/.rustup/
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly
USER vscode
RUN rustup target add riscv32i-unknown-none-elf
RUN rustup component add rust-src
RUN cargo install cargo-espflash
RUN echo source /opt/export-rust.sh >> ~/.zshrc
RUN echo source /opt/export-rust.sh >> ~/.bashrc