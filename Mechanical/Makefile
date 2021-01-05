NAME := eurorack-cv-gate-breakout-module

ALL := \
	exports/${NAME}-panel.dxf \
	exports/${NAME}-panel.svg \
	exports/${NAME}-panel.stl \
	exports/${NAME}-assembly.stl

.PHONY: all clean

all: ${ALL}

exports/${NAME}-panel.dxf exports/${NAME}-panel.svg: exports/export-panel-2d.scad ${NAME}.scad
	openscad -o $@ $<

exports/${NAME}-panel.stl: exports/export-panel-3d.scad ${NAME}.scad
	openscad -o $@ $<

exports/${NAME}-assembly.stl: exports/export-assembly-3d.scad ${NAME}.scad
	openscad -o $@ $<

clean:
	rm -f ${ALL}
