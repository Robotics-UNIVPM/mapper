/*
Questo sketch simula gli encoder a velocità costanti usando millis
*/

//velocità simulate, in passi di encoder al millsecondo
#define VELSX 2.9
#define VELDX 1.45

//ms tra un campione e il successivo
#define T 10

int32_t  cntL, cntR;
uint32_t time;

const uint8_t ID_1 = 0x41;   //'A', per sincronizzare con MATLAB
const uint8_t ID_2 = 0x42;   //'B', per sincronizzare con MATLAB
const uint8_t ID_END = 0x5A; //'Z', per sincronizzare con MATLAB

void setup()
{
  Serial.begin(115200, SERIAL_8N1);
}

void loop()
{
  time = millis();
  cntL = VELSX*sin(time/1000.0)*1000.0;
  cntR = VELDX*cos(time/1000.0)*1000.0;
  Serial.write(ID_1); //per sincronizzare con MATLAB
  Serial.write(ID_2); //per sincronizzare con MATLAB
  Serial.write((char*)& cntL, sizeof(cntL));
  Serial.write((char*)& cntR, sizeof(cntR));
  Serial.write((char*)& time, sizeof(time));
  Serial.write(ID_END); //per sincronizzare con MATLAB


  //più preciso di delay(), non teniamo conto del tempo impiegato da write
  while(millis() - time < T) ;
}
