#include <NewPing.h>

#define TRIGGER_PIN  12
#define ECHO_PIN     11
#define TRIGGER_PIN  10
#define ECHO_PIN     9
#define TRIGGER_PIN  8
#define ECHO_PIN     7
#define MAX_DISTANCE 400 

NewPing sonar1(TRIGGER_PIN1, ECHO_PIN1, MAX_DISTANCE);
NewPing sonar2(TRIGGER_PIN2, ECHO_PIN2, MAX_DISTANCE);
NewPing sonar3(TRIGGER_PIN3, ECHO_PIN3, MAX_DISTANCE);


void setup() 
{
  Serial.begin(9600); // Open serial monitor at 9600 baud to see ping results.
}

void loop() 
{
  //delay(50);
  Serial.print("Primo: ");Serial.println(sonar1.ping_cm());
  Serial.print("Secondo: ");Serial.println(sonar2.ping_cm());
  Serial.print("Terzo: ");Serial.println(sonar3.ping_cm());
}

//Questo sketch è stato utilizzato per la prova di più moduli utilizzati, posti in parallelo, uno vicino all'altro, per 
//misurarne gli effetti di interferenza creata dalle onde di ritorno. L' effetto è stato nullo
