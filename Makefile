all: main.pdf

INCLUDEs := $(wildcard ./include/*)
GRAPHs   := $(wildcard ./graphs/*)

%.pdf: %.tex $(INCLUDEs) $(GRAPHs)
	pdflatex -synctex=1 -interaction=nonstopmode $<
	pdflatex -synctex=1 -interaction=nonstopmode $<

.PHONY: clean
clean:
	find . \( -name "*.aux" -o -name "*.log" -o -name "*.nav" -o \
	          -name "*.out" -o -name "*.snm" -o -name "*.toc" -o -name "*.synctex.gz" -o \
	       \( -name "*.pdf" -a -not -path "./graphs/*" \) \) | xargs $(RM)

.PHONY: update
update:
	git submodule update --init && cd include && git checkout master && git pull