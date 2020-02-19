![Alt text](https://user-images.githubusercontent.com/1878314/73881972-3bc0c600-4859-11ea-84fe-474fa8a54b36.png)
# Pi PoE Switch HAT
Resources for the [Pi PoE range](http://pipoe.net) of boards from [Pi Supply](https://www.pi-supply.com).

With [PiPoE](https://www.pi-supply.com/product/pi-poe-switch-hat-power-over-ethernet-for-raspberry-pi/) you can power your Raspberry Pi and provide an Ethernet connection in any location with just a single cable. Additional information on how to assemble the board can be found on the [Maker Zone](https://www.pi-supply.com/make) guide - [Pi PoE Switch HAT Quickstart and FAQ](https://www.pi-supply.com/make/pi-poe-switch-hat-quickstart-faq/).

The script provided here instructs the Pi PoE to completely remove power to the Raspberry Pi if a shutdown is invoked.

## Installation
1. Login via SSH or via the console.
2. Run the following command and PiPoE will be setup and installed:
```bash
curl -sSL https://pisupp.ly/pipoecode | sudo bash
```

## Optional resistors and LEDs on the Ethernet jack
The resistors should be soldered on the reverse of the board where the silk screen read R12 and R13. Once the resistors are in place GPIO 22,23 and 24 will be connected to the LEDs of the on-board PoE connector. GPIO 23 is connected to the single green LED and GPIO 22 and 24 are connected to the green/amber dual LED.

To drive the LEDs you will have to set the GPIOs as outputs. The LED on the left is a single green LED whereas the one on the right is a dual green/amber LED. To drive the green LED on the left it is sufficient to pull the corresponding GPIO 23 high, to turn it bring the GPIO low. For the dual LED instead you will have to bring GPIO 22 high whilst having GPIO 24 low to turn on the green LED, with GPIO 22 low and GPIO 24 high you will turn on the amber LED.
You can test the LEDS with the code below:

This will turn on the green of the single LED
```bash
gpio -g mode 23 out
gpio -g write 23 1
```
This will turn on the green of the dual LED
```bash
gpio -g mode 22 out
gpio -g mode 24 out
gpio -g write 22 1
gpio -g write 24 0
```
This will turn on the amber of the dual LED
```bash
gpio -g mode 22 out
gpio -g mode 24 out
gpio -g write 22 0
gpio -g write 24 1
```

## Manual operation of the board
### Button - SW1
To start the Raspberry Pi press SW1 for 2 seconds.
To completely remove power to the Raspberry Pi press SW1 for at least 15 seconds and until the red LED of the Pi will switch off.
### Jumper - CN2
With the jumper in place to power up the Raspberry Pi you will need to operate SW1, without the jumper as soon as the PoE line receives power the board will power up the Raspberry Pi without the need to use SW1. This is particularly ideal if the Raspberry Pi is in a remote location.
### Solder Pad
On the reverse of the board you can find a solder pad to allow you to add flexibility to the Pi PoE by for example use a custom made button to power on and off the Pi PoE.
The pinout is:
* 5V
* OC (Open Collectors)
* GND
* But (Button)

## A word of caution
Remember that the power to the PiPoE from the managed switch or from the external injector should **only** be applied after the Ethernet cables have been connected. Although the current version of PiPoE has been designed to protect it from electrical spikes caused by plugging PoE cables with power already present, it is best practice to **connect cables with no power**.

## Pinout
The pinout for the Pi PoE can be found at the [Raspberry Pi pinout website](https://pinout.xyz/pinout/pi_poe_switch_hat).

## Gigabit Ethernet

The Raspberry Pi 3 B+ now supports gigabit ethernet but unfortunately the PoE HAT does not. If you are using the PoE HAT with a gigabit Ethernet you will receive power but not data. One way to resolve this issue is to tell the Raspberry Pi to only let the switch know that it is 10/100 only. To do this we need to add the following line to `/etc/rc.local`:

```bash
/sbin/ethtool -s eth0 autoneg on speed 100 duplex full
```
If you can't modify that Rapsberry pi config, you can also configure the switch to only negotiate for a 100M link
