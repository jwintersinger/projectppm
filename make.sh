#!/bin/sh
CC="gcc -Wall -O3"

function make_bin {
  for foo in project_onto_PPM.c main.c; do
    base=$(basename $foo | cut -d. -f1)
    $CC -c -o bin/$base.o $foo
  done

  $CC -o bin/projectppm bin/{project_onto_PPM,main}.o
}

function make_lib {
  # See https://stackoverflow.com/questions/4580789. (Thanks, Juber!)
  if [[ "$OSTYPE" == "darwin"* ]]; then
    SWITCHES="-install_name"
  else
    SWITCHES="-soname"
  fi

  # Need -fPIC for library.
  $CC -shared -fPIC -Wl,$SWITCHES,libprojectppm.so -o bin/libprojectppm.so project_onto_PPM.c
}

function main {
  rm -rf bin
  mkdir -p bin
  make_bin
  make_lib
}

main
