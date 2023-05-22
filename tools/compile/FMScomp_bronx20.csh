#!/bin/csh
#

set version=REPRO

module load fre/bronx-20

mkdir -p build/bronx20/shared/$version

mkdir -p build/bronx20/shared/$version/
(cd build/bronx20/shared/$version/; rm -f path_names; \
../../../../src/mkmf/bin/list_paths -l ../../../../src/FMS; \
../../../../src/mkmf/bin/mkmf -t ../../../../src/mkmf/templates/ncrc-intel.mk -p libfms.a -c "-Duse_libMPI -Duse_netCDF -DHAVE_GETTID" path_names)
(cd build/bronx20/shared/$version/; make NETCDF=3 $version=1 libfms.a -j)
