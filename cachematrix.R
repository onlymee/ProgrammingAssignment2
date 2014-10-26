# file ProgrammingAssignment2/cachematrix.R
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

## makeCacheMatrix - construct a closure to represent a matrix and its inverse
##                   with caching of the calculated inverse
makeCacheMatrix <- function(x = matrix()) {
    set(x)  # Call setter it initialise for type checking

    ## set - sets the underlying matrix object
    set <- function(y) {
        if(!is.matrix(y))
            stop(simpleError("y must be a matrix"))
        x <<- y
        cache.inv <<- NULL
    }

    ## get - returns the underlying matrix object
    get <- function() x

    ## setinv - allows cached inverse to be set (or cleared)
    setinv <- function(inv=NULL) cache.inv <<- inv

    ## getinv - return the matrix inverse from the cache if available and if
    ##          not, calculating it using 'base::solve' by default
    getinv <- function(... ,solver=solve) {
        if (is.null(cache.inv))
        {
            cache.inv<<-do.call(solver,alist(x,...))
        } else {
            message("using cached inverse")
        }
        cache.inv
    }

    ## return classed list of accessors for the closure
    obj<-list(set = set, setinv = setinv,
              get = get, getinv = getinv)
    class(obj)<-"CacheMatrix"
    obj
} # makeCacheMatrix


## cacheSolve - primative helper to calculate the inverse of an matrix
##              represented as a "CacheMatrix"
cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    if(!inherits(x,"CacheMatrix")) 
        stop(simpleError("x must be a CacheMatrix"))
    x$getinv()
} # cacheSolve
