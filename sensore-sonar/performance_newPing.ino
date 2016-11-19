#include <NewPing.h>

#define TRIGGER_PIN  12  // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN     11  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 400 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); // NewPing setup of pins and maximum distance.

void setup() {
  Serial.begin(9600); // Open serial monitor at 9600 baud to see ping results.
}

void loop() {
  delay(50);   // Wait 50ms between pings (about 20 pings/sec). 29ms should be the shortest delay between pings.
  Serial.print(sonar.convert_cm(sonar.ping())); Serial.print(" "); Serial.print(1000); Serial.print("\n");
}

//Questo sketch è stato utilizzato per provare gli strumenti forniti dalla libreria NewPing.
//Questo è infatti uno sketch di esempio modificato per poter plottare il segnale con gli script python della cartella tools
