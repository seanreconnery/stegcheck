# StegCheck
Bash script to analyze a JPG for embedded data &amp; tell-tale strings present in steg'ed images.

You'll need to make sure you have Strings installed (it should be installed by default on most linux distros) as well as Outguess 0.2 & Outguess 0.13.

The inspiration from this script came from Dominic Brueker's Stego-Toolkit.  https://github.com/DominicBreuker/stego-toolkit
I modified the check_XXX.sh scripts to better suit my purposes of scanning images.

Often times, the Stego-Toolkit is used for CTF challenges where you are pretty sure you'll be dealing with steganography.
However, in the "real world" (or ARG realm even), you aren't always aware if an image is worth digging into.

I needed a way to quickly suss out if a JPG is fishy or not.
StegDetect is prone to false-negatives, so I wanted to create a better way to assess images and this script helps me do just that.

# WHAT:
This script will run StegDetect with varying sensitivity settings (optimum settings based on a few whitepapers RE: stegdetect reliability)
Then Outguess will see if it can extract data.
And finally, the Strings in the header of the image will be checked against known steganography strings.

# INSTALL:
sudo apt-get update
git clone https://github.com/seanreconnery/stegcheck.git
cd stegcheck
chmod +x steg-check-setup.sh

# USE:
./steg-check.sh IMG.jpg

