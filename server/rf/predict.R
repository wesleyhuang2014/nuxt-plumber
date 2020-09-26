#!env Rscript
library("randomForest")

predictRF <- function(data) {
    str(data)

    set.seed(2345)
    rfmodel = readRDS("./rf/file.rds")
    result <- as.numeric(predict(rfmodel, data))

    str(result)
    
    return (result)
}