specdata <- "~/Documents/Iulia/Coursera/R Programming/specdata"

pollutantmean <- function(directory, pollutant, id = 1:332) {
	output <- data.frame()
	for(i in id) {
		path <- paste(directory,"/",sprintf("%03d.csv",i),sep="")
		data <- read.csv(path)    
		output <- rbind(output, data)
	}   
round(mean(output[,pollutant], na.rm = TRUE),3)
}