#Inertial Motion Unit

<br>
###Introduzione
L’IMU è un sensore che comprende un accelerometro a 3 assi (ortogonali), un giroscopio a 3 assi e talvolta un magnetometro a 3 assi. 
*Accelerometro*: misura le accelerazioni lungo gli assi. È da tenere presente che l’accelerazione di gravità viene sempre rilevata, quindi bisognerebbe eliminarla per ottenere le misure effettive.
*Giroscopio*: misura la velocità angolare per ogni asse
*Magnetometro*: misura la componente del campo magnetico per ogni asse.

<br>
###Problematiche
In linea teorica, l’IMU permetterebbe di calcolare la velocità e lo spostamento lineare, e lo spostamento angolare (orientazione) rispetto ad ogni asse. 
Nella realtà, però, non è così semplice. I valori dell’accelerometro sono sempre “sporcati” dall’accelerazione gravitazionale (vettore g), e per ottenere le accelerazioni utili al nostro scopo bisognerebbe sottrarre il vettore g. Non è possibile farlo in maniera precisa, pertanto si producono errori.
Dato che la velocità si ottiene integrando l’accelerazione, gli errori si sommano con l'avanzare del tempo, ottenendo così valori della velocità sempre più inesatti. 
La situazione peggiora se integriamo la velocità per ottenere lo spazio, gli errori aumentano maggiormente e purtroppo non si possono ottenere dati affidabili.
Anche il giroscopio soffre di errori di integrazione, perché il valore misurato è sporcato da qualche errore (seppur minimo). Inoltre il giroscopio è sensibile alle variazioni di temperatura, generando ulteriori errori.
Per quanto riguarda il magnetometro, negli ambienti chiusi il campo magnetico subisce diverse variazioni, perciò il magnetometro non è molto affidabile in tali situazioni.

Da ciò consegue che è difficile utilizzare in maniera utile i valori “grezzi” misurati dall’IMU.

<br>
###Soluzioni
Per riuscire a gestire i dati dell’IMU in modo efficace si possono utilizzare degli algoritmi AHRS (Attitude and Heading Reference System). Questi algoritmi sono dei filtri che fondono i dati dell’accelerometro e del giroscopio. 
Tra i filtri più utilizzati ci sono il filtro di Kalman, il filtro complementare e il filtro Mahony.
Questi filtri sono piuttosto complessi, è possibile ottenere maggiori informazioni su di essi su internet. 

<br>
###MPU 9250
Durante i nostri esperimenti è stato utilizzato il sensore MPU 9250 prodotto dalla InvenSense, il quale prevede anche il magnetometro; tuttavia, per i nostri scopi progettuali è sconsigliato il suo uso, considerando le problematiche qui sopra esposte.

Il sensore MPU 9250 presenta al suo interno una DMP (Digital Motion Processor) che filtra automaticamente i dati provenienti da accelerometro e giroscopio.
Grazie a una libreria che fa uso della DMP, siamo riusciti ad ottenere risultati accettabili per Yaw, Pitch e Roll (imbardata, beccheggio, rollio; sono gli angoli di orientazione rispetto a Z, Y, X).
Il dato più interessante per un robot mobile è lo Yaw, visto che indica la direzione verso cui si sta puntando, e purtroppo si è rilevato quello più “sporco”; questo succede perché gli assi X e Y hanno sempre come riferimento l’accelerazione gravitazionale che punta verso il basso, mentre l’asse Z, da cui deriva lo Yaw, non ha un riferimento, infatti il valore della Yaw è instabile soprattutto quando l’IMU rimane ferma.

<br>
###Conclusioni
Date le considerazioni qui sopra esposte, si è concluso che l’IMU non è molto utile per il nostro progetto. Una sua applicazione più sensata è in un pendolo inverso, ad esempio, dove vengono sfruttati Pitch e Roll, che sono relativamente affidabili.
Nel nostro robot si potrebbe usare l’IMU insieme agli encoder tramite una fusione sensoriale (l’IMU è utile quando si cambia direzione, gli encoder sono utili quando si va in linea retta). In futuro si valuterà se utilizzare questa soluzione o meno, considerando che non sarà facile fondere i dati provenienti dalle due fonti diverse.