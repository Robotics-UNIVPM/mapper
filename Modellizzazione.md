Prima di mettere insieme il nostro robot dobbiamo studiare individualmente le componenti che lo costituiscono.
Questo serve per conoscere i limiti fisici delle parti considerate individualmente per guidare la progettazione in modo più "scientifico".

I blocchi da considerare sono:

- IMU
- Motori DC (comprensivi di ingranaggi)
- Alimentazione
- Sensori a ultrasuoni
- Modulo per trasmissione dati in real-time
- Scheda Arduino

#IMU
Una volta scelto il chip I datasheet dovrebbero essere soddisfacenti.
Abbiamo parlato di:
- MPU6050
- MPU9250 (include magnetometro)
...

#Motori DC
Vogliamo approssimare un modello dinamico dei nostri motori.
Qui si giocano molti fattori, si tratta di scegliere quali possiamo trascurare e quanto tempo vale la pena spenderci.
Sperimentalmente si dovranno tracciare delle curve di corrente e di velocità a regime, al variare di tensione e carico.
L'apparato potrebbe essere costituito da una carrucola tramite la quale si solleverà una massa nota.
Il motore alimentato da un generatore di tensione variabile con amperometro integrato.
la velocità di sollevamento può essere misurata in vari punti, con un encoder sull'asse del motore o linearmente.
C'è da fare attenzione a non introdurre attriti eccessivi.
Se ne potrebbero tirare fuori le matrici della dinamica se il sistema si comporta bene.

Sono marginalmente interessanti anche i valori di picco di corrente in partenza, frenata e inversione (forse stallo).

#Alimentazione
Per comodità si intende usare un powerbank per alimentare a 5V l'intero sistema. 
È fondamentale assicurarsi che fornisca una tensione stabile al variare della carica e della corrente erogata.

#Sensore Ultrasuoni
Abbiamo disponibili HC-SR04, sensori ad ultrasuoni di fascia bassa. 
Sarà tramite questi che saranno acquisiti i dati per la mappatura.
É imporante conoscerne la sensibilità, la risoluzione e il "campo visivo" in modo più dettagliato possibile.
Ci sono da condurre prove con ostacoli di diversi materiali, forme e dimensioni posti a varie distanze e orientazioni

#Trasmissione dei dati
Abbiamo a disposizione ESP8266 e alcuni moduli bluetooth di cui misurare le prestazioni e la facilità di utilizzo.

#Scheda Arduino
Bisogna verificare che questa abbia potenza di calcolo e memoria sufficiente per coordinare le varie parti del sistema.
