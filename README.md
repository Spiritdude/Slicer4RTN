# Slicer4RTN

RTN stands for [Rotating Tilted Nozzle](https://xyzdims.com/2021/01/27/3d-printing-rotating-tilted-nozzle-option/), a 4-axis 3D printer setup.

Slicing4RTN is an Open Source implementation of a conic slicing procedure as mentioned by [ZHAW](https://zhaw.ch) as part of their [RotBot](https://www.zhaw.ch/en/medien/medienmitteilungen/detail-news-releases/event-news/upgrade-fuer-den-3d-drucker-spart-zeit-und-stuetzmaterial/) in 2021/01.
This software is highly experimental and has been independently developed.

[Conic Slicing for Rotating Tilted Nozzle (RTN) / 4 Axis](https://xyzdims.com/2021/02/26/3d-printing-conic-slicing-for-rotating-tilted-nozzle-rtn/) lays out more details of the slicing procedure and its application.

## Installation
```
% make requirements
```
if you want to install `slicer4rtn` system-wide:
```
% make install
```

## Usage
```
% ./slicer4rtn
USAGE Slicer4RTN 0.3.2: [<opts>] <file.stl> ...
   options:
      -v or --verbose      increase verbosity
      --version            display version and exit
      -k or --keep         keep all temporary files (temp.stl, temp.gcode)
      --subdivide=<n>      set midpoint subdivisions (default: 2)
      --mode=<mode>        set cone mode, either 'outside' or 'inside' (default: 'outside')
      --output=<fname>     override default naming convention file.stl -> file.gcode
      --axis=<axis>        set axis count of printer: 3, 4 or 5 (default: 4)
      --angle=<angle>      set angle of cone (default: 45)
      --center=<cx,cy>     set conic slicing center (default: 0,0)
      --bed-center=<cx,cy> set bed-enter, only affects output G-code (default: 100,100)
      --layer-height=<z>   set conic layer height (default: 0.2)
      --rot-gcode=<v>      set G-code symbol for rotation (default: A)
      --rot-revolv=<mode>  set rotation revolution, 0 = unlimited, 1 = once (default: 1)
      --rot-offset=<a>     set rotation offset (default: 90)
      --tilt-gcode=<v>     set G-code symbol for tilt for 5-axis operation (default: B)
      --rot-fixed=<angle>  set fixed rotation angle, usable if --axis=3 but 4-axis or 5-axis printer is target
      --zoff=<v>           set z-offset, will be added to G1 ... Z<v>
      --erate=<f>          set extrusion rate (multiplier, default: 1)
      --efmin=<v>          set extrusion factor minimum, (default: 0.01)
      --efmax=<v>          set extrusion factor maximum, (default: 3)
      --inter-steps=<n>    set interpolation steps per mm (default: 2)
      --motion-minz=<v>    set minimum Z level for motion (without extrusion) (default: 0.2)
      --max-speed=<s>      set maximum speed (default: 0)
      --recenter           recenter model X- & Y-wise
      --core-slicer=<slicer> set slicer (default: 'slic3r')
      --slicer.<k>=<v>     add additional slicer arguments, e.g. --slicer.infill-density=0
      --<k>=<v>            all other arguments not for slicer4rtn will be passed to the core slicer (slic3r)
      
   examples:
      slicer4rtn sphere.stl
      slicer4rtn overhang.stl --output=sample.gcode
      slicer4rtn overhang.stl --axis=5 --output=sample.gcode
      slicer4rtn overhang.stl --axis=3 --output=sample-belt-printer.gcode --fill-density=5
      slicer4rtn model-6.stl --angle=25 --subdivide=5

```

## Todo
- [ ] improve extrusion accuracy
- more core slicer support
  - [x] Slic3r (`slic3r`): gives best results for now
  - [x] Prusa Slicer (`prusa-slicer`): it makes assumptions of printability, e.g. an inverse conic mapped cube creates "Empty layers detected, the output would not be printable", and fails to be sliced; not recommended
  - [ ] Cura Engine
  - [x] [Mandoline (Python)](https://github.com/revarbat/mandoline-py) (`mandoline`): creates bad G-code for now, struggles with pointy structures (after inverse conic mapping), not recommended
- [ ] port to Python: larger developer pool than with Perl (must be fully compatible with its Perl version) and have more geometrical libraries available
- [ ] recognize overhangs, segment sub-volumes and choose proper slicing methods and conic-centers (that's a complex undertake)

## 3-, 4- and 5-axis Printing
- 3-axis: use `--angle=25` or so, and preview the G-code before you print, see [90 Overhangs without Support Structure with Non-Planar Slicing on 3-axis Printer](https://xyzdims.com/2021/03/03/3d-printing-90-overhangs-without-support-structure-with-non-planar-slicing-on-3-axis-printer/)
- 4-axis: not yet tested in physical, only as simulation
  - RotBot: use `--rot-gcode=U` and `--rot-revolv=0` (untested)
- 5-axis: not yet tested in physical, only as simulation

See [Rotating Tilted Nozzle](https://xyzdims.com/2021/01/27/3d-printing-rotating-tilted-nozzle-option/) for more details.

