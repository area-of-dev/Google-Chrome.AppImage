# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)

.PHONY: all

all: clean init
	mkdir --parents $(PWD)/build/Boilerplate.AppDir
	$(PWD)/bin/Apprepo.AppImage --destination=$(PWD)/build appdir boilerplate \
	    libgdk-pixbuf2.0-0 libatk1.0-0 libatk-bridge2.0-0 libgtk2.0-0 libbotan-2-12 \
	    libreadline8 at-spi2-core libpango-1.0-0 libselinux1 \
	    libgtk-3-0 libwayland-cursor0

	wget --output-document="$(PWD)/build/build.deb" https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	dpkg -x $(PWD)/build/build.deb $(PWD)/build

	cp --force --recursive $(PWD)/build/usr/*			$(PWD)/build/Boilerplate.AppDir/
	cp --force --recursive $(PWD)/build/opt/google/* 	$(PWD)/build/Boilerplate.AppDir/

	chmod 4755 $(PWD)/build/Boilerplate.AppDir/chrome/chrome-sandbox
	chmod 4755 $(PWD)/build/Boilerplate.AppDir/chrome/chrome

	echo "LD_LIBRARY_PATH=\$${LD_LIBRARY_PATH}:\$${APPDIR}/chrome" 	>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo "export LD_LIBRARY_PATH=\$${LD_LIBRARY_PATH}" 				>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo "exec \$${APPDIR}/chrome/google-chrome \"\$${@}\"" 		>> $(PWD)/build/Boilerplate.AppDir/AppRun

	rm --recursive --force $(PWD)/build/Boilerplate.AppDir/*.desktop 		     || true
	rm --recursive --force $(PWD)/build/Boilerplate.AppDir/*.png 		  	     || true
	rm --recursive --force $(PWD)/build/Boilerplate.AppDir/*.svg 		  	     || true
	rm --recursive --force $(PWD)/build/Boilerplate.AppDir/lib64/libstdc++.so.6*  || true

	cp --force $(PWD)/AppDir/*.desktop 			$(PWD)/build/Boilerplate.AppDir/ || true
	cp --force $(PWD)/AppDir/*.png 				$(PWD)/build/Boilerplate.AppDir/ || true
	cp --force $(PWD)/AppDir/*.svg 				$(PWD)/build/Boilerplate.AppDir/ || true

	 export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/Google-Chrome.AppImage
	 chmod +x $(PWD)/Google-Chrome.AppImage

init:
	mkdir --parents $(PWD)/bin

	wget https://apprepo.de/appimage/download/apprepo \
		--output-document=$(PWD)/bin/Apprepo.AppImage
	chmod +x $(PWD)/bin/Apprepo.AppImage

	wget https://github.com/AppImage/AppImageKit/releases/download/13/appimagetool-x86_64.AppImage \
		--output-document=$(PWD)/bin/appimagetool.AppImage
	chmod +x $(PWD)/bin/appimagetool.AppImage

clean:
	rm -rf $(PWD)/*.AppImage
	rm -rf $(PWD)/bin/*
	rm -rf $(PWD)/build
