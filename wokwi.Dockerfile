# Esp Idf v4.4 enviroment with Espressif Training and example dependencies fetched
FROM sergiogasquez/esp-rs-env:espidf_v4.4
# Set user
ARG CONTAINER_USER=esp
ENV USER=${CONTAINER_USER}
USER ${CONTAINER_USER}
# Set default toolchain
ARG NIGHTLY_VERSION=nightly
RUN $HOME/.cargo/bin/rustup default ${NIGHTLY_VERSION}
# Fetch dependencies: espressif-trainings
RUN git clone https://github.com/SergioGasquez/ferrous-training.git && \
    # Hardware Check
    cd $HOME/espressif-trainings/intro/hardware-check && \
    $HOME/.cargo/bin/cargo fetch && \
    $HOME/.cargo/bin/cargo build && \
    $HOME/.cargo/bin/cargo clean && \
    # Http Client
    cd $HOME/espressif-trainings/intro/http-client/exercise && \
    $HOME/.cargo/bin/cargo fetch && \
    cd $HOME/espressif-trainings/intro/http-client/solution && \
    $HOME/.cargo/bin/cargo fetch && \
    # Http Server
    cd $HOME/espressif-trainings/intro/http-server/exercise && \
    $HOME/.cargo/bin/cargo fetch && \
    cd $HOME/espressif-trainings/intro/http-server/solution && \
    $HOME/.cargo/bin/cargo fetch && \
    # MQTT
    cd $HOME/espressif-trainings/intro/mqtt/exercise && \
    $HOME/.cargo/bin/cargo fetch && \
    cd $HOME/espressif-trainings/intro/mqtt/solution && \
    $HOME/.cargo/bin/cargo fetch && \
    cd $HOME/espressif-trainings/intro/mqtt/host-client && \
    $HOME/.cargo/bin/cargo fetch && \
    # Button Interrupt
    cd $HOME/espressif-trainings/advanced/button-interrupt/exercise && \
    $HOME/.cargo/bin/cargo fetch && \
    cd $HOME/espressif-trainings/advanced/button-interrupt/solution && \
    $HOME/.cargo/bin/cargo fetch && \
    # I2C Driver
    cd $HOME/espressif-trainings/advanced/i2c-driver/solution && \
    $HOME/.cargo/bin/cargo fetch && \
    # I2C Sensor Reading
    cd $HOME/espressif-trainings/advanced/i2c-sensor-reading/solution && \
    $HOME/.cargo/bin/cargo fetch && \
    # Delete the repository
    rm -rf $HOME/espressif-trainings
# Fetch dependencies: ESP32S3
RUN $HOME/.cargo/bin/cargo generate --vcs none --git https://github.com/esp-rs/esp-idf-template cargo --name esp32s3 --define mcu=esp32s3 --define toolchain=nightly --define espidfver=v4.4 --define std=true && \
    cd $HOME/esp32s3 && \
    $HOME/.cargo/bin/cargo +esp fetch && \
    rm -rf $HOME/esp32s3
RUN $HOME/.cargo/bin/cargo generate --vcs none --git https://github.com/esp-rs/esp-idf-template cargo --name esp32s3nostd --define mcu=esp32s3 --define toolchain=nightly --define espidfver=v4.4 --define std=false && \
    cd $HOME/esp32s3nostd && \
    $HOME/.cargo/bin/cargo +esp fetch && \
    rm -rf $HOME/esp32s3nostd
# Fetch dependencies: ESP32S2
RUN $HOME/.cargo/bin/cargo generate --vcs none --git https://github.com/esp-rs/esp-idf-template cargo --name esp32s2 --define mcu=esp32s2 --define toolchain=nightly --define espidfver=v4.4 --define std=true && \
    cd $HOME/esp32s2 && \
    $HOME/.cargo/bin/cargo +esp fetch  && \
    rm -rf $HOME/esp32s2
RUN $HOME/.cargo/bin/cargo generate --vcs none --git https://github.com/esp-rs/esp-idf-template cargo --name esp32s2nostd --define mcu=esp32s2 --define toolchain=nightly --define espidfver=v4.4 --define std=false && \
    cd $HOME/esp32s2nostd && \
    $HOME/.cargo/bin/cargo +esp fetch  && \
    rm -rf $HOME/esp32s2nostd
# Fetch dependencies: ESP32
RUN $HOME/.cargo/bin/cargo generate --vcs none --git https://github.com/esp-rs/esp-idf-template cargo --name esp32 --define mcu=esp32 --define toolchain=nightly --define espidfver=v4.4 --define std=true && \
    cd $HOME/esp32 && \
    $HOME/.cargo/bin/cargo +esp fetch  && \
    rm -rf $HOME/esp32
RUN $HOME/.cargo/bin/cargo generate --vcs none --git https://github.com/esp-rs/esp-idf-template cargo --name esp32nostd --define mcu=esp32 --define toolchain=nightly --define espidfver=v4.4 --define std=false && \
    cd $HOME/esp32nostd && \
    $HOME/.cargo/bin/cargo +esp fetch  && \
    rm -rf $HOME/esp32nostd
# Fetch dependencies: ESP32C3
RUN $HOME/.cargo/bin/cargo generate --vcs none --git https://github.com/esp-rs/esp-idf-template cargo --name esp32c3 --define mcu=esp32c3 --define toolchain=nightly --define espidfver=v4.4 --define std=true && \
    cd $HOME/esp32c3 && \
    $HOME/.cargo/bin/cargo fetch  && \
    rm -rf $HOME/esp32c3
RUN $HOME/.cargo/bin/cargo generate --vcs none --git https://github.com/esp-rs/esp-idf-template cargo --name esp32c3nostd --define mcu=esp32c3 --define toolchain=nightly --define espidfver=v4.4 --define std=false && \
    cd $HOME/esp32c3nostd && \
    $HOME/.cargo/bin/cargo fetch  && \
    rm -rf $HOME/esp32c3nostd