
                                              ### JUST A REMINDER ###

# terra::mask(rast_biomas, newflow_mb) # we mask mapbiomas on upstream area

# hydronetwork <- shapefile(file.path(dir_data, "water_surface", "second.shp"))
# hydronetwork <- readOGR(dsn=file.path(dir_data, "water_surface", "second.shp"))

# newflow_mb <- resample(rast_flow, rast_biomas, method = 'ngb') # we put flow raster (15 sec) at mapbiomas resolution (30m) 

# %in%

# spp_biomas_utm<- st_transform(spp_biomas, crs="EPSG:32721") 

# crop_list <- st_intersects(hydrobasins[ligne,],nascente)
#   nascente_shp <- nascente[unlist(crop_list),]

# %>% rename(value=year_index)

# sf_list_name <- list.files(path=file.path(dir_data, "vulnerability"), pattern = paste0(year_select,".+.shp"), full.names = TRUE)

# R.Version()$version.string
# updateR()

# df in loop: df <- do.call("rbind",mylist)