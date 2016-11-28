/* Encoder Library - Basic Example
 * http://www.pjrc.com/teensy/td_libs_Encoder.html
 *
 * This example code is in the public domain.
 */

#include <Encoder.h>

// Change these two numbers to the pins connected to your encoder.
//   Best Performance: both pins have interrupt capability
//   Good Performance: only the first pin has interrupt capability
//   Low Performance:  neither pin has interrupt capability



Encoder encL(2, 4);
Encoder encR(3, 5);

//   avoid using pins with LEDs attached

void setup() {
  Serial2.begin(115200);
  Serial2.println("Basic Encoder Test:");
}

// long oldPosition1 = -999, oldPosition2  = -999;
long L_position, R_position;
long L_old = -999, R_old = -999;

void loop() {
  L_position = encL.read();
  R_position = encR.read();
  if (L_position != L_old or R_position != R_old) {
    L_old = L_position;
    R_old = R_position;
    //Serial2.write(int16_t(L_position)); //Serial2.write(',');
    //Serial2.write(int16_t(R_position));
    Serial2.write(int16_t(0)); //Serial2.write(',');
    Serial2.write(int16_t(1));
    
    //Serial2.writeln();
    delay(50);
  }
  
}
