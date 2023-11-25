#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt
from scipy.spatial import Voronoi, voronoi_plot_2d
#initialisations clusters
M = 20;
N =100; #point par cluster
K = N*M
means = np.random.rand(M,2)*10
X = np.zeros((K,2))
plt.figure()
cov = np.array([[1,0],[0,1]])
for m in range(M):
    xi = np.random.multivariate_normal(means[m,:],cov,N)
    X[m*N:(m+1)*N] = xi
    plt.plot(xi[:,0],xi[:,1],'+')
plt.plot(means[:,0],means[:,1],'ob')
mean= np.mean(X,axis=0)
Y0 = np.random.multivariate_normal(mean, 10*cov, M)
plt.show()
Y0= means #triche
plt.plot(Y0[:,0],Y0[:,1],'ok')
plt.show()
def LBG(X,Y0,eps=1e-5,maxiter=1000):
    Y = Y0.copy()
    old_dist = np.inf
    cluster_index = np.zeros(K,dtype=int)
    for l in range(maxiter):
        dist= 0;
        for k in range(len(X)):
            quant_min =np.inf
            for j in range(len(Y)):
                if np.linalg.norm(X[k]-Y[j]) <np.linalg.norm(X[k]-quant_min):
                    quant_min = Y[j]
                    cluster_index[k] = j
            dist += sum((X[k]-quant_min)**2)
        for j in range(len(Y)):
            Y[j,:] = np.mean(X[cluster_index==j],axis=0)
        if dist-old_dist < eps:
            break
        else:
            old_dist = dist
    return Y
Y = LBG(X,Y0)
vor = Voronoi(Y)# black magic
voronoi_plot_2d(vor,show_vertices=False)
plt.plot(X[:,0],X[:,1],'+')
plt.plot(Y[:,0],Y[:,1],'ob')           
plt.plot(Y0[:,0],Y0[:,1],'ok')  
plt.show()        