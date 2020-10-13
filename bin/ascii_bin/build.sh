#!/usr/bin/env bash
if ! [[ -f $(command -v clang) ]]; then sudo apt -y install clang; fi
if ! [[ -f $(command -v cmake) ]]; then sudo apt -y install cmake; fi

BUILD_DIR="$HOME/bin/ascii_bin/build"
mkdir -p "$BUILD_DIR" && cd "$BUILD_DIR" || exit 1
cmake -DCMAKE_C_COMPILER=clang .. && make
cp ./_ascii "$HOME/bin/"
rm -rf "$BUILD_DIR"
