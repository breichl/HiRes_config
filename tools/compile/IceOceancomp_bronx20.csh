#!/bin/csh

set version="REPRO"

module load fre/bronx-20

mkdir -p build/bronx20/ice_ocean_SIS2/${version}/
(cd build/bronx20/ice_ocean_SIS2/${version}/; rm -f path_names; \
../../../../src/mkmf/bin/list_paths -l ./ ../../../../src/MOM6/config_src/{infra/FMS1,memory/dynamic_symmetric,drivers/FMS_cap,external} ../../../../src/MOM6/src/{*,*/*}/ ../../../../src/{atmos_null,coupler,land_null,ice_param,icebergs,SIS2,FMS/coupler,FMS/include}/)
(cd build/bronx20/ice_ocean_SIS2/${version}/; \
../../../../src/mkmf/bin/mkmf -t ../../../../src/mkmf/templates/ncrc-intel.mk -o "-I../../shared/${version}" -p MOM6 -l "-L../../shared/${version} -lfms" -c '-Duse_AM3_physics -D_USE_LEGACY_LAND_' path_names )
(cd build/bronx20/ice_ocean_SIS2/${version}/; make NETCDF=3 $version=1 MOM6 -j)
