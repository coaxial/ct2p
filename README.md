# combine-tif2pdf

This is a docker container whose sole purpose it to unpack an archive
containing TIFF images, prep them for OCR using textcleaner, and combine them
into a single PDF file.

Used in combination with coaxial/insaned-config, because a SBC isn't beefy
enough to handle imagemagick on more than a couple of pages.

## Credits

Uses GNU parallel by O. Tange, and textcleaner by Fred Weinhaus
