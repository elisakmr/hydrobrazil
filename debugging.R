
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

# triying sf functionss
hybas_id<-6090596700

riosimple <- st_read(file.path(dir_data,"water_surface", "rios_simples", paste0("riossimple_poly",hybas_id,".shp")))
nascente <- st_read(file.path(dir_data, "water_surface","nascentes", paste0("source_poly",hybas_id,".shp")))
lariviere <- riosimple %>% filter(FONTE==1706)
water_source <- st_within(riosimple, nascente)
length(which(water_source))
length(water_source)

# intersecting upstream buffer and land use with SF
tictoc::tic()
mapbiom_up <- st_intersects(spp_biomas, buf_stream[12,], sparse = TRUE)
tictoc::toc()
st_write(spp_biomas[unlist(mapbiom_up),], file.path(dir_data, "processed", "water", paste0("crop_map12.shp")), delete_layer = TRUE)
st_write(buf_stream[12,], file.path(dir_data, "processed", "water", paste0("buf6090484790_bis.shp")), delete_layer = TRUE)
spp_biomas_utm<- st_transform(spp_biomas, crs="EPSG:32721") 
buf_stream_utm<- st_transform(buf_stream, crs="EPSG:32721") 
mapbiom_up_utm <- st_intersects(spp_biomas, buf_stream[1,])

plot(spp_biomas[unlist(mapbiom_up_utm),])
spp_biomas[unlist(mapbiom_up_utm),]
plot(mapbiom_crop)

plot(buf_stream)
plot(spp_biomas)
plot(spp_biomas[unlist(mapbiom_up),])
sum(st_area(buf_stream))
plot(mapbiom_up)

buf_mb <- st_buffer(spp_biomas, dist=0.0000001) 

mapbiom_up1 <- st_crosses(buf_mb, buf_stream[1,])
plot(buf_stream[1,])
plot(spp_biomas[unlist(mapbiom_up1)])
st_write(spp_biomas[unlist(mapbiom_up1),], file.path(dir_data, "processed", "water", paste0("crop_map103",i,".shp")), delete_layer = TRUE)

# intersecting upstream buffer and land use with SHAPEFILE

spp_biomas_sp <- as(spp_biomas, "Spatial")
plot(spp_biomas_sp)
buf_stream_sp <- as(buf_stream, "Spatial")
plot(buf_stream_sp)
biom_up <- over(spp_biomas_sp, buf_stream_sp[1,], returnList = TRUE)#
biom_up <- na.omit(biom_up)
nrow(biom_up)
lapply(biom_up, FUN=nrow)

spp_biomas[unlist(mapbiom_up_utm),]
nrow(spp_biomas[unlist(mapbiom_up_utm),] %>% filter(bio_30 == 3))

class(biom_up)

spp_biomas[unlist(mapbiom_up),]$bio_30
st_write(spp_biomas[unlist(mapbiom_up),], file.path(dir_data, "processed", "water", paste0("crop_map_comp.shp")), delete_layer = TRUE)
writeOGR(biom_up, dsn=file.path(dir_data, "processed", "water", paste0("crop_map_comp2.shp")), driver="ESRI Shapefile")

lu_int <- st_intersection(spp_biomas, buf_stream[12,])
plot(lu_int)

# optimizing
tictoc::tic()
vuln_shp<- basin %>% mutate(for_up=for_up, soy=soy, sug_ma=sug_ma, temp=temp, perm = perm, past_ma = past_ma, agrpast = agrpast, aquacult = aquacult, wet = wet, foret_ma = foret_ma, sav=sav, mang=mang, forplan=forplan, cotton_fallow = cotton_fallow, soy_fallow = soy_fallow, millet_cotton = millet_cotton, soy_millet = soy_millet, soy_corn = soy_corn, soy_cotton = soy_cotton, past_mo = past_mo, foret_mo = foret_mo, sav_mo=sav_mo, sug_mo = sug_mo, n_dam = n_dam)

st_write(vuln_shp, file.path(dir_data,paste0(year,"_vulnerabilitylol_", hybas_id, ".shp")), delete_layer = TRUE)
tictoc::toc()

tictoc::tic()
df_vuln <- data.frame(for_up=for_up, soy=soy, sug_ma=sug_ma, temp=temp, perm = perm, past_ma = past_ma, agrpast = agrpast, aquacult = aquacult, wet = wet, foret_ma = foret_ma, sav=sav, mang=mang, forplan=forplan, cotton_fallow = cotton_fallow, soy_fallow = soy_fallow, millet_cotton = millet_cotton, soy_millet = soy_millet, soy_corn = soy_corn, soy_cotton = soy_cotton, past_mo = past_mo, foret_mo = foret_mo, sav_mo=sav_mo, sug_mo = sug_mo, n_dam = n_dam)
save(df_vuln, file=file.path(dir_data,paste0(year,"_vulnerabilitylol2_", hybas_id, ".shp")))
tictoc::toc()


df_biom<-read.table(file=file.path(dir_data, "processed", paste0("mapbiomas_extractbasin_",hybas_id,".RData")))
tictoc::tic()
df_biom<-get(load(file=file.path(dir_data, "processed", paste0("mapbiomas_extractbasin_",hybas_id,".RData"))))
tictoc::toc()
tictoc::tic()
load(file=file.path(dir_data, "processed", paste0("mapbiomas_extractbasin_",hybas_id,".RData")))
tictoc::toc()

tictoc::tic()
spp_biomas <- st_as_sf(cbind(value=df_export[,year_index+16],df_export[,c('x','y', 'fraction')]), coords = c("x","y"), crs = "+proj=longlat +datum=WGS84")#
past_ma <- sum((spp_biomas %>% filter(value==15))$fraction)*900/basin_surface_mb
tictoc::toc()

tictoc::tic()
past_ma <- sum((df_export %>% filter(bio_1==15))$fraction)*900/basin_surface_mb
tictoc::toc()




