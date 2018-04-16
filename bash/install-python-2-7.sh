#!/bin/bash
set -x;
yum -y update;
yum groupinstall -y 'development tools';
yum install -y zlib-devel bzip2-devel openssl-devel xz-libs wget;

# Download, package and install Python2.7
cd /tmp/;
wget --no-check-certificate https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz;
tar -xvf /tmp/Python-2.7.12.tgz;
cd /tmp/Python-2.7.12/;
./configure --prefix=/usr/local;
make;
make altinstall;

# Download and install setuptools
cd /tmp/;
wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz;
tar -xvf /tmp/setuptools-1.4.2.tar.gz;
cd /tmp/setuptools-1.4.2/;
python2.7 setup.py install;

# Download and install pip
cd /tmp/;
wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py;
python2.7 /tmp/get-pip.py;
set +x;