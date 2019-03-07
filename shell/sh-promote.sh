#!/bin/bash
# by Wade H. vdtdev.prod@gmail.com ~ http://github.com/vdtdev

# Promote shell script to executable

def_clr="\033[0;37m"
opt_clr="\033[0;33m"
lcy_clr="\033[1;36m"

function ctext {
    txt=$1
    bgc=$2
    fgc=$3
    printf "\033[${bgc};${fgc}m${txt}\033[0;37m\n"
}

function make_executable {
    cp $1 $2
    chmod a+x $2
    printf "Created executable file $2\n"
}

if [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ "$#" = 0 ]; then
    printf "\033[1;35mUsage:${def_clr} sh-promote  "
    printf "[${opt_clr}options${def_clr}] "
    printf "<${lcy_clr}source sh script${def_clr}> <${lcy_clr}output executable${def_clr}>\n"
    printf "\t${opt_clr}--help${def_clr}\t\t"
    printf "(${opt_clr}-h${def_clr})\tDisplay usage info\n"
    printf "\t${opt_clr}--install${def_clr}\t"
    printf "(${opt_clr}-i${def_clr})\tCopy executable to /usr/local/bin\n"
    printf "\t${opt_clr}--tools${def_clr}\t\t"
    printf "(${opt_clr}-t${def_clr})\tCopy executable to ~/bin/tools\n"
elif [ $# -eq 2 ]; then
    make_executable $1 $2
elif [ $# -eq 3 ]; then
    if [ "$1" = "--install" ] || [ "$1" = "-i" ]; then
        make_executable $2 $3
        cp $3 /usr/local/bin/$3
        printf "Installed executable to /usr/local/bin/$3\n"
    elif [ "$1" = "--tools" ] || [ "$1" = "-t" ]; then
        make_executable $2 $3
        cp $3 ~/bin/tools/$3
        printf "Installed executable to ~/bin/tools/$3\n"
    else
        printf "Invalid arguments\n"
    fi
fi
  
