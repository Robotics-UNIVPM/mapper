
// IMU-Sensor
#include "i2c_MPU9250.h"
MPU9250 mpu9250;

void setup()
{
    Serial.begin(115200);

    mpu9250.initialize();


    mpu9250.setGSensitivity(0);
    mpu9250.setASensitivity(0);
    mpu9250.setDatarate(1000);
    mpu9250.setBandwidth(200);

}

void loop()
{
    static float xyz_GyrAccMag[9];

    mpu9250.getMeasurement(xyz_GyrAccMag);

    Serial.print(millis());
    Serial.print(';');
    Serial.print(xyz_GyrAccMag[0],2);
    Serial.print(';');
    Serial.print(xyz_GyrAccMag[1],2);
    Serial.print(';');
    Serial.print(xyz_GyrAccMag[2],2);
    Serial.print(';');
    Serial.print(xyz_GyrAccMag[4],2);
    Serial.print(';');
    Serial.print(xyz_GyrAccMag[5],2);
    Serial.print(';');
    Serial.println(xyz_GyrAccMag[6],2);

}

