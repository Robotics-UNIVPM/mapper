#include <Arduino.h>
#include "Rover.h"
#include "Encoder.h"
#include "NewPing.h"

#define SONAR_RANGE 30 // distanza massima da rilevare

//Sarebbe da fare uno schema elettrico
//NewPing sonar (12, 13, SONAR_RANGE);
Encoder encL(2, 4);
Encoder encR(3, 7);
Rover   rov (5, 10, 6, 11
int32_t cntL, cntR;
int32_t oldL = 0x7FFFFFFF, oldR = 0x7FFFFFFF; //valori lontani da 0
uint32_t time;

const uint8_t ID_1 = 0x41,   //'A', per sincronizzare con MATLAB
              ID_2 = 0x42,   //'B', per sincronizzare con MATLAB
              ID_END = 0x5A, //'Z', per sincronizzare con MATLAB
              ID_CMD = 0x42; //'B', per identificare i pacchetti in arrivo

uint8_t distance;
short i=0;

void setup() {
  Serial.begin(115200, SERIAL_8N1);
}

void loop() {

  cntL = encL.read();
  cntR = encR.read();

  if (cntL != oldL || cntR != oldR) {

    time = millis();

    oldL = cntL;
    oldR = cntR;

  }

}

int16_t l,r;
void serialEvent(){
  if(Serial.read()!=ID_CMD) return;
  while(Serial.available() < sizeof(l)+sizeof(r)) ;
  Serial.readBytes((char*)&l, sizeof(l));
  Serial.readBytes((char*)&r, sizeof(r));
  rov.drive(l,r);
}
