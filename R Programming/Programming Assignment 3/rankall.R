rankall <- function(outcome, num = "best") {
    # Read data
    data <- read.csv("outcome-of-care-measures.csv", colClasses="character")

    # Get the column number for chosen outcome; return error message if not valid
    if(outcome == "heart attack")
      col_num <- 11
    else if(outcome == "heart failure")
      col_num <- 17
    else if(outcome == "pneumonia")
      col_num <- 23
    else stop("invalid outcome")   

    # Convert outcome column to numeric & remove NAs
    suppressWarnings(data[, col_num] <- as.numeric(data[, col_num]))
    data <- data[complete.cases(data[,col_num]),]

    # Sort by state, rate and hospital name
    data <- data[order(data$State, data[col_num], data$Hospital.Name), ]

    # Split dataset per state
    data_state <- split(data, data$State)

    # Create hospital and state vectors for specified outcome and rank
    hospital_list <- character(0)
    state_list <- character(0)

    for(state in names(data_state)){
      if (num == "best")
        num <- 1
      if(num == "worst")
        num <- nrow(data_state[[state]])
      
      suppressWarnings(rank <- as.numeric(num))

      hos_name <- data_state[[state]][rank, 2]
        
      hospital_list <- c(hospital_list, hos_name)
      state_list <- c(state_list, state)
    }

    return(data.frame(hospital=hospital_list, state=state_list))
}