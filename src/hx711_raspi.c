#include <wiringPi.h>
#include "hx711_raspi.h" 

uint8_T doutPin;
uint8_T sckPin;

#ifdef __cplusplus
extern "C" {
#endif

void digitalIOSetup(uint8_T dout_Pin, uint8_T sck_Pin)
{
    doutPin = dout_Pin;
    sckPin = sck_Pin;
    
    wiringPiSetupGpio();
    
    pinMode(doutPin, 0);
    pinMode(sckPin, 1);
    
    digitalWrite(sckPin, true);
    delayMicroseconds(100);
    digitalWrite(sckPin, false);
}

uint32_T getValue()
{
    uint32_T data = 0;
    
    while (digitalRead(doutPin))
        ;
    
    for (uint8_T i = 0; i < 24; i++)
    {
        digitalWrite(sckPin, true);
        delayMicroseconds(1);
        digitalWrite(sckPin, false);
        data = data << 1;
        if (digitalRead(doutPin))
        {
            data++;
        }
        delayMicroseconds(1);
    }
    
    data = data ^0x800000;
    
    digitalWrite(sckPin, true);
    delayMicroseconds(1);
    digitalWrite(sckPin, false);
    delayMicroseconds(1);
    
    return data;
}

#ifdef __cplusplus
}
#endif