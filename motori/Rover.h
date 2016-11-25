/*
  API:

Crea un'istanza di Rover
  Rover rov(3,9,10,11);

Muovi i motori
  rov.drive(l, r)

l ed r comandano le velocità rispettive del motore sx e dx.
Negativi per la retromarcia.

Se l ed r sono interi, vengono usati come valore da scrivere sul pwm
Se l ed r sono float, saranno il valore in frazione sulla potenza massima (|1|)

Per comodità ci sono anche:
  rov.drive()     che equivale a      rov.drive(1.0, 1.0)
  rov.stop()      che equivale a      rov.drive(0,0)

*/

#ifndef _ROVER_H_
#define _ROVER_H_

#include <Arduino.h>

class Rover{
public:
  //Contructor, takes pins as arguments
  Rover(int fwdLeftPin, int fwdRightPin, int revLeftPin, int revRightPin);

  // Control motors with signed pwm values. Sign indicates direction.
  // Default arguments to drive forward with maximum power.
  // WARNING: different MCUs will give different results
  void drive(int leftPWM=PWMRANGE, int rightPWM=PWMRANGE);

  // Control motors with signed duty cycle.   Sign indicates direction.
  // Values should be in range [-1.0, 1.0].   Platform independent!
  void drive(float leftDutyCycle, float rightDutyCycle);

  void stop(); //shorthand for drive(0,0)

private:
  //Pins connected to H-Bridge
  const int forwardLeftPin_, forwardRightPin_,
            reverseLeftPin_, reverseRightPin_;
};


//============================================================================//
//================IMPLEMENTATION==============================================//

Rover::Rover(int fl, int fr, int rl, int rr):
  forwardLeftPin_(fl), forwardRightPin_(fr),
  reverseLeftPin_(rl), reverseRightPin_(rr) {
  //Initialize all pins for output
  pinMode(forwardLeftPin_,  OUTPUT);
  pinMode(forwardRightPin_, OUTPUT);
  pinMode(reverseLeftPin_,  OUTPUT);
  pinMode(reverseRightPin_, OUTPUT);
  //Set all pins LOW just to be sure
  analogWrite(forwardLeftPin_,  0);
  analogWrite(forwardRightPin_, 0);
  analogWrite(reverseLeftPin_,  0);
  analogWrite(reverseRightPin_, 0);
}

// PWMRANGE is the maximum PWM value you can give to your hardware. This is
// #defined in Arduino Framework, using this constant makes this code
// platform independent.
void Rover::drive(int leftPWM, int rightPWM){
  // Control left motor:
  if (leftPWM<0) {
    analogWrite(forwardLeftPin_, 0);
    analogWrite(reverseLeftPin_, -leftPWM);
  }  else {
    analogWrite(reverseLeftPin_, 0);
    analogWrite(forwardLeftPin_, leftPWM);
  }

  //Control right motor:
  if (rightPWM<0) {
    analogWrite(forwardRightPin_, 0);
    analogWrite(reverseRightPin_, -rightPWM);
  } else {
    analogWrite(reverseRightPin_, 0);
    analogWrite(forwardRightPin_, rightPWM);
  }
}

void Rover::drive(float leftDutyCycle, float rightDutyCycle){
  // convert duty cycles to integer pwm values and pass to drive(int,int)
  drive((int)leftDutyCycle/PWMRANGE, (int)rightDutyCycle/PWMRANGE);
}

void Rover::stop(){
  drive(0,0);
}

#endif
