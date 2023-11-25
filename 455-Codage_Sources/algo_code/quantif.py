#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt

N = 1000
X = np.random.rand(N)
X_c = (X - 0.5)*10

def quantif_uniforme(M,X,xmin=-1,xmax=1,d=0):
    """
    réalise la quantification uniforme d'un vecteur sur M niveau
    """
    delta = 2 * xmax/M # pas de quantification
    Q = np.zeros(len(X))
    for k in range(len(X)):
       q =  (X[k]/ delta)
       if abs(q)<d: #seuil
           Q[k] = 0
           continue
       elif abs(q)<2*delta:
           if q <0:
               Q[k] =-1
           else:
               Q[k] = 1
           continue
       else:
           Q[k] = int(q)

    return Q,delta

def reverse_quantif(Q,delta):
    return Q*delta

Q,delta = quantif_uniforme(4,X_c)
Q_2,delta = quantif_uniforme(4,X_c,d=0.5):


print(len(Q),len(X_c))
plt.figure()
plt.grid()
plt.plot(X_c,Q,'.')
plt.plot(X_c,Q_2,'.')
plt.show()


