#!/usr/bin/env python3

import numpy as np

univers = ['a','b','c']
message = "aabababac"

def code_LZW(message, univers):
    msg = message
    dictionnaire = dict(zip(univers,[i for i in range (len(univers))]))
    w=""
    code =[]
    for c in msg:
        wc = w+c
        if wc in dictionnaire:
            w =wc
        else:
            code.append(dictionnaire[w])
            dictionnaire[wc] = len(dictionnaire)
            w = c
    if w:
        code.append(dictionnaire[w])
    return code,dictionnaire

def decode_LZW(code,univers):
    dictionnaire = dict(zip([i for i in range(len(univers))],univers))
    w = dictionnaire[code.pop(0)]
    msg = [w]
    for k in code:
        if k in dictionnaire:
            entry = dictionnaire[k]
        elif k == len(dictionnaire):
            entry = w +w[0]
        msg.append(entry)
        dictionnaire[len(dictionnaire)] = w+entry[0]
        w = entry
    print(dictionnaire)
    return ''.join(msg)

code,dictionnaire = code_LZW(message,univers)
msg = decode_LZW(code, univers)
print(code, dictionnaire, msg)
