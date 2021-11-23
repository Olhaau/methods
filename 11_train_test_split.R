# Aufteilung der Gesamtdaten mit geschichteter Zufallsstichprobe
set.seed(SEED)
index_train = createDataPartition(data[,"Y"], p = 0.6 , list=FALSE)
trd = data[index_train, ]
ted = data[-index_train, ]

formel = as.formula("Y~.")

anwendung_auf_testdaten = function(modell=NULL, testdaten=NULL)
{
   vorhs = NULL 
   vorhs = predict(modell, newdata=testdaten[,erklv], type="raw")
   print(confusionMatrix(vorhs, testdaten[,Y], positive=as.character(posc)))
   return(vorhs)
}
