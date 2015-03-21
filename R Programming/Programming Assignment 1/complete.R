specdata <- "~/Documents/Iulia/Coursera/R Programming/specdata"

complete <- function(directory, id = 1:332) {
	output <- data.frame()
	for(i in id) {
		path <- paste(directory,"/",sprintf("%03d.csv",i),sep="")
		data <- read.csv(path)    
		nobs <- sum(complete.cases(data))
		row <- c(i, nobs)
		output <- rbind(output, row)
	}   
colnames(output) <- c('id', 'nobs')
output
}