IPython GEANT4 Linac
====================

A GEANT4 Linac written purely in the python environment using IPython notebook.




How to install
==============

Assuming you have Ubuntu 14.04 64-bit LTS follow these steps to create a working environment:

Open terminal (ctrl + alt + T)

    sudo apt-get -y install git
    
    mkdir ~/github
    cd ~/github
    git clone https://github.com/SimonBiggs/ipython-geant4-linac.git
    
    sudo ~/github/ipython-geant4-linac/install.sh

NOTE: This will take quite some time and use quite a bit of internet data. 

if you know what you are doing you should read through the install.sh before running it in case there are any options that disagree with your environment. if you are starting from scratch, don't mind where things are installed, and wouldn't know where to begin installing geant4, then the above method is for you.

Once complete type:

    cd ~/github/ipython-geant4-linac
    ipython3 notebook
    
This will open up the notebook


Tips for virtual box
====================
Download Ubuntu 14.04 64-bit LTS

dowload virtualbox, use version 2.3.14 if you have antvius installed.

Install virtualbox -- follow wizard

create new virtual machine

 * > 50 gb hard drive
 * > 4 gb ram
 * increase video memory
 * increase cpu
 * insert ubuntu iso into virtual cd drive

Install Ubuntu 14.04 64-bit LTS inside the virtualbox


Boot new Ubuntu machine

Open terminal (ctrl + alt + T)

    sudo apt-get update
    sudo apt-get -y upgrade

    sudo apt-get -y install build-essential dkms
    sudo reboot

(Virtualbox menu) || Devices > Insert Guest aditions CD Image

Allow the cd to autorun > follow prompts

    sudo reboot

(Virtualbox menu) || Machine > Settings > General > Advanced (Tab) > Enable bidirectional shared clipboard and drag 'n' drop
