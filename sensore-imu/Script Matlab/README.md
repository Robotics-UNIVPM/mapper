##Script Matlab
Lo script Matlab dovrebbe essere abbastanza comprensibile, è diviso in sezioni e sono presenti tanti commenti.<br>
I file *one_minutes.csv* e *five_minutes.csv* sono stati ottenuti utilizzando lo script Python [*serialread.py*](../../../tree/master/tools/serialread.py).<br>
In particolare, 
- *one_minutes.csv* è un file di circa 60 secondi di dati, presi alla frequenza massima possibile (l'intervallo di tempo tra una misura e la successiva è circa 10 ms)
- *five_minutes.csv* è un file di circa 300 secondi di dati, presi a una frequenza di 20 Hz (l'intervallo di tempo tra una misura e la successiva è circa 50 ms). Si è scelto di diminuire la frequenza per non avere troppi dati: attualmente il file ha circa 5000 righe di valori, se avessimo utilizzato la frequenza massima avremmo ottenuto un file di circa 25'000 righe
