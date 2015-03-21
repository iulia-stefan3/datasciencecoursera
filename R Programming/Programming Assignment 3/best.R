# This is just a special case of the rankhospital function; source that function and evaluate it for num = "best"
best <- function(state, outcome) {
  source("rankhospital.R")
  rankhospital(state, outcome, "best")
}