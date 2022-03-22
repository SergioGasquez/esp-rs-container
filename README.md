# esp-rs-container
[![Docker Base Image CI](https://github.com/SergioGasquez/esp-rs-container/actions/workflows/base-image.yml/badge.svg)](https://github.com/SergioGasquez/esp-rs-container/actions/workflows/base-image.yml)
[![Docker Esp Idf Versions Images CI](https://github.com/SergioGasquez/esp-rs-container/actions/workflows/esp-idf-images.yml/badge.svg)](https://github.com/SergioGasquez/esp-rs-container/actions/workflows/esp-idf-images.yml)

This repository contains Dockerfiles that create environments, using Debian
11.2, with all the necessary tools to develop applications for
[ESP boards using Rust](https://github.com/esp-rs).

In order to use it with Visual Studio Code integration, please refer to
[esp-rs-devcontainer](https://github.com/SergioGasquez/esp-rs-devcontainer).

Using Git Hub actions, several tags will be published into the
[sergiogasquez/esp-rs-env](https://hub.docker.com/repository/docker/sergiogasquez/esp-rs-env) image:
- `latest` and `base` is be generated using `base.Dockerfile` and they will have
  all the dependencies but no prebuild esp-idf environment installed.
- `espidf_v4.4` is generated with `Dockerfile` and has
  [esp-idf v4.4](https://github.com/espressif/esp-idf/tree/release/v4.4) installed.
- `espidf_v4.3.2` is generated with `Dockerfile` and has
  [esp-idf v4.3](https://github.com/espressif/esp-idf/tree/release/v4.3) installed.
- `espidf_v5.0` and `master` is generated with `Dockerfile` and have the [master
  branch of esp-idf](https://github.com/espressif/esp-idf/tree/master) installed.
> Note that `espidf_v4.3.2` is only available for `linux/amd64` while the rest
  are available for `linux/amd64` and for `linux/arm64`.