##These functions (1) store a matrix's inverse in a variable from previous calculations if it exists
## and (2) either retrieve the inverse or calculate & store it in the variable from (1)

##(1) Creates a special "matrix" object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {
    i <- NULL

    # set the value of the matrix; clear the cached inverse from previous runs
    set <- function(y) {
        x <<- y
        i <<- NULL
    }

    # get the value of the matrix
    get <- function() {
        x
    }

    # set the value of the matrix inverse. inv is a variable which stores the value of the inverse
    setinv <- function(inv) {
        i <<- inv
    }

    # return the value of the cached inverse
    getinv <- function() {
        i
    }

    # return each function from above in a list
    list(set = set,
         get = get,
         setinv = setinv,
         getinv = getinv)    
}


## (2) Computes the inverse of the special "matrix" returned by makeCacheMatrix. 
## If the inverse has already been calculated (and the matrix has not changed), 
## then cachesolve will retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
    # get the cached inverse
    i <- x$getinv()

    if(!is.null(i)) {
        # if the inverse has already been set by makeCacheMatrix, return the value
        message("getting cached inverse for matrix")
        return(i)
    }

    # if the inverse is null, calculate it, cache it for future use, and then return the value
    matrix <- x$get()
    i <- solve(matrix, ...)
    x$setinv(i)
    i
}