.PHONY: examples clean

CC = lualatex
PANDOC = pandoc
EXAMPLES_DIR = examples
RESUME_DIR = examples/resume
CV_DIR = examples/cv
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')

examples: $(foreach x, coverletter cv resume, $x.pdf) $(foreach x, coverletter cv resume, $x.docx)

# PDF targets
resume.pdf: $(EXAMPLES_DIR)/resume.tex $(RESUME_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

cv.pdf: $(EXAMPLES_DIR)/cv.tex $(CV_SRCS)
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

coverletter.pdf: $(EXAMPLES_DIR)/coverletter.tex
	$(CC) -output-directory=$(EXAMPLES_DIR) $<

# DOCX targets (converted from LaTeX)
resume.docx: $(EXAMPLES_DIR)/resume.tex $(RESUME_SRCS)
	$(PANDOC) $(EXAMPLES_DIR)/resume.tex -t docx -o $(EXAMPLES_DIR)/resume.docx

cv.docx: $(EXAMPLES_DIR)/cv.tex $(CV_SRCS)
	$(PANDOC) $(EXAMPLES_DIR)/cv.tex -t docx -o $(EXAMPLES_DIR)/cv.docx

coverletter.docx: $(EXAMPLES_DIR)/coverletter.tex
	$(PANDOC) $(EXAMPLES_DIR)/coverletter.tex -t docx -o $(EXAMPLES_DIR)/coverletter.docx

clean:
	rm -rf $(EXAMPLES_DIR)/*.pdf $(EXAMPLES_DIR)/*.docx $(EXAMPLES_DIR)/*.aux $(EXAMPLES_DIR)/*.log $(EXAMPLES_DIR)/*.out
