## Get fancy filenames
#### (Still haven't figured out how to chain to make standard.files.mk without creating problems)
-include DHS_overview/standard.files.mk

## unzip rule (could just be here I guess)
include unzip.mk

## Download (go to that directory)
download/%:
	cd download_scripts && $(MAKE) files/$*

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

-include $(ms)/wrapR.mk
