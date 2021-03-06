# Slicer4RTN

RTN stands for [Rotating Tilted Nozzle](https://xyzdims.com/2021/01/27/3d-printing-rotating-tilted-nozzle-option/), a 4-axis 3D printer.

Slicing4RTN is an Open Source implementation of a conic slicing procedure as invented by [ZHAW](https://zhaw.ch) (Elspass, Jaeger, Wuethrich, Gubser, Bos and Holdener) and became known as part of their [RotBot](https://www.zhaw.ch/en/medien/medienmitteilungen/detail-news-releases/event-news/upgrade-fuer-den-3d-drucker-spart-zeit-und-stuetzmaterial/) announcement in 2021/01.
This software has been independently developed yet is comparable to the solution of ZHAW.

[Conic Slicing for Rotating Tilted Nozzle (RTN) / 4 Axis](https://xyzdims.com/2021/02/26/3d-printing-conic-slicing-for-rotating-tilted-nozzle-rtn/) lays out more details of the slicing procedure and its application;
and [Slicer4RTN](https://xyzdims.com/3d-printing/slicer4rtn/) contains a more thorough description of the features and details how to use `slicer4rtn`.

**NOTE**: The software is in a very experimental state and defaults and settings might change during this early stage of development - please use caution when running the G-code on your 3-, 4- or 5-axis 3D printer, **don't do this unattended**.

## Limitations
In its current state only slices in a single "conic mode" per model, either `outside`-cone printing or `inside`-cone printing (change with `--mode=..`)
which means, only a single overhang reference is supported: conic slicing allows overhangs to be printed without support structure given they point away or to a central conic center;
multiple centers are not yet supported which would require sub-volume segmenting and treat each sub-volume printed in its own mode.

A future version of Slicer4RTN might segment volumes and support multiple conic centers and more complex overhang slicing - this is why this software is released as Open Source to help to push this development.

## Supported Platforms
- Linux Ubuntu/Debian, tested on Ubuntu 20.04 LTS

## Updates
- 0.6.0: $efa multiplier adjusted, --rot-revolve=0 (new default, unlimited revolv), --rot-revolve=1 (single revolv) does performs smart rotate-around to immitate continenous rotation
- 0.5.2: --rotate, --scale and --translate added for pre-processing model
- 0.5.1: experimentally support .off, .obj, both more compact than .stl
- 0.5.0: fixing levelModel() affected CuraEngine/cura-slicer, version bump
- 0.4.8: support of start-gcode and end-gcode
- 0.4.7: cleaner X Y Z output
- 0.4.6: adding support for 'cura-slicer' (CuraEngine wrapper https://github.com/Spiritdude/Cura-CLI-Wrapper)
- 0.4.5: fixing config load for slic3r & prusa-slicer
- 0.4.2: CuraEngine 4.4.x & CuraEngineLegacy (15.10) experimental support added 
- 0.4.0: supporting ~/.config/slicer4rtn/slicer4rtn.ini with new defaults
- 0.3.4: rot_revolv=1 better $rot calculation (rot_revolv=0 untested)
- 0.3.1: changing rot-offset 0 => -90
- 0.3.0: version bump with various cleanups, more consistent settings, --inter-steps added
- 0.2.6: diverse new settings: rot_gcode, rot_offset, rot_revolv, tilt_gcode and layer-height which is computed for core-slicer
- 0.2.5: added main $efa multiplier depends on angle, not yet sure if it's correct
- 0.2.4: making arguments for core slicer easier, --slicer.<k>=<v> as well --<k>=<v> works (better for print3r integration)
- 0.2.3: simplifying code, extrusion interpolation still off (needs reworking)
- 0.2.0: changing extrusion calculation, better apprx., flow_rate => erate
- 0.1.1: properly re-offset G-code output from slic3r and prusa-slicer as it centers model, early support for prusa-slicer
- 0.1.0: new --slicer.key=val added, added --zoff=val to re-adjust zoffset in final G-code
- 0.0.5: added --axis=3, 4 or 5 to create for 3-, 4- or 5-axis G-code 3d-printer, added --angle=45 to change angle of cone
- 0.0.4: added --mode=outside or inside to reverse order for inside/outside-cone printing
- 0.0.3: moving stl2rtn and gcodertn into slicer4rtn
- 0.0.2: bug fixed, much better G-gcode output, viewable by Cura
- 0.0.1: first functional version, various bugs

## Download
```
% git clone https://github.com/Spiritdude/Slicer4RTN
% cd Slicer4RTN/
```

## Installation
```
% make requirements
```
if you want to install `slicer4rtn` system-wide:
```
% make install
```
which installs the app and sane defaults in `/usr/share/slicer4rtn/` but edit your personal settings per core slicer 
in `~/.config/slicer4rtn/` as those will not be overwritten in future upgrades with the same filename as in `/usr/share/slicer4rtn/`.

## Usage
```
% ./slicer4rtn
USAGE Slicer4RTN 0.6.0: [<opts>] <file.stl> ...
   options:
      -v or --verbose      increase verbosity
      --version            display version and exit
      -k or --keep         keep all temporary files (temp.stl, temp.gcode)
      --rotate=<x,y,z>     rotate model
      --translate=<x,y,z>  translate model
      --scale=<s>          scale uniform
      --scale=<x,y,z>      scale individually
      --recenter           recenter model X- & Y-wise
      --subdivide=<n>      set midpoint subdivisions (default: 2)
      --mode=<mode>        set cone mode, either 'outside' or 'inside' (default: 'outside')
      --output=<fname>     override default naming convention file.stl -> file.gcode
      --axis=<axis>        set axis count of printer: 3, 4 or 5 (default: 4)
      --angle=<angle>      set angle of cone (default: 45)
      --center=<cx,cy>     set conic slicing center (default: 0,0)
      --bed-center=<cx,cy> set bed-enter, only affects output G-code (default: 100,100)
      --layer-height=<z>   set conic layer height (default: 0.2)
      --rot-gcode=<v>      set G-code symbol for rotation (default: A)
      --rot-revolv=<mode>  set rotation revolution, 0 = unlimited, 1 = once (default: 0)
      --rot-offset=<a>     set rotation offset (default: -90)
      --rot-fixed=<angle>  set fixed rotation angle, usable if --axis=3 but 4-axis or 5-axis printer is target
      --tilt-gcode=<v>     set G-code symbol for tilt for 5-axis operation (default: B)
      --zoff=<v>           set z-offset, will be added to G1 ... Z<v>
      --erate=<f>          set extrusion rate (multiplier, default: 1)
      --efmin=<v>          set extrusion factor minimum, (default: 0.01)
      --efmax=<v>          set extrusion factor maximum, (default: 3)
      --inter-steps=<n>    set interpolation steps per mm (default: 2)
      --motion-minz=<v>    set minimum Z level for motion (without extrusion) (default: 0.2)
      --max-speed=<s>      set maximum speed (default: 0)
      --slicer=<slicer>    set core slicer slic3r, prusa-slicer, CuraEngine{Legacy}, cura-slicer, mandoline (default: 'slic3r')
      --start-gcode=...    set start gcode (disables core slicer's start-gcode)
      --end-gcode=...      set end gcode (disables core slicer's end-gcode)
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
- [ ] improve extrusion accuracy (needs to be tested more thoroughly)
- more core slicer support
  - [x] Slic3r 1.2.x (`slic3r`): gives reliable results for now
  - [x] Prusa Slicer 2.x (`prusa-slicer`): it makes assumptions of printability, e.g. an inverse conic mapped cube creates "Empty layers detected, the output would not be printable", and fails to be sliced; not recommended
  - [x] Cura Engine 4.x (`CuraEngine`): gives very good results, but is tedious to configure without GUI
    - [x] [Cura CLI Wrapper](https://github.com/Spiritdude/Cura-CLI-Wrapper) (`cura-slicer`): easier to use than CuraEngine
  - [x] Cura Engine Legacy 15.10 (`CuraEngineLegacy`): gives good results as well
  - [x] [Mandoline (Python)](https://github.com/revarbat/mandoline-py) (`mandoline`): creates faulty G-code for now, struggles with pointy structures after inverse conic mapping, not recommended yet (but might become the most relevant slicer in the future of `slicer4rtn`)
- [ ] port to Python: larger developer pool than with Perl (must be fully compatible with its Perl version) in order to push development like
- [ ] support for Multi Cone-Mode/Centers printing, requires overhang recognition and sub-volume segmentation

## 3-, 4- and 5-axis Printing
- 3-axis: use `--angle=25` or so, and preview the G-code before you print, see [90 deg Overhangs without Support Structure with Non-Planar Slicing on 3-axis Printer](https://xyzdims.com/2021/03/03/3d-printing-90-overhangs-without-support-structure-with-non-planar-slicing-on-3-axis-printer/)
- 4-axis: not yet tested in physical, only as simulation
  - RotBot: use `--rot-gcode=U`, `--rot-revolv=0` and `--rot-offset=0` (untested)
- 5-axis: not yet tested in physical, only as simulation

See [Rotating Tilted Nozzle](https://xyzdims.com/2021/01/27/3d-printing-rotating-tilted-nozzle-option/) for more details.

