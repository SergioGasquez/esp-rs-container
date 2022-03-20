FROM sergiogasquez/esp-rs-env:base
# Test: Set global esp-idf env
USER vscode
ENV USER=vscode
ENV ESP_IDF_TOOLS_INSTALL_DIR=global
ARG ESP_IDF_VERSION
ENV ESP_IDF_VERSION=${ESP_IDF_VERSION}
RUN $HOME/.cargo/bin/cargo generate --vcs none \
    --git https://github.com/esp-rs/esp-idf-template cargo \
    --name rust-project --define mcu=esp32c3 --define toolchain=nightly \
    --define espidfver=${ESP_IDF_VERSION} --define std=true && cd rust-project \
    && $HOME/.cargo/bin/cargo espflash save-image --release test.bin \
    && rm -rf /home/vscode/workspace/rust-project