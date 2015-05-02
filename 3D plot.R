library(lattice)
library(colorspace)
library(foreign)

# change to your directory
dir <- "/Users/oliviadaoust/GitHub/From-Stata-to-R/"

# opens the file containing coefficients estimates saved in Stata
coef <- read.dta(paste(dir, "coef.dta",sep=""))
coef

## generate data points (from summary statistics)
data = data.frame(
  x1 = rep( seq(-3, 3, by = 0.2), 60),
  x2 = rep( seq(-3, 3, by = 0.2), each=60))

## estimate effect of the coefficient of interest and their interaction
data$x1x2 = (data$x1*coef[,2] + data$x2* coef[,3] + coef[,4] * (data$x1*data$x2))
#coefx1 is the coefficient associated to x1, etc.

## range of colors
newcols <- colorRampPalette(c("aliceblue", "darkblue"))

## 3D plot
wireframe(x1x2 ~ x1 * x2, data=data,screen=list(y=0, z=15,x=-75) ,
          aspect = c(0.55,0.4),panel.aspect=0.5,drape = TRUE,col.regions = newcols(100),colorkey=F,
          xlab = list("x1",cex=0.85), ylab = list("x2",cex=0.85),
          zlab = list("Predicted effect",rot=90,cex=0.85),
          scales=list(arrows=FALSE,cex=0.85,tick.number=4, col="black"))