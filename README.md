# esp-rs-container
This repository contains a Dockerfile that creates an enviroment, using Debian
11.2, with all the neccesary tools to develop applications for
[ESP boards using Rust](https://github.com/esp-rs).

In order to use it with Visual Studio Code integration, please refer to
[esp-rs-devcontaioner](https://github.com/SergioGasquez/esp-rs-devcontainer).

Using Git Hub actions, several tags will be published into the
[sergiogasquez/esp-rs-env](https://hub.docker.com/repository/docker/sergiogasquez/esp-rs-env) image:
- `latest` and `base` will be generated using `base.Dockerfile` and they will have
  all the dependencies but no prebuild esp-idf enviroment installed.
- `espidf_v4.4` will generated with `Dockerfile` and has 
  [esp-idf v4.4](https://github.com/espressif/esp-idf/tree/release/v4.4) installed.
- `espidf_v4.3.2` will generated with `Dockerfile` and has 
  [esp-idf v4.3](https://github.com/espressif/esp-idf/tree/release/v4.3) installed.
- `espidf_v5.0` and `master` will generated with `Dockerfile` and have the [master
  branch of esp-idf](https://github.com/espressif/esp-idf/tree/master) installed.