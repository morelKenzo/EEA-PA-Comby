#!/usr/bin/python3

def get_2min(l):
    min1 = 0
    min2 = 1
    for k in range(1,len(l)):
        if l[k]<=l[min1]:
            min2 = min1
            min1 = k
        elif l[k]<=l[min2]:
            min2 = k
    return min1,min2

def huffman_rec(p):
    if len(p) == 2:
        C = ['1','0']
        print(p,C)
        return C
    else:
       min1,min2 = get_2min(p)
       min1,min2 = min(min1,min2),max(min1,min2)
       print(p,min1,min2)
       p_save=p.pop(min2)
       p[min1] = p[min1]+p_save
       C = huffman_rec(p)
       C.insert(min2,C[min1]+'1')
       C[min1] +='0'
       p.insert(min2,p_save)
       p[min1] -= p_save
       return C

p = [25,20,15,12,10,8,5,5]
print(huffman_rec(p))
