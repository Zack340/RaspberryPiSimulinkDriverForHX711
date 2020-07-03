# Raspberry Pi Simulink Driver for HX711
[![View Raspberry Pi Simulink Driver for HX711 on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/77639-raspberry-pi-simulink-driver-for-hx711)

## Overview
This model makes it possible to log data from HX711 using Raspberry Pi on Simulink. This model simply reads the data from the HX711. Add post-processing blocks as needed. For example, filtering.

## Requires
* Simulink Support Package for Raspberry Pi Hardware (with wiringPi)

## Compatibility
Created with
* MATLAB R2020a
* Raspberry Pi 3B+ / 4B
* HX711's Input Channel and Gain Selection : Ch.A, Gain 128

## How to use
### Getting started
1. Open the "SampleForC.slx" or "SampleForCpp.slx" model.

2. Double-click the "HX711" block to open the "block parameter". You need to set the **appropriate** parameters for "DOUT Pin Number", "PD_SCK Pin Number" and "Data rate".

   **Note:** *If you set a different data rate from the one set on the connected HX711 board, the time in the model will not match the real time.*

3. Open the model's "configuration parameters" and change settings as needed. For example, Device Address, Username, etc.

4. Click "Monitor & tune" on the model's "Hardware" tab to start logging. In default model, you will log binary data.

5. Set the "offset" and "scale" by referring to the acquired binary data. (You may add a post-processing block for this process.) The relationship between "offset" and "scale" in the model is as follows.

   *output = (binary data - offset) * scale*

### Implementation in your model
Copy the "HX711" block to your model. If the target language is C, refer to "SampleForC.slx", and if C++, refer to "SampleForCpp.slx" for configuration parameters. Both models have the different configuration parameters but same blocks.

Place the "src", "include" folders and "HX711Driver.m" on your model path.

## Troubleshoot
* Doesn't work on the Raspberry Pi 4 Model B

  This driver  requires **wiringPi version 2.52** for the Raspberry Pi 4 Model B. You can check the version with the following command on the Terminal.
  ```
  gpio -v
  ```
  If the version is not 2.52 or later, update it with the following command.
  ```
  cd /tmp
  wget https://project-downloads.drogon.net/wiringpi-latest.deb
  sudo dpkg -i wiringpi-latest.deb
  ```

  Reference : [wiringPi updated to 2.52 for the Raspberry Pi 4B](http://wiringpi.com/wiringpi-updated-to-2-52-for-the-raspberry-pi-4b/)

## Known issues
* Spike noise

   In rare cases, spike noise may be recorded in the data. It is presumed that the bit data of serial communication was misread, but the cause is unknown. Add filtering as needed.
