#Daten generieren
#Um dem Zufall keine Chance zu geben
RNGkind(sample.kind="Rounding")
SEED = 1
set.seed(SEED)

#?runif
n = 2000
n_x = 4

data <- data.frame(matrix(runif(n * n_x, -2, 2), ncol=n_x))

# Kategorien: in/außer Einheitskreis
cat = c()
for (i in seq(nrow(data))){
    cat = c(cat, sum(data[i,]^2.)^.5)
}
cat <- (cat <= 1)

# Zufaellig 5% der Labels tauschen
ran = sample(n, n * .05)
for (i in ran){
    cat[i] = 1 - cat[i]
}
Y <- cat
data <- cbind(data,Y)
data$Y <- factor(data$Y)
# Festlegung, welche Variablen erklaeren sollen
erklv <- setdiff(colnames(data),"Y")
