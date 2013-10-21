output/book.epub: output/OEBPS/content.opf output/mimetype output/OEBPS/figs/web
	cd output; zip -0Xq  book.epub mimetype && zip -Xr9D book.epub * && echo ebook in $@
check: epubcheck-3.0.1/epubcheck-3.0.1.jar output/book.epub 
	java -jar $^
epubcheck-3.0.1/epubcheck-3.0.1.jar: epubcheck-3.0.1.zip
	unzip -u $^
epubcheck-3.0.1.zip:
	wget https://github.com/IDPF/epubcheck/releases/download/v3.0.1/$@
output/OEBPS/figs/web:
	mkdir -p $@ && cp oreilly_final/figs/* $@
output/mimetype:
	echo "application/epub+zip" > $@
output/OEBPS/content.opf: output docbook-xsl-1.78.1/epub/docbook.xsl
	cd output; xsltproc ../docbook-xsl-1.78.1/epub/docbook.xsl ../oreilly_final/book.xml
docbook-xsl-1.78.1/epub/docbook.xsl: docbook-xsl-1.78.1.tar.bz2
	tar xjf $^
docbook-xsl-1.78.1.tar.bz2:
	wget http://downloads.sourceforge.net/project/docbook/docbook-xsl/1.78.1/$@
output:
	mkdir output
clean:
	rm -rf output
distclean:
	rm -rf docbook-xsl-1.78.1* epubcheck-3.0.1*
