# esp-rs-container
<div align="center">

[![Docker Base Tags CI](https://github.com/SergioGasquez/esp-rs-container/actions/workflows/base-tags.yml/badge.svg)](https://github.com/SergioGasquez/esp-rs-container/actions/workflows/base-tags.yml)
[![Docker Esp Idf Versions Tags CI](https://github.com/SergioGasquez/esp-rs-container/actions/workflows/esp-idf-tags.yml/badge.svg)](https://github.com/SergioGasquez/esp-rs-container/actions/workflows/esp-idf-tags.yml)
</div>

This repository contains Dockerfiles that create environments, using Debian
11.2, with all the necessary tools to develop applications for
[ESP boards using Rust](https://github.com/esp-rs).

In order to use it with Visual Studio Code integration, please refer to
[esp-rs-devcontainer](https://github.com/SergioGasquez/esp-rs-devcontainer).

Using Git Hub actions, several tags for `linux/amd64` and for `linux/arm64`
platforms will be published into the
[sergiogasquez/esp-rs-env](https://hub.docker.com/repository/docker/sergiogasquez/esp-rs-env) image:
- `base` is generated using `base.Dockerfile` and they will have
  all the dependencies for all the supported ESP boards but no prebuild esp-idf environment installed.
- `xtensa-base` is generated using `xtensa-base.Dockerfile` and they will have
  all the dependencies for all the Xtensa supported ESP boards but no prebuild esp-idf environment installed.
- `riscv-base` is generated using `riscv-base.Dockerfile` and they will have
  all the dependencies for all the RiscV supported ESP boards but no prebuild esp-idf environment installed.
- `espidf_v4.4` is generated from `Dockerfile` and has
  [esp-idf v4.4](https://github.com/espressif/esp-idf/tree/release/v4.4) installed.
  It can be used with all the supported ESP boards.
- `espidf_v4.3.2` is generated from `Dockerfile` and has
  [esp-idf v4.3](https://github.com/espressif/esp-idf/tree/release/v4.3) installed.
  It can be used with all the supported ESP boards.
    > _Note that `espidf_v4.3.2` is only available for `linux/amd64`._
- `espidf_v5.0` and `master` is generated from `Dockerfile` and have the [master
  branch of esp-idf](https://github.com/espressif/esp-idf/tree/master) installed.
  It can be used with all the supported ESP boards.
- `esp32` fully functional environment with
  [esp-idf v5.0](https://github.com/espressif/esp-idf/tree/master) installed for
  `esp32`.
- `esp32s2` fully functional environment with
  [esp-idf v5.0](https://github.com/espressif/esp-idf/tree/master) installed for
  `esp32s2`.
- `esp32s3` fully functional environment with
  [esp-idf v5.0](https://github.com/espressif/esp-idf/tree/master) installed for
  `esp32s3`.
- `esp32c3` fully functional environment with
  [esp-idf v5.0](https://github.com/espressif/esp-idf/tree/master) installed for
  `esp32c3`.
- `espidf_v4.4-esp32c3` fully functional environment with
  [esp-idf v4.4](https://github.com/espressif/esp-idf/tree/release/v4.4) installed for
  `esp32c3`.
- `wokwi` is generated from `espidf_v4.4` and has some dependencies fetched.