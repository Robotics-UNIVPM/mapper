import sys, serial, argparse
import numpy as np
from time import sleep
from collections import deque
import matplotlib.pyplot as plt
import matplotlib.animation as animation


# plot class
class AnalogPlot:
  # constr
  def __init__(self, strPort, maxLen):
      # open serial port
      self.ser = serial.Serial(strPort, 9600) #initialize serial port from parameter passed by args

      self.ax = deque([0.0]*maxLen) 
      self.ay = deque([0.0]*maxLen)
      self.maxLen = maxLen

  # add to buffer
  def addToBuf(self, buf, val):
      if len(buf) < self.maxLen:
          buf.append(val)
      else:
          buf.pop()
          buf.appendleft(val)

  # add data
  def add(self, data):
      assert(len(data) == 2)
      self.addToBuf(self.ax, data[0])
      self.addToBuf(self.ay, data[1])

  # update plot
  def update(self, frameNum, a0, a1):
      try:
          line = self.ser.readline()
	  print 'readline(): ' + str(line)
          data = [val for val in line.split()]
          # print data
          if(len(data) == 2):
          	self.add(data)
          	a0.set_data(range(self.maxLen), self.ax)
          	a1.set_data(range(self.maxLen), self.ay)
      except KeyboardInterrupt:
          print('exiting')

      return a0, a1
				
  # clean up
  def close(self):
      # close serial
      self.ser.flush()
      self.ser.close()

# main() function
def main():
  # create parser
  parser = argparse.ArgumentParser(description="LDR serial")
  # add expected arguments
  parser.add_argument('--port', dest='port', required=True)

  # parse args
  args = parser.parse_args()

  #strPort = '/dev/ttyACM0'
  strPort = args.port

  print('reading from serial port %s...' % strPort)

  # plot parameters
  analogPlot = AnalogPlot(strPort, 100)

  print('plotting data...')

  # set up animation
  fig = plt.figure()
  ax = plt.axes(xlim=(0, 100), ylim=(0, 1023))
  a0, = ax.plot([], [])
  a1, = ax.plot([], [])
  anim = animation.FuncAnimation(fig, analogPlot.update,
                                 fargs=(a0, a1),
                                 interval=50)

  # show plot
  plt.show()

  # clean up
  analogPlot.close()

  print('exiting.')


# call main
if __name__ == '__main__':
  main()



#In questo esempio vengono plottati due segnali (per modificare questa funzione bisogna aggiungere il numero di variabili
#desiderate all'interno della classe e modificare sia i metodi nel quale viene forzato il funzionamento del programma alla
#sola presenza di due elementi nella lista data, con: assert(len(data) == 2). Di seguito vengono fatti altri controlli simili
#con strutture condizionali. In più bisogna lavorare con più variabili anche quando viene gestito il plot che attualmente
#funziona solamente con le variabili a0 e a1). In caso di necessità mi assumo volentieri l'incarico di modificare e testare
#lo script.

#Per lanciare lo script, da terminale, nella stessa cartella di dove si trova il file eseguire: 
#	python serial_analog_plot.py --port 'nome della porta seriale'
#Il nome della porta personalmente varia in base al dispositivo attaccato, generalmente di tratta di /dev/ttyUSB0 o /dev/ttyACM0


#Per ricevere in questo modo i dati il file arduino deve anch' esso stampare in seriale due dati che vengono poi splittati dallo
#script e plottati. Per il sensore ad ultrasuoni ad esempio il programma di gestione è lo stesso ma una volta elaborato il
#segnale invece che stampare sequenzialmente "distanza", distanza, "cm", dividere opportunamente i due valori da plottare come
#nell' esempio seguente:
#	Serial.print(distanza); Serial.print(" "); Serial.print(time); Serial.print("\n");
#è importante includere \n alla fine per andare a capo in quanto la funzione della libreria serial di python legge l'intera
#riga e splitta quello che ci trova dentro. Perciò andare a capo divide automaticamente le coppie di dati.

