# methods

## contents of ST48 (ML)
focus on binary classification
* EDA
* Basic statistic methods
  * benchmarks
  * train and test data
  * logistic regression
  * analysis of output
    * confusion matrix
    * accuracy <!-- share of correctly classified data points -->   
    * 95%-CI <!-- normal approximation --> 
    * no information rate <!-- accuracy if always the majority class is predicted -->   
    * P-Value[Acc >= NIR] <!-- probability that model has a better accuracy than the no information rate  -->
    * (Cohen's) Kappa 
    <!-- 
         measure for the accuracy for the test data which considers the random error, 
         in [-inf, 1],
         0 means only random effect
         higher = better 
    -->
    * Mcnemar's Test P-Value <!-- measures the symmetry of errors -->
    * Sensitivity (or Recall, Hitrate) <!-- correct-positive-rate 
                                            - rate of correctly positive classified data points of all positive data points -->
    * Specificity <!-- correct-negative-rate ... -->
    * Pos Pred Value (relevance) <!-- rate of correctly positive classified data points of all positive CLASSIFIED data points -->
    * Neg Pred Value <!-- rate of correctly negative classified data points of all negative CLASSIFIED data points -->
    * Prevalence <!-- rate of positive data points in test data -->
    * Detection Rate <!-- ... -->
    * Detection Prevalence <!-- ... -->
    * Balanced Accuracy <!-- ... -->
  * probit regression
  * LDA
* non-linear methods
  * QDA
  * NB
  * Nearest Neighbour
  * (hyper-)parameter and tuning
  * CART
  * Boosting
  * Bagging and RF
  * SVM
* further topics
  * model choice (caret)
  * black box and explainability
  * change caret options
  * unbalanced data
  * multi-class   
  * regression  

## References
Biau, G., Scornet, E. A random forest guided tour. TEST 25, 197–227 (2016). https://doi.org/10.1007/s11749-016-0481-7
