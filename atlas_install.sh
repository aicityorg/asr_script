#!/bin/bash
### ATLAS Ubuntu install

# Assign user name
read -p "Enter your user name: " UserName

### MAIN ###
# Number of CPUs
CPUNum=$(nproc)

# Install required packages
apt-get update
apt-get -y upgrade
apt-get -y install build-essential gfortran cpufrequtils

# Turn off CPU throttling
for (( i=0; i<$CPUNum; i++ ))
do
	echo "cpufreq-set -c $i -g performance"
	cpufreq-set -c $i -g performance
done

cd ~/Downloads

# Check/remove atlas3.10.2.tar.bz2
if [ -f ~/Downloads/atlas3.10.2.tar.bz2 ]
	then
		rm ~/Downloads/atlas3.10.2.tar.bz2
fi

# Check/remove lapack-3.4.2.tgz
if [ -f ~/Downloads/lapack-3.4.2.tgz ]
	then
		rm ~/Downloads/lapack-3.4.2.tgz 
fi

# Download atlas3.10.2.tar.bz2
sudo -u $UserName wget http://downloads.sourceforge.net/project/math-atlas/Stable/3.10.2/atlas3.10.2.tar.bz2

# Download lapack-3.4.2.tgz 
sudo -u $UserName wget http://www.netlib.org/lapack/lapack-3.4.2.tgz

# Extract atlas3.10.2.tar.bz2
sudo -u $UserName tar xjf ~/Downloads/atlas3.10.2.tar.bz2

# Compile and Install
cd ATLAS
sudo -u $UserName mkdir obj64
cd obj64
sudo -u $UserName mkdir ~/Downloads/atlasComp
sudo -u $UserName ../configure -b 64 -D c -DPentiumCPS=3000 --shared --prefix=~/Downloads/atlasComp --with-netlib-lapack-tarfile=~/Downloads/lapack-3.4.2.tgz
sudo -u $UserName make
sudo -u $UserName make check
sudo -u $UserName make ptcheck
sudo -u $UserName make time
sudo -u $UserName make install
cd ~

# Move files
mkdir /usr/local/include/atlas
cp -r ~/Downloads/atlasComp/include/atlas/* /usr/local/include/atlas/
cp -r ~/Downloads/atlasComp/include/cblas.h /usr/local/include/atlas/
cp -r ~/Downloads/atlasComp/include/clapack.h /usr/local/include/atlas/
cp -r ~/Downloads/atlasComp/lib/* /usr/local/lib/

# Cleanup
rm ~/Downloads/atlas3.10.2.tar.bz2
rm ~/Downloads/lapack-3.4.2.tgz
rm -r ~/Downloads/ATLAS
rm -r ~/Downloads/atlasComp

echo "ATLAS Install Complete"