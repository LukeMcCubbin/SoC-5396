/*****************************************************************//**
 * @file main_sampler_test.cpp
 *
 * @brief Basic test of nexys4 ddr mmio cores
 *
 * @author p chu
 * @version v1.0: initial release
 *********************************************************************/

// #define _DEBUG
#include "chu_init.h"
#include "gpio_cores.h"
#include "xadc_core.h"
#include "sseg_core.h"
#include "spi_core.h"
#include "i2c_core.h"
#include "ps2_core.h"
#include "ddfs_core.h"
#include "adsr_core.h"


/*
 * Function: Luke_Piano
 *
 *This function reads in the switches value, button debounced value, and the octave number as inputs.
 *The octave is increased when the up button is pressed and decressed with the down button.
 *The function reads which switch is in the on position and the case statement evaluates which sound should be played
 * and also which value should be displayed to the seven segment
 *
 */
void luke_piano(DebounceCore *db_p, AdsrCore *adsr_p, GpoCore *led_p, GpiCore *sw_p, SsegCore *sseg_p, int *octave) {
   const int melody[] = { 0, 2, 4, 5, 7, 9, 11 };
   int i;
   int s;
   int button;

   //s = sw_p->read();
   adsr_p->select_env(2);
   //led_p->write(s);
   button = db_p->read();


   if(button == 1){
	   *octave = *octave +1;
   }
   if(button == 4){
	   *octave = *octave -1;
   }


   sseg_p->write_1ptn(sseg_p->h2s(*octave), 4);
   s = sw_p->read();
   led_p->write(s);

   switch(s)
   {
   	   case 1:
   		  sseg_p->write_1ptn(sseg_p->h2s(12), 0);
   		  adsr_p->play_note(melody[0], *octave+1, 700);
   		  break;

   	   case 2:
   		  sseg_p->write_1ptn(sseg_p->h2s(11), 0);
   		  adsr_p->play_note(melody[6], *octave, 700);
   		  break;

   	   case 4:
   		  sseg_p->write_1ptn(sseg_p->h2s(10), 0);
   		  adsr_p->play_note(melody[5], *octave, 700);
   		  //sleep_ms(500);
   		  break;

   	   case 8:
   		  sseg_p->write_1ptn(sseg_p->h2s(9), 0);
		  adsr_p->play_note(melody[4], *octave, 700);
		  //sleep_ms(500);
		  break;

   	   case 16:
   		  sseg_p->write_1ptn(sseg_p->h2s(15), 0);
		  adsr_p->play_note(melody[3], *octave, 700);
		  //sleep_ms(500);
		  break;

   	   case 32:
   		  sseg_p->write_1ptn(sseg_p->h2s(14), 0);
		  adsr_p->play_note(melody[2], *octave, 700);
		  //sleep_ms(500);
		  break;

   	   case 64:
   		  sseg_p->write_1ptn(sseg_p->h2s(13), 0);
		  adsr_p->play_note(melody[1], *octave, 700);
		  break;

   	   case 128:
   		  sseg_p->write_1ptn(sseg_p->h2s(12), 0);
		  adsr_p->play_note(melody[0], *octave, 700);
		  break;


   	   default:
   		   led_p->write(0);

   }

   sleep_ms(700);
   led_p->write(0);
   //turn off led
	for (i = 0; i < 8; i++) {
		sseg_p->write_1ptn(0xff, i);
	}
	//turn off all decimal points
	sseg_p->set_dp(0x00);
}

GpoCore led(get_slot_addr(BRIDGE_BASE, S2_LED));
GpiCore sw(get_slot_addr(BRIDGE_BASE, S3_SW));
XadcCore adc(get_slot_addr(BRIDGE_BASE, S5_XDAC));
PwmCore pwm(get_slot_addr(BRIDGE_BASE, S6_PWM));
DebounceCore btn(get_slot_addr(BRIDGE_BASE, S7_BTN));
SsegCore sseg(get_slot_addr(BRIDGE_BASE, S8_SSEG));
SpiCore spi(get_slot_addr(BRIDGE_BASE, S9_SPI));
I2cCore adt7420(get_slot_addr(BRIDGE_BASE, S10_I2C));
Ps2Core ps2(get_slot_addr(BRIDGE_BASE, S11_PS2));
DdfsCore ddfs(get_slot_addr(BRIDGE_BASE, S12_DDFS));
AdsrCore adsr(get_slot_addr(BRIDGE_BASE, S13_ADSR), &ddfs);


int main() {
   int octave = 0;

   //timer_check(&led);
   while (1) {

      luke_piano(&btn, &adsr, &led, &sw, &sseg, &octave);

   } //while
} //main

