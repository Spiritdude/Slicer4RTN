SLICER=slic3r
#SLICER=CuraEngine

all::	stl gcode

stl::
	openscad cube.scad -o cube.stl
	openscad sphere.scad -o sphere.stl
	openscad overhang-out.scad -o overhang-out.stl
	openscad overhang-in.scad -o overhang-in.stl
	openscad overhang-inout.scad -o overhang-inout.stl
	openscad overhang3l4mm.scad -o overhang3l4mm.stl

gcode::
	../slicer4rtn --recenter --subdivide=5 cube.stl   
	../slicer4rtn --recenter --subdivide=5 --axis=3 --output=cube-axis=3.gcode cube.stl   
	../slicer4rtn --recenter --subdivide=5 --axis=3 --rot-fixed=90 --output=cube-rot=90-axis=3.gcode cube.stl   
	../slicer4rtn --recenter --subdivide=5 --axis=3 --rot-fixed=-45 --output=cube-rot=-45-axis=3.gcode cube.stl   
	../slicer4rtn --recenter --subdivide=5 --axis=3 --angle=25 --output=cube-25deg-axis=3.gcode cube.stl   
	../slicer4rtn sphere.stl
	../slicer4rtn --subdivide=4 overhang-out.stl
	../slicer4rtn --subdivide=4 --mode=inside overhang-in.stl
	#../slicer4rtn --subdivide=4 overhang-inout.stl  # -- not yet possible 

gcode-settings::
	../slicer4rtn --slicer=${SLICER} --recenter --subdivide=5 cube.stl --output=cube-lh=0.1.gcode --layer-height=0.1
	../slicer4rtn --slicer=${SLICER} --recenter --subdivide=5 cube.stl --output=cube-lh=0.2.gcode --layer-height=0.2
	../slicer4rtn --slicer=${SLICER} --recenter --subdivide=5 cube.stl --output=cube-lh=0.3.gcode --layer-height=0.3

slicers::
	../slicer4rtn --recenter --subdivide=5 cube.stl --slicer=slic3r --output=cube-slic3r.gcode
	../slicer4rtn --recenter --subdivide=7 cube.stl --slicer=prusa-slicer --output=cube-prusa-slicer.gcode
	../slicer4rtn --recenter --subdivide=5 cube.stl --slicer=CuraEngine --output=cube-CuraEngine.gcode
	../slicer4rtn --recenter --subdivide=5 cube.stl --slicer=CuraEngineLegacy --output=cube-CuraEngineLegacy.gcode
	../slicer4rtn --recenter --subdivide=5 cube.stl --slicer=mandoline --output=cube-mandoline.gcode
	../slicer4rtn --subdivide=5 overhang3l4mm.stl --slicer=slic3r --output=overhang3l4mm-slic3r.gcode
	../slicer4rtn --subdivide=7 overhang3l4mm.stl --slicer=prusa-slicer --output=overhang3l4mm-prusa-slicer.gcode
	../slicer4rtn --subdivide=5 overhang3l4mm.stl --slicer=CuraEngine --output=overhang3l4mm-CuraEngine.gcode
	../slicer4rtn --subdivide=5 overhang3l4mm.stl --slicer=CuraEngineLegacy --output=overhang3l4mm-CuraEngineLegacy.gcode
	../slicer4rtn --subdivide=5 overhang3l4mm.stl --slicer=mandoline --output=overhang3l4mm-mandoline.gcode

png::
	gcode2png --color=1,1,0 --complete=50% cube.gcode
	gcode2png --color=1,1,0 --complete=50% cube-axis=3.gcode
	gcode2png --color=1,1,0 --complete=50% cube-rot=90-axis=3.gcode
	gcode2png --color=1,1,0 --complete=50% cube-rot=-45-axis=3.gcode
	gcode2png --color=1,1,0 --complete=50% cube-25deg-axis=3.gcode

clean::
	rm -f *.gcode *.stl
