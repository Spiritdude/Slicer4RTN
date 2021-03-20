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
	../slicer4rtn --subdivide=5 overhang3l4mm.stl

png::
	gcode2png --color=1,1,0 --complete=50% cube.gcode
	gcode2png --color=1,1,0 --complete=50% cube-axis=3.gcode
	gcode2png --color=1,1,0 --complete=50% cube-rot=90-axis=3.gcode
	gcode2png --color=1,1,0 --complete=50% cube-rot=-45-axis=3.gcode
	gcode2png --color=1,1,0 --complete=50% cube-25deg-axis=3.gcode

clean::
	rm -f *.gcode *.stl
