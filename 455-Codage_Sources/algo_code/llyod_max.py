#!/usr/bin/env python3
import numpy as np
from scipy import integrate
from scipy.stats import norm
import matplotlib.pyplot as plt

def ddp(x):
    mean = 0; sigma = 1
    return norm.pdf(x,mean,sigma)

def quant(centroids, X):
    bornes = (centroids[:-1]+centroids[1:])/2
    bornes = np.insert(bornes,0,-np.inf)
    bornes = np.append(bornes,np.inf)
    xquant =np.zeros(len(X))
    for k in range(len(X)):
        for i in range(len(bornes)):
            if X[k]>=bornes[i] and X[k] <bornes[i+1]:
                xquant[k] = centroids[i]
    return xquant
def llyodMax(X,M,maxiter=1000,eps=1e-6):
    #répartition uniforme des bornes
    step = (np.max(X)-np.min(X))/(M-2)
    Xmin = np.min(X)
    bornes = np.array([i*step+Xmin for i in range(M-1)])
    bornes = np.insert(bornes,0,-np.inf)
    bornes = np.append(bornes,np.inf)
    centroids = np.zeros(M)
    for  it in range(maxiter):
        old_centroids = centroids.copy()
        for i in range(M): 
            centroids[i] = integrate.quad(lambda x: x*ddp(x),bornes[i],bornes[i+1])[0]\
                         /integrate.quad(lambda x: ddp(x),bornes[i],bornes[i+1])[0]
        bornes[1:-1] = (centroids[:-1]+centroids[1:])/2
        err = np.linalg.norm(centroids-old_centroids)
        if err < eps :
            break
    return centroids    

M = 4
X = np.random.normal(0,1,1000)
centroids = llyodMax(X,M)
bornes = (centroids[:-1]+centroids[1:])/2
bornes = np.insert(bornes,0,-np.inf); bornes = np.append(bornes,np.inf)
plt.figure()
plt.plot(X)
plt.plot(quant(bornes,X))
plt.show()