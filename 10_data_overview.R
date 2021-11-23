#Uebersichtsstatistiken
# Betrachtung der ersten 15 Zeilen
head(data, n=15)

# Betrachtung der letzten 9 Zeilen
tail(data, n=9)

# Angabe der Dimensionen
cat("\n Der Datensatz hat ", dim(data)[1], " Zeilen und ", dim(data)[2], " Spalten.", sep="")

# Pruefung auf fehlende Werte
anyNA(data)

# Betrachtung von Ueberblicksstatistiken der
# erklaerenden Variablen , Teil 1
summary(data[,erklv])
sapply(data[,erklv], sd)
korrelationen = cor(data[,erklv])
print(korrelationen)

boxplot(data[,erklv], main="Boxplots der erklaerenden Variablen")

library("corrplot")
corrplot(korrelationen, method ="circle")

for (ev in erklv)
{
    hist(data[,ev], main=ev, freq=FALSE)
    plot(density(data[,ev]), main=ev)
}

anteile = prop.table(table(data[,"Y"]))
cbind(freq = table(data[,"Y"]), percentage=anteile)
plot(data[,"Y"], main="Y")

print("Gemeinsame Betrachtung")
library("scatterplot3d")
pairs(as.formula("y~."), data=data, main ="Alle Variablen", col=data[,"Y"])

print("mit caret")
library("caret")
featurePlot(x=data[,erklv], y=data[,"Y"], plot="ellipse")
featurePlot(x=data[,erklv], y=data[,"Y"], plot="box")
featurePlot(x=data[,erklv], y=data[,"Y"], plot="density")


print("3D-Plots")
library("scatterplot3d")
posc = 1
negc = 0

for (i in 1:length(erklv)){
	for (j in 2:length(erklv)){
		for (k in 3:length(erklv)){
			if(i<j && j<k){
			  meinplot = scatterplot3d(
			  data[(data["Y"]==negc),erklv[i]],
			  data[(data["Y"]==negc),erklv[j]],
			  data[(data["Y"]==negc),erklv[k]],
			  color="blue",
			  xlab=erklv[i],ylab=erklv[j],zlab=erklv[k],
			  xlim=c(min(data[,erklv[i]]),max(data[,erklv[i]])),
			  ylim=c(min(data[,erklv[j]]),max(data[,erklv[j]])),
			  zlim=c(min(data[,erklv[k]]),max(data[,erklv[k]]))  )
			  meinplot$points3d(
			  data[(data["Y"]==posc),erklv[i]],
			  data[(data["Y"]==posc),erklv[j]],
			  data[(data["Y"]==posc),erklv[k]],
			  col="red")
			}
		}
	}
}
