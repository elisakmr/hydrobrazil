
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

source <-"mapbiomas"
hybas_id <- hydrobasins$HYBAS_ID
i <- hybas_id[369] #25,369,2625
#ligne = which(hybas_id==i)

load(file=file.path(dir_data, "processed", paste0(source, "_extractbasin_",i,".RData")))
min(flowacc$sa_acc_15s)

df_trans <- cbind(df_export[,'x'],df_export[,'y'], df_export[,'AMZ_2015_9_2016_8'])
rast_check <- rasterFromXYZ(df_trans)
plot(rast_check)

writeRaster(rast_check, file = file.path(dir_data, "processed", paste0(source,"_check.tif")), overwrite = TRUE)

crsshp <- "EPSG:32721"
crsterra <- CRS('+init=epsg:32721')
hydrobasin <- st_transform(hydrobasins, crs=crsshp)
elevation_ras <- 
biom_21 <- terra::project(panga_braz[[1]], crsterra) #flowacc
biom_21 <- raster::projectRaster(panga_braz[[1]], crs=crsterra) #flowacc
flow_21 <- terra::project(flowacc, crsterra)
plot(biom_21)
plot(panga_braz[[1]])
extract1 <- raster::extract(panga_braz84, hydrobasin[1,], exact=TRUE)
extract2 <- exact_extract(panga_braz84, hydrobasin[1,])
df <- as.data.frame(extract1)
max(df[,2])
dim(df)
int_raster <- intersect(panga_braz84, hydrobasin[1,])

sum(df[,2])*250*250
st_area(hydrobasin[1,])

r <- raster(nrow=3, ncol=3, crs=crsshp)
plot(r)
newpanga <- resample(panga_braz84, r, method = 'ngb')

df_extract <- terra::extract(panga_0018,vect(hydrobasin[3,]), exact=TRUE, xy=TRUE)
sum((spp_modis %>% filter(AMZ_2014_9_2015_8 == 100))$fraction)*62500/st_area(basins)*lat_weight

# trying sf functions on rios-nascente intersection

hybas_id<-6090408590

riosimple <- st_read(file.path(dir_data,"water_surface", "rios_simples", paste0("riossimple_poly",hybas_id,".shp")))
nascente <- st_read(file.path(dir_data, "water_surface","nascentes", paste0("source_poly",hybas_id,".shp")))
lariviere <- riosimple %>% filter(FONTE==1706)
water_source <- st_crosses(riosimple, nascente, sparse = FALSE)
length(water_source)

# changing projection to planar
riosimple_utm <- st_transform(riosimple, crs="EPSG:32721")
nascente_utm <- st_transform(nascente, crs="EPSG:32721")
ligne = which(hydrobasins$HYBAS_ID==hybas_id)

# buffering 
water_source <- st_within(hydrobasins[ligne,],riosimple, sparse = TRUE) #

buf_source50 <- st_buffer(nascente, dist=50)
plot(buf_source50)
st_write(buf_source50, file.path(dir_data, "water_surface","nascentes",paste0("50nascente_buff",hybas_id,".shp")), delete_layer = TRUE)
buf_source100 <- st_buffer(nascente, dist=100)
plot(buf_source100)
st_write(buf_source50, file.path(dir_data, "water_surface","nascentes",paste0("100nascente_buff",hybas_id,".shp")), delete_layer = TRUE)
buf_source200 <- st_buffer(nascente, dist=200)
plot(buf_source100)
st_write(buf_source50, file.path(dir_data, "water_surface","nascentes",paste0("200nascente_buff",hybas_id,".shp")), delete_layer = TRUE)

# within on buffered sources

buf_source <- st_buffer(nascente, dist=0.0000001)
water_source <- st_crosses(buf_source10,riosimple, sparse = TRUE) #

