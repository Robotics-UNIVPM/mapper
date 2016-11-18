#Encoder per determinare l'orientazione

I kit attuali sono dotati di dischi forati per encoder ottici sulle due ruote
motrici in configurazione differenziale, assumiamo rotolamento perfetto su
superficie piana di entrambe le ruote e rigidità infinita delle parti
meccaniche, oltre che di conoscerne le dimensioni esatte.

Lo scopo di queste considerazioni geometriche è valutare l'efficacia dei sensori
ottici nella determinazione dell'orientazione.

- N = numero di fori
- R = raggio delle ruote
- D = distanza tra i centri delle ruote (tra i punti di contatto ideali con il
	suolo)

La risoluzione sulla misura della rotazione è l'angolo in radianti compreso tra
due rising edge successivi, pari a

E_r = 2π / N

Questo si traduce in un intervallo lungo l'ascissa curvilinea di ciascuna ruota
pari a

E = E_r*R = 2πR / N

Se il robot è fermo potremmo conoscere la direzione in cui punta a meno di

± ε = ± (E/2) / (D/2)  = ± 2π R / (ND)

<img src="https://cloud.githubusercontent.com/assets/3638098/20029153/43a2dd66-a345-11e6-988c-6cfd462c29e8.jpg" width="500">


Allo stato attuale:

N = 20,
R = 3.5 cm,
D = 12 cm

ε ≅ 0.029 π rad = 5.2°

Questo significa che anche prima di muoversi il robot non sa dove sta puntando
in un campo largo più di 10°.
Assumendo di poter controllare perfettamente la velocità di entrambi i motori
durante uno spostamento rettilineo di un metro ci ritroveremo da qualche parte
su un arco di ampiezza

2ε * 1m = 18 cm

Nelle condizioni ipotizzate, all'interno di questo range la distribuzione è
proporzionale a quella dello sfasamento tra gli encoder destro e sinistro
(triangolare).

<img src="https://cloud.githubusercontent.com/assets/3638098/20029191/4079a47a-a346-11e6-9397-e1c3e50a8192.JPG" width="300">



Potrebbero essere realizzabili degli algoritmi che determinino questo sfasamento
per apportare correzioni intelligenti, manca comunque la precisione nelle
parti meccaniche sopratutto per i kit di basso costo attualmente utilizzati.

Per ora sembra essenziale utlizzare un altro sistema, il candidato più valido è
un IMU con magnetometro, per avere come riferimento assoluto il campo magnetico
terrestre.

Un'altra conclusione che si può trarre è che si ha maggiore precisione (e quindi controllo)
sulla direzione del veicolo se le ruote sono più distanti fra loro. 
A questo si aggiungerebbe la teorica precisione maggiore derivante da ruote più piccole 
(anche sulla distanza lineare) se non fosse che ruote più piccole sono più sensibili a
disturbi fisici e imperfezioni nel pavimento e rendono meno adatta l'approssimazione
del rotolamento perfetto.
