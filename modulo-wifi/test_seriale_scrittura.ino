/*struct info{
     long int enc_dx;
     long int enc_sx;
     long unsigned int tempo; //18 byte
     unsigned int sonar1;
     unsigned int sonar2;
     unsigned int sonar3;
};

 info prova={1,2,3,4,5,6};*/
 
long int enc_dx=1;
     long int enc_sx=2;
     long unsigned int tempo=3; //18 byte
     unsigned int sonar1=4;
     unsigned int sonar2=5;
     unsigned int sonar3=6;

  
int i = 0;
int trentamila=0;
int puntatore;
char c = '!';
const int massimo=11;
char vet_prova[massimo];
int inizio=millis();
bool esci=true;
int a,b;
float d=4.54254;

void setup() {
  Serial.begin(250000);

  
}

void loop() {
  if(esci){
   inizio=micros();
 //Serial.write((char*)&prova,18);
 
/*Serial.write(enc_dx);
 Serial.write(enc_sx);
 Serial.write(tempo);
 Serial.write(sonar1);
 Serial.write(sonar2);
 Serial.write(sonar3);*/
 
 Serial.print(enc_dx);
 Serial.print(enc_sx);
 Serial.print(tempo);
 Serial.print(sonar1);
 Serial.print(sonar2);
 Serial.print(sonar3); 
 b=micros()-inizio;
  Serial.print("microsecondi: ");
  Serial.print(b);
  esci=false;
  }
/*if((millis()-inizio)<10000){
i=0;
 while(i<30000)
       Serial.println(i++);
 trentamila++;
} else if(esci){
  a=millis();
  Serial.print("in 10 s num Trentamila: ");
  b=millis()-a;
  Serial.print("millis print stringa ");
  Serial.print(b);
  
  a=millis();
  Serial.println(trentamila);
  b=millis()-a;
   Serial.print("millis println int ");
  Serial.print(b);
  
  Serial.print("i=");
  a=micros();
  Serial.print(i);
  b=micros()-a;
  Serial.print("\nmicros print int ");
  Serial.print(b);
  
  Serial.print("numfloat=");
  a=micros();
  Serial.write((byte*)&d,4);
  ;
  b=micros()-a;
  Serial.print("\nmicros print float e int ");
  Serial.print(b);
  esci=false;}*/
}


