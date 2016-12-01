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
*21/11/16*

- Dopo diverse ricerche sulla libreria "perfetta", si è riscontrato che essa non esiste, cioè non esiste una libreria che utilizzi il DMP (sensor fusion) e il magnetometro contemporaneamente. La libreria che ci è sembrata più utile da usare è [questa](https://github.com/kriswiner/MPU-9250), che purtroppo fa fare il filtraggio dei dati ad Arduino, perdendo efficienza.
- Si è testata l'integrazione per ricavare lo spostamento dalle accelerazioni fornite dall'IMU. Purtroppo i risultati sono un disastro, gli errori sono enormi, quindi non è possibile utilizzare il sensore per calcolare la distanza percorsa.
- Si è provato a mantenere fermo il sensore per 5 minuti; le tre terne di valori fornite dall'IMU non soffrono di deriva, i valori sono rimasti pressochè costanti (seppur con un intervallo di errore ovviamente).
- In ogni caso, si è constatato che per i nostri scopi (progettare un robot che riesca a mappare una stanza) non è utile l'IMU, l'unico dato interessante potrebbe essere l'orientazione, ma il magnetometro è facilmente influenzabile dai campi magnetici che si trovano nella stanza, quindi non è molto affidabile. 
Pertanto si è deciso di mettere il sensore da parte, magari per un utilizzo futuro su un pendolo inverso o qualcosa di simile.



<br>
**Eventuali test applicativi:**


- Utilizzare solo il giroscopio. Calibrarlo in modo che due assi siano paralleli al terreno (x e y), aiutandosi con i valori dell'accelerometro (in teoria l'accelerazione sugli assi x e y dovrebbe essere nulla). Poi verificare su un percorso rettilineo se il giroscopio è affidabile o se pensa che stiamo cambiando orientazione.
- Muovere il robot con un pennarello (in modo che tracci la traiettoria) e far fare lo stesso percorso avanti e indietro, oppure fargli fare qualche figura geometrica ripetutamente, in modo da vedere visivamente quanto errore c'è

<br>
# Idee
Potrebbe essere utile posizionare il sensore lontano dal centro del robot.
In questo modo l'accelerometro rileverebbe le accelerazioni centrifughe durante
le rotazioni, un'informazione utile per filtrare i dati del giroscopio.
