#ifndef __ROVER__
#define __ROVER__

#include <Arduino.h>

/*
Crea un'istanza di Rover
  Rover rov(3,9,10,11);

Muovi i motori
  rov.drive(l, r)

l ed r comandano le velocità rispettive del motore sx e dx.
Negativi per la retromarcia.

Se l ed r sono interi, vengono usati come valore da scrivere sul pwm
Se l ed r sono float, saranno il valore in frazione sulla potenza massima (|1|)

  rov.drive()     equivale a      rov.drive(1.0, 1.0)
  rov.stop()      è ovvio
  
  rov.pause() ferma i motori e memorizza lo stato precendete, per riprenderlo:
  rov.resume()

*/

class Rover{

  int fl_, fr_, rl_, rr_; //pins
  int L_, R_; //duty cycles stored for pausing and resuming

  public:

  Rover(int fl, int fr, int rl, int rr):
  fl_(fl), fr_(fr), rl_(rl), rr_(rr) {
    pinMode(fl_, OUTPUT);
    analogWrite(fl_, LOW);
    pinMode(fr_, OUTPUT);
    analogWrite(fr_, LOW);
    pinMode(rl_, OUTPUT);
    analogWrite(rl_, LOW);
    pinMode(rr_, OUTPUT);
    analogWrite(rr_, LOW);
  }

  void drive(int L=PWMRANGE, int R=PWMRANGE){
    if (L<0) {
      analogWrite(fl_, LOW);
      analogWrite(rl_, -L);
    } else {
      analogWrite(rl_, LOW);
      analogWrite(fl_, L);
    }
    if (R<0) {
      analogWrite(fr_, LOW);
      analogWrite(rr_, -R);
    } else {
      analogWrite(rr_, LOW);
      analogWrite(fr_, R);
    }
    L_=L;
    R_=R;
  }

  void drive(float L=1, float R=1){
    drive((int)L/PWMRANGE,(int)R/PWMRANGE);
  }

  void stop(){
    drive(0,0);
  }

  void pause(){
    analogWrite(fl_, 0);
    analogWrite(fr_, 0);
    analogWrite(rl_, 0);
    analogWrite(rr_, 0);
  }

  void resume(){
    drive(L_, R_);
  }
};


#endif
