## makeCacheMatrix and cacheSolve exploit R function closures to cache results
## of matrix inversion. Inversion is performed by feeding a matrix as the 
## sole argument to solve(). 

## Usage: 1 Create a special matrix by feeding an ordinary matrix to makeCacheMatrix.
##        2 Call cacheSolve on the result of 1.
##        3  Subsequent calls to cacheSolve will return a cached result

## Assumptions:
##     1  The initial argument is an invertable matrix. Otherwise,
##         behaviour is undefined.
##     2  cacheSolve does not check whether the special matrix created by
##         makeCacheMatrix has been changed externally (eg by a call on the set method).
##         This is unlikely in normal use, but if there is a risk of it happening, 
##         check with all(sm.get() == a) before calling cachSolve. If all returns FALSE,
##         create a new special array with makeCacheMatrix.

## Simple testing:
##     The integrity of the output can be tested by reinverting it and comparing the
##     result with the original matrix. eg: all(a == c).
##     Check that repeat calls use the cached result.

## Given an ordinary invertable matrix, makeCacheMatrix creates a "special matrix"
## Argument:
##    x is a matrix (assumed to be invertable).
## Return: Returns a list of getter and setter functions for both input data
##    and inverted matrix. 


makeCacheMatrix <- function(x = matrix()) {
    invMatrix <- NULL
    set <- function(y) {
        x <<- y
        invMatrix <<- NULL
    }
    get <- function() x 
    setInverse <- function(inv) invMatrix <<- inv
    getInverse <- function() invMatrix
    list(set = set, get = get,
         setInverse = setInverse,
         getInverse = getInverse)
}




## cacheSolve  defines a function that takes a special matrix created by makeCacheMatrix
##  as its argumenent and returns an inverted matrix.

## Arguments: x is a special matrix
## Return: an inverted matrix


cacheSolve <- function(x, ...) {
        ## Returns a matrix that is the inverse of 'x'
        invMatrix <- x$getInverse()
        if(!is.null(invMatrix)) {
            message("getting cached data") # Only useful to show when cach is used.
            return(invMatrix) 
        }
        data <- x$get() # No cached result, so get data for calculation
        invMatrix <- solve(data, ...)
        x$setInverse(invMatrix)  # cache result
        invMatrix
}
