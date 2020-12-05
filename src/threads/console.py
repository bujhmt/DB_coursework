# from tkinter import *
# import threading
#
# class FakeConsole(Frame):
#     def __init__(self, root, *args, **kargs):
#         Frame.__init__(self, root, *args, **kargs)
#
#         #white text on black background,
#         self.text = Text(self, bg="black", fg="white")
#         self.text.pack()
#
#         #list of things not yet printed
#         self.printQueue = []
#         self.printQueueLock = threading.Lock()
#         self.after(5, self.__on_idle)
#
#     #check for new messages every five milliseconds
#     def __on_idle(self):
#         with self.printQueueLock:
#             for msg in self.printQueue:
#                 self.text.insert(END, msg)
#                 self.text.see(END)
#             self.printQueue = []
#         self.after(5, self.__on_idle)
#
#     #print msg to the console
#     def show(self, msg, sep="\n"):
#         with self.printQueueLock:
#             self.printQueue.append(str(msg) + sep)
#
# def makeConsoles(amount):
#     root = Tk()
#     consoles = [FakeConsole(root) for n in range(amount)]
#     for c in consoles:
#         c.pack()
#     threading.Thread(target=root.mainloop).start()
#     return consoles

from subprocess import call, ne

call('python Threads.py', creationflags=CREATE_NEW_CONSOLE)
