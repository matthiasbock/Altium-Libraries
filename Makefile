
#
# Makefile to compile all the OpenSCAD models
# in the subfolder "3d bodies"
#


SC = $(shell which openscad)

SRC = $(wildcard 3d_bodies/*.scad)
PNG = $(SRC:.scad=.png)

all: $(PNG)

clean:
	rm -f 3d_bodies/*.png

%.png: %.scad
	$(SC) "$<" -o "$@"

