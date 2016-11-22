#Inertial Motion Unit

<br>
###Introduzione
L’IMU è un sensore che comprende un accelerometro a 3 assi (ortogonali), un giroscopio a 3 assi e talvolta un magnetometro a 3 assi. 
<br>*Accelerometro*: misura le accelerazioni lungo gli assi. È da tenere presente che l’accelerazione di gravità viene sempre rilevata, quindi bisognerebbe eliminarla per ottenere le misure effettive.
<br>*Giroscopio*: misura la velocità angolare per ogni asse
<br>*Magnetometro*: misura la componente del campo magnetico per ogni asse.

<br>
###Problematiche
In linea teorica, l’IMU permetterebbe di calcolare la velocità e lo spostamento lineare, e lo spostamento angolare (orientazione) rispetto ad ogni asse. 
<br>Nella realtà, però, non è così semplice. I valori dell’accelerometro sono sempre “sporcati” dall’accelerazione gravitazionale (vettore g), e per ottenere le accelerazioni utili al nostro scopo bisognerebbe sottrarre il vettore g. Non è possibile farlo in maniera precisa, pertanto si producono errori.
<br>Dato che la velocità si ottiene integrando l’accelerazione, gli errori si sommano con l'avanzare del tempo, ottenendo così valori della velocità sempre più inesatti. 
<br>La situazione peggiora se integriamo la velocità per ottenere lo spazio, gli errori aumentano maggiormente e purtroppo non si possono ottenere dati affidabili.
<br>Anche il giroscopio soffre di errori di integrazione, perché il valore misurato è sporcato da qualche errore (seppur minimo). Inoltre il giroscopio è sensibile alle variazioni di temperatura, generando ulteriori errori.
<br>Per quanto riguarda il magnetometro, negli ambienti chiusi il campo magnetico subisce diverse variazioni, perciò il magnetometro non è molto affidabile in tali situazioni.

Da ciò consegue che è difficile utilizzare in maniera utile i valori “grezzi” misurati dall’IMU.

<br>
###Soluzioni
Per riuscire a gestire i dati dell’IMU in modo efficace si possono utilizzare degli algoritmi AHRS (Attitude and Heading Reference System). Questi algoritmi sono dei filtri che fondono i dati dell’accelerometro e del giroscopio. 
<br>Tra i filtri più utilizzati ci sono il filtro di Kalman, il filtro complementare e il filtro Mahony.
<br>Questi filtri sono piuttosto complessi, è possibile ottenere maggiori informazioni su di essi su internet. 

<br>
###MPU 9250
Durante i nostri esperimenti è stato utilizzato il sensore MPU 9250 prodotto dalla InvenSense, il quale prevede anche il magnetometro; tuttavia, per i nostri scopi progettuali è sconsigliato il suo uso, considerando le problematiche qui sopra esposte.

Il sensore MPU 9250 presenta al suo interno una DMP (Digital Motion Processor) che filtra automaticamente i dati provenienti da accelerometro e giroscopio.
<br>Grazie a una libreria che fa uso della DMP, siamo riusciti ad ottenere risultati accettabili per Yaw, Pitch e Roll (imbardata, beccheggio, rollio; sono gli angoli di orientazione rispetto a Z, Y, X).
<br>Il dato più interessante per un robot mobile è lo Yaw, visto che indica la direzione verso cui si sta puntando, e purtroppo si è rilevato quello più “sporco”; questo succede perché gli assi X e Y hanno sempre come riferimento l’accelerazione gravitazionale che punta verso il basso, mentre l’asse Z, da cui deriva lo Yaw, non ha un riferimento, infatti il valore della Yaw è instabile soprattutto quando l’IMU rimane ferma.


####Grafici
(In [questa](https://github.com/Robotics-UNIVPM/mapper/tree/MPU/sensore-imu/Script%20Matlab) cartella si trovano i dati e lo script Matlab utilizzato per elaborarli)
<br>Il sensore è rimasto fermo per 5 minuti. Da questi grafici si può apprezzare che il sensore non ha qualche errore di deriva nel tempo, e che i valori dell'accelerometro e del giroscopio oscillano in un intervallo d'errore piuttosto ridotto.
<br>
<img src="https://github.com/Robotics-UNIVPM/mapper/blob/MPU/sensore-imu/Grafici/acc3axes.png" width="400">
<img src="https://github.com/Robotics-UNIVPM/mapper/blob/MPU/sensore-imu/Grafici/accX.png" width="400">
<img src="https://github.com/Robotics-UNIVPM/mapper/blob/MPU/sensore-imu/Grafici/gyr3axes.png" width="400">
<br><br>
Qui sotto viene mostrato lo spostamento, calcolato integrando due volte le accelerazioni. E' evidente che il risultato è lontano dalla realtà, secondo questi dati il sensore si sarebbe spostato di 170 metri in 5 minuti!
<img src="https://github.com/Robotics-UNIVPM/mapper/blob/MPU/sensore-imu/Grafici/distance.png" width="400">

<br>
###Conclusioni
Date le considerazioni qui sopra esposte, si è concluso che l’IMU non è molto utile per il nostro progetto. Una sua applicazione più sensata potrebbe essere in un pendolo inverso, dove vengono sfruttati Pitch e Roll, che sono relativamente affidabili.
<br>Nel nostro robot si potrebbe usare l’IMU insieme agli encoder tramite una fusione sensoriale (l’IMU è utile quando si cambia direzione, gli encoder sono utili quando si va in linea retta). In futuro si valuterà se utilizzare questa soluzione o meno, considerando che non sarà facile fondere i dati provenienti dalle due fonti diverse.
