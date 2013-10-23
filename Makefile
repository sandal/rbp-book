output/book.epub: output/OEBPS/content.opf output/mimetype output/OEBPS/figs/web output/OEBPS/images/callouts/16.png OEBPS/covers/9780596523008_lrg.jpg
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
	echo -n "application/epub+zip" > $@
output/OEBPS/content.opf: output docbook-xsl-1.78.1/epub/docbook.xsl
	cd output; xsltproc ../docbook-xsl-1.78.1/epub/docbook.xsl ../oreilly_final/book.xml
docbook-xsl-1.78.1/epub/docbook.xsl: docbook-xsl-1.78.1.tar.bz2
	tar xjf $^
docbook-xsl-1.78.1.tar.bz2:
	wget http://downloads.sourceforge.net/project/docbook/docbook-xsl/1.78.1/$@
output/OEBPS/images/callouts/16.png: output/OEBPS/images/callouts
	cd output/OEBPS/images/callouts; make; make destroy
output/OEBPS/images/callouts: output/OEBPS/images/callouts-master clean-master-zip
	mv $< $@
clean-master-zip:
	rm -f output/OEBPS/images/master.zip
output/OEBPS/images/callouts-master: output/OEBPS/images/master.zip
	cd output/OEBPS/images/; unzip master.zip
output/OEBPS/images/master.zip: output/OEBPS/images
	wget -P $^ https://github.com/yazgoo/callouts/archive/master.zip
output/OEBPS/images:
	mkdir -p $@
OEBPS/covers/9780596523008_lrg.jpg: output/OEBPS/covers
	wget -P $^ http://abdessel.iiens.net/9780596523008_lrg.jpg
output/OEBPS/covers:
	mkdir -p $@
output:
	mkdir output
clean:
	rm -rf output
distclean:
	rm -rf docbook-xsl-1.78.1* epubcheck-3.0.1*
