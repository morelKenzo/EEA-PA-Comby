#!/usr/bin/env python3

import subprocess

class Noeud(object):
    def __init__(self,p=0,left=None,right=None,code='',name=''):
        self.left = left
        self.right= right
        if left != None and right != None :
            self.p = left.p + right.p
            self.name =left.name+right.name
        else:
            self.p = p
            self.name = name
        self.code = code
    def __lt__(self,other):
        return self.p<other.p
    def __repr__(self):
        return self.name

def create_tree(table_noeud):
    queue = table_noeud.copy()
    while len(queue) > 2:
        queue.sort()
        l=queue.pop(0)
        r=queue.pop(0)
        queue.append(Noeud(left=l,right=r))
    root= Noeud(left=queue[0],right=queue[1])
    return root

def gen_code(node,prefix=''):
    def gen_code_rec(node,prefix=''):
        if node.left != None:
            node.code = prefix
            t_1 = gen_code(node.left,prefix+'0')
            t_2 = gen_code(node.right,prefix+'1')
            return [*t_1,*t_2]
        else:
            node.code = prefix
            return (node.name,node.code)

    x = gen_code_rec(node,prefix)
    return x
#affichage à l'aide de graphviz
def draw_tree(node):
    if len(node.name) == 1: # feuille
        desc ='N{} [label="{}:{}",\
               fontcolor=blue, fontsize=16,\
               width=2, shape=box];\n'.format(node.code, node.name, node.code)
    else:
        desc = 'N{} [label="{}"];\n'.format(node.code,node.code)
        desc += draw_tree(node.left)
        desc += draw_tree(node.right)
        desc += 'N{}:n -> N{}:e;\n'.format(node.code,node.left.code)
        desc += 'N{}:s -> N{}:e;\n'.format(node.code,node.right.code)
    return desc

def make_tree():
    with open('graph.dot','w') as f:
        f.write('digraph G {\n ')
        f.write(' splines=ortho \n')
        f.write('rankdir=RL;\n')
        f.write(draw_tree(root_node))
        f.write('{rank =same; N' + '; N'.join([n.code for n in table_noeud]) +';}\n')
        f.write('}')
    subprocess.call('dot -Tpng graph.dot -o graph.png', shell=True)

def decode_huffman(reverse, code):
    res =""
    while code:
        for k in reverse:
            if text.startswith(k):
                res +=reverse[k]
                text = text[len(k):]
    return res

table = [('A', 25),('B', 20),('C', 15),('D', 12),
         ('E', 10),('F', 8),('G', 5),('H', 5)]
table_noeud = [Noeud(name=x[0],p=x[1]) for x in table]
root_node= create_tree(table_noeud)
x= gen_code(root_node)
reverse_huffman = {x[i+1]:x[i] for i in range(0,len(x)-1,2)}
print(table_huffman)
