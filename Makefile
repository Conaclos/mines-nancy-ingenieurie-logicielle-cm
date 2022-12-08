TMP = .temp

all: main.pdf

clear:
	rm -rf .temp
	rm main.pdf $(patsubst %.tex, %.pdf, $(wildcard fig/*.tex))

main.pdf: $(wildcard *.tex fig/*)
	# Generate tikz/*.pdf whetheir they don't exist.
	$(MAKE) empty $(patsubst %.tex, %.pdf, $(wildcard fig/*.tex))
	latexmk -Werror -outdir=$(TMP) -pdflua $<
	cp $(TMP)/$(notdir $@) $@

fig/%.pdf: fig/%.tex
	latexmk -Werror -outdir=$(TMP) -pdflua $<
	cp $(TMP)/$(notdir $@) $@

empty: ;
