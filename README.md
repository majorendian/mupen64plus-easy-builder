mupen64plus-easy-builder
------------------------

## About

Easily build mupen64plus. Just clone the repo and run `bash build.sh fetch` and then `bash build install`
This script requires root privliedges for now.

This simple script was designed specifically for me because I was getting weird segfaults from the
official gentoo repos. So feel free to tweak the build.sh compile flags to suit your needs.

For my system, I had to use OSD=0 OPENCV=0 in order for mupen to work correctly.
