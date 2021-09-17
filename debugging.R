
### DEBUGGING ###

  ## Rios simple error ##

hydrobasins <- st_read(file.path(dir_data, "hydroshed","hydrobasins_level9","hydrobasin_mg_lev9.shp"))
hydronetwork <- st_read(file.path(dir_data, "water_surface", "rios_simples", "rios_simple84.shp"))

st_is_valid(hydronetwork[2000713,])

check <- vector()

for (i in 1:dim(hydrobasins)[1]){
  
  check[i] <- st_intersects(hydronetwork[2000713,], hydrobasins[i,])
  
}


  ## Extract ##

source <-"flowacc"
hybas_id <- hydrobasins$HYBAS_ID
i <- hybas_id[369] #25,369,2625
#ligne = which(hybas_id==i)

load(file=file.path(dir_data, "processed", paste0(source, "_extractbasin_",i,".RData")))
min(flowacc$sa_acc_15s)

df_trans <- cbind(df_export[,'x'],df_export[,'y'], df_export[,'AMZ_2015_9_2016_8'])
rast_check <- rasterFromXYZ(df_trans)
plot(rast_check)

writeRaster(rast_check, file = file.path(dir_data, "processed", paste0(source,"_check.tif")), overwrite = TRUE)





