#!/bin/bash
if [ -d ../webapps/2 ]; then
cp ../webapps/ROOT/index503.jsp ../webapps/ROOT/2/index.jsp
else
cp ../webapps/ROOT/index503.jsp ../webapps/ROOT/index.jsp
fi
