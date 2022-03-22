FROM sergiogasquez/esp-rs-env:base
USER vscode
ENV USER=vscode
ENV ESP_IDF_TOOLS_INSTALL_DIR=global
ARG ESP_IDF_VERSION
ARG ESP_IDF_BRANCH
ENV ESP_IDF_VERSION=${ESP_IDF_VERSION}
ENV ESP_IDF_BRANCH=${ESP_IDF_BRANCH}
WORKDIR /home/vscode
RUN git clone https://github.com/espressif/esp-idf.git
WORKDIR /home/vscode/esp-idf
RUN git checkout ${ESP_IDF_BRANCH}
ENV IDF_PATH=/home/vscode/esp-idf
RUN /home/vscode/esp-idf/install.sh all
RUN echo source /home/vscode/esp-idf/export.sh >> ~/.bashrc
RUN echo export IDF_PYTHON_ENV_PATH=/home/vscode/.local/bin >> ~/.bashrc