#!/bin/bash



SCRIPT=`realpath $0`
SCRIPTS_DIR=`dirname $SCRIPT`
TEMPLATES_DIR=$SCRIPTS_DIR/../Templates

mkdir -p ~/Templates
cp -r $TEMPLATES_DIR/. ~/Templates/.
