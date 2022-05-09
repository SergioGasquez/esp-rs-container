FROM debian:bullseye-slim
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ARG CONTAINER_USER=esp
ARG CONTAINER_GROUP=esp
ARG NIGHTLY_VERSION=nightly-2022-03-10
ARG ESP_IDF_VERSION=release/v4.4
ARG ESP_BOARD=esp32c3
RUN apt-get update \
    && apt-get install -y git curl gcc clang ninja-build libudev-dev \
    python3 python3-pip libusb-1.0-0 libssl-dev pkg-config libtinfo5  \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts \
    && pip3 install websockets==10.2
RUN adduser --disabled-password --gecos "" ${CONTAINER_USER}
USER ${CONTAINER_USER}
WORKDIR /home/${CONTAINER_USER}
ENV PATH=${PATH}:$HOME/.cargo/bin
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- \
    --default-toolchain ${NIGHTLY_VERSION} -y --profile minimal\
    && $HOME/.cargo/bin/rustup component add rust-src --toolchain ${NIGHTLY_VERSION} \
    && $HOME/.cargo/bin/rustup target add riscv32i-unknown-none-elf \
    && $HOME/.cargo/bin/cargo install cargo-generate cargo-espflash espmonitor bindgen ldproxy
RUN mkdir -p .espressif/frameworks/ \
    && git clone --branch ${ESP_IDF_VERSION} -q --depth 1 --shallow-submodules \
    --recursive https://github.com/espressif/esp-idf.git \
    .espressif/frameworks/esp-idf-v4.4 \
    && python3 .espressif/frameworks/esp-idf-v4.4/tools/idf_tools.py install cmake \
    && .espressif/frameworks/esp-idf-v4.4/install.sh ${ESP_BOARD} \
    && rm -rf .espressif/dist \
    && rm -rf .espressif/frameworks/esp-idf-v4.4/docs \
    && rm -rf .espressif/frameworks/esp-idf-v4.4/examples \
    && rm -rf .espressif/frameworks/esp-idf-v4.4/tools/esp_app_trace \
    && rm -rf .espressif/frameworks/esp-idf-v4.4/tools/test_idf_size
ENV IDF_TOOLS_PATH=/home/${CONTAINER_USER}/.espressif
RUN echo "source /home/${CONTAINER_USER}/.espressif/frameworks/esp-idf-v4.4/export.sh > /dev/null 2>&1" >> ~/.bashrc
# In order to have dependencies pre-fecthed please, uncoment this section:
# RUN git clone https://github.com/ferrous-systems/espressif-trainings.git && \
#     # Hardware Check
#     cd $HOME/espressif-trainings/intro/hardware-check && \
#     $HOME/.cargo/bin/cargo fetch && \
#     $HOME/.cargo/bin/cargo build && \
#     $HOME/.cargo/bin/cargo clean && \
#     # Http Client
#     cd $HOME/espressif-trainings/intro/http-client/exercise && \
#     $HOME/.cargo/bin/cargo fetch && \
#     cd $HOME/espressif-trainings/intro/http-client/solution && \
#     $HOME/.cargo/bin/cargo fetch && \
#     # Http Server
#     cd $HOME/espressif-trainings/intro/http-server/exercise && \
#     $HOME/.cargo/bin/cargo fetch && \
#     cd $HOME/espressif-trainings/intro/http-server/solution && \
#     $HOME/.cargo/bin/cargo fetch && \
#     # MQTT
#     cd $HOME/espressif-trainings/intro/mqtt/exercise && \
#     $HOME/.cargo/bin/cargo fetch && \
#     cd $HOME/espressif-trainings/intro/mqtt/solution && \
#     $HOME/.cargo/bin/cargo fetch && \
#     cd $HOME/espressif-trainings/intro/mqtt/host-client && \
#     $HOME/.cargo/bin/cargo fetch && \
#      # Button Interrupt
#     cd $HOME/espressif-trainings/advanced/button-interrupt/exercise && \
#     $HOME/.cargo/bin/cargo fetch && \
#     cd $HOME/espressif-trainings/advanced/button-interrupt/solution && \
#     $HOME/.cargo/bin/cargo fetch && \
#     # I2C Driver
#     cd $HOME/espressif-trainings/advanced/i2c-driver/solution && \
#     $HOME/.cargo/bin/cargo fetch && \
#     # I2C Sensor Reading
#     cd $HOME/espressif-trainings/advanced/i2c-sensor-reading/solution && \
#     $HOME/.cargo/bin/cargo fetch && \
#     # Delete the repository
#     rm -rf $HOME/espressif-trainings
CMD "/bin/bash"