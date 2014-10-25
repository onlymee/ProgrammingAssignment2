## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
    cache.inv <- NULL
    set <- function(y) {
        x <<- y
        cache.inv <<- NULL
    }
    get <- function() x
    setinv <- function(inv) cache.inv <<- inv
    getinv <- function() { cache.inv }
    
    obj<-list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
    #class(obj)<-"CacheMatrix"
    obj
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    inv <- x$getinv()
    if(!is.null(inv)) {
        message("getting cached inverse")
        return(inv)
    }
    mat <- x$get()
    inv <- solve(mat, ...)
    x$setinv(inv)
    inv
}
