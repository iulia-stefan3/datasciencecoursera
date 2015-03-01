rankhospital <- function(state, outcome, num = "best") {
    # Read data
    data <- read.csv("outcome-of-care-measures.csv", colClasses="character")

    # Subset data for chosen state; check if valid
    data <- data[data$State == state, ]

    if(nrow(data) == 0)
      stop("invalid state")    

    # Get the column number for chosen outcome; return error message if not valid
    if(outcome == "heart attack")
      col_num <- 11
    else if(outcome == "heart failure")
      col_num <- 17
    else if(outcome == "pneumonia")
      col_num <- 23
    else stop("invalid outcome")   

    # Clean data subset - convert to numeric, remove NAs, sort by rate and hospital.name for tiebreak
    data[, col_num] <- suppressWarnings(as.numeric(data[, col_num]))
    data <- data[complete.cases(data[,col_num]),]
    data <- data[order(data[col_num], data$Hospital.Name), ]

    # Return the hospital for the specified state, outcome and rank
    if (num == "best")
      num <- 1
    if(num == "worst")
      num <- nrow(data)

    suppressWarnings(rank <- as.numeric(num))

    return(data[rank, ]$Hospital.Name)
}