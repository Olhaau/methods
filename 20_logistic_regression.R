# logistic regression
train_LR = function(traindata, testdata = NULL, SEED = 1){
    # (SEED = NULL) = no seed 
    set.seed(SEED)

    
    # training
    modell_LR = train(as.formula("Y~."), data = traindata, method = "glm", family=binomial, metric="Accuracy")
    print(summary(meinmodell_LR))
    
    # testing
    vorhs = NULL
    if(!is.null(testdata)){
       # Festlegung, welche Variablen erklaeren sollen
       erklv <- setdiff(colnames(traindata),"Y") 
       vorhs = predict(modell_LR, newdata = testdata[,erklv], type = "raw")
       print("--- Test results ---")
       print(confusionMatrix(vorhs, testdata[,"Y"], positive = "1"))        

    }
    return(list("model" = modell_LR, "pred" = vorhs))
}

LR = train_LR(trd, ted)
modell_LR = LR$model
