#!/bin/bash

# install env
sudo apt-get install -y build-essential
sudo apt-get install -y bison 
sudo apt-get install -y flex 
sudo apt-get install -y libgmp3-dev
sudo apt-get install -y libmpc-dev 
sudo apt-get install -y libmpfr-dev
sudo apt-get install -y texinfo


WORK_DIR=$(pwd)
OUT_DIR=$WORK_DIR/out

export PREFIX="$WORK_DIR/out"
export TARGET=arm-xxx-eabi
export PATH="$PREFIX/bin:$PATH"

# build binutils
mkdir -p $OUT_DIR/build_binutils && cd $OUT_DIR/build_binutils

$WORK_DIR/binutils/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make -j4
make install

rm -rf $OUT_DIR/build_binutils
cd $WORK_DIR

# The $PREFIX/bin dir _must_ be in the PATH. We did that above.
which -- $TARGET-as || echo $TARGET-as is not in the PATH

# build gcc
mkdir -p $OUT_DIR/build_gcc && cd $OUT_DIR/build_gcc

$WORK_DIR/gcc-11.2.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make -j4 all-gcc
make -j4 all-target-libgcc
make install-gcc
make install-target-libgcc

rm -rf $OUT_DIR/build_gcc 
cd $WORK_DIR

echo done?
