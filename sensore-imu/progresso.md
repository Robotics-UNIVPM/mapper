Piano di lavoro per lo studio dell'IMU [MPU-9250](https://www.invensense.com/wp-content/uploads/2015/02/PS-MPU-9250A-01-v1.1.pdf)

*9/11/16*

- Download libreria [iLib](https://github.com/orgua/iLib) (libreria generale che gestisce diversi moduli in I2C, noi abbiamo utilizzato quella relativa al MPU-9250)
- E' stato modificato, all'interno della libreria, l'indirizzo della porta seriale, da 0x69 a 0x68
- Si è riscontrato un periodo di lettura di 6 dati (2 terne, una per accelerometro e l'altra per il giroscopio) pari a 3-4 ms, con una velocità di comunicazione seriale di 115200 baud
- Acquisizione dei dati con lo script Python e salvataggio in csv

<br>
*14/11/16*

- Implementato grafico su MatLab, con la possibilità di vedere più valori contemporaneamente
- Si è trovata una nuova libreria con dei filtri/calibrazioni interni, è necessario studiarsela per capire bene il funzionamento
- Da alcuni grafici è risultato che i valori hanno delle oscillazioni, si deve lavorare per cercare di compensarle
- Si è cominciato a vedere l'integrazione delle accelerazioni per trovare la velocità e lo spazio percorso. Inoltre si è notato che il sensore rileva delle accelerazioni nonostante sia fermo.
- Il prof ha dato spunti applicativi interessanti, ad esempio si potrebbe simulare un sistema airbag (il quale si aziona se viene rilevata una forte decelerazione)


<br>
**Da fare:**

- Analizzare l'errore di deriva nel tempo
- Testare in generale come si comporta il modulo (range massimo dei valori assunti, ecc.)
- Risolvere i problemi legati all'integrazione
- Capire bene come calibrare i dati, il sensore non dovrebbe rilevare accelerazioni se rimane fermo
- Test applicativi, ad esempio:
	- Muovere il sensore su un percorso rettilineo e calcolare lo spazio percorso, verificando l'errore effettivo.
	- Muovere il robot con un pennarello (in modo che tracci la traiettoria) e far fare lo stesso percorso avanti e indietro, oppure fargli fare qualche figura geometrica ripetutamente, in modo da vedere visivamente quanto errore c'è

<br>
# Idee
Potrebbe essere utile posizionare il sensore lontano dal centro del robot.
In questo modo l'accelerometro rileverebbe le accelerazioni centrifughe durante
le rotazioni, un'informazione utile per filtrare i dati del giroscopio.
