

#include <compat/deprecated.h>
#include <FlexiTimer2.h>                  //download as library for ide http://www.arduino.cc/playground/Main/FlexiTimer2


#define NUMCHANNELS 1                     // can prob do 6 channels
#define HEADERLEN 3
#define PACKETLEN (NUMCHANNELS * 2 + HEADERLEN + 1)
#define SAMPFREQ 256                      // ADC sampling rate 256
#define TIMER2VAL (1024/(SAMPFREQ))       // Set 256Hz sampling frequency                    
#define LED1  13

// golbal constants vars
volatile unsigned char TXBuf[PACKETLEN];  //transmission pckt
volatile unsigned char TXIndex;           //next byte for pckt
volatile unsigned char counter = 0;	      //generate cal_sig 
volatile unsigned int ADC_Value = 0;	    //curr val adc



void Toggle_LED1(void){

 if((digitalRead(LED1))==HIGH){ digitalWrite(LED1,LOW); }
 else{ digitalWrite(LED1,HIGH); }
 
}



void setup() {

 noInterrupts();  // Disable all interrupts before initialization
 

 pinMode(LED1, OUTPUT);  //Setup LED1 direction
 digitalWrite(LED1,LOW); //Setup LED1 state
 

 TXBuf[0] = 0xa5;    //sync 0 and 1
 TXBuf[1] = 0x5a;    
 TXBuf[2] = 0;       //pckt count
 TXBuf[3] = 0x02;    //channel 1 high
 TXBuf[4] = 0x00;    //channel 1 low
 TXBuf[5] =  0x01;	// switch

 //set up the second timer
 FlexiTimer2::set(TIMER2VAL, Timer2_Overflow_ISR);
 FlexiTimer2::start();

 //baudrate 57600 bps
 Serial.begin(57600);
 
 interrupts();  
}


void Timer2_Overflow_ISR()
{
  // Toggle LED1 with ADC sampling frequency /2
  Toggle_LED1();
  
  //Read the Channel 1 ADC inputs and store values in packet (Analog Pin: A0)
  ADC_Value = analogRead(0);
  TXBuf[3] = ((unsigned char)((ADC_Value & 0xFF00) >> 8));	// Write High Byte
  TXBuf[4] = ((unsigned char)(ADC_Value & 0x00FF));	// Write Low Byte
	 
  // pckt send
  for(TXIndex=0;TXIndex<6;TXIndex++){
    Serial.write(TXBuf[TXIndex]);
  }
  
  // pckt counter inc
  TXBuf[3]++;			
}


//sleep 
void loop() {
  
 __asm__ __volatile__ ("sleep");
 
}
