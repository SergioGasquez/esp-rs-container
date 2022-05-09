# Uses one of the base dockerfiles and installs an esp-idf version
# for the desired board (or all)

# Base image
ARG BASE_DOCKERFILE
FROM sergiogasquez/esp-rs-env:${BASE_DOCKERFILE}
# Arguments
ARG CONTAINER_USER=esp
ARG ESP_IDF_VERSION=release/v4.4
ARG ESP_BOARD=all
# Set user
USER ${CONTAINER_USER}
# Install ESP-IDF
RUN mkdir -p .espressif/frameworks/ \
    && git clone --branch ${ESP_IDF_VERSION} --depth 1 --shallow-submodules \
    --recursive https://github.com/espressif/esp-idf.git \
    .espressif/frameworks/esp-idf-v4.4 \
    && python3 .espressif/frameworks/esp-idf-v4.4/tools/idf_tools.py install cmake \
    && .espressif/frameworks/esp-idf-v4.4/install.sh ${ESP_BOARD} \
    && rm -rf .espressif/dist \
    && rm -rf .espressif/frameworks/esp-idf-v4.4/docs \
    && rm -rf .espressif/frameworks/esp-idf-v4.4/examples \
    && rm -rf .espressif/frameworks/esp-idf-v4.4/tools/esp_app_trace \
    && rm -rf .espressif/frameworks/esp-idf-v4.4/tools/test_idf_size
# Activate ESP-IDF environment
ENV IDF_TOOLS_PATH=/home/${CONTAINER_USER}/.espressif
RUN echo "source /home/${CONTAINER_USER}/.espressif/frameworks/esp-idf-v4.4/export.sh > /dev/null 2>&1" >> ~/.bashrc