#!/usr/bin/bash

_buildsh_path="$(realpath -- "$0")"

function build_polybar() {
	[[ ! -d ./work ]] && mkdir work
	cd work
	git clone http://github.com/polybar/polybar
	cd polybar
	git submodule update --init --recursive
	mkdir build
	cd build
	cmake ..
	make -j $(nproc)
	cd ../../..
	rm -rf work/polybar
}

function get_dotfiles() {
	cp -r /home/sarenord/Documents/Storage/Git/dotfiles/* /home/sarenord/Documents/Storage/Git/dotfiles/.* airootfs/home/sarenord/
	# rm -rf airootfs/home/sarenord/.* airootfs/home/sarenord/*; git clone git@github.com:sarenord/dotfiles.git airootfs/home/sarenord
}

function build_deps() {
	get_dotfiles
	build_polybar
}

[[ "$*" == *'--deps'* ]] && build_deps
sudo mkarchiso -v -w /tmp/archiso -o . "${_buildsh_path%/*}" && sudo rm -rf /tmp/archiso

_fname=$(find ./ -iname "archlinux-baseline*")

[[ "$*" == *'-r'* ]] && run_archiso -i ${_fname[0]}
