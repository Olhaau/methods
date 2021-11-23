# probit regression
train_PR = function(traindata, testdata = NULL, SEED = 1){
    # (SEED = NULL) = no seed 
    set.seed(SEED)

    # training
    model = train(as.formula("Y~."), data = traindata, method = "glm", family=binomial(link ="probit"), metric="Accuracy")
    print(summary(model))
    
    # testing
    vorhs = NULL
    if(!is.null(testdata)){
       # Festlegung, welche Variablen erklaeren sollen
       erklv <- setdiff(colnames(traindata),"Y") 
       vorhs = predict(model, newdata = testdata[,erklv], type = "raw")
       print("--- Test results ---")
       print(confusionMatrix(vorhs, testdata[,"Y"], positive = "1"))        

    }
    return(list("model" = model, "pred" = vorhs))
}

PR = train_PR(trd, ted)
modell_PLR = PR$model
