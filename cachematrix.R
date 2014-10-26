# file ProgrammingAssignment2/cachematrix_perexample.R
# copyright (C) 2014 A. J. Mee
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 or 3 of the License
#  (at your option).
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  A copy of the GNU General Public License is available at
#  http://www.r-project.org/Licenses/
#

## makeCacheMatrix - construct a closure to represent a matrix and allow its
##                   inverse to be cached within the same closure.
makeCacheMatrix <- function(x = matrix()) {
    cache.inverse <- NULL
    set(x)  # Call setter it initialise for type checking
    
    ## set - sets the underlying matrix object    
    set <- function(y) {
        if(!is.matrix(y))
            stop(simpleError("y must be a matrix"))
        x <<- y
        cache.inverse <<- NULL
    }

    ## get - returns the underlying matrix object
    get <- function() x

    ## setinverse - allows cached inverse to be set (or cleared)
    setinverse <- function(inverse) cache.inverse <<- inverse
    
    
    getinverse <- function() { cache.inverse }

    obj<-list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
    class(obj)<-"CacheMatrix"  # Assign a class attribute
    obj
} # makeCacheMatrix


## cacheSolve - primative helper to return the inverse of an matrix
##              represented as a "CacheMatrix"
cacheSolve <- function(x, ...) {

    # Check the parameter x is of the expected type
    if(!inherits(x,"CacheMatrix")) 
        stop(simpleError("x must be a CacheMatrix"))

    ## Try to get the inverse direct from the CacheMatrix
    inverse <- x$getinverse()
    if(!is.null(inverse)) {
        message("getting cached inverse")
        return(inverse)
    }

    # Otherwise calculate the inverse and store it in the CacheMatrix
    inverse <- solve(x$get(), ...)
    x$setinverse(inverse)
    inverse
} # cacheSolve
