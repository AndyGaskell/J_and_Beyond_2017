#!/bin/sh
echo "Hello, this is a script to create a Joomla site from a symlinks"
echo "It requires two parameters:"
echo "Parameter 1: source, eg live or beta"
echo "Parameter 2: target, eg site1"

source=$1
target=$2

# cd into the target
cd symlink_demo/children/$target
pwd

# create symlinks
ln -s -f ../../parents/$source/bin .
ln -s -f ../../parents/$source/cli .
ln -s -f ../../parents/$source/components .
ln -s -f ../../parents/$source/includes .
ln -s -f ../../parents/$source/language .
ln -s -f ../../parents/$source/layouts .
ln -s -f ../../parents/$source/libraries .
ln -s -f ../../parents/$source/media .
ln -s -f ../../parents/$source/modules .
ln -s -f ../../parents/$source/plugins .
ln -s -f ../../parents/$source/templates .
cd administrator
pwd
ln -s -f ../../../parents/$source/administrator/components .
ln -s -f ../../../parents/$source/administrator/help .
ln -s -f ../../../parents/$source/administrator/includes .
ln -s -f ../../../parents/$source/administrator/language .
ln -s -f ../../../parents/$source/administrator/manifests .
ln -s -f ../../../parents/$source/administrator/modules .
ln -s -f ../../../parents/$source/administrator/templates .

