# Parallelisierung Anfang
library(doParallel)
meineclusterzahl = makeCluster(3)
registerDoParallel(meineclusterzahl)
set.seed(1)


# Parallelisierung Ende
stopCluster(meineclusterzahl)
registerDoSEQ()
