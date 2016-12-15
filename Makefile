# DHS_convert
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: convert/Bangladesh_V.DHS.V.women.Rout 

##################################################################

## Cribbing

Convert:
	/bin/ln -s ~/Downloads/$@ .

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk
# include $(ms)/perl.def

##################################################################

### Directories

Makefile: convert download download_scripts overview

convert:
	/bin/ln -s $(Drop)/DHS_convert $@

download:
	/bin/ln -s $(Drop)/DHS_downloads $@
download/%:
	cd download_scripts && $(MAKE) files/$*

download_scripts:
	/bin/ln -s $(gitroot)/DHS_downloads $@

overview:
	/bin/ln -s $(gitroot)/DHS_overview $@
overview/%:
	$(makethere)

##################################################################

### Unzipping

.PRECIOUS: convert/%fl.sav
convert/%fl.sav: download/%sv.zip
	unzip -d convert -LL -o $<
	touch $@

convert/zwmr70fl.sav:
convert/keir52fl.sav:

######################################################################

### Reading, trimming ...

### Get fancy filenames
-include standard.files.mk
standard.files.mk: %: overview/%
	$(copy)

convert/Bangladesh_V.DHS.V.women.Rout:

##################################################################

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
