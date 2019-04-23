#!/bin/sh
CC="gcc -Wall -O3"

rm -rf bin
mkdir -p bin

for foo in project_onto_PPM.c main.c; do
  base=$(basename $foo | cut -d. -f1)
  $CC -c -o bin/$base.o $foo
done

$CC -o bin/projectppm bin/{project_onto_PPM,main}.o
