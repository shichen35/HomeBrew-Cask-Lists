#!/usr/bin/env bash

(set -x; brew update;)
(set -x; brew upgrade;)

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

casks=( $(brew cask list) )

for cask in ${casks[@]}
do
    version=$(brew cask info $cask | sed -n "s/$cask:\ \(.*\)/\1/p")
    installed=$(find "/usr/local/Caskroom/$cask" -type d -mindepth 1 -maxdepth 1 -name "$version")

    if [[ -z $installed ]]; then
        echo "${red}${cask}${reset} requires ${red}update${reset}."
        read -p "update? (y/n)" goupdate
        if [ "$goupdate" == "y" ]; then
          brew cask reinstall $cask
       fi 
    else
        echo "${red}${cask}${reset} is ${green}up-to-date${reset}."
    fi
done

(set -x; brew cleanup;)
