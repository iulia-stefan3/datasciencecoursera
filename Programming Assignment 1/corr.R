corr <- function(directory, threshold = 0) {
    source("complete.R")
    complete <- complete(directory)
    subset <- complete[complete$nobs > threshold, ]
    result <- numeric(0)

    for(i in subset$id) {
      path <- paste(directory,"/",sprintf("%03d.csv",i),sep="")
      data <- read.csv(path)
      boolean <- !is.na(data$sulfate) & !is.na(data$nitrate)
      x <- data[boolean, ]
      result <- c(result, cor(x$sulfate, x$nitrate))
    }
    
result
}