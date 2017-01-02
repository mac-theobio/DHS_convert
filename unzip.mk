.PRECIOUS: convert/%fl.sav
convert/%fl.sav: download/%sv.zip
	unzip -d convert -LL -o $<
	touch $@

