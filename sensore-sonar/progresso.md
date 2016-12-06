#Piano di lavoro per lo studio del Sensore a Ultrasuoni [(HC-SR04)](http://www.micropik.com/PDF/HCSR04.pdf)

**09/11/16**
- Download libreria [NewPing](https://bitbucket.org/teckel12/arduino-new-ping/wiki/Home) e studio dei metodi della classe NewPing
- Verifica della stabilità del sensore (Nel rilevamento)
- Comportamento per brevi distanze
- Problematica dell'angolo di incidenza del ping
- Problematica dell'interferenza tra moduli posti in parallelo


**14/11/16**
- verificata la stabilità ed il comportamento per le lunghe distanze
- verificato il corretto funzionamento di più moduli posti in parallelo, non vi è interferenza in alcun modo
- analisi in tempo reale con plot del funzionamento di due moduli posti in parallelo
- trattata la problematica dell'angolo di incidenza variando l'agolazione della superficie di riflessione, verticalmente ed orizzontalmente. Essendo il pin e l'echo conici, in entrambe le direzioni l' angolazione massima che fornisce una certa sicurezza
nel rilevamento è 30°. I dati sono stati trattati e si dispone di una dozzina di file csv che ne testimoniano il funzionamento
- il cono di rilevamento è di 15°

Manca:
- Prove su diverse superfici (mancanza di materiale). Sarebbe interessante fare una prova con una scatola di uova per vedere quanto l' ultrasuono viene riflesso, la risposta del sensore, e quanto viene invece assorbito. Essendo una prova marginale verrà svolta in separata sede come prova aggiuntiva.

La pagina [ElettronicaOpenSource/Sonar](http://it.emcelettronica.com/realizzazione-di-un-rilevatore-sonar-con-arduino) contiene informazioni che potranno risultare utili nello studio delle caratteristiche di questo modulo.

Sono state provate tutte le diverse soluzioni riguardanti il modulo e le sue problematiche. Il gruppo si appresta a comporre la relazione riassuntiva.
