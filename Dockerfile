# Uses one of the base dockerfiles and installs the an esp-idf version
# for the desired board (or all)
ARG BASE_DOCKERFILE
FROM sergiogasquez/esp-rs-env:${BASE_DOCKERFILE}
# Set user
ARG CONTAINER_USER=esp
USER ${CONTAINER_USER}
# Set enviroment variables
ENV ESP_IDF_TOOLS_INSTALL_DIR=global
ARG ESP_IDF_VER
ARG ESP_IDF_BRANCH
ARG ESP_BOARD
ENV ESP_BOARD=${ESP_BOARD}
ENV ESP_IDF_VER=${ESP_IDF_VER}
ENV ESP_IDF_VERSION=${ESP_IDF_BRANCH}
ENV ESP_IDF_BRANCH=${ESP_IDF_BRANCH}
# Clone and install esp-idf
RUN git clone --recursive --depth 1 --shallow-submodules -b ${ESP_IDF_BRANCH} \
    https://github.com/espressif/esp-idf.git $HOME/esp-idf
RUN $HOME/esp-idf/install.sh ${ESP_BOARD}
# Set enviroment variables
ENV IDF_PATH=$HOME/esp-idf
RUN echo export IDF_PYTHON_ENV_PATH=$HOME/.local/bin >> ~/.bashrc