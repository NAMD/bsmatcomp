#/bin/bash

ifort matriz.f90 -o matriz.x -xhost -i8 -O3 -parallel -fast
