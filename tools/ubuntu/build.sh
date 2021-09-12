#!/bin/bash

./install_env.sh

TARGET_ARCH=$1

WORK_DIR=$(pwd)
OUT_DIR=$WORK_DIR/out

export PREFIX="$WORK_DIR/out"
export TARGET=$TARGET_ARCH
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
