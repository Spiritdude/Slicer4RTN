APPNAME = Slicer4RTN
VERSION = 0.4.3
DEST = /usr/local/bin

all::
	@echo "make install install-default install-user-defaults deinstall tests clean edit push pull change backup"

install::
	sudo apt -y install slic3r prusa-slicer cura-engine
	sudo cp slicer4rtn ${DEST}/
	mkdir -p ~/.config/slicer4rtn/ && touch ~/.config/slicer4rtn/slicer4rtn.ini && touch ~/.config/slicer4rtn/slic3r.ini

install-user-defaults::
	cd settings/slicers/; tar cfv - . | (cd ~/.config/slicer4rtn/; tar xf -)

install-defaults::
	sudo mkdir -p /usr/share/slicer4rtn/
	cd settings/; tar cfv - . | (cd /usr/share/slicer4rtn/; sudo tar xf -)

deinstall::
	sudo rm -f ${DEST}/slicer4rtn /usr/share/slicer4rtn/

tests::
	cd tests; make

clean::
	cd tests; make clean

# -- dev only

edit::
	dee4 slicer4rtn Makefile README.md settings/*.ini tests/Makefile tests/*.scad

push::
	git push

pull::
	git pull

change::
	git commit -am "..."

backup::
	cd ..; tar cfvz ~/Backup/${APPNAME}-${VERSION}.tar.gz ${APPNAME}; scp ~/Backup/${APPNAME}-${VERSION}.tar.gz backup:Backup/

