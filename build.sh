#!/usr/bin/bash

_buildsh_path="$(realpath -- "$0")"
_base_dir=$(dirname $_buildsh_path)

function build_polybar() {
    git clone git@github.com:polybar/polybar airootfs/usr/bin/polybar
    cd airootfs/usr/bin/polybar
    git submodule update --init --recursive
    mkdir build
    cd build
    cmake ..
    make -j $(nproc)
    cd ../..
    mv polybar polybar-build
    cp polybar-build/build/bin/polybar polybar-build/build/bin/polybar-msg .
    rm -rf polybar-build
    cd $_base_dir
}

function build_stterm() {
    git clone git@github.com:shell-drick/stterm airootfs/usr/bin/stterm
    cd airootfs/usr/bin/stterm
    make
    cp st ..
    cd ..
    rm -rf stterm
    cd $_base_dir
    chmod +x airootfs/usr/bin/st
}


function build_deps() {
    rm -rf airootfs/home/sarenord airootfs/usr/bin/*
    git clone git@github.com:shell-drick/dotfiles airootfs/home/sarenord
    build_stterm
    build_polybar
}

[[ "$*" == *'--deps'* ]] && build_deps
sudo mkarchiso -v -w /tmp/archiso -o . "${_buildsh_path%/*}" && sudo rm -rf /tmp/archiso

_fname=$(find ./ -iname "archlinux-baseline*")

[[ "$*" == *'-r'* ]] && run_archiso -i ${_fname[0]}
