"""
Objetivo do código:
 Ler caracteres do teclado e escrever na tela.
 Se nada for escrito em alguns segundos, será disparado o timeout.
"""

import poller
import sys,time

class CallbackStdin(poller.Callback):
    
    def __init__(self, cb):
      poller.Callback.__init__(self, sys.stdin, 0)
      print("Quer mesmo apagar esses arquivos (S/N) ? \n")
      # self.disable_timeout()
      self.cb = cb

    def handle(self):
        l = sys.stdin.readline()
        self.cb.send(l)
        

class CallbackCoisa(poller.Callback):
    
    def __init__(self, tout):
        poller.Callback.__init__(self, None, tout)
        # self.disable_timeout()
  
    def envia(self, dado):
      print('Dado:', dado)
      self.reload_timeout()

    def handle_timeout(self):
        print('Tempo excedido. Arquivos apagados.')


        
obj = CallbackCoisa(1)
cb = CallbackStdin(obj)

sched = poller.Poller()
sched.adiciona(cb)
sched.adiciona(obj)

sched.despache()
