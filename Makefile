PANDOC ?= pandoc

SRC := workshop.md
PDF := workshop.pdf

PANDOC_FLAGS := --standalone --from markdown --to latex --shift-heading-level-by=-1

.PHONY: serve pdf clean

serve:
	slipshow serve presentation.md

$(TEX): $(SRC)
	$(PANDOC) $(PANDOC_FLAGS) --output $@ $<

pdf: $(PDF)

$(PDF): $(SRC)
	$(PANDOC) $(PANDOC_FLAGS) --pdf-engine=tectonic --output $@ $<

clean:
	rm -f $(PDF)
