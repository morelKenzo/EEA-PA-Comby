#!/usr/bin/env python3

import numpy as np

X=[0,1,0,0,1,0,0,0,0,0]

def binary(n,m,b=2):
#    Convertie un nombre décimal en sa version binaire tronqué à m bits.
    binaire= np.floor(n*b**m) # on se décale dans les entiers et on floor
    return binaire,np.binary_repr(int(binaire))

def arithm(X,p):
    l=[0]; h= [1]
    for x in X:
        if x == 0:
            h.append(l[-1]+p*(h[-1]-l[-1]))
            l.append(l[-1])
        else:
            l.append(l[-1]+p*(h[-1]-l[-1]))
            h.append(h[-1])
            lmb = (l[-1]+h[-1])/2
            mu = int(-np.log2(h[-1]-l[-1]))+1
    code = binary(lmb,mu)
    return code,lmb,mu

def arithm_pratique(X,p):
    l = [0]; h =[1] ;f = 0;c =[] #inf, sup,follow, code
    for k in range(len(X)):
        print("for loop")
        if X[k] == 0:
            l.append(l[-1])
            h.append(l[-1]+p*(h[-1]-l[-1]))
        else:
           l.append(l[-1]+p*(h[-1]-l[-1]))
           h.append(h[-1])
        while ((l[-1]>=0 and h[-1]<0.5) or (l[-1]>=0.5 and h[-1]<1) or (l[-1]>= 0.25 and h[-1]<0.75)):
            if (l[-1]>=0 and h[-1]<0.5):
                c += [0]+[1]*f
                l[-1] *=2
                h[-1] *=2
            elif (l[-1]>=0.5 and h[-1]<1):
                c += [1]+[0]*f
                l[-1] = 2*l[-1]-1
                h[-1] = 2*h[-1]-1
            elif (l[-1]>= 0.25 and h[-1]<0.75):
                f +=1
                l[-1] = 2*l[-1]-0.5
                h[-1] = 2*h[-1]-0.5
    return c
print(arithm_pratique(X,p))
