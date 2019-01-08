TEMPLATE := Beamer

all: main.pdf

%.pdf: %.tex
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<

.PHONY: clean
clean:
	find . -maxdepth 1 \
		\( -name "*.aux" -o -name "*.bbl" -o -name "*.blg" -o \
	           -name "*.log" -o -name "*.out" -o -name "*.pdf" -o \
		   -name "*.nav" -o -name "*.snm" -o -name "*.toc" -o \
		   -name "*.vrb" -o -name "*.synctex.gz" \) | xargs $(RM)

.PHONY: template-update style-update

DOC_ROOT := $(shell pwd)
GIT_ROOT := $(shell git rev-parse --show-toplevel)

template-update:
	-git add -A && git commit -m "Checkpoint before template update [ci skip]." && git push
	 cd $(GIT_ROOT) && git subtree pull \
		--prefix=$(shell python -c "import os.path; print os.path.relpath('$(DOC_ROOT)', '$(GIT_ROOT)')") \
		https://github.com/ArmageddonKnight/$(TEMPLATE) master --squash

style-update:
	wget http://ctan.mirror.rafal.ca/macros/latex/contrib/xurl/latex/xurl.sty -O xurl.sty
