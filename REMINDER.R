
                                              ### JUST A REMINDER ###

# terra::mask(rast_biomas, newflow_mb) # we mask mapbiomas on upstream area
#hydrobasins <- shapefile(file.path(dir_data, "hydroshed","hydrobasins_level9","hydrobasin_mg_lev9.shp"))
#hydronetwork <- shapefile(file.path(dir_data, "water_surface", "second.shp"))
#hydronetwork <- readOGR(dsn=file.path(dir_data, "water_surface", "second.shp"))
# newflow_mb <- resample(rast_flow, rast_biomas, method = 'ngb') # we put flow raster (15 sec) at mapbiomas resolution (30m) 
# %in%