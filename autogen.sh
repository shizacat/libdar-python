#!/bin/bash

libtoolize --automake
aclocal
autoconf
autoheader
automake --add-missing --gnu