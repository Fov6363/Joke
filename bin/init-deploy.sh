#!/bin/bash
if [ "$1" = "" ];then
echo "please enter svn address"
exit 1
fi

if [ ! -d ../current_tag ]; then
svn checkout $1 ../current_tag
else
cd ../current_tag
svn sw $1
fi

if [ -d ../webapps/ROOT ]; then
rm -rf ../webapps/ROOT/*
cp -rp ../current_tag/* ../webapps/ROOT/
else
mkdir -p ../webapps/ROOT
cp -rp ../current_tag/* ../webapps/ROOT/
fi
