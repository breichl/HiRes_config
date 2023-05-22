#!/bin/tcsh

module load fre/bronx-20
cd INPUT
#This is to make the super-grid, so nlon=8 for a 4x4 model
make_hgrid --grid_type simple_cartesian_grid --xbnd 0,1 --ybnd 0,1 --nlon 1024 --nlat 1024 --simple_dx 3125 --simple_dy 3125 --grid_name ocean_hgrid

make_solo_mosaic --num_tiles 1 --dir ./ --mosaic_name ocean_mosaic --tile_file ocean_hgrid.nc
make_solo_mosaic --num_tiles 1 --dir ./ --mosaic_name atmos_mosaic --tile_file ocean_hgrid.nc
make_solo_mosaic --num_tiles 1 --dir ./ --mosaic_name land_mosaic --tile_file ocean_hgrid.nc
make_solo_mosaic --num_tiles 1 --dir ./ --mosaic_name wave_mosaic --tile_file ocean_hgrid.nc

make_topog --mosaic ocean_mosaic.nc --topog_type  rectangular_basin --bottom_depth 3000
make_coupler_mosaic --atmos_mosaic atmos_mosaic.nc --land_mosaic land_mosaic.nc --ocean_mosaic ocean_mosaic.nc --ocean_topog topog.nc --mosaic_name grid_spec --check --verbose

#These can be run parallel to greatly speed up (particularly the coupler_mosaic)
#make_topog_parallel --mosaic ocean_mosaic.nc --topog_type  rectangular_basin --bottom_depth 3000
#make_coupler_mosaic_parallel --atmos_mosaic atmos_mosaic.nc --land_mosaic land_mosaic.nc --ocean_mosaic ocean_mosaic.nc --ocean_topog topog.nc --mosaic_name grid_spec --check --verbose
