# Raspberry Pi Simulink Driver for HX711
## Overview
This model makes it possible to log data from HX711 using Raspberry Pi on Simulink. This model simply reads the data from the HX711. Add post-processing blocks as needed. For example, filtering.

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
#####   Note :
     *If you set a different data rate from the one set on the connected HX711 board, the time in the model will not match the real time.*

3. Open the model's "configuration parameters" and change settings as needed. For example, Device Address, Username, etc.

4. Click "Monitor & tune" on the model's "Hardware" tab to start logging. In default model, you log binary data.

5. Set the "offset" and "scale" by referring to the acquired binary data. (You may add a post-processing block for processing.) The relationship between "offset" and "scale" in the model is as follows.

   *output = (binary data - offset) * scale*

#### Implementation in your model
Copy the "HX711" block to your model. If the target language is C, refer to "SampleForC.slx", and if C++, refer to "SampleForCpp.slx" for configuration parameters. Both models have the different configuration parameters but same blocks.
