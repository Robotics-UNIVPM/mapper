#Encoder per determinare l'orientazione

I KIT attuali sono dotati di dischi forati per encoder ottici sulle due ruote
motrici in configurazione differenziale, assumiamo rotolamento perfetto su
superficie piana di entrambe le ruote e rigidità infinita delle parti
meccaniche, oltre che di conoscerne le dimensioni esatte.

Lo scopo di questi semplici conti geometrici è valutare l'efficacia dei sensori
ottici nella determinazione dell'orientazione.

- N = numero di fori
- R = raggio delle ruote
- D = distanza tra i centri delle ruote (tra i punti di contatto ideali con il
	suolo)

La risoluzione sulla misura della rotazione è l'angolo in radianti compreso tra
due rising edge successivi, pari a

E_r = 2π / N

Questo si traduce in un errore lineare sull'ascissa curvilinea di ciascuna ruota
pari a

E = E_r*R = 2πR / N

Se il robot è fermo potremo conoscere la direzione in cui punta a meno di

± ε = ± (E/2) / (D/2)  = ± 2π R / (ND)

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

Nelle condizioni ipotizzate, all'interno di questo range la distrbuzione è
porporzionale a quella dello sfasamento tra gli encoder destro e sinistro
(gaussiana?).

Potrebbero essere realizzabili degli algoritmi che determinino questo sfasamento
per apportare correzioni intelligenti, manca comunque la precisione nelle
parti meccaniche sopratutto per i KIT di basso costo attualmente disponibili.

Per ora sembra essenziale utlizzare un altro sistema, il candidato più valido è
un IMU con magnetometro, per avere come riferimento assoluto il campo magnetico
terrestre.
