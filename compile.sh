#!/bin/bash

# Pour compiler tous les fichiers sources du dépot:

#find . -name "main.tex" -execdir sh -c "pwd  && latexmk -e '$pdflatex=q/pdflatex %O -shell-escape %S/' -pdf {} -quiet| grep Latexmk" \;
find . -name "T*.tex" -execdir sh -c "pwd  && latexmk -g -e '$pdflatex=q/pdflatex %O -shell-escape %S/' -pdf {} -quiet| grep Latexmk" \;


# 3 compilation nécessaire pour obtenir un résultat stable
find . -name "main.tex" -execdir sh -c "pwd  && pdflatex -shell-escape -interaction=batchmode {} &&pdflatex -shell-escape -interaction=batchmode {}&&pdflatex -shell-escape -interaction=batchmode {}" \;


mkdir "public"
for i in `find . -maxdepth 1 -type d -regex \.\/[0-9].*?`;do
     cp -f $i/Cours/main.pdf ./public/${i:2}.pdf;
     cp -f $i/TD/main.pdf ./public/${i:2}_TD.pdf;

done;
#clean up :
shopt -s globstar
rm -f **/*.aux **/*.log **/*.out **/*.fls **/*.fdb_latexmk **/*.toc **/*.pyg
