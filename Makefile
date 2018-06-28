all: main.pdf

GRAPHs := $(wildcard ./graphs/*)

%.pdf: %.tex $(GRAPHs)
	pdflatex -synctex=1 -interaction=nonstopmode $<

.PHONY: clean
clean:
	find . \( -name "*.aux" -o -name "*.log" -o -name "*.nav" -o \
	          -name "*.out" -o -name "*.snm" -o -name "*.toc" -o -name "*.synctex.gz" \) -o \
	       \( -name "*.pdf" -a -not -path "./graphs/*" \) | xargs $(RM)
