#!/bin/bash

if [ -z $1 ]; then
	keyboard_type="iso_tkl"
else
	case $1 in
		"ansi") keyboard_type="ansi" ;;
		"iso_tkl") keyboard_type="iso_tkl" ;;
		*) echo "Invalid keyboard type"; exit 1 ;;
	esac
fi
echo "Set keyboard type: $keyboard_type"


generate_xmodmap()
{
	xmodmap_file=$2
	# keycode: run `showkey` in a virtual console
	# keysym: http://wiki.linuxquestions.org/wiki/List_of_Keysyms_Recognised_by_Xmodmap
	# debug mapping: xmodmap -pke
	MAP_ANSI=(
		"keycode 100 = less NoSymbol"
		"keycode 101 = greater NoSymbol"
	)
	MAP_ISO_TKL=(
		"keycode 24 = a A NoSymbol NoSymbol aring Aring"
	)
	case $1 in
		"ansi") map=$MAP_ANSI ;;
		"iso_tkl") map=$MAP_ISO_TKL ;;
	esac

	echo "" > $xmodmap_file
	for i in "${map[@]}"; do
		echo "$i" >> $xmodmap_file

	done
	echo "Generated $xmodmap_file, apply manually (for now)"

}

generate_xmodmap $keyboard_type /tmp/xmodmap.conf
