#include <NewPing.h>
#include <Servo.h> 
 
#define TRIGGER_PIN  12  // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN     11  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 400 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.


NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);
Servo myservo;

int pos = 0;

void setup() 
{
  Serial.begin(9600); // Open serial monitor at 9600 baud to see ping results.
  myservo.attach(9);
  myservo.write(pos);
}

void loop() 
{
  delay(300);                  
  if(pos>=50)
  {
    pos = 0;
    myservo.write(pos);
  }
  myservo.write(pos);
  Serial.print(pos); Serial.print(";"); Serial.println(sonar.ping_cm());
  pos++;
}


//Questo sketch è stato utilizzato per la prova dell'angolo di incidenza dell' hc-sr04 su una superficie piatta, in questo
//una tessera attaccata al servo che veniva azionato da questo sketch.
//Contemportaneamente veniva salva la distanza misurata dal modulo ultrasuoni, anche qui grazie lo script per creare file csv
//reperibile nella cartella tools
