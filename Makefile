# DHS_convert
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: convert/Kenya_IV.DHS.IV.men.Rout

##################################################################

## Cribbing
Convert:
	/bin/ln -s ~/Downloads/$@ .

## make files

Sources += Makefile .gitignore README.md stuff.mk LICENSE.md notes.txt
Sources += $(wildcard *.tmp)

# subdirs = convert download download_scripts DHS_overview

include stuff.mk

use_simple:
	$(LNF) simple.tmp local.mk

# include $(ms)/perl.def

##################################################################

### Directories

## Place to keep converted files
convert: DHS_convert_drop download download_scripts
	$(link)

## Place to keep downloaded files (separated for space, I guess)

download_scripts: $(gitroot)/DHS_downloads
	$(link)

download: $(Drop)/DHS_downloads
	$(link)


##################################################################

### Unzipping

Sources += unzip.mk
include unzip.mk

convert/zwmr70fl.sav:
convert/keir52fl.sav:

######################################################################

### Reading, trimming ...

Sources += $(wildcard *.R)

## Careful with dependencies here (don't want to re-download bunches of files)
Sources += convert.mk
convert/%.Rout:
	$(MAKE) convert download download_scripts DHS_overview
	$(MAKE) -f convert.mk $@

convert/Bangladesh_V.DHS.V.men.Rout:

##################################################################

-include $(ms)/git.mk
-include $(ms)/visual.mk
-include $(ms)/linkdirs.mk

-include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
