#!/bin/bash

set -e

# Download STEGDETECT
wget -O /tmp/stegdetect.deb http://old-releases.ubuntu.com/ubuntu/pool/universe/s/stegdetect/stegdetect_0.6-6_amd64.deb

# Install STEGDETECT
dpkg -i /tmp/stegdetect.deb || apt-get install -f -y
rm /tmp/stegdetect.deb

# Download OUTGUESS-0.13
wget -O /usr/bin/outguess-0.13 https://github.com/mmayfield1/SSAK/raw/master/programs/64/outguess_0.13
chmod +x /usr/bin/outguess-0.13

# Download OUTGUESS-0.2
wget -O /usr/bin/outguess https://github.com/mmayfield1/SSAK/raw/master/programs/64/outguess_0.2
chmod +x /usr/bin/outguess

# Install STRINGS
# apt-get install binutils

chmod +x steg-check.sh
