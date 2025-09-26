.PHONY: all clean chapter

OUTPUT_DIR = build
LATEX = latexmk -xelatex -halt-on-error

all: build book

build:
	mkdir -p $(OUTPUT_DIR)

# Rule to compile the entire book (3-pass compilation)
book: main.tex
	@echo "Building full project: main.pdf..." # Add custom message
	@$(LATEX) -output-directory=$(OUTPUT_DIR) $< > $(OUTPUT_DIR)/log_temp.txt 2>&1; \
	STATUS=$$?; \
	if [ $$STATUS -ne 0 ]; then \
		echo "--- Compilation Failed for main.tex (Exit Code $$STATUS) ---"; \
		tail -n 20 $(OUTPUT_DIR)/log_temp.txt; \
		echo "-------------------------------------------------------------------"; \
		echo "For more detailed information check $(OUTPUT_DIR)/log_temp.txt"; \
		rm -f $(OUTPUT_DIR)/log_temp.txt; \
		exit 1; \
	fi; \

	@echo "Operation ended succesfully"

clean:
	rm -rf $(OUTPUT_DIR)

# Rule to compile a single chapter
chapter:
	@if [ -z "$(file)" ]; then echo "Error: Please specify the chapter file. Example: make chapter file=wstep"; exit 1; fi
	mkdir -p $(OUTPUT_DIR)/single
	@echo "\input{../../utils/preamble.tex}" > $(OUTPUT_DIR)/single/$(file).tex
	@echo "\addbibresource{../../utils/references.bib}" >> $(OUTPUT_DIR)/single/$(file).tex
	@echo "\begin{document}" >> $(OUTPUT_DIR)/single/$(file).tex
	@echo "\input{../../chapters/$(file).tex}" >> $(OUTPUT_DIR)/single/$(file).tex
	@echo "\printbibliography" >> $(OUTPUT_DIR)/single/$(file).tex  # <-- You need this to display citations
	@echo "\end{document}" >> $(OUTPUT_DIR)/single/$(file).tex
	@echo "Building single chapter $(file).tex"
	@cd $(OUTPUT_DIR)/single && \
	( \
	  $(LATEX) $(file).tex > log_temp.txt 2>&1; \
	  STATUS=$$?; \
	  if [ $$STATUS -ne 0 ]; then \
	    echo "--- Compilation Failed for $(file).tex (Exit Code $$STATUS) ---"; \
	    tail -n 20 log_temp.txt; \
	    echo "-------------------------------------------------------------------"; \
		echo "For more detailed information check build/single/$log_temp.txt"; \
	    exit 1; \
	  fi; \
	)
	@echo "Operation ended succesfully"
