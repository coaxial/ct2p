# combine-tif2pdf [![Build Status](https://travis-ci.org/coaxial/ct2p.svg?branch=master)](https://travis-ci.org/coaxial/ct2p)

This is a docker container whose sole purpose it to unpack an archive
containing TIFF images, prep them for OCR using textcleaner, and combine them
into a single PDF file.

Used in combination with coaxial/insaned-config, because a SBC isn't beefy
enough to handle imagemagick on more than a couple of pages.

## Usage with Mayan EDMS

The container has two directories, `dropbox`, and `processed`. When a tar.gz
file is written to `dropbox`, the container will unpack it, optimze each page
for OCR with textcleaner, and combine them to a single PDF file.

### General flow

```
+-----------+     +-----------------+       +-------------+
|           |     |                 |       |             |
|  Scanner  +-----> combine-tif2pdf +-------> Mayan EDMS/ |
|           |     |                 |       | OCR         |
+-----------+     +-----------------+       +-------------+
```

### File flow between directories

```
+-----------+   +------------------------------+  +-------------+
| ./dropbox +---> unpack => textcleaner => pdf +--> ./processed |
+-----------+   +------------------------------+  +-------------+
```

### The `dropbox` directory

Is exported by the docker container at `/ct2p/incoming`, and should be mapped
to a network share where scanned documents can be written to. The requirements
for scanned documents are:

- Must be a `tar.gz` file
- Must contain `.tif` files

The pages will be assembled in alphabetical order, from their names.
`insaned-config` names the pages with a timestamp, so they will be assembled in
the order they're scanned.

### The `processed` directory

Is exported by the docker container at `/ct2p/processed`. Files placed there
are PDF files, and can be readily ingested by Mayan EDMS. It can be automated
by instructing Mayan EDMS to watch for changes in this directory and import any
file written there.

## Limitations and TODOs

- It's more coupled than I'd like. Ideally, the scanner should do all the
  processing required for consumption by Mayan EDMS. Alas, the CHIP computer
doesn't have enough RAM or CPU power to do this in any practical way.
- Handle files that aren't `tar.gz` by checking their extension and magic
  number. Files that don't match are deleted.
- Handle other formats than `tif`. Ideally, the script should find out what
  image files are in the archive and use this list for processing.
- Works best with 300dpi grayscale images.

## Credits

Uses [GNU parallel](https://www.gnu.org/software/parallel/) by O. Tange, and
[textcleaner](http://www.fmwconcepts.com/imagemagick/textcleaner/) by Fred
Weinhaus
