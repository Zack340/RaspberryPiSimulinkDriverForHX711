// 
//  	Author : Eisuke Matsuzaki
//  	Created on : 2020/07/01
//  	Copyright (c) 2020 d’Arbeloff Lab, MIT Department of Mechanical Engineering
//      Released under the MIT license
// 
//      HX711 Driver for Raspberry Pi
// 

#ifndef _HX711_RASPI_H_
#define _HX711_RASPI_H_
#include "rtwtypes.h"

#ifdef __cplusplus
extern "C" {
#endif
    
void digitalIOSetup(uint8_T dout_Pin, uint8_T sck_Pin);
uint32_T getValue();

#ifdef __cplusplus
}
#endif
#endif //_HX711_RASPI_H_