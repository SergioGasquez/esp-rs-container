ARG VARIANT=bullseye
FROM debian:${VARIANT}
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN apt-get update \
    && apt-get install -y vim nano git curl gcc ninja-build cmake libudev-dev \
     python3 python3-pip libusb-1.0-0 libssl-dev pkg-config libtinfo5 clang \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts
RUN adduser --disabled-password --gecos "" vscode
USER vscode
WORKDIR /home/vscode
RUN git clone https://github.com/esp-rs/rust-build.git rust-build
RUN rust-build/install-rust-toolchain.sh \
    --extra-crates "ldproxy cargo-generate cargo-espflash espmonitor bindgen" \
    --clear-cache "YES" --export-file /home/vscode/export-rust.sh
RUN . ./export-rust.sh
ENV PATH=${PATH}:$HOME/.cargo/bin:$HOME/.cargo/bin
RUN echo source /home/vscode/export-rust.sh >> ~/.bashrc