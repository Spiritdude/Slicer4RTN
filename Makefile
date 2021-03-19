APPNAME = Slicer4RTN
VERSION = 0.4.0
DEST = /usr/local/bin

all::
	@echo "make install deinstall tests clean edit push pull change backup"

install::
	sudo apt -y install slic3r prusa-slicer
	sudo cp slicer4rtn ${DEST}/
	mkdir -p ~/.config/slicer4rtn/ && touch ~/.config/slicer4rtn/slic3r.ini

deinstall::
	sudo rm -f ${DEST}/slicer4rtn

tests::
	cd tests; make

clean::
	cd tests; make clean

# -- dev only

edit::
	dee4 slicer4rtn Makefile README.md tests/Makefile tests/*.scad

push::
	git push

pull::
	git pull

change::
	git commit -am "..."

backup::
	cd ..; tar cfvz ~/Backup/${APPNAME}-${VERSION}.tar.gz ${APPNAME}; scp ~/Backup/${APPNAME}-${VERSION}.tar.gz backup:Backup/

