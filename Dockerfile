ARG BASE_DOCKERFILE
FROM sergiogasquez/esp-rs-env:${BASE_DOCKERFILE}
USER vscode
ENV USER=vscode
ENV ESP_IDF_TOOLS_INSTALL_DIR=global
ARG ESP_IDF_VER
ARG ESP_IDF_BRANCH
ENV ESP_IDF_VER=${ESP_IDF_VER}
ENV ESP_IDF_BRANCH=${ESP_IDF_BRANCH}
RUN git clone --recursive --depth 1 --shallow-submodules -b ${ESP_IDF_BRANCH} \
    https://github.com/espressif/esp-idf.git /home/vscode/esp-idf
ARG ESP_BOARD
ENV ESP_BOARD=${ESP_BOARD}
RUN /home/vscode/esp-idf/install.sh ${ESP_BOARD}
ENV IDF_PATH=/home/vscode/esp-idf
RUN echo source /home/vscode/esp-idf/export.sh >> ~/.bashrc
RUN echo export IDF_PYTHON_ENV_PATH=/home/vscode/.local/bin >> ~/.bashrc