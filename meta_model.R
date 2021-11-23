library("caret")
library(R.utils)

train_model = function(traindata, testdata = NULL, model_type, paraGrid = NULL, preprocess = FALSE, SEED = 1, max_time = 1800){
    # meta model trainer for binary classification

    formula = as.formula("Y~.")    
    
    # (SEED = NULL) = no seed 
    set.seed(SEED)
    if (preprocess){
        # transformation
        preprocessingwerte = preProcess(traindata , method=c("range"))
        traindata = predict(preprocessingwerte, traindata)
        testdata = predict(preprocessingwerte, testdata)
    }
    
    # training
    set.seed(SEED)
    model = NULL
    withTimeout(
        if (model_type == "LR") {
            print("-## model: logistic regression ##-")
            model = train(formula, data = traindata, method = "glm", family=binomial, metric="Accuracy")
        } else if (model_type == "PR"){
            print("-## model: probit regression ##-")
            model = train(formula, data = traindata, method = "glm", family=binomial(link ="probit"), metric="Accuracy") 
        } else if (model_type == "LDA"){
            print("-## model: linear discriminant analysis ##-")
            model = train(formula, data = traindata, method = "lda", metric="Accuracy") 
        } else if (model_type == "QDA"){
            print("-## model: quadratic discriminant analysis ##-")
            model = train(formula, data = traindata, method = "qda", metric="Accuracy") 
        } else if (model_type == "NB"){
            print("-## model: Naive Bayes ##-")
            model = train(formula, data = traindata, method = "nb", metric="Accuracy", tuneGrid = paraGrid) 
        } else if (model_type == "KNN"){
            print("-## model: k-nearest neighbours ##-")
            model = train(formula, data = traindata, method = "knn", metric="Accuracy", tuneGrid = paraGrid) 
        } else if (model_type == "CART"){
            print("-## model: CART ##-")
            model = train(formula, data = traindata, method = "rpart", metric="Accuracy", tuneGrid = paraGrid) 
            # error 
        } else if (model_type == "C5.0"){
            print("-## model: C5.0 ##-")
            model = train(formula, data = traindata, method = "C5.0", metric="Accuracy", tuneGrid = paraGrid) 
        } else if (model_type == "RF"){
            print("-## model: Random Forest ##-")
            model = train(formula, data = traindata, method = "rf", metric="Accuracy", tuneGrid = paraGrid) 
        } else if (model_type == "SVM"){
            print("-## model: Support Vector Machine ##-")
            model = train(formula, data = traindata, method = "svmRadialSigma", metric="Accuracy", tuneGrid = paraGrid) 
        }
        , timeout = max_time
    )
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

paraGrid_NB = expand.grid(.fL = 0.5*(0:5), .adjust = 2^(-4:4), .usekernel = c(TRUE,FALSE))
paraGrid_KNN = expand.grid(.k=c(1:25))
paraGrid_CART = expand.grid(.cp=c(0.01,0.1))
paraGrid_C50 = expand.grid(.trials=c(20,30,40), .model=c("tree"), .winnow=c(TRUE,FALSE))
paraGrid_RF = expand.grid(.mtry=c(1:4))
paraGrid_SVM = expand.grid(.sigma = 2^(seq(-8, 8)), .C = 2^(seq(-8, 8)))

result = train_model(trd, ted, model_type = "SVM", paraGrid = paraGrid_SVM, preprocess=TRUE#, max_time = 15
                    )

trained_models = append(trained_models, result$model)

methods = list("LR", "PR", "LDA", "QDA", "NB", "KNN", "CART", "C5.0", "RF", "SVM")

# 1. svm w/ acc = 94.25%
# 2. knn w/ acc = 93.88%
# 3. rf w/ acc = 93.66%
# no information rate = 93%
