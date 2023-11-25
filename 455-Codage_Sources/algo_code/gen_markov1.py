#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jan 28 12:31:21 2019

@author: pac
"""

import numpy as np
P = [[0.8,0.1,0.1],[0.1,0.7,0.2],[0.1,0.2,0.7]]
def get_state(p,cump):
    print(p, cump)
    for i in range(len(cump)):
        if p < cump[i]:
            return i

def gen_markov1(N,P,init_state=0):
    cumP = np.cumsum(P,1)
    states = [init_state]
    p = np.random.rand(N)
    for k in range(N):
         states.append(get_state(p[k],cumP[states[-1]]))
    return states
print(gen_markov1(100,P,init_state=1))
