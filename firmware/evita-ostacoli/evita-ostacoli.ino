/*
Questo firmware guida il robot facendolo andare dritto e fermare agli ostacoli.
Ogni T_SONAR millisecondi fa un campione con il sensore ultrasuoni.
Ogni volta che un encoder cambia stato invia una quaterna di dati: i conteggi
dei due encoder, i millisecondi dall'avvio del programma e l'ultima distanza
rilvata con l'ultrasuoni.
TODO:
evitare il delay, e studiare il periodo di campionamento del sonar.
implementare un rilevamento degli errori
*/
#include <Arduino.h>
#include "NewPing.h"
#include "Rover.h"
#include "Encoder.h"

#define T_SONAR 20 //ms tra un ping e quello dopo
#define D_MIN 30   //cm dall'ostacolo per girare
#define SONAR_RANGE D_MIN // distanza massima da rilevare

#define T_ROT 1000 //ms per girarsi

//Sarebbe da fare uno schema elettrico
NewPing sonar (12, 13, SONAR_RANGE);
Encoder encL  (2, 4);
Encoder encR  (3, 7);
Rover   rov   (5, 10, 6, 11);

//da ottimizzare per la memoria e la larghezza di banda
int32_t  cntL, cntR, oldL = -999, oldR = -999;
int32_t  time; //da convertire ad uint32_t
uint32_t lastPing = 0;
int32_t  dist = 0; //da convertire ad uint8_t

void setup() {
  Serial.begin(115200);
  rov.drive();
}

void loop()
{
  cntL = encL.read();
  cntR = encR.read();

  if (millis()-lastPing > T_SONAR )
  {
    dist = sonar.ping_cm(); // 0 significa timeout
    if (dist && dist <= D_MIN)
    {
      rov.drive(-1.0, 1.0); //bisognerebbe stare attenti al retro del robot
      delay(T_ROT); //da evitare
      rov.drive();
    }
    lastPing = millis();
  }

  if (cntL != oldL || cntR != oldR)
  {
    tempo = millis();

    //da implementare un controllo degli errori
    Serial.write((char *)&L_position, sizeof(L_position));
    Serial.write((char *)&R_position, sizeof(R_position));
    Serial.write((char *)&tempo,      sizeof(tempo));
    Serial.write((char *)&dist,       sizeof(dist));

    oldL = cntL;
    oldR = cntR;
  }


}
