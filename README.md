# esp-rs-env
This repository uses Docker to offer the enviroment needed to develop applications for [ESP 
boards using Rust](https://github.com/esp-rs), it also offers integration with VsCode using [Remote - Containers](https://code.visualstudio.com/docs/remote/containers)

## Table of contents
- [esp-rs-env](#esp-rs-env)
  - [Table of contents](#table-of-contents)
  - [Quick Start](#quick-start)
  - [Create a project](#create-a-project)
  - [Build](#build)
  - [Flash](#flash)
    - [Adafruit ESPTool](#adafruit-esptool)

# Quick Start


## Create a project
`cargo generate --git https://github.com/esp-rs/esp-idf-template cargo`

## Build
`cargo espflash save-image --release image.bin`


## Flash
### [Adafruit ESPTool](https://adafruit.github.io/Adafruit_WebSerial_ESPTool/)
Default Offsets:
|             | **Bootloader** | **Partition Table** | **Application Image** |
|:-----------:|:--------------:|:-------------------:|:---------------------:|
|  **esp32**  |       0x0      |        0x8000       |        0x10000        |
| **esp32s2** |       0x0      |        0x8000       |        0x10000        |
| **esp32s3** |       0x0      |        0x8000       |        0x10000        |
| **esp32c3** |       0x0      |        0x8000       |        0x10000        |
