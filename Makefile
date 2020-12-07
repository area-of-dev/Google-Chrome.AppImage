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

all:  clean

	mkdir --parents $(PWD)/build/Boilerplate.AppDir
	
	apprepo --destination=$(PWD)/build appdir boilerplate libatk1.0-0 libglib2.0-0 shared-mime-info libffi7 libselinux1 libpango-1.0-0 \
											libgdk-pixbuf2.0-0 librsvg2-2 adwaita-icon-theme libgtk-3-0 libncurses5 libncurses6 gsettings-desktop-schemas

	wget --output-document="$(PWD)/build/build.deb" https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	dpkg -x $(PWD)/build/build.deb $(PWD)/build

	echo "LD_LIBRARY_PATH=\$${LD_LIBRARY_PATH}:\$${APPDIR}/chrome" >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo "export LD_LIBRARY_PATH=\$${LD_LIBRARY_PATH}" >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo "exec \$${APPDIR}/chrome/chrome \"\$${@}\"" >> $(PWD)/build/Boilerplate.AppDir/AppRun

	cp --force --recursive $(PWD)/build/opt/google/* $(PWD)/build/Boilerplate.AppDir/
	chmod 4755 $(PWD)/build/Boilerplate.AppDir/chrome/chrome-sandbox

	rm --force $(PWD)/build/Boilerplate.AppDir/*.desktop

	cp --force $(PWD)/AppDir/*.desktop $(PWD)/build/Boilerplate.AppDir/
	cp --force $(PWD)/AppDir/*.png $(PWD)/build/Boilerplate.AppDir/ || true
	cp --force $(PWD)/AppDir/*.svg $(PWD)/build/Boilerplate.AppDir/ || true

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/Google-Chrome.AppImage
	chmod +x $(PWD)/Google-Chrome.AppImage

clean:
	rm -rf $(PWD)/build
