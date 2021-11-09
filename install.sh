#!/bin/bash

OS=`uname -s`
if [ ${OS} == "Darwin"  ];then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install grep findutils flex
    brew tap homebrew/cask
    brew cask install phantomjs
elif [ ${OS} == "Linux"  ];then
    source /etc/os-release
    case $ID in
        debian|ubuntu|devuan)
            sudo apt-get install flex bison phantomjs
            ;;
        centos|fedora|rhel)
            yumdnf="yum"
            if test "$(echo "$VERSION_ID >= 22" | bc)" -ne 0;
            then
                yumdnf="dnf"
            fi
            sudo $yumdnf install -y flex bison phantomjs
            ;;
        *)
            exit 1
            ;;
    esac
else
    echo "Other OS: ${OS}"
fi

SHELL_FOLDER=$(dirname "$0")
pip3 install -r $SHELL_FOLDER/requirements.txt
