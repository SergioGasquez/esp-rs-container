# Installs Rust esp toolchain and sets it to be used with RiscV ESP targets (esp32s2, esp32s3 and esp32)
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
# Install toolchain with extra crates
RUN git clone https://github.com/esp-rs/rust-build.git rust-build
RUN rust-build/install-rust-toolchain.sh \
    --toolchain-version 1.59.0.1 \
    --extra-crates "ldproxy cargo-generate cargo-espflash espmonitor bindgen" \
    --clear-cache "YES" --export-file /home/vscode/export-rust.sh
# Set enviroment variables
RUN . ./export-rust.sh
ENV PATH=${PATH}:$HOME/.cargo/bin:$HOME/.cargo/bin
RUN echo "source /home/vscode/export-rust.sh > /dev/null" >> ~/.bashrc