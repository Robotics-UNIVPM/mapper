/*
Questo sketch simula gli encoder a velocità costanti usando millis
*/

//velocità simulate, in passi di encoder al millsecondo
#define VELSX 2.9
#define VELDX 1.45

//ms tra un campione e il successivo
#define T 1

int32_t  cntL, cntR;
uint32_t time;

const uint8_t ID = 0xFF; //per sincronizzare con MATLAB

void setup() {
  Serial.begin(115200);
}

void loop()
{
  time = millis();
  cntL = VELSX*time;
  cntR = VELDX*time;
  Serial.write(ID); //per sincronizzare con MATLAB
  Serial.write((char*)& cntL, sizeof(cntL));
  Serial.write((char*)& cntR, sizeof(cntR));
  Serial.write((char*)& time, sizeof(time));

  //più preciso di delay(), non teniamo conto del tempo impiegato da write
  while(millis() - time < T) ;
}
