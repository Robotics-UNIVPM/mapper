/*
Questo sketch simula gli encoder a velocità costanti usando millis
*/

//velocità simulate, in passi di encoder al millsecondo
#define VEL_MAX 2.9

//ms tra un campione e il successivo
#define T 10

int16_t  pwmL = 0, pwmR = 0;
int32_t  cntL = 0, cntR = 0;
uint32_t time, deltaTime, lastTime = 0;

const uint8_t ID_1 = 0x41,   //'A', per sincronizzare con MATLAB
              ID_2 = 0x42,   //'B', per sincronizzare con MATLAB
              ID_END = 0x5A, //'Z', per sincronizzare con MATLAB
              ID_CMD = 0x42; //'C', per identificare i pacchetti in arrivo

void setup()
{
  Serial.begin(115200, SERIAL_8N1);
}

void loop()
{
  time = millis();
  deltaTime = time - lastTime;
  cntL += VEL_MAX * pwmL * deltaTime;
  cntR += VEL_MAX * pwmR * deltaTime;
  Serial.write(ID_1); //per sincronizzare con MATLAB
  Serial.write(ID_2); //per sincronizzare con MATLAB
  Serial.write((char*)& cntL, sizeof(cntL));
  Serial.write((char*)& cntR, sizeof(cntR));
  Serial.write((char*)& time, sizeof(time));
  Serial.write(ID_END); //per sincronizzare con MATLAB

  //più preciso di delay(), non teniamo conto del tempo impiegato da write
  while(millis() - lastTime < T) ;
}

void serialEvent(){
  if(Serial.read()!=ID_CMD) return;
  while(Serial.available() < sizeof(pwmL)+sizeof(pwmR)) ;
  Serial.readBytes((char*)&pwmL, sizeof(pwmL));
  Serial.readBytes((char*)&pwmR, sizeof(pwmR));
}
