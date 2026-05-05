# build as gitbook
#pushd src; make; popd;

R_LIBS := ~/R/library
RSCRIPT := R_LIBS_USER=$(R_LIBS) Rscript

install-r-deps:
	$(RSCRIPT) scripts/install-r-deps.R

book:
	$(RSCRIPT) -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook', quiet=T)";
	mkdir -p docs/appendici
	cp appendici/*.html docs/appendici/

pdf:
	$(RSCRIPT) -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book', quiet=T)";

epub:
	$(RSCRIPT) -e "bookdown::render_book('index.Rmd', 'bookdown::epub_book', quiet=T)";

all: pdf epub book

serve:
	$(RSCRIPT) -e "bookdown::serve_book(dir='.', output_dir='docs', preview=TRUE, in_session=TRUE)";

deploy: #all
	git subtree push --prefix docs https://github.com/info340/info340.github.io master
