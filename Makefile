# DHS_convert
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: convert/Bangladesh_V.DHS.V.women.Rout 

##################################################################

## For cribbing old stuff; may not currently be in use.
Convert:
	/bin/ln -s ~/Downloads/$@ .

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk
# include $(ms)/perl.def

##################################################################

### Directories

Makefile: convert download download_scripts overview

## Dropbox folder for RData files made here
convert:
	/bin/ln -s $(Drop)/DHS_convert $@

## Dropbox folder for files downloaded from DHS
## These rules won't work unless you have set up auto-downloading. Instead, download files you need from DHS into the download directory
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

## Why are these precious? Should they be kept in convert, or in download?
.PRECIOUS: convert/%fl.sav
convert/%fl.sav: download/%sv.zip
	unzip -d convert -LL -o $<
	touch $@

convert/zwmr70fl.sav:
convert/keir52fl.sav:

######################################################################

Sources += $(wildcard *.R)

### Reading, trimming ...

### Get fancy filenames
-include standard.files.mk
standard.files.mk: %: overview/%
	$(copy)

### GPS files
.PRECIOUS: convert/%.gps.Rout
convert/%.gps.Rout: convert_gps.R

### HIV files 
.PRECIOUS: convert/%.hiv.Rout
convert/%.hiv.Rout: convert.R convert_hiv.R
	$(run-R)

### Dataset files 
### Separate specifications for each phase!
### Fix (or make sure to add the next phase before it makes you crazy!)
.PRECIOUS: convert/%.AIS.V.adults.Rout convert/%.AIS.VI.adults.Rout
convert/%.AIS.V.adults.Rout convert/%.AIS.VI.adults.Rout: convert.R convert_dataset.R
	$(run-R)

.PRECIOUS: convert/%.DHS.IV.women.Rout convert/%.DHS.V.women.Rout convert/%.DHS.VI.women.Rout convert/%.DHS.VII.women.Rout
convert/%.DHS.IV.women.Rout convert/%.DHS.V.women.Rout convert/%.DHS.VI.women.Rout convert/%.DHS.VII.women.Rout: convert.R convert_dataset.R
	$(run-R)

.PRECIOUS: convert/%.DHS.IV.men.Rout convert/%.DHS.V.men.Rout convert/%.DHS.VI.men.Rout convert/%.DHS.VII.men.Rout
convert/%.DHS.IV.men.Rout convert/%.DHS.V.men.Rout convert/%.DHS.VI.men.Rout convert/%.DHS.VII.men.Rout: convert.R  convert_mnames.R convert_dataset.R
	$(run-R)

.PRECIOUS: convert/%.DHS.IV.cr.Rout convert/%.DHS.V.cr.Rout convert/%.DHS.VI.cr.Rout convert/%.DHS.VII.cr.Rout
convert/%.DHS.IV.cr.Rout convert/%.DHS.V.cr.Rout convert/%.DHS.VI.cr.Rout convert/%.DHS.VII.cr.Rout: convert.R  convert_dataset.R
	$(run-R)

##################################################################

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
