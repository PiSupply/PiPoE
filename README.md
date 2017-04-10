# PiPoE
Resources for Pi PoE range.

With [PiPoE](https://www.pi-supply.com/product/pi-poe-switch-hat-power-over-ethernet-for-raspberry-pi/) you can power your Raspberry Pi and provide an Ethernet connection in any location with just a single cable

## Installation
1. Login via SSH or via the console.
2. Run the following command and PiPoE will be setup and installed:
```bash
curl -sSL https://pisupp.ly/pipoecode | sudo bash
```

With this script you can make so that the PiPoE completely removes power to the Raspberry Pi if a shutdown is invoked.

## Manual operation of the board
### SW1
To start the Raspberry Pi press SW1 for 2 seconds.
To completely remove power to the Raspberry Pi press SW1 for at least 15 seconds and until the red LED of the Pi will switch off.
### CN2
With the jumper in place to power up the Raspberry Pi you will need to operate SW1, without the jumper as soon as the PoE line receives power the board will power up the Raspberry Pi without the need to use SW1. This is particularly ideal if the Raspberry Pi is in a remote location.

## A word of caution
Remember that the power to the PiPoE from the managed switch or from the external injector should **only** be applied after the Ethernet cables have been connected. Altough the current version of PiPoE has been designed to protect it from electrical spikes coused by plugging PoE cables with power already present, it is best practice to **connect cables with no power**.
