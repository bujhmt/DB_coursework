
from threading import Thread
import time


class newThread(Thread):
   def __init__(self, function):
      Thread.__init__(self)
      self.function = function
      self.name = function.__name__
      self.target = function

   def run(self):
      print("Starting " + self.name)
      self.function()
      print("Ended " + self.name)


def print1():
   while True:
      print(1)
      time.sleep(1)


thread1 = newThread(print1)
thread1.start()
