#  R script to run TauDEM

# Packages used
# install rgdal
# install raster
# install shapefiles
# install.packages("rgdal")
# install.packages("raster")
# install.packages("shapefiles")

# This also assumes that MPICH2 is properly installed on your machine and that TauDEM command line executables exist
# MPICH2.  Obtain from http://www.mcs.anl.gov/research/projects/mpich2/
# Install following instructions at http://hydrology.usu.edu/taudem/taudem5.0/downloads.html.  
# It is important that you install this from THE ADMINISTRATOR ACCOUNT.

# TauDEM command line executables.  
# If on a PC download from http://hydrology.usu.edu/taudem/taudem5.0/downloads.html
# The install package will install to c:\program files\taudem or c:\program files (x86)\taudem set a 
# system path.  If you want to do this manually you can download the command line executables and place where you wish.
# If on a different system, download the source code and compile for your system.

library(raster)
library(shapefiles)

#tif names
name_dem   = "boulder_clip.tif"
name_fel   = paste(substring(name_dem,0,nchar(name_dem) - 4),"fel.tif",sep = "")
name_sd8   = paste(substring(name_dem,0,nchar(name_dem) - 4),"sd8.tif",sep = "")
name_p     = paste(substring(name_dem,0,nchar(name_dem) - 4),"p.tif",sep = "")
name_ad8   = paste(substring(name_dem,0,nchar(name_dem) - 4),"ad8.tif",sep = "")
name_gord  = paste(substring(name_dem,0,nchar(name_dem) - 4),"gord.tif",sep = "")
name_tlen  = paste(substring(name_dem,0,nchar(name_dem) - 4),"tlen.tif",sep = "")
name_ang   = paste(substring(name_dem,0,nchar(name_dem) - 4),"ang.tif",sep = "")
name_slp   = paste(substring(name_dem,0,nchar(name_dem) - 4),"slp.tif",sep = "")
name_sca   = paste(substring(name_dem,0,nchar(name_dem) - 4),"sca.tif",sep = "")
name_src   = paste(substring(name_dem,0,nchar(name_dem) - 4),"src.tif",sep = "")
name_ssa   = paste(substring(name_dem,0,nchar(name_dem) - 4),"ssa.tif",sep = "")
name_src1  = paste(substring(name_dem,0,nchar(name_dem) - 4),"src1.tif",sep = "")
name_ord   = paste(substring(name_dem,0,nchar(name_dem) - 4),"ord.tif",sep = "")
name_tree  = paste(substring(name_dem,0,nchar(name_dem) - 4),"tree.txt",sep = "")
name_coord = paste(substring(name_dem,0,nchar(name_dem) - 4),"coord.txt",sep = "")
name_net   = paste(substring(name_dem,0,nchar(name_dem) - 4),"net.shp",sep = "")
name_w     = paste(substring(name_dem,0,nchar(name_dem) - 4),"w.tif",sep = "")
name_ss    = paste(substring(name_dem,0,nchar(name_dem) - 4),"ss.tif",sep = "")
name_drp   = paste(substring(name_dem,0,nchar(name_dem) - 4),"drp.txt",sep = "")
name_src2  = paste(substring(name_dem,0,nchar(name_dem) - 4),"src2.tif",sep = "")
name_ord2  = paste(substring(name_dem,0,nchar(name_dem) - 4),"ord2.tif",sep = "")
name_tree2 = paste(substring(name_dem,0,nchar(name_dem) - 4),"tree2.dat",sep = "")
name_coord2= paste(substring(name_dem,0,nchar(name_dem) - 4),"coord2.dat",sep = "")
name_net2  = paste(substring(name_dem,0,nchar(name_dem) - 4),"net2.shp",sep = "")
name_w2    = paste(substring(name_dem,0,nchar(name_dem) - 4),"w2.tif",sep = "")
name_sar   = paste(substring(name_dem,0,nchar(name_dem) - 4),"sar.tif",sep = "")
name_dd    = paste(substring(name_dem,0,nchar(name_dem) - 4),"dd.tif",sep = "")
name_plen  = paste(substring(name_dem,0,nchar(name_dem) - 4),"plen.tif",sep = "")

# set working directory to your location
setwd("C:\\Users\\Admin\\Desktop\\USC\\Internships\\ISI\\HAND\\boulder_clipNET\\")

z=raster(name_dem)
plot(z, main = "original dem")

### grid preparation
# pitremove
system(paste("mpiexec -n 8 pitremove -z ",name_dem," -fel ",name_fel,sep= ""))
fel=raster(name_fel)
plot(fel, main = "filled dem")

# d8 flow directions
system(paste("mpiexec -n 8 d8flowdir -fel ",name_fel," -p ",name_p," -sd8 ",name_sd8,sep = ""))
p=raster(name_p)
plot(p, main = "d8 flow direction (-p)")
sd8=raster(name_sd8)
plot(sd8,main = "sd8")

# contributing area
system(paste("mpiexec -n 8 aread8 -p ",name_p," -ad8 ",name_ad8,sep = ""))
ad8=raster(name_ad8)
plot(ad8,main = "ad8")

# a quick R function to write a shapefile
makeshape.r=function(sname="shape",n=1)
{
  xy=locator(n=1)
  xy$x = -105.295957
  xy$y = 40.013462
  points(xy)
  
  #Point
  dd <- data.frame(Id=1:n,X=xy$x,Y=xy$y)
  ddTable <- data.frame(Id=c(1),Name=paste("Outlet",1:n,sep=""))
  ddShapefile <- convert.to.shapefile(dd, ddTable, "Id", 1)
  write.shapefile(ddShapefile, sname, arcgis=T)
}

makeshape.r("ApproxOutlets")

# Move Outlets
#system("mpiexec -n 8 moveoutletstostreams -p loganp.tif -src logansrc.tif -o approxoutlets.shp -om Outlet.shp")
#outpt=read.shp("outlet.shp")
#approxpt=read.shp("ApproxOutlets.shp")

# peuker douglas stream definition
system(paste("mpiexec -n 8 peukerdouglas -fel ",name_fel, " -ss ",name_ss, sep = ""))
ss=raster(name_ss)
plot(ss,main = "ss")

# Contributing area upstream of outlet
system(paste("mpiexec -n 8 Aread8 -p ",name_p," -ad8 ",name_ssa," -wg ",name_ss,sep = ""))
ssa=raster(name_ssa)
plot(ssa,main = "ssa")

system(paste("mpiexec -n 8 dropanalysis -p ",name_p," -fel ",name_fel," -ad8 ",name_ad8," -ssa ", name_ssa, " -drp " ,name_drp," -o ApproxOutlets.shp -par 5 500 100 0",sep = ""))
