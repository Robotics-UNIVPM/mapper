Piano di lavoro per lo studio dell'IMU [MPU-9250](https://www.invensense.com/wp-content/uploads/2015/02/PS-MPU-9250A-01-v1.1.pdf)

*9/11/16*

- Download libreria [iLib](https://github.com/orgua/iLib) (libreria generale che gestisce diversi moduli in I2C, noi abbiamo utilizzato quella relativa al MPU-9250)
- E' stato modificato, all'interno della libreria, l'indirizzo della porta seriale, da 0x69 a 0x68
- Si è riscontrato un periodo di lettura di 6 dati (2 terne, una per accelerometro e l'altra per il giroscopio) pari a 3-4 ms, con una velocità di comunicazione seriale di 115200 baud
- Acquisizione dei dati con lo script Python e salvataggio in csv

<br>
**Da fare:**

- Grafico dei dati su MatLab, possibilmente di tutti i 6 valori simultaneamente
- Analizzare l'errore di deriva nel tempo
- Testare in generale come si comporta il modulo (range massimo dei valori assunti, ecc.)
