## Cortex-M (STM32) development framework hosted on Debian GNU/Linux

- [x] ST-Link v1/v2/v2-1 support installation
- [ ] arm-none-eabi GNU toolchain
- [ ] mbed intergration

## Supported hardware
### STMicroelectronics
- [ ] [32F746GDISCOVERY](http://www.st.com/en/evaluation-tools/32f746gdiscovery.html)
- [ ] STM32F4 VL Discovery
- [ ] STM32F103 VL Discovery
- [ ] STM32F030
### NXP Semiconductors
- [ ] [FRDM-KL25Z](https://www.nxp.com/support/developer-resources/hardware-development-tools/freedom-development-boards/freedom-development-platform-for-kinetis-kl14-kl15-kl24-kl25-mcus:FRDM-KL25Z)

github: https://github.com/ponyatov/STM32.git

### Installation

```
$ cd ~ ; git clone -o gh https://github.com/ponyatov/STM32.git
$ cd STM32 ; make ramdisk
```

### GNU Toolchain

This package uses specially compiled __local__ tools (mostly fresh versions)
_does not interfere with system-wide installed tools_:
this gives you more repeatability in build process in multi-developer teams
