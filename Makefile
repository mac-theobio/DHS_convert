# DHS_convert
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: Makefile 

##################################################################

## Cribbing

Convert:
	/bin/ln -s ~/Downloads/$@ .

## make files

Sources += Makefile .gitignore README.md stuff.mk LICENSE.md
Sources += $(wildcard *.tmp)

subdirs = convert download download_scripts

include stuff.mk

use_simple:
	$(LNF) simple.tmp local.mk

# include $(ms)/perl.def

##################################################################

### Directories

Makefile: DHS_overview
	cp $(gitroot)/DHS_overview/standard.files.mk .

## Place to keep converted files
convert: $(Drop)/DHS_convert
	$(link)
$(Drop)/DHS_convert:
	$(mkdir)

## Place to keep downloaded files (separated for space, I guess)
download: $(Drop)/DHS_downloads
	$(link)
$(Drop)/DHS_downloads:
	$(mkdir)
download/%:
	cd download_scripts && $(MAKE) files/$*

download_scripts: $(gitroot)/DHS_downloads
	$(link)

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

Sources += $(wildcard *.R)

### Get fancy filenames

-include standard.files.mk

### GPS files
.PRECIOUS: convert/%.gps.Rout
convert/%.gps.Rout: convert_gps.R

### HIV files 
.PRECIOUS: convert/%.hiv.Rout
convert/%.hiv.Rout: convert.R convert_hiv.R
	$(run-R)

### Dataset files 
.PRECIOUS: convert/%.AIS.V.adults.Rout convert/%.AIS.VI.adults.Rout
convert/%.AIS.V.adults.Rout convert/%.AIS.VI.adults.Rout: convert.R convert_dataset.R
	$(run-R)

.PRECIOUS: convert/%.DHS.IV.women.Rout convert/%.DHS.V.women.Rout convert/%.DHS.VI.women.Rout
convert/%.DHS.IV.women.Rout convert/%.DHS.V.women.Rout convert/%.DHS.VI.women.Rout: convert.R convert_dataset.R
	$(run-R)

.PRECIOUS: convert/%.DHS.IV.men.Rout convert/%.DHS.V.men.Rout convert/%.DHS.VI.men.Rout
convert/%.DHS.IV.men.Rout convert/%.DHS.V.men.Rout convert/%.DHS.VI.men.Rout: convert.R  convert_mnames.R convert_dataset.R
	$(run-R)

.PRECIOUS: convert/%.DHS.IV.cr.Rout convert/%.DHS.V.cr.Rout convert/%.DHS.VI.cr.Rout
convert/%.DHS.IV.cr.Rout convert/%.DHS.V.cr.Rout convert/%.DHS.VI.cr.Rout: convert.R  convert_dataset.R
	$(run-R)

convert/Bangladesh_V.DHS.V.women.Rout:

##################################################################

-include $(ms)/git.mk
-include $(ms)/visual.mk
-include $(ms)/linkdirs.mk

-include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
