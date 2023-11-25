#!/usr/bin/make -f
#
# Requires latexmk.
#
.PHONY: all
SHELL = /bin/bash


TEX_COMMAND = latexmk -pdf -shell-escape --quiet

TEX_FILES = $(wildcard **/**/main.tex)

PDF_FILES = $(TEX_FILES:tex=pdf)

OUTPUT_FILES =  $(subst /,-,$(dir $(PDF_FILES)))

all: reset $(PDF_FILES)

reset:
	@rm -rf ./public
	@mkdir public

$(PDF_FILES): $(TEX_FILES)
	cd ./$(dir $@); \
	$(TEX_COMMAND) $(notdir $<);
	cd ../../
	cp $@ public/$(subst /,-,$@)


clean:
	@echo -n " out log aux bbl blg dvi fdb_latexmk fls nav snm tdo toc thm vrb"|xargs -t -d ' ' -n 1 -I {} find . -iname "*.{}" -delete
	find . -iname "*flymake*" -delete
	find . -iname "*~" -delete
	find . -iname "\#*" -delete
	find . -type d  -iname 'auto' -exec rm -rf {} +

cleanall: clean
	rm -f $(PDF_FILES)
