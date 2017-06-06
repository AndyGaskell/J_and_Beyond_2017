#!/bin/sh
echo "Hello, this is a script to create a Joomla site from a symlinks"
echo "It requires three parameters:"
echo "Parameter 1: full site name, eg 'Hill Valley'"
echo "Parameter 2: system site name, lower case no spaces, eg 'hillvalley'"
echo "Parameter 3: source, eg 'live'"

# get params
sitename=$1
sysname=$2
source=$3
echo "sitename: $sitename "
echo "sysname: $sysname "
echo "source: $source "

# create the db user and db
mysql -u root --password=mypassword -N -e "CREATE USER '$sysname'@'localhost' IDENTIFIED BY 'password';"
mysql -u root --password=mypassword -N -e "GRANT USAGE ON *.* TO '$sysname'@'localhost' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
mysql -u root --password=mypassword -N -e "CREATE DATABASE IF NOT EXISTS $sysname;"
mysql -u root --password=mypassword -N -e "GRANT ALL PRIVILEGES ON $sysname.* TO $sysname@'localhost';"

# do a dump n load
mysqldump -h localhost -u root --password=mypassword $source > $sysname.sql 
mysql -h localhost -u root --password=mypassword $sysname < $sysname.sql 

# create folders
mkdir symlink_demo/children/$sysname
mkdir symlink_demo/children/$sysname/images
mkdir symlink_demo/children/$sysname/tmp
mkdir symlink_demo/children/$sysname/cache
mkdir symlink_demo/children/$sysname/administrator
mkdir symlink_demo/children/$sysname/administrator/cache
mkdir symlink_demo/children/$sysname/administrator/logs

# read in the config
configbase=`cat symlink_demo/parents/$source/configuration.php`
echo "$configbase"
configbase="${configbase//parents/children}"
configbase="${configbase//$source/$sysname}"
echo "$configbase"
echo $configbase > symlink_demo/children/$sysname/configuration.php

# copy files
cp symlink_demo/parents/$source/htaccess.txt symlink_demo/children/$sysname/
cp symlink_demo/parents/$source/robots.txt symlink_demo/children/$sysname/
cp symlink_demo/parents/$source/index.php symlink_demo/children/$sysname/
cp symlink_demo/parents/$source/administrator/index.php symlink_demo/children/$sysname/administrator/


cd symlink_demo/children/$sysname
pwd

# create symlinks
ln -s ../../parents/$source/bin .
ln -s ../../parents/$source/cli .
ln -s ../../parents/$source/components .
ln -s ../../parents/$source/includes .
ln -s ../../parents/$source/language .
ln -s ../../parents/$source/layouts .
ln -s ../../parents/$source/libraries .
ln -s ../../parents/$source/media .
ln -s ../../parents/$source/modules .
ln -s ../../parents/$source/plugins .
ln -s ../../parents/$source/templates .
cd administrator
pwd
ln -s ../../../parents/$source/administrator/components .
ln -s ../../../parents/$source/administrator/help .
ln -s ../../../parents/$source/administrator/includes .
ln -s ../../../parents/$source/administrator/language .
ln -s ../../../parents/$source/administrator/manifests .
ln -s ../../../parents/$source/administrator/modules .
ln -s ../../../parents/$source/administrator/templates .

