#**RELAZIONE MODULO WIfI**
 
 ***SCOPO***: <br> 
Valutare le performance fornite dal modulo wifi, sotto stress.
 
 ***SOFTWARE***:<br>
  Link al software usato:<br>
 [Sketch Test Seriale](https://github.com/Robotics-UNIVPM/mapper/blob/esp8266/modulo-wifi/test_seriale_scrittura.ino)<br>
 [Programma python per la prova con Telnet](https://github.com/Robotics-UNIVPM/mapper/blob/esp8266/modulo-wifi/test_telnet.py)
 
 ***PROCEDIMENTO E CONCLUSIONI***:<br>
Dopo aver configurato la rete che ci è servita nelle prove (schema della configurazione [qui](https://github.com/Robotics-UNIVPM/mapper/modulo-wifi/impostazioneAP.md)).
Abbiamo flashato il modulo con il firmware esp_link che ci ha permesso di utilizzare il suddetto come un collegamento trasparente tra la seriale di Arduino e qualsiasi dispositivo sia in grado di stabilire una connessione Telnet.
Il modulo dispone di un'interfaccia di configurazione web, una volta raggiunta lo abbiamo configurato e abbiamo cominciato con le prove.
Abbiamo testato il corretto funzionamento del tutto tramite alcuni sketch(il più importante in allegato), raggiungendo il modulo tramite la bash del pc con il comando telnet.
Per un corretto funzionamento bisogna ovviamente configurare con lo stesso Baud Rate sia la Seriale di Arduino, sia quella del modulo(si fa dall'interfaccia web, ha dei valori predefiniti), una volta certi del funzionamento abbiamo iniziato con i test di velocità di invio da seriale.
La velocità del tutto dipende per la maggior parte da Arduino e dalle istruzioni che sono contenute nello sketch (si vedano serial.print(), serial.write()).
Il tutto è piuttosto stabile, i test sono stati fatti ad un B.R. di 250000 ottenendo che la scelta migliore è quella di utilizzare Serial.write() che ci permette di rimanere nell'ordine di 5 microsecondi per ogni invio di singolo dato.
Le performance della rete sono indipendenti  da Arduino o dal modulo e variano in base agli apparati di rete disponibili.
