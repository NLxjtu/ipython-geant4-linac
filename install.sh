#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


su $SUDO_USER

	# =====================
	# Download GEANT4 Files
	# =====================
	mkdir ~/GEANT4
	cd ~/GEANT4

	mkdir ~/GEANT4/source
	cd ~/GEANT4/source

	wget http://geant4.web.cern.ch/geant4/support/source/geant4.9.6.p03.tar.gz

	mkdir ~/GEANT4/datafiles
	cd ~/GEANT4/datafiles

	wget http://geant4.cern.ch/support/source/G4NDL.4.2.tar.gz \
	http://geant4.cern.ch/support/source/G4EMLOW.6.32.tar.gz \
	http://geant4.cern.ch/support/source/G4PhotonEvaporation.2.3.tar.gz \
	http://geant4.cern.ch/support/source/G4RadioactiveDecay.3.6.tar.gz \
	http://geant4.cern.ch/support/source/G4NEUTRONXS.1.2.tar.gz \
	http://geant4.cern.ch/support/source/G4PII.1.3.tar.gz \
	http://geant4.cern.ch/support/source/RealSurface.1.0.tar.gz \
	http://geant4.cern.ch/support/source/G4SAIDDATA.1.1.tar.gz


	# =============================
	# Extract source and data files
	# =============================
	cd ~/GEANT4/source
	tar -xzf geant4.9.6.p03.tar.gz

	cd ~/GEANT4/datafiles

	mkdir ~/GEANT4/datafiles/extract
	cd ~/GEANT4/datafiles/extract

	tar -xzf ../G4NDL.4.2.tar.gz
	tar -xzf ../G4EMLOW.6.32.tar.gz
	tar -xzf ../G4PhotonEvaporation.2.3.tar.gz
	tar -xzf ../G4RadioactiveDecay.3.6.tar.gz
	tar -xzf ../G4NEUTRONXS.1.2.tar.gz
	tar -xzf ../G4PII.1.3.tar.gz
	tar -xzf ../RealSurface.1.0.tar.gz
	tar -xzf ../G4SAIDDATA.1.1.tar.gz

exit

mkdir -p /usr/local/share/Geant4-9.6.3/data
cp -r * /usr/local/share/Geant4-9.6.3/data


# ==============
# Install GEANT4
# ==============
apt-get -y install cmake build-essential qt4-dev-tools libxmu-dev libmotif-dev libexpat1-dev

su $SUDO_USER

	mkdir ~/GEANT4/build
	cd ~/GEANT4/build

	cmake ~/GEANT4/source/geant4.9.6.p03 -DGEANT4_BUILD_MULTITHREADED=ON -DGEANT4_USE_QT=ON -DGEANT4_USE_XM=ON -DGEANT4_USE_OPENGL_X11=ON -DGEANT4_USE_RAYTRACER_X11=ON -Wno-dev

	make -j`grep -c processor /proc/cpuinfo`

exit


make install


su $SUDO_USER

	echo " . geant4.sh" >> ~/.bashrc
	
exit


# ==============================
# Install python 3.4 scipy stack
# ==============================

apt-get -y install python3 python3-pip

apt-get -y build-dep ipython3 ipython3-notebook python3-numpy python3-scipy python3-matplotlib python3-pandas python3-nose 
	
pip3 install --upgrade ipython[all] numpy scipy matplotlib pandas nose
	
	
# =============
# Install boost
# =============

apt-get -y install libboost-all-dev


# =================================
# Install GEANT4 Python Environment
# =================================

apt-get -y install xfonts-75dpi xfonts-100dpi
fc-cache -f -v


su $SUDO_USER

	cd ~/GEANT4/source/geant4.9.6.p03/environments/g4py
	sed -e 's/lib64/lib/g' configure > configure_edit_lib64
	sed -e 's/python3.3/python3.4 python3.3/g' configure_edit_lib64 > configure_edit_lib64_python34
	chmod +x configure_edit_lib64_python34

	mkdir ~/GEANT4/source/geant4.9.6.p03/environments/g4py/python34

	./configure_edit_lib64_python34 linux64 --with-python3 --enable-openglxm --enable-raytracerx --enable-openglx --with-g4install-dir=/usr/local --with-boost-libdir=/usr/lib/x86_64-linux-gnu --with-boost-python-lib=boost_python-py34 --prefix=~/GEANT4/source/geant4.9.6.p03/environments/g4py/python34

	make -j`grep -c processor /proc/cpuinfo`

	make install # (don't worry about errors)


	cd ~/GEANT4/source/geant4.9.6.p03/environments/g4py/python34/lib/Geant4
	python3 -c 'import py_compile; py_compile.compile( "colortable.py" )'
	python3 -c 'import py_compile; py_compile.compile( "g4thread.py" )'
	python3 -c 'import py_compile; py_compile.compile( "g4viscp.py" )'
	python3 -c 'import py_compile; py_compile.compile( "hepunit.py" )'
	python3 -c 'import py_compile; py_compile.compile( "__init__.py" )'
	python3 -O -c 'import py_compile; py_compile.compile( "colortable.py" )'
	python3 -O -c 'import py_compile; py_compile.compile( "g4thread.py" )'
	python3 -O -c 'import py_compile; py_compile.compile( "g4viscp.py" )'
	python3 -O -c 'import py_compile; py_compile.compile( "hepunit.py" )'
	python3 -O -c 'import py_compile; py_compile.compile( "__init__.py" )'


	cd ~/GEANT4/source/geant4.9.6.p03/environments/g4py/python34/lib/g4py
	python3 -c 'import py_compile; py_compile.compile( "emcalculator.py" )'
	python3 -O -c 'import py_compile; py_compile.compile( "emcalculator.py" )'
	python3 -c 'import py_compile; py_compile.compile( "mcscore.py" )'
	python3 -O -c 'import py_compile; py_compile.compile( "mcscore.py" )'
	python3 -c 'import py_compile; py_compile.compile( "__init__.py" )'
	python3 -O -c 'import py_compile; py_compile.compile( "__init__.py" )'

exit


cp -r ~/GEANT4/source/geant4.9.6.p03/environments/g4py/python34/lib/* /usr/local/lib/python3.4/dist-packages/


# ===========================
# Install Python/GEANT4 Linac
# ===========================
	
apt-get -y install git nohup

su $SUDO_USER

	mkdir ~/github

	cd ~/github
	git clone https://github.com/SimonBiggs/ipython-geant4-linac.git
	# or for SSH -- git clone git@github.com:SimonBiggs/ipython-geant4-linac.git 

	mkdir ~/github/linac/linac/g4/build
	cd ~/github/linac/linac/g4/build

	cmake ../ -DPYTHON_INCLUDE_DIR=/usr/include/python3.4m -DPYTHON_INCLUDE_DIR2=/usr/include/x86_64-linux-gnu/python3.4m -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.4m.so -DBoost_PYTHON_LIBRARY_DEBUG=/usr/lib/x86_64-linux-gnu/libboost_python-py34.so -DBoost_PYTHON_LIBRARY_RELEASE=/usr/lib/x86_64-linux-gnu/libboost_python-py34.so

	make

	cd ~/github/linac
	nohup ipython3 notebook &
	
exit
