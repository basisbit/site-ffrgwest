# site-ffrgwest
FF Ruhrgebiet West (FFRGWEST) specific Gluon configuration

## How to build
1. `sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo reboot now`
2. `sudo apt-get install git subversion python build-essential gawk unzip libncurses5-dev zlib1g-dev libssl-dev wget`
3. `cd ~`
4. `mkdir freifunk`
5. `cd freifunk`
6. `git clone https://github.com/freifunk-gluon/gluon.git gluon -b v2017.1.3`
7. `cd gluon`
8. `git clone https://github.com/basisbit/site-ffrgwest.git site`
9. `make update`
10. `make -j 4 GLUON_TARGET=ar71xx-generic` (use V=s and leave the -j 4 away to get detailled error output,...)

For more details about the gluon build tools, see https://gluon.readthedocs.io/en/v2017.1.x/user/getting_started.html#building-the-images .
