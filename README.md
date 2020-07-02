# Raspberry Pi Simulink Driver for HX711
## Overview
This driver makes it possible to log data from HX711 using Raspberry Pi on Simulink.

## Requires
* Simulink Support Package for Raspberry Pi Hardware (with wiringPi)

## Compatibility
Created with
* MATLAB R2020a
* Raspberry Pi 3B+/4B
* HX711's Input Channel and Gain Selection : Ch.A, Gain 128

## How to use
#### Getting started
1. Open the "SampleForC.slx" or "SampleForCpp.slx" model.
2. Double-click the "HX711" block to open the "block parameter". You need to set the **appropriate** parameters for "DOUT Pin Number", "PD_SCK Pin Number" and "Data rate".
3. Open the model's "configuration parameters" and change settings as needed. For example, Device Address, Username, etc.
4. Click "Monitor & tune" on the model's "Hardware" tab to start logging.

#### Implementation in your model
Copy the "HX711" block to your model. If the target language is C, refer to "SampleForC.slx", and if C++, refer to "SampleForCpp.slx" for configuration parameters. Both models have the different configuration parameters but same blocks.
