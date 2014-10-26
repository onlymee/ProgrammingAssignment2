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
    inv <- x$getinv()
    if(!is.null(inv)) {
        message("getting cached inverse")
        return(inv)
    }

    # Otherwise calculate the inverse and store it in the CacheMatrix
    inv <- solve(x$get(), ...)
    x$setinv(inv)
    inv
} # cacheSolve
